/*
 * File:   newmain.c
 * Author: user
 *
 * Created on 2021?10?26?, ?? 12:16
 */


#include <xc.h>

//extern unsigned int divide(unsigned int a, unsigned int b);
extern unsigned int divide_signed(unsigned char a, unsigned char b);

void main(void) {
    volatile unsigned int res = divide_signed(-20 , -5);
    volatile char quotient = res >> 8;
    volatile char remainder = res;
    while(1){};
    return;
} 
