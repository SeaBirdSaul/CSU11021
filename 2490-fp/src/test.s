  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Main

  .section  .text

Main:
  PUSH    {R4-R12, LR}

  @ Implement your own tests for each of your subroutines

  @MOV     R0, 0x2491
  MOV     R0, 0x2800
  BL      fp_exp
  MOV     R4, R0

@  MOV     R0, 0x2491 @pos
  MOV     R0, 0xA491 @neg
  BL      fp_frac
  MOV     R5, R0


  @MOV     R0, R5 @working
  @MOV     R1, R4 @working

  MOV     R0, 0x0922
  MOV     R1, R4
  BL      fp_enc  

  @ HINT: A useful pattern for your tests is to pass
  @   an IEEE-754 half-precision value to your fp_exp and
  @   fp_frac subroutines and then pass the results
  @   from both subroutines to your fp_enc subroutine. You
  @   should end up with the original IEEE-754 half-precision
  @   value.

  POP     {R4-R12, PC}

.end