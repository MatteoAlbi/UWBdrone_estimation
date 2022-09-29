from ast import Try

'''
bit print order
        rx1 rx2 tx1 tx2
master  1   7   13  19
#1      2   8   14  20  
#2      3   9   15  21
#3      4   10  16  22
#4      5   11  17  23
#5      6   12  18  24

all ts have 40 bits
'''

log = open("log_trajectory.txt","r")
acc = open("acc.txt","w")
rx1 = open("rx1.txt","w")
rx2 = open("rx2.txt","w")
tx1 = open("tx1.txt","w")
tx2 = open("tx2.txt","w")
uwb = open("uwb.txt","w")

iter = 0 #number of data processed

exponensts = range(39,-1,-1)
print(len(exponensts))

ts_line = log.readline().strip() #read first line: ts
while ts_line != "":
    if(ts_line[0] == "R"): break

    # UWB processed data
    uwb_line = log.readline()
    # sing matrix error
    if(uwb_line[0] == "S"):
        uwb_line = log.readline()
        # uwb_v = uwb_line.split(" ")
        # sing_mat_str = uwb_v[0] + " " + uwb_v[1] + " " + uwb_v[2] + uwb_v[3]
        #uwb.write(sing_mat_str)  
        uwb.write("5 0 0\n")
    # div by 0 error
    elif(uwb_line[0] == "D"):
        #uwb_v = uwb_line.split(" ")
        #divbyzero_str = uwb_v[0] + " " + uwb_v[1] + " " + uwb_v[2] + "\n"
        #uwb.write(divbyzero_str)  
        uwb.write("0 0 0\n")
    # no error
    else :
        uwb.write(uwb_line)   
    
    # acc raw data
    acc_line = log.readline() #read second line: acc
    acc.write(acc_line) #write to file

    # timestamp
    ts_v = ts_line.split(" ") #vector of timestamps in bit
    
    for i in range(len(ts_v)):
        ts_string = ts_v[i] #single ts

        ts_numeric = 0 #convert to numeric
        for j in range(len(ts_string)):
            bit = int(ts_string[j])
            ts_numeric = ts_numeric + bit * pow(2,exponensts[j])

        if (i < 6): rx1.write(str(ts_numeric)+" ")
        elif (i<12): rx2.write(str(ts_numeric)+" ")
        elif (i<18): tx1.write(str(ts_numeric)+" ")
        else: tx2.write(str(ts_numeric)+" ")

    rx1.write("\n")
    rx2.write("\n")
    tx1.write("\n")
    tx2.write("\n")
    
    ts_line = log.readline().strip()
    iter = iter + 1 

print(iter)
log.close()
acc.close()
rx1.close()
rx2.close()
tx1.close()
tx2.close()
uwb.close()
