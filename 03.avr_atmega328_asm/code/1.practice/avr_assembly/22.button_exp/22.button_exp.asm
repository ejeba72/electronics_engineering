; 2010mf,~2100mf thu 23may2024
; Button Experiment

; PIND  = 0x29
; DDRD  = 0x2a
; PORTD = 0x2b

.device atmega328p
  ldi r21, 0                    ; R21 is made a zero reg
  ldi r18, 0b00001000           ; DDRD bitmask
  sts 0x2a, r18                 ; Set DDRD
button:
  lds r20, 0x29                 ; Read data PIND
  ldi r19, 0b00000100
  and r19, r20                  ; Isolate input data from 3rd bit of PIND
  cpi r19, 0b00000100
  breq onLed
  rjmp offLed
onLed:
  sts 0x2b, r18                 ; Set PORTD (PORTD bitmask = DDRD bitmask)
  rjmp button
offLed:
  sts 0x2b, r21
  rjmp button
