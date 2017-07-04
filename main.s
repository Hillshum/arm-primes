
.set EXIT, 1
.set WRITE, 4
.set OPEN, 5
.set CLOSE, 6
.set BRK, 45


// Constants
.set O_WRONLY, 1
.set O_CREAT, 64
.set O_TRUNC, 512
.set CREAT_FLAGS, (O_WRONLY | O_CREAT | O_TRUNC)

.set MEM_BLOCK, 0x1000
.set LOAD_MEM_THRESHOLD, 0x1000


.balign 2

.section .rodata
prime_message:
    .ascii "Found a prime\n"
    .set MESSAGE_LEN, .-prime_message

newline:
    .ascii "\n"

filename: .asciz "primes.bin"
    .set NAMESIZE, .-filename -1

.data
prime:
    .space 4

init_break:
    .word 0

curr_break:
    .word 0

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

    // get some memory

    bl get_initial
    mov r10, r0 // location in memory to write to
    mov r5, r0 // start of known primes

    
    mov r0, #MEM_BLOCK
    bl get_more
    mov r11, r0 // final location
    mov r0, #3
    str r0, [r5] // Seed known primes
    add r10, #4




    // initialize parameters
    mov r6, #0x00Ec0000 // upper bound 
   // mov r6, #0x1000
    mov r4, #5 // lower bound
    

    
loop:

    mov r0, r4
    mov r1, r5
    bl is_prime

    mov r8, r0
    cmp r0, #1
    moveq r0, r4
    beq found_prime

    


test:
    add r4, r4, #2
    cmp r6, r4
    bls after

    b loop

    

after:

    bl get_initial
    sub r2, r10, r0 // write should only write as many as are queued
    bl writing // write whatever is left

    // close the file
    mov r0, r9
    mov r7, #CLOSE
    svc #0
    mov r7, #EXIT
    svc #0


found_prime:
    str r0, [r10],  #4
    cmp r10, r11
    bleq writing
    b test

writing:
    push {r1, lr}

    mov r10, r11
    sub r1, r11, #MEM_BLOCK
    mov r0, r9
    mov r2, #MEM_BLOCK // write a full memory block of primes

    mov r7, #WRITE
    svc #0
    mov r0, #MEM_BLOCK
    bl get_more
    mov r11, r0
    
    pop {r1, pc}


