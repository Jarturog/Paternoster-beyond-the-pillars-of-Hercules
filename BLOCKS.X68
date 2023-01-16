*-----------------------------------------------------------
*BLOCKS
*-----------------------------------------------------------

; -----------------------------------------------------------------------------
ISBLWHICHPROP 
; CHECKS IF THE BLOCK IN D4 IS ONE OF A LIST IN A0 WITH AN SPECIFIC PROPERY
; INPUT    - D4.B, A0.L
; OUTPUT   - ALL 1'S IF D4.L PRODUCES COLLISIONS, ALL 0'S IF NOT
; MODIFIES - D4.L, A0
; -----------------------------------------------------------------------------
            
.BNEXTCHCK  TST.B   (A2)
            BEQ.B   .BNOCOLL
            CMP.B   (A2),D4
            BEQ.B   .BCOLL
            ADDA.L  #1,A2
            BRA     .BNEXTCHCK
.BCOLL      ORI.L   #$FFFFFFFF, D4
            BRA     .BEND
.BNOCOLL    CLR.L   D4
.BEND
            RTS

; -----------------------------------------------------------------------------
BLKCOLL 
; DETECTS IF A RECTANGLE IN SPACE COLLIDES WITH BLOCKS IN A2'S LIST.
; INPUT    - D0 TOP LEFT CORNER OF OBJECT, D1 BOTTOM RIGHT, WHERE UPPER WORD
;            IS THE X COORDINATE AND LOWER WORD Y COORDINATE.
;            A2 IS THE LIST OF BLOCKS OF THE SAME PROPERTY THAT MATTERS
;            WHEN CHECKING COLLISIONS.
; OUTPUT   - ALL 1'S IN THE THE REGISTER THAT COLLIDES WITH A BLOCK
;            THAT CANNOT BE TRAVERSED. THESE ARE D0 FOR LEFT UPPER BLOCK,
;            D1 FOR RIGHT UPPER BLOCK, D2 FOR LEFT LOWER BLOCK AND D3 FOR 
;            RIGHT LOWER BLOCK
; MODIFIES - D0.L, D1.L, D2.L, D3.L
; -----------------------------------------------------------------------------
            MOVEM.L D4-D6/A0-A1,-(A7)
            
            MOVE.L  #16,D4
            MOVE.W  D0,D2   ; D2 CONTAINS X LEFT
            LSR.L   D4,D0   ; D0 CONTAINS Y UPPER
            MOVE.W  D1,D3   ; D3 CONTAINS X RIGHT
            LSR.L   D4,D1   ; D1 CONTAINS Y LOWER
            
            EXT.L   D0
            EXT.L   D1
            EXT.L   D2
            EXT.L   D3
            
            DIVU.W  #BLOCKSIZE,D0   ; LEFT BLOCK
            DIVU.W  #BLOCKSIZE,D1   ; RIGHT BLOCK
            DIVU.W  #BLOCKSIZE,D2   ; UPPER BLOCK
            DIVU.W  #BLOCKSIZE,D3   ; LOWER BLOCK
            
            EXT.L   D0
            EXT.L   D1
            EXT.L   D2
            EXT.L   D3
            
            MOVE.L  #BLOCKSROW+1,D4 ; +1 BECAUSE OF NULL
            MULU.W  D2,D4           ; INDEX OF COLUMN OF UPPER LEFT AND RIGHT BLOCKS
            MOVE.L  #BLOCKSROW+1,D5 ; +1 BECAUSE OF NULL
            MULU.W  D3,D5           ; INDEX OF COLUMN OF LOWER LEFT AND RIGHT BLOCKS
            
            MOVE.W  (LOADEDMAP),D6
            EXT.L   D6
            MULU    #4,D6
            LEA.L   MAPLIST,A0
            ADDA.L  D6,A0
            MOVEA.L (A0),A0         ; CURRENT MAP ADDRESS
            
            MOVEA.L A0,A1
            ADDA.L  D5,A1   
            ADDA.L  D1,A1           ; RIGHT LOWER BLOCK
            MOVE.B  (A1),D3         ; STORING BOTTOM RIGHT BLOCK IN D3
            
            MOVEA.L A0,A1
            ADDA.L  D5,A1   
            ADDA.L  D0,A1           ; LEFT LOWER BLOCK
            MOVE.B  (A1),D2         ; STORING BOTTOM LEFT BLOCK IN D2
            
            MOVEA.L A0,A1
            ADDA.L  D4,A1   
            ADDA.L  D1,A1           ; RIGHT UPPER BLOCK
            MOVE.B  (A1),D1         ; STORING TOP RIGHT BLOCK IN D1
            
            MOVEA.L A0,A1
            ADDA.L  D4,A1   
            ADDA.L  D0,A1           ; LEFT UPPER BLOCK
            MOVE.B  (A1),D0         ; STORING TOP LEFT BLOCK IN D0
            
            MOVE.B  D0,D4
            JSR     ISBLWHICHPROP 
            MOVE.L  D4,D0
            
            MOVE.B  D1,D4
            JSR     ISBLWHICHPROP 
            MOVE.L  D4,D1
            
            MOVE.B  D2,D4
            JSR     ISBLWHICHPROP 
            MOVE.L  D4,D2
            
            MOVE.B  D3,D4
            JSR     ISBLWHICHPROP 
            MOVE.L  D4,D3
            
            MOVEM.L (A7)+,D4-D6/A0-A1
            
            RTS

