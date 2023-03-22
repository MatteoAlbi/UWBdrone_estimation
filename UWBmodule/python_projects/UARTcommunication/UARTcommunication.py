# -- import
import serial
import struct
import time
import sys
import numpy as np
from median_filter import Median_filter

from mag_calibration import ellipsoid_fit_ML, load_data, save_data

'''
Main program to manage the communication with the UWB tag DWM1001 via UART
'''

# -- alias
#f_vec = list[float]

# -- macro

BOOL_DEBUG =                True
MF_BUF_LEN =                64

# size of variables
UINT16_SIZE =               2
UINT16_MAX =                65535
FLOAT_SIZE =                4
UINT8_SIZE =                1

# package def
HEAD =                      (0x55).to_bytes(1,'little')
TAIL =                      (0x55).to_bytes(1,'little')

# flow control
STOP_CMD =                  (0x00).to_bytes(1,'little')
WAIT_CMD =                  (0x01).to_bytes(1,'little')
STREAM_WIN =                (0x02).to_bytes(1,'little')
START =                     (0x03).to_bytes(1,'little')
EXIT =                      (0x04).to_bytes(1,'little')

# routines
STREAM_FILTER =             (0x11).to_bytes(1,'little')
STREAM_ACC =                (0x12).to_bytes(1,'little')
STREAM_MAG =                (0x13).to_bytes(1,'little')
STREAM_RTDOA =              (0x14).to_bytes(1,'little')
STREAM_ACC_MAG =            (0x15).to_bytes(1,'little')

DEBUG_CMD =                 (0x99).to_bytes(1,'little')

# type of packages from master
ACC_BIAS =                  (0x21).to_bytes(1,'little')
ACC_SCALE =                 (0x22).to_bytes(1,'little')
MAG_HI =                    (0x23).to_bytes(1,'little')
MAG_SI1 =                   (0x24).to_bytes(1,'little')
MAG_SI2 =                   (0x25).to_bytes(1,'little')
MAG_SI3 =                   (0x26).to_bytes(1,'little')
ACC_UNC =                   (0x27).to_bytes(1,'little')
MAG_UNC =                   (0x28).to_bytes(1,'little')
POS_UNC =                   (0x29).to_bytes(1,'little')

# answers received
ACK =                       (0x00).to_bytes(1,'little')
ERR =                       (0xff).to_bytes(1,'little')
SEND_UINT16 =               (0x01).to_bytes(1,'little')
SEND_FLOAT =                (0x02).to_bytes(1,'little')
SEND_STRING =               (0x03).to_bytes(1,'little')

# -- params
global head_timeout_flag
head_timeout_flag = False
global stream_data_buf
stream_data_buf = []
global acc_extreme_buf

# serial interface
port = "COM4"
br = 921600
timeout = 0.01

# data file
mag_file = "./data/mag.csv"
acc_file = "./data/acc.csv"
acc_ex_file = "./data/acc_ex.csv"
data_file = "./data/data.csv"

# streaming 
default_start_win = int(128)
default_add_win = int(default_start_win/2)

# menu options
options = { "exit" : "e",
            "run_acc" : "ra",
            "run_mag" : "rm",
            "run_rtdoa" : "rr",
            "run_acc_mag" : "ram",
            "run_filt" : "rf",
            "cal_acc" : "ca",
            "cal_acc_unc" : "cau",
            "cal_mag" : "cm",
            "cal_mag_unc" : "cmu",
            "debug" : "db"
            }

