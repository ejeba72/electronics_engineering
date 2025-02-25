// 1254am mon24feb2025
// Pull up button

#define F_CPU 16000000UL
#define BUTTON 0x02
#define LED 0x01

#include<avr/io.h>
#include<util/delay.h>

void main(void) {
  DDRB = LED;

  int i = 0;
  while (i<2) {
    PORTB |= LED;
    _delay_ms(900);
    PORTB &= ~LED;
    _delay_ms(100);
    i++;
  }

  PORTB |= BUTTON;    // set pull-up resistor

  while (1) {
  int button_pressed = ~PINB & BUTTON;
    if (button_pressed) {
      PORTB |= LED;
    } else {
      PORTB &= ~LED;
    }
  }
}
