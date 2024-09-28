.model small

.data
    size equ 5
    string db size (?)
ends

NL macro
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
endm

.code
    MOV CX, size
    MOV AH, 01h
    MOV DI, 0
    
    unos:
        INT 21h
        MOV string[DI], AL
        
        INC DI
        LOOP unos    
    
    MOV CX, size
    MOV AH, 02h
    MOV DI, 0
    
    ispis:
        NL
        MOV DL, string[DI]
        INT 21h
        INC DI
        LOOP ispis
ends

end