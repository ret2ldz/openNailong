[bits 32]

global _start       ; 声明 _start 是链接器要找的全局入口符号

extern main

_start:
    call main
    jmp $
    

