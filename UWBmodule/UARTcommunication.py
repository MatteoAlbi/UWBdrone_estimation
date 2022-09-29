import serial

print("Start program")
port = "COM3"
br = 115200

ser = serial.Serial(port, br)

message = [0x28, 0x02, 0x0D, 0x01]
message_b = bytearray(message)
ser.write(message_b)

while True:  # Or: while ser.inWaiting():
    print(ser.readline())

#ret = ser.read(3)
#print(ret)
ser.close()
del ser

print("End program")
