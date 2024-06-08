; 0537mf tue 4jun2024

; pind = 0x29
; ddrd = 0x2a
; portd = 0x2b

.device atmega328p

  ldi r18, 0b11111100
  sts 0x2a, r18
onLed:
  sts 0x2b, r18
  rjmp onLed
