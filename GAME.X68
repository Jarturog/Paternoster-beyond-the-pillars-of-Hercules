; ==============================================================================
; GAME MANAGEMENT
; ==============================================================================

; ------------------------------------------------------------------------------
GAMINIT
; INITIALIZES THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.W D0-D5,-(A7)
            MOVEM.L A1-A3,-(A7)
            
            MOVE.W  #60,D0
            MOVE.W  #$0000,D1       ; TURNING OFF MOUSE
            TRAP    #15
            
            CLR.L   (SECONDS)
            
            JSR UTLRAND
            BRA .1STRTRY
.1STROOM    SUB.W   #MAXOBSXROOM-1,D0
.1STRTRY    CMP.W   #MAXOBSXROOM,D0
            BGT.W   .1STROOM
            
            MOVE.W  D0,D5
            
            JSR UTLRAND
            BRA .2NDRTRY
.2NDROOM    SUB.W   #MAXOBSXROOM-1,D0
.2NDRTRY    CMP.W   #MAXOBSXROOM,D0
            BGT.W   .2NDROOM
            
            MOVE.W  D0,D2
            
            JSR UTLRAND
            BRA .3RDRTRY
.3RDROOM    SUB.W   #MAXOBSXROOM-1,D0
.3RDRTRY    CMP.W   #MAXOBSXROOM,D0
            BGT.W   .3RDROOM
            
            MOVE.W  D0,D3
            
            JSR UTLRAND
            BRA .4THRTRY
.4THROOM    SUB.W   #MAXOBSXROOM-1,D0
.4THRTRY    CMP.W   #MAXOBSXROOM,D0
            BGT.W   .4THROOM
            
            MOVE.W  D0,D4
            
            ; AGLADD
            MOVE.W  (LOADEDMAP),D1
            LEA     OBSINIT,A1
            LEA     STAEMPTY,A2
            LEA     OBSPLOT,A3
            MOVE.W  #OBSTYPE,D0
            
.LOOP1      
            JSR     AGLADD
            DBRA.W  D5,.LOOP1
            
            ADDQ.W  #1,D1
.LOOP2      JSR     AGLADD
            DBRA.W  D2,.LOOP2
            
            ADDQ.W  #1,D1
.LOOP3      JSR     AGLADD
            DBRA.W  D3,.LOOP3
        
            ADDQ.W  #1,D1
.LOOP4      JSR     AGLADD
            DBRA.W  D4,.LOOP4

            MOVEM.L (A7)+,A1-A3
            MOVEM.W (A7)+,D0-D5
            RTS
            

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
            MOVE.W  #PROJTYPE,D0
            JSR     AGLADD
.NOTFIRED
            JSR     AGLUPD
            MOVEM.L (A7)+,D0/A1-A3
            RTS

; ------------------------------------------------------------------------------
GAMPLOT
; PLOTS THE GAME
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            JSR     BLOCKSPLOT  
            JSR     AGLPLOT
            BRA     PLAYERPLOT















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
