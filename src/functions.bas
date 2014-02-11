
Dim Shared As String temp_user_name



'---Netzwerk---


Sub Senddata(player As Integer,data_send_1 As String,data_send_2 As String,data_send_3 As String,data_send_4 As String,data_type_1 As Integer,data_type_2 As Integer,data_type_3 As Integer,data_type_4 As Integer) 
	Dim As String TSNE_Send_content
	Dim As Integer anzahl_ds,anzahl_dt
	
	If data_send_1<>"" Then anzahl_ds=1
	If data_send_2<>"" Then anzahl_ds=2
	If data_send_3<>"" Then anzahl_ds=3
	If data_send_4<>"" Then anzahl_ds=4
	
	If data_type_1<>0 Then anzahl_dt=1
	If data_type_2<>0 Then anzahl_dt=2
	If data_type_3<>0 Then anzahl_dt=3
	If data_type_4<>0 Then anzahl_dt=4
	
	
	TSNE_Send_content+=Str(anzahl_ds)
	If anzahl_ds>=1 Then TSNE_Send_content+=Str(Len(data_send_1))
	If anzahl_ds>=2 Then TSNE_Send_content+=Str(Len(data_send_2))
	If anzahl_ds>=3 Then TSNE_Send_content+=Str(Len(data_send_3))
	If anzahl_ds>=4 Then TSNE_Send_content+=Str(Len(data_send_4))
	
	If anzahl_ds>=1 Then TSNE_Send_content+=(data_send_1)
	If anzahl_ds>=2 Then TSNE_Send_content+=(data_send_2)
	If anzahl_ds>=3 Then TSNE_Send_content+=(data_send_3)
	If anzahl_ds>=4 Then TSNE_Send_content+=(data_send_4)
	
	TSNE_Send_content+=Str(anzahl_dt)
	If anzahl_dt>=1 Then TSNE_Send_content+=Str(Len(Str(data_type_1)))
	If anzahl_dt>=2 Then TSNE_Send_content+=Str(Len(Str(data_type_2)))
	If anzahl_dt>=3 Then TSNE_Send_content+=Str(Len(Str(data_type_3)))
	If anzahl_dt>=4 Then TSNE_Send_content+=Str(Len(Str(data_type_4)))
	
	
	If anzahl_dt>=1 Then TSNE_Send_content+=Str(data_type_1)
	If anzahl_dt>=2 Then TSNE_Send_content+=Str(data_type_2)
	If anzahl_dt>=3 Then TSNE_Send_content+=Str(data_type_3)
	If anzahl_dt>=4 Then TSNE_Send_content+=str(data_type_4)
	
	
	TSNEPlay_SendData(player,TSNE_Send_content)


End Sub

