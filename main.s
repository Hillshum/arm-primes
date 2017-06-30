
.set EXIT, 1
.set WRITE, 4
.set OPEN, 5
.set CLOSE, 6


// Constants
.set O_WRONLY, 1
.set O_CREAT, 64
.set CREAT_FLAGS, (O_WRONLY | O_CREAT)


.balign 2

.section .rodata
prime_message:
    .ascii "Found a prime\n"
    .set MESSAGE_LEN, .-prime_message

newline:
    .ascii "\n"

filename: .asciz "primes.txt"
    .set NAMESIZE, .-filename -1

.data
prime:
    .space 4

.text
.global _start
_start:


    // open file
    movw r0, #:lower16:filename
    movt r0, #:upper16:filename

    movw r1, #CREAT_FLAGS
    movw r2, #0644
    mov r7, #OPEN
    svc #0
    mov r9, r0 // file handle in r9


    mov r6, #19 // upper bound (must be odd)
    mov r5, #3 // lower bound
    

    mov r4, r5 // r4 has number getting tested

    
loop:

    mov r0, r4
    bl is_prime

    mov r8, r0
    cmp r0, #1
    moveq r0, r4
    beq found_prime

    


test:
    add r4, r4, #2
    cmp r6, r4
    beq after

    b loop

    

after:
    mov r11, r0 // save the return value

    // close the file
    mov r0, r9
    mov r7, #CLOSE
    svc #0

    mov r7, #EXIT
    svc #0


found_prime:
    ldr r1, =prime
    add r0, r0, #48
    str r0, [r1]
    mov r0, r1
    mov r0, r1
    mov r1, #4
    bl write
    /*
    mov r0, r9
    mov r3, #4

    mov r7, #WRITE
    svc #0
    */

    ldr r0, =prime_message
    mov r1, #MESSAGE_LEN
    bl write
    b test
