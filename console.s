
.set EXIT, 1
.set READ, 3
.set WRITE, 4


// Constants

.set STDIN, 0
.set STDOUT, 1


.text

.global write
write:
    push {r4, r5, r6, r7, r8, lr}
    mov r2, r1 // Length of output
    mov r1, r0 // Address of output
    mov r0, #STDOUT
    mov r7, #WRITE
    svc #0

    pop {r4, r5, r6, r7, r8, pc}
