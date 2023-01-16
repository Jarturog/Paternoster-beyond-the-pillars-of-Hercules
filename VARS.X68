; ==============================================================================
; VARIABLES
; ==============================================================================
            
; --- KEYBOARD RELATED VARIABLES -----------------------------------------------
            
KBDVAL      DS.B    1                       ; KEY STATE ;PARA COMPROBAR SI ESTÃ PULSADO O NO, POR EJEMPLO MOVERSE
KBDEDGE     DS.B    1                       ; KEY EDGE	;PARA COMPROBAR SI SE ACABA DE PULSAR O NO, POR EJEMPLO DISPARAR


; --- TIMED INTERRUPT RELATED VARIABLES ----------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER
SCRCYCCT    DS.B    1                       ; CYCLE COUNTER
SCRINTFPS   DS.B    1                       ; INTERRUPTIONS IN 1 SECOND
            DS.W    0

; --- PLAYER RELATED VARIABLES -------------------------------------------------

PLAYERHEALTH	DC.W	$64 ;100 EN HEX. DC.B ES PARA STRINGS Y DA ERROR ASI QUE USAMOS DC.W AUNQUE NO HICIERA FALTA
PLAYERPOSX		DC.W	SCRWIDTH/2
PLAYERPOSY		DC.W	SCRHEIGH/2

; --- PROJECTILE RELATED VARIABLES ---------------------------------------------

NPROJ       DC.W    0   ; NUMBER OF PROJECTILES

; --- BLOCKS RELATED VARIABLES -------------------------------------------------

BPOSX1	    DC.W	0
BPOSY1	    DC.W	0
BPOSX2	    DC.W	32
BPOSY2	    DC.W	32
BLWHICHCOLL DC.B    2,3,0 ; BLOCKS WHICH PRODUCES COLLISIONS, ENDS WITH NULL
BLWHICHNTRA DC.B    1,2,3,8,9,12,0 ; BLOCKS WHICH CANNOT BE TRAVERSED, ENDS WITH NULL

; --- MAP RELATED VARIABLES ----------------------------------------------------

LOADEDMAP	DC.W	0                       ; CURRENT MAP
MAPUPDLIST  DC.L    MAPA1,MAPA2,MAPA3,MAPA4,MAPA5,MAPA6,MAPA7,MAPA8
MAPLIST     DC.L    HEAVEN_0,HEAVEN_1,HEAVEN_END,HEAVEN_ROOM,HELL_0,HELL_1,HELL_END,HELL_ROOM,0 

; --- MUSIC RELATED VARIABLES --------------------------------------------------

MUSICPLAYED DC.B	0
            DS.W    0

; --- FPS RELATED VARIABLES ----------------------------------------------------

REALFPS     DS.W    1
STRFPS1     DC.B    'GOAL: ',0   ; THESE STRINGS MUST BE IN THIS ORDER IN MEMORY
STRFPS2     DC.B    'FPS - ACTUAL: ',0
STRFPS3     DC.B    'FPS',0
            DS.W    0

; --- STATE RELATED VARIABLES --------------------------------------------------

STACUR      DS.W    1                       ; CURRENT STATE
STANEXT     DS.W    1                       ; NEXT STATE

; --- OBSTACLE RELATED VARIABLES -----------------------------------------------

NOBS        DC.W    0                       ; NUMBER OF OBSTACLES

; --- ENDGAME RELATED VARIABLES ------------------------------------------------

SECONDS     DS.B    1       ; NUMBER OF SECONDS THAT HAVE PASSED
FILENAME    DC.B    'DATA/scores.txt',0
            DS.W    0
FILEBUFFER  DS.B    8
FILESIZE    DC.B    8
SCORE       DS.B    1
            DS.W    0








*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
