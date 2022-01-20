/*
 * File:   lab9-1.c
 * Author: user
 *
 * Created on 2021?12?6?, ?? 7:26
 */


//#include <xc.h>
//#include <pic18f4520.h>
//
//#pragma config OSC = INTIO67    // Oscillator Selection bits
//#pragma config WDT = OFF        // Watchdog Timer Enable bit 
//#pragma config PWRT = OFF       // Power-up Enable bit
//#pragma config BOREN = ON       // Brown-out Reset Enable bit
//#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
//#pragma config LVP = OFF        // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
//#pragma config CPD = OFF        // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)
//
//void main(void)
//{
//    // Timer2 -> On, prescaler -> 4
//    T2CONbits.TMR2ON = 0b1;
//    T2CONbits.T2CKPS = 0b01;
//
//    // Internal Oscillator Frequency, Fosc = 125 kHz, Tosc = 8 탎
//    OSCCONbits.IRCF = 0b001;
//    
//    // PWM mode, P1A, P1C active-high; P1B, P1D active-high
//    CCP1CONbits.CCP1M = 0b1100;
//    
//    // CCP1/RC2 -> Output
//    TRISC = 0;
//    LATC = 0;
//    
//    // Set up PR2, CCP to decide PWM period and Duty Cycle
//    /** 
//     * PWM period
//     * = (PR2 + 1) * 4 * Tosc * (TMR2 prescaler)
//     * = (0x9b + 1) * 4 * 8탎 * 4
//     * = 0.019968s ~= 20ms
//     */
//    PR2 = 0x9b;
//    
//    /**
//     * Duty cycle
//     * = (CCPR1L:CCP1CON<5:4>) * Tosc * (TMR2 prescaler)
//     * = (0x0b*4 + 0b01) * 8탎 * 4
//     * = 0.00144s ~= 1450탎
//     */
//    CCPR1L = 0x0b;
//    CCP1CONbits.DC1B = 0b01;
//    
//    while(1);
//    return;
//}



#include <xc.h>
#include <pic18f4520.h>

#pragma config OSC = INTIO67    // Oscillator Selection bits
#pragma config WDT = OFF        // Watchdog Timer Enable bit 
#pragma config PWRT = OFF       // Power-up Enable bit
#pragma config BOREN = ON       // Brown-out Reset Enable bit
#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
#pragma config LVP = OFF        // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
#pragma config CPD = OFF        // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)


void __interrupt() Rotate(void)             // High priority interrupt
{
    while(1){
    // 16*32=512 76*32=2432 76=19*4
    CCPR1L = 0x04;
    CCP1CONbits.DC1B = 0b00;
    for(int i = 0; i < 17; i++){
        for(int j = 0; j < 4; j++){
            CCP1CONbits.DC1B++;
            for(int k = 0; k < 10; k++);
        }
        CCPR1L++;
        CCP1CONbits.DC1B = 0b00;
    }        
    for(int i = 0; i < 50; i++){
        CCPR1L = 0x04;
        CCP1CONbits.DC1B = 0b00;
    }
}
    INTCONbits.INT0IF = 0;
}
void main(void)
{
    // Timer2 -> On, prescaler -> 4
    T2CONbits.TMR2ON = 0b1;
    T2CONbits.T2CKPS = 0b01;

    // Internal Oscillator Frequency, Fosc = 125 kHz, Tosc = 8 탎
    OSCCONbits.IRCF = 0b001;
    
    // PWM mode, P1A, P1C active-high; P1B, P1D active-high
    CCP1CONbits.CCP1M = 0b1100;
    
    // CCP1/RC2 -> Output
    TRISC = 0;
    LATC = 0;
    
    // Set up PR2, CCP to decide PWM period and Duty Cycle
    /** 
     * PWM period
     * = (PR2 + 1) * 4 * Tosc * (TMR2 prescaler)
     * = (0x9b + 1) * 4 * 8탎 * 4
     * = 0.019968s ~= 20ms
     */
    PR2 = 0x9b;
     RCONbits.IPEN = 1;
    INTCON = 0b11010000;
    INTCON2 = 0b01110001;
    /**
     * Duty cycle
     * = (CCPR1L:CCP1CON<5:4>) * Tosc * (TMR2 prescaler)
     * = (0x0b*4 + 0b01) * 8탎 * 4
     * = 0.00144s ~= 1450탎
     */
//    CCPR1L = 0x0b;
//    CCP1CONbits.DC1B = 0b01;
    
    CCPR1L = 0x04;
    CCP1CONbits.DC1B = 0b00;
    
    while(1);
    return;
}





//#include <xc.h>
//#include <pic18f4520.h>
//
//#pragma config OSC = INTIO67    // Oscillator Selection bits
//#pragma config WDT = OFF        // Watchdog Timer Enable bit 
//#pragma config PWRT = OFF       // Power-up Enable bit
//#pragma config BOREN = ON       // Brown-out Reset Enable bit
//#pragma config PBADEN = OFF     // Watchdog Timer Enable bit 
//#pragma config LVP = OFF        // Low Voltage (single -supply) In-Circute Serial Pragramming Enable bit
//#pragma config CPD = OFF        // Data EEPROM?Memory Code Protection bit (Data EEPROM code protection off)
//
//
//void __interrupt() Rotate(void)             // High priority interrupt
//{
//
//    // 16*32=512 76*32=2432 76=19*4
//    CCPR1L = 0x04;
//    CCP1CONbits.DC1B = 0b00;
//    for(int i = 0; i < 17; i++){
//        for(int j = 0; j < 4; j++){
//            CCP1CONbits.DC1B++;
//            for(int k = 0; k < 10; k++);
//        }
//        CCPR1L++;
//        CCP1CONbits.DC1B = 0b00;
//    }        
//    for(int i = 0; i < 50; i++){
//        CCPR1L = 0x04;
//        CCP1CONbits.DC1B = 0b00;
//    }
//    INTCONbits.INT0IF = 0;
//}
//void main(void)
//{
//    // Timer2 -> On, prescaler -> 4
//    T2CONbits.TMR2ON = 0b1;
//    T2CONbits.T2CKPS = 0b01;
//
//    // Internal Oscillator Frequency, Fosc = 125 kHz, Tosc = 8 탎
//    OSCCONbits.IRCF = 0b001;
//    
//    // PWM mode, P1A, P1C active-high; P1B, P1D active-high
//    CCP1CONbits.CCP1M = 0b1100;
//    
//    // CCP1/RC2 -> Output
//    TRISC = 0;
//    LATC = 0;
//    
//    // Set up PR2, CCP to decide PWM period and Duty Cycle
//    /** 
//     * PWM period
//     * = (PR2 + 1) * 4 * Tosc * (TMR2 prescaler)
//     * = (0x9b + 1) * 4 * 8탎 * 4
//     * = 0.019968s ~= 20ms
//     */
//    PR2 = 0x9b;
//     RCONbits.IPEN = 1;
//    INTCON = 0b11010000;
//    INTCON2 = 0b01110001;
//    /**
//     * Duty cycle
//     * = (CCPR1L:CCP1CON<5:4>) * Tosc * (TMR2 prescaler)
//     * = (0x0b*4 + 0b01) * 8탎 * 4
//     * = 0.00144s ~= 1450탎
//     */
////    CCPR1L = 0x0b;
////    CCP1CONbits.DC1B = 0b01;
//    
//    CCPR1L = 0x04;
//    CCP1CONbits.DC1B = 0b00;
//    
//    while(1);
//    return;
//}