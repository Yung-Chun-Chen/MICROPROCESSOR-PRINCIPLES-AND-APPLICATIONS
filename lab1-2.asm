LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
start:
    clrf WREG
    clrf TRISC
    clrf TRISD
    movlw D'1'
loop:
    addwf TRISC,1
    mullw D'2'
    movf PRODL,0
    btfss WREG,7
    goto loop
cont:
    movf TRISC,0
    
end
