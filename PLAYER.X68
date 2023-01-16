; ==============================================================================
; PLAYER MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PLAYERUPD
; UPDATES THE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D3/A2,-(A7)
			; CHECK COLLISIONS
            ; TOP LEFT CORNER
            MOVE.W  (PLAYERPOSX),D0
            LSL.L   #8,D0
            LSL.L   #8,D0
            MOVE.W  (PLAYERPOSY),D0
            
            MOVE.W  (PLAYERPOSX),D1
            ADD.W   #PLAYERWIDTH,D1
            LSL.L   #8,D1
            LSL.L   #8,D1
            MOVE.W  (PLAYERPOSY),D1
            ADD.W   #PLAYERHEIGHT,D1
            
            LEA.L   BLWHICHCOLL,A2
            JSR BLKCOLL    
                            
	        BTST #0, KBDVAL         ; SI NO VA HACIA LA IZQUIERDA
	        BEQ .NOLEFT
	        SUB.W   #PLAYERSPEED,(PLAYERPOSX)
	        TST.L   D0              ; SI HAY COLISIONES CON D0
            BNE .LEFT             
	        TST.L   D3              ; SI HAY COLISIONES CON D3
	        BNE .LEFT
	        BRA  .NOLEFT
.LEFT       ADD.W   #PLAYERSPEED,(PLAYERPOSX)
.NOLEFT     
            BTST #1, KBDVAL         ; SI NO VA ARRIBA
	        BEQ .NOUP
	        SUB.W   #PLAYERSPEED,(PLAYERPOSY)
	        TST.L   D0              ; SI HAY COLISIONES CON D0
            BNE .UP             
	        TST.L   D1              ; SI HAY COLISIONES CON D1
	        BNE .UP
	        BRA .NOUP
.UP         ADD.W   #PLAYERSPEED,(PLAYERPOSY)
.NOUP       
            BTST #2, KBDVAL         ; SI NO VA HACIA LA DERECHA
	        BEQ .NORIGHT
	        ADD.W   #PLAYERSPEED,(PLAYERPOSX)
	        TST.L   D1              ; SI HAY COLISIONES CON D1
            BNE .RIGHT             
	        TST.L   D2              ; SI HAY COLISIONES CON D2
	        BNE .RIGHT
	        BRA .NORIGHT
.RIGHT      SUB.W   #PLAYERSPEED,(PLAYERPOSX)
.NORIGHT    
            BTST #3, KBDVAL         ; SI NO VA ABAJO
	        BEQ .NODOWN             
	        ADD.W   #PLAYERSPEED,(PLAYERPOSY)
	        TST.L   D2              ; SI HAY COLISIONES CON D2
            BNE .DOWN             
	        TST.L   D3              ; SI HAY COLISIONES CON D3
	        BNE .DOWN             
	        BRA .NODOWN             
.DOWN       SUB.W   #PLAYERSPEED,(PLAYERPOSY)
.NODOWN     
            MOVEM.L (A7)+,D0-D3/A2
            RTS
        
; ------------------------------------------------------------------------------
PLAYERPLOT
; PLOT THE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ; *** DIBUJAMOS CUADRADO, ESTO LO PODREMOS BORRAR LUEGO AL SUSTITUIRLO POR EL JUGADOR ***
            MOVE.B  D0,-(A7)
            MOVE.L  D1,-(A7)
	  MOVEM.W D2-D4, -(A7)
	  
	  MOVE.L #$00CC954E,D1 ;PEN COLOR
	  MOVE.B #80,D0
	  TRAP #15
	  MOVE.L #$00B53866,D1 ;FILL COLOR
	  MOVE.B #81,D0
	  TRAP #15
	  ; SE DIBUJA EL CUADRADO
	  MOVE.W (PLAYERPOSX),D1	
	  MOVE.W (PLAYERPOSY),D2	  
	  MOVE.W D1,D3
            ADD.W  #PLAYERWIDTH,D3	
	  MOVE.W D2,D4
            ADD.W  #PLAYERHEIGHT,D4
	  MOVE.B #87,D0
	  TRAP #15
	  
            MOVEM.W (A7)+,D2-D4
            MOVE.L  (A7)+,D1	  
            MOVE.B  (A7)+,D0
  
	  RTS







*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
