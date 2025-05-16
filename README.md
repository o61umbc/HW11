; Demi Oloyede
; CMSC 313,
; 5/15/2025 
; To assemble: nasm -f elf32 -g -F dwarf -o ascii.o ascii.asm
; To link and load: ld -m elf_i386 -o ascii ascii.o
; To view: ./ascii

; Description: This program takes the provided hex values and prints out their ASCII characters, ex: 0x83 will be converted into 83 in the print, and so on.
; Internal documentation is available in the form of comments within code.
