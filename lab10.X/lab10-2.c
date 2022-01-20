#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67 // Oscillator Selection bits
#pragma config WDT = OFF     // Watchdog Timer Enable bit 
#pragma config PWRT = OFF    // Power-up Enable bit
#pragma config BOREN = ON   // Brown-out Reset Enable bit
#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
#pragma config LVP = OFF     // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF 

void __interrupt(high_priority) Hi_ISR(void){    
    //while(ADCON0bits.DONE);
    if((ADRESH * 256 + ADRESL) <102)LATD = 0b00000001;
     else if((ADRESH * 256 + ADRESL) >=102 && (ADRESH * 256 + ADRESL) < 102*2)LATD = 0b00001000;
     else if((ADRESH * 256 + ADRESL) >=102*2 && (ADRESH * 256 + ADRESL) <102*3)LATD = 0b00000100;
      else if((ADRESH * 256 + ADRESL) >=102*3 && (ADRESH * 256 + ADRESL) <102*4)LATD = 0b00000010;
      else if((ADRESH * 256 + ADRESL) >=102*4 && (ADRESH * 256 + ADRESL) <102*5)LATD = 0b00000001;
       else if((ADRESH * 256 + ADRESL) >=102*5 && (ADRESH * 256 + ADRESL) <102*6)LATD = 0b00000010;
       else if((ADRESH * 256 + ADRESL) >=102*6 && (ADRESH * 256 + ADRESL) <102*7)LATD = 0b00000001;
        else if((ADRESH * 256 + ADRESL) >=102*7 && (ADRESH * 256 + ADRESL) <102*8)LATD = 0b00000100;
        else if((ADRESH * 256 + ADRESL) >=102*8 && (ADRESH * 256 + ADRESL) <102*9)LATD = 0b00000001;
        else{
            LATD = 0b00000010;
        }
    PIR1bits.ADIF = 0;
    ADCON0bits.GODONE = 1;
    return;
}

void main(void) {
    
    RCONbits.IPEN = 1;
    INTCONbits.GIE = 1;
    
    //for input
    TRISAbits.RA0 = 1;
    
    // for output
    TRISDbits.RD0 = 0;
    TRISDbits.RD1 = 0;
    TRISDbits.RD2 = 0;
    TRISDbits.RD3 = 0;
    
    // 8M hz
    OSCCONbits.IRCF2 = 1;
    OSCCONbits.IRCF1 = 1;
    OSCCONbits.IRCF0 = 0;
    
    ADCON0bits.ADON = 1; //for ADON AN0
    ADCON0bits.CHS = 0b0000;
    ADCON1bits.PCFG = 0b1110; // A for AN0
    ADCON1bits.VCFG = 0b00;
    ADCON2bits.ADFM = 1; //right justified(10 bits)
    ADCON2bits.ACQT = 0b010;
    ADCON2bits.ADCS = 0b001;
    // right , 4tad , fosc/8
    
    PIR1bits.ADIF = 0;
    PIE1bits.ADIE = 1;
    IPR1bits.ADIP = 1; 
      
    ADCON0bits.GO = 1;
    
    //TRISC= 25;
   // LATD=0;
    while(1){        //1432121312
        //while(ADCON0bits.DONE);
       
        //1024/10??? = 102.4 ~= 102
      if((ADRESH * 256 + ADRESL) <102)LATD = 0b00000001;
     else if((ADRESH * 256 + ADRESL) >=102 && (ADRESH * 256 + ADRESL) < 102*2)LATD = 0b00001000;
     else if((ADRESH * 256 + ADRESL) >=102*2 && (ADRESH * 256 + ADRESL) <102*3)LATD = 0b00000100;
      else if((ADRESH * 256 + ADRESL) >=102*3 && (ADRESH * 256 + ADRESL) <102*4)LATD = 0b00000010;
      else if((ADRESH * 256 + ADRESL) >=102*4 && (ADRESH * 256 + ADRESL) <102*5)LATD = 0b00000001;
       else if((ADRESH * 256 + ADRESL) >=102*5 && (ADRESH * 256 + ADRESL) <102*6)LATD = 0b00000010;
       else if((ADRESH * 256 + ADRESL) >=102*6 && (ADRESH * 256 + ADRESL) <102*7)LATD = 0b00000001;
        else if((ADRESH * 256 + ADRESL) >=102*7 && (ADRESH * 256 + ADRESL) <102*8)LATD = 0b00000100;
        else if((ADRESH * 256 + ADRESL) >=102*8 && (ADRESH * 256 + ADRESL) <102*9)LATD = 0b00000001;
        else{
            LATD = 0b00000010;
        }
      return;
    }
}