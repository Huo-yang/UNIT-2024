#include <Acquire.h>

vWave_t gAcqWave[WIVE_FIFO_DEEPTH*25]={};
vWave_t Wave[WIVE_FIFO_DEEPTH]={};
float aiWave[1024]={};

int valible_wave_length = 0;
int save_flag = 0;
bool first_read_flag = 1;
bool auto_set_flag = 0;
int save_count = 1998;

SignalINFO ch1_info = {
    .trig_level = 0,
    .min = 0,
    .max = 0,
    .period = 0,
    .frequency = 0,
    .vpp = 0,
};

void AcquireWave(Opencl *my_cl){
    if(first_read_flag){
        // 使能FPGA读取寄存器数据
        FPGA_WriteW(eFRA_FPGA_updata_state, 0);
        Wave_FIFO_Clean(true);
        Wave_FIFO_Start(true);
        first_read_flag = 0;
    }
    // 更新触发值
    Update_FPGA_Trig_Set();
    // 配置触发
    FPGA_Trig_Set(ch4_fpga_info.trig_mode, ch4_fpga_info.trig_edge, ch4_fpga_info.trig_level);
    if(!ch4_ui.wave_stop){
        if(ch4_fpga_info.trig_mode == 0) no_trigger(my_cl);
        else if(ch4_fpga_info.trig_mode < 3) auto_trigger_normal_trigger(my_cl);
        else if(ch4_fpga_info.trig_mode == 3){
            single_trigger(my_cl);
            usleep(100000);
            single_trigger(my_cl);
        }
        if(ch4_ui.ai_status == 1){
            int ret = 1;
            ret = my_cl->UnitNet(GetWaveForAi(), &ch4_ui.ai_result);
            if(ret != 0){
                ch4_ui.ai_status = 0;
                ch4_ui.ai_result = -1;
            }
            else{
                if(ch4_ui.ai_method == 1){
                    switch(ch4_ui.ai_result){
                        case -1:
                            break;
                        case 0:
                            ch4_ui.wave_stop = 1;
                            RunStopLed(0);
                            break;
                        case 1:
                            break;
                        case 2:
                            ch4_ui.wave_stop = 1;
                            RunStopLed(0);
                            break;
                        case 3:
                            ch4_ui.wave_stop = 1;
                            RunStopLed(0);
                            break;
                    }
                }
            }
        }
    }
    if(auto_set_flag){
        clock_t start,finish;
        start = clock();
        auto_set();
        finish = clock();
        printf("cost time %ld us\n", (finish - start));
        ch4_ui.wave_stop = 0;
    }
    if(save_flag){
        save_flag = 0;
        printf("save wave\n");
        char command[256];
        snprintf(command, sizeof(command), "/mnt/spike_up_square_%d.txt", save_count);
        WriteWaveToTXT(command);
//        snprintf(command, sizeof(command), "/mnt/hook_in_posedge_squre_ai_%d.txt", save_count);
//        WriteAIWaveToTXT(command);
        save_count++;
    }
}

void no_trigger(Opencl *my_cl){
    int ret;
    ret = FPGA_FIFO_FULL();
    if(ret){
        FPGA_Read_Wave(gAcqWave, Wave, aiWave, WIVE_FIFO_DEEPTH);
        valible_wave_length = WIVE_FIFO_DEEPTH;
        GetWaveINFOFromFPGA();
        cul_signal_info();
        ch4_fpga_info.trig_pos = 4096;
        if(eXScale_inset_value[ch4_ui.time_base]>1) insert_value();
        if(eXScale_draw_value[ch4_ui.time_base]>1) draw_value();
        Wave_FIFO_Clean(true);
    }
    Wave_FIFO_Start(true);
}

void auto_trigger_normal_trigger(Opencl *my_cl){
    // 等待fifo写满
    int ret;
    ret = FPGA_FIFO_FULL();
    if(ret){
        // 读取fifo中的数据
        FPGA_Read_Wave(gAcqWave, Wave, aiWave, WIVE_FIFO_DEEPTH);
        valible_wave_length = WIVE_FIFO_DEEPTH;
        GetWaveINFOFromFPGA();
        cul_signal_info();
        HardwareTrigger();
        if(eXScale_inset_value[ch4_ui.time_base]>1) insert_value();
        if(eXScale_draw_value[ch4_ui.time_base]>1) draw_value();
    }
    // 通知FPGA读取完毕
    FPGA_Notify_Trigger();
}

