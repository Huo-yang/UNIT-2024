#ifndef COLOR_H
#define COLOR_H

#define ConvRGB(RGB)		(RGB)
#define MakeRGB(R, G, B)	(GUI_RGB)( (((R)&0xfF)<<16) |(((G)&0xfF)<<8) | ((B)&0xfF) )
#define MakeRGBA(R, G, B, A)	(GUI_RGB)( (((A)&0xfF)<<24) |(((R)&0xfF)<<16) |(((G)&0xfF)<<8) | ((B)&0xfF) )

#define ClrAliceBlue			ConvRGB(0xF0F8FF)
#define ClrAntiqueWhite 		ConvRGB(0xFAEBD7)
#define ClrAqua 				ConvRGB(0x00FFFF)
#define ClrAquamarine			ConvRGB(0x7FFFD4)
#define ClrAzure				ConvRGB(0xF0FFFF)
#define ClrBeige				ConvRGB(0xF5F5DC)
#define ClrBisque				ConvRGB(0xFFE4C4)
#define ClrBlack				ConvRGB(0x000000)
#define ClrBlanchedAlmond		ConvRGB(0xFFEBCD)
#define ClrBlue 				ConvRGB(0x0000FF)
#define ClrBlueViolet			ConvRGB(0x8A2BE2)
#define ClrBrown				ConvRGB(0xA52A2A)
#define ClrBurlyWood			ConvRGB(0xDEB887)
#define ClrCadetBlue			ConvRGB(0x5F9EA0)
#define ClrChartreuse			ConvRGB(0x7FFF00)
#define ClrChocolate			ConvRGB(0xD2691E)
#define ClrCoral				ConvRGB(0xFF7F50)
#define ClrCornflowerBlue		ConvRGB(0x6495ED)
#define ClrCornsilk 			ConvRGB(0xFFF8DC)
#define ClrCrimson				ConvRGB(0xDC143C)
#define ClrCyan 				ConvRGB(0x00FFFF)
#define ClrDarkBlue 			ConvRGB(0x00008B)
#define ClrDarkCyan 			ConvRGB(0x008B8B)
#define ClrDarkGoldenrod		ConvRGB(0xB8860B)
#define ClrDarkGray 			ConvRGB(0xA9A9A9)
#define ClrDarkGreen			ConvRGB(0x006400)
#define ClrDarkKhaki			ConvRGB(0xBDB76B)
#define ClrDarkMagenta			ConvRGB(0x8B008B)
#define ClrDarkOliveGreen		ConvRGB(0x556B2F)
#define ClrDarkOrange			ConvRGB(0xFF8C00)
#define ClrDarkOrchid			ConvRGB(0x9932CC)
#define ClrDarkRed			    ConvRGB(0x8B0000)
#define ClrDarkSalmon			ConvRGB(0xE9967A)
#define ClrDarkSeaGreen 		ConvRGB(0x8FBC8F)
#define ClrDarkSlateBlue		ConvRGB(0x483D8B)
#define ClrDarkSlateGray		ConvRGB(0x2F4F4F)
#define ClrDarkTurquoise		ConvRGB(0x00CED1)
#define ClrDarkViolet			ConvRGB(0x9400D3)
#define ClrDeepPink 			ConvRGB(0xFF1493)
#define ClrDeepSkyBlue		    ConvRGB(0x00BFFF)
#define ClrDimGray			    ConvRGB(0x696969)
#define ClrDodgerBlue			ConvRGB(0x1E90FF)
#define ClrFireBrick			ConvRGB(0xB22222)
#define ClrFloralWhite			ConvRGB(0xFFFAF0)
#define ClrForestGreen			ConvRGB(0x228B22)
#define ClrFuchsia				ConvRGB(0xFF00FF)
#define ClrGainsboro			ConvRGB(0xDCDCDC)
#define ClrGhostWhite			ConvRGB(0xF8F8FF)
#define ClrGold 				ConvRGB(0xFFD700)
#define ClrGoldenrod			ConvRGB(0xDAA520)
#define ClrGray 				ConvRGB(0x808080)
#define ClrGreen				ConvRGB(0x00ff00)
#define ClrGreenYellow			ConvRGB(0xADFF2F)
#define ClrHoneydew 			ConvRGB(0xF0FFF0)
#define ClrHotPink				ConvRGB(0xFF69B4)
#define ClrIndianRed			ConvRGB(0xCD5C5C)
#define ClrIndigo				ConvRGB(0x4B0082)
#define ClrIvory				ConvRGB(0xFFFFF0)
#define ClrKhaki				ConvRGB(0xF0E68C)
#define ClrLavender 			ConvRGB(0xE6E6FA)
#define ClrLavenderBlush		ConvRGB(0xFFF0F5)
#define ClrLawnGreen			ConvRGB(0x7CFC00)
#define ClrLemonChiffon 		ConvRGB(0xFFFACD)
#define ClrLightBlue			ConvRGB(0xADD8E6)
#define ClrLightCoral			ConvRGB(0xF08080)
#define ClrLightCyan			ConvRGB(0xE0FFFF)
#define ClrLightGoldenrodYellow ConvRGB(0xFAFAD2)
#define ClrLightGreen			ConvRGB(0x90EE90)
#define ClrLightGrey			ConvRGB(0xD3D3D3)
#define ClrLightPink			ConvRGB(0xFFB6C1)
#define ClrLightSalmon			ConvRGB(0xFFA07A)
#define ClrLightSeaGreen		ConvRGB(0x20B2AA)
#define ClrLightSkyBlue 		ConvRGB(0x87CEFA)
#define ClrLightSlateGray		ConvRGB(0x778899)
#define ClrLightSteelBlue		ConvRGB(0xB0C4DE)
#define ClrLightYellow			ConvRGB(0xFFFFE0)
#define ClrLime 				ConvRGB(0x00FF00)
#define ClrLimeGreen			ConvRGB(0x32CD32)
#define ClrLinen				ConvRGB(0xFAF0E6)
#define ClrMagenta				ConvRGB(0xFF00FF)
#define ClrMaroon				ConvRGB(0x800000)
#define ClrMediumAquamarine 	ConvRGB(0x66CDAA)
#define ClrMediumBlue			ConvRGB(0x0000CD)
#define ClrMediumOrchid 		ConvRGB(0xBA55D3)
#define ClrMediumPurple 		ConvRGB(0x9370DB)
#define ClrMediumSeaGreen		ConvRGB(0x3CB371)
#define ClrMediumSlateBlue		ConvRGB(0x7B68EE)
#define ClrMediumSpringGreen	ConvRGB(0x00FA9A)
#define ClrMediumTurquoise	    ConvRGB(0x48D1CC)
#define ClrMediumVioletRed		ConvRGB(0xC71585)
#define ClrMidnightBlue 		ConvRGB(0x191970)
#define ClrMintCream			ConvRGB(0xF5FFFA)
#define ClrMistyRose			ConvRGB(0xFFE4E1)
#define ClrMoccasin 			ConvRGB(0xFFE4B5)
#define ClrNavajoWhite			ConvRGB(0xFFDEAD)
#define ClrNavy 				ConvRGB(0x000080)
#define ClrOldLace				ConvRGB(0xFDF5E6)
#define ClrOlive				ConvRGB(0x808000)
#define ClrOliveDrab			ConvRGB(0x6B8E23)
#define ClrOrange				ConvRGB(0xFFA500)
#define ClrOrangeRed			ConvRGB(0xFF4500)
#define ClrOrchid				ConvRGB(0xDA70D6)
#define ClrPaleGoldenrod		ConvRGB(0xEEE8AA)
#define ClrPaleGreen			ConvRGB(0x98FB98)
#define ClrPaleTurquoise		ConvRGB(0xAFEEEE)
#define ClrPaleVioletRed		ConvRGB(0xDB7093)
#define ClrPapayaWhip			ConvRGB(0xFFEFD5)
#define ClrPeachPuff			ConvRGB(0xFFDAB9)
#define ClrPeru 				ConvRGB(0xCD853F)
#define ClrPink 				ConvRGB(0xFFC0CB)
#define ClrPlum 				ConvRGB(0xDDA0DD)
#define ClrPowderBlue			ConvRGB(0xB0E0E6)
#define ClrPurple				ConvRGB(0x800080)
#define ClrRed				    ConvRGB(0xFF0000)
#define ClrRosyBrown			ConvRGB(0xBC8F8F)
#define ClrRoyalBlue			ConvRGB(0x4169E1)
#define ClrSaddleBrown		    ConvRGB(0x8B4513)
#define ClrSalmon				ConvRGB(0xFA8072)
#define ClrSandyBrown			ConvRGB(0xF4A460)
#define ClrSeaGreen 			ConvRGB(0x2E8B57)
#define ClrSeashell 			ConvRGB(0xFFF5EE)
#define ClrSienna				ConvRGB(0xA0522D)
#define ClrSilver				ConvRGB(0xC0C0C0)
#define ClrSkyBlue				ConvRGB(0x87CEEB)
#define ClrSlateBlue			ConvRGB(0x6A5ACD)
#define ClrSlateGray			ConvRGB(0x708090)
#define ClrSnow 				ConvRGB(0xFFFAFA)
#define ClrSpringGreen			ConvRGB(0x00FF7F)
#define ClrSteelBlue			ConvRGB(0x4682B4)
#define ClrTan					ConvRGB(0xD2B48C)
#define ClrTeal 				ConvRGB(0x008080)
#define ClrThistle				ConvRGB(0xD8BFD8)
#define ClrTomato				ConvRGB(0xFF6347)
#define ClrTurquoise			ConvRGB(0x40E0D0)
#define ClrViolet				ConvRGB(0xEE82EE)
#define ClrWheat				ConvRGB(0xF5DEB3)
#define ClrWhite				ConvRGB(0xFFFFFF)
#define ClrWhiteSmoke			ConvRGB(0xF5F5F5)
#define ClrYellow				ConvRGB(0xFFFF00)
#define ClrYellowGreen			ConvRGB(0x9ACD32)



