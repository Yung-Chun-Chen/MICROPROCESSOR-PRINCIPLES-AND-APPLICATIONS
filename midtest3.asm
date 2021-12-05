LIST p=18f4520
    #include<p18f4520.inc>
	    CONFIG OSC = INTIO67
	    CONFIG WDT =OFF
	    org 0x00
start:
    LFSR 0,0x000;origin
    movlw 0x0A
    movwf POSTINC0
    movlw 0x14
    movwf POSTINC0
    movlw 0x0F
    movwf POSTINC0
    movlw 0x13
    movwf POSTINC0
    movlw 0x06
    movwf POSTINC0
    
    movlw 0x3    ;k=2
    movwf 0x010;put k
    LFSR 0,0x000;origin
    LFSR 1,0x100;ans
    clrf WREG
    CPFSEQ 0x010 ;if==0,skip
    goto count
    goto zero
count:
    movlw 1
    subwf 0x010,0
    btfsc STATUS,Z;skip if 0
    goto case1
    
    movlw 2
    subwf 0x010,0
    btfsc STATUS,Z;skip if 0
    goto case2
    
    movlw 3
    subwf 0x010,0
    btfsc STATUS,Z;skip if 0
    goto case3
    
    movlw 4
    subwf 0x010,0
    btfsc STATUS,Z;skip if 0
    goto case4
    
    goto finish
case1:
    movff PREINC0,POSTINC1
    movff PREINC0,POSTINC1
    movff PREINC0,POSTINC1
    movff PREINC0,POSTINC1
    LFSR 0,0x000
    movff POSTINC0,POSTINC1
    goto finish
case2:
    movff PREINC0,WREG
    addwf PREINC0,0
    movwf POSTINC1
    
    movff INDF0,WREG
    addwf PREINC0,0
    movwf POSTINC1
    
    movff INDF0,WREG
    addwf PREINC0,0
    movwf POSTINC1
    
    
    movff INDF0,WREG
    LFSR 0,0x000
    addwf INDF0,0
    movwf POSTINC1
    
    movff INDF0,WREG
    addwf PREINC0,0
    movwf POSTINC1
    goto finish
case3:
    movff PREINC0,WREG
    addwf PREINC0,0
    addwf PREINC0,0
    movwf POSTINC1
    
    
    movff POSTDEC0,WREG
    movff POSTINC0,WREG
    addwf POSTINC0,0
    addwf POSTINC0,0
    movwf POSTINC1
    
    LFSR 0,0x003
    movff POSTINC0,WREG
    addwf POSTINC0,0
    LFSR 0,0x000
    addwf INDF0,0
    movwf POSTINC1
    
    LFSR 0,0x004
    movff INDF0,WREG
    LFSR 0,0x000
    addwf POSTINC0,0
    addwf POSTINC0,0
    movwf POSTINC1
    
    LFSR 0,0x000
    movff POSTINC0,WREG
    addwf POSTINC0,0
    addwf POSTINC0,0
    movwf POSTINC1
    goto finish
case4:
    movff PREINC0,WREG
    addwf  PREINC0,WREG
    addwf  PREINC0,WREG
    addwf  PREINC0,WREG
    movwf POSTINC1
    
    LFSR 0,0x002
    movff POSTINC0,WREG
    addwf POSTINC0,0
    addwf POSTINC0,0
    LFSR 0,0x000
    addwf POSTINC0,0
    movwf POSTINC1
    
    LFSR 0,0x003
    movff POSTINC0,WREG
    addwf POSTINC0,0
    LFSR 0,0x000
    addwf POSTINC0,0
    addwf POSTINC0,0
    movwf POSTINC1
    
    LFSR 0,0x004
    movff POSTINC0,WREG
    LFSR 0,0x000
    addwf POSTINC0,0
    addwf POSTINC0,0
    addwf POSTINC0,0
    movwf POSTINC1
    
    LFSR 0,0x000
    movff POSTINC0,WREG
    addwf POSTINC0,0
    addwf POSTINC0,0
    addwf POSTINC0,0
    movwf POSTINC1
    
    goto finish
zero:
    LFSR 0,0x100
    clrf POSTINC0
    clrf POSTINC0
    clrf POSTINC0
    clrf POSTINC0
    clrf POSTINC0
finish:
    end

