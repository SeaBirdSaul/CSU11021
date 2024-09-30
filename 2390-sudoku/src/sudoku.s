  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  countInRow
  .global  countInCol
  .global  countIn3x3
  .global  nextInCell
  .global  solveSudoku


@ countInRow subroutine
@ Count the number of occurrences of a specified value in one row of a Sudoku
@   grid.
@
@ Parameters: what is takedn in when called
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number
@   R2: value to count
@ Return:
@   R0: number of occurrences of value in specified row
countInRow:
  PUSH    {R4-R8,  LR} @ will nedd to push other registers that we are using onto the stack aswell

  @
  @ Your subroutine implementation goes here
  @

  MOV     R4, R0
  MOV     R0, #0
  MOV     R8, #9
  MUL     R5, R1, R8
  ADD     R6, R4, R5
whileRow:
  CMP     R7, #9
  BEQ     endWhileRow
  ADD     R8, R6, R7
  LDRB    R5, [R8]
  CMP     R5, R2
  BNE     afterIfRow
  ADD     R0, R0, #1
afterIfRow:
  ADD     R7, R7, #1
  B       whileRow
endWhileRow:
  POP     {R4-R8, PC}



@ countInCol subroutine
@ Count the number of occurrences of a specified value in one column of a Sudoku
@   grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: column number
@   R2: value to count
@ Return:
@   R0: number of occurrences of value in specified column
countInCol:
  PUSH    {R4-R9, LR}

  @
  @ Your subroutine implementation goes here
  @

  MOV     R4, R0
  MOV     R0, #0
  ADD     R5, R4, R1
  MOV     R9, #9
whileCol:
  CMP     R6, #9
  BEQ     endWhileCol
  MUL     R7, R6, R9
  ADD     R7, R7, R5
  LDRB    R8, [R7]
  CMP     R8, R2
  BNE     afterIfCol
  ADD     R0, R0, #1
afterIfCol:
  ADD     R6, R6, #1
  B       whileCol
endWhileCol:

  POP     {R4-R9, PC}



@ countIn3x3 subroutine
@ Count the number of occurrences of a specified value in one 3x3 subgrid
@   of a Sudoku grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number of any row in the 3x3 subgrid
@   R2: column number of any column in the 3x3 subgrid
@   R3: value to count
@ Return:
@   R0: number of occurrences of value in specified 3x3 subgrid
countIn3x3:
  PUSH    {R4-R9, LR}

  @
  @ Your subroutine implementation goes here
  @


  


  CMP     R1, #3
  BGE     rowIf2
  CMP     R2, #3
  BGE     colIf2
  MOV     R4, 0x0
  B       start3x3While
colIf2:
  CMP     R2, #6
  BGE     colIf3
  MOV     R4, 0x3
  B       start3x3While
colIf3:
  CMP     R2, #9
  BGE     endCountIn3x3
  MOV     R4, 0x6
  B       start3x3While

rowIf2:
  CMP     R1, #6
  BGE     rowIf3
  CMP     R2, #3
  BGE     colIf4
  MOV     R4, 0x1b
  B       start3x3While
colIf4:
  CMP     R2, #6
  BGE     colIf5
  MOV     R4, 0x1e
  B       start3x3While
colIf5:
  CMP     R2, #9
  BGE     endCountIn3x3
  MOV     R4, 0x21
  B       start3x3While

rowIf3:
  CMP     R1, #9
  BGE     endCountIn3x3
  CMP     R2, #3
  BGE     colIf6
  MOV     R4, 0x36
  B       start3x3While
colIf6:
  CMP     R2, #6
  BGE     colIf7
  MOV     R4, 0x39
  B       start3x3While
colIf7:
  CMP     R2, #9
  BGE     endCountIn3x3
  MOV     R4, 0x3c
  B       start3x3While

start3x3While:
  ADD     R4, R4, R0
  MOV     R0, #0
  MOV     R6, #9
  MOV     R5, #0
ColWhile3x3:
  CMP     R5, #3
  BGE     endCountIn3x3
  CMP     R5, #0
  BEQ     afterSmolIf
  ADD     R4, R4, R6
afterSmolIf:
  MOV     R7, #0
