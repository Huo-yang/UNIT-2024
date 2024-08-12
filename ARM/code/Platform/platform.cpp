#include "usrio.h"
#include <stdlib.h>
#include <wchar.h>
#include <math.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <stdarg.h>
#include "platform.h"
#include "printf_define.h"
#define MAX_PATH 256
#ifdef SYS_ARM
#include <unistd.h>

char * wcstostr (const wchar_t* wcs)
{
    static char str[1024];
    wcstombs(str, wcs, sizeof(str));
    return str;
}

wchar_t * strtowcs (const char* str)
{
    static wchar_t wcs[1024];
    mbstowcs(wcs, str, sizeof(wcs));
    return wcs;
}

int waccess(const wchar_t* filename, int _AccessMode)
{
    char fn[MAX_PATH];
    wcstombs(fn, filename, MAX_PATH);
    return access(fn, _AccessMode);
}
int wmkdir(const wchar_t* filename)
{
    char fn[MAX_PATH];
    wcstombs(fn, filename, MAX_PATH);
    return mkdir(fn, S_IRWXU);
}

int wf_open(FILE** fp, const wchar_t* filename, const wchar_t* mode)  
{  
    char fn[MAX_PATH] ={0};
    char m[MAX_PATH] ={0};
    wcstombs(fn, filename, MAX_PATH);
    wcstombs(m, mode, MAX_PATH);
    *fp = fopen(fn, m);
	if(*fp !=0 )
	{
        fseek(*fp, 0L, SEEK_END);
        int len = ftell(*fp);
        fseek(*fp, 0L, SEEK_SET);
        return len;
	}
	else
		return -1;
}

int f_read(void* buff, int len, int _size, int _n, FILE *fp)
{
    return fread(buff, _size, _n, fp);
}

long filesize(const wchar_t* filename)
{
    FILE * fp;
    long size = wf_open(&fp, filename, L"rb");
    fclose(fp);
    usr_printf("filesize:%ls %ld\n",filename, size);
    return size;
}

#else
#include "stdio.h"
#include "windows.h"
void set_console_color(unsigned short color_index)
{
    SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color_index);
}
char * wcstostr (const wchar_t* wcs)
{
    static char str[1024];
    wcstombs(str, wcs, sizeof(str));
    return str;
}
wchar_t * strtowcs (const char* str)
{
    static wchar_t wcs[1024];
    mbstowcs(wcs, str, sizeof(wcs));
    return wcs;
}


int waccess(const wchar_t* filename, int _AccessMode)
{
    return _waccess_s(filename, _AccessMode);
}

int wmkdir(const wchar_t* filename)
{
    return _wmkdir(filename);
}


int wf_open(FILE **fp, const wchar_t* filename, const wchar_t* mode)  
{
	return _wfopen_s(fp, filename, mode);
}
int f_read(void* buff, int len, int _size, int _n, FILE *fp)
{
	return fread_s(buff, len, _size, _n, fp);
}

long filesize(const wchar_t* filename)
{
    FILE * fp;
    long size = 0;
    if(0==wf_open(&fp, filename, L"rb"))
    {
        fseek(fp, 0L, SEEK_END);
        size = ftell(fp);
        fclose(fp);
    }
    return size;
}


const wchar_t * ChangeFormat(const wchar_t *format)
{
    static wchar_t tmp[256] ;
	
	memset(tmp, 0, 256 * sizeof(wchar_t)) ;
    wcscpy(tmp,format);
    for(int i=0; ((i + 1) < sizeof(tmp)/sizeof(*tmp)) && tmp[i];i++)
    {
        if(tmp[i] == L'%' && tmp[i+1]==L'S')
            tmp[i+1]=L's';
    }
    return tmp;
}

int sw_printf(wchar_t *dst,int _Count, const wchar_t *_Format, ...)
{
    va_list _Arglist;
    int _Ret;
    _crt_va_start(_Arglist, _Format);
    _Ret = _vswprintf_c_l(dst, _Count, ChangeFormat(_Format), NULL, _Arglist);
    _crt_va_end(_Arglist);
    return _Ret;
}

#endif

wchar_t * wc_scpy(wchar_t * dest, size_t n, const wchar_t * src)
{
    if(dest == NULL || n <= 0)
        return dest;
    else if(src == NULL)
    {
        *dest = '\0';
    }
    else
    {
        for(size_t i = 0; i < n; i++)
        {
            dest[i] = src[i];
            if(src[i] == '\0')
                return dest;
        }
    }
    dest[n-1] = '\0';
    return dest;
}
wchar_t * wc_scat(wchar_t * dest, size_t n, const wchar_t * src)
{
    if(dest == NULL || n <= 0)
        return dest;
    else if(src == NULL || *src == L'\0')
    {
        return dest;
    }
    else
    {
        size_t index = 0;
		
		dest[n-1] = L'\0';
		
        while(dest[index]) 
		{ 
			index++; 
		}
		
        while(index <n-1 && *src)
        {
        	dest[index++] = *src++;
        }
		
		dest[index] = L'\0';
    }
    return dest;
}

int _SystemPrintf(const char *format, ...)
{
	int status ;
    char cmd[512]={0};
    va_list args;
    va_start(args,format);
    usr_vsprintf(cmd,format,args);
    va_end(args);
    status = SYSTEM(cmd);
	if(status == -1){
		return -1 ;
	}
	else if((WIFEXITED(status) > 0) && (WEXITSTATUS(status) == 0)){
		return 1 ;
	}
	return 0 ;
}



