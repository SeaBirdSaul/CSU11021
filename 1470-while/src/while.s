  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Language.
  @ Assume h is a value in R0.

  @ while (h >= 13) {
  @ 	h = h - 12;
  @ }

  @ *** your solution goes here ***

WhileLable:
  CMP R0, #13
  BLO EndWhile
  SUB R0, R0, #12
  B   WhileLable

EndWhile:

End_Main:
  BX    LR

  .end