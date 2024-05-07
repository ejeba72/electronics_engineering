; BLINKING LED, FREESTYLE APPROACH
; 2024feb22 thu 1042mf,??
; 2024feb23 fri 2247mf,feb24 sat 0106mf
; 2024feb25 sun 0911mf, 

; choice of pin: d2 = pd2 (ie digital pin2 on arduino)

; timer would consist of three loops: 1. outerLoop, 2. innerLoop, 3. innerInnerLoop

; DDRD = 0x2a in avr. However, this will not work for armlite. Therefore I'll assume that DDRD = 0x002a0 in armlite.
; PORTD = 0x2b in avr. However, this will not work for armlite. Therefore I'll assume that PORTD = 0x002b0 in armlite.

; to-do: flash the corresponding avr code into m328p device. observe the behaviour of the led. Try to write code in armlite that replicate such behaviour. Also, find the clock cycle of armlite LMC (Little Man Computer).
; The corresponding avr code causes an led placed in arduino digital pin 2, atmega328p pd2, to come on for about 1 Second. And go off for about 1 Second.
; clock cycle of armlite LMC:

; bitmask to set pin pd2 = 0b00000100 = 4 = 0x04
  mov r0, #4  ; move into r0 the immediate value 4. This immediate value is actually the bitmask to set pd2

; bitmask to clear pin pd2 = 0b00000000 = 0 = 0x00
  mov r1, #0  ; load bitmask in r1

; set pin 2 in data direction register, DDRD
  str r0, 0x002a0

; blink led
blinkLoop:
  str r0, 0x002b0  ; set pin pd2
  mov lr, pc  ; call delay subroutine
  b delay
  str r1, 0x002b0  ; clear pin pd2
  mov lr, pc
  b delay
  b blinkLoop

delay:
  mov r2, #2  ; outerLoop count
outerLoop:
  sub r2, r2, #1
  mov r3, #3  ; innerLoop count
innerLoop:
  sub r3, r3, #1
  mov r4, #3  ; innerInnerLoop count
innerInnerLoop:
  subs r4, r4, #1
  bne innerInnerLoop
  cmp r3, #0
  bne innerLoop
  cmp r2, #0
  bne outerLoop
  mov pc, lr

pause:
  b pause
