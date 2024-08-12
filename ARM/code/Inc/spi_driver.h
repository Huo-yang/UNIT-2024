#ifndef __SPIDRIVER_H
#define __SPIDRIVER_H

#include <string>
#include <stdexcept>

#include <fcntl.h>
#include <linux/spi/spidev.h>
#include <sys/ioctl.h>
#include <unistd.h>

class spiDriver {
    private:
        int fd;

    public:
        spiDriver(const char* dev, uint8_t mode = SPI_MODE_0);
        virtual ~spiDriver();
        void setMode(uint8_t mode);
        template<typename t> void setOption(unsigned long int request, t v, const std::string& vStr);
        void writeAndRead(uint8_t *txBuf, uint8_t *rxBuf, __u32 len, uint32_t speed_hz = 48000000);
};

#endif // SPIDRIVER_H