void single_trigger(Opencl *my_cl){
    // 等待fifo写满
    int ret;
    ret = FPGA_FIFO_FULL();
    if(ret){
        // 读取fifo中的数据
        FPGA_Read_Wave(gAcqWave, Wave, aiWave, WIVE_FIFO_DEEPTH);
        valible_wave_length = WIVE_FIFO_DEEPTH;
        GetWaveINFOFromFPGA();
        cul_signal_info();
        HardwareTrigger();
        if(eXScale_inset_value[ch4_ui.time_base]>1) insert_value();
        if(eXScale_draw_value[ch4_ui.time_base]>1) draw_value();
        RunStop(0);
    }
    // 通知FPGA读取完毕
    FPGA_Notify_Trigger();
}

//void auto_set(){
//    auto_set_flag = 0;
//    bool bias_flag = 0;
//    bool yScale_flag = 0;
//    bool xScale_flag = 0;
//    vWave_t prediff_abs = 255;
//    uint pre_end_bias = 1250;
//    FPGA_WriteW (eFRA_trig_mode, 0);
//    do{
//        Wave_FIFO_Clean(true);
//        Wave_FIFO_Start(true);
//        int ret=0;
//        do ret = FPGA_FIFO_FULL();
//        while(!ret);
//        GetWaveINFOFromFPGA();
//        printf("<----------------->\n");
//        if(ch1_fpga_info.vpp == 0){
//            printf("vpp error\n");
//            ch1_ui.time_base++;
//            FPGA_Time_Base_Set(ch1_ui.time_base);
//            continue;
//        }
//        //---------------------------------偏置调整--------------------------------
//        if(!bias_flag){
//            vWave_t wave_mid = (vWave_t)ch1_fpga_info.vpp/2 + ch1_fpga_info.min;
//            vWave_t diff_abs = abs(wave_mid - 126); // 最大值容易抖动
//            printf("mid:%d\n", wave_mid);
//            if(wave_mid>128){
//                dac_bias.ch1_end_bias++;
//                if(dac_bias.ch1_end_bias==2000) bias_flag=1;
//                HW_SetDAC_EndBias_updata(ch1_ui.yscale, dac_bias.ch1_end_bias);
//            }
//            else if(wave_mid<124){
//                dac_bias.ch1_end_bias--;
//                if(dac_bias.ch1_end_bias==500) bias_flag=1;
//                HW_SetDAC_EndBias_updata(ch1_ui.yscale, dac_bias.ch1_end_bias);
//            }
//            else{
//                bias_flag=1;
//                printf("Success of auto bias\n");
//            }
//            if((diff_abs >= prediff_abs)&&(!bias_flag)){
//                bias_flag = 1;
//                dac_bias.ch1_end_bias = pre_end_bias;
//                HW_SetDAC_EndBias_updata(ch1_ui.yscale, dac_bias.ch1_end_bias);
//                printf("Success of auto bias\n");
//            }
//            pre_end_bias = dac_bias.ch1_end_bias;
//            prediff_abs = diff_abs;
//        }
//        //---------------------------------幅格调整--------------------------------
//        if(bias_flag && (!yScale_flag)){
//            printf("vpp:%d\n", ch1_fpga_info.vpp);
//            if(ch1_fpga_info.vpp>178){
//                if(ch1_ui.yscale==YLEV_MAX) yScale_flag=1;
//                else{
//                    bias_flag=0;
//                    ch1_ui.yscale++;
//                    SetYscale(ID_CH1, ch1_ui.yscale);
//                }
//            }
//            else if(ch1_fpga_info.vpp<70){
//                if(ch1_ui.yscale==YLEV_MIN) yScale_flag=1;
//                else{
//                    bias_flag=0;
//                    ch1_ui.yscale--;
//                    SetYscale(ID_CH1, ch1_ui.yscale);
//                }
//            }
//            else{
//                yScale_flag=1;
//                printf("Success of auto yScale\n");
//            }
//        }
//        //---------------------------------时基调整--------------------------------
//        if(yScale_flag && (!xScale_flag)){
//            double period;
//            if(ch1_fpga_info.frequency_count) period = 1000000000/ch1_fpga_info.frequency_count; // 单位ns
//            printf("freq:%d\n", (int)ch1_fpga_info.frequency_count);
//            double n_period = (12 * eXScale_value[ch1_ui.time_base])/period;
//            printf("n_perid:%f\n", n_period);
//            if(n_period>10){
//                ch1_ui.time_base--;
//                if(ch1_ui.time_base==XLEV_MIN) xScale_flag=1;
//                FPGA_Time_Base_Set(ch1_ui.time_base);
//            }
//            else if(n_period<4){
//                ch1_ui.time_base++;
//                if(ch1_ui.time_base==XLEV_MAX) xScale_flag=1;
//                FPGA_Time_Base_Set(ch1_ui.time_base);
//            }
//            else{
//                xScale_flag=1;
//                printf("Success of auto xScale\n");
//            }
//        }
//    }while(!(bias_flag&&yScale_flag&&xScale_flag));
//    printf("Success of auto set\n");
//}