Sub TSNEPlay_Data(ByVal V_FromPlayerID as UInteger, ByVal V_ToPlayerID as UInteger, ByRef V_Data as String)
	
	Dim As String ds_data(1 To 4)
	Dim As Integer dt_data(1 To 4),anzahl_ds,anzahl_dt,aktu_stelle,ds_len(1 To 4),dt_len(1 To 4)
	
	
	anzahl_ds=Val(Mid(V_data,1,1))
	
	
	If anzahl_ds>=1 Then ds_len(1)=Val(Mid(V_data,2,1))
	If anzahl_ds>=2 Then ds_len(2)=Val(Mid(V_data,3,1))
	If anzahl_ds>=3 Then ds_len(3)=Val(Mid(V_data,4,1))
	If anzahl_ds>=4 Then ds_len(4)=Val(Mid(V_data,5,1))
	
	
	If anzahl_ds>=1 Then ds_data(1)=Mid(V_Data,2+anzahl_ds,ds_len(1))
	aktu_stelle=ds_len(1)+2+anzahl_ds
	If anzahl_ds>=2 Then ds_data(2)=Mid(V_Data,aktu_stelle,ds_len(2))
	aktu_stelle+=ds_len(2)
	If anzahl_ds>=3 Then ds_data(3)=Mid(V_Data,aktu_stelle,ds_len(3))
	aktu_stelle+=ds_len(3)
	If anzahl_ds>=4 Then ds_data(4)=Mid(V_Data,aktu_stelle,ds_len(4))
	aktu_stelle+=ds_len(4)
	
	anzahl_dt=Val(Mid(v_data,aktu_stelle,1))
	If anzahl_dt>=1 Then dt_len(1)=Val(Mid(v_data,aktu_stelle+1,1))
	If anzahl_dt>=2 Then dt_len(2)=Val(Mid(v_data,aktu_stelle+2,1))
	If anzahl_dt>=3 Then dt_len(3)=Val(Mid(v_data,aktu_stelle+3,1))
	If anzahl_dt>=4 Then dt_len(4)=Val(Mid(v_data,aktu_stelle+4,1))
	
	If anzahl_dt>=1 Then dt_data(1)=Val(Mid(V_Data,aktu_stelle+anzahl_dt+1,dt_len(1)))
	aktu_stelle+=dt_len(1)+anzahl_dt+1
	If anzahl_dt>=2 Then dt_data(2)=Val(Mid(V_Data,aktu_stelle,dt_len(2)))
	aktu_stelle+=dt_len(2)
	If anzahl_dt>=3 Then dt_data(3)=Val(Mid(V_Data,aktu_stelle,dt_len(3)))
	aktu_stelle+=dt_len(3)
	If anzahl_dt>=4 Then dt_data(4)=Val(Mid(V_Data,aktu_stelle,dt_len(4)))
	aktu_stelle+=dt_len(4)
	
	'####################################################################################
	
	If dt_data(1)=1 Then
		If dt_data(2)=1 Then
			If dt_data(3)=1 then
				player(dt_data(4)).pos_x=Val(ds_data(2))/1000
				player(dt_data(4)).pos_y=Val(ds_data(3))/1000
				player(dt_data(4)).pos_z=Val(ds_data(4))/1000
			End If
			
			If dt_data(3)=2 then
				player(dt_data(4)).rot_x=Val(ds_data(2))
				player(dt_data(4)).rot_y=Val(ds_data(3))
				player(dt_data(4)).rot_z=Val(ds_data(4))
			End If
			
			If dt_data(3)=3 Then
				If dt_data(4)=1 Then
					'If Asc(ds_data(2))=0 Or Asc(ds_data(2))>18 Then end
					'If Asc(ds_data(3))=0 Or Asc(ds_data(3))>18 Then end
					'If Asc(ds_data(4))=0 Or Asc(ds_data(4))>18 Then end
					
					global.world+=ds_data(2)
					global.world+=ds_data(3)
					global.world+=ds_data(4)
					
				EndIf
				
			EndIf
			
			If dt_data(3)=4 Then
				global.ready=1
			EndIf
		EndIf
	EndIf
	
	
End Sub



Sub render_screen
	updateworld
   renderworld
	'ScreenSync
	Flip
End Sub

