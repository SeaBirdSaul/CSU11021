  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  isRowFull
  .global  lowestFull
  .global  removeRow
  .global  tetrominoFits
  .global  playTetromino


@
@ DEBUGGING TIP!!!
@
@ Use the WATCH window in Run/Debug mode to view each
@   row of the Tetris field.
@   <---------
@
@ Click the + in the WATCH view panel and set the
@   "expression to watch" to the following:
@
@   (char[20][10])(tetrisField)
@


@ isRowFull subroutine
@ Determines whether a row in a tetris field is full.
@
@ Parameters:
@   R0: address of tetris field
@   R1: row number
@
@ Return:
@   R0: 1 if the row is full, 0 otherwise
isRowFull:
  PUSH    {R4-R12, LR}

  MOV     R4, R0 @givenField = R0
  MOV     R5, R1 @givenRow = R1

@getToGivenRown
  MOV     R6, 0x0a
  MUL     R6, R5, R6 @tempNum = givenRow*10
  ADD     R6, R6, R4 @rowAddress = tempNum+givenField
  @MOV     R9, 0x03 @testValue
  @STRB    R9, [R6] @store testValue, test for working code

@checkGivenRow
  MOV     R7, #0 @i = 0
.LcheckWhile:
  CMP     R7, #10
  BEQ     .LendCheckWhile @while i < 10
  ADD     R8, R6, R7 @checkAddress= givenRowStartAddress + i
  LDRB    R9, [R8] @valueInCheck = load checkAddress
  CMP     R9, #0
  BNE     .LafterIf    
  MOV     R0, #0
  B       .LendIsRowFull
.LafterIf:
  ADD     R7, R7, #1
  B       .LcheckWhile
.LendCheckWhile:
  MOV     R0, #1
.LendIsRowFull:

  @ Your subroutine implementation goes here
  
  POP     {R4-R12, PC}


@ lowestFull subroutine
@ Finds the lowest (bottommost) full row of a Tetris field. Note
@   that the "lowest" row is the row with the highest index.
@
@ Parameters:
@   R0: address of tetris field
@
@ Return:
@   R0: number of lowest full row or -1 if there is no full row
lowestFull:
  PUSH    {R4-R12, LR}

@storeVariables
  MOV     R4, R0

@implementation
  MOV     R5, #19 @lowestRow = 19
.LlowestWhile:
  CMP     R5, #-1
  BEQ     .LendLowestWhile @while lowestRow != -1
  MOV     R0, R4
  MOV     R1, R5
  BL      isRowFull @check =isRowFull(givenField, lowestRow)
  CMP     R0, #1 @if check == 1
  BNE     .LafterLowestIf
  MOV     R0, R5 @return lowestRow
  B       .LendLowestFull
.LafterLowestIf:
  SUB     R5, R5, #1
  B       .LlowestWhile
.LendLowestWhile:
  MOV     R0, #-1

.LendLowestFull:

  @ Your subroutine implementation goes here
  
  POP     {R4-R12, PC}


@ removeRow subroutine
@ Removes a specified row from a Tetris field. The occupied
@   squares in rows above the removed row move downwards.
@
@ Parameters:
@   R0: address of tetris field
@   R1: row number to be removed
@
@ Return:
@   none
removeRow:
  PUSH    {R4-R12, LR}

  MOV     R4, R0
  MOV     R5, R1

//nukingTime
  MOV     R6, 0x0a
  MUL     R6, R6, R5
  ADD     R6, R6, R4 @rowAddress = (givenRow*10)+givenField
  MOV     R7, 0x00 @i = 0
nukingTime:
  CMP     R7, 0x0a 
  BEQ     .LendNukingTime @while i < 10
  ADD     R8, R6, R7 @valueToNuke = rowAddress+i
  MOV     R9, 0x00
  STRB    R9, [R8]
  ADD     R7, R7, 0x01
  B       nukingTime
.LendNukingTime:

@moveAboveRowsDown
  MOV     R6, R5 @saverRow = rowToNuke
.LmovingAdminWhile:
  CMP     R6, 0x00
  BEQ     .LendMovingAdminWhile
  SUB     R7, R6, 0x01 @rowAbove = saverRow-1
  MOV     R9, 0x0a
  MUL     R7, R7, R9 @rowAbove = rowAbove*10
  ADD     R7, R7, R4 @rowAbove = rowAbove+givenField
  MUL     R8, R6, R9 @rowBelow = saverRow*10
  ADD     R8, R8, R4 @rowBelow = rowBelow+givenField
  MOV     R9, 0x00 @j = 0
