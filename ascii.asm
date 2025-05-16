; Demi Oloyede
; CMSC 313,
; 5/15/2025 
; To assemble: nasm -f elf32 -g -F dwarf -o ascii.o ascii.asm
; To link and load: ld -m elf_i386 -o ascii ascii.o
; To view: ./ascii

; Description: This program takes the provided hex values and prints out their ASCII characters, ex: 0x83 will be converted into 83 in the print, and so on.
; Internal documentation is available in the form of comments within code.



section .data
inputBuf:
    db  0x83,0x6A,0x88,0xDE,0x9A,0xC3,0x54,0x9A
    bufLen equ $ - inputBuf ;Determine the length of the above provided value.

section .bss
    outputBuf resb 80

section .text
    global _start

_start:
    mov esi, inputBuf; Holds the current input
    mov edi, outputBuf; Holds the current out buffer
    mov ecx, bufLen; Holds the total length of bytes.

main_loop:
    mov al, [esi]; Get this byte
    
    mov ah, al; Move the original to the high portion
    shr al, 4; Shift 4 units to the right to get high nibble
    call translationSubroutine
    mov [edi], al
    inc edi

    mov al, ah
    and al, 0x0F; Perform the operation on the low nibble
    call translationSubroutine
    mov [edi], al
    inc edi
    mov byte [edi], ' '; Add space after every byte
    inc edi
    inc esi
    
    loop main_loop; Loop again

    ;When all loops are over, print out the final result
    mov eax, 4             ; sys_write is 4
    mov ebx, 1             ; stdout is 1
    mov ecx, outputBuf     ; print output buffer

    mov edx, bufLen
    imul edx, 3
    int 0x80

    ;Print out a newline
    mov eax, 4;4 is the input for sys_write
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80; Print newline

    ;EEnd the program
    mov eax, 1; 1 is the input for sys_exit
    xor ebx, ebx
    int 0x80

; Subroutine to convert nibble to ASCII hex, this is the Extra Credit
translationSubroutine:
    cmp al, 9; Determine if this is a number or letter
    jg  .getLetter;If it has proven to be a letter, get the value
    add al, '0'
    ret
.getLetter:
    add al, 'A' - 10; Letters start at a position of 10.
    ret

section .data
newline db 0x0A
