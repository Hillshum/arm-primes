
.set BRK, 45


.data
init_break:
    .word 0

curr_break:
    .word 0

.text
.global get_initial
get_initial:
    
    push {r4, lr}

    movw r3, #:lower16:init_break
    movt r3, #:upper16:init_break
    ldr r0, [r3]

    cmp r0, #0
    bleq brk_call

    pop {r4, pc}



.global get_current
get_current:
  movw r3, #:lower16:curr_break
  movt r3, #:upper16:curr_break
  ldr r0, [r3]
  bx lr


.global get_more // r0 is amount needed
get_more:
    push {r7, lr}
    mov r7, r0

    bl get_initial

    movw r3, #:lower16:curr_break
    movt r3, #:upper16:curr_break
    add r0, r0, r7
    bl brk_call
    

    pop {r7, pc}
    

brk_call: // asumes the caller is saving r7
    push {r7, lr}
    mov r7, #BRK
    svc #0
    pop {r7, pc}

