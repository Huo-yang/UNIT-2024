import numpy as np
import matplotlib.pyplot as plt
import os
from tqdm import tqdm


class DatasetsCreator:
    def __init__(self):
        self.n_data_points = 512
        self.base_path = "E:\\postgraduate\\比赛\\2024研电赛\\优利德示波器\\实验\\anomaly_detection\\datasets\\datasets"
        self.class_names = ["normal", "point_anomaly", "contextual_anomaly"]

    def create_normal_sin(self, period, amplitude):
        assert 1.5 < period < 3
        assert 50 < amplitude < 125
        x = np.linspace(0, 2 * np.pi * period, self.n_data_points)
        phase_shift = 2 * np.pi * period * np.random.random()
        noise = np.random.normal(0, 0.01, len(x))
        y = np.sin(x + phase_shift) + noise
        y = (y * amplitude).astype(int)

        plt.plot(x, y)
        plt.show()
        return y

    def create_normal_mix_sin(self):
        x1_period = np.random.uniform(1.5, 3)
        x1_amplitude = np.random.randint(50, 125) / 2
        x2_period = np.random.uniform(1.5, 3)
        x2_amplitude = np.random.randint(50, 125) / 2
        x1 = np.linspace(0, 2 * np.pi * x1_period, self.n_data_points)
        x2 = np.linspace(0, 2 * np.pi * x2_period, self.n_data_points)
        x1_phase_shift = 2 * np.pi * x1_period * np.random.random()
        x2_phase_shift = 2 * np.pi * x2_period * np.random.random()
        noise = np.random.normal(0, 0.01, self.n_data_points)
        y = np.sin(x1 + x1_phase_shift) * x1_amplitude + np.sin(x2 + x2_phase_shift) * x2_amplitude
        noise = (noise * (x1_amplitude + x2_amplitude))/2
        y = (y + noise).astype(int)

        plt.plot(y)
        plt.show()
        return y

    def create_normal_square(self, period, amplitude):
        assert 1.5 < period < 3
        assert 50 < amplitude < 125
        x = np.linspace(0, 2 * np.pi * period, self.n_data_points)
        phase_shift = 2 * np.pi * period * np.random.random()
        noise = np.random.normal(0, 0.01, len(x))
        y = np.sign(np.sin(x + phase_shift))
        y = y + noise
        y = (y * amplitude).astype(int)

        plt.plot(x, y)
        plt.show()
        return y

    def create_normal_pulse(self):
        num_samples = 512
        # 随机脉冲的次数，不大于4
        num_pulses = np.random.randint(5, 7)

        # 初始化信号数组，填充零
        y = np.zeros(num_samples)

        # 对每个脉冲，随机选择其位置、高度和宽度
        for _ in range(num_pulses):
            pulse_position = np.random.randint(0, num_samples)  # 脉冲的中心位置
            pulse_height = np.random.uniform(-1, 1)  # 脉冲的高度
            pulse_width = np.random.randint(1, 11)  # 脉冲的宽度，至少为1个采样点宽，这里假设不超过10个采样点

            # 确保脉冲不会超出信号的边界
            start = max(pulse_position - pulse_width // 2, 0)
            end = min(pulse_position + pulse_width // 2 + 1, num_samples)

            # 生成该脉冲的信号片段
            pulse_signal = np.arange(start, end) - pulse_position
            pulse_signal = np.clip(pulse_signal, -pulse_width // 2, pulse_width // 2)
            pulse_signal = np.where(np.abs(pulse_signal) <= pulse_width // 2,
                                    pulse_height * (1 - (np.abs(pulse_signal) / (pulse_width // 2))), 0)

            # 将脉冲信号累加到总信号中
            y[start:end] += pulse_signal

        plt.plot(y)
        plt.show()
        return y

    def create_point_anomaly_sin(self, period, amplitude):
        assert 1.5 < period < 3
        assert 50 < amplitude < 125
        x = np.linspace(0, 2 * np.pi * period, self.n_data_points)
        phase_shift = 2 * np.pi * period * np.random.random()
        noise = np.random.normal(0, 0.01, len(x))
        y = np.sin(x + phase_shift) + noise
        y = (y * amplitude).astype(int)
        anomaly_pos = np.random.randint(0, self.n_data_points)
        anomaly_data = np.random.randint(-128, 127)
        while np.abs(y[anomaly_pos] - anomaly_data) < amplitude * 0.06 or np.abs(y[anomaly_pos] - anomaly_data) > amplitude * 0.5:
            anomaly_data = np.random.randint(-128, 127)
        y[anomaly_pos] = anomaly_data

        plt.plot(x, y)
        plt.show()
        return y

    def create_point_anomaly_square(self, period, amplitude):
        assert 1.5 < period < 3
        assert 50 < amplitude < 125
        x = np.linspace(0, 2 * np.pi * period, self.n_data_points)
        phase_shift = 2 * np.pi * period * np.random.random()
        noise = np.random.normal(0, 0.01, len(x))
        y = np.sign(np.sin(x + phase_shift))
        y = y + noise
        y = (y * amplitude).astype(int)
        anomaly_pos = np.random.randint(0, self.n_data_points)
        anomaly_data = np.random.randint(-128, 127)
        while np.abs(y[anomaly_pos] - anomaly_data) < amplitude * 0.06 or np.abs(y[anomaly_pos] - anomaly_data) > amplitude * 0.5:
            anomaly_data = np.random.randint(-128, 127)
        y[anomaly_pos] = anomaly_data

        plt.plot(x, y)
        plt.show()
        return y

    def create_contextual_anomaly_sin(self, period, amplitude):
        assert 1.5 < period < 3
        assert 50 < amplitude < 125
        x = np.linspace(0, 2 * np.pi * period, self.n_data_points)
        phase_shift = 2 * np.pi * period * np.random.random()
        noise = np.random.normal(0, 0.01, len(x))
        y = np.sin(x + phase_shift)
        y = y + noise
        y = (y * amplitude).astype(int)
        range_min = 4
        range_max = 8
        anomaly_pos = np.random.randint(0, self.n_data_points - range_max)
        anomaly_range = np.random.randint(range_min, range_max)
        anomaly_shift = np.random.randint(-128, 127)
        while np.abs(anomaly_shift) < amplitude * 0.1 or np.abs(anomaly_shift) > amplitude * 0.5:
            anomaly_shift = np.random.randint(-128, 127)
        for shift_point in range(0, anomaly_range):
            y[anomaly_pos + shift_point] = y[anomaly_pos + shift_point] - anomaly_shift

        plt.plot(x, y)
        plt.show()
        return y

    def create_contextual_anomaly_square(self, period, amplitude):
        assert 1.5 < period < 3
        assert 50 < amplitude < 125
        x = np.linspace(0, 2 * np.pi * period, self.n_data_points)
        phase_shift = 2 * np.pi * period * np.random.random()
        noise = np.random.normal(0, 0.01, len(x))
        y = np.sign(np.sin(x + phase_shift)) + noise
        y = (y * amplitude).astype(int)
        range_min = 4
        range_max = 8
        anomaly_pos = np.random.randint(0, self.n_data_points - range_max)
        anomaly_range = np.random.randint(range_min, range_max)
        anomaly_shift = np.random.randint(-128, 127)
        while np.abs(anomaly_shift) < amplitude * 0.1 or np.abs(anomaly_shift) > amplitude * 0.5:
            anomaly_shift = np.random.randint(-128, 127)
        for shift_point in range(0, anomaly_range):
            y[anomaly_pos + shift_point] = y[anomaly_pos + shift_point] - anomaly_shift

        plt.plot(x, y)
        plt.show()
        return y

    def create_normal_sin_datas(self, num):
        path = os.path.join(self.base_path, "sin", "normal")
        if not os.path.exists(path):
            os.makedirs(path)
        period_range = [1.55, 2.95]
        amplitude_range = [51, 124]
        period_list = np.arange(start=period_range[0], stop=period_range[1], step=0.01)
        amplitude_list = np.arange(start=amplitude_range[0], stop=amplitude_range[1], step=1)
        data = []
        with tqdm(total=len(period_list) * len(amplitude_list)) as pbar:
            for period in period_list:
                for amplitude in amplitude_list:
                    pbar.set_description("Processing period {:.2f} amplitude {:d}".format(period, amplitude))
                    for _ in range(num):
                        data.append(self.create_normal_sin(period, amplitude))
                    pbar.update(1)
        file_name = "period_start_{:.2f}_end_{:.2f}_amplitude_start_{:.2f}_end_{:.2f}_each_n_{}.npy".format(
            period_range[0], period_range[1], amplitude_range[0], amplitude_range[1], num)
        np.save(os.path.join(path, file_name), np.array(data, dtype=np.int8))

    def create_point_anomaly_sin_datas(self, num):
        path = os.path.join(self.base_path, "sin", "point_anomaly")
        if not os.path.exists(path):
            os.makedirs(path)
        period_range = [1.55, 2.95]
        amplitude_range = [51, 124]
        period_list = np.arange(start=period_range[0], stop=period_range[1], step=0.01)
        amplitude_list = np.arange(start=amplitude_range[0], stop=amplitude_range[1], step=1)
        data = []
        with tqdm(total=len(period_list) * len(amplitude_list)) as pbar:
            for period in period_list:
                for amplitude in amplitude_list:
                    pbar.set_description("Processing period {:.2f} amplitude {:d}".format(period, amplitude))
                    for _ in range(num):
                        data.append(self.create_point_anomaly_sin(period, amplitude))
                    pbar.update(1)
        file_name = "period_start_{:.2f}_end_{:.2f}_amplitude_start_{:.2f}_end_{:.2f}_each_n_{}.npy".format(
            period_range[0], period_range[1], amplitude_range[0], amplitude_range[1], amplitude, num)
        np.save(os.path.join(path, file_name), np.array(data, dtype=np.int8))

    def create_contextual_anomaly_sin_datas(self, num):
        path = os.path.join(self.base_path, "sin", "contextual_anomaly")
        if not os.path.exists(path):
            os.makedirs(path)
        period_range = [1.55, 2.95]
        amplitude_range = [51, 124]
        period_list = np.arange(start=period_range[0], stop=period_range[1], step=0.01)
        amplitude_list = np.arange(start=amplitude_range[0], stop=amplitude_range[1], step=1)
        data = []
        with tqdm(total=len(period_list) * len(amplitude_list)) as pbar:
            for period in period_list:
                for amplitude in amplitude_list:
                    pbar.set_description("Processing period {:.2f} amplitude {:d}".format(period, amplitude))
                    for _ in range(num):
                        data.append(self.create_contextual_anomaly_sin(period, amplitude))
                    pbar.update(1)
        file_name = "period_start_{:.2f}_end_{:.2f}_amplitude_start_{:.2f}_end_{:.2f}_each_n_{}.npy".format(
            period_range[0], period_range[1], amplitude_range[0], amplitude_range[1], amplitude, num)
        np.save(os.path.join(path, file_name), np.array(data, dtype=np.int8))

    def show_signal_data(self):
        # data_path = "./datasets/sin/normal/period_start_1.55_end_2.95_amplitude_start_51.00_end_124.00_each_n_123.npy"
        data_path = "./datasets/ANOMALY DETECTION/square/point_anomaly/period_start_1.55_end_2.95_amplitude_start_51.00_end_124.00_each_n_10.npy"
        datas = np.load(data_path)
        for data in datas:
            plt.plot(range(len(data)), data)
            plt.show()
            plt.close()

    def create_datasets(self, num):
        self.create_normal_sin_datas(num)
        self.create_point_anomaly_sin_datas(num)
        self.create_contextual_anomaly_sin_datas(num)


def load_processed_emulation():
    dataset = DatasetsCreator()
    path = os.path.join(dataset.base_path, "sin")
    class_names = dataset.class_names
    data = []
    label = []
    n_class = []
    for index, name in enumerate(class_names):
        num = 0
        data_path = os.path.join(path, name)
        file_names = os.listdir(data_path)
        file_paths = [os.path.join(data_path, file_name) for file_name in file_names if file_name.endswith('.npy')]
        for file in file_paths:
            one_file_data = np.load(file)
            one_file_label = np.ones(len(one_file_data), dtype=np.int64) * index
            num += len(one_file_data)
            data.extend(one_file_data)
            label.extend(one_file_label)
        n_class.append(num)
    data = np.array(data, dtype=np.float32)
    label = np.array(label, dtype=np.float32)

    return data, label, class_names, n_class


if __name__ == '__main__':
    creator = DatasetsCreator()
    # creator.create_normal_square(2, 51)
    # creator.create_point_anomaly_square(2, 51)
    # creator.create_contextual_anomaly_square(2, 51)
    # creator.create_normal_pulse()
    # creator.create_normal_sin_datas(100)
    # creator.create_point_anomaly_sin_datas(100)
    # creator.create_contextual_anomaly_sin_datas(100)
    # creator.create_datasets(2)
    creator.show_signal_data()
