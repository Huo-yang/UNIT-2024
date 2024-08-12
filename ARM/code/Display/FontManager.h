#ifndef FONTMANAGER_H
#define FONTMANAGER_H
#include "../Inc/Type.h"
#include "FontLib.h"


extern GUI_FONT_CHAR_DATA pFntLib;

void Fnt_Init(void);

FONT_SIZE Fnt_Get_Size(void);
void Fnt_Set(FONT_SIZE size);
const GUI_FONT_CHAR_DATA * Fnt_Find_Word(UI_CHAR uc);
int Fnt_Find_Glyph(UI_CHAR uc, GUI_FONT_CHAR_DATA *data);
GUI_FONT_CHAR_DATA * Fnt_GetLib();

int Fnt_Width_Word(wchar_t uc);
int Fnt_Width_WStr(const wchar_t *pcstr);
int Fnt_Width_Tab(void);
int Fnt_Height_Word(wchar_t uc);
int Fnt_Height();



#endif // FONTMANAGER_H
