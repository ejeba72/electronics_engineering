; 2200mf tue 14may2024
; 0655mf thu 16may2024
; DUAL BLINKING LED
; This can be used in ambulances, police cars, fire trucks etc

; DDRD = 0x2a (avr asm) = 0x002a0 (arbitrarily chosen address for armlite asm)
; PORTD = 0x2b (avr asm) = 0x002b0 (arbitrarily chosen address for armlite asm)
; Blue led --> pin2 = PD2 = 3rd bit on PORTD AND DDRD = 0b00000100 = 0x04 = 4
; Red led  --> pin3 = PD3 = 4th bit on PORTD AND DDRD = 0b00001000 = 0x08 = 8

  mov r0, #4               ; bitmask for blue led
  mov r1, #8               ; bitmask for red led
  mov r3, #0               ; bitmask to turn off each led
  mov r4, #12              ; bitmask for DDRD (data direction register)
  str r4, 0x002a0
blink:
  str r0, 0x002b0             ; blue led
  mov lr, pc
  b shortDelay
  str r3, 0x002b0
  mov lr, pc
  b shortDelay
  str r0, 0x002b0
  mov lr, pc
  b shortDelay
  str r3, 0x002b0
  mov lr, pc
  b longDelay
  str r1, 0x002b0             ; red led
  mov lr, pc
  b shortDelay
  str r3, 0x002b0
  mov lr, pc
  b shortDelay
  str r1, 0x002b0
  mov lr, pc
  b shortDelay
  str r3, 0x002b0
  mov lr, pc
  b longDelay
  b blink
shortDelay:
  mov r5, #1
  mov r6, #1
outer:
  sub r5, r5, #1
inner:
  sub r6, r6, #1
  cmp r6, #0
  bne inner
  cmp r5, #0
  bne outer
  mov pc, lr
longDelay:
  mov r5, #1
  mov r6, #1
  mov r7, #1
outerLoop:
  sub r5, r5, #1
innerLoop:
  sub r6, r6, #1
innerInnerLoop:
  sub r7, r7, #1
  cmp r7, #0
  bne innerInnerLoop
  cmp r6, #0
  bne innerLoop
  cmp r5, #0
  bne outerLoop
  mov pc, lr
