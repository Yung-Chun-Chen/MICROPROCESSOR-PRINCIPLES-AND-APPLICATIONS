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
    LATD = ADRESH * 4 + ADRESL / 64;    
    PIR1bits.ADIF = 0;
    ADCON0bits.GODONE = 1;
    return;
}
/*
void adc_init(){
    ADCON0bits.ADON = 1; //for ADON AN0
    ADCON1bits.PCFG = 1110; // A for AN0
    ADCON2bits.ADFM = 1;
    ADCON2bits.ACQT = 010;
    ADCON2bits.ADCS = 001;
    // right , 4tad , fosc/8
    
    //PIR1bits.ADIF = 0;
    //PIE1bits.ADIE = 1;
    //IPR1bits.ADIP = 1;
    return;
}

void ccp2_init(){
    //enable PIR
    //PIR2bits.CCP2IF = 0;
    //PIE2bits.CCP2IE = 1;
    //IPR2bits.CCP2IP = 1;
    
    //special event trigger
    CCP2CONbits.CCP2M3 = 1;
    CCP2CONbits.CCP2M2 = 0;
    CCP2CONbits.CCP2M1 = 1;
    CCP2CONbits.CCP2M0 = 1;
    
    CCPR2H = 1000 / 256;
    CCPR2L = 1000 % 256;
    return;
}

void timer3_init(){
    // 16bis
    T3CONbits.RD16 = 1;
    //tmr 3
    T3CONbits.T3CCP2 = 0;
    T3CONbits.T3CCP1 = 1;
    // pre 8
    T3CONbits.T3CKPS1 = 1;
    T3CONbits.T3CKPS0 = 1;
    
    T3CONbits.TMR3ON = 1;
    return;
}
*/
void main(void) {
    
    RCONbits.IPEN = 1;
    INTCONbits.GIE = 1;
    
    //for analog input
    TRISAbits.RA0 = 1;
    
    // for output
    TRISDbits.RD0 = 0;
    TRISDbits.RD1 = 0;
    TRISDbits.RD2 = 0;
    TRISDbits.RD3 = 0;
    
    // osc 8M hz
    OSCCONbits.IRCF2 = 1;
    OSCCONbits.IRCF1 = 1;
    OSCCONbits.IRCF0 = 0;
    
    ADCON0bits.ADON = 1; //on ADC module
    ADCON0bits.CHS = 0b0000; //AN0 for analog input
    ADCON1bits.PCFG = 0b1110; // Analog for AN0, other digital
    ADCON1bits.VCFG = 0b00; //reference voltage
    ADCON2bits.ADFM = 1; //rights justified(10 bits resolution))
    ADCON2bits.ACQT = 0b010; //4 TAD, 4*0.7 = 2.8?? > 2.4??
    ADCON2bits.ADCS = 0b001; //FOSC / 8, 1/11430000*8 ~= 0.7??
    // right , 4tad , fosc/8
    
    //for ADC interrupt
    PIR1bits.ADIF = 0;
    PIE1bits.ADIE = 1;
    IPR1bits.ADIP = 1;
    
    ADCON0bits.GO = 1; //start conversion
    
    while(1){        
        //while(ADCON0bits.DONE);
        LATD = ADRESH * 4 + ADRESL / 64; //ADRESH,ADRESL : store converted value
        //ADRESH : 000000++ ADRESL :  ++xxxxxx  , 1024/16=64(?64????)
    }
    return;
}