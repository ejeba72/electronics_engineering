// 0106pm sat22mar2025
// Unit logic for LED output by Emmanuel Eni.
// 1st-year electrical engineering student at HAN University.

#define F_CPU 16000000UL
#define LED 0xFF

#include<avr/io.h>

int main(void) {
  // initialisation
  DDRB = LED;
  // event loop
  while (1) {
    PORTB = LED;
  }
}

// 0151pm sat22mar2025: It worked! Hurray! :)
