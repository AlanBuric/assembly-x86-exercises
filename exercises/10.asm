; Napisati program koji unosi niz jednoznamankasatih brojeva dok se ne ucita 0 i ispisuje broj ucitanih parnih brojeva.
.Model Small

.CODE
    MOV BL, 0
    MOV CX, 9
    MOV AH, 01h
    
    petlja:
        INT 21h
        
        CMP AL, '0'
        JE kraj
        
        AND AL, 1
        JNZ preskoci
        
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