'''
Author: Huo yang 935585440@qq.com
Date: 2024-06-11 09:53:26
LastEditors: Huo yang 935585440@qq.com
LastEditTime: 2024-06-11 10:12:09
FilePath: /anomaly_detection/train.py
Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
'''
import argparse
import torch
import random
import time
from experiment.exp import Exp
from utils.tools import string_split

parser = argparse.ArgumentParser(description='Radio Fingerprint Classification')

parser.add_argument('--data', type=str, default='Anomaly', help='chose data')
parser.add_argument('--model', type=str, default='CNN', help='chose model')
parser.add_argument('--data_split', type=str, default='0.8,0.2',
                    help='train/val/test split, must be ratio, test can be zero')
parser.add_argument('--pretrained', type=bool, default=True, help='load pretrained model')
parser.add_argument('--pretrained_path', type=str, default="/home/star/huoyang/unit/anomaly_detection/checkpoints/experiment_Anomaly_date_20240806101744/0_CNN_0.9999.pth", help='path of pretrained model')
parser.add_argument('--checkpoints', type=str, default='./checkpoints/', help='location to store model checkpoints')

parser.add_argument('--num_workers', type=int, default=0, help='data loader num workers')
parser.add_argument('--batch_size', type=int, default=64, help='batch size of train input data')
parser.add_argument('--train_epochs', type=int, default=200, help='train epochs')
parser.add_argument('--patience', type=int, default=8, help='early stopping patience')
parser.add_argument('--learning_rate', type=float, default=1e-4, help='optimizer initial learning rate')
parser.add_argument('--lradj', type=str, default='type1', help='adjust learning rate')
parser.add_argument('--itr', type=int, default=1, help='times of experiment')
parser.add_argument('--seed', type=int, default=random.randint(0, 2 ** 32 - 1), help='experiment seed')

parser.add_argument('--n_class', type=int, default=16, help='number of class')

parser.add_argument('--use_gpu', type=bool, default=True, help='use gpu')
parser.add_argument('--gpu', type=int, default=0, help='gpu')
parser.add_argument('--use_multi_gpu', default=False, action='store_true', help='use multiple gpus')
parser.add_argument('--devices', type=str, default='0,1', help='device ids of multile gpus')

args = parser.parse_args()

args.use_gpu = True if torch.cuda.is_available() and args.use_gpu else False

if args.use_gpu and args.use_multi_gpu:
    args.device_ids = string_split(args.devices, "int")
    args.gpu = args.device_ids[0]

args.data_split = string_split(args.data_split, "float")
assert sum(args.data_split) == 1 and args.data_split[0] > 0 and args.data_split[1] > 0 and len(args.data_split) <= 3
if len(args.data_split) == 2:
    args.data_split.append(0.0)

data_parser = {
    "Anomaly": {"n_class": 4},
}

data_info = data_parser[args.data]
args.n_class = data_info["n_class"]

print('Args in experiment:')
print(args)

st = time.strftime('%Y%m%d%H%M%S', time.localtime())

exp = Exp(args)
# exp.setup_seed(args.seed)

for i_experiment_time in range(args.itr):
    setting = 'experiment_{}_date_{}'.format(args.data, st)

    print('>>>>>>>start training : {}_times_{}>>>>>>>>>>>>>>>>>>>>>>>>>>'.format(setting, i_experiment_time))
    exp.train(setting, i_experiment_time)
