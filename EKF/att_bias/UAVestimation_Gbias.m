clear all;
close all;
clc;

NoiseScale = 1e-2;
BiasScale = 1e-1;
Duration = 100;

%% Quaternion dynamics

% Length of inputs
Dt = 0.1;
t = 0:Dt:Duration;

% Inputs
omega_x = 0.1*sin(2*pi*t/10);
omega_y = 0.2*cos(2*pi*t/4);
omega_z = 0.4*sin(2*pi*t/3);

% Motor acceleration
aM = 0.02 * (1 + sin(2*pi*t/7));

% Quaternion
q = zeros(4,length(t));
% q(:,1) = rand(1,4);
% q(:,1) = q(:,1)/norm(q(:,1));
q(:,1) = [0,0,0,1];

% Number of samples
n = length(t);
Z = zeros(4,n);
mw = [rand(1); 0; rand(1)];
mw = mw/norm(mw);
m = zeros(3,n);
a = zeros(3,n);
for k=1:n-1
    S_omega = [0, -omega_x(k), -omega_y(k), -omega_z(k);
        0, 0, omega_z(k), -omega_y(k);
        0, 0, 0, omega_x(k);
        zeros(1,4)];
    S_omega = S_omega - S_omega';
    q(:,k+1) = (S_omega*Dt/2 + eye(4))*q(:,k);
    
    q(:, k+1) = q(:, k+1)/norm(q(:, k+1));
    
    % Measurements:
    % a - Accelerometers
    Za = [-2*q(3,k+1)*q(1,k+1) + 2*q(4,k+1)*q(2,k+1);
        2*q(2,k+1)*q(1,k+1) + 2*q(4,k+1)*q(3,k+1);
        q(1,k+1)^2 - q(2,k+1)^2 - q(3,k+1)^2 + q(4,k+1)^2] + [0;0;-1]*aM(k+1);
    % b - Magnetometer + accelerometer
    Zm = 2*q(4,k+1)*q(1,k+1) + 2*q(3,k+1)*q(2,k+1);
    % Overall
    Z(:,k+1) = [Za; Zm];
    % Magnetometer readings
    wRb = [q(1,k+1)^2 + q(2,k+1)^2 - q(3,k+1)^2 - q(4,k+1)^2, 2*q(3,k+1)*q(2,k+1) - 2*q(4,k+1)*q(1,k+1), 2*q(3,k+1)*q(1,k+1) + 2*q(4,k+1)*q(2,k+1);
        2*q(4,k+1)*q(1,k+1) + 2*q(3,k+1)*q(2,k+1), q(1,k+1)^2 - q(2,k+1)^2 + q(3,k+1)^2 - q(4,k+1)^2, -2*q(2,k+1)*q(1,k+1) + 2*q(4,k+1)*q(3,k+1);
        -2*q(3,k+1)*q(1,k+1) + 2*q(4,k+1)*q(2,k+1), 2*q(2,k+1)*q(1,k+1) + 2*q(4,k+1)*q(3,k+1), q(1,k+1)^2 - q(2,k+1)^2 - q(3,k+1)^2 + q(4,k+1)^2];
    m(:,k+1) = wRb'*mw;    
end


%% Gyroscope

% GyroUnc
mu_g = (rand(3,1) + rand(3,1).*sin(2*pi*t/100)).*BiasScale;
sigma_mu_g = BiasScale*NoiseScale*rand(3,1);
Rb = diag(sigma_mu_g.^2);

sigma_g = NoiseScale*rand(3,1);
Rg = diag(sigma_g.^2);

% Measured velocities
omega_bar = [omega_x; 
    omega_y;
    omega_z] + randn(3, n).*(sigma_g*ones(1,n)) ...
      + mu_g + randn(3, n).*(sigma_mu_g*ones(1,n));


%% Accelerometer

g = 9.8;

% Accelerometer uncertainties
mu_a = zeros(3,1);
sigma_a = NoiseScale*rand(3,1);

% Covariance matrix
Ra = diag(sigma_a.^2);

% Noisy measurements
a_bar = Z(1:3,:)*g + mvnrnd(mu_a, Ra, n)';


%% Magnetometer

% Uncertainties
mu_m = zeros(3,1);
sigma_m = NoiseScale*rand(3,1);
Rm = diag(sigma_m.^2);

% Noisy measurements
m_bar = m + mvnrnd(mu_m, Rm, n)';


%% Estimates

% q_est = zeros(4, n);
% b_est = zeros(3, n);
% q_est(:,1) = q(:,1); %[1; 0; 0; 0];
% b_est(:,1) = BiasScale*rand(3,1);

X_est = zeros(7,n);
X_est(1:4,1) = q(:,1);
X_est(5:7,1) = mu_g(:,1);

