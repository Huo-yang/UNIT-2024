/**
 * @FilePath     : /unit/src/main.cpp
 * @Description  :  
 * @Author       : Huo yang 935585440@qq.com
 * @Version      : 0.0.1
 * @LastEditors  : Huo yang 935585440@qq.com
 * @LastEditTime : 2024-05-31 14:26:48
 * @Copyright    : G AUTOMOBILE RESEARCH INSTITUTE CO.,LTD Copyright (c) 2024.
**/
#include "main.h"

int main(int argc, char** argv)
{
    Opencl my_cl;
    int ret = 0;
    ret = my_cl.Init();
    if (ret == EXIT_FAILURE)
    {
        return 1;
    }
    bool is_bad = 0;
    loadParameter(&my_cl.input.data, WAVE_SIZE, "./bin/wave.bin");
    printf("input array:\n");
    for (int i = 0; i < WAVE_SIZE; i++)
    {
        printf("%f ", my_cl.input.data[i]);
        if((i + 1) % 16 == 0) printf("\n");
    }
    clock_t start,finish;
    start = clock();
    if(my_cl.UnitNet(&is_bad)) return 1;
    finish = clock();
    printf("cost time %ld us\n", (finish - start));
    if (is_bad)
    {
        printf("bad wave\n");
    }
    else printf("good wave\n");
    if(my_cl.UnitNet(&is_bad)) return 1;
    printf("Executed program succesfully.\n");
    return 0;
}
