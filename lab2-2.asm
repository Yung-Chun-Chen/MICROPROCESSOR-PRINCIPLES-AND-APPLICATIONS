LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
start:
    
    lfsr 0, 0100
    movlw D'0'
loop:
    movwf INDF0
    addlw D'1'
    btfss POSTINC0,3
    goto loop
    clrf WREG
    clrf TRISC
    lfsr 0, 0100
    lfsr 1, 0120 
loop2:    
    movf INDF0,0
    addwf TRISC,1
    movff TRISC,POSTINC1
    btfss POSTINC0,3
    goto loop2
end