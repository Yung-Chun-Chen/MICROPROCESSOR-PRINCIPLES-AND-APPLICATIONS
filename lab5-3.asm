#include "xc.inc"
GLOBAL _mysqrt
    
PSECT mytext, local, class=CODE, reloc=2

_mysqrt:
    incf 0x010,1
    movff 0x002,LATC ;high value
    movff 0x001,LATD ;low value
    movff 0x010,WREG
    mulwf 0x010 ;0x010*0x010
    movlw 0
    cpfseq LATC ;if high=0, skip
    goto check_high

check_low:
    movff LATD,WREG ;value
    cpfsgt PRODL ;PROD > value,skip
    goto _mysqrt
    goto finish
    
check_high:
    movff LATC,WREG ;value
    cpfseq PRODH ;PRODH = value,skip
    goto _mysqrt
    goto check_low
    
finish:
    movlw 1
    subwf 0x010,1
    movff 0x010,WREG
    return


