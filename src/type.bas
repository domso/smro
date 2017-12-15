Declare Sub Senddata(player As Integer,data_send_1 As String,data_send_2 As String,data_send_3 As String,data_send_4 As String,data_type_1 As Integer,data_type_2 As Integer,data_type_3 As Integer,data_type_4 As Integer)
Type tile_type
	As Any Ptr obj,shadow,tex
	As String filename
	As double rx,ry,rz,sx,sy,sz,rot,lx,lz,w1,len1,flip1,typ
	Declare Sub load
End Type

Sub tile_type.load
	this.obj=loadMesh(this.filename)
	this.tex=loadTexture("stein.png")
	Entitytexture this.obj,this.tex	
	rotateEntity this.obj,this.rx,this.ry,this.rz
	scaleEntity this.obj,this.sx,this.sz,this.sy	
	this.w1=Atn(this.lz/this.lx)
	this.len1=(((this.lx*this.sx)^2)+((this.lz*this.sz)^2))^0.5
	If this.flip1=1 Then flipmesh this.obj
	Entityfx this.obj,16	
	Entitytype this.obj,2
	hideEntity this.obj
End Sub

Type daytimeType
	As Integer fog_max,fog_min,fog_red,fog_green,fog_blue,amb_red,amb_green,amb_blue
End Type

Type config_item_type
	As Integer value
End Type

Type config_type
	As Integer maxConfig
	As config_item_type config(1 To 15)
End Type

Type global_type
	As Integer windowx,windowy,finish,ready,setdaytime=3
	As daytimeType daytime(1 To 3)
	As Double zeit,fs, last_player_send=0
	As String param(1 To 3),world
	As Any Ptr camera,light,ter(1 To 9),tile(1 to 2,1 To 3),sky_box,item(1 To 2, 1 To 5), finish_tile
	As double tile_belegt(1 to 2,1 To 3),deko_belegt(1 To 2),tile_rot,tile_x,tile_z,item_belegt(1 To 2,1 To 5),ter_x,ter_z, resetX, resetY, resetZ, resetRot, resetRotNew=0
	Declare Sub init
	Declare Sub sendhsc(hsc_name As String,hsc_punkte As String, hsc_meter As String, hsc_time As double,force As integer)

	as config_type configValue
	'interface
	As Any Ptr SpeedMeter( 1 To 2),waiting,finishscreen,finishTileMesh
End Type
Dim Shared RV as TSNEPlay_GURUCode
Declare Sub TSNEPlay_Data(ByVal V_FromPlayerID as UInteger, ByVal V_ToPlayerID as UInteger, ByRef V_Data as String)

