; LEARNING ASSEMBLY WITH LED
; 2024feb18 sun 0916mf

; I wish to work with pin 8, 9, and 13.
; 8=PB0, 9=PB1, 13=PB5.
; DDRB=$24, PORTB=$25.

.device atmega328p

;  ldi r21, 0b00100011
;  ldi r21, $35  ; wrong. I'm trying to convert binary to hex. Ended up with the value in decimal. Also, there is another detail I forgot to consider which I understand but is hard for me to explain. In trying to get the hex, the binary is grouped into groups of 4 binary digits each. This is what I forgot to consider. Consequently, I ended up with the wrong decimal value of 35. If I factor what I what I forgot to consider, I would have two decimal values (each decimal value could be single-digit or double-digit, but certainly not triple-digit. In fact the maximum attainable decimal value would be 15) or two hexadecimal values (each hex value would be certainly a single-digit value, with the maximum attainable value been $F). I just realise, that there is a detail about the aforementioned decimal conversion that effectively makes it a hex conversion. That is, I'm still confuse somewhere with what I've written above.
  ldi r21, $23
;  ldi r21, 35  ; Don't just mind me jare! What I wrote above, on the line that has the "ldi r21, $35", about decimal conversion is wrong (at least some of it, if not all). I got a wrong result, with that line of code because I converted bin to decimal, but wrote or presented it as hex. Now that I have written the decimal value in the correct format in which decimal is written, I am getting the expected and desired result.
  sts $24, r21

  sts $25, r21

loop:
  rjmp loop
