#ifndef __TOUCH_SCREEN_H__
#define __TOUCH_SCREEN_H__

#include <time.h>
#include <unistd.h>
#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/input.h>
#include <unistd.h>
#include <time.h>
#include "Type.h"
#include "Type.h"
#include "ui_display.h"
#include "uart.h"
#include "usrio.h"

struct input_val{
    int x;
    int y;
    bool flag;
};
extern input_val input_v;
// 结构体定义简称
typedef struct input_event input;

void* touch_screen_read (void* threadid);
void deal_touch();

#endif /* INC_TOUCH_SCREEN_H_ */
