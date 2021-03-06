DATA SEGMENT 
	ENG DB 'SUNSUNSUN', 0DH, 0AH, '$'
	ENG_LEN DW $ - ENG
	RESULT DB 'SUN: ', '$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:
	MOV AX, DATA
	MOV DS, AX

	MOV CX, OFFSET ENG_LEN
	SUB CX, 3
	MOV SI, OFFSET ENG
	MOV BX, 0		;记录数量
	
FIND_SUB:
	CMP [SI], 'S'	
	JNZ NOT_MATCH
	CMP [SI + 1], 'U'
	JNZ NOT_MATCH
	CMP [SI + 2], 'N'	;模式匹配
	JNZ NOT_MATCH
MATCH:		
	INC BX				
	ADD SI, 2		;因为SUN不是自己的前缀，所以下标直接加2  
NOT_MATCH:
	INC SI
	CMP SI, CX
	JB FIND_SUB


	MOV AH, 09H		;输出提示
	MOV DX, OFFSET RESULT
	INT 21H			

	MOV AX, BX
    	MOV BL, 0AH
OUTLOOP:   
    
	DIV BL
	MOV DL, AH
	ADD DL, '0'
	MOV AH, 02H
	INT 21H
	CMP AL, 0
	JZ OUTLOOP		;输出数量
	
	MOV AH, 4CH
	INT 21H
CODE ENDS
	END START