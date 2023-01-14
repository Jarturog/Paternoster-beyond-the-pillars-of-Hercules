; ==============================================================================
; VICTORY SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
ENDGINIT
; END GAME SCREEN INIT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            ; GUARDAR SU RECORD EN UN FICHERO
            ; LEER FICHERO QUE GUARDE LOS RECORDS Y GUARDAR EN MEMORIA
            RTS
; ------------------------------------------------------------------------------
ENDGUPD
; END GAME SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.B  #61,D0          ; READ MOUSE
            MOVE.B  #2,D1           ; MOUSE DOWN STATE
            TRAP    #15
            ANDI.B  #%00001111, D0  ; MIDDLE, DOUBLE, LEFT AND RIGHT MASK
            BEQ.B   .DONE           ; IF NO CLICK
            MOVE.W  #1,(STANEXT)
.DONE
            RTS

; ------------------------------------------------------------------------------
ENDGPLOT
; END GAME SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1/A0,-(A7)
            
            CLR.L   D1
            MOVE.B  #81,D0
            TRAP    #15
            
            LEA     .TXT1,A0
            MOVE.B  #10,D0
            JSR     UTLPRINT
            
            BTST.B  #8,(SCRCYCCT)
            BEQ     .NOTPRINT
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.NOTPRINT
            LEA     .TXT3,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
            ; MOSTRAR FICHERO QUE GUARDE LOS RECORDS
            
            MOVEM.L (A7)+,D0-D1/A0

            RTS
.TXT1       DC.B    'YOUR RECORD THIS TIME WAS',0
.TXT2       DC.B    'CLICK ANYWHERE TO START',0
.TXT3       DC.B    'HERE ARE THE BEST RECORDS',0
            DS.W    0





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
