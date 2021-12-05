LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

Initial:  
    clrf 0x000
    popp macro F
	clrf WREG
	clrf POSTDEC0 ;back
	movff INDF0,F
	clrf INDF0
	endm
	
    pushh macro F
	subwf F,0
	movwf POSTINC0
	endm
	
    movlw 0x06 ;F6
    LFSR 0, 0x010
    movff WREG, POSTINC0
        
Start:
    rcall Fib_recur
    rcall finish
    
Fib_recur:
    popp 0x004 ;addr=0x10
    movlw 1
    cpfsgt 0x004 ;if 0x004 > 1, skip
    goto F0F1
    goto larger_than_one
    
larger_than_one:
    movlw 0x01 ;push(a-1)
    pushh 0x004
    movlw 0x02 ;push(a-2)
    pushh 0x004
    movlw 0x10 ;goto 0x10
    movwf PCL
    
F0F1:
    movff 0x004,WREG
    addwf 0x000,1
    movlw 0x10
    TSTFSZ 0x010 ;stack empty, skip, else, goto 0x10
    movwf PCL 
    return
    
finish:
    end