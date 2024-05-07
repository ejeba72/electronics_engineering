; BLINK AN LED IN ASSEMLY
; 2024jan4 sun 0811mf

#define __SFR_OFFSET 0x00
#include "avr/io.h"

.global start
.global led

start:
  sbi DDRB, 5
  ret
led:
  cpi r24, 0x00
  breq ledOff
  sbi PORTB, 5
  ret
ledOff:
  cbi PORTB, 5
  ret
