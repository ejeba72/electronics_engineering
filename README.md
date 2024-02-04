2023.nov28 tue 1956mf

Hi,

My name is Emmanuel.

I'm using this repo to sort of summarize or record what I learn along the way in electronics.

"BUILDING BLOCKS" OF A MICROCONTROLLER:
* cpu
* ram (e.g. sram)
* flash
* rom (e.g. eeprom)
* peripheral modules (also called module types)

RECOMMENDED HARDWARE FOR PROGRAMMING MICROCONTROLLERS:
* usb-serial converter cable

HOW TO PROGRAM AVR MICROCONTROLLER
* AVR uses SPI for In-System Programming (ISP). This implies that you need the following four wire connections:
  ** SCK: Serial ClocK
  ** MISO: Master-In, Slave-Out
  ** MOSI: Master-Out, Slave-In
  ** Reset: Reset tells the AVR to enter programming mode
* Of course, you will also need two additional wires for power connection. That is, power (VCC) and ground (GND).

ASSEMBLY LANGUAGE
* "i" should mean "an immediate (value or data)" in a mnemonic.
* Every line of assembly code is either:
  ** an instruction,
  ** a directive,
  ** a label,
  ** a comment,
  ** a combination of the above, or
  ** an empty line.
* The maximum number of entities in a line of assembly code is 4. Namely:
  [label:] instruction/directive [operands] [; comment]

REFERENCES:
* The C Programming Language, 2nd Edition (ANSI Edition): "https://ia903407.us.archive.org/35/items/the-ansi-c-programming-language-by-brian-w.-kernighan-dennis-m.-ritchie.org/The%20ANSI%20C%20Programming%20Language%20by%20Brian%20W.%20Kernighan%2C%20Dennis%20M.%20Ritchie.pdf"
* Answers To The C Programming Language Exercises: "http://clc-wiki.net/wiki/K%26R2_solutions"
* Atmel 8-bit microcontroller with 4/8/16/32kbytes in-system programmable flash: "https://web.archive.org/web/20160412093102/http://www.atmel.com/Images/Atmel-8271-8-bit-AVR-Microcontroller-ATmega48A-48PA-88A-88PA-168A-168PA-328-328P_datasheet_Summary.pdf"
