  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Convert the character in R0 to upper case

  @ *** your solution goes here ***

  CMP R0, 'a'
  BLO EndIfLc
  CMP R0, 'z'
  BHS EndIfLc
  SUB R0, R0, #0x20
EndIfLc:

  @ End of program ... check your result

End_Main:
  BX    LR

  .end