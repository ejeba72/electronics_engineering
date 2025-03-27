// 1053am thu27feb2025
// Blink LED on actual ATmega328p chip (not the one on an arduino board)

#define F_CPU 8000000UL
#define LED PB1

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  DDRB = 0xFF;
  while (1) {
    PORTB ^= 0xFF;
    _delay_ms(10);
  }
}
