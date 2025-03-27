// 0839pm fri21mar2025
// Pull-up button by Emmanuel Eni
// 1st-year electrical engineering student at HAN University.
// This is the first part of my attempt in creating binary counter with user input in the form of push buttons for pause-play and stop-reset actions. My plan is to adopt a modular or unit testing approach. Consequently, I wish to write the code for push button implementation in isolation of other functionality to ensure it works properly. I will do the same for other units or modules or functionalites of the Binary Counter program. If every module works well in isolation or independently, then I will integrate them together and test that they work well together. So, let the "show" begin! :)

#define F_CPU 8000000UL    // I'm using the ATmega328P without an external crystal oscillator.

// 0102pm sat22mar2025: I just realized that it's better I start with testing the output first before the input for at least two reasons. Firstly, I will need the output to test the input. Secondly, the code for the output is more straightforward than the code for the input. Consequently, I will pause here, and go and write the logic for the basic output test with LEDs and then come back to write the input logic for a pull-up push-button setup.

// 0153pm sat22mar2025: LED-output unit program worked. Now I will go ahead with this pull-up push-button program. I will start by writing the output logic first and then writing the input logic next.

#define LED_PINS 0xFF
#define OFF_LED 0
#define ON_LED 0xFF
#define PAUSE_PLAY_BUTTON PD2
#define RESET_START_BUTTON PD3

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  // initializations
  DDRD &= ~(1 << PAUSE_PLAY_BUTTON);   // set as input
  DDRD &= ~(1 << RESET_START_BUTTON);
  PORTD |= (1 << PAUSE_PLAY_BUTTON);   // setup pull-up resistor
  PORTD |= (1 << RESET_START_BUTTON);
  DDRB = LED_PINS;

  // event loop
  int reset_start_button_is_high;
  int pause_play_button_is_high;
  while (1) {
    pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    //if (!pause_play_button_is_high) {
    while (pause_play_button_is_high) {
      PORTB = ON_LED;
      pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    }
    //PORTB = OFF_LED;
    PORTB = (1 << PB2);
    //PORTB = ON_LED;
  }
  return 0;
}
