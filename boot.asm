; Print a character to teletype
mov ah, 0x0e ; Display Character
mov al, 'H' ; The character to print
int 0x10 ; BIOS video service interrupt

;mov ah, 0x0e Not needed as 0x0e is still stored in the register
mov al, 0x65 ; The same as 'e'
int 0x10

mov al, 'l'
int 0x10

mov al, 'l'
int 0x10

mov al, 'o'
int 0x10

mov al, 0x0A ; '\n'
int 0x10

mov al, 0x0D ; '\r'
int 0x10

mov al, 'A'
alphabet:
int 0x10
inc al
xor al, 0x20
cmp al, 'Z' + 1
jne alphabet

jmp $
times 510-($-$$) db 0
db 0x55, 0xaa
