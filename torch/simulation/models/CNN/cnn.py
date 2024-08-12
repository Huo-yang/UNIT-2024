import torch
import torch.nn as nn

class CNN(nn.Module):
    def __init__(self, num_classes):
        super(CNN, self).__init__()
        self.conv1 = nn.Sequential(
            nn.Conv1d(in_channels=1, out_channels=32, kernel_size=49, stride=15),
            nn.BatchNorm1d(32),
            nn.ReLU(),
        )
        self.conv2 = nn.Sequential(
            nn.Conv1d(in_channels=32, out_channels=32, kernel_size=15, stride=3),
            nn.BatchNorm1d(32),
            nn.ReLU(),
        )
        self.conv3 = nn.Sequential(
            nn.Conv1d(in_channels=32, out_channels=16, kernel_size=3, stride=1),
            nn.BatchNorm1d(16),
            nn.ReLU(),
        )
        self.fc1 = nn.Sequential(
            nn.Linear(16*16, 4),
        )
        
    def forward(self, batch_x):
        batch_x = torch.unsqueeze(batch_x, dim=1)
        batch_x = self.conv1(batch_x)
        batch_x = self.conv2(batch_x)
        batch_x = self.conv3(batch_x)
        batch_x = batch_x.flatten(1)
        batch_x = self.fc1(batch_x)
        
        return batch_x
        