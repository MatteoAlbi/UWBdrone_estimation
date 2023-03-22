clc;
clear all;

% display histograms of onboard tag computed positions and locally computed positions

log_dwm = importdata("data\uwb.txt");
log_local = importdata("data\out.txt");

i = 1;
while i <= length(log_dwm)
    if(log_dwm(i,2) == 0 || abs(log_dwm(i,1)) > 10000 ) 
        log_dwm(i,:) = [];
    else
        i = i+1;
    end
end

i = 1;
while i <= length(log_local)
    if(log_local(i,2) == 0 || abs(log_local(i,1)) > 10000 ) 
        log_local(i,:) = [];
    else
        i = i+1;
    end
end

x_dwm = log_dwm(:,1);
y_dwm = log_dwm(:,2);
x_local = log_local(:,1);
y_local = log_local(:,2);
real_x = 4.043;
real_y = 1.935;

FigID = 0;
FigID = FigID + 1;
figure(FigID), clf, hold on;
histogram(x_dwm);
histogram(y_dwm);

FigID = FigID + 1;
figure(FigID), clf, hold on;
histogram(x_local);
histogram(y_local);

disp("DWM OUTPUT:");
disp("mean,std of x: " + mean(x_dwm) + ", " + std(x_dwm));
disp("real x: " + real_x + ", diff: " + (real_x-mean(x_dwm)));
disp("mean,std of y: " + mean(y_dwm) + ", " + std(y_dwm));
disp("real y: " + real_y + ", diff: " + (real_y-mean(y_dwm)));

disp("LOCAL OUTPUT:");
disp("mean,std of x: " + mean(x_local) + ", " + std(x_local));
disp("real x: " + real_x + ", diff: " + (real_x-mean(x_local)));
disp("mean,std of y: " + mean(y_local) + ", " + std(y_local));
disp("real y: " + real_y + ", diff: " + (real_y-mean(y_local)));
