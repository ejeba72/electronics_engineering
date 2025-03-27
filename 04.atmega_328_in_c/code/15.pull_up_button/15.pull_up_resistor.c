// 614pm wed26feb2025
// Using a button as a switch and activating its pin internal pull-up resistor
// Note: statements that begin with a # are translator or compiler directives
// If you're having issues with setting up reg D, then use reg B in your second attempt

#define F_CPU 16000000UL
#define BUTTON 0x02
#define FIRST_LED 0x03
#define FOUR_LEDS_IN_A_ROW 0x0F
#define DDRD_MASK 0x03
#define PORTD_MASK 0x07
#define BUTTON_MASK 0x04

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  DDRD = (DDRD & DDRD_MASK) | (FOUR_LEDS_IN_A_ROW << FIRST_LED);
  PORTD |= (PORTD & BUTTON_MASK);    // Pull-up resistor for Button pin
  while (1) {
    //PORTD = (PORTD & PORTD_MASK) | (PORTD ^ (FOUR_LEDS_IN_A_ROW << FIRST_LED));    // Toggle leds while preserving bits 1,2,3
    int button_pressed = !(PIND & BUTTON_MASK);    // ! operation because of the pull-up resistor
    if (button_pressed) {
      PORTD ^= (FOUR_LEDS_IN_A_ROW << FIRST_LED);
      _delay_ms(70);
    } else {
      PORTD &= ~(FOUR_LEDS_IN_A_ROW << FIRST_LED);
    }
  }
  return 0;
}
