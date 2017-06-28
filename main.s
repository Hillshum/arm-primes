
.set EXIT, 1


.balign 2

.section .rodata
prime_message:
    .ascii "Found a prime\n"
    .set MESSAGE_LEN, .-prime_message
    

.balign 4
.text
.global _start
_start:

    mov r0, #101
    bl itoa
    
    mov r6, #15 // upper bound (must be odd)
    mov r5, #3 // lower bound
    

    mov r4, r5 // r4 has number getting tested
    
loop:

    mov r0, r4
    bl is_prime

    mov r8, r0
    cmp r0, #0
    beq found_prime

    


test:
    cmp r6, r4
    beq after

    add r4, r4, #2
    b loop

    

after:
    mov r7, #EXIT
    svc #0


found_prime:
    ldr r0, =prime_message
    mov r1, #MESSAGE_LEN
    bl write
    b test
