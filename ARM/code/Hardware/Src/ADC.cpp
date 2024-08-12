#include <Inc/Define.h>
#include <Inc/Type.h>
#include "FPGA.h"
#include "HW_Channel.h"
#include "Hardware.h"
#include "PLL.h"
#include "product.h"

/**************************************************************************************/
///																						///
///                                     ADC UPDATE ///
///																						///
/**************************************************************************************/

void HW_ADC_Write(ushort Addr, ushort Data) {
  // return;
  FPGA_WriteW(eFRA_adc_send_dataH, Addr | (0x0010));
  FPGA_WriteW(eFRA_adc_send_dataL, Data);
  FPGA_WriteW(eFRA_adc_send_en, 0);
  FPGA_WriteW(eFRA_adc_send_en, 1);

  uSleep(100);
}

void HW_ADC_WriteCmd(int ic, ushort Addr, ushort Data) {
  FPGA_WriteW(eFRA_adc_send_sel, 1 << ic);
  HW_ADC_Write(Addr, Data);
}

void HW_ADC_WriteMerga(uint ch, ushort merga) {
  int ic = ch >> 1;
  if (merga) {
    // 拼合模式：双边沿采样，禁用自动时钟相位控制功能
    HW_ADC_WriteCmd(ic, 0x1, 0xbaff);
    HW_ADC_WriteCmd(ic, 0xd, 0xbfff);

    if ((ch & 0x01) == 0) {
      HW_ADC_WriteCmd(ic, 0xe, 0xc7ff);
    } else {
      HW_ADC_WriteCmd(ic, 0xe, 0x07ff);
    }
    // 拼合模式：双边沿采样，启用自动时钟相位控制功能
    HW_ADC_WriteCmd(ic, 0xd, 0xffff);
  } else {
    // 拼合模式：双边沿采样，启用自动时钟相位控制功能
    HW_ADC_WriteCmd(ic, 0x1, 0xbaff);
    HW_ADC_WriteCmd(ic, 0xd, 0x7fff);
    HW_ADC_WriteCmd(ic, 0xd, 0x3fff);
  }
}

void HW_ADC_WriteGain(uint ch, ushort Data) {
  FPGA_WriteW(eFRA_adc_send_sel, 1 << (ch >> 1));
  HW_ADC_Write((ch & 0x01) == 0 ? 0xb : 0x3, ((Data << 7) | 0x007f));
}

void HW_WriteADC_Gian(uint ch, short Data) {
  Data += 256;
  LIMIT(Data, 0, 511);
  HW_ADC_WriteGain(ch, Data);
}

void HW_InitOneADC(int ic) {
  FPGA_WriteW(eFRA_adc_send_sel, 1 << ic);

  HW_ADC_Write(0x2, 0x007f); // CHI 偏置校正
  HW_ADC_Write(0xa, 0x007f); // CHQ 偏置校正

  // DDR等系统配置, 启用占空比稳定电路，双时钟0相位，单通道，标准幅度，上升沿
  HW_ADC_Write(0x1, 0xb6ff);
  HW_ADC_Write(0xd, 0x7fff); // DES使能,双通道同时采样
  HW_ADC_Write(0xe, 0x07ff); // DES粗调
  HW_ADC_Write(0x3, 0x807f); // CHI增益校正
  HW_ADC_Write(0xb, 0x807f); // CHQ增益校正
  HW_ADC_Write(0xf, 0x007f);

  // FPGA_WriteW(ADC_DDRB, 0);
  uSleep(100);
}

void ADF4360_Write(unsigned long data) {
    // 开启DAC发送
    FPGA_WriteW(eFRA_dac_send_en, 0x00);
    FPGA_WriteW(eFRA_dac_send_dataL, (ushort)(data & 0xFFFF));
    FPGA_WriteW(eFRA_dac_send_dataH, (ushort)(data >> 16));
    uSleep(1);
    FPGA_WriteW(eFRA_dac_send_sel, 1 << 3);
    uSleep(1);
    FPGA_WriteW(eFRA_dac_send_en, 0x01);
    uSleep(50);
    FPGA_WriteW(eFRA_dac_send_sel, 0);
}

void HW_InitADC_Config() {
  usr_printf("[UI]%s\n", __FUNCTION__);
#if 0
	    ADF4360_Write ( 0x3007D1 ); //r
#else
  ADF4360_Write(0x3000C9); // r
#endif
  ADF4360_Write(0x4FF120); // ADF4360_Write ( 0x4FF128 ); //c
  uSleep(20000);
  ADF4360_Write(0x013822); // n,1G
}

void ADC_Reaset() {
  // ADC reaset
  usr_printf("[UI]%s\n", __FUNCTION__);
  FPGA_WriteW(eFRA_adc_send_sel, 0);

  HW_ADC_Reset(1);
  HW_ADC_Reset(0);
}

void HW_ADC_Init(void) {
  printf("[UI]------adc init------\n");
  // 配置采样率
  HW_InitADC_Config();
  uSleep(10000);
  // 分别配置两个双通道ADC
  for(int iAdc = 0; iAdc < 2; iAdc++) // PHY_CH_COUNT/2
  {
    HW_InitOneADC(iAdc);
    HW_ADC_WriteMerga(iAdc, false);
  }
  ADC_Reaset();
}
