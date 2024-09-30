  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Write a program to compute the maximum of the values in R1 and R2

  @ *** your program goes here ***

  CMP R1, R2
  BLT ElseMaxB
  MOV R0, R1
  B   EndMax
ElseMaxB:
  MOV R0, R2
EndMax:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end