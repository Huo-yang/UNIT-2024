#include "parameters.h"

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
