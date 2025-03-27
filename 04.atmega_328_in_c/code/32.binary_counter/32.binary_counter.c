// 0839pm fri21mar2025
// 0123am wed26mar2025 (after several marathon coding sessions, several failed iterations, I am finally satisfied).
// Binary counter by Emmanuel Eni
// 1st-year electrical engineering student at HAN University.
// MCU Assignment: 8-bit binary counter with pause-play button and reset button

#define F_CPU 8000000UL    // I'm using the ATmega328P without an external crystal oscillator.

#include<avr/io.h>
#include<util/delay.h>

#define LED_PINS 0xFF
#define PAUSE_PLAY_BUTTON PD2
#define RESET_BUTTON PD3

int main(void) {
  // initializations
  DDRD &= ~(1 << PAUSE_PLAY_BUTTON);   // set as input
  DDRD &= ~(1 << RESET_BUTTON);
  PORTD |= (1 << PAUSE_PLAY_BUTTON);   // setup pull-up resistor
  PORTD |= (1 << RESET_BUTTON);
  DDRB = LED_PINS;
  int reset_button_is_high;
  int pause_play_button_is_high;
  int pause_trigger = 1;
  int current_value = 0;

  // event loop
  while (1) {
    pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
    reset_button_is_high = PIND & (1 << RESET_BUTTON);
    if (!pause_play_button_is_high) {
      pause_trigger = !pause_trigger;
      while (!pause_play_button_is_high) {
        pause_play_button_is_high = PIND & (1 << PAUSE_PLAY_BUTTON);
      }
    } else if (!reset_button_is_high) {
      current_value = 0;
      while (!reset_button_is_high) {
        reset_button_is_high = PIND & (1 << RESET_BUTTON);
      } 
    }
    if (!pause_trigger) {
      PORTB = current_value;
      _delay_ms(70);
      current_value++;  // It automatically resets because in binary 0xff + 0x01 = 0x00.
    } else if (pause_trigger) {
      PORTB = current_value;
    } 
  }       
}
