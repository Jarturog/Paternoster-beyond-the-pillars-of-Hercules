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

            MOVEM.L  D0-D3/A2,-(A7)
            ; CHECK OUTSIDE SCREEN
            MOVE.W  (A0),D0
            CMP.W   #SCRWIDTH,D0
            BGT.W   .PROJCOLL
            CMP.W   #0,D0
            BLT.W   .PROJCOLL
            MOVE.W  2(A0),D0
            CMP.W   #SCRHEIGH,D0
            BGT.W   .PROJCOLL
            CMP.W   #0,D0
            BLT.W   .PROJCOLL
            ; ADD POSITION
            MOVE.L  4(A0),D0 ; COMO X E Y ESTÁN JUNTOS EN MEMORIA HAGO UNA SOLA OPERACIÓN LONG WORD
            ADD.W   D0,2(A0)
            LSR.L   #8,D0 ; LAS SUMAS SE TIENEN QUE HACER APARTE PARA QUE SI HAY OVERFLOW NO SE AFECTEN ENTRE ELLAS
            LSR.L   #8,D0
            ADD.W   D0,(A0) 
            ; CHECK COLLISIONS
            ; TOP LEFT CORNER
            MOVE.W  (A0),D0
            LSL.L   #8,D0
            LSL.L   #8,D0
            MOVE.W  2(A0),D0
            ; BOTTOM RIGHT CORNER
            MOVE.W  (A0),D1
            ADD.W   #PROJWIDTH,D1
            LSL.L   #8,D1
            LSL.L   #8,D1
            MOVE.W  2(A0),D1
            ADD.W   #PROJHEIGHT,D1
            ; COLLISIONS
            LEA.L   BLWHICHCOLL,A2
            JSR BLKCOLL
            TST.L   D0
            BEQ.L   .PROJNOHIT  
            TST.L   D1
            BEQ.L   .PROJNOHIT  
            TST.L   D2
            BEQ.L   .PROJNOHIT  
            TST.L   D3
            BEQ.L   .PROJNOHIT  

.PROJCOLL   JSR AGLKILL
            SUB.W   #1,(NPROJ)
.PROJNOHIT  JSR PROJHITOBS ; CHECKS COLLISION WITH AN OBSTACLE
            MOVEM.L  (A7)+,D0-D3/A2
            RTS

; ------------------------------------------------------------------------------
PROJHITOBS
; DESTROYS AN OBSTACLE IN CASE IT WAS HITTEN BY THE PROJECTILE. IT ALSO DELETES
; THE PROJECTILE.
; INPUT    : A0 POINTER TO THE INSTANCE VARIABLES  
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------            

            MOVEM.L A0-A1/D0-D7,-(A7)
            MOVE.W  (A0),D2                 ; PREPARE SHOT COORDINATES FOR
            MOVE.W  2(A0),D3                ; COLLISION CHECK
            MOVE.W  #PROJWIDTH,D5
            MOVE.W  #PROJHEIGHT,D7
            MOVE.L  A0,A1
            MOVE.W  #OBSTYPE,D0             ; LOOP THROUGH ALL ASTEROIDS
            JSR     DMMFRSTO
.LOOP       CMP.L   #0,A0
            BEQ     .END
            MOVE.W  8(A0),D0
            MOVE.W  10(A0),D1
            MOVE.W  #OBSWIDTH,D4
            MOVE.W  #OBSHEIGHT,D6
            JSR     UTLCHCOLL
            TST.B   D0
            BNE     .POCOLL                 ; IF COLLISION, EXPLODE IT
            MOVE.W  #OBSTYPE,D0
            JSR     DMMNEXTO
            BRA     .LOOP
.END        MOVEM.L (A7)+,A0-A1/D0-D7
            RTS
.POCOLL     ADD.L   #8,A0
            JSR     HITOBS                  ; HIT OBSTACLE
            MOVE.L  A1,A0
            JSR     AGLKILL                 ; DESTROY SHOT
          ;  ADD.W   #ASTSCORE,(PLRSCORE)    ; INCREASE SCORE
            BRA     .END

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
