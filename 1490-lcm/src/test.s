  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text
  
  .type     Init_Test, %function
Init_Test:

  LDR   R1, =6      @ a = 6
  LDR   R2, =8      @ b = 8

  bx    lr

.end
