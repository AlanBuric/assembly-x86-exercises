.MODEL Small
.STACK

.DATA
    niz DB 'Pozdrav svima!$'
ENDS

.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV SI, OFFSET niz
    CALL ispisi_niz
    
    MOV AH, 4Ch
    INT 21h
    
    ispisi_niz PROC
        MOV AH, 02h
    
        petlja:       
            MOV DL, [SI]
            CMP DL, '$'
            JE kraj
        
            INT 21h
            INC SI
            JMP petlja
    
        kraj:
        
        RET
    ispisi_niz ENDP
ENDS

END