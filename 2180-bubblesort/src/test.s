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
  LDR   R0, =testValues
  LDR   R1, =countTestValues



  LDMFD SP!, {PC}


@
@ Initialisation data
@
@ Read-only data that will be copied from ROM to RAM on program start
@
  .section  .rodata
init_data_start:

@ testValues
init_testValues_start:
  .equ testValues, .-init_data_start+rw_data_start
  .word  4, 1, 7, 12, 11, 10, 3, 9, 8, 2, 6, 5  @ <-- MODIFY TEST VALUES
  .equ countTestValues, (.-init_testValues_start) >> 2

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