; =============================================================================
; MAP MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
MAPINIT
; INITALIZES THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            LEA.L   PATRONPLOT,A0
            MOVE.L  PATRON0,(A0)+
            MOVE.L  PATRON1,(A0)+
            MOVE.L  PATRON2,(A0)+
            MOVE.L  PATRON3,(A0)+
            MOVE.L  PATRON4,(A0)+
            MOVE.L  PATRON5,(A0)+
            MOVE.L  PATRON6,(A0)+
            MOVE.L  PATRON7,(A0)
            MOVEM.L (A7)+,D0/A0
            RTS  
PATRON0
            CLR.B  D7
            RTS
PATRON1
            ADD.B  #1,D7
            RTS
PATRON2
            ADD.B  #2,D7
            RTS
PATRON3
            ADD.B  #3,D7
            RTS
PATRON4
            ADD.B  #4,D7
            RTS
PATRON5
            ADD.B  #5,D7
            RTS
PATRON6
            ADD.B  #6,D7
            RTS
PATRON7
            ADD.B  #7,D7
            RTS
; -----------------------------------------------------------------------------
MAPUPD
; UPDATES THE MAP IF PLAYER CHANGES SCREEN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
MAPPLOT
; PLOTS THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
*            LEA.L   PATRONPLOT,A0
*            MOVE.W  #NPATRONS-1,D0
*.LOOP       JSR     (A0)                   ; EL CÓDIGO AQUÍ INTRODUCIDO SE CAMBIARÁ POR EL DIBUJO DE LOS 20 * 15 PATRONES
*            ADDA.W  #4,A0                  ; SE USARÁ LA VARIABLE MAP POINTER Y LA CONSTANTE MAPTILESIZE
*            DBRA.W  D0,.LOOP
            MOVEM.L (A7)+,D0/A0
            RTS     




*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
