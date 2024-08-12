/*
 * @Author: song sds0222@163.com
 * @Date: 2023-04-12 16:31:57
 * @LastEditors: song sds0222@163.com
 * @LastEditTime: 2023-04-12 16:32:05
 * @FilePath: \Graduate_Demo\mso2000\Hardware\ADC.h
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
#pragma once
#include "Type.h"

void HW_ADC_Init();
void HW_ADC_WriteMerga (uint ch, ushort merga );
void HW_ADC_WriteGain (uint ch, ushort Data );
void HW_WriteADC_Gian (uint ch, short Data );

