#include "Hardware.h"

const char* eYScale_names[] = {"1mv", "2mv", "5mv", "10mv",
                                "20mv", "50mv", "100mv", "200mv",
                                "500mv", "1v", "2v", "5v", "10v",
                                "20v"};
const uint eYScale_value[] = {1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000};

const char* eXScale_names[] = {"2ns", "5ns", "10ns", "20ns", "50ns",
                               "100ns", "200ns", "500ns", "1us", "2us",
                               "5us", "10us", "20us", "50us", "100us",
                               "200us", "500us", "1ms", "2ms", "5ms",
                               "10ms", "20ms", "50ms"};
const ulong eXScale_value[] = {2, 5, 10, 20, 50,
                               100, 200, 500, 1000, 2000,
                               5000, 10000, 20000, 50000, 100000,
                               200000, 500000, 1000000, 2000000, 5000000,
                               10000000, 20000000, 50000000};

const char eXScale_draw_value[] = {1, 1, 1, 2, 1,
                                   2, 4, 4, 4, 4,
                                   4, 4, 4, 4, 4,
                                   4, 4, 4, 4, 4,
                                   4, 4, 4};
const char eXScale_inset_value[] = {25, 10, 5, 5, 1,
                                    1, 1, 1, 1, 1,
                                    1, 1, 1, 1, 1,
                                    1, 1, 1, 1, 1,
                                    1, 1, 1};

KeyBoardLED LEDCode = {0};

void HW_ADC_Reset(uint ic)
{
    uSleep(100);

	// power down
	FPGA_ADC_PD (ic);
	// ADC
    FPGA_WriteW ( eFRA_reset_adc_fifo, 1<<ic);
    //uSleep(1);
    FPGA_WriteW ( eFRA_reset_adc_fifo, 0 );
    //uSleep(1);
	
	// pll
    //FPGA_WriteW ( eFRA_test, 8<<(ic*8) );
	//uSleep(1);
    //FPGA_WriteW ( eFRA_test, 0 );
	//uSleep(1);

	// fifo
    FPGA_WriteW ( eFRA_reset_adc_fifo, 4<<ic);
    uSleep(1);
    FPGA_WriteW ( eFRA_reset_adc_fifo, 0 );
    uSleep(1);
}


/**************************************************************************************/
///																						///
///                                      键盘灯控制                                     ///
///																						///
/**************************************************************************************/

void SendCmdToLEDInit ( void )
{
	LEDCode.CH4 = true;
	LEDCode.RUNSTOP = true;

	UartKeyBoard_Write ( LEDCode.LED );
}

void RunStopLed(bool run)
{
    if(run != LEDCode.RUNSTOP){
        LEDCode.RUNSTOP = run;
        UartKeyBoard_Write (LEDCode.LED);
    }
}

void TrigLed(int status)
{
    switch(status){
        case 0:
            LEDCode.MODE_AUTO = false;
            LEDCode.MODE_NORMAL = false;
            LEDCode.MODE_SINGLE = false;
            break;
        case 1:
            LEDCode.MODE_AUTO = true;
            LEDCode.MODE_NORMAL = false;
            LEDCode.MODE_SINGLE = false;
            break;
        case 2:
            LEDCode.MODE_AUTO = false;
            LEDCode.MODE_NORMAL = true;
            LEDCode.MODE_SINGLE = false;
            break;
        case 3:
            LEDCode.MODE_AUTO = false;
            LEDCode.MODE_NORMAL = false;
            LEDCode.MODE_SINGLE = true;
            break;
    }
    UartKeyBoard_Write (LEDCode.LED);
}
/**************************************************************************************/
///																						///
///                                     LCD UPDATE                                      ///
///																						///
/**************************************************************************************/
void AdjLCDBackLight ( int brightness )
{
	SystemPrintf ( "echo %d >  /sys/class/pwm/ecap.0/duty_percent", brightness );
}

