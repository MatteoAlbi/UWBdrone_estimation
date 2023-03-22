clear all;
% close all;
clc;

buf_len = 4;

%% EKF config
conf = readcell("data_collected\conf.csv");

tmp = split(conf{1,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
ab = [tmp{1:end}]';

tmp = split(conf{2,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
as = [tmp{1:end}]';

tmp = split(conf{3,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
hi = [tmp{1:end}]';

tmp = split(conf{4,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
si = reshape([tmp{1:end}]', 3,3);

tmp = split(conf{5,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
gb = [tmp{1:end}]';

tmp = split(conf{6,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
ra = reshape([tmp{1:end}]', 3,3)*10000;

tmp = split(conf{7,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
rm = reshape([tmp{1:end}]', 3,3);

tmp = split(conf{8,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
rg = reshape([tmp{1:end}]', 3,3);

tmp = split(conf{9,2}, ';')';
tmp = cellfun(@str2num,tmp(2:end),'un',0).';
ru = reshape([tmp{1:end}]', 3,3)/1;

%% Real measurements
load("data_collected\mavic2.mat");
true_pos = squeeze(Measurement6.RigidBodies.Positions)/1000;
true_rot = squeeze(Measurement6.RigidBodies.Rotations);
true_angles = squeeze(Measurement6.RigidBodies.RPYs);

%% Corrupted measurements
data = readcell("data_collected\mavic2.csv");
n = length(data);
buf_acc = zeros(3,buf_len); 

%% log variables
q_ekf = zeros(4, n);
gyro_b_ekf = zeros(3, n);
p_ekf = zeros(2, n);
v_ekf = zeros(2, n);
ext_acc = zeros(3, n);
acc_det = zeros(1, n);

acc_rec = zeros(3, n);
mag_rec = zeros(3, n);
gyro_rec = zeros(3, n);
uwb_rec = zeros(3, n);

%% build t vectors
t_ekf = zeros(1, n);

tmp = split(data{2}, ';')';
tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
tmp = [tmp{1:end}]';
t_ekf(2) = tmp(end);
t_base = tmp(end);

for k=3:n
    tmp = split(data{k}, ';')';
    tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
    tmp = [tmp{1:end}]';

    if length(tmp) == 4
        tmp = split(data{k-1}, ';')';
        tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
        tmp = [tmp{1:end}]';
        t1 = tmp(end);

        tmp = split(data{k+1}, ';')';
        tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
        tmp = [tmp{1:end}]';
        t2 = tmp(end);

        dt = (t2-t1)/2;
        t_ekf(k) = t_ekf(k-1)+dt;

    else
        tmp = split(data{k}, ';')';
        tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
        tmp = [tmp{1:end}]';
        t_ekf(k) = tmp(end);

    end

end

t_ekf = t_ekf - t_base;
% first value
t_ekf(1) = t_ekf(2) - t_ekf(3);
t_ekf = t_ekf - t_ekf(1);

t_true = (0:1:Measurement6.Frames-1) ./ Measurement6.FrameRate;



%% EKF running

ekf = EKF2(ra,rm,rg,rg./100,ru,hi,si,ab,as);

%init states
k = 1;
tmp = split(data{k}, ';')';
tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
tmp = [tmp{1:end}]';
pos = tmp(1:3); %[m]
pos_t = tmp(end)/1000; %[s]
ekf.init_pos(pos, pos_t)

uwb_rec(:,k) = reshape(pos, 3,1);
acc_rec(:,k) = NaN(3,1);
mag_rec(:,k) = NaN(3,1);
gyro_rec(:,k) = NaN(3,1);


k = 2;
tmp = split(data{k}, ';')';
tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
tmp = [tmp{1:end}]';
acc = tmp(1:3); %[m/s^2]
mag = tmp(4:6); %[gauss]
gyro = tmp(7:9)/180*pi; %[rad/s]
att_t = tmp(end); %[s]
ekf.init_att(acc, mag, gb, att_t);

uwb_rec(:,k) = NaN(3,1);
acc_rec(:,k) = reshape(acc, 3,1);
mag_rec(:,k) = reshape(mag, 3,1);
gyro_rec(:,k) = reshape(gyro, 3,1);

for i=1:buf_len
    buf_acc(:,i) = acc;
end

for k=3:n
    % extract data from row
    tmp = split(data{k}, ';')';
    tmp = cellfun(@str2num,tmp(1:end-1),'un',0).';
    tmp = [tmp{1:end}]';

    if length(tmp) == 4
        % uwb data
        pos = tmp(1:3); %[m]
        pos_t = tmp(end)/1000; %[s]

        ekf.step_uwb(pos, pos_t);

        uwb_rec(:,k) = reshape(pos, 3,1);
        acc_rec(:,k) = NaN(3,1);
        mag_rec(:,k) = NaN(3,1);
        gyro_rec(:,k) = NaN(3,1);
    else
        %imu data
        acc = tmp(1:3); %[m/s^2]
        buf_acc = [buf_acc(:,1:end-1), reshape(acc,3,1)];
        mag = tmp(4:6); %[gauss]
        gyro = tmp(7:9)/180*pi; %[rad/s]
        att_t = tmp(end); %[s]

        ekf.step_imu(mean(buf_acc, 2), mag, gyro, att_t);

        uwb_rec(:,k) = NaN(3,1);
        acc_rec(:,k) = reshape(acc, 3,1);
        mag_rec(:,k) = reshape(mag, 3,1);
        gyro_rec(:,k) = reshape(gyro, 3,1);
    end

    q_ekf(:,k) = ekf.get_att();
    gyro_b_ekf(:,k) = ekf.get_g_b();
    p_ekf(:,k) = ekf.get_pos();
    v_ekf(:,k) = ekf.get_vel();
    acc_det(k) = ekf.get_acc_det();
    ext_acc(:,k) = ekf.get_ext_acc();

end


%% Plots
eul_est = quat2eul(q_ekf.').' * 180/pi;
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
plot(t_ekf, q_ekf(1,:), 'LineWidth', 1.5);
plot(t_ekf, q_ekf(2,:), 'LineWidth', 1.5);
plot(t_ekf, q_ekf(3,:), 'LineWidth', 1.5);
plot(t_ekf, q_ekf(4,:), 'LineWidth', 1.5);
legend('qe_0', 'qe_1', 'qe_2', 'qe_3', 'Location', 'best');
xlabel('t [s]');
title("attitude");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_ekf, ext_acc(1,:));
plot(t_ekf, ext_acc(2,:));
plot(t_ekf, ext_acc(3,:));
plot(t_ekf, acc_det);
legend('x', 'y', 'z', 'det', 'Location', 'best');
xlabel('t [s]');
title("ext acc");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_ekf, gyro_b_ekf(1,:));
plot(t_ekf, gyro_b_ekf(2,:));
plot(t_ekf, gyro_b_ekf(3,:));
legend('mu_g_x est', 'mu_g_y est', 'mu_g_z est', 'Location', 'best');
xlabel('t [s]');
title("gyro bias");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, eul(1,:)-eul_est(1,:));
% plot(t, eul(2,:)-eul_est(2,:));
% plot(t, eul(3,:)-eul_est(3,:));
% legend('x_err', 'y_err', 'z_err', 'Location', 'best');
% xlabel('t [s]');
% title("Euler ang error");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_ekf, eul_est(1,:));
plot(t_ekf, eul_est(2,:));
plot(t_ekf, eul_est(3,:));
legend('x', 'y', 'z', 'Location', 'best');
xlabel('t [s]');
title("Estimated euler angles");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_true, true_angles(1,:));
plot(t_true, true_angles(2,:));
plot(t_true, true_angles(3,:));
legend('x', 'y', 'z', 'Location', 'best');
xlabel('t [s]');
title("True euler angles");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, triad);
% % legend('x', 'y', 'z', 'Location', 'best');
% xlabel('t [s]');
% title("TRIAD");

p_ekf = lowpass(p_ekf',0.5)';
FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_ekf, p_ekf(1,:));
plot(t_ekf, p_ekf(2,:));
plot(t_true, true_pos(1,:));
plot(t_true, true_pos(2,:));
legend('pos_x est', 'pos_y est', 'pos_x', 'pos_y','Location', 'best');
xlabel('t [s]');
ylabel('pos [m]');
title("position");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t_true, true_pos(1,:));
% plot(t_true, true_pos(2,:));
% legend('pos_x', 'pos_y', 'Location', 'best');
% xlabel('t [s]');
% title("true position");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_ekf, v_ekf(1,:));
plot(t_ekf, v_ekf(2,:));
% plot(t, X_pos(3,:));
% plot(t, X_pos(4,:));
legend('vel_x est', 'vel_y est', 'Location', 'best');
xlabel('t [s]');
ylabel(['v [m/s]']);
title("velocity");

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
% title("position estimation error");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, a_M(:));
% plot(t, aM_est(:));
% legend('a_M', 'a_M_est', 'Location', 'best');
% xlabel('t [s]');
% title("extern acc");

acc_rec(:,1) = acc_rec(:,2);
for i=2:length(acc_rec)
    if all(isnan(acc_rec(:,i)))
        acc_rec(:,i) = (acc_rec(:,i+1) + acc_rec(:,i-1)) / 2;
    end
end
fs = length(t_ekf)/t_ekf(end);
acc_rec = lowpass(acc_rec',0.01)';

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t_ekf, acc_rec(1,:));
plot(t_ekf, acc_rec(2,:));
plot(t_ekf, acc_rec(3,:));
legend('a_x', 'a_y', 'a_z', 'Location', 'best');
xlabel('t [s]');
ylabel('acceleration [m/s^2]');

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
