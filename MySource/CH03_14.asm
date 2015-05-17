	NAME "CH03_14"

STACK	SEGMENT	STACK
	DD	128	DUP(00000000H)
STACK	ENDS
	
DATA	SEGMENT
BLANK0	DB	1000H	DUP(00H)
BCD1	DB	12H,	34H,	56H,	78H,	90H,	12H,	34H,	56H
BLANK1	DB	0FF8H	DUP(00H)
BCD2	DB	78H,	90H,	23H,	45H,	67H,	89H,	45H,	67H
DATA	ENDS

CODE	SEGMENT
	ASSUME  CS:CODE,	DS:DATA,	ES:DATA,	SS:STACK
START:  
	PUSHA
	
	MOV	AX,	DATA
	MOV	DS,	AX
	MOV	ES,	AX
	LEA	SI,	BCD1
	LEA	DI,	BCD2
	CLC
	MOV	CX,     8
K1:	
	MOV	AL,     [SI]
	MOV	AH,     [DI]
	ADC	AL,	AH
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