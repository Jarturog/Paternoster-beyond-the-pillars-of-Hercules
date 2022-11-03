; ==============================================================================
; CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH    EQU    640                     ; SCREEN WIDTH
SCRHEIGH    EQU   320  ; 480                     ; SCREEN HEIGHT
SCRFPS      EQU     50                      ; SCREEN FRAMES PER SECOND

; --- KEYCODES -----------------------------------------------------------------

KBDUP       EQU     'W'
KBDRIGHT    EQU     'D'
KBDDOWN     EQU     'S'
KBDLEFT     EQU     'A'
KBDACTION   EQU     'X'
KBDPAUSE    EQU     'P'

; --- TRAP NUMBERS -------------------------------------------------------------

SCRUPTN     EQU     0                       ; SCREEN UPDATE TRAP NUMBER
KBDUPTN     EQU     1                       ; KEYBOARD UPDATE TRAP NUMBER
SNDPLTN     EQU     2                       ; SOUND PLAY TRAP NUMBER

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER

; --- MENU CONSTANTS -----------------------------------------------------------

MENUMAXM    EQU     4                       ; MENU MAX MOVEMENTS

; --- PLAYER RELATED CONSTANTS -----------------------------------------------------------

PLAYERSPEED 	EQU		5						; SPEED OF MAIN PLAYER
