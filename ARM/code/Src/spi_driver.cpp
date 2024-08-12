#include <Inc/spi_driver.h>
#include <iostream>
spiDriver::spiDriver(const char * dev, uint8_t mode) : fd(-1) {
    fd = open(dev, O_WRONLY);
    if(fd < 0) {
        throw std::runtime_error("can't open ");
    }
    else{
        printf("[UI]Success open spi, fd = %d\n",fd);
        setMode(mode);
    }
}

spiDriver::~spiDriver() {
    if(fd >= 0) {
        close(fd);
    }
}

int __spi_setctl__(int fd, unsigned long int request, int v, const char* vstr)
{
    int ret = ioctl(fd, request, &v);
    if (ret == -1){
        // Printf("can't set %s\r\n", vstr);
        return ret;
    }
    int vtemp = 0;
	ret = ioctl(fd, request^((3)  << _IOC_DIRSHIFT), &vtemp);
    
	if (ret == -1)
		;
        // Printf("can't get %s\r\n", vstr);
    
	if(v != vtemp)
	{
		// Printf("spi set %s failed!\n", vstr);
	}

    return ret;
}

#define spi_setctl(fd, request, v) __spi_setctl__(fd, request, v, #request)

void spiDriver::setMode(uint8_t mode) {
    if(fd<0){
        return;
    }
    // int ret = ioctl(fd, SPI_IOC_WR_MODE32, &mode);
    spi_setctl(fd, SPI_IOC_WR_MODE32, SPI_MODE_0);
    // if(ret == -1) {
    //     //  throw std::runtime_error("can't set mode");
    // }
}

template<typename t> void spiDriver::setOption(unsigned long int request, t v, const std::string& vStr) {
     if(fd<0){
        return;
    }

   int ret = ioctl(fd, request, &v);
    if(ret == -1) {
        throw std::runtime_error("can't set " + vStr);
    }

    t vTemp;
    ret = ioctl(fd, request^((3)<< _IOC_DIRSHIFT), &vTemp);
    if (ret == -1) {
        std::cerr << "can't get " << vStr << std::endl;
    }

    if(v != vTemp) {
        std::cerr << "spi set " << vStr << " failed!" << std::endl;
    }
}

void spiDriver::writeAndRead(uint8_t *txBuf, uint8_t *rxBuf, __u32 len, uint32_t speed_hz) {
    struct spi_ioc_transfer tr ={0};
    if(txBuf == nullptr) {
        return;
    }
    if(fd<0){
        return;
    }

    tr.tx_buf = (__u64)txBuf;        //发送缓存区
    tr.rx_buf = (__u64)(rxBuf == nullptr ? 0 : rxBuf);        //接收缓存区
    tr.len = len;
    tr.delay_usecs = 0;              //发送时间间隔
    tr.speed_hz = speed_hz;          //总线速率
    tr.bits_per_word = 8;            //收发的一个字的二进制位数

    const __u32 ones_size_max = 4<<10;
    int ret = 0;
    int cnt  = 0;
    while(len > 0) {
        if(len > ones_size_max) {
            tr.len = ones_size_max;
            tr.bits_per_word = 32;

            uint8_t temp[4];
            for(__u32 i = 0; i < ones_size_max; i += 4) {
                temp[0] = txBuf[cnt+i+0];
                temp[1] = txBuf[cnt+i+1];
                temp[2] = txBuf[cnt+i+2];
                temp[3] = txBuf[cnt+i+3];
                txBuf[cnt+i+0] = temp[3];
                txBuf[cnt+i+1] = temp[2];
                txBuf[cnt+i+2] = temp[1];
                txBuf[cnt+i+3] = temp[0];
            }
        } else {
            tr.len = len;
            tr.bits_per_word = 8;
        }
        if(txBuf) {
            tr.tx_buf = (__u64)txBuf+cnt;    //发送缓存区
        }
        if(rxBuf) {
            tr.rx_buf = (__u64)rxBuf+cnt;        //接收缓存区
        }

        ret  = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
        if (ret < 0) {   
            throw std::runtime_error("can't send spi message");
        }
        cnt += tr.len;
        len -= tr.len;
    }
}
