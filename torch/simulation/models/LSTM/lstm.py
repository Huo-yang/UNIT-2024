import torch
import torch.nn as nn

class LstmFc(nn.Module):
    def __init__(self, num_classes):
        super(LstmFc, self).__init__()
        hidden_size = 16
        num_layers = 2
        self.lstm = nn.LSTM(1, hidden_size, num_layers, batch_first=True, dropout=0.2)
        self.fc = nn.Sequential(
            nn.Linear(hidden_size * 2048, num_classes)
        )

    def forward(self, batch_x):
        batch_x = torch.unsqueeze(batch_x, dim=1)
        batch_x = batch_x.permute(0, 2, 1)
        batch_x, _ = self.lstm(batch_x)
        batch_x = batch_x.flatten(1)
        batch_y = self.fc(batch_x)

        return batch_y