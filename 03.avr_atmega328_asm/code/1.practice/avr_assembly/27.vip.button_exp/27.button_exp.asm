; 1942mf fri 24may2024
; Button Experiment
; Using a Pull-up button as a Toggle button.
; Logic: When the previous reg receives a value of zero, then check if the value in the present reg is 1.

; PIND  = 0x29
; DDRD  = 0x2a
; PORTD = 0x2b

.device atmega328p
  ldi r18, 0b00001000              ; Bitmask for DDRD & PORTD.
  sts 0x2a, r18                    ; Set DDRD.
  ldi r20, 0                       ; Designate r20 as zero reg.
button:
  mov r21, r19                     ; Update val in previous reg.
  lds r19, 0x29                    ; Read PIND.
  andi r19, 0b00000100             ; Isolate 3rd pin.
  cpi r21, 0                       ; Cmp val in previous reg with 0.
  brne button
  cpi r19, 0b00000100              ; Cmp val in present reg with 1 in the 3rd pin.
  brne button
  cpi r22, 0                       ; These few lines of code is used to toggle the val in the toggle reg.
  breq zeroToOne
  ldi r22, 0
  rjmp checkToggleReg
zeroToOne:
  ldi r22, 1
checkToggleReg:
  cpi r22, 0
  breq offLed
  sts 0x2b, r18                    ; Turn on the LED.
  rjmp button
offLed:
  sts 0x2b, r20                    ; Turn off the LED.
  rjmp button
