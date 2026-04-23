format ELF64 executable 3
entry start

segment readable
    line        equ 10
    msg1        db 'Hello, World!', line
    msg1_end:
    msg2        db 'Hello again!', line
    msg2_end:

segment readable executable
    msg1_len    equ msg1_end - msg1
    msg2_len    equ msg2_end - msg2
    ;msg2_len    equ 14
    ;msg1_len    equ 13

write:
    mov eax, 1
    syscall
    ret

start:
    mov edi, 1          ; stdout
    mov rsi, msg1
    mov edx, msg1_len
    call write

    mov edi, 1          ; stdout
    mov rsi, msg2
    mov edx, msg2_len
    call write

    mov eax, 60         ; syscall exit
    xor edi, edi
    syscall
