  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text
  
  .type     Init_Test, %function
Init_Test:

  LDR   R1, =6     @ N = 6 (result should be 10 coprime pairs)

  bx    lr

.end
