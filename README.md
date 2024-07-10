2023.nov28 tue 1956mf

Hi,

My name is Emmanuel.

I'm using this repo to sort of summarize or record what I learn along the way in electronics.

"BUILDING BLOCKS" OF A MICROCONTROLLER:
- cpu
- ram (e.g. sram)
- flash
- rom (e.g. eeprom)
- peripheral modules (also called module types)

AVRDUDE RESOURCES:
- Git repo: https://github.com/avrdudes/avrdude
- Online documentation: https://avrdudes.github.io/avrdude/
- pdf, v7.3: https://avrdudes.github.io/avrdude/7.3/avrdude.pdf
- pdf, v5.1:  https://www.cs.ou.edu/~fagg/classes/general/atmel/avrdude.pdf

AVRA RESOURCES:
- https://github.com/Ro5bert/avra
- https://avra.sourceforge.net/README.html
- https://manpages.debian.org/unstable/avra/avra.1.en.html

RECOMMENDED HARDWARE FOR PROGRAMMING MICROCONTROLLERS:
- usb-serial converter cable

HOW TO PROGRAM AVR MICROCONTROLLER
- AVR uses SPI for In-System Programming (ISP). This implies that you need the following four wire connections:
    - SCK: Serial ClocK
    - MISO: Master-In, Slave-Out
    - MOSI: Master-Out, Slave-In
    - Reset: Reset tells the AVR to enter programming mode
- Of course, you will also need two additional wires for power connection. That is, power (VCC) and ground (GND).

POINTER
  A pointer is a value that is meant to be used as a memory address. (A pointer is a value in a register or memory address that is meant (or intended) to be used as memory address).

ASSEMBLY LANGUAGE
- "i" should (not always) mean "an immediate (value or data)" in a mnemonic.
- Every line of assembly code is either:
    - an instruction,
    - a directive,
    - a label,
    - a comment,
    - a combination of the above, or
    - an empty line.
- The maximum number of entities in a line of assembly code is four (4), Namely:
    - label (e.g. startLoop:)
    - instruction/directive
    - operands
    - comment  (e.g. ; This is a comment)
- This is how a typical line of assembly code could be written:
    - [label:] instruction/directive [operands] [; comment]
    - The square brackets indicate that those components within the square brackets are optional for a line of instruction or directive. Also, it is possible to write a comment or a label in its own line. However, operands can only follow an instruction if required. In other words, operands cannot be written in seperate lines. Nonetheless, there is no need to cram or memorise these details the understanding would come naturally as one continues to learn and practice.

I/O REGISTERS:
https://www.rjhcoding.com/avr-asm-io.php

SRAM AND EXTENDED I/O:
- https://www.rjhcoding.com/avr-asm-sram.php

LOAD PROGRAM MEMORY(LPM):
- https://www.rjhcoding.com/avr-asm-pm.php

ASSEMBLE AND FLASH ASSEMBLY CODE
- "avra 06.filename.asm"
- "avrdude -U flash:w:filename.hex:i -c arduino -p atmega328p -P /dev/cu.usbserial-11230 -b 115200"
- BREAKDOWN: The above command has 6 components (an executable command and 5 flags)
    - "avrdude": this is the executable command.
    - the 5 flags are -p(partno), -U(memory operation), -c(programmer), -P(port), -b(baudrate).
    - "-p" flag: literarily means "partno". This specifies the microcontroller to be programmed. NOTE: "atmega328p" is the same as "m328p".
    - "-U" flag: indicates that a memory operation is to be performed. It could be write, read or erase memory operation.
        - "flash": indicates that the memory in which a memory operation would performed on, is the flash memory.
        - "w": write memory operation.
        - "i": indicate that the file is intex HEX format.
    - "-c" flag: specifies the programmer to be used to program the microcontroller.
    - "-P" flag: specifies the port to which the programmer is connected.
        - NOTE: you can use the following commands to find the port where the programmer is connected on your computer:
            - Unix, Linux or Mac:
                - "ls /dev/cu.*" or
                - "ls /dev | grep cu" or
                - "ls /dev | grep usb" (if the connection is specifically a USB connection)
                    - NOTE: cu (communications, unbuffered) is preferred to tty (teletype) when flashing microcontrollers.
                - Windows: "mode" This will list all available COM ports in Command Prompt.
    - "-b" flag: specifies the baud rate for communication with the programmer. Default baud rate is 115200 baud. That is, no need to specify baud rate, if baud rate is 115200 baud.
        - NOTE: For Nano, baud rate is 57600 baud (115200/2). That is, "-b 57600".
- GENERAL TIPS: Provided avrdude has been installed, you can type the following on the commandline for help or more info:
    - "man avrdude"
    - "avrdude -h"

 ARDUINO-CLI
- General tip, provided arduino-cli has been installed:
    - On the commandline, type "arduino-cli -h" for the various commands
- Compile tip:
    - type "arduino-cli compile -h" to know more about the compile command. The same approach for other commands.
- Upload command:
    - "arduino-cli upload /home/user/Arduino/MySketch -p /dev/ttyACM0 -b arduino:avr:uno"
    - NOTE: When uploading to Nano board with old bootloader, -b is "arduino:avr:nano:cpu=atmega328old". That is, include "cpu=atmega328old" to the board name flag. Source: https://github.com/arduino/arduino-cli/issues/538.

SERIAL MONITOR FROM THE COMMANDLINE
- screen:
    - "screen /dev/ttyACMO 9600"  (i.e. screen path baudrate)
- stty:
    - "stty -f /dev/ttyACMO speed 9600" ("-f" for freebsd, mac. "-F" for Linus ditros. I assume that "-f" or "-F" stands for "filepath". I stand to be corrected. :) )
- arduino-cli:
    - "arduino-cli monitor -p /dev/ttyACMO" (I assume that "-p" stands for "path" which is the same as "filepath". Again, I stand to be corrected.)

REFERENCES:
- The C Programming Language, 2nd Edition (ANSI Edition):
    - https://ia903407.us.archive.org/35/items/the-ansi-c-programming-language-by-brian-w.-kernighan-dennis-m.-ritchie.org/The%20ANSI%20C%20Programming%20Language%20by%20Brian%20W.%20Kernighan%2C%20Dennis%20M.%20Ritchie.pdf
- Answers To The C Programming Language Exercises:
    - http://clc-wiki.net/wiki/K%26R2_solutions
- Atmel 8-bit microcontroller with 4/8/16/32kbytes in-system programmable flash:
    - https://web.archive.org/web/20160412093102/http://www.atmel.com/Images/Atmel-8271-8-bit-AVR-Microcontroller-ATmega48A-48PA-88A-88PA-168A-168PA-328-328P_datasheet_Summary.pdf