Sub load_game(lvl As Integer)

	'If global.finish=1 Then Exit sub

	Dim As String text
	For i As Integer = 1 To 1
		global.item_belegt(lvl,i)=1
		global.item(lvl,i)=copyEntity(item(global.item_belegt(lvl,i)).obj)
		positionEntity global.item(lvl,i),global.tile_x-5+Int(Rnd*10),+Int(Rnd*5),global.tile_z-5+Int(Rnd*10)
	Next
	For i As Integer= 1 To 2
		If Mid(global.world,1,1)<>"" And Mid(global.world,1,1)<>"0" And global.finish=0 Then
			global.tile_belegt(lvl,i)=Asc(Mid(global.world,1,1)) 'int(Rnd*anzahl_tile)+1
			If Asc(Mid(global.world,1,1))=0 Then global.finish=3
			global.world=Mid(global.world,2)
			
			
			 
			global.tile(lvl,i)=copyEntity(tile(global.tile_belegt(lvl,i)).obj)
			global.finishTileMesh=global.tile(lvl,i)
			EntityFx global.tile(lvl,i),16
			player(0).aktu_world=lvl
			'global.tileShadow(lvl,i)=createShadow(global.tile(lvl,i))
		
			If tile(global.tile_belegt(lvl,i)).typ=1 Then 
				turnEntity global.tile(lvl,i),0,(global.tile_rot),0
			ElseIf tile(global.tile_belegt(lvl,i)).typ=2 Then
				turnEntity global.tile(lvl,i),0,(global.tile_rot),0
			ElseIf tile(global.tile_belegt(lvl,i)).typ=3 then
				turnEntity global.tile(lvl,i),0,-(global.tile_rot),0
			EndIf
			positionEntity global.tile(lvl,i),global.tile_x,0,global.tile_z
			global.tile_z-=((Sin(((global.tile_rot)/(180/(ACos(0)*2)))-tile(global.tile_belegt(lvl,i)).w1))*tile(global.tile_belegt(lvl,i)).len1)
			global.tile_rot+=tile(global.tile_belegt(lvl,i)).rot
			global.tile_x-=(Cos(((global.tile_rot)/(180/(ACos(0)*2)))+tile(global.tile_belegt(lvl,i)).w1)*tile(global.tile_belegt(lvl,i)).len1)
			
			'If global.tile_belegt(lvl,i)=0 Then global.tile_belegt(lvl,i)=-1
		Else
			global.tile(lvl,i)=CreateMesh
			Senddata(1,"GenWorld","","","",1,1,2,1)
			
		EndIf
	
	Next			

End Sub

