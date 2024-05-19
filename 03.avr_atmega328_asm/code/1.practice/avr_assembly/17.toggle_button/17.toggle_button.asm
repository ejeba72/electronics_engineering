; 1450mf,1547mf sun 19may2024
; TOGGLE BUTTON FOR DUAL BLINKING LED

; Blue light  --> arduino pin2 = PD2. Therefore bitmask = 0b00000100 (3rd bit) = 0x04 = 4
; Red light   --> arduino pin3 = PD3. Therefore bitmask = 0b00001000 (4th bit) = 0x08 = 8
; Toggle button --> arduino pin4 = PD4. Therefore bitmask = 0b00010000 (5th bit) = 0x0f = 16
; PIND  = 0x29 --> input register
; DDRD  = 0x2a (data direction register)
; PORTD = 0x2b (output register)

.device atmega328p
  ldi r18, 4
  ldi r19, 8
  ldi r20, 0
  ldi r21, 12
  ldi r27, 1            ; variable toggle logic register
  ldi r28, 1            ; constant toggle logic register
  sts 0x2a, r21         ; set 3rd and 4th bit of DDRD to output bits (by implication every other bit is set to input bits).
toggleButtonMonitor:
  ldi r26, 16
  lds r25, 0x29
  and r26, r25
  cpi r26, 16
  breq toggleButtonMonitor
toggleLogic:
  eor r27, r28
  cpi r27, 0
  brne toggleButtonMonitor
  call blink
  rjmp toggleButtonMonitor
blink:
  sts 0x2b, r18         ; blink LEDs
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
