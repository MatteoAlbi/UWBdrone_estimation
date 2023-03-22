# *UWBmodule* folder

Contains the projects code for real-life utilization:

- [datasheet_and_guides](/UWBmodule/datasheet_and_guides): contains all datasheets/guides consulted to develop the project
- [python_projects](/UWBmodule/python_projects)
  - [raspy_estimation](/UWBmodule/python_projects/raspy_estimation)
    - [estimation_proj](/UWBmodule/python_projects/raspy_estimation/estimation_proj): contains the code running on the Raspberry zero used to collect the data on the flying drone
    - [data_collected](/UWBmodule/python_projects/raspy_estimation/data_collected): contains the data collected during test (more info in drone_test [readme](../test/drone_test/readme.md))
  - [UARTcommunication](/UWBmodule/python_projects/UARTcommunication): contains teh library implemented to manage the UART communivation with the UWB tag. Real data used to test the accelerometer and magentometer calibration are saved in [data](python_projects/UARTcommunication/data) folder
- [segger_projects](/UWBmodule/segger_projects): contains the program running on the UWB tag, which comprehends:
  - rTDoA algorithm
  - accelerometer and magentometer sensors reading
  - python communication management
  - flash memory management (to save sensors configuration)
  - EKF
