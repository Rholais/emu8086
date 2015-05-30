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

	NAME "CH04_06"

STACK	SEGMENT	STACK
	DD	128	DUP(00000000H)
STACK	ENDS
	
DATA	SEGMENT
I16	DW	1234H
I32	DW	5678H,	90ABH
I48	DW	0000H,	0000H, 0000H
DATA	ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,	DS:DATA,	ES:DATA,	SS:STACK
START:  
	PUSHA
	
	MOV	AX,	DATA
	MOV	DS,	AX
	MOV	ES,	AX
	LEA	SI,	I32
	LEA	DI,	I48
	MOV	CX,	2
K1:
	MOV	AX,	I16
	MUL	W.[SI]
	ADD	[DI],	AX
	ADC	[DI+2],	DX
	ADD	SI,	2
	ADD	DI,	2
	LOOP	K1             ; external loop.
	
	POPA
	MOV	AH,	4CH
	INT	21H
CODE	ENDS

END	START
