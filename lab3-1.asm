LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
start:
    movlw 0xC2
    movwf TRISA
    clrf WREG
    iorwf TRISA,0,0
    andlw B'10000000'
    bcf STATUS,0
    rrcf TRISA,1
    iorwf TRISA,1,0
end

