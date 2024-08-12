#include <ui_display.h>

void *ui_display(void* threadid)
{
    // 显示初始化
    CDevDrm DevDrm;
    // 字体库初始化
    Fnt_Init();

    FpgaConfig();
    OpenFPGA();
    HW_ADC_Init();
    CD4094SendADCInit();
    HW_InitDAC_LTC2620();

    SendCmdToLEDInit();
    Opencl my_cl;
    my_cl.Init();

    ui::painter p(g_FrameBuffer, LCD_WIDTH, LCD_HEIGHT);

    while (1) {
        // UI显示字符缓冲
//        UI_CHAR buff[100]={0};
        AcquireWave(&my_cl);
        // 绘制界面
        p.draw_win_base();
        // 绘制logo
        if(flush_flag) p.draw_logo();
        // 绘制波形
        p.drawWaveVector(&main_window, GetWaveCenterPointer(), main_window.x1 - main_window.x0, CH1_COLOR, &ch4_ui);
        // 绘制测量栏
        p.drawMeasurementBar(&measurement_bar);
        p.draw_pointer();
        p.draw_info_box();
        if(tool_bar.Id == 2) p.draw_trig_float_bar();
        else if(tool_bar.Id == 3) p.draw_set_float_bar();
        else if(tool_bar.Id == 4) p.draw_ai_float_bar();
        // 刷新显示
        DevDrm.Write(g_FrameBuffer, 0, 0, LCD_WIDTH, LCD_HEIGHT, sizeof(UI_COLOR));
        DevDrm.DrmModePageFlip(0, g_FrameBuffer);
        if(flush_flag) flush_flag = 0;
        if(alternate_flush_flag < 3) alternate_flush_flag++;
        else alternate_flush_flag = 0;
    }
    return 0;
}
