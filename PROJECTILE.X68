; ==============================================================================
; PROJECTILE MANAGEMENT (AGENT)
; PROJPOSX (W)  (A0)
; PROJPOSY (W) 2(A0)
; PROJVELX (W) 4(A0)
; PROJVELY (W) 6(A0)
; ==============================================================================

; ------------------------------------------------------------------------------
PROJINIT 
; INITIALIZES THE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
           MOVE.L  D0,-(A7)
           
            CLR.L   D0
            BTST #4, (KBDEDGE)    
            BEQ .FUP ; SI SALTA ES PORQUE NO HA DISPARADO A LA IZQUIERDA
            ADD.L   #-PROJSPEEDX<<16,D0
.FUP	    BTST #5, (KBDEDGE)		
            BEQ .FRIGHT ; SI SALTA ES PORQUE NO HA DISPARADO ARRIBA
            ADD.W   #-PROJSPEEDY,D0	
.FRIGHT	    BTST #6, (KBDEDGE)
            BEQ .FDOWN ; SI SALTA ES PORQUE NO HA DISPARADO A LA DERECHA
            ADD.L   #PROJSPEEDX<<16,D0
.FDOWN	    BTST #7, (KBDEDGE)
            BEQ .NOTFDOWN ; SI SALTA ES PORQUE NO HA DISPARADO ABAJO
            ADD.W   #PROJSPEEDY,D0
.NOTFDOWN   TST.L   D0
            BNE.L .SHOOT ; SI EN D0 NO HAY NADA ES PORQUE SE HAN ANULADO DISPAROS CONTRARIOS
            MOVE.W  #PROJSPEEDY,D0 ; POR PREDETERMINADO DISPARA ABAJO SI SE ANULAN
.SHOOT      MOVE.L  (PLAYERPOSX),(A0)
            MOVE.L  D0,4(A0) ; COMO X E Y ESTÁN JUNTOS EN MEMORIA HAGO UNA SOLA OPERACIÓN LONG WORD 
            ADD.W   #1,(NPROJ)
            MOVE.L  (A7)+,D0
            RTS
  
; ------------------------------------------------------------------------------
PROJUPD 
; UPDATES THE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES 
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.L  D0,-(A7)
            MOVE.L  4(A0),D0 ; COMO X E Y ESTÁN JUNTOS EN MEMORIA HAGO UNA SOLA OPERACIÓN LONG WORD
            ADD.W   D0,2(A0)
            LSR.L   #8,D0 ; LAS SUMAS SE TIENEN QUE HACER APARTE PARA QUE SI HAY OVERFLOW NO SE AFECTEN ENTRE ELLAS
            LSR.L   #8,D0
            ADD.W   D0,(A0) 
            MOVE.L  (A7)+,D0
            
            RTS
    
; ------------------------------------------------------------------------------
PROJPLOT 
; PLOTS THE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES  
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.B  D0,-(A7)
            MOVE.L  D1,-(A7)
	  MOVEM.W D2-D4, -(A7)
	  
	  MOVE.L #$00C00FFE,D1 ;PEN COLOR
	  MOVE.B #80,D0
	  TRAP #15
	  MOVE.L #$00BFF006,D1 ;FILL COLOR
	  MOVE.B #81,D0
	  TRAP #15
	  ; SE DIBUJA EL CUADRADO
	  MOVE.W (A0),D1	
	  MOVE.W 2(A0),D2	  
	  MOVE.W D1,D3
            ADD.W  #PROJWIDTH,D3	
	  MOVE.W D2,D4
            ADD.W  #PROJHEIGHT,D4
	  MOVE.B #87,D0
	  TRAP #15
	  
            MOVEM.W (A7)+,D2-D4
            MOVE.L  (A7)+,D1	  
            MOVE.B  (A7)+,D0
            RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