# menu info
menu_description = "Command list:\n\
                    {exit}\t- exit from program\n\
                    {run_acc}\t- run accelerometer\n\
                    {run_mag}\t- run magnetometer\n\
                    {run_rtdoa}\t- run rTDoA\n\
                    {run_acc_mag}\t- run accelerometer and magnetometer\n\
                    {run_filt}\t- run filter\n\
                    {cal_acc}\t- calibrate accelerometer bias and uncertainty\n\
                    {cal_acc_unc}\t- calibrate magnetometer uncertainty\n\
                    {cal_mag}\t- calibrate magnetometer iron specs\n\
                    {cal_mag_unc}\t- calibrate magnetometer uncertainty\n\
                    {debug}\t- send a package to test/debug the code".format(exit = options["exit"],
                                                                            run_acc = options["run_acc"],
                                                                            run_mag = options["run_mag"],
                                                                            run_rtdoa = options["run_rtdoa"],
                                                                            run_acc_mag = options["run_acc_mag"],
                                                                            run_filt = options["run_filt"],
                                                                            cal_acc = options["cal_acc"],
                                                                            cal_acc_unc = options["cal_acc_unc"],
                                                                            cal_mag = options["cal_mag"],
                                                                            cal_mag_unc = options["cal_mag_unc"],
                                                                            debug = options["debug"])

# -- functions

def b_vec2b_arr(bv : list[bytes]) -> bytearray:
    return bytearray([int.from_bytes(b, byteorder='big', signed=False) for b in bv])


# -- sensor cal

def compute_mean_var(data):
    # return mean and variance of given data set
    vec = np.array(data, dtype=np.float32)

    return np.mean(vec, axis=0), np.var(vec, axis=0)


# -- communication management

def open_serial(port: str, br: int) -> serial.Serial:
    # open serial communication on given port, with given baudrate
    # port      name of bort to open
    # br        communication baud rate 
    # return: serial object of opened communication

    ser = serial.Serial()
    # set default params
    ser.baudrate = br
    ser.port = port
    ser.timeout = timeout

    while(not ser.is_open):
        try:
            # try open
            ser.open()
        except Exception as err:
            print(f"Unexpected {err=}, {type(err)=}")
            print("Unable to connect to port ", ser.port)
            # change port setting
            new_port = input("Type port to open or leave blank to use previous one (type e to exit): ")
            if(new_port != ""): 
                if(new_port == "e"): 
                    break
                else:
                    ser.__setattr__("port", new_port)
        else:
            # ser open succsessful
            print("Serial connection opened\n\nStart program\n")

    return ser


def write_package_float(ser: serial.Serial, id: bytes, length: int = 0, data: list[float]=[]):
    # write float payload package on uart
    # ser       serial interface object connected to tag
    # id        package id
    # length    length of payload
    # data      vector with payload to send

    byte_vec = []
    byte_vec.append(HEAD)
    byte_vec.append(id)
    byte_vec.append(length.to_bytes(1,"little"))

    # convert data to bytes and append to buffer
    tmp = struct.pack("f" * length, *data)
    for i in range(len(tmp)): byte_vec.append(tmp[i:i+1])

    byte_vec.append(TAIL)
    
    ser.write(b_vec2b_arr(byte_vec))


def write_package_uint16(ser: serial.Serial, id: bytes, length: int = 0, data: list[int]=[]):
    # write uint16 payload package on uart
    # ser       serial interface object connected to tag
    # id        package id
    # length    length of payload
    # data      vector with payload to send
    
    byte_vec = []
    byte_vec.append(HEAD)
    byte_vec.append(id)
    byte_vec.append(length.to_bytes(1,"little"))

    # uint16 data check
    if(any(val > UINT16_MAX for val in data)): raise AssertionError("One or more values in data are too big \
                                                                          to be converted to uint16", max(data))
    if(not all(isinstance(val, int) for val in data)): raise AssertionError("One or more values in data are not integer")

    # convert data to bytes and append to buffer
    tmp = struct.pack("H" * length, *data)
    for i in range(len(tmp)): byte_vec.append(tmp[i:i+1])

    byte_vec.append(TAIL)
    
    ser.write(b_vec2b_arr(byte_vec))


def write_package_command(ser: serial.Serial, id: bytes):
    # write command type package on uart
    # ser       serial interface object connected to tag
    # id        package id
    
    write_package_float(ser, id)


