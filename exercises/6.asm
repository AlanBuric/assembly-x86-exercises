.MODEL Small

VELICINA equ 5

.DATA
    poruka DB VELICINA DUP(?), '$'
ends

.CODE
    MOV BX, @DATA
    MOV DS, BX
    MOV DI, OFFSET poruka
    
    ulaz:
        MOV AH, 01h
        INT 21h
        
        MOV [DI], AL
        
        INC DI
        CMP DI, VELICINA
        JNE ulaz
    
    razmak:
        MOV AH, 02h
        MOV DL, 13
        INT 21h
        MOV DL, 10
        INT 21h
    
    ispis:
        MOV DX, OFFSET poruka
        MOV AH, 09h
        INT 21h
ends

END