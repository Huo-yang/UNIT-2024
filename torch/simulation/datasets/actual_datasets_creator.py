import numpy as np
import matplotlib.pyplot as plt
import os
from tqdm import tqdm

class ActualDatasetsCreator:
    def __init__(self):
        self.n_data_points = 2048
        self.base_path = "/home/star/huoyang/unit/dataset/processed/square"
        self.save_path = "/home/star/huoyang/unit/dataset/for_train"
        self.class_names = []
        self._check_class()
        
    def _check_class(self):
        dirs_path = os.listdir(self.base_path)
        dirs_path = sorted(dirs_path)
        for dir_path in dirs_path:
            if "hook" in dir_path and "hook" not in self.class_names:
                self.class_names.append("hook")
            elif "normal" in dir_path and "normal" not in self.class_names:
                self.class_names.append("normal")
            elif "overshoot" in dir_path and "overshoot" not in self.class_names:
                self.class_names.append("overshoot")
            elif "spike" in dir_path and "spike" not in self.class_names:
                self.class_names.append("spike")
        
    def _cut_by_window(self, data, window_length, overlap_rate):
        width = len(data)
        i = 0
        signal_list = []
        while((i+1) * window_length - window_length * overlap_rate * i < width):
            signal_list.append(data[int(i * window_length - window_length * overlap_rate * i):int((i+1) * window_length - window_length * overlap_rate * i)])
            i += 1
        return np.array(signal_list)
    
    def deal_ori_data(self, select = 1):
        dirs_path = os.listdir(self.base_path)
        dirs_path = sorted(dirs_path)
        save_count = 0
        for class_index, class_name in enumerate(self.class_names):
            print("process " + class_name)
            class_dirs_path = [class_dir_path for class_dir_path in dirs_path if class_name in class_dir_path]
            for class_dir_path in class_dirs_path:
                file_paths = os.listdir(os.path.join(self.base_path, class_dir_path))
                for one_file in file_paths:
                    one_file = os.path.join(self.base_path, class_dir_path, one_file)
                    file_data = np.load(one_file)
                    for i in range(select):
                        data = file_data[i::select]
                        np.savez(self.save_path + '/' + "{}.npz".format(save_count), data = data, label = class_index)
                        save_count += 1
            
if __name__ == "__main__":
    creator = ActualDatasetsCreator()
    creator.deal_ori_data(8)
                
