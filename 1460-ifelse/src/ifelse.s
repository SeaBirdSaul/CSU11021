  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Language.
  @ Assume a and b are values in R1 and R2 and r is a value in R0.

  CMP R1, R2  @ if (a < b)
  BHI ElseStatement  @ {
  MOV R0, R1  @   r = a;
  B   EndIfStatement  @ }

ElseStatement:  @ else {
  MOV R0, R2  @   r = b;
  B   EndIfStatement @ }

EndIfStatement:


  @ End of program ... check your result

End_Main:
  BX    LR

  .end