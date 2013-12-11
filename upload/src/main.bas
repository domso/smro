Randomize Timer

'###2d teil###
CHDIR "resgame/"
#Include "openb3d.bi"
#Include "TSNEplay_V3.bi" 
#Include "type.bas"
#Include "functions.bas"


init_game

Do
	player(0).start_meter=player(0).meter
	player(0).start_zeit=Timer
	
	player(0).gfx=0
	player(0).controlls
	update_game
	
   render_gfx
	render_screen
Loop Until MultiKey(1)
