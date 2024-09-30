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
  STMFD SP!, {LR}

  @ Test initialisation
  BL    InitRam       @ Initialise RAM contents from ROM
  LDR   R1, =testArray
  LDR   R2, =testArrayColumns



  LDMFD SP!, {PC}


@
@ Initialisation data
@
@ Read-only data that will be copied from ROM to RAM on program start
@
  .section  .rodata
init_data_start:

@ testArray
  .equ testArray, .-init_data_start+rw_data_start
init_testArray_firstRow:
  .word   4, 9, 2  @ row 0
  .equ testArrayColumns, (.-init_testArray_firstRow) >> 2 @ auto calc columns
  .word   3, 5, 7  @ row 1
  .word   8, 1, 6  @ row 2

.equ init_data_size, .-init_data_start



@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ IT IS RECOMMENDED THAT YOU DO NOT MODIFY BELOW THIS LINE @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

  .section  .data
rw_data_start:
  .space    init_data_size



@ InitRam subroutine
@ Utility subroutine to initialise RAM from ROM
  .section  .text
  .type     InitRam, %function
InitRam:

  STMFD   SP!, {R0-R2,LR}
  
  LDR   R1, =init_data_start  @ start address of RAM initial data
  LDR   R0, =rw_data_start    @ address for RAM data
  LDR   R2, =init_data_size   @ size (bytes) initial RAM data
  BL    MemCpy  

  LDMFD   SP!, {R0-R2,PC}



@ MemCpy subroutine
@ Copies memory
@
@ Parameters:
@   R0: destination address
@   R1: source address
@   R2: bytes
  .section  .text
  .type     MemCpy, %function
MemCpy:

  STMFD   SP!, {R4-R5, LR}

  MOV     R4, #0
whMemCpy:
  CMP     R4, R2
  BHI     eWhMemCpy
  LDRB    R5, [R1], #1
  STRB    R5, [R0], #1
  ADD     R4, R4, #1
  B       whMemCpy
eWhMemCpy:

  LDMFD   SP!, {R4-R5, PC}

.end