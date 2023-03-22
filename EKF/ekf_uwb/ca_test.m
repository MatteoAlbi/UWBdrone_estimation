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
eul = zeros(3,n);
eul2 = zeros(3,n);

filt2 = EKF(Ra, Rm, soft_iron, 0.6);
error = zeros(1, length(0:0.01:1));
ca_values = 0:0.01:2;

%% Estimates
for i= 1:length(ca_values)

    filt = EKF(Ra, Rm, soft_iron, ca_values(i));
    
    % Initialization
    filt.init_att(acc_corr(1,:), mag(1,:));
    filt2.init_att(acc(1,:), mag(1,:));
    X_att_ekf(:,1) = filt.get_att();
    ext_acc(:,1) = filt.get_ext_acc();
    X_att_ref(:,1) = filt2.get_att();
    
    % run
    for k = 2:n
        filt.step(acc_corr(k,:), mag(k,:));
        filt2.init_att(acc(k,:), mag(k,:));
    %     filt.init_att(acc(i,:), mag(i,:))
        X_att_ekf(:,k) = filt.get_att();
        ext_acc(:,k) = filt.get_ext_acc();
        X_att_ref(:,k) = filt2.get_att();
    
    end
    
    for k=1:n
        eul(:,k) = quat_to_eul(X_att_ekf(:,k));
        eul2(:,k) = quat_to_eul(X_att_ref(:,k));
    end
    
    
    error(i) = sqrt(sum((eul2 - eul).^2, 'all'));

end

%% Plot

FigID = 0;

FigID = FigID + 1;
figure(FigID), clf, hold on;
plot(ca_values, error);
hold off;

[v, index] = min(error);

disp(ca_values(index));
disp(error(index));
