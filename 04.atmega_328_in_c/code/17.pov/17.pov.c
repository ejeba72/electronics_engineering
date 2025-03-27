// 1115pm sat1mar2025
// Persistence Of Vision Program

#define F_CPU 8000000UL

#include<avr/io.h>
#include<util/delay.h>

void pov_display(uint8_t one_byte) {
  PORTB = one_byte;
  _delay_ms(2);
}

int main(void) {
  // init
  DDRB = 0xFF;
  // event loop
  while (1) {
    pov_display(0x70);
    pov_display(0x18);
    pov_display(0xBD);
    pov_display(0x6E);
    pov_display(0x3C);
    pov_display(0x3C);
    pov_display(0x3C);
    pov_display(0x6E);
    pov_display(0xBD);
    pov_display(0x18);
    pov_display(0x70);

    PORTB = 0xFF;
    _delay_ms(10);
  }
  return 0;
}
