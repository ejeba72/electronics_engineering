; 0820mf thu 9may2024
; 1113mf sat 11may2024

; I am starting from scratch after a long time away from practicing assembly language coding. I feel bad that I have lost ground or should I say that I am brain rusty. However, it was due to circumstances beyond my control. Nonetheless, I pray that I will be able to recover lost grounds and become consistent with learning and practicing microcontroller programming, breadboard prototyping etc. May the force be with me! :)

; device definition
.device atmega328p

; ddrd = 0x2a
; portd = 0x2b

; Arduino pin2 is the 0b00000100 = 0x4 = 4

; load 4 into r24.
;  ldi r24, 4
;  ldi r24, 0

; set direction register to output
  sts 0x2a, r24

; set portd to be 1
  sts 0x2b, r24

; halt
  rjmp $
