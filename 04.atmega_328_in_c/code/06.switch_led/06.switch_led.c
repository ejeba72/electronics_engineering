// 335pm fri21feb2025
// Switching LEDs using a button

#include <avr/io.h>
#include <util/delay.h>

#define LED_PINS 31     // that is, 11 111 in binary.
#define ORANGE_LED 2
#define RED_LED 3
#define RGB_RED 4
#define RGB_GREEN 5
#define RGB_BLUE 6
#define BUTTON1 7
#define BUTTON2 0

int main() {
  DDRD |= (LED_PINS << 2);    // set pins 2 to 6 on reg D as output for the LEDs
  DDRD &= ~(1 << BUTTON1);    // clear pin 7 on reg D as input for button 1
  DDRB &= ~(1 << BUTTON2);    // clear pin 0 on reg B as input for button 2
  DDRD |= (1 << BUTTON1);   // activate the pull-up resistor for button 1 pin
  DDRB |= (1 << BUTTON2);   // activate the pull-up resistor for button 2 pin
  int button1_pressed = DDRD & ~(1 << BUTTON1);
  int button2_pressed = DDRB & ~(1 << BUTTON2);
  while (1) {
    DDRD |= (1 << RED_LED);
    /*
    if (button1_pressed) {
      DDRD |= (1 << RED_LED);
    } else {
      DDRD &= ~(1 << RED_LED);
    }
    */
  }
}
