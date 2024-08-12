#ifndef __FontLib_H__
#define __FontLib_H__


#ifdef __cplusplus
extern "C" {
#endif


#include <wchar.h>

#include "product.h"

enum FONT_SIZE
{
    FONT_SIZE_MIN = 11,
	FONT_SIZE_10 = 10,
	FONT_SIZE_12 = 12,
	FONT_SIZE_14 = 14,
	FONT_SIZE_16 = 16,
	FONT_SIZE_18 = 18,
	FONT_SIZE_MAX = 28,
};

#define MAX_FONT_SIZE_NUM	7

#define GUI_FLASH

#define GUI_FONTINFO_FLAG_PROP (1<<0)    /* Is proportional */
#define GUI_FONTINFO_FLAG_MONO (1<<1)    /* Is monospaced */
#define GUI_FONTINFO_FLAG_AA   (1<<2)    /* Is an antialiased font */
#define GUI_FONTINFO_FLAG_AA2  (1<<3)    /* Is an antialiased font, 2bpp */
#define GUI_FONTINFO_FLAG_AA4  (1<<4)    /* Is an antialiased font, 4bpp */

#define GUI_FONTTYPE_PROP_AA2	(GUI_FONTINFO_FLAG_AA2)
#define GUI_FONTTYPE_PROP_AA4   (GUI_FONTINFO_FLAG_AA4)
#define GUI_FONTTYPE_PROP       (GUI_FONTINFO_FLAG_PROP)

#define GUI_FONT_MAX_LIGHT_DEEP (1<<4)//GUI_FONTINFO_FLAG_AA4



#if PRODUCT == MSO_2KP
#define USE_FREETYPE_DISP	1
#else
#define USE_FREETYPE_DISP	1
#endif

#if (USE_FREETYPE_DISP == 1)

typedef struct{
	int left_up_x ;
	int left_up_y ;
	int w ;
	int h ;
}font_region_t ;

typedef struct {
	font_region_t region ;
	int cur_origin_x ;
	int cur_origin_y ;
	int next_origin_x ;
	int next_origin_y ;
	int pitch ;
	
	int XSize ;
	int YSize ;
	const unsigned char  *data;
} GUI_FONT_CHAR_DATA;


#else

typedef struct {
	//wchar_t  code;
	unsigned char YSize;
	unsigned char XSize;
	unsigned short LineBytes;
	const unsigned char * PData;
} GUI_FONT_CHAR_DATA;

typedef struct {
    unsigned short First;
    unsigned short Last;
    const GUI_FONT_CHAR_DATA * PCharInfo;
} GUI_FONT_DATA_PROP;

typedef struct {
    int FontType;
    short YSize;
    int  libSize;
    const GUI_FONT_DATA_PROP * PProp;
}GUI_FONT_DATA_LIB;

#endif


#ifdef __cplusplus
}
#endif

#endif

