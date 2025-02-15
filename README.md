2023.nov28 tue 1956mf

Hi,

My name is Emmanuel.

I'm using this repo to sort of summarize or record what I learn along the way in electronics.

IMPORTANT TERMS:
  - Pointer:
    -- Basically, a pointer is a value that is meant to be used as a memory address. That is, A pointer is a value in a register or memory address that is intended to be used as a memory address.
    -- In the context of C, pointer is a variable that contains the memory address of a variable.
  - Variable: A variable is a named reference to a location in memory that holds data, and this data can change during execution
  - Set a bit: Write 1 to a bit.
  - Clear a bit: Write 0 to a bit.
  - Set a register: Write 1 to every bit in a register.
  - Clear a register: Write 0 to every bit in a register.

ACCRONYMS:
  - reg: register
  - val: value
  - var: variable
  - const: constant

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

LABEL: A label is an arbitrary name that is used to "label" (identify) a memory location. Furthermore, a label can also be used to initialise a constant or variable.

NOTE: To the best of my knowledge so far, a symbol is a synonym of a label. That is, a symbol is effectively the same thing as a label in assembly language. However, I perceive that there may be nuance or technical difference between the two. It could be that a symbol is a type of label. Related terms: label, symbol, symbolic label.

ASSEMBLER DIRECTIVES
- SET: Set a label equal to an expression.
    The set directive assigns a value to a label. This label can then be used in later expressions. A label assigned to a value by the set directive can be changed (redefined) later in the program.

- EQU: Set a label equal to an expression.
    The equ directive assigns a value to a label. This label can then be used in later expressions. Unlike the set directive, a label assigned to a value by the equ directive is a constant and cannot be changed or redefined.

I/O REGISTERS:
https://www.rjhcoding.com/avr-asm-io.php

SRAM AND EXTENDED I/O:
- https://www.rjhcoding.com/avr-asm-sram.php

LOAD PROGRAM MEMORY(LPM):
- https://www.rjhcoding.com/avr-asm-pm.php

ASSEMBLE ASSEMBLY PROGRAM:
- "avra 06.filename.asm"

FLASH INTO MICROCONTROLLER:
- "avrdude -U flash:w:filename.hex:i -c arduino -p atmega328p -P /dev/cu.usbserial-11230 -b 115200"
- BREAKDOWN: The above command has 6 components (an executable command and 5 flags)
    - "avrdude": this is the executable command.
    - the 5 flags are -p(partno), -U(memory operation), -c(programmer), -P(port), -b(baudrate).
    - "-p" flag: literarily means "partno". This specifies the microcontroller to be programmed. NOTE: "atmega328p" is the same as "m328p".
    - "-U" flag: indicates that a memory operation is to be performed. It could be write, read or erase memory operation.
        - "flash": indicates that the memory in which a memory operation would performed on, is the flash memory.
        - "w": write memory operation.
        - "i": indicate that the file is intex HEX format (":i" could be optional).
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
        - NOTE: For Nano, baud rate is 57600 baud (115200/2). That is, "-b 57600". However, it could be that the baud rate of newer Nano boards may be 115200. So if 57600 doesn't work, try 115200 and vice versa.
- GENERAL TIPS: Provided avrdude has been installed, you can type the following on the commandline for help or more info:
    - "man avrdude"
    - "avrdude -h"

C LANGUAGE

TOOLS REQUIRED FOR COMPILING AND FLASHING C CODE

MACOS:
AVR-GCC TOOLCHAIN:
- brew tap osx-cross/avr
- brew install avr-gcc
NOTE: avr-gcc toolchain contains several tools including avr-gcc and avr-objcopy commands.
AVRDUDE:
- brew install avrdude

LINUX:
I'm yet to know.

WINDOWS:
I'm yet to know.

