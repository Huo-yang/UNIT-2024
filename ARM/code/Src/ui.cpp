#include "ui.h"
#include "stddef.h"

// LCD帧缓冲
UI_COLOR g_FrameBuffer[LCD_WIDTH * LCD_HEIGHT]={0};
bool ip_status = 0;
double elapsedTime = 0;

bool flush_flag=1;
unsigned char alternate_flush_flag=0;

// 主窗口
UI_Window main_window = {
    .Id=0,
    .visible=true,
    .x0=WIN_X0,
    .y0=WIN_Y0,
    .x1=WIN_X0+WIN_WIDTH,
    .y1=WIN_Y0+WIN_HEIGHT,
    .width=WIN_WIDTH,
    .height=WIN_HEIGHT,
    .y_mid=WIN_HEIGHT/2 + WIN_Y0,
    .x_mid=WIN_WIDTH/2 + WIN_X0,
    .y_zoom=WIN_HEIGHT/2,
    .x_zoom=WIN_WIDTH/2,
    .y_div=WIN_YDIV,
    .x_div=WIN_XDIV,
    .y_subdiv=5,
    .x_subdiv=5,
    .next=NULL,
    .paint=NULL
};

UI_Window head_status_bar = {
    .Id=0,
    .visible=true,
    .x0=HEAD_BAR_X0,
    .y0=HEAD_BAR_Y0,
    .x1=HEAD_BAR_X0+HEAD_BAR_WIDTH,
    .y1=HEAD_BAR_Y0+HEAD_BAR_HEIGHT,
    .y_mid=(HEAD_BAR_Y0+HEAD_BAR_HEIGHT)/2,
    .x_mid=(HEAD_BAR_X0+HEAD_BAR_WIDTH)/2,
};

UI_Window tool_bar = {
    .Id=0,
    .visible=true,
    .x0=TOOL_BAR_X0,
    .y0=TOOL_BAR_Y0,
    .x1=TOOL_BAR_X0+TOOL_BAR_WIDTH,
    .y1=TOOL_BAR_Y0+TOOL_BAR_HEIGHT,
    .y_mid=TOOL_BAR_Y0+TOOL_BAR_HEIGHT/2,
    .x_mid=TOOL_BAR_X0+TOOL_BAR_WIDTH/2,
};

UI_Window foot_status_bar = {
    .Id=0,
    .visible=true,
    .x0=FOOT_BAR_X0,
    .y0=FOOT_BAR_Y0,
    .x1=FOOT_BAR_X0+FOOT_BAR_WIDTH,
    .y1=FOOT_BAR_Y0+FOOT_BAR_HEIGHT,
    .y_mid=(FOOT_BAR_Y0+FOOT_BAR_HEIGHT)/2,
    .x_mid=(FOOT_BAR_X0+FOOT_BAR_WIDTH)/2,
};

UI_Window measurement_bar = {
    .Id=0,
    .visible=false,
    .x0=MEASUREMENT_BAR_X0,
    .y0=MEASUREMENT_BAR_Y0,
    .x1=MEASUREMENT_BAR_X0+MEASUREMENT_BAR_WIDTH,
    .y1=MEASUREMENT_BAR_Y0+MEASUREMENT_BAR_HEIGHT,
    .y_mid=(MEASUREMENT_BAR_Y0+MEASUREMENT_BAR_HEIGHT)/2,
    .x_mid=(MEASUREMENT_BAR_X0+MEASUREMENT_BAR_WIDTH)/2,
};

UI_Window trig_float_bar = {
    .Id=0,
    .visible=false,
    .x0=TRIG_FLOAT_BAR_X0,
    .y0=TRIG_FLOAT_BAR_Y0,
    .x1=TRIG_FLOAT_BAR_X0+TRIG_FLOAT_BAR_WIDTH,
    .y1=TRIG_FLOAT_BAR_Y0+TRIG_FLOAT_BAR_HEIGHT,
    .y_mid=(TRIG_FLOAT_BAR_Y0+TRIG_FLOAT_BAR_HEIGHT)/2,
    .x_mid=(TRIG_FLOAT_BAR_X0+TRIG_FLOAT_BAR_WIDTH)/2,
};

UI_Window ai_float_bar = {
    .Id=0,
    .visible=false,
    .x0=AI_FLOAT_BAR_X0,
    .y0=AI_FLOAT_BAR_Y0,
    .x1=AI_FLOAT_BAR_X0+AI_FLOAT_BAR_WIDTH,
    .y1=AI_FLOAT_BAR_Y0+AI_FLOAT_BAR_HEIGHT,
    .y_mid=(AI_FLOAT_BAR_Y0+AI_FLOAT_BAR_HEIGHT)/2,
    .x_mid=(AI_FLOAT_BAR_X0+AI_FLOAT_BAR_WIDTH)/2,
};

UI_Window set_float_bar = {
    .Id=0,
    .visible=false,
    .x0=SET_FLOAT_BAR_X0,
    .y0=SET_FLOAT_BAR_Y0,
    .x1=SET_FLOAT_BAR_X0+SET_FLOAT_BAR_WIDTH,
    .y1=SET_FLOAT_BAR_Y0+SET_FLOAT_BAR_HEIGHT,
    .y_mid=(SET_FLOAT_BAR_Y0+SET_FLOAT_BAR_HEIGHT)/2,
    .x_mid=(SET_FLOAT_BAR_X0+SET_FLOAT_BAR_WIDTH)/2,
};

SignalUI ch4_ui = {
    .vertical_pos = 0,
    .herizontal_pos = 0,
    .xscale_model=0,
    .time_base = 4, // 50ns
    .xscale_skip=1,
    .yscale_model=0,
    .yscale=0,
    .yscale_rate=1,
    .coupling_mode=0, // 0:直流耦合
    .bandwidth_20M=0, // 0:关闭
    .wave_stop = false,
    .ai_status = 0,
    .ai_method = 0,
    .ai_result = -1,
};

INFO_Box info_box = {
    .x0 = 620,
    .y0 = 395,
    .life_time = 0,
    .buff={0}
};

Measure_Pointer trigger_pointer = {
    .y0 = WIN_WIDTH/2 + WIN_X0,
};

