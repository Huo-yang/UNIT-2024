/**
 * @FilePath     : /unit/src/opencl.cpp
 * @Description  :  
 * @Author       : Huo yang 935585440@qq.com
 * @Version      : 0.0.1
 * @LastEditors  : Huo yang 935585440@qq.com
 * @LastEditTime : 2024-06-10 20:37:47
 * @Copyright    : G AUTOMOBILE RESEARCH INSTITUTE CO.,LTD Copyright (c) 2024.
**/
#include "opencl.h"

const char* kernel_file_path = "./kernel/unit.cl";

Opencl::Opencl()
{
    context = 0;
    commandQueue = 0;
    program = 0;
    device = 0;
    memset(kernel, 0, sizeof(kernel));
    memset(memObjects, 0, sizeof(memObjects));

    input = {1, WAVE_SIZE};
    
    conv1d_1 = {1, 32, 49, 15};
    bn_1 = {32};
    conv1d_2 = {32, 32, 15, 3};
    bn_2 = {32};
    conv1d_3 = {32, 16, 3, 1};
    bn_3 = {16};
    fc_1 = {4, 256};
}

Opencl::~Opencl()
{
    Cleanup(context, commandQueue, program, kernel, memObjects);
}

char* Opencl::ReadKernelSourceFile(const char* filename, size_t* length)
{
    FILE *file = NULL;
    size_t sourceLength;
    char *sourceString;
    int ret;
    file = fopen(filename, "rb");
    if (file == NULL)
    {
        printf("%s at %d :Can't open %s\n", __FILE__, __LINE__ - 2, filename);
        return NULL;
    }
    fseek(file, 0, SEEK_END);
    sourceLength = ftell(file);
    fseek(file, 0, SEEK_SET);
    sourceString = (char *)malloc(sourceLength + 1);
    sourceString[0] = '\0';
    ret = fread(sourceString, sourceLength, 1, file);
    if (ret == 0)
    {
        printf("%s at %d :Can't read source %s\n", __FILE__, __LINE__ - 2, filename);
        return NULL;
    }
    fclose(file);
    if(length != 0)
    {
        *length = sourceLength;
    }
    sourceString[sourceLength] = '\0';
    return sourceString;
}
/**
 * @brief        : 创建平台 创建设备 根据设备创建上下文
 * @param         {cl_device_id*} device:
 * @return        {cl_context}
**/
cl_context Opencl::CreateContext(cl_device_id* device)
{
    cl_int errNum;
    cl_uint numPlatforms;
    cl_platform_id firstPlatformID;
    cl_context context = NULL;
    // 只初始化第一个可用的OpenCL平台
    errNum = clGetPlatformIDs(1, &firstPlatformID, &numPlatforms);
    if (errNum != CL_SUCCESS || numPlatforms <= 0)
    {
        printf("Failed to find any OpenCL platforms.");
        return NULL;
    }
    errNum = clGetDeviceIDs(firstPlatformID, CL_DEVICE_TYPE_GPU, 1, device, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf("There is no GPU, trying CPU...");
        errNum = clGetDeviceIDs(firstPlatformID, CL_DEVICE_TYPE_CPU, 1, device, NULL);
    }
    if (errNum != CL_SUCCESS)
    {
        printf( "There is NO GPU or CPU" );
        return NULL;
    }
    context = clCreateContext(NULL, 1, device, NULL, NULL, &errNum);
    if (errNum != CL_SUCCESS)
    {
        printf("create context error\n");
        return NULL;
    }
    return context;
}
/**
 * @brief        : 在上下文可用的第一个设备创建命令队列
 * @param         {cl_context} context:
 * @param         {cl_device_id} device:
 * @return        {cl_command_queue}
**/
cl_command_queue Opencl::CreateCommandQueue(cl_context context, cl_device_id device)
{
    cl_command_queue commandQueue = NULL;
    commandQueue = clCreateCommandQueueWithProperties(context, device, 0, NULL);
    if(commandQueue == NULL)
    {
        printf("Failed to create commandQueue for device 0");
        return NULL;
    }
    return commandQueue;
}
/**
 * @brief        : 读取内核源码创建OpenCL程序
 * @param         {cl_context} context:
 * @param         {cl_device_id} device:
 * @param         {char*} fileName:
 * @return        {cl_program}
**/
cl_program Opencl::CreateProgram(cl_context context, cl_device_id device, const char* fileName)
{
    cl_int errNum;
    cl_program program;
    size_t program_length;
    char* const source = ReadKernelSourceFile(fileName, &program_length);
    if (source == NULL)
    {
        return NULL;
    }
    program = clCreateProgramWithSource(context, 1, (const char**)&source, NULL, NULL);
    if (program == NULL)
    {
        printf("Failed to create CL program from source.");
        return NULL;
    }
    errNum = clBuildProgram(program, 0, NULL, NULL, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        char buildLog[16384];
        clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG, sizeof(buildLog), buildLog, NULL);
        printf("Error in kernel:%s ", buildLog);
        clReleaseProgram(program);
        return NULL;
    }
    return program;
}
/**
 * @brief        : 创建内存对象
 * @param         {cl_context} context:
 * @param         {cl_mem} memObjects:
 * @param         {float*} a:
 * @param         {float*} b:
 * @return        {*}
**/
int Opencl::CreateMemObjects(cl_context context, cl_mem memObjects[NUM_MEM_OBJE], float* input)
{
    memObjects[0] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(float) * WAVE_SIZE, input, NULL);
    if (memObjects[0] == NULL)
    {
        printf("Error creating memory objects.");
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}
/**
 * @brief        : 清除OpenCL资源
 * @param         {cl_context} context:
 * @param         {cl_command_queue} conmmandQueue:
 * @param         {cl_program} program:
 * @param         {cl_kernel} kernel:
 * @param         {cl_mem} memObjects:
 * @return        {*}
**/
void Opencl::Cleanup(cl_context context, cl_command_queue commandQueue, cl_program program, cl_kernel kernel[NUM_LAYER], cl_mem memObjects[NUM_MEM_OBJE])
{
    for (int i = 0; i < NUM_MEM_OBJE; i++)
    {
        if (memObjects[i] != 0)
        {
            clReleaseMemObject(memObjects[i]);
        }
    }
    if (commandQueue != 0)
        clReleaseCommandQueue(commandQueue);
    for (int i = 0; i < NUM_LAYER; i++)
    {
        if (kernel[i] != 0)
        {
            clReleaseKernel(kernel[i]);
        }
    }
    if (program != 0)
        clReleaseProgram(program);
    if (context != 0)
        clReleaseContext(context);
}

