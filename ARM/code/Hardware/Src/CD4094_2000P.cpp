#include "CD4094_2000P.h"

/**************************************************************************************/
///																						///
///                                    串行移位寄存器                                   ///
///																						///
/**************************************************************************************/
union CD4094bits
{
	unsigned long long All;
	struct
	{
		unsigned long long Trig_Video : 2;	  // 视频触发通道选择
		unsigned long long Trig_ExtSel : 2;	  // 后置
		unsigned long long EXT_TRIG_HYS : 1;  // 高频抑制，0:使能
		unsigned long long EXT_TRIG_LF : 1;	  // 触发灵敏度调节
		unsigned long long EXT_TRIG_ADDC : 1; // 低频抑制，0:使能
		unsigned long long EXT_Lower : 1;	  // 外触发除5

		unsigned long long ch1_opt_en : 1;
		unsigned long long ch1_VGA_H : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch1_VGA_L : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch1_bw_20MHz : 1;	 // 20M带宽
		unsigned long long ch1_ctl_H : 1;		 // 前级放大
		unsigned long long ch1_ctl_lower100 : 1; // 100倍衰减
		unsigned long long ch1_ctl_lower10 : 1;	 // 10倍衰减
		unsigned long long CH1_AC_DC : 1;		 // 交直耦合

		unsigned long long ch2_opt_en : 1;
		unsigned long long ch2_ctl_A1 : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch2_ctl_A0 : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch2_bw_20MHz : 1;	 //
		unsigned long long ch2_ctl_5mv : 1;		 //
		unsigned long long ch2_ctl_lower100 : 1; //
		unsigned long long ch2_ctl_lower10 : 1;	 //
		unsigned long long CH2_AC_DC : 1;		 //

		unsigned long long ch3_opt_en : 1;
		unsigned long long ch3_ctl_A1 : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch3_ctl_A0 : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch3_bw_20MHz : 1;	 //
		unsigned long long ch3_ctl_5mv : 1;		 //
		unsigned long long ch3_ctl_lower100 : 1; //
		unsigned long long ch3_ctl_lower10 : 1;	 //
		unsigned long long CH3_AC_DC : 1;		 //

		unsigned long long ch4_opt_en : 1;
		unsigned long long ch4_ctl_A1 : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch4_ctl_A0 : 1;		 // 5mv,10mv,20mv,50mv
		unsigned long long ch4_bw_20MHz : 1;	 //
		unsigned long long ch4_ctl_5mv : 1;		 //
		unsigned long long ch4_ctl_lower100 : 1; //
		unsigned long long ch4_ctl_lower10 : 1;	 //
		unsigned long long CH4_AC_DC : 1;		 //

		unsigned long long CH1_TRIG_HF : 1;	 // 高频抑制，0:使能
		unsigned long long CH1_TRIG_HYS : 1; // 触发灵敏度调节
		unsigned long long CH1_TRIG_LF : 1;	 // 低频抑制，0:使能
		unsigned long long CH1_TRIG_AC_DC : 1;
		unsigned long long CH2_TRIG_HF : 1;
		unsigned long long CH2_TRIG_AC_DC : 1;
		unsigned long long CH2_TRIG_LF : 1;
		unsigned long long CH2_TRIG_HYS : 1;

		unsigned long long CH3_TRIG_HF : 1;
		unsigned long long CH3_TRIG_HYS : 1;
		unsigned long long CH3_TRIG_LF : 1;
		unsigned long long CH3_TRIG_AC_DC : 1;
		unsigned long long CH4_TRIG_HF : 1;
		unsigned long long CH4_TRIG_AC_DC : 1;
		unsigned long long CH4_TRIG_LF : 1;
		unsigned long long CH4_TRIG_HYS : 1;
	};
};

CD4094bits CD4094Reg = {0};

