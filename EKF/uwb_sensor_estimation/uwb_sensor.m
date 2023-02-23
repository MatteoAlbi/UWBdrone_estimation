clear all;
close all;
clc;

% sensor params
Ra = diag([10.663, 8.27316, 16.6894]);
Rm = diag([21.0981, 22.5288, 21.9521]);
soft_iron = [1.0562, 0.0597149, 0.00421155;
             0.0597149, 1.01886, -0.0164807;
             0.00421157, -0.0164808, 0.932647];

% read sensor data
data = readmatrix("data.csv");
n = length(data);
acc = data(:,1:3);
mag = data(:,4:6);

Duration = 100;
dt = Duration/n;
t = dt:dt:Duration;

% instantiate filter
X_att_ekf = zeros(4,n);
eul = zeros(3,n);
filt = EKF(Ra, Rm, soft_iron);

%% Estimates

% Initialization
filt.init_att(acc(1,:), mag(1,:));
X_att_ekf(:,1) = filt.get_att();

% run
for i = 2:n
    filt.step(acc(i,:), mag(i,:));
    X_att_ekf(:,i) = filt.get_att();
end

for i=1:n
    eul(:,i) = quat_to_eul(X_att_ekf(:,i));
end


%% Plots
FigID = 0;

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, X_att_ekf(1,:), 'LineWidth', 1.5);
plot(t, X_att_ekf(2,:), 'LineWidth', 1.5);
plot(t, X_att_ekf(3,:), 'LineWidth', 1.5);
plot(t, X_att_ekf(4,:), 'LineWidth', 1.5);
legend('q_0', 'q_1', 'qe_2', 'q_3', 'Location', 'best');
xlabel('t [s]');
title("attitude");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, eul(1,:));
plot(t, eul(2,:));
plot(t, eul(3,:));
legend('x', 'y', 'z', 'Location', 'best');
xlabel('t [s]');
title("Estimated euler angles");

eul = (quat2eul(X_att_ekf')*180/pi)';

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, eul(1,:));
plot(t, eul(2,:));
plot(t, eul(3,:));
legend('x', 'y', 'z', 'Location', 'best');
xlabel('t [s]');
title("Estimated euler angles");


FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, acc(:,1));
plot(t, acc(:,2));
plot(t, acc(:,3));
legend('a_x', 'a_y', 'a_z', 'Location', 'best');
xlabel('t [s]');
ylabel('Accelerometers');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, mag(:,1));
plot(t, mag(:,2));
plot(t, mag(:,3));
legend('m_x', 'm_y', 'm_z', 'Location', 'best');
xlabel('t [s]');
ylabel('Magnetometers');
