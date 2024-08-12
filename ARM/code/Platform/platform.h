#pragma once
//#ifndef _PLATFORM_H_
//#define _PLATFORM_H_
#include "usrio.h"

//#include <Assistant.h>
#define STR_MAX_LEN 1024

#ifdef SYS_ARM
#include "usrio.h"
#include <sys/stat.h>
#include <unistd.h>
#include <wchar.h>
#include <stdlib.h>
#include "../Inc/Define.h"

#define sw_printf               swprintf

#define wstrtol(wstr)   wcstol(wstr, NULL, 10)
#define wstrtoul(wstr)  wcstoul(wstr, NULL, 10)
#define wstrtoll(wstr)  wcstoll(wstr, NULL, 10)
#define wstrtoull(wstr) wcstoull(wstr, NULL, 10)
#define wstrtof(wstr)   wcstof(wstr, NULL)
#define wstrtod(wstr)   wcstod(wstr, NULL)
#define usr_vsprintf vsprintf
#define SYSTEM(x) system(x)
#else
#include <stdlib.h>
#include <io.h>
#include <direct.h>
#include "stdio.h"
#include "stdarg.h"

const wchar_t * ChangeFormat(const wchar_t *format);
int sw_printf(wchar_t *dst,int _Count, const wchar_t *_Format, ...);

//#define sw_printf(dst, len, cmd,...) swprintf_s(dst, len, ChangeFormat(cmd),...)


#define wstrtol _wtol
#define wstrtoul _wtol
#define wstrtoll _wtoi64
#define wstrtoull _wtoi64
#define wstrtof _wtof
#define wstrtod _wtof
#define usr_vsprintf vsprintf_s
#define SYSTEM(x)
#endif

#ifdef SYS_ARM
#define xstrtok             strtok_r
#define xstrtoi             strtol
#define xstrtod             strtod
#define xitoa(i,str)        sprintf(str,"%d",i)
#else
#define xstrtok             strtok_s
#define xstrtoi             strtol
#define xstrtod             strtod
#define xitoa(i,str)        itoa(i,str, 10)
#endif
wchar_t * wc_scpy(wchar_t * __dest, size_t __n, const wchar_t * __src);
wchar_t * wc_scat(wchar_t * __dest, size_t __n, const wchar_t * __src);

inline int hexToNum(int wc, int &hex)
{
	hex = 0;
	if(wc >= '0' && wc <= '9')
		hex = wc - '0';
	else if(wc >= 'a' && wc <= 'f')
		hex = 10 + wc - 'a';
	else if(wc >= 'A' && wc <= 'F')
		hex = 10 + wc - 'A';
	else
		return false;
	return true;
}
char * wcstostr (const wchar_t* wcs);
wchar_t * strtowcs (const char* str);
int waccess(const wchar_t* filename, int _AccessMode);
int wmkdir(const wchar_t* filename);
long filesize(const wchar_t* filename);
int wf_open(FILE** fp, const wchar_t* filename, const wchar_t* mode);
int f_read(void* buff, int len, int _size, int _n, FILE *fp);

#include "stdio.h"
#include "stdarg.h"
//
int _SystemPrintf(const char *format, ...);

//#define SystemPrintf usr_printf("%s::%s<%d>:", __FILE__, __FUNCTION__, __LINE__),_SystemPrintf
#define SystemPrintf _SystemPrintf