typedef enum
{
	IRGB_Background  = ConvRGB(0x000000),
	IRGB_BASE_WAVE	 = ConvRGB(0xF8F800),
	IRGB_MOD_WAVE    = ConvRGB(0x00F800),
	IRGB_MIX_WAVE    = ConvRGB(0xFFFFFF),
	IRGB_Text        = ConvRGB(0xFFFFFF),
	IRGB_Text_Dim    = ConvRGB(0xA0A0A0),
	IRGB_Text_Tip    = ConvRGB(0xF8F800),
	IRGB_BTN_Darker  = ConvRGB(0x505050),
	IRGB_BTN_Darkest = ConvRGB(0x181818),
	IRGB_BTN_Light	 = ConvRGB(0x909090),
	IRGB_BTN_Lighter = ConvRGB(0xD0D0D0),
	IRGB_BTN_Lightest= ConvRGB(0xFFFFFF),
	IRGB_Red         = ConvRGB(0xF80000),

	IRGB_Total = 13
}CstColors;


#define RGB_Background		ClrGold//IRGB_Background
#define RGB_BASE_WAVE		IRGB_BASE_WAVE
#define RGB_MOD_WAVE		IRGB_MOD_WAVE
#define RGB_MIX_WAVE		IRGB_MIX_WAVE
#define RGB_Text			IRGB_Text
#define RGB_Text_Dim		IRGB_Text_Dim
#define RGB_Text_Tip		IRGB_Text_Tip
#define RGB_BTN_Darker		IRGB_BTN_Darker
#define RGB_BTN_Darkest		IRGB_BTN_Darkest
#define RGB_BTN_Light		IRGB_BTN_Light
#define RGB_BTN_Lighter		IRGB_BTN_Lighter
#define RGB_BTN_Lightest	IRGB_BTN_Lightest
#define RGB_Red		        IRGB_Red
#define RGB_ProgressBar		ClrSilver
#define RGB_ProgressBarFill ClrGreenYellow

