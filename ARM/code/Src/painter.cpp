#include <painter.h>

template <typename T>
inline T uiMapADToWindow(const struct UI_Window *pWindow, T y, const struct SignalUI *ch)
{
	// 去AD坐标，取反，加显示窗口坐标
	T result = (ADC_MID - y) * 2 * ch4_ui.yscale_rate + pWindow->y_mid;
//	T result = (ADC_MID - y) * 1 * ch1_ui.yscale_rate + pWindow->y_mid;
	return result;
}

inline int uiTruncateInWindow ( const struct UI_Window* pWindow, int y)
{
	if(y < pWindow->y0) y = pWindow->y0;
	else if(y >= pWindow->y1) y = pWindow->y1-1;
	return(y);
}

ui::painter::painter(UI_COLOR* pFrameBuffer, int width, int height)
{
    m_pFrameBuffer = pFrameBuffer;
    m_width = width;
    m_height = height;
}

ui::painter::~painter()
{
    
}

void ui::painter::drawPoint(int x, int y, UI_COLOR color)
{
    if (x < 0 || x >= m_width || y < 0 || y >= m_height)
    {
        return;
    }
    m_pFrameBuffer[y * m_width + x] = color;
}

void ui::painter::drawLine(int x0, int y0, int x1, int y1, UI_COLOR color)
{
    int dx = x1 - x0;
    int dy = y1 - y0;
    int step = abs(dx) > abs(dy) ? abs(dx) : abs(dy);
    float x = x0;
    float y = y0;
    float x_inc = dx / (float)step;
    float y_inc = dy / (float)step;
    for (int i = 0; i < step; i++)
    {
        drawPoint((int)x, (int)y, color);
        x += x_inc;
        y += y_inc;
    }
}

void ui::painter::drawRect(int x0, int y0, int x1, int y1, UI_COLOR color)
{
    drawLine(x0, y0, x1, y0, color);
    drawLine(x1, y0, x1, y1, color);
    drawLine(x1, y1, x0, y1, color);
    drawLine(x0, y1, x0, y0, color);
}

void ui::painter::drawRect(int x0, int y0, int x1, int y1, UI_COLOR color, bool up, bool down, bool left, bool right)
{
    if(up) drawLine(x0, y0, x1, y0, color);
    if(right) drawLine(x1, y0, x1, y1, color);
    if(down) drawLine(x1, y1, x0, y1, color);
    if(left) drawLine(x0, y1, x0, y0, color);
}

void ui::painter::drawRectFill(int x0, int y0, int x1, int y1, UI_COLOR color)
{
    for (int i = x0; i < x1; i++)
    {
        for (int j = y0; j < y1; j++)
        {
            drawPoint(i, j, color);
        }
    }
}

void ui::painter::drawCircle(int x0, int y0, int r, UI_COLOR color)
{
    int x = 0;
    int y = r;
    int d = 3 - 2 * r;
    while (x <= y)
    {
        drawPoint(x0 + x, y0 + y, color);
        drawPoint(x0 + x, y0 - y, color);
        drawPoint(x0 - x, y0 + y, color);
        drawPoint(x0 - x, y0 - y, color);
        drawPoint(x0 + y, y0 + x, color);
        drawPoint(x0 + y, y0 - x, color);
        drawPoint(x0 - y, y0 + x, color);
        drawPoint(x0 - y, y0 - x, color);
        if (d < 0)
        {
            d = d + 4 * x + 6;
        }
        else
        {
            d = d + 4 * (x - y) + 10;
            y--;
        }
        x++;
    }
}

