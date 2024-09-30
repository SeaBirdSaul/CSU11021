  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test
  .global  stringA
  .global  stringB



@
@ Subroutine to initialise test inputs
@
  .section  .text
  .type     Init_Test, %function
Init_Test:
  STMFD SP!, {LR}
  BL    InitRam               @ Copy initial RAM contents from ROM
  LDR   R1, =stringA          @ Start address for string A in RAM
  LDR   R2, =stringB          @ Start address for string B in RAM
  LDMFD SP!, {PC}



@
@ Initial test strings
@
@ This initial data will be copied from ROM to
@   to RAM before your program starts.
@
  .section  .rodata
@ Initial contents of test string A
init_stringA:
  @ .asciz    "ABCWXYZ"         @ Test Part 1 (comment to test other parts)
  @ .asciz    "ABCDWXYZ"      @ Uncomment to test Part 2
   .asciz    "ABCDWXABCDEYZ" @ Uncomment to test Part 3 and Part 4

@ Initial contents of test string B
init_stringB:
  @ .asciz    "ABCPQRST"         @ Test Part 1 (comment to test other parts)
  @ .asciz    "ABCPQABCDRST"   @ Uncomment to test Part 2
   .asciz    "ABCPQABCDERST"  @ Uncomment to test Part 3 and Part 4



@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ IT IS RECOMMENDED THAT YOU DO NOT MODIFY BELOW THIS LINE @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  .section  .data
stringA:
  .space  128

stringB:
  .space  128



@ InitRam subroutine
@ Utility subroutine to initialise RAM from ROM
  .section  .text
  .type     InitRam, %function
InitRam:

  STMFD   SP!, {LR}
  
  LDR   R1, =init_stringA     @ start address of initial stringA in ROM
  LDR   R0, =stringA          @ address for stringA in RAM
  BL    StrCpy  

  LDR   R1, =init_stringB     @ start address of initial stringB in ROM
  LDR   R0, =stringB          @ address for stringB in RAM
  BL    StrCpy

  LDMFD   SP!, {PC}



@ StrCpy subroutine
@ Copies a NULL-terminated ASCII string
@
@ Parameters:
@   R0: destination address
@   R1: source address
  .section  .text
  .type     StrCpy, %function
StrCpy:

  STMFD   SP!, {R4, LR}
  
whCpy:
  LDRB    R4, [R1], #1
  STRB    R4, [R0], #1
  CMP     R4, #0
  BNE     whCpy

  LDMFD   SP!, {R4, PC}

.end
