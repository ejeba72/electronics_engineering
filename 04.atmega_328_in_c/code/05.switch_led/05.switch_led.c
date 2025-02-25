// 713pm mon17feb2025
// Switch on & off LEDs using buttons.

#include<avr/io.h>
#include<util/delay.h>

#define orangeLed 2
#define redLed 3
#define rgbRed 4
#define rgbGreen 5
#define rgbBlue 6
#define button1 7
#define button2 0

int readButton() {
}

int main(void) {
  DDRD |= (31 << 2);    // set DDRD reg, bit2 to bit6 (set Arduino pin2 to pin6 as output)
  DDRD &= ~(1 << button1);    // clear DDRD reg, bit7 (set Arduino pin7 as input)
  DDRB &= ~(1 << button2);    // Clear DDRB reg, bit0 (set Arduino pin8 as input)
  PORTD |= (1 << button1);    // set the pull-up resistor for Arduino pin7
  PORTB |= (1 << button2);    // set the pull-up resistor for Arduino pin8

  while(1) {
    if (!(PIND & (1 << button1))) {
      PORTD ^= (1 << redLed);   // toggles the state of red LED
      _delay_ms(50);    // delay to stabilize button press
    }
  }
  

  /*DDRD |= (63 << 2); // set bit2 to bit6 as output and bit7 as input
  while (1) {
    //PORTD |= (1<<orangeLed);
    PORTD ^= (63 << 2);
    _delay_ms(300);
  }*/
}
