  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  fp_exp
  .global  fp_frac
  .global  fp_enc
  .global  fp_add

@ fp_exp subroutine
@ Obtain the exponent of an IEEE-754 (half-precision) number as a signed
@   integer (2's complement)
@
@ Parameters:
@   R0: IEEE-754 half-precision number (occupying bits 15 to 0)
@
@ Return:
@   R0: exponent (signed integer using 2's complement)
fp_exp:
  PUSH    {R4, R5, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @
  MOV     R4, R0
  MOV     R5, 0x7C00
  AND     R0, R4, R5
  SUB     R0, #15
  POP     {R4, R5, PC}                           @ add any registers R4...R12 that you use



@ fp_frac subroutine
@ Obtain the fraction of an IEEE-754 (half-precision) number.
@
@ The returned fraction will include the 'hidden' bit to the left
@   of the radix point (at bit 10). The radix point should be considered to be
@   between bits 9 and 10.
@
@ The returned fraction will be in 2's complement form, reflecting the sign
@   (sign bit) of the original IEEE-754 number.
@
@ Parameters:
@   R0: IEEE-754 half-precision number (occupying bits 15 to 0)
@
@ Return:
@   R0: fraction (signed fraction, including the 'hidden' bit, in 2's
@         complement form)
fp_frac:
  PUSH    {LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

  POP     {PC}                      @ add any registers R4...R12 that you use



@ fp_enc subroutine
@ Encode an IEEE-754 (half-precision) floating point number given the
@   fraction (in 2's complement form) and the exponent (also in 2's
@   complement form).
@
@ Fractions that are not normalised will be normalised by the subroutine,
@   with a corresponding adjustment made to the exponent.
@
@ Parameters:
@   R0: fraction (in 2's complement form)
@   R1: exponent (in 2's complement form)
@
@ Return:
@   R0: IEEE-754 half-precision floating point number (occupying bits 15 to 0)
fp_enc:
  PUSH    {LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

  POP     {PC}                      @ add any registers R4...R12 that you use


@ fp_add subroutine
@ Add two IEEE-754 half-precision floating point numbers
@
@ Paramaters:
@   R0: a - first number (occupying bits 15 to 0)
@   R1: b - second number  (occupying bits 15 to 0)
@
@ Return:
@   R0: result - a+b (occupying bits 15 to 0)
fp_add:
  PUSH    {LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

  POP     {PC}                      @ add any registers R4...R12 that you use



  .end