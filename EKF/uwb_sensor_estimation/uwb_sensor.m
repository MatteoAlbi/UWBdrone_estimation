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

% add external acc
added_ext_acc = zeros(n,3);
len = 200;
added_ext_acc(200:200+len-1,2) = sin((1:len) .*pi/len) * 500;

acc_corr = added_ext_acc + acc;

Duration = 100;
dt = Duration/n;
t = dt:dt:Duration;

% instantiate filter
X_att_ekf = zeros(4,n);
ext_acc = zeros(3,n);
X_att_ref = zeros(4,n);
triad = zeros(5,n);
acc_det = zeros(1,n);
eul = zeros(3,n);
eul2 = zeros(3,n);
filt = EKF(Ra, Rm, soft_iron, 0.98);
filt2 = EKF(Ra, Rm, soft_iron, 0.6);

%% Estimates

% Initialization
filt.init_att(acc_corr(1,:), mag(1,:));
filt2.init_att(acc(1,:), mag(1,:));
X_att_ekf(:,1) = filt.get_att();
ext_acc(:,1) = filt.get_ext_acc();
X_att_ref(:,1) = filt2.get_att();
acc_det(1) = filt.get_acc_det();

% run
for i = 2:n
    filt.step(acc_corr(i,:), mag(i,:));
    filt2.init_att(acc(i,:), mag(i,:));
%     filt.init_att(acc(i,:), mag(i,:))
    X_att_ekf(:,i) = filt.get_att();
    ext_acc(:,i) = filt.get_ext_acc();
    X_att_ref(:,i) = filt2.get_att();
    triad(:,i) = filt.get_triad();
    acc_det(i) = filt.get_acc_det();

end

for i=1:n
    eul(:,i) = quat_to_eul(X_att_ekf(:,i));
    eul2(:,i) = quat_to_eul(X_att_ref(:,i));
end


%% Plots

% read c log
c_log = readmatrix("debug\log.csv");
eul_c = c_log(:,1:3)';
q_c = c_log(:,4:7)';
triad_c = c_log(:,8:12)';
ext_acc_c = c_log(:,13:15)';
acc_det_c = c_log(:,16)';

FigID = 0;

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, X_att_ekf, 'LineWidth', 1.5);
% plot(t, X_att_ref(1,:), 'LineWidth', 1.5);
% plot(t, X_att_ref(2,:), 'LineWidth', 1.5);
% plot(t, X_att_ref(3,:), 'LineWidth', 1.5);
% plot(t, X_att_ref(4,:), 'LineWidth', 1.5);
plot(t, q_c, 'LineWidth', 1.5);
legend('q_0', 'q_1', 'q_2', 'q_3', 'qe_0', 'qe_1', 'qe_2', 'qe_3', 'Location', 'best');
xlabel('t [s]');
title("attitude");

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, eul(1,:));
% plot(t, eul(2,:));
% plot(t, eul(3,:));
% legend('x', 'y', 'z', 'Location', 'best');
% xlabel('t [s]');
% title("Estimated euler angles");

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, acc_corr(:,1));
plot(t, acc_corr(:,2));
plot(t, acc_corr(:,3));
legend('a_x', 'a_y', 'a_z', 'Location', 'best');
xlabel('t [s]');
ylabel('Accelerometers');

% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, mag(:,1));
% plot(t, mag(:,2));
% plot(t, mag(:,3));
% legend('m_x', 'm_y', 'm_z', 'Location', 'best');
% xlabel('t [s]');
% title('Magnetometers');

for i=1:n
    mag(i,:) = mag(i,:)/norm(mag(i,:))*500;
end

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, eul(3,:));
plot(t, eul2(3,:));
% plot(t, c_log(:, 3));
% plot(t, acc_det_c.*200);
%plot(t, triad(4:5,:)'*200);
legend('ML','ref', 'C', 'triad1', 'triad2', 'Location', 'best');
xlabel('t [s]');
title('yaw');

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(t, added_ext_acc(:,2)');
plot(t, ext_acc(2,:));
plot(t, acc_det*400);
legend('ax', 'ay', 'az', 'ax_e', 'ay_e', 'az_e', 'Location', 'best');
xlabel('t [s]');
title("ext acc");

% update_diff = zeros(n);
% for i=2:n
%     update_diff(i) = update_diff(i) + sum(abs(q_c(:,i) - q_c(:,i-1)));
% end
% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, update_diff);
% xlabel('t [s]');
% title("update C diff");

% fill null data with prev one
% for i=2:n
%     if( all(triad_c(:,i) == zeros(5,1)) )
%         triad_c(:,i) = triad_c(:,i-1);
%     end
% end
% FigID = FigID + 1;
% figure(FigID), clf, hold on;
% plot(t, triad_c(:,:)');
% legend('1', '2', '3', '4', '5', 'Location', 'best');
% xlabel('t [s]');
% title("TRIAD C");

error = sqrt(sum((eul2 - eul).^2, 'all'))

%%
norm_acc = zeros(1,n);
for i =1:n
    norm_acc(i) = norm(acc_corr(i,:));
end