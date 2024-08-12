import numpy as np

file_path = './bin/wave.bin'

with open(file_path, 'rb') as file:
    data_bytes = file.read()

n_floats = len(data_bytes) // np.dtype(np.float32).itemsize

data_array = np.frombuffer(data_bytes, dtype=np.float32)

print("Length of data array:", len(data_array))
print("Data array:")
for i in range(len(data_array)):
    print("{:f} ".format(data_array[i]), end="")
    if (i + 1) % 16 == 0 and i != len(data_array) - 1:
        print("")