import numpy as np
import matplotlib.pyplot as plt

data = []
file_name = "./data2.txt"

with open(file_name, 'r') as fp:
    for line in fp:
        line = line.strip()
        data_vec = line.split(" ")

        data_vec = [val for val in data_vec if val != '']
        data.append(data_vec)

# data_mask = [i for i, line in enumerate(data) if line[-1] == '0']
# data_filt = [data[i] for i in data_mask]
data_filt = data

raw_m = [line[1:4]  for line in data_filt if len(line) > 3]
mag_n = [line[5:8]  for line in data_filt if len(line) > 7]
#eul   = [line[9:12] for line in data_filt if len(line) > 12]

raw_m = [line for line in raw_m if line != []]
mag_n = [line for line in mag_n if line != []]


for i in range(len(raw_m)):
    for j in range(len(raw_m[1])):
        #eul[i][j]   = float(eul[i][j])
        raw_m[i][j] = float(raw_m[i][j])
for i in range(len(mag_n)):
    for j in range(len(mag_n[1])):       
        mag_n[i][j] = float(mag_n[i][j])

raw_m = np.array(raw_m)
mag_n = np.array(mag_n)
#eul   = np.array(eul)

print(raw_m.shape)
print(mag_n.shape)
#print(eul.shape)

plt.plot(mag_n[:,:])
plt.ylabel('some numbers')
plt.legend(("x", "y"))
plt.show()

