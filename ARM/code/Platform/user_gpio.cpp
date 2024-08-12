#include <fcntl.h>
#include <linux/fb.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "usrio.h"
#include "printf_define.h"

int gpio_export(int pin)
{
    char buffer[64];
    int len;

    snprintf(buffer, sizeof(buffer), "/sys/class/gpio/gpio%d/direction", pin);
    if(0 == access(buffer, F_OK)){
        return 0 ;
    }
    
    int fd = open("/sys/class/gpio/export", O_WRONLY);
    if (fd < 0) {
        Printf("Failed to open export for writing!\n");
        return(-1);
    }

    len = snprintf(buffer, sizeof(buffer), "%d", pin);
    if (write(fd, buffer, len) < 0) {
        Printf("Failed to export gpio!\n");
        return -1;
    }

    close(fd);
    return 0;
}

int gpio_unexport(int pin)
{
    char buffer[64];
    int len;
    int fd;

    fd = open("/sys/class/gpio/unexport", O_WRONLY);
    if (fd < 0) {
        Printf("Failed to open unexport for writing!\n");
        return -1;
    }

    len = snprintf(buffer, sizeof(buffer), "%d", pin);
    if (write(fd, buffer, len) < 0) {
        Printf("Failed to unexport gpio!");
        return -1;
    }

    close(fd);
    return 0;
}
//dir: 0-->IN, 1-->OUT
int gpio_direction(int pin, int dir)
{
    static const char dir_str[] = "in\0out";
    char path[64];
    int fd;

    snprintf(path, sizeof(path), "/sys/class/gpio/gpio%d/direction", pin);
    fd = open(path, O_WRONLY);
    if (fd < 0) {
        Printf("Failed to open gpio direction for writing!\n");
        return -1;
    }

    if (write(fd, &dir_str[dir == 0 ? 0 : 3], dir == 0 ? 2 : 3) < 0) {
        Printf("Failed to set direction!\n");
        return -1;
    }

    close(fd);
    return 0;
}
// 0-->none, 1-->rising, 2-->falling, 3-->both
int gpio_edge(int pin, int edge)
{
    const char *ptr;

    char path[64];
        int fd;
    switch(edge){
    case 0: ptr = "none";    break;
    case 1: ptr = "rising";    break;
    case 2: ptr = "falling";   break;
    case 3: ptr = "both";   break;
    default:ptr = "none"; break;
    }

    snprintf(path, sizeof(path), "/sys/class/gpio/gpio%d/edge", pin);
    fd = open(path, O_WRONLY);
    if (fd < 0) {
        Printf("Failed to open gpio edge for writing!\n");
        return -1;
    }

    if (write(fd, &ptr, strlen(ptr)) < 0) {
        Printf("Failed to set edge!\n");
        return -1;
    }

    close(fd);
    return 0;
}

int fd_gpio[8*32] = {-1};
int gpio_open(int pin)
{
    char path[64];
    snprintf(path, sizeof(path), "/sys/class/gpio/gpio%d/value", pin);
    fd_gpio[pin] = open(path, O_RDONLY);
    if (fd_gpio[pin] < 0) {
     Printf("Failed to open gpio value for reading!\n");
     return -1;
    }
    return fd_gpio[pin];
}
int gpio_close(int pin)
{
    if (fd_gpio[pin] >= 0) {
        close(fd_gpio[pin]);
    }
    return 0;
}

int gpio_read_1(int pin)
{
    char value_str[3];
    if (fd_gpio[pin] >= 0)
    {
        if (read(fd_gpio[pin], value_str, 3) < 0) {
            Printf("Failed to read value!\n");
            return -1;
        }
        else
            return (atoi(value_str));
    }
    else
        return -1;
}

int gpio_read(int pin)
{
    char path[64];
    char value_str[3];
    int fd;

    snprintf(path, sizeof(path), "/sys/class/gpio/gpio%d/value", pin);
    //usr_printf(path);
    fd = open(path, O_RDONLY);
    if (fd < 0) {
        Printf("Failed to open gpio value for reading!\n");
        return -1;
    }

    if (read(fd, value_str, 3) < 0) {
        Printf("Failed to read value!\n");
   		close(fd);
        return -1;
    }

    close(fd);
    return (atoi(value_str));
}

int gpio_write(int pin, bool v)
{
    char path[64];
    char value_str[3]={v?'1':'0'};
    int fd;

    snprintf(path, sizeof(path), "/sys/class/gpio/gpio%d/value", pin);
    //usr_printf(path);
    fd = open(path, O_WRONLY);
    if (fd < 0) {
        Printf("Failed to read gpio%d!\n", pin);
        return -1;
    }
    if (write(fd, value_str, strlen(value_str)) < 0) {
        Printf("Failed to set gpio%d edge!\n", pin);
	    close(fd);
        return -1;
    }
   
    close(fd);
    return 0;
}



