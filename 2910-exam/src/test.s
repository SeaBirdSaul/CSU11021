  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb

  .global  Main
  .global  tetrisField
  .global  tetromino

@
@ HINT!!!
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


@
@ Test each subroutine
@
  .section  .text
  .type     Init_Test, %function
Main:
  PUSH    {LR}

  @ Test isRowFull (full)
  LDR     R0, =tetrisField
  LDR     R1, =17
  BL      isRowFull           @ should be TRUE / 1
  
  @ Test isRowFull (not full)
  LDR     R0, =tetrisField
  LDR     R1, =19
  BL      isRowFull           @ should be FALSE / 0

  @ Test lowestFull (18)  
  LDR     R0, =tetrisField
  BL      lowestFull          @ should be 18 (0x12)

  @ Test removeRow
  LDR     R0, =tetrisField
  LDR     R1, =17
  BL      removeRow           @ check field

  @ Test tetrominoFits (fits)
  LDR     R0, =tetrisField
  LDR     R1, =14
  LDR     R2, =3
  LDR     R3, =tetromino
  BL      tetrominoFits      @ should be TRUE / 1

  @ Test tetrominoFits (does not fit)
  LDR     R0, =tetrisField
  LDR     R1, =16
  LDR     R2, =5
  LDR     R3, =tetromino
  BL      tetrominoFits      @ should be FALSE / 0

  @ Test playTetromino
  LDR     R0, =tetrisField
  LDR     R1, =7
  LDR     R2, =3
  LDR     R3, =tetromino
  BL      playTetromino      @ check field

End_Main:
  POP     {PC}



  .section  .data.test

@
@ The sample Tetris field below is the field shown
@   in Part 1 of the examination paper.
@

tetrisField:                            @ row    address
  @ Example #1
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 0   0x20000000
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 1   0x2000000A
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 2   0x20000014
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 3   0x2000001E
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 4   0x20000028
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 5   0x20000032
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 6   0x2000003C
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 7   0x20000046
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 8   0x20000050
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 9   0x2000005A
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 10  0x20000064
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 11  0x2000006E
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 12  0x20000078
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 13  0x20000082
  .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0    @ 14  0x2000008C
  .byte 0, 0, 0, 0, 0, 1, 0, 1, 0, 0    @ 15  0x20000096
  .byte 1, 0, 0, 1, 0, 1, 0, 1, 0, 1    @ 16  0x200000A0
  .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1    @ 17  0x200000AA
  .byte 1, 1, 1, 1, 1, 1, 1, 1, 1, 1    @ 18  0x200000B4
  .byte 1, 1, 1, 1, 1, 1, 0, 1, 1, 1    @ 19  0x200000BE


@
@ The sample tetromino below is the tetromino shown
@   in Part 4 of the examination paper.
@

tetromino:
  .byte 1, 0, 0, 0
  .byte 1, 1, 0, 0
  .byte 0, 1, 0, 0
  .byte 0, 0, 0, 0

.end