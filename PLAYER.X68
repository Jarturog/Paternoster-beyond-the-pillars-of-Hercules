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

	 BTST #0, KBDVAL         ; SI ES 0 EL FLAG Z SE PONE A 1
	 BEQ	NOLEFT         ; SI EL FLAG Z = 1, OSEA, LA TECLA NO SE HA PULSADO, SALTA
	 JSR	MOVELEFT	
NOLEFT	 BTST #1, KBDVAL			
	 BEQ	NOUP         
	 JSR	MOVEUP
NOUP	 BTST #2, KBDVAL
	 BEQ	NORIGHT         
	 JSR	MOVERIGHT
NORIGHT	 BTST #3, KBDVAL
	 BEQ	NODOWN         
	 JSR	MOVEDOWN
NODOWN	 RTS
MOVELEFT				;RESTA LA VELOCIDAD A LAS COORDENADAS X DE INICIO Y FIN DEL CUADRADO
	MOVEM.W D0-D2, -(A7)
	MOVE.W (PLAYERPOSX),D1
	MOVE.W (PLAYERWIDTH),D2
	CMP.W #0, D1		;EL LIMITE POR LA IZQUIERDA SERÁ QUE LA COORDENADA X VALGA 0 
	BEQ EDGELEFT
	SUB.W #PLAYERSPEED,D2
	SUB.W #PLAYERSPEED,D1
	MOVE.W D1, (PLAYERPOSX)
	MOVE.W D2, (PLAYERWIDTH)	
EDGELEFT	MOVEM.W (A7)+, D0-D2
	RTS
MOVEUP				;RESTA (PQ RESTA Y NO SUMA? LO EXPLICO ABAJO) LA VELOCIDAD A LAS COORDENADAS Y DE INICIO Y FIN DEL CUADRADO

	MOVEM.W D0-D2, -(A7)
	MOVE.W (PLAYERPOSY),D1
	MOVE.W (PLAYERHEIGHT),D2
*	CMP #SCRHEIGH, D2		;NO FUNCIONAN LOS LIMITES POR ARRIBA Y POR ABAJO
*	BEQ EDGEUP
	SUB.W #PLAYERSPEED,D2	;UP Y DOWN FUNCIONAN AL REVÉS PORQUE LAS COORDENADAS EMPIEZAN COMO 0,0 ARRIBA A LA IZQUIERDA.
	SUB.W #PLAYERSPEED,D1	;POR TANTO PARA BAJAR HAY QUE SUMARLE A LA Y Y PARA SUBIR HAY QUE RESTARLE. 
	MOVE.W D1, (PLAYERPOSY)
	MOVE.W D2, (PLAYERHEIGHT)
EDGEUP	MOVEM.W (A7)+, D0-D2	
	RTS
MOVERIGHT
	MOVEM.W D0-D2, -(A7)
	MOVE.W (PLAYERPOSX),D1
	MOVE.W (PLAYERWIDTH),D2
	CMP #SCRWIDTH,D2
	BEQ EDGERIGHT
	ADD.W #PLAYERSPEED,D2
	ADD.W #PLAYERSPEED,D1
	MOVE.W D1, (PLAYERPOSX)
	MOVE.W D2, (PLAYERWIDTH)
EDGERIGHT	MOVEM.W (A7)+, D0-D2
	RTS
MOVEDOWN
	MOVEM.W D0-D2, -(A7)
	MOVE.W (PLAYERPOSY),D1
	MOVE.W (PLAYERHEIGHT),D2
	ADD.W #PLAYERSPEED,D2
	ADD.W #PLAYERSPEED,D1
	MOVE.W D1, (PLAYERPOSY)
	MOVE.W D2, (PLAYERHEIGHT)
EDGEDOWN	MOVEM.W (A7)+, D0-D2
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
	  MOVE.W (PLAYERWIDTH),D3
	  MOVE.W (PLAYERHEIGHT),D4
	  MOVE.B #87,D0
	  TRAP #15
	  
            MOVEM.W (A7)+,D2-D4
            MOVE.L  (A7)+,D1	  
            MOVE.B  (A7)+,D0
  
	  RTS

PLAYERFIRE
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
	  MOVE.W (PLAYERWIDTH),D3	
	  MOVE.W (PLAYERHEIGHT),D4	
	  MOVE.B #87,D0
	  TRAP #15

	  MOVEM.W (A7)+,D2-D4
            MOVE.L  (A7)+,D1	  
            MOVE.B  (A7)+,D0

	  
	  ; *** FIN ***
            RTS
            



