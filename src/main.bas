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
	Cls
	
	
	global.zeit=timer
	player(0).start_meter=player(0).meter

	
	player(0).gfx=0
	If global.finish<>1 then
		player(0).controlls(global.fs)
		update_game
	Elseif global.finish=1 Then
		If player(0).finish_zeit=0 Then
			player(0).finish_zeit=Timer-player(0).start_zeit
			global.sendhsc(mid(global.param(3),7+Val(Mid(global.param(3),2,1))),Str(player(0).punkte),Str(player(0).meter),(player(0).finish_zeit),1)
		End If
		'player(0).controlls(global.fs)
		showEntity global.finishscreen
		player(0).speed_minus+=300*global.fs
		If player(0).speed_minus >= player(0).max_speed Then 
			player(0).speed_minus=player(0).max_speed		
		EndIf
		turnEntity player(0).obj2,0,100*global.fs,0
		moveEntity player(0).obj,0,0,-(player(0).max_speed-player(0).speed_minus)*global.fs*2
		If EntityCollided(player(0).obj,2)<>0 Then
  			moveEntity player(0).obj,0,-20*global.fs,0
		Else
			moveEntity player(0).obj,0,-80*global.fs,0
		EndIf
	End if
	
   render_gfx
	render_screen
	global.fs=(Timer-global.zeit)/2
	
Loop Until MultiKey(1)



End