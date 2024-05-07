; USING RGB LED TO SIMULATE BLINKING SIREN FOR EMERGENCY AND PARAMILITARY VEHICLES
; 2024feb26 mon 2136mf,2303mf

; I would add a button to the circuit such that the following color combinations can be selected:
; * Green and Blue
; * Green and Red
; * Blue and Red
; There would be a 4th switch to toggle on or off the led.
; Create a functionality that saves the last color combination before it was off, such that when next it is on, the system would blink the previous combination, as oppose to a default combination. Right now, I don't have a clue of how I can do this. However, when I can, I would implement it. But for now, there would be a default.

; Assign pd2, pd3 and pd4 to Green, Blue and Red respectively.
; For the sake of learning by practice, I have decided to randomly use any reg as my link reg, instead of lr. This is because I know it really doesn't matter. Furthermore, as long as I don't use the bl and ret instructions, I can use the lr reg for the purpose of a general reg. However, I know that I should be careful with not deleting or modifying the value in such register at the 'wrong' time. I wish I can explain better, but it's so difficult to articulate myself :(.
; Again for the sake of learning by practice, I will use the same general purpose registers that I have used in the main routine, in all the sub-routines. This will force me to use the stack multiple times, which implies practicing push and pop.

;  offset for DDRD = 0x002a0
;  offset for PORTD = 0x002b0

; set direction reg for pd2, pd3 and pd4 (pd2, pd3 and pd4: 0b00011100 = 0x1c = 28).
  mov r0, #28
  str r0, 0x002a0

; clear bitmask for all combinations
  mov r0, #0

; set bitmask for Green and Blue combo (pd2 and pd3: 0b00001100 = 0x0c = 12)
  mov r1, #12

; set bitmask for Green and Red combo (pd2 and pd4: 0b00010100 = 0x14 = 20)
  mov r2, #20

; set bitmask for Blue and Red combo (pd2 and pd4: 0b00011000 = 0x18 = 24)
  mov r3, #24

; blinking leds
; to-do:
; * A combo should blink 40 times. Then another combo will blink 40 time. And so on. For example, Green and Blue will blink 40 times. Then Green and Red will blink 40 times. After that, Blue and Red will blink 40 times. Then it will return to Green and Blue blinking 40 times.

greenAndBlue:
  mov r4, #4  ; Green led
  mov r5, pc  ; call blinkLed
  b blinkLed
  mov r4, #8  ; Blue led
  mov r5, pc
  b blinkLed
  b greenAndBlue

blinkLed:
  push {r5}
  str r4, 0x002b0  ; short on
  mov r5, pc  ; call shortDelay
  b shortDelay
  str r0, 0x002b0  ; short off
  mov r5, pc
  b shortDelay
  str r4, 0x002b0  ; short on
  mov r5, pc
  b shortDelay
  str r0, 0x002b0  ; long off
  mov r5, pc  ; call longDelay
  b longDelay
  pop {r5}
  mov pc, r5  ; ret

shortDelay:
  push {r3, r4}
  mov r3, #10  ; you can use #1 when stepping through your code or slow delay on armlite
  mov r4, pc  ; call delay subroutine
  b delay
  pop {r3,r4}
  mov pc, r5

longDelay:
  push {r3,r4}
  mov r3, #120  ; you can use #6 when stepping through your code or slow delay on armlite
  mov r4, pc
  b delay
  pop {r3,r4}
  mov pc, r5

delay:
  push {r0,r1,r2}
  mov r0, r3
outerLoop:
  sub r0, r0, #1
  mov r1, #255  ; you can use #2 when stepping through your code or slow delay on armlite
innerLoop:
  sub r1, r1, #1
  mov r2, #255  ; you can use #2 when stepping through your code or slow delay on armlite
innerInnerLoop:
  subs r2, r2, #1
  bne innerInnerLoop
  cmp r1, #0
  bne innerLoop
  cmp r0, #0
  bne outerLoop
  pop {r0,r1,r2}
  mov pc, r4

pause:
  b pause
