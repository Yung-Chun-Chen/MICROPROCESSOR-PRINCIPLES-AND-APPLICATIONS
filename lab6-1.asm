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
    ;clrf PORTA
    BSF TRISA,4 ;RA4 set input
    clrf LATD
    clrf TRISD ;RD0-RD3 set output
    
	
    lightup:
    movlw B'00000101'
    movwf LATD
    DELAY d'100',d'80' ;0.25s
    btfsc PORTA,4
    BRA lightup ;unconditional branch
    BRA lightup2
    
    lightup2:
    movlw B'00001010'
    movwf LATD
    DELAY d'100',d'80' ;0.25s
    btfsc PORTA,4
    BRA lightup2 ;unconditional branch
    BRA lightup
    
    end

