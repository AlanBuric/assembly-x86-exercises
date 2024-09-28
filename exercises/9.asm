.MODEL Small

size equ 10

.DATA
    niz DB size DUP(?)
ends

.CODE
    MOV BX, @DATA
    MOV DS, BX

    MOV CX, size
    MOV DI, 0
    
    MOV AH, 01h
    
    unos:
        INT 21h
        
        MOV niz[DI], AL
        
        INC DI
        LOOP unos
    
    MOV AH, 02h
    
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV BL, 0   ; U BL pohranjujemo boolean 'zastavicu' koja
                ; govori je li doslo do zamjene unutar i-te
                ; iteracije vanjske petlje
    MOV CX, size
    DEC CX          ; i = size - 1

    ; Optimizirani bubble sort algoritam (mjehuricasto sortiranje)
    ; Optimizaran je zbog:
    ; 1. Raniji izlaz kada unutarnja petlja nije provela niti jednu zamjenu
    ; 2. Nesortirani dio niza se smanjuje, sto smanjuje broj unutarnjih iteracija
    vanjska:
	    MOV DI, 0	; j = 0

	    unutarnja:
		    MOV AL, niz[DI]		    ; AL = niz[j]
		    CMP AL, niz[DI+1]	    ; CMP niz[j], niz[j+1]
		    
		    JLE preskoci_zamjenu    ; niz[j] >= niz[j+1]
		    
	        XCHG niz[DI+1], AL
	        XCHG niz[DI], AL
	        MOV BL, 1

		    preskoci_zamjenu:
            
            INC DI        ; j++
		    CMP DI, CX
		    JL unutarnja  ; j < i <=> j < size - 1 - i za i = 0...size-1
	    
	    CMP BL, 0
	    JE izlaz
	    LOOP vanjska
    
    izlaz:
    
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
ends

END