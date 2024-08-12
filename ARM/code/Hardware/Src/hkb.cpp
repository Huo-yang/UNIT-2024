#include "KeyCode.h"
#include "printf_define.h"

//物理键盘按键编码
#define HKB_BASEVAL		0x20
enum eHKB_CODE
{
    HKB_UPDATE     = -1,
    HKB_NULL	    = 0,
    ///////////////

    HKB_F1	    = 0x20,
    HKB_F2	    = 0x21,
    HKB_F3	    = 0x22,
    HKB_F4	    = 0x23,
    HKB_F5	    = 0x24,

    HKB_CH1		= 0x25,
    HKB_CH2		= 0x26,
	HKB_CH3		= 0x27,
	HKB_CH4		= 0x28,
    HKB_MATH	= 0x29,
    HKB_REF		= 0x2A,

    HKB_HORIZON     = 0x2B,
    HKB_TRIGGER     = 0x2C,
    HKB_SAVE        = 0x33,
    HKB_CURSOR      = 0x30,
    HKB_DISPLAY     = 0x32,
    HKB_MEASURE     = 0x2F,
    HKB_UTILITY	    = 0x34,
    HKB_DECODE      = 0x35,
    HKB_DEFAULT     = 0x36,
    HKB_ACQUIRE     = 0x31,
    HKB_HELP        = 0x2E,



    //////////
    HKB_AUTOSET      = 0x37,
    HKB_RUNSTOP      = 0x38,
    HKB_FORCE        = 0x2D,
    //单次触发
    HKB_SINGLE       = 0x39,
    //PRINTSCREEN
    HKB_CLEAR     	= 0x3A,
    HKB_PRSCREEN     = 0x3B,
    HKB_MENUOFF      = 0x3C,

    HKB_MANUALCALI	= 0X01,

    //多功能旋钮
    HKB_SELUP        = 0x4D,
    HKB_SELDOWN      = 0x4C,
    HKB_SELECT	     = 0x4E,

    //辉度调节
    //HKB_INTENUP		= 52,
    //HKB_INTENDOWN		= 51,
    //HKB_INTENDEF		= 16,


    HKB_CH_DOWN			= 0x3E,
    HKB_CH_UP			= 0x3D,
    HKB_CH_Y_MID_POS    = 0x3F,


    HKB_LEFT		    = 0x40,
    HKB_RIGHT			= 0x41,
    HKB_X_MID_POS		= 0x42,

    HKB_TRIDOWN			= 0x43,
    HKB_TRIUP			= 0x44,
    HKB_TRIG_MID	    = 0x45,

    HKB_CH_LCHLEVEL		= 0x46,
    HKB_CH_RCHLEVEL		= 0x47,
    HKB_COARSE		    = 0x48,


    HKB_LTMLEVEL			= 0x49,
    HKB_RTMLEVEL			= 0x4A,
    HKB_TMLEVEL_MID 		= 0x4B,


    HKB_STOP          	= (KEY_BASEVAL + 0x2f),
    HKB_PLAY_PAUSE      = (KEY_BASEVAL + 0x30),
    HKB_RECORD         	= (KEY_BASEVAL + 0x31),
    HKB_REC_SET         = (KEY_BASEVAL + 0x56),
    
    HKB_MODE          	= (KEY_BASEVAL + 0x32),
    HKB_LA            	= (KEY_BASEVAL + 0x33),
    HKB_AWG           	= (KEY_BASEVAL + 0x34),
	
    HKB_PAN_FINE_RIGHT	= (KEY_BASEVAL + 0x35),
    HKB_PAN_FINE_LEFT 	= (KEY_BASEVAL + 0x36),
    HKB_PAN_ANGLE_ZERO	= (KEY_BASEVAL + 0x37),
	