void auto_set(){
    auto_set_flag = 0;
    int bias_diff_flag = 0;
    bool bias_flag = 0;
    bool yScale_flag = 0;
    bool xScale_flag = 0;
    vWave_t prediff_abs = 255;
    uint pre_end_bias = 1250;
    // --------------------------------------切换到不触发模式下----------------------------------------
    FPGA_WriteW (eFRA_trig_mode, 0);
    // ------------------------------------------时基初始化------------------------------------------
    if(ch4_fpga_info.frequency_count <= 10) ch4_ui.time_base = XLEV_2MS;
    else if(ch4_fpga_info.frequency_count <= 25) ch4_ui.time_base = XLEV_1MS;
    else if(ch4_fpga_info.frequency_count <= 50) ch4_ui.time_base = XLEV_500US;
    else if(ch4_fpga_info.frequency_count <= 100) ch4_ui.time_base = XLEV_200US;
    else if(ch4_fpga_info.frequency_count <= 250) ch4_ui.time_base = XLEV_100US;
    else if(ch4_fpga_info.frequency_count <= 500) ch4_ui.time_base = XLEV_50US;
    else if(ch4_fpga_info.frequency_count <= 1000) ch4_ui.time_base = XLEV_20US;
    else if(ch4_fpga_info.frequency_count <= 2500) ch4_ui.time_base = XLEV_10US;
    else if(ch4_fpga_info.frequency_count <= 5000) ch4_ui.time_base = XLEV_5US;
    else if(ch4_fpga_info.frequency_count <= 10000) ch4_ui.time_base = XLEV_2US;
    else if(ch4_fpga_info.frequency_count <= 25000) ch4_ui.time_base = XLEV_1US;
    else if(ch4_fpga_info.frequency_count <= 50000) ch4_ui.time_base = XLEV_500NS;
    else ch4_ui.time_base = XLEV_200NS;
    FPGA_Time_Base_Set(ch4_ui.time_base);
    // -------------------------------------------自动设置-----------------------------------------
    do{
        Wave_FIFO_Clean(true);
        Wave_FIFO_Start(true);
        int ret=0;
        do ret = FPGA_FIFO_FULL();
        while(!ret);
        GetWaveINFOFromFPGA();
        vWave_t maxmin = FPGA_Read_Wave(WIVE_FIFO_DEEPTH);
        uchar max = (maxmin >> 8) & 0xFF;
        uchar min = maxmin & 0xFF;
        uchar vpp = max - min;
        uchar run_count = 0;
        printf("max:%d  min:%d\n", max, min);
        printf("<--------AUTO--------->\n");
        //---------------------------------偏置调整--------------------------------
        if(!bias_flag){
            vWave_t wave_mid = vpp/2 + min;
            vWave_t diff_abs = abs(wave_mid - 126); // 最大值容易抖动
            printf("mid:%d\n", wave_mid);
            if(wave_mid > 130){
                if(wave_mid > 180){
                    dac_bias.ch4_end_bias += 3;
                }
                else if(wave_mid > 145){
                    dac_bias.ch4_end_bias += 2;
                }
                else{
                    dac_bias.ch4_end_bias++;
                }
                if(dac_bias.ch4_end_bias>=2000) bias_flag=1;
                HW_SetDAC_EndBias_updata(ch4_ui.yscale, dac_bias.ch4_end_bias);
            }
            else if(wave_mid < 126){
                if(wave_mid < 76){
                    dac_bias.ch4_end_bias -= 3;
                }
                else if(wave_mid < 111){
                    dac_bias.ch4_end_bias -= 2;
                }
                else{
                    dac_bias.ch4_end_bias--;
                }
                if(dac_bias.ch4_end_bias<=500) bias_flag=1;
                HW_SetDAC_EndBias_updata(ch4_ui.yscale, dac_bias.ch4_end_bias);
            }
            else{
                bias_flag = 1;
                printf("Success of auto bias\n");
            }
            if((diff_abs >= prediff_abs) && (!bias_flag)){
                if(bias_diff_flag == 3){
                    bias_flag = 1;
                    dac_bias.ch4_end_bias = pre_end_bias;
                    HW_SetDAC_EndBias_updata(ch4_ui.yscale, dac_bias.ch4_end_bias);
                    printf("Success of auto bias\n");
                }
                bias_diff_flag++;
                printf("+++++\n");
            }
            else{
                bias_diff_flag = 0;
                prediff_abs = diff_abs;
            }
            pre_end_bias = dac_bias.ch4_end_bias;
        }
        //---------------------------------幅格调整--------------------------------
        if(bias_flag && (!yScale_flag)){
            printf("vpp:%d\n", vpp);
            if(vpp > 178){
                if(ch4_ui.yscale==YLEV_MAX) yScale_flag=1;
                else{
                    bias_flag = 0;
                    ch4_ui.yscale++;
                    SetYscale(ID_CH4, ch4_ui.yscale);
                }
            }
            else if(vpp < 70){
                if(ch4_ui.yscale==YLEV_MIN) yScale_flag=1;
                else{
                    bias_flag = 0;
                    ch4_ui.yscale--;
                    SetYscale(ID_CH4, ch4_ui.yscale);
                }
            }
            else{
                yScale_flag = 1;
                printf("Success of auto yScale\n");
            }
        }
        //---------------------------------时基调整--------------------------------
        if(yScale_flag && (!xScale_flag)){
            if(ch4_fpga_info.frequency_count <= 10) ch4_ui.time_base = XLEV_50MS;
            else if(ch4_fpga_info.frequency_count <= 25) ch4_ui.time_base = XLEV_20MS;
            else if(ch4_fpga_info.frequency_count <= 50) ch4_ui.time_base = XLEV_10MS;
            else if(ch4_fpga_info.frequency_count <= 100) ch4_ui.time_base = XLEV_5MS;
            else if(ch4_fpga_info.frequency_count <= 250) ch4_ui.time_base = XLEV_2MS;
            else if(ch4_fpga_info.frequency_count <= 500) ch4_ui.time_base = XLEV_1MS;
            else if(ch4_fpga_info.frequency_count <= 1000) ch4_ui.time_base = XLEV_500US;
            else if(ch4_fpga_info.frequency_count <= 2500) ch4_ui.time_base = XLEV_200US;
            else if(ch4_fpga_info.frequency_count <= 5000) ch4_ui.time_base = XLEV_100US;
            else if(ch4_fpga_info.frequency_count <= 10000) ch4_ui.time_base = XLEV_50US;
            else if(ch4_fpga_info.frequency_count <= 25000) ch4_ui.time_base = XLEV_20US;
            else if(ch4_fpga_info.frequency_count <= 50000) ch4_ui.time_base = XLEV_10US;
            else if(ch4_fpga_info.frequency_count <= 100000) ch4_ui.time_base = XLEV_5US;
            else if(ch4_fpga_info.frequency_count <= 250000) ch4_ui.time_base = XLEV_2US;
            else if(ch4_fpga_info.frequency_count <= 500000) ch4_ui.time_base = XLEV_1US;
            else if(ch4_fpga_info.frequency_count <= 1000000) ch4_ui.time_base = XLEV_500NS;
            else if(ch4_fpga_info.frequency_count <= 2500000) ch4_ui.time_base = XLEV_200NS;
            else if(ch4_fpga_info.frequency_count <= 5000000) ch4_ui.time_base = XLEV_100NS;
            else if(ch4_fpga_info.frequency_count <= 10000000) ch4_ui.time_base = XLEV_50NS;
            else if(ch4_fpga_info.frequency_count <= 25000000) ch4_ui.time_base = XLEV_20NS;
            else if(ch4_fpga_info.frequency_count <= 50000000) ch4_ui.time_base = XLEV_10NS;
            else if(ch4_fpga_info.frequency_count <= 100000000) ch4_ui.time_base = XLEV_5NS;
            else ch4_ui.time_base = XLEV_2NS;
            FPGA_Time_Base_Set(ch4_ui.time_base);
            xScale_flag = 1;
        }
        if(run_count > 50)
            break;
        run_count++;
    }while(!(bias_flag && yScale_flag && xScale_flag));
    printf("Success of auto set\n");
}

