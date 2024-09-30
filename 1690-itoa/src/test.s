  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test



@
@ Subroutine to initialise test inputs
@
  .section  .text
  .type     Init_Test, %function
Init_Test:
  STMFD   SP!, {LR}
  LDR     R1, =-9
  LDR     R0, =newString    @ Start address (in RAM) of space for new (copied) string
  LDMFD   SP!, {PC}



@
@ Space in RAM for new string
@
  .section .data

newString:
  .space  256

.end
