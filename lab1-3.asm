LIST p=18f4520
    #include<p18f4520.inc>
	    CONFIG OSC = INTIO67
	    CONFIG WDT = OFF
	    org 0x00
Start:
    clrf WREG
    clrf H'00001' 
    clrf H'00002' 
    clrf H'00003' 
    
    movlw 0xCF;D9 CF
    movff WREG,H'00001'
    movlw 0xFB;9B FB
    movff WREG,H'00002' 
    movlw D'8'
    movff WREG,TRISC 
    movlw D'7'
loopmove:
    rlncf H'00002' 
    decfsz WREG 
    goto loopmove
    goto loopcheck 

loopcheck:
    movlw 0x00
    xorwf H'00001',0,0
    xorwf H'00002',0,0
    btfsc WREG,7 ;0:yes,1:no
    goto Nonpalindrome
    rlncf H'00001' 
    movlw D'7' 
    decfsz TRISC
    goto loopmove
    goto cont

Nonpalindrome:
    movlw 0x01
    movff WREG,H'00003'
    movlw 0xCF
    movff WREG,H'00001'
    movlw 0xFB
    movff WREG,H'00002'
    goto nxt

cont:
    setf H'00003'

nxt:
end