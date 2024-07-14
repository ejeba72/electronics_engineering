; 0842mf sun 14jul2024

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
  ldi r20, 48         ; 48 is the ascii val for zero.
  ldi r22, 7          ; 7 is the positional offset of the character 'A' on the ascii table.
readAdc:
  sts ADCSRA, r19     ; Start conversion by setting the 6th bit in ADCSRA.
  lds r18, ADCSRA     ; Check if bit4 (ADIF flag) is set.
  andi r18, 0x10
  cpi r18, 0x10
  brne readAdc
  lds r18, ADCH
  ;push r18, r18, r18  ; Intentionally push r18 thrice.
  mov r23, r18
  mov r24, r18
  mov r25, r18
  andi r18, 0xf0      ; Mask the lower nimble in order to work on the most significant hex value.
  swap r18            ; Swap nimbles
  add r18, r20
  cpi r18, 58         ; Compare r18 with ascii val 58 (i.e. the ascii val after the ascii val for '9').
  brge addSeven
  call writeToUsart   ; For vals between 0 and 9.
addSeven:
  add r18, r22
  call writeToUsart   ; For vals between 0xa and 0xf.


  rjmp secondHexVal
writeToUsart:
  lds r21, UCSR0A
  andi r21, 0x20
  cpi r21, 0x20
  brne writeToUsart
  sts UDR0, r18       ; Write into the UDR0 reg, if the UDRE0 bit (bit5) in the UCSR0A reg is set.
  ret
secondHexVal:
  ;pop r18
  andi r23, 0x0f      ; Mask the upper nimble in order to work in the least significant hex value.
  add r23, r20
  cpi r23, 58
  brge add7
  call writeToUsart
add7:
  add r23, r22
  call writeToUsart
  call delay
  ldi r26, 10         ; 10 is ascii val for line feed.
  call writeToUsart
  ldi r26, 13         ; 13 is the ascii val for carriage return.
  call writeToUsart
  ;pop r18             ; ledOutput
  lsl r24
  lsl r24
  sts PORTD, r24
  ;pop r18
  ;andi r18, 0xc0
  lsr r25
  lsr r25
  lsr r25
  lsr r25
  lsr r25
  lsr r25
  sts PORTB, r25
  rjmp readAdc

delay:
  push r18, r19, r20
  ldi r18, 0x20
outer:
  ldi r19, 0xff
inner:
  ldi r20, 0xff
innerInner:
  subi r20, 1
  brne innerInner
  subi r19, 1
  brne inner
  subi r18, 1
  brne outer
  pop r18, r19, r20
  ret
