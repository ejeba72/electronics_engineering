; ~1930mf,1939mf fri 24may2024
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
  lds r19, 0x29                    ; Read PIND.
  andi r19, 0b00000100              ; Isolate 3rd pin.
  cpi r19, 0
  breq offLed
  rjmp onLed
onLed:
  sts 0x2b, r18
  rjmp button
offLed:
  sts 0x2b, r20
  rjmp button
