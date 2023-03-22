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
a_M = g* 0.1 * (1 + sin(2*pi*t/7));

% -- Variables initialization

% Quaternions
q = zeros(4,length(t));
% q(:,1) = rand(1,4);
% q(:,1) = q(:,1)/norm(q(:,1));
q(:,1) = [0,0,0,1]; % initial state

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

% -- Quaternions dynamic
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
                [0;0;0];
%                 [0; 0; -1] * a_M(k); % add motor acceleration

    % position and velocity
    if(k>1)
        a_tmp = wRb*a(:,k);
        p(:,k) = p(:,k-1) + v(:,k-1)*dt + a_tmp(1:2)*dt^2/2;
        v(:,k) = v(:,k-1) + a_tmp(1:2)*dt;
    end    
end


%% Corrupted measurements generation
gamma = [0.004; -0.006; 0.007];
% -- Gyroscope
%mu_g = zeros(3,1);
mu_g = (rand(3,1) + rand(3,1)/10.*sin(2*pi*t/100)*BiasScale); %bias
%mu_g = t .* gamma;
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

ekf_filt = EKF( Ra, Rm, Rg, Rbg, eye(3));
mad_filt = Madgwick(q(:,1) + rand(4,1)*NoiseScale, ...
                    Rg, ...
                    gamma + rand(3,1)*NoiseScale);

ekf_filt.init_att(a_bar(:,1), m_bar(:,1), mu_g(:,1));
ekf_filt.X_att = [q(:,1); mu_g(:,1)];
% ekf_filt.P_att = [eye(4), zeros(4,3);
%                   zeros(3,4), eye(3)/1000];

mad_filt.imu_filter(a_bar(:,1), omega_bar(:,1), m_bar(:,1), dt);

% attitude
X_att_ekf = zeros(7,n);
X_att_mad = zeros(7,n);


%% KF loop

for k=1:n-1
    % -- ATTITUDE EKF
    ekf_filt.step(omega_bar(:,k+1), dt, a_bar(:,k+1), m_bar(:,k+1));
    X_att_ekf(:, k+1) = ekf_filt.get_att(); 

    % -- Madgwick
    X_att_mad(1:4, k+1) = mad_filt.imu_filter(a_bar(:,k+1), omega_bar(:,k+1), m_bar(:,k+1), dt);
    X_att_mad(5:7, k+1) = mad_filt.get_bias();