Sub global_type.init
	ScreenInfo this.windowx,this.windowy 
	param(1)=Command(1)
	param(2)=Command(2)
	param(3)=Command(3)
	this.setdaytime=val(Command(4))
	
	For i As Integer = 1 To 15
		this.configValue.config(i).value=Val(Command(i+4))
	Next
	
	
	Do

	TSNEPlay_CloseAll()
	RV = TSNEPlay_ConnectToServer(param(1),Val(param(2)),param(3),"",0,0,0,0,0,@TSNEPlay_Data)
	If RV <> TSNEPlay_NoError Then 
		Print "[ERROR] "; TSNEPlay_Desc_GetGuruCode(RV)
		Print "Could not connect as "+Str(param(2))+"@"+Str(param(1))
		Sleep
		'end
	EndIf
	Loop Until RV = TSNEPlay_NoError
	

	'this.windowx=800
	'this.windowy=600


	If this.configValue.config(1).value=1 Then 
		ScreenRes this.windowx,this.windowy,32,,&h10002 Or &h01	
	Else
		ScreenRes this.windowx,this.windowy,32,,&h10002
	EndIf
	
	Graphics3D this.windowx,this.windowy
	this.camera=createcamera
	
	this.SpeedMeter(1)=loadsprite("speed.png",2)
	this.SpeedMeter(2)=loadsprite("speed2.png",2)
	this.waiting=loadsprite("waiting.png",2)
	this.finishscreen=loadsprite("finish.png",2)
	
	SpriteViewMode  this.SpeedMeter(1),1
	SpriteViewMode  this.SpeedMeter(2),1

	SpriteViewMode  this.waiting,1
	SpriteViewMode  this.finishscreen,1
	'MoveEntity this.SpeedMeter(1),-3.5,2.5,5
	'MoveEntity this.SpeedMeter(2),-3.5,2.5,5
	MoveEntity this.SpeedMeter(1),-4.5,2.3,5
	MoveEntity this.SpeedMeter(2),-4.5,2.3,5

	MoveEntity this.waiting,0,0,5
	MoveEntity this.finishscreen,0,0,5
	ScaleSprite this.speedMeter(1),0.5,0.5
	ScaleSprite this.speedMeter(2),0.5,0.5

	EntityParent this.SpeedMeter(1), this.camera
	EntityParent this.SpeedMeter(2), this.camera

	EntityParent this.waiting, this.camera
	EntityParent this.finishscreen, this.camera
	hideEntity this.waiting
	hideEntity this.finishscreen
	rotateSprite this.SpeedMeter(2),60

	
	moveEntity this.camera,0,5,10
	turnEntity This.camera,200,0,180
	CameraRange camera, 1, 283
	
	'CameraClsColor camera, 222, 252, 255
	
	CameraFogColor camera, this.daytime(setdaytime).fog_red,this.daytime(setdaytime).fog_green,this.daytime(setdaytime).fog_blue
	AmbientLight this.daytime(setdaytime).amb_red,this.daytime(setdaytime).amb_green,this.daytime(setdaytime).amb_blue
	cameraFogMode camera,1
	CameraFogRange camera, this.daytime(setdaytime).fog_min,this.daytime(setdaytime).fog_max
	this.light=createlight(1)
	LightColor this.light, this.daytime(setdaytime).amb_red,this.daytime(setdaytime).amb_green,this.daytime(setdaytime).amb_blue
	moveEntity this.light,0,5,0
	'EntityParent this.light,this.camera
	For t_i As Integer = 1 To 9
		this.ter(t_i)=loadMesh("ground.b3d")
		Entitytype this.ter(t_i),4
		moveEntity this.ter(t_i),50,-1,50
	Next
	moveEntity this.ter(2),100,0,0
	moveEntity this.ter(3),100,0,100
	moveEntity this.ter(4),0,0,100
	moveEntity this.ter(5),-100,0,100
	moveEntity this.ter(6),-100,0,0
	moveEntity this.ter(7),-100,0,-100
	moveEntity this.ter(8),0,0,-100
	moveEntity this.ter(9),100,0,-100
	This.ter_x=50
	This.ter_z=50
	For i As Integer = 1 To 2
		For j As Integer = 1 To 3
			this.tile(i,j)=createMesh		
		Next
	Next
	this.sky_box=loadMesh("sky.b3d")
	flipmesh this.sky_box
	scaleEntity this.sky_box,200,200,200
	
	this.world+=Chr(1)
	this.world+=Chr(1)
	this.world+=Chr(1)
	this.world+=Chr(1)
	
	For i As Integer = 1 To 2
		For j As Integer = 1 To 3
			this.tile(i,j)=createcube		
		Next
	Next
	
	

	
End Sub

Sub global_type.sendhsc(hsc_name As String,hsc_punkte As String, hsc_meter As String, hsc_time As double,force As integer)
	'Senddata(1,,,,,1,3,1,1)
	Senddata(1,hsc_name,hsc_punkte,"0",Mid(Str(Cast(Integer,hsc_time*1000)),1,9),1,3,1,1)

End Sub

Type login_type
	As Integer ID
	As String nickname
End Type

Dim Shared As Any Ptr player_obj
Type player_type
	As Any Ptr obj,obj2,shadow,shadowMeshObj
	As double aktu_world,speed_minus,max_speed,gfx,gfx_count,sprung_aktiv,sprung_dauer,sprung_aktu_dauer,zeit,start_zeit,finish_zeit,pos_x,pos_y,pos_z,old_pos_x,old_pos_y,old_pos_z,rot_x,rot_y,rot_z,meter_sec, last_rot
	As Integer meter,start_meter,modi,enable,punkte,last_rot_was_delete, isReset=0
	Declare Sub init
	Declare Sub controlls(plfs As Double)
End Type

Sub player_type.init
	this.obj=copyEntity(player_obj)'
	this.shadowMeshObj=copyEntity(player_obj)
	ScaleEntity this.shadowMeshObj,1.2,1.2,1.2
	EntityAlpha this.ShadowMeshObj,0
	
	EntityParent this.ShadowMeshObj,this.obj
	this.obj2=createMesh
	'EntityFx this.obj,4
	EntityParent this.obj2,this.obj
	this.max_speed=200
	this.speed_minus=this.max_speed
	this.aktu_world=1
	Entitytype This.obj,1
	this.sprung_dauer=8
	this.last_rot = 0
	This.last_rot_was_delete = 0
End Sub

