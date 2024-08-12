#ifndef __HARDWARE__
#define __HARDWARE__
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <signal.h>

#include "product.h"
#include "usrio.h"
#include "platform.h"
//#include "FPGA.h"
//#include "DAC.h"
//#include "ADC.h"
//#include "CD4094.h"
#include "Define.h"
#include "uart_key.h"

typedef enum{
	ID_CH1 = 0,
	ID_CH2,
    ID_CH3,
    ID_CH4,

	ID_CH_MATH,
	ID_CH_REF_A,
	ID_CH_REF_B,
    ID_CH_REF_C,
    ID_CH_REF_D,
    ID_CH_TOTAL,
    PHY_CH_MAX_TOTAL =ID_CH4+1
}eCHANNEL_ID;

enum eYScale
{
    YLEV_MIN,
    YLEV1MV = 0,
    YLEV2MV,
    YLEV5MV,
    YLEV10MV,
    YLEV20MV,
    YLEV50MV,
    YLEV100MV,
    YLEV200MV,
    YLEV500MV,
    YLEV1V,
    YLEV2V,
    YLEV5V,
	YLEV10V,
	YLEV20V,

    YLEV_PHY_MIN  = YLEV1MV,
   	YLEV_MAX    = YLEV20V,
    Y_LEV_TOTAL = YLEV_MAX+1,
	YLEV_PHY_MAX	= YLEV20V,
    YPHY_LEV_TOTAL = YLEV20V+1,
	YLEV_50OHM_MIN = YLEV1MV,
	YLEV_50OHM_MAX = YLEV1V, 
};

enum eXScale
{
    XLEV_MIN=0,
    XLEV_2NS=0,
    XLEV_5NS,
    XLEV_10NS,
    XLEV_20NS,
    XLEV_50NS,
    XLEV_100NS,
    XLEV_200NS,
    XLEV_500NS,
    XLEV_1US,
    XLEV_2US,
    XLEV_5US,
    XLEV_10US,
    XLEV_20US,
    XLEV_50US,
    XLEV_100US,
    XLEV_200US,
    XLEV_500US,
    XLEV_1MS,
    XLEV_2MS,
    XLEV_5MS,
    XLEV_10MS,
    XLEV_20MS,
    XLEV_50MS,

    XLEV_MAX = XLEV_50MS,
};

union KeyBoardLED
{
    uint LED;
    struct
    {
        uint RUNSTOP:1;         //0
        uint SINGLE:1;          //1
        uint MATH:1;            //2
        uint REF:1;             //3
        uint CH4:1;             //4
        uint CH3:1;             //5
        uint CH2:1;             //6
        uint CH1:1;             //7
        uint MODE_AUTO:1;       //8
        uint MODE_NORMAL:1;     //9
        uint MODE_SINGLE:1;     //10
        uint LA:1;              //11
        uint PAUSE:1;           //12
        uint PLAYBACK:1;        //13
        uint SUSBEND:1;         //14
        uint AWG:1;             //15
    };
};

extern const char* eYScale_names[];
extern const uint eYScale_value[];
extern const char* eXScale_names[];
extern const ulong eXScale_value[];
extern const char eXScale_draw_value[];
extern const char eXScale_inset_value[];

#define LEV_Y_DEFAULTE			YLEV200MV

#define CH_YLEV_MIN				YLEV_MIN
#define AUTO_MIN_Y_SCALE		YLEV_MIN

#define MATH_YLEV_MAX           YLEV_MAX
#define MATH_YLEV_MIN           YLEV_MIN

enum eTG_SRC
{
	eTG_SRC_MIN=0,
	eTG_SRC_CH1=eTG_SRC_MIN,
	eTG_SRC_CH2,
	eTG_SRC_CH3,
	eTG_SRC_CH4,
	eTG_SRC_PHY_MAX=eTG_SRC_CH4,

	eTG_SRC_LA_D0,
	eTG_SRC_LA_D1,
	eTG_SRC_LA_D2,
	eTG_SRC_LA_D3,
	eTG_SRC_LA_D4,
	eTG_SRC_LA_D5,
	eTG_SRC_LA_D6,
	eTG_SRC_LA_D7,

	eTG_SRC_LA_D8,
	eTG_SRC_LA_D9,
	eTG_SRC_LA_D10,
	eTG_SRC_LA_D11,
	eTG_SRC_LA_D12,
	eTG_SRC_LA_D13,
	eTG_SRC_LA_D14,
	eTG_SRC_LA_D15,
	eTG_SRC_MAX_DATA=eTG_SRC_LA_D15,

	eTG_SRC_EXT,
	eTG_SRC_EXT5,
	eTG_SRC_AC,
	eTG_SRC_MAX
};
enum enumPhyCoupling
{
    ePC_DC,
    ePC_AC
};

enum eChBW:menu_val
{
    SS_CHL_BW_FULL=0,
    SS_CHL_BW_20M,
};

enum eTG_HW_SRC
{
	eTGH_SRC_MIN=0,
	eTGH_SRC_CH1=eTG_SRC_MIN,
	eTGH_SRC_CH2,
	eTGH_SRC_CH3,
	eTGH_SRC_CH4,
	eTGH_SRC_PHY_MAX=eTG_SRC_CH4,
	eTGH_SRC_LA,
	eTGH_SRC_EXT,
	eTGH_SRC_MAX
};

#define SS_TRIG_COUPLING_DC			0
#define SS_TRIG_COUPLING_AC			1
#define SS_TRIG_COUPLING_LFR		2//触发耦合:低频抑制
#define SS_TRIG_COUPLING_HFR		3//触发耦合:高频抑制
#define SS_TRIG_COUPLING_NOISER		4//触发耦合:噪声抑制

#define SS_TRIG_MODE_AUTO		0//触发方式:自动
#define SS_TRIG_MODE_NORMAL		1
#define SS_TRIG_MODE_SINGLE		2

#define SS_TRIG_PW_POLARITY_NEG		0
#define SS_TRIG_PW_POLARITY_POS		1//触发脉宽极性：正
void HW_ADC_Reset(uint ic);
void SendCmdToLEDInit( void );
void RunStopLed(bool run);
void TrigLed(int status);
#endif

