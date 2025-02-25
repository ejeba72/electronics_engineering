// 126pm thu13feb2025
// Alternating Blink LEDs

#include <avr/io.h>
#include <util/delay.h>

int main() {
  DDRB |= (1<<5);
  DDRD |= (1<<6);
  while (1) {
    PORTD ^= (1<<6);
    _delay_ms(500);
    PORTB ^= (1<<5);
  }
}