void ui::painter::drawCircleFill(int x0, int y0, int r, UI_COLOR color)
{
    int x = 0;
    int y = r;
    int d = 3 - 2 * r;
    while (x <= y)
    {
        drawLine(x0 - x, y0 + y, x0 + x, y0 + y, color);
        drawLine(x0 - x, y0 - y, x0 + x, y0 - y, color);
        drawLine(x0 - y, y0 + x, x0 + y, y0 + x, color);
        drawLine(x0 - y, y0 - x, x0 + y, y0 - x, color);
        if (d < 0)
        {
            d = d + 4 * x + 6;
        }
        else
        {
            d = d + 4 * (x - y) + 10;
            y--;
        }
        x++;
    }
}
int ui::painter::drawTriangle(int x0, int y0, int x1, int y1, UI_COLOR color, int direction){
    if(((x0 >= x1) && (y0 == y1)) || ((x0 == x1) && (y0 >= y1))) return -1;
    if(direction == 1){
        if(y0 != y1) return -1;
        drawLine(x0, y0, x1+1, y1, color);
        do{
            x0 += 1;
            y0 -= 1;
            x1 -= 1;
            y1 -= 1;
            drawPoint(x0, y0, color);
            drawPoint(x1, y1, color);
        }
        while(x0 + 2 <= x1);
    }
    else if(direction == 2){
        if(y0 != y1) return -1;
        drawLine(x0, y0, x1+1, y1, color);
        do{
            x0 += 1;
            y0 += 1;
            x1 -= 1;
            y1 += 1;
            drawPoint(x0, y0, color);
            drawPoint(x1, y1, color);
        }
        while(x0 + 2 <= x1);
    }
    else if(direction == 3){
        if(x0 != x1) return -1;
        drawLine(x0, y0, x1, y1+1, color);
        do{
            x0 -= 1;
            y0 += 1;
            x1 -= 1;
            y1 -= 1;
            drawPoint(x0, y0, color);
            drawPoint(x1, y1, color);
        }
        while(y0 + 2 <= y1);
    }
    else if(direction == 4){
        if(x0 != x1) return -1;
        drawLine(x0, y0, x1, y1+1, color);
        do{
            x0 += 1;
            y0 += 1;
            x1 += 1;
            y1 -= 1;
            drawPoint(x0, y0, color);
            drawPoint(x1, y1, color);
        }
        while(y0 + 2 <= y1);
    }
    else {
        printf("unknown direction");
        return -1;
    }
    return 0;
}
int ui::painter::drawTriangleFill(int x0, int y0, int x1, int y1, UI_COLOR color, int direction){
    if(((x0 >= x1) && (y0 == y1)) || ((x0 == x1) && (y0 >= y1))) return -1;
    if(direction == 1){
        if(y0 != y1) return -1;
        drawLine(x0, y0, x1+1, y1, color);
        do{
            x0 += 1;
            y0 -= 1;
            x1 -= 1;
            y1 -= 1;
            drawLine(x0, y0, x1+1, y1, color);
        }
        while(x0 + 2 <= x1);
    }
    else if(direction == 2){
        if(y0 != y1) return -1;
        drawLine(x0, y0, x1+1, y1, color);
        do{
            x0 += 1;
            y0 += 1;
            x1 -= 1;
            y1 += 1;
            drawLine(x0, y0, x1+1, y1, color);
        }
        while(x0 + 2 <= x1);
    }
    else if(direction == 3){
        if(x0 != x1) return -1;
        drawLine(x0, y0, x1, y1+1, color);
        do{
            x0 -= 1;
            y0 += 1;
            x1 -= 1;
            y1 -= 1;
            drawLine(x0, y0, x1, y1+1, color);
        }
        while(y0 + 2 <= y1);
    }
    else if(direction == 4){
        if(x0 != x1) return -1;
        drawLine(x0, y0, x1, y1+1, color);
        do{
            x0 += 1;
            y0 += 1;
            x1 += 1;
            y1 -= 1;
            drawLine(x0, y0, x1, y1+1, color);
        }
        while(y0 + 2 <= y1);
    }
    else {
        printf("unknown direction");
        return -1;
    }
    return 0;
}

void ui::painter::drawBracket(int x0, int y0, int length, UI_COLOR color){
    drawPoint(x0, y0, color);
    int i;
    for(i=1; i<10; i++){
        drawPoint(x0-i, y0+i, color);
        drawPoint(x0-i, y0-i, color);
    }
    drawLine(x0-i, y0+i, x0-i, y0+i+length, color);
    drawLine(x0-i, y0-i, x0-i, y0-i-length, color);
}
// 单个字占18*18个像素
void ui::painter::drawString_big(int x, int y, const UI_CHAR* str, UI_COLOR color)
{
    if(Fnt_Get_Size()!=FONT_SIZE_18) Fnt_Set(FONT_SIZE_18);
    drawString(x, y, str, color, 2);
}

void ui::painter::drawString_small(int x, int y, const UI_CHAR* str, UI_COLOR color)
{
    if(Fnt_Get_Size()!=FONT_SIZE_14) Fnt_Set(FONT_SIZE_14);
    drawString(x, y, str, color, 1);
}

void ui::painter::drawString(int x, int y, const UI_CHAR* str, UI_COLOR color, int size)
{
    int x0 = x;
    int y0 = y;
    while (*str)
    {
        if (*str == '\r')
        {
            x0 = x;
            str++;
            continue;
        }
        if (*str == '\t')
        {
            y0 += 4 * size;
            str++;
            continue;
        }
        if (*str == '\n')
        {
            x0 -= 9 * size;
            y0 += 9 * size;
            str++;
            continue;
        }
        drawChar(&x0, &y0, *str, color);
        str++;
    }
}


static inline UI_COLOR MakeBackGradientRamp ( unsigned char gray, UI_COLOR color, UI_COLOR back)
{
    if(0==gray)
        return back;
    int R = 0xFF & ( color>>16 );
    int G = 0xFF & ( color>>8 );
    int B = 0xFF & ( color>>0 );

    int bR = 0xFF & ( back>>16 );
    int bG = 0xFF & ( back>>8 );
    int bB = 0xFF & ( back>>0 );

    int colorTotal = 255 ;
    int back_gray = 255 - gray ;
    
    int r = ( R * gray + bR * back_gray ) / colorTotal;
    int g = ( G * gray + bG * back_gray ) / colorTotal;
    int b = ( B * gray + bB * back_gray ) / colorTotal;
    
    UI_COLOR gr = 0xff000000 | ( r << 16 ) | ( g << 8 ) | ( b << 0 );

    return gr ;
}


