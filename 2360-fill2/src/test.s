  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Main


Main:
  PUSH    {R4, R8, R9, LR}

  LDR     R4, =testMem      @ fill memory at testMem
  MOV     R9, #64           @ fill 64 words
  LDR     R8, =0x12345678   @ fill with value 0x12345678

  @ push parameters to stack (order is important!!)
  PUSH    {R4}              @ push address
  PUSH    {R9}              @ push length
  PUSH    {R8}              @ push value

  @ invoke fill subroutine
  BL      fill

  ADD     SP, SP, #12       @ pop parameters

End_Main:
  POP     {R4, R8, R9, PC}



  .section  .data.test
testMem:
  .space    0x400             @ 1KiB of memory to play with
