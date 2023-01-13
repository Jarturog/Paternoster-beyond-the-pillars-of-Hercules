; ==============================================================================
; TITLE       :
; DESCRIPTION :
; AUTHOR      :
; HISTORY     :
; ==============================================================================
	
            ORG     $1000
            
            INCLUDE "CONST.X68"
            INCLUDE "BLOCKS.X68"
            INCLUDE "MAP.X68"
            INCLUDE "ELEVATOR_MENU.X68"
            INCLUDE "LIB/DMMCONST.X68"           
            INCLUDE "LIB/DMMCODE.X68"
            INCLUDE "SYSTEM.X68"
            INCLUDE "LIB/AGLCODE.X68"
            INCLUDE "LIB/UTLCODE.X68"           
            INCLUDE "PLAYER.X68"    
            INCLUDE "PROJECTILE.X68"
            
START

; --- INITIALIZATION -----------------------------------------------------------
            CLR.W LOADEDMAP
            ORI.W   #$0700,SR
            JSR     SYSINIT
            JSR     PLAYERINIT

.LOOP

; --- UPDATE -------------------------------------------------------------------

; READ INPUT DEVICES

            TRAP    #KBDUPTN

; UPDATE GAME LOGIC				
			JSR ELEVATORUPDATE 
        	JSR PLAYERUPD	
			JSR MAPUPD		  
            MOVE.B  (KBDEDGE),D0
            AND.B #%11110000,D0 ; SI DA CERO NO HA DISPARADO
            BEQ.B .NOTFIRED
            LEA     PROJINIT,A1
            LEA     PROJUPD,A2
            LEA     PROJPLOT,A3
            MOVE.W  #1,D0
            JSR     AGLADD

.NOTFIRED
            ; --
            TST.W   (NPROJ)
            BEQ     .NOPROJ1
            JSR     AGLUPD
.NOPROJ1
            

; --- SYNC ---------------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT ---------------------------------------------------------------------
			
			JSR MAPPLOT
            
            TST.W   (NPROJ)
            BEQ     .NOPROJ2
            JSR     AGLPLOT
.NOPROJ2
            JSR     PLAYERPLOT
            TRAP    #SCRUPTN                    ; UPDATE DOUBLE BUFFER

            BRA     .LOOP

            SIMHALT
            
            INCLUDE "VARS.X68" 
            INCLUDE "LIB/UTLVARS.X68"
            INCLUDE "LIB/DMMVARS.X68"
            
            
            END     START





*~Font name~Fixedsys~
*~Font size~9~
*~Tab type~1~
*~Tab size~4~
