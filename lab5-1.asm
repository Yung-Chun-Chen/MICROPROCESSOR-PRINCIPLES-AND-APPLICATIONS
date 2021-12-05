#include "xc.inc"
GLOBAL _divide
    
PSECT mytext, local, class=CODE, reloc=2
 
_divide:
    movff 0x001,PRODL ;PRODL:remainder
    bcf STATUS,0
    btfsc PRODL,7 ;if PRODL's bit7==0,skip
    bsf PRODH,0
    rlcf PROD
    movff 0x003,LATD ;LATD:divisor
    movlw 0x08 ;counter
    movwf 0x000
    
loop:
    movff LATD,WREG
    subwf PRODH,1 ;PRODH = PRODH-WREG
    btfsc PRODH,7 ;if PRODH's bit7==0,skip
    goto remainder_is_neg
    rlcf PRODH
    bsf STATUS,0
    rlcf PRODL ;remainder shift left
    decfsz 0x000,1
    goto loop
    goto finish
remainder_is_neg:
    movff PRODH,WREG
    addwf LATD,W
    movff WREG,PRODH
    rlcf PRODH
    bcf STATUS,0
    rlcf PRODL
    decfsz 0x000,1
    goto loop
    goto finish
finish:
    bcf STATUS,0
    rrcf PRODH
    movff PRODL,0x002
    movff PRODH,0x001
    return
