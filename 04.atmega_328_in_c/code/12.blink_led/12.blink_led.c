// 9am mon24feb2025
// Blink LEDs

#define F_CPU 16000000UL

#include<avr/io.h>
#include<util/delay.h>

void main(void) {
  //DDRB |= PB0;    // failed
  DDRB = 0x01;    // passed
  while (1) {
    //PORTB |= PB0;   // failed
    //PORTB = 0x01;   // passed
    //PB0 = 1;    // failed
    //_delay_ms(100);
    //PORTB &= ~PB0;    // failed
    //PORTB = 0x00;   // passed
    //PB0 = 0;    // failed
    //_delay_ms(100);
    PORTB ^= 0x01;
    _delay_ms(600);
  }
}
