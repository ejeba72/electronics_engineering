; 2024feb16 fri 1126mf
; yet another attempt, after previous failed attempts

.device ATmega328P  ; That is, the name of the MCU inside the Arduino Uno or Nano

.equ PORTB = 0x05
.equ DDRB = 0x04
.equ PORTB5 = 5

setup:
  ldi r16, 0b00100000
  out DDRB, r16

loop:
  sbi PORTB, PORTB5  ; set bit 5 of I/O port B
  call delayCounter
  cbi PORTB, PORTB5
  call delayCounter
  rjmp loop

delayCounter:
  ldi r29, 0x03
  ldi r30, 0xFF
  ldi r31, 0xFF

delayLoop:
  dec r31
  brne delayLoop
  dec r30
  brne delayLoop
  dec r29
  brne delayLoop
  ret
