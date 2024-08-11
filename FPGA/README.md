# FPGA
FPGA主要完成对ADC采样信号的预处理和分析。在开启时，ARM会完成对FPGA的配置，再经由FPGA，完成对ADC、DAC和PLL的初始化配置。  
- [基本结构](#基本结构)
- [信号流程](#信号流程)
- [模块流程](#模块流程)
- [功能实现](#功能实现)
    - [频率测量](#频率测量)
    - [预触发](#预触发)
    - [抽值](#抽值)
## 基本结构
一般流程是通过采样时钟采集数据写入FIFO，在通过系统时钟对FIFO中的数据做其他处理。处理后结果传给ARM。  

<img src=pics\FPGA基本框图.png alt="FPGA基本框图" style="display: block; margin: 0 auto; width: 80%">  

## 信号流程
上电后，ARM和FPGA进行通信，先进行ADC，PLL等配置。配置完成后，ADC对模拟信号进行采样送入到FPGA内部进行接收处理。处理完成后，ARM通过GPMC总线控制FPGA对FIFO进行读写，FIFO读出来的波形数据再通过GPMC总线传给ARM进行显示。

<img src=pics\信号流程.png alt="信号流程" style="display: block; margin: 0 auto; width: 80%"> 

## 模块流程

<img src=pics\模块流程.png alt="模块流程" style="display: block; margin: 0 auto; width: 80%">   

- `clk_manager`是时钟管理模块，整个系统所用到的时钟都是由这个模块产生。  
- `cpu_databus_mg`是GPMC总线模块，将数据通过GPMC总线发送给ARM,或从ARM通过GPMC总线接收数据。  
- `dsp_cmd_wr`模块是接收ARM发给FPGA的数据和配置等信息。  
- `dsp_cmd_rd`模块是FPGA发给 ARM的数据和配置等信息。  
- `adc_data_stream`模块是对adc采集到的波形数据进行处理接收。  
- `peripheral_ctrl`模块是对adc，pll等外围设备进行进行配置。

## 功能实现
### 频率测量
频率测量前先通过施密特整形将输入信号控制输出为方波信号，再进行测量，测量方法基于等进度测量方法进行改进。  

<img src=pics\等精度测量方法.png alt="等精度测量方法" style="display: block; margin: 0 auto; width: 80%"> 

`传统方法`流程如下：  
- 设置一个预定义闸门信号，开启时间T为可调节。
- 当预置闸门信号变为高电平时，等待待测信号上升沿的到达。当上升沿首次到达后，计数器开始计数，并产生计数闸门;当预置闸门信号变为低电平时，首个待测信号的上升沿变为低电平，此时计数闸门关闭，测量计数器停止计数，其计数值即为待测信号周期数$n_x$。
- 当计数闸门再次开启后，计数器等待高频时钟上升沿的到达。当第一个基准时钟上升沿到达时，开始计数;当计数闸门关闭后的第一个上升沿时到达时，结束计数，得到基准信号周期数$n_r$。  

由此可知，等精度测频法可消除计数闸门与待测信号的相位量化误差，即将该误差转化为更低数量级的高频时钟与计数闸门之间的相位误差。待测信号周期$T_x$的关系式为:
$$T_x=\frac{T}{n_x}$$
计数闸门信号维持高电平的时间T应满足$T=n_r \cdot T_r$，因此，被测信号频率为:
$$f_x=\frac{n_x}{n_r \cdot T_r}$$
式中，$T_r$为高频时钟信号的周期。由于计数闸门信号与高频时钟信号存在随机的相位差，因此，计数闸门的实际开启时间$T_1$为：
$$T_1=n_r \cdot T_r - \Delta t_2 + \Delta t_1$$
根据上式，可得出实际待测信号的频率为：
$$f_{x1} = \frac{n_x}{n_r \cdot T_r - \Delta t_2 + \Delta t_1}$$
相对误差为：
$$\frac{\Delta f}{f_{x1}}=\frac{|\Delta t_2+\Delta t_1|}{n_r \cdot T_r}$$
$n_r \cdot T_r$由计数闸门决定。由于计数闸门固定，因此，基准时钟频率越高，相对误差越小。同时，由于等精度测频法的计数闸门由待测信号产生，消除了±1待测信号周期计数误差，因此，频率测量误差最终来源于±1个高频时钟信号周期的计数误差。  

`传统方法的问题`是当低频信号（Hz级别）进行测量时，输入信号被测周期数太大会导致测量时间过长，单纯减小被测周期数又会导致高频精度不够。

`解决方案`是通过预测频的方式估计频率范围，再根据预估值设定计数闸门后二次测频得到准确的频率值。

<img src=pics\等精度测量方法改进思路.jpg alt="等精度测量方法改进思路" style="display: block; margin: 0 auto;width: 50%"> 

### 预触发
触发的目的是捕捉目标触发事件，将触发事件作为稳定显示待测信号波形的同步参考点。而预触发功能使示波器在触发事件发生之前就开始采集数据，捕获引发触发事件的前后信息。  

<img src=pics\预触发.jpg alt="预触发" style="display: block; margin: 0 auto; width: 80%">   

`实现方法`是通过基于两级FIFO对采集数据进行缓存。ADC采集到的数据先输入TRIG_FIFO进行预触发缓存，再由TRIG_FIFO输出到WAVE_FIFO，两个FIFO的读写逻辑由一个单独的读写控制模块FIFO_Control控制。

<img src=pics\两级FIFO.png alt="两级FIFO" style="display: block; margin: 0 auto; width: 80%"> 

假设初始数据点为下图中的A点，状态机处于IDLE状态。当触发未使能时，TRIG_FIFO一直处于边读边写的状态，WAVA_FIFO的写使能拉高，WAVE_FIFO写满时ARM从WAVE_FIFO中读取一次波形。

<img src=pics\预触发原理.jpg alt="预触发原理" style="display: block; margin: 0 auto; width: 80%"> 

进入触发状态后，状态机从IDLE跳转到RST_DELAY状态，此状态复位两个FIFO，避免WAVE_FIFO中的残留数据影响下一帧波形数据的读写。复位完成后，进入PRE_TRIG状态，此时TRIG_FIFO的写使能拉高，读使能拉低，直到TRIG_FIFO的预触发深度达到B点，TRIG_FIFO开始同步读取数据，保持数据量在预触发深度，状态机进入WAIT_TRIG等待触发状态。  
当触发信号到来时，状态机进入WAVE_FIFO_RST状态，清空WAVE_FIFO，同时继续向TRIG_FIFO写数据，打开WAVE_FIFO写使能和TRIG_FIFO读使能，直到WAVE_FIFO写满，状态机进入POST_TRIG状态。在此状态下，FPGA向ARM发送FULL信号，ARM接收到信号后，通过总线读取WAVE_FIFO中的数据，状态机处于WAIT_RD_DONE状态。读取预定长度数据后，ARM返回RD_DONE信号，完成一次读波形操作，状态机重新回到IDLE状态。

### 抽值
抽值方法为等距抽值。由于通过双边沿采样和两路数据交织方式提升了采样率，每个时钟周期内将产生4路并行波形数据，因此要实现等距抽值须FPGA与ARM共同配合。在采样率为1GHz时，相邻点的时间间隔为1ns，选用50个点组成一个时基格，则基准时基格为50ns。 

<div align="center">

|时基档位|插值倍数|硬件抽值倍数|软件抽值倍数|
|:-:|:-:|:-:|:-:|
|2ns|25|-|-|
|5ns|10|-|-|
|10ns|5|-|-|
|20ns|5|-|2|
|50ns|-|-|-|
|100ns|-|-|2|
|200ns|-|-|4|
|500ns|-|2.5|4|
|1us|-|5|4|
|2us|-|10|4|
|5us|-|25|4|
|10us|-|50|4|
|20us|-|100|4|
|50us|-|250|4|
|100us|-|500|4|
|200us|-|1000|4|
|500us|-|2500|4|
|1ms|-|5000|4|
|2ms|-|10000|4|
|5ms|-|25000|4|
|10ms|-|50000|4|
|20ms|-|100000|4|
|50ms|-|250000|4|

</div>