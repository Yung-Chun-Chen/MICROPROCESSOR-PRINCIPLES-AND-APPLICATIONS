#include "p18f4520.inc"

    CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
    CONFIG  LVP = OFF
    
    org 0x00
    nop
    goto initi
  
ISR:
    org 0x08
    rlcf LATD  
    bcf PIR1,INT0IF
    retfie    
initi:
    movlw B'00000000'
    movwf TRISD
    movlw B'00000001'
    movwf LATD    
    
    movlw B'00101100'
    movwf OSCCON
    bsf RCON,IPEN
    bsf INTCON,GIE
    bsf PIE1,TMR2IE
    movlw d'244'
    movwf PR2
    movlw b'01111111'
    movwf T2CON
main:
    btfss LATD,4
    goto main
    goto rl4
rl4:
    rlcf LATD
    rlcf LATD
    rlcf LATD
    rlcf LATD    
    goto main
end


