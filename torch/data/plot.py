import matplotlib.pyplot as plt
import numpy as np
import os

def plot_folder_data(select = 1):
    data_path = "E:/postgraduate/比赛/2024研电赛/优利德示波器/实验/dataset/processed/square/overshoot_down/"
    file_names = os.listdir(data_path)
    file_paths = [os.path.join(data_path, file_name) for file_name in file_names if file_name.endswith('.npy')]
    file_paths = sorted(file_paths, key=lambda file_path: int(file_path.split('_')[-1].split('.')[0]))
    for index, one_file in enumerate(file_paths):
        if(index < 1000):
            continue
        data = np.load(one_file)
        data = data[::select]
        plt.figure(figsize=(16, 6))
        plt.plot(data)
        plt.title(one_file.split('/')[-1].split('.')[0])
        plt.xlabel(len(data))
        plt.show()
        plt.close()

if __name__ == "__main__":
    plot_folder_data()