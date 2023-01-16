; ==============================================================================
; OBSTACLE MANAGEMENT (AGENT)
; OBSPOSX (W)  (A0)
; OBSPOSY (W) 2(A0)
; OBSMAP  (W) 4(A0)
; ==============================================================================

; ------------------------------------------------------------------------------
OBSINIT
; INITIALIZES AN OBSTACLE
; INPUT    : D1.W IS MAP'S OBSTACLE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

        MOVEM.L D0-D6/A2,-(A7)
        
        MOVE.W  D1,4(A0)
.OORANH JSR UTLRAND
        LSL.W   #1,D0 ; x2
        CMP.W   #SCRHEIGH,D0
        BGT.W   .OORANH ; OUT OF RANGE HEIGHT
        MOVE.W  D0,D1
.OORANW JSR UTLRAND
        LSL.W   #1,D0 ; x2
        CMP.W   #SCRWIDTH,D0
        BGT.W   .OORANW ; OUT OF RANGE WIDTH
        
        MOVE.W  D0,D4   ; OBSPOSX
        MOVE.W  D1,D5   ; OBSPOSY
        ; CHECK COLLISIONS
        ; TOP LEFT CORNER
        SWAP.W  D0
        MOVE.W  D1,D0
        
        ADD.W   #OBSHEIGHT,D1
        SWAP.W  D1
        MOVE.W  D4,D1
        ADD.W   #OBSWIDTH,D1
        
        MOVE.W  (LOADEDMAP),D6
        MOVE.W  4(A0),(LOADEDMAP)
        LEA.L   BLWHICHNTRA,A2
        JSR BLKCOLL
        MOVE.W  D6,(LOADEDMAP)
        TST.L   D0
        BNE.L   .OORANH 
        TST.L   D1
        BNE.L   .OORANH 
        TST.L   D2
        BNE.L   .OORANH 
        TST.L   D3
        BNE.L   .OORANH 
        
        MOVE.W  D4,(A0)
        MOVE.W  D5,2(A0)
        
        ADD.W   #1,(NOBS)
        
        MOVEM.L (A7)+,D0-D6/A2
        RTS

; ------------------------------------------------------------------------------
OBSPLOT
; PLOTS AN OBSTACLE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        MOVE.B  D0,-(A7)
        MOVE.L  D1,-(A7)
	    MOVEM.W D2-D4, -(A7)
	    
        MOVE.W  4(A0),D1
        CMP.W   (LOADEDMAP),D1
        BNE     .NOPLOT          ; IT IS NOT FROM THIS MAP
        
	    MOVE.L #$00AA4411,D1 ;PEN COLOR
	    MOVE.B #80,D0
	    TRAP #15
	    MOVE.L #$003322EE,D1 ;FILL COLOR
	    MOVE.B #81,D0
	    TRAP #15
	    ; SE DIBUJA EL CUADRADO
	    MOVE.W (A0),D1	
	    MOVE.W 2(A0),D2	  
	    MOVE.W D1,D3
        ADD.W  #OBSWIDTH,D3	
	    MOVE.W D2,D4
        ADD.W  #OBSHEIGHT,D4
	    MOVE.B #87,D0
	    TRAP #15
.NOPLOT	  
        MOVEM.W (A7)+,D2-D4
        MOVE.L  (A7)+,D1	  
        MOVE.B  (A7)+,D0
        
        RTS
        
; ------------------------------------------------------------------------------
HITOBS
; DESTROYS AN OBSTACLE
; INPUT    : A0 POINTING LOCAL MEMORY
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
        JSR     AGLKILL
        SUB.W   #1,(NOBS)
        TST.W   (NOBS)      ; IF THERE IS NO MORE OBSTACLES
        BNE.W   .NOTEND
        MOVE.W  #3,(STANEXT)
.NOTEND RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