.LmovingWhile:
  CMP     R9, 0x0a @while j < 10
  BEQ     .LendMovingWhile
  ADD     R3, R7, R9
  LDRB    R10, [R3] @check = load[rowAbove+j]
  CMP     R10, 0x01 @if check ==1
  BNE     .LafterMovingIf
  ADD     R11, R8, R9 @rowBelow +j
  MOV     R12, 0x01 
  STRB    R12, [R11] @store 1 in rowBelow+j
  MOV     R12, 0x00
  STRB    R12, [R3] @store 0 in rowAbove+j
.LafterMovingIf:
  ADD     R9, R9, 0x01
  B       .LmovingWhile
.LendMovingWhile:
  SUB     R6, R6, 0x01
  B       .LmovingAdminWhile
.LendMovingAdminWhile:  


  @ Your subroutine implementation goes here
  
  POP     {R4-R12, PC}



@ tetrominoFits subroutine
@ Tests whether a given tetromino can be placed with its top
@   left corner at a specified row and column number in a
@   Tetris field.
@
@ Parameters:
@   R0: address of tetris field
@   R1: row number
@   R2: column number
@   R3: address of 4x4 tetromino
@
@ Return:
@   R0: 1 if the tetromino fits, 0 otherwise
tetrominoFits:
  PUSH    {R4-R12, LR}

@storeValues
  MOV     R4, R0 @givenField =R0
  MOV     R5, R1 @givenRow = R1
  MOV     R6, R2 @givenColumn = R2
  MOV     R7, R3 @tetrominoAddress =R3

@getTetrominoOnField
  MOV     R8, 0x0a
  MUL     R8, R5, R8 @givenRow*10
  ADD     R8, R8, R4 @rowOnField = rowOnField+givenField
  ADD     R8, R8, R6 @tetrominoTopLeft = rowOnField+givenColumn

@checkIfFits
  MOV     R9, 0x00 @rowCounter = 0
.LrowCounterWhile:
  CMP     R9, 0x04
  BEQ     .LendRowCounterWhile @while rowCounter != 4
  MOV     R10, 0x00 @columnCounter = 0
.LcolumnCounterWhile:
  CMP     R10, 0x04
  BEQ     .LendColumnCounterWhile @while columnCounter != 4
  MOV     R11, 0x04
  MUL     R11, R11, R9 @tetreminoValue=rowCounter*4
  ADD     R11, R11, R10 @tetreminoValue=tetreminoValue+columnCounter
  ADD     R11, R11, R3 @tetreminoValue=tetreminoValue+tetreminoAddress
  LDRB    R11, [R11] @load tetreminoValue
  CMP     R11, 0x01
  BNE     .LafterTetrominoCheck @if tetreminoValue == 1
  MOV     R12, 0x0a
  MUL     R12, R12, R9 @checkBox=rowCounter*10
  ADD     R12, R12, R10 @checkBox=checkBox+columnCounter
  ADD     R12, R12, R8 @checkBox=checkBox+tetreminoTopLeft
  LDRB    R12, [R12] @load checkBox
  CMP     R12, 0x01
  BNE     .LafterTetrominoCheck
  MOV     R0, 0x00
  B       .LendTetrominoFits
.LafterTetrominoCheck:
  ADD     R10, R10, 0x01
  B       .LcolumnCounterWhile
.LendColumnCounterWhile:
  ADD     R9, R9, 0x01
  B       .LrowCounterWhile
.LendRowCounterWhile:
  MOV     R0, 0x01
.LendTetrominoFits:
  @ Your subroutine implementation goes here
  
  POP     {R4-R12, PC}



@ playTetromino subroutine
@ Given a Tetris field and a tetromino, finds the lowest
@   position to which the tetromino would drop from a given
@   starting position, updates the field with the tetromino
@   at that position and updates the board to remove any
@   rows that become full by placing the tetromino.
@
@ Parameters:
@   R0: address of tetris field
@   R1: starting tetromino row number
@   R2: starting tetromino column number
@   R3: address of 4x4 tetromino
@
@ Return:
@   R0: 1 if the tetromino could be played, 0 otherwise
playTetromino:
  PUSH    {LR}

  @ Your subroutine implementation goes here
  
  POP     {PC}


  .end