; ~0750mf mon 20may2024
; TOGGLE BUTTON FOR DUAL BLINKING LED

; Blue light -----> arduino pin2 = PD2. Therefore bitmask = 0b00000100 (3rd bit) = 0x04 = 4
; Red light ------> arduino pin3 = PD3. Therefore bitmask = 0b00001000 (4th bit) = 0x08 = 8
; Toggle button --> arduino pin4 = PD4. Therefore bitmask = 0b00010000 (5th bit) = 0x0f = 16
; PIND  = 0x29
; DDRD  = 0x2a
; PORTD = 0x2b

.device atmega328p
  ldi r18, 4
  ldi r19, 8
  ldi r20, 0
  ldi r21, 12
  sts 0x2a, r21               ; Set 3rd and 4th bit of DDRD to output bits.
  ldi r28, 16                 ; Initialise register for storing previous input signal with a value of 1 in the 5th bit.
  ldi r27, 16                 ; Initialise toggle register with a value of 1 in the 5th bit.
toggleButtonMonitor:
  cpi r27, 16                 ; Compare the the value in the 5th bit with 1.
  brne offLeds
  call blinkLeds
offLeds:
  ldi r26, 16
  lds r25, 0x29
  and r26, r25                ; Isolate the input signal from the 5th bit.
  cpi r28, 0                  ; Check if previous input signal from button is 0.
  brne toggleButtonMonitor
  mov r28, r26                ; Update the register for storing the previous input signal with new value.
  cpi r26, 16                 ; Check if new input signal from button is 1 in the 5th bit.
  brne toggleButtonMonitor
  cpi r27, 0                  ; The aim is to toggle the value in 5th bit of the toggle reg from 1 to 0 and vice versa.
  breq zeroToOne
  ldi r27, 0                  ; If value in 5th bit of toggle reg is 1, make it 0.
  rjmp branch
zeroToOne:
  ldi r27, 16                 ; If value in 5th bit of toggle reg is 0, make it 1.
branch:
  rjmp toggleButtonMonitor
blinkLeds:
  sts 0x2b, r18
  call shortDelay
  sts 0x2b, r20
  call shortDelay
  sts 0x2b, r18
  call shortDelay
  sts 0x2b, r20
  call longDelay
  sts 0x2b, r19
  call shortDelay
  sts 0x2b, r20
  call shortDelay
  sts 0x2b, r19
  call shortDelay
  sts 0x2b, r20
  call longDelay
  ret
shortDelay:
  ldi r22, 4
  ldi r23, 255
  ldi r24, 255
outer:
  subi r22, 1
inner:
  subi r23, 1
innerInner:
  subi r24, 1
  cpi r24, 0
  brne innerInner
  cpi r23, 0
  brne inner
  cpi r22, 0
  brne outer
  ret
longDelay:
  ldi r22, 60
  ldi r23, 255
  ldi r24, 255
outerLong:
  subi r22, 1
innerLong:
  subi r23, 1
innerInnerLong:
  subi r24, 1
  cpi r24, 0
  brne innerInnerLong
  cpi r23, 0
  brne innerLong
  cpi r22, 0
  brne outerLong
  ret
