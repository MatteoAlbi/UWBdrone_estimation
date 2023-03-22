# UWB drone estimation

This project aims to build an algorithm to estimate position and pose of a drone using an IMU sensor and a UWB module.

## Description

The project consists in three steps:

1. Program the UWB module [dwm1001C](https://www.qorvo.com/products/p/DWM1001C) to run an rTDoA algorithm for the localization of the drone it via UART.
2. Build an Extended Kalmann Filter to estimate pose and position of the drone based on the available sensors.
3. Possibly, run the EKF on board the UWB module by installing the needed sensors.

## Folders description

### *EKF*

Contains an incremental implementation of an EKF using MATLab and the mathematical derivations generated on Maple.

More info can be found in [readme](/EKF/readme.md) file.

### *test*

Contains all real data collected and all tests done on them. There are two subfolders:

- [drone_test](test/drone_test) data and tests on the EKF algorithms using a flying drone. More info in file [readme](test/drone_test/readme.md) file.
- [uwb_tag_test](test/uwb_tag_test) data and tests on the UWB tag running the rTDoA algorithm. More info in file [readme](test/uwb_tag_test/readme.md) file.

### *UWBmodule*

In the folder [UWBmodule](/UWBmodule/) can be found all code related to the programming of the dwm1001C SoC and python scripts to collect data and manage the tag.

More info can be found in [readme](/UWBmodule/readme.md) file.
