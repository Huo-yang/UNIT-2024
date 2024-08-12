#ifndef _HKB_h_
#define _HKB_h_

void HardwareKeyboardMapInit(void);
unsigned short HardwareKeyboardToKeyCode(unsigned char hkb);
unsigned char HardwareKeyboardPreprocess(unsigned char key, unsigned char &keybak, int &step, int deltaT);

#endif
