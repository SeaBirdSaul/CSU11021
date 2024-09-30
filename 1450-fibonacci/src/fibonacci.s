  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Calculate Fibonacci number Fn, where n is stored in R1
  @ Store the result in R0

  @ *** your solution goes here ***
  

  MOV R4, #0
  MOV R5, #0
  MOV R0, #1
  MOV R6, #1
WhileFib:
  CMP R6, R1
  BHS EndWhFib
  MOV R4, R5
  MOV R5, R0
  ADD R6, R6, #1
  ADD R0, R5, R4
  B   WhileFib

EndWhFib:


  @ End of program ... check your result

End_Main:
  BX    LR

  .end