/*
 * @Author: song sds0222@163.com
 * @Date: 2023-04-12 20:42:40
 * @LastEditors: song sds0222@163.com
 * @LastEditTime: 2023-04-12 20:42:44
 * @FilePath: \Graduate_Demo\mso2000\Display\ut_freetype.h
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
/**************************************************************************************************************
---Copyright (C) , 2022, UNI-TREND.CHENGDU
---File name : ut_freetype.h
---Author : Kinwa       Version: V1.0         Date : 2022/7/20
---Description :  freetype
---Version : V1.0
---Function list :
---History :
   1. Author:
   	  Time :
   	  Modification :
**************************************************************************************************************/
#if 1
/* Define to prevent recursive inclusion --------------------------------------------------------------------*/
#ifndef __UT_FREETYPE_H__
#define __UT_FREETYPE_H__


#include "FontLib.h"


#ifdef __cplusplus
extern "C"
{
#endif

/*Macro definition ------------------------------------------------------------------------------------------*/
#define FREETYPE_DEBUG_LEVEL 0

#if FREETYPE_DEBUG_LEVEL > 0
#define freetype_log_info(format,...) usr_printf(format,##__VA_ARGS__)
#else
#define freetype_log_info(format,...) 
#endif



#define USE_FT_CACHE_MANAGER	0 //1
#if USE_FT_CACHE_MANAGER == 1
/* 1: bitmap cache use the sbit cache, 0:bitmap cache use the image cache. */
/* sbit cache:it is much more memory efficient for small bitmaps(font size < 256) */
/* if font size >= 256, must be configured as image cache */
#  define USE_FT_SBIT_CACHE		1
#endif



#define FONT_FILE_PATH		"/mso2000/language/HarmonyOS_Sans_SC_Regular.ttf"
#define SEG_FONT_FILE_PATH	"/mso2000/language/digifaw.ttf"




/*Structure definition --------------------------------------------------------------------------------------*/
typedef struct {
    char * name;
} ut_face_info_t;


typedef struct {
    unsigned short adv_w; /**< The glyph needs this space. Draw the next glyph after this width.*/
    unsigned short box_w;  /**< Width of the glyph's bounding box*/
    unsigned short box_h;  /**< Height of the glyph's bounding box*/
    short ofs_x;   /**< x offset of the bounding box*/
    short ofs_y;  /**< y offset of the bounding box*/
    unsigned char bpp;   /**< Bit-per-pixel: 1, 2, 4, 8*/
} ut_font_glyph_dsc_t;






/*Global variable declaration--------------------------------------------------------------------------------*/


/*Global Function declaration -------------------------------------------------------------------------------*/


extern bool ut_freetype_init(unsigned short max_faces, unsigned short max_sizes, unsigned int max_bytes) ;
extern void FontSetSize(unsigned int size) ;
extern unsigned int FontGetSize();
extern int Font_Get_Glyph(wchar_t c, GUI_FONT_CHAR_DATA *data) ;
extern void bitmap_printf(const unsigned char *bitmap, int x, int y,  int w, int h) ;


#ifdef __cplusplus
}
#endif
#endif 
#endif
/*------------------------------------------- end of file ---------------------------------------------------*/


