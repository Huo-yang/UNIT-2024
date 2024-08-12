
#include <sys/ioctl.h>
#include <fcntl.h>
#include <Inc/Define.h>
#include "CI2C.h"


//子类单独实现
dev_eeprom::dev_eeprom(const char *_dev, ushort addr, ushort _page_size, ushort _TotalSize)
{
	dev = _dev;
	dev_addr = addr;
	page_size = _page_size;
	TotalSize = _TotalSize;

	ram = new u8[_TotalSize];
	memset(ram, 0xff, TotalSize);
	iocs_init();

    fd = open(dev, O_WRONLY);
    if (fd < 0) {
        perror("open eeprom");
        return;
    }

    if(eeprom_init(fd)<0)
    {
        fd = -1;
    }
    else
    {
        page_read(0,ram,TotalSize);
    }
}

dev_eeprom::~dev_eeprom()
{
    delete(iocs.msgs[0].buf);
    delete(iocs.msgs[1].buf);
    delete(iocs.msgs);
    delete(ram);
}

int dev_eeprom::iocs_init()
{
	iocs.msgs = (struct i2c_msg *)new __u8[I2C_MSG_SIZE * MAX_MSG_NR];
	if (!(iocs.msgs)) {
	    perror("__malloc iocs.msgs");
		return -1;
	}
	
	iocs.msgs[0].buf = new __u8[(I2C_MSG_BUFFER_SIZE + 1)];
	if (!(iocs.msgs[0].buf)) {
		perror("__malloc iocs.msgs[0].buf");
		return -1;
	}
	
	iocs.msgs[1].buf = new __u8[I2C_MSG_BUFFER_SIZE + 1];
	if (!(iocs.msgs[1].buf)) {
		perror("__malloc iocs.msgs[1].buf");
		return -1;
	}
    return 0;
}



int dev_eeprom::eeprom_init(int fd)
{
    ioctl(fd, I2C_TIMEOUT, 10);
    ioctl(fd, I2C_RETRIES, 1);
    return 0;
}

/* 根据eeprom_st结构生成page_read时序所需的ioctl_st结构 */
void dev_eeprom::page_read_st_gen(ioctl_st *piocs, eeprom_st *eeps)
{
    int size = eeps->len;

    piocs->nmsgs = 2;  //page_read需2次start信号

    /* 第1次信号 */
    piocs->msgs[0].addr = eeps->slave_addr;  //填入slave_addr
    piocs->msgs[0].flags = I2C_M_WR;         //write标志
    piocs->msgs[0].len = 1;                  //信号长度1字节
    piocs->msgs[0].buf[0] = eeps->byte_addr; //填入byte_addr

    /* 第2次信号 */
    piocs->msgs[1].addr = eeps->slave_addr;  //填入slave_addr
    piocs->msgs[1].flags = I2C_M_RD;         //read标志
    piocs->msgs[1].len = size;               //信号长度: 待读数据长度
    memset(piocs->msgs[1].buf, 0, size);     //先清零, 待读数据将自动存放于此
}

/* 用ioctl方法从eeprom中读取数据 */
int dev_eeprom::page_read_eeps(eeprom_st *eeps)
{
	int ret;
	int size = eeps->len;

	page_read_st_gen(&iocs, eeps);
	ret = ioctl(fd, I2C_RDWR, (u32)&iocs);
	if (ret == -1) {
		perror("ioctl");
		return ret;
	}

	/* 将读取的数据从ioctl结构中复制到用户buf */
	memcpy(eeps->buf, iocs.msgs[1].buf, size);
	//	  Printf("read byte ioctl ret = %d\n", ret);

	return ret;
}

