// 753pm fri21feb2025
// LED Binary Counter

/* First attempt: failed.
#include<avr/io.h>
#include<util/delay.h>

const int FIRST_LED = PD2;
const int SECOND_LED = PD3;
const int THIRD_LED = PD4;
const int FOURTH_LED = PD5;

void main(void) {
  DDRD |= (0b1111 << 2);    // make arduino pin 2 to pin 5 output
  while (1) {
    int counter = 0;
    while (counter < 15) {
      PORTD |= (counter << 2);
      _delay_ms(400);
      counter += counter;
    }
  }
}
*/

/* Correction from chatgpt. It worked. But I'm not convinced that all the changes are necessary. And I don't know the change(s) that make it worked.
#include <avr/io.h>
#include <util/delay.h>

#define FIRST_LED  PD2
#define SECOND_LED PD3
#define THIRD_LED  PD4
#define FOURTH_LED PD5

int main(void) {
  DDRD |= (0b1111 << 2);  // Set PD2–PD5 as outputs

  while (1) {
    int counter = 0;
    while (counter < 16) {  // Use 16 to cover 4 bits (0-15)
      //PORTD = (counter << 2);  // Assign directly to avoid accumulation.
      _delay_ms(400);
      counter++;
    }
  }
}
*/

// Debugging the code I wrote.
#include<avr/io.h>
#include<util/delay.h>

const int FIRST_LED = PD2;
const int SECOND_LED = PD3;
const int THIRD_LED = PD4;
const int FOURTH_LED = PD5;

void main(void) {
  DDRD |= (0b1111 << 2);    // make arduino pin 2 to pin 5 output

  // This section is just to indicate the start of the program and to confirm that everything is ok.
  int twice = 0;
  while (twice < 2) {
    PORTD = (0B1111 << 2);
    _delay_ms(800);
    PORTD = ~(0B1111 << 2);
    _delay_ms(100);
    twice++;
  }

  while (1) {
    int counter = 0;
    while (counter < 16) {    // indeed the "counter < 15" condition was wrong. but how about combining it with ++counter? Well I can't try that today.
      //PORTD = (counter << 2);   // indeed, PORT |= (counter << 2); was accumulating previous results. Although "PORTD = (counter << 2);" assigns directly to avoid accumulation, it does not preserve Tx & maybe Rx bits.
      PORTD = (PORTD & 0x03) | (counter << 2);    // Assigns directly and yet preserves bit 0 & 1.
      _delay_ms(1200);
      counter += 1;
    }
  }
}
