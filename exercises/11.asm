.MODEL Small

unos_znaka MACRO
    MOV AH, 01h
    INT 21h
unos_znaka ENDM

.CODE
    MOV BL, 0
    MOV CX, 9
    
    petlja:
        unos_znaka
        
        CMP AL, '0'
        JE kraj
        
        AND AL, 1
        JZ preskoci
        
        INC BL
        
        preskoci:       
    
        LOOP petlja
    
    kraj:
    
    MOV AH, 02h
    
    MOV DL, 10
    INT 21h
    MOV DL, 13
    INT 21h
    
    MOV DL, BL
    ADD DL, 30h
    INT 21h
ends

END