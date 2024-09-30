  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Write a program to compute n! where n is a value in R1

  @ *** your program goes here ***

  MOV R0, #1
  MOV R2, R1
WhileMul:
  CMP R2, #1
  BLS EndWhMul
  MUL R0, R0, R2
  SUB R2, R2, #1
  B   WhileMul
EndWhMul:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end