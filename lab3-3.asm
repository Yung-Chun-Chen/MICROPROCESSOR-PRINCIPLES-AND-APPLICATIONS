LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
start:
    movlw 0x40
    movwf 0x000;dividend
    movwf TRISC;dividend
    movlw 0x28
    movwf 0x001;divisor
    movwf TRISD;divisor
loop:
    movff 0x001,0x011;last divisor
    movff 0x001,WREG
    subwf 0x000,0 ;000-WREG
    movff WREG,0x012;012:remainder 
    clrf WREG;in order to implement line21
    movff 0x001,0x000 ;divisor>dividend
    movff 0x012,0x001 ;remainder>divisor
    cpfseq 0x012 ;check 012 is 0 or not
    goto loop
L_End:
    movff TRISC,0x000;dividend
    movff TRISD,0x001;divisor
    movff 0x011,0x002
end