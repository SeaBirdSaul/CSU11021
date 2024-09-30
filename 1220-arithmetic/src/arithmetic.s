  .syntax unified
  .cpu cortex-m3
  .thumb
  .global  Main

Main:
  
  @ Write a program to compute 4x^2+3x

  @ *** your program goes here ***
  MUL R2, R1, R1
  MOV R3, #4
  MUL R2, R2, R3

  MOV R3, #3
  MUL R3, R3, R1
  ADD R0, R3, R2
  @ End of program ... check your result

End_Main:
  BX    lr
