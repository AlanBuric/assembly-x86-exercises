.model small

.data
    size equ 5
    string db size (?)
ends

unos macro kolicina, adresa
    MOV CX, kolicina
    MOV AH, 01h
    MOV DI, 0
    
    petlja:
        INT 21h
        MOV adresa[DI], AL
        
        INC DI
        LOOP petlja
endm

.code
    unos size, string
ends

end