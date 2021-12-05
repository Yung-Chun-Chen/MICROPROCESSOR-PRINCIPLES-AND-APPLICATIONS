; PIC18F4520 Configuration Bit Settings

; Assembly source line config statements

#include "p18f4520.inc"

CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LVP = OFF

  DELAY macro int_i,int_j
    movlw int_i
    movwf 0x010  
    local outerloop
    local innerloop
    outerloop:
	movlw int_j
	movwf 0x011
	innerloop:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	decfsz 0x011
	bra innerloop
    decfsz 0x010
    bra outerloop
  endm
  
  CNTVAL equ d'255'
  
org 0x00
nop
goto initial
  
ISR:
    org 0x08
    btg 0x000,0
    bcf INTCON,INT0IF ; (must be cleared in software) 
    retfie
initial:
    bsf TRISB,0
    clrf 0x000
    bsf 0x000,0
    clrf TRISD
    clrf LATD
    clrf WREG
    movlw B'00000000'
    movwf TRISD
    movlw B'00000001'
    movwf LATD    
    
    bsf RCON,IPEN ;Enable priority levels on interrupts
    movlw B'11010000'
    movwf INTCON
    movlw B'01110001'
    movwf INTCON2 
main:
    btfss 0x000,0
    goto opposite
    rlncf LATD
    btfss LATD,4
    goto conti
    rlncf LATD
    rlncf LATD
    rlncf LATD
    rlncf LATD
    goto conti
opposite:
    rrncf LATD
    btfss LATD,7
    goto conti
    rrncf LATD
    rrncf LATD
    rrncf LATD
    rrncf LATD
conti:
    DELAY D'400',D'180'
    goto main    
end


