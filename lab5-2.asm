#include "xc.inc"
GLOBAL _divide_signed
    
PSECT mytext, local, class=CODE, reloc=2

_divide_signed:	
    clrf TRISB
    clrf TRISC
    clrf 0x010 ;0x010 : quotient
    movff 0x001,0x012 ;0x012:divisor
    movff WREG,0x011 ;0x011:dividend
    btfsc 0x011,7 ;skip if 0
    bsf TRISB,7
    movff 0x011,WREG
    xorwf 0x012,0
    btfsc WREG,7;skip if 0
    bsf TRISC,7 ;keep sign value
    btfsc 0x011,7 ;skip if 0    
    rcall complement1
    btfsc 0x012,7 ;skip if 0
    rcall complement2
    goto check
    
complement1:
    comf 0x011,1
    movlw 1
    addwf 0x011,1
    return
    
complement2:
    comf 0x012,1
    movlw 1
    addwf 0x012,1
    return
    
complement3:
    comf 0x010,1
    movlw 1
    addwf 0x010,1
    return
    
complement4:
    comf 0x011,1
    movlw 1
    addwf 0x011,1
    return
    
check:
    movff 0x011,WREG
    cpfsgt 0x012 ;if divisor > dividend, skip
    goto loop
    goto finish
    
loop:
    movff 0x011,WREG
    cpfsgt 0x012 ;divisor > remainder:skip
    incf 0x010,1
    movff 0x012,WREG
    subwf 0x011,1 ;f-w
    movff 0x011,WREG
    cpfsgt 0x012 ;divisor > remainder:skip
    goto loop
    goto finish
    
finish:  ;check sign
    btfsc TRISC,7 ;skip if 0
    rcall complement3
    btfsc TRISB,7 ;skip if 0
    rcall complement4
    movff 0x010,0x002
    movff 0x011,0x001
    movlw 0x04
    
shift_left:
    bcf STATUS,0
    rlcf 0x001
    decfsz WREG
    goto shift_left
    
    movlw 0x04
    
shift_right:    
    bcf STATUS,0
    rrcf 0x001
    decfsz WREG
    goto shift_right
    
    return