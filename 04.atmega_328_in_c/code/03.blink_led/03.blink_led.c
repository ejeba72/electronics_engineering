// 343pm mon10feb2025

#include <avr/io.h>
#include <util/delay.h>

int main(void) {
  DDRB |= (1 << 5);     // Set pin find to output
  while (1) {
    PORTB ^= (1 << 5);      // Toggle LED on pin 13
    _delay_ms(70);
    PORTB ^= (1 << 5);
    _delay_ms(70);
    PORTB ^= (1 << 5);
    _delay_ms(70);
    PORTB ^= (1 << 5);
    _delay_ms(500);
  }
}
