; 2000mf tue 14may2024

; DDRD = 0X2a (avr asm) = 0x002a0 (arbitrarily chosen address for armlite asm)
; PORTD = 0x2b (avr asm) = 0x002b0 (arbitrarily chosen address for armlite asm)
; Digital pin4 on arduino board = pin6 on ATmega328P = PD4 = 5th bit on PORTD and DDRD7

  mov r0, #0x10                                 ; PD4 is on the 5th bit of PORTD and DDRD. 0b00010000 = 0x10 = 16.
  mov r1, #0
  str r0, 0x002a0
blink:
  str r0, 0x002b0
  mov lr, pc                                    ; lr is link register
  b delay
  str r1, 0x002b0
  mov lr, pc
  b delay
  b blink
delay:
  mov r2, #1
  mov r3, #1
  mov r4, #2
outer:
  sub r2, r2, #1
inner:
  sub r3, r3, #1
innerInner:
  sub r4, r4, #1
  cmp r4, #0
  bne innerInner
  cmp r3, #0
  bne inner
  cmp r4, #0
  bne outer
  mov pc, lr
