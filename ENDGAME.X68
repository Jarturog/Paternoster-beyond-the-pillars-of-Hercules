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
            MOVEM.L D0-D2,-(A7)
            
            MOVE.B  (SECONDS),(SCORE)
            
            MOVE.W  #52,D0
            LEA     FILENAME,A1 ; OPENS FILE
            TRAP    #15
            LEA     FILEBUFFER,A1 ; READ FILE
            MOVE.L  #FILESIZE,D2
            MOVE    #53,D0
            TRAP    #15
            ADD.B   #1,(A1)
            ADD.B   (A1),D2
            MOVE    #55,D0 ; POSITIONING CURSOR
            TRAP    #15
            MOVE.W  #54,D0
            MOVE.W  #1,D2 ; WRITE ONE BYTE
            LEA     SECONDS,A1 ; WRITE SECONDS
            TRAP    #15
            CLR.L   D2
            MOVE    #55,D0 ; POSITIONING CURSOR
            TRAP    #15
            MOVE.W  #56,D0 ; CLOSE FILE
            TRAP    #15

            MOVEM.L (A7)+,D0-D2
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
            CLR.L   D1
            MOVE.B  (SCORE),D1
            JSR     UTLPRINTNUM
            
            LEA     .TXT3,A0
            MOVE.B  #17,D0
            JSR     UTLPRINT
            
            MOVE.B  #20,D0
            LEA     FILEBUFFER,A0
            ADDA    #1,A0
            CLR.L   D1
            MOVE.B  (A0),D1
            
.READSCORES TST.B   (A0)
            BMI     .PRINTEDALL
            JSR     UTLPRINTNUM
            MOVE.B  (A0)+,D1
            TST.B   (A0)
            BRA     .READSCORES
.PRINTEDALL            
            BTST.B  #4,(SCRINTFPS)
            BEQ     .NOTPRINT
            
            LEA     .TXT2,A0
            MOVE.B  #25,D0
            JSR     UTLPRINT
            
.NOTPRINT
            
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
