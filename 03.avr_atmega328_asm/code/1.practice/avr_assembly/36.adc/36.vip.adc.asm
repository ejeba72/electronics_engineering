; 1010mf sun 16jun2024
; Analog-to-Digital Converter (ADC)

; Acronyms
; - ADMUX (ADC MUltipleXer selection reg)
;   - ADLAR: (ADC Left Adjust Result)

; 1st LED (blue):  D11 = PB3
; 2nd LED (blue):  D10 = PB2
; 3rd LED (blue):  D2  = PD2
; 4th LED (blue):  D3  = PD3
; 5th LED (blue):  D4  = PD4
; 6th LED (blue):  D5  = PD5
; 7th LED (blue):  D6  = PD6
; 8th LED (blue):  D7  = PD7
; 9th LED (blue):  D8  = PB0
; 10th LED (blue): D9  = PB1

.device atmega328p

.equ DDRC        = 0x27
.equ DDRD        = 0x2a
.equ DDRB        = 0x24
.equ PORTD       = 0x2B
.equ PORTB       = 0x25
.equ ADMUX       = 0x7c
.equ ADC_CON_REG = 0x7a    ; Directive for adcsra reg.
.equ ADCL        = 0x78
.equ ADCH        = 0x79

; Set ddrc0 as input reg
  ldi r18, 0
  sts DDRC, r18

; Set admux reg
  ldi r19, 0b11000000  ; internal voltage ref, ADC righ adjust result, adc0.
  sts ADMUX, r19

; Set adcsra reg
  ldi r20, 0b10000111
  sts ADC_CON_REG, r20

; Use r24 to transfer data from ADCL0 which is meant for first led (first led is connected to pb3).
  ;ldi r24, 1   ; 0b00000001 = 1
  ldi r24, 0b00000001   ; 0b00000001 = 1
  
; Use r25 to transfer data from ADCL1 which is meant for second led (second led is connected to pb2).
  ;ldi r25, 2   ; 0b00000010 = 2
  ldi r25, 0b00000010   ; 0b00000010 = 2

; Set ddrb and ddrd as output registers
  ldi r26, 0xff
  sts DDRD, r26
  sts DDRB, r26

startConversion:
  ori r20, 0b01000000     ; Set the adsc bit in adcsra reg to start conversion
  sts ADC_CON_REG, r20
  lds r21, ADC_CON_REG
  andi r21, 0b00010000
  cpi r21, 0b00010000
  brne startConversion
  lds r22, ADCL
  lds r23, ADCH
  and r24, r22            ; Extract data for first led from first pin of ADCL (ADCL0).
  and r25, r22            ; Extract data for second led from second pin of ADCL (ADCL1).
  ;lsl r24                 ; Shift the extracted data from the first bit (bit 0) of r24 to it's fourth bit (bit 3).
  ;lsl r24
  ;lsl r24
  ;lsl r25                 ; Shift the extracted data from the second bit (bit 1) of r25 to its third bit (bit 2).
  ;sts PORTB, r24          ; First led
  ;sts PORTB, r25          ; Second led
  sts PORTD, r22          ; Third led to eighth led
  sts PORTB, r23          ; Ninth and tenth led
  rjmp startConversion
