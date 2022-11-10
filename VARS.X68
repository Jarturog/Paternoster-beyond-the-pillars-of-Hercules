; ==============================================================================
; VARIABLES
; ==============================================================================
            
; --- KEYBOARD RELATED VARIABLES -----------------------------------------------
            
KBDVAL      DS.B    1                       ; KEY STATE ;PARA COMPROBAR SI ESTÁ PULSADO O NO, POR EJEMPLO MOVERSE
KBDEDGE     DS.B    1                       ; KEY EDGE	;PARA COMPROBAR SI SE ACABA DE PULSAR O NO, POR EJEMPLO DISPARAR

; --- MENU TEXTS ---------------------------------------------------------------

MNTITLE     DC.B    'Mooncake',0
MNPLAY      DC.B    'Play',0
MNOPTION    DC.B    'Options',0
MNEXIT      DC.B    'Exit',0

; --- MENU POSITON -------------------------------------------------------------

MENUPOS     DC.W    $2010   ; idealmente deberÃ­a cambiarlo para que sea relativo a SCRWIDHT y SCRHEIGH pero no me sale
MENUMOV     DC.B    MENUMAXM/2              ; AMOUNT OF MOVIMENTS LEFT BEFORE CHANGING DIRECTION
MENUDIR     DC.B    2

; --- TIMED INTERRUPT RELATED VARIABLES ----------------------------------------

SCRINTCT    DS.B    1                       ; INTERRUPT COUNTER
SCRCYCCT    DS.B    1                       ; CYCLE COUNTER
            DS.W    0

; --- PLAYER RELATED VARIABLES -------------------------------------------------

PLAYERHEALTH	DC.W	$64 ;100 EN HEX. DC.B ES PARA STRINGS Y DA ERROR ASI QUE USAMOS DC.W AUNQUE NO HICIERA FALTA
PLAYERPOSX		DC.W	SCRWIDTH/2
PLAYERPOSY		DC.W	SCRHEIGH/2