def read_package(ser: serial.Serial, timeout: int = 0):
    # read packages and parse fields
    # ser       serial interface object connected to tag
    # timeout   waiting time to receive a package [ms]
    
    global head_timeout_flag
    
    i = 0
    head = None
    # read buffer until find an header 
    while(head != HEAD):
        # wait for head 
        while(ser.in_waiting < 1):
            time.sleep(0.00100)
            # timeout case
            if(i >= timeout):
                if(not head_timeout_flag): 
                    print("head reading timeout")
                    head_timeout_flag = True
                return False, None, None
            i += 1

        #read new byte
        head = ser.read()

    head_timeout_flag = False

    # wait for id and len
    while(ser.in_waiting < 2):
            time.sleep(0.00100)
            # timeout case
            if(i >= timeout): 
                print("id, len reading timeout")
                return False, None, None
            i += 1
    
    
    # get id and len
    id = ser.read()
    # convert len into unsigned char
    length = int.from_bytes(ser.read(), byteorder='big', signed=False)

    # wait for payload and tail
    i = 0
    while(ser.in_waiting < length + 1):
        time.sleep(0.00100)
        if(i >= timeout): 
            print("pl, tail reading timeout")
            return False, None, None
        i += 1

    # get payload
    payload = []
        
    if(id == SEND_UINT16): 
        buf = ser.read(UINT16_SIZE * length)
        if(len(buf) != UINT16_SIZE * length): raise BufferError("Number of byte read for UINT16 not correct", len(buf))
        payload = struct.unpack("H" * length, buf)
    elif(id == SEND_FLOAT): 
        buf = ser.read(FLOAT_SIZE * length)
        if(len(buf) != FLOAT_SIZE * length): raise BufferError("Number of byte read for FLOAT not correct", len(buf))
        payload = struct.unpack("f" * length, buf)
    elif(id == ACK or id == ERR):
        buf = ser.read(UINT8_SIZE * length)
        if(len(buf) != UINT8_SIZE * length): raise BufferError("Number of byte read for UINT8 not correct", len(buf))
        payload = struct.unpack("B" * length, buf)
    
    # check tail
    tail = ser.read()
    if(tail != TAIL): raise AssertionError("Package tail not correct", tail, TAIL)

    return True, id, payload


def parse_package(ser: serial.Serial, id: bytes, pl):
    # parse packages base on their id
    # ser       serial interface object connected to tag
    # id        package id
    # pl        package payload
    
    if(id == ACK):
        print("Received ACK to command ", hex(pl[0]))#.to_bytes(1,'little')

    elif(id == ERR):
        print("Received ERR", hex(pl[1])," to command ", hex(pl[0]))#.to_bytes(1,'little')

    elif(id == SEND_UINT16):
        #if(BOOL_DEBUG): print("Successfully received a uint16 package with pl: ", pl)
        None

    elif(id == SEND_FLOAT):
        #if(BOOL_DEBUG): print("Successfully received a float package with pl: ", pl)
        None

    elif(id == SEND_STRING):
        if(BOOL_DEBUG): print("Received request to read string")
        pl = ser.readline()
        #print(pl)
        print(pl.decode('utf-8'))

    else:
        raise ValueError("Command not found", id)


def get_stream_float(ser: serial.Serial, cmd: bytes, N: int = 0, inf: bool = False, delay: int = 10, raw: int = 0):
    # send request for stream of float data and collect data packages
    # ser           serial interface object connected to tag
    # cmd           command code that identifies type of streaming
    # N             N stream length
    # inf           true if streaming must be infinite
    # delay_stream  wait time between packets of the streaming [ms]
    # delay ack     wait time for ack to commands [ms]
    # raw           1 if sent data must be raw, 0 if sent data must be calibrated
    
    global stream_data_buf
    stream_data_buf = []
    pck_received = 0 # number of received packages
    incremental_window = 0 # tot window set so far

    write_package_uint16(ser, cmd, 3, [default_start_win, delay, raw])

    # increment tot window
    incremental_window += default_start_win 
    while(N > pck_received or inf): # if packages are missing
        # read package
        read_flag, id, pl = read_package(ser, delay + 10)
        
        if(read_flag): # no timeout
            parse_package(ser, id, pl)
            # if correct package -> add to buffer
            if(id == SEND_FLOAT):
                if(inf): print(pl)
                else: stream_data_buf.append(pl)
                pck_received += 1

        # if window must be incereased
        # inf case
        if(inf and incremental_window - pck_received <= default_add_win):
            write_package_uint16(ser, STREAM_WIN, 1, [default_add_win])
            incremental_window += default_add_win
        # fixed window case
        elif(incremental_window - pck_received <= default_add_win and incremental_window < N):
            write_package_uint16(ser, STREAM_WIN, 1, [min(default_add_win, N - incremental_window)])
            incremental_window = min(incremental_window + default_add_win, N)
            if(BOOL_DEBUG): print("Increment window, new incremental window: ", incremental_window)

    print("Finished to receive the stream")


