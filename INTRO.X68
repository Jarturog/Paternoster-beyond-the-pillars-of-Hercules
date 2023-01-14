; ==============================================================================
; INTRO SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.B  #61,D0          ; READ MOUSE
            MOVE.B  #2,D1           ; MOUSE DOWN STATE
            TRAP    #15
            ANDI.B  #%00001111, D0  ; MIDDLE, DOUBLE, LEFT AND RIGHT MASK
            BEQ.B   .DONE ; IF NO CLICK
            MOVE.W  #1,(STANEXT)
.DONE
            RTS
; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TITLE,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
            
            BTST.B  #4,(SCRCYCCT)
            BEQ     .DONE
            
            LEA     .HINT,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.DONE       MOVEM.L (A7)+,D0-D1/A0

            RTS
.TITLE      DC.B    'PATERNOSTER: LAS COLUMNAS DEL OLIMPO',0
.HINT       DC.B    'CLICK ANYWHERE TO START',0
            DS.W    0








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
