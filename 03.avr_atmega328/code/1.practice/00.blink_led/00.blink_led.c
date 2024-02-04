// BLINK LED
// 2024jan29 mon 1002mf
// My first ever microcontroller code written in C! :)

#include<avr/io.h>
#include<util/delay.h>

int main() {
  DDRB |= (1 << DDB5);
  do {
    PORTB |= (1 << PORTB5);
    _delay_ms(1000);
    PORTB &= ~(1 << PORT5);
    _delay_ms(1000);
  } while (1);
}
