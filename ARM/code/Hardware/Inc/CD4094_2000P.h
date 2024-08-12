#pragma once
#include "../../Inc/Type.h"
#include "../../Inc/ui.h"
#include "product.h"
#include "Hardware.h"
#include "fcntl.h"

struct stRelay
{
    unsigned char ctl_lower10:1;
    unsigned char ctl_lower100:1;
    unsigned char ctl_H:1;
    unsigned char ctl_VGA_H:1;             //5mv,10mv,20mv,50mv
    unsigned char ctl_VGA_L:1;             //5mv,10mv,20mv,50mv
    unsigned char :3;
};
//static void HW_SetVideoTrgSrc(int ch);
//static void HW_SetTrgCouplingRelay(uint ch, bool DC, bool LR, bool HR, bool HYS);
//static void HW_SetTrgCoupling(uint ch, int AC);
//static void HW_SetChCoupling(uint ch, int AC);
//static void HW_SetChBandwidth(uint ch, int bw_20MHz);
//static void HW_SetChRelay(uint ch, stRelay att);

void UpdateCmdToCD4094();
void CD4094SendADCInit();
void SendCmdToCD4094();
void OffChDefaultOffset();
float HW_GetPosGain (short yscale);

void SetYscaleAndDAC(uint ch, ushort yScale);
void SetYscale(uint ch, ushort yScale);
void HW_SetChBandwidth(uint ch, int bw_20MHz);
void HW_UpdataChCoupling(uint ch, int AC);
