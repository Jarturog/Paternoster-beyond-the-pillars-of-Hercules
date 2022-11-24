; =============================================================================
; MAP MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
MAPINIT
; INITALIZES THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A0-A1,-(A7)
            LEA.L   ARRAYPATRONES,A0
            LEA.L   PATRON0,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON1,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON2,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON3,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON4,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON5,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON6,A1
            MOVE.L  A1,(A0)+
            LEA.L   PATRON7,A1
            MOVE.L  A1,(A0)
            MOVEM.L (A7)+,A0-A1
            RTS  
; -----------------------------------------------------------------------------
PATRONX
; INITALIZES THE MAP
; INPUT    - D1 y D2 como coordenadas donde se dibujará (X e Y respectivamente)
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTA: LOS NOMBRES DE LAS SUBRUTINAS SON ARBITRARIS, SI HACEMOS UN ÁRBOL
; LO PODREMOS LLAMAR PLOTARBOL O LO QUE SEA. DENTRO DE LA FUNCIÓN SE RELLENA
; CON EL CÓDIGO QUE DIBUJA
; -----------------------------------------------------------------------------
PATRON0     
	RTS
PATRON1
	RTS
PATRON2
	RTS
PATRON3
            RTS
PATRON4
            RTS
PATRON5
            RTS
PATRON6
            RTS
PATRON7
            RTS
; -----------------------------------------------------------------------------
MAPUPD
; UPDATES THE MAP IF PLAYER CHANGES SCREEN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
MAPPLOT
; PLOTS THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D2/A0-A1,-(A7)
            LEA.L   EJEMPLOMAPA,A0
            CLR.W   D0
            ; POSICIÓN AL ARRAY (COLUMNA + (FILA * MAPSCRW))
            ; D0 = D2 + (D1*MAPSCRW)
.LOOP       LEA.L   ARRAYPATRONES,A1
            CLR.W   D1
            MOVE.B  (A0)+,D1
            LSL.W   #2,D1   ; MULTIPLICO POR 4
            ADDA.W  D1,A1
            MOVE.L  (A1),A1
            ;
            MOVE.L  D0,D2
            DIVU.W  #MAPSCRW,D2
            MOVE.L  D2,D1
            EXT.L   D2          ; EL ENTERO RESULTADO DE D0/MAPSCRW ES LA FILA
            LSR.L   #8,D1
            LSR.L   #8,D1       ; EL RESIDUO DE D0/MAPSCRH ES LA COLUMNA  
            ; MULTIPLICO D1 Y D2 POR PÍXELES PARA CONSEGUIR LAS COORDENADAS DE LA PANTALLA
            MULU.W  #MAPTILESIZE,D1 ; COORDENADA X
            MULU.W  #MAPTILESIZE,D2 ; COORDENADA Y
            ; MOVE.W D1<<16|D2, MAPPOINTER
            JSR     (A1)
            ADDQ.W  #1,D0
            CMP.W   #MAPSCRW*MAPSCRH,D0
            BMI.W   .LOOP
            MOVEM.L (A7)+,D0-D2/A0-A1
            RTS     
; lo de abajo es un ejemplo y se debe cambiar por el mapa que nos genere el TILED
EJEMPLOMAPA DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DC.B    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
ARRAYPATRONES       DS.L NPATRONS ; el array de patrones (si hay un 2 en el mapa se dibuja el patrón en la posición 2)

