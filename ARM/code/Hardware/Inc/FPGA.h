#ifndef FPGAREGISTER_H
#define FPGAREGISTER_H

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/ioctl.h>
#include <linux/spi/spidev.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <signal.h>
#include "ADC.h"
#include "Define.h"
#include "usrio.h"
#include "user_gpio.h"
#include "product.h"
#include "Type.h"
#include "product.h"
#include "printf_define.h"
#include "Define.h"
#include "Type.h"

#define AWG_DEV   "/dev/ioIrq"
#define FPGAPrintf usr_printf

#define ADC_MAX 255
#define ADC_MIN 0
#define ADC_MID 128
#define YSCALE_VALUE_RATE 23.6

typedef int fpga_id_t;

// FPGA触发地址
enum eFpgaRegID
{
    //eFRA_indp_setId = 0x000, // 0~3 => ch1~ch3;4:all ch
//    eFRA_sys_rst = 0x002,    // 0~3 => ch1~ch3; 高电平复位采集状态，清楚所有数据

//    eFRA_acq_en = 0x08E, // 高电平使能采集，0：暂停采集。注意：停止采集时同时停止录制波形

    // FPGA外围设备控制寄存器
    eFRA_dac_send_en = 0x004,  // bit[0]高电平有效
    eFRA_dac_send_sel = 0x006, //[3:0]:每个BIT对应相应的通道，高电平有效
    eFRA_dac_send_dataL = 0x008,
    eFRA_dac_send_dataH = 0x00A,
    //eFRA_Output = 0x00C,      //[0] pass/fail, [1] 1:TriggerOutput,
    //eFRA_trg_slope = 0x010, // 触发边沿；0：rise ，1：fall

    //eFRA_trig_force = 0x012,          //[0]强制触发:上升沿有效
    eFRA_adc_send_en = 0x014,  // ADC配置寄存器发送使能，高电平有效
    eFRA_adc_send_sel = 0x016, //[1:0]:ADC选择, 每个BIT选择相应的ADC,高电平有效
    eFRA_adc_send_dataL = 0x018,
    eFRA_adc_send_dataH = 0x01A,
    //eFRA_dvga_send_en = 0x01C,  //[0]   :DVGA寄存器发送使能，高电平有效
    //eFRA_dvga_send_sel = 0x01E, //[3:0]:DVGA选择,每个BIT对应相应的CH,高电平有效
    //eFRA_dvga_send_dataL = 0x020,
    //eFRA_dvga_send_dataH = 0x022,
    eFRA_FPGA_updata_state = 0x0AA,  // FPGA更新寄存器中的值状态
    eFRA_reset_adc_fifo = 0x0AC, // 采样FIFO清除数据标志

//    eFRA_ACQ_CLEAN = 0x160, //

    eFRA_WAVE_FIFO_RESET = 0x162, // 波形FIFO清除数据标志

    //eFRA_BW_100 = 0x166, //
    eFRA_fifo_data = 0x304, //
    eFRA_fifo_full = 0x306, //
//    eFRA_trig_count_H = 0x320, // 频率计数值 1ms的触发数
//    eFRA_trig_count_L = 0x322,
//    eFRA_trig_low_count_H = 0x32a, // 频率计数值 1ms的触发数
//    eFRA_trig_low_count_L = 0x32c,
    eFRA_trig_count_FSL = 0x320, // 频率计数值 1ms的触发数
    eFRA_trig_count_FSH = 0x322,
    eFRA_trig_count_FXL = 0x32a, // 频率计数值 1ms的触发数
    eFRA_trig_count_FXH = 0x32c,
    eFRA_trig_count_flag = 0x332,

    eFRA_trig_mode = 0x170,  // //0:无触发  1:自动触发  2:正常触发
    eFRA_trig_level = 0x172,  // 触发水平
    eFRA_trig_edge = 0x178,  // 触发边沿选择
    eFRA_read_end_flag = 0x176,  // 读取完成标志

    eFRA_time_base_extract = 0x180,  // 时基抽值

    eFRA_wave_max = 0x324, // 最大值
    eFRA_wave_min = 0x326, // 最小值
    eFRA_trig_pos = 0x328, // 触发位置

    eFRA_test = 0x310, // 测试频率寄存器
};
// 触发信息结构体
struct SignalFPGAINFO{
    // 触发
    int trig_mode; //0:无触发  1:自动触发  2:正常触发  3:单次触发
    bool trig_edge;
    ushort trig_level;
    int trig_pos;
    // 信息相关
    ushort min;
    ushort max;
    short vpp;
    float frequency_count;
};

extern SignalFPGAINFO ch4_fpga_info;

int ReadIRQ(bool &bMso, bool &bAwg);

ushort FPGA_ReadW(ushort addr);

void FPGA_CMD_WRITE(fpga_id_t ch, ushort Adata, void *useraddr, int len, bool bEnFiFo, bool bEnDMA);
void FPGA_WriteW(ushort addr, ushort data);
void FPGA_WriteDW(ushort addrL, ushort addrH, uint data);
void FPGA_WriteTW(ushort addrL, ushort addrH, ushort addrT, xindex_t data);
void FPGA_WriteQW(ushort addrL, ushort addrML, ushort addrMH, ushort addrH, ullong data);

void Wave_FIFO_Clean(bool v);
void Wave_FIFO_Start(bool v);

ushort FPGA_FIFO_FULL();

void FPGA_Read_Wave(short *dst_big, short *dst_full, float *dst_small, int len);
short FPGA_Read_Wave (int len);

void FPGA_Set_vector(bool start);

void FPGA_ADC_CAL(void);
void FPGA_ADC_PD(uint ic);

int FpgaConfig(const char *filename);

void Update_FPGA_Trig_Set();
void FPGA_Time_Base_Set(unsigned char time_base_index);
void FPGA_Trig_Set(unsigned char trig_enable, bool trig_edge, ushort trig_level);
void FPGA_Notify_Trigger();
#endif
