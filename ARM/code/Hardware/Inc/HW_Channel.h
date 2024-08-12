#pragma once
#include "product.h"
#if PRODUCT == MSO_2KP
#include "FPGA.h"

void YSys_Set_DVGA_Gain (uint ch, int yleve );
uint FPGA_CMD_READ ( fpga_id_t ch, ushort Adata, void* useraddr, int len, bool bEnFiFo, bool bEnDMA);
void FPGA_CMD_WRITE ( fpga_id_t ch, ushort Adata, void* useraddr, int len, bool bEnFiFo, bool bEnDMA);
void InitIRQ ( void ( *__KeyIRQ ) ( int ) );
void InitIRQAwg ( void ( *__KeyIRQ ) ( int ) );
extern void OpenFPGA();
extern int HW_DVGA_YCLE_Gain(uint yleve);
#endif
