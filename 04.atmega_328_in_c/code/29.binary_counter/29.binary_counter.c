#define F_CPU 16000000UL  // Define CPU clock speed (adjust if using internal oscillator)
#include <avr/io.h>
#include <util/delay.h>

#define PAUSE_PLAY_BUTTON PD2  // Pause-Play button on PD2
#define RESET_START_BUTTON PD3 // Reset-Start button on PD3

void init_pins() {
    DDRB = 0xFF;  // Set PORTB as output for LEDs
    DDRD &= ~(1 << PAUSE_PLAY_BUTTON) & ~(1 << RESET_START_BUTTON); // Set PD2 & PD3 as input
    PORTD |= (1 << PAUSE_PLAY_BUTTON) | (1 << RESET_START_BUTTON);  // Enable pull-up resistors
}

uint8_t debounce_button(uint8_t pin) {
    if (!(PIND & (1 << pin))) {  // Check if button is pressed (active low)
        _delay_ms(50);            // Debounce delay
        if (!(PIND & (1 << pin))) return 1; // Confirm press
    }
    return 0;
}

int main(void) {
    init_pins();
    uint8_t counter = 0;
    uint8_t paused = 0, reset_mode = 0;

    while (1) {
        if (debounce_button(PAUSE_PLAY_BUTTON)) {
            paused = !paused; // Toggle pause state
            while (!(PIND & (1 << PAUSE_PLAY_BUTTON))); // Wait for button release
        }
        
        if (debounce_button(RESET_START_BUTTON)) {
            reset_mode = !reset_mode; // Toggle reset-start state
            counter = 0; // Reset counter to zero
            while (!(PIND & (1 << RESET_START_BUTTON))); // Wait for button release
        }
        
        if (!paused && !reset_mode) {
            PORTB = counter; // Display counter on LEDs
            counter++;
            _delay_ms(75);
        }
    }
}

