import numpy as np
import torch
from scipy.fftpack import fft
from datasets.emulation_datasets_creator import *


def FFT(Fs, data):
    """
    对输入信号进行FFT
    :param Fs:  采样频率
    :param data:待FFT的序列
    :return:
    """
    L = len(data)  # 信号长度
    N = np.power(2, np.ceil(np.log2(L)))  # 下一个最近二次幂，也即N个点的FFT
    result = np.abs(fft(x=data, n=int(N))) / L * 2  # N点FFT
    axisFreq = np.arange(int(N / 2)) * Fs / N  # 频率坐标
    result = result[range(int(N / 2))]  # 因为图形对称，所以取一半
    return axisFreq, result


def BIQ_FFT(datas):
    cuda_flag = False
    if datas.is_cuda:
        cuda_flag = True
        device = "{}:{}".format(datas.device.type, datas.device.index)
        datas = datas.cpu().numpy()
    else:
        datas = datas.numpy()
    Fs = 2e5
    batch, channel, length = datas.shape
    out_datas = []
    for iq_data in datas:
        processed_iq = []
        for data in iq_data:
            N = np.power(2, np.ceil(np.log2(length)))
            result = np.abs(fft(x=data, n=int(N))) / length * 2
            result = result[range(int(N / 2))]
            processed_iq.append(result)
        out_datas.append(processed_iq)
    out_datas = np.array(out_datas)
    out_datas = torch.from_numpy(out_datas)
    if cuda_flag:
        out_datas = out_datas.to(device)
    return out_datas
