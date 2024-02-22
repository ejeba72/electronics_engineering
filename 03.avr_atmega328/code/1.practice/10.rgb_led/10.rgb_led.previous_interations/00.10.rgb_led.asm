; BLINKING RGB LED
; 2024feb20 thu 1659mf
; FAILED ITERATION

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
  ldi r22, 20
  ldi r23, 24
  ldi r24, 28

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
  sts 0x2b, r22  ; blueAndRed
  call delay
  sts 0x2b, r23  ; greenAndRed
  call delay
  sts 0x2b, r24  ; white
  call delay
  rjmp blinks

delay:
  ldi r25, 100
  ldi r26, 255
  ldi r27, 255
  call outerLoop
  ret

outerLoop:
  subi r25, 1
  call innerLoop
  brne outerLoop
  ret

innerLoop:
  subi r26, 1
  call innerInnerLoop
  brne innerLoop
  ret

innerInnerLoop:
  subi r27, 1
  brne innerInnerLoop
  ret

; halt
  rjmp $
