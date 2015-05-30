;	Copyright 2015 LII Haw-cherng
;	
;	Licensed under the Apache License, Version 2.0 (the "License");
;	you may not use this file except in compliance with the License.
;	You may obtain a copy of the License at
;	
;	    http://www.apache.org/licenses/LICENSE-2.0
;	
;	Unless required by applicable law or agreed to in writing, software
;	distributed under the License is distributed on an "AS IS" BASIS,
;	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;	See the License for the specific language governing permissions and
;	limitations under the License.

	NAME "CH03_14"

STACK	SEGMENT	STACK
	DD	128	DUP(00000000H)
STACK	ENDS
	
DATA	SEGMENT
BLANK0	DB	01000H	DUP(00H)
BCD1	DD	12345678H,	90123456H
BLANK1	DB	00FF8H	DUP(00H)
BCD2	DD	78902345H,	67894567H
DATA	ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,	DS:DATA,	ES:DATA,	SS:STACK
START:  
	PUSHA
	
	MOV	AX,	DATA
	MOV	DS,	AX
	MOV	ES,	AX
	MOV	SI,	01000H
	MOV	DI,	02000H
	CLC
	MOV	CX,     8
K1:	
	MOV	AL,     [SI]
	ADC	AL,	[DI]
	DAA
	MOV	[DI],	AL
	INC	SI
	INC	DI 
	LOOP	K1             ; external loop.

	POPA
	MOV	AH,	4CH
	INT	21H
CODE	ENDS

END	START