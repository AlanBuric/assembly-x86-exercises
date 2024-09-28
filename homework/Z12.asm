.MODEL Small

.DATA
    PORUKA DB 'Najveci broj je: $'
ends

; BL registar koristimo za pracenje najveceg broja.
; Odabrao sam BL registar jer mislim da niti jedna
; od ovih instrukcija ne utjece opcenito na EBX registar.

.CODE
    MOV CX, 0003h              ; Inicijaliziramo counter register na 3, sto je 4 - 1
                               ; jer cemo vec izvrsiti prvi unos.
    MOV AH, 01h
    INT 21h
    
    MOV BL, AL                 ; Prvim unosom inicijaliziramo relativni maksimum koji
                               ; pohranjujemo u BL.
    MOV AH, 02h
    MOV DL, 13				   ; Povratak na pocetak reda
    INT 21h
    MOV DL, 10				   ; Novi red
    INT 21h
    
    petlja:
        MOV AH, 01h
        INT 21h                ; Unos broja - uneseni broj zavrsava u AL registru
        
        CMP AL, BL             ; Usporedi AL s najvecim brojem koji drzimo u BL registru
        
        JG zamjena             ; Ako je AL > BL, zamjeni
        
        nastavak:              ; 'Prazna' labela za povratak 
                               ; (navodno se moze koristiti stack (stog), pa zatim CALL
                               ; instrukcija za ovakve slucajeve, jer stog pamti
                               ; instrukcije koje treba izvesti dalje i vratiti se)
        
        MOV AH, 02h
        MOV DL, 13			   ; Povratak na pocetak reda
        INT 21h
        MOV DL, 10			   ; Novi red
        INT 21h
        
        LOOP petlja            ; LOOP dekrementira ono sto je pohranjeno
                               ; u counter registeru (CX) i skace na navedenu labelu sve 
                               ; dok ono sto je u CX-u nije jednako nuli.
        JMP kraj               ; Do ovog ce se preskoka doci samo jednom, a to je kada je 
							   ; CX petlje jednak 0, tj. LOOP petlja se nije izveo.
    
    zamjena:
        MOV BL, AL             ; AL ide u BL
        JMP nastavak		   ; Petlja mora ici dalje bez obzira na zamjenu
    
    kraj:
    	MOV AX, @DATA		   ; Prijenos lokacije podatkovnog segmenta u AX	
	    MOV DS, AX			   ; Iz AX u DS koji se koristi za DOS Interrupt AH=09h
        MOV DX, OFFSET PORUKA  ; Pohrani adresu recenice za ispis (relativno za DATA segment)
        MOV AH, 09h            ; Odredi prekid
        INT 21h                ; Izvrsi prekid ispisa znakovnog niza
        
        MOV DL, BL             ; Pohrani jednoznamenkasti broj za ispis
        MOV AH, 02h            ; Odredi prekid
        INT 21h                ; Izvrsi prekid ispisa znaka
ends

END