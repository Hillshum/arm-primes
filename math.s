
.arch armv7-a
.cpu cortex-a7
.fpu neon-vfpv4


.global mod
mod: // ( r0 % r1)
    udiv r2, r0, r1
    mul r3, r1, r2
    sub r0, r0, r3
    bx lr


.global sqrt
sqrt:
    vmov s0, r0
    vcvt.f32.u32 s0, s0
    vsqrt.f32 s0, s0
    vcvt.u32.f32 s0, s0
    vmov r0, s0
    bx lr
