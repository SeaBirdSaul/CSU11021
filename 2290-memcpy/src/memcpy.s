  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:
 
  MOV R4, R2
.LwhMemCpy:
  CMP     R4, #40        
  BLO     .LeWhMemCpy 
  LDMIA   R1!, {R2, R3, R5-R12} 
  STMIA   R0!, {R2, R3, R5-R12}  
  SUB     R4, R4, #40
  B       .LwhMemCpy    
.LeWhMemCpy:

 @Original Johnny code
  CMP     R4, #0
  BLE     End_Main
  LDRB    R2, [R1], #1
  STRB    R2, [R0], #1
  SUB     R4, R4, #1
  B       .LeWhMemCpy

End_Main:
  BX    LR

  .end