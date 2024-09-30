  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text
  
  .type     Init_Test, %function
Init_Test:

  @ Test with a=5, b=6
  MOV   R1, #5
  MOV   R2, #6

  bx    lr

.end
