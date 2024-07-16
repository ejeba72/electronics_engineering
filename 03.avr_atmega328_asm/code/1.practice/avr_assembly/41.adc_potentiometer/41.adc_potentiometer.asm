; 1221mf thu 11jul2024
; ~1630mf thu 11jul2024
; Analog To Digital Converter

.device atmega328p

.equ ADMUX = 0x7c
.equ ADCSRA = 0x7a
;.equ ADCL = 0x78     I have decided to comment out ADCL, because I would no longer be needing it in my code.
.equ ADCH = 0x79
.equ DDRC = 0x27
.equ DDRD = 0x2a
.equ DDRB = 0x24
.equ PORTD = 0x2b
.equ PORTB = 0x25

  ldi r18, 0xe0       ; 0b11100000 = 0xe0. I have also set the ADLAR (bit5), because I wish to deal with 8bits.
  sts ADMUX, r18
  ldi r19, 0x87       ; 0b10000111 = 0x87 (Dedicate r19 to ADCSRA, because its val will be modified).
  sts ADCSRA, r19
  ori r19, 0x40       ; 0x40 = 0b01000000 (Set the bit6. This new value will be used to start conversion.)
  ldi r18, 0
  sts DDRC, r18       ; set DDRC as input reg by clearing its bits.
  ldi r18, 0xff
  sts DDRB, r18       ; set DDRB as output reg.
  lds r18, DDRD
  ori r18, 0xfc       ; 0xfc = 0b11111100. I wish to avoid modifying bit0 and bit1.
  sts DDRD, r18       ; Set bit2 to bit7 as output bits and leave bit0 and bit 1 unaltered.
readAdc:
  sts ADCSRA, r19     ; Start conversion by setting the 6th bit in ADCSRA.
  lds r18, ADCSRA     ; Check if bit4 (ADIF flag) is set.
  andi r18, 0x10
  cpi r18, 0x10
  brne readAdc
  lds r18, ADCH
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
