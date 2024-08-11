# UNIT-2024
该代码仓用于记录2024研电赛作品，作品基于优利德公司提供的开发套件。包含除开程序的成品示波器。因此本次比赛的主要工作是基于已有的硬件系统编写软件程序，如下：
- [FPGA信号处理程序](FPGA/readme.md)
- [ARM显示与交互程序](ARM/readme.md)  

当前文档主要介绍硬件系统的基础，包括：
- [系统结构](#系统结构)  
- [通道与控制](#通道与控制)  
    - [模拟通道](#模拟通道)  
    - [外触发通道](#外触发通道)  
    - [通道控制](#通道控制)  

<img src=pics\作品外观图.jpg alt="作品外观" style="display: block; margin: 0 auto; width: 90%">

## 系统结构
套件包含四个模拟通道，经过两片8位[ADC](docs\MXT2001_datasheet.pdf)进行采样，再进入FPGA处理。FPGA处理后通过16位总线发给[ARM](docs\am5708.pdf)进行显示。

<img src=pics\MSO2000方框图.jpg alt="MSO2000系统方框图" style="display: block; margin: 0 auto;">

## 通道与控制
### 模拟通道 
模拟通道用于对外部输入信号进行预处理，使输入信号处于8位ADC的采样范围内。 

<img src=pics\模拟通道结构.png alt="模拟通道结构" style="display: block; margin: 0 auto;">  

- BNC连接器：示波器接口。
- 交直耦合：交流耦合状态滤除直流分量。
- 偏置：前级偏置、末级偏置共同影响系统叠加在信号上的直流分量。前级偏置对信号影响较大，末级偏置影响较小。
- 衰减和放大：两者共同影响信号幅度的缩放。
- 20M带宽限制：通过硬件限制高频噪声。 

### 外触发通道

<img src=pics\外部触发通道.png alt="外部触发通道" style="display: block; margin: 0 auto;">  

- BNC连接器：示波器接口。

### 通道控制
偏置通过调整DAC输出控制，其他通过[CD4094](docs\CD4094.pdf)寄存器进行控制。

<img src=pics\DAC电路原理图.png alt="DAC电路原理图" style="display: block; margin: 0 auto;">  

图上为3片DAC的接线图，3片DAC共同完成对4个通道的偏置调整。单个通道的偏置由前级偏置和后级偏置组成，前级偏置包含粗调、细调和REF。

<img src=pics\偏置电路.png alt="偏置电路" style="display: block; margin: 0 auto;">  

图上V_C为粗调，V_X为细调。

<img src=pics\CD4094电路原理图.png alt="CD4094电路原理图" style="display: block; margin: 0 auto;">  

图上为5片CD4094完成对通道的其他参数控制。芯片输入包含片选、时钟和数据。  
**所有控制均为高电平有效**  

- EXT_HF：外触发的高频抑制。
- EXT_2bits：触发信源选择。“01”表示触发信源选择EXT，“10”表示触发信源选择为市电(AC_Line)。
- EXT_Noise：外触发的噪声抑制。
- EXT_LF：外触发的低频抑制。
- EXT_ACDC：外触发的交直流耦合，H表示DC耦合，L表示AC耦合。
- EXT/5：外触发的低频抑制。
- CH_2bits：通道VGA档位控制。
- CH_BW_20MHz：通道20MHz带宽限制控制。
- CH_H：通道前级放大倍数控制, H表示选择10倍放大, L表示选择2倍放大。
- CH/10：通道10倍衰减控制，H时10倍衰减，L时为直通。
- CH/100：通道100倍衰减控制，H时100倍衰减，L时为直通。
- CH_ACDC：通道的直流耦合打开，H表示DC耦合，L表示AC耦合。  

通道幅格档位控制如下表。  

<div align="center">

|档位|CH/10|CH/100|CH_H|CH_2bits_H|CH_2bits_L|DEC|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|1mV/div|0|0|1|0|0|4|
|2mV/div|0|0|1|0|1|5|
|5mV/div|0|0|0|0|0|0|
|10mV/div|0|0|0|0|1|1|
|20mV/div|0|0|0|1|0|2|
|50mV/div|0|0|0|1|1|3|
|100mV/div|1|0|0|0|1|17|
|200mV/div|1|0|0|1|0|18|
|500mV/div|1|0|0|1|1|19|
|1V/div|0|1|0|0|1|9|
|2V/div|0|1|0|1|0|10|
|5V/div|0|1|0|1|1|11|
|10V/div|1|1|0|0|1|25|
|20V/div|1|1|0|1|0|26|

</div>
