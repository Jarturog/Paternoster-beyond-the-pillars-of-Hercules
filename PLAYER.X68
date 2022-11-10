; ==============================================================================
; PLAYER MANAGEMENT
; ==============================================================================
            
; ------------------------------------------------------------------------------
PLAYERINIT
; INITIALIZE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            RTS
            
; ------------------------------------------------------------------------------
PLAYERUPD
; UPDATES THE PLAYER.
; INPUT    : NONE 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.W  D0,-(A7)
	  BTST #0, KBDVAL         
            BEQ	.UP    
            MOVE.W  #-PLAYERSPEED,D0     
	  JSR	MOVEHOR	
.UP	  BTST #1, KBDVAL			
	  BEQ	.RIGHT  
            MOVE.W  #-PLAYERSPEED,D0      
	  JSR	MOVEVER
.RIGHT	  BTST #2, KBDVAL
	  BEQ	.DOWN  
            MOVE.W  #PLAYERSPEED,D0     
	  JSR	MOVEHOR
.DOWN	  BTST #3, KBDVAL
	  BEQ	.NOTMOVED  
            MOVE.W  #PLAYERSPEED,D0       
	  JSR	MOVEVER
.NOTMOVED	  MOVE.W  (A7)+,D0
            RTS

MOVEHOR     ADD.W   D0,(PLAYERPOSX)
            BPL.W   .NOTLEFTEDGE
            CLR.W   (PLAYERPOSX)
.NOTLEFTEDGE
            CMP.W   #SCRWIDTH-PLAYERWIDTH,(PLAYERPOSX)
            BLT.W   .NORIGHTEDGE
            MOVE.W  #SCRWIDTH-PLAYERWIDTH,(PLAYERPOSX)
.NORIGHTEDGE 
            RTS
            
MOVEVER     ADD.W   D0,(PLAYERPOSY)
            BPL.W   .NOTUPPEREDGE
            CLR.W   (PLAYERPOSY)
.NOTUPPEREDGE
            CMP.W   #SCRHEIGH-PLAYERHEIGHT,(PLAYERPOSY)
            BLT.W   .NOLOWEREDGE
            MOVE.W  #SCRHEIGH-PLAYERHEIGHT,(PLAYERPOSY)
.NOLOWEREDGE 
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

PLAYERFIRE ; ESTE CÓDIGO NO ESTÁ ACABADO
            ; *** DIBUJAMOS PROYECTIL (CUADRADO POR AHORA) ***
            MOVE.B  D0,-(A7)
            MOVE.L  D1,-(A7)
	  MOVEM.W D2-D4, -(A7)
	  
	  MOVE.L #$00CC954E,D1 ;PEN COLOR
	  MOVE.B #80,D0
	  TRAP #15
	  MOVE.L #$00B53866,D1 ;FILL COLOR
	  MOVE.B #81,D0
	  TRAP #15
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

	  
	  ; *** FIN ***
            RTS
            




