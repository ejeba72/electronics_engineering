; 1423mf sat 13jul2024
; Checking potentiometer vals using USART. 

.device atmega328p

; ADC-Potentiometer Directives
.equ ADMUX = 0x7c
.equ ADCSRA = 0x7a
;.equ ADCL = 0x78     I have decided to comment out ADCL, because I would no longer be needing it in my code.
.equ ADCH = 0x79
.equ DDRC = 0x27
.equ DDRD = 0x2a
.equ DDRB = 0x24
.equ PORTD = 0x2b
.equ PORTB = 0x25

; ADC-Potentiometer Setup
  ldi r18, 0xe0       ; 0b11100000 = 0xe0. I have also set the ADLAR (bit5), because I wish to deal with 8bits.
  sts ADMUX, r18
  ldi r19, 0x87       ; 0b10000111 = 0x87 (Dedicate r19 to ADCSRA, because its val will be modified).
  sts ADCSRA, r19
  ori r19, 0x40       ; 0x40 = 0b01000000 (Set the bit0. This new value will be used to start conversion.)
  ldi r18, 0
  sts DDRC, r18       ; set DDRC as input reg by clearing its bits.
  ldi r18, 0xff
  sts DDRB, r18       ; set DDRB as output reg.
  lds r18, DDRD
  ori r18, 0xfc       ; 0xfc = 0b11111100. I wish to avoid modifying bit0 and bit1.
  sts DDRD, r18       ; Set bit2 to bit7 as output bits and leave bit0 and bit 1 unaltered.

; USART Directives
.equ UCSR0A = 0xc0
.equ UCSR0B = 0xc1
.equ UCSR0C = 0xc2
.equ UBRR0L = 0xc4
.equ UBRR0H = 0xc5
.equ UDR0 = 0xc6

; USART Setup
  ldi r18, 0x18
  sts UCSR0B, r18
  ldi r18, 0x06
  sts UCSR0C, r18
  ldi r18, 0x67       ; 0b01100111
  sts UBRR0L, r18
  ldi r18, 0
  sts UBRR0H, r18

; ADC-Potentiometer Loop
readAdc:
  sts ADCSRA, r19     ; Start conversion by setting the 6th bit in ADCSRA.
  lds r18, ADCSRA     ; Check if bit4 (ADIF flag) is set.
  andi r18, 0x10
  cpi r18, 0x10
  brne readAdc
  lds r18, ADCH
writeToUsart:
  lds r21, UCSR0A
  andi r21, 0x20
  cpi r21, 0x20
  brne writeToUsart
  sts UDR0, r18       ; Write into the UDR0 reg, if the UDRE0 bit (bit5) in the UCSR0A reg is set.
  mov r20, r18
  lsl r20
  lsl r20
  sts PORTD, r20
  mov r20, r18
  ;andi r20, 0xc0
  lsr r20
  lsr r20
  lsr r20
  lsr r20
  lsr r20
  lsr r20
  sts PORTB, r20
  rjmp readAdc
