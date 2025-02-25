// 1058pm sun23feb2025
// More AVR Practice

#define F_CPU 16000000UL
//#define mmcu atmega328p

#include<avr/io.h>
#include<util/delay.h>

const int BUTTON = (0x01 << 6);   // PD6
const int LEDS = (0x0F << 2);    // PD2 to PD5 (Four LEDs)
const int TX_RX_PINS = 0x03;
const int PD6_PULL_UP_RESISTOR = (0x01 << 6);

/*
void signify_program_start(void) {
  // This loop is just to signify the start of the program.
  int i = 0;
  while (i < 2) {
    PORTD = (PORTD & TX_RX_PINS) | LEDS;    // set LEDs
    _delay_ms(900);
    PORTD = (PORTD & TX_RX_PINS) & ~LEDS;   // clear LEDs
    _delay_ms(100);
    i++;
  }
  //PORTD = (PORTD & TX_RX_PINS) & ~LEDS;   // clear LEDs (Could be redundant code line).
  _delay_ms(900);
}
*/

void main(void) {
  //signify_program_start();
  // This loop is just to signify the start of the program.
  int i = 0;
  while (i < 2) {
    PORTD = (PORTD & TX_RX_PINS) | LEDS;    // set LEDs
    _delay_ms(900);
    PORTD = (PORTD & TX_RX_PINS) & ~LEDS;   // clear LEDs
    _delay_ms(100);
    i++;
  }
  //PORTD = (PORTD & TX_RX_PINS) & ~LEDS;   // clear LEDs (Could be redundant code line).
  _delay_ms(900);


  DDRD = (DDRD & TX_RX_PINS) | LEDS;   // set the LED pins as output, button pin as input. Don't touch Tx and Rx pins.
  PORTD |= PD6_PULL_UP_RESISTOR;   // set the pull-resistor for PD6
  // This loop is the main loop
  while(1) {
    int switch_pressed = !(PIND & BUTTON);    // Because of pull-resistor BUTTON == 0 when button is pressed.
    if (switch_pressed) {
      PORTD = (PORTD & TX_RX_PINS & PD6_PULL_UP_RESISTOR) | LEDS;
    } else {
      PORTD = (PORTD & TX_RX_PINS & PD6_PULL_UP_RESISTOR) & ~LEDS;
    }
  }
}
