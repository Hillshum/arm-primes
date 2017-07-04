
.balign 4
.text

.global is_prime
is_prime: // r0 is the potential prime
    push {r3, r4, r5, r6, r7, r8, r9, r10, r11, lr}

    mov r4, r0 // Save the input
    mov r7, r1 // pointer to next prime
    bl sqrt
    mov r5, r0
    
    ldr r6, [r7], #4 // Number divided by

test:
    cmp r6, r5
    bhi prime

loop:
    mov r0, r4
    mov r1, r6
    bl mod

after_mod:
    cmp r0, #0
    beq composite

    ldr r6, [r7], #4

    b test



prime: // return 1
    mov r0, #1
    pop {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}


composite: // return 0
    mov r0, #0
    pop {r3, r4, r5, r6, r7, r8, r9, r10, r11, pc}


