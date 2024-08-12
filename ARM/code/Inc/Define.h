#pragma once
#ifndef UNREFERENCED_PARAMETER
#ifdef SYS_ARM
#define UNREFERENCED_PARAMETER(x)
#else
#define UNREFERENCED_PARAMETER(x) (x)
#endif
#endif

#ifdef SYS_ARM
#include "unistd.h"
#define ssync()
#define uSleep(x) usleep(x)
#define mSleep(x) usleep(1000*(x))
//#define uSleep(x) do{ErroPrintf("usleep(%d)\r\n",x);usleep((x)); }while(0)//usleep(x)
//#define mSleep(x) do{ErroPrintf("mSleep(%d)\r\n",x);usleep(1000*(x)); }while(0)
#else
#include"QThread"
#define uSleep(x) QThread::usleep(x)
#define mSleep(x) QThread::msleep(x)
#endif
#define BW_200MHZ
typedef unsigned long long ullong;
typedef signed   long long llong;
typedef unsigned long      ulong;
typedef unsigned short     ushort;
typedef unsigned char      uchar;
typedef unsigned int       uint;

typedef unsigned int   size_t;
typedef signed char  xscale_t; 	//X档位刻度
typedef llong  xtime_t;     //ps为单位
typedef long  xsample_t;   	//抽点倍数
typedef llong  xclock_t;    //采样时钟
typedef llong  xdepth_t;    //存储深度
typedef llong  xindex_t;    //存储顺序
typedef short  vdisp_t;    //显示数据类型
typedef uchar  vacq_t;    //采集数据类型
typedef uint  vlogic_t;    //LA
typedef uchar menu_val;

#define mux_type_size sizeof(ullong)

#ifdef __cplusplus
union mux_type
{
    ullong vull;
    template<typename T>
    void set ( T v )
    {
        memcpy ( &vull,&v,sizeof ( v ) );
    }
    template<typename T>
    void set ( int i, T v )
    {
        ( ( T* ) &vull ) [i] = v;
    }
    template<typename T>
    T& get ( int i=0 )
    {
        return ( ( T* ) &vull ) [i];
    }
};

enum eValueType:uint
{
	eVT_bool,
	eVT_char,
    eVT_schar,
	eVT_uchar,
	eVT_wchar,
	eVT_short,
	eVT_ushort,
	eVT_int,
	eVT_uint,
	eVT_long,
	eVT_ulong,
	eVT_llong,
	eVT_ullong,
	eVT_float,
	eVT_double,
	eVT_str,
	eVT_wstr,
	eVT_bin,
	eVT_erro
};

struct ValueInfo
{
    eValueType Type;
    void *pData;
    int Size;
    int (*FnOnKey)(int key, void * pData, const wchar_t* str);
};

inline eValueType TypeOf(bool)       {return eVT_bool;}
inline eValueType TypeOf(signed char){return eVT_schar;}
inline eValueType TypeOf(char)       {return eVT_char;}
inline eValueType TypeOf(uchar)      {return eVT_uchar;}
inline eValueType TypeOf(wchar_t)    {return eVT_wchar;}
inline eValueType TypeOf(short)      {return eVT_short;}
inline eValueType TypeOf(ushort)     {return eVT_ushort;}
inline eValueType TypeOf(int)        {return eVT_int;}
inline eValueType TypeOf(uint)       {return eVT_uint;}
inline eValueType TypeOf(long)       {return eVT_long;}
inline eValueType TypeOf(ulong)      {return eVT_ulong;}
inline eValueType TypeOf(llong)      {return eVT_llong;}
inline eValueType TypeOf(ullong)     {return eVT_ullong;}
inline eValueType TypeOf(float)      {return eVT_float;}
inline eValueType TypeOf(double)     {return eVT_double;}
inline eValueType TypeOf(char *)     {return eVT_str;}
inline eValueType TypeOf(wchar_t *)  {return eVT_wstr;}
inline eValueType TypeOf(void *)     {return eVT_bin;}

inline bool TypeIsFixed ( eValueType type )
{
	switch ( type )
	{
		case eVT_char:
		case eVT_uchar:
		case eVT_schar:
		case eVT_wchar:
		case eVT_short:
		case eVT_ushort:
		case eVT_int:
		case eVT_uint:
		case eVT_long:
		case eVT_ulong:
		case eVT_llong:
		case eVT_ullong:
			return true;
		default:
			return false;
	}
}

template<typename T, typename T1, typename T2>
inline T LIMIT(T &v, T1 min, T2 max)
{
    if(v < (T)min)
        v = (T)min;
    else if (v > (T)max)
        v = (T)max;
    return v;
}

#define MIN(a, b) ((a)<(b)?(a):(b))
#define MAX(a, b) ((a)>(b)?(a):(b))

#endif
