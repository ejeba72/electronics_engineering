; ~1050mf,1140mf wed 20may2024
; TOGGLE BUTTON FOR DUAL BLINKING LED

; Blue led      --> arduino pin2 = PD2. Therefore bitmask = 0b00000100 (3rd bit) = 0x04 = 4
; Red led       --> arduino pin3 = PD3. Therefore bitmask = 0b00001000 (4th bit) = 0x08 = 8
; Toggle button --> arduino pin4 = PD4. Therefore bitmask = 0b00010000 (5th bit) = 0x0f = 16
; PIND  = 0x29
; DDRD  = 0x2a
; PORTD = 0x2b

; Plan:
; ledState            ---> 0 or 1. Initial value = 0.
; previousInputSignal ---> 0 or 1. Initial value = 1.
; newInputSignal      ---> 0 or 1. No initial value.

.device atmega328p
  ldi r18, 4            ; blueLed reg.
  ldi r19, 8            ; redLed reg.
  ldi r20, 0            ; zero reg.
  ldi r21, 12           ; data direction.
  sts 0x2a, r21         ; set 3rd and 4th bit of DDRD to output bits (by implication every other bit is set to input bits).
  ldi r28, 0            ; Initialise r28 (ledState reg) to 0.
toggleButtonMonitor:
  ldi r26, 16           ; Loading the value that will be used to perform a AND operation on r25.
  lds r25, 0x29         ; Reading input value from PIND.
  and r26, r25          ; AND operation to isolate the value coming from the 5th bit in PIND.
  cpi r27, 0            ; Compare previousInputSignal with 0.
  brne ledState
  cpi r26, 16           ; Compare newInputSignal in the 5th bit with 1.
  brne ledState
  cpi r28, 0            ; The goal in these few lines of code is to toggle the value of r28 (ledState reg) btw 0 & 1.
  breq zeroToOne
  ldi r28, 0
zeroToOne:
  ldi r28, 16
ledState:
  mov r27, r26          ; Update previousInputSignal with newInputSignal.
  cpi r28, 16
  brne toggleButtonMonitor
  call blinkLeds
  rjmp toggleButtonMonitor
blinkLeds:
  sts 0x2b, r18         ; blink LEDs
  call shortDelay
  sts 0x2b, r20
  call shortDelay
  sts 0x2b, r18
  call shortDelay
  sts 0x2b, r20
  call longDelay
  sts 0x2b, r19
  call shortDelay
  sts 0x2b, r20
  call shortDelay
  sts 0x2b, r19
  call shortDelay
  sts 0x2b, r20
  call longDelay
  ret
shortDelay:
  ldi r22, 4
  ldi r23, 255
  ldi r24, 255
outer:
  subi r22, 1
inner:
  subi r23, 1
innerInner:
  subi r24, 1
  cpi r24, 0
  brne innerInner
  cpi r23, 0
  brne inner
  cpi r22, 0
  brne outer
  ret
longDelay:
  ldi r22, 60
  ldi r23, 255
  ldi r24, 255
outerLong:
  subi r22, 1
innerLong:
  subi r23, 1
innerInnerLong:
  subi r24, 1
  cpi r24, 0
  brne innerInnerLong
  cpi r23, 0
  brne innerLong
  cpi r22, 0
  brne outerLong
  ret
