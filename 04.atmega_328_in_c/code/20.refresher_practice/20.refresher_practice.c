// 829pm mon10mar2025
// Refresher practice

#define F_CPU 8000000UL
#define ROW_OF_LED 0xFF
#define DELAY_TIME 30

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  // initialization
  DDRB = 0xFF;

  // event loop
  while (1) {
    PORTB ^= 0xFF;
    _delay_ms(DELAY_TIME);
  }
}
