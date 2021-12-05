LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    
start:
    lfsr 0,100
    movlw D'0'
loop:
    movwf INDF0
    addlw 1
    btfss POSTINC0,3
    goto loop
lfsr 1,110
    movlw D'9'
    clrf POSTDEC0
loop2:
    movff POSTDEC0,POSTINC1
    decfsz WREG,0
    goto loop2
end


