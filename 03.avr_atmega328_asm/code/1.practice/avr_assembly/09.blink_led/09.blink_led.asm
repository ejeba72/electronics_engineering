; BLINKING LED, FREESTYLE APPROACH
; 2024feb19 mon 1939mf
; 2024feb25 sun ~1400mf, 

; 2ND ITERATION:
; I wish to try a different approach to the delay loops

; I wrote the last assembly code myself, '08.blink_led.asm'. However, because I am not too conversant with avr instruction set, I adopted the little instructions that I could learn immediately. But, after writing it yesterday, I did some more reasearch, including reviewing what I had learnt before with armlite little man computer. Consequently, in this practice session, my goal is to adopt a freestyle approach in writing assembly code a little bit more in my own way. I wish to write it with my own preference.

; I feel that my approach might suck to some others. But I don't care! Because, I am all about learning more and more about the computer hardware and electronics in general. Also, I am not really into syntatic sugar. But desire to imagine what the computer is doing as I write my code. In addition, I have a strong preference for learning as few instructions as possible. For me, it is not about learning as many specialised instructions as possible. Rather, it is about learning the most basic instructions, and using my imagination and knowledge of the operation of the computer to write assembly code.

; However, I am still in my 'infancy' with respect to my knowledge of computer architecture and electronics. But let me use the little I know so far to start practicing. More power to my elbow! :)

; choice of pin: d2 = pd2 (ie, digital pin 2 on arduino board)

; timer would consist of three loops: 1. innerInnerLoop, 2. innerLoop, and 3. outerLoop

; DDRD = 0x2a
; PORTD = 0x2b

; indicate device for the assembler
.device atmega328p

; load the value that will be used to set pin 2 into r18. Recall 4 = 0x4 = 0x04 = 0b00000100
  ldi r18, 0x04

; load the value that will be used to clear pin 2 into r18
  ldi r19, 0x00

; make d2 an output reg
  sts 0x2a, r18  ; store the value in r18 in the memory address, 0x2a

blinkLoop:
  sts 0x2b, r18  ; supply electricity to d2
  call delay
  sts 0x2b, r19  ; cut off electricity to d2
  call delay
  rjmp blinkLoop

; nested loop for timer
delay:
  ldi r20, 160  ; reg for outerLoop Count
outerLoop:
  subi r20, 1
  ldi r21, 255  ; reg for innerLoop Count
innerLoop:
  subi r21, 1
  ldi r22, 255  ; reg for innerInnerLoop Count
innerInnerLoop:
  subi r22, 1
  brne innerInnerLoop
  cpi r21, 0
  brne innerLoop
  cpi r20, 0
  brne outerLoop
  ret

; halt program
;haltLoop:
;  rjmp haltLoop

; better alternative to halt program
;  rjmp $  ; 'rjmp $' means 'keep looping on this single line of code'. '$' is the address of this line of code.
; update (2024feb25 sun 1459mf):
; I have recently (probably today or day before yesterday) realised that 'rjmp haltLoop' also means 'keep looping on this single line of code', because the label wil not be executed.

; halt program
pause:
  rjmp pause
