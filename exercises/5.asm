.MODEL Small

MOV CX, 10

MOV DL, '3'
MOV AH, 02h

petlja:
    ; Za ispis u nove retke:
    
    ;MOV DL, 13
    ;INT 21h
    ;MOV DL, 10
    ;INT 21h
    ;MOV DL, '3'
    INT 21h
    
    LOOP petlja

END