def get_acc_extremes(ser: serial.Serial, delay: int = 10):
    # collect data and compute acc extremes, saving them in global variable acc_extreme_buf
    # ser       serial interface object connected to tag
    #delay      wait time between packages [ms]
    
    global acc_extreme_buf
    acc_extreme_buf = np.zeros(6)

    flag_acc_extremes = np.zeros(6)
    
    str_axis = ["x", "y", "z"]
    # create a filter for each axis
    filters = []
    for i in str_axis:
        filters.append(Median_filter(MF_BUF_LEN, i, np.float32))

    pck_received = 0 # number of received packages
    incremental_window = 0 # tot window set so far

    write_package_uint16(ser, STREAM_ACC, 3, [default_start_win, 1, 1]) # 1[ms] delay between measures, raw data

    # increment tot window
    incremental_window += default_start_win 
    while(not np.all(flag_acc_extremes)): # if extremes are missing
        # read package
        read_flag, id, pl = read_package(ser, delay + 10)
        
        if(read_flag): # no timeout
            parse_package(ser, id, pl)
            # if correct package 
            if(id == SEND_FLOAT):
                #print(pl)
                pck_received += 1

                # process package
                if(not filters[0].is_full()):
                    for i, mf in enumerate(filters):
                        mf.add_el(pl[i])

                else:
                    # add pl to filters
                    for i, mf in enumerate(filters):
                        mf.add_el(pl[i])
                    #filter data
                    filtered_pl = np.array([mf.filter() for mf in filters])

                    # extract min and max values
                    min_index = np.argmin(filtered_pl)
                    max_index = np.argmax(filtered_pl)
                    # compare to current extremes
                    if(filtered_pl[min_index] < acc_extreme_buf[min_index*2]): #update min
                        acc_extreme_buf[min_index*2] = filtered_pl[min_index]
                        print("New min value on axis ", str_axis[min_index], " : ", filtered_pl[min_index])
                    if(filtered_pl[max_index] > acc_extreme_buf[max_index*2 + 1]): #update max
                        acc_extreme_buf[max_index*2 + 1] = filtered_pl[max_index]
                        print("New max value on axis ", str_axis[max_index], " : ", filtered_pl[max_index])

        # if window must be incereased
        if(incremental_window - pck_received <= default_add_win):
            write_package_uint16(ser, STREAM_WIN, 1, [default_add_win])
            incremental_window += default_add_win

    print("Finished to receive the stream")


def wait_ack(ser: serial.Serial, delay = 30):
    # wait for ack loop, interruptible by keyboard
    # ser           serial interface object connected to tag
    # delay     wait time for ack [ms]
    
    try:
        #read answer
        read_flag, id, pl = read_package(ser, delay)
        if(read_flag): parse_package(ser, id, pl)
        while(id != ACK and id != ERR):
            read_flag, id, pl = read_package(ser, delay)
            if(read_flag): parse_package(ser, id, pl)

    except KeyboardInterrupt:
        print("Interrupting wait_ack")


def run_streaming(ser: serial.Serial, cmd: bytes, N: int = 0, inf: bool = False, delay_stream: int = 10, delay_ack: int = 10, raw: int = 0):
    # send streaming request and collect data
    # ser           serial interface object connected to tag
    # cmd           command code that identifies type of streaming
    # N             N stream length
    # inf           true if streaming must be infinite
    # delay_stream  wait time between packets of the streaming [ms]
    # delay ack     wait time for ack to commands [ms]
    # raw           1 if sent data must be raw, 0 if sent data must be calibrated
    
    try:
        get_stream_float(ser, cmd, N, inf, delay_stream, raw)
    except KeyboardInterrupt:
        print("Interrupting streaming")
        write_package_command(ser, STOP_CMD)
        # wait for ack
        wait_ack(ser, delay_ack)
    print