void auto_set_endbias(){
    FPGA_WriteW (eFRA_trig_mode, 0);
    for(int yscale=YLEV_MIN;yscale<YLEV_MAX+1;yscale++){
        SetYscale(ID_CH4, yscale);
        bool bias_flag = 0;
        do{
            int ret=0;
            do ret = FPGA_FIFO_FULL();
            while(!ret);
            GetWaveINFOFromFPGA();
            Wave_FIFO_Clean(true);
            Wave_FIFO_Start(true);
            vWave_t wave_mid = (vWave_t)ch4_fpga_info.vpp/2 + ch4_fpga_info.min;
            if(wave_mid>130){
                dac_bias.ch1_end_bias++;
                if(dac_bias.ch1_end_bias==2000) bias_flag=1;
                HW_SetDAC_EndBias_updata(yscale, dac_bias.ch1_end_bias);
            }
            else if(wave_mid<126){
                dac_bias.ch1_end_bias--;
                if(dac_bias.ch1_end_bias==500) bias_flag=1;
                HW_SetDAC_EndBias_updata(yscale, dac_bias.ch1_end_bias);
            }
            else{
                bias_flag=1;
                printf("Success of auto bias\n");
            }
        }while(!(bias_flag));
    }
}

void cul_signal_info(){
    ch1_info.max = ((double)ch4_fpga_info.max - ADC_MID)*eYScale_value[ch4_ui.yscale]/YSCALE_VALUE_RATE; // 单位mv
    ch1_info.min = ((double)ch4_fpga_info.min - ADC_MID)*eYScale_value[ch4_ui.yscale]/YSCALE_VALUE_RATE; // 单位mv
    ch1_info.vpp = ch1_info.max - ch1_info.min; // 单位mv
    ch1_info.frequency = ch4_fpga_info.frequency_count; // 单位HZ
    if(ch1_info.frequency) ch1_info.period = 1000000000/ch1_info.frequency; // 单位ns
}

