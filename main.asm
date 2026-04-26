format ELF64

section '.text'
_window_height equ 600
_window_width equ 400
_background_color equ 0x18181818
_button_color equ 0xFFFFFFFF
_button_size equ 90
_button_gap equ 15

section '.text' executable
public _start

extrn _exit
extrn WindowShouldClose
extrn CloseWindow
extrn BeginDrawing 
extrn EndDrawing 
extrn InitWindow        ; InitWindow(int width, int height, const char *title)
extrn ClearBackground   ; ClearBackground(Color color)
extrn DrawRectangle     ; DrawRectangle(int posX, int posY, int width, int height, Color color);

_start:
    mov rdi, _window_width
    mov rsi, _window_height
    mov rdx, msg
    call InitWindow
    
.draw_window:
    call WindowShouldClose
    test rax, rax
    jnz .over
    
    call BeginDrawing
    mov rdi, _background_color
    call ClearBackground
    
    xor r12, r12 ; i = 0
.rect_loop:
    cmp r12, 4 
    jge .rect_loop_end ; if i >= 4 exit loop

    mov rsi, _window_height
    sub rsi, _button_size ; y = _window_height - _button_size 

    mov rax, r12
    mov rcx, _button_size + _button_gap 
    imul rax, rcx ; i * (_button_size + gap)
    mov rdi, rax

    mov rdx, _button_size
    mov rcx, _button_size
    mov r8, _button_color

    call DrawRectangle

    inc r12
    jmp .rect_loop

.rect_loop_end:
    call EndDrawing
    jmp .draw_window

.over:
    call CloseWindow
    call _exit

section '.data' writable
msg db "Fasm Calculator", 10, 0

