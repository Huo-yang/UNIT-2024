#ifndef __MAIN_H__
#define __MAIN_H__
#include <arpa/inet.h>
#include <time.h>
#include <unistd.h>
#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/times.h>
#include <fcntl.h>
#include <linux/input.h>
#include <unistd.h>
#include <time.h>
#include <net/if.h>
#include <netinet/in.h>
#include "touch_screen.h"
#include "Type.h"
#include "uart.h"
#include "usrio.h"
#include "uart_key.h"
#include "ui.h"

// 多线程
#define NUM_THREADS 3

extern bool ip_status;

#endif
