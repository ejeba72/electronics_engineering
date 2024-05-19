; 0758mf sat 18may2024
; DUAL BLINKING LED
; This can be used in ambulances, police cars, fire trucks etc

; Blue light --> arduino pin2 = PD2. Therefore bitmask = 0b00000100 (3rd bit) = 0x04 = 4
; Red light  --> arduino pin3 = PD3. Therefore bitmask = 0b00001000 (4nd bit) = 0x08 = 8
; DDRD = 0x2a
; PORTD = 0x2b

.device atmega328p
  ldi r18, 4
  ldi r19, 8
  ldi r20, 0
  ldi r21, 12
  sts 0x2a, r21         ; set 3rd and 4th bit of DDRD to output bits.
blink:
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
  rjmp blink
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
