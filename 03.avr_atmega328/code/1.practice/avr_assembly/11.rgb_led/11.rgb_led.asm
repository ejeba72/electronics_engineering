; USING RGB LED TO SIMULATE BLINKING SIREN FOR EMERGENCY AND PARAMILITARY VEHICLES
; 2024mar1 fri 1223mf,

; I would add a button to the circuit such that the following color combinations can be selected:
; * Green and Blue
; * Green and Red
; * Blue and Red
; There would be a 4th switch to toggle on or off the led.
; Create a functionality that saves the last color combination before it was off, such that when next it is on, the system would blink the previous combination, as oppose to a default combination. Right now, I don't have a clue of how I can do this. However, when I can, I would implement it. But for now, there would be a default.

; Assign pd2, pd3 and pd4 to Green, Blue and Red respectively.
; For the sake of learning by practice, I have decided to randomly use any reg as my link reg, instead of lr. This is because I know it really doesn't matter. Furthermore, as long as I don't use the bl and ret instructions, I can use the lr reg for the purpose of a general reg. However, I know that I should be careful with not deleting or modifying the value in such register at the 'wrong' time. I wish I can explain better, but it's so difficult to articulate myself :(.
; Again for the sake of learning by practice, I will use the same general purpose registers that I have used in the main routine, in all the sub-routines. This will force me to use the stack multiple times, which implies practicing push and pop.

;  offset for DDRD = 0x002a0
;  offset for PORTD = 0x002b0

