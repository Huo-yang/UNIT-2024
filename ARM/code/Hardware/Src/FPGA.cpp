#include "FPGA.h"
#include "HW_Channel.h"
#include "Hardware.h"

static int fdIRQ=-1;

SignalFPGAINFO ch4_fpga_info = {
    .trig_mode=0,
    .trig_edge=0,
    .trig_level=ADC_MID,
    .trig_pos=4096,
    .min = 255,
    .max = 0,
    .vpp = 0,
    .frequency_count = 0,
};

void InitIRQ ( void ( *__KeyIRQ ) ( int ) )
{
	system ( "insmod /fpga/ioIrq.ko" );
	//sleep(1);
	fdIRQ= open ( AWG_DEV, O_RDWR );
	if ( fdIRQ < 0 )
	{
		printf( "Can't Open %s !!!\n\r", AWG_DEV );
	}
	else
	{
		signal ( SIGIO, __KeyIRQ );
		fcntl ( fdIRQ, F_SETOWN, getpid() );
		int oflags = fcntl ( fdIRQ, F_GETFL );
		fcntl ( fdIRQ, F_SETFL, oflags | FASYNC );
		printf ( "Open %s :%d!!!\n\r", AWG_DEV,fdIRQ );
	}
}

int ReadIRQ ( bool& bMso, bool& bAwg )
{
	//static int buff_bak[2]={-1,-1};
	uchar buff[2];
	if ( fdIRQ < 0 )
	{
		return -1;
	}

	read ( fdIRQ, buff, sizeof ( buff ) );
	bMso = buff[0];
	bAwg = buff[1];
	//HW_Printf("read irq:%d,%d\r\n", buff[0],buff[1]);
	return 0;
}

int fFpga = -1;

#define FPGA_DEV "/dev/fpga"

void OpenFPGA()
{
    printf("[UI]------open FPGA------\n");
	if (fFpga >= 0)
	{
		return;
	}
	fFpga = open(FPGA_DEV, O_RDWR);
	if (fFpga < 0)
	{
	    printf("[UI]Can't Open %s !!!\n\r", FPGA_DEV);
	}
	else
	{
	    printf("[UI]Success open %s :%d!!!\n\r", FPGA_DEV, fFpga);
	}
}

#pragma pack(4)
typedef struct _userCmd
{
    ushort head;
    ushort ch;
    uchar bEnFIFO; 
    uchar bEnDMA;
    ushort Adata;
    char *AddrUser;
}userCmd;
#pragma pack()

uint FPGA_CMD_READ (fpga_id_t ch, ushort Adata, void* useraddr, int len, bool bEnFiFo, bool bEnDMA)
{
    unsigned int n = 0 ;
    userCmd cmd;
    cmd.head = 0xa5a5;
    cmd.ch = ch;
    cmd.bEnFIFO = bEnFiFo;
    //cmd.bEnDMA = false;
    cmd.bEnDMA = bEnDMA;
    cmd.AddrUser = (char*)useraddr;
    cmd.Adata = Adata;

	if ( fFpga >= 0 )
	{
		n = read ( fFpga, &cmd, len );
#if PrintfDebug != 0
		if ( n != 0 )
		{
			qDebug() << "read err : " << n << "byte";
		}
#endif
	}
	return n;	
}

void FPGA_CMD_WRITE ( fpga_id_t ch, ushort Adata, void* useraddr, int len, bool bEnFiFo, bool bEnDMA )
{
	userCmd cmd;
	cmd.head = 0xa5a5;
	cmd.ch = ch;
	cmd.bEnFIFO = bEnFiFo;
	cmd.bEnDMA = bEnDMA;
	cmd.AddrUser = ( char* ) useraddr;
	cmd.Adata = Adata;

	if ( fFpga >= 0 )
	{
		write ( fFpga, &cmd, len );
	}
}

template <typename T>
inline T FPGA_Read (ushort addr)
{
	T v=0;
#if 1
    FPGA_CMD_READ ( 0, addr, &v, sizeof(v), false, false );
#else
    uchar *pchar = (uchar *)&v;
    for(uint i=0; i< sizeof(T); i +=2)
    {
        FPGA_CMD_READ ( 0, addr+i, pchar+i, MIN(sizeof (v),2), false, false );
        FPGA_CMD_READ ( 0, addr+i, pchar+i, MIN(sizeof (v),2), false, false );
    }
#endif
	return v;
}

template <typename T>
inline void FPGA_WriteData ( ushort addr, T data )
{
	FPGA_CMD_WRITE ( 0, addr, &data, sizeof ( data ), false, false );
}

ushort FPGA_ReadW ( ushort addr )
{
#ifdef SYS_ARM
    //FPGA_Read<ushort> ( addr );FPGA_Read<ushort> ( addr );FPGA_Read<ushort> ( addr );

	return FPGA_Read <ushort> ( addr );
#else
	return 0xFF;
#endif
}

void FPGA_WriteW ( ushort addr, ushort data )
{
	FPGA_WriteData ( addr, data );
}
void FPGA_WriteTW ( ushort addrL, ushort addrH, ushort addrT, xindex_t data )
{
	ushort*pv = (ushort*)&data;
	
	FPGA_WriteData ( addrL, pv[0] );
	FPGA_WriteData ( addrH, pv[1] );
	FPGA_WriteData ( addrT, pv[2] );

}