    HKB_PAN_ANGLE_R20 	= (KEY_BASEVAL + 0x38),
    HKB_PAN_ANGLE_R30 	= (KEY_BASEVAL + 0x39),
    HKB_PAN_ANGLE_R40 	= (KEY_BASEVAL + 0x3a),
    HKB_PAN_ANGLE_R50 	= (KEY_BASEVAL + 0x3b),
    HKB_PAN_ANGLE_R60 	= (KEY_BASEVAL + 0x3c),
    HKB_PAN_ANGLE_R70 	= (KEY_BASEVAL + 0x3d),
    HKB_PAN_ANGLE_R80 	= (KEY_BASEVAL + 0x3e),
	
    HKB_PAN_ANGLE_L10 	= (KEY_BASEVAL + 0x3f),
    HKB_PAN_ANGLE_L20 	= (KEY_BASEVAL + 0x40),
    HKB_PAN_ANGLE_L30 	= (KEY_BASEVAL + 0x41),
    HKB_PAN_ANGLE_L40 	= (KEY_BASEVAL + 0x42),
    HKB_PAN_ANGLE_L50 	= (KEY_BASEVAL + 0x43),
    HKB_PAN_ANGLE_L60 	= (KEY_BASEVAL + 0x44),
    HKB_PAN_ANGLE_L70 	= (KEY_BASEVAL + 0x45),
    HKB_PAN_ANGLE_L80 	= (KEY_BASEVAL + 0x46),

	HKB_PgDn				 = 0x67,

	//数码键盘
	HKB_DK_0			=0x68 ,
	HKB_DK_1			=0x69 ,
	HKB_DK_2			=0x6a ,
	HKB_DK_3			=0x6b ,
	HKB_DK_4			=0x6c ,
	HKB_DK_5			=0x6d ,
	HKB_DK_6			=0x6e ,
	HKB_DK_7			=0x6f ,
	HKB_DK_8			=0x70 ,
	HKB_DK_9			=0x71 ,
	HKB_DK_POINT		=0x74 ,
	HKB_DK_ADD_SUB		=0x72 ,
	HKB_DK_RETURN		=0x75 ,
	HKB_DK_ENTER	    =0x73 ,


    HKB_PAN_LBIT =0x80,
};


enum eKEY_CODE HardwareKeyboard[256]={KC_NULL};

