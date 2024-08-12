#pragma once

#define GPIO_TO_PIN(port, pin) ((port-1)*32 + pin)
#define DIR_IN 0
#define DIR_OUT 1
int gpio_export(int pin);

int gpio_unexport(int pin);
//dir: 0-->IN, 1-->OUT
int gpio_direction(int pin, int dir);
// 0-->none, 1-->rising, 2-->falling, 3-->both
int gpio_edge(int pin, int edge);

int gpio_open(int pin);
int gpio_close(int pin);
int gpio_read_1(int pin);
int gpio_read(int pin);
int gpio_write(int pin, bool v);


