// 0839pm fri21mar2025
// Binary counter by Emmanuel Eni
// 1st-year electrical engineering student at HAN University.
// MCU Assignment: 8-bit binary counter with pause-play and reset-start button

#define F_CPU 8000000UL    // I'm using the ATmega328P without an external crystal oscillator.

#include<avr/io.h>
#include<util/delay.h>

#define LED_PINS 0xFF
#define OFF_LED 0
#define ON_LED 0xFF
#define PAUSE_PLAY_BUTTON PD2
#define RESET_START_BUTTON PD3

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
  int reset_trigger = 0;
  int pause_trigger = 1;
  int current_value = 0;

  while (1) {
    pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    reset_start_button_is_high = PIND & (1 << RESET_START_BUTTON);
    /*if (pause_play_button_is_high) {
      PORTB = OFF_LED;
      //pause_trigger = 0;
    } else {
      PORTB = ON_LED;
    }*/

    if (reset_start_button_is_high) {
      reset_trigger = 1;
    }

    if (!pause_play_button_is_high) {
      pause_trigger = !pause_trigger;
      while (!pause_play_button_is_high) {
        pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
      }
    } 

    if (!pause_trigger) {
      //PORTB = ON_LED;
      PORTB = current_value;
      _delay_ms(70);
      current_value++;  // It automatically resets because in binary 0xff + 0x01 = 0x00. So no need for a reset code.
    } else if (pause_trigger) {
      PORTB = current_value;
    } else if (reset_trigger) {
      PORTB = 0;
    } else {
      PORTB = 0x80;
    }
    
  }       
}











  /*while (1) {
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
}*/
