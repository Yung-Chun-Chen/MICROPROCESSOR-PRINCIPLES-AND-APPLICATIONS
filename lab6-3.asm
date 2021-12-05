#include "p18f4520.inc"

  CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  PBADEN = OFF           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LVP = OFF  ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  
  L1  EQU 0X14
  L2  EQU 0X15
  org 0x00

initial:
    DELAY macro num1,num2
	local LOOP1
	local LOOP2
	movlw num2
	movwf L2
	LOOP2:
	    movlw num1
	    movwf L1
	LOOP1:
	    NOP
	    NOP
	    NOP
	    NOP
	    NOP
	    DECFSZ L1,1
	    BRA LOOP1
	    DECFSZ L2,1
	    BRA LOOP2
	endm
    
start:
init:
    movlw 0x0f ;configure A/D
    movwf ADCON1 ;set digital i/o
   ; clrf PORTA
    BSF TRISA,4 ;RA4 set input
    clrf LATD
    clrf TRISD ;RD0-RD3 set output
    ;movlw B'10000000'
    ;movwf 0x001
    ;movlw 0x04;0x05
    ;movwf 0x002 ;counter
    
dark:
    clrf LATD
    DELAY d'100',d'80' ;0.125s
    btfsc PORTA,4
    goto dark
    goto init_state1

init_state1:
    movlw B'10000000'
    movwf 0x001
    goto state1
state1:
    rlncf 0x001
    btfsc 0x001,4 ;if 0x001 no.4 bit=0,skip
    bsf 0x001,0
    bcf 0x001,4
    movff 0x001,WREG
    movwf LATD
    DELAY d'400',d'180' ;0.5s
    btfsc PORTA,4
    goto state1
    goto init_state2
    
init_state2:
    movlw B'10000001'
    movwf 0x001
    goto state2
state2:
    rlncf 0x001
    btfsc 0x001,4 ;if 0x001 no.4 bit=0,skip
    bsf 0x001,0
    bcf 0x001,4
    movff 0x001,WREG
    movwf LATD
    DELAY d'400',d'180' ;0.5s
    btfsc PORTA,4
    goto state2
    goto init_state3

init_state3:
    movlw B'10000011'
    movwf 0x001
    goto state3
state3:
    rlncf 0x001
    btfsc 0x001,4 ;if 0x001 no.4 bit=0,skip
    bsf 0x001,0
    bcf 0x001,4
    movff 0x001,WREG
    movwf LATD
    DELAY d'400',d'180' ;0.5s
    btfsc PORTA,4
    goto state3
    goto dark
    
    end


