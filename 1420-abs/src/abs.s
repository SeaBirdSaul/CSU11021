  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Write a program to compute the absolute value of an integer in R1

  @ *** your program goes here ***
  
  MOV R0, R1
  CMP R0, #0
  BGE EndIfNeg
  RSB R0, R0, #0
EndIfNeg:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end