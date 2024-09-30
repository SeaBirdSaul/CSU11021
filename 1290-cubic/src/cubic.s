  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @
  @ Write a program to compute ax^3+bx^2+cx+d
  @   where x, a, b, c, and d are values in R1, R2, R3, R4 and R5 respectively
  @
  @ Store your result in R0
  @

  @ *** your program goes here ***

  MUL R6, R1, R1  @R6 = x^2
  MUL R7, R6, R1
  MUL R7, R7, R2  @R7 =ax^3

  MUL R8, R3, R6  @R8 = bx^2

  MUL R9, R4, R1  @R9 = cx

  ADD R0, R7, R8
  ADD R0, R0, R9
  ADD R0, R0, R5  @R0 = ax^3+bx^2+cx+d

  @ End of program ... check your result

End_Main:
  BX    LR

  .end