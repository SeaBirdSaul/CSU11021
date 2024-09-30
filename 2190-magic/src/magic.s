  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 1

  @ *** your program goes here ***

  @R0 = OUTPUT
  @R1 = RAM ADDRESS
  @R2 = NUMBER OF ROWS/COLUMNS 
  @R3 = INDEX
  @R4 = COUNTER
  @R5 = NUMFOVALUESFOUND 
  @R6 = EVERYVALUE
  @R7 = SOMEBOOBEAN
  @R8 = N^2
  @R9 = ARRAY[]
  @R10 = ADDRESS SAVER
  @R11 = MAGICCONSTANT
  @R12 = VALUSE

  MOV R10, R1
  MOV R0, #1
  MUL R8, R2, R2
whileFirst:
  CMP R6, #1
  BEQ endWhile1
  MOV R3, #1 
startFirstFor:
  CMP R3, R8
  BGT endFirstFor
  MOV R4, #0
startSecondFor:
  CMP R4, R8
  BEQ endSecondFor
startFirstIf:
  LDR R9, [R10, R4, LSL #2]
  ADD R4, R4, #1 @increment counter
  CMP R3, R9
  BNE startSecondFor
  ADD R5, R5, #1
endSecondFor:
  ADD R3, R3, #1 @increment index
  B   startFirstFor
endFirstFor:
  CMP R5, R8
  BNE endWhile1
  MOV R6, #1
endWhile1:
  CMP R6, #1
  BEQ afterIf
  MOV R0, #0
afterIf:

  CMP R0, #0
  BEQ End_Main

  MOV R3, #2 @TEMP USING INDEX TO HOLD  A DIVISOR
  MOV R11, R8
  ADD R11, R11, #1
  UDIV R11, R11, R3
  MUL R11, R11, R2 @SET R11 TO THE MAGIC CONSTANT
  MOV R4, #0

  MOV R10, R1
  MOV R3, #0
startRowsWhile:
  CMP R3, R2
  BHS endRowsWhile
  MOV R4, #0
  MOV R12, #0
secondRowsWhile:
  MUL R5, R3, R2
  ADD R5, R5, R4
  LDR R9, [R10, R5, LSL #2]
  ADD R12, R12, R9
  ADD R4, R4, #1
  CMP R4, R2
  BLO secondRowsWhile 
  B   endSecondRowsWhile
endSecondRowsWhile:
  CMP R12, R11
  BEQ correctIf
  MOV R0, #0
  B   End_Main
correctIf:
  ADD R3, R3, #1
  B   startRowsWhile
endRowsWhile:

  MOV R10, R1
  MOV R3, #1
  MOV R5, #0
startColumnsWhile:
  CMP R3, R2
  BHI endColumnsWhile
  MOV R4, #0
  MOV R12, #0
secondColumnsWhile:
  MUL R5, R4, R2  
  LDR R9, [R10, R5, LSL #2]
  ADD R12, R12, R9
  ADD R4, R4, #1
  ADD R5, R5, #1
  MUL R5, R5, R2
  ADD R5, R5, R3
  CMP R4, R2
  BLO secondColumnsWhile
endSecondColumnsWhile:
  CMP R12, R11
  BEQ correctIf2ElectricBoogaloo
  MOV R0, #0
  B   End_Main
correctIf2ElectricBoogaloo:
  ADD R3, R3, #1
  B   startColumnsWhile
endColumnsWhile:

  MOV R10, R1
  MOV R12, #0
  MOV R3, #1
  MOV R5, #0
  MOV R4, #0
startDiagonalWhile:
  CMP R3, R2
  BHI endDiagonalWhile
  MUL R5, R4, R2  
  CMP R4, #1
  BLO skip
  ADD R5, R5, R4
skip:
  LDR R9, [R10, R5, LSL #2]
  ADD R12, R12, R9
  ADD R4, R4, #1 @increment counter
  CMP R4, R2
  BLO startDiagonalWhile
  CMP R12, R11
  BEQ correctIfForDiagonal
  B   End_Main
correctIfForDiagonal:
  MOV R0, #2
  ADD R3, R3, #1
  B   startDiagonalWhile
endDiagonalWhile:

  @R7 = N^2-INDEX
  @R12 = ARRAY[N^2-INDEX]
  @R4 = N^2/2
  @R6 = N^2-INDEX
  @R11 = N^2+1

  MOV R10, R1
  MOV R3, #0
  MOV R4, #2
  UDIV R4, R8, R4
  ADD R11, R8, #1
finalFor:
  CMP R3, R4
  BEQ endFinalFor
finalIf:
  LDR R9, [R10, R3, LSL #2]
  SUB R6, R8, R3
  SUB R6, R6, #1
  LDR R12, [R10, R6, LSL #2]
  ADD R3, #1
  ADD R12, R12, R9
  CMP R12, R11
  BEQ finalFor
  B   End_Main
endFinalFor:
  MOV R0, #3
  B   End_Main
  @ End of program ... check your result

End_Main:
  BX    LR

  .end