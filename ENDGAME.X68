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
            MOVEM.L D0-D1,-(A7)
            
            MOVE.L  (SECONDS),(RECORD)
            
            MOVE.W  #51,D0
            LEA     FILENAME,A1 ; OPENS FILE
            TRAP    #15
            MOVE    #53,D0
            LEA     FILEBUFFER,A1 ; READ FILE
            MOVE.L  #NBYTREAD,D2
            TRAP    #15
            MOVE    #55,D0 ; POSITIONING CURSOR
            TRAP    #15
            MOVE.W  #54,D0
            MOVE.W  #LINELENGTH,D2 ; WRITE SECONDS
            LEA     RECORD,A1
            TRAP    #15
            MOVE.W  #56,D0         ; CLOSE FILE
            TRAP    #15
            ; GUARDAR SU RECORD EN UN FICHERO
            ; LEER FICHERO QUE GUARDE LOS RECORDS Y GUARDAR EN MEMORIA
            MOVEM.L (A7)+,D0-D1
            RTS
; ------------------------------------------------------------------------------
ENDGUPD
; END GAME SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.B  (KBDVAL),D0
            ANDI.B  #%00001111,D0
            CMP.B   #%00001111,D0
            BNE.B   .DONE
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
            
            MOVE.B  #14,D0
            MOVE.L  (RECORD),D1
            JSR     UTLPRINTNUM
            
            LEA     .TXT3,A0
            MOVE.B  #17,D0
            JSR     UTLPRINT
            
            MOVE.B  #20,D0
            LEA     FILEBUFFER,A0
            MOVE.L  (A0),D1
            
.READRECORD JSR     UTLPRINTNUM
            ADD.L   #LINELENGTH,A0
            MOVE.L  (A0),D1
            TST.L   (A0)
            BNE     .READRECORD
            
            BTST.B  #32,(SCRCYCCT)
            BEQ     .NOTPRINT
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.NOTPRINT
            
            
            ; MOSTRAR FICHERO QUE GUARDE LOS RECORDS
            
            MOVEM.L (A7)+,D0-D1/A0

            RTS
.TXT1       DC.B    'YOUR RECORD THIS TIME WAS',0
.TXT2       DC.B    'HOLD THE NEXT KEYS TO REPLAY: W, A, S, D',0
.TXT3       DC.B    'HERE ARE THE BEST RECORDS',0
            DS.W    0







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
