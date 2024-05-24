; ~1800mf,1859mf fri 24may2024
; Button Experiment
; Using a Push-up button as a Toggle button.
; Logic: When the previous reg receives a value of zero, then check the value in the present reg.

; PIND  = 0x29
; DDRD  = 0x2a
; PORTD = 0x2b

.device atmega328p
  ldi r21, 0b00000000                    ; R21 is made a zero reg.
  ldi r18, 0b00001000           ; DDRD bitmask.
  sts 0x2a, r18                 ; Set DDRD.
  ;ldi r19, 0b00000100           ; Load default present input val to use for the first update of previous input reg.
  ldi r23, 0b01000000                    ; Load default val in tentatative state reg.
button:
  ;mov r22, r19                  ; Update previous input reg with val in present input reg.
  lds r20, 0x29                 ; Read input data from PIND.
  ldi r19, 0b00000100
  and r19, r20                  ; Isolate input data from 3rd bit of PIND.
  ;cpi r22, 0b00000000                    ; Cmp previous input val with zero.
  ;brne tentativeOutput

  ;ldi r19, 0b00000000
  cpi r19, 0b00000100           ; Cmp present input val with 1 in the 3rd bit.
  brne tentativeOutput

  ;cpi r23, 0b00000000           ; The aim of these few lines of code is to toggle the value of the tentative state reg.
  ;breq zeroToOne
  ;ldi r23, 0b00000000                    ; Toggle val in r23 from 1 to 0.
  ;rjmp tentativeOutput
;zeroToOne:
  ;ldi r23, 1                    ; Toggle val in r23 from 0 to 1. Note: the choice of the val 1 and 0 are arbitrary.
tentativeOutput:
  cpi r23, 0b00000000                    ; Cmp val in tentative state reg with 0.
  breq offLed
  sts 0x2b, r18                 ; On LED by setting PORTD (PORTD bitmask = DDRD bitmask)
  rjmp button
offLed:
  sts 0x2b, r21                 ; Off LED by clearing PORTD with zero reg.
  rjmp button
