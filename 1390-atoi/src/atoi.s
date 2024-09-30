  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 2

  @ *** your program goes here ***


  CMP R5, #16
  BEQ Hex
  CMP R5, #2
  BEQ Binary
  CMP R5, #8
  BEQ Oct
  CMP R5, #10
  BEQ Dec

Hex: 
  MOV R6, 0x30
  SUB R1, R1, R6 
  SUB R2, R2, R6
  SUB R3, R3, R6
  SUB R4, R4, R6 
  B   Check

Check:
  CMP R1, #17
  BEQ R1A
  CMP R1, #18
  BEQ R1B
  CMP R1, #19
  BEQ R1C
  CMP R1, #20
  BEQ R1D
  CMP R1, #21
  BEQ R1E
  CMP R1, #22
  BEQ R1F
  CMP R2, #17
  BEQ R2A
  CMP R2, #18
  BEQ R2B
  CMP R2, #19
  BEQ R2C
  CMP R2, #20
  BEQ R2D
  CMP R2, #21
  BEQ R2E
  CMP R2, #22
  BEQ R2F
  CMP R3, #17
  BEQ R3A
  CMP R3, #18
  BEQ R3B
  CMP R3, #19
  BEQ R3C
  CMP R3, #20
  BEQ R3D
  CMP R3, #21
  BEQ R3E
  CMP R3, #22
  BEQ R3F
  CMP R4, #17
  BEQ R4A
  CMP R4, #18
  BEQ R4B
  CMP R4, #19
  BEQ R4C
  CMP R4, #20
  BEQ R4D
  CMP R4, #21
  BEQ R4E
  CMP R4, #22
  BEQ R4F
  B   Final

R1A:
  MOV R1, #10
  B   Check
R1B:
  MOV R1, #11
  B   Check
R1C:
  MOV R1, #12
  B   Check
R1D:
  MOV R1, #13
  B   Check
R1E:
  MOV R1, #14
  B   Check
R1F:
  MOV R1, #15
  B   Check

R2A:
  MOV R2, #10
  B   Check
R2B:
  MOV R2, #11
  B   Check
R2C:
  MOV R2, #12
  B   Check
R2D:
  MOV R2, #13
  B   Check
R2E:
  MOV R2, #14
  B   Check
R2F:
  MOV R2, #15
  B   Check

R3A:
  MOV R3, #10
  B   Check
R3B:
  MOV R3, #11
  B   Check
R3C:
  MOV R3, #12
  B   Check
R3D:
  MOV R3, #13
  B   Check
R3E:
  MOV R3, #14
  B   Check
R3F:
  MOV R3, #15
  B   Check

R4A:
  MOV R4, #10
  B   Check
R4B:
  MOV R4, #11
  B   Check
R4C:
  MOV R4, #12
  B   Check
R4D:
  MOV R4, #13
  B   Check
R4E:
  MOV R4, #14
  B   Check
R4F:
  MOV R4, #15
  B   Check

Binary:
  MOV R6, #48

  SUB R1, R1, R6
  SUB R2, R2, R6
  SUB R3, R3, R6
  SUB R4, R4, R6 
  B   Final

Oct:
  MOV R6, #060

  SUB R1, R1, R6
  SUB R2, R2, R6
  SUB R3, R3, R6
  SUB R4, R4, R6 
  B   Final

Dec:
  MOV R6, #48

  SUB R1, R1, R6
  SUB R2, R2, R6
  SUB R3, R3, R6
  SUB R4, R4, R6 
  B   Final

Final:
  MOV R0, R4
  MUL R0, R0, R5
  ADD R0, R0, R3
  MUL R0, R0, R5
  ADD R0, R0, R2
  MUL R0, R0, R5
  ADD R0, R0, R1 

  @ End of program ... check your result

End_Main:
  BX    LR

  .end