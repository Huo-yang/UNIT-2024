import os
import json
import time
import numpy as np
import random
import torch
import torch.nn as nn
from torch import optim
from torch.nn import DataParallel
from torch.utils.data import DataLoader

from datasets.dataloader import DatasetAnomaly
from utils.tools import EarlyStopping, LearningRateAdjuster, save_model_structure_in_txt
from utils.plotter import Plotter
import models


class Exp:
    def __init__(self, args):
        self.model = None
        self.args = args
        self.device = self._acquire_device()
        self.path = None
        self.test_flag = True if args.data_split[2] != 0 else False
        self.class_names = None

    def _build_model(self, pretrained=False, model_path=""):
        model = getattr(models, "{}".format(self.args.model))(self.args.n_class)
        if pretrained:
            if model_path != "":
                print("using pretrained model")
                model.load_state_dict(torch.load(model_path))
            else:
                raise TypeError

        if self.args.use_multi_gpu and self.args.use_gpu:
            model = nn.DataParallel(model, device_ids=self.args.device_ids)
        return model

    def _acquire_device(self):
        if self.args.use_gpu and not self.args.use_multi_gpu:
            device = torch.device('cuda:{}'.format(self.args.gpu))
            print('Use GPU: cuda:{}'.format(self.args.gpu))
        elif self.args.use_gpu and self.args.use_multi_gpu:
            device = torch.device('cuda:{}'.format(self.args.gpu))
            print('Use GPU: cuda:{}'.format(self.args.devices))
        else:
            device = torch.device('cpu')
            print('Use CPU')
        return device

    def _get_dataloader(self):
        args = self.args

        dataset = DatasetAnomaly(data_split=args.data_split)

        train_dataset, val_dataset, test_dataset, self.class_names = dataset.get_dataset()

        print("train length:{}, validation length:{}".format(len(train_dataset), len(val_dataset)), end='')

        train_loader = DataLoader(
            train_dataset,
            batch_size=args.batch_size,
            shuffle=True,
            num_workers=args.num_workers,
            drop_last=False)

        val_loader = DataLoader(
            val_dataset,
            batch_size=args.batch_size,
            shuffle=True,
            num_workers=args.num_workers,
            drop_last=False)

        if self.test_flag:
            print(", test length:{}".format(len(test_dataset)))
            test_loader = DataLoader(
                test_dataset,
                batch_size=args.batch_size,
                shuffle=False,
                num_workers=args.num_workers,
                drop_last=False)
        else:
            print("")
            test_loader = DataLoader(
                test_dataset,
                batch_size=args.batch_size,
                shuffle=False,
                num_workers=args.num_workers,
                drop_last=False)

        return train_loader, val_loader, test_loader

    def vali(self, vali_loader, criterion):
        self.model.eval()
        identify_confusion_matrix = np.zeros(
            shape=(self.args.n_class, self.args.n_class), dtype=np.int32)
        total_loss = []
        correct = {"number": 0, "total": 0}
        with torch.no_grad():
            for i, (batch_x, batch_y) in enumerate(vali_loader):
                pred, true = self._process_one_batch(batch_x, batch_y)
                batch_y_hat = torch.argmax(pred.detach().cpu(), 1)
                correct["number"] += (batch_y_hat == batch_y).sum()
                correct["total"] += batch_y.shape[0]
                loss = criterion(pred.detach().cpu(), true.detach().cpu())
                total_loss.append(loss.detach().item())
                for i in range(len(batch_y)):
                    identify_confusion_matrix[batch_y[i]][batch_y_hat[i]] += 1
        self.model.train()
        return total_loss, correct["number"] / correct["total"], identify_confusion_matrix

    def train(self, setting, times_now):
        train_loader, vali_loader, test_loader = self._get_dataloader()

        self.path = os.path.join(self.args.checkpoints, setting)
        if not os.path.exists(self.path):
            os.makedirs(self.path)
        with open(os.path.join(self.path, "args.json"), 'w') as f:
            json.dump(vars(self.args), f, indent=True)

        train_steps = len(train_loader)
        lr_adjuster = LearningRateAdjuster(initial_lr=self.args.learning_rate, patience=self.args.patience)
        early_stopping = EarlyStopping(patience=self.args.patience, verbose=True, delta=0.001, data_parallel=self.args.use_multi_gpu,
                                       times_now=times_now)
        plotter = Plotter(self.path, self.test_flag, self.args.train_epochs, len(train_loader), len(vali_loader),
                         len(test_loader), times_now, class_names=self.class_names)

        self.model = self._build_model(self.args.pretrained, self.args.pretrained_path).to(self.device)
        model_optim = optim.Adam(self.model.parameters(), lr=self.args.learning_rate)
        criterion = nn.CrossEntropyLoss()

        total_train_loss, total_vali_loss, total_test_loss = [], [], []
        total_train_acc, total_vali_acc, total_test_acc = [], [], []
        best_model_path = None
        save_index = None
        confusion_matrixs_list = []
        for epoch in range(self.args.train_epochs):
            time_now = time.time()
            iter_count = 0
            train_loss = []

            self.model.train()
            epoch_time = time.time()

            correct = {"number": 0, "total": 0}
            for i, (batch_x, batch_y) in enumerate(train_loader):
                iter_count += 1

                model_optim.zero_grad()
                pred, true = self._process_one_batch(batch_x, batch_y)
                loss = criterion(pred, true)
                train_loss.append(loss.item())
                batch_y_hat = torch.argmax(pred.detach().cpu(), 1)
                correct["number"] += (batch_y_hat == batch_y).sum()
                correct["total"] += batch_y.shape[0]

                if (i + 1) % 100 == 0:
                    print("\titers: {0}, epoch: {1} | loss: {2:.7f}".format(i + 1, epoch + 1, loss.item()))
                    speed = (time.time() - time_now) / iter_count
                    left_time = speed * ((self.args.train_epochs - epoch) * train_steps - i)
                    print('\tspeed: {:.4f}s/iter; left time: {:.4f}s'.format(speed, left_time))
                    iter_count = 0
                    time_now = time.time()

                loss.backward()
                model_optim.step()

            print("Epoch: {0} cost time: {1:.4f}s".format(epoch + 1, time.time() - epoch_time))
            vali_loss, vali_acc, confusion_matrixs = self.vali(vali_loader, criterion)
            total_train_loss.extend(train_loss)
            total_train_acc.append(correct["number"] / correct["total"])
            total_vali_loss.extend(vali_loss)
            total_vali_acc.append(vali_acc)
            confusion_matrixs_list.append(confusion_matrixs)
            print("Epoch: {0}, Steps: {1} | Train Loss: {2:.7f} Vali Loss: {3:.7f} Vali Acc: {4:.4f}".format(
                epoch + 1, train_steps, np.average(train_loss), np.average(vali_loss), vali_acc), end="")
            if self.test_flag:
                test_loss, test_acc, _ = self.vali(test_loader, criterion)
                print(" Test Loss: {0:.7f} Test Acc: {1:.4f}".format(np.average(test_loss), test_acc))
                total_test_loss.extend(test_loss)
                total_test_acc.append(test_acc)
            else:
                print("")
            best_model_path, save_flag = early_stopping(np.average(vali_loss), vali_acc, self.model, self.path)
            if early_stopping.early_stop:
                print("Early stopping")
                break
            if save_flag:
                save_index = epoch

            lr_adjuster.rate_decay_with_patience(model_optim, early_stopping.counter)

        self.model.load_state_dict(torch.load(best_model_path))
        state_dict = self.model.module.state_dict() if isinstance(self.model, DataParallel) else self.model.state_dict()
        torch.save(state_dict, best_model_path)

        self.save_reasult()
        plotter.plot_train_validation_loss(total_train_loss, total_vali_loss, total_test_loss)
        plotter.plot_train_validation_acc(total_train_acc, total_vali_acc, total_test_acc)
        plotter.plot_confusion_matrix(confusion_matrixs_list[save_index])

        return self.model

    def _process_one_batch(self, batch_x, batch_y):
        batch_x = batch_x.to(self.device)
        batch_y = batch_y.to(self.device)

        outputs = self.model(batch_x)

        return outputs, batch_y

    @staticmethod
    def setup_seed(seed):
        torch.manual_seed(seed)
        torch.cuda.manual_seed_all(seed)
        np.random.seed(seed)
        random.seed(seed)
        torch.backends.cudnn.deterministic = True

    def save_reasult(self):
        save_model_structure_in_txt(self.path, self.model)
