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

	NAME "CH04_08"

STACK	SEGMENT	STACK
	DD	128	DUP(00000000H)
STACK	ENDS
	
DATA	SEGMENT
ARRAY	DB	32	DUP(0FH)
PRIME	DD	10	DUP(00H)
DATA	ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,	DS:DATA,	ES:DATA,	SS:STACK
START:  
	PUSHA
	
	MOV	AX,	DATA
	MOV	DS,	AX
	MOV	ES,	AX
	LEA	SI,	ARRAY
	LEA	DI,	PRIME
	MOV	W.[SI],	0000H
	MOV	CX,	10
K1:
K2:		
		INC	SI
		TEST	[SI],	0FH
		JZ	K2
	MOV	[DI],	SI
L2:	
		MOV	[SI],	00H
		ADD	SI,	[DI]
		CMP	SI,	32
		JB	L2
	LEA	SI,	ARRAY
	INC	DI
	LOOP	K1	; external loop.
	
	POPA
	MOV	AH,	4CH
	INT	21H
CODE	ENDS

END	START
