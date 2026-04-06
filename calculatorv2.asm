section .data
    prompt db "Enter a number (0-9): ",0
    prompt_len equ $-prompt
    plus_msg db " + ",0
    equals_msg db " = ",0
    newline db 10

section .bss
    num1 resb 1
    num2 resb 1
    res resb 1

section .text
    global _start

_start:
    ; Prompt first number
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; Read first number
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    mov rsi, num1
    mov rdx, 1
    syscall

    ; Convert ASCII to number
    mov al, [num1]
    sub al, '0'
    mov [num1], al

    ; Prompt second number
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    ; Read second number
    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 1
    syscall

    ; Convert ASCII to number
    mov al, [num2]
    sub al, '0'
    mov [num2], al

    ; Add numbers
    mov al, [num1]
    add al, [num2]
    mov [res], al

    ; Print result message: e.g., "5 + 3 = 8"
    mov rax, 1
    mov rdi, 1
    mov rsi, num1
    mov rdx, 1
    add byte [rsi], '0'      ; convert to ASCII
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, plus_msg
    mov rdx, 3
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, num2
    mov rdx, 1
    add byte [rsi], '0'
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, equals_msg
    mov rdx, 3
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, res
    mov rdx, 1
    add byte [rsi], '0'
    syscall

    ; Newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall
