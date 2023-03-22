# *drone_test* folder

Contains the data collected by mounting the UWB tag and an IMU on a quadcopter flying following a rectangular trajectory.

In [data_collected](/test/drone_test/data_collected) folder:

- [conf.csv](/test/drone_test/data_collected/conf.csv) file contains the configuration of the sensors running to collect the data
- [mavic1.csv](data_collected/mavic1.csv) and [mavic1.mat](data_collected/mavic1.mat) are the collected data and the true trajectory and attitude of the drone, respectively, collected during test #1
- [mavic2.csv](data_collected/mavic1.csv) and [mavic2.mat](data_collected/mavic1.mat) are the collected data and the true trajectory and attitude of the drone, respectively, collected during test #2

*EKF\** files contains different extended Kalman filter implementations to estimate the position and the attitude given the data, which are tested in *data_process\** files.
