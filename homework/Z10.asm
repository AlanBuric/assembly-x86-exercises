.MODEL Small

MOV AH, 01h ; DOS Interrupt za unos znaka
INT 21h     ; Poziv DOS prekida

MOV BL, AL  ; Broj je unesen u AL, pa ga pohranjujemo u BL jer prvo slijede dva znaka za novi red

MOV DL, 13  ; CR
MOV AH, 02h ; Poslije ovoga vise ne definiramo prekid 02h jer ostaje nepromijenjen
INT 21h

MOV DL, 10  ; LF
INT 21h

MOV DL, BL  ; Konacno uneseni broj ide iz BL u DL za ispis
INT 21h

END