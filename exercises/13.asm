.MODEL Small
.STACK

.DATA
    ; Izravno funkcijsko mapiranje vrijednosti tezina u njihove
    ; heksadecimalne znamenke
    heksa_abeceda DB '0123456789ABCDEF'
    buffer DB 0FFh, 254 DUP(?)
ends

.CODE
    MOV DX, @DATA
    MOV DS, DX
    MOV DX, OFFSET buffer
    MOV SI, DX
    
    MOV AX, 0A00h
    INT 21h
    
    MOV AX, 0200h
    
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    INC SI          ; Pokazuj na kolicinu unesenih znakova
    
    MOV CX, [SI]    ; Prepisi kolicinu u brojac
    XOR CH, CH      ; Adresiranje je prepisalo i sljedeci znak
    
    petlja:
        INC SI
        
        MOV BX, [SI]    ; Prepisuje po 2 bajta, dakle po 2 znaka, u obrnutome smjeru.
                        ; Prvi znak zavrsava u BL-u, a sljedeci u BH-u.
        XOR BH, BH      ; Izbrisi taj sljedeci znak
        SHR BL, 4       ; Pomakni udesno za 4 mjesta, cime se izolira High Nibble
        
        MOV DL, heksa_abeceda[BX]
        INT 21h
        
        MOV BX, [SI]
        AND BX, 0Fh     ; Ipak, izoliraj zadnji nibble
        
        MOV DL, heksa_abeceda[BX]
        INT 21h
        
        LOOP petlja     ; Umanjuje CX
ends
    
END