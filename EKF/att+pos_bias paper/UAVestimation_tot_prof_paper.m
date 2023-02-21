clear all;
close all;
clc;

% experiment parameters
NoiseScale = 1e-1;
BiasScale = 1e-1;
Duration = 100;
g = 9.807;
dt = 0.1;

% Length of inputs
t = 0:dt:Duration;
n = length(t);

%% Real measurements generations

% -- Input variables

% Input angular velocity
omega_x = 0.1*sin(2*pi*t/10);
omega_y = 0.2*cos(2*pi*t/4);
omega_z = 0.4*sin(2*pi*t/3);

% Input motor acceleration
a_M = g* 0.1 * (1 + sin(2*pi*t/7 - pi/2));
a_M(1:500) = zeros(1,500);
a_M(800:1000) = zeros(1,201);

% -- Variables initialization

% Quaternions
q = zeros(4,n);
% q(:,1) = rand(1,4);
% q(:,1) = q(:,1)/norm(q(:,1));
q(:,1) = [0,0,0,1]; % initial state
% DCM state
dcm = zeros(3,n);
tmp = quat2dcm(q(:,1)');
dcm(:,1) = tmp(:,3);

% Magnetometer
mw = [rand(1); 0; rand(1)];
mw = mw/norm(mw); % world reference
m = zeros(3,n); % body reference
% Accelerometer
a = zeros(3,n);
% Acc and mag combination
Z = zeros(4,n);
% Position and velocity
p = zeros(2,n);
v = zeros(2,n);

% -- Quaternions dynamics
for k=1:n-1
    % rotation
    S_omega = [0, -omega_x(k), -omega_y(k), -omega_z(k);
        0, 0, omega_z(k), -omega_y(k);
        0, 0, 0, omega_x(k);
        zeros(1,4)];
    S_omega = S_omega - S_omega';
    %integration
    q(:,k+1) = (S_omega*dt/2 + eye(4))*q(:,k);
    % normalization
    q(:, k+1) = q(:, k+1)/norm(q(:, k+1));
    tmp = quat2dcm(q(:,k+1)');
    dcm(:,k+1) = tmp(:,3);
end

% -- Measurements:
for k=1:n
    % compute rotation matrix
    wRb = [q(1,k)^2 + q(2,k)^2 - q(3,k)^2 - q(4,k)^2, 2*q(3,k)*q(2,k) - 2*q(4,k)*q(1,k), 2*q(3,k)*q(1,k) + 2*q(4,k)*q(2,k);
        2*q(4,k)*q(1,k) + 2*q(3,k)*q(2,k), q(1,k)^2 - q(2,k)^2 + q(3,k)^2 - q(4,k)^2, -2*q(2,k)*q(1,k) + 2*q(4,k)*q(3,k);
        -2*q(3,k)*q(1,k) + 2*q(4,k)*q(2,k), 2*q(2,k)*q(1,k) + 2*q(4,k)*q(3,k), q(1,k)^2 - q(2,k)^2 - q(3,k)^2 + q(4,k)^2];
    % Magnetometer readings in body frame
    m(:,k) = wRb'*mw;  
    % Accelerometers readings in body frame
    a(:,k) = [-2*q(3,k)*q(1,k) + 2*q(4,k)*q(2,k);
                 2*q(2,k)*q(1,k) + 2*q(4,k)*q(3,k);
                 q(1,k)^2 - q(2,k)^2 - q(3,k)^2 + q(4,k)^2] * g + ...
                [0; 1; 0] * a_M(k); % add motor acceleration

    % position and velocity
    if(k>1)
        a_tmp = wRb*a(:,k);
        p(:,k) = p(:,k-1) + v(:,k-1)*dt + a_tmp(1:2)*dt^2/2;
        v(:,k) = v(:,k-1) + a_tmp(1:2)*dt;
    end    
end


%% Corrupted measurements generation

% -- Gyroscope
mu_g = zeros(3,n);
% mu_g = (rand(3,1) + rand(3,1).*sin(2*pi*t/100)*BiasScale); %bias
sigma_mu_g = zeros(3,1);
% sigma_mu_g = NoiseScale*rand(3,1)*BiasScale; %bias uncert
Rbg = diag(sigma_mu_g.^2); %bias cov

sigma_g = NoiseScale*rand(3,1); %meas uncert
Rg = diag(sigma_g.^2); %meas cov

% Noisy ang rates
omega_bar = [omega_x; ...
             omega_y; ...
             omega_z] + mu_g + mvnrnd(zeros(1,3), Rbg+Rg, n)';

% -- Accelerometer
mu_a = zeros(3,1); %bias
% mu_a = (rand(3,1) + rand(3,1).*sin(2*pi*t/400)*BiasScale); %bias
sigma_mu_a = zeros(3,1); %bias uncert
% sigma_mu_a = NoiseScale*rand(3,1)*BiasScale; %bias uncert
Rba =  diag(sigma_mu_a.^2); %bias cov

sigma_a = NoiseScale*rand(3,1); %meas uncert
Ra = diag(sigma_a.^2); %meas cov

% Noisy measurements
a_bar = a + mvnrnd(zeros(1,3), Rba+Ra, n)'; % use this for no bias
% a_bar = a + mu_a + mvnrnd(zeros(3,1), Rba+Ra, n)';

% -- Magnetometer
mu_m = zeros(3,1); %bias
sigma_m = NoiseScale*rand(1,3); %meas uncert
Rm = diag(sigma_m.^2); %meas cov
% In future: add calibration

% Noisy measurements
m_bar = m + mvnrnd(mu_m, Rm, n)';

% -- UWB
mu_uwb = zeros(2,1); %bias
sigma_uwb = NoiseScale*10*rand(2,1); %meas uncert
Ruwb = diag(sigma_uwb.^2); %meas cov

% Noisy measurements
uwb = p + mvnrnd(mu_uwb, Ruwb, n)';

%% Estimates

% -- Initialization

% -- Ext acc detection and estimation
alpha = zeros(1,n);
threshold_acc = 0.05;
ca_const = 0.97; % process cut-off freq
acc_err = zeros(1,n);

alpha(1) = 0;
ca = ca_const/2;

ext_acc_est = zeros(3,n);
ext_acc_est(:,1) = [0; 0; a_M(1)] + mu_a(:,1);

if ~all(ext_acc_est(:,1))
    ext_acc_est(:,1) = normrnd(0,0.1,3,1);
end

% -- attitude 
dcm_est = zeros(3,n);
dcm_est(:,1) = dcm(:,1);
P_dcm = diag(NoiseScale*ones(1,3)); % attitude estimate cov
Innovation_dcm = zeros(3, n); % attitude innovation
Hacc = g*eye(3); % measurements matrix

% -- gyro bias
mu_g_est = zeros(3,n);
mu_g_est(:,1) = mu_g(:,1);
P_mu_g = diag(sigma_mu_g'); % gyro_bias estimate cov
Innovation_mu_g = zeros(3, n); % gyro_bias innovation

cb_const = 0.99; % process cut-off freq
Gamma = cb_const * eye(3);

t_zero = 1;
ya_zero = g * dcm_est(:,1);


% -- position
X_pos = zeros(7,n);
X_pos(1:2,1) = p(:,1); % correct initial position
X_pos(3:4,1) = v(:,1); % correct initial velocity
X_pos(5:7,1) = mu_a(:,1); % correct initial acc bias estimate

P_pos = diag([sigma_uwb; ...
              sigma_uwb*2/dt^2; ...
              sigma_mu_a]); % pos, vel, acc_bias estimate cov
Innovation_pos = zeros(4,n); % pos,vel innovation

% state function matrices
A = [1, 0, dt, 0;
     0, 1, 0,  dt;
     0, 0, 1,  0;
     0, 0, 0,  1];
B = [dt^2/2, 0;
     0,      dt^2/2;
     dt,     0;
     0,      dt];

% variables to compute vel from uwb (to filter corrupted measurements)
pos_buff_iter = 1;
vel_iter = -1;
pos_buff = zeros(2,2);
update_pos = false;
update_vel = false;

% motor's acceleration estimates
aM_est = zeros(1,n);

%% KF loop

for k=1:n-1
    % -- ATTITUDE DCM
    yG_star = omega_bar(:,k) - mu_g_est(:,k);
    Phi = eye(3) - dt * cross_prod_matrix(yG_star);
    
    % -- Prediction
    dcm_tilde = cross_prod_matrix(dcm_est(:,k));
    Q = - dt^2 * dcm_tilde * (Rg + P_mu_g) * dcm_tilde';

    dcm_est(:,k+1) = Phi*dcm_est(:,k);
    P_dcm = Phi * P_dcm * Phi' + Q;

    dcm_est(:,k+1) = dcm_est(:,k+1)/norm(dcm_est(:,k+1));
    
    % -- Update
    z_dcm = a_bar(:,k+1) - ca*ext_acc_est(:,k);
    
%     if ~all(ext_acc_est(:,k))
%         ext_acc_est(:,k) = normrnd(0,0.1,3,1);
%     end

    W = diag(ext_acc_est(:,k)) / sum(abs(ext_acc_est(:,k)));
    E_ext_acc = (ca^2 * norm(ext_acc_est(:,k))^2 + ...
                abs(norm(a_bar(:,k+1))^2 - g)) * W;
    M = Ra + E_ext_acc;

    Innovation_dcm(:,k+1) = z_dcm - Hacc * dcm_est(:,k+1);

    % Kalmann steps
    S_dcm = Hacc * P_dcm * Hacc' + M;
    K_dcm = P_dcm * Hacc' / S_dcm;
    dcm_est(:,k+1) = dcm_est(:,k+1) + K_dcm * Innovation_dcm(:, k+1);
    P_dcm = (eye(3) - K_dcm * Hacc) * P_dcm;

    dcm_est(:,k+1) = dcm_est(:,k+1)/norm(dcm_est(:,k+1));
    
    % -- EXT ACC DETECTION & ESTIMATION
    % uses simple threshold check
    acc_err(k+1) = abs(norm(a_bar(:,k+1)) - g);
    if  acc_err(k+1) > threshold_acc
        alpha(k+1) = 1;
        ca = ca_const;
    else
        alpha(k+1) = 0;
        ca = ca_const/2;
        
        t_zero = k+1;
        ya_zero = g * dcm_est(:,k+1);
    end

    ext_acc_est(:,k+1) = a_bar(:,k+1) - g * dcm_est(:,k+1);

    % -- GYRO BIAS
    % -- Prediction
    mu_g_est(:,k+1) = Gamma * mu_g_est(:,k);
    P_mu_g = Gamma * P_mu_g * Gamma' + Rbg;

    % -- Update
    Lb = (k+1 - t_zero) / dt;
    J = eye(3) + dt * cross_prod_matrix(sum(omega_bar(:,t_zero:k+1),2));
    
    z_bg = a_bar(:,k+1) - J' * ya_zero - ext_acc_est(:,k+1);
    Hbg = -Lb * dt * cross_prod_matrix(ya_zero);
    Mbg = Ra + alpha(k+1) * eye(3);

    Innovation_mu_g(:,k+1) = z_bg - Hbg * mu_g_est(:,k+1);

    % Kalmann steps
    S_bg = Hbg * P_mu_g * Hbg' + Mbg;
    K_bg = P_mu_g * Hbg' / S_bg;
    mu_g_est(:,k+1) = mu_g_est(:,k+1) + K_bg * Innovation_mu_g(:, k+1);
    P_mu_g = (eye(3) - K_bg * Hbg') * P_mu_g;

    % -- POSITION
    %
    %   Same as UAVestimation_tot_bias
    %

end


%% Plots

FigID = 0;

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, omega_x);
% plot(t, omega_y);
% plot(t, omega_z);
% legend('\omega_x', '\omega_y', '\omega_z', 'Location', 'best');
% xlabel('t [s]');
% ylabel('[rad/s]');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, dcm(1,:));
plot(t, dcm(2,:));
plot(t, dcm(3,:));
plot(t, dcm_est(1,:));
plot(t, dcm_est(2,:));
plot(t, dcm_est(3,:));
legend('dcm_0', 'dcm_1', 'dcm_2', 'dcme_0', 'dcme_1', 'dcme_2','Location', 'best');
xlabel('t [s]');
title("attitude");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(dcm(1,:) - dcm_est(1,:)));
plot(t, abs(dcm(2,:) - dcm_est(2,:)));
plot(t, abs(dcm(3,:) - dcm_est(3,:)));
legend('e_0', 'e_1', 'e_2', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors');
set(gca, 'YScale', 'log');
title("attitude estimation error");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, mu_g(1,:));
% plot(t, mu_g(2,:));
% plot(t, mu_g(3,:));
% plot(t, mu_g_est(1,:));
% plot(t, mu_g_est(2,:));
% plot(t, mu_g_est(3,:));
% legend('mu_g_x', 'mu_g_y', 'mu_g_z', 'mu_g_x_est', 'mu_g_y_est', 'mu_g_z_est', 'Location', 'best');
% xlabel('t [s]');
% title("gyro bias");

FigID = FigID + 1;
figure(FigID), clf, hold on;
% plot(t, mu_a(1,:));
% plot(t, mu_a(2,:));
plot(t, alpha(:));
plot(t, acc_err(:));
plot(t, a_M(:));
plot(t, ext_acc_est(1,:));
plot(t, ext_acc_est(2,:));
plot(t, ext_acc_est(3,:));
legend('alpha', '|acc|-g', 'mu_a_z', 'mu_a_x_est', 'mu_a_y_est', 'mu_a_z_est', 'Location', 'best');
% legend('mu_a_x', 'mu_a_y', 'mu_a_z', 'mu_a_x_est', 'mu_a_y_est', 'mu_a_z_est', 'Location', 'best');
xlabel('t [s]');
title("acc bias");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, a_bar(1,:));
plot(t, a_bar(2,:));
plot(t, a_bar(3,:));
plot(t, sqrt(sum(a_bar.^2)));
legend('a_x', 'a_y', 'a_z', '|| a ||', 'Location', 'best');
xlabel('t [s]');
ylabel('Accelerometers');
% 
% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, m(1,:));
% plot(t, m(2,:));
% plot(t, m(3,:));
% plot(t, sqrt(sum(m.^2)));
% legend('m_x', 'm_y', 'm_z', '|| m ||', 'Location', 'best');
% xlabel('t [s]');
% ylabel('Magnetometers');
% 
% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, uwb(1,:));
% plot(t, uwb(2,:));
% legend('uwb_x', 'uwb_y', 'Location', 'best');
% xlabel('t [s]');
% title('UWB');
