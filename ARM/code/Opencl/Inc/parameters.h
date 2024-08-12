#ifndef __MODEL_PARAMETERS__
#define __MODEL_PARAMETERS__
#include <stdio.h>
#include <stdlib.h>

#define NUM_AI_MEM_OBJE 25
#define NUM_OTHER_MEM_OBJE 2
#define NUM_MEM_OBJE_ALL (NUM_AI_MEM_OBJE + NUM_OTHER_MEM_OBJE)
#define NUM_KERNEL_LAYER 10
#define NUM_KERNEL_OTHER 2
#define NUM_KERNEL_ALL (NUM_KERNEL_LAYER + NUM_KERNEL_OTHER)

int loadParameter(float** data, size_t num, const char* file_path);

#endif
