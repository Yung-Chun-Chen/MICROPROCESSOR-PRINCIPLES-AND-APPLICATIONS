LIST p=18f4520
    #include<p18f4520.inc>
	    CONFIG OSC = INTIO67
	    CONFIG WDT =OFF
	    org 0x00
Initial:
    unsigned_16_add macro oper1_H,oper1_L,oper2_H,oper2_L
	movff oper1_L,WREG
	addwf oper2_L,1
	movff oper1_H,WREG
	addwfc oper2_H,1
	endm
start:
    movlw 0x06
    movff WREG,0x000
    movff 0x000,0x010; 0x010:first
    movff 0x000,0x011
    movlw H'1'
    subwf 0x011,1 ;0x011:-1
    rcall fac
    goto finish
fac:
    movff 0x010,WREG
    mulwf 0x011
    movff PRODL,0x002
    movff PRODH,0x001
    
    movff 0x020,WREG ;0x020:if prodh has value
    mulwf 0x011
;    movff PRODL,0x002
;    movff PRODH,0x001
    movlw 0x16
    mulwf PRODL
    unsigned_16_add PRODH,PRODL,0x001,0x002
    
    movlw 0
    movff 0x002,0x010
    movff 0x001,0x020 
    decfsz 0x011
    goto fac
    return
finish:    
    end

