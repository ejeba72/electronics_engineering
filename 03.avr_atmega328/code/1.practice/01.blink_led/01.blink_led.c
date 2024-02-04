// BLINK LED (2ND ATTEMPT)
// 2024jan31 wed 0835mf

#include<avr/io.h>
#include<util/delay.h>

int main() {
  // pin2 on arduino board == PD2 on ATmega329P
  DDRD |= (1<<DDD2);
  while(1) {
    PORTB |= (1<<PORTB2);
    delay_ms(100);
    PORT &= ~(1<<PORTB2);
    delay_ms(100);
  }
}































































/*
int main() {
  // Pin13 on arduino == PB5 on ATmega328P
  // Set the direction of PB5 to write
  DDRB |= (1<<
  while(1) {
    PORTB |= (1<<PORTB5);
    delay_ms(100);
  }
}
*/
