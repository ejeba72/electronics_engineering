; 1221mf thu 11jul2024
; ~1630mf thu 11jul2024
; Analog To Digital Converter

.device atmega328p

.equ ADMUX = 0x7c
.equ ADCSRA = 0x7a
.equ ADCL = 0x78
.equ ADCH = 0x79
.equ DDRC = 0x27
.equ DDRD = 0x2a
.equ DDRB = 0x24

  ldi r18, 0xc0 ; 0b11000000 = 0xc0
  sts ADMUX, r18
  ldi r19, 0x87 ; 0b10000111 = 0x87 (Dedicate r19 to ADCSRA, because its val will be modified).
  sts ADCSRA, r19
  ori r19, 0x40          ; 0x40 = 0b01000000 (Set the bit0. This new value will be used to start conversion.)
  ldi r18, 0
  sts DDRC, r18          ; set DDRC as input reg by clearing its bits.
  ldi r18, 0xff
  sts DDRB, r18          ; set DDRB as output reg.
  lds r18, DDRD
  ori r18, 0xfc          ; 0xfc = 0b11111100. I wish to avoid modifying bit0 and bit1.
  sts DDRD, r18          ; Set bit2 to bit7 as output bits and leave bit0 and bit 1 unaltered.
readAdc:
  sts ADCSRA, r19        ; Start conversion by setting the 6th bit in ADCSRA.
  lds r18, ADCSRA        ; Check if bit4 (ADIF flag) is set.
  andi r18, 0x10
  cpi r18, 0x10
  brne readAdc