void ui::painter::drawChar(int *px, int *py, UI_CHAR ch, UI_COLOR color)
{
    GUI_FONT_CHAR_DATA *pWordData=Fnt_GetLib();

	pWordData->cur_origin_x = *px;
	pWordData->cur_origin_y = *py + pWordData->YSize;
	
	if(Fnt_Find_Glyph(ch, pWordData)<=0)
		return;

    int line, col;
    UI_COLOR* pPix;

    GUI_FONT_CHAR_DATA* pData = pWordData ;

    int x = pData->region.left_up_x;
    int y = pData->region.left_up_y;

    y = y > m_height ? m_height - 1 : y ;
    pPix = m_pFrameBuffer + y * m_width + x;

    int w = pData->region.w;
    const unsigned char *buffer = pData->data;
    for(line = 0; line < pData->region.h; line++){
        if(*py + line < m_width){
            if(*py + line >= 0){
                const unsigned char *pSrc = &buffer[line * w] ;
                for(col = 0; col < pData->region.w; col++){
                    const unsigned char gray = *pSrc++ ;
                    if(255 == gray){
                        pPix[col] = color;
                    }
                    else if(gray > 0){
                        pPix[col] = MakeBackGradientRamp(gray, color, pPix[col]) ;
                    }
                }
            }
        }
        pPix += m_width;
    }
    *px = pData->next_origin_x ;
}

void ui::painter::draw_logo(){

    drawString_big(5, 5, L"UNI-T", 0xff0000);
}

void ui::painter::drawWaveVector(const UI_Window *pWindow, vWave_t *pData_center, int len, UI_COLOR Color, const SignalUI *CH)
{
    vWave_t CurrentMax, CurrentMin;
    pData_center = pData_center - ch4_ui.herizontal_pos;
    vWave_t* pData_begin = pData_center - (int)(valible_wave_length/2) + ch4_ui.herizontal_pos;
    vWave_t* pData_last = pData_center + (int)(valible_wave_length/2) + ch4_ui.herizontal_pos;
    vWave_t* pBuffer = pData_center;
    // Pre为第一个绘制点
    vWave_t Pre = *pBuffer;
    Pre = uiMapADToWindow(pWindow, Pre, CH);
    Pre = uiTruncateInWindow(pWindow, Pre);
    // 从中心位置或触发位置向右绘制
    for(int i=pWindow->x_mid; i < pWindow->x1; i++)
    {
        pBuffer += ch4_ui.xscale_skip;
//        pBuffer += ch1_ui.herizontal_pos;
        if(pBuffer > pData_last) break;
        vWave_t Current = *pBuffer;
        //采样数据到显示区域的数据变换
        Current = uiMapADToWindow (pWindow, Current, CH);
        Current = uiTruncateInWindow (pWindow, Current);
        if(Current > Pre)
        {
            CurrentMax = Current;
            CurrentMin = Pre;
        }
        else
        {
            CurrentMax = Pre;
            CurrentMin = Current;
        }
        int index = CurrentMin;
        // 判断像素点是否绘制过，如果绘制过则直接return
        UI_COLOR* pPix = getPix(pWindow->x0 + i, CurrentMin);
        if(pPix == NULL)
            return;
        // 两像素点差值过大则由一条直线代替
        for ( ; index <= CurrentMax-8; index += 8)
        {
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
            *pPix = Color;
            pPix += m_width;
        }
        do
        {
            *pPix = Color;
            pPix += m_width;
        }
        while (++index < CurrentMax);
        Pre = Current;
    }
    // 从中心位置或触发位置向左绘制
    pBuffer = pData_center;
    Pre = *pBuffer;
    Pre = uiMapADToWindow(pWindow, Pre, CH);
    Pre = uiTruncateInWindow(pWindow, Pre);
    for(int i=pWindow->x_mid; i > pWindow->x0; i--)
        {
            pBuffer -= ch4_ui.xscale_skip;
//            pBuffer += ch1_ui.herizontal_pos;
            if(pBuffer < pData_begin) break;
            vWave_t Current = *pBuffer;
            //采样数据到显示区域的数据变换
            Current = uiMapADToWindow (pWindow, Current, CH);
            Current = uiTruncateInWindow (pWindow, Current);
            if(Current > Pre)
            {
                CurrentMax = Current;
                CurrentMin = Pre;
            }
            else
            {
                CurrentMax = Pre;
                CurrentMin = Current;
            }
            int index = CurrentMin;
            // 获取像素指针
            UI_COLOR* pPix = getPix(pWindow->x0 + i, CurrentMin);
            if(pPix == NULL)
                return;
            // 两像素点差值过大则由一条直线代替
            for ( ; index <= CurrentMax-8; index += 8)
            {
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
                *pPix = Color;
                pPix += m_width;
            }
            do
            {
                *pPix = Color;
                pPix += m_width;
            }
            while (++index < CurrentMax);
            Pre = Current;
        }
}

void ui::painter::drawWaveDots(const UI_Window *pWindow, vWave_t *pAddr, int len, UI_COLOR Color, const SignalUI *CH)
{
    if ( NULL == pAddr )
    {
        return;
    }
    vWave_t* pBuffer = pAddr;

    for (int i=0; i<len; i++ )
    {
        vWave_t Current = *pBuffer++;
        //采样数据到显示区域的数据变换
        Current = uiMapADToWindow(pWindow, Current, CH);
        Current = uiTruncateInWindow (pWindow, Current);
        setPix(pWindow->x0+i, Current, Color);
    }
}

