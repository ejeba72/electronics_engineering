; 1521mf sat 8jun2024
; Emergency Vehicle Lightning. 
 
.device atmega328p

.equ PIND  = 0x29
.equ DDRD  = 0x2a
.equ PORTD = 0x2b

  ldi r19, 0xff
  ldi r18, 0xff
  sts DDRD, r19
  sts PORTD, r18
led:
  rjmp led
