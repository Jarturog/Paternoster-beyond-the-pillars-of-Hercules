*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

MENUINIT
    ; FILL COLOR
    MOVE.B  #81,D0
    MOVE.L  #$00000000,D1
    TRAP    #15
    ; PEN COLOR
    MOVE.B  #80,D0
    MOVE.L  #$00FFFFFF,D1
    TRAP    #15
    
    RTS
    
MENUPLOT
    MOVE.B  D0,-(A7)
    MOVE.L  D1,-(A7)
    MOVEM.W D2-D4, -(A7)
    MOVE.L  #$00808080,D1 ;ELEVATOR PEN COLOR
    MOVE.B  #80,D0
    TRAP    #15
    MOVE.L  #$00808080,D1 ;ELEVATOR FILL COLOR
    MOVE.B  #81,D0
    TRAP    #15
    ; ELEVATOR PLOT
    MOVE.W  #ELEVXL,D1	
    MOVE.W  #ELEVYU,D2	  
    MOVE.W  #ELEVXR,D3	
    MOVE.W  #ELEVYD,D4	
    MOVE.B  #87,D0
    TRAP    #15
    ; TRIANGLES PLOT
    MOVE.L  #$003CB371,D1 ; TRIANGLE PEN COLOR
    MOVE.B  #80,D0
    TRAP    #15
    MOVE.L  #$003CB371,D1 ; TRIANGLE FILL COLOR
    MOVE.B  #81,D0
    TRAP    #15
    MOVE.L  #(((ELEVXR/2)+(TRILENGH*2))<<16)|((3*ELEVYD/4)),-(A7) ; COORDINATES
    MOVE.W  #TRILENGH,-(A7)  ; PUSHING LENGTH OF EACH SIDE
    JSR TRIANGLE
    MOVE.W  #(ELEVYD/4),4(A7) ; ADDING Y COORDINATE AND REUSING OTHER PARAMETERS
    NEG.W   (A7)
    JSR TRIANGLE
    ADDA.L  #6,A7        ; "EMPTYING STACK"
    ; SET MENU TITLE POSITION
    MOVE.B  #11,D0
    MOVE.W  (MENUPOS),D1 
    TRAP    #15
    MOVE.L  #$003CB371,D1 ;MENU PEN COLOR
    MOVE.B  #80,D0
    TRAP    #15
    MOVE.L  #$003CB371,D1 ;MENU FILL COLOR
    MOVE.B  #81,D0
    TRAP    #15
    ; PLOT MENU TITLE
    LEA.L   MNTITLE,A1
    MOVE.B  #14,D0
    TRAP    #15
              
    MOVEM.W (A7)+,D2-D4
    MOVE.L  (A7)+,D1	  
    MOVE.B  (A7)+,D0
    RTS

; ------------------------------------------------------------------------------
TRIANGLE
; DRAWS AN ALMOST EQUILATERAL TRIANGLE. THE TRIANGLE WILL BE UPWARDS ORIENTATED 
; IF THE SIDES LENGTH IS NEGATIVE, OTHERWHISTE IT WILL BE DOWNWARDS ORIENTATED
; INPUT    : TRIANGLE LEFT CORNER POSITION X (WORD), POSITION Y (WORD) AND
;            SIDES LENGTH (WORD) IN THAT ORDER
; OUTPUT   : NONE
; MODIFIES : NONE
; ------------------------------------------------------------------------------
    MOVEM.W D0-D4, -(A7)
    ; LINE FROM LEFT TO RIGHT
    MOVE.B  #84,D0      ; TASK NUMBER
    MOVE.W  16(A7),D1   ; X POSITION FROM
    MOVE.W  18(A7),D2   ; Y POSITION FROM
    MOVE.W  D2,D4       ; Y POSITION TO
    MOVE.W  14(A7),D3   ; LENGTH
    
    BPL.W   .UPWARDS
    NEG.W   D3          ; TURNING LENGTH INTO POSITIVE
.UPWARDS
    ADD.W   D1,D3       ; TURNING LENGTH INTO POSITION (Y POSITION TO)
    TRAP    #15         ; HORIZONTAL LINE DRAWN
    ; LINE FROM RIGHT TO UP/DOWN
    SUB.W   D1,D3       ; I GET LENGTH IN D3
    MOVE.W  D1,D0       ; I GET X POSITION FROM IN DO
    ADD.W   D3,D1       ; X POSITION FROM
    LSR.W   #1,D3       ; LENGTH/2
    ADD.W   D0,D3       ; X POSITION TO (LAST X POSITION FROM + LENGTH/2)
    ; HEIGHT OF TRIANGLE = LENGTH*0.5*(3^0.5) =~ LENGTH*0.8 =~ LENGTH
    ADD.W   14(A7),D4   ; Y POSITION TO (LENGTH + Y POSITION)
    MOVE.B  #84,D0
    TRAP    #15
    ; LINE FROM LEFT TO UP/DOWN
    MOVE.W  16(A7),D1   ; X POSITION FROM
    TRAP    #15         ; ALL THE OTHERS COORDINATES ARE THE SAME
    
    ; FILLING TRIANGLE
    MOVE.B  #89,D0
    ADDQ.W  #1,D1
    MOVE.W  #1,D3
    TST.W   14(A7)
    BPL.W   .ISPOSITIVE
    NEG.W   D3
.ISPOSITIVE
    ADD.W   D3,D2
    TRAP    #15
    
    MOVEM.W (A7)+,D0-D4
    RTS
    
MENUUPD
    MOVE.B  D0, -(A7)
    MOVE.B  (SCRCYCCT),D0
    ADD.B   D0,D0 ; MULTIPLICO POR 2, SI NO QUEDA NADA ES QUE ERA $80 O $00
    BNE.B   .NOTHING
    
    MOVE.B  (MENUDIR),D0
    ADD.B   D0, (MENUPOS+1) ; MENUPOS ES UN WORD, SUMO AL BIT BAJO
    SUBQ.B  #1,(MENUMOV)
    BPL.B   .NOTHING
    
    MOVE.B  #MENUMAXM, (MENUMOV)
    NEG.B   (MENUDIR)
.NOTHING
    MOVE.B  (A7)+, D0
    RTS

