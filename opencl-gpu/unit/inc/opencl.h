/**
 * @FilePath     : /unit/inc/opencl.h
 * @Description  :  
 * @Author       : Huo yang 935585440@qq.com
 * @Version      : 0.0.1
 * @LastEditors  : Huo yang 935585440@qq.com
 * @LastEditTime : 2024-05-30 15:45:40
 * @Copyright    : G AUTOMOBILE RESEARCH INSTITUTE CO.,LTD Copyright (c) 2024.
**/
#ifndef __OPENCL_H__
#define __OPENCL_H__
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <CL/cl.h>

#include "model_parameters.h"
#include "loadParameters.h"

#define WAVE_SIZE 1024

typedef struct _Conv1dData {
    int channel;
    int col;
    float *data;
} Conv1dData;

typedef struct _Conv1dFilter {
    int in_channel;  // 输入通道
    int out_channel;  //输出通道
    int kernel_size;  // 列: 几列
    int stride;
    float *weight_data;
    float *bias_data;
} Conv1dFilter;

typedef struct _BatchNorm1d {
    int size;
    float *mean;
    float *var;
    float *gamma;
    float *beta;
} BatchNorm1d;

typedef struct _FCData {
    int col;
    float *data;
} FCData;

typedef struct _FCLayer {
    int row;  // 排：几排
    int col;  // 列: 几列
    float *weight_data;
    float *bias_data;
} FCLayer;

class Opencl {
public:
    Opencl();
    ~Opencl();
    cl_context context;
    cl_command_queue commandQueue;
    cl_program program;
    cl_device_id device;
    cl_kernel kernel[NUM_LAYER];
    cl_mem memObjects[NUM_MEM_OBJE];

    Conv1dData input;

    Conv1dFilter conv1d_1;
    BatchNorm1d bn_1;
    Conv1dFilter conv1d_2;
    BatchNorm1d bn_2;
    Conv1dFilter conv1d_3;
    BatchNorm1d bn_3;
    FCLayer fc_1;
    
    int Init();
    int UnitNet(bool* is_bad);
private:
    char* ReadKernelSourceFile(const char* filename, size_t* length);
    cl_context CreateContext(cl_device_id* device);
    cl_command_queue CreateCommandQueue(cl_context context, cl_device_id device);
    cl_program CreateProgram(cl_context context, cl_device_id device, const char* fileName);
    int CreateLayerMemObjects(cl_context context, cl_mem memObjects[NUM_MEM_OBJE]);
    int CreateMemObjects(cl_context context, cl_mem memObjects[NUM_MEM_OBJE], float* input);
    void Cleanup(cl_context context, cl_command_queue commandQueue, cl_program program, cl_kernel kernel[NUM_LAYER], cl_mem memObjects[NUM_MEM_OBJE]);
};
#endif