  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @
  @ Follow the instructions given in the examination paper
  @
  @ The address of string A is in register R1
  @ The address of string B is in register R2
  @
  @ To aid your debugging using Visual Studio Code:
  @ 
  @   - string A will be in RAM at 0x20000000
  @   - string B will be in RAM at 0x20000080
  @ 
  @ (However, your program should not assume that strings A and B will always
  @ be at the above addresses and Submitty may start your program with
  @ different start addresses for Strings A and B in R1 and R2.)
  @

  @ *** your program goes here ***


@PART1 - PSUEDOCODE
  @LOAD R1 -> R3
  @LOAD R2 -> R4
  @WHILE R1 != 0 || R2 != 0
  @CMP R1, R2
  @BEQ INCANS
  @R1++
  @R2++
  @B WHILESTART

  @INCANS
  @R0++
  @R1++
  @R2++
  @B WHILESTART 


@PART2 - PSUEDOCODE
  @GETLENGTH1 
  @LOAD R1 -> R3
  @CMP R3, 0
  @BEQ ENDGETLENGTH1
  @R12++
  @R5++
  @R1++
  @B   GETLENGTH1

  @ENDGTLENGTH1
  @SUB R1, R5

  @MOV R5, 0
  @GETLENGTH2
  @LOAD R2 -> R4
  @CMP R4, 0
  @BEQ ENDGETLENGTH2
  @R12++
  @R6++
  @R2++
  @B   GETLENGTH2

  @ENDGTLENGTH1
  @SUB R2, R12

  @LOAD R1 -> R3
  @LOAD R2 -> R4
  @WHILE R7 != R5 
  @IF R8 = R5
  @R7++
  @SUB R2, R8
  @R8 -> 0
  @CMP R3, R4
  @BEQ INCANS
  @R2++
  @B WHILESTART

  @INCANS
  @R0++
  @R1++
  @R2++
  @B WHILESTART 

@PART3 - PSEUDOCODE

@GETLENGTH1 
  @LOAD R1 -> R3
  @CMP R3, 0
  @BEQ ENDGETLENGTH1
  @R12++
  @R5++
  @R1++
  @B   GETLENGTH1

  @ENDGTLENGTH1
  @SUB R1, R5

  @MOV R12, 0
  @GETLENGTH2
  @LOAD R2 -> R4
  @CMP R4, 0
  @BEQ ENDGETLENGTH2
  @R12++
  @R6++
  @R2++
  @B   GETLENGTH2

  @ENDGTLENGTH1
  @SUB R2, R12

  @MOV 0 -> R0
  @LOAD R1 -> R3
  @LOAD R2 -> R4
  @WHILE R7 != R5
  @IF R8 = R5
  @R7++
  @SUB R2, R8
  @R8 -> 0
  @CMP R3, R4
  @BEQ INCANS
  @R2++
  @R8++
  @B WHILESTART

  @INCANS
  @R11++
  @R1++
  @R7++
  @R2++
  @R8++
  @IF R11>R10
  @R11 = R10
  @B WHILESTART 

  @INCR7
  @R7++
  @R1++
  @R2 = R2 - R6
  @R8 == 0
  @R11 == 0
  @B WHILESTART


  @ENDLIFE
  @IF R11>R10
  @R0 = R11
  @ELSEIF R10>R11
  @R0 = R10


  @ R0 = ANS
  @ R1 = STRING1
  @ R2 = STRING2
  @ R3 = LOADEDVALUE1
  @ R4 = LOADEDVALUE2
  @ R5 = LENGTHSTRING1
  @ R6 = LENGTHSTRING2
  @ R7 = COUNTERSTRING1
  @ R8 = COUNTERSTRING2
  @ R11 = TEMPANS
  @ R12 = COUNTER


getLength1:
  LDRB R3, [R1]
  CMP R3, #0X0
  BEQ endGetLength1
  ADD R12, #1
  ADD R5, #1
  ADD R1, #1
  B   getLength1

endGetLength1:
  SUB R1, R1, R12


  MOV R12, #0
getLength2:
  LDRB R4, [R2]
  CMP R4, #0X0
  BEQ endGetLength2
  ADD R12, #1
  ADD R6, #1
  ADD R2, #1
  B   getLength2

endGetLength2:
  SUB R2, R2, R12


  MOV R0, #0
whileStart:
  LDRB R3, [R1]
  LDRB R4, [R2]
  CMP R7, R5
  BEQ EndLife
  CMP R8, R6
  BEQ IncR7
  CMP R3, R4
  BEQ IncAns
  ADD R2, R2, #1
  ADD R8, R8, #1
  B   whileStart


IncAns:
  ADD R11, R11, #1
  ADD R1, R1, #1
  ADD R7, R7, #1
  ADD R2, R2, #1
  ADD R8, R8, #1
  CMP R11, R10
  BGT ChangeR11
  B   whileStart

ChangeR11:
  MOV R10, R11
  B   whileStart

IncR7:
  ADD R7, R7, #1
  ADD R1, R1, #1
  SUB R2, R2, R6
  MOV R8, #0
  MOV R11, #0
  B   whileStart


EndLife:
  CMP R11, R10
  BGT MOVR11TOR0
  CMP R10, R11
  BGT MOVR10TOR0

MOVR11TOR0:
  MOV R0, R11
  B   EndLife2ElectricBoogaloo

MOVR10TOR0:
  MOV R0, R10
  B   EndLife2ElectricBoogaloo

EndLife2ElectricBoogaloo:


End_Main:
  BX    LR

  .end