.MODEL Small
.STACK

SIZE EQU 16
MASK EQU 1

.CODE
    MOV AX, 0100h
    
    XOR DH, DH      ; Isprazni DH
    MOV CX, SIZE
    XOR BX, BX      ; Postavi BX na 0
    
    petlja:
        INT 21h
        
        MOV DL, AL
        AND DL, MASK
        CMP DL, MASK
        
        JNE dalje
        MOV DL, AL
        PUSH DX
        INC BX
        
        dalje:
        
        CMP AL, '0'
        LOOPNZ petlja
    
    MOV CX, BX
    
    MOV AX, 0200h
    
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    CMP CX, 0
    JLE dalje2
    
    ispis:
        POP DX
        INT 21h
        LOOPNZ ispis
    
    dalje2:
        
ends

END