clc;
clear all;

log = importdata("log_filtered.txt");

x = log(:,1);
y = log(:,2);
real_x = 4.122;
real_y = 1.738;

hold on;
histogram(x);
histogram(y);

disp("mean,std of x: " + mean(x) + ", " + std(x));
disp("real x: " + real_x + ", diff: " + (real_x-mean(x)));
disp("mean,std of y: " + mean(y) + ", " + std(y));
disp("real y: " + real_y + ", diff: " + (real_y-mean(y)));