float linear_interpolate(float x, float x1, float y1, float x2, float y2) {
    return y1 + (y2 - y1) * ((x - x1) / (x2 - x1));
}

double sinc(double i)
{
    return i?sin(3.1415926535*i)/(3.1415926535*i):1;
}

double sinc_interpolate(double x[],int size,double d)
{
  int i;
  double sum=0;
  for(i=0;i<size;i++)
    sum+=x[i]*sinc(d-i);
  return sum;
}

void insert_value(){
    // --------------------------------线性插值---------------------------------------
#if 1
    for(int i=0;i<valible_wave_length-1;i++){
        float x1 = i * eXScale_inset_value[ch4_ui.time_base];
        float x2 = (i+1) * eXScale_inset_value[ch4_ui.time_base];
        float y1 = gAcqWave[(int)x1];
        float y2 = gAcqWave[(int)x2];
        for(int j=1;j<eXScale_inset_value[ch4_ui.time_base];j++){
            float x = x1 + j;
            gAcqWave[(int)x] = (unsigned char)linear_interpolate(x, x1, y1, x2, y2);
        }
    }
    valible_wave_length = valible_wave_length * eXScale_inset_value[ch4_ui.time_base] - eXScale_inset_value[ch4_ui.time_base] + 1;
    int bias_pos;
    switch(ch4_ui.time_base){
    case XLEV_2NS:
        bias_pos = 90;
        break;
    case XLEV_5NS:
        bias_pos = 36;
        break;
    case XLEV_10NS:
        bias_pos = 19;
        break;
    case XLEV_20NS:
        bias_pos = 22;
        break;
    default:
        bias_pos = 0;
    }
    ch4_fpga_info.trig_pos = ch4_fpga_info.trig_pos * eXScale_inset_value[ch4_ui.time_base] - bias_pos;
    ch4_fpga_info.trig_pos = LIMIT(ch4_fpga_info.trig_pos, 0, valible_wave_length);
    // --------------------------------sinc内插---------------------------------------
#else
    int cont_num = 16;
    int part_num = (int)(8192/cont_num);
    for(int part_index=0 + 200;part_index<part_num - 200;part_index++){
        for(int i=0;i<cont_num*eXScale_inset_value[ch4_ui.time_base];i++){
            int index = i + cont_num*eXScale_inset_value[ch4_ui.time_base]*part_index;
            if(i%eXScale_inset_value[ch4_ui.time_base] == 0){
                continue;
            }
            else{
                double y = 0;
                for(int j=-8;j<cont_num+8;j++){
                    double x = (double)i/(double)eXScale_inset_value[ch4_ui.time_base]-(double)j;
                    y += Wave[part_index*cont_num + j] * sinc(x);
                }
                gAcqWave[index] = y;
            }
        }
    }
    valible_wave_length = valible_wave_length * eXScale_inset_value[ch4_ui.time_base];
#endif
}

