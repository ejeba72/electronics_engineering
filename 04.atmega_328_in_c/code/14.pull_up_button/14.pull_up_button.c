// 853pm tue25feb2025
// Using a button as a switch and activating its pin internal pull-up resistor
// Note: statements that begin with a # are translator or compiler directives

#define F_CPU 16000000UL
#define BUTTON 0x01
#define FIRST_LED 0x01
#define FOUR_LEDS_IN_A_ROW 0x0F
#define DATA_DIRECTION 0x1E
#define BUTTON_MASK 0x01

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  DDRB = DATA_DIRECTION;
  PORTB = BUTTON_MASK;    // Pull-up resistor for Button pin
  while (1) {
    int button_pressed = !(PINB & BUTTON_MASK);    // ! operation because of the pull-up resistor
    if (button_pressed) {
      PORTB ^= (FOUR_LEDS_IN_A_ROW << FIRST_LED);
      _delay_ms(70);
    } else {
      PORTB &= ~(FOUR_LEDS_IN_A_ROW << FIRST_LED);
    }
  }
  return 0;
}