static const stRelay Relay[YPHY_LEV_TOTAL] =
    {
        {0, 0, 1, 0, 0}, //  1mv
        {0, 0, 1, 0, 1}, //  2mv
        {0, 0, 0, 0, 0}, //  5mv
        {0, 0, 0, 0, 1}, //  10mv
        {0, 0, 0, 1, 0}, //  20mv
        {0, 0, 0, 1, 1}, //  50mv
        {1, 0, 0, 0, 1}, //  100mv
        {1, 0, 0, 1, 0}, //  200mv
        {1, 0, 0, 1, 1}, //  500mvs
        {0, 1, 0, 0, 1}, //  1v
        {0, 1, 0, 1, 0}, //  2v
        {0, 1, 0, 1, 1}, //  5v
        {1, 1, 0, 0, 1}, //  10v
        {1, 1, 0, 1, 0}, //  20v
};

void OffChDefaultOffset()
{
	// CD4094Reg.CH_UP= 0;
}

static void HW_SetVideoTrgSrc(int ch)
{
	CD4094Reg.Trig_ExtSel = 0;
	switch (ch)
	{
	case eTG_SRC_EXT:
		CD4094Reg.Trig_ExtSel = 2;
		CD4094Reg.EXT_Lower = 0;
		break;
	case eTG_SRC_EXT5:
		CD4094Reg.Trig_ExtSel = 2;
		CD4094Reg.EXT_Lower = 1;
		break;
	case eTG_SRC_AC:
		CD4094Reg.Trig_ExtSel = 1;
		break;
	default:
		break;
	}
	
}

void HW_SetSlopeHYS(int v)
{
	// CD4094Reg.Trig_Slope_HYS = v;
}

static void HW_SetTrgCouplingRelay(uint ch, bool DC, bool LR, bool HR, bool HYS)
{
	switch (ch)
	{
	case eTG_SRC_CH2:
		// ErroPrintf("====================CH2_TRIG_AC_DC = %d\n",DC);
		CD4094Reg.CH2_TRIG_AC_DC = DC;
		CD4094Reg.CH2_TRIG_LF = LR;
		CD4094Reg.CH2_TRIG_HF = HR;
		CD4094Reg.CH2_TRIG_HYS = HYS;
		break;
	case eTG_SRC_CH3:
		// ErroPrintf("====================CH3_TRIG_AC_DC = %d\n",DC);
		CD4094Reg.CH3_TRIG_AC_DC = DC;
		CD4094Reg.CH3_TRIG_LF = LR;
		CD4094Reg.CH3_TRIG_HF = HR;
		CD4094Reg.CH3_TRIG_HYS = HYS;
		break;
	case eTG_SRC_CH4:
		// ErroPrintf("====================CH4_TRIG_AC_DC = %d\n",DC);
		CD4094Reg.CH4_TRIG_AC_DC = DC;
		CD4094Reg.CH4_TRIG_LF = LR;
		CD4094Reg.CH4_TRIG_HF = HR;
		CD4094Reg.CH4_TRIG_HYS = HYS;
		break;
	case eTG_SRC_CH1:
		// ErroPrintf("====================CH1_TRIG_AC_DC = %d\n",DC);
		CD4094Reg.CH1_TRIG_AC_DC = DC;
		CD4094Reg.CH1_TRIG_LF = LR;
		CD4094Reg.CH1_TRIG_HF = HR;
		CD4094Reg.CH1_TRIG_HYS = HYS;
		break;
	default:
		// ErroPrintf("====================EXT_TRIG_AC_DC = %d\n",DC);
		CD4094Reg.EXT_TRIG_ADDC = DC;
		CD4094Reg.EXT_TRIG_LF = LR;
		CD4094Reg.Trig_Video = HR ? 0x02 : 0x00;
		CD4094Reg.EXT_TRIG_HYS = HYS;
		break;
	}
}

