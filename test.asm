LIST p=18f4520
    #include<p18f4520.inc>
	    CONFIG OSC = INTIO67
	    CONFIG WDT =OFF
	    org 0x00
Initial:
    LIST_INIT macro addr,n1,n2,n3,n4,n5
	LFSR 0,addr
	movlw n1
	movwf POSTINC0
	movlw n2
	movwf POSTINC0
	movlw n3
	movwf POSTINC0
	movlw n4
	movwf POSTINC0
	movlw n5
	movwf POSTINC0
    endm
start:
    LIST_INIT 0x100,0x03,0x03,0x04,0x91,0xC4
    LIST_INIT 0x200,0x08,0x08,0xa1,0xb2,0xff
    rcall MERGE_LIST
    goto finish
MERGE_LIST:
    LFSR 0,0x400
    LFSR 1,0x100
    LFSR 2,0x200
    movff POSTINC1,POSTINC0
    movff POSTINC1,POSTINC0
    movff POSTINC1,POSTINC0
    movff POSTINC1,POSTINC0
    movff POSTINC1,POSTINC0
    
    movff POSTINC2,POSTINC0
    movff POSTINC2,POSTINC0
    movff POSTINC2,POSTINC0
    movff POSTINC2,POSTINC0
    movff POSTINC2,INDF0
    LFSR 0,0x400
    LFSR 1,0x400;i
    LFSR 2,0x401;j
	movlw 0x09
	movwf TRISA ;counter1
	movwf 0x000
	movlw 0x09
	movwf TRISB ;counter2
	
	loop:
	movff INDF1,WREG
	cpfsgt INDF2 ;skip if f>w do nothing
	rcall swap
	movff POSTINC2,WREG ;LFSR2 ++
	decfsz TRISA ;-1 skip == 0
	goto loop
	rcall loop2
	decfsz TRISB ;for big loop
	goto loop
    return
swap:
    movff INDF1,WREG
    movff INDF2,INDF1
    movff WREG,INDF2
return
loop2:
    decf 0x000;f-1
    movff 0x000,TRISA
    
    movff POSTINC1,WREG ;LFSR1++
    ;LFSR2 = LFSR1 + 1
    movff FSR1L,FSR2L   
    movff FSR1H,FSR2H
    movff POSTINC2,WREG
    
return
    
    
finish:
    end
