  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test
  .global  testSeq
  .global  newSeq



@
@ Subroutine to initialise test inputs
@
  .section  .text
  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}
  LDR     R1, =testSeq   @ Start address of test sequence (in ROM)
  LDR     R2, =newSeq    @ Start address (in RAM) of space for new sequence
  LDMFD   SP!, {PC}



@
@ Test data (in ROM)
@
  .section  .rodata

testSeq:
  .word   5
  .hword  13, 15, 15, 13, 11



@
@ Space in RAM for copied sequence
@
  .section .data

newSeq:
  .space  4
newValues:
  .space  256

.end
