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

	NAME "CH04_16"

DISP	MACRO	POS
	MOV	DX,	OFFSET POS
	MOV	AH,	09H
	INT	21H
DISP	ENDM
	
STACK	SEGMENT	STACK
	DD	128	DUP(00000000H)
STACK	ENDS
	
DATA	SEGMENT
MSG	DB	'Password:', 0DH, 0AH, '$'
PWD	DB	'ROOT', 00H, '$'
ERR	DB	0DH, 0AH, 'Sorry!', 0DH, 0AH, '$'
PSS	DB	0DH, 0AH, 'Hello!', 0DH, 0AH, '$'
DATA	ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,	DS:DATA,	SS:STACK
START:  
	PUSHA
	
	MOV	AX,	DATA
	MOV	DS,	AX
	LEA	SI,	PWD
	DISP	MSG
READY:
	MOV	AH,	01H
	INT	16H
	JZ	READY
	MOV	AH,	00H
	INT	16H
	CMP	[SI],	AL
	JE	PRT
	DISP	ERR
	JMP	BRK
PRT:
	MOV	AL,	'*'
	MOV	AH,	0EH
	INT	10H
	INC	SI
	CMP	[SI],	00H
	JNZ	READY
SUC:
	DISP	PSS
BRK:	
	POPA
	MOV	AH,	4CH
	INT	21H	
CODE	ENDS

END	START
