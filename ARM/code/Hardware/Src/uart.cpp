#include "uart.h"

/*********************************************************************/
int OpenDev(const char *Dev)
{
    int fd = open( Dev, O_RDWR /* | O_TRUNC| O_ASYNC| O_NOCTTY | O_NDELAY*/);         //| O_NOCTTY | O_NDELAY
    //Printf("%s\n",__FUNCTION__);
    if (-1 == fd)   
    {           
        perror("Can't Open Serial Port");
        return -1;      
    }   
    else    
        return fd;
}
/**
*@brief  设置串口通信速率
*@param  fd     类型 int  打开串口的文件句柄
*@param  speed  类型 int  串口速度
*@return  void
*/
struct stBaudRate
{
    int name;
    int speed;
};


struct stBaudRate BaudRate[]=
{
    {230400,B230400},
    {115200,B115200},
    {57600, B57600},
    {38400, B38400},
    {19200, B19200},
    {9600,  B9600},
    {4800,  B4800},
    {2400,  B2400},
    {1200,  B1200},
    {300,   B300},
    {38400, B38400},
    {19200, B19200},
    {9600,  B9600},
    {4800,  B4800},
    {2400,  B2400},
    {1200,  B1200},
    {300,   B300},
};

int set_speed(int fd, int speed)
{
    uint   i;
    int   status; 
    struct termios   Opt;

    tcgetattr(fd, &Opt); 
    for ( i= 0;  i < sizeof(BaudRate) / sizeof(*BaudRate);  i++) {
        if  (speed == BaudRate[i].name) {
            tcflush(fd, TCIOFLUSH);     
            cfsetispeed(&Opt, BaudRate[i].speed);
            cfsetospeed(&Opt, BaudRate[i].speed);
            status = tcsetattr(fd, TCSANOW, &Opt);  
            if  (status != 0) {        
                return -1;
            }    
            tcflush(fd,TCIOFLUSH);
            return 0;
        }  
    }
    return -1;

}
/**
*@brief   设置串口数据位，停止位和效验位
*@param  fd     类型  int  打开的串口文件句柄
*@param  databits 类型  int 数据位   取值 为 7 或者8
*@param  stopbits 类型  int 停止位   取值为 1 或者2
*@param  parity  类型  int  效验类型 取值为N,E,O,,S
*/
int set_Parity(int fd,int databits,int stopbits,int parity)
{ 
    struct termios options = {0};
    options.c_lflag  &= ~(ICANON | ECHO | ECHOE | ISIG);  /*Input*/
    options.c_oflag  &= ~OPOST;   /*Output*/
    if  ( tcgetattr( fd,&options)  !=  0) { 
        perror("SetupSerial 1");     
        return(FALSE);  
    }
    options.c_cflag &= ~CSIZE; 
    switch (databits) /*设置数据位数*/
    {   
    case 7:     
        options.c_cflag |= CS7; 
        break;
    case 8:     
        options.c_cflag |= CS8;
        break;   
    default:    
        fprintf(stderr,"Unsupported data size/n"); return (FALSE);  
    }
    switch (parity) 
    {   
        case 'n':
        case 'N':    
            options.c_cflag &= ~PARENB;   /* Clear parity enable */
            options.c_iflag &= ~INPCK;     /* Enable parity checking */ 
            break;  
        case 'o':   
        case 'O':     
            options.c_cflag |= (PARODD | PARENB); /* 设置为奇效验*/  
            options.c_iflag |= INPCK;             /* Disnable parity checking */ 
            break;  
        case 'e':  
        case 'E':   
            options.c_cflag |= PARENB;     /* Enable parity */    
            options.c_cflag &= ~PARODD;   /* 转换为偶效验*/     
            options.c_iflag |= INPCK;       /* Disnable parity checking */
            break;
        case 'S': 
        case 's':  /*as no parity*/   
            options.c_cflag &= ~PARENB;
            options.c_cflag &= ~CSTOPB;break;  
        default:   
            fprintf(stderr,"Unsupported parity/n");    
            return (FALSE);  
    }  
    /* 设置停止位*/  
    switch (stopbits)
    {   
        case 1:    
            options.c_cflag &= ~CSTOPB;  
            break;  
        case 2:    
            options.c_cflag |= CSTOPB;  
           break;
        default:    
             fprintf(stderr,"Unsupported stop bits/n");  
             return (FALSE); 
    } 
    /* Set input parity option */ 
    if (parity != 'n')   
        options.c_iflag |= INPCK; 
    tcflush(fd,TCIFLUSH);
    options.c_cc[VTIME] = 150; /* 设置超时15 seconds*/   
    options.c_cc[VMIN] = 0; /* Update the options and do it NOW */
    if (tcsetattr(fd,TCSANOW,&options) != 0)   
    { 
        perror("SetupSerial 3");   
        return (FALSE);  
    } 
    return (TRUE);  
}



int OpenUart(const char *Dev, int speed, int databits, int stopbits, int parity)
{
	int fd = -1;
    if( (fd = OpenDev(Dev) )< 0)
    {
        Printf("Open %s err: %d\n", Dev,fd);
        return -1;
    }

    struct termios tio;

    // 保存测试现有串口参数设置，在这里如果串口号等出错，会有相关的出错信息
    if (tcgetattr(fd, &tio) != 0)
    {
        perror("get SetupSerial");
        return -1;
    }
    // 关闭自动回环
    tio.c_lflag &= ~ECHO;
	
	//禁用输出前处理特殊字符
	//https://blog.csdn.net/jinchengzhou/article/details/52005132
    tio.c_oflag &= ~(OPOST);

    if (tcsetattr(fd, TCSANOW, &tio) != 0)    //激活新设置
    {
        perror("set SetupSerial");
        return -1;
    }


    if(set_speed(fd,speed) < 0)
    {
		close(fd);
        Printf("set_speed err\n");
        return -1;
    }
    if (set_Parity(fd,databits,stopbits,parity) == FALSE)
    {
		close(fd);
        Printf("Set Parity Error/n");
        return -1;
    }

    Printf("InitKeyUart ttyS0 fd=%d \n",fd);
    return fd;
}

int OpenUartTmc(const char *Dev)
{
	int fd = -1;
    if( (fd = OpenDev(Dev) )< 0)
    {
        Printf("Open %s err: %d\n", Dev,fd);
        return -1;
    }

    struct termios tio;

    // 保存测试现有串口参数设置，在这里如果串口号等出错，会有相关的出错信息
    if (tcgetattr(fd, &tio) != 0)
    {
        perror("get SetupSerial");
        return -1;
    }
    // 关闭自动回环
    tio.c_lflag &= ~ECHO;
	
	//禁用输出前处理特殊字符
	//https://blog.csdn.net/jinchengzhou/article/details/52005132
    tio.c_oflag &= ~(OPOST);

    if (tcsetattr(fd, TCSANOW, &tio) != 0)    //激活新设置
    {
        perror("set SetupSerial");
        return -1;
    }
	
    return fd;
}






