clc;
clear all;

log_local = importdata("data\out.txt");

i = 1;
while i <= length(log_local)
    if(log_local(i,2) == 0 || abs(log_local(i,1)) > 10000 ) 
        log_local(i,:) = [];
    else
        i = i+1;
    end
end

x_local = log_local(:,1);
y_local = log_local(:,2);
real_x = 4.067;
real_y = 2.012;

FigID = 0;
FigID = FigID + 1;
figure(FigID), clf, hold on;
histogram(x_local);
histogram(y_local);

disp("LOCAL OUTPUT:");
disp("mean,std of x: " + mean(x_local) + ", " + std(x_local));
disp("real x: " + real_x + ", diff: " + (real_x-mean(x_local)));
disp("mean,std of y: " + mean(y_local) + ", " + std(y_local));
disp("real y: " + real_y + ", diff: " + (real_y-mean(y_local)));

sigma_x = std(x_local)^2;
sigma_y = std(y_local)^2;