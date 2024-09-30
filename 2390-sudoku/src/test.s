  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Init_Test
  .global  Main
  .global  testGrid

@
@ Main
@
@ An implementation of Main to test each of our subroutines
@ You should "comment out" all but one subroutine call
@   to test individual subroutines as you develop them.
@
@ Modify the tests to suit your needs.
@
Main:

  PUSH  {LR}

  LDR   R0, =testGrid
  LDR   R1, =2        @ row number
  LDR   R2, =5        @ value to look for
  BL    countInRow    @ countInRow(grid, row, value)

  LDR   R0, =testGrid
  LDR   R1, =8        @ row number
  LDR   R2, =9        @ value to look for
  BL    countInRow    @ countInRow(grid, row, value)

  LDR   R0, =testGrid
  LDR   R1, =0        @ column number
  LDR   R2, =9        @ value to look for
  BL    countInCol    @ countInCol(grid, row, value)

  LDR   R0, =testGrid
  LDR   R1, =6        @ column number
  LDR   R2, =1        @ value to look for
  BL    countInCol    @ countInCol(grid, row, value)

  LDR   R0, =testGrid
  LDR   R1, =3        @ row number
  LDR   R2, =6        @ column number
  LDR   R3, =1        @ value to look for
  BL    countIn3x3    @ countIn3x3(grid, row, col, value)

  LDR   R0, =testGrid
  LDR   R1, =8        @ row number
  LDR   R2, =4        @ column number
  LDR   R3, =2        @ value to look for
  BL    countIn3x3    @ countIn3x3(grid, row, col, value)

  LDR   R0, =testGrid
  LDR   R1, =1        @ row number
  LDR   R2, =7        @ column number
  BL    nextInCell    @ nextInCell(grid, row, col)

  LDR   R0, =testGrid
  LDR   R1, =6        @ row number
  LDR   R2, =0        @ column number
  BL    nextInCell    @ nextInCell(grid, row, col)

  @
  @ Finally, let's try to solve the puzzle ...
  @ (The initial call to the resursive solveSudoku subroutine
  @   should always start in the top-left corner.)
  @

  LDR   R0, =testGrid
  LDR   R1, =0        @ row number
  LDR   R2, =0        @ column number
  BL    solveSudoku   @ solveSudoku(grid, 0, 0)


End_Main:

   POP   {PC}


  .section  .data.test
@ Sudoku Test Grid
testGrid:
  .byte 2, 5, 7, 1, 3, 8, 6, 4, 9
  .byte 1, 4, 6, 2, 9, 5, 7, 8, 3
  .byte 3, 8, 9, 7, 6, 4, 5, 1, 2
  .byte 7, 2, 5, 8, 1, 6, 9, 3, 4
  .byte 4, 9, 3, 5, 7, 2, 1, 6, 8
  .byte 8, 6, 1, 9, 4, 3, 2, 7, 5
  .byte 9, 3, 4, 6, 5, 1, 8, 2, 7
  .byte 6, 7, 2, 3, 8, 9, 4, 5, 1
  .byte 5, 1, 8, 4, 2, 7, 3, 9, 6


@  .byte 2, 5, 7, 1, 3, 8, 6, 4, 9
@  .byte 1, 4, 6, 2, 9, 5, 7, 8, 3
@  .byte 3, 8, 9, 7, 6, 4, 5, 1, 2
@  .byte 7, 2, 5, 8, 1, 6, 9, 3, 4
@  .byte 4, 9, 3, 5, 7, 2, 1, 6, 8
@  .byte 8, 6, 1, 9, 4, 3, 2, 7, 5
@  .byte 9, 3, 4, 6, 5, 1, 8, 2, 7
@  .byte 6, 7, 2, 3, 8, 9, 4, 5, 1
@  .byte 5, 1, 8, 4, 2, 7, 3, 9, 6

@  .byte 5, 3, 4, 6, 7, 8, 9, 1, 2
@  .byte 6, 7, 2, 1, 9, 5, 3, 4, 8
@  .byte 1, 9, 8, 3, 4, 2, 5, 6, 7
@  .byte 8, 5, 9, 7, 6, 1, 4, 2, 3
@  .byte 4, 2, 6, 8, 5, 3, 7, 9, 1
@  .byte 7, 1, 3, 9, 2, 4, 8, 5, 6
@  .byte 9, 6, 1, 5, 3, 7, 2, 8, 4
@  .byte 2, 8, 7, 4, 1, 9, 6, 3, 5
@  .byte 3, 4, 5, 2, 8, 6, 1, 7, 9


@  .byte 5, 3, 4, 6, 7, 8, 0, 1, 2
@  .byte 6, 7, 2, 1, 9, 5, 3, 0, 8
@  .byte 1, 9, 8, 3, 4, 2, 0, 6, 7
@  .byte 8, 5, 9, 7, 6, 1, 4, 2, 3
@  .byte 4, 2, 6, 8, 5, 3, 7, 9, 1
@  .byte 7, 1, 3, 9, 2, 4, 8, 5, 6
@  .byte 0, 6, 1, 5, 3, 0, 2, 8, 4
@  .byte 2, 0, 7, 4, 1, 9, 6, 3, 5
@  .byte 3, 4, 0, 0, 8, 6, 1, 7, 9


.end