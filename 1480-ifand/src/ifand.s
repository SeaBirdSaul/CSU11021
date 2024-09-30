  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Langauge.
  @ Assume ch is an ASCII character in R0.

  @ if (ch >= 'A' && ch <= 'Z') {
  @ 	ch = ch + 0x20;
  @ }

  @ *** your solution goes here ***

  CMP R0, 'A'
  BLO EndIfState
  CMP R0, 'Z'
  BHI EndIfState
  ADD R0, R0, #0x20

EndIfState:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end