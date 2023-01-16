; ==============================================================================
; SYSTEM
; ==============================================================================
            
; ------------------------------------------------------------------------------
SYSINIT
; INITIALIZE SYSTEM AND ENABLES INTERRUPTIONS
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVE.L  #SCRPLOT,($80+SCRUPTN*4)
            MOVE.L  #KBDUPD,($80+KBDUPTN*4)
            MOVE.L  #SCRTIM,($60+SCRINTN*4)
            MOVE.L  #SCRTIM1S,($60+SCRINTFPSN*4)
            
            JSR     DMMINIT
            JSR     SCRINIT
            JSR     KBDINIT 
            
            MOVE.W  SR,-(A7)
            ANDI.W  #$D8FF,(A7)     ; ENABLES INTERRUPTIONS AND 
            RTE
            
; ------------------------------------------------------------------------------
SCRINIT
; INIT SCREEN. SET SCREEN RESOLUTION, SET WINDOWED MODE, CLEAR SCREEN,
; ENABLE DOUBLE BUFFER.
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D3,-(A7)

            ; SET SCREEN RESOLUTION
            MOVE.B  #33,D0
            MOVE.L  #SCRWIDTH<<16|SCRHEIGH,D1
            TRAP    #15
            
            ; SET WINDOWED MODE
            MOVE.L  #1,D1
            TRAP    #15
            
            ; CLEAR SCREEN
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15

            ; ENABLE DOUBLE BUFFER
            MOVE.B  #92,D0
            MOVE.B  #17,D1
            TRAP    #15
            
            ; ENABLE BOTH TIMED INTERRUPT
            MOVE.B  #32,D0
            MOVE.B  #6,D1
            MOVE.B  #$80|SCRINTN,D2
            MOVE.L  #1000/FRAMES_PER_SECOND,D3
            TRAP    #15
            MOVE.B  #$80|SCRINTFPSN,D2
            MOVE.L  #1000,D3
            TRAP    #15
            
            ; CLEAR INTERRUPT COUNTER
            CLR.W   (SCRINTCT)
            CLR.B   (SCRINTFPS) 
            
            MOVEM.L (A7)+,D0-D3
            
            RTS

; ------------------------------------------------------------------------------
SCRPLOT
; UPDATES DOUBLE BUFFER
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVEM.L D0-D2,-(A7)
            MOVE.L  A1,-(A7)
            
            ; PLOT ACTUAL FPS AND GOAL FPS
            
            MOVE.B  #81,D0
            MOVE.L  #$00000000,D1 ; FILL COLOR
            TRAP    #15
            
            MOVE.B  #80,D0
            MOVE.L  #$00FFFFFF,D1 ; PEN COLOR
            TRAP    #15
            
            MOVE.B  #11,D0
            MOVE.L  #FPSTEXTPOS,D1 ; SET FPS TEXT POSITION
            TRAP    #15
            
            LEA.L   STRFPS1,A1 
            MOVE.B  #14,D0  ; PLOT 'GOAL: '
            TRAP    #15
            
            MOVE.B  #11,D0
            MOVE.W  #FPSTEXTPOS+9<<8,D1 ; SET NEXT FPS TEXT POSITION
            TRAP    #15
            
            ADDA.L  #7,A1 ; PLOT 'FPS - ACTUAL: '
            MOVE.B  #14,D0  
            TRAP    #15 
            
            MOVE.B  #11,D0
            MOVE.W  #FPSTEXTPOS+26<<8,D1 ; SET NEXT FPS TEXT POSITION
            TRAP    #15
            
            ADDA.L  #15,A1 ; PLOT 'FPS'
            MOVE.B  #14,D0 
            TRAP    #15
            
            ADD.W   #20,D3
            MOVE.B  #11,D0
            MOVE.W  #FPSTEXTPOS+6<<8,D1 ; SET FPS NUMBER POSITION
            TRAP    #15
            
            MOVE.L  #FRAMES_PER_SECOND,D1
            MOVE.L  #10,D2
            MOVE.B  #15,D0  ; PLOT GOAL NUMBER OF FPS
            TRAP    #15
            
            ADD.W   #20,D3
            MOVE.B  #11,D0
            MOVE.W  #FPSTEXTPOS+23<<8,D1 ; SET FPS NUMBER POSITION
            TRAP    #15
            
            CLR.L   D1
            MOVE.B  (REALFPS),D1
            MOVE.L  #10,D2
            MOVE.B  #15,D0  ; PLOT REAL NUMBER OF FPS
            TRAP    #15
            
            ; SWITCH BUFFERS
            MOVE.B  #94,D0
            TRAP    #15
            
            ; CLEAR HIDDEN BUFFER
            MOVE.B  #11,D0
            MOVE.W  #$FF00,D1
            TRAP    #15
            
            MOVE.L  (A7)+,A1
            MOVEM.L (A7)+,D0-D2
            RTE
            
; ------------------------------------------------------------------------------
SCRTIM
; TIMED INTERRUPT SERVICE ROUTINE
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            ADDQ.B  #1,(SCRINTCT)
            ADDQ.B  #1,(SCRCYCCT)
            RTE
            
; ------------------------------------------------------------------------------
SCRTIM1S
; TIMED INTERRUPT SERVICE ROUTINE FOR ONE SECOND
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            MOVE.B  (SCRINTFPS),REALFPS
            CLR.B   SCRINTFPS
            ADD.B   #1,(SECONDS)
            RTE

; ------------------------------------------------------------------------------
KBDINIT
; INIT KEYBOARD
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
            CLR.B   (KBDVAL)
            CLR.B   (KBDEDGE)
            RTS

; ------------------------------------------------------------------------------
KBDUPD
; UPDATE KEYBOARD INFO.  
; 7 -> FIRE DOWN
; 6 -> FIRE RIGHT
; 5 -> FIRE UP
; 4 -> FIRE LEFT
; 3 -> DOWN
; 2 -> RIGHT
; 1 -> UP
; 0 -> LEFT
; INPUT    : NONE
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------

            MOVEM.L D0-D3,-(A7)

            ; READ FIRST PART
            MOVE.B  #19,D0
            MOVE.L  #KBDFDOWN<<24|KBDFRIGHT<<16|KBDFUP<<8|KBDFLEFT,D1 ;DEVUELVE FF SI ESTÃ PULSADA LA TECLA ESPECIFICADA, 00 SI NO. 
            TRAP    #15
            
            ; CONVERT TO DESIRED FORMAT (DEJA EL RESULTADO EN D2 EN EL ORDEN ESPECIFICADO ARRIBA) 
            JSR     .PACK

            ; READ SECOND PART
            MOVE.L  #KBDDOWN<<24|KBDRIGHT<<16|KBDUP<<8|KBDLEFT,D1
            TRAP    #15

            ; CONVERT TO DESIRED FORMAT
            JSR     .PACK
            
            ; COMPUTE KBDEDGE
            MOVE.B  (KBDVAL),D0
            NOT.B   D0
            AND.B   D2,D0
            MOVE.B  D0,(KBDEDGE)
            
            ; STORE KBDVAL
            MOVE.B  D2,(KBDVAL)
            
            MOVEM.L (A7)+,D0-D3

            RTE
            
.PACK       MOVE.W  #3,D3
.LOOP       LSL.L   #8,D1
            ROXL.B  #1,D2
            DBRA.W  D3,.LOOP
            RTS





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
