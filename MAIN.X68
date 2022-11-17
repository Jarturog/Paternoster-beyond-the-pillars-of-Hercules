; ==============================================================================
; TITLE       :
; DESCRIPTION :
; AUTHOR      :
; HISTORY     :
; ==============================================================================

            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "MAPCONST.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "MENU.X68"
            INCLUDE "VARS.X68" 
            INCLUDE "MAPVARS.X68" 
            INCLUDE "PLAYER.X68"
            INCLUDE "MAP.X68"
            
            
            
START

; --- INITIALIZATION -----------------------------------------------------------

            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     MENUINIT
            JSR     PLAYERINIT
            JSR     MAPINIT
.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC
            JSR     MENUUPD         
            JSR     PLAYERUPD 

; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT ---------------------------------------------------------------------

            JSR     MENUPLOT ; POR AHORA SOLO ES EL MOONCAKE Y EL ASCENSOR
            JSR     MAPPLOT
            JSR     PLAYERPLOT
            
            TRAP    #SCRUPTN                    ; UPDATE DOUBLE BUFFER

            BRA     .LOOP

            SIMHALT
            
            END     START




*~Font name~Fixedsys~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
