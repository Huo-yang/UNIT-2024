'''
Author: Huo yang 935585440@qq.com
Date: 2024-06-11 09:53:26
LastEditors: Huo yang 935585440@qq.com
LastEditTime: 2024-06-11 13:28:17
FilePath: /anomaly_detection/save_weight_to_bin.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''
import torch
import models
import struct

model_path = "/home/star/huoyang/unit/anomaly_detection/checkpoints/experiment_Anomaly_date_20240806160040/0_CNN_0.9999.pth"
save_path = "/home/star/huoyang/unit/anomaly_detection/bin"
model = models.CNN(4)
model.load_state_dict(torch.load(model_path))
for name in model.state_dict():
    with open(save_path + '/' + '{}.bin'.format(name), 'wb') as file:
        tensor = model.state_dict()[name]
        tensor = tensor.flatten()
        tensor = tensor.numpy()
        tensor = tensor.tolist()
        print("{:30}  length:{}".format(name, len(tensor)))
        for singal_data in tensor:
            file.write(struct.pack('f', singal_data))
