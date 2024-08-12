#ifndef __PAINTER__
#define __PAINTER__
#include <stdlib.h>
#include <math.h>
#include "ui.h"
#include "Acquire.h"
#include "FontManager.h"
#include "Hardware.h"

typedef short vWave_t;
namespace ui {
    class painter
    {
    public:
        painter(UI_COLOR* pFrameBuffer, int width, int height);
        ~painter();

        inline UI_COLOR* getPix(int x, int y)
        {
            if (x < 0 || x >= m_width || y < 0 || y >= m_height)
            {
                return NULL;
            }
            return &m_pFrameBuffer[y * m_width + x];
        }
        inline void setPix(int x, int y, UI_COLOR color)
        {
            if (x < 0 || x >= m_width || y < 0 || y >= m_height)
            {
                return;
            }
            m_pFrameBuffer[y * m_width + x] = color;
        }

        void drawPoint(int x, int y, UI_COLOR color);
        void drawLine(int x0, int y0, int x1, int y1, UI_COLOR color);
        void drawRect(int x0, int y0, int x1, int y1, UI_COLOR color);
        void drawRect(int x0, int y0, int x1, int y1, UI_COLOR color, bool up, bool down, bool left, bool right);
        void drawRectFill(int x0, int y0, int x1, int y1, UI_COLOR color);
        void drawCircle(int x0, int y0, int r, UI_COLOR color);
        void drawCircleFill(int x0, int y0, int r, UI_COLOR color);
        int drawTriangle(int x0, int y0, int x1, int y1, UI_COLOR color, int direction);
        int drawTriangleFill(int x0, int y0, int x1, int y1, UI_COLOR color, int direction);
        void drawBracket(int x0, int y0, int length, UI_COLOR color);
        void drawString_big(int x, int y, const UI_CHAR* str, UI_COLOR color);
        void drawString_small(int x, int y, const UI_CHAR* str, UI_COLOR color);
        void drawString(int x, int y, const UI_CHAR* str, UI_COLOR color, int size);
        void drawChar(int *px, int *py, UI_CHAR ch, UI_COLOR color);

        void draw_logo();

        void drawWaveDots(const UI_Window *pWindow, vWave_t *data, int len, UI_COLOR color, const SignalUI *CH);
        void drawWaveVector(const UI_Window *pWindow, vWave_t *data, int len, UI_COLOR color, const SignalUI *CH);

        void drawGrid (const struct UI_Window* pWindow, UI_COLOR Color);

        void drawHeadStatusBar( const struct UI_Window* pWindow);

        void drawToolBar( const struct UI_Window* pWindow);
        void draw_function();
        void draw_trig_float_bar();
        void draw_set_float_bar();
        void draw_ai_float_bar();

        void drawFootStatusBar(const struct UI_Window* pWindow);
        void draw_time_based_box(int x0, int y0, int x1, int y1);
        void draw_trigger_box(int x0, int y0, int x1, int y1);
        void draw_signal_box(int x0, int y0, int x1, int y1);
        void draw_init_box(int x0, int y0, int x1, int y1);
        void draw_status_icon(int x0, int y0, int x1, int y1);
        void draw_intenet_status(int x0, int y0);

        void drawMeasurementBar(const struct UI_Window* pWindow);

        void draw_info_box();

        void draw_trigger_pointer();

        void draw_win_base();
        void draw_pointer();

    private:
        UI_COLOR* m_pFrameBuffer;
        // 水平的像素点个数
        int m_width;
        // 垂直的像素点个数
        int m_height;
    };
}

#endif
