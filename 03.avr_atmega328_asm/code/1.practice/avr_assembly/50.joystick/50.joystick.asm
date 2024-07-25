; 1943wat thu 25jun2024
; Basic Joystick Setup

; NOTE: The difference between '.equ', '.def', and '.set' is that each is uniquely applied to a const, reg, and var respectively. Otherwise, they do the same thing, which is to set or assign a label to a value.

.device atmega328p

.equ ADCL = $78            ; Set 'ADCL' equal to '$78'.
.equ ADCH = $79
.equ ADCSRA = $7a
.equ ADCSRB = $7b
.equ ADMUX = $7c
.equ DDRC = $27
.equ DDRB = $24
.equ DDRD = $2a
.equ PINC = $26
.equ PORTB = $25
.equ PORTD = $2b

.def miscReg = r18         ; Set 'reg' equal to 'r18'.

  clr miscReg
  sts DDRC, miscReg
  ser miscReg              ; Set reg
  sts DDRB, miscReg
  sts DDRD, miscReg

  ldi miscReg, $87
  sts ADCSRA, miscReg      ; But to start conversion, set bit6 (write 1 to bit6). That is, ADCSRA = $c7.
  clr miscReg
  sts ADCSRB, miscReg      ; Assign $00 in ADCSRB.

  ldi miscREg, $01         ; For Y-axis

; X-axis
adcConvert:
  clr miscReg
  sts ADMUX, miscReg       ; Assign $00 to ADMUX Selection Reg for X-axis.
  ldi miscReg, $c7
  sts ADCSRA, miscReg
isConversionComplete:
  lds miscReg, ADCSRA
  andi miscReg, $10
  cpi miscReg, $10
  brne isConversionComplete
  lds r19, ADCL
  lds r20, ADCH
  lsl r20
  lsl r20
  push r19
  andi r19, $c0
  rol r19
  rol r19
  or r20, r19
  pop r19
  lsl r19
  lsl r19
  sts PORTD, r19
  sts PORTB, r20
  rjmp adcConvert
