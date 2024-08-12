#pragma once
#include "product.h"
#include "Type.h"

#define DAC_DONE_MS 10

#define DAC_PRE_FIN (15.0/(499+15.0))
#define DAC_POS_FIN 1
#define DAC_TRG_FIN 1

#define DAC_MAX_PRE  4095
#define DAC_MAX_POST 4095
#define DAC_MAX_TRIG 4095

#define DAC_MID 2048
#define DAC_MAX 4095

#define DAC_DEFALUT 2000

#define DAC_CH1_VREF_INIT 2048
#define DAC_CH4_VREF_INIT 2064
#define DAC_CH1_PRE_BIAS_INIT 1900
#define DAC_CH4_PRE_BIAS_INIT 1900
#define DAC_CH1_END_BIAS_INIT 1250
#define DAC_CH4_END_BIAS_INIT 1250

typedef void (*hDAC_Write) ( ushort Port, uint Data );
typedef void (*hDAC_Init) ( void );

struct DAC_BIAS{
    uint ch1_ref;
    uint ch2_ref;
    uint ch3_ref;
    uint ch4_ref;
    double ch1_pre_bias;
    double ch2_pre_bias;
    double ch3_pre_bias;
    double ch4_pre_bias;
    uint ch1_end_bias;
    uint ch2_end_bias;
    uint ch3_end_bias;
    uint ch4_end_bias;
};
extern DAC_BIAS dac_bias;

void HW_InitDAC_LTC2620(void);
void HW_WriteDAC_LTC2620(ushort Port, uint Data);

void HW_SetDAC_PreFine(ushort ch, uint Data);  // 前置粗调
void HW_SetDAC_PreCoarse(ushort ch, uint Data);  // 前置细调

void HW_SetDAC_REF (uint ch, double Data);
void HW_SetDAC_PreBias(uint ch, double Data);
void HW_SetDAC_EndBias(uint ch, double Data);
void HW_SetDAC_After_Scale_Set(ushort yScale);
void HW_SetDAC_EndBias_updata(ushort yScale, uint Data);

void HW_SetDAC_TrgBias(uint ch, double Data);
void HW_SetDAC_SlopeTrgBias(uint ch, double Data);
void HW_SetDAC_SlopeTrgBias(uint ch, double Data);
void Trg_SetHardwareHYS (uint ch, int ySCALE, int Coupling );
void HW_WaitDACDone (void);

