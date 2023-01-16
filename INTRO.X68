; ==============================================================================
; INTRO SCREEN
; ==============================================================================

; ------------------------------------------------------------------------------
ISCINIT
; INTRO SCREEN INITIALISATION
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D1,-(A7)
            
            MOVE.W  #60,D0
            MOVE.W  #$0105,D1       ; TURNING ON MOUSE MOVEMENT AND DOWN
            TRAP    #15
            
            MOVEM.L (A7)+,D0-D1
            RTS
; ------------------------------------------------------------------------------
ISCUPD
; INTRO SCREEN UPDATE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            
            MOVE.B  #11,D0          ; SET POINTER
            MOVE.L  #BTONPOSX<<16|BTONPOSY,D1
            TRAP    #15
            
            MOVE.B  #61,D0          ; READ MOUSE
            MOVE.B  #2,D1           ; MOUSE DOWN STATE
            TRAP    #15
            ANDI.B  #%00001111, D0  ; MIDDLE, DOUBLE, LEFT AND RIGHT MASK
            BEQ.B   .DONE           ; IF NO CLICK
            
	        CLR.L		D2
	        MOVE.W	    D1,D2		; D2 IS MOUSE X
	        SUB.W   #BTONPOSX,D2
	        BLT     .DONE
	        
	        SWAP		D1			; D1 IS MOUSE Y
	        SUB.W   #BTONPOSY,D1
	        BLT     .DONE
	        
	        CMPI.W  #BTONWIDTH,D2
            BGT     .DONE
            CMPI.W  #BTONHEIGHT,D1
            BGT     .DONE           ; IF CLICKED OUTSIDE THE AREA
            
            
            MOVE.W  #1,(STANEXT)
.DONE
            MOVEM.L (A7)+,D0-D2
            RTS
; ------------------------------------------------------------------------------
ISCPLOT
; INTRO SCREEN PLOT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D4/A0,-(A7)
            
            MOVE.W  #80, D0
            MOVE.L  #$00FFFFFF, D1 ; PEN COLOR
            TRAP    #15
            
            MOVE.W  #87, D0
            MOVE.W  #BTONPOSX, D1 ; DRAW BUTTON
            MOVE.W  #BTONPOSY, D2
            MOVE.W  #BTONPOSX+BTONWIDTH, D3
            MOVE.W  #BTONPOSY+BTONHEIGHT, D4
            TRAP    #15
            
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
            
.DONE       
            LEA.L   BITMAP,A0   ; PRINT BITMAP
            MOVE.W  #BMAPPOSX,D2
            MOVE.W  #BMAPPOSY,D3
            
.KEEPGOING  MOVE.W  #80,D0
            MOVE.L  (A0)+,D1 ; NEXT PIXEL
            TRAP    #15 ; PEN COLOR
            MOVE.W  D3,D1
            MOVE.W  #82,D0
            TRAP    #15 ; DRAW PIXEL
            MOVE.W  D1,D3
            ADDQ.W  #1,D3 ; NEXT COLUMN
            CMP.W   #BMAPWIDTH+BMAPPOSX,D1
            BNE     .KEEPGOING
            MOVE.W  #BMAPPOSX+1,D3
            ADDQ.W  #1,D2 ; NEXT ROW
            CMP.W   #BMAPHEIGH+BMAPPOSY,D2
            BNE     .KEEPGOING

            MOVEM.L (A7)+,D0-D4/A0

            RTS
.TITLE      DC.B    'PATERNOSTER: Beyond the pillars of Hercules',0 ; IN CASE THE IMAGE FAILS
.HINT       DC.B    'CLICK HERE TO START',0
            DS.W    0















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