Sub player_type.controlls(plfs As Double)
	this.last_rot = 0
	If MultiKey(&h48) And this.sprung_aktiv=0 Then
		this.gfx=1
		If this.speed_minus>0 then 
			this.speed_minus-=400*plfs*(1/((this.meter_sec/5)+1))
			'If wasRotatedInLastIteration <> 2 Then
				turnEntity this.obj,-100*plfs,0,0
				this.last_rot = -100*plfs
			'End If
			'this.wasRotatedInLastIteration = 1
		EndIf
	Else
		If Entitypitch(this.obj)<>0 And this.sprung_aktiv=0 Then
  			If Entitypitch(this.obj)>0 Then turnentity this.obj,-100*plfs,0,0	
  			If Entitypitch(this.obj)<0 Then turnentity this.obj,100*plfs,0,0
  			'this.wasRotatedInLastIteration += 2
		EndIf
	EndIf
	
	If MultiKey(&h50) Then
		If this.speed_minus>0 Then
			this.speed_minus+=80*plfs
			turnentity this.obj,-50*plfs,0,0,0
		EndIf
	EndIf
	
	If MultiKey(&h39) And this.sprung_aktiv=0 Then   
   	this.sprung_aktiv=1
   	this.sprung_aktu_dauer=0
   EndIf
   If MultiKey(&h4d) then turnentity this.obj,0,-200*plfs,200*plfs,0
   If MultiKey(&h4b) then turnentity this.obj,0,200*plfs,-200*plfs,0

End Sub



Type typgfx
	As double aktiv,speed, x=1,y=1,z=1, hoehe
	As Any Ptr obj
End Type
Dim Shared As typgfx regen(1 To 5000)
Dim Shared As Integer level_regen,regen_count,sturm_x,sturm_z
sturm_x=1
sturm_z=1

Dim Shared As typgfx player_gfx(1 To 1000)

Type item_type
	As Any Ptr obj
	As String filename
	As Double sx,sz,sy
	Declare Sub load
End Type

sub item_type.load
	this.obj=loadMesh(this.filename)
	scaleEntity this.obj,this.sx,this.sz,this.sy
	Entitytype this.obj,3
	hideentity this.obj
End Sub



Dim Shared As global_type global
global.daytime(1).fog_max=250
global.daytime(1).fog_min=50
global.daytime(1).fog_red=255
global.daytime(1).fog_green=255
global.daytime(1).fog_blue=255
global.daytime(1).amb_red=127
global.daytime(1).amb_green=127
global.daytime(1).amb_blue=127

global.daytime(2).fog_max=85
global.daytime(2).fog_min=50
global.daytime(2).fog_red=0
global.daytime(2).fog_green=0
global.daytime(2).fog_blue=0
global.daytime(2).amb_red=50
global.daytime(2).amb_green=50
global.daytime(2).amb_blue=50


global.init

player_obj=loadmesh("body.b3d")



Dim Shared As player_type player(0 To 10)
For p_ci As Integer= 0 To UBound(player)
	player(p_ci).init
Next
'player(0).shadow=createShadow(player(0).obj)

'Player 0 -> selbst
 

Entityparent global.camera, player(0).obj2

PositionEntity player(0).obj,0,10,0

Dim Shared As Integer anzahl_tile=24
Dim Shared As tile_type tile(0 To anzahl_tile)
tile(0).filename="finish.b3d"
tile(0).typ=1
tile(0).ry=180
tile(0).sx=10
tile(0).sz=10
tile(0).sy=10
tile(0).lx=10
tile(0).load



tile(1).filename="tile1.b3d"
tile(1).typ=1
tile(1).ry=180
tile(1).sx=10
tile(1).sz=10
tile(1).sy=10
tile(1).lx=10
tile(1).load

tile(2).filename="tile2.b3d"
tile(2).typ=2
tile(2).ry=180
tile(2).sx=10
tile(2).sz=10
tile(2).sy=10
tile(2).lx=4
tile(2).lz=4
tile(2).flip1=0
tile(2).rot=-90
tile(2).load

tile(3).filename="tile3.b3d"
tile(3).typ=3
tile(3).ry=180
tile(3).rx=180
tile(3).sx=10
tile(3).sz=10
tile(3).sy=10
tile(3).lx=4
tile(3).lz=-4
tile(3).flip1=1
tile(3).rot=90
tile(3).load

tile(4).filename="tile25.b3d"
tile(4).typ=1
tile(4).ry=180
tile(4).sx=10
tile(4).sz=10
tile(4).sy=10
tile(4).lx=10
tile(4).load

tile(5).filename="tile5.b3d"
tile(5).typ=1
'tile(5).flip1=1
tile(5).ry=180
tile(5).sx=10
tile(5).sz=10
tile(5).sy=10
tile(5).lx=10
tile(5).load

tile(6).filename="tile6.b3d"
tile(6).typ=1
'tile(6).flip1=1
tile(6).ry=180
tile(6).sx=10
tile(6).sz=10
tile(6).sy=10
tile(6).lx=10
tile(6).load

