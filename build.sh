#!/bin/bash
set -e

# 创建输出目录
mkdir -p out

# 编译 C 内核代码
echo "[*] Compiling kernel.c"
gcc -m32 -ffreestanding -c kernel.c -o out/kernel.o

echo "[*] Compiling port_io.c"
gcc -m32 -ffreestanding -c ./drivers/ports.c -o out/port_io.o

# 编译汇编内核入口
echo "[*] Compiling kernel_entry.asm"
nasm -f elf32 kernel_entry.asm -o out/kernel_entry.o

# 链接内核
echo "[*] Linking kernel"
ld -m elf_i386 -T linker.ld -o out/kernel.bin out/port_io.o out/kernel_entry.o out/kernel.o

# 编译启动扇区
echo "[*] Compiling bootsector"
nasm -f bin bootsector.asm -o out/bootsect.bin

# 合并内核和启动扇区
echo "[*] Creating final image"
cat out/bootsect.bin out/kernel.bin > out/os-image.bin

# 运行
echo "[*] Running in QEMU..."
qemu-system-i386 -fda out/os-image.bin -s 
#-nographic