void draw_value(){
    vWave_t* get_pos = &gAcqWave[ch4_fpga_info.trig_pos];
    vWave_t* start_pos = &gAcqWave[ch4_fpga_info.trig_pos];
    uchar skip = eXScale_draw_value[ch4_ui.time_base];
    if(0){
        for(int i=1; ch4_fpga_info.trig_pos + 4 * i < valible_wave_length; i++){
            get_pos++;
            if(i%2 == 1) start_pos += 6;
            else start_pos += 2;
            *get_pos = *start_pos;
        }
        get_pos = &gAcqWave[ch4_fpga_info.trig_pos];
        start_pos = &gAcqWave[ch4_fpga_info.trig_pos];
        for(int i=1; ch4_fpga_info.trig_pos - 4 * i < valible_wave_length; i++){
            get_pos--;
            if(i%2 == 1) start_pos -= 6;
            else start_pos -= 2;
            *get_pos = *start_pos;
        }
    }
    else{
        for(int i=1; ch4_fpga_info.trig_pos + 4 * i < valible_wave_length; i++){
            get_pos++;
            start_pos += skip;
            *get_pos = *(start_pos);
        }
        get_pos = &gAcqWave[ch4_fpga_info.trig_pos];
        start_pos = &gAcqWave[ch4_fpga_info.trig_pos];
        for(int i=1; ch4_fpga_info.trig_pos - 4 * i > 0; i++){
            get_pos--;
            start_pos -= skip;
            *get_pos = *(start_pos);
        }
        valible_wave_length = (int)(valible_wave_length/skip);
    }
}

vWave_t* GetWaveCenterPointer()
{
    return &gAcqWave[ch4_fpga_info.trig_pos];
}

float* GetWaveForAi()
{
    return &aiWave[0];
}

void ResetGetWave()
{
    for(int i = 0; i < WIVE_FIFO_DEEPTH; i++)
    {
        gAcqWave[i] = ADC_MID;
    }
}

void GetWaveINFOFromFPGA(){
    // 获取触发计数计算频率值
//    ushort frequency_H = FPGA_ReadW(eFRA_trig_count_H);
//    ushort frequency_L = FPGA_ReadW(eFRA_trig_count_L);
//    ch1_fpga_info.frequency_count = (frequency_H << 16) | frequency_L;
//    if(ch1_fpga_info.frequency_count < 1000){
//        frequency_H = FPGA_ReadW(eFRA_trig_low_count_H);
//        frequency_L = FPGA_ReadW(eFRA_trig_low_count_L);
//        if((frequency_H << 16) | frequency_L)
//        ch1_fpga_info.frequency_count = 125000000/((frequency_H << 16) | frequency_L);
//    }
//    if(FPGA_ReadW(eFRA_trig_count_flag)){
    int64_t frequency_FX = (FPGA_ReadW(eFRA_trig_count_FXH) << 16) | FPGA_ReadW(eFRA_trig_count_FXL);
    int64_t frequency_FS = (FPGA_ReadW(eFRA_trig_count_FSH) << 16) | FPGA_ReadW(eFRA_trig_count_FSL);
    ch4_fpga_info.frequency_count = ((float)(frequency_FX * 250000000)) / ((float)(frequency_FS));
//    }
    ch4_fpga_info.max = FPGA_ReadW(eFRA_wave_max);
    ch4_fpga_info.min = FPGA_ReadW(eFRA_wave_min);
    ch4_fpga_info.vpp = ch4_fpga_info.max - ch4_fpga_info.min;
}