int Opencl::Init()
{
    // 创建OpenCL上下文
    context = CreateContext(&device);
    if (context == NULL)
    {
        printf("Failed to create OpenCL context.");
        return EXIT_FAILURE;
    }
    // 获取OpenCL设备，并创建命令队列
    commandQueue = CreateCommandQueue(context, device);
    if (commandQueue == NULL)
    {
        Cleanup(context, commandQueue, NULL, NULL, NULL);
        return EXIT_FAILURE;
    }
    // 创建OpenCL程序
    program = CreateProgram(context, device, kernel_file_path);
    if (program == NULL)
    {
        Cleanup(context, commandQueue, program, NULL, NULL);
        return EXIT_FAILURE;
    }
    // 创建OpenCL内核
    kernel[0] = clCreateKernel(program, "Conv1D", NULL);
    kernel[1] = clCreateKernel(program, "BatchNorm1D2DIM", NULL);
    kernel[2] = clCreateKernel(program, "ReLU", NULL);
    kernel[3] = clCreateKernel(program, "Conv1D", NULL);
    kernel[4] = clCreateKernel(program, "BatchNorm1D2DIM", NULL);
    kernel[5] = clCreateKernel(program, "ReLU", NULL);
    kernel[6] = clCreateKernel(program, "Conv1D", NULL);
    kernel[7] = clCreateKernel(program, "BatchNorm1D2DIM", NULL);
    kernel[8] = clCreateKernel(program, "ReLU", NULL);
    kernel[9] = clCreateKernel(program, "FC", NULL);
    for (int i = 0; i < NUM_LAYER; i++)
    {
        if (kernel[i] == NULL)
        {
            printf("Failed to create kernel");
            Cleanup(context, commandQueue, program, kernel, NULL);
            return EXIT_FAILURE;
        }
    }
    // 读取权重
    int ret;
    // -------------------------conv1d------------------------------------------
    ret = loadParameter(&conv1d_1.weight_data, conv1d_1.in_channel * conv1d_1.out_channel * conv1d_1.kernel_size, "./bin/conv1.0.weight.bin");
    ret |= loadParameter(&conv1d_1.bias_data, conv1d_1.out_channel, "./bin/conv1.0.bias.bin");
    // ---------------------------bn--------------------------------------------
    ret |= loadParameter(&bn_1.mean, bn_1.size, "./bin/conv1.1.running_mean.bin");
    ret |= loadParameter(&bn_1.var, bn_1.size, "./bin/conv1.1.running_var.bin");
    ret |= loadParameter(&bn_1.gamma, bn_1.size, "./bin/conv1.1.weight.bin");
    ret |= loadParameter(&bn_1.beta, bn_1.size, "./bin/conv1.1.bias.bin");
    // -------------------------conv1d------------------------------------------
    ret |= loadParameter(&conv1d_2.weight_data, conv1d_2.in_channel * conv1d_2.out_channel * conv1d_2.kernel_size, "./bin/conv2.0.weight.bin");
    ret |= loadParameter(&conv1d_2.bias_data, conv1d_2.out_channel, "./bin/conv2.0.bias.bin");
    // ---------------------------bn--------------------------------------------
    ret |= loadParameter(&bn_2.mean, bn_2.size, "./bin/conv2.1.running_mean.bin");
    ret |= loadParameter(&bn_2.var, bn_2.size, "./bin/conv2.1.running_var.bin");
    ret |= loadParameter(&bn_2.gamma, bn_2.size, "./bin/conv2.1.weight.bin");
    ret |= loadParameter(&bn_2.beta, bn_2.size, "./bin/conv2.1.bias.bin");
    // -------------------------conv1d------------------------------------------
    ret |= loadParameter(&conv1d_3.weight_data, conv1d_3.in_channel * conv1d_3.out_channel * conv1d_3.kernel_size, "./bin/conv3.0.weight.bin");
    ret |= loadParameter(&conv1d_3.bias_data, conv1d_3.out_channel, "./bin/conv3.0.bias.bin");
    // ---------------------------bn--------------------------------------------
    ret |= loadParameter(&bn_3.mean, bn_3.size, "./bin/conv3.1.running_mean.bin");
    ret |= loadParameter(&bn_3.var, bn_3.size, "./bin/conv3.1.running_var.bin");
    ret |= loadParameter(&bn_3.gamma, bn_3.size, "./bin/conv3.1.weight.bin");
    ret |= loadParameter(&bn_3.beta, bn_3.size, "./bin/conv3.1.bias.bin");
    // ---------------------------fc---------------------------------------------
    ret |= loadParameter(&fc_1.weight_data, fc_1.row * fc_1.col, "./bin/fc1.0.weight.bin");
    ret |= loadParameter(&fc_1.bias_data, fc_1.row, "./bin/fc1.0.bias.bin");
    if (ret != EXIT_SUCCESS)
    {
        return EXIT_FAILURE;
    }
    // 创建权重内存对象
    cl_int errNum;
    Conv1dData temp_conv1d_data;
    // -------------------------conv1d------------------------------------------1111111111111111111
    temp_conv1d_data.channel = conv1d_1.out_channel;
    temp_conv1d_data.col = (int)((input.col - conv1d_1.kernel_size) / conv1d_1.stride) + 1;
    memObjects[1] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * conv1d_1.in_channel * conv1d_1.out_channel * conv1d_1.kernel_size, 
                                conv1d_1.weight_data, NULL);
    free(conv1d_1.weight_data);
    memObjects[2] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * conv1d_1.out_channel, 
                                conv1d_1.bias_data, NULL);
    free(conv1d_1.bias_data);
    memObjects[3] = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * temp_conv1d_data.channel * temp_conv1d_data.col, NULL, NULL);
    errNum = clSetKernelArg(kernel[0], 1, sizeof(cl_mem), &memObjects[1]);
    errNum |= clSetKernelArg(kernel[0], 2, sizeof(cl_mem), &memObjects[2]);
    errNum |= clSetKernelArg(kernel[0], 3, sizeof(int), &conv1d_1.in_channel);
    errNum |= clSetKernelArg(kernel[0], 4, sizeof(int), &input.col);
    errNum |= clSetKernelArg(kernel[0], 5, sizeof(int), &conv1d_1.kernel_size);
    errNum |= clSetKernelArg(kernel[0], 6, sizeof(int), &conv1d_1.stride);
    errNum |= clSetKernelArg(kernel[0], 7, sizeof(cl_mem), &memObjects[3]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ----------------------------bn------------------------------------------
    memObjects[4] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_1.size, 
                                bn_1.mean, NULL);
    free(bn_1.mean);
    memObjects[5] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_1.size, 
                                bn_1.var, NULL);
    free(bn_1.var);
    memObjects[6] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_1.size, 
                                bn_1.gamma, NULL);
    free(bn_1.gamma);
    memObjects[7] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_1.size, 
                                bn_1.beta, NULL);
    free(bn_1.beta);
    errNum = clSetKernelArg(kernel[1], 0, sizeof(cl_mem), &memObjects[3]);
    errNum |= clSetKernelArg(kernel[1], 1, sizeof(cl_mem), &memObjects[4]);
    errNum |= clSetKernelArg(kernel[1], 2, sizeof(cl_mem), &memObjects[5]);
    errNum |= clSetKernelArg(kernel[1], 3, sizeof(cl_mem), &memObjects[6]);
    errNum |= clSetKernelArg(kernel[1], 4, sizeof(cl_mem), &memObjects[7]);
    errNum |= clSetKernelArg(kernel[1], 5, sizeof(cl_mem), &memObjects[3]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // --------------------------relu-------------------------------------------
    errNum = clSetKernelArg(kernel[2], 0, sizeof(cl_mem), &memObjects[3]);
    errNum |= clSetKernelArg(kernel[2], 1, sizeof(cl_mem), &memObjects[3]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // -------------------------conv1d------------------------------------------222222222222222222222
    temp_conv1d_data.channel = conv1d_2.out_channel;
    int temp_col = temp_conv1d_data.col;
    temp_conv1d_data.col = (int)((temp_conv1d_data.col - conv1d_2.kernel_size) / conv1d_2.stride) + 1;
    memObjects[8] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * conv1d_2.in_channel * conv1d_2.out_channel * conv1d_2.kernel_size, 
                                conv1d_2.weight_data, NULL);
    free(conv1d_2.weight_data);
    memObjects[9] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * conv1d_2.out_channel, 
                                conv1d_2.bias_data, NULL);
    free(conv1d_2.bias_data);
    memObjects[10] = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * temp_conv1d_data.channel * temp_conv1d_data.col, NULL, NULL);
    errNum = clSetKernelArg(kernel[3], 0, sizeof(cl_mem), &memObjects[3]);
    errNum |= clSetKernelArg(kernel[3], 1, sizeof(cl_mem), &memObjects[8]);
    errNum |= clSetKernelArg(kernel[3], 2, sizeof(cl_mem), &memObjects[9]);
    errNum |= clSetKernelArg(kernel[3], 3, sizeof(int), &conv1d_2.in_channel);
    errNum |= clSetKernelArg(kernel[3], 4, sizeof(int), &temp_col);
    errNum |= clSetKernelArg(kernel[3], 5, sizeof(int), &conv1d_2.kernel_size);
    errNum |= clSetKernelArg(kernel[3], 6, sizeof(int), &conv1d_2.stride);
    errNum |= clSetKernelArg(kernel[3], 7, sizeof(cl_mem), &memObjects[10]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ----------------------------bn------------------------------------------
    memObjects[11] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_2.size, 
                                bn_2.mean, NULL);
    free(bn_2.mean);
    memObjects[12] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_2.size, 
                                bn_2.var, NULL);
    free(bn_2.var);
    memObjects[13] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_2.size, 
                                bn_2.gamma, NULL);
    free(bn_2.gamma);
    memObjects[14] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_2.size, 
                                bn_2.beta, NULL);
    free(bn_2.beta);
    errNum = clSetKernelArg(kernel[4], 0, sizeof(cl_mem), &memObjects[10]);
    errNum |= clSetKernelArg(kernel[4], 1, sizeof(cl_mem), &memObjects[11]);
    errNum |= clSetKernelArg(kernel[4], 2, sizeof(cl_mem), &memObjects[12]);
    errNum |= clSetKernelArg(kernel[4], 3, sizeof(cl_mem), &memObjects[13]);
    errNum |= clSetKernelArg(kernel[4], 4, sizeof(cl_mem), &memObjects[14]);
    errNum |= clSetKernelArg(kernel[4], 5, sizeof(cl_mem), &memObjects[10]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // --------------------------relu-------------------------------------------
    errNum = clSetKernelArg(kernel[5], 0, sizeof(cl_mem), &memObjects[10]);
    errNum |= clSetKernelArg(kernel[5], 1, sizeof(cl_mem), &memObjects[10]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // -------------------------conv1d------------------------------------------33333333333333333333333
    temp_conv1d_data.channel = conv1d_3.out_channel;
    temp_col = temp_conv1d_data.col;
    temp_conv1d_data.col = (int)((temp_conv1d_data.col - conv1d_3.kernel_size) / conv1d_3.stride) + 1;
    memObjects[15] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * conv1d_3.in_channel * conv1d_3.out_channel * conv1d_3.kernel_size, 
                                conv1d_3.weight_data, NULL);
    free(conv1d_3.weight_data);
    memObjects[16] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * conv1d_3.out_channel, 
                                conv1d_3.bias_data, NULL);
    free(conv1d_3.bias_data);
    memObjects[17] = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * temp_conv1d_data.channel * temp_conv1d_data.col, NULL, NULL);
    errNum = clSetKernelArg(kernel[6], 0, sizeof(cl_mem), &memObjects[10]);
    errNum |= clSetKernelArg(kernel[6], 1, sizeof(cl_mem), &memObjects[15]);
    errNum |= clSetKernelArg(kernel[6], 2, sizeof(cl_mem), &memObjects[16]);
    errNum |= clSetKernelArg(kernel[6], 3, sizeof(int), &conv1d_3.in_channel);
    errNum |= clSetKernelArg(kernel[6], 4, sizeof(int), &temp_col);
    errNum |= clSetKernelArg(kernel[6], 5, sizeof(int), &conv1d_3.kernel_size);
    errNum |= clSetKernelArg(kernel[6], 6, sizeof(int), &conv1d_3.stride);
    errNum |= clSetKernelArg(kernel[6], 7, sizeof(cl_mem), &memObjects[17]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ----------------------------bn------------------------------------------
    memObjects[18] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_3.size, 
                                bn_3.mean, NULL);
    free(bn_3.mean);
    memObjects[19] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_3.size, 
                                bn_3.var, NULL);
    free(bn_3.var);
    memObjects[20] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_3.size, 
                                bn_3.gamma, NULL);
    free(bn_3.gamma);
    memObjects[21] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * bn_3.size, 
                                bn_3.beta, NULL);
    free(bn_3.beta);
    errNum = clSetKernelArg(kernel[7], 0, sizeof(cl_mem), &memObjects[17]);
    errNum |= clSetKernelArg(kernel[7], 1, sizeof(cl_mem), &memObjects[18]);
    errNum |= clSetKernelArg(kernel[7], 2, sizeof(cl_mem), &memObjects[19]);
    errNum |= clSetKernelArg(kernel[7], 3, sizeof(cl_mem), &memObjects[20]);
    errNum |= clSetKernelArg(kernel[7], 4, sizeof(cl_mem), &memObjects[21]);
    errNum |= clSetKernelArg(kernel[7], 5, sizeof(cl_mem), &memObjects[17]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // --------------------------relu-------------------------------------------
    errNum = clSetKernelArg(kernel[8], 0, sizeof(cl_mem), &memObjects[17]);
    errNum |= clSetKernelArg(kernel[8], 1, sizeof(cl_mem), &memObjects[17]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ---------------------------fc---------------------------------------------111111111
    FCData temp_fc_data;
    temp_fc_data.col = temp_conv1d_data.channel * temp_conv1d_data.col;
    memObjects[22] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * fc_1.row * fc_1.col, 
                                fc_1.weight_data, NULL);
    free(fc_1.weight_data);
    memObjects[23] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, 
                                sizeof(float) * fc_1.row, 
                                fc_1.bias_data, NULL);
    memObjects[24] = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * fc_1.row, NULL, NULL);
    free(fc_1.bias_data);
    errNum = clSetKernelArg(kernel[9], 0, sizeof(cl_mem), &memObjects[17]);
    errNum |= clSetKernelArg(kernel[9], 1, sizeof(cl_mem), &memObjects[22]);
    errNum |= clSetKernelArg(kernel[9], 2, sizeof(cl_mem), &memObjects[23]);
    errNum |= clSetKernelArg(kernel[9], 3, sizeof(int), &temp_fc_data.col);
    errNum |= clSetKernelArg(kernel[9], 4, sizeof(cl_mem), &memObjects[24]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    printf("Success init opencl.\n");
    return EXIT_SUCCESS;
}

