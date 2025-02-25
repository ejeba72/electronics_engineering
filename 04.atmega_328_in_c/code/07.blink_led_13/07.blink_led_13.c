// 510pm fri21feb2025
// Blink led on pin 13

#include<avr/io.h>
#include<util/delay.h>

#define PIN13 PB5
#define OUTPUT 1

int main(void) {
  DDRB |= (OUTPUT << PIN13);   // Set pin13 as output pin
  while (1) {
    //PORTB ^= (1 << PIN13);    // Toggle pin13 HIGH and LOW
    //_delay_ms(300);   // Delay for 0.3 sec which is period of 0.6 sec and a frequency of 1.666 Hz
    PORTB |= (1 << PIN13);
    _delay_ms(900);
    PORTB &= ~(1 << PIN13);
    _delay_ms(100);
  }
}
