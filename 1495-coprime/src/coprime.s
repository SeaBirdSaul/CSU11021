  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 4

  @ *** your program goes here ***
  @R2 = A
  @R3 = B
  @R4 = COUNTER
  @R5 = MODULO
  MOV R2, #1
  MOV R3, R2
  MOV R0, #0

  MOV R4, #1
StartGCD:
  CMP R4, R2
  BGT CoprimePair
  ADD R4, R4, #1
  UDIV R5, R4, R2
  MUL R5, R5, R2
  SUB R5, R4, R5
  CMP R5, #0
  BNE StartGCD
  UDIV R5, R4, R3
  MUL R5, R5, R3
  SUB R5, R4, R5
  CMP R5, #0 
  BEQ NotCoprimePair
  B StartGCD


IncB:
  ADD R3, R3, #1
  CMP R3, R1
  BEQ IncA
  B StartGCD

IncA:
  ADD R2, R2, #1
  CMP R2, R1
  BEQ EndProg
  ADD R3, R2, #1
  B StartGCD
  
CoprimePair:
  ADD R0, R0, #1

NotCoprimePair:
  MOV R4, #1
  B IncB

EndProg:


  @ End of program ... check your result

End_Main:
  BX    LR

  .end