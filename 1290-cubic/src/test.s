  .syntax unified
  .cpu cortex-m3
  .thumb

  .global  Init_Test

  .section  .text

  .type     Init_Test, %function
Init_Test:

  @ Test with x=3, a=2, b=-5, c=4 and d=10
  MOV   R1, #3
  MOV   R2, #2
  MOV   R3, #-5
  MOV   R4, 4
  MOV   R5, #10

  bx    lr

.end