#define GetBaseWaveColor(ch) ((ch>0)?ClrCyan:ClrYellow)
#define GetModeWaveColor(ch) ((ch>0)?ClrCyan:ClrYellow)

//GUI_RGB GetChCheckedColor(int ch);







//颜色定义

#define GUI_CONV_RGB(R, G, B)	((GUI_RGB)((( B&0xFFU)<<0) | (( G&0xFFU)<<8) | (( R&0xFFU)<<16)))

#define GUI_RED			0xFF0000
#define GUI_GREEN	 	0x00FF00
#define GUI_BLUE 		0x0000FF
#define GUI_CYAN		(GUI_BLUE | GUI_GREEN)                     	//0xFFFF00
#define GUI_MAGENTA		(GUI_RED | GUI_BLUE)                       	//0xFF00FF
#define GUI_YELLOW 		(GUI_RED | GUI_GREEN)




#define GUI_DEEP_PINK		0xFF1493
#define GUI_ORANGE1			0xFFA500

#define GUI_DARK_CYAN		0x00CDCD
#define GUI_DARK_YELLOW		0xCDCD00
#define GUI_DARK_GREEN		0x00CD00
#define GUI_DARK_MAGENTA	0xEE82EE

#define GUI_LIGHTRED      0xFF8080
#define GUI_LIGHTGREEN    0x80FF80
#define GUI_LIGHTBLUE     0x8080FF
#define GUI_LIGHTCYAN     (GUI_LIGHTBLUE | GUI_LIGHTGREEN)          //0xFFFF80
#define GUI_LIGHTMAGENTA  (GUI_LIGHTRED | GUI_LIGHTBLUE)            //0xFF80FF
#define GUI_LIGHTYELLOW   (GUI_LIGHTRED | GUI_LIGHTGREEN)           //0x80FFFF

