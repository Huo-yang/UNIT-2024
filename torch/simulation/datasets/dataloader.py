import os
import numpy as np
import random
import torch
from torch.utils.data import Dataset

from utils.tools import StandardScaler
from datasets import actual_datasets_creator


class DatasetAnomaly():
    def __init__(self, data_split=None):
        if data_split is None:
            data_split = [0.7, 0.1, 0.2]
        self.data_split = data_split
        self.class_names = None

    def _get_data_path(self):
        creator = actual_datasets_creator.ActualDatasetsCreator()
        self.class_names = creator.class_names
        datas_path = [file for file in os.listdir(creator.save_path) if ".npz" in file]

        return datas_path, creator.save_path

    @staticmethod
    def _data_path_split(input_datas_path, ratio):
        n_examples = len(input_datas_path)
        n_x1 = round(ratio[0] * n_examples)  # 划分数据集 n_train : n_test = 8:2

        random.shuffle(input_datas_path)

        return input_datas_path[:n_x1], input_datas_path[n_x1:]

    def get_dataset(self, test_source_flag=False):
        datas_path, path_base = self._get_data_path()
        train_datas_path, other_datas_path = self._data_path_split(datas_path, [self.data_split[0], sum(self.data_split[1:])])
        train_dataset = MyDataset(train_datas_path, path_base)
        if self.data_split[-1] != 0 and not test_source_flag:
            validation_datas_path, test_datas_path = self._data_path_split(other_datas_path, [x / sum(self.data_split[1:]) for x in self.data_split[1:]])
            validation_dataset = MyDataset(validation_datas_path, path_base)
            test_dataset = MyDataset(test_datas_path, path_base)
        else:
            validation_dataset = MyDataset(other_datas_path, path_base)
            if test_source_flag:
                test_data = None
                test_dataset = MyDataset(test_data, path_base)
            else:
                test_dataset = MyDataset([], path_base)
        return train_dataset, validation_dataset, test_dataset, self.class_names


class MyDataset(Dataset):
    def __init__(self, datas_path, path_base):
        self.datas_path = datas_path
        self.path_base = path_base

    def __getitem__(self, index):
        with np.load(self.path_base + '/' + self.datas_path[index]) as data_file:
            data = data_file['data']
            label = data_file['label']
            data = np.array(data, dtype=np.float32)
            label = np.array(label, dtype=np.int64)
        return data, label

    def __len__(self):
        return len(self.datas_path)