; -----------------------------------------------------------------------------
BLOCKSPLOT
; INPUT    - 
; OUTPUT   - 
; MODIFIES - 
; -----------------------------------------------------------------------------

		MOVEM.L D0-D7, -(A7)
		MOVEM.L A0-A6, -(A7)
	       MOVE.W LOADEDMAP, D1
	       MULU #12, D1
	       MOVEA.W D1, A1
	       JMP MAPSEL(A1)
MAPSEL:
		   LEA HEAVEN_0, A0
		   JMP NEXT
		   LEA HEAVEN_1, A0
		   JMP NEXT
		   LEA HEAVEN_END, A0
		   JMP NEXT
		   LEA HEAVEN_ROOM, A0
		   JMP NEXT
		   LEA HELL_0, A0
		   JMP NEXT
		   LEA HELL_1, A0
		   JMP NEXT
	       LEA HELL_END, A0
	       JMP NEXT
	       LEA HELL_ROOM, A0
	       JMP NEXT
			
NEXT
		   CLR.L D1
           MOVE.B (A0)+,D1
           MULU #6, D1
           MOVEA.L D1, A1
           JMP JMPLIST(A1)
           
JMPLIST: 
			JMP NEWLINE ; 0 = END OF ROW
			JMP DGHE    ; 1 = DRAW GRASS HEAVEN 
			JMP DBHL    ; 2 = DRAW BRICK HELL
			JMP DBHV    ; 3 = DRAW BRICK HEAVEN
			JMP DGHL    ; 4 = DRAW GRASS HELL
			JMP DF1HV   ; 5 = DRAW FLOOR 1 HEAVEN
			JMP DF1HL   ; 6 = DRAW FLOOR 1 HELL
			JMP DF2HV   ; 7 = DRAW FLOOR 2 HEAVEN
			JMP DDHL	; 8 = DRAW DOOR HELL
			JMP DDHV	; 9 = DRAW DOOR HEAVEN
			JMP DF2HL   ; 10 = DRAW FLOOR 2 HELL
			JMP ENDMAP  ; 11 = END OF THE MAP
			
DDHL
	MOVE.L #$00111111, -(A7)
	MOVE.L #$00111111, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6    
	JSR ENDBLOCK
	JMP NEXT
DDHV
	MOVE.L #$00FFFFFF, -(A7)
	MOVE.L #$00FFFFFF, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	JSR ENDBLOCK
	JMP NEXT
