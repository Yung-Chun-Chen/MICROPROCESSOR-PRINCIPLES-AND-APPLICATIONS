#INCLUDE <p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF 
	org 0x10
	
start:
    movlw 0xB5
    movff WREG,0x100
    movlw 0xF3
    movff WREG,0x101
    movlw 0x64
    movff WREG,0x102
    movlw 0x7F
    movff WREG,0x103
    movlw 0x98
    movff WREG,0x104
    lfsr 0 ,0x100
    lfsr 1,0x101
    movlw D'4'
    movff WREG,TRISD ;big
    movff WREG,0x0F0
    movff WREG,TRISC ;small
    movff WREG,0x0F1
    movlw D'0'
Loop:   
    movff INDF0,WREG ;WREG=FSR0
    subwf INDF1,0 ;back-front
    btfsc WREG,7 ;=1 swap,=0 skip
    goto exchange
innerloop:
    movff POSTINC1,TRISB ;FSR1++
    decfsz TRISD ;TRISD==0 skip
    goto Loop
    goto Update_FSR0
    
Update_FSR0:
    movff POSTINC0,WREG
     ;FSR0++ ,FSR1 point to newFSR0 
    movff FSR0L,FSR1L
    movff FSR0H,FSR1H
    movff POSTINC1,WREG
    decfsz TRISC ;TRISC==0 skip 
    goto counter_update
    goto next
exchange:
    movff INDF0,WREG
    movff INDF1,INDF0
    movff WREG,INDF1
    goto innerloop
    
counter_update:
    movlw 0x01
    subwf 0x0F0,1
    movff 0x0F0,TRISD
    subwf 0x0F1,1
    movff 0x0F1,TRISC
    goto Loop
next:
end