  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Language.
  @ Assume ch is an ASCII character code in R1 and v is a value in R0.

  @ if (ch=='a' || ch=='e' || ch=='i' || ch=='o' || ch=='u')
  @ {
  @ 	v = 1;
  @ }
  @ else
  @ {
  @ 	v = 0;
  @ }

  @ *** your solution goes here ***

  CMP R1, 'a'
  BEQ Equals
  CMP R1, 'e'
  BEQ Equals
  CMP R1, 'i'
  BEQ Equals
  CMP R1, 'o'
  BEQ Equals
  CMP R1, 'u'
  BNE EndIfState

Equals:
  MOV R0, #1
  B   Fin
  
EndIfState:
  MOV R0, #0
  B   Fin

Fin:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end