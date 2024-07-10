; 2117mf wed jul10,2024
; "hello, world" Program

;

.device atmega328p

.equ UCSR0A = 0xc0
.equ UCSR0B = 0xc1
.equ UCSR0C = 0xc2
.equ UBRR0L = 0xc4
.equ UBRR0H = 0xc5
.equ UDR0 = 0xc6

; Initialise UCSR0B, UCSR0C, UBRR0H and UBRR0L
; NOTE:
;    - For 8-bits character size, UCSZ0[2:0] = 011.
;    - UBRR = 103 (in order to have a baudrate of 9600)
;    - 103 = 0b01100111 = 0x67

  ldi r18, 0x18         ; 0x18 = 0b00011000
  sts UCSR0B, r18
  ldi r18, 0x06         ; 0x06 = 0b00000110
  sts UCSR0C, r18
  ldi r18, 0x67
  sts UBRR0L, r18
  ldi r18, 0
  sts UBRR0H, r18

helloLoop:
  ldi r20, 104             ; ascii val for 'h'
  call writeLoop
  ldi r20, 101             ; ascii val for 'e'
  call writeLoop
  ldi r20, 108             ; ascii val for 'l'
  call writeLoop
  ldi r20, 108             ; ascii val for 'l'
  call writeLoop
  ldi r20, 111             ; ascii val for '0'
  call writeLoop
rjmp helloLoop

writeLoop:
  lds r18, UCSR0A
  andi r18, 0x20           ; check if the UDRE0 bit is set or cleared.
  cpi r18, 0x20
  brne writeLoop           ; branch to writeLoop if UDRE0 bit is cleared.
  mov r19, r20
  sts UDR0, r19
  call delay
  ret

delay:
  push r18, r19, r20
  ldi r18, 30
outer:
  ldi r19, 255
inner:
  ldi r20, 255
innerInner:
  subi r20, 1
  brne innerInner
  subi r19, 1
  brne inner
  subi r18, 1
  brne outer
  pop r18, r19, r20
  ret
