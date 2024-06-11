; 1521mf,? sat 8jun2024
; ?,? sun 9jun2024
; 1141mf mon 10jun2024
; Emergency Vehicle Lightning. 

; STEPS:
;  - Write pushBtn logic. Use Arduino's digital pin 2 (pd2). Input.
;  - Write LED logic. Use Arduino's digital pin 3 (pd3). Output.
;  - Data direction bitmask = 0b00001000.
;  - Write btnDelay logic.
;  - Convert pushBtn to toggleBtn.
;     - When switch is open, input signal = low.
;     - When switch is close, input signal = high.
;     - Toggling a toggle button involves the following sequence: low --> high --> low.
;     - Monitor the instance when input is transitioned from high to low.
;     - Then toggle the output signal.
; TODO:
; - Blink a pair of LEDs.
; - Toggle between 3 light themes with a toggle button.
; - On and off the LEDs with a toggle button.
 
.device atmega328p

.equ PIND  = 0x29
.equ DDRD  = 0x2a
.equ PORTD = 0x2b

  ldi r18, 0b00001000      ; Load data direction bitmask into reg 18.
  sts DDRD, r18            ; Store bitmask in ddrd reg.
  ldi r20, 0               ; Make reg 20 the zero reg.

toggleBtn:
  call btnDelay
  mov r24, r19             ; update old input signal.
  lds r19, PIND
  andi r19, 0b00000100     ; Filter the input signal coming from the pin 2.
  cpi r19, 0               ; Check if new input signal is low.
  brne toggleBtn
  cpi r24, 0b00000100      ; Check if the old input signal is high.
  brne toggleBtn
  cpi r25, 0b00001000      ; Toggle output signal, since old signal is high and new signal is low.
  brne offToOn
  ldi r25, 0
  rjmp sendOutput
offToOn:
  ldi r25, 0b00001000
sendOutput:
  sts PORTD, r25           ; On or off the LED as the case may be.
  rjmp toggleBtn
  

;  cpi r19, 0b00000100     ; Check the signal in pin 2.
;  breq onLed              ; Branch to onLed if there is signal in pin 2.
;  sts PORTD, r20          ; Off LED if there is no signal in pin 2.
;  rjmp toggleBtn
;onLed:
;  sts PORTD, r18          ; On LED if there is signal in pin 2.
;  rjmp toggleBtn
btnDelay:
  ldi r21, 3               ; Note: delay loops are analogous to the multiple circular layers of an onion.
outer:
  ldi r22, 0xff
inner:
  ldi r23, 0xff
innerInner:
  subi r23, 1
  cpi r23, 0
  brne innerInner
  subi r22, 1
  cpi r22, 0
  brne inner
  subi r21, 1
  cpi r21, 0
  brne outer
  ret
