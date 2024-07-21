; 1904wat sun 21jul2024
; Practice: Load Program Memory

.device atmega328p

.equ UCSR0A = $c0
.equ UCSR0B = $c1
.equ UCSR0C = $c2
.equ UBRR0L = $c4
.equ UBRR0H = $c5
.equ UDR0 = $c6

  ldi r18, $18
  sts UCSR0B, r18
  ldi r18, $06
  sts UCSR0C, r18
  ldi r18, 103
  sts UBRR0L, r18
  ldi r18, 0
  sts UBRR0H, r18

hello_world:
  ldi r30, low(2*msg)
  ldi r31, high(2*msg)
next_char:
  lpm r19, z+
  cpi r19, 0
  breq hello_world
  call write
  rjmp next_char

write:
  lds r18, UCSR0A
  andi r18, $20
  cpi r18, $20
  brne write
  sts UDR0, r19
  call delay
  ret

delay:
  push r18, r19, r20
  ldi r18, 20
  ldi r19, $ff
  ldi r20, $ff
loop:
  dec r20
  brne loop
  dec r19
  brne loop
  dec r18
  brne loop
  pop r18, r19, r20
  ret

msg:
  .db "hello, world"
