import os

path_base = "E:/postgraduate/比赛/2024研电赛/优利德示波器/实验/dataset/origin/square/overshoot_down"
file_names = os.listdir(path_base)
new_names = ["overshoot_down" + file.split("overshoot")[1] for file in file_names]

for index in range(len(file_names)):
    os.rename(os.path.join(path_base, file_names[index]), os.path.join(path_base, new_names[index]))