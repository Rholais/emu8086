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

	NAME "CH03_15"

STACK	SEGMENT	STACK
	DD	128	DUP(00000000H)
STACK	ENDS
	
DATA	SEGMENT
BLANK0	DB	02000H	DUP(00H)
ARRAY	DD	12345678H,	90ABCDEFH,	23456789H
DATA	ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,	DS:DATA,	SS:STACK
START:  
	PUSHA
	
	MOV	AX,	DATA
	MOV	DS,	AX
	MOV	SI,	02000H
	MOV	AL,	[SI]
	INC	SI
	CLC
	MOV	CX,     9
K1:	
	MOV	AH,     [SI]
	CMP	AH,	AL
	JL	ELS
	MOV	AL,	AH
	INC	SI
ELS:	LOOP	K1             ; external loop.
	LEA	SI,	ARRAY
	MOV	[SI],	AL
	
	POPA
	MOV	AH,	4CH
	INT	21H
CODE	ENDS

END	START