void HardwareKeyboardMapInit(void)
{
	HardwareKeyboard[HKB_NULL            ]=KC_NULL            ;
	HardwareKeyboard[HKB_F1	             ]=KC_F1	           ; 
	HardwareKeyboard[HKB_F2	             ]=KC_F2	           ; 
	HardwareKeyboard[HKB_F3	             ]=KC_F3	           ; 
	HardwareKeyboard[HKB_F4	             ]=KC_F4	           ; 
	HardwareKeyboard[HKB_F5	             ]=KC_F5	           ; 

	HardwareKeyboard[HKB_CH1		     ]=KC_CH1		       ;
	HardwareKeyboard[HKB_CH2		     ]=KC_CH2		       ;
	HardwareKeyboard[HKB_CH3		     ]=KC_CH3		       ;
	HardwareKeyboard[HKB_CH4		     ]=KC_CH4		       ;
	HardwareKeyboard[HKB_MATH	         ]=KC_MATH	           ;
	HardwareKeyboard[HKB_REF		     ]=KC_REF		       ;

	HardwareKeyboard[HKB_HORIZON         ]=KC_HORIZON         ;
	HardwareKeyboard[HKB_TRIGGER         ]=KC_TRIGGER         ;
	HardwareKeyboard[HKB_SAVE            ]=KC_SAVE            ;
	HardwareKeyboard[HKB_CURSOR          ]=KC_CURSOR          ;
	HardwareKeyboard[HKB_DISPLAY         ]=KC_DISPLAY         ;
	HardwareKeyboard[HKB_MEASURE         ]=KC_MEASURE         ;
	HardwareKeyboard[HKB_UTILITY	     ]=KC_UTILITY	      ;
	HardwareKeyboard[HKB_DECODE          ]=KC_DECODE          ;
	HardwareKeyboard[HKB_DEFAULT         ]=KC_DEFAULT         ;
	HardwareKeyboard[HKB_ACQUIRE         ]=KC_ACQUIRE         ;
	HardwareKeyboard[HKB_HELP            ]=KC_HELP         ;




	HardwareKeyboard[HKB_AUTOSET         ]=KC_AUTOSET         ;
	HardwareKeyboard[HKB_RUNSTOP         ]=KC_RUNSTOP         ;
	HardwareKeyboard[HKB_FORCE           ]=KC_FORCE           ;

	HardwareKeyboard[HKB_SINGLE          ]=KC_SINGLE          ;

	HardwareKeyboard[HKB_CLEAR           ]=KC_CLEAR           ;
	HardwareKeyboard[HKB_PRSCREEN        ]=KC_PRSCREEN        ;
	HardwareKeyboard[HKB_MENUOFF         ]=KC_MENUOFF         ;

	HardwareKeyboard[HKB_MANUALCALI	     ]=KC_MANUALCALI	   ; 


	HardwareKeyboard[HKB_SELUP           ]=KC_SELUP           ;
	HardwareKeyboard[HKB_SELDOWN         ]=KC_SELDOWN         ;
	HardwareKeyboard[HKB_SELECT	         ]=KC_SELECT	       ; 


	HardwareKeyboard[HKB_CH_DOWN		 ]=KC_CH_DOWN		   ;
	HardwareKeyboard[HKB_CH_UP			 ]=KC_CH_UP			; 
	HardwareKeyboard[HKB_CH_Y_MID_POS    ]=KC_CH_Y_MID_POS    ;

	HardwareKeyboard[HKB_LEFT		     ]=KC_LEFT		       ;
	HardwareKeyboard[HKB_RIGHT			 ]=KC_RIGHT			; 
	HardwareKeyboard[HKB_X_MID_POS		 ]=KC_X_MID_POS		; 

	HardwareKeyboard[HKB_TRIDOWN		 ]=KC_TRIDOWN		   ;
	HardwareKeyboard[HKB_TRIUP			 ]=KC_TRIUP			; 
	HardwareKeyboard[HKB_TRIG_MID	     ]=KC_TRIG_MID	       ;

	HardwareKeyboard[HKB_CH_LCHLEVEL	 ]=KC_CH_LCHLEVEL	   ;
	HardwareKeyboard[HKB_CH_RCHLEVEL	 ]=KC_CH_RCHLEVEL	   ;
	HardwareKeyboard[HKB_COARSE		     ]=KC_COARSE		   ; 

	HardwareKeyboard[HKB_LTMLEVEL		 ]=KC_LTMLEVEL		   ;
	HardwareKeyboard[HKB_RTMLEVEL		 ]=KC_RTMLEVEL		   ;
	HardwareKeyboard[HKB_TMLEVEL_MID 	 ]=KC_TMLEVEL_MID 	   ;

	HardwareKeyboard[HKB_STOP          	 ]=KC_STOP          	; 
	HardwareKeyboard[HKB_PLAY_PAUSE      ]=KC_PLAY_PAUSE      ;
	HardwareKeyboard[HKB_RECORD          ]=KC_RECORD          ;
	HardwareKeyboard[HKB_REC_SET          ]=KC_REC_SET          ;

	HardwareKeyboard[HKB_MODE          	 ]=KC_MODE          	; 
	HardwareKeyboard[HKB_LA            	 ]=KC_LA            	; 
	HardwareKeyboard[HKB_AWG           	 ]=KC_AWG           	; 

	HardwareKeyboard[HKB_PAN_FINE_RIGHT	 ]=KC_PAN_FINE_RIGHT	; 
	HardwareKeyboard[HKB_PAN_FINE_LEFT 	 ]=KC_PAN_FINE_LEFT 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_ZERO	 ]=KC_PAN_ANGLE_ZERO	; 

	HardwareKeyboard[HKB_PAN_ANGLE_R20 	 ]=KC_PAN_ANGLE_R20 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_R30 	 ]=KC_PAN_ANGLE_R30 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_R40 	 ]=KC_PAN_ANGLE_R40 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_R50 	 ]=KC_PAN_ANGLE_R50 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_R60 	 ]=KC_PAN_ANGLE_R60 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_R70 	 ]=KC_PAN_ANGLE_R70 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_R80 	 ]=KC_PAN_ANGLE_R80 	; 

	HardwareKeyboard[HKB_PAN_ANGLE_L10 	 ]=KC_PAN_ANGLE_L10 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L20 	 ]=KC_PAN_ANGLE_L20 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L30 	 ]=KC_PAN_ANGLE_L30 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L40 	 ]=KC_PAN_ANGLE_L40 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L50 	 ]=KC_PAN_ANGLE_L50 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L60 	 ]=KC_PAN_ANGLE_L60 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L70 	 ]=KC_PAN_ANGLE_L70 	; 
	HardwareKeyboard[HKB_PAN_ANGLE_L80 	 ]=KC_PAN_ANGLE_L80 	; 

	HardwareKeyboard[HKB_PgDn			 ]=KC_PgDn			   ;

	HardwareKeyboard[HKB_DK_0			 ]=KC_DK_0			   ;
	HardwareKeyboard[HKB_DK_1			 ]=KC_DK_1			   ;
	HardwareKeyboard[HKB_DK_2			 ]=KC_DK_2			   ;
	HardwareKeyboard[HKB_DK_3			 ]=KC_DK_3			   ;
	HardwareKeyboard[HKB_DK_4			 ]=KC_DK_4			   ;
	HardwareKeyboard[HKB_DK_5			 ]=KC_DK_5			   ;
	HardwareKeyboard[HKB_DK_6			 ]=KC_DK_6			   ;
	HardwareKeyboard[HKB_DK_7			 ]=KC_DK_7			   ;
	HardwareKeyboard[HKB_DK_8			 ]=KC_DK_8			   ;
	HardwareKeyboard[HKB_DK_9			 ]=KC_DK_9			   ;
	HardwareKeyboard[HKB_DK_POINT		 ]=KC_DK_POINT		   ;
	HardwareKeyboard[HKB_DK_ADD_SUB		 ]=KC_DK_ADD_SUB		; 
	HardwareKeyboard[HKB_DK_RETURN		 ]=KC_DK_RETURN		; 
	HardwareKeyboard[HKB_DK_ENTER	     ]=KC_DK_ENTER	       ;
}

