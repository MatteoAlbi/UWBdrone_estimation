# *EKF* folder

Contains the mathematical derivation and implementation of several EKF tested by simulation on matlab, except "ekf_uwb" which uses real data as well:

- [att_bias](/att_bias):             EKF for attitude and gyroscope bias estimation
- [att_pos](/att_pos):              EKF for attitude and position estimation (exploiting quadcopter dynamics)
- [att_pos_bias](/att_pos_bias):         EKF for attitude, position and gyroscope bias estimation (exploiting quadcopter dynamics)
- [att_pos_bias_paper](/att_pos_bias_paper):   EKF for attitude, position and gyroscope bias estimation (implementing algorithm described in [this paper](/papers/Cascaded_Kalman_Filtering-Based_Attitude_and_Gyro_Bias_Estimation_With_Efficient_Compensation_of_External_Accelerations2020.pdf)). Two algorithms have been developed (both implemented as classes):
  - [EKF](/att_pos_bias_paper/EKF.m):     add extra variables acc_ext where the estimated exetrnal_accelerations are stored. Algorithm implementation very similar to the paper
  - [EKF2](/att_pos_bias_paper/EKF2.m):    expands the position state of the filter, adding the external acceleration. It then uses the same approach for the gyroscope bias to estiamte the external accelerations, using the paper methods in update phase.
- [C++](/C++):                  code draft to implement an EKF on C++
- [comparison](/comparison):           performances comparison between the Madgwick filter and the EKF (both implemented as classes)
- [ekf_uwb](/ekf_uwb):              used to debug the C implemenation of the EKF running on board of the UWB tag. These implementation are focused on estimating the attitude. Available sensors: accelerometer, magnetometer. In [debug](/ekf_uwb/debug) folder is contained the C implementaion of the filter running on board, which is tested locally with real data save in [data](/ekf_uwb/debug/data.csv) file. Results are saved in [log](/ekf_uwb/debug/log.csv) and displayed using matlab. The EKF in matlab is implemented as a class file, and the matlab and C implementations are compared in [uwb_sensor](ekf_uwb/uwb_sensor.m). In file [ca_test](/ekf_uwb/ca_test.m) I try which is the best value for the external accelerations cut-off frequency
- [papers](/papers):               contains all papers consulted for the project development
- [rTDoA_algorithm](/rTDoA_algorithm):      implementaion of the rTDoA algorithm on board on the UWB tag. The [matlab](/rTDoA_algorithm/matlab) folder contains the reference algorithm and data used to run some tests. The [C](/rTDoA_algorithm/C) folder contains the rTDoA algorithm in C which is running on the UWB tag. The [C_dynamic](/rTDoA_algorithm/C_dynamic) folder contains the rTDoA algorithm in C implmented using dynamic memory allocation, however it raises error when running on the UWB tag (probably due to memory overflow) and needs debugging
