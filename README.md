# UWB drone estimation

This project aims to build an algorithm to estimate position and pose of a drone using an IMU sensor and a UWB module.

## Description

The project consists in three steps:
1. Program the UWB module [dwm1001C](https://www.qorvo.com/products/p/DWM1001C) to run an rTDoA algorithm for the localization of the drone and read data from an internal accelerometer sensor, then output both via UART.
2. Build an Extended Kalmann Filter to estimate pose and position of the drone based on the available sensors.
3. Assemble the first two steps using ROS2.

## UWB module

In the folder [UWBmodule](/UWBmodule/) can be found all data an code related to the programming and testing of the dwm1001C.
- [data](/UWBmodule/data/): contains different data gathered to test the algorithm. The tests consisted in using an high accuracy motion detection system to register the reference position of the sensor in the space and collect data from the module. Then data have been compared using MATLab to asses the algorithm works correctly in this [script](/UWBmodule/data/comparison.m).  
Moreover, a [Kalmann Filter](/UWBmodule/data/trajectory/kf_bias.m) has been developed for the estimation of the module position using only the data coming from the on-board sensors. It has been tested on a registration of a moving trajectory of the module using the same procedure previously described.
- [datasheet and guides](/UWBmodule/datasheet%20and%20guides/): contains several guides and datasheet about dwm1001C, the internal accelerometer sensor and the API guide.
- [rTDoA_algorithm](/UWBmodule/rTDoA_algorithm/): is were the rTDoA algorithm has been developed and tested, comparing the results from the C code with the MATLab reference script.
- [segger projects](/UWBmodule/segger%20projects/): contains the development of the firmware for dwm1001C.
    - [rtdoa](/UWBmodule/segger%20projects/rtdoa/): basic implementation using static variables (**working**).
    - [rtdoa_dynamic](/UWBmodule/segger%20projects/rtdoa_dynamic/): implementation using dynamic allocation of variables (**not working**).
    - [UART communication script](/UWBmodule/segger%20projects/UARTcommunication.py): to test the dwm1001C communication.

## EKF

Contains an incremental implementation of an EKF using MATLab and the mathematical derivations generated on Maple.
- [attitude](/EKF/attitude/): estimates the attitude in case of noisy accelerometer and gyroscope, including a varying bias on the gyroscope.
- [att+pos](/EKF/att%2Bpos/): estimates both attitude and position in two different steps, in the same conditions stated before.
- [att+pos_bias](/EKF/att%2Bpos_bias/): estimates both attitude and position  in two different steps, in the same conditions stated before including a varying bias for the accelerometer. The EKF is divided into two different estimators, one for the attitude and one for the positions, with separeted state vectors.  
**Problem**: can't properly estimate the accelerometer bias.
- [att+pos_single_state](/EKF/att%2Bpos_bias_single_state/): same case as previous one, but using one singular estimator having a single state vector. The aim is to find a solution for the accelerometer bias estimation, needed in both the estimation steps.  
**Ongoing**
- [C++](/EKF/C%2B%2B/): draft for the implementation of the EKF in C++ code.
- [papers](/EKF/papers/): reference material for the EKF development. However, most of it is based on personal notes from the course [Design methods for unmanned vehicles](https://www.esse3.unitn.it/Guide/PaginaADErogata.do;jsessionid=8B93A824E8F048884993F99F6DE6D09E.esse3-unitn-prod-03?cod_lingua=eng&ad_er_id=2022*N0*N0*S2*75296*95343&ANNO_ACCADEMICO=2022&mostra_percorsi=N#shortcut), module: estimation algorithms, held by professor [Daniele Fontanelli](https://webapps.unitn.it/du/it/Persona/PER0047723/Didattica).