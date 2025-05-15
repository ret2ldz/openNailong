; boot_sect_simple.asm
[org 0x7c00]
    mov bp, 0x9000 ; set the stack
    mov sp, bp
    mov bx, mystring
    call print
    call print_nl
    mov bx, MSG_REAL_MODE
    call print ;  
    call switch_to_pm

    jmp $ ;
mystring :
    db 'OpenNaiLong', 0

%include "boot_sect_print.asm"
%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"
%include "32bit-print-tty.asm"

[bits 32]
BEGIN_PM: ; after the switch we will get here
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Note that this will be written at the top left corner
    call init_serial1    
    mov ebx, MSG_PROT_MODE
    call print_string_pm1 ;  
    jmp $



; data


MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

; 填充为512字节
times 510 - ($ - $$) db 0
dw 0xaa55