%     % -- POSITION
%     [aW, J_Xpos, J_Upos, aM_est(k+1)] = func_aW(X_att(1:4, k+1), a_bar(:,k+1), X_pos(5:7,k), dt, A);
% 
%     % -- Prediction
%     X_pos(1:4,k+1) = A*X_pos(1:4,k) + B*aW(1:2);
%     X_pos(5:7,k+1) = X_pos(5:7,k);
%     % jacobian to propagate uncertainties
%     P_pos = J_Xpos*P_pos*J_Xpos' + J_Upos*[Ra,zeros(3,4); zeros(4,3), P_att(1:4,1:4)]*J_Upos';
% 
%     % -- Update
%     if uwb(2,k+1) ~= 0 && abs(uwb(1,k+1)) < 10000 && uwb(2,k+1)-X_pos(2,k+1) < 10
%         pos_buff(:,pos_buff_iter) = uwb(1:2,k+1);
%         pos_buff_iter = pos_buff_iter +1;
%         Z_pos = uwb(1:2,k+1);
%         Quwb = diag(sigma_uwb(1:2));
%         update_pos = true;
%     end
%     % if a sample is saved: increment iter
%     if pos_buff_iter > 1
%         vel_iter = vel_iter +1; %counts number of cycles between pos acquisition
%     end
% 
%     % compute vel from uwb
%     if pos_buff_iter > 2
%         %compute vel
%         vel_uwb = (pos_buff(:,2) - pos_buff(:,1)) / (vel_iter*dt);
%         %reset variables
%         pos_buff_iter = 1;
%         vel_iter = -1;
%         update_vel = true;
%         %build matrices
%         Z_pos = [uwb(1:2,k+1);vel_uwb(:)];
%         Quwb = diag([sigma_uwb(1:2); sigma_uwb(1:2)*2 / (vel_iter*dt)^2]');
%     end
%      
%     % If i got only pos from UWB
%     if update_pos && ~update_vel
%         %reset variable
%         update_pos = false;
%         % innovation
%         Innovation_pos(1:2,k+1) = Z_pos - H(1:2,:)*X_pos(:,k+1);
% 
%         %kalmann steps
%         S_pos = H(1:2,:) * P_pos * H(1:2,:)' + Quwb;
%         W_pos = P_pos * H(1:2,:)' / S_pos;
%         X_pos(:, k+1) = X_pos(:, k+1) + W_pos * Innovation_pos(1:2, k+1);
%         P_pos = (eye(7) - W_pos * H(1:2,:)) * P_pos;
%     % If i got pos and vel data from UWB
%     elseif update_pos && update_vel
%         %reset variable
%         update_vel = false;
%         % innovation
%         Innovation_pos(:,k+1) = Z_pos - H*X_pos(:,k+1);
%         
%         %kalmann steps
%         S_pos = H * P_pos * H' + Quwb;
%         W_pos = P_pos * H' / S_pos;
%         X_pos(:, k+1) = X_pos(:, k+1) + W_pos * Innovation_pos(:, k+1);
%         P_pos = (eye(7) - W_pos * H) * P_pos;
%        
%     end

end


%% Plots
eul_ekf = quat2eul(X_att_ekf(1:4,:)', "XYZ")' * 180/pi;
eul_mad = quat2eul(X_att_mad(1:4,:)', "XYZ")' * 180/pi;
eul_true = quat2eul(q.', "XYZ").' * 180/pi;

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
plot(t, eul_true(1,:));
plot(t, eul_true(2,:));
plot(t, eul_true(3,:));
plot(t, eul_ekf(1,:));
plot(t, eul_ekf(2,:));
plot(t, eul_ekf(3,:));
legend('\phi_{ekf}', '\theta_{ekf}', '\psi_{ekf}', '\phi_{true}', '\theta_{true}', '\psi_{true}', 'Location', 'best');
xlabel('t [s]');
title("attitude EKF");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(eul_true(1,:) - eul_ekf(1,:)));
plot(t, abs(eul_true(2,:) - eul_ekf(2,:)));
plot(t, abs(eul_true(3,:) - eul_ekf(3,:)));
legend('\phi_{err}', '\theta_{err}', '\psi_{err}', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors [deg]');
set(gca, 'YScale', 'log');
title("attitude estimation error EKF");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, mu_g(1,:));
plot(t, mu_g(2,:));
plot(t, mu_g(3,:));
plot(t, X_att_ekf(5,:));
plot(t, X_att_ekf(6,:));
plot(t, X_att_ekf(7,:));
legend('mu_g_x', 'mu_g_y', 'mu_g_z', 'mu_g_x_est', 'mu_g_y_est', 'mu_g_z_est', 'Location', 'best');
xlabel('t [s]');
ylabel('Gyroscope bias [rad/s]');
title("gyro bias EKF");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(mu_g(1,:) - X_att_ekf(5,:)));
plot(t, abs(mu_g(2,:) - X_att_ekf(6,:)));
plot(t, abs(mu_g(3,:) - X_att_ekf(7,:)));
legend('e_x', 'e_y', 'e_z', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors [rad/s]');
set(gca, 'YScale', 'log');
title("gyro bias estimation error EKF");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, eul_mad(1,:));
plot(t, eul_mad(2,:));
plot(t, eul_mad(3,:));
plot(t, eul_true(1,:));
plot(t, eul_true(2,:));
plot(t, eul_true(3,:));
legend('\phi_{mad}', '\theta_{mad}', '\psi_{mad}', '\phi_{true}', '\theta_{true}', '\psi_{true}', 'Location', 'best');
xlabel('t [s]');
title("attitude Madgwick");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(eul_true(1,:) - eul_mad(1,:)));
plot(t, abs(eul_true(2,:) - eul_mad(2,:)));
plot(t, abs(eul_true(3,:) - eul_mad(3,:)));
legend('\phi_{err}', '\theta_{err}', '\psi_{err}', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors [deg]');
set(gca, 'YScale', 'log');
title("attitude estimation error Madgwick");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, p(1,:));
% plot(t, p(2,:));
% plot(t, X_pos(1,:));
% plot(t, X_pos(2,:));
% plot(t, uwb(1,:));
% plot(t, uwb(2,:));
% legend('pos_x', 'pos_y', 'pos_x_est', 'pos_y_est', 'uwb_x', 'uwb_y', 'Location', 'best');
% xlabel('t [s]');
% title("position");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, v(1,:));
% plot(t, v(2,:));
% plot(t, X_pos(3,:));
% plot(t, X_pos(4,:));
% legend('vel_x', 'vel_y', 'vel_x_est', 'vel_y_est', 'Location', 'best');
% xlabel('t [s]');
% title("velocity");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, abs(p(1,:) - X_pos(1,:)));
% plot(t, abs(p(2,:) - X_pos(2,:)));
% plot(t, abs(v(1,:) - X_pos(3,:)));
% plot(t, abs(v(2,:) - X_pos(4,:)));
% legend('e_p_x', 'e_p_y', 'e_v_x', 'e_v_y', 'Location', 'best');
% xlabel('t [s]');
% ylabel('Absolute errors');
% set(gca, 'YScale', 'log');
% title("position and velocity estimation error");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, mu_a(1,:));
% plot(t, mu_a(2,:));
% plot(t, mu_a(3,:));
% plot(t, X_pos(5,:));
% plot(t, X_pos(6,:));
% plot(t, X_pos(7,:));
% legend('mu_a_x', 'mu_a_y', 'mu_a_z', 'mu_a_x_est', 'mu_a_y_est', 'mu_a_z_est', 'Location', 'best');
% xlabel('t [s]');
% title("acc bias");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, a_M(:));
% plot(t, aM_est(:));
% legend('a_M', 'a_M_est', 'Location', 'best');
% xlabel('t [s]');
% title("Motor trust");

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
