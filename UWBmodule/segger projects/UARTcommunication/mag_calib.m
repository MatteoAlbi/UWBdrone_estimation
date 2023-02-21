clear all;
close all;
clc;

%% load data
mag_data = readmatrix("data\mag_backup.csv");

%% calibration
[A,b,expMFS]  = magcal(mag_data);
corrected_data = (mag_data-b)*A;

%% 3D-plot
scatter3(mag_data(:,1), mag_data(:,2), mag_data(:,3));
axis equal;
title('Raw magnetometer Data');
scatter3(corrected_data(:,1), corrected_data(:,2), corrected_data(:,3));
axis equal;
title('Calibrated magnetometer Data');

%% plot after calibration
de = HelperDrawEllipsoid;
de.plotCalibrated(A,b,expMFS,mag_data,mag_data,'Auto');
