; Blink LED, 5th iteration
; 2024feb4 sun 2050mf

.device ATmega328P

.equ DDRB = 0x04
.equ PORTB = 0x05

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
.equ innerLoopCountVal = 10000
delayLoop:
  ldi r20, 100  ; 100 is the outer loop count value.
outerLoop:
  ldi r30, 0x10
  ldi r31, 0x27
innerLoop:
  sbiw r30, 1
  brne innerLoop
  subi r20, 1
  brne outerLoop
