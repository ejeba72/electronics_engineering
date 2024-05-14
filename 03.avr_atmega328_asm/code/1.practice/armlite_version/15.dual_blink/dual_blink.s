; 2200mf tue 14may2024
; DUAL BLINKING LED
; This can be used in ambulances, police cars etc

; DDRD = 0x2a (avr asm) = 0x002a0 (arbitrarily chosen address for armlite asm)
; PORTD = 0x2b (avr asm) = 0x002b0 (arbitrarily chosen address for armlite asm)
; Blue led --> pin2 = PD2 = 3rd bit on PORTD AND DDRD = 0b00000100 = 0x04 = 4
; Red led  --> pin3 = PD3 = 4th bit on PORTD AND DDRD = 0b00001000 = 0x08 = 8

  mov r0, #4               ; bitmask for blue led
  mov r1, #8               ; bitmask for red led
  mov r3, #0               ; bitmask to turn off each led
  mov r4, #12              ; bitmask for DDRD (data direction register)
  str r4, 0x2a
blink:
  str r0, 0x2b             ; blue led
  mov pc, lr
  b shortDelay
  str r3, 0x2b
  mov pc, lr
  b shortDelay
  str r0, 0x2b
  mov pc, lr
  b shortDelay
  str r3, 0x2b
  mov pc, lr
  b longDelay
  str r1, 0x2b             ; red led
  mov pc, lr
  b shortDelay
  str r3, 0x2b
  mov pc, lr
  b shortDelay
  str r1, 0x2b
  mov pc, lr
  b shortDelay
  str r3, 0x2b
  mov pc, lr
  b longDelay
shortDelay:
  mov r5, #1
  mov r6, #1
outer:
  sub r5, r5, #1
