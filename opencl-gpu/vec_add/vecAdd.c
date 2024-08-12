/**
 * @FilePath     : /opencl/myHandWrite/vec_add/vecAdd.c
 * @Description  :  
 * @Author       : Huo yang 935585440@qq.com
 * @Version      : 0.0.1
 * @LastEditors  : Huo yang 935585440@qq.com
 * @LastEditTime : 2024-05-28 10:45:59
 * @Copyright    : G AUTOMOBILE RESEARCH INSTITUTE CO.,LTD Copyright (c) 2024.
**/
#include <stdio.h>
#include <stdlib.h>
#include <CL/cl.h>
#include <time.h>

const int ARRAY_SIZE = 100;
/**
 * @brief        : 
 * @param         {char*} filename:
 * @param         {size_t*} length:
 * @return        {char*} 
**/
char* ReadKernelSourceFile(const char* filename, size_t* length)
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
cl_context CreateContext(cl_device_id* device)
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
cl_command_queue CreateCommandQueue(cl_context context, cl_device_id device)
{
    cl_int errNum;
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
cl_program CreateProgram(cl_context context, cl_device_id device, const char* fileName)
{
    cl_int errNum;
    cl_program program;
    size_t program_length;
    char* const source = ReadKernelSourceFile(fileName, &program_length);
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
_Bool CreateMemObjects(cl_context context, cl_mem memObjects[3], float* a, float* b)
{
    memObjects[0] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(float) * ARRAY_SIZE, a, NULL);
    memObjects[1] = clCreateBuffer(context, CL_MEM_READ_ONLY | CL_MEM_COPY_HOST_PTR, sizeof(float) * ARRAY_SIZE, b, NULL);
    memObjects[2] = clCreateBuffer(context, CL_MEM_READ_WRITE, sizeof(float) * ARRAY_SIZE, NULL, NULL);
    if (memObjects[0] == NULL || memObjects[1] == NULL || memObjects[2] == NULL)
    {
        printf("Error creating memory objects.");
        return 0;
    }
    return 1;
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
void Cleanup(cl_context context, cl_command_queue commandQueue, cl_program program, cl_kernel kernel, cl_mem memObjects[3])
{
    for (int i = 0; i < 3; i++)
    {
        if (memObjects[i] != 0)
        {
            clReleaseMemObject(memObjects[i]);
        }
    }
    if (commandQueue != 0)
        clReleaseCommandQueue(commandQueue);
    if (kernel != 0)
        clReleaseKernel(kernel);
    if (program != 0)
        clReleaseProgram(program);
    if (context != 0)
        clReleaseContext(context);
}

int main(int argc, char** argv)
{
    cl_context context = 0;
    cl_command_queue commandQueue = 0;
    cl_program program = 0;
    cl_device_id device = 0;
    cl_kernel kernel = 0;
    cl_mem memObjects[3] = { 0, 0, 0 };
    cl_int errNum;
    // 创建OpenCL上下文
    context = CreateContext(&device);
    if (context == NULL)
    {
        printf("Failed to create OpenCL context.");
        return 1;
    }
    // 获取OpenCL设备，并创建命令队列
    commandQueue = CreateCommandQueue(context, device);
    if (commandQueue == NULL)
    {
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    // 创建OpenCL程序
    program = CreateProgram(context, device, "vecAdd.cl");
    if (program == NULL)
    {
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    // 创建OpenCL内核
#ifdef ADD1D
    kernel = clCreateKernel(program, "Add1D", NULL);
#else
    kernel = clCreateKernel(program, "Add2D", NULL);
#endif
    if (kernel == NULL)
    {
        printf("Failed to create kernel");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    // 创建OpenCL内存对象
    float result[ARRAY_SIZE];
    float a[ARRAY_SIZE];
    float b[ARRAY_SIZE];
    for (int i = 0; i < ARRAY_SIZE; i++)
    {
        a[i] = (float)i;
        b[i] = (float)(i * 2);
    }
    if (!CreateMemObjects(context, memObjects, a, b))
    {
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    clock_t start,finish;
    start = clock();
    // 设置内核参数
    errNum = clSetKernelArg(kernel, 0, sizeof(cl_mem), &memObjects[0]);
    errNum |= clSetKernelArg(kernel, 1, sizeof(cl_mem), &memObjects[1]);
    errNum |= clSetKernelArg(kernel, 2, sizeof(cl_mem), &memObjects[2]);
    if (errNum != CL_SUCCESS)
    {
        printf("Error setting kernel arguments.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return -1;
    }
#ifdef ADD1D
    size_t globalWorkSize[1] = { ARRAY_SIZE };
    size_t localWorkSize[1] = { 1 };
    //执行内核
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel, 1, NULL, globalWorkSize, localWorkSize, 0, NULL, NULL);
#else
    size_t globalWorkSize[2] = { 10, 10 };
    size_t localWorkSize[1] = { 1 };
    //执行内核
    errNum = clEnqueueNDRangeKernel(commandQueue, kernel, 2, NULL, globalWorkSize, localWorkSize, 0, NULL, NULL);
#endif
    if (errNum != CL_SUCCESS)
    {
        printf( "Error queuing kernel for execution." );
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    // 计算结果拷贝回主机
    errNum = clEnqueueReadBuffer(commandQueue, memObjects[2], CL_TRUE, 0, ARRAY_SIZE * sizeof(float), result, 0, NULL, NULL);
    if (errNum != CL_SUCCESS)
    {
        printf("Error reading reasult buffer.");
        Cleanup(context, commandQueue, program, kernel, memObjects);
        return 1;
    }
    finish = clock();
    printf("cost time %ld us\n", (finish - start));
    for (int i = 0; i < ARRAY_SIZE; i++)
    {
        printf("i=%d:%f\n", i, result[i]);
    }
    printf("Executed program succesfully.");
    Cleanup(context, commandQueue, program, kernel, memObjects);
    return 0;
}