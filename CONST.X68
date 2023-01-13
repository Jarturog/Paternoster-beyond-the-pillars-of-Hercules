; ==============================================================================
; CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU    640                     ; SCREEN WIDTH
SCRHEIGH    EQU    480               ; SCREEN HEIGHT
SCRFPS      EQU     50                     ; SCREEN FRAMES PER SECOND

; --- KEYCODES -----------------------------------------------------------------

KBDLEFT     EQU     'A'
KBDUP       EQU     'W'
KBDRIGHT    EQU     'D'
KBDDOWN     EQU     'S'
KBDFLEFT    EQU     $25
KBDFUP      EQU     $26
KBDFRIGHT   EQU		$27
KBDFDOWN	EQU		$28

; --- TRAP NUMBERS -------------------------------------------------------------

SCRUPTN     EQU     0                       ; SCREEN UPDATE TRAP NUMBER
KBDUPTN     EQU     1                       ; KEYBOARD UPDATE TRAP NUMBER
SNDPLTN     EQU     2                       ; SOUND PLAY TRAP NUMBER

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER


; --- PLAYER RELATED CONSTANTS -------------------------------------------------
PLAYERSPEED 	EQU		4						; SPEED OF MAIN PLAYER
PLAYERWIDTH     EQU	    32
PLAYERHEIGHT	EQU     32

; --- PROJECTILE RELATED CONSTANTS ---------------------------------------------

PROJWIDTH       EQU     PLAYERWIDTH/2
PROJHEIGHT      EQU     PLAYERHEIGHT/2
PROJSPEEDX      EQU     8
PROJSPEEDY      EQU     8




*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
