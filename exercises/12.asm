.Model Small

.DATA
    broj DB 231 ; 255, 1, 122,..
    heksa_abeceda DB '0123456789ABCDEF'
ends

.CODE
    MOV BX, @DATA
    MOV DS, BX
    
    MOV AH, 02h
    
    MOV BL, broj
    MOV BH, 0
    
    SHR BL, 4
    
    MOV DL, heksa_abeceda[BX]
    INT 21h
    
    MOV BL, broj
    
    SHL BL, 4   ; 4 najlijevija bita pomakni u BH
    MOV BH, 0   ; Njih ponisti na 0
    
    SHR BL, 4   ; Vrati natrag najdesnije bitove
    
    MOV DL, heksa_abeceda[BX]
    INT 21h
    
    MOV DL, 'H'
    INT 21h
ends

END