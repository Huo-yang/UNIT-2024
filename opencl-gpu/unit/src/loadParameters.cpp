/**
 * @FilePath     : /unit/src/loadParameters.cpp
 * @Description  :  
 * @Author       : Huo yang 935585440@qq.com
 * @Version      : 0.0.1
 * @LastEditors  : Huo yang 935585440@qq.com
 * @LastEditTime : 2024-05-30 16:00:44
 * @Copyright    : G AUTOMOBILE RESEARCH INSTITUTE CO.,LTD Copyright (c) 2024.
**/
#include "loadParameters.h"

int loadParameter(float** data, size_t num, const char* file_path){
    FILE* file;
    size_t result;
    file = fopen(file_path, "rb");
    if (file == NULL) {
        perror("Error opening file\n");
        return EXIT_FAILURE;
    }
    *data = (float *)malloc(sizeof(float) * num);
    result = fread(*data, sizeof(float), num, file);
    if (result != num) {
        free(*data); 
        *data = NULL;
        fclose(file);
        perror("Error reading data from file");
        return EXIT_FAILURE;
    }
    fclose(file);
    return EXIT_SUCCESS;
}