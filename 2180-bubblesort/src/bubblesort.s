  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

@
@ Implement the well-known bubblesort algorithm to sort a sequence
@ of word-size values in ascending order. The values should be sorted
@ 'in-place', overwriting the original sequence. A pseudocode description
@ of 'bubblesort' is provided below for convenience.
@
@ The sequence of values ('array' below) begins in memory at the address in R0.
@ The number of values in the sequence (variable 'n' below) is in R1.
@
@ do {
@   swapped = false;
@   for (i = 1; i < n; i++) {
@     if (array[i−1] > array[i]) {
@       tmpswap = array[i−1];
@       array[i−1] = array[i];
@       array[i] = tmpswap;
@       swapped = true ;
@     }
@   }
@   n = n - 1;
@ } while ( swapped );
@

@R0 = array
@R1 = n
@R2 = swapped
@R3 = i 
@R4 = tempswap
doWhile:
  MOV R2, #0@swapped=false
  MOV R3, #1 @i=1
  CMP R3, R1
  BHS endFor @i<n
  


  ADD R3, R3, #1
endFor:

End_Main:
  BX    LR

  .end