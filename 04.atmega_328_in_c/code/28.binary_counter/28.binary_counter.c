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

/*int binary_counter(int input_val) {
  
}*/

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
  int pause_play_trigger = 0;
  int pause_play_state = 0;
  int current_value = 0;
  while (1) {
    pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    while (!pause_play_button_is_high) {
      pause_play_trigger = 1;
      pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    }
    if (pause_play_trigger) {
      pause_play_state += pause_play_trigger;
      pause_play_trigger = 0;  // reset pause_play_trigger
      if (pause_play_state > 1) {
        pause_play_state = 0;  // reset pause_play_state
      }
    }
    while (pause_play_state) {
      PORTB = current_value;
      pause_play_state = PIND & (1 << PAUSE_PLAY_BUTTON);
    }

    //PORTB = (1 << PB2);
    //_delay_ms(70);
    while (pause_play_button_is_high) {
      PORTB = current_value;
      _delay_ms(70);
      current_value++;  // It automatically resets because in binary 0xff + 0x01 = 0x00. So no need for a reset code.
      pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    }
    //PORTB = ON_LED;
    //_delay_ms(70);
  }
  return 0;
}