def run_acc_extremes(ser: serial.Serial, delay_ack: int = 10):
    # run the acc extermes routine, it is possible to interrupt it using keyboard
    # ser           serial interface object connected to tag
    # delay_ack     wait time for ack [ms]
    
    try:
        get_acc_extremes(ser)
    except KeyboardInterrupt:
        print("Interrupting streaming")
        write_package_command(ser, STOP_CMD)
        # wait for ack
        wait_ack(ser, delay_ack)


# -- task management

def f_debug(ser: serial.Serial):
    # send test packages and parse the answer
    # ser       serial interface object connected to tag
    
    print("debug package")
    # send package
    write_package_float(ser, DEBUG_CMD, 6, [64.0,64.0,64.0,64.0,64.0,64.0])
    #write_package_command(ser, WAIT_CMD)
    
    wait_ack(ser)
    
    write_package_float(ser, DEBUG_CMD, 6, [64.0,64.0,64.0,64.0,64.0,64.0])
    #write_package_command(ser, WAIT_CMD)
    
    wait_ack(ser)
    
    write_package_float(ser, DEBUG_CMD, 6, [64.0,64.0,64.0,64.0,64.0,64.0])
    #write_package_command(ser, WAIT_CMD)
    
    wait_ack(ser)  


def f_run_acc(ser: serial.Serial):
    # collect data from accelerometer
    # ser       serial interface object connected to tag
    
    print("sending run_acc request")
    run_streaming(ser, STREAM_ACC, 0, True, 40)


def f_run_mag(ser: serial.Serial):
    # collect data from magnetometer
    # ser       serial interface object connected to tag
    
    print("sending run_mag request")
    run_streaming(ser, STREAM_MAG, 0, True, 40)


def f_run_acc_mag(ser: serial.Serial):
    # collect data from accelerometer and magnetometer
    # ser       serial interface object connected to tag
    
    print("sending run_acc_mag request")
    run_streaming(ser, STREAM_ACC_MAG, 5000, False, 40)
    save_data(stream_data_buf, data_file)


def f_run_rtdoa(ser: serial.Serial):
    # to implement
    print("sending run_rtdoa request")


def f_run_filt(ser: serial.Serial):
    # to implement
    print("sending run_filt request")


def f_cal_acc(ser: serial.Serial):
    # compute acc bias and scale
    # ser       serial interface object connected to tag
    
    global acc_extreme_buf

    print("sending run_acc request")
    run_acc_extremes(ser) # get acc axis extremes on global variable acc_extreme_buf
    #acc_extreme_buf = load_data(acc_ex_file)[0] # load data from file
    
    print(acc_extreme_buf)
    #save_data(acc_extreme_buf, acc_ex_file) # save data on file
    min = np.array((acc_extreme_buf[0], acc_extreme_buf[2], acc_extreme_buf[4]))
    max = np.array((acc_extreme_buf[1], acc_extreme_buf[3], acc_extreme_buf[5]))   

    # compute scaling&offsetting
    scale = np.array([2000 / (max[i]-min[i]) for i in range(len(max))])
    offset = np.array([max[i] - 1000 / scale[i] for i in range(len(max))])
    print(scale, offset)

    write_package_float(ser, ACC_BIAS, 3, offset.flatten())
    wait_ack(ser)
    write_package_float(ser, ACC_SCALE, 3, scale.flatten())
    wait_ack(ser)

    if(BOOL_DEBUG): print("accelerometer calibration completed")


def f_cal_acc_unc(ser: serial.Serial):
    # compute accelerometer uncertainty
    # ser       serial interface object connected to tag
    
    global stream_data_buf

    print("sending run_acc request")
    run_streaming(ser, STREAM_ACC, 1000, delay_stream=1, raw=1)

    save_data(stream_data_buf, acc_file) # save data

    #stream_data_buf = load_data(acc_file) # load data from file
    _, var = compute_mean_var(stream_data_buf)
    if(BOOL_DEBUG): print(var)

    # send variance
    write_package_float(ser, ACC_UNC, 3, var.flatten())
    wait_ack(ser)

    if(BOOL_DEBUG): print("accelerometer variance calibration completed")


