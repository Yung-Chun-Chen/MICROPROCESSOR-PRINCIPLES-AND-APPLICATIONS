/*
 * File:   mainc.c
 * Author: user
 *
 * Created on 2021?10?25?, ?? 6:46
 */

#include "xc.h"

extern unsigned int divide(unsigned int a, unsigned int b);

void main(void) {
    volatile unsigned int res = divide(255, 13);
    volatile unsigned char quotient = res >> 8;
    volatile unsigned char remainder = res;
    while(1){};
    return;
} 
