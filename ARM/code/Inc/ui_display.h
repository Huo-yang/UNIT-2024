#ifndef __UI_DISPLAY_H__
#define __UI_DISPLAY_H__

#include "FPGA.h"
#include "FontManager.h"
#include "HW_Channel.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "opencl.h"
#include "ADC.h"
#include "CD4094_2000P.h"
#include "DAC.h"
#include "fpga_config.h"
#include "OptFB0.h"
#include "painter.h"
#include "uart_key.h"
#include "ui.h"

#define DO_NOTHING {}

extern void *ui_display(void* threadid);

#endif
