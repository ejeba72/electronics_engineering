// 1220am wed2apr2025
// Hello world for MCU programming. ;)

#define F_CPU 8000000UL

#include<avr/io.h>
#include<util/delay.h>

#define LED_PIN 0

int main() {
  // initialization
  DDRB = DDRB | (1 << LED_PIN);  // configure led pin as output

  // event loop
  while (1) {
    PORTB |= (1 << LED_PIN);  // set led pin
    _delay_ms(10);
    PORTB &= 0;  // clear led pin
    _delay_ms(90);
  }
  return 0;
}
