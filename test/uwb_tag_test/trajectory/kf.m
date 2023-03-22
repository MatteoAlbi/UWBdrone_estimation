clc;
clear all;

%n_samples = length(log_acc);
n_samples = 1266;
step = 1:n_samples;
dt = 0.018; %[s]
acc_const = 9.81/1000;
acc_std_scale_factor = 10;

load("..\accelerometer.mat");
load("..\uwb.mat");

%% Read data
uwb = importdata("data\out.txt");

acc_raw_g = importdata("data\acc.txt");

uwb = uwb(1:n_samples,:);

acc_g = acc_raw_g(1:n_samples,:) * acc_const; %data with gravity

%% Acc parameters
%remove gravity
acc = acc_g - ([0,0,1]*9.81); %sensor is flat
%for bias take mean value of 20 first sample (not moving)
bias_acc = mean(acc(20,:));
acc_nobias = acc - bias_acc;

Qacc = Qacc*acc_std_scale_factor^2; %due to vibrations


%% Plots

FigID = 0;

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, acc_nobias(:,1));
% plot(step, acc(:,1));
% plot(step, acc_nobias(:,2));
% plot(step, acc(:,2));
% plot(step, acc_nobias(:,3));
% plot(step, acc(:,3));
% legend('a_x', 'a_xbias', 'a_y', 'a_ybias', 'a_z', 'a_zbias');

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, uwb_clean(:,1));
% plot(step, uwb_clean(:,2));
% %plot(step, uwb(:,3));

%% KF
% state
X = zeros(n_samples,4);
%state inizialization
X(2,1:2) = uwb(2,1:2);
X(2,3:4) = (uwb(2,1:2) - uwb(1,1:2))/dt;

P = diag([sigma_uwb(1:2),sigma_uwb(1:2)*2/dt^2]);

innovation = zeros(4,n_samples);

% variables to compute vel from uwb
pos_buff_iter = 1;
vel_iter = -1;
pos_buff = zeros(2,2);
update = false;

% state function matrices
A = [1, 0, dt, 0;
     0, 1, 0,  dt;
     0, 0, 1,  0;
     0, 0, 0,  1];
B = [dt^2/2, 0;
     0,      dt^2/2;
     dt,     0;
     0,      dt];
H = eye(4);

for i = 3:n_samples
    % check for relaiable data
%     if uwb(i,1:2)-X(i,1:2) < 10
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
        vel_uwb = (pos_buff(2,:) - pos_buff(1,:)) / (vel_iter*dt);
        pos_buff_iter = 1;
        vel_iter = -1;
        update = true;
        Z_bar = [uwb(i,1:2)';vel_uwb(:)];
        Quwb = diag([sigma_uwb(1:2), sigma_uwb(1:2)*2 / (vel_iter*dt)^2]);
    end

    % prediction
    X(i,:) = A*X(i-1,:)' + B*acc_nobias(i,1:2)';
    P_pred = A*P*A' + B*Qacc*B';

    %update
    if update
        update = false;
        % innovation
        innovation(:,i) = Z_bar - H*X(i,:)';
        
        %kalmann steps
        S = H*P_pred*H' + Quwb;
        W = P_pred*H'/S;
        P = (eye(4) - W*H)*P_pred;
        X(i,:) = X(i,:) + (W * innovation(:, i))';

    end

end

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(step, X(:,1));
plot(step, X(:,2));
legend('pos_x', 'pos_y');
title("Estimated position without bias estimation");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(step, X(:,3));
% plot(step, X(:,4));
% legend('vel_x', 'vel_y');
% title("Estimated velocity without bias estimation");

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

