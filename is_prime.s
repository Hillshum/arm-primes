
.balign 4
.text

.global is_prime
is_prime: // r0 is the potential prime
    push {r4, r5, r6, r7, r8, lr}

    mov r4, r0 // Save the input
    bl sqrt
    mov r5, r0
    
    mov r6, #3 // Number divided by

loop:
    mov r0, r4
    mov r1, r6
    bl mod


test:
    cmp r0, #0
    beq composite

    add r6, r6, #2
    cmp r6, r5
    bpl prime

    b loop



prime: // return 1
    mov r0, #1
    pop {r4, r5, r6, r7, r8, pc}


composite: // return 0
    mov r0, #0
    pop {r4, r5, r6, r7, r8, pc}


