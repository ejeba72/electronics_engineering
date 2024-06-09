; 1521mf sat 8jun2024
; Emergency Vehicle Lightning. 

; STEPS:
;  - Write pushBtn logic. Use Arduino's digital pin 2 (pd2). Input.
;  - Write LED logic. Use Arduino's digital pin 3 (pd3). Output.
;  - Data direction bitmask = 0b00001000.
;  - Write btnDelay logic.
 
.device atmega328p

.equ PIND  = 0x29
.equ DDRD  = 0x2a
.equ PORTD = 0x2b

  ldi r18, 0b00001000      ; Load data direction bitmask into reg 18.
  sts DDRD, r18            ; Store bitmask in ddrd reg.
  ldi r20, 0               ; Make reg 20 the zero reg.

onLed:
  sts PORTD, r18           ; On LED if there is signal in pin 2.
  call btnDelay
  sts PORTD, r20
  call btnDelay
  rjmp onLed
btnDelay:
  ldi r21, 100               ; Note: delay loops are analogous to the multiple circular layers of an onion.
outer:
  ldi r22, 0xff
inner:
  ldi r23, 0xff
innerInner:
  subi r23, 1
  cpi r23, 0
  brne innerInner
  subi r22, 1
  cpi r22, 0
  brne inner
  subi r21, 1
  cpi r21, 0
  brne outer
  ret
