#ifndef __UI_H__
#define __UI_H__
#define UI_CHAR wchar_t
#define UI_COLOR unsigned int
#define UI_STATE unsigned char

// 整块LCD的宽度和高度
#define LCD_WIDTH  800
#define LCD_HEIGHT 480
// LCD帧缓冲
extern UI_COLOR g_FrameBuffer[LCD_WIDTH * LCD_HEIGHT];
// ---------------------------主窗口
// 主窗口的起始点
#define WIN_X0 0
#define WIN_Y0 30
// 主窗口的宽度和高度
#define WIN_WIDTH 750
#define WIN_HEIGHT 390
// ---------------------------上状态栏
// 上状态栏的起始点
#define HEAD_BAR_X0 0
#define HEAD_BAR_Y0 0
// 上状态栏的宽度和高度
#define HEAD_BAR_WIDTH WIN_WIDTH
#define HEAD_BAR_HEIGHT WIN_Y0
// ---------------------------工具栏
// 工具栏的起始点
#define TOOL_BAR_X0 WIN_WIDTH
#define TOOL_BAR_Y0 0
// 工具栏的宽度和高度
#define TOOL_BAR_WIDTH (LCD_WIDTH-WIN_WIDTH)
#define TOOL_BAR_HEIGHT (WIN_Y0+WIN_HEIGHT)
// ---------------------------下状态栏
// 下状态栏的起始点
#define FOOT_BAR_X0 0
#define FOOT_BAR_Y0 (WIN_Y0+WIN_HEIGHT)
// 下状态栏的宽度和高度
#define FOOT_BAR_WIDTH LCD_WIDTH
#define FOOT_BAR_HEIGHT  (LCD_HEIGHT-TOOL_BAR_HEIGHT)
// ---------------------------测量值栏
// 测量值栏的起始点
#define MEASUREMENT_BAR_X0 5
#define MEASUREMENT_BAR_Y0 390
// 测量值栏的宽度和高度
#define MEASUREMENT_BAR_WIDTH 600
#define MEASUREMENT_BAR_HEIGHT 24
// ---------------------------控制漂浮栏
// 漂浮栏的起始点
#define TRIG_FLOAT_BAR_X0 615
#define TRIG_FLOAT_BAR_Y0 40
// 漂浮栏的宽度和高度
#define TRIG_FLOAT_BAR_WIDTH 130
#define TRIG_FLOAT_BAR_HEIGHT 140
// ---------------------------AI漂浮栏
// 漂浮栏的起始点
#define AI_FLOAT_BAR_X0 675
#define AI_FLOAT_BAR_Y0 40
// 漂浮栏的宽度和高度
#define AI_FLOAT_BAR_WIDTH 70
#define AI_FLOAT_BAR_HEIGHT 130
// ---------------------------设置漂浮栏
// 漂浮栏的起始点
#define SET_FLOAT_BAR_X0 645
#define SET_FLOAT_BAR_Y0 40
// 漂浮栏的宽度和高度
#define SET_FLOAT_BAR_WIDTH 100
#define SET_FLOAT_BAR_HEIGHT 135

#define ZERO_LINE_COLOR 0x777777
#define ZERO_SCALE_COLOR 0x777777
#define GRID_COLOR 0x333333
#define CH1_COLOR 0x00bfff

// 波形窗口的宽度
#define WAVE_WIDTH  600
// 波形窗口的高度
#define WAVE_HEIGHT 580
// 波形窗口的起始位置
#define WAVE_X      10
#define WAVE_Y      10
// 波形窗口的背景颜色
#define WAVE_BGCOLOR 0x00FF00
// 波形窗口的边框颜色
#define WAVE_BORDERCOLOR 0x00FF00
// Normal Window
#define WIN_YDIV			47
#define WIN_XDIV			50
#define YDOTS_PER_DIV		50

#define MAXWIN_XDOTS_PER_DIV	50
#define MAXWIN_DATA_X0     30//29
#define MAXWIN_DATA_X1     (WIN_DATA_X0 + WIN_XDIV * MAXWIN_XDOTS_PER_DIV)
#define MAXWIN_DATA_XMID   ( (MAXWIN_DATA_X0 + MAXWIN_DATA_X1) / 2 )

#define WINDOW_STD_ZOOM	100
#define AD_DATA_MID	128

#define INFO_BOX_LIFE_TIME 40
// 窗口结构体定义
struct UI_Window{
	int Id;
	bool visible;
	int x0;
	int y0;
	int x1;
	int y1;
	int width;
	int height;
	int y_mid;
    int x_mid;
	int y_zoom;
    int x_zoom;
	int y_div;
	int x_div;
	int y_subdiv;
	int x_subdiv;
    struct UI_Window *const next;
    void (*paint)(const struct UI_Window *);
};
// 窗口结构体定义
struct UI_Float_Window{
    int Id;
    bool visible;
    int x0;
    int y0;
    int x1;
    int y1;
    int width;
    int height;
    int y_zoom;
    int x_zoom;
};
// 信号结构体定义 通道尺度
struct SignalUI{
    int vertical_pos;
    int herizontal_pos;
    bool xscale_model; // 0:切换时基 1:尺度缩放
    unsigned char time_base;
    unsigned char xscale_skip;
    bool yscale_model; // 0:切换赋格 1:尺度缩放
    unsigned char yscale;
    unsigned char yscale_rate;
    unsigned char coupling_mode; // 0:直流耦合 1:交流耦合
    unsigned char bandwidth_20M;
    bool wave_stop;
    int ai_status;
    int ai_method;
    int ai_result;
};
// 通知信号结构体定义
struct INFO_Box{
    int x0;
    int y0;
    int life_time;
    UI_CHAR buff[100];
};
// 测量指针结构体定义
struct Measure_Pointer{
    int x0;
    int y0;
};

extern UI_Window main_window;
extern UI_Window head_status_bar;
extern UI_Window tool_bar;
extern UI_Window foot_status_bar;
extern UI_Window measurement_bar;
extern UI_Window trig_float_bar;
extern UI_Window ai_float_bar;
extern UI_Window set_float_bar;
extern SignalUI ch4_ui;
extern INFO_Box info_box;
extern Measure_Pointer trigger_pointer;

extern bool flush_flag;
extern unsigned char alternate_flush_flag;

extern bool ip_status;
extern double elapsedTime;

#endif
