  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text
  
  .type     Init_Test, %function
Init_Test:

  @ test with x=5
  MOV   R1, #5      @ x=5

  bx    lr

.end
