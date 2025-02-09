//237pm sun9feb2025

 
#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    DDRB |= (1 << PB5);  // Set pin 13 (PB5) as output
    while(1) {
        PORTB ^= (1 << PB5);  // Toggle pin 13
        _delay_ms(1000);      // Wait for 1 second
    }
    return 0;
}

/*
#include <avr/io.h>
#include <util/delay.h>

int main(void) {
  DDRB |= (1 << PB5);   // Set pin 13 (PB5) as output
  while (1) {
    PORTB ^= (1 << PB5);  // Toggle pin 13
    _delay_ms(1000);      // Wait for 1 second
  }
  return;
}
*/
