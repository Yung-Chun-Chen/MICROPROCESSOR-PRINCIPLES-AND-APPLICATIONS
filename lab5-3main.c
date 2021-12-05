/*
 * File:   newmain.c
 * Author: user
 *
 * Created on 2021?10?28?, ?? 9:51
 */


#include <xc.h>
extern unsigned char mysqrt(unsigned int a);

void main(void) {
    volatile unsigned char result = mysqrt(1600); //sqrt(0).sqrt(10).sqrt(15).sqrt(400).sqrt(800).sqrt(1300).sqrt(1600)
                                            //  0x00?   0x03?    0x03?    0x14?    0x1C?    0x24?    0x28
    while(1){};
    return;
}