int dev_eeprom::page_read(unsigned short pos, u8 *data, int size)
{
	eeprom_st eeps;
	if (fd < 0) {
		perror("open eeprom");
		return 0;
	}

	/* 判断要读取数据的长度size有效性 */
	if (size > page_size)
		size = page_size;
	else if (size < 1)
		return 0;
	if (pos+size >= TotalSize)
	{
		//memset(data,0,size);
	    usr_printf("dev_eeprom::page_read:Address out of range %d~%d\r\n", pos,pos+size);
		return 0;
	}

	int slave_addr = (pos>>8);
	int byte_addr = (pos&0xff);

	if (size > (EEPROM_BLOCK_SIZE - byte_addr))
		size = EEPROM_BLOCK_SIZE - byte_addr;

	eeps.slave_addr = dev_addr + slave_addr;
	eeps.byte_addr = byte_addr;
	eeps.len = size;
	eeps.buf = data;

	page_read_eeps(&eeps);
	return size;
}

/////////////////////////////////////////////////////////////////////////////
/* 根据eeprom_st结构生成page_write时序所需的ioctl_st结构 */
void dev_eeprom::page_write_st_gen(ioctl_st *piocs, eeprom_st *eeps)
{
	int size = eeps->len;

	piocs->nmsgs = 1;  //page_write只需1次start信号

	piocs->msgs[0].addr = eeps->slave_addr;	//填入slave_addr
	piocs->msgs[0].flags = I2C_M_WR; 		//write标志
	piocs->msgs[0].len = size + 1; //信号长度: 待写入数据长度 + byte_addr长度
	piocs->msgs[0].buf[0] = eeps->byte_addr; //第1字节为byte_addr
	memcpy((piocs->msgs[0].buf + 1), eeps->buf, size); //copy待写数据
}

/* 用ioctl方法向eeprom中写入数据 */
int dev_eeprom::page_write_eeps(eeprom_st *eeps)
{
	page_write_st_gen(&iocs, eeps);
	
	int ret = ioctl(fd, I2C_RDWR, (u32)&iocs);
	if (ret == -1) {
		perror("ioctl");
		return ret;
	}
	return ret;
}

int dev_eeprom::page_write(unsigned short pos, const u8 *data, int size)
{
    eeprom_st eeps;

    if (fd < 0) {
        perror("open eeprom");
        return 0;
    }
    //Printf("write->  0x%02x,  %d bytes\n",pos, size);

    /* 判断要读取数据的长度size有效性 */
    if (size > page_size)
        size = page_size;
    else if (size < 1)
    {
        return 0;
    }
	
	if (pos+size >= TotalSize)
	{
	    usr_printf("dev_eeprom::page_write:Address out of range %d~%d\r\n", pos,pos+size);
		return 0;
	}

	//if(0 == memcmp(&ram[pos], data, size))
	//{ 
	//    return size;
	//}
	
	//ErroPrintf("[%d] <= 0x%02X\n", pos,*data);
	
    int slave_addr = (pos>>8);
    int byte_addr = (pos&0xff);

    if (size > (EEPROM_BLOCK_SIZE - byte_addr))
        size = EEPROM_BLOCK_SIZE - byte_addr;
	
    eeps.slave_addr = dev_addr + slave_addr;
    eeps.byte_addr = byte_addr;
    eeps.len = size;
    eeps.buf = (u8 *)data;
	
    if(page_write_eeps(&eeps)>=0)
    {
		//memcpy(&ram[pos], data, size);
	    return size;
	}
	else
		return 0;

}


int dev_eeprom::write_buff(int addr, const void *buff, int size)
{
	int length = 0;
    const uchar *pBuff=(const uchar *)buff;

	for(int i = 0; i < size; i+= EEPROM_PAGE_SIZE)
	{
		int remain = MIN(size-i,EEPROM_PAGE_SIZE);
		if(page_write(addr+i, pBuff+i, remain)<=0)
			return -1;
		length += remain;
	}
	return length;
}
int dev_eeprom::read_buff(int addr, void *buff, int size)
{
	int length = 0;
	uchar *pBuff = (uchar *)buff;
	for(int i = 0; i < size; i+= EEPROM_PAGE_SIZE){
		int remain = MIN(size-i, EEPROM_PAGE_SIZE);
		if(page_read(addr+i, pBuff+i, remain)<=0)
			return -1;
		length += remain;
	}
	return length;
}


dev_eeprom* e2prom;//(DEV_eeprom, eeprom_dev_addr, EEPROM_PAGE_SIZE, EEPROM_AMX_SIZE);