DGHE ;DRAW-GRASS-HEAVEN vvvR
	MOVE.L #$0099FF99, -(A7)
	MOVE.L #$0099FF99, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	; SET PEN COLOR 
	MOVE.B #80, D0
	MOVE.L #$0000CC00, D1
	TRAP #15
	;DRAW LINES   
	MOVE.B #84, D0 
	;LINEA 11 
	MOVE.W BPOSX1,D1
	ADD.W #6, D1
	MOVE.W BPOSY1, D2
	ADD.W #5, D2
	MOVE.W BPOSX1, D3
	ADD.W #9, D3
	MOVE.W BPOSY1, D4
	ADD.W #10, D4
	TRAP #15
	;LINEA 12
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	;LINEA 13
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	;LINEA 21
	MOVE.W BPOSX1,D1
	ADD.W #6, D1
	MOVE.W BPOSY1, D2
	ADD.W #20, D2
	MOVE.W BPOSX1, D3
	ADD.W #9, D3
	MOVE.W BPOSY1, D4
	ADD.W #25, D4
	TRAP #15
	;LINEA 22
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	;LINEA 23
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	JSR ENDBLOCK
	JMP NEXT
DBHL ;DRAW BRICK-HELL vvvR
	
	MOVE.L #$00010101, -(A7)
	MOVE.L #$00666666, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	;DRAW HORIZONTAL LINE
	MOVE.B #84, D0 
	MOVE.W BPOSX1, D1
	MOVE.W BPOSY1, D2
	ADD.W #16, D2
	MOVE.W BPOSX1, D3
	ADD.W #32, D3
	MOVE.W BPOSY1, D4
	ADD.W #16, D4
	TRAP #15
	;DRAW VERTICAL LINE 
	MOVE.W BPOSX1, D1
	ADD.W #16, D1
	MOVE.W BPOSY1, D2
	ADD.W #16, D2
	MOVE.W BPOSX1, D3
	ADD.W #16, D3
	MOVE.W BPOSY1, D4
	ADD.W #32, D4
	TRAP #15
	JSR ENDBLOCK	
	JMP NEXT
DBHV ;DRAW BRICK-HEAVEN vvvR
	
	MOVE.L #$00CCCCCC, -(A7)
	MOVE.L #$00D7EBFA, -(A7)
    JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	;DRAW HORIZONTAL LINE
	MOVE.B #84, D0 
	MOVE.W BPOSX1, D1
	MOVE.W BPOSY1, D2
	ADD.W #16, D2
	MOVE.W BPOSX1, D3
	ADD.W #32, D3
	MOVE.W BPOSY1, D4
	ADD.W #16, D4
	TRAP #15
	;DRAW VERTICAL LINE 
	MOVE.W BPOSX1, D1
	ADD.W #16, D1
	MOVE.W BPOSY1, D2
	ADD.W #16, D2
	MOVE.W BPOSX1, D3
	ADD.W #16, D3
	MOVE.W BPOSY1, D4
	ADD.W #32, D4
	TRAP #15 
	JSR ENDBLOCK
	JMP NEXT
DGHL ;DRAW GRASS HELL vvvR

	MOVE.L #$002255EE, -(A7)
	MOVE.L #$002255EE, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	; SET PEN COLOR 
	MOVE.B #80, D0
	MOVE.L #$000000CC, D1
	TRAP #15
	;DRAW LINES   
	MOVE.B #84, D0 
	;LINEA 11 
	MOVE.W BPOSX1,D1
	ADD.W #6, D1
	MOVE.W BPOSY1, D2
	ADD.W #5, D2
	MOVE.W BPOSX1, D3
	ADD.W #9, D3
	MOVE.W BPOSY1, D4
	ADD.W #10, D4
	TRAP #15
	;LINEA 12
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	;LINEA 13
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	;LINEA 21
	MOVE.W BPOSX1,D1
	ADD.W #6, D1
	MOVE.W BPOSY1, D2
	ADD.W #20, D2
	MOVE.W BPOSX1, D3
	ADD.W #9, D3
	MOVE.W BPOSY1, D4
	ADD.W #25, D4
	TRAP #15
	;LINEA 22
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	;LINEA 23
	ADD.W #8, D1	
	ADD.W #8, D3
	TRAP #15
	JSR ENDBLOCK
	JMP NEXT

