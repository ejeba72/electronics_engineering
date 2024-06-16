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

; STEPS:
; 1. Set the desired pin(s) in the analog port (DDRC) as input reg.
; 2. Set the ADMUX and ADCSRA regs to your desired preferences.
; 3. Set the desired pins in DDRD and/or DDRB port as output reg.
; 4. Enable ADC conversion (i.e. set the ADSC bit in ADCSRA reg to start conversion).
; 5. Check ADIF flag in ADCSRA reg to ascertain if conversion is complete.
; 6. If no, start again from step 4.
; 7. If yes, read the data from from ADCL and ADCH.

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

; Set DDRC0 as input reg
  ldi r18, 0
  sts DDRC, r18
; Set ADMUX reg
  ldi r19, 0b11000000  ; internal voltage ref, ADC righ adjust result, adc0.
  sts ADMUX, r19
; Set ADCSRA reg
  ldi r20, 0b10000111
  sts ADC_CON_REG, r20
; Set DDRB and DDRD as output registers
  ldi r26, 0xff
  sts DDRD, r26
  sts DDRB, r26
startConversion:
  ori r20, 0b01000000     ; Set the ADSC bit in ADCSRA reg to start conversion.
  sts ADC_CON_REG, r20
  lds r21, ADC_CON_REG    ; Check ADIF flag in ADCSRA reg to ascertain if conversion is complete.
  andi r21, 0b00010000
  cpi r21, 0b00010000
  brne startConversion
  lds r22, ADCL
  lds r23, ADCH
  ldi r24, 0b00000001     ; Use r24 to extract data for PB3 (first LED is connected to PB3).
  ldi r25, 0b00000010     ; Use r25 to extract data for PB2 (second LED is connected to PB2).
  and r24, r22            ; Extract data for first LED from first pin of ADCL (ADCL0).
  and r25, r22            ; Extract data for second LED from second pin of ADCL (ADCL1).
  lsl r24                 ; Shift the extracted data from the first bit (bit 0) of r24 to it's fourth bit (bit 3).
  lsl r24
  lsl r24
  lsl r25                 ; Shift the extracted data from the second bit (bit 1) of r25 to its third bit (bit 2).
  or r23, r24             ; Include the shifted data in r24 to the data in r23 (data in r24 is for first LED).
  or r23, r25             ; Also include the shifted data in r25 to the data in r23 (data in r25 is for second LED).
  sts PORTB, r23          ; Ninth and tenth LEDs (PB0 and PB1), first and second LEDs (PB2 and PB3).
  sts PORTD, r22          ; Third LED to eighth LED (PD2 to PD7).
  rjmp startConversion
