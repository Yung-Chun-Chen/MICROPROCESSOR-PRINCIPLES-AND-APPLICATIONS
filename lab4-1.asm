LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

Initial:
    MOVLF macro literal,F
	movlw literal
	movff WREG,F
	endm
	
    RECT macro addr_x1, addr_y1, addr_x2, addr_y2, F
	movff addr_x1,WREG
	subwf addr_x2,0
	movff WREG,0x010
	movff addr_y1,WREG
	subwf addr_y2,0
	mulwf 0x010
	movff PROD,0x004
	endm
start:
    MOVLF 0x03,0x000
    MOVLF 0x09,0x001
    MOVLF 0x07,0x002
    MOVLF 0x0F,0x003
    RECT 0x000,0x001,0x002,0x003,0x004
end