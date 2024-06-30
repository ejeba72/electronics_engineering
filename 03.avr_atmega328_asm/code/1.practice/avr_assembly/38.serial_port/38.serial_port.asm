; 1221mf sat jun29,2024
; Serial Port Programming

; USART: Universal Sychronous and Asychronous Receiver-Transmitter
; USART Registers:
;   1. UDR0: Usart i/o Data Register 0.
;   2. UBRROL: Usart Baud Rate Register 0 Low.
;   3. UBRROH: Usart Baud Rate Register 0 High.
;   4. UCSR0A: Usart Control and Status Register 0 A.
;   5. UCSR0B: Usart Control and Status Register 0 B.
;   6. UCSR0C: Usart Control and Status Register 0 C.

; Initialise USART with the following spec:
;   1. Asychronous mode
;   2. Charater size: 8 bits
;   3. No parity coding
;   4. 1 stop bit
;   5. Enable both RXB & TXB
;   6. 9600 baud rate

.device atmega328p

.equ UCSR0A = 0xc0      ; 0b00100000 = 0x20
.equ UCSR0B = 0xc1      ; 0b00011000 = 0x18
.equ UCSR0C = 0xc2      ; 0b00000110 = 0x06
.equ UBRR0L = 0xc4      ; 103 = 64+32+4+2+1 = 0b01100111 = 0x67
.equ UBRR0H = 0xc5      ; 0x00
.equ UDR0 = 0xc6

  ldi r18, 0            ; Make r18 the zero reg.
; Initialise USART
  sts UCSR0A, r18       ; Clr UCSR0A reg.
  ldi r19, 0x18
  sts UCSR0B, r19
  ldi r19, 0x06
  sts UCSR0C, r19
  ldi r19, 0x67
  sts UBRR0L, r19
  sts UBRR0H, r18
printMsg:
  ;ldi r30, lo8(msg)
  ;ldi r31, hi8(msg)
  ;ldi r30, low(msg)
  ;ldi r31, high(msg)
loadChar:
  ;lpm r19, z+
  ;cpi r19, 0
  ;breq delayAndRepeat
  ldi r19, 69           ; Load the letter 'E' which has an ascii value of 69.
  ;rjmp delayAndRepeat
checkBit5:
  lds r20, UCSR0A
  andi r20, 0b00100000
  cpi r20, 0b00100000
  brne checkBit5
  sts UDR0, r19
  ;rjmp loadChar
delayAndRepeat:
  call delay
  rjmp printMsg
delay:
  ldi r21, 30
outer:
  ldi r22, 255
inner:
  ldi r23, 255
innerInner:
  subi r23, 1
  brne innerInner
  subi r22, 1
  brne inner
  subi r21, 1
  brne outer
  ret
msg:
  ;.db "25"
  ;.db "Programming Serial Interface!!\n"
  ;.byte 10, 13, 0
