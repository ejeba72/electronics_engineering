; 1905mf fri 14jun2024
; Analog-Digital Converter (ADC)

; STEPS:
; - Write a program to test that all the LEDs are properly connected.

; 1st LED (blue):  D11 = PB3
; 2nd LED (blue):  D10 = PB2
; 3rd LED (blue):  D2  = PD2
; 4th LED (blue):  D3  = PD3
; 5th LED (blue):  D4  = PD4
; 6th LED (blue):  D5  = PD5
; 7th LED (blue):  D6  = PD6
; 8th LED (blue):  D7  = PD7
; 9th LED (blue):  D8  = PB0
; 10th LED (blue): D9  = PB1

.device atmega328p

.equ DDRD  = 0x2a
.equ DDRB  = 0x24
.equ PORTD = 0x2b
.equ PORTB = 0x25

  ldi r18, 0xff
  ldi r19, 0
  sts DDRD, r18
  sts DDRB, r18
;blink:
  ;sts PORTD, r18
  ;call btnDelay
  ;sts PORTD, r19
  ;call btnDelay
  ;sts PORTB, r18
  ;call btnDelay
  ;sts PORTB, r19
  ;call btnDelay
  ;rjmp blink


blink:
  sts PORTB, r19
  sts PORTD, r18
  call btnDelay
  sts PORTD, r19
  sts PORTB, r18
  call btnDelay
  rjmp blink



;halt:
  ;rjmp halt

btnDelay:
  ;ldi r21, 3                ; Note: delay loops are analogous to the multiple circular layers of an onion.
  ldi r21, 30                ; Note: delay loops are analogous to the multiple circular layers of an onion.
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
