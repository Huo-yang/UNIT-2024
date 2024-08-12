/**************************************************************************************************************
---Copyright (C) , 2022, UNI-TREND.CHENGDU
---File name : ut_freetype.cpp
---Author : Kinwa       Version: V1.0         Date : 2022/7/20
---Description :  freetype transplant
---Version : V1.0
---Function list :
---History :
	<Author>      <Time>      <Version>     <Desc>

	FT_Face 是矢量字体的外观对象，用于保存字体外观数、当前外观索引、当前外观所包含字形文件数等相关数据，
	其中外观可简单理解为常规、斜体、加粗等字体风格，加载 FT_Face 有两种方式，一是通过字体文件名加载，
	二是从内存中加载

**************************************************************************************************************/

/*Includes---------------------------------------------------------------------------------------------------*/
#include "ut_freetype.h"


#include "ft2build.h"
#include FT_FREETYPE_H
#include FT_GLYPH_H
#include FT_CACHE_H
#include FT_SIZES_H

#include <wchar.h>
#include <stdio.h>
#include <stdint.h>

#include "FontLib.h"






/*Variable definition----------------------------------------------------------------------------------------*/
static FT_Library library[MAX_FONT_SIZE_NUM];

static FT_Face FntFace[MAX_FONT_SIZE_NUM] ;
static FT_GlyphSlot FntSLot ;

static unsigned int FntSize = FONT_SIZE_MIN ;



unsigned int getFontSizeByIndex(unsigned int index)
{
	unsigned int size = 0 ; 
	switch(index){
		case 0:
			size = FONT_SIZE_10;
			break;
		case 1:
			size = FONT_SIZE_MIN;
			break;
		case 2:
			size = FONT_SIZE_12;
			break;
		case 3:
			size = FONT_SIZE_14;
			break;
		case 4:
			size = FONT_SIZE_16;
			break;
		case 5:
			size = FONT_SIZE_18;
			break;
		case 6:
			size = FONT_SIZE_MAX;
			break;
		default:
			size = FONT_SIZE_MIN;
			break;
	}
	return size;
}


unsigned int getFontIndexBySize(unsigned int size)
{
	unsigned int index = 0 ; 

	switch(size){
		case FONT_SIZE_10:
			index = 0 ;
			break ;
		case FONT_SIZE_MIN:
			index = 1 ;
			break ;
		case FONT_SIZE_12:
			index = 2 ;
			break ;
		case FONT_SIZE_14:
			index = 3 ;
			break ;
		case FONT_SIZE_16:
			index = 4 ;
			break ;
		case FONT_SIZE_18:
			index = 5 ;
			break ;
		case FONT_SIZE_MAX:
			index = 6 ;
			break ;
		default:
			size = 1 ;
			break ;
	}
	return index ;
}



/*
**************************************************************************************************************
---Function: ut_freetype_init
---Description : 
---Calls :
---Called By : main
---Input : 
   @max_faces: Maximum number of opened FT_Face objects managed by this cache instance, Use 0 for defaults.
   @max_sizes: Maximum number of opened FT_Size objects managed by this cache instance. Use 0 for defaults.
   @max_bytes: Maximum number of bytes to use for cached data nodes. Use 0 for defaults. \
               Note that this value does not account for managed FT_Face and FT_Size objects.
---Output : None
---Return : None
---Other :
**************************************************************************************************************
*/

bool ut_freetype_init(unsigned short max_faces, unsigned short max_sizes, unsigned int max_bytes)
{
	FT_Error error ;

	for(int i = 0; i < MAX_FONT_SIZE_NUM; i++){
		/*creating a new instance of the FreeType 2 library and setting the handle library to it*/
		error = FT_Init_FreeType(&library[i]);
	    if(error) {
	        freetype_log_info("[UI]init freeType error(%d)", error);
	        return false;
	    }
		
		error = FT_New_Face(library[i], FONT_FILE_PATH, 0, &FntFace[i]) ;
		if(error) {
	        freetype_log_info("[UI]Failed to open sbit cache");
	        FT_Done_FreeType(library[i]);
			return false ;
	    }

		unsigned int size = getFontSizeByIndex(i) ;
		FT_Set_Pixel_Sizes(FntFace[i], 0, size);

		FntSLot = FntFace[i]->glyph ;
		FT_Select_Charmap(FntFace[i], FT_ENCODING_UNICODE);

		FntFace[i]->FntMap = new std::map<wchar_t, FT_GlyphData*>();
		FntFace[i]->FntMap->clear();
	}
	return true;
}

