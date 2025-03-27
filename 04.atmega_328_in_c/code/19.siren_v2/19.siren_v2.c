// 1201pm sun2mar2025
// Siren Logic Version 2

#define F_CPU 8000000UL
#define LED_PATTERN1 0xAA
#define LED_PATTERN2 0x55
#define LED_PATTERN_BITMASK 0xFF
#define DURATION 30

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  // init
  DDRB = 0xFF;
  PORTB = 0xAA;
  //_delay_ms(1000);
  // event loop
  while (1) {
    /*PORTB = LED_PATTERN1;
    _delay_ms(DURATION);
    PORTB = LED_PATTERN2;
    _delay_ms(DURATION);*/
    /*PORTB ^= PORTB;
    _delay_ms(DURATION);*/
    /*PORTB ^= LED_PATTERN_BITMASK;
    _delay_ms(DURATION);*/
    PORTB = ~PORTB;
    _delay_ms(DURATION);
  }
  return 0;
}
