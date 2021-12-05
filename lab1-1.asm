LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
start:
    clrf WREG
    clrf TRISC
    movlw D'15'
loop:
    addwf TRISC,1
    decfsz WREG
    goto loop
cont:
    movf TRISC,0
    
end