Sub update_game
	Dim As Any Ptr mesh_col 

	For i As Integer = 1 To 2
		For j As Integer = 1 To 1
			If global.item_belegt(i,j)<>0 Then
				turnEntity global.item(i,j),0,1,0
			EndIf
		Next
	Next

	For i As Integer = 1 To 2
		For j As Integer = 1 To 1
			If global.item_belegt(i,j)<>0 then 
				If Abs(entityX(global.item(i,j))-EntityX(player(0).obj))<8 and Abs(entityy(global.item(i,j))-Entityy(player(0).obj))<8 And Abs(entityz(global.item(i,j))-Entityz(player(0).obj))<8 Then
					freeEntity global.item(i,j)
					global.item_belegt(i,j)=0
					player(0).modi+=1
					If global.finish=2 And Asc(Mid(global.world,1,1))=0 Then global.finish=1
					If global.finish=0 Then player(0).punkte+=1
					
					
				End if
			EndIf	
		Next
	Next

	For col As Integer = 1 To countcollisions(player(0).obj)
		mesh_col=CollisionEntity(player(0).obj,col)	
		If mesh_col<>0 And global.finish=3 Then
			If global.finishTileMesh=mesh_col Then global.finish=2
		EndIf
		
		If global.tile(player(0).aktu_world,1)=mesh_col Or global.tile(player(0).aktu_world,2)=mesh_col Or global.tile(player(0).aktu_world,3)=mesh_col Then
			If player(0).aktu_world=1 Then 
				
				'freeshadow(global.tileshadow(2,1))
				'freeshadow(global.tileshadow(2,2))
				'freeshadow(global.tileshadow(2,3))
				
				freeEntity global.tile(2,1)
				freeEntity global.tile(2,2)
				freeEntity global.tile(2,3)
				
				
				
				global.tile(2,1)=createMesh
				global.tile(2,2)=createMesh
				global.tile(2,3)=createMesh
				
		
				
				
				If global.item_belegt(2,1)<>0 Then freeEntity global.item(2,1)
				load_game(2)
				'If global.finish=0 Then player(0).punkte+=1

				'player(0).aktu_world=2

			
			ElseIf player(0).aktu_world=2 Then
				'freeshadow(global.tileshadow(1,1))
				'freeshadow(global.tileshadow(1,2))
				'freeshadow(global.tileshadow(1,3))

				freeEntity global.tile(1,1)
				freeEntity global.tile(1,2)
				freeEntity global.tile(1,3)
				
				global.tile(1,1)=createMesh
				global.tile(1,2)=createMesh
				global.tile(1,3)=createMesh
				

				
				If global.item_belegt(1,1)<>0 Then freeEntity global.item(1,1)
				load_game(1) 
				'If global.finish=0 Then player(0).punkte+=1
				'WindowTitle Str(player(0).meter_sec)
				'player(0).aktu_world

			EndIf
		EndIf
		
		
		If global.ter(1)=mesh_col Or global.ter(2)=mesh_col Or global.ter(3)=mesh_col Or global.ter(4)=mesh_col Or global.ter(5)=mesh_col Or global.ter(6)=mesh_col Or global.ter(7)=mesh_col Or global.ter(8)=mesh_col Or global.ter(9)=mesh_col Then
			player(0).modi=0
			'positionEntity player(0).obj,global.tile_x,100,global.tile_z
			'RotateEntity player(0).obj,0,0,0
	
			

		EndIf	
		
		
	Next

	If EntityX(player(0).obj)-global.ter_x>50 Then
		global.ter_x+=100
		For t_i As Integer = 2 To 9
			moveEntity global.ter(t_i),100,0,0
		Next
		moveEntity global.ter(1),100,0,0
	ElseIf EntityX(player(0).obj)-global.ter_x<(-50) Then
		global.ter_x-=100
		For t_i As Integer = 2 To 9
			moveEntity global.ter(t_i),-100,0,0
		Next
			moveEntity global.ter(1),-100,0,0
	EndIf
	If Entityz(player(0).obj)-global.ter_z>50 Then
		global.ter_z+=100
		For t_i As Integer = 2 To 9
			moveEntity global.ter(t_i),0,0,100
		Next
		moveEntity global.ter(1),0,0,100
	ElseIf Entityz(player(0).obj)-global.ter_z<(-50) Then
		global.ter_z-=100
		For t_i As Integer = 2 To 9
			moveEntity global.ter(t_i),0,0,-100
		Next
		moveEntity global.ter(1),0,0,-100
	EndIf


	moveEntity player(0).obj,0,0,-(player(0).max_speed-player(0).speed_minus)*global.fs*2
	
	player(0).meter+=(player(0).max_speed-player(0).speed_minus)*global.fs
	player(0).speed_minus+=3*global.fs
	If player(0).speed_minus>player(0).max_speed Then player(0).speed_minus=player(0).max_speed
	If player(0).sprung_aktiv=1 Then
		moveEntity player(0).obj,0,Abs(player(0).sprung_dauer-1-player(0).sprung_aktu_dauer),0'turnentity player,1,0,0
		player(0).sprung_aktu_dauer+=1
		If player(0).sprung_aktu_dauer>=player(0).sprung_dauer Then
			player(0).sprung_aktiv=-1
		EndIf
		
	Else
		
	EndIf
	If EntityCollided(player(0).obj,2)<>0 Then
  		player(0).sprung_aktiv=0
  		moveEntity player(0).obj,0,-20*global.fs,0
	Else
		moveEntity player(0).obj,0,-80*global.fs,0
	EndIf
	If Entitypitch(player(0).obj)<>0 Then
  		If Entitypitch(player(0).obj)>0 Then turnentity player(0).obj,-100*global.fs,0,0	
  		If Entitypitch(player(0).obj)<0 Then turnentity player(0).obj,100*global.fs,0,0
   EndIf
   If EntityRoll(player(0).obj)<>0 Then
   	If EntityRoll(player(0).obj)>0 Then turnentity player(0).obj,0,0,-100*global.fs
   	If EntityRoll(player(0).obj)<0 Then turnentity player(0).obj,0,0,100*global.fs
   EndIf
	
	
	
	'x*200*global.fs=100
	'x =100/200/global.fs
	
	player(0).pos_x=EntityX(player(0).obj)
	player(0).pos_y=Entityy(player(0).obj)
	player(0).pos_z=Entityz(player(0).obj)
	

	player(0).meter_sec=(player(0).max_speed-player(0).speed_minus) '(player(0).meter-player(0).start_meter)/(Timer-player(0).start_zeit)\10000

	rotateSprite global.SpeedMeter(2),60-1.5*player(0).meter_sec
	
	player(0).old_pos_x=player(0).pos_x
	player(0).old_pos_z=player(0).pos_z
	player(0).old_pos_y=player(0).pos_y
	
	Senddata(1,"PlayPos",Str(EntityX(player(0).obj)*1000),Str(Entityy(player(0).obj)*1000),Str(Entityz(player(0).obj)*1000),1,1,1,1)
	Senddata(1,"PlayRot",Str(EntityPitch(player(0).obj)),Str(EntityYaw(player(0).obj)),Str(EntityRoll(player(0).obj)),1,1,1,2)

	'Gegenspieler
	For pl_i As Integer = 1 To 10
		'If player(pl_i).enable=1 Then
			positionEntity player(pl_i).obj,(player(pl_i).pos_x),(player(pl_i).pos_y),(player(pl_i).pos_z)
			rotateEntity player(pl_i).obj,(player(pl_i).rot_x),(player(pl_i).rot_y),(player(pl_i).rot_z)
		'EndIf
	Next
	
	
	
	'WindowTitle "Punktzahl: "+Str(player(0).punkte)+" "+Str("Meter: ")+Str(player(0).meter\10)+"  Meter/Sekunde:"+Str(player(0).meter_sec)+"  Modifikator"+Str(player(0).modi)+"x"
	'WindowTitle Str(player(0).aktu_world)
	
   positionEntity global.sky_box,EntityX(player(0).obj),Entityy(player(0).obj),Entityz(player(0).obj)
   'positionEntity global.light ,EntityX(player(0).obj)-50,Entityy(player(0).obj)+50,Entityz(player(0).obj)+10


	