void ui::painter::drawGrid(const struct UI_Window* pWindow, UI_COLOR Color)
{
    int x0 = pWindow->x0;
    int y0 = pWindow->y0;
    int x1 = pWindow->x1;
    int y1 = pWindow->y1;
    int x_mid = pWindow-> x_mid;
    int y_mid = pWindow-> y_mid;
    int xGrid = pWindow->x_div;
    int yGrid = pWindow->y_div;
    int scale_length = 2;
    drawRectFill(x0, y0, x1, y1, 0x000000);
    // 绘制x正网格 垂直
    for (int x = xGrid; x_mid + x <= x1; x += xGrid)
    {
        drawLine(x_mid + x, y0, x_mid + x, y1, GRID_COLOR);
    }
    // 绘制x负网格 垂直
    for (int x = xGrid; x_mid - x >= x0; x += xGrid)
    {
        drawLine(x_mid -x, y0, x_mid -x, y1, GRID_COLOR);
    }
    // 绘制y正网格 水平
    for (int y = yGrid; y_mid + y <= y1; y += yGrid)
    {
        drawLine(x0, y_mid + y, x1 + 1 , y_mid + y, GRID_COLOR);
    }
    // 绘制y负网格 水平
    for (int y = yGrid; y_mid - y >= y0; y += yGrid)
    {
        drawLine(x0, y_mid - y, x1 + 1, y_mid -y, GRID_COLOR);
    }
    // 绘制x零线
    drawLine(x0, y_mid, x1, y_mid, ZERO_LINE_COLOR);
    // 绘制x零线正刻度
    for (int x = 5; x_mid + x <= x1; x += 5)
    {
        drawLine(x_mid + x, y_mid - scale_length, x_mid + x, y_mid + scale_length + 1, ZERO_SCALE_COLOR);
    }
    // 绘制x零线负刻度
    for (int x = 5; x_mid - x >= x0; x += 5)
    {
        drawLine(x_mid -x, y_mid - scale_length, x_mid -x, y_mid + scale_length + 1, ZERO_SCALE_COLOR);
    }
    // 绘制y零线
    drawLine(x_mid, y0, x_mid, y1, ZERO_LINE_COLOR);

    // 绘制y零线正刻度
    for (int y = 5; y_mid + y <= y1; y += 5)
    {
        drawLine(x_mid - scale_length, y_mid + y,x_mid + scale_length + 1 , y_mid + y, ZERO_SCALE_COLOR);
    }
    // 绘制y零线负刻度
    for (int y = 5; y_mid - y >= y0; y += 5)
    {
        drawLine(x_mid - scale_length, y_mid - y, x_mid + scale_length + 1, y_mid -y, ZERO_SCALE_COLOR);
    }
}

void ui::painter::drawHeadStatusBar (const struct UI_Window* pWindow)
{
    int x0 = pWindow->x0;
    int y0 = pWindow->y0;
    int x1 = pWindow->x1;
    int y1 = pWindow->y1;
    if(flush_flag) drawRectFill(x0, y0, x1-130, y1, 0x101010);
    drawRectFill(x1-125, y0, x1, y1, 0x101010);
    if(ch4_ui.ai_status == 0){
        drawString_big(x1-121, 5, L"异常检测:关闭", CH1_COLOR);
    }
    else if(ch4_ui.ai_status == 1){
        if(ch4_ui.ai_result < 0) drawString_big(x1-121, 5, L"异常检测:无结果", CH1_COLOR);
        else if(ch4_ui.ai_result == 0) drawString_big(x1-121, 5, L"异常检测:回沟", CH1_COLOR);
        else if(ch4_ui.ai_result == 1) drawString_big(x1-121, 5, L"异常检测:正常", CH1_COLOR);
        else if(ch4_ui.ai_result == 2) drawString_big(x1-121, 5, L"异常检测:过冲", CH1_COLOR);
        else if(ch4_ui.ai_result == 3) drawString_big(x1-121, 5, L"异常检测:尖峰", CH1_COLOR);
        else drawString_big(x1-121, 5, L"异常检测:异常", 0xff0000);
    }
    else drawString_big(x1-121, 5, L"异常检测:异常", 0xff0000);
}

void ui::painter::drawToolBar (const struct UI_Window* pWindow)
{
    int x0 = pWindow->x0;
    int y0 = pWindow->y0;
    int x1 = pWindow->x1;
    int y1 = pWindow->y1;
    int x_mid = pWindow->x_mid;

    drawRectFill(x0, y0, x1, y1, 0x101010);
    drawRectFill(x0, y0, x1, 30, 0x202020);
    drawString_big(x_mid-16, y0 + 4, L"菜单", 0xffffff);

    draw_function();
}