#define GUI_DARKRED       0x800000
#define GUI_DARKGREEN     0x008000
#define GUI_DARKBLUE      0x000080
#define GUI_DARKCYAN      (GUI_DARKRED | GUI_DARKGREEN)             //0x808000
#define GUI_DARKMAGENTA   (GUI_DARKRED | GUI_DARKCYAN)              //0x800080
#define GUI_DARKYELLOW    (GUI_DARKBLUE | GUI_DARKGREEN)            //0x008080





#define GUI_WHITE 		0xFFFFFF
#define GUI_LIGHTGRAY   0xD3D3D3
#define GUI_GRAY        0x808080
#define GUI_LIGHT_GRAY  0xB0B0B0
#define GUI_DARKGRAY    0x404040
#define GUI_BLACK 		0x000000
#define GUI_SEL_BLUE	0x19538C
#define GUI_FREQ_TRIG	0xdf9300

#define GUI_ORANGE		(0xe260)
#define GUI_BROWN       GUI_CONV_RGB(0x2A, 0x2A, 0xA5)						//0x2A2AA5

#define GUI_DKGRAY		GUI_CONV_RGB(93, 93, 93)
#define GUI_DKGRAY2		GUI_CONV_RGB(200, 200, 200)

#define GUI_XY_INDICATE MakeRGB(255, 140, 16)

//业务含义的颜色
#define GUI_COLOR_SCREENBACK 	GUI_BLACK

//解码颜色


#define GUI_VALUE_COLOR			GUI_WHITE
#define GUI_SELECTED_COLOR		GUI_BLUE



#define COLOR_CH1			GUI_CYAN
#define COLOR_CH2			GUI_YELLOW
#define COLOR_CH3			GUI_GREEN
#define COLOR_CH4			GUI_MAGENTA
#define COLOR_MATH			GUI_RED


#endif // COLOR_H
