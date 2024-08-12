/*
 * @Author: song sds0222@163.com
 * @Date: 2023-04-12 16:01:15
 * @LastEditors: song sds0222@163.com
 * @LastEditTime: 2023-04-12 16:30:04
 * @FilePath: \Graduate_Demo\mso2000\Display\FontManager.cpp
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
/*
 * @Author: song sds0222@163.com
 * @Date: 2023-04-11 19:47:40
 * @LastEditors: song sds0222@163.com
 * @LastEditTime: 2023-04-12 15:59:41
 * @FilePath: \Graduate_Demo\mso2000\Display\FontManager.cpp
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
#include "usrio.h"
#include "platform.h"
#include "FontManager.h"



//#define STR_MAX_LEN 1024
#include "usrio.h"

#include <dlfcn.h>

#include <iostream>
#include <gnu/lib-names.h>
#include <Inc/Type.h>
#include "ut_freetype.h"


using namespace std;



GUI_FONT_CHAR_DATA pFntLib;
void Fnt_Init(void)
{
    printf("[UI]------FreeType init------\n");
	ut_freetype_init(0, 0, 0);
}


static FONT_SIZE Font_Curr_Size = FONT_SIZE_16;
FONT_SIZE Fnt_Get_Size(void)
{
	return Font_Curr_Size;
}


void Fnt_Set(FONT_SIZE size)
{
//    printf("font size:%d\n", size);
	pFntLib.XSize = size;
	pFntLib.YSize = size;
	
	FontSetSize(size);
	Font_Curr_Size = size;
}

GUI_FONT_CHAR_DATA * Fnt_GetLib()
{
	return &pFntLib ;
}

const GUI_FONT_CHAR_DATA * Fnt_Find_Word(UI_CHAR uc)
{
    Font_Get_Glyph(uc, &pFntLib) ;
	return &pFntLib ;
}

int Fnt_Find_Glyph(UI_CHAR uc, GUI_FONT_CHAR_DATA *data)
{
	return Font_Get_Glyph(uc, data) ;
}

int Fnt_Width_Word(wchar_t uc)
{
	return Fnt_Find_Word(uc)->XSize ;
}
int Fnt_Height_Word(wchar_t uc)
{
	return Fnt_Find_Word(uc)->YSize ;
}

int Fnt_Height()
{
	return pFntLib.YSize ;
}

int Fnt_Width_Tab(void)
{
    return 2*Fnt_Width_Word(L'　');
}


int Fnt_Width_WStr(const wchar_t *pcstr)
{
    int Width  = 0;
    while(*pcstr)
    {
        if(*pcstr == '\n' || *pcstr == '\r')
            break;
        Width += Fnt_Width_Word(*pcstr);
        pcstr ++;
    }
    return Width;
}


#define STR_MAX_SPLIT_LEN 1024
const UI_CHAR *Fnt_WordSeparation(const UI_CHAR *Instr, UI_CHAR *strBuff)
{
    const UI_CHAR *str = Instr;
    while(*str)
    {
        if(str > Instr + sizeof(UI_CHAR)*STR_MAX_SPLIT_LEN - 4)
            break;

        if(*(INT8U*)str >=0x2000)
        {
            *strBuff++ = *str++;
            break;
        }
        else if((*str >= L'a') && (*str <= L'z'))
            *strBuff++ = *str++;
        else if((*str >= L'A') && (*str <= L'Z'))
            *strBuff++ = *str++;
        else if((*str >= L'0') && (*str <= L'9'))
            *strBuff++ = *str++;
        else if((*str == L'.')||(*str == L','))
        {
            if(((*(str-1) >= L'0') && (*(str-1) <= L'9')) && ((*(str+1) >= L'0') && (*(str+1) <= L'9')))
                *strBuff++ = *str++;
            else
            {
                *strBuff++ = *str++;
                break;
            }
        }
        else if(*str == L'\n')
            break;
        else
        {
            *strBuff++ = *str++;
            break;
        }
    }
    *strBuff = '\0';

    return str;
}
