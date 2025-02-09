#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN PB5  // D13 on Arduino Nano (Port B, Pin 5)

int main(void) {
    // Set LED pin as output
    DDRB |= (1 << LED_PIN);

    while (1) {
        PORTB ^= (1 << LED_PIN);  // Toggle LED state
        _delay_ms(500);           // Delay 500 milliseconds
    }

    return 0;
}

