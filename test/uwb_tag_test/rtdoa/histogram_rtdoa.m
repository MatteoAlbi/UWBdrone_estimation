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
xline(real_x, "Color", "b", "LineWidth", 2)
xline(real_y, "Color", "r", "LineWidth", 2)
axis([1 5 0 1000])
legend('X_{samples}', 'Y_{samples}', "X_{real}", "Y_{real}")


disp("mean,std of x: " + mean(x) + ", " + std(x));
disp("real x: " + real_x + ", diff: " + (real_x-mean(x)));
disp("mean,std of y: " + mean(y) + ", " + std(y));
disp("real y: " + real_y + ", diff: " + (real_y-mean(y)));