P = diag([NoiseScale*ones(1,4),sigma_mu_g']);
Innovation = zeros(4, n);

for k=1:n-1
    % Prediction
    omega_no_bias = omega_bar(:,k) - X_est(5:7,k);
    S_omega = [0, -omega_no_bias(1), -omega_no_bias(2), -omega_no_bias(3);
        0, 0, omega_no_bias(3), -omega_no_bias(2);
        0, 0, 0, omega_no_bias(1);
        zeros(1,4)];
    S_omega = S_omega - S_omega';

    X_est(1:4, k+1) = (S_omega*Dt/2 + eye(4))*X_est(1:4, k);
    X_est(1:4, k+1) = X_est(1:4, k+1)/norm(X_est(1:4, k+1));

    X_est(5:7, k+1) = X_est(5:7, k);
    
    % Covariance of the prediction
    G = [-X_est(2,k), -X_est(3,k), -X_est(4,k);
        X_est(1,k), -X_est(4,k), X_est(3,k);
        X_est(4,k), X_est(1,k), -X_est(2,k);
        -X_est(3,k), X_est(2,k), X_est(1,k)]*Dt/2;

    J_G = [ G;
            zeros(3,3)];
    J_B = [ G;
            eye(3,3)];
    J_X = [ S_omega*Dt/2 + eye(4), -G;
            zeros(3,4),eye(3,3)];

    Ppred = J_X*P*J_X' + J_G*Rg*J_G' + J_B*Rb*J_B';
    
    % Update
    
    % Magnetomter + Accelerometer measurements
    % Normalization
    a_bar_mod = norm(a_bar(:,k+1));
    a_n = a_bar(:,k+1)/a_bar_mod;
    J_A = J_normalization(a_bar(:,k+1));
    Ran = J_A*Ra*J_A';

    m_bar_mod = norm(m_bar(:,k+1));
    m_n = m_bar(:,k+1)/m_bar_mod;
    J_M = J_normalization(m_bar(:,k+1));
    Rmn = J_M*Rm*J_M';    

    % TRIAD algorithm
    mD = sum(a_n.*m_n);
    mN = sqrt(1 - mD.^2);
    Zm_num = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
    Zm_bar = Zm_num/mN;
    Z_bar = [a_n;Zm_bar];

    J_ZA = [eye(3,3);
            Zm_num*mD*m_n(1)/mN^3, ...
            m_n(3)/mN + Zm_num*mD*m_n(2)/mN^3, ...
            -m_n(2)/mN + Zm_num*mD*m_n(3)/mN^3];
    J_ZM = [zeros(3,3);
            Zm_num*mD*a_n(1)/mN^3, ...
            -a_n(3)/mN + Zm_num*mD*a_n(2)/mN^3, ...
            a_n(2)/mN + Zm_num*mD*a_n(3)/mN^3];
%     J_Z = [J_ZA,J_ZM];
    
    Rz = J_ZA*Ran*J_ZA' + J_ZM*Rmn*J_ZM';
    
    % Predicted measurements
    Zpred = [-2*X_est(3, k+1)*X_est(1, k+1) + 2*X_est(4, k+1)*X_est(2, k+1);
    2*X_est(2, k+1)*X_est(1, k+1) + 2*X_est(4, k+1)*X_est(3, k+1);
    X_est(1, k+1)^2 - X_est(2, k+1)^2 - X_est(3, k+1)^2 + X_est(4, k+1)^2;
    2*X_est(4, k+1)*X_est(1, k+1) + 2*X_est(3, k+1)*X_est(2, k+1)];
    
    J_H = zeros(4,7);
    J_H(1:4,1:4) = 2*...
      [-X_est(3,k+1), X_est(4,k+1), -X_est(1,k+1), X_est(2,k+1);
        X_est(2,k+1), X_est(1,k+1), X_est(4,k+1), X_est(3,k+1);
        X_est(1,k+1), -X_est(2,k+1), -X_est(3,k+1), X_est(4,k+1);
        X_est(4,k+1), X_est(3,k+1), X_est(2,k+1), X_est(1,k+1)];

    Innovation(:,k+1) = Z_bar - Zpred;

    % Kalman steps
    S = J_H*Ppred*J_H' + Rz;
    W = Ppred*J_H'/S;
    X_est(:, k+1) = X_est(:, k+1) + W*Innovation(:, k+1);
    P = (eye(7) - W*J_H)*Ppred;

    X_est(1:4, k+1) = X_est(1:4, k+1)/norm(X_est(1:4, k+1));    
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
plot(t, sqrt(sum(q.^2)));
legend('q_0', 'q_1', 'q_2', 'q_3', '|| q ||', 'Location', 'best');
xlabel('t [s]');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, X_est(1,:));
plot(t, X_est(2,:));
plot(t, X_est(3,:));
plot(t, X_est(4,:));
plot(t, sqrt(sum(X_est(1:4,:).^2)));
legend('qe_0', 'qe_1', 'qe_2', 'qe_3', '|| qe ||', 'Location', 'best');
xlabel('t [s]');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, abs(q(1,:) - X_est(1,:)));
plot(t, abs(q(2,:) - X_est(2,:)));
plot(t, abs(q(3,:) - X_est(3,:)));
plot(t, abs(q(4,:) - X_est(4,:)));
plot(t, abs(sqrt(sum(q.^2)) - sqrt(sum(X_est(1:4,:).^2))));
legend('e_0', 'e_1', 'e_2', 'e_3', '|| e ||', 'Location', 'best');
xlabel('t [s]');
ylabel('Absolute errors');
set(gca, 'YScale', 'log');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, Innovation(1,:));
plot(t, Innovation(2,:));
plot(t, Innovation(3,:));
plot(t, Innovation(4,:));
legend('i_1', 'i_2', 'i_3', 'i_4', 'Location', 'best');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, mu_g(1,:));
plot(t, mu_g(2,:));
plot(t, mu_g(3,:));
legend('mu_g_x', 'mu_g_y', 'mu_g_z', 'Location', 'best');
xlabel('t [s]');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, X_est(5,:));
plot(t, X_est(6,:));
plot(t, X_est(7,:));
legend('mu_g_x_est', 'mu_g_y_est', 'mu_g_z_est', 'Location', 'best');
xlabel('t [s]');

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, Z(1,:));
% plot(t, Z(2,:));
% plot(t, Z(3,:));
% plot(t, sqrt(sum(m.^2)));
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