eKEY_CODE HardwareKeyboardToKeyCode(unsigned char hkb)
{
	eKEY_CODE KC = HardwareKeyboard[hkb];
	if(0==KC)
	{
		Printf("\n\n\n" LIGHT_RED "HKB:%d" NONE " \n", (int)hkb);
	}
	return KC;
}
int KeyStepSpeed(int deltaT , int maxstep)
{
	const int gaptime = 500;
    if(deltaT > gaptime/2)
        return 1;

    if(deltaT <= gaptime/maxstep)
        return maxstep;

    return gaptime/deltaT;
}

unsigned char HardwareKeyboardPreprocess(unsigned char key, unsigned char &keybak, int &step, int deltaT)
{
	switch (key)
    {
    case HKB_PAN_LBIT|HKB_PAN_FINE_RIGHT:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_FINE_LEFT :// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_ZERO:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R20:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R30:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R40:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R50:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R60:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R70:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_R80:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L10:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L20:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L30:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L40:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L50:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L60:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L70:// @suppress("No break at end of case")
    case HKB_PAN_LBIT|HKB_PAN_ANGLE_L80:
        key = key&(~HKB_PAN_LBIT);
        step = 1;
        break;
    case HKB_LEFT:
    case HKB_RIGHT:
        step = (keybak == key)?KeyStepSpeed(deltaT, 20):1;
        break;
    case HKB_SELUP:
    case HKB_SELDOWN:
        step = (keybak == key)?KeyStepSpeed(deltaT, 10):1;
        break;
    case HKB_CH_UP:
    case HKB_CH_DOWN:
        step = (keybak == key)?KeyStepSpeed(deltaT, 10):1;
        break;
    case HKB_TRIDOWN:
    case HKB_TRIUP:
        step = (keybak == key)?KeyStepSpeed(deltaT, 10):1;
        break;
    default:
        step = 0;
        break;
    }
	return key;
}


