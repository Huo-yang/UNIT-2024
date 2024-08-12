#ifndef CI2C_H
#define CI2C_H
#include "usrio.h"
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include "../Inc/Type.h"
#include "product.h"


typedef unsigned char u8;
typedef unsigned int u32;

#define  eeprom_dev_addr  0x50

#if PRODUCT == MSO_3K
#define  DEV_eeprom "/dev/i2c-1"  //设备文件路径
#else
#define  DEV_eeprom "/dev/i2c-0"  //设备文件路径
#endif
#define EEPROM_AMX_SIZE   512  //容量512 bytes

#define I2C_M_WR          0    //定义写标志
#define MAX_MSG_NR        2    //根据AT24C08手册, 最大消息数为2
#define EEPROM_BLOCK_SIZE 256  //每个block容量256 bytes
#define EEPROM_PAGE_SIZE  16   //AT24C08页大小为16字节

#define I2C_MSG_BUFFER_SIZE  EEPROM_BLOCK_SIZE   //AT24C08页大小为16字节


#define I2C_MSG_SIZE (sizeof(struct i2c_msg))

#define E2PROM_DNA_ADDR   0
#define E2PROM_DNA_SIZE   0x40

#define E2PROM_PARAM_FLAG 0x40

#define E2PROM_PARAM_ADDR (E2PROM_PARAM_FLAG+sizeof(unsigned int))


/* 自定义eeprom参数结构体 */
typedef struct eeprom_data {
    u8 slave_addr;
    u8 byte_addr;
    u8 len;
    u8 *buf;
} eeprom_st;

/* I2C总线ioctl方法所使用的结构体 */
typedef struct i2c_rdwr_ioctl_data ioctl_st;

class dev_eeprom
{
public:
	//子类单独实现
	dev_eeprom(const char *_dev, ushort addr, ushort _page_size, ushort _TotalSize);
    ~dev_eeprom();
	int iocs_init();
	

	
	int eeprom_init(int fd);

	/* 根据eeprom_st结构生成page_read时序所需的ioctl_st结构 */
	void page_read_st_gen(ioctl_st *piocs, eeprom_st *eeps);
	/* 用ioctl方法从eeprom中读取数据 */
	int page_read_eeps(eeprom_st *eeps);
	
	int page_read(unsigned short pos, u8 *data, int size);

/////////////////////////////////////////////////////////////////////////////
	/* 根据eeprom_st结构生成page_write时序所需的ioctl_st结构 */
	void page_write_st_gen(ioctl_st *piocs, eeprom_st *eeps);
	
	/* 用ioctl方法向eeprom中写入数据 */
	int page_write_eeps(eeprom_st *eeps);
	int page_write(unsigned short pos, const u8 *data, int size);

	int write_buff(int addr, const void *buff, int size);
	int read_buff(int addr, void *buff, int size);
	
	template <typename T>
	int write(unsigned short pos, T v)
	{
		return page_write(pos, (u8 *)&v, sizeof(v));
	}
	
	template <typename T>
	T read(unsigned short pos)
	{
		T v;
		page_read(pos, (u8 *)&v, sizeof(v));
		return v;
	}

	template <typename T>
	int read(unsigned short pos, T &v)
	{
		return page_read(pos, (u8 *)&v, sizeof(v));
	}

private:
	u8 *ram;
	const char *dev;
	u8 dev_addr;
	u8 page_size;
	ushort TotalSize;
	int fd;
    ioctl_st iocs;
public:
};

extern dev_eeprom* e2prom;

#endif