static void HW_SetTrgCoupling(uint ch, int AC)
{
	bool DC = 0, LR = 0, HR = 0, HYS = 0;

	// ErroPrintf("ch%d= %d\n",ch+1,AC);
	switch (AC)
	{
	case SS_TRIG_COUPLING_DC:
		DC = 1;
		LR = 0;
		HR = 0;
		HYS = 0;
		break;
	case SS_TRIG_COUPLING_AC:
		DC = 0;
		LR = 0;
		HR = 0;
		HYS = 0;
		break;
	case SS_TRIG_COUPLING_LFR:
		DC = 0;
		LR = 1;
		HR = 0;
		HYS = 0;
		break;
	case SS_TRIG_COUPLING_HFR:
		DC = 1;
		LR = 0;
		HR = 1;
		HYS = 0;
		break;
	case SS_TRIG_COUPLING_NOISER:
		DC = 1;
		LR = 0;
		HR = 0;
		HYS = 1;
		break;
	default:
		break;
	}

	HW_SetTrgCouplingRelay(ch, DC, !LR, HR, !HYS);
}

static void HW_SetChCoupling(uint ch, int AC)
{
	switch (ch)
	{
	case ID_CH1:
		CD4094Reg.CH1_AC_DC = !AC;
		break;
	case ID_CH2:
		CD4094Reg.CH2_AC_DC = !AC;
		break;
	case ID_CH3:
		CD4094Reg.CH3_AC_DC = !AC;
		break;
	case ID_CH4:
		CD4094Reg.CH4_AC_DC = !AC;
		break;
	default:
		break;
	}
}

static void HW_ChBandwidth(uint ch, int bw_20MHz)
{
	switch (ch)
	{
	case ID_CH1:
		CD4094Reg.ch1_bw_20MHz = bw_20MHz;
		break;
	case ID_CH2:
		CD4094Reg.ch2_bw_20MHz = bw_20MHz;
		break;
	case ID_CH3:
		CD4094Reg.ch3_bw_20MHz = bw_20MHz;
		break;
	case ID_CH4:
		CD4094Reg.ch4_bw_20MHz = bw_20MHz;
		break;
	default:
		break;
	}
}

float HW_GetPosGain(short yScale)
{
	float gain = 0.72f;

	if (yScale < YLEV_MIN || yScale > YLEV_PHY_MAX)
		return gain;

	LIMIT(yScale, 0, element(Relay));

	stRelay att = Relay[yScale];
	if (att.ctl_H)
	{
		gain *= 5.0f;
	}
	if (att.ctl_VGA_L && att.ctl_VGA_H)
	{
		gain *= 1.0f;
	}
	else if (!att.ctl_VGA_L && att.ctl_VGA_H)
	{
		gain *= 2.5f;
	}
	else if (att.ctl_VGA_L && !att.ctl_VGA_H)
	{
		gain *= 5.0f;
	}
	else // 5mv
	{
		gain *= 10.0f;
	}
	return gain;
}

static void HW_SetChRelay(uint ch, stRelay att)
{
	// ErroPrintf("ch%d Relay = %d\n",ch,X20X320);
	switch (ch)
	{
        case ID_CH1:
            CD4094Reg.ch1_VGA_L = att.ctl_VGA_L;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch1_VGA_H = att.ctl_VGA_H;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch1_ctl_H = att.ctl_H; //
            CD4094Reg.ch1_ctl_lower10 = att.ctl_lower10;
            CD4094Reg.ch1_ctl_lower100 = att.ctl_lower100;
            break;
        case ID_CH2:
            CD4094Reg.ch2_ctl_A0 = att.ctl_VGA_L;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch2_ctl_A1 = att.ctl_VGA_H;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch2_ctl_5mv = att.ctl_H; //
            CD4094Reg.ch2_ctl_lower10 = att.ctl_lower10;
            CD4094Reg.ch2_ctl_lower100 = att.ctl_lower100;
            break;
        case ID_CH3:
            CD4094Reg.ch3_ctl_A0 = att.ctl_VGA_L;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch3_ctl_A1 = att.ctl_VGA_H;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch3_ctl_5mv = att.ctl_H; //
            CD4094Reg.ch3_ctl_lower10 = att.ctl_lower10;
            CD4094Reg.ch3_ctl_lower100 = att.ctl_lower100;
            break;
        case ID_CH4:
            CD4094Reg.ch4_ctl_A0 = att.ctl_VGA_L;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch4_ctl_A1 = att.ctl_VGA_H;	 // 5mv,10mv,20mv,50mv
            CD4094Reg.ch4_ctl_5mv = att.ctl_H; //
            CD4094Reg.ch4_ctl_lower10 = att.ctl_lower10;
            CD4094Reg.ch4_ctl_lower100 = att.ctl_lower100;
            break;
        default:
            break;
	}

}

