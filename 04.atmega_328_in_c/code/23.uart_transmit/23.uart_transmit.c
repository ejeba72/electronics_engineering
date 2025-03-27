// 1255am sun16mar2025
// UART Transmit



/*
Required Registers and Bits
(A) UART Initialization
    - UBRR0: USART Baud Rate Register 0: 12-bit register for storing baud register value
      -- UBRR0L: store the 8 LSB of the baud register value
      -- UBRR0H: store the 4 MSB of the baud register value
    - UCSR0B: USART Control & Status Register 0 B
      -- bit4: RXEN0: enable receiver
      -- bit3: TXEN0: enable transmitter
    - UCSR0C: USART Control & Status Register 0 C
      -- bit3: USBS0: select number of stop bits
      -- bit2: UCSZ01: set/clear bit1 of the 3-bit charater size bitmask
      -- bit1: UCSZ00: set/clear bit0 of the 3-bit character size bitmask
*/

/*
Required Steps
(A) Initialize UART
    - Set baud
    - Enable transmitter and/or receiver
    - Configure frame format [e.g. character size (UCSZ0) and stop bit (USBS0)]
(B) 
*/

//#define CLOCK_SPEED 1843200
//#define CLOCK_SPEED 8000000UL
#define F_CPU 8000000UL
#define BAUD 9600
#define BAUD_REG_VAL F_CPU/16/BAUD-1
#define DURATION 500

#include<avr/io.h>
#include<util/delay.h>

// Function prototypes
void initialize_usart(unsigned int baud_reg_param);
void write_usart_buffer(unsigned char data_param);


//void main(void) {
int main(void) {
  // Initialisation
  unsigned char data_val = 0x69;
  initialize_usart(BAUD_REG_VAL);
  DDRB = 0xFF;
  // event loop
  while (1) {
    //write_usart_buffer(data_val);
    write_usart_buffer('A');
    _delay_ms(DURATION);
    //received_data = read_usart_buffer();
    //PORTB = received_data;
    PORTB = data_val;
  }
}

// Function declarations & definitions
void initialize_usart(unsigned int baud_reg_param) {
  //UBRR0L = baud_reg_param;
  //UBRR0H = (baud_reg_param >> 8);
  UBRR0L = (unsigned char) baud_reg_param;
  UBRR0H = (unsigned char) (baud_reg_param >> 8);
  UCSR0B = (1 << TXEN0);
  UCSR0C = (1 << UCSZ01) | (1 << UCSZ00);
}

void write_usart_buffer(unsigned char data_param) {
  while ( !(UCSR0A & (1 << UDRE0)) )
  UDR0 = data_param;
}


/*
void main(void) {
  // Initialisation
  unsigned char received_data;
  unsigned char data_val = 0x69;
  //unsigned char data_val = 'A';
  initialize_usart(BAUD_REG_VAL);
  DDRB = 0xFF;
  // event loop
  while (1) {
    write_usart_buffer(data_val);
    //received_data = read_usart_buffer();
    //PORTB = received_data;
    PORTB = data_val;
  }
}

// Function declarations & definitions
void initialize_usart(unsigned int baud_reg_param) {
  UBRR0L = baud_reg_param;
  UBRR0H = (baud_reg_param >> 8);
  UCSR0B = (1 << TXEN0) | (1 << RXEN0);
  UCSR0C = (1 << UCSZ01) | (1 << UCSZ00) | (1 << USBS0);
}
unsigned char read_usart_buffer(void) {
  if (UCSR0A & (1 << RXC0)) {
  return UDR0;
  }
}
void write_usart_buffer(unsigned char data_param) {
  while ( !(UCSR0A & (1 << UDRE0)) )
    UDR0 = data_param;
}
*/
