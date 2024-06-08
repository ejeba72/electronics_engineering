; 1239mf fri 31may2024

; This program is for blinking Emergency Vehicle Lighting. The will be three toggle switches to select colour combination of the light. And a fourth toggle switch to off or on the light.

; To-do:
; - Write delay logic for toggle button.
; - Write toggle button logic.
; - Write logic for long delay and short delay.
; - Write logic to switch on each of the three emergency lighting options Green & Blue, Green & Red, Blue & Red.
; - Write logic to turn emergency lights off.

; pind = 0x29
; ddrd = 0x2a
; portd = 0x2b

.device atmega328p

  ldi r18, 0                       ; R18 is made a zero reg.
  ldi r19, 0b00001000              ; Data direction bitmask.
;toggleBtn:
;  rjmp toggleBtn

  sts 0x2b, r19
lightLed:
  rjmp lightLed

pullDownBtn:
;  lds r20, 029
;  cpi r20, 0b00000100
;  breq onLed
;  sts 0x2b, r18                    ; Turn off the led.
;onLed:
;  sts 0x2b, r19
;  rjmp pullDownBtn

btnDelay:
  push r18, r19, r20
  ldi r18, 3
outer:
  subi r18, 1
  ldi r19, 255
inner:
  subi r19, 1
  ldi r20, 255
innerInner:
  cpi r20, 0
  brne innerInner
  cpi r19, 0
  brne inner
  cpi r18, 0
  brne outer
  pop r18, r19, r20
  ret