void FontSetSize(unsigned int size)
{
	FntSize = size ;
}
unsigned int FontGetSize()
{
	return FntSize;
}

int Font_Get_Glyph(wchar_t c, GUI_FONT_CHAR_DATA *data)
{
	unsigned int index = getFontIndexBySize(FntSize) ;
	std::map<wchar_t,FT_GlyphData*> &FntMap = *FntFace[index]->FntMap;
	
	if(!FntMap.empty() ){
		auto it = FntMap.find(c);
		if (it != FntMap.end()){
			FT_GlyphData* word = (*it).second;

			data->data = word->bitmap.buffer ;
			
			data->region.left_up_x = data->cur_origin_x + word->bitmap_left;
			data->region.left_up_y = data->cur_origin_y + word->bitmap_top;
			
			data->region.w = word->bitmap.width ;
			data->region.h = word->bitmap.rows;
			
			data->XSize = word->advance.x / 64 ;
			data->pitch = word->bitmap.pitch ;
			
			data->next_origin_x = data->cur_origin_x + word->advance.x / 64 ;
			data->next_origin_y = data->cur_origin_y + word->advance.y / 64 ;
			return 1 ;
		}
	}
	
	{
		FT_Vector pen;
		FT_Int32 flags = FT_LOAD_RENDER ;

		pen.x = data->cur_origin_x * 64 ; 	  /* 单位: 1/64像素 */
		pen.y = data->cur_origin_y * 64 ; 	  /* 单位: 1/64像素 */

		FT_Set_Transform(FntFace[index], 0, &pen) ;

		FT_Error error = FT_Load_Char(FntFace[index], c, flags);
		if (error){
			freetype_log_info("FT_Load_Char error\n");
			return -0;
		}


		FntSLot = FntFace[index]->glyph;
		data->data = FntSLot->bitmap.buffer ;
		data->region.left_up_x = FntSLot->bitmap_left;
		data->region.left_up_y = data->cur_origin_y * 2 - FntSLot->bitmap_top;

		data->region.w = FntSLot->bitmap.width ;
		data->region.h = FntSLot->bitmap.rows;

		data->XSize = FntSLot->advance.x / 64 ;
		data->pitch = FntSLot->bitmap.pitch ;

		data->next_origin_x = data->cur_origin_x + FntSLot->advance.x / 64 ;
		data->next_origin_y = data->cur_origin_y + FntSLot->advance.y / 64 ;

		///-----------------------------------------------------------------
		FT_GlyphData* word = new FT_GlyphData;
		
		//ErroPrintf("\'%C\':data->region.left_up_y = %d, bitmap_top = %d\n", c,data->region.left_up_y, FntSLot->bitmap_top);
		word->advance 		= FntSLot->advance;
		word->bitmap 		= FntSLot->bitmap;
		word->bitmap_left 	= FntSLot->bitmap_left - data->cur_origin_x;
		word->bitmap_top 	= data->cur_origin_y - FntSLot->bitmap_top;
		
		int size = FntSLot->bitmap.width*FntSLot->bitmap.rows;
		//ErroPrintf("\'%C\':size = %d\n", c, size);
		word->bitmap.buffer = new unsigned char[size];

		memcpy((void*)word->bitmap.buffer, FntSLot->bitmap.buffer, size);
		
		FntMap.insert({c, word});
		///-----------------------------------------------------------------
	}
	//ErroPrintf("\'%C\':end\n", c);
	return 1 ;
}







void bitmap_printf(const unsigned char *bitmap, int x, int y,  int w, int h)
{
	FT_Int  i, j, p, q;
	FT_Int  x_max = x + w;
	FT_Int  y_max = y + h;

	putchar( '\n' );
	for ( j = y, q = 0; j < y_max; j++, q++ ){
		for ( i = x, p = 0; i < x_max; i++, p++ ){
			if ( i < 0 || j < 0 || i >= 400 || j >= 300 ){
				continue;
			}
			unsigned char v = bitmap[q * w + p];
			putchar(0==v? ' ' : (128 > v ? '+' : '*'));
    	}
		putchar( '\n' );
  }
}



/*------------------------------------------- end of file ---------------------------------------------------*/


