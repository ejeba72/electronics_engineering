; 0139mf mon 15jul2024
; Reading pot vals using USART and LEDs. 

.device atmega328p

; ADC-Potentiometer Directives
.equ ADMUX = 0x7c
.equ ADCSRA = 0x7a
;.equ ADCL = 0x78     I have decided to comment out ADCL, because I would no longer be needing it in my code.
.equ ADCH = 0x79
.equ DDRC = 0x27
.equ DDRD = 0x2a
.equ DDRB = 0x24
.equ PORTD = 0x2b
.equ PORTB = 0x25

; ADC-Potentiometer Setup
  ldi r18, 0xe0       ; 0b11100000 = 0xe0. I have also set the ADLAR (bit5), because I wish to deal with 8bits.
  sts ADMUX, r18
  ldi r19, 0x87       ; 0b10000111 = 0x87 (Dedicate r19 to ADCSRA, because its val will be modified).
  sts ADCSRA, r19
  ori r19, 0x40       ; 0x40 = 0b01000000 (Set the bit0. This new value will be used to start conversion.)
  ldi r18, 0
  sts DDRC, r18       ; set DDRC as input reg by clearing its bits.
  ldi r18, 0xff
  sts DDRB, r18       ; set DDRB as output reg.
  lds r18, DDRD
  ori r18, 0xfc       ; 0xfc = 0b11111100. I wish to avoid modifying bit0 and bit1.
  sts DDRD, r18       ; Set bit2 to bit7 as output bits and leave bit0 and bit 1 unaltered.

; USART Directives
.equ UCSR0A = 0xc0
.equ UCSR0B = 0xc1
.equ UCSR0C = 0xc2
.equ UBRR0L = 0xc4
.equ UBRR0H = 0xc5
.equ UDR0 = 0xc6

; USART Setup
  ldi r18, 0x18
  sts UCSR0B, r18
  ldi r18, 0x06
  sts UCSR0C, r18
  ldi r18, 0x67       ; 0b01100111
  sts UBRR0L, r18
  ldi r18, 0
  sts UBRR0H, r18

  ldi r22, 48         ; 48 is the ascii val for zero.
; ADC-Potentiometer Loop
readAdc:
  sts ADCSRA, r19     ; Start conversion by setting the 6th bit in ADCSRA.
  lds r18, ADCSRA     ; Check if bit4 (ADIF flag) is set.
  andi r18, 0x10
  cpi r18, 0x10
  brne readAdc
  lds r18, ADCH
  ; Write to LEDs
  mov r20, r18
  lsl r20
  lsl r20
  sts PORTD, r20
  mov r20, r18
  lsr r20
  lsr r20
  lsr r20
  lsr r20
  lsr r20
  lsr r20
  sts PORTB, r20
  ; Write to USART in decimal. Start with processing most significant decimal digit.
  ; Initialise counters for hundreds, tens, units
  ldi r23, 0          ; hundreds counter
  ldi r24, 0          ; tens counter
  ldi r26, 0          ; units counter
  mov r20, r18
  ; Check if bit7 (negative bit) is set.
  andi r20, 0x80
  cpi r20, 0x80
  brne continue
  ; 128 = 100 + 20 + 8. Therefore, update the various counters accordingly.
  ldi r23, 1
  ldi r24, 2
  ldi r26, 8          ; Later in the program, check that the val in the units counter does not exceed 9.
continue:
  mov r20, r18
  andi r20, 0x7f
hundredsCounter:
  cpi r20, 100
  brlt tensCounter
  subi r20, 100
  inc r23
  rjmp hundredsCounter
tensCounter:
  cpi r20, 10
  brlt checkUnitsCounter
  subi r20, 10
  inc r24
  rjmp tensCounter
checkUnitsCounter:
  add r26, r20        ; Since r20 is now less 10, add it to the units counter.
  cpi r26, 10         ; Check that the val in the units counter does not exceed 9.
  brlt checkTensCounter
  subi r26, 10
  inc r24
checkTensCounter:
  cpi r24, 10         ; Check that the val in the tens counter does not exceed 9.
  brlt checkHundredsCounter
  subi r24, 10
  inc r23
checkHundredsCounter:
  ;ldi r23, 13        ; This is to manually test the error message because error is unlikely.
  cpi r23, 10         ; Check that the val in the hundreds counter does not exceed 9.
  brlt writeDecNum
  call errorMsg
  rjmp readAdc
writeDecNum:
  add r23, r22        ; Write hundreds
  mov r25, r23
  call writeToUsart
  add r24, r22        ; Write tens
  mov r25, r24
  call writeToUsart
  add r26, r22        ; Write units
  mov r25, r26
  call writeToUsart
  call lineFeed
  rjmp readAdc
lineFeed:
  ldi r25, 10
  call writeToUsart
  ldi r25, 13
  call writeToUsart
  call delay
  ret
writeToUsart:
  lds r21, UCSR0A
  andi r21, 0x20
  cpi r21, 0x20
  brne writeToUsart
  sts UDR0, r25       ; Write into the UDR0 reg, if the UDRE0 bit (bit5) in the UCSR0A reg is set.
  ret
errorMsg:
  ldi r25, 69         ; 'E'
  call writeToUsart
  ldi r25, 114        ; 'r'
  call writeToUsart
  ldi r25, 114        ; 'r'
  call writeToUsart
  ldi r25, 111        ; 'o'
  call writeToUsart
  ldi r25, 114        ; 'r'
  call writeToUsart
  ldi r25, 33         ; '!'
  call writeToUsart
  call lineFeed
  ret
delay:
  push r18
  push r19
  push r20
  ldi r18, 25
third:
  ldi r19, 255
second:
  ldi r20, 255
first:
  subi r20, 1
  brne first
  subi r19, 1
  brne second
  subi r18, 1
  brne third
  pop r18
  pop r19
  pop r20
  ret
