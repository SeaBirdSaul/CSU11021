  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  fill


@ fill subroutine
@ Fills a contiguous sequence of words in memory with the same value
@ Parameters
@       [sp+0]: value – value to store in each word (1st Top Of Stack)
@       [sp+4]: length – number of words to be filled (2nd Top Of Stack)
@       [sp+8]: address – address of first word to be filled (3rd Top Of Stack)
fill:
  PUSH    {R4-R7,LR}            @ save registers
          
  LDR     R4, [SP, #28]         @ load address parameter (not popping)
  LDR     R5, [SP, #24]         @ load length parameter (not popping)
  LDR     R6, [SP, #20]         @ load value parameter (not popping)
        
  MOV     R7, #0                @ count = 0;
.LwhFill:
  CMP     R7, R5                @ while (count < length)
  BHS     .LeWhFill             @ {
  STR     R6, [R4, R7, LSL #2]  @  word[address + count * 4] = value;
  ADD     R7, #1                @  count = count + 1;
  B       .LwhFill              @ }
.LeWhFill:
  POP     {R4-R7,PC}            @ restore registers

  .end