RowWhile3x3:
  CMP     R7, #3
  BEQ     end3x3RowWhile
  ADD     R8, R4, R7
  LDRB    R9, [R8]
  CMP     R9, R3
  BNE     after3x3If
  ADD     R0, R0, #1
after3x3If:
  ADD     R7, R7, #1
  B       RowWhile3x3
end3x3RowWhile:
  ADD     R5, R5, #1
  B       ColWhile3x3
endCountIn3x3:

  POP     {R4-R9, PC}



@ nextInCell subroutine
@ Find the next higher valid value that can be placed in a specified cell in a
@   Sudoku grid.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number of cell
@   R2: column number of cell
@ Return:
@   R0: next higher value or 0 if there is no valid higher value
nextInCell:
  PUSH    {R4-R7, LR}

  @
  @ Your subroutine implementation goes here
  @

  MOV     R4, R0 @MEM
  MOV     R5, R1 @ROW
  MOV     R6, R2 @COL
  MOV     R7, #1 @COUNTER
nextWhile:
  CMP     R7, #9
  BGT     noResult
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R7
  BL      countInRow
  CMP     R0, #0
  BNE     incCounter
  MOV     R0, R4
  MOV     R1, R6
  MOV     R2, R7
  BL      countInCol
  CMP     R0, #0
  BNE     incCounter
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R6
  MOV     R3, R7
  BL      countIn3x3
  
  CMP     R0, #0
  BNE     incCounter
  MOV     R0, R7
  B       endNext

incCounter:
  ADD     R7, R7, #1
  B       nextWhile

noResult:
  MOV     R0, #0
endNext:

  POP     {R4-R7, PC}



@ solveSudoku subroutine
@ Solve a Sudoku puzzle.
@
@ Parameters:
@   R0: start address of 2D array representing the Sudoku grid
@   R1: row number of next cell to modify
@   R2: column number of next cell to modify
@ Return:
@   R0: 1 if a solution was found, zero otherwise
solveSudoku:
  PUSH    {R4-R12, LR}

  @
  @ Your subroutine implementation goes here
  @
  
  MOV     R4, R0
  MOV     R5, R1
  MOV     R6, R2
  MOV     R12, #0
  CMP     R5, #9
  BLO     afterFirstSolveIf
  MOV     R12, #1
  B       endSolve
afterFirstSolveIf:
  MOV     R12, #0
  ADD     R8, R6, #1
  MOV     R7, R5
  CMP     R8, #9
  BLO     afterSecondSolveIf
  MOV     R8,  #0
  ADD     R7, R7, #1
afterSecondSolveIf:
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R6
  BL      getArrayPos
  LDRB    R9, [R0]
  CMP     R9, #0
  BEQ     afterThirdSolveIf
  MOV     R0, R4
  MOV     R1, R7
  MOV     R2, R8
  BL      solveSudoku
  MOV     R12, R0
afterThirdSolveIf:
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R6
  BL      nextInCell
  MOV     R10, R0
  CMP     R10, #0
  BEQ     afterSolveWhile
  CMP     R12, #1
  BEQ     afterSolveWhile
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R6
  BL      getArrayPos
  STRB    R10, [R0]
  MOV     R0, R4
  MOV     R1, R7
  MOV     R2, R8
  BL      solveSudoku
  MOV     R12, R0
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R6
  BL      nextInCell
  MOV     R10, R0
afterSolveWhile:
  CMP     R12, #0
  BNE     afterFinalSolveIf
  MOV     R0, R4
  MOV     R1, R5
  MOV     R2, R6
  BL      getArrayPos
  MOV     R11, #0
  STRB    R11, [R0]
afterFinalSolveIf:
  MOV     R0, R12
  B       endSolve

endSolve:
  MOV     R0, R12

 
 

  POP     {R4-R12, PC}


@ Parameters:
@ R0 = startingMemAddress
@ R1 = rowNum
@ R2 = colNum
@ output:
@ R0 = memAddressOfIntersection
getArrayPos:
  PUSH    {R4-R7, R9, LR}

  MOV     R4, R0
  MOV     R5, R1
  MOV     R6, R2

  MOV     R9, #9

  MUL     R7, R5, R9
  ADD     R4, R4, R7
  ADD     R4, R4, R6

  MOV     R0, R4
  
  POP     {R4-R7, R9, PC}

  .end