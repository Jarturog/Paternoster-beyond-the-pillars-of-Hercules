; ==============================================================================
; GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES GAME.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
           * CLR.W LOADEDMAP
            JSR     PLAYERINIT
            BRA 	AUDINIT

; ------------------------------------------------------------------------------
GAMUPD
; UPDATES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0/A1-A3,-(A7)
            
            ; CHECK IF MUSIC IS ALREADY PLAYING	
		    MOVE.B MUSICPLAYED, D0
		    CMP #1, D0
		    BEQ .NOMUSIC
			JSR AUDPLAY
; GENERAL UPDATES
.NOMUSIC	JSR PLAYERUPD	
			JSR MAPUPD
; SHOTS LOGIC		  
            MOVE.B  (KBDEDGE),D0
            AND.B #%11110000,D0 ; SI DA CERO NO HA DISPARADO
            BEQ.B .NOTFIRED
            JSR FIREDSOUND
            LEA     PROJINIT,A1
            LEA     PROJUPD,A2
            LEA     PROJPLOT,A3
            MOVE.W  #1,D0
            JSR     AGLADD
.NOTFIRED
            TST.W   (NPROJ)
            BEQ     .NOPROJ1
            JSR     AGLUPD
.NOPROJ1
            MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR MAPPLOT     
            TST.W   (NPROJ)
            BEQ     .NOPROJ2
            JSR     AGLPLOT
.NOPROJ2    BRA     PLAYERPLOT







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
