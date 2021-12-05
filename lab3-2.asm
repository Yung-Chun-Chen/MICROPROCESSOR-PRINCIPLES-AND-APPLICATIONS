LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
initial:
    movlw 0x0D
    movwf TRISB
    movlw 0x06
    movwf TRISC
    movff TRISC,0x000 ;0x000:result
    movlw 0x04
    movwf 0x001
    movff 0x001,0x002
    movff TRISB,WREG
loop1:
    rlncf WREG
    decfsz 0x001
    bnz loop1;not 0,branch
mult:      
    btfsc 0x000,0 ;bit0 is 1:write
    addwf 0x000,1
    rrcf 0x000       
    bcf STATUS,0
    decfsz 0x002
    bnc mult
ans:
    movff 0x000,TRISA
end
