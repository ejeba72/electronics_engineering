; Blink LED, 5th iteration
; 2024feb4 sun 1440mf

#define __SFR_OFFSET 0x00
#include "avr/io.h"

.global setDir
.global led

setDir:
  sbi DDRB, 5
  ret
led:
  cpi r24, 0x00
  breq ledOff
  sbi PORTB, 5
  rcall delayLoop
  ret
ledOff:
  cbi PORTB, 5
  rcall delayLoop
  ret
.equ innerLoopCountVal, 10000
delayLoop:
  ldi r20, 100  ; 100 is the outer loop count value.
outerLoop:
  ldi r30, lo8(innerLoopCountVal)
  ldi r31, hi8(innerLoopCountVal)
innerLoop:
  sbiw r30, 1
  brne innerLoop
  subi r20, 1
  brne outerLoop
