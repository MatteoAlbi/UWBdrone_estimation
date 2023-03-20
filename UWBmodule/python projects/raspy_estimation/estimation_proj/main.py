# -- import
import serial
import serial.tools.list_ports
import board
import adafruit_icm20x
import time
import sys
import numpy as np

from ekf import EKF

# serial interface params
port = "/dev/ttyACM0"
desc = "J-Link - CDC"
br = 921600
timeout = 0.01


# data file
mag_file = "./data/mag.csv"
acc_file = "./data/acc.csv"
acc_ex_file = "./data/acc_ex.csv"
data_file = "data.csv"
conf_file = "conf.csv"

# menu
options = { "exit" : "e",
            "run_acc" : "ra",
            "run_mag" : "rm",
            "run_gyro" : "rg",
            "run_uwb" : "ru",
            "run_imu" : "ri",
            "run_filt" : "rf",
            "cal_acc" : "ca",
            "cal_acc_unc" : "cau",
            "cal_mag" : "cm",
            "cal_mag_unc" : "cmu",
            "cal_gyro" : "cg",
            "cal_uwb" : "cu",
            "cal_all_unc" : "cuall",
            "collect_data" : "data"
            }

menu_description = "Command list:\n\
                    {exit}\t\t- exit from program\n\
                    {run_acc}\t\t- run accelerometer\n\
                    {run_mag}\t\t- run magnetometer\n\
                    {run_gyro}\t\t- run gyroscope\n\
                    {run_uwb}\t\t- run uwb\n\
                    {run_imu}\t\t- run all imu sensor\n\
                    {run_filt}\t\t- run filter\n\
                    {cal_acc}\t\t- calibrate accelerometer bias and scale\n\
                    {cal_acc_unc}\t\t- calibrate accelerometer uncertainty\n\
                    {cal_mag}\t\t- calibrate magnetometer iron specs\n\
                    {cal_mag_unc}\t\t- calibrate magnetometer uncertainty\n\
                    {cal_gyro}\t\t- calibrate gyroscope bias and uncertainty\n\
                    {cal_uwb}\t\t- calibrate uwb uncertainty\n\
                    {cal_all_unc}\t- calibrate gyroscope bias and sensors uncertainties\n\
                    {collect_data}\t- collect data from all available sensors".format(
                        exit = options["exit"],
                        run_acc = options["run_acc"],
                        run_mag = options["run_mag"],
                        run_gyro = options["run_gyro"],
                        run_uwb = options["run_uwb"],
                        run_imu = options["run_imu"],
                        run_filt = options["run_filt"],
                        cal_acc = options["cal_acc"],
                        cal_acc_unc = options["cal_acc_unc"],
                        cal_mag = options["cal_mag"],
                        cal_mag_unc = options["cal_mag_unc"],
                        cal_gyro = options["cal_gyro"],
                        cal_uwb = options["cal_uwb"],
                        cal_all_unc = options["cal_all_unc"],
                        collect_data = options["collect_data"]
                        )

# -- functions


def save_data(data, file_name):

    with open(file_name, 'w') as fp:

        for line in data:
            for el in line:
                fp.write("%f;" % el)
            fp.write("\n")
        fp.close()

# -- communication management


def open_serial(port: str, desc: str, br: int, timeout: float) -> serial.Serial:
    ser = serial.Serial()
    ser.baudrate = br
    ser.timeout = timeout
    
    # check available ports
    ports = serial.tools.list_ports.comports()
    for p, d, _ in sorted(ports):
        if(d == desc):
            print("Port with description: ", desc, " found")
            print("Port name: ", p)
            if(p != port):
                print("Port name not matching the given param: ", port)
                print("Connecting to new port: ", p)
                ser.port = p
            else:
                print("Port name matching the given param: ", port)
                ser.port = port
            
            try:
                # try open
                ser.open()
            except Exception as err:
                print(f"Unexpected {err=}, {type(err)=}")
                print("Unable to connect to port ", ser.port)
            else:
                # ser open succsessful
                print("Serial connection opened\n\nStart program\n")   
                
    if(ser.port == None):
        print("Unable to found port with given description: ", desc)
        
    return ser


# -- task management

def f_run_acc(filt: EKF, wait_ms = 10):
    try:
        while(True): 
            print(filt.get_acc_calibrated())
            time.sleep(wait_ms/1000)
    except KeyboardInterrupt:
        print("Task interrupted")


