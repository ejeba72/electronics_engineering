; 2127mf mon 15jul2024 { My 35th birthday! Yahh! :) }
; Joystick Setup. My First Attempt In Assembly Language.

; Steps:
; - Write to serial monitor.
; - Read from joystick
; - Create counters for thousands, hundreds, tens and units.

.device atmega328p

; Declare the following regs.
; - USART regs
.equ UCSR0A = 0xc0
.equ UCSR0B = 0xc1
.equ UCSR0C = 0xc2
.equ UBRR0L = 0xc4
.equ UBRR0H = 0xc5
.equ UDR0 = 0xc6
; - ADC regs
.equ ADMUX = 0x7c
.equ ADCSRA = 0x7a
.equ ADCL = 0x78
.equ ADCH = 0x79
; - Analog port
.equ DDRC = 0x27
.equ PINC = 0x26

; Initialise UCSR0B, UCSR0C, UBRR0L, UBRR0H. (I don't think there is a reason to initialise UCSR0A).
  ;andi UCSR0A, 0x20
  ldi r18, 0x18
  sts UCSR0B, r18
  ldi r18, 0x06
  sts UCSR0C, r18
  ldi r18, 103
  sts UBRR0L, r18
  ldi r18, 0
  sts UBRR0H, r18
; Initialise analog port (DDRC)
  ldi r18, 0
  sts DDRC, r18
; Initialise ADMUX and ADCSRA regs
  ldi r22, 0x87            ; Dedicate r22 to ADCSRA because the value will later be modified.
  sts ADCSRA, r18         ; Store 0x87 in ADCSRA
  ori r22, 0x40            ; Set the 6th bit. The result will later be used to to start ADC conversion.
 
serialWrite:
  ldi r20, 120             ; 'x'
  call writeToUdr
  ldi r20, 45              ; '-'
  call writeToUdr
  ldi r20, 97              ; 'a'
  call writeToUdr
  ldi r20, 120             ; 'x'
  call writeToUdr
  ldi r20, 105             ; 'i'
  call writeToUdr
  ldi r20, 115             ; 's'
  call writeToUdr
  ldi r20, 58              ; ':'
  call writeToUdr
  ldi r20, 32              ; space
  call writeToUdr

  call xAxis


  ;rjmp xAxis
;printX:

  ;mov r20, r18             ; Thousands counter
  ;call writeToUdr
  ;mov r20, r19             ; Hundreds counter
  ;call writeToUdr
  ;mov r20, r21             ; Tens counter
  ;call writeToUdr
  ;mov r20, r25             ; Units counter
  ;call writeToUdr

  ldi r20, 32              ; space
  call writeToUdr
  ldi r20, 121             ; 'y'
  call writeToUdr
  ldi r20, 45              ; '-'
  call writeToUdr
  ldi r20, 97              ; 'a'
  call writeToUdr
  ldi r20, 120             ; 'x'
  call writeToUdr
  ldi r20, 105             ; 'i'
  call writeToUdr
  ldi r20, 115             ; 's'
  call writeToUdr
  ldi r20, 58              ; ':'
  call writeToUdr
  ldi r20, 32              ; Space
  call writeToUdr

  call yAxis


  ;rjmp yAxis
;printY:

  ;ldi r20, 48              ; '0'
  ;call writeToUdr
  ;ldi r20, 48              ; '0'
  ;call writeToUdr
  ;ldi r20, 48              ; '0'
  ;call writeToUdr

  ldi r20, 10              ; Line Feed
  call writeToUdr
  ldi r20, 13              ; Carriage Return
  call writeToUdr
  call delay


  ;ret
  ;rjmp initialiseAdc
  rjmp serialWrite

readJoystick:
  sts ADCSRA, r22        ; Start ADC conversion.
  lds r18, ADCSRA
  andi r18, 0x10
  cpi r18, 0x10          ; Check if ADC conversion is complete.
  brne readJoystick
  lds r23, ADCL
  lds r24, ADCH

  lsl r24                  ;  LSL ADCH, once, in order to "create space" to transfer ADCL-bit7 to ADCH-bit0.
  mov r19, r23
  andi r19, 0x80           ; Preserve only bit7 and mask the rest.
  lsr r19                  ; Shift bit7 to bit0 (i.e. from most to least significant bit)...
  lsr r19                  ; ...in order to prepare the transfer from ADCL-bit7 to ADCH-bit0.
  lsr r19
  lsr r19
  lsr r19
  lsr r19
  lsr r19
  or r24, r19              ; Transfer ADCL-bit7 to ADCH-bit0. Because, UDRO-bit7 may be a negative flag.
  andi r23, 0x7f            ; Mask ADCL-bit7 in order to complete the transfer.

  ; Initialise Decimal counters. Avoid using r20, r22, r23, r24 (Because, they may likely still be in used).
  ldi r18, 0               ; Thousands counter
  ldi r19, 0               ; Hundreds counter
  ldi r21, 0               ; Tens counter
  ldi r25, 0               ; Units counter

  ; Bit9 (512)
  mov r26, r24
  andi r26, 0x04
  cpi r26, 0x04            ; Check if bit9 is set. ADC-bit9 is in ADCH-bit3.
  brne bit8
  ; Update hundreds counter
  ldi r26, 5
  add r19, r26
  ; Update tens counter
  ldi r26, 1
  add r21, r26
  ; Update units counter
  ldi r26, 2
  add r25, r26

bit8:                      ; bit8 = 256
  mov r26, r24
  andi r26, 0x02
  cpi r26, 0x02            ; Check if ADC-bit8 is set. ADC-bit8 = ADCH-bit2.
  brne bit7
  ; Update hundreds counter
  ldi r26, 2
  add r19, r26
  ; Update tens counter
  ldi r26, 5
  add r21, r26
  ; Update units counter
  ldi r26, 6
  add r25, r26

bit7:                      ; bit7 = 128
  mov r26, r24
  andi r26, 0x01
  cpi r26, 0x01            ; Check if ADC-bit7 is set. ADC-bit7 = ADCH-bit1.
  brne bit6
  ; Update hundreds counter
  ldi r26, 1
  add r19, r26
  ; Update tens counter
  ldi r26, 2
  add r21, r26
  ; Update units counter
  ldi r26, 8
  add r25, r26

bit6:                      ; bit6 = 64
  mov r26, r23
  andi r26, 0x40
  cpi r26, 0x40            ; Check if ADC-bit6 is set. ADC-bit6 = ADCL-bit6.
  brne bit5
  ; Update tens counter
  ldi r26, 6
  add r21, r26
  ; Update units counter
  ldi r26, 4
  add r25, r26

bit5:                      ; bit5 = 32
  mov r26, r23
  andi r26, 0x20
  cpi r26, 0x20            ; Check if ADC-bit5 is set. ADC-bit5 = ADCL-bit5.
  brne bit4
  ; Update tens counter
  ldi r26, 3
  add r21, r26
  ; Update units counter
  ldi r26, 2
  add r25, r26

bit4:                      ; bit4 = 16
  mov r26, r23
  andi r26, 0x10
  cpi r26, 0x10            ; Check if ADC-bit4 is set. ADC-bit4 = ADCL-bit4.
  brne bit3
  ; Update tens counter
  ldi r26, 1
  add r21, r26
  ; Update units counter
  ldi r26, 6
  add r25, r26

bit3:                      ; bit3 = 8
  mov r26, r23
  andi r26, 0x08
  cpi r26, 0x08            ; Check if ADC-bit3 is set. ADC-bit3 = ADCL-bit3.
  brne bit2
  ; Update units counter
  ldi r26, 8
  add r25, r26

bit2:                      ; bit2 = 4
  mov r26, r23
  andi r26, 0x04
  cpi r26, 0x04            ; Check if ADC-bit2 is set. ADC-bit2 = ADCL-bit2.
  brne bit1
  ; Update units counter
  ldi r26, 4
  add r25, r26

bit1:                      ; bit1 = 2
  mov r26, r23
  andi r26, 0x02
  cpi r26, 0x02            ; Check if ADC-bit1 is set. ADC-bit1 = ADCL-bit1.
  brne bit0
  ; Update units counter
  ldi r26, 2
  add r25, r26

bit0:                      ; bit0 = 1
  mov r26, r23
  andi r26, 0x01
  cpi r26, 0x01            ; Check if ADC-bit0 is set. ADC-bit0 = ADCL-bit0.
  brne processCounters
  ; Update units counter
  ldi r26, 1
  add r25, r26

  ldi r26, 1
processCounters:
  cpi r25, 10
  brlt tensCounter
  subi r25, 10
  add r21, r26
  rjmp processCounters

tensCounter:
  cpi r21, 10
  brlt hundredsCounter
  subi r21, 10
  add r19, r26
  rjmp tensCounter

hundredsCounter:
  cpi r19, 10
  brlt add48
  subi r19, 10
  add r18, r26
  rjmp tensCounter
; Please note: Thousands counter cannot exceed 10,000. In fact the highest value is 1,023.

add48:            ; 48 is the ascii val for 0. It needs to be added to each counter.
  ldi r26, 48
  add r18, r26              ; Thousands counter
  add r19, r26              ; Hundreds counter
  add r21, r26              ; Tens counter
  add r25, r26              ; Units counter

  mov r20, r18
  call writeToUdr
  mov r20, r19
  call writeToUdr
  mov r20, r21
  call writeToUdr
  mov r20, r25
  call writeToUdr

  ret

writeToUdr:
  lds r18, UCSR0A
  andi r18, 0x20           ; Check if UDRE0 flag (bit5) is set.
  cpi r18, 0x20
  brne writeToUdr
  sts UDR0, r20
  ret

; Counter Analogy: A counter in assembly language is like a countdown timer or stopwatch or such.

delay:
  push r18, r19, r20
  ldi r18, 17
thirdLoop:
  ldi r19, 0xff
secondLoop:
  ldi r20, 0xff
firstLoop:
  subi r20, 1
  brne firstLoop
  subi r19, 1
  brne secondLoop
  subi r18, 1
  brne thirdLoop
  pop r18, r19, r20
  ret


xAxis:
  push r18
  ldi r18, 0xc0            ; For x-axis (ADC0, i.e. PC0 or A0)
  sts ADMUX, r18
  call readJoystick
  pop r18
  ;rjmp printX
  ret
yAxis:
  push r18
  ldi r18, 0xc1            ; For y-axis (ADC1, i.e. PC1 or A1)
  sts ADMUX, r18
  call readJoystick
  pop r18
  ;rjmp printY
  ret



; Debug subroutine. I used this subroutine to debug my code.
call debug

debug:
push r26
ldi r26, 48

add r18, r26
mov r20, r18
call writeToUdr

add r19, r26
mov r20, r19
call writeToUdr

add r21, r26
mov r20, r21
call writeToUdr

add r25, r26
mov r20, r25
call writeToUdr

ldi r20, 10
call writeToUdr
ldi r20, 13
call writeToUdr
pop r26
ret
