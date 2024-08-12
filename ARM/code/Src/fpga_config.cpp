#include <Inc/spi_driver.h>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <unistd.h>
#include "printf_define.h"
#include "user_gpio.h"
//#include "spi.h"

#define FPGA_CFG_DEV "/dev/FPGA_CFG"
#define PIN_NUM_PROG GPIO_TO_PIN(5,8)
#define PIN_NUM_DONE GPIO_TO_PIN(5,9)
#define PIN_NUM_INIT GPIO_TO_PIN(5,10)


int FpgaConfig(){
    printf("[UI]------fpga config------\n");
    const char* filename = "/mso2000/fpga/mso2000plus_top.bit";
    FILE* fp = fopen(filename, "rb");
    if (fp == NULL) {
        fprintf(stderr, "[UI]Failed to open file: %s\n", filename);
        return -1;
    }
    printf("[UI]Success to open file: %s\n", filename);
    fseek(fp, 0L, SEEK_END);
    uint file_size = ftell(fp);
    fseek(fp, 0L, SEEK_SET);

    unsigned char *data = (unsigned char*)malloc(file_size + (10 << 10));
    if (data == NULL) {
        fprintf(stderr, "[UI]Failed to allocate memory for file buffer.\n");
        fclose(fp);
        free(data);
        return -1;
    }
    memset(data, 0, file_size);
    if (fread(data, 1, file_size, fp) != file_size) {
        fprintf(stderr, "[UI]Failed to read file contents.\n");
        fclose(fp);
        free(data);
        return -1;
    }
    fclose(fp);

    gpio_export(PIN_NUM_PROG);
    gpio_direction(PIN_NUM_PROG, DIR_OUT);
    gpio_write(PIN_NUM_PROG, 0);
    usleep(2000);
    // 循环检测等待设置完成信号
    int vio_init;
    for (int i = 0; i < 100000; i++) {
        vio_init = gpio_read(PIN_NUM_INIT);
        if (vio_init == 0) {
            break;
        }
    }
    fprintf(stderr, "[UI]init done (PinNumInit == %d)\n", vio_init);
    usleep(2000);
    gpio_write(PIN_NUM_PROG, 1);
    int vio_done;
    for (int i = 0; i < 100000; i++) {
        vio_done = gpio_read(PIN_NUM_DONE);
        if (vio_done == 1) {
            break;
        }
    }
    fprintf(stderr, "[UI]set done (Done = %d)\n", (int)vio_done);
    // 通过spi接口配置FPGA
    int ret_val = -1;
    if (vio_done) {
        spiDriver spi("/dev/spidev2.0", SPI_MODE_0);
        spi.writeAndRead(data, NULL, file_size);
    } else {
        fprintf(stderr, "[UI]FPGA configuration failed.\n");
    }
    free(data);
    gpio_unexport(PIN_NUM_INIT);
    gpio_unexport(PIN_NUM_PROG);
    gpio_unexport(PIN_NUM_DONE);
    return ret_val;
}