void ui::painter::drawFootStatusBar ( const struct UI_Window* pWindow)
{
    int x0 = pWindow->x0;
    int y0 = pWindow->y0;
    int x1 = pWindow->x1;
    int y1 = pWindow->y1;

    if(flush_flag) drawRectFill(x0, y0, x1, y1, 0x101010);
    if(alternate_flush_flag==2) draw_time_based_box(x0 + 480, y0, x1, y1);
    if(alternate_flush_flag==2) draw_trigger_box(x0 + 605, y0, x1, y1);
    if(alternate_flush_flag==2) draw_signal_box(x0 + 5, y0, x1, y1);
    if(flush_flag) draw_init_box(x0 + 130, y0, x1, y1);
    if(alternate_flush_flag==2) draw_status_icon(x0 + 730, y0, x1, y1);
}

void ui::painter::draw_function(){
    int num_func = 5;
    const UI_CHAR *fuc_name1 = L"测\n量";
    const UI_CHAR *fuc_name2 = L"触\n发";
    const UI_CHAR *fuc_name3 = L"设\n定";
    const UI_CHAR *fuc_name4 = L"\tAI";
    const UI_CHAR *fuc_name5 = L"关\n于";
    const UI_CHAR *fuc_name[5] = {fuc_name1, fuc_name2, fuc_name3, fuc_name4, fuc_name5};
    for(int i=0; i<num_func; i++)
    {
        drawString_big(770, 52 + i * 80, fuc_name[i], 0xffffff);
    }
    if(tool_bar.Id != 0) drawRect (750, 44 + (tool_bar.Id - 1) * 80, 800, 99 + (tool_bar.Id - 1) * 80, 0xffffff, true, true, true, false);
}

void ui::painter::draw_trig_float_bar(){
    int x0 = trig_float_bar.x0;
    int y0 = trig_float_bar.y0;
    int x1 = trig_float_bar.x1;
    int y1 = trig_float_bar.y1;
    drawRectFill(x0, y0, x1 - 20, y0 + 20, 0x101010);
    drawString_small(x0 + 2, y0 + 2, L"触发", 0xAAAAAA);
    drawRectFill(x1 - 20, y0, x1, y0 + 20, 0x101010);
    drawRect(x1 - 20, y0, x1 - 1, y0 + 19, 0xAAAAAA);
    drawLine(x1 - 18, y0 + 2, x1 - 2, y0 + 18, 0xAAAAAA);
    drawLine(x1 - 18, y0 + 18, x1 - 2, y0 + 2, 0xAAAAAA);
    drawRectFill(x0, y0 + 20, x1, y1, 0x202020);
    drawString_small(x0 + 2, y0 + 25, L"触发方式", 0xAAAAAA);
    drawString_small(x0 + 5, y0 + 50, L"关闭", 0xAAAAAA);
    drawString_small(x0 + 35, y0 + 50, L"自动", 0xAAAAAA);
    drawString_small(x0 + 65, y0 + 50, L"正常", 0xAAAAAA);
    drawString_small(x0 + 95, y0 + 50, L"单次", 0xAAAAAA);
    drawTriangleFill(x0 + 16 + ch4_fpga_info.trig_mode * 30, y0 + 72, x0 + 22 + ch4_fpga_info.trig_mode * 30, y0 + 72, 0xFFFF00, 1);

    drawString_small(x0 + 2, y0 + 80, L"触发条件", 0xAAAAAA);
    drawString_small(x0 + 10, y0 + 105, L"上升沿", 0xAAAAAA);
    drawString_small(x0 + 70, y0 + 105, L"下降沿", 0xAAAAAA);
    drawTriangleFill(x0 + 28 + ch4_fpga_info.trig_edge * 60, y0 + 127, x0 + 34 + ch4_fpga_info.trig_edge * 60, y0 + 127, 0xFFFF00, 1);
    if(trig_float_bar.Id == 0) ;
    else if(trig_float_bar.Id < 5) drawRect(x0 + 4 + (trig_float_bar.Id - 1) * 30, y0 + 48, x0 + 32 + (trig_float_bar.Id - 1) * 30, y0 + 68, 0xAAAAAA);
    else drawRect(x0 + 8 + (trig_float_bar.Id - 5) * 60, y0 + 103, x0 + 55 + (trig_float_bar.Id - 5) * 60, y0 + 123, 0xAAAAAA);
}

void ui::painter::draw_set_float_bar(){
    int x0 = set_float_bar.x0;
    int y0 = set_float_bar.y0;
    int x1 = set_float_bar.x1;
    int y1 = set_float_bar.y1;
    drawRectFill(x0, y0, x1 - 20, y0 + 20, 0x101010);
    drawString_small(x0 + 2, y0 + 2, L"CH1设定", 0xAAAAAA);
    drawRectFill(x1 - 20, y0, x1, y0 + 20, 0x101010);
    drawRect(x1 - 20, y0, x1 - 1, y0 + 19, 0xAAAAAA);
    drawLine(x1 - 18, y0 + 2, x1 - 2, y0 + 18, 0xAAAAAA);
    drawLine(x1 - 18, y0 + 18, x1 - 2, y0 + 2, 0xAAAAAA);
    drawRectFill(x0, y0 + 20, x1, y1, 0x202020);
    drawString_small(x0 + 20, y0 + 25, L"耦合方式", 0xAAAAAA);
    drawString_small(x0 + 20, y0 + 50, L"DC", 0xAAAAAA);
    drawString_small(x0 + 55, y0 + 50, L"AC", 0xAAAAAA);
    drawTriangleFill(x0 + 26 + ch4_ui.coupling_mode * 34, y0 + 72, x0 + 32 + ch4_ui.coupling_mode * 34, y0 + 72, 0xFFFF00, 1);

    drawString_small(x0 + 7, y0 + 80, L"20M带宽限制", 0xAAAAAA);
    drawString_small(x0 + 15, y0 + 105, L"关闭", 0xAAAAAA);
    drawString_small(x0 + 55, y0 + 105, L"开启", 0xAAAAAA);
    drawTriangleFill(x0 + 26 + ch4_ui.bandwidth_20M * 40, y0 + 127, x0 + 32 + ch4_ui.bandwidth_20M * 40, y0 + 127, 0xFFFF00, 1);
    if(set_float_bar.Id == 0);
    else if(set_float_bar.Id < 3) drawRect(x0 + 16 + (set_float_bar.Id - 1) * 35, y0 + 48, x0 + 42 + (set_float_bar.Id - 1) * 35, y0 + 68, 0xAAAAAA);
    else drawRect(x0 + 12 + (set_float_bar.Id - 3) * 40, y0 + 103, x0 + 44 + (set_float_bar.Id - 3) * 40, y0 + 123, 0xAAAAAA);
}

