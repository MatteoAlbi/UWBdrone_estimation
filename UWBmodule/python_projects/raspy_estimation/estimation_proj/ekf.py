# -- import
import time
import numpy as np
from median_filter import Median_filter
from mag_calibration import ellipsoid_fit_ML, compute_hi_si


class EKF():
    
    def __init__(self, ser, icm):
        # states
        self.X_att = np.zeros((7,1))
        self.P_att = np.eye(7)
        
        self.X_pos = np.zeros((4,1))
        self.P_pos = np.eye(4)
        
        self.dt = 1
        
        # sensors
        self.uwb_ser = ser
        self.imu = icm
        
        # config
        self.acc_bias = np.zeros((3,1))
        self.acc_scale = np.ones((3,1))
        
        self.mag_hi = np.zeros((3,1))
        self.mag_si = np.eye(3)
        
        self.acc_unc = np.eye(3)
        self.mag_unc = np.eye(3)
        self.gyro_unc = np.eye(3)
        self.uwb_unc = np.eye(3)
        
        # parameters
        self.ser_timeout = 10 #[ms]
        self.mf_buf_len = 64  # median filter buffer size
        self.g_const = 9.807  # earth acceleration value as read by the sensor
        
        
    def get_acc(self):
        # return accelerometer raw readings
        
        return self.imu.acceleration
    
    
    def get_acc_calibrated(self):
        # return accelerometer calibrated readings
        
        x,y,z = self.get_acc()
        acc = np.array([[x],[y],[z]])
        
        # x = (x - self.acc_bias[0]) * self.acc_scale[0]
        # y = (y - self.acc_bias[1]) * self.acc_scale[1]
        # z = (z - self.acc_bias[2]) * self.acc_scale[2]
        acc = np.multiply((acc - self.acc_bias), self.acc_scale)
        
        return acc[0,0], acc[1,0], acc[2,0]
    
    
    def get_mag(self):
        # return magnetometer raw readings
        
        return self.imu.magnetic
    
    
    def get_mag_calibrated(self):
        # return magnetometer calibrated readings
        
        x,y,z = self.get_mag()
        mag = np.array([[x],[y],[z]])
        
        mag = np.matmul(np.transpose(self.mag_si), mag - self.mag_hi)
        
        return mag[0,0], mag[1,0], mag[2,0]
    
    
    def get_gyro(self):
        # return gyroscope raw readings
        
        return self.imu.gyro
    
    
    def get_gyro_calibrated(self):
        # return gyroscope calibrated readings
        
        x,y,z = self.get_gyro()
        
        x = x - self.X_att[4]
        y = y - self.X_att[5]
        z = z - self.X_att[6]
        
        return x[0], y[0], z[0]
       
       
    def get_uwb(self, timeout = None):
        # return UWB readings and their timestamp [s]
        
        if(not self.uwb_ser.is_open): return None, None, None, None
        
        if(timeout == None): timeout = self.ser_timeout
        # wait for data
        cnt = 0
        while(self.uwb_ser.in_waiting == 0 and cnt < timeout):
            cnt = cnt + 1
            time.sleep(0.001)
        
        # check data found
        if(self.uwb_ser.in_waiting > 0):
            # read whole buffer
            lines = self.uwb_ser.readlines(self.uwb_ser.in_waiting)
            # extract last row
            line = lines[-1].strip()
            #print("last row: ", line)
                
            try:
                s_line = line.decode("utf-8")
            except Exception as err:
                print(f"Unexpected {err=}, {type(err)=}")
            else:
                # process data
                v = s_line.split("\t")
                if(len(v) < 4): return None, None, None, None
                try:
                    return float(v[0]), float(v[1]), float(v[2]), int(v[3])
                except Exception as err:
                    print(f"Unexpected {err=}, {type(err)=}")
                    return None, None, None, None
            
        else:
            #print("timeout")
            return None, None, None, None
    
    
    def get_imu(self):
        # return IMU readings and their timestamp [s]
        
        ax, ay, az = self.get_acc_calibrated()
        mx, my, mz = self.get_mag_calibrated()
        gx, gy, gz = self.get_gyro_calibrated()
        tick = time.time()
        
        return ax, ay, az, mx, my, mz, gx, gy, gz, tick
    
    
    def get_all(self):
        # return all sensors readings
        
        ax, ay, az = self.get_acc_calibrated()
        mx, my, mz = self.get_mag_calibrated()
        gx, gy, gz = self.get_gyro_calibrated()
        ux, uy, uz, _ = self.get_uwb()          
        
        return ax, ay, az, mx, my, mz, gx, gy, gz, ux, uy, uz
        
        
    def cal_acc(self):
        # compute accelerometer bias and scale, filters samples using a median filter
        
        acc_extreme_buf = np.zeros((6,1))
        str_axis = ["x", "y", "z"]
        # create a filter for each axis
        filters = []
        for i in str_axis:
            filters.append(Median_filter(self.mf_buf_len, i))
            
        # collect data until interrupted
        try:
            while(True):
                x,y,z = self.get_acc()
                
                filters[0].add_el(x)
                filters[1].add_el(y)
                filters[2].add_el(z)
                
                # once filters are full
                if(filters[0].is_full()):
                    #filter data
                    filtered_acc = np.array([mf.filter() for mf in filters])
                    
                    # extract min and max values
                    min_index = np.argmin(filtered_acc)
                    max_index = np.argmax(filtered_acc)
                    # compare to current extremes
                    if(filtered_acc[min_index] < acc_extreme_buf[min_index*2]): #update min
                        acc_extreme_buf[min_index*2] = filtered_acc[min_index]
                        print("New min value on axis ", str_axis[min_index], " : ", filtered_acc[min_index])
                    if(filtered_acc[max_index] > acc_extreme_buf[max_index*2 + 1]): #update max
                        acc_extreme_buf[max_index*2 + 1] = filtered_acc[max_index]
                        print("New max value on axis ", str_axis[max_index], " : ", filtered_acc[max_index])
                        
                time.sleep(0.01)
            
        except KeyboardInterrupt:
            print("Data collection interrupted")
            
        print("Extremes:\n", acc_extreme_buf)
        min = acc_extreme_buf[[0,2,4]]
        max = acc_extreme_buf[[1,3,5]]
        # compute scaling&offsetting
        self.acc_scale = self.g_const*2 / (max-min) 
        self.acc_bias = max - self.g_const / self.acc_scale
        print("acc scale, offset:\n", self.acc_scale, "\n", self.acc_bias)


    def cal_acc_unc(self, n = 1000):
        # compute accelerometer uncertainty
        # n     number of collected samples
        
        buf = np.zeros((3,n))
        # collect data
        for i in range(0, n):
            buf[0,i], buf[1,i], buf[2,i] = self.get_acc()
        
        var = np.var(buf, axis=1)
        print("acc unc:\n", var)
        self.mag_unc = np.diag(var)

    
    def cal_mag(self, wait_ms = 10, n = 4000):
        # compute magnetometer hard and soft iron
        # wait_ms       wait time between samples collection
        # n             number of collected samples
        
        data = []
        # collect data
        try:
            for i in range(0,n):
                x,y,z = self.get_mag()
                data.append([x,y,z])
                time.sleep(wait_ms/1000)
        except KeyboardInterrupt:
            print("Data collection interrupted")
        else:
            print("Data collection finished")
            
        si, hi, expMFS = ellipsoid_fit_ML(data)
        #hi, si = compute_hi_si(data)
        
        print("hi, si, expMFS:\n", hi, "\n", si, "\n", expMFS)
        self.mag_hi = np.reshape(hi, self.mag_hi.shape)
        self.mag_si = si


    def cal_mag_unc(self, n = 1000):
        # compute magnetometer uncertainty
        # n     number of collected samples
        
        buf = np.zeros((3,n))
        # collect data
        for i in range(0, n):
            buf[0,i], buf[1,i], buf[2,i] = self.get_mag()
        
        var = np.var(buf, axis=1)
        print("mag unc:\n", var)
        self.mag_unc = np.diag(var)


    def cal_gyro(self, n = 1000):
        # compute gyroscope uncertainty and bias
        # n     number of collected samples
        
        buf = np.zeros((3,n))
        # collect data
        for i in range(0, n):
            buf[0,i], buf[1,i], buf[2,i] = self.get_gyro()
        
        mean = np.mean(buf, axis=1)
        var = np.var(buf, axis=1)
        print("gyro bias, unc:\n", mean,var)
        self.X_att[4:7] = np.reshape(mean, self.X_att[4:7].shape)
        self.gyro_unc = np.diag(var)
    
      
    def cal_uwb_unc(self, n = 1000):
        # compute UWB uncertainty
        # n     number of collected samples
        
        buf = np.zeros((3,n))
        cnt = 0
        # collect data
        while(cnt < n):
            x, y, z, _ = self.get_uwb()
            if(x != None and x < 1000 and x > -1000): 
                print(x,y,z)
                buf[0,cnt], buf[1,cnt], buf[2,cnt] = x, y, z
                cnt = cnt + 1
                if(cnt%20 == 0): print("counter: ", cnt)
        
        #print(buf)
        mean = np.mean(buf[:,:cnt], axis=1)
        var = np.var(buf[:,:cnt], axis=1)
        print("uwb unc:\n", var)
        print("uwb mean:\n", mean)
        self.uwb_unc = np.diag(var)


    def cal_unc_all(self, n = 1000):
        # compute all sensors uncertainties
        # n     number of collected samples
        
        acc = np.zeros((3,n))
        mag = np.zeros((3,n))
        gyro = np.zeros((3,n))
        uwb = np.zeros((3,n))
        
        cnt = 0
        # collect data
        for i in range(0, n):
            acc[0,i], acc[1,i], acc[2,i] = self.get_acc()
            mag[0,i], mag[1,i], mag[2,i] = self.get_mag()
            gyro[0,i], gyro[1,i], gyro[2,i] = self.get_gyro()
            x, y, z, _ = self.get_uwb()
            if(x != None and x < 1000 and x > 1000): 
                uwb[0,cnt], uwb[1,cnt], uwb[2,cnt] = x, y, z
                cnt = cnt + 1
        # finish to fill uwb buffer
        while(cnt < n):
            x, y, z, _ = self.get_uwb()
            if(x != None and x < 1000 and x > -1000): 
                uwb[0,cnt], uwb[1,cnt], uwb[2,cnt] = x, y, z
                cnt = cnt + 1
                
        print(acc)
        print(mag)
        print(gyro)
        print(uwb)
        
        mean = np.mean(gyro, axis=1)
        print("gyro bias: ", mean)
        self.X_att[4:7] = np.reshape(mean, self.X_att[4:7].shape)
        
        var = np.var(acc, axis=1)
        print("acc unc: ", var)
        self.acc_unc = np.diag(var)
        
        var = np.var(mag, axis=1)
        print("mag unc: ", var)
        self.mag_unc = np.diag(var)
        
        var = np.var(gyro, axis=1)
        print("gyro unc: ", var)
        self.gyro_unc = np.diag(var)        
        
        var = np.var(uwb[:,:cnt], axis=1)
        print("uwb unc: ", var)
        self.uwb_unc = np.diag(var)

    
    def save_config(self, file_name):
        # save current config on file
        # file_name         file name where to save the config
        
        saved = False
        while(not saved):
            try:
                with open(file_name, 'w') as fp:
                    fp.write("acc_bias")
                    for line in self.acc_bias:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("acc_scale")
                    for line in self.acc_scale:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("mag_hi")
                    for line in self.mag_hi:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("mag_si")
                    for line in self.mag_si:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("gyro_bias")
                    for line in self.X_att[4:7]:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("acc_unc")
                    for line in self.acc_unc:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("mag_unc")
                    for line in self.mag_unc:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("gyro_unc")
                    for line in self.gyro_unc:
                        for el in line:
                            fp.write(";%f" % el)
                    fp.write("\n")
                    
                    fp.write("uwb_unc")
                    for line in self.uwb_unc:
                        for el in line:
                            fp.write(";%f" % el)
                    #fp.write("\n")
                    
                    fp.close()
                    saved = True
        
            except Exception as err:
                print(f"Unexpected {err=}, {type(err)=}")
                file_name = input("Enter new file_name: ")
                
            
    def load_config(self, file_name):
        loaded = False
        while(not loaded):
            try:
                with open(file_name, 'r') as fp:
                    for line in fp:
                        # remove linebreak
                        line = line.strip()
                        # split data
                        data_vec = line.split(";")
                        
                        head = data_vec[0]
                        # remove empty element and convert to float
                        data_vec = np.array([float(val) for val in data_vec[1:] if val != ''])
                        
                        if(head == "acc_bias"):
                            self.acc_bias = np.reshape(data_vec, (3,1))
                        
                        if(head == "acc_scale"):
                            self.acc_scale = np.reshape(data_vec, (3,1))
                            
                        if(head == "mag_hi"):
                            self.mag_hi = np.reshape(data_vec, (3,1))
                            
                        if(head == "mag_si"):
                            self.mag_si = np.reshape(data_vec, (3,3))
                            
                        if(head == "gyro_bias"):
                            self.X_att[4:7] = np.reshape(data_vec, (3,1))
                            
                        if(head == "acc_unc"):
                            self.acc_unc = np.reshape(data_vec, (3,3))
                            
                        if(head == "mag_unc"):
                            self.mag_unc = np.reshape(data_vec, (3,3))
                            
                        if(head == "gyro_unc"):
                            self.gyro_unc = np.reshape(data_vec, (3,3))
                        
                        if(head == "uwb_unc"):
                            self.uwb_unc = np.reshape(data_vec, (3,3))
                            
                        print("Loaded ", head)

                    fp.close()
                    loaded = True
                    
            except Exception as err:
                print(f"Unexpected {err=}, {type(err)=}")
                file_name = input("Enter new file_name (blank to exit): ")
                if(file_name == ""): loaded = True