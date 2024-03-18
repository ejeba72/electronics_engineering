; 1718mf mon 18mar2024
; BLINKING RGB

; MINDSET BEHIND CODE
; ATmega328P assumption for ARMlite:
;   * Offset for DDRD = 0x002a0,
;   * Offset for PORTD = 0x002b0,

; To make Arduino Digital Pins d2, d3, and d4 output pins.
; That is, the value for memory address 0x002a0 = 0b00011100 = 0x1c = 28

; To make each of the d2, d3, and d4 pins to light up respectively.
; For d2, memory address 0x002b0 = 0b00000100 = 0x04 = 4
; For d3, memory address 0x002b0 = 0b00001000 = 0x08 = 8
; For d4, memory address 0x002b0 = 0b00010000 = 0x10 = 16

; Let Red, Green and Blue leds be connected to pins d2, d3, d4 respectively.
; NOTE: values placed in DDRD (0x002a0) and PORTD (0x002b0) can be called bitmasks. In fact, 28, 4, 8, and 16 are bitmasks.
; In order to skip one step and consequently have a faster program, I will dedicate r0, r1, and r2 to store the bitmasks for lighting up the Red (d2), Green (d3) and Blue (d4) leds respectively.

; I assume before the first blinking operation that PORTD = 0x00 (ie that every pin is off), otherwise that should be the first thing to do.


; CODE SECTION
; Make d2, d3, d4 output pins
  mov r0, #28    ; mov into reg r0 the immediate value 28
  str r0, 0x002a0    ; str the value in reg r0 in mem addr 0x002a0

; Store Red, Green and Blue bitmasks in r0, r1, and r2 regs respectively
  mov r0, #4    ; Red
  mov r1, #8    ; Green
  mov r2, #16    ; Blue
  mov r3, #0    ; to turn off all pins

; Blink Red led on and off
  str r0, 0x002b0
; delay
;insert delay code here
  str r3, 0x002b0
; delay
;insert delay code here

; Blink Green led on and off
  str r1, 0x002b0
; delay
;insert delay code here
  str r3, 0x002b0
; delay
;insert delay code here

; Blink Blue led on and off
  str r2, 0x002b0
; delay
;insert delay code here
  str r3, 0x002b0
; delay
;insert delay code here

