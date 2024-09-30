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
  MOV     R0, R0, LSR #10
  SUB     R0, #15

  POP     {R4, R5, PC}                      @ add any registers R4...R12 that you use



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
  PUSH    {R4-R6, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

  MOV     R4, R0
  AND     R5, R4, 0x8000 @ sign 

  BIC     R6, R4, 0xFC00 @ fraction
  ORR     R6, R6, 0x0400 @ adds hidden bit
  CMP     R5, 0x8000
  BNE     notNeg
  NEG     R6, R6
notNeg:
  MOV     R0, R6
  @AND     R0, R0, 0x077F

  POP     {R4-R6, PC}                      @ add any registers R4...R12 that you use



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
  PUSH    {R4-R12, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

 @ AND     R4, R0, 0x001007FF
  MOV     R4, R0
  MOV     R5, R1
  MOV     R12, #21
  

  CLZ     R7, R4 @gets amount of 0's before hidden bit | should be 21
  CMP     R7, R12
  BLT     shiftRight
  CMP     R7, R12
  BGT     shiftLeft
  MOV     R9, R4
  B       afterShift
shiftRight:
  SUB     R8, R12, R7
  MOV     R9, R4, LSR R8
  ADD     R5, R5, R8
  B       afterShift
shiftLeft:
  SUB     R8, R7, R12
  MOV     R9, R4, LSL R8
  SUB     R5, R5, R8
  B       afterShift

afterShift:
  BIC     R9, R9, 0xFC00 @gets only fraction | removes hidden bit
  MOV     R0, #0
  ORR     R0, R0, R9
  ADD     R5, R5, #15
  MOV     R5, R5, LSL #10
  ORR     R0, R0, R5

  @AND     R6, R4, 0x0400 @gets bit 11 on its own
  @CMP     R6, 0x0400
  @BEQ     tisNeg



  POP     {R4-R12, PC}                      @ add any registers R4...R12 that you use


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
  PUSH    {R4-R12, LR}                      @ add any registers R4...R12 that you use

  @
  @ your implementation goes here
  @

  MOV     R4, R0
  MOV     R5, R1

  MOV     R0, R4 
  BL      fp_exp
  MOV     R6, R0  @gets first expo
  MOV     R0, R4
  BL      fp_frac
  MOV     R7, R0  @gets first fract
  MOV     R0, R5
  BL      fp_exp
  MOV     R8, R0  @gets second exp 
  MOV     R0, R5
  BL      fp_frac
  MOV     R9, R0  @gets second fract

  CMP     R6, R8
  BGT     firstExpoGreater
  BLT     secondExpoGreater
  B       afterExpoManip

firstExpoGreater:
  SUB     R10, R6, R8 @gets diff in exponent 
  MOV     R9, R9, LSR R10 @moves second fract by exponent diff
  ADD     R8, R8, R10
  B       afterExpoManip
secondExpoGreater:
  SUB     R10, R8, R6
  MOV     R7, R7, LSR R10
  ADD     R6, R6, R10
  B       afterExpoManip
afterExpoManip:
  ADD     R0, R7, R9
  MOV     R1, R6
  BL      fp_enc

  POP     {R4-R12, PC}                      @ add any registers R4...R12 that you use



  .end