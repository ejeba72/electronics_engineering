; 1036mf tue 18jun2024
; Lcd Display

.device atmega328p

.equ DDRD = 0x2a
.equ DDRB = 0x24
.equ PORTD = 0x2b
.equ PORTB = 0x25

  ldi r18, 0xff
  ldi r19, 0
  ldi r20, 1
  ldi r21, 4
  ldi r22, 1            ; bitmask for Enable pin = 1 and RS = 0 (RS = 0 is for writing command).
  ldi r23, 3            ; bitmask for Enable pin = 1 and RS = 1 (RS = 1 is for writing data).
  ldi r24, 2            ; bitmask for Enable pin = 0 and RS = 1 (RS = 1 is for writing data).
  sts DDRD, r18         ; Set DDRD to output.
  sts DDRB, r18         ; Set DDRB to output.
  sts PORTB, r19        ; Clear PORTB with the intent of specifically clearing PB0 (Enable pin).
  rcall delayMilliSecs         ; Wait for LCD to power on.
  rcall lcdInit         ; Initialise LCD.
;======================================================================
repeat:
  rcall dispMessage     ; Display message.
  rcall commandWrite    ; Clear Screen.
  rcall delayMilliSecs
callDelaySecs:
  rcall delaySecs    ; Wait 1 second.
  subi r21, 1
  brne callDelaySecs
  rjmp repeat
;======================================================================
lcdInit:
  push r18
  ldi r18, 0x33
  rcall commandWrite    ; Init LCD for 4-bit data.
  rcall delayMilliSecs
  ldi r18, 0x32
  rcall commandWrite    ; Init LCD for 4-bit data.
  rcall delayMilliSecs
  ldi r18, 0x28
  rcall commandWrite    ; 2 lines, 5 by 7 matrix, 4-bit mode.
  rcall delayMilliSecs
  ldi r18, 0x0c
  rcall commandWrite    ; Display ON, Cursor OFF.
  ldi r18, 0x01
  rcall commandWrite    ; Clear display screen.
  rcall delayMilliSecs
  ldi r18, 0x06
  rcall commandWrite    ; Shift cursor right.
  pop r18
  ret
;======================================================================
commandWrite:
  mov r27, r18
  andi r27, 0b11110000  ; mask low nibble and keep high nibble (using 0xf0).
  sts PORTD, r27
  sts PORTB, r22        ; EN = 1, RS = 0.
  rcall delayShort
  sts PORTB, r19        ; EN = 0, RS = 0.
  rcall delayMicroSecs
  ;--------------------------------------------------------------------
  mov r27, r18
  swap r27              ; Swap the nibbles in r27.
  andi r27, 0xf0        ; Mask the low nibble in r27.
  sts PORTD, r27
  sts PORTB, r22        ; Set Enable pin (i.e. initiate high-to-low pulse).
  rcall delayShort
  sts PORTB, r19        ; Clear Enable pin.
  rcall delayMicroSecs
  ret
;======================================================================
dataWrite:
  mov r27, r18
  andi r27, 0xf0        ; Mask the low nibble, so that only the high nibble are sent to pd4 -> pd7.
  sts PORTD, r27
  sts PORTB, r23        ; Initiate high-to-low pulse. Enable pin = 1, Reg Select pin = 1 (1 is for writing data).
  rcall delayShort
  sts PORTB, r24
  rcall delayMicroSecs
  ;--------------------------------------------------------------------
  mov r27, r18
  swap r27              ; To be able to write the low nibble of r27 to pd4 -> pd7, swap its high and low nibbles.
  andi r27, 0xf0        ; Mask the nibble you don't need before writing r27 to pd4 -> pd7.
  sts PORTD, r27
  sts PORTB, r23        ; Initiate high-to-low pulse for data write.
  rcall delayShort
  sts PORTB, r24
  rcall delayMicroSecs
  ret
;======================================================================
dispMessage:
  ldi r18, 'B'          ; display character
  rcall dataWrite       ; via data register
  rcall delaySecs       ; delay about 0.25s
  ldi r18, 'e'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'r'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'n'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'a'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'r'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'd'
  rcall dataWrite
  rcall delaySecs
  ldi r18, ' '
  rcall dataWrite
  rcall delaySecs
  ldi r18, '&'
  rcall dataWrite
  rcall delaySecs
  ldi r18, ' '
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'R'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'a'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'c'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'h'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'a'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'e'
  rcall dataWrite
  rcall delaySecs
  ldi r18, 'l'
  rcall dataWrite
  rcall delaySecs
  ret
;======================================================================
delayShort:
  nop
  nop
  ret
;--------------------------------------------------------------------
delayMicroSecs:
  ldi r25, 90
callDelayShort:
  rcall delayShort
  subi r25, 1
  brne callDelayShort
  ret
;--------------------------------------------------------------------
delayMilliSecs:
  ldi r25, 40
callDelayMicroSecs:
  rcall delayMicroSecs
  subi r25, 1
  brne callDelayMicroSecs
  ret
;--------------------------------------------------------------------
delaySecs:              ; nested loop subroutine (max delay 3.11s)
  push r20, r21, r22
  ldi r20, 255          ; outer loop counter
midLoop:
  ldi r21, 255          ; mid loop counter
innerLoop:
  ldi r22, 20           ; inner loop counter to give 0.25s delay
decInner:
  dec r22
  brne decInner
  dec r21
  brne innerLoop
  dec r20
  brne midLoop
  pop r20, r21, r22
  ret
