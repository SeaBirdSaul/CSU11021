  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 8

  @ *** your program goes here ***

  @R2 = currentLength
  @R0 = longestBoi
  @R3 = loopCounter
  MOV R0, #0
  MOV R3, #0
preWhile:
  MOV R2, #0

While:
  ADD R3, R3, #1
  MOVS R1, R1, LSL #1
  BCS checkLength 
  CMP R1, #0
  BEQ EndLife
  ADD R2, R2, #1
  CMP R3, #33
  BEQ checkLength
  B   While

checkLength:
  CMP R2, R0
  BLT preWhile
  MOV R0, R2
  CMP R3, #33
  BEQ EndLife
  B   preWhile

EndLife:






  @ End of program ... check your result

End_Main:
  BX    LR

  .end