tile(7).filename="tile7.b3d"
tile(7).typ=1
'tile(7).flip1=1
tile(7).ry=180
tile(7).sx=10
tile(7).sz=10
tile(7).sy=10
tile(7).lx=10
tile(7).load

tile(8).filename="tile8.b3d"
tile(8).typ=1
'tile(8).flip1=1
tile(8).ry=180
tile(8).sx=10
tile(8).sz=10
tile(8).sy=10
tile(8).lx=10
tile(8).load

tile(9).filename="tile9.b3d"
tile(9).typ=1
'tile(9).flip1=1
tile(9).ry=180
tile(9).sx=10
tile(9).sz=10
tile(9).sy=10
tile(9).lx=10
tile(9).load

tile(10).filename="tile10.b3d"
tile(10).typ=1
'tile(10).flip1=1
tile(10).ry=180
tile(10).sx=10
tile(10).sz=10
tile(10).sy=10
tile(10).lx=10
tile(10).load

tile(11).filename="tile11.b3d"
tile(11).typ=1
'tile(1).flip1=1
tile(11).ry=180
tile(11).sx=10
tile(11).sz=10
tile(11).sy=10
tile(11).lx=10
tile(11).load

tile(12).filename="tile12.b3d"
tile(12).typ=1
'tile(1).flip1=1
tile(12).ry=180
tile(12).sx=10
tile(12).sz=10
tile(12).sy=10
tile(12).lx=10
tile(12).load

tile(13).filename="tile13.b3d"
tile(13).typ=1
'tile(1).flip1=1
tile(13).ry=180
tile(13).sx=10
tile(13).sz=10
tile(13).sy=10
tile(13).lx=10
tile(13).load

tile(14).filename="tile14.b3d"
tile(14).typ=1
'tile(1).flip1=1
tile(14).ry=180
tile(14).sx=10
tile(14).sz=10
tile(14).sy=10
tile(14).lx=20
tile(14).load

tile(15).filename="tile15.b3d"
tile(15).typ=2
tile(15).ry=180
tile(15).sx=10
tile(15).sz=10
tile(15).sy=10
tile(15).lx=4
tile(15).lz=4
tile(15).flip1=0
tile(15).rot=-90
tile(15).load

tile(16).filename="tile16.b3d"
tile(16).typ=3
tile(16).ry=180
tile(16).rx=180
tile(16).sx=10
tile(16).sz=10
tile(16).sy=10
tile(16).lx=4
tile(16).lz=-4
tile(16).flip1=1
tile(16).rot=90
tile(16).load

tile(17).filename="tile17.b3d"
tile(17).typ=2
tile(17).ry=180
tile(17).sx=10
tile(17).sz=10
tile(17).sy=10
tile(17).lx=4
tile(17).lz=4
tile(17).flip1=0
tile(17).rot=-90
tile(17).load

tile(18).filename="tile18.b3d"
tile(18).typ=3
tile(18).ry=180
tile(18).rx=180
tile(18).sx=10
tile(18).sz=10
tile(18).sy=10
tile(18).lx=4
tile(18).lz=-4
tile(18).flip1=1
tile(18).rot=90
tile(18).load

tile(19).filename="tile19.b3d"
tile(19).typ=1
tile(19).ry=180
tile(19).sx=10
tile(19).sz=10
tile(19).sy=10
tile(19).lx=10
tile(19).load

tile(20).filename="tile20.b3d"
tile(20).typ=1
tile(20).ry=180
tile(20).sx=10
tile(20).sz=10
tile(20).sy=10
tile(20).lx=10
tile(20).load

tile(21).filename="tile21.b3d"
tile(21).typ=1
tile(21).ry=180
tile(21).sx=10
tile(21).sz=10
tile(21).sy=10
tile(21).lx=10
tile(21).load


tile(22).filename="tile22.b3d"
tile(22).typ=2
tile(22).ry=180
tile(22).sx=10
tile(22).sz=10
tile(22).sy=10
tile(22).lx=4
tile(22).lz=4
tile(22).flip1=0
tile(22).rot=-90
tile(22).load

tile(23).filename="tile23.b3d"
tile(23).typ=3
tile(23).ry=180
tile(23).rx=180
tile(23).sx=10
tile(23).sz=10
tile(23).sy=10
tile(23).lx=4
tile(23).lz=-4
tile(23).flip1=1
tile(23).rot=90
tile(23).load

tile(24).filename="tile24.b3d"
tile(24).typ=1
tile(24).ry=180
tile(24).sx=10
tile(24).sz=10
tile(24).sy=10
tile(24).lx=10
tile(24).load


Dim Shared As Integer item_anzahl=1
Dim Shared As item_type item(1 To item_anzahl)
item(1).filename="item1.b3d"
item(1).sx=2
item(1).sy=2
item(1).sz=2
item(1).load