def f_run_mag(filt: EKF, wait_ms = 10):
    try:
        while(True): 
            print(filt.get_mag_calibrated())
            time.sleep(wait_ms/1000)
    except KeyboardInterrupt:
        print("Task interrupted")
       
            
def f_run_gyro(filt: EKF, wait_ms = 10):
    try:
        while(True): 
            print(filt.get_gyro_calibrated())
            time.sleep(wait_ms/1000)
    except KeyboardInterrupt:
        print("Task interrupted")


def f_run_imu(filt: EKF, wait_ms = 10):
    try:
        while(True): 
            print(filt.get_imu())
            time.sleep(wait_ms/1000)
    except KeyboardInterrupt:
        print("Task interrupted")


def f_run_uwb(filt: EKF, wait_ms = 10):
    try:
        while(True): 
            x,y,z,t = filt.get_uwb()
            if(x != None): print(x,y,z,t)
            #time.sleep(wait_ms/1000)
    except KeyboardInterrupt:
        print("Task interrupted")


def f_run_filt(filt: EKF):
    print("Still to implement")


def f_cal_acc(filt: EKF):
    filt.cal_acc()


def f_cal_acc_unc(filt: EKF):
    filt.cal_acc_unc()


def f_cal_mag(filt: EKF):
    filt.cal_mag()
    
    
def f_cal_mag_unc(filt: EKF):
    filt.cal_mag_unc()
    
    
def f_cal_gyro(filt: EKF):
    filt.cal_gyro()
    

def f_cal_uwb(filt: EKF):
    filt.cal_uwb_unc()
    
    
def f_cal_unc_all(filt: EKF):
    filt.cal_unc_all()


def collect_data(filt: EKF, round_prec = 6):
    data = []
    try:
        while(True):
            x,y,z,t = filt.get_uwb(timeout = 0)
            if(x != None): 
                data.append([x,y,z,t])
                data[-1] = [round(d, round_prec) for d in data[-1]]
                print(data[-1])
                    
            
            data.append(filt.get_imu())
            data[-1] = [round(d, round_prec) for d in data[-1]]
            print(data[-1])
            
    except KeyboardInterrupt:
        save_data(data, data_file)
    except Exception as err:
        print(f"Unexpected {err=}, {type(err)=}")
        


def menu(filt: EKF):
    menu_open = True

    try:
        print(menu_description)
    
        while menu_open: 
            cm = input("Select action: ")

            if cm == options["exit"]: 
                menu_open = False

            elif cm == options["run_acc"]:
                f_run_acc(filt)

            elif cm == options["run_mag"]:
                f_run_mag(filt)
                
            elif cm == options["run_gyro"]:
                f_run_gyro(filt)

            elif cm == options["run_uwb"]:
                f_run_uwb(filt)

            elif cm == options["run_imu"]:
                f_run_imu(filt)

            elif cm == options["run_filt"]:
                f_run_filt(filt)

            elif cm == options["cal_acc"]:
                f_cal_acc(filt)

            elif cm == options["cal_acc_unc"]:
                f_cal_acc_unc(filt)

            elif cm == options["cal_mag"]:
                f_cal_mag(filt)

            elif cm == options["cal_mag_unc"]:
                f_cal_mag_unc(filt)

            elif cm == options["cal_gyro"]:
                f_cal_gyro(filt)
                
            elif cm == options["cal_uwb"]:
                f_cal_uwb(filt)
                
            elif cm == options["cal_all_unc"]:
                f_cal_unc_all(filt)
                
            elif cm == options["collect_data"]:
                collect_data(filt)
            
            else:
                print("command not found\n")
    
    except KeyboardInterrupt: 
        print("Exiting from menu")


# -- main
if __name__ == "__main__":
    
    # connect to sensors
    ser = open_serial(port, desc, br, timeout) 
    i2c = board.I2C()  # uses board.SCL and board.SDA 
    icm = adafruit_icm20x.ICM20948(i2c)
    
    # instanciate filter
    filter = EKF(ser, icm)
    filter.load_config(conf_file)

    try:
        menu(filter)

    except KeyboardInterrupt:
        print("Closing program")
        
    filter.save_config(conf_file)

    print("End program")
