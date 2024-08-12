#include <Inc/uart_key.h>

static int fd =-1;
static KEY_VALUE key_val = 0;

int test_mode = 0;

void *UartKeyBoard(void* threadid){
    int nread=0;
    uchar buff[512];
	fd = OpenUart("/dev/ttyS0", 19200, 8, 1, 'N');
    if( fd < 0 )
    {
        return 0;
    }
    HardwareKeyboardMapInit();
    //循环读取数据
    while((nread = read(fd, buff, sizeof(buff))) > 0)
    {
		key_val = buff[0];
		key_val = HardwareKeyboardToKeyCode(key_val);
        printf("K:0x%02x,\n", (int)key_val);
        deal_key();
    }
    close(fd);
	fd = -1;
    return 0;
}

void deal_key(){
    KEY_VALUE key = read_key();
    if (key<=0x84 && key>=0x80){
        switch (key) {
            case 0x80:
               if(tool_bar.Id == 1) tool_bar.Id = 0;
               else tool_bar.Id = 1;
               break;
            case 0x81:
                if(tool_bar.Id == 2){
                    tool_bar.Id = 0;
                    trig_float_bar.Id = 0;
                }
                else tool_bar.Id = 2;
                break;
            case 0x82:
                if(tool_bar.Id == 3){
                    tool_bar.Id = 0;
                    set_float_bar.Id = 0;
                }
                else tool_bar.Id = 3;
                break;
            case 0x83:
                if(tool_bar.Id == 4) {
                    tool_bar.Id = 0;
                    ai_float_bar.Id = 0;
                }
                else tool_bar.Id = 4;
                break;
            case 0x84:
                if(tool_bar.Id == 5) tool_bar.Id = 0;
                else tool_bar.Id = 5;
               break;
            default :
                DO_NOTHING;
        }
    }
    // 水平平移
    else if(key<=0xc5 && key>=0xc3){
        switch (key) {
            case 0xc3:
               ch4_ui.herizontal_pos -= 1;
               info_box.life_time = INFO_BOX_LIFE_TIME;
               swprintf(info_box.buff, 100, L"T Pos = %d", ch4_ui.herizontal_pos);
               break;
            case 0xc4:
               ch4_ui.herizontal_pos += 1;
               info_box.life_time = INFO_BOX_LIFE_TIME;
               swprintf(info_box.buff, 100, L"T Pos = %d", ch4_ui.herizontal_pos);
               break;
            case 0xc5:
               ch4_ui.herizontal_pos = 0;
               info_box.life_time = INFO_BOX_LIFE_TIME;
               swprintf(info_box.buff, 100, L"T Pos = %d", ch4_ui.herizontal_pos);
               break;
            default :
               DO_NOTHING
        }
    }
    // --------------------------------------垂直平移--------------------------------------
    else if(key<=0xc2 && key>=0xc0){
        switch (key) {
            case 0xc0:
                if(test_mode == 0){
                   dac_bias.ch4_end_bias++;
                   HW_SetDAC_EndBias(ID_CH4, dac_bias.ch4_end_bias);
                   info_box.life_time = INFO_BOX_LIFE_TIME;
                   swprintf(info_box.buff, 100, L"end bias = %d", dac_bias.ch4_end_bias);
                }
                else if(test_mode == 1){
                    dac_bias.ch4_ref+=1;
                    HW_SetDAC_REF(ID_CH4, dac_bias.ch4_ref);
                    info_box.life_time = INFO_BOX_LIFE_TIME;
                    swprintf(info_box.buff, 100, L"ch4_ref = %d", dac_bias.ch4_ref);
                }
                else if(test_mode == 2){
                    dac_bias.ch4_pre_bias += 0.5;
                    HW_SetDAC_PreBias(ID_CH4, dac_bias.ch4_pre_bias);
                    info_box.life_time = INFO_BOX_LIFE_TIME;
                    swprintf(info_box.buff, 100, L"ch4_pre_bias = %.1f", dac_bias.ch4_pre_bias);
                }
               break;
            case 0xc1:
                if(test_mode == 0){
                   dac_bias.ch4_end_bias--;
                   HW_SetDAC_EndBias(ID_CH4, dac_bias.ch4_end_bias);
                   info_box.life_time = INFO_BOX_LIFE_TIME;
                   swprintf(info_box.buff, 100, L"end bias = %d", dac_bias.ch4_end_bias);
                }
                else if(test_mode == 1){
                    dac_bias.ch4_ref-=1;
                    HW_SetDAC_REF(ID_CH4, dac_bias.ch4_ref);
                    info_box.life_time = INFO_BOX_LIFE_TIME;
                    swprintf(info_box.buff, 100, L"ch4_ref = %d", dac_bias.ch4_ref);
                }
                else if(test_mode == 2){
                    dac_bias.ch4_pre_bias-=0.5;
                    HW_SetDAC_PreBias(ID_CH4, dac_bias.ch4_pre_bias);
                    info_box.life_time = INFO_BOX_LIFE_TIME;
                    swprintf(info_box.buff, 100, L"ch4_pre_bias = %.1f", dac_bias.ch4_pre_bias);
                }
               break;
            case 0xc2:
                dac_bias.ch4_end_bias = DAC_CH4_END_BIAS_INIT;
                HW_SetDAC_EndBias(ID_CH4, dac_bias.ch4_end_bias);
                info_box.life_time = INFO_BOX_LIFE_TIME;
                swprintf(info_box.buff, 100, L"end bias = %d", dac_bias.ch4_end_bias);
                break;
            default :
               DO_NOTHING
        }
    }
    // 触发指针
    else if(key<=0xc8 && key>=0xc6){
        switch (key) {
            case 0xc6:
               if((ushort)(YSCALE_VALUE_RATE * ch1_info.trig_level / eYScale_value[ch4_ui.yscale]) > -120){
                   ch1_info.trig_level -= eYScale_value[ch4_ui.yscale] / 20;
               }
               break;
            case 0xc7:
                if((ushort)(YSCALE_VALUE_RATE * ch1_info.trig_level / eYScale_value[ch4_ui.yscale]) < 120){
                    ch1_info.trig_level += eYScale_value[ch4_ui.yscale] / 20;
                }
               break;
            case 0xc8:
               ch1_info.trig_level = 0;
               break;
            default :
               DO_NOTHING
        }
    }
    // 水平尺度
    else if(key<=0xce && key>=0xcc){
        switch (key) {
            case 0xcc:
               if(ch4_ui.xscale_model){
                   if(ch4_ui.xscale_skip < 12) ch4_ui.xscale_skip++;
               }
               else{
                   if(ch4_ui.time_base < XLEV_MAX) ch4_ui.time_base++;
                   FPGA_Time_Base_Set(ch4_ui.time_base);
               }
               break;
            case 0xcd:
               if(ch4_ui.xscale_model){
                   if(ch4_ui.xscale_skip>1) ch4_ui.xscale_skip--;
               }
               else{
                   if(ch4_ui.time_base > XLEV_MIN) ch4_ui.time_base--;
                   FPGA_Time_Base_Set(ch4_ui.time_base);
               }
               break;
            case 0xce:
               ch4_ui.xscale_model = !ch4_ui.xscale_model;
               if(ch4_ui.xscale_model){
                   info_box.life_time = INFO_BOX_LIFE_TIME;
                   swprintf(info_box.buff, 100, L"细调");
               }
               else{
                   info_box.life_time = INFO_BOX_LIFE_TIME;
                   swprintf(info_box.buff, 100, L"粗调");
               }
               break;
            default :
               DO_NOTHING
        }
    }
    // 垂直尺度
    else if(key<=0xcb && key>=0xc9){
        switch (key) {
            case 0xc9:
                if(ch4_ui.yscale_model){
                    if(ch4_ui.yscale_rate<4) ch4_ui.yscale_rate++;
                }
                else{
                    if(ch4_ui.yscale<YLEV_MAX){
                        ch4_ui.yscale++;
                        SetYscaleAndDAC(ID_CH4, ch4_ui.yscale);
                    }
                }
                break;
            case 0xca:
                if(ch4_ui.yscale_model){
                    if(ch4_ui.yscale_rate>1) ch4_ui.yscale_rate--;
                }
                else{
                    if(ch4_ui.yscale>YLEV_MIN){
                        ch4_ui.yscale--;
                        SetYscaleAndDAC(ID_CH4, ch4_ui.yscale);
                    }
                }
               break;
            case 0xcb:
                ch4_ui.yscale_model = !ch4_ui.yscale_model;
                if(ch4_ui.yscale_model){
                    info_box.life_time = INFO_BOX_LIFE_TIME;
                    swprintf(info_box.buff, 100, L"细调");
                }
                else{
                    info_box.life_time = INFO_BOX_LIFE_TIME;
                    swprintf(info_box.buff, 100, L"粗调");
                }
                break;
            default :
               DO_NOTHING
        }
    }
    // 万能旋钮 LED
    else if(key<=0xbd && key>=0xbb){
        switch (key) {
            case 0xbb:
               if(tool_bar.Id == 2){
                   if(trig_float_bar.Id < 6) trig_float_bar.Id++;
                   else trig_float_bar.Id = 1;
               }
               else if(tool_bar.Id == 3){
                   if(set_float_bar.Id < 4) set_float_bar.Id++;
                   else set_float_bar.Id = 1;
               }
               else if(tool_bar.Id == 4){
                   if(ai_float_bar.Id < 4) ai_float_bar.Id++;
                   else ai_float_bar.Id = 1;
               }
               break;
            case 0xbc:
                if(tool_bar.Id == 2){
                    if(trig_float_bar.Id > 1) trig_float_bar.Id--;
                    else trig_float_bar.Id = 6;
                }
                else if(tool_bar.Id == 3){
                    if(set_float_bar.Id > 1) set_float_bar.Id--;
                    else set_float_bar.Id = 4;
                }
                else if(tool_bar.Id == 4){
                    if(ai_float_bar.Id > 1) ai_float_bar.Id--;
                    else ai_float_bar.Id = 4;
                }
               break;
            case 0xbd:
                if(tool_bar.Id == 2){
                    if(trig_float_bar.Id == 0);
                    else if(trig_float_bar.Id < 5){
                        SetTrigStatus(trig_float_bar.Id - 1);
                    }
                    else{
                        SetTrigEdge(trig_float_bar.Id - 5);
                    }
                    tool_bar.Id = 0;
                    trig_float_bar.Id = 0;
                }
                else if(tool_bar.Id == 3){
                    if(set_float_bar.Id == 0);
                    else if(set_float_bar.Id < 3){
                        HW_UpdataChCoupling(ID_CH4, set_float_bar.Id - 1);
                    }
                    else{
                        HW_SetChBandwidth(ID_CH4, set_float_bar.Id - 3);
                    }
                    tool_bar.Id = 0;
                    set_float_bar.Id = 0;
                }
                else if(tool_bar.Id == 4){
                    tool_bar.Id = 0;
                    if(ai_float_bar.Id < 1) ;
                    else if(ai_float_bar.Id < 3) ch4_ui.ai_status = ai_float_bar.Id - 1;
                    else if(ai_float_bar.Id < 5) ch4_ui.ai_method = ai_float_bar.Id - 3;
                    ai_float_bar.Id = 0;
                }
               break;
            default :
               DO_NOTHING
        }
    }
    else if(key==0xa2){
//        ch1_ui.wave_stop = !ch1_ui.wave_stop;
//        SetYscale(ID_CH1, YLEV100MV);
        if(test_mode < 2) test_mode++;
        else test_mode=0;
        info_box.life_time = INFO_BOX_LIFE_TIME;
        swprintf(info_box.buff, 100, L"test mode = %d", test_mode);
    }
    else if(key == 0xb1){
        save_wave();
    }
    else if(key<=0xb4 && key>=0xb3){
        switch (key) {
            case 0xb3:
               AutoSet();
               break;
            case 0xb4:
               RunStop(ch4_ui.wave_stop);
               break;
            default :
               DO_NOTHING
        }
    }
    else if(key == 0xd3){
        ChangeTrigStatus();
    }
    renew_key();
}

unsigned char read_key(){
    return key_val;
}

void renew_key(){
    key_val = 0;
}

int UartKeyBoard_Write(unsigned int LED){
    static uint LED_BAK = 0xFFFFFFFF;
    if(fd<0)
        return 0;
    if(LED_BAK == LED)
        return 0;

    LED_BAK = LED;
    //Printf("Wirte KeyBoard LED 0x%04X\n",LED);

    uchar *pLED8b = (uchar *)&LED_BAK;
    uchar tx[]={0xFF, pLED8b[0], pLED8b[1]};

    if(write(fd, tx ,sizeof(tx)) == -1)
    {
        printf("Wirte sbuf error./n");
    }
    usleep(1000);
    return 0;
}
