import matplotlib.pyplot as plt
import numpy as np

def plot_folder_data():
    data_path = "E:/postgraduate/比赛/2024研电赛/优利德示波器/实验/anomaly_detection/datasets/spike_up.npy"
    datas = np.load(data_path)
    length = len(datas)
    for index, data in enumerate(datas):
        plt.figure(figsize=(16, 6))
        plt.plot(data)
        plt.title("{}/{}".format(index + 1, length))
        plt.show()
        plt.close()
        
if __name__ == "__main__":
    plot_folder_data()