.MODEL Small
.STACK

.DATA
    size equ 5
    niz DB size DUP (?)
ENDS

NL macro
    MOV AH, 02h
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
endm

.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV DI, OFFSET niz
    CALL unesi_niz
    
    MOV SI, OFFSET niz
    CALL sortiraj_niz
    
    NL
    
    MOV SI, OFFSET niz
    CALL ispisi_niz
    
    MOV AH, 4Ch
    INT 21h
    
    unesi_niz PROC
        MOV AH, 01h
        MOV CX, size
    
        petlja1:
            INT 21h       
            MOV [DI], AL
            INC DI
            LOOP petlja1
    
        kraj:
        
        RET
    unesi_niz ENDP
    
    sortiraj_niz PROC
        MOV CX, size
        DEC CX		; i < duljina
    
        ; Selection sort algoritam (sortiranje odabirom)
        ; U nesortiranome nizu uvijek trazimo najmanji broj za uzlazni poredak
        vanjska:
    	    MOV BX, SI	; min = i
    	    MOV DI, SI	; j = i
    	    INC DI		; j++
    	    ; => j = i + 1
    
    	    unutarnja:
    		    MOV AL, [DI]		; AX = niz[j]
    		    CMP AL, [BX]		; CMP niz[j], niz[min]
    		    JGE preskoci_zamjenu
    		
    		    MOV BX, DI		; min = j
    
    		    preskoci_zamjenu:
    
    		    INC DI			; j++
    		    CMP DI, size
    		    JNE unutarnja
    	
    	    CMP BX, SI              ; ako je najmanji zapravo onaj trenutni
    	    JE preskoci_zamjenu2
    	
    	    MOV AL, [BX]         ; inace smo pronasli novi najmanji, zamjeni
    	    MOV DL, [SI]
    	    MOV [BX], DL
    	    MOV [SI], AL
        
    	    preskoci_zamjenu2:
    
    	    INC SI	
    	    LOOP vanjska
        RET            
    sortiraj_niz ENDP
    
    ispisi_niz PROC
        MOV AH, 02h
        MOV CX, size
    
        petlja2:       
            MOV DL, [SI]
            INT 21h
            INC SI
            LOOP petlja2
        
        RET
    ispisi_niz ENDP
ENDS

END