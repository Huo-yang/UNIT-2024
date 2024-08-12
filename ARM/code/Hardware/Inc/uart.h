#ifndef _uart_HEAD
#define _uart_HEAD

#include     <stdio.h>      /*标准输入输出定义*/
#include     <stdlib.h>     /*标准函数库定义*/
#include     <unistd.h>     /*Unix 标准函数定义*/
#include     <sys/types.h>
#include     <sys/stat.h>
#include     <string.h>
#include     <fcntl.h>      /*文件控制定义*/
#include     <termios.h>    /*PPSIX 终端控制定义*/
#include     <errno.h>      /*错误号定义*/
#include    <termios.h>

#include "Type.h"
#include "uart_key.h"
#include "printf_define.h"
/*
*@param  speed 230400,115200,57600,38400,  19200,  9600,  4800,  2400,  1200,  300, 38400,  
                    19200,  9600, 4800, 2400, 1200,  300
*@param  databits 类型  int 数据位   取值 为 7 或者8
*@param  stopbits 类型  int 停止位   取值为 1 或者2
*@param  parity  类型  int  效验类型 取值为N,E,O,,S
*/
int OpenUart(const char *Dev, int speed, int databits, int stopbits, int parity);
int OpenUartTmc(const char *Dev) ;


#endif
