.MODEL Small

.DATA
    size equ 10
    niz DB size DUP(?), '$'
ends

.CODE
    MOV CX, SIZE
    MOV DI, 0
    
    MOV AH, 01h
    
    unos:
        INT 21h
        
        MOV niz[BX], AL
        
        INC BX
        LOOP unos
    
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV SI, 0	; i = 0
    MOV CX, SIZE
    DEC CX		; i < 10

    ; Selection sort algoritam (sortiranje odabirom)
    ; U nesortiranome nizu uvijek trazimo najmanji broj za uzlazni poredak
    vanjska:
	    MOV BX, SI	; min = i
	    MOV DI, SI	; j = i
	    INC DI		; j++
	    ; => j = i + 1

	    unutarnja:
		    MOV AL, niz[DI]		; AX = niz[j]
		    CMP AL, niz[BX]		; CMP niz[j], niz[min]
		    JGE preskoci_zamjenu
		
		    MOV BX, DI		; min = j

		    preskoci_zamjenu:

		    INC DI			; j++
		    CMP DI, size
		    JNE unutarnja
	
	    CMP BX, SI              ; ako je najmanji zapravo onaj trenutni
	    JE preskoci_zamjenu2
	
	    MOV AL, niz[BX]         ; inace smo pronasli novi najmanji, zamjeni
	    MOV DL, niz[SI]
	    MOV niz[BX], DL
	    MOV niz[SI], AL
    
	    preskoci_zamjenu2:

	    INC SI	
	    LOOP vanjska
    
    MOV AH, 02h
    
    MOV SI, 0
    MOV CX, size
    
    ispis:
        MOV DL, niz[SI]
        INT 21h
        
        MOV DL, ' '
        INT 21h
        
        INC SI
        LOOP ispis
    
    ; Zanemarimo cinjenicu da je na kraju
    ; ispisan suvisan razmak... za to bi
    ; bila potrebna dodatna provjera.
    
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
ends

END