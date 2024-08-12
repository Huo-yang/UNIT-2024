#ifndef __OPT_FB0_H
#define	__OPT_FB0_H

#include "product.h"

#ifdef __cplusplus
extern "C" { //h
#endif

#include <drm/drm_mode.h>
#include <xf86drm.h>
#include <xf86drmMode.h>
#include "../Inc/ui.h"
class CDevDrm
{
    int fd;
    static const int BuffNum = 2;
    int crtcid[BuffNum];
    unsigned char* buf[BuffNum];
    struct drm_mode_create_dumb creq[BuffNum];
    uint32_t framebuffer[BuffNum];
    uint32_t connectors[BuffNum];
    drmModeModeInfo modes[BuffNum];

    uint32_t height;
    uint32_t width;
    int PingPong;
public:
    CDevDrm();
    ~CDevDrm();
	unsigned char **ppBuf(){return buf;}

    drmModeConnector* FindConnector(int fd);
    int FindCrtc(int fd, drmModeConnector *conn);
    int Open();
    int Close();
    void WaitDrmVBlank(void);
    int Write(const void *pixelbuffer, uint x, uint y, uint memwidth, uint memhigh, uint membpp);
	int ScreenCopy(int ID, void* scrn);
    int DrmModePageFlip(int ID, void* scrn);
    void DrmDMAReq(const void *data, uint x, uint y, uint memwidth, uint memhigh, uint membpp);
    int WriteBlankSync(const void *pixelbuffer, uint x, uint y, uint memwidth, uint memhigh, uint membpp);
};
extern CDevDrm DevDrm;

void InitFBO(void);
void UnInitFBO(void);
void FillFBO(unsigned int color);
void SetFB0(unsigned int color, int size);
void Write_FBO(const unsigned char *pixelbuffer, int x, int y, int memwidth, int memhigh, int membpp);
void WriteFBOFullScreen(const unsigned char *pixelbuffer);

#ifdef __cplusplus
}//extern "C" { //h
#endif

#endif