void ui::painter::draw_ai_float_bar(){
    int x0 = ai_float_bar.x0;
    int y0 = ai_float_bar.y0;
    int x1 = ai_float_bar.x1;
    int y1 = ai_float_bar.y1;
    drawRectFill(x0, y0, x1 - 20, y0 + 20, 0x101010);
    drawString_small(x0 + 2, y0 + 2, L"AI", 0xAAAAAA);
    drawRectFill(x1 - 20, y0, x1, y0 + 20, 0x101010);
    drawRect(x1 - 20, y0, x1 - 1, y0 + 19, 0xAAAAAA);
    drawLine(x1 - 18, y0 + 2, x1 - 2, y0 + 18, 0xAAAAAA);
    drawLine(x1 - 18, y0 + 18, x1 - 2, y0 + 2, 0xAAAAAA);
    drawRectFill(x0, y0 + 20, x1, y1, 0x202020);
    drawString_small(x0 + 7, y0 + 25, L"异常检测", 0xAAAAAA);
    drawString_small(x0 + 5, y0 + 50, L"关闭", 0xAAAAAA);
    drawString_small(x0 + 35, y0 + 50, L"开启", 0xAAAAAA);
    drawTriangleFill(x0 + 16 + ch4_ui.ai_status * 30, y0 + 72, x0 + 22 + ch4_ui.ai_status * 30, y0 + 72, 0xFFFF00, 1);
    drawString_small(x0 + 7, y0 + 75, L"工作方式", 0xAAAAAA);
    drawString_small(x0 + 5, y0 + 100, L"检测", 0xAAAAAA);
    drawString_small(x0 + 35, y0 + 100, L"捕获", 0xAAAAAA);
    drawTriangleFill(x0 + 16 + ch4_ui.ai_method * 30, y0 + 122, x0 + 22 + ch4_ui.ai_method * 30, y0 + 122, 0xFFFF00, 1);
    if(ai_float_bar.Id == 0) ;
    else if(ai_float_bar.Id < 3) drawRect(x0 + 4 + (ai_float_bar.Id - 1) * 30, y0 + 48, x0 + 32 + (ai_float_bar.Id - 1) * 30, y0 + 68, 0xAAAAAA);
    else drawRect(x0 + 4 + (ai_float_bar.Id - 3) * 30, y0 + 98, x0 + 32 + (ai_float_bar.Id - 3) * 30, y0 + 118, 0xAAAAAA);
}

void ui::painter::drawMeasurementBar(const struct UI_Window* pWindow)
{
    int x0 = pWindow->x0;
    int y0 = pWindow->y0;
    int x1 = pWindow->x1;
    int y1 = pWindow->y1;
    drawRectFill(x0, y0, x1, y1, 0x101010);
    double culc_temp = 0;
    UI_CHAR buff[100]={0};
    if(abs(ch1_info.max)>1000)
    {
        culc_temp = ch1_info.max/1000;
        swprintf(buff, 100, L"最大值:%.1fv", culc_temp);
    }
    else swprintf(buff, 100, L"最大值:%.1fmv", ch1_info.max);
    drawString_small(x0+10, y0+5, buff, 0xffffff);
    if(abs(ch1_info.min)>1000)
    {
        culc_temp = ch1_info.min/1000;
        swprintf(buff, 100, L"最小值:%.1fv", culc_temp);
    }
    else swprintf(buff, 100, L"最小值:%.1fmv", ch1_info.min);
    drawString_small(x0+120, y0+5, buff, 0xffffff);
    if(ch1_info.vpp>1000)
    {
        culc_temp = ch1_info.vpp/1000;
        swprintf(buff, 100, L"峰峰值:%.1fv", culc_temp);
    }
    else swprintf(buff, 100, L"峰峰值:%.1fmv", ch1_info.vpp);
    drawString_small(x0+240, y0+5, buff, 0xffffff);
    if(ch1_info.period>1000)
    {
        culc_temp = ch1_info.period/1000;
        if(culc_temp > 1000){
            culc_temp = culc_temp/1000;
            swprintf(buff, 100, L"周期:%.1fms", culc_temp);
        }
        else swprintf(buff, 100, L"周期:%.1fus", culc_temp);
    }
    else swprintf(buff, 100, L"周期:%.1fns", ch1_info.period);
    drawString_small(x0+360, y0+5, buff, 0xffffff);
    if(ch1_info.frequency >= 1000)
    {
        culc_temp = ch1_info.frequency/1000;
        if(culc_temp >= 1000){
            culc_temp = culc_temp/1000;
            swprintf(buff, 100, L"频率:%.6fMHz", culc_temp);
        }
        else swprintf(buff, 100, L"频率:%.3fkHz", culc_temp);
    }
    else if(ch1_info.frequency < 5){
        swprintf(buff, 100, L"频率:<5Hz");
    }
    else swprintf(buff, 100, L"频率:%.1fHz", ch1_info.frequency);
    drawString_small(x0+470, y0+5, buff, 0xffffff);
}

