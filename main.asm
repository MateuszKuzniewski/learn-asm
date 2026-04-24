format ELF64

section '.text' executable
public _start

extrn _exit
extrn InitWindow
extrn WindowShouldClose
extrn CloseWindow
extrn BeginDrawing 
extrn EndDrawing 
extrn ClearBackground

_start:
    mov rdi, 800
    mov rsi, 600
    mov rdx, msg
    call InitWindow
    
again:
    call WindowShouldClose
    test rax, rax
    jnz over
    
    call BeginDrawing
    mov rdi, 0xFF0000FF
    call ClearBackground
    call EndDrawing
    jmp again

over:
    call CloseWindow
    mov rdi, 0
    call _exit

section '.data' writable
msg db "Hello from fasm", 10, 0
