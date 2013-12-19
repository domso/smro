Randomize Timer
ChDir("resgame")
'###2d teil###

#Include "openb3d.bi"
'#Define render_opengl
'#Include "2d.bi"
#Include "TSNEplay_V3.bi" 
#Include "type.bas"
#Include "functions.bas"


init_game
player(0).start_zeit=Timer
Do
	cls
	global.zeit=timer
	player(0).start_meter=player(0).meter

	
	player(0).gfx=0
	If global.finish<>1 then
		player(0).controlls(global.fs)
	Elseif global.finish=1 Then
		If player(0).finish_zeit=0 Then
			player(0).finish_zeit=Timer-player(0).start_zeit
			global.sendhsc(mid(global.param(2),7+Val(Mid(global.param(2),2,1))),Str(player(0).punkte),Str(player(0).meter),(player(0).finish_zeit),1)
		End If
		'player(0).controlls(global.fs)
		showEntity global.finishscreen
		player(0).speed_minus+=300*global.fs
		turnEntity player(0).obj2,0,100*global.fs,0
	End if
	update_game
   render_gfx
	render_screen
	global.fs=(Timer-global.zeit)
	
Loop Until MultiKey(1)



end