#ifndef __UART_KEY_H__
#define	__UART_KEY_H__
#include <stdio.h>      /*标准输入输出定义*/
#include <stdlib.h>     /*标准函数库定义*/
#include <unistd.h>     /*Unix 标准函数定义*/
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <fcntl.h>      /*文件控制定义*/
#include <termios.h>    /*PPSIX 终端控制定义*/
#include <errno.h>      /*错误号定义*/
#include "Define.h"
#include "ui_display.h"
#include "product.h"
#include "KeyCode.h"
#include "printf_define.h"
#include "hkb.h"
#include "uart.h"
#include "FPGA.h"
#include "Hardware.h"

#define KEY_LOCK_NOTICE_TIME 1000
#define KEY_VALUE unsigned char

int UartKeyBoard_Write(unsigned int LED);
void* UartKeyBoard(void* threadid);
void deal_key();
unsigned char read_key();
void renew_key();

extern void SetKeyLockNoticeTime(uint t);
#endif