DF1HV ; DRAW FLOOR_1 HEAVEN vvvR
	MOVE.L #$00CCCCCC, -(A7)
	MOVE.L #$00C6DAE9, -(A7)
    JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	JSR ENDBLOCK
	JMP NEXT
DF1HL ; DRAW FLOOR_1 HELL vvvR 
	MOVE.L #$00010101, -(A7)
	MOVE.L #$00777777, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6

	JSR ENDBLOCK
	JMP NEXT
	
DF2HV ;DRAW FLOOR_2 HEAVEN vvvR
	MOVE.L #$00CCCCCC, -(A7)
	MOVE.L #$00C6DAE9, -(A7)
    JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	;SET NEW FILL COLOR  
	MOVE.B #81, D0
	MOVE.L #$00D7EBFA, D1
	TRAP #15 
	;DRAW INSIDE SQUARE 
	MOVE.B #87, D0
	MOVE.W BPOSX1, D1
	ADD.W #8, D1
	MOVE.W BPOSY1, D2
	ADD.W #8, D2
	MOVE.W BPOSX2, D3
	SUB.W #8, D3
	MOVE.W BPOSY2, D4
	SUB.W #8, D4
	TRAP #15
	JSR ENDBLOCK
	JMP NEXT
DF2HL ; DRAW FLOOR_2 HELL vvvR
	MOVE.L #$00010101, -(A7)
	MOVE.L #$00777777, -(A7)
	JSR DRAWBLOCK
	MOVE.L (A7)+, D6 ;RETURN SP TO ORIGINAL STATE
	MOVE.L (A7)+, D6
	;SET NEW FILL COLOR  
	MOVE.B #81, D0
	MOVE.L #$00666666, D1
	TRAP #15 
;DRAW INSIDE SQUARE 
	MOVE.B #87, D0
	MOVE.W BPOSX1, D1
	ADD.W #8, D1
	MOVE.W BPOSY1, D2
	ADD.W #8, D2
	MOVE.W BPOSX2, D3
	SUB.W #8, D3
	MOVE.W BPOSY2, D4
	SUB.W #8, D4
	TRAP #15
	JSR ENDBLOCK
	JMP NEXT	
    
DRAWBLOCK 
;SE TIENE QUE PONER EN LA PILA EL PEN COLOR PRIMERO Y EL FILL COLOR DESPU?S COMO LONGS. 
	
	;SET FILL COLOR  
	MOVE.B #81, D0
	MOVE.L 4(A7), D1
	TRAP #15 
	
	; SET PEN COLOR 
	MOVE.B #80, D0
	MOVE.L 8(A7), D1
	TRAP #15 

	;DRAW BLOCK 
	MOVE.B #87, D0
	MOVE.W BPOSX1, D1
	MOVE.W BPOSY1, D2
	MOVE.W BPOSX2, D3
	MOVE.W BPOSY2, D4
	TRAP #15
	RTS

NEWLINE
	;RESET X POSITION
	MOVE.W #0, BPOSX1
	MOVE.W #32, BPOSX2
	;ADD 33 TO Y POSITION
	ADD.W #32, BPOSY1
	ADD.W #32, BPOSY2
	JMP NEXT
   
ENDBLOCK
	;SET NEW BLOCK POSITION
	ADD.W #32, BPOSX1
	ADD.W #32, BPOSX2
	RTS
ENDMAP
	;SET DEFAULT BLOCK POSITION
	MOVE.W #0, BPOSX1
	MOVE.W #0, BPOSY1
	MOVE.W #32, BPOSX2
	MOVE.W #32, BPOSY2
	MOVEM.L (A7)+, A0-A6
	MOVEM.L (A7)+, D0-D7
	RTS
	




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
