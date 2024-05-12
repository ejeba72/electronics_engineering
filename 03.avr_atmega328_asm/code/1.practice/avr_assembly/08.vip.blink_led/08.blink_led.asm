; Trying to blink led or leds
; 2024feb18 sun 1222mf

; In this practice project, I have three leds to play with in pins 8, 9, and 13. I wish that the led on pin 13 will remain on. The leds on pins 8 and 9 will blink like the blue and red lights of some ambulances, police cars or such! :)

.device atmega328p ; It is on an Arduino board.

; set the direction of the pins 8, 9, 13 to be output
  ldi r20, $23
  sts $24, r20

blinks:
  call pin8On
  call shortDelay
  call off
  call shortDelay
  call pin8On
  call shortDelay
  call off
  call longDelay
  call pin9On
  call shortDelay
  call off
  call shortDelay
  call pin9On
  call shortDelay
  call off
  call longDelay
  rjmp blinks

off:
  ldi r20, $20  ; only pin 13 is on.
  sts $25, r20  ; store in memory $25 the value in register 20 OR bit position for port b.
  ret

pin8On:
  ldi r20, $21  ; pin 8 and 13 are on.
  sts $25, r20
  ret

pin9On:
  ldi r20, $22  ; pin 9 and 13 are on.
  sts $25, r20
  ret

longDelay:
  ldi r21, $20
  ldi r22, $FF
  ldi r23, $FF
  call delayLoop

shortDelay:
  ldi r21, 4
  ldi r22, $FF
  ldi r23, $FF

delayLoop:
  subi r23, 1
  brne delayLoop
  subi r22, 1
  brne delayLoop
  subi r21, 1
  brne delayLoop
  ret

endLoop:
  rjmp endLoop
