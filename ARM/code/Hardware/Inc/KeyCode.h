#ifndef _KEYCODE_HEAD
#define _KEYCODE_HEAD

typedef unsigned short KEY ;
#define KEY_BASEVAL		0x20

#define MAX_MOV_STEP_Y		10

enum eKEY_CODE
{
    KC_UPDATE     = -1,
    KC_NULL	    = 0,

	//0x01~0x7f 为标准ASCII码预留键
	
	//数码键盘
	KC_DK_0				=L'0',//=0x68 ,
	KC_DK_1				,//=0x69 ,
	KC_DK_2				,//=0x6a ,
	KC_DK_3				,//=0x6b ,
	KC_DK_4				,//=0x6c ,
	KC_DK_5				,//=0x6d ,
	KC_DK_6				,//=0x6e ,
	KC_DK_7				,//=0x6f ,
	KC_DK_8				,//=0x70 ,
	KC_DK_9				,//=0x71 ,
	KC_DK_POINT			=L'.',//=0x74 ,
	KC_DK_ADD_SUB		=L'-',//=0x72 ,
	KC_DK_ADD_ADD		=L'+',//=0x72 ,
	KC_DK_ENTER			=L'\n',//=0x73 ,
	KC_DK_RETURN		=24,//ASCII 取消//=0x75 ,
	KC_DK_LEFT  =L'<',// 左
	KC_DK_RIGHT  =L'>',// 右
	KC_DK_DELET  =L' ',
	KC_DK_U  = L'μ',
	KC_DK_M  = L'm',
	KC_DK_O  = L'O',
	KC_DK_K  = L'k',
	KC_DK_M_H  = L'M',

    KC_F1	    =0x80, //= 0x01,
    KC_F2	    ,
    KC_F3	    ,
    KC_F4	    ,
    KC_F5	    ,
    KC_FN_MAX	=0xA0, //= 0x20,
	KC_PgDn		, //= 0x67,

    KC_CH1		, //= 0x25,
    KC_CH2		, //= 0x26,
    KC_CH3		, //= 0x27,
    KC_CH4		, //= 0x28,
    KC_MATH		, //= 0x29,
    KC_REF		, //= 0x2A,

    KC_HORIZON      , //= 0x2B,
    KC_TRIGGER      , //= 0x2C,
    KC_SAVE         , //= 0x33,
    KC_CURSOR       , //= 0x30,
    KC_DISPLAY      , //= 0x32,
    KC_MEASURE      , //= 0x2F,
    KC_UTILITY	    , //= KC_USER,
    KC_DECODE       , //= 0x35,
    KC_DEFAULT      , // = 0x36,
    KC_ACQUIRE      , //= 0x31,
    KC_HELP         , //= 0x2E,

    //////////
    KC_AUTOSET      , //= 0x37,
    KC_RUNSTOP      , //= 0x38,
    KC_FORCE        , //= 0x2D,
    //单次触发
    KC_SINGLE       , //= 0x39,
    //PRINTSCREEN
    KC_CLEAR     	, //= 0x3A,
    KC_PRSCREEN     , //= 0x3B,截屏
    KC_MENUOFF      , //= 0x3C,

    KC_MANUALCALI	, //= KC_F1,

    //多功能旋钮
    KC_SELUP        , //= 0x4D,
    KC_SELDOWN      , //= 0x4C,
    KC_SELECT	    , //= 0x4E,
    KC_OK	    , //= 0x4E,
    KC_CANCEL	    , //= 0x4E,

    //辉度调节
    //KC_INTENUP		= 52,
    //KC_INTENDOWN		= 51,
    //KC_INTENDEF		= 16,

    KC_CH_DOWN			,//= 0x3E,
    KC_CH_UP			,//= 0x3D,
    KC_CH_Y_MID_POS     ,//= 0x3F,

    KC_LEFT				,//= 0x40,
    KC_RIGHT			,//= 0x41,
    KC_X_MID_POS		,//= 0x42,

    KC_TRIDOWN			,//= 0x43,
    KC_TRIUP			,//= 0x44,
    KC_TRIG_MID			,//= 0x45,

    KC_CH_LCHLEVEL		,//= 0x46,
    KC_CH_RCHLEVEL		,//= 0x47,
    KC_COARSE		    ,//= 0x48,

    KC_LTMLEVEL			,//= 0x49,
    KC_RTMLEVEL			,//= 0x4A,
    KC_TMLEVEL_MID 		,//= 0x4B,

    KC_STOP          	,//= (KEY_BASEVAL + 0x2f),
    KC_PLAY_PAUSE       ,//= (KEY_BASEVAL + 0x30),
    KC_RECORD         	,//= (KEY_BASEVAL + 0x31),
    KC_REC_SET         	,//= (KEY_BASEVAL + 0x31),
    
    KC_MODE          	,//= (KEY_BASEVAL + 0x32),
    KC_LA            	,//= (KEY_BASEVAL + 0x33),
    KC_AWG           	,//= (KEY_BASEVAL + 0x34),
	
    KC_PAN_FINE_RIGHT	,//= (KEY_BASEVAL + 0x35),
    KC_PAN_FINE_LEFT 	,//= (KEY_BASEVAL + 0x36),
    KC_PAN_ANGLE_ZERO	,//= (KEY_BASEVAL + 0x37),
	
