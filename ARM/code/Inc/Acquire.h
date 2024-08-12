#ifndef __ACQUIRE__
#define __ACQUIRE__
#include <stdlib.h>
#include <time.h>
#include "opencl.h"
#include "ui.h"
#include "FPGA.h"
#include "Hardware.h"

typedef short vWave_t;
#define WIVE_FIFO_DEEPTH 8192

struct SignalINFO{
    double trig_level;
    double min;
    double max;
    double period;
    double frequency;
    double vpp;
};
extern SignalINFO ch1_info;

extern int valible_wave_length;

void AcquireWave(Opencl *my_cl);
void cul_signal_info();
void insert_value();
void draw_value();
void no_trigger(Opencl *my_cl);
void auto_trigger_normal_trigger(Opencl *my_cl);
void single_trigger(Opencl *my_cl);
void auto_set();
void auto_set_endbias();
void save_wave();

void HardwareTrigger();
void SoftwareTrigger();
int WriteWaveToTXT(const char* name);
int WriteAIWaveToTXT(const char* name);

vWave_t* GetWaveCenterPointer();
float* GetWaveForAi();
void ResetGetWave();
void GetWaveINFOFromFPGA();

void SetTrigStatus(int status);
void SetTrigEdge(int edge);
void ChangeTrigStatus();
void RunStop(bool run);
void AutoSet();

#endif
