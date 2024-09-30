  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test

  .section  .text
  
  .type     Init_Test, %function
Init_Test:
  LDR   R1, =expression
  BX    LR

@
@ Below are some sample expressions that you can use to test different
@   features of your program
@
@ You should uncomment exactly one of the expressions at a time to
@   test your program
@

  .section  .rodata

expression:

  @ .asciz    "25"            @ Part 1 - value only
  @ .asciz    "25+35"         @ Part 2 - addition expression
   .asciz    "25+35+40+50+60+70"      @ Part 2 - longer addition expression
  @ .asciz    "35-25"         @ Part 3 - subtraction expression
  @ .asciz    "35*25"         @ Part 3 - multiplication expression
  @ .asciz    "0x23+0x19"     @ Part 4 - expression with hexadecimal values

.end