End Sub

Function gfx(ByRef regen_akt As Integer, ByRef regen_dichte As Integer, ByRef regen_speed As Integer) As Integer
	If  regen_akt=1 Then
		level_regen=1
		regen_count=(((global.windowx+500)/10)/100)*regen_dichte
		For gfx_i As Integer = 1 To (((global.windowx+500)/10)/100)*regen_dichte
			regen(gfx_i).aktiv=1
			regen(gfx_i).speed=(regen_speed/10)*Int(Rnd*10)+1
			regen(gfx_i).hoehe=regen(gfx_i).z
			regen(gfx_i).obj=loadsprite("snow_sprite.png")	

			SpriteViewMode  regen(gfx_i).obj,4
			Entityfx regen(gfx_i).obj,16
		Next
		Return 1
	Else
		For gfx_i As Integer = 1 To (((global.windowx+500)/10)/100)*regen_dichte
			regen(gfx_i).aktiv=0
		Next
		Return 0
	EndIf
End Function

Function gfx_player(ByRef snow_akt As Integer, ByRef snow_dichte As Integer, ByRef snow_speed As Integer) As Integer
	If  snow_akt=1 Then
		player(0).gfx=1
		player(0).gfx_count=snow_dichte
		For gfx_i As Integer = 1 To player(0).gfx_count
			player_gfx(gfx_i).aktiv=1
			player_gfx(gfx_i).speed=(snow_speed/10)*Int(Rnd*10)+1
			player_gfx(gfx_i).hoehe=player_gfx(gfx_i).z	
			player_gfx(gfx_i).obj=loadsprite("snow_sprite.png")
			scaleEntity player_gfx(gfx_i).obj,2,2,2			
			SpriteViewMode  player_gfx(gfx_i).obj,3
			Entityfx player_gfx(gfx_i).obj,16
			positionEntity player_gfx(gfx_i).obj,EntityX(player(0).obj),Entityy(player(0).obj),Entityz(player(0).obj)
		Next
		Return 1
	Else
		For gfx_i As Integer = 1 To player(0).gfx_count
			regen(gfx_i).aktiv=0
		Next
		Return 0
	EndIf