void SoftwareTrigger(){
    // 从屏幕显示位置开始软件遍历触发
    int start_pos = (valible_wave_length - (main_window.width)/2)/2;
    for(int i=0;start_pos<valible_wave_length;i++){
        vWave_t previous_point_1 = gAcqWave[i - 2];
        vWave_t previous_point_2 = gAcqWave[i - 3];
        vWave_t previous_point_3 = gAcqWave[i - 4];
        vWave_t later_point_1 = gAcqWave[i + 2];
        vWave_t later_point_2 = gAcqWave[i + 3];
        bool vote_1 = (previous_point_1<ch4_fpga_info.trig_level);
        bool vote_2 = (previous_point_2<ch4_fpga_info.trig_level);
        bool vote_3 = (previous_point_3<ch4_fpga_info.trig_level);
        bool vote_4 = (later_point_1>=ch4_fpga_info.trig_level);
        bool vote_5 = (later_point_2>=ch4_fpga_info.trig_level);
        if( ((vote_1&&vote_2)||(vote_1&&vote_3)||(vote_2&&vote_3)) && (vote_4||vote_5) ){
            ch4_fpga_info.trig_pos = i;
            break;
        }
        else ch4_fpga_info.trig_pos = valible_wave_length/2;
    }
}

void HardwareTrigger(){
    ch4_fpga_info.trig_pos = 4088 + FPGA_ReadW(eFRA_trig_pos);
    if(ch4_ui.time_base<=XLEV_20NS) ch4_fpga_info.trig_pos += 2;
    if(ch4_ui.time_base>=XLEV_500NS) ch4_fpga_info.trig_pos += 2;
//    ch1_fpga_info.trig_pos = 4096;
}

int WriteWaveToTXT(const char* name){
    FILE *file = fopen(name, "w");
    if(file == NULL){
        perror("Error opening file");
        return -1;
    }
    for(int i = 0; i < WIVE_FIFO_DEEPTH; i++)
    {
        fprintf(file, "%d, ", Wave[i]);
        if((i+1)%10 == 0) fprintf(file, "\n");
    }
    fclose(file);
    return 0;
}

int WriteAIWaveToTXT(const char* name){
    FILE *file = fopen(name, "w");
    if(file == NULL){
        perror("Error opening file");
        return -1;
    }
    for(int i = 0; i < 1024; i++)
    {
        fprintf(file, "%d, ", (int)aiWave[i]);
        if((i+1)%10 == 0) fprintf(file, "\n");
    }
    fclose(file);
    return 0;
}

int SendTxt(const char* name){
    const char *remote_filename_startwith = "/home/mso2000/Documents/dataset/normal_square_";
    const char *remote_filename_endwith = ".txt";
    const char *remote_user = "mso2000";
    const char *remote_host = "192.168.2.49";
    char command[256];

    snprintf(command, sizeof(command), "scp %s %s@%s:%s%d%s", name, remote_user, remote_host, remote_filename_startwith, save_count, remote_filename_endwith);

    int result = system(command);
    if (result == 0) {
        printf("File successfully transferred to remote server.\n");
    } else {
        perror("Error during file transfer");
    }

    return EXIT_SUCCESS;
}

void SetTrigStatus(int status){
    if(ch4_fpga_info.trig_mode != status){
        ch4_fpga_info.trig_mode = status;
        TrigLed(ch4_fpga_info.trig_mode);
        RunStop(1);
    }
}

void SetTrigEdge(int edge){
    if(ch4_fpga_info.trig_edge != edge){
        ch4_fpga_info.trig_edge = edge;
    }
}

void ChangeTrigStatus(){
    RunStop(1);
    if(ch4_fpga_info.trig_mode < 3) ch4_fpga_info.trig_mode++;
    else ch4_fpga_info.trig_mode = 0;
    TrigLed(ch4_fpga_info.trig_mode);
}

void RunStop(bool run)
{
    if(ch4_ui.wave_stop != !run){
        ch4_ui.wave_stop = !ch4_ui.wave_stop;
        RunStopLed(run);
    }
}

void AutoSet(){
    auto_set_flag = 1;
}

void save_wave(){
    save_flag = 1;
}

