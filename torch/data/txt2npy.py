'''
Author: Huo yang 935585440@qq.com
Date: 2024-06-11 09:53:27
LastEditors: Huo yang 935585440@qq.com
LastEditTime: 2024-06-11 13:03:07
FilePath: /dataset/txt2npy.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''
import numpy as np
import os

def processed_ori_data():
    txt_folder_path = "/home/star/huoyang/unit/dataset/origin/square/spike_up"
    file_names = os.listdir(txt_folder_path)
    file_paths = [os.path.join(txt_folder_path, file_name) for file_name in file_names if file_name.endswith('.txt')]
    for one_file in file_paths:
        with open(one_file, 'r') as file:
            str_data = file.read()
            str_data = str_data.replace(' ', '').replace('\n', '')
            str_list = [s for s in str_data.split(",") if s]
            data = np.array(str_list, dtype=np.float32)
            data[0] = data[2]
            data[1] = data[2]
            data[-1] = data[-3]
            data[-2] = data[-3]
            np.save(one_file.replace("origin", "processed").replace(".txt", ".npy"), data)
            
if __name__ == "__main__":
    processed_ori_data()