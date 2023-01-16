   
; =============================================================================
; AUDIO MANAGEMENT
; =============================================================================


; -----------------------------------------------------------------------------
AUDINIT
; CHANGES AUDIO TO PLAY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	
	MOVEM.W D0-D2, -(A7)
	MOVEM.W A0-A1, -(A7)
;LOAD ELEVATOR MUSIC IN POS 0 
	MOVE.B #71, D0
	LEA ELEVATOR_MUSIC, A1
	MOVE.B #0, D1
	TRAP #15
;LOAD HEAVEN MUSIC IN POS 1
	LEA HEAVENSOUND, A1
	MOVE.B #1, D1
	TRAP #15
;LOAD HELL MUSIC IN POS 2
	LEA HELLSOUND, A1
	MOVE.B #2, D1
	TRAP #15
	MOVEM.W (A7)+, A0-A1
	MOVEM.W (A7)+, D0-D2

	RTS


; -----------------------------------------------------------------------------
AUDPLAY
; CHANGES AUDIO TO PLAY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
	
	MOVEM.L D0-D2, -(A7)
	MOVEM.W A0-A1, -(A7)	
	
	MOVE.W LOADEDMAP, D1
	       MULU #6, D1
	       MOVEA.W D1, A1
	       JMP MSCSEL(A1)
MSCSEL:
		   
		   JMP HEAVENMUSIC
		   
		   JMP HEAVENMUSIC
		   
		   JMP HEAVENMUSIC
		   
		   JMP HEAVENMUSIC
		   
		   JMP HELLMUSIC
		   
		   JMP HELLMUSIC
		   
		   JMP HELLMUSIC
		   
	       JMP HELLMUSIC
	       
	       

ELEVATORMUSIC
    MOVEM.W D0-D2 ,-(A7)
	MOVE.B #76, D0
	MOVE.B #0, D1
	MOVE.L #0, D2
	TRAP #15
	MOVEM.W (A7)+, D0-D2 
	MOVE.B #1, MUSICPLAYED
	RTS

HEAVENMUSIC	
	MOVE.B #76, D0
	MOVE.B #0, D1
	MOVE.L #2, D2
	TRAP #15
	MOVE.B #76, D0
	MOVE.B #1, D1
	MOVE.L #0, D2
	TRAP #15
	MOVEM.W (A7)+, A0-A1
	MOVEM.L (A7)+, D0-D2
	RTS
HELLMUSIC
	MOVE.B #76, D0
	MOVE.B #0, D1
	MOVE.L #2, D2
	TRAP #15
	MOVE.B #76, D0
	MOVE.B #2, D1
	MOVE.L #0,  D2
	TRAP #15
	MOVEM.W (A7)+, A0-A1
	MOVEM.L (A7)+, D0-D2
	RTS

FIREDSOUND
	MOVEM.W D0-D2, -(A7)
	MOVEM.W A0-A1, -(A7)
	MOVE.B #73, D0
	LEA PROJ_SOUND, A1
	TRAP #15
	MOVEM.W (A7)+, A0-A1
	MOVEM.W (A7)+, D0-D2
	RTS


*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
