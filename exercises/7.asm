.MODEL Small

SIZE equ 10

.DATA
    niz DB SIZE DUP(?), '$'
ends

.CODE
    MOV BX, @DATA
    MOV DS, BX
    MOV DI, OFFSET niz
    
    unos:
        MOV AH, 01h
        INT 21h
        
        MOV [DI], AL
        
        INC DI
        CMP DI, SIZE
        JNE unos
    
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV DI, OFFSET niz
    MOV AH, 02h
    
    ispis:
        MOV DL, [DI]
        INT 21h
        
        MOV DL, ' '
        INT 21h
        
        INC DI
        CMP DI, SIZE
        JNE ispis
    
    ; Zanemarimo cinjenicu da je na kraju
    ; ispisan suvisan razmak... za to bi
    ; bila potrebna dodatna provjera.
    
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV DI, OFFSET niz
    MOV AH, 02h
    
    MOV CL, [DI]    ; U CL pohranjujemo prvi najmanji broj
    MOV CH, [DI]    ; U CH pohranjujemo prvi najveci broj
    
    INC DI
    
    najmanji_najveci:
        CMP CL, [DI]    ; Najmanji
        JBE veci
        
        MOV CL, [DI]
        
        veci:
        
        CMP CH, [DI]
        
        JAE manji
        
        MOV CH, [DI]
            
        manji:
        
        INC DI
        CMP DI, SIZE
        JNE najmanji_najveci
    
    MOV DL, CL  ; Najmanji
    INT 21h
    
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV DL, CH  ; Najveci
    INT 21h
ends

END