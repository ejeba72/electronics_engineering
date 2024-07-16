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
; Initialise ADMUX and ADCSRA regs
  ldi r18, 0xc0            ; For x-axis (ADC0, i.e. PC0 or A0)
  sts ADMUX, r18
  ;ldi r18, 0xc1            ; For y-axis (ADC1, i.e. PC1 or A1)
  ;sts ADMUX, r18
  ldi r22, 0x87            ; Dedicate r22 to ADCSRA because the value will later be modified.
  sts ADCSRA, r18         ; Store 0x87 in ADCSRA
  ori r22, 0x40            ; Set the 6th bit. The result will later be used to to start ADC conversion.
; Initialise analog port (DDRC)
  ldi r18, 0
  sts DDRC, r18

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
  andi r26, 0x04           ; Check if bit9 is set. Bit9 of the ADC val is in of ADCH-bit3.
  cpi r26, 0x04
  brne bit8
  ; Update hundreds counter
  mov r26, 5
  add r19, r26
  ; Update tens counter
  mov r26, 1
  add r21, r26
  ; Update units counter
  mov r26, 2
  add r25, r26


bit8:                      ; bit8 = 256



;mov r20, r23
;ldi r20, 33
;add r20, r24
;call writeToUdr




  ;call serialWrite
  rjmp readJoystick

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
  ldi r20, 48              ; '0'
  call writeToUdr
  ldi r20, 48              ; '0'
  call writeToUdr
  ;pop r19
  ;mov r20, r19              ; '0'
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
  ldi r20, 48              ; '0'
  call writeToUdr
  ldi r20, 48              ; '0'
  call writeToUdr
  ;pop r19
  ;mov r20, r19              ; '0'
  ;call writeToUdr
  ldi r20, 10              ; Line Feed
  call writeToUdr
  ldi r20, 13              ; Carriage Return
  call writeToUdr
  rjmp serialWrite

writeToUdr:
  lds r18, UCSR0A
  andi r18, 0x20           ; Check if UDRE0 flag (bit5) is set.
  cpi r18, 0x20
  brne writeToUdr
  sts UDR0, r20
  ret