void FPGA_WriteDW ( ushort addrL, ushort addrH, uint data )
{
	if ( addrL+2 == addrH )
	{
		FPGA_WriteData ( addrL, data );
	}
	else
	{
		FPGA_WriteData ( addrL, ( ushort ) ( data & 0xffff ) );
		FPGA_WriteData ( addrH, ( ushort ) ( data >> 16 ) );
	}
}

void FPGA_WriteQW ( ushort addrL, ushort addrML,ushort addrMH, ushort addrH, ullong data )
{
	if ( ( addrL+2 == addrML ) && ( addrML+2 == addrMH ) && ( addrMH+2==addrH ) )
	{
		FPGA_WriteData ( addrL, data );
	}
	else
	{
		short* pdata = ( short* ) &data;
		FPGA_WriteData ( addrL, 	pdata[0] );
		FPGA_WriteData ( addrML, 	pdata[1] );
		FPGA_WriteData ( addrMH, 	pdata[2] );
		FPGA_WriteData ( addrH, 	pdata[3] );
	}
}

//void FPGA_Set_sys_rst (ushort flage)
//{
//	FPGA_WriteW (eFRA_sys_rst, flage?0x0f:0);
//}

void Wave_FIFO_Clean(bool v)
{
	FPGA_WriteW (eFRA_WAVE_FIFO_RESET, v?0x02:0);
}

void Wave_FIFO_Start(bool v)
{
	FPGA_WriteW (eFRA_WAVE_FIFO_RESET, v?0x01:0);
}

ushort FPGA_FIFO_FULL ( )
{
	return FPGA_ReadW (eFRA_fifo_full);
}

//void FPGA_Set_AcqClean ( void )
//{
//	FPGA_WriteW ( eFRA_ACQ_CLEAN, 0 );
//	FPGA_WriteW ( eFRA_ACQ_CLEAN, 1 );
//}

void FPGA_Read_Wave (vWave_t *dst_big, vWave_t *dst_full, float *ai_wave, int len)
{
    uchar *data = new uchar [len];
    FPGA_CMD_READ(0, eFRA_fifo_data, data, len/*sizeof(*dst)*/, true, false);
    for(int i = 0; i < len; i++){
        dst_big[i*eXScale_inset_value[ch4_ui.time_base]] = data[i];
        dst_full[i] = data[i] - ADC_MID;
        if((i - 4)%8 == 0) ai_wave[(int)((i - 4)/8)] = data[i] - ADC_MID;
    }
    delete data;
}

vWave_t FPGA_Read_Wave (int len)
{
    uchar *data = new uchar [len];
    FPGA_CMD_READ(0, eFRA_fifo_data, data, len/*sizeof(*dst)*/, true, false);
    uchar min = 255;
    uchar max = 0;
    vWave_t maxmin = 0;
    for(int i = 0; i < len; i++){
        if(i > 2 && i < 8190){
            if(data[i] < min) min = data[i];
            if(data[i] > max) max = data[i];
        }
    }
    delete[] data;
//    printf("max:%d  min:%d\n", max, min);
    maxmin = (max << 8) | min;
    return maxmin;
}

void FPGA_ADC_CAL (void )
{
#if 1
    FPGA_WriteW ( eFRA_test, 0 );
    FPGA_WriteW ( eFRA_test, (1<<2)*0x101 );
	uSleep(1);
    FPGA_WriteW ( eFRA_test, 0 );
#endif
}
void FPGA_ADC_PD (uint ic )
{
#if 1
    FPGA_WriteW ( eFRA_test, 0 );
    FPGA_WriteW ( eFRA_test, 3<<(ic*8) );
	mSleep(1);
    FPGA_WriteW ( eFRA_test, 0 );
	mSleep(1);
#endif
}

void Update_FPGA_Trig_Set(){
    ch4_fpga_info.trig_level = (ushort)(YSCALE_VALUE_RATE * ch1_info.trig_level / eYScale_value[ch4_ui.yscale] + ADC_MID);
}

void FPGA_Trig_Set(unsigned char trig_mode, bool trig_edge, ushort trig_level){
    trig_mode = LIMIT(trig_mode, 0, 2);
    FPGA_WriteW (eFRA_trig_mode, trig_mode);
    FPGA_WriteW (eFRA_trig_edge, trig_edge);
    FPGA_WriteW (eFRA_trig_level, trig_level);
}

void FPGA_Time_Base_Set(unsigned char time_base_index){
    printf("Success set time base %s\n", eXScale_names[time_base_index]);
    if(time_base_index > 5){
        time_base_index = time_base_index - 6;
        FPGA_WriteW (eFRA_time_base_extract, time_base_index);
    }
    else FPGA_WriteW (eFRA_time_base_extract, 0);
}

void FPGA_Notify_Trigger(){
    FPGA_WriteW (eFRA_read_end_flag, 0x00);
    FPGA_WriteW (eFRA_read_end_flag, 0x01);
    FPGA_WriteW (eFRA_read_end_flag, 0x00);
}
