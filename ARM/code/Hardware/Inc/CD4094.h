#pragma once
#include "product.h"

#if PRODUCT == MSO_3K
#include "3000/CD4094_3000.h"
#elif PRODUCT == MSO_2KP
#include "CD4094_2000P.h"
#else
#include "2000/CD4094_2000.h"
#endif