COMPILE C PRGRAM:
- "avr-gcc -mmcu=atmega328p -DF_CPU=16000000UL -Os -o blink.elf blink.c"
BREAKDOWN:
    - -mmcu=atmega328p: Target ATmega328P (Nano's microcontroller).
    - -DF_CPU=16000000UL: Clock frequency of 16 MHz.
    - -Os: Optimize for size.
    - -o blink.elf: Output file for the compiled object.

CONVERT ".elf" FILE TO ".hex" FILE.
- "avr-objcopy -O ihex -R .eeprom blink.elf blink.hex"
BREAKDOWN:
    - avr-objcopy: Tool to convert and extract sections from object files.
    - -O: the -O flag should stand for 'output format'. Good mnemonic. But subject to confirmation.
    - ihex: Output format is Intel HEX, suitable for microcontroller flashing.
    - -R: The -R flag should stand for remove. At least it's a good mnemonic.
    - .eeprom: Excludes the .eeprom section (which may contain EEPROM data) from the output.
    - blink.elf: Input file in ELF format (with program and debug data).
    - blink.hex: Output file in HEX format, ready for flashing.
    NOTE: Follow the order of the flags for this command, especially for the last two components, the input and output files. I suspect that the output file must be the last component of this command. I will confirm all these as soon as the opportunity arises to learn more.

FLASH INTO MICROCONTROLLER:
- "avrdude -c arduino -p m328p -P /dev/tty.usbserial-XXXXXX -b 115200 -U flash:w:blink.hex"
BREAKDOWN:
    - -c arduino: Specifies the Arduino protocol.
    - -p m328p: Microcontroller type (ATmega328P).
    - -P /dev/tty.usbserial-XXXXXX: Serial port for Nano (update based on your device).
    - -b 115200: Baud rate for Nano bootloader.
    - -U flash:w:blink.hex: Write the hex file to flash memory.

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
    - "screen /dev/ttyACMO 9600"  (i.e. screen [PATH] [BAUDRATE])
    - "C-a C-\", to quit.
    - "C-a ?", for help.
- stty:
    - First step: "stty -f /dev/ttyACMO speed 9600" (Use "-f" for freebsd and mac. Use "-F" for Linux distros. I assume that "-f" or "-F" stands for "filepath". I stand to be corrected. :) )
    - Second step: "cat /dev/ttyACMO"
    - "C-c", to quit.
- arduino-cli:
    - "arduino-cli monitor -p /dev/ttyACMO" (I assume that "-p" stands for "path" which should be the same as "filepath". Again, I stand to be corrected.)

ANALOG TO DIGITAL CONVERTER PROGRAM, BASIC STEPS:
1. Set the ADMUX and ADCSRA regs to your desired preferences.
2. Set the desired pin(s) in the analog port (DDRC) as input reg.
3. Set the desired pins in DDRD and/or DDRB port as output reg.
4. Start the ADC conversion by setting the ADSC bit (bit6) in ADCSRA reg.
5. Check if the the ADC conversion is complete by checking if the ADIF flag (bit4) in ADCSRA reg is set.
6. If no, start again from step 4.
7. If yes, read the data from from ADCL and ADCH.
8. Start again from step 4.

SERIAL MONITOR PROGRAM, BASIC STEPS:
1. You will be working with the UCSR0A, UCSR0B, UCSR0C, UBRR0L, UBRR0H, and UDR0.
2. Initialise UCSR0B, UCSR0C, UBRR0L and UBRR0H regs with your desired vals.
3. Check if the UDRE0 bit (bit5) in the UCSR0A reg is set.
4. If no, repeat step 3.
5. If yes, write an ascii val to the UDR0 reg.

REFERENCES:
- set directive:
    - https://onlinedocs.microchip.com/pr/GUID-E06F3258-483F-4A7B-B1F8-69933E029363-en-US-2/index.html?GUID-21F01B2A-E5C5-4E4B-97B1-F6664744A510
- equ directive:
    - https://onlinedocs.microchip.com/pr/GUID-E06F3258-483F-4A7B-B1F8-69933E029363-en-US-2/index.html?GUID-B43C78EC-F26F-4DD4-AA2B-7973B3C6A4A1
- The C Programming Language, 2nd Edition (ANSI Edition):
    - https://ia903407.us.archive.org/35/items/the-ansi-c-programming-language-by-brian-w.-kernighan-dennis-m.-ritchie.org/The%20ANSI%20C%20Programming%20Language%20by%20Brian%20W.%20Kernighan%2C%20Dennis%20M.%20Ritchie.pdf
- Answers To The C Programming Language Exercises:
    - http://clc-wiki.net/wiki/K%26R2_solutions
- Atmel 8-bit microcontroller with 4/8/16/32kbytes in-system programmable flash:
    - https://web.archive.org/web/20160412093102/http://www.atmel.com/Images/Atmel-8271-8-bit-AVR-Microcontroller-ATmega48A-48PA-88A-88PA-168A-168PA-328-328P_datasheet_Summary.pdf
