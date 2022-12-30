clear all;
close all;
clc;

% experiment parameters
NoiseScale = 1e-2;
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
a_M = g* 0.1 * (1 + sin(2*pi*t/7));

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
                [0; 0; -1] * a_M(k); % add motor acceleration

    % position and velocity
    if(k>1)
        a_tmp = wRb*a(:,k);
        p(:,k) = p(:,k-1) + v(:,k-1)*dt + a_tmp(1:2)*dt^2/2;
        v(:,k) = v(:,k-1) + a_tmp(1:2)*dt;
    end    
end


%% Corrupted measurements generation

% -- Gyroscope
mu_g = (rand(3,1) + rand(3,1).*sin(2*pi*t/100)*BiasScale); %bias
sigma_mu_g = NoiseScale*rand(3,1)*BiasScale; %bias uncert
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
alpha = zeros(t,1);
threshold_acc = 0.1;
ca_const = 0.5;
ca = ca_const;

% attitude state
dcm_est = zeros(3,n);
dcm_est(:,1) = dcm(:,1);
P_dcm = diag(NoiseScale*ones(1,3)); % attitude estimate cov
Innovation_dcm = zeros(3, n); % attitude innovation

% gyro bias
mu_g_est = zeros(3,n);
mu_g_est(:,1) = mu_g(:,1);
P_mu_g = diag(sigma_mu_g'); % gyro_bias estimate cov
Innovation_mu_g = zeros(3, n); % gyro_bias innovation

% position
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
% measurements matrix
H = [eye(4), zeros(4,3)];

% variables to compute vel from uwb (to filter corrupted measurements)
pos_buff_iter = 1;
vel_iter = -1;
pos_buff = zeros(2,2);
update_pos = false;
update_vel = false;

% motor's acceleration estimates
aM_est = zeros(1,n);

%% KF loop

for k=2:n-1
    % -- EXT ACC DETECTION
    % uses simple threshold check
    if abs(sum(a_bar(:,k-1)/norm(a_bar(:,k-1))) - g) > threshold_acc
        alpha(k-1) = 1;
        ca = ca_const;
    else
        alpha(k-1) = 0;
        ca = ca_const/2;
    end

    % -- ATTITUDE
    yG_star = omega_bar(:,k-1) - mu_g_est(:,k-1);
    Phi = eye(3) - dt*cross_prod_matrix(yG_star);
    
    % -- Prediction
    dcm_est(:,k) = Phi*dcm_est(:,k-1);
    dcm_tilde = cross_prod_matrix(dcm_est(:,k-1));
    P_dcm(:,k) = Phi*P_dcm*Phi' - dt^2*dcm_tilde*(Rg + Rbg)*dcm_tilde';
    
    % -- Update
    % Split acc contributions

    [aG, RaG] = func_aG(X_att(1:4, k+1), ...
                        a_bar(:,k+1), ...
                        X_pos(5:7,k), ...
                        Ra, ...
                        P_pos(5:7,5:7));
    
    % Magnetomter + Accelerometer measurements
    % Normalization
    m_bar_mod = norm(m_bar(:,k+1));
    m_n = m_bar(:,k+1)/m_bar_mod;
    J_M = J_normalization(m_bar(:,k+1));
    Rmn = J_M*Rm*J_M';    

    % TRIAD algorithm
    mD = sum(aG.*m_n);
    mN = sqrt(1 - mD.^2);
    Zm_num = (aG(2)*m_n(3) - aG(3)*m_n(2));
    Zm = Zm_num/mN;
    Z_bar = [aG;Zm];
    
    % uncert propagation matrices
    J_ZA = [eye(3,3);
            Zm_num*mD*m_n(1)/mN^3, ...
            m_n(3)/mN + Zm_num*mD*m_n(2)/mN^3, ...
            -m_n(2)/mN + Zm_num*mD*m_n(3)/mN^3];
    J_ZM = [zeros(3,3);
            Zm_num*mD*aG(1)/mN^3, ...
            -aG(3)/mN + Zm_num*mD*aG(2)/mN^3, ...
            aG(2)/mN + Zm_num*mD*aG(3)/mN^3];
    
    % Z uncert
    Rz = J_ZA*RaG*J_ZA' + J_ZM*Rmn*J_ZM';
    
    % Predicted measurements
    Zpred = [-2*X_att(3, k+1)*X_att(1, k+1) + 2*X_att(4, k+1)*X_att(2, k+1);
    2*X_att(2, k+1)*X_att(1, k+1) + 2*X_att(4, k+1)*X_att(3, k+1);
    X_att(1, k+1)^2 - X_att(2, k+1)^2 - X_att(3, k+1)^2 + X_att(4, k+1)^2;
    2*X_att(4, k+1)*X_att(1, k+1) + 2*X_att(3, k+1)*X_att(2, k+1)];
    
    % linearized 
    J_H = zeros(4,7);
    J_H(1:4,1:4) = 2*...
      [-X_att(3,k+1), X_att(4,k+1), -X_att(1,k+1), X_att(2,k+1);
        X_att(2,k+1), X_att(1,k+1), X_att(4,k+1), X_att(3,k+1);
        X_att(1,k+1), -X_att(2,k+1), -X_att(3,k+1), X_att(4,k+1);
        X_att(4,k+1), X_att(3,k+1), X_att(2,k+1), X_att(1,k+1)];

    Innovation_att(:,k+1) = Z_bar - Zpred;

    % Kalmann steps
    S_att = J_H*P_att*J_H' + Rz;
    W_att = P_att*J_H'/S_att;
    X_att(:, k+1) = X_att(:, k+1) + W_att*Innovation_att(:, k+1);
    P_att = (eye(7) - W_att*J_H) * P_att;

    X_att(1:4, k+1) = X_att(1:4, k+1)/norm(X_att(1:4, k+1)); 

    % -- POSITION
    [aW, J_Xpos, J_Upos, aM_est(k+1)] = func_aW(X_att(1:4, k+1), a_bar(:,k+1), X_pos(5:7,k), dt, A);

    % -- Prediction
    X_pos(1:4,k+1) = A*X_pos(1:4,k) + B*aW(1:2);
    X_pos(5:7,k+1) = X_pos(5:7,k);
    % jacobian to propagate uncertainties
    P_pos = J_Xpos*P_pos*J_Xpos' + J_Upos*[Ra,zeros(3,4); zeros(4,3), P_att(1:4,1:4)]*J_Upos';

    % -- Update
    if uwb(2,k+1) ~= 0 && abs(uwb(1,k+1)) < 10000 && uwb(2,k+1)-X_pos(2,k+1) < 10
        pos_buff(:,pos_buff_iter) = uwb(1:2,k+1);
        pos_buff_iter = pos_buff_iter +1;
        Z_pos = uwb(1:2,k+1);
        Quwb = diag(sigma_uwb(1:2));
        update_pos = true;
    end
    % if a sample is saved: increment iter
    if pos_buff_iter > 1
        vel_iter = vel_iter +1; %counts number of cycles between pos acquisition
    end

    % compute vel from uwb
    if pos_buff_iter > 2
        %compute vel
        vel_uwb = (pos_buff(:,2) - pos_buff(:,1)) / (vel_iter*dt);
        %reset variables
        pos_buff_iter = 1;
        vel_iter = -1;
        update_vel = true;
        %build matrices
        Z_pos = [uwb(1:2,k+1);vel_uwb(:)];
        Quwb = diag([sigma_uwb(1:2); sigma_uwb(1:2)*2 / (vel_iter*dt)^2]');
    end
     
    % If i got only pos from UWB
    if update_pos && ~update_vel
        %reset variable
        update_pos = false;
        % innovation
        Innovation_pos(1:2,k+1) = Z_pos - H(1:2,:)*X_pos(:,k+1);

        %kalmann steps
        S_pos = H(1:2,:) * P_pos * H(1:2,:)' + Quwb;
        W_pos = P_pos * H(1:2,:)' / S_pos;
        X_pos(:, k+1) = X_pos(:, k+1) + W_pos * Innovation_pos(1:2, k+1);
        P_pos = (eye(7) - W_pos * H(1:2,:)) * P_pos;
    % If i got pos and vel data from UWB
    elseif update_pos && update_vel
        %reset variable
        update_vel = false;
        % innovation
        Innovation_pos(:,k+1) = Z_pos - H*X_pos(:,k+1);
        
        %kalmann steps
        S_pos = H * P_pos * H' + Quwb;
        W_pos = P_pos * H' / S_pos;
        X_pos(:, k+1) = X_pos(:, k+1) + W_pos * Innovation_pos(:, k+1);
        P_pos = (eye(7) - W_pos * H) * P_pos;
       
    end

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
plot(t, q(1,:));
plot(t, q(2,:));
plot(t, q(3,:));
plot(t, q(4,:));
plot(t, X_att(1,:));
plot(t, X_att(2,:));
plot(t, X_att(3,:));
plot(t, X_att(4,:));
legend('q_0', 'q_1', 'qe_2', 'q_3', 'qe_0', 'qe_1', 'qe_2', 'qe_3', 'Location', 'best');
xlabel('t [s]');
title("attitude");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(q(1,:) - X_att(1,:)));
plot(t, abs(q(2,:) - X_att(2,:)));
plot(t, abs(q(3,:) - X_att(3,:)));
plot(t, abs(q(4,:) - X_att(4,:)));
legend('e_0', 'e_1', 'e_2', 'e_3', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors');
set(gca, 'YScale', 'log');
title("attitude estimation error");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, mu_g(1,:));
plot(t, mu_g(2,:));
plot(t, mu_g(3,:));
plot(t, X_att(5,:));
plot(t, X_att(6,:));
plot(t, X_att(7,:));
legend('mu_g_x', 'mu_g_y', 'mu_g_z', 'mu_g_x_est', 'mu_g_y_est', 'mu_g_z_est', 'Location', 'best');
xlabel('t [s]');
title("gyro bias");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, p(1,:));
plot(t, p(2,:));
plot(t, X_pos(1,:));
plot(t, X_pos(2,:));
plot(t, uwb(1,:));
plot(t, uwb(2,:));
legend('pos_x', 'pos_y', 'pos_x_est', 'pos_y_est', 'uwb_x', 'uwb_y', 'Location', 'best');
xlabel('t [s]');
title("position");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, v(1,:));
plot(t, v(2,:));
plot(t, X_pos(3,:));
plot(t, X_pos(4,:));
legend('vel_x', 'vel_y', 'vel_x_est', 'vel_y_est', 'Location', 'best');
xlabel('t [s]');
title("velocity");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(p(1,:) - X_pos(1,:)));
plot(t, abs(p(2,:) - X_pos(2,:)));
plot(t, abs(v(1,:) - X_pos(3,:)));
plot(t, abs(v(2,:) - X_pos(4,:)));
legend('e_p_x', 'e_p_y', 'e_v_x', 'e_v_y', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors');
set(gca, 'YScale', 'log');
title("position and velocity estimation error");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, mu_a(1,:));
plot(t, mu_a(2,:));
plot(t, mu_a(3,:));
plot(t, X_pos(5,:));
plot(t, X_pos(6,:));
plot(t, X_pos(7,:));
legend('mu_a_x', 'mu_a_y', 'mu_a_z', 'mu_a_x_est', 'mu_a_y_est', 'mu_a_z_est', 'Location', 'best');
xlabel('t [s]');
title("acc bias");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, a_M(:));
plot(t, aM_est(:));
legend('a_M', 'a_M_est', 'Location', 'best');
xlabel('t [s]');
title("Motor trust");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, a(1,:));
% plot(t, a(2,:));
% plot(t, a(3,:));
% plot(t, sqrt(sum(a.^2)));
% legend('a_x', 'a_y', 'a_z', '|| a ||', 'Location', 'best');
% xlabel('t [s]');
% ylabel('Accelerometers');
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
