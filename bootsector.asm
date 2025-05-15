；bootsect.asm

[org 0x7C00]

KERNEL_OFFSET equ 0x0 ; 在这里定义一个宏来指定内核的位置

    mov [BOOT_DRIVE], dl ; BIOS sets the boot drive in 'dl' register on boot
    mov bp, 0x9000 ; build a stack whose stack base is 0x9000
    mov sp, bp
    mov bx,mystring
    call print
    call print_nl  
    mov bx, MSG_REAL_MODE
    call print
    call print_nl
    
    call load_kernel ; read kernel from disk (actually from memroy)
    call switch_to_pm ; disable interrupts, load GDT, etc. Finally jumps to 'BEGIN_PM'
    jmp $ ; never executed

%include "boot_sect_print.asm"
%include "boot_sect_disk.asm"
%include "boot_sect_print_hex.asm"

%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"

[bits 16]
load_kernel: 
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; read from disk and store into 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
    BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; give control to the kernel
    jmp $ ; stay here when the kernel returns controls to us(if ever)
    
    BOOT_DRIVE db 0 ; we store boot drive in memory. just an example.
    MSG_REAL_MODE db "Started in 16-bit REAL MODE", 0
    MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0
    MSG_LOAD_KERNEL db "loading kernel into memory", 0
mystring:
    db 'OpenNaiLong.',0
times 510-($-$$) db 0
dw 0xAA55

