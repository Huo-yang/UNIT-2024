#include <Inc/Define.h>
#include <Inc/Define.h>
#include "product.h"
#include "product.h"
#include "DAC.h"
#include "FPGA.h"

#include "CD4094.h"
#include "Hardware.h"

enum eDACV02_Port
{
    eDACV02_CH1_Pre_X = 0,  //细调
    eDACV02_CH1_Pre_C,      //粗调
    eDACV02_CH1_REF,        //前级静态参考电压（2048）
    eDACV02_CH1_Base,       //后级偏置

    eDACV02_CH2_Base,
    eDACV02_CH2_Pre_C,
    eDACV02_CH2_Pre_X,
    eDACV02_CH2_REF,        //后级偏置

    eDACV02_CH3_Pre_X = 8,  //细调
    eDACV02_CH3_Pre_C,      //粗调
    eDACV02_CH3_REF,        //触发
    eDACV02_CH3_Base,       //后级偏置

    eDACV02_CH4_Base,
    eDACV02_CH4_Pre_C,
    eDACV02_CH4_Pre_X,
    eDACV02_CH4_REF,        //后级偏置

    eDACV02_ch4_Trig_HYS = 16,
    eDACV02_ch3_Trig_HYS,
    eDACV02_ch2_Trig_HYS,
    eDACV02_ch1_Trig_HYS,
    eDACV02_EXT = 20,
    eDACV02_CMP_LA2,
    eDACV02_CMP_LA1,
    eDACV02_REF_LA,

    eDACV02_MAX,
};

DAC_BIAS dac_bias = {
                     .ch1_ref = DAC_CH1_VREF_INIT,
                     .ch2_ref = DAC_MID,
                     .ch3_ref = DAC_MID,
                     .ch4_ref = DAC_CH4_VREF_INIT,
                     .ch1_pre_bias = DAC_CH1_PRE_BIAS_INIT,
                     .ch4_pre_bias = DAC_CH4_PRE_BIAS_INIT,
                     .ch1_end_bias = DAC_CH1_END_BIAS_INIT,
                     .ch2_end_bias = 1255,
                     .ch3_end_bias = 1255,
                     .ch4_end_bias = DAC_CH4_END_BIAS_INIT,
};

