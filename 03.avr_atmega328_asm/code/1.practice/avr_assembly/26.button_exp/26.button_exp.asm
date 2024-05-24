; 1942mf fri 24may2024
; Button Experiment
; Using a Push-up button as a Toggle button.
; Logic: When the previous reg receives a value of zero, then check the value in the present reg.

; PIND  = 0x29
; DDRD  = 0x2a
; PORTD = 0x2b

.device atmega328p
  ldi r18, 0b00001000              ; Bitmask for DDRD & PORTD.
  sts 0x2a, r18                    ; Set DDRD.
  ldi r20, 0                       ; Designate r20 as zero reg.
button:
  mov r21, r19
  lds r19, 0x29                    ; Read PIND.
  andi r19, 0b00000100              ; Isolate 3rd pin.
  cpi r21, 0
  brne offLed
  cpi r19, 0b00000100
  brne offLed
  rjmp onLed
onLed:
  sts 0x2b, r18
  call delay
  sts 0x2b, r20
  rjmp button
offLed:
  sts 0x2b, r20
  rjmp button

delay:
  ldi r22, 100
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
