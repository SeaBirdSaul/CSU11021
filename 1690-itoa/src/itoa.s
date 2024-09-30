  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 5

  @ *** your program goes here ***

  @mov R1 to R2
  @factor = 1
  @if R2 = 0 
  @store 0 in memory and end
  @else if R2 > 0 
  @then store '+' in mem 1
  @else if R2 < 0
  @store '-' in mem 1 
  @mul R2 -1
  @for R2 != 0
  @if R2 divide 10(Factor) < 10
  @converte ans to ascii
  @store ascii in mem 2 
  @R2 = R2 - (ans * 10Factor)
  @Factor - 1
  @mem +1
  @loop
  @else factor +1

  @R2 = R1
  @R3 = '0'
  @R4 = '+'
  @R5 = '-'
  @R6 = -1
  @R7 = 10Power
  @R9 = ASCII
  @R10 = ans * 10Power
  @R11 = ans
  @R12 = 10
  @R0 = mem
  MOV R12, #10
  MOV R7, #1
  MOV R6, #-1
  MOV R2, R1
  CMP R2, #0
  BEQ is0
  CMP R2, #0
  BLT Negative
  MOV R4, '+'
  STRB R4, [R0]
  ADD R0, R0, #1

loop:
  CMP R2, #0
  BEQ endLife
  CMP R2, #10
  BLT lessThan10
  UDIV R11, R2, R7
  CMP R11, R12
  BGT incFactor
  ADD R9, R11, #0X30
  STRB R9, [R0]
  MUL R10, R11, R7 
  SUB R2, R2, R10
  ADD R0, R0, #1
  MOV R7, #10
  B   loop

lessThan10:
  CMP R2, #0
  BLE endLife
  ADD R9, R2, #0X30
  STRB R9, [R0]
  ADD R0, R0, #1
  B   endLife

incFactor:
  MUL R7, R7, R12
  B   loop

Negative:
  MOV R5, '-'
  STRB R5, [R0]
  MUL R2, R2, R6
  ADD R0, R0, #1
  B  loop

is0:
  MOV R3, '0'
  STRB R3, [R0]

endLife:
  @ End of program ... check your result

End_Main:
  BX    LR

  .end