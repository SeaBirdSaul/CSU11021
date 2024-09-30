  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Follow the instructions in the handout for Assignment 7

  @ *** your program goes here ***
  @load from mem
  @get num1
  @check sign/store sign
  @get num 2
  @check if there is a second sign or if it ends
  @if second sign, store second sign
  @then do first calc and store in num 1 place
  @get num3 and store in num 2
  @check sign and do thing
  @end
  @else do first sign
  @end
  
  @R1 = MEMYOKE
  @R2 = HOLDERNUM
  @R3 = NUM1
  @R4 = SIGN1
  @R5 = NUM2 
  @R6 = SIGN2
  @R10 = 10

  MOV R10, #10
  LDRB R2, [R1]
  B    getNum1Loop
getNum1:
  MOV R3, #0
  ADD R1, R1, #1
  LDRB R2, [R1]
getNum1Loop:
  SUB R2, R2, #0x30
  ADD R3, R3, R2
  ADD R1, R1, #1
  LDRB R2, [R1]
  CMP R2, #0x30
  BLT checkSign
  CMP R2, #0x39
  BGT checkSign
  MUL R3, R3, R10
  B   getNum1Loop

checkSign:
  CMP R2, #0x00
  BEQ EndLife
  MOV R4, R2
  ADD R1, R1, #1

  LDRB R2, [R1]
getNum2:
  MOV R5, #0
getNum2Loop:
  SUB R2, R2, 0x30
  ADD R5, R5, R2
  ADD R1, R1, #1
  LDRB R2, [R1]
  CMP R2, #0x30
  BLT checkSign2ElectricBoogaloo
  CMP R2, #0x39
  BGT checkSign2ElectricBoogaloo
  MUL R5, R5, R10
  B   getNum2Loop

@can be editted to for hex
checkSign2ElectricBoogaloo: 
  CMP R2, #0x00
  BEQ performSurgery
  MOV R6, R2
  ADD R1, R1, #1

performSurgery:
  CMP R4, '+'
  BEQ doAddition
  CMP R4, '-'
  BEQ doSubtraction
  CMP R4, '*'
  BEQ doMultiplication

doAddition:
  ADD R0, R3, R5 
  CMP R6, #0
  BEQ EndLife2ElectricBoogaloo
  B   getNum3

doSubtraction:
  SUB R0, R3, R5 
  CMP R6, #0
  BEQ EndLife2ElectricBoogaloo
  B   getNum3

doMultiplication:
  MUL R0, R3, R5 
  CMP R6, #0
  BEQ EndLife2ElectricBoogaloo
  B   getNum3

getNum3:
  LDRB R2, [R1]
  MOV R3, #0
getNum3Loop:
  SUB R2, R2, #0x30
  ADD R3, R3, R2
  ADD R1, R1, #1
  LDRB R2, [R1]
  CMP R2, #0x30
  BLT checkSign3ElectricOrgy
  CMP R2, #0x39
  BGT checkSign3ElectricOrgy
  MUL R3, R3, R10
  B   getNum3Loop

checkSign3ElectricOrgy: 
  CMP R2, #0x00
  BEQ performSurgery2ElectricBoogaloo
  MOV R4, R2
  ADD R1, R1, #1

performSurgery2ElectricBoogaloo:
  CMP R4, '+'
  BEQ doAddition2ElectricBoogaloo
  CMP R4, '-'
  BEQ doSubtraction2ElectricBoogaloo
  CMP R4, '*'
  BEQ doMultiplication2ElectricBoogaloo

doAddition2ElectricBoogaloo:
  ADD R0, R0, R3
  CMP R2, #0
  BEQ EndLife2ElectricBoogaloo
  B   getNum3

doSubtraction2ElectricBoogaloo:
  SUB R0, R0, R3 
  CMP R2, #0
  BEQ EndLife2ElectricBoogaloo
  B   getNum3

doMultiplication2ElectricBoogaloo:
  MUL R0, R0, R3 
  CMP R2, #0
  BEQ EndLife2ElectricBoogaloo
  B   getNum3

  
EndLife:
  MOV R0, R3

EndLife2ElectricBoogaloo:
  @ End of program ... check your result

End_Main:
  BX    LR

  .end