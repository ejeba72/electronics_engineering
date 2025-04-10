// 0231am wed2apr2025
// LED Chaser Program
// with respect to delay, scale down by a factor of 10. E.g. 100ms will be 10ms.

#define F_CPU 8000000UL

#include<avr/io.h>
#include<util/delay.h>

#define LED1 0
#define LED2 1
#define LED3 2
#define LED4 3
#define LED5 4
#define LED6 5

int main(void) {
  // initializations
  DDRB = 0x3F;
  // event loop
  while (1) {
    PORTB = 0x07;
    _delay_ms(20);
    PORTB = 0X38;
    _delay_ms(20);
  }
}
