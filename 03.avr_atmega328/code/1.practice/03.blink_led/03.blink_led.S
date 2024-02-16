; Blink LED, more pratice.
; 2024feb4 sun 1206mf

#define __SFR_OFFSET 0x00
#include "avr/io.h"

; Declare setDir and led as global functions
.global setDir
.global led

; Set the 5th bit of DDRB register (to 1). That is, let the 5th bit of DDRB reg be an output bit.
setDir:
  sbi DDRB, 5
  ret

; If r24 is 1 set the 5th bit of PORTB. If r24 is 0, clear the 5th bit of PORTB.
led:
  cpi r24, 0x00
  breq ledOff
  sbi PORTB, 5
  ret

ledOff:
  cbi PORTB, 5
  ret
