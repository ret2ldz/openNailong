; boot_sect_simple.asm
[bits 16]
[org 0x7c00]

start:
    mov ah, 0x0E
    mov al, 'O'
    int 0x10

    mov al, 'p'          ; 输出字符 i
    int 0x10
    
    mov al, 'e'
    int 0x10

    mov al, 'n'          ; 输出字符 i
    int 0x10

    mov al, 'N'
    int 0x10

    mov al, 'a'          ; 输出字符 i
    int 0x10

    mov al, 'i'
    int 0x10

    mov al, 'L'          ; 输出字符 i
    int 0x10

    mov al, 'o'
    int 0x10

    mov al, 'n'          ; 输出字符 i
    int 0x10

    mov al, 'g'
    int 0x10

    mov al, '.'          ; 输出字符 i
    int 0x10
hang:
    jmp hang

; 填充为512字节
times 510 - ($ - $$) db 0
dw 0xAA55

