;LIST p = 18f4520
;#include<p18f4520.inc>
;    CONFIG OSC = INTIO67
;    CONFIG WDT = OFF
;    org 0x00
;
;start:
;    movlw 6
;    movff WREG,0x012 ;0x012 : need to count F6
;    movlw 0
;    movff WREG,0x010 ;last last term
;    movlw 1
;    movff WREG,0x011 ;last term
;    movlw 2
;    subwf 0x012,0 ;0x012-WREG
;    bn F0F1
;    rcall Fib
;    movff 0x011,0x000 ;d'26'
;    rcall finish
;Fib:
;    movlw 2
;    cpfslt 0x012 ;skip if 0x012 < 2
;    rcall L1
;    return
;L1:
;    movff 0x010,WREG
;    addwf 0x011,0
;    movff 0x011,0x010;last last term
;    movff WREG,0x011;last term
;    movlw D'14'
;    dcfsnz 0x012,1
;    movwf PCL
;    rcall Fib
;    return
;F0F1:
;    movlw 1
;    movff WREG,TRISC
;    clrf 0x000
;    movlw 0
;    cpfseq 0x012 ;if 0x012=0,skip
;    movff TRISC,0x000
;finish:
;    end
;    
LIST p = 18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00

start:
    movlw 6                                           ;0
    movff WREG,0x012 ;0x012 : need to count F6         2
    movlw 0                                           ;6
    movff WREG,0x010 ;last last term                   8
    movlw 1                                           ;12
    movff WREG,0x011 ;last term                        14
    rcall Fib                                            ;18
    movff 0x011,0x000                                ; 20
    rcall finish                                        ;24
Fib:
    movff 0x010,WREG                                ;addr=D'26'
    addwf 0x011,0
    movff 0x011,0x010;last last term
    movff WREG,0x011;last term
    movlw 1
    subwf 0x012,1
    cpfsgt 0x012 ;skip if 0x012 > 1
    return
    movlw D'26'
    movwf PCL
;F0F1:
;    movlw 1
;    movff WREG,TRISC
;    clrf 0x000
;    movlw 0
;    cpfseq 0x012 ;if 0x012=0,skip
;    movff TRISC,0x000
finish:
    end