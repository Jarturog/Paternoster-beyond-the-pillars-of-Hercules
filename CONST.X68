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

; --- MENU CONSTANTS -----------------------------------------------------------

MENUMAXM    EQU     4                       ; MENU MAX MOVEMENTS
ELEVXL      EQU     SCRWIDTH/4              ; ELEVATOR X LEFT COORDINATE
ELEVXR      EQU     3*SCRWIDTH/4            ; ELEVATOR X RIGHT COORDINATE
ELEVYU      EQU     SCRHEIGH/64             ; ELEVATOR Y UP COORDINATE
ELEVYD      EQU     63*SCRHEIGH/64          ; ELEVATOR Y DOWN COORDINATE
TRILENGH    EQU     32                      ; LENGTH OF EACH SIDE OF EACH TRIANGLE IN THE ELEVATOR

; --- PLAYER RELATED CONSTANTS -------------------------------------------------
PLAYERSPEED 	EQU		5						; SPEED OF MAIN PLAYER
PLAYERWIDTH     EQU	    80
PLAYERHEIGHT	EQU     80

; --- PROJECTILE RELATED CONSTANTS ---------------------------------------------

PROJWIDTH       EQU     PLAYERWIDTH/2
PROJHEIGHT      EQU     PLAYERHEIGHT/2
PROJSPEEDX      EQU     8
PROJSPEEDY      EQU     8