def f_cal_mag(ser: serial.Serial):
    # compute magnetometer hard and soft iron
    # ser       serial interface object connected to tag
    
    global stream_data_buf

    print("sending run_mag request")
    run_streaming(ser, STREAM_MAG, 4000, raw=1) # collect data from tag

    save_data(stream_data_buf, mag_file) # save data on file

    #stream_data_buf = load_data(mag_file) # load data from file
    soft_iron, hard_iron, expMFS = ellipsoid_fit_ML(stream_data_buf)

    if(BOOL_DEBUG): print("Sending hard_iron")
    write_package_float(ser, MAG_HI, 3, hard_iron.flatten())
    wait_ack(ser)

    if(BOOL_DEBUG): print("Sending soft_iron")
    write_package_float(ser, MAG_SI1, 3, soft_iron[0].flatten())
    wait_ack(ser)

    write_package_float(ser, MAG_SI2, 3, soft_iron[1].flatten())
    wait_ack(ser)

    write_package_float(ser, MAG_SI3, 3, soft_iron[2].flatten())
    wait_ack(ser)
    
    if(BOOL_DEBUG): print("magnetometer iron calibration completed")


def f_cal_mag_unc(ser: serial.Serial):
    # compute mag uncertainty
    # ser       serial interface object connected to tag
    
    global stream_data_buf

    print("sending run_mag request")
    run_streaming(ser, STREAM_MAG, 1000, delay_stream=1, raw=1)
    #save_data(stream_data_buf, acc_file) #save data on file

    _, var = compute_mean_var(stream_data_buf)

    # send variance
    write_package_float(ser, MAG_UNC, 3, var.flatten())
    wait_ack(ser)

    if(BOOL_DEBUG): print("magnetometer variance calibration completed")


def menu(ser: serial.Serial):
    # manage menu and actions
    # ser       serial interface object connected to tag
    
    menu_open = True

    # ack 
    write_package_command(ser, START)

    try:
        print(menu_description)
    
        while menu_open: 
            cm = input("Select action: ")

            # print error report
            while(ser.in_waiting > 0):
                read_flag, id, pl = read_package(ser)
                if(read_flag): parse_package(ser, id, pl)

            if cm == options["exit"]: 
                write_package_command(ser, EXIT)
                menu_open = False
                wait_ack(ser)

            elif cm == options["run_acc"]:
                f_run_acc(ser)

            elif cm == options["run_mag"]:
                f_run_mag(ser)

            elif cm == options["run_rtdoa"]:
                f_run_rtdoa(ser)

            elif cm == options["run_acc_mag"]:
                f_run_acc_mag(ser)

            elif cm == options["run_filt"]:
                f_run_filt(ser)

            elif cm == options["cal_acc"]:
                f_cal_acc(ser)

            elif cm == options["cal_acc_unc"]:
                f_cal_acc_unc(ser)

            elif cm == options["cal_mag"]:
                f_cal_mag(ser)

            elif cm == options["cal_mag_unc"]:
                f_cal_mag_unc(ser)

            elif cm == options["debug"]:
                f_debug(ser)
            
            else:
                print("command not found\n")
    
    except KeyboardInterrupt: 
        print("Exiting from menu")
        write_package_command(ser, EXIT)
        wait_ack(ser)


# -- main
if __name__ == "__main__":


    # connect to sensor
    ser = open_serial(port, br)  

    try:

        while True:
            if(ser.in_waiting > 0): #read uart data
                line = ser.readline().strip()
                try:
                    s_line = line.decode("utf-8") # convert byte->string
                except Exception as err:
                    print(f"Unexpected {err=}, {type(err)=}")
                else:
                    print(s_line)

                    if(s_line == "START_PYCOM"): # start communication
                        menu(ser)

    except KeyboardInterrupt:
        print("Closing serial communication")

    ser.close()
    del ser

    print("End program")