int Opencl::UnitNet(bool* is_bad)
{
    cl_int errNum;
    if (CreateMemObjects(context, memObjects, input.data) == EXIT_FAILURE)
    {
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // 设置卷积内核参数
    errNum = clSetKernelArg(kernel[0], 0, sizeof(cl_mem), &memObjects[0]); // 输入
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    Conv1dData temp_conv_data;
    temp_conv_data.channel = conv1d_1.out_channel;
    temp_conv_data.col = (int)((input.col - conv1d_1.kernel_size) / conv1d_1.stride) + 1;
    // ------------------------------------conv--------------------------------------------------------------------111111111
    size_t globalWorkSize_1[2] = {(size_t)temp_conv_data.channel, (size_t)temp_conv_data.col};
    size_t localWorkSize_1[2] = { 1, 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[0], 2, NULL, globalWorkSize_1, localWorkSize_1, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[1], 2, NULL, globalWorkSize_1, localWorkSize_1, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    size_t globalWorkSize_2[1] = {(size_t)(temp_conv_data.channel * temp_conv_data.col)};
    size_t localWorkSize_2[1] = { 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[2], 1, NULL, globalWorkSize_2, localWorkSize_2, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ===============================================debug===============================================================
    // printf("size:%d\n", temp_conv_data.channel * temp_conv_data.col);
    // temp_conv_data.data = (float *)malloc(sizeof(float) * temp_conv_data.channel * temp_conv_data.col);
    // clEnqueueReadBuffer(commandQueue, memObjects[3], CL_TRUE, 0, temp_conv_data.channel * temp_conv_data.col * sizeof(float), temp_conv_data.data, 0, NULL, NULL);
    // for (int i = 0; i < (temp_conv_data.channel * temp_conv_data.col); i++)
    // {
    //     printf("%f ", temp_conv_data.data[i]);
    //     if((i+1)%temp_conv_data.col == 0) printf("\n");
    // }
    // ==============================================================================================================
    temp_conv_data.channel = conv1d_2.out_channel;
    temp_conv_data.col = (int)((temp_conv_data.col - conv1d_2.kernel_size) / conv1d_2.stride) + 1;
    // ------------------------------------conv--------------------------------------------------------------------22222222
    size_t globalWorkSize_3[2] = {(size_t)temp_conv_data.channel, (size_t)temp_conv_data.col};
    size_t localWorkSize_3[2] = { 1, 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[3], 2, NULL, globalWorkSize_3, localWorkSize_3, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[4], 2, NULL, globalWorkSize_3, localWorkSize_3, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    size_t globalWorkSize_4[1] = {(size_t)(temp_conv_data.channel * temp_conv_data.col)};
    size_t localWorkSize_4[1] = { 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[5], 1, NULL, globalWorkSize_4, localWorkSize_4, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ===============================================debug===============================================================
    // printf("size:%d\n", temp_conv_data.channel * temp_conv_data.col);
    // temp_conv_data.data = (float *)malloc(sizeof(float) * temp_conv_data.channel * temp_conv_data.col);
    // clEnqueueReadBuffer(commandQueue, memObjects[10], CL_TRUE, 0, temp_conv_data.channel * temp_conv_data.col * sizeof(float), temp_conv_data.data, 0, NULL, NULL);
    // for (int i = 0; i < (temp_conv_data.channel * temp_conv_data.col); i++)
    // {
    //     printf("%f ", temp_conv_data.data[i]);
    //     if((i+1)%temp_conv_data.col == 0) printf("\n");
    // }
    // ==============================================================================================================
    temp_conv_data.channel = conv1d_3.out_channel;
    temp_conv_data.col = (int)((temp_conv_data.col - conv1d_3.kernel_size) / conv1d_3.stride) + 1;
    // ------------------------------------conv--------------------------------------------------------------------33333333
    size_t globalWorkSize_5[2] = {(size_t)temp_conv_data.channel, (size_t)temp_conv_data.col};
    size_t localWorkSize_5[2] = { 1, 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[6], 2, NULL, globalWorkSize_5, localWorkSize_5, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[7], 2, NULL, globalWorkSize_5, localWorkSize_5, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    size_t globalWorkSize_6[1] = {(size_t)(temp_conv_data.channel * temp_conv_data.col)};
    size_t localWorkSize_6[1] = { 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[8], 1, NULL, globalWorkSize_6, localWorkSize_6, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ===============================================debug===============================================================
    // printf("size:%d\n", temp_conv_data.channel * temp_conv_data.col);
    // temp_conv_data.data = (float *)malloc(sizeof(float) * temp_conv_data.channel * temp_conv_data.col);
    // clEnqueueReadBuffer(commandQueue, memObjects[17], CL_TRUE, 0, temp_conv_data.channel * temp_conv_data.col * sizeof(float), temp_conv_data.data, 0, NULL, NULL);
    // for (int i = 0; i < (temp_conv_data.channel * temp_conv_data.col); i++)
    // {
    //     printf("%f ", temp_conv_data.data[i]);
    //     if((i+1)%temp_conv_data.col == 0) printf("\n");
    // }
    // ==============================================================================================================
    FCData temp_fc_data;
    temp_fc_data.col = fc_1.row;
    // -----------------------------------------fc----------------------------------------------------------------11111
    size_t globalWorkSize_7[1] = {(size_t)temp_fc_data.col};
    size_t localWorkSize_7[1] = { 1 };
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel[9], 1, NULL, globalWorkSize_7, localWorkSize_7, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution.\n" );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return EXIT_FAILURE;
    }
    // ===============================================debug===============================================================
    // printf("size:%d\n", temp_fc_data.col);
    // temp_fc_data.data = (float *)malloc(sizeof(float) * temp_fc_data.col);
    // clEnqueueReadBuffer(commandQueue, memObjects[24], CL_TRUE, 0, temp_fc_data.col * sizeof(float), temp_fc_data.data, 0, NULL, NULL);
    // for (int i = 0; i < (temp_fc_data.col); i++)
    // {
    //     printf("%f ", temp_fc_data.data[i]);
    //     if((i+1)%10 == 0) printf("\n");
    // }
    // printf("\n");
    // ==============================================================================================================
    FCData out_data;
    out_data.col = fc_1.row;
    // 计算结果拷贝回主机
    out_data.data = (float *)malloc(sizeof(float) * out_data.col);
    errNum = clEnqueueReadBuffer(commandQueue, memObjects[24], CL_TRUE, 0, out_data.col * sizeof(float), out_data.data, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf("Error reading result buffer.\n");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    printf("output array:\n");
    for (int i = 0; i < (out_data.col); i++)
    {
        printf("%f ", out_data.data[i]);
    }
    printf("\n");
    if(out_data.data[0] < out_data.data[1]) *is_bad = true;
    return 0;
}