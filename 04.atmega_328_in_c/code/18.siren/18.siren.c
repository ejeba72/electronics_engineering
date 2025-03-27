// 924am sun2mar2025
// Siren Lights With LEDs

#define F_CPU 8000000UL
#define LED1 0x55
#define LED2 0xAA
#define DELAY 30

#include<avr/io.h>
#include<util/delay.h>

int main(void) {
  DDRB = 0xFF;
  while (1) {
    PORTB = LED1;
    _delay_ms(DELAY);
    PORTB = LED2;
    _delay_ms(DELAY);
  }
  return 0;
}
