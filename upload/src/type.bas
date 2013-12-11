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

Type global_type
	As Integer windowx,windowy
	As String param(1 To 3),world
	As Any Ptr camera,light,ter(1 To 9),tile(1 to 2,1 To 3),deko(1 To 2),sky_box,item(1 To 2, 1 To 5)
	As double tile_belegt(1 to 2,1 To 3),deko_belegt(1 To 2),tile_rot,tile_x,tile_z,item_belegt(1 To 2,1 To 5),ter_x,ter_z
	Declare Sub init

End Type
Dim Shared RV as TSNEPlay_GURUCode
Declare Sub TSNEPlay_Data(ByVal V_FromPlayerID as UInteger, ByVal V_ToPlayerID as UInteger, ByRef V_Data as String)
Sub global_type.init
	Screen 18
	param(1)=Command(1)
	param(2)=Command(2)
	
	Print ":"+param(1)
	Print ":"+param(2)
	Do
		
	TSNEPlay_CloseAll()
	RV = TSNEPlay_ConnectToServer(param(1),9869,param(2),"",0,0,0,0,0,@TSNEPlay_Data)
	If RV <> TSNEPlay_NoError Then 
		Print "[ERROR] "; TSNEPlay_Desc_GetGuruCode(RV)
		Print "### GAME CRASH ###"
		Sleep
		'end
	EndIf
	Loop Until RV = TSNEPlay_NoError
	

	this.windowx=800
	this.windowy=600
	
	ScreenRes this.windowx,this.windowy,32,,&h10002
	Graphics3D windowx,windowy
	this.camera=createcamera
	moveEntity this.camera,0,5,10
	turnEntity This.camera,200,0,180
	CameraRange camera, 1, 250
	CameraClsColor camera, 222, 252, 255
	CameraFogColor camera, 222, 252, 255
	cameraFogMode camera,1
	CameraFogRange camera, 50,230
	this.light=createlight
	For t_i As Integer = 1 To 9
		this.ter(t_i)=loadMesh("ground.b3d")
		Entitytype this.ter(t_i),2
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
	
End Sub


Type login_type
	As Integer ID
	As String nickname
End Type

Dim Shared As Any Ptr player_obj
Type player_type
	As Any Ptr obj,obj2
	As double aktu_world,speed_minus,max_speed,punkte,gfx,gfx_count,sprung_aktiv,sprung_dauer,sprung_aktu_dauer,zeit,start_zeit,pos_x,pos_y,pos_z,rot_x,rot_y,rot_z
	As Integer meter,start_meter,modi,meter_sec,enable
	Declare Sub init
	Declare Sub controlls
End Type

Sub player_type.init
	this.obj=copyEntity(player_obj)'
	this.max_speed=2
	this.speed_minus=this.max_speed
	this.aktu_world=1
	Entitytype This.obj,1
	this.sprung_dauer=8

End sub

Sub player_type.controlls

	If MultiKey(&h48) And this.sprung_aktiv=0 Then
		this.gfx=1
		If this.speed_minus>0 then 
			this.speed_minus-=0.2
		EndIf
	EndIf
	
	If MultiKey(&h50) Then
		If this.speed_minus>0 Then
			this.speed_minus+=0.05
			turnentity this.obj,-2,0,0,0
		EndIf
	EndIf
	
	If MultiKey(&h39) And this.sprung_aktiv=0 Then   
   	this.sprung_aktiv=1
   	this.sprung_aktu_dauer=0
   EndIf
   If MultiKey(&h4d) then turnentity this.obj,0,-2,2,0
   If MultiKey(&h4b) then turnentity this.obj,0,2,-2,0

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
global.init

player_obj=loadmesh("body.b3d")
Dim Shared As player_type player(0 To 10)
For p_ci As Integer= 0 To UBound(player)
	player(p_ci).init
Next
'Player 0 -> selbst

Entityparent global.camera, player(0).obj

PositionEntity player(0).obj,0,10,0

Dim Shared As Integer anzahl_tile=18
Dim Shared As tile_type tile(1 To anzahl_tile)
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

tile(4).filename="tile4.b3d"
tile(4).typ=1
'tile(4).flip1=1
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

Dim Shared As Integer deko_anzahl=1
Dim Shared As tile_type deko(1 To deko_anzahl)
deko(1).filename="deko1.b3d"
deko(1).typ=1
tile(1).sx=10
tile(1).sz=10
tile(1).sy=10
deko(1).load



Dim Shared As Integer item_anzahl=1
Dim Shared As item_type item(1 To item_anzahl)
item(1).filename="item1.b3d"
item(1).sx=2
item(1).sy=2
item(1).sz=2
item(1).load