DAC_BIAS bias_after_change_yscale[YPHY_LEV_TOTAL] = {
    {1915, 0, 0, 1914, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  1mv
    {1918, 0, 0, 1917, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  2mv
    {1925, 0, 0, 1926, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  5mv
    {1939, 0, 0, 1941, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  10mv
    {1964, 0, 0, 1972, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  20mv
    {2041, 0, 0, 2064, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  50mv
    {1938, 0, 0, 1941, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  100mv
    {1963, 0, 0, 1973, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  200mv
    {2041, 0, 0, 2062, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  500mv
    {1938, 0, 0, 1941, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  1v
    {1963, 0, 0, 1972, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  2v
    {2041, 0, 0, 2063, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  5v
    {1938, 0, 0, 1941, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  10v
    {1963, 0, 0, 1972, 1900, 0, 0, 1900, DAC_CH1_END_BIAS_INIT, 0, 0, DAC_CH4_END_BIAS_INIT}, //  20v
};

/**************************************************************************************/
///																						///
///                                     DAC LTC2620                                      ///
///																						///
/**************************************************************************************/
void HW_WriteDAC_LTC2620(ushort Port, uint Data)
{
	Data = ((ushort)(Data<<4)) | ((0x30 | ( Port%8 )) << 16);
	//if ( Port >= eDAC_MAX || DAC_VBuffer[Port] == Data )
	//	return ;

	//DAC_VBuffer[Port] = Data;
	//命令模式
	FPGA_WriteW (eFRA_dac_send_dataL, (ushort)(Data >> 0x00) );
	FPGA_WriteW (eFRA_dac_send_dataH, (ushort)(Data >> 0x10) );
	
	FPGA_WriteW (eFRA_dac_send_sel, (1<< ( Port/8 )) | (0x01<<4) );
	FPGA_WriteW (eFRA_dac_send_en, 0);
	FPGA_WriteW (eFRA_dac_send_en, 1);

	uSleep ( 100 );
	//关闭所有片选
	FPGA_WriteW ( eFRA_dac_send_sel, 0 );
}

void HW_InitDAC_LTC2620 (void){
    printf("[UI]--------------DAC init------------------\n");
	for (int iDAC = eDACV02_CH1_Pre_X; iDAC <= eDACV02_REF_LA; iDAC++)
	{
	    HW_WriteDAC_LTC2620(iDAC, 1900);
	}
	HW_WriteDAC_LTC2620(eDACV02_CH4_REF, dac_bias.ch4_ref);
	HW_SetDAC_PreBias(ID_CH4, dac_bias.ch4_pre_bias);
	HW_WriteDAC_LTC2620(eDACV02_CH4_Base, dac_bias.ch4_end_bias);

	OffChDefaultOffset();
}

void HW_SetDAC_PreFine(ushort ch, uint Data)
{
    switch (ch)
    {
        case ID_CH1:
            HW_WriteDAC_LTC2620(eDACV02_CH1_Pre_X, Data );
            break;
        case ID_CH2:
            HW_WriteDAC_LTC2620(eDACV02_CH2_Pre_X, Data );
            break;
        case ID_CH3:
            HW_WriteDAC_LTC2620(eDACV02_CH3_Pre_X, Data );
            break;
        case ID_CH4:
            HW_WriteDAC_LTC2620(eDACV02_CH4_Pre_X, Data );
            break;
        default:
            break;
    }
}

void HW_SetDAC_PreCoarse (ushort ch, uint Data)
{
    switch (ch)
    {
        case ID_CH1:
            HW_WriteDAC_LTC2620(eDACV02_CH1_Pre_C, Data);
            break;
        case ID_CH2:
            HW_WriteDAC_LTC2620(eDACV02_CH2_Pre_C, Data);
            break;
        case ID_CH3:
            HW_WriteDAC_LTC2620(eDACV02_CH3_Pre_C, Data);
            break;
        case ID_CH4:
            HW_WriteDAC_LTC2620(eDACV02_CH4_Pre_C, Data);
            break;
        default:
            break;
    }
}

// DAC前级偏置
void HW_SetDAC_PreBias(uint ch, double Data)
{
	ushort usVualC = ( ushort ) Data;
	ushort usVualX = usVualC + ( ushort ) ( ( Data - usVualC ) / DAC_PRE_FIN + 0.5 );
	//ErroPrintf("CH%d, PreBias =%f\n", ch + 1, Data);

	LIMIT ( usVualC, 0, DAC_MAX );
	LIMIT ( usVualX, 0, DAC_MAX );
    // 粗调
    HW_SetDAC_PreCoarse(ch, usVualC);
    // 细调
    HW_SetDAC_PreFine(ch, usVualX);
}

void HW_SetDAC_REF (uint ch, double Data)
{
    switch ( ch )
    {
        case ID_CH1:
            HW_WriteDAC_LTC2620( eDACV02_CH1_REF, Data);
            break;
        case ID_CH2:
            HW_WriteDAC_LTC2620( eDACV02_CH2_REF, Data);
            break;
        case ID_CH3:
            HW_WriteDAC_LTC2620( eDACV02_CH3_REF, Data);
            break;
        case ID_CH4:
            HW_WriteDAC_LTC2620( eDACV02_CH4_REF, Data);
            break;
        default:
            break;
    }
}

void HW_SetDAC_EndBias (uint ch, double Data)
{
	switch ( ch )
	{
		case ID_CH1:
		    HW_WriteDAC_LTC2620( eDACV02_CH1_Base, Data);
			break;
		case ID_CH2:
		    HW_WriteDAC_LTC2620( eDACV02_CH2_Base, Data);
			break;
		case ID_CH3:
		    HW_WriteDAC_LTC2620( eDACV02_CH3_Base, Data);
			break;
		case ID_CH4:
		    HW_WriteDAC_LTC2620( eDACV02_CH4_Base, Data);
			break;
		default:
			break;
	}
}

void HW_SetDAC_After_Scale_Set(ushort yScale){
    dac_bias = bias_after_change_yscale[yScale];
    HW_WriteDAC_LTC2620(eDACV02_CH4_REF, dac_bias.ch4_ref);
    HW_SetDAC_PreBias(ID_CH4, dac_bias.ch4_pre_bias);
    HW_WriteDAC_LTC2620(eDACV02_CH4_Base, dac_bias.ch4_end_bias);
}

void HW_SetDAC_EndBias_updata(ushort yScale, uint Data){
    bias_after_change_yscale[yScale].ch4_end_bias = Data;
    HW_WriteDAC_LTC2620(eDACV02_CH4_Base, Data);
}

void HW_SetDAC_TrgBias(uint ch, double Data)
{
	switch ( ch )
	{
		case eTG_SRC_EXT:
		case eTG_SRC_EXT5:
		case eTG_SRC_AC:
		    HW_WriteDAC_LTC2620(eDACV02_EXT, Data);
			break;
		default:
			break;
	}
}

void HW_SetDAC_SlopeTrgBias (uint ch, double Data )
{
	//HW_SetDAC(eDAC_Slope, Data);
}

static void HW_SetDAC_TrgHYS (uint ch, double Data )
{
    switch (ch)
    {
        case ID_CH1:
            HW_WriteDAC_LTC2620( eDACV02_ch1_Trig_HYS, Data );
            break;
        case ID_CH2:
            HW_WriteDAC_LTC2620( eDACV02_ch2_Trig_HYS, Data );
            break;
        case ID_CH3:
            HW_WriteDAC_LTC2620( eDACV02_ch3_Trig_HYS, Data );
            break;
        case ID_CH4:
            HW_WriteDAC_LTC2620( eDACV02_ch4_Trig_HYS, Data );
            break;
        default:
            HW_WriteDAC_LTC2620( eDACV02_ch1_Trig_HYS, Data );
            break;
    }
}

static ushort TriggerSensitivity (int ySCALE, int Coupling)
{
    ushort Sensitivity =0;
    if ( SS_TRIG_COUPLING_NOISER == Coupling )
    {
        switch ( ySCALE )
        {
#ifdef EN_YLEV500UV
            case YLEV500UV:               Sensitivity = 2459;             break;
#endif
            case YLEV1MV:               Sensitivity = 2459;             break;
            case YLEV2MV:               Sensitivity = 1630;             break;
            case YLEV5MV:               Sensitivity = 665;              break;//0.6div
            case YLEV10MV:              Sensitivity = 560;              break;//0.6div
            case YLEV20MV:              Sensitivity = 725;              break;//0.6div
            case YLEV50MV:              Sensitivity = 809;              break;//0.6div
            case YLEV100MV:             Sensitivity = 698;              break;//0.6div
            case YLEV200MV:             Sensitivity = 745;              break;//0.6div
            case YLEV500MV:             Sensitivity = 707;              break;//0.6div
            case YLEV1V:                Sensitivity = 720;              break;//0.6div
            case YLEV2V:                Sensitivity = 742;              break;//0.6div
            case YLEV5V:                Sensitivity = 660;              break;//0.6div
            case YLEV10V:               Sensitivity = 715;              break;//0.6div
            case YLEV20V:               Sensitivity = 679;              break;//0.6div
            default:                Sensitivity = 500;                  break;//0.4div
        }
    }
    else
    {
        switch ( ySCALE )
        {
#ifdef EN_YLEV500UV
            case YLEV500UV:               Sensitivity = 1876;             break;
#endif
            case YLEV1MV:               Sensitivity = 1876;             break;
            case YLEV2MV:               Sensitivity = 989;              break;
            case YLEV5MV:               Sensitivity = 300;              break;//0.6div
            case YLEV10MV:              Sensitivity = 387;              break;//0.6div
            case YLEV20MV:              Sensitivity = 300;              break;//0.6div
            case YLEV50MV:              Sensitivity = 250;              break;//0.6div
            case YLEV100MV:             Sensitivity = 192;              break;//0.6div
            case YLEV200MV:             Sensitivity = 230;              break;//0.6div
            case YLEV500MV:             Sensitivity = 187;              break;//0.6div
            case YLEV1V:                Sensitivity = 173;              break;//0.6div
            case YLEV2V:                Sensitivity = 462;              break;//0.6div
            case YLEV5V:                Sensitivity = 139;              break;//0.6div
            case YLEV10V:               Sensitivity = 220;              break;//0.6div
            case YLEV20V:               Sensitivity = 198;              break;//0.6div
            default:                    Sensitivity = 300;              break;//0.4div
        }
    }
    return Sensitivity;
}

void Trg_SetHardwareHYS (uint ch, int level, int Coupling )
{
    ushort hys = TriggerSensitivity ( level, Coupling );
    HW_SetDAC_TrgHYS ( ch, hys );
}

