  .syntax unified
  .cpu cortex-m3
  .fpu softvfp
  .thumb
  
  .global  Main

Main:

  @ Translate the pseudocode below into ARM Assembly Langauge.
  @ Assume v is a value in R1 and a is a value in R0.

  @ if (v < 10) {
  @ 	a = 1;
  @ }
  @ else if (v < 100) {
  @ 	a = 10;
  @ }
  @ else if (v < 1000) {
  @ 	a = 100;
  @ }
  @ else {
  @ 	a = 0;
  @ }  

  @ *** your solution goes here ***

  CMP R1, #10
  BHS ElseIf
  MOV R0, #1
  B   EndIf

ElseIf:
  CMP R1, #100
  BHS ElseIfIf
  MOV R0, #10
  B   EndIf

ElseIfIf:
  CMP R1, #1000
  BHS ElseStat
  MOV R0, #100
  B   EndIf

ElseStat:
  MOV R0, #0
  B   EndIf

EndIf:


End_Main:
  BX    LR

  .end