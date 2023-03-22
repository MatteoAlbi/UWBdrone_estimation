%clc;
clear all;

%% kf to estimate trajectory and acc bias from uwb and acc data

%n_samples = length(log_acc);
n_samples = 1266;
step = 1:n_samples;
dt = 0.018; %[s]
acc_const = 9.81/1000;
acc_std_scale_factor = 300;

load("..\accelerometer_kfbias.mat");
load("..\uwb.mat");

%% Read data
uwb = importdata("data\out.txt");

acc_raw_g = importdata("data\acc.txt");

uwb = uwb(1:n_samples,:);

acc_g = acc_raw_g(1:n_samples,:) * acc_const; %data with gravity

%% Acc parameters
%remove gravity
acc = acc_g - ([0,0,1]*9.81); %sensor is flat
%for bias take value of acc
bias_acc = acc(1,:);

Qacc = Qacc*acc_std_scale_factor^2;
Qb_acc = Qb_acc*acc_std_scale_factor^2;

%% Plots

FigID = 0;

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, norm_acc_g(:,1));
% plot(step, norm_acc_g(:,2));
% plot(step, norm_acc_g(:,3));
% plot(step, mod_acc_raw_g./1000);
% legend('norm_x', 'norm_y', 'norm_z', 'tot norm');
% 
% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, acc(:,1));
% plot(step, acc(:,2));
% plot(step, acc(:,3));
% legend('a_x', 'a_y', 'a_z');

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, uwb_clean(:,1));
% plot(step, uwb_clean(:,2));
% plot(step, uwb(:,3));

%% KF
% state
X = zeros(n_samples,6);
%state inizialization
X(2,1:2) = uwb(2,1:2);
X(2,3:4) = (uwb(2,1:2) - uwb(1,1:2))/dt;
X(2,5:6) = bias_acc(1:2);

P = diag([sigma_uwb(1:2),sigma_uwb(1:2)*2/dt^2,diag(Qb_acc)']);

innovation = zeros(4,n_samples);

% variables to compute vel from uwb
pos_buff_iter = 1;
vel_iter = -1;
pos_buff = zeros(2,2);
update = false;

% state function matrices
A = [1, 0, dt, 0,  -dt^2/2, 0;
     0, 1, 0,  dt, 0,       -dt^2/2;
     0, 0, 1,  0,  -dt,      0;
     0, 0, 0,  1,  0,       -dt;
     0, 0, 0,  0,  1,       0;
     0, 0, 0,  0,  0,       1];
B = [dt^2/2, 0;
     0,      dt^2/2;
     dt,     0;
     0,      dt;
     0,      0;
     0,      0];
H = [eye(4), zeros(4,2)];

for i = 3:n_samples
    % check for relaiable data
    if uwb(i,2) ~= 0 && abs(uwb(i,1)) < 10000 && uwb(i,2)-X(i,2) < 10
        pos_buff(pos_buff_iter,:) = uwb(i,1:2);
        pos_buff_iter = pos_buff_iter +1;
    end
    % if a sample is saved: increment iter
    if pos_buff_iter > 1
        vel_iter = vel_iter +1; %counts number of cycles between pos acquisition
    end

    % compute vel from uwb
    if pos_buff_iter >= 3
        %compute vel
        vel_uwb = (pos_buff(2,:) - pos_buff(1,:)) / (vel_iter*dt);
        %reset variables
        pos_buff_iter = 1;
        vel_iter = -1;
        update = true;
        %build matrices
        Z_bar = [uwb(i,1:2)';vel_uwb(:)];
        Quwb = diag([sigma_uwb(1:2), sigma_uwb(1:2)*2 / (vel_iter*dt)^2]);
    end

    % prediction
    X(i,:) = A*X(i-1,:)' + B*acc(i,1:2)';
    P_pred = A*P*A' + B*Qacc*B';

    %update
    if update
        %reset variable
        update = false;
        % innovation
        innovation(:,i) = Z_bar - H*X(i,:)';
        
        %kalmann steps
        S = H*P_pred*H' + Quwb;
        W = P_pred*H'/S;
        P = (eye(6) - W*H)*P_pred;
        X(i,:) = X(i,:) + (W * innovation(:, i))';

    end

end

FigID = FigID + 1;
% figure(FigID), clf, hold on;
figure(11), clf, hold on;
plot(step, X(:,1));
plot(step, X(:,2));
legend('pos_x', 'pos_y');
title("Estimated position with bias estimation");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, X(:,3));
% plot(step, X(:,4));
% legend('vel_x', 'vel_y');
% title("Estimated velocity with bias estimation");
% 
% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, X(:,5));
% plot(step, X(:,6));
% legend('a_xbias', 'a_ybias');
% title("Estimated acc bias");

true_meas = open("data\Measurement10.mat");

frames = 1:true_meas.Measurement10.Frames;
true_traj = true_meas.Measurement10.RigidBodies.Positions;

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(frames, squeeze(true_traj(1,1,:))/1000);
plot(frames, squeeze(true_traj(1,2,:))/1000);
legend('pos_x', 'pos_y');
title("True position measurements");

disp("end of program");

