// 559pm fri21feb2025
// "SOS" Morse Code

#include<avr/io.h>
#include<util/delay.h>

#define LED_PIN PD3

const int short_delay = 100;
const int long_delay = 600;

void blink_pattern_for_letter_s() {
  PORTD ^= (1 << LED_PIN);
  _delay_ms(short_delay);
}

void letter_s() {
  blink_pattern_for_letter_s();
  blink_pattern_for_letter_s();
  blink_pattern_for_letter_s();
}

void blink_pattern_for_letter_o();

void letter_o() {
  blink_pattern_for_letter_o();
  blink_pattern_for_letter_o();
  blink_pattern_for_letter_o();
}

void blink_pattern_for_letter_o() {
  PORTD |= (1 << 3);
  _delay_ms(long_delay);
  PORTD &= ~(1 << 3);
  _delay_ms(short_delay);
}

void main(void) {
  DDRD |= (1 << 3);
  while (1) {
    letter_s();
    letter_o();
    letter_s();
  }
}
