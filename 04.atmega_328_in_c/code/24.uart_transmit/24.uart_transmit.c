#define F_CPU 16000000UL  // 16 MHz clock speed
#define BAUD 9600          // Baud rate
#define MY_UBRR F_CPU/16/BAUD-1  // UBRR calculation

#include <avr/io.h>
#include <util/delay.h>

void USART_init(void) {
    unsigned int ubrr = MY_UBRR;
    UBRR0H = (unsigned char)(ubrr>>8);  // Set baud rate
    UBRR0L = (unsigned char)ubrr;

    // Enable transmitter
    UCSR0B = (1<<TXEN0);

    // Set frame format: 8 data bits, 1 stop bit
    UCSR0C = (1<<UCSZ01) | (1<<UCSZ00);
}

void USART_transmit(unsigned char data) {
    // Wait for the transmit buffer to be empty
    while (!(UCSR0A & (1<<UDRE0))) {
        // Do nothing, just wait
    }
    // Put data into the transmit buffer
    UDR0 = data;
}

int main(void) {
    USART_init();  // Initialize USART

    while (1) {
        USART_transmit('A');  // Transmit 'A'
        _delay_ms(1000);  // Wait 1 second before sending next character
    }

    return 0;
}

