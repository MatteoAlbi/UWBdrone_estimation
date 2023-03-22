from ast import Try

# filters log_rtdoa.txt eliminating failed/wrong computation, save filtered data on log_filtered.txt

log = open("log_rtdoa.txt","r")
out = open("log_filtered.txt","w")
ignore = []
iter = 0

line = log.readline()
while line != "":

    v = line.split(" ")
    #print(v[0], iter)
    
    try:
        if abs(float(v[0])) > 1000:
            ignore.append(line)
        else:
            out.write(line)
    except:
        ignore.append(line)

    line = log.readline()
    iter = iter + 1

print("deleted lines: ",len(ignore))
for line in ignore:
    print(line)

log.close()
out.close()
