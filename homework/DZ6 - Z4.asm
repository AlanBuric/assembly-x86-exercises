.MODEL Small
.STACK

.DATA
    ; Izravno funkcijsko mapiranje vrijednosti tezina u njihove
    ; heksadecimalne znamenke
    heksa_abeceda DB '0123456789ABCDEF'
ends

; Ulazni parametri:
;   BX - broj
; Izlaz:
;   Broj u BX-u u heksadecimalnome obliku na konzoli/terminalu
.CODE
    MOV BX, 81Fh    ; Pohrani bilokakav broj u BX
    
    ; Cilj nam je u svakoj iteraciji ostvariti da je
    ; neki odabrani registar jednak i-tom po redu nibbleu
    ; originalnog broja. Originalni je broj pohranjen
    ; u 16-bitnom registru BX, pa su to 16 / 4 = 4 nibblea.
    
    ; Mogli bismo u svakoj iteraciji pomaknuti broj x puta
    ; u lijevo i y puta u desno, te u nekom trenutku
    ; prebrisati High polovicu registra i pomaknuti nibble
    ; da pocinje na LSB strani.
    ; Vjerojatno bismo mogli koristiti i stog.
    
    ; Druga opcija je postepeno pomaknuti broj 16 puta ulijevo,
    ; zapravo 4 puta po 4, u svakom koraku prepisujuci 4 bita u
    ; neki drugi registar. Na kraju ga citamo kao heksadecimalnu
    ; znamenku, ispisujemo i prebrisujemo registar te nastavljamo
    ; dalje.
    ; Ova se radnja ipak cini laksa i izvodi se u O(n) (linearnome)
    ; vremenu, gdje je n maksimalni broj bitova, u ovom slucaju 16 
	; (velicina registra).
    
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AX, 0200h
    
    MOV CX, 4				; 4 iteracije za 4 nibblea
    MOV SI, 0               ; Ocisti DI
    
    petlja:
        PUSH CX             ; Pohrani vanjski brojac za sada na stog
        MOV CX, 4           ; Inicijaliziraj unutarnji brojac
        
        petlja2:
            SHL BX, 1       ; pomakni sve ulijevo, MSB ide u CF
            RCL SI, 1       ; pomakni sve ulijevo, CF ide u LSB
            LOOP petlja2
        
        MOV DL, heksa_abeceda[SI]
        INT 21h
        MOV SI, 0           ; Resetiraj SI za sljedecu radnju
        
        POP CX              ; Vrati se na vanjski brojac
        LOOP petlja         ; Umanjuje CX
ends
    
END