    KC_PAN_ANGLE_R20 	,//= (KEY_BASEVAL + 0x38),
    KC_PAN_ANGLE_R30 	,//= (KEY_BASEVAL + 0x39),
    KC_PAN_ANGLE_R40 	,//= (KEY_BASEVAL + 0x3a),
    KC_PAN_ANGLE_R50 	,//= (KEY_BASEVAL + 0x3b),
    KC_PAN_ANGLE_R60 	,//= (KEY_BASEVAL + 0x3c),
    KC_PAN_ANGLE_R70 	,//= (KEY_BASEVAL + 0x3d),
    KC_PAN_ANGLE_R80 	,//= (KEY_BASEVAL + 0x3e),
	
    KC_PAN_ANGLE_L10 	,//= (KEY_BASEVAL + 0x3f),
    KC_PAN_ANGLE_L20 	,//= (KEY_BASEVAL + 0x40),
    KC_PAN_ANGLE_L30 	,//= (KEY_BASEVAL + 0x41),
    KC_PAN_ANGLE_L40 	,//= (KEY_BASEVAL + 0x42),
    KC_PAN_ANGLE_L50 	,//= (KEY_BASEVAL + 0x43),
    KC_PAN_ANGLE_L60 	,//= (KEY_BASEVAL + 0x44),
    KC_PAN_ANGLE_L70 	,//= (KEY_BASEVAL + 0x45),
    KC_PAN_ANGLE_L80 	,//= (KEY_BASEVAL + 0x46),

	KC_TPLock,

    KEY_RMASK =0xFF,
    KEY_RLBIT =0xC0,
    KEY_MASK =0xFF,
    KEY_LBIT =0x100,
    
    KC_MENUITEM_NULL	 = 0xff,
    KC_DESGAIN			 = (KC_LEFT		| 0X0200),
    KC_INCGAIN			 = (KC_RIGHT	| 0x0200),

    KC_DESPREOFFSET		 = (KC_CH_DOWN 	| 0x0200),
    KC_INCPREOFFSET		 = (KC_CH_UP    | 0x0200),

    KC_WRONG			 = KEY_LBIT,
    KC_LONG_FLAG		 = KEY_LBIT,

    KeyUserVirtual = 0x400,
    KeyUserHz,
    KeyUserkHz,
    KeyUserMHz,
    KeyUserDel,
    //KeyUserMenuOff,
	Key_Touch_Eevent=0x1000,
	KC_Touch_Up,
	KC_Touch_Down,
	KC_Touch_Left,
	KC_Touch_Right,

    KC_MENUMASK			 = 0x4000,
    KC_BUTTON,
    KC_AWGHF1,
	KC_AWGHF2,
	KC_AWGHF3,
	KC_AWGHF4,
	KC_AWGHF5,
	KC_AWGHF6,
	KC_AWGHF7,
	KC_AWGVF1,
	KC_AWGVF2,
	KC_AWGVF3,
	KC_AWGVF4,
	KC_AWG_Overvoltage,
    KC_AWGHF1T,
	KC_AWGHF2T,
	KC_AWGHF3T,
	KC_AWGHF4T,
	KC_AWGHF5T,
	KC_AWGHF6T,
	KC_AWGHF7T,

	// 解码事件列表
	KC_DECODE_LIST_1 ,
	KC_DECODE_LIST_2 ,
	KC_DECODE_LIST_3 ,
	KC_DECODE_LIST_4 ,
	KC_DECODE_LIST_5 ,
	KC_DECODE_LIST_6 ,
	KC_DECODE_LIST_7 ,
	KC_DECODE_LIST_8 ,
	KC_DECODE_LIST_9 ,
	KC_DECODE_LIST_10,
	KC_DECODE_LIST_11,
	KC_DECODE_LIST_12,
	KC_DECODE_LIST_13,
	KC_DECODE_LIST_14,
	KC_DECODE_LIST_15,
	KC_DECODE_LIST_16,
	KC_DECODE_LIST_17,
	KC_DECODE_LIST_18,
	KC_DECODE_LIST_19,
	KC_DECODE_LIST_20,
	// 
	Key_BODE_1,
	Key_BODE_2,
	Key_BODE_3,
	Key_BODE_4,
	Key_BODE_5,
	Key_BODE_6,
	Key_BODE_7,
	Key_BODE_8,
	// home
	KC_HOME        ,//
	KC_HOME_ICON_0 ,
	KC_HOME_ICON_1 ,
	KC_HOME_ICON_2 ,
	KC_HOME_ICON_3 ,
	KC_HOME_ICON_4 ,
	KC_HOME_ICON_5 ,
	KC_HOME_ICON_6 ,
	KC_HOME_ICON_7 ,
	KC_HOME_ICON_8 ,
	KC_HOME_ICON_9 ,
	KC_HOME_ICON_10,
	KC_HOME_ICON_11,
	KC_HOME_ICON_12,
	KC_HOME_ICON_13,
	KC_HOME_ICON_14,
	KC_HOME_ICON_15,
	KC_QUIT,
    KC_Navigate_XMLeft,
    KC_Navigate_XMStop,
    KC_Navigate_XMRight,
	KC_UNIVERSAL_0,
	KC_UNIVERSAL_1,
	KC_UNIVERSAL_2,
	KC_UNIVERSAL_3,
	KC_UNIVERSAL_4,
	KC_UNIVERSAL_5,
	KC_UNIVERSAL_6,
	KC_UNIVERSAL_7,
	KC_UNIVERSAL_8,
	KC_UNIVERSAL_9,
	KC_UNIVERSAL_10,
};

#define KF1		0
#define KF2		1
#define KF3		2
#define KF4		3
#define KF5		4

#endif
