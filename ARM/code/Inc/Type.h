#pragma once

#include <limits>
#include <stdint.h>
#include <float.h>
#include "usrio.h"

#define F_OK 0
#define X_OK 1
#define W_OK 2
#define R_OK 4

#define KHZ_TO_PICOS(a) ((a>0)?(1000000000000ULL/(a)):0)

#ifdef __cplusplus
extern "C" { //h
#endif

#ifndef NULL
#define NULL    ((void *)0)
#endif

#ifndef FALSE
#define FALSE   (0)
#endif
#ifndef TRUE
#define TRUE    (1)
#endif
#ifndef Bool
typedef unsigned char Bool;
#endif
#ifndef DWORD
typedef unsigned long  DWORD;
#endif
#ifndef WORD
typedef unsigned short WORD;
#endif
#ifndef BYTE
typedef unsigned char BYTE;
#endif

#ifndef uint8
typedef unsigned char uint8;
#endif
#ifndef int8
typedef signed char int8;
#endif
#ifndef uint16
typedef unsigned short uint16;
#endif
#ifndef int16
typedef signed short int16;
#endif
#ifndef uint32
typedef unsigned int uint32;
#endif
#ifndef int32
typedef signed int int32;
#endif
#ifndef fp32
typedef float fp32;
#endif
#ifndef fp64
typedef double fp64;
#endif
#ifndef uint64
typedef unsigned long long uint64;
#endif
#ifndef ulong
typedef unsigned long ulong;
#endif
#ifndef uchar
typedef unsigned char uchar;
#endif
#ifndef schar
typedef signed char schar;
#endif
#ifndef ushort
typedef unsigned short ushort;
#endif
#ifndef uint
typedef unsigned int uint;
#endif
#ifndef sint
typedef signed int sint;
#endif
#ifndef ullong
typedef unsigned long long ullong;
#endif
#ifndef sllong
typedef signed long long sllong;
#endif
#ifndef INT8U
typedef unsigned char INT8U;
#endif
#ifndef INT8S
typedef signed char INT8S;
#endif
#ifndef INT16U
typedef unsigned short INT16U;
#endif
#ifndef INT16S
typedef signed short INT16S;
#endif
#ifndef INT32U
typedef unsigned int INT32U;
#endif
#ifndef INT32S
typedef signed int INT32S;
#endif
#ifndef FP32
typedef float FP32;
#endif
#ifndef FP64
typedef double FP64;
#endif
#ifndef INT64U
typedef unsigned long long INT64U;
#endif
#ifndef INT64S
typedef signed long long INT64S;
#endif
#ifndef INT8
typedef signed char INT8;
#endif
#ifndef INT16
typedef short int INT16;
#endif
#ifndef INT32
//typedef int INT32;
#endif
#ifndef INT32L
typedef unsigned long INT32L;
#endif
#ifndef INT32_UL
typedef unsigned long INT32_UL;
#endif
#ifndef INT32_L
typedef long INT32_L;
#endif
#ifndef U8
typedef unsigned char U8;
#endif
#ifndef S8
typedef signed char S8;
#endif
#ifndef U16
typedef unsigned short U16;
#endif
#ifndef S16
typedef signed short S16;
#endif
#ifndef U32
//typedef unsigned int U32;
#endif
#ifndef S32
typedef signed int S32;
#endif
#ifndef U64
typedef unsigned long long U64;
#endif
#ifndef S64
typedef signed long long S64;
#endif
#ifndef F32
typedef float F32;
#endif
#ifndef F64
typedef double F64;
#endif
#ifndef UINT8
typedef INT8U UINT8;
#endif
#ifndef SINT8
typedef INT8S SINT8;
#endif
#ifndef UINT16
typedef INT16U UINT16;
#endif
#ifndef SINT16
typedef INT16S SINT16;
#endif
#ifndef UINT32
typedef INT32U UINT32;
#endif
#ifndef SINT32
typedef INT32S SINT32;
#endif

#ifndef ticker_t
typedef unsigned long long ticker_t;
#endif

typedef signed char DisData;

#define element(x) (sizeof(x)/sizeof(*(x)))

#define PI  3.14159265358979323846

#define CHAR_MULTI_BYTE

#ifdef CHAR_MULTI_BYTE

#include "wchar.h"
#ifndef _T
#define _T(x) L##x
#endif
#define  UI_CHAR wchar_t

#define xstrlen wcslen
#define xstrcat wcscat

#else

#define _T(x) x
typedef  char UI_CHAR;
#endif

#ifdef __cplusplus
} //extern "C" { //h
#endif

#ifndef UINT_LEAST8_MAX
# define UINT_LEAST8_MAX	(255)
#endif

#ifndef UINT_LEAST16_MAX
# define UINT_LEAST16_MAX	(65535)
#endif

#ifndef UINT_LEAST32_MAX
# define UINT_LEAST32_MAX	(4294967295U)
#endif

#ifndef UINT_LEAST64_MAX
# define UINT_LEAST64_MAX	(__UINT64_C(18446744073709551615))
#endif

#ifndef INT_LEAST8_MAX
# define INT_LEAST8_MAX		(127)
#endif

#ifndef INT_LEAST16_MAX
# define INT_LEAST16_MAX	(32767)
#endif

#ifndef INT_LEAST32_MAX
# define INT_LEAST32_MAX	(2147483647)
#endif

#ifndef INT_LEAST64_MAX
# define INT_LEAST64_MAX	(__INT64_C(9223372036854775807))
#endif

#ifndef INT_LEAST8_MIN
# define INT_LEAST8_MIN		(-128)
#endif

#ifndef INT_LEAST16_MIN
# define INT_LEAST16_MIN	(-32767-1)
#endif

#ifndef INT_LEAST32_MIN
# define INT_LEAST32_MIN	(-2147483647-1)
#endif

#ifndef INT_LEAST64_MIN
# define INT_LEAST64_MIN	(-__INT64_C(9223372036854775807)-1)
#endif










