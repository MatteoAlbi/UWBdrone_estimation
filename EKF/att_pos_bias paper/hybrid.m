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
a_M = g* 0.4 * (1 + sin(2*pi*t/10));
a_M(1:500) = zeros(1,500);
a_M(800:1000) = zeros(1,201);

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
ext_acc = [1; 1; 0] * a_M;
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
                ext_acc(:,k); % add random acceleration

    % position and velocity
    if(k>1)
        a_tmp = wRb*a(:,k);
        p(:,k) = p(:,k-1) + v(:,k-1)*dt + a_tmp(1:2)*dt^2/2;
        v(:,k) = v(:,k-1) + a_tmp(1:2)*dt;
    end    
end


%% Corrupted measurements generation
% -- Gyroscope
%mu_g = zeros(3,1);
mu_g = (rand(3,1) + rand(3,1)/1*sin(2*pi*t/100)*BiasScale); %bias
sigma_mu_g = NoiseScale*rand(3,1)*BiasScale; %bias uncert
Rbg = diag(sigma_mu_g.^2); %bias cov

sigma_g = NoiseScale*rand(3,1); %meas uncert
Rg = diag(sigma_g.^2); %meas cov

% Noisy ang rates
omega_bar = [omega_x; ...
             omega_y; ...
             omega_z] + mu_g + mvnrnd(zeros(1,3), Rbg+Rg, n)';

% -- Accelerometer
sigma_a = NoiseScale/10*rand(3,1); %meas uncert
Ra = diag(sigma_a.^2); %meas cov

% Noisy measurements
a_bar = a + mvnrnd(zeros(1,3), Ra, n)'; 

% -- Magnetometer
mu_m = zeros(3,1); %bias
sigma_m = NoiseScale*rand(1,3); %meas uncert
Rm = diag(sigma_m.^2); %meas cov
% In future: add calibration

% Noisy measurements
m_bar = m + mvnrnd(mu_m, Rm, n)';

% -- UWB
mu_uwb = zeros(3,1); %bias
sigma_uwb = NoiseScale*rand(3,1); %meas uncert
Ruwb = diag(sigma_uwb.^2); %meas cov

% Noisy measurements
p = [p; ones(1,n)];
uwb = p + mvnrnd(mu_uwb, Ruwb, n)';

%% log variables
q_ekf = zeros(4, n);
gyro_b_ekf = zeros(3, n);
p_ekf = zeros(2, n);
v_ekf = zeros(2, n);
ext_acc_ekf = zeros(3, n);
acc_det = zeros(1, n);

%% Estimates

% -- Initialization

ekf = EKF( Ra*10, Rm, Rg, Rbg, Ruwb, zeros(3,1), eye(1), zeros(3,1), ones(3,1));

ekf.init_att(a_bar(:,1), m_bar(:,1), mu_g(:,1), t(1));
ekf.init_att(a_bar(:,1), m_bar(:,1), mu_g(:,1), t(1));
ekf.init_pos(uwb(:,1), t(1));


%% KF loop

for k=2:n
    % -- ATTITUDE EKF
    ekf.step_imu(a_bar(:,k), m_bar(:,k), omega_bar(:,k), t(k));
    ekf.step_uwb(uwb(:,k), t(k));

    q_ekf(:,k) = ekf.get_att();
    gyro_b_ekf(:,k) = ekf.get_g_b();
    p_ekf(:,k) = ekf.get_pos();
    v_ekf(:,k) = ekf.get_vel();
    acc_det(k) = ekf.get_acc_det();
    ext_acc_ekf(:,k) = ekf.get_ext_acc();

end


%% Plots
eul_ekf = quat2eul(q_ekf', "XYZ")' * 180/pi;
eul_true = quat2eul(q', "XYZ")' * 180/pi;

FigID = 0;

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, omega_x);
% plot(t, omega_y);
% plot(t, omega_z);
% legend('\omega_x', '\omega_y', '\omega_z', 'Location', 'best');
% xlabel('t [s]');
% ylabel('[rad/s]');

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, eul_true(1,:));
% plot(t, eul_true(2,:));
% plot(t, eul_true(3,:));
% plot(t, eul_ekf(1,:));
% plot(t, eul_ekf(2,:));
% plot(t, eul_ekf(3,:));
% legend('\phi_{ekf}', '\theta_{ekf}', '\psi_{ekf}', '\phi_{true}', '\theta_{true}', '\psi_{true}', 'Location', 'best');
% xlabel('t [s]');
% ylabel('Euler angles [deg]')
% title("attitude EKF");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(eul_true(1,:) - eul_ekf(1,:)));
plot(t, abs(eul_true(2,:) - eul_ekf(2,:)));
plot(t, abs(eul_true(3,:) - eul_ekf(3,:)));
legend('\phi_{err}', '\theta_{err}', '\psi_{err}', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute error [deg]')
set(gca, 'YScale', 'log');
title("Euler angles error");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, mu_g(1,:));
% plot(t, mu_g(2,:));
% plot(t, mu_g(3,:));
% plot(t, gyro_b_ekf(1,:));
% plot(t, gyro_b_ekf(2,:));
% plot(t, gyro_b_ekf(3,:));
% legend('\mu_g_x true', '\mu_g_y true', '\mu_g_z true', '\mu_g_x est', '\mu_g_y est', '\mu_g_z est', 'Location', 'best');
% xlabel('t [s]');
% ylabel('bias [rad/s]')
% title("Gyroscope bias");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(mu_g(1,:) - gyro_b_ekf(1,:)));
plot(t, abs(mu_g(2,:) - gyro_b_ekf(2,:)));
plot(t, abs(mu_g(3,:) - gyro_b_ekf(3,:)));
legend('e_x', 'e_y', 'e_z', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors [rad/s]');
set(gca, 'YScale', 'log');
title("Gyro bias estimation error");


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

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(p(1,:) - p_ekf(1,:)));
plot(t, abs(p(2,:) - p_ekf(2,:)));
plot(t, abs(v(1,:) - v_ekf(1,:)));
plot(t, abs(v(2,:) - v_ekf(2,:)));
legend('x_{err} [m]', 'y_{err} [m]', 'u_{err} [m/s]', 'v_{err} [m/s]', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors');
set(gca, 'YScale', 'log');
title("Position and velocity estimation error");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, ext_acc(1,:));
plot(t, ext_acc(2,:));
plot(t, ext_acc(3,:));
plot(t, acc_det*2);
legend('a_x', 'a_y', 'a_z',' acc det', 'Location', 'best');
ylabel('Acceleration [m/s^2]');
xlabel('t [s]');
title("True external accelerations");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, ext_acc_ekf(1,:));
plot(t, ext_acc_ekf(2,:));
plot(t, ext_acc_ekf(3,:));
plot(t, acc_det);
legend('a_x est', 'a_y est', 'a_z est', ' acc det', 'Location', 'best');
ylabel('Acceleration [m/s^2]');
xlabel('t [s]');
title("Estimated external accelerations");

acc_norm = zeros(1,n);
for i=1:n
    acc_norm(i) = norm(a_bar(:,i));
end

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, acc_norm);
plot(t, acc_det*10);
legend('||acc||', 'acc det', 'Location', 'best');
xlabel('t [s]');
title("acc detection");

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
