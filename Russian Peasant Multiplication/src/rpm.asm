; #include <stdio.h>

; unsigned multiply(unsigned x, unsigned y) {
;     unsigned result = 0;
;     while(x > 0) {
;         if (x & 1) result += y;
;         x >>= 1;
;         y <<= 1;
;     }
;     return result;
; }

; int main() {
;     printf("%u\n", multiply(47, 42));
;     return 0;
; }

section .data
    d_prinf_format db "%d", 0xA, 0x0

section .text
    global main
    extern printf

main:
    mov rbx, 47
    mov rcx, 42

    call multiply
    call print_result
    call exit

multiply: ; rbx = x, rcx = y, rax = result
    xor rax, rax

.while:
    test rbx, rbx ; x > 0
    jz .return
    test rbx, 1 ; x & 1
    jnz .add
    jz .shift
    
.shift:
    shr rbx, 1 ; x >>= 1
    shl rcx, 1 ; y <<= 1
    jmp .while

.add:
    add rax, rcx ; result += y
    jmp .shift

.return:
    ret

print_result:
    mov rdi, d_prinf_format
    mov rsi, rax
    xor rax, rax
    call printf

exit:
    mov rax, 60 ; sys_exit
    xor rdi, rdi
    syscall