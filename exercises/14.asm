.MODEL Small

SIZE EQU 10
; 2,4,5 postavljeni bitovi tako da su 
; bitovi od 7 do 0 postavljeni redom:
; 0b00110100 = 34h
MASK EQU 34h

.DATA
    znakovi DB SIZE+1 DUP('$')
ends

.CODE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AX, 0100h
    
    MOV CX, SIZE
    MOV DI, OFFSET znakovi
    
    petlja:
        INT 21h
        
        MOV DL, AL      ; Kopiraj da ne izgubimo vrijednost
        AND DL, MASK    ; Svodi se na logicki uvjet:
        CMP DL, MASK    ; (mask & bits) == mask
        
        JNE dalje
        MOV [DI], AL
        INC DI
        
        dalje:
        
        CMP AL, '0'
        LOOPNZ petlja
    
    MOV AX, 0200h
    
    MOV DL, 13
    INT 21h
    MOV DL, 10
    INT 21h
    
    MOV AX, 0900h
    MOV DL, OFFSET znakovi
    INT 21h
ends

END