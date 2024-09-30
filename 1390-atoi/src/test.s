  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text
  
  .type     Init_Test, %function
Init_Test:

  @ 2034 (base 10 / decimal)
  LDR   R1, ='4'    @ '4' = 0x34
  LDR   R2, ='A'    @ '3' = 0x33
  LDR   R3, ='1'    @ '0' = 0x30
  LDR   R4, ='0'    @ '2' = 0x32

  LDR   R5, =16    @ base 10 / decimal

  bx    lr

.end
