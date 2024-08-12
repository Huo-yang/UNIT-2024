#include "touch_screen.h"

// 定义触摸输入结构体
input_val input_v = {
                     .x = -1,
                     .y = -1,
                     .flag = false
};

void* touch_screen_read (void* threadid)
{
    int fd = -1;
    int ret = -1;
    struct input_event ev = { 0 };
    const int size = sizeof(input);
    fd = open("/dev/input/event1", O_RDONLY);
    if (fd < 0) {
        perror("open");
        return 0;
    }
    while (1) {
        ret = read(fd, &ev, size);
        if (ret != size) {
            close(fd);
            printf("[touch]reade erorr!!!\n");
            return 0;
        }
        if(ev.type == 3 && ev.code == 53)
        {
            input_v.x = ev.value;
        }
        else if(ev.type == 3 && ev.code == 54)
        {
            input_v.y = ev.value;
        }
        else if(ev.type == 1 && ev.code == 330)
        {
            if(input_v.flag == false) input_v.flag = true;
            else{
                input_v.flag = false;
                deal_touch();
                input_v.x = -1;
                input_v.y = -1;
            }
        }
    }
    close(fd);
    return threadid;
}

void deal_touch(){
    if(input_v.x < 800 && input_v.x > 750 && input_v.y < 99 && input_v.y > 44){
        if(tool_bar.Id == 1) tool_bar.Id = 0;
        else tool_bar.Id = 1;
    }
    else if(input_v.x < 800 && input_v.x > 750 && input_v.y < 179 && input_v.y > 124){
        if(tool_bar.Id == 2){
            tool_bar.Id = 0;
            trig_float_bar.Id = 0;
        }
        else tool_bar.Id = 2;
    }
    else if(input_v.x < 800 && input_v.x > 750 && input_v.y < 259 && input_v.y > 204){
        if(tool_bar.Id == 3){
            tool_bar.Id = 0;
            set_float_bar.Id = 0;
        }
        else tool_bar.Id = 3;
    }
    else if(input_v.x < 800 && input_v.x > 750 && input_v.y < 339 && input_v.y > 284){
        if(tool_bar.Id == 4) {
            tool_bar.Id = 0;
            ai_float_bar.Id = 0;
        }
        else tool_bar.Id = 4;
    }
    else if(input_v.x < 800 && input_v.x > 750 && input_v.y < 419 && input_v.y > 364){
        if(tool_bar.Id == 5) tool_bar.Id = 0;
        else tool_bar.Id = 5;
    }
}

