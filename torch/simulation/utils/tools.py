import numpy as np
import torch
import os
import json
import sys


class LearningRateAdjuster:
    def __init__(self, initial_lr, patience, lr_decay_rate=0.5):
        self.lr = initial_lr
        self.patience = patience
        self.lr_decay_rate = lr_decay_rate
        assert 1 >= self.lr_decay_rate > 0

    def rate_decay_with_patience(self, optimizer, patience_count):
        if patience_count / self.patience > 0.5:
            self.lr *= self.lr_decay_rate
            for param_group in optimizer.param_groups:
                param_group['lr'] = self.lr
            print('Updating learning rate to {}'.format(self.lr))


class EarlyStopping:
    def __init__(self, patience=7, verbose=False, delta=0, data_parallel=False, times_now=None):
        self.patience = patience
        self.verbose = verbose
        self.counter = 0
        self.best_score = None
        self.best_acc = None
        self.early_stop = False
        self.val_loss_min = np.Inf
        self.vali_acc_max = np.Inf
        self.delta = delta
        self.save_checkpoint_path = None
        self.data_parallel = data_parallel
        self.times_now = times_now

    def __call__(self, val_loss, vali_acc, model, path):
        score = -val_loss
        if self.best_score is None:
            self.best_score = score
            self.best_acc = vali_acc
            self.save_checkpoint(val_loss, vali_acc, model, path)
            save_flag = True
        elif score < self.best_score + self.delta:
            self.counter += 1
            print(f'EarlyStopping counter: {self.counter} out of {self.patience}')
            if self.counter >= self.patience:
                self.early_stop = True
            save_flag = False
        else:
            self.best_score = score
            self.best_acc = vali_acc
            self.save_checkpoint(val_loss, vali_acc, model, path)
            self.counter = 0
            save_flag = True
        return self.save_checkpoint_path, save_flag

    def save_checkpoint(self, val_loss, vali_acc, model, path):
        if self.verbose:
            print(f'Validation loss decreased ({self.val_loss_min:.6f} --> {val_loss:.6f})')
            # print(f', and validation acc increased ({self.vali_acc_max:.6f} --> {vali_acc:.6f}).')
            print("saving model...")
        if self.save_checkpoint_path is not None:
            os.remove(self.save_checkpoint_path)
        if self.data_parallel:
            self.save_checkpoint_path = path + '/' + '{}_{}_{:.4f}.pth'.format(
                self.times_now if self.times_now is not None else 0, type(model.module).__name__, vali_acc)
        else:
            self.save_checkpoint_path = path + '/' + '{}_{}_{:.4f}.pth'.format(
                self.times_now if self.times_now is not None else 0, type(model).__name__, vali_acc)
        torch.save(model.state_dict(), self.save_checkpoint_path)
        self.val_loss_min = val_loss
        self.vali_acc_max = vali_acc


class StandardScaler:
    def __init__(self, mean=0., std=1.):
        self.mean = mean
        self.std = std

    def fit(self, data):
        self.mean = data.mean(0)
        self.std = data.std(0)

    def transform(self, data):
        mean = torch.from_numpy(self.mean).type_as(data).to(data.device) if torch.is_tensor(data) else self.mean
        std = torch.from_numpy(self.std).type_as(data).to(data.device) if torch.is_tensor(data) else self.std
        return (data - mean) / std

    def inverse_transform(self, data):
        mean = torch.from_numpy(self.mean).type_as(data).to(data.device) if torch.is_tensor(data) else self.mean
        std = torch.from_numpy(self.std).type_as(data).to(data.device) if torch.is_tensor(data) else self.std
        return (data * std) + mean


def load_args(filename):
    with open(filename, 'r') as f:
        args = json.load(f)
    return args


def save_model_structure_in_txt(path, model):
    with open(os.path.join(path, 'model_structure.txt'), 'w') as f:
        sys.stdout = f
        print(model)
        sys.stdout = sys.__stdout__


def string_split(str_for_split, flag):
    str_no_space = str_for_split.replace(' ', '')
    str_split = str_no_space.split(',')
    if flag == "float":
        value_list = [float(x) for x in str_split]
    elif flag == "int":
        value_list = [int(x) for x in str_split]
    else:
        raise ValueError

    return value_list
