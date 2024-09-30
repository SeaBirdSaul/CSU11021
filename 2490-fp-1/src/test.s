  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Main

  .section  .text

Main:
  PUSH    {R4-R12, LR}

  @ Implement your own tests for each of your subroutines

  @ HINT: A useful pattern for your tests is to pass
  @   an IEEE-754 half-precision value to your fp_exp and
  @   fp_frac subroutines and then pass the results
  @   from both subroutines to your fp_enc subroutine. You
  @   should end up with the original IEEE-754 half-precision
  @   value.

  POP     {R4-R12, PC}

.end