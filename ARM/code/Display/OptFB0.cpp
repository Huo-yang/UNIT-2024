#include "product.h"

#include "usrio.h"
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <arm_neon.h>
#include <Inc/Type.h>
#include "OptFB0.h"


//#include <xf86drm.h>
//#include <xf86drmMode.h>

//#include <iostream>
//#include <opencv2/opencv.hpp>
//#include <opencv2/highgui.hpp>
//#include <opencv2/core/ocl.hpp>

//using namespace std;
//using namespace cv;

//#include <bits/fcntl.h>
#ifdef __cplusplus
extern "C" {
#endif
#include "printf_define.h"

//static int FrameBufferSize = 0;
//static char * FrameBufferMem = 0;
//static struct fb_var_screeninfo vinfo;
//static struct fb_fix_screeninfo finfo;
//static struct fb_vblank vblank;
//static bool toggle = false;

#define VILD_DRM

int edgeThresh = 20;
// 构造函数
CDevDrm::CDevDrm()
{
    printf("[UI]------DRI init------\n");
    //destroyAllWindows();
    //namedWindow("msowindow", WINDOW_NORMAL | WINDOW_FREERATIO|WINDOW_FULLSCREEN);
    //resizeWindow("msowindow", 800, 480);
    //createTrackbar("Canny threshold", "Edge map", &edgeThresh, 100, onTrackbar);
    //memset(this,0,sizeof(*this));
    PingPong = 1;
    Open();
}

CDevDrm::~CDevDrm()
{
    Close();
}


drmModeConnector* CDevDrm::FindConnector(int fd)
{
    drmModeRes *resources = drmModeGetResources(fd); //drmModeRes描述了计算机所有的显卡信息：connector，encoder，crtc，modes等。
    if (!resources)
    {
        return NULL;
    }

    drmModeConnector* conn = NULL;
    int i = 0;
    for (i = 0; i < resources->count_connectors; i++)
    {
        conn = drmModeGetConnector(fd, resources->connectors[i]);
        if (conn != NULL)
        {
            //找到处于连接状态的Connector。
            if (conn->connection == DRM_MODE_CONNECTED && conn->count_modes > 0)
            {
                break;
            }
            else
            {
                drmModeFreeConnector(conn);
            }
        }
    }

    drmModeFreeResources(resources);
    return conn;
}

int CDevDrm::FindCrtc(int fd, drmModeConnector *conn)
{
    drmModeRes *resources = drmModeGetResources(fd);
    if (!resources)
    {
        fprintf(stderr, "drmModeGetResources failed\n");
        return -1;
    }


    for (int i = 0; i < conn->count_encoders; ++i)
    {
        drmModeEncoder *enc = drmModeGetEncoder(fd, conn->encoders[i]);
        if (NULL != enc)
        {
            for (int j = 0; j < resources->count_crtcs; ++j)
            {
                // connector下连接若干encoder，每个encoder支持若干crtc，possible_crtcs的某一位为1代表相应次序（不是id哦）的crtc可用。
                if ((enc->possible_crtcs & (1 << j)))
                {
                    int id = resources->crtcs[j];
                    drmModeFreeEncoder(enc);
                    drmModeFreeResources(resources);
                    return id;
                }
            }

            drmModeFreeEncoder(enc);
        }
    }

    drmModeFreeResources(resources);
    return -1;
}

int CDevDrm::Open()
{
    fd = -1;
    //return fd;
    int fdev = open("/dev/dri/card0", O_RDWR | O_CLOEXEC | O_NONBLOCK);
    if (fdev < 0)
    {
        /* Probably permissions error */
        fprintf(stderr, "couldn't open %s, skipping\n", "/dev/dri/card0");
        return fd;
    }
    drmSetMaster(fdev);

    drmModeConnectorPtr connector = FindConnector(fdev);
    int width = connector->modes[0].hdisplay;
    int height = connector->modes[0].vdisplay;

    printf("[UI]display is %d*%d.\n", width, height);

    memset(&creq, 0, sizeof(creq));
    bool bErro = false;
    for(int i =0; i< BuffNum; i++)
    {
        crtcid[i] = FindCrtc(fdev, connector);
        this->height= height;
        this->width = width;

        creq[i].width = width;
        creq[i].height = height;
        creq[i].bpp = 32;
        creq[i].flags = 0;

        framebuffer[i] = -1;
        creq[i].handle = 0;
        if (drmIoctl(fdev, DRM_IOCTL_MODE_CREATE_DUMB, &creq[i]))
        {
            Printf("create dumb failed!\n");
        }
        //使用缓存的handel创建一个FB，返回fb的id：framebuffer。
        if (drmModeAddFB(fdev, width, height, 24, creq[i].bpp, creq[i].pitch, creq[i].handle, &framebuffer[i]))
        {
            Printf("failed to create fb\n");
            return fd;
        }
        struct drm_mode_map_dumb mreq; //请求映射缓存到内存。
        mreq.handle = creq[i].handle;

        if (drmIoctl(fdev, DRM_IOCTL_MODE_MAP_DUMB, &mreq))
        {
            Printf("map dumb failed!\n");
        }
        // 猜测：创建的缓存位于显存上，在使用之前先使用drm_mode_map_dumb将其映射到内存空间。
        // 但是映射后缓存位于内核内存空间，还需要一次mmap才能被程序使用。
        buf[i] = (unsigned char*)mmap(0, creq[i].size, PROT_READ | PROT_WRITE| PROT_EXEC , MAP_SHARED, fdev, mreq.offset);
        if (buf[i] == MAP_FAILED)
        {
            Printf("mmap failed!\n");
        }
        //一切准备完毕，只差连接在一起了！
        int ierr = drmModeSetCrtc(fdev, crtcid[i], framebuffer[i], 0, 0, &connector->connector_id, 1, connector->modes);
        if (ierr)
        {
            fprintf(stderr, LIGHT_RED "Cannot set CRTC for connector 0x%08x (%d): %m \n" NONE, (uint)connector, -ierr);
            bErro = true;
            //return fd;
        }
        //memset(buf[i], 0 , height * width * 4);
        //drmModePageFlip(fd, crtcid[i], framebuffer[i], DRM_MODE_PAGE_FLIP_EVENT,buf[i]);
        connectors[i] = connector->connector_id;
        modes[i] = *connector->modes;
        Printf("[%d]crtcid = %d, buf = %p, framebuffer = %d\n", i, crtcid[i], buf[i], framebuffer[i]);
    }
    if(!bErro)
    {
        Printf("CDevDrm open is OK\n");
        fd = fdev;
    }
    return fd;
}
int CDevDrm::Close()
{
    Printf("over\n");
    return close(fd);
}

void CDevDrm::WaitDrmVBlank(void)
{
    drmVBlank vbl;
    vbl.request.type = DRM_VBLANK_NEXTONMISS;
    vbl.request.sequence = 0;
    //vbl.request.type = DRM_VBLANK_RELATIVE;
    //vbl.request.sequence = 1;
    drmWaitVBlank(fd, &vbl);
}
void CDevDrm::DrmDMAReq(const void *data, uint x, uint y, uint memwidth, uint memhigh, uint membpp)
{
}
//uchar test_ram [800*480*4];
int CDevDrm::Write(const void *data, uint x, uint y, uint memwidth, uint memhigh, uint membpp)
{
#ifdef VILD_DRM
    const uchar *pixelbuffer = (const uchar *)data;
    if(0==x && 0== y && width == memwidth && height == memhigh)
    {
        //DrmDMAReq(data, x, y, memwidth, memhigh, membpp);
        memcpy(buf[PingPong], pixelbuffer , memhigh * memwidth * membpp);
    }
    else
    {
        for(uint iy = 0; iy < memhigh; iy++)
            memcpy(buf[PingPong]+((y+iy)*creq[PingPong].width + x) * 4, pixelbuffer + (iy*memwidth +x) *membpp, memwidth * membpp);
    }

#endif
    return 0;
}
int CDevDrm::WriteBlankSync(const void *pixelbuffer, uint x, uint y, uint memwidth, uint memhigh, uint membpp)
{
    WaitDrmVBlank();
    return Write(pixelbuffer, x, y, memwidth, memhigh, membpp);
}

int CDevDrm::ScreenCopy(int ID, void* scrn)
{
    if(fd<0)
    {
        return -1;
    }
	
	//ErroPrintf("[20,40]= 0x%08X\n", UI_GetPixel(20,40));
	PingPong = ID%BuffNum ;
	memcpy(buf[PingPong],scrn, sizeof(UI_COLOR)*800*480);
	//ELAPSE_TIME(X);
	//memcpy(test_ram,buf[PingPong],sizeof(UI_RGB)*800*480);

    return 0;
}

int CDevDrm::DrmModePageFlip(int ID, void* scrn)
{
    if(fd<0)
        return -1;
    if (drmModeSetCrtc(fd, crtcid[PingPong], framebuffer[PingPong], 0, 0, &connectors[PingPong], 1, &modes[PingPong]))
    {
        fprintf(stderr, "failed to set mode: %m\n");
        return 0;
    }

    //timer_measure elapse("",__LINE__);
    PingPong =(PingPong+1)%BuffNum;
    return -1;
}
#ifdef __cplusplus
}
#endif


