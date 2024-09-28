.MODEL Small

.DATA
    poruka DB 'Nema pozitivnih vrijednosti$'
ends

.CODE
    ; ENTER (simbol 13, carriage return), 
    ; uzima se kao sentinel vrijednost
    MOV AX, 0100h
    MOV BX, 0
    
    petlja:
        INT 21h
        
        CMP AL, 13
        JE izlaz
        
        CMP AL, '0'
        JE dalje
        
        MOV BX, 1   ; BX ce se ponasati kao zastavica
        
        dalje:
        
        JMP petlja
    
    izlaz:
    
    CMP BX, 0   ; Ako je zastavica ostala 0,
    JNE kraj    ; nije bilo pozitivnih brojeva.    
    
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV AH, 09h
    
    MOV BX, @DATA	; Prenamijeni isti registar jer
    MOV DS, BX		; nam vise nije potreban
    MOV DL, OFFSET poruka
    
    INT 21h
    
    kraj:
            
ends
    
END