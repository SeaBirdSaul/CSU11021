  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 6

  @ *** your program goes here ***
  @read in from memory, count and variables
  @isolate count and set to counter
  @read each variable and store somewhere (memory)
  @keep track of how many times the repeat (mode)
  @store mode in R0

  @while (counter != count)
  @  for (x in list)
  @      for (y in list)
  @          if (x == y)
  @              Modecount+=1
  @          y+=1
  @      if (Modecount > currentmode)
  @          modevlaue = x
  @          currentmode = Modecount
  @      x+=1
  @  counter +=1


  @R1 = MENYOKE
  @R2 = part 2 stuff
  @R3 = count
  @R4 = x
  @R5 = y
  @R6 = counter
  @R7 = xcount
  @R8 = ycount
  @R9 = Modecount
  @R10 = currentModeCount
  @R11 = modeValue
  @R12 = ADDCOUNT
  
  
  LDR R3, [R1] @puts count in R3
  ADD R1, R1, #4 @increments R1 to get the half word things
  LDRH R4, [R1] @puts x in R4
  MOV R7, #1
  @LDRH R4, [R1] @gets first half word variable (x)
  @ADD R1, R1, #2 @increments to get second variable 
  @LDRH R5, [R1] @gets second variable (y)
  

while:
  LDRH R5, [R1] @puts y in R5
  @CMP R6, R3 @compares counter to count
  @BEQ EndLife @death is equal
  ADD R6, R6, #1 @increments counter
  CMP R7, R3 @compares xcount to count
  BEQ EndLife @death if equal
  CMP R8, R3 @compares ycount to count
  BEQ check @if equal break to check
  ADD R1, R1, #2
  ADD R8, R8, #1
  CMP R4, R5 @comp x and y 
  BNE while @reset loop if not equal
  ADD R9, R9, #1 @if equal inc Modecount
  B   while @restart loop
  
@      if (Modecount > currentmode)
  @          modevlaue = x
  @          currentmode = Modecount
check:
  CMP R9, R10 @comps Modecount to currentModeCount
  BLE incXdecY @branch if >=
  MOV R11, R4
  MOV R10, R9 @update current mode 
  

incXdecY:
  MOV R8, #0
  ADD R12, R6, R6
  SUB R1, R1, R12
  MOV R12, #2
  ADD R7, R7, #1 @increment xcount
  MUL R12, R7, R12
  ADD R1, R1, R12 @increment R1
  LDRH R4, [R1] @puts x in R4
  SUB R1, R1, R12
  MOV  R6, #0  
  B   while

EndLife:
  MOV R6, #0 @sets counter to 0
  MOV R0, R11 @sets R0 to mode
  SUB R7, R3, R10
  
  ADD R12, R6, R6
  SUB R1, R1, R12
  
  STR R7, [R1]
  ADD R1, R1, #4
listLoop:
  CMP R6, R3
  BEQ EndLife2ElectricBoogaloo
  ADD R6, R6, #1
  LDR R4, [R1]
  ADD R1, R1, #2
  CMP R4, R0
  BEQ listLoop
  STRH R4, [R1]
  B   listLoop

EndLife2ElectricBoogaloo:



  @ End of program ... check your result

End_Main:
  BX    LR

  .end