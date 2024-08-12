'''
Author: Huo yang 935585440@qq.com
Date: 2024-06-11 09:53:26
LastEditors: Huo yang 935585440@qq.com
LastEditTime: 2024-06-11 13:23:56
FilePath: /anomaly_detection/check_predict.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''
import torch
import models
import struct
import numpy as np

model_path = "/home/star/huoyang/unit/anomaly_detection/checkpoints/experiment_Anomaly_date_20240801100115/0_CNN_0.9994.pth"
model = models.CNN(4)
model.load_state_dict(torch.load(model_path))
model.eval()
file_path = './bin/wave.bin'
with open(file_path, 'rb') as file:
    data_bytes = file.read()
n_floats = len(data_bytes) // np.dtype(np.float32).itemsize
data_array = np.frombuffer(data_bytes, dtype=np.float32)
data_array = torch.tensor(data_array)
data_array = torch.unsqueeze(data_array, dim=0)
print(model(data_array))
