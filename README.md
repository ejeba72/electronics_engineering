2023.nov28 tue 1956mf
2024jan24 wed ~0000mf
2024jan24 wed ~0930mf

Hi,

My name is Emmanuel.

I'm using this repo to sort of summarize or record what I learn along the way in electronics.

RECOMMENDED HARDWARE FOR PROGRAMMING MICROCONTROLLERS:
* usb-serial converter cable

HOW TO PROGRAM AVR MICROCONTROLLER
* AVR uses SPI for In-System Programming (ISP). This implies that you need the following four wire connections:
  ** SCK: Serial ClocK
  ** MISO: Master-In, Slave-Out
  ** MOSI: Master-Out, Slave-In
  ** Reset: Reset tells the AVR to enter programming mode
* Of course, you will also need two additional wires for power connection. That is, power (VCC) and ground (GND).


REFERENCES:
* The C Programming Language, 2nd Edition (ANSI Edition): "https://ia903407.us.archive.org/35/items/the-ansi-c-programming-language-by-brian-w.-kernighan-dennis-m.-ritchie.org/The%20ANSI%20C%20Programming%20Language%20by%20Brian%20W.%20Kernighan%2C%20Dennis%20M.%20Ritchie.pdf"

* Answers To The C Programming Language Exercises: "http://clc-wiki.net/wiki/K%26R2_solutions"