void ui::painter::draw_time_based_box(int x0, int y0, int x1, int y1){
    int titile_x0 = x0;
    int titile_y0 = y0;
    int titile_x1 = x0 + 120;
    int titile_y1 = y0 + 24;
    int box_x0 = x0;
    int box_y0 = titile_y1;
    int box_x1 = titile_x1;
    int box_y1 = y1;

    drawRectFill(titile_x0, titile_y0, titile_x1, titile_y1, 0x202020);
    drawRectFill(box_x0, box_y0, box_x1, box_y1, 0x303030);
    drawString_small(titile_x0 + 4, titile_y0 + 4, L"时基", 0xffffff);
    drawString_small(box_x0 + 4, box_y0 + 2, L"8us", 0xffffff);
    UI_CHAR buff[100]={0};
    swprintf(buff, 100, L"%s/div", eXScale_names[ch4_ui.time_base]);
    drawString_small(box_x0 + 46, box_y0 + 2, buff, 0xffffff);
    drawString_small(box_x0 + 4, box_y0 + 20, L"8kpts", 0xffffff);
    drawString_small(box_x0 + 46, box_y0 + 20, L"1GSa/s", 0xffffff);
}

void ui::painter::draw_trigger_box(int x0, int y0, int x1, int y1){
    int titile_x0 = x0;
    int titile_y0 = y0;
    int titile_x1 = x0 + 120;
    int titile_y1 = y0 + 24;
    int box_x0 = x0;
    int box_y0 = titile_y1;
    int box_x1 = titile_x1;
    int box_y1 = y1;

    drawRectFill(titile_x0, titile_y0, titile_x1, titile_y1, 0x202020);
    drawRectFill(box_x0, box_y0, box_x1, box_y1, 0x303030);

    UI_CHAR buff[100]={0};
    double culc_temp = 0;
    drawString_small(titile_x0 + 4, titile_y0 + 4, L"触发", CH1_COLOR);
    if(!ch4_ui.coupling_mode) drawString_small(titile_x1 - 44, titile_y0 + 4, L"C1DC", CH1_COLOR);
    else drawString_small(titile_x1 - 44, titile_y0 + 4, L"C1AC", CH1_COLOR);
    if(ch4_fpga_info.trig_mode==0) drawString_small(box_x0 + 4, box_y0 + 2, L"关闭", 0xffffff);
    else if(ch4_fpga_info.trig_mode==1) drawString_small(box_x0 + 4, box_y0 + 2, L"自动", 0xffffff);
    else if(ch4_fpga_info.trig_mode==2) drawString_small(box_x0 + 4, box_y0 + 2, L"正常", 0xffffff);
    else if(ch4_fpga_info.trig_mode==3) drawString_small(box_x0 + 4, box_y0 + 2, L"单次", 0xffffff);
    culc_temp = ch1_info.trig_level;
    if(abs(culc_temp) > 1000)
    {
        culc_temp = culc_temp/1000;
        swprintf(buff, 100, L"%.02fv", culc_temp);
    }
    else swprintf(buff, 100, L"%.02fmv", culc_temp);
    drawString_small(box_x1 - 60, box_y0 + 2, buff, 0xffffff);
    drawString_small(box_x0 + 4, box_y0 + 20, L"边沿", 0xffffff);
    if(ch4_fpga_info.trig_edge) drawString_small(box_x0 + 60, box_y0 + 20, L"下降沿", 0xffffff);
    else drawString_small(box_x1 - 60, box_y0 + 20, L"上升沿", 0xffffff);
}

