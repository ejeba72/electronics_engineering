; BLINKING RGB LED
; 2024feb20 thu 1659mf
; PARTIAL SUCCESS: WHITE, AND THE OTHER COMBINATIONS ARE NOT DISPLAYING

.device atmega328p

; address of ddrd = 0x2a
; address portd = 0x2b

; let pd2 = blue, pd3 = green, pd4 = red.
; blue pin mask: 4
; green pin mask: 8
; red pin mask: 16
; blueAndGreen pin mask: 12
; blueAndRed pin mask: 20
; greenAndRed pin mask: 24
; white pin mask: 0b00011100 = 0x1c = 28

; load pin mask into seperate registers. Since there are sufficient registers, it is more efficient, with respect to the various loops, to load them into seperate regs.
  ldi r18, 4
  ldi r19, 8
  ldi r20, 16
  ldi r21, 12

; set the data direction register to make pd2, pd3 and pd4 output pins
  sts 0x2a, r18

blinks:
  sts 0x2b, r18  ; blue light
  call delay
  sts 0x2b, r19  ; green
  call delay
  sts 0x2b, r20  ; red
  call delay
  sts 0x2b, r21  ; blueAndGreen
  call delay
  ldi r21, 20  ; blueAndRed
  sts 0x2b, r21
  call delay
  ldi r21, 24  ; greenAndRed
  sts 0x2b, r21
  call delay
  ldi r21, 28  ; white
  sts 0x2b, r21
  call delay
  rjmp blinks

delay:
  ldi r22, 100  ; outerLoop count
  ldi r23, 255  ; innerLoop count
  ldi r24, 255  ; innerInnerLoop count
  call delayLoop
  ret

delayLoop:
  subi r24, 1
  brne delayLoop
  subi r23, 1
  brne delayLoop
  subi r22, 1
  brne delayLoop
  ret

; halt
  rjmp $
