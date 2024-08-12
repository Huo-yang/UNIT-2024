'''
Author: Huo yang 935585440@qq.com
Date: 2024-06-11 09:53:26
LastEditors: Huo yang 935585440@qq.com
LastEditTime: 2024-06-11 13:40:25
FilePath: /anomaly_detection/save_wive_to_bin.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''
import struct
import numpy as np
import matplotlib.pyplot as plt
from datasets import actual_datasets_creator

def save_wave_to_bin():
    data = np.load("/home/star/huoyang/unit/anomaly_detection/normal_square_1037.npy")
    with open('./bin/wave.bin', 'wb') as file:
        data = data[4::8].tolist()
        # data = data.tolist()
        print("length:{}".format(len(data)))
        for singal_data in data:
            file.write(struct.pack('f', singal_data))
     
def save_txt_wave_to_npy():
    one_file = "/home/star/huoyang/unit/anomaly_detection/normal_square_1037.txt"
    with open(one_file, 'r') as file:
        str_data = file.read()
        str_data = str_data.replace(' ', '').replace('\n', '')
        str_list = [s for s in str_data.split(",") if s]
        data = np.array(str_list, dtype=np.float32)
        data[0] = data[2]
        data[1] = data[2]
        data[-1] = data[-3]
        data[-2] = data[-3]
        np.save(one_file.replace(".txt", ".npy"), data)
        
def plot_data():
    data = np.load("/home/star/huoyang/unit/anomaly_detection/normal_square_1037.npy")
    plt.plot(data)
    plt.savefig("wave.png")

if __name__ == "__main__":
    save_txt_wave_to_npy()
    save_wave_to_bin()
    plot_data()
