.MODEL Small

.DATA
	NIJE_VECI DB 'Nije veci$'
	VECI_JE DB 'Veci je$'
ends

.CODE
	MOV AX, 8 ; Radi se o brojcanoj vrijednosti,
	           ; ne o znakovoj vrijednosti
	           ; (znamenke od 30h do 39h)
	CMP AX, 10
	JG veci

	MOV BX, 0FFFFh
	
	MOV AX, @DATA
	MOV DS, AX
	MOV DX, OFFSET NIJE_VECI
	
	JMP kraj

	veci:
		MOV BX, 0h
		MOV AX, @DATA
		MOV DS, AX
		MOV DX, OFFSET VECI_JE

	kraj:
		MOV AH, 09h
		INT 21h
ends

END