void ui::painter::draw_signal_box(int x0, int y0, int x1, int y1){
    int titile_x0 = x0;
    int titile_y0 = y0;
    int titile_x1 = x0 + 120;
    int titile_y1 = y0 + 24;
    int box_x0 = x0;
    int box_y0 = titile_y1;
    int box_x1 = titile_x1;
    int box_y1 = y1;

    drawRectFill(titile_x0, titile_y0, titile_x1, titile_y1, 0x202020);
    drawRectFill(box_x0, box_y0, box_x1, box_y1, 0x303030);
    drawString_small(titile_x0 + 4, titile_y0 + 4, L"C1", CH1_COLOR);
    if(!ch4_ui.coupling_mode) drawString_small(titile_x1 - 44, titile_y0 + 4, L"DC1M", CH1_COLOR);
    else drawString_small(titile_x1 - 44, titile_y0 + 4, L"AC1M", CH1_COLOR);
    drawString_small(box_x0 + 4, box_y0 + 2, L"1X", 0xffffff);
    UI_CHAR buff[100]={0};
//    swprintf(buff, 100, L"%.02f?v/div", ch1_info.trig_level);
    swprintf(buff, 100, L"%s/div\n", eYScale_names[ch4_ui.yscale]);
    drawString_small(box_x0 + 50, box_y0 + 2, buff, 0xffffff);
    if(!ch4_ui.bandwidth_20M) drawString_small(box_x0 + 4, box_y0 + 20, L"FULL", 0xffffff);
    else drawString_small(box_x0 + 4, box_y0 + 20, L"20MHz", 0xffffff);
    drawString_small(box_x0 + 50, box_y0 + 20, L"0.00v", 0xffffff);
}

void ui::painter::draw_init_box(int x0, int y0, int x1, int y1){
    int titile_x0 = x0;
    int titile_y0 = y0;
    int titile_x1 = x0 + 120;

    drawRect(titile_x0, titile_y0, titile_x1, y1-1, 0x777777);
//    printf("%d", box_y1);
//    drawRect(titile_x0, titile_y0, box_x1, box_y1 - 60, 0xeeeeee);
    drawLine((titile_x0 + titile_x1)/2, y0 + 8, (titile_x0 + titile_x1)/2, y1 - 8, 0x777777);
    drawLine(x0 + 20, y0 + (y1 - y0)/2, titile_x1 - 20, y0 + (y1 - y0)/2, 0x777777);
}

void ui::painter::draw_status_icon(int x0, int y0, int x1, int y1){
    drawRectFill(x0, y0, x1, y1, 0x222222);
    draw_intenet_status(x0+6, y0+6);
    uchar hour = (uchar)floor(elapsedTime / 3600);
    uchar minu = ((uchar)floor(elapsedTime / 60)) % 60;
    uchar second = static_cast<uchar>(fmod(elapsedTime, 60));
    UI_CHAR buff[100]={0};
    swprintf(buff, 100, L"%02d:%02d:%02d", hour, minu, second);
    drawString_small(x0+6, y0+34, buff, 0xffffff);
}

void ui::painter::draw_info_box(){
    if(info_box.life_time > 0){
        drawString_small(info_box.x0, info_box.y0, info_box.buff, 0xffff00);
        info_box.life_time --;
    }
}

void ui::painter::draw_trigger_pointer(){
    // 绘制垂直触发箭头
    if(abs(ch4_ui.herizontal_pos) < 320){
        drawTriangleFill(main_window.x_mid - 8 + ch4_ui.herizontal_pos, main_window.y0, main_window.x_mid + 8 + ch4_ui.herizontal_pos, main_window.y0, 0xffff00, 2);
    }

    trigger_pointer.y0 = (ushort)(-2 * YSCALE_VALUE_RATE * (ch1_info.trig_level) / eYScale_value[ch4_ui.yscale] + main_window.y_mid + ch4_ui.vertical_pos);
    if(trigger_pointer.y0 < 360 && trigger_pointer.y0 > 50){
        drawRectFill(main_window.x0, trigger_pointer.y0 - 9, main_window.x0 + 10, trigger_pointer.y0 + 10, 0xffff00);
        // 绘制触发指针箭头
        drawTriangleFill(main_window.x0 + 10, trigger_pointer.y0 - 9, main_window.x0 + 10, trigger_pointer.y0 + 9, 0xffff00, 4);
        drawString_big(main_window.x0, trigger_pointer.y0 - 10, L"T", 0x010101);
        drawLine(main_window.x0 + 10, trigger_pointer.y0, main_window.x1, trigger_pointer.y0, 0xffff00);
    }
}

void ui::painter::draw_intenet_status(int x0, int y0){
    UI_COLOR status_color;
    if(ip_status) status_color = 0xffffff;
    else status_color = 0xff0000;
    drawRectFill(x0+4, y0+4, x0+8, y0+8, status_color);
    drawRectFill(x0, y0+12, x0+4, y0+16, status_color);
    drawRectFill(x0+8, y0+12, x0+12, y0+16, status_color);
    drawLine(x0, y0+9, x0+12, y0+9, status_color);
    drawLine(x0+2, y0+10, x0+2, y0+16, status_color);
    drawLine(x0+6, y0+8, x0+6, y0+10, status_color);
    drawLine(x0+10, y0+10, x0+10, y0+16, status_color);
}

void ui::painter::draw_win_base(){
    // 绘制主画面方框
    if(alternate_flush_flag % 2 == 0) drawGrid(&main_window, 0xFFffFF);
    // 绘制上状态栏
    drawHeadStatusBar(&head_status_bar);
    // 绘制工具栏
    if(alternate_flush_flag == 1) drawToolBar(&tool_bar);
    // 绘制下状态栏
    drawFootStatusBar(&foot_status_bar);
}

void ui::painter::draw_pointer(){
    // 触发指针
    draw_trigger_pointer();
}
