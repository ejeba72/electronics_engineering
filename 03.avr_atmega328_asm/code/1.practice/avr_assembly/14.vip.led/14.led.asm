; 1904,2017mf sun 12may2024
; From now on, my comments will be more terse.

; Digital pin4 on arduino board = pin6 on ATmega328P = PD4 = 5th bit on PORTD and DDRD7
; DDRD = 0X2a
; PORTD = 0x2b

.device atmega328p

  ldi r18, 16                    ; 0b00010000 = 0x10 = 2^4 = 16
  ldi r19, 0
  sts 0x2a, r18                  ; set DDRD to output
blinkLed:
  sts 0x2b, r18
  call delay
  sts 0x2b, r19
  call delay
  rjmp blinkLed
delay:
  ldi r20, 20
  ldi r21, 0xff
  ldi r22, 0xff
outer:
  subi r20, 1
inner:
  subi r21, 1
innerInner:
  subi r22, 1
  cpi r22, 0
  brne innerInner
  cpi r21, 0
  brne inner
  cpi r20, 0
  brne outer
  ret
  rjmp $                         ; halt program (For this program, this line is redundant because "blinkLed" is an unconditional loop)