End Function



Sub render_gfx
	If global.configValue.config(2).value=1 Then
		For gfx_i As Integer = 1 To regen_count
			If regen(gfx_i).aktiv=1 Then
				regen(gfx_i).hoehe=Int(Rnd*10)
				regen(gfx_i).y-=((regen(gfx_i).speed)/20)*((Int(Rnd*10)+1)+10)
				regen(gfx_i).x-=sturm_x
				regen(gfx_i).z-=sturm_z		
				If regen(gfx_i).y<=0 Then
					regen(gfx_i).x=entityx(player(0).obj)-100+Int(Rnd*200)-sturm_x
					regen(gfx_i).z=entityz(player(0).obj)-100+Int(Rnd*200)-sturm_z
					regen(gfx_i).y=entityy(player(0).obj)+50
				EndIf
			EndIf
			positionEntity regen(gfx_i).obj,regen(gfx_i).x,regen(gfx_i).y,regen(gfx_i).z
		Next
	End If
	
	If global.configValue.config(3).value=1 then
		For gfx_i As Integer = 1 To player(0).gfx_count
			If player_gfx(gfx_i).aktiv=1 Then
				'If player_gfx(gfx_i).hoehe>0 Then moveEntity player_gfx(gfx_i).obj,-1+Int(Rnd*2),1,-1+Int(Rnd*2) 	
				If player_gfx(gfx_i).hoehe>0 Then moveEntity player_gfx(gfx_i).obj,0,1,0 	
				If player_gfx(gfx_i).hoehe<0 Then moveEntity player_gfx(gfx_i).obj,0,-1,0
				player_gfx(gfx_i).hoehe-=1
				If EntityY(player_gfx(gfx_i).obj)<=0 And player(0).gfx=1  Then
					positionEntity player_gfx(gfx_i).obj,EntityX(player(0).obj),Entityy(player(0).obj),Entityz(player(0).obj)
					RotateEntity player_gfx(gfx_i).obj,EntityPitch(player(0).obj),EntityYaw(player(0).obj)-10+Int(Rnd*10),-1*EntityRoll(player(0).obj)-10+Int(Rnd*10)
					'moveEntity player_gfx(gfx_i).obj,0,0,-1+Int(Rnd*2)
					player_gfx(gfx_i).hoehe=-5+Int(Rnd*10)+1
				EndIf
			EndIf
		Next
	End if
End Sub

Sub init_game
	Collisions 1,2,2  
	load_game(player(0).aktu_world)
	gfx(1,500,5)
	gfx_player(1,25,5)

	turnEntity player(0).obj,0,-90,0

	'turnentity global.camera,0,180,0
	moveEntity global.camera,0,100,200



	For i As Integer = 1 To 100
		pointEntity global.camera,player(0).obj
		moveEntity global.camera,0,1,2
		render_screen
	Next
	positionEntity global.camera,EntityX(player(0).obj),Entityy(player(0).obj),Entityz(player(0).obj)

	rotateEntity global.camera,0,0,0
	moveEntity global.camera,0,-5,10
	turnEntity global.camera,200,0,180	
	

	moveEntity player(0).obj,0,0,-10	

	'gamePlayer Ready!!
	Senddata(1,"plgarde","---","---","---",1,2,1,1)
	showEntity global.waiting
	Do
		render_screen
		If MultiKey(1) Then End
		
	Loop Until global.ready=1
	hideEntity global.waiting
End Sub
