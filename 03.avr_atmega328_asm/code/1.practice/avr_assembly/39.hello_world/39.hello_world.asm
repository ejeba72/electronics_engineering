; 1536mf wed jul3,2024
; 'hello, world' Program

; UCSR0A: USART Control and Status Reg A (0x00. However, check bit5.)
; UCSR0B: USART Control and Status Reg B (0x18)
; UCSR0C: USART Control and Status Reg C (0x06. Async, Parity disabled, 1 stop bit, 8-bit character.)
; UBRR0L: USART Baud Rate Reg, Low (For baudrate = 9600, UBRR = 103 = 0b01100111 = 0x67)
; UBRR0H: USART Baud Rate Reg, High
; UDR0: USART Data Reg

.device atmega328p

.equ UCSR0A = 0xc0
.equ UCSR0B = 0xc1
.equ UCSR0C = 0xc2
.equ UBRR0L = 0xc4
.equ UBRR0H = 0xc5
.equ UBR0 = 0xc6

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
