; ==============================================================================
; TITLE       :
; DESCRIPTION :
; AUTHOR      :
; HISTORY     :
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "LIB/DMMCONST.X68"
            INCLUDE "LIB/UTLCONST.X68"         
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"
            INCLUDE "BLOCKS.X68"
            INCLUDE "MAP.X68"
            INCLUDE "ELEVATOR.X68"           
            INCLUDE "PLAYER.X68"    
            INCLUDE "PROJECTILE.X68"
            INCLUDE "AUDIO.X68"
            INCLUDE "STATES.X68"
            INCLUDE "GAME.X68"
            INCLUDE "INTRO.X68"
            INCLUDE "ENDGAME.X68"
            INCLUDE "OBSTACLE.X68"
START

; --- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     STAINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC

              JSR     STAUPD

; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)
            ADDQ.B  #1,(SCRINTFPS) ; ONE MORE FRAME

; --- PLOT ---------------------------------------------------------------------
            
            JSR     STAPLOT
            
            TRAP    #SCRUPTN                ; UPDATE DOUBLE BUFFER

            BRA     .LOOP
            
            SIMHALT
            
            INCLUDE "VARS.X68"
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"
            INCLUDE "DATA/MAPDATA.X68"
            INCLUDE "DATA/INTRODATA.X68"

            END     START













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
