boot: boot.asm
	nasm -f bin boot.asm -o boot.bin

run: boot
	qemu-system-x86_64 boot.bin
