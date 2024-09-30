  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 3

  @ *** your program goes here ***

  @if (((num1 % count) == 0) && ((num2 % count) == 0)) {
	@		result = count;


  @divisoin with remainder - BlackBoard descussion opened by Lucia Brown
@  UDIV R4, R3, R1
@  MUL R4, R4, R1
@  SUB R4, R3, R4 

  @start of if/while statement
  MOV R6, #0
WhileState:
  CMP R0, #0  @while result == 0 
  BNE EndWhileState
  ADD R6, #1 @ count++
  UDIV R4, R6, R1  @(num1 % count)
  MUL R4, R4, R1  @(num1 % count)
  SUB R4, R6, R4  @(num1 % count)
  CMP R4, #0    @((num1 % count) == 0) 
  BNE WhileState
  UDIV R5, R6, R2 @(num2 % count)
  MUL R5, R5, R2  @(num2 % count)
  SUB R5, R6, R5  @(num2 % count)
  CMP R5, #0  @((num2 % count) == 0)
  BNE WhileState
  MOV R0, R6  @		result = count;
  B   EndWhileState

EndWhileState: 
@The lettuce won
  @ End of program ... check your result

End_Main:
  BX    LR

  .end