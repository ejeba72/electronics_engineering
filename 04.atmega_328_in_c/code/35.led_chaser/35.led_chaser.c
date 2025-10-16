// 0231am wed2apr2025
// LED Chaser Program
// with respect to delay, scale down by a factor of 10. E.g. 100ms will be 10ms.

#define F_CPU 8000000UL

#include<avr/io.h>
#include<util/delay.h>

#define FIRST_LED 0

int current_led;
int main(void) {
  // initializations
  DDRB = 0x3F;
  // event loop
  while (1) {
    current_led = 0;
    while (current_led < 6) {
      PORTB = 0x01 << current_led;
      _delay_ms(10);
      //_delay_us(1500);
      current_led++;
    }
  }
}
