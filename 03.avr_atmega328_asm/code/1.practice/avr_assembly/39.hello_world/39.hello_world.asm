; 1536mf wed jul3,2024
; 'hello, world' Program

; UCSR0A: USART Control and Status Reg A
; UCSR0B: USART Control and Status Reg B
; UCSR0C: USART Control and Status Reg C
; UBRR0L: USART Baud Rate Reg, Low
; UBRR0H: USART Baud Rate Reg, High
; UDR0: USART Data Reg

.device atmega328p

.equ ddrb = 4  ; 0x04 = 4.
.equ portb = 5  ; 0x05 = 5.

; Test Program: Blink LED
  sbi ddrb, 5
loop:
  sbi portb, 5
  rcall delay
  cbi portb, 5
  rcall delay
  rjmp loop

delay:
  push r18, r19, r20
  ldi r18, 8
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