void UpdateCmdToCD4094()
{
	HW_SetVideoTrgSrc(eTG_SRC_CH1);
	HW_SetTrgCoupling(eTG_SRC_CH1, SS_TRIG_COUPLING_DC);

	CD4094Reg.ch1_opt_en = 1;
	CD4094Reg.ch2_opt_en = 0;
	CD4094Reg.ch3_opt_en = 0;
	CD4094Reg.ch4_opt_en = 0;

	for (uint ch = ID_CH1; ch <= ID_CH4; ch++)
	{
		HW_SetTrgCoupling(ch, SS_TRIG_COUPLING_DC);
		HW_SetChCoupling(ch, true);

		HW_ChBandwidth(ch, false);

		ch4_ui.yscale = YLEV50MV;
        LIMIT(ch4_ui.yscale, YLEV_MIN, YLEV_MAX);
        HW_SetChRelay(ch, Relay[ch4_ui.yscale]);
	}
	SendCmdToCD4094();
}

void CD4094SendADCInit()
{
    printf("[UI]------CD4094 init------\n");
	uint src = eTG_SRC_CH4;
	HW_SetVideoTrgSrc(src);
	CD4094Reg.ch1_opt_en = 0;
	CD4094Reg.ch2_opt_en = 0;
	CD4094Reg.ch3_opt_en = 0;
	CD4094Reg.ch4_opt_en = 1;
	for (uint ch = ID_CH1; ch <= ID_CH4; ch++)
	{
		HW_SetTrgCoupling(ch, SS_TRIG_COUPLING_DC);
		// 交直耦合
		HW_SetChCoupling(ch, ePC_DC);
		// 20M带宽限制
		HW_ChBandwidth(ch, SS_CHL_BW_FULL);
		ch4_ui.yscale = YLEV50MV;
        LIMIT(ch4_ui.yscale, YLEV_MIN, YLEV_MAX);
        HW_SetChRelay(ch, Relay[ch4_ui.yscale]);
	}
	SendCmdToCD4094();
}

void SendCmdToCD4094()
{
	static unsigned long long CD4094Code = 0;
	if (CD4094Code != CD4094Reg.All)
	{
		CD4094Code = CD4094Reg.All;
		int pf = open("/dev/cd4094", O_RDWR);
		if (pf >= 0)
		{
			write(pf, &CD4094Reg.All, 7);
//			printf("Success of %s\n", __FUNCTION__);
			close(pf);
			// 等待继电器稳定
			mSleep(30);
		}
		else
		{
		    printf("Error of %s\n", __FUNCTION__);
		}
	}
}

void SetYscaleAndDAC(uint ch, ushort yScale){
    HW_SetChRelay(ch, Relay[yScale]);
    HW_SetDAC_After_Scale_Set(yScale);
    SendCmdToCD4094();
//    printf("Success set yscale %s\n", eYScale_names[yScale]);
}

void SetYscale(uint ch, ushort yScale){
    HW_SetChRelay(ch, Relay[yScale]);
    HW_SetDAC_After_Scale_Set(yScale);
    SendCmdToCD4094();
    printf("Success set yscale %s\n", eYScale_names[yScale]);
}

void HW_SetChBandwidth(uint ch, int bw_20MHz){
    bw_20MHz = LIMIT(bw_20MHz, 0, 1);
    if(bw_20MHz != ch4_ui.bandwidth_20M){
        ch4_ui.bandwidth_20M = bw_20MHz;
        HW_ChBandwidth(ch, ch4_ui.bandwidth_20M);
        SendCmdToCD4094();
    }
}

void HW_UpdataChCoupling(uint ch, int AC){
    AC = LIMIT(AC, 0, 1);
    if(AC != ch4_ui.coupling_mode){
        ch4_ui.coupling_mode = AC;
        HW_SetChCoupling(ch, ch4_ui.coupling_mode);
        SendCmdToCD4094();
    }
}
