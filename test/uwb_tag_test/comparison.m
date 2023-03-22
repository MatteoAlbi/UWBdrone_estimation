clc;
clear all;

log_all = importdata("all\data\uwb.txt");
log_rtdoa = importdata("rtdoa\log_filtered.txt");
log_ts_acc = importdata("ts_acc\data\out.txt");

i = 1;
while i <= length(log_all)
    if(log_all(i,2) == 0 || abs(log_all(i,1)) > 10000 ) 
        log_all(i,:) = [];
    else
        i = i+1;
    end
end

i = 1;
while i <= length(log_rtdoa)
    if(log_rtdoa(i,2) == 0 || abs(log_rtdoa(i,1)) > 10000 ) 
        log_rtdoa(i,:) = [];
    else
        i = i+1;
    end
end

i = 1;
while i <= length(log_ts_acc)
    if(log_ts_acc(i,2) == 0 || abs(log_ts_acc(i,1)) > 10000 ) 
        log_ts_acc(i,:) = [];
    else
        i = i+1;
    end
end

x_all = log_all(:,1);
y_all = log_all(:,2);
x_rtdoa = log_rtdoa(:,1);
y_rtdoa = log_rtdoa(:,2);
x_ts_acc = log_ts_acc(:,1);
y_ts_acc = log_ts_acc(:,2);
real_x_all = 4.067;
real_y_all = 2.012;
real_x_rtdoa = 4.122;
real_y_rtdoa = 1.738;
real_x_ts_acc = 4.043;
real_y_ts_acc = 1.935;

FigID = 0;

FigID = FigID + 1;
figure(FigID), clf, hold on;
histogram(x_all);
histogram(y_all);

FigID = FigID + 1;
figure(FigID), clf, hold on;
histogram(x_rtdoa);
histogram(y_rtdoa);

FigID = FigID + 1;
figure(FigID), clf, hold on;
histogram(x_ts_acc);
histogram(y_ts_acc);

disp("all data: n of samples = " + length(log_all));
disp("mean,std of x: " + mean(x_all) + ", " + std(x_all));
disp("real x: " + real_x_all + ", diff: " + (real_x_all-mean(x_all)));
disp("mean,std of y: " + mean(y_all) + ", " + std(y_all));
disp("real y: " + real_y_all + ", diff: " + (real_y_all-mean(y_all)));

disp("rtdoa data: n of samples = " + length(log_rtdoa));
disp("mean,std of x: " + mean(x_rtdoa) + ", " + std(x_rtdoa));
disp("real x: " + real_x_rtdoa + ", diff: " + (real_x_rtdoa-mean(x_rtdoa)));
disp("mean,std of y: " + mean(y_rtdoa) + ", " + std(y_rtdoa));
disp("real y: " + real_y_rtdoa + ", diff: " + (real_y_rtdoa-mean(y_rtdoa)));

disp("ts_acc data: n of samples = " + length(log_ts_acc));
disp("mean,std of x: " + mean(x_ts_acc) + ", " + std(x_ts_acc));
disp("real x: " + real_x_ts_acc + ", diff: " + (real_x_ts_acc-mean(x_ts_acc)));
disp("mean,std of y: " + mean(y_ts_acc) + ", " + std(y_ts_acc));
disp("real y: " + real_y_ts_acc + ", diff: " + (real_y_ts_acc-mean(y_ts_acc)));
