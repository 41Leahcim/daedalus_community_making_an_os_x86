[org 0x7c00] ; Required to take memory addresses without offset

start:
mov bx, buffer ; Load the address of the buffer
mov al, [bx] ; Load the current character

print_string:
mov ah, 0x0e ; Display Character
int 0x10 ; Print character
inc bx ; Increment the address
mov al, [bx] ; Load the current character
cmp al, 0 ; Compare it to 0
jne print_string ; Jump to print_string if it is 0

mov bx, buffer
read_line:
; Read from keyboard
mov ah, 0
int 0x16
cmp ah, 0x1C ; Stop reading if the user presses enter
je pressed_enter
mov [bx], al ; Store the acii character (ah contains the scancode)
inc bx ; Continue to the next position in the buffer
mov cx, bx ; Store the current pointer in cx
sub cx, buffer ; Subtract the buffer address to get the index
cmp cx, [length] ; Stop reading if the index is less than the length
jl read_line

pressed_enter:
; Store '\n' in the buffer
mov al, 0x0A
mov [bx], al
inc bx

; Store '\r' in the buffer
mov al, 0x0D
mov [bx], al
inc bx

adding_zero:
; Store a 0 in the buffer so we can easily find the end
mov cl, 0
mov [bx], cl

; Go back to the start of the application
jmp start

jmp $

buffer: db "Start typing...", 0x0A, 0x0D, 0
length: dw 17 ; Buffer is 18 bytes long, subtract 1 for safety
times 510-($-$$) db 0
db 0x55, 0xaa
