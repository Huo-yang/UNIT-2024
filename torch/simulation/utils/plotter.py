import numpy as np
import json
import os
import matplotlib.pyplot as plt
from matplotlib.ticker import FormatStrFormatter
import math


class Plotter:
    def __init__(self, path, test_flag, epoch, len_train_loader, len_vali_loader, len_test_loader=None, times_now=None,
                 class_names=None):
        self.path = path
        self.test_flag = test_flag
        self.epoch = epoch
        self.len_train_loader = len_train_loader
        self.len_vali_loader = len_vali_loader
        self.len_test_loader = len_test_loader
        self.times_now = times_now
        self.class_names = class_names

    def plot_train_validation_loss(self, train_loss_list, validation_loss_list, test_loss_list=None):
        fig, ax = plt.subplots()
        skip = 10
        x1 = np.array(range(1, len(train_loss_list) + 1), dtype=np.float32) / self.len_train_loader
        x2 = np.array(range(1, len(validation_loss_list) + 1), dtype=np.float32) / self.len_vali_loader
        plt.plot(x1[::skip], train_loss_list[::skip], color='#00BFFF', label="train loss")
        plt.plot(x2[::math.ceil(skip / 2)], validation_loss_list[::math.ceil(skip / 2)], color='#00FF7F',
                 label="validation loss")
        if self.test_flag:
            x3 = np.array(range(1, len(test_loss_list) + 1), dtype=np.float32) / self.len_test_loader
            plt.plot(x3[::math.ceil(skip / 2)], test_loss_list[::math.ceil(skip / 2)], color='#EF8A43',
                     label="validation loss")
        plt.legend()
        plt.title(f"Loss")
        ax.xaxis.set_major_formatter(FormatStrFormatter('%.0f'))
        plt.gca().xaxis.set_major_locator(plt.MultipleLocator(math.ceil(self.epoch / 10)))
        plt.xlabel("epoch")
        plt.ylabel("loss")
        plt.savefig(os.path.join(self.path, "{}_loss.png".format(self.times_now if self.times_now is not None else 0)))
        plt.close()

    def plot_train_validation_acc(self, train_acc_list, validation_acc_list, test_acc_list=None):
        x1 = np.array(range(1, len(train_acc_list) + 1), dtype=np.int16)
        x2 = np.array(range(1, len(validation_acc_list) + 1), dtype=np.int16)
        plt.plot(x1, train_acc_list, color='#00BFFF', label="train acc")
        plt.plot(x2, validation_acc_list, color='#00FF7F', label="validation acc")
        if self.test_flag:
            x3 = np.array(range(1, len(test_acc_list) + 1), dtype=np.int16)
            plt.plot(x3, test_acc_list, color='#EF8A43', label="validation loss")
        plt.legend()
        plt.ylim((0, 1))
        plt.title("Acc")
        plt.xlabel("epoch")
        plt.ylabel("acc")
        plt.savefig(os.path.join(self.path, "{}_acc.png".format(self.times_now if self.times_now is not None else 0)))
        plt.close()

    def _plot_confusion_matrix(self, confusion_matrix, classes=None, normalize=False, title='', cmap=plt.cm.Blues,
                               save_filename=None):
        confusion_matrix = np.array(confusion_matrix)
        if classes is None:
            classes = [str(i) for i in range(len(confusion_matrix))]
        if normalize:
            confusion_matrix = confusion_matrix / confusion_matrix.sum(axis=1, keepdims=True)

        # plt.figure(figsize=(6, 4))
        plt.imshow(confusion_matrix, interpolation='nearest', cmap=cmap)
        plt.title(title + " Confusion matrix")
        plt.colorbar()
        tick_marks = np.arange(len(classes))
        plt.xticks(tick_marks, classes, rotation=-45)
        plt.yticks(tick_marks, classes)

        iters = np.reshape([[[i, j] for j in range(len(classes))] for i in range(len(classes))],
                           (confusion_matrix.size, 2))
        for i, j in iters:
            if normalize:
                plt.text(j, i, "{:.2f}".format(confusion_matrix[i, j]), va='center', ha='center')
            else:
                plt.text(j, i, format(confusion_matrix[i, j]), va='center', ha='center')

        plt.xlabel('Prediction')
        plt.ylabel('Real label')
        plt.tight_layout()
        # plt.show()
        if save_filename is not None:
            plt.savefig(save_filename, dpi=600, bbox_inches='tight')
        plt.close()

    def plot_confusion_matrix(self, confusion_matrixs):
        classes_name = self.class_names
        save_path = os.path.join(self.path,
                                 "{}_confusion_matrix.png".format(self.times_now if self.times_now is not None else 0))
        self._plot_confusion_matrix(confusion_matrixs, classes=classes_name, normalize=False, title='',
                                    save_filename=save_path)


if __name__ == "__main__":
    plotter = Plotter("path", 1, 1, 1, 1)
    plotter._plot_confusion_matrix([[1, 2, 3], [2, 3, 4], [4, 5, 6]])
