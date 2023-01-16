; ==============================================================================
; CONSTANTS
; ==============================================================================

; --- SCREEN RELATED CONSTANTS -------------------------------------------------

SCRWIDTH            EQU    640      ; SCREEN WIDTH
SCRHEIGH            EQU    480      ; SCREEN HEIGHT
FRAMES_PER_SECOND   EQU     50      ; DESIRED SCREEN FRAMES PER SECOND
FPSTEXTPOS          EQU    (SCRWIDTH/14)<<8|1

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

; --- INTERRUPT NUMBERS --------------------------------------------------------

SCRINTN     EQU     1                       ; TIMED INTERRUPT NUMBER
SCRINTFPSN  EQU     2                       ; 1 SECOND TIMED INTERRUPT NUMBER

; --- PLAYER RELATED CONSTANTS -------------------------------------------------

PLAYERSPEED 	EQU		4						; SPEED OF MAIN PLAYER
PLAYERWIDTH     EQU	    32
PLAYERHEIGHT	EQU     32

; --- PROJECTILE RELATED CONSTANTS ---------------------------------------------

PROJWIDTH       EQU     PLAYERWIDTH/2
PROJHEIGHT      EQU     PLAYERHEIGHT/2
PROJSPEEDX      EQU     8
PROJSPEEDY      EQU     8

; --- MUSIC RELATED CONSTANTS --------------------------------------------------

HEAVENSOUND	    DC.B 'SND/MUSIC1.WAV',0
ELEVATOR_MUSIC	DC.B 'SND/ELEVATOR_MUSIC.WAV',0
HELLSOUND	    DC.B 'SND/MUSIC2.WAV',0
PROJ_SOUND	    DC.B 'SND/PROJ_SOUND.WAV',0

; --- STATE RELATED CONSTANTS --------------------------------------------------

STANONE     EQU     -1                      ; NON-EXISTENT STATE NUMBER

; --- MAP RELATED CONSTANTS ----------------------------------------------------

BLOCKSROW   EQU     20                      ; BLOCKS PER ROW
BLOCKSCOL   EQU     15                      ; BLOCKS PER COLUMN
BLOCKSIZE   EQU     32                      ; BLOCK SIZE IN PIXELS

; --- ELEVATOR RELATED CONSTANTS -----------------------------------------------

COLBUTHL	EQU	    $000000CC
COLBUTHV	EQU	    $00EEEEEE

; --- INTRO RELATED CONSTANTS --------------------------------------------------

BTONPOSX    EQU     SCRWIDTH/3
BTONPOSY    EQU     SCRHEIGH-112
BTONWIDTH   EQU     218
BTONHEIGHT  EQU     32
BMAPWIDTH   EQU     400
BMAPHEIGH   EQU     100
BMAPPOSX    EQU     (SCRWIDTH-BMAPWIDTH)/2
BMAPPOSY    EQU     128

; --- OBSTACLE RELATED CONSTANTS -----------------------------------------------

OBSWIDTH    EQU     32
OBSHEIGHT   EQU     32
MAXOBSXROOM EQU     8

; --- AGENT RELATED CONSTANTS --------------------------------------------------

PROJTYPE    EQU     1
OBSTYPE     EQU     2




















*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
