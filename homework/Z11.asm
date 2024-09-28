.MODEL Small

; Postavljamo pocetne uvjete
MOV CL, 'A' ; Pocetno slovo u counter register kao brojac
MOV AH, 02h ; Naredba koju cemo citavo vrijeme koristiti

petlja:
    MOV DL, CL ; Trenutno slovo iz CL u DL za ispis
    INT 21h    ; Ispis slova
    
    MOV DL, 13 ; Pohrani carriage return
    INT 21h    ; Ispisi ga
    MOV DL, 10 ; Pohrani line feed
    INT 21h    ; Ispisi ga
    
    INC CL     ; Pomakni slovo za 1
    
    CMP CL, 'F'; Usporedi trenutno slovo s krajem petlje
    JB petlja  ; Ako je prvi broj manji od drugog, nastavi s petljom

END