#INCLUDE "fbgfx.bi"
Using fb
#Include "TSNEplay_V3.bi" 
Dim As String send_game_string,game_player_name(0)
Dim shared As Integer game_count,test

Dim Shared RV as TSNEPlay_GURUCode
Declare Sub log_chat(input_msg As String)
Declare Sub Senddata(player As Integer,data_send_1 As String,data_send_2 As String,data_send_3 As String,data_send_4 As String,data_type_1 As Integer,data_type_2 As Integer,data_type_3 As Integer,data_type_4 As Integer)

ChDir("resclient")

Type game_type
	As Integer player(0 To 10),player_id(0 To 10),ready(0 To 10),host,enable,count,set_start_game,set_ready,max_tile=100
	As String player_name(0 To 10),title
	
	
	As Integer hsc_score(0 To 11)
	As double hsc_game_time(1 To 11)
	As String hsc_player_name(0 To 11)
	Declare Sub start

	Declare Sub wait
	
End Type

Type button_type
	As Integer x_pos,y_pos,height,Width,dif,noklick
	As Any Ptr obj
	Declare Function klick As Integer
	Declare sub Draw
End Type

sub button_type.Draw
	Put (this.x_pos-this.dif,this.y_pos-this.dif),this.obj,alpha
End Sub
Dim Shared As Integer temp_button_klick_release
Function button_type.klick As Integer
	Dim As Integer temp_mx,temp_my,temp_mb
	GetMouse temp_mx,temp_my,,temp_mb
	If temp_mb=0 Then temp_button_klick_release=0
	If temp_mx>this.x_pos And temp_mx<this.x_pos+this.width-this.dif And temp_my>this.y_pos And temp_my<this.y_pos+this.height-this.dif And temp_mb=1  Then
		If temp_button_klick_release=0 Or noklick=1 Then
			temp_button_klick_release=1
			Return 1
		End If
	EndIf
	Return 0
End Function

Sub game_type.wait
	ScreenUnLock
	cls
	Do
		Sleep 1,1 
		'Sleep 1000,1 
		If MultiKey(1) Then Exit do
	Loop Until this.enable=0
	For p_i As Integer = 1 To 10
		this.player_name(p_i)=""
		this.player(p_i)=0
	Next
End Sub

Sub game_type.start
	Dim As String send_game_string="game"+Str(Len(Str(this.count)))+Str(this.count)+this.player_name(0)
	Do
	Loop Until this.set_start_game=1
	this.set_start_game=0
	ChDir("..")
	
	'Shell "start main.exe 127.0.0.1 "+send_game_string
	'Shell "start bin/main.exe 127.0.0.1 "+send_game_string
	Shell "start bin/main.exe klingenbund.org "+send_game_string
	ChDir("resclient")
End Sub



Dim Shared As game_type game(0 To 100)

Type global_type
	As Integer windowx,windowy,verbindungs_status,verbindungs_counter,verbindungs_set_show
	As Double verbindungs_time
	As String chat_text(1 To 30)
	As Integer chat_text_verschiebung,chat_lock
	Declare Sub init
	Declare Sub quit(temp_mx As Integer,temp_my As Integer,temp_mb As Integer)
	Declare Sub chat
	Declare Sub window_move
	Declare Sub verbinden
	Declare Sub verbindung
	Declare Function input_name  As String
	As Any Ptr background
	As Any Ptr table
	As Any Ptr logo
	As Any Ptr games
	As Any Ptr player
	As Any Ptr config
	As Any Ptr closeobj
	As button_type leftbutton
	As button_type rightbutton
	As Any Ptr scrollBackground
	As Any Ptr chatBackground
	As Any Ptr hscBackground
	As Any Ptr chatlittleBackground
	As Any Ptr chattextBackground
	As Any Ptr nameBackground
	As button_type createButton
	As button_type startButton
	As button_type readyButton
	As button_type backButton
	AS EVENT e
	As INTEGER x, y, pressed, col
	As ANY PTR img
	Declare Sub hsc
End Type

Sub global_type.quit(temp_mx As Integer,temp_my As Integer,temp_mb As Integer)
	Dim As Integer temp_x,temp_y
	temp_x=710-11
	temp_y=190-11
	Put (temp_x,temp_y),this.closeobj,Alpha
	If temp_mx>temp_x+11 And temp_mx<temp_x+46 And temp_my>temp_y+11 And temp_my<temp_y+46 And temp_mb=1 Then
		
		
		End
	EndIf
End Sub

Sub global_type.init
	this.windowx=800
	this.windowy=600
	
	ScreenRes this.windowx,this.windowy,32,,GFX_SHAPED_WINDOW
	'ScreenRes 400,250,32,, 
	background=ImageCreate(this.windowx,this.windowy)
	table=ImageCreate(180,325)
	logo=ImageCreate(600,200)
	games=ImageCreate(180,60)
	this.closeobj=ImageCreate(80,80)

	scrollBackground=ImageCreate(48,335)
	chatBackground=ImageCreate(446,49)
	chatlittleBackground=ImageCreate(246,50)
	chattextBackground=ImageCreate(450,375)
	hscBackground=ImageCreate(450,375)
	nameBackground=ImageCreate(180,60)
	player=ImageCreate(180,60)
	config=ImageCreate(180,60)
	BLoad "screen.bmp",background
	BLoad "table.bmp",table
	BLoad "logo.bmp",logo
	BLoad "games.bmp",games
	BLoad "player.bmp",player
	BLoad "config.bmp",config
	BLoad "close.bmp",this.closeobj
	BLoad "scroll.bmp",scrollBackground
	BLoad "chat.bmp",chatBackground
	BLoad "chatlittle.bmp",chatlittleBackground
	BLoad "chatbg.bmp",chattextBackground
	BLoad "hsc.bmp",hscBackground
	BLoad "name.bmp",nameBackground
	game(0).player_name(0)=this.input_name

	this.startButton.height=60
	this.startButton.width=180
	this.startButton.dif=11
	this.startButton.obj=ImageCreate(this.startButton.width,this.startButton.height)
	BLoad "start.bmp",this.startButton.obj
	
	this.createButton.height=60
	this.createButton.width=180
	this.createButton.dif=11
	this.createButton.obj=ImageCreate(this.createButton.width,this.createButton.height)
	BLoad "create.bmp",this.createButton.obj

	this.readyButton.height=60
	this.readyButton.width=180
	this.readyButton.dif=11
	this.readyButton.obj=Imagecreate(this.readyButton.width,this.readyButton.height)
	BLoad "ready.bmp",this.readyButton.obj
	
	this.backButton.height=60
	this.backButton.width=180
	this.backButton.dif=11
	this.backButton.obj=Imagecreate(this.backButton.width,this.backButton.height)
	BLoad "back.bmp",this.backButton.obj
	
	
	this.leftbutton.height=15
	this.leftbutton.width=8
	this.leftbutton.noklick=1
	this.leftButton.obj=Imagecreate(this.leftButton.width,this.leftButton.height)
	BLoad "left.bmp",this.leftbutton.obj

	this.rightbutton.height=15
	this.rightbutton.width=8
	this.rightbutton.noklick=1
	this.rightButton.obj=Imagecreate(this.rightButton.width,this.rightButton.height)
	BLoad "right.bmp",this.rightbutton.obj
	
End Sub

Sub global_type.window_move

  IF SCREENEVENT(@e) THEN
    SELECT CASE e.type
    CASE EVENT_MOUSE_BUTTON_PRESS
      ' Druck der Maustaste merken
      pressed = -1
    CASE EVENT_MOUSE_BUTTON_RELEASE
      ' Loslassen der Maustaste merken
      pressed = 0
    CASE EVENT_MOUSE_MOVE
      IF pressed Then
        ' Fenster verschieben
        If e.y<=180 Or e.x<=40 Or e.x>=760 Or e.y>=540 Then
	        SCREENCONTROL GET_WINDOW_POS, x, y
	        SCREENCONTROL SET_WINDOW_POS, x + e.dx, y + e.dy
	      
        End if
      END IF
    END SELECT
  END If
End Sub

function global_type.input_name As String
	Dim As String temp_msg,key
	Dim As Integer mx,my,mr,mb
	Do
		ScreenLock
		Cls
		GetMouse mx,my,mr,mb
		Put (0,0),this.background
		Put (128-15,189-17),this.logo,alpha
		this.quit(mx,my,mb)
		
		'Line ((this.windowx-410)/2+2+100,this.windowy/2-50)-(((this.windowx-410)/2)+420-2-100,this.windowy/2+20-50),RGB(90,90,90),bf
		Put ((this.windowx)/2-90,this.windowy/2-50-11+150),this.nameBackground,alpha
	
		'Line (()
		'(((this.windowx-410)/2)+318,this.windowy/2+20),RGB(90,90,90),bf
		Put ((this.windowx)/2-123,this.windowy/2-11+150),chatlittleBackground,alpha
		Draw String (this.windowx/2-(Len(game(0).player_name(0))/2*8),this.windowy/2+5+150),game(0).player_name(0)
		
		key=InKey
		If key<>"" Then 
			If key<>Chr(8)  Then
				If key>Chr(31) And key<Chr(127) Then game(0).player_name(0)+=key
			ElseIf key=Chr(8) Then
   			game(0).player_name(0)=Str(Mid(game(0).player_name(0),1,(Len(game(0).player_name(0))-1)))
			End If
		EndIf
		If Len(game(0).player_name(0))>9 Then game(0).player_name(0)=Mid(game(0).player_name(0),1,9)
		If MultiKey(&h1C) And game(0).player_name(0)<>"" Then
			If Len(game(0).player_name(0))<4 Then game(0).player_name(0)+="     "
			Return game(0).player_name(0)
		EndIf
		
		
		
		this.window_move
	ScreenunLock
	Sleep 1,1
	Loop
End Function

Sub global_type.verbindung
		this.verbindungs_status = TSNEPlay_Connection_GetState()
	'Do
		If this.verbindungs_status<3 then
				
			If this.verbindungs_status <3 Then
				'ScreenUnLock
				If verbindungs_set_show=0 Then log_chat("Connection error!"):verbindungs_set_show=1
				If verbindungs_time=0 Then verbindungs_time=Timer
				If verbindungs_counter<=0 Then verbindungs_counter=5
				If (Timer-verbindungs_time)>1 Then
					verbindungs_counter-=1
					verbindungs_time=0
					
					log_chat("Try to reconnect in "+Str(verbindungs_counter)+(" seconds!"))
				EndIf
				
					
				If verbindungs_counter<=0 Then
					verbindungs_set_show=0
					log_chat("Try to Connect...")
					this.verbinden
				EndIf
				this.verbindungs_status = TSNEPlay_Connection_GetState()
			EndIf
		End if

		
	'Loop Until 
End Sub

Sub global_type.hsc
	Dim As Integer mx,my,mr,mb
	Do
		GetMouse mx,my,mr,mb
		ScreenLock
		Cls
		Put (0,0),this.background
		this.quit(mx,my,mb)
		Put  (((this.windowx)/2)-225+11,this.windowy/4+32),this.hscBackground,Alpha

		this.backButton.x_pos=((this.windowx-410)/2)-170+20
		this.backButton.y_pos=this.windowy/4+313
		this.backButton.draw

		Draw String (((this.windowx)/2)-225+22+60,this.windowy/4+32+75-40),game(0).hsc_player_name(1)
		Draw String (((this.windowx)/2)-225+22+200,this.windowy/4+32+75-40),Str(game(0).hsc_score(1))+"x"
		Draw String (((this.windowx)/2)-225+5+300,this.windowy/4+32+75-40),Str(game(0).hsc_game_time(1))+"sec"
		
		Draw String (((this.windowx)/2)-225+22+60,this.windowy/4+32+125-39),game(0).hsc_player_name(2)
		Draw String (((this.windowx)/2)-225+22+200,this.windowy/4+32+125-39),Str(game(0).hsc_score(2))+"x"
		Draw String (((this.windowx)/2)-225+5+300,this.windowy/4+32+125-39),Str(game(0).hsc_game_time(2))+"sec"
		Draw String (((this.windowx)/2)-225+22+60,this.windowy/4+32+170-36),game(0).hsc_player_name(3)
		Draw String (((this.windowx)/2)-225+22+200,this.windowy/4+32+170-36),Str(game(0).hsc_score(3))+"x"
		Draw String (((this.windowx)/2)-225+5+300,this.windowy/4+32+170-36),Str(game(0).hsc_game_time(3))+"sec"
		
		For i As Integer = 1 To 7
			Draw String (((this.windowx)/2)-225+22+60,this.windowy/4+32+156+i*25-12),game(0).hsc_player_name(i+3)
			Draw String (((this.windowx)/2)-225+22+200,this.windowy/4+32+156+i*25-12),Str(game(0).hsc_score(i+3))+"x"
			Draw String (((this.windowx)/2)-225+5+300,this.windowy/4+32+156+i*25-12),Str(game(0).hsc_game_time(i+3))+"sec"
		Next

		For i As Integer = 1 To 10
			If game(0).player(i)<>0 Then
				'Draw String (10,i*10),(game(0).hsc_player_name(i))+" "+Str(game(0).hsc_score(i))
			EndIf
		Next
		this.window_move
		ScreenUnLock
		Sleep 1,1
	Loop Until this.backbutton.klick=1
End Sub

Sub global_type.chat
	Dim As String temp_input_chat,key
	Dim As Double temp_zeit
	'Cls
	Dim As Integer mx,my,mr,mb,temp_mr,temp_my,temp_click,temp_verschiebung,temp_init,temp_input_ln=1,mb_release,f=freefile
	Do
	Loop while len(inkey)
	this.chat_lock=1 
	game(0).ready(0)=0
	For g_i As Integer = 1 To 10
		game(0).ready(g_i)=0
	Next
	Do
		temp_zeit=timer
		GetMouse mx,my,mr,mb
		ScreenLock
		cls
		Put (0,0),this.background
		this.quit(mx,my,mb)
		Dim As Integer temp_screen_y=40
		Dim As Integer temp_screen_x=60

		

		
		this.CreateButton.x_pos=((this.windowx-410)/2)-170+temp_screen_x
		this.CreateButton.y_pos=this.windowy/4+313+temp_screen_y
		this.startButton.x_pos=((this.windowx-410)/2)-170+temp_screen_x
		this.startButton.y_pos=this.windowy/4+313+temp_screen_y
		this.readyButton.x_pos=((this.windowx-410)/2)-170+temp_screen_x
		this.readyButton.y_pos=this.windowy/4+313+temp_screen_y
		
		If game(0).enable=0 Then
			this.CreateButton.draw
		Else
			If game(0).ready(0)=0 Then
				this.ReadyButton.draw
			Else
				this.StartButton.draw
			EndIf
		EndIf
		
		Put ((this.windowx-410)/2+2+temp_screen_x-11,this.windowy/4+75+280-1-30+temp_screen_y-11),chatBackground,alpha


		Dim As Integer temp_line,scroll_balken_ln,temp_scroll_verschiebung
		Dim As String temp_text,open_file
		If game(0).enable=0 Then open_file="ChatLobby.txt"
		If game(0).enable<>0 Then open_file="ChatGame.txt"
		Open open_file For input As #f
			Do
				temp_line+=1
				Input #f,temp_text
				If temp_line>=this.chat_text_verschiebung+1 And temp_line<=this.chat_text_verschiebung+30 Then
					this.chat_text(temp_line-this.chat_text_verschiebung)=temp_text
					
				EndIf
			Loop Until Eof(f)
		Close #f
		If temp_init=0 or this.chat_lock=1 Then 
			this.chat_text_verschiebung=temp_line-30
			temp_init=1
		EndIf
		
		

		If mx<>-1 Then			
			If mr>temp_mr Then this.chat_text_verschiebung-=2  : this.chat_lock=0
			If mr<temp_mr Then this.chat_text_verschiebung+=2  : this.chat_lock=0
			temp_mr=mr			
		End If
		
		If temp_click=1 Then
			If my>temp_my Then this.chat_text_verschiebung=temp_verschiebung+(temp_line/(319-scroll_balken_ln))*(my-temp_my) : this.chat_lock=0
			If my<temp_my Then this.chat_text_verschiebung=temp_verschiebung-(temp_line/(319-scroll_balken_ln))*(temp_my-my) : this.chat_lock=0
		EndIf
		
		if this.chat_text_verschiebung=temp_line-30 then this.chat_lock=1
		
		If mb=0 And temp_click=1 Then temp_click=0
				 
			
		scroll_balken_ln=319*30/temp_line
		If scroll_balken_ln>319 Then scroll_balken_ln=319
			

		If this.chat_text_verschiebung<0 Then this.chat_text_verschiebung=0 
	
		
		If this.chat_text_verschiebung+30>temp_line Then this.chat_text_verschiebung=temp_line-30
	
		temp_scroll_verschiebung=((this.chat_text_verschiebung/(temp_line-30))*(319-scroll_balken_ln))
			

		
		Put  (((this.windowx-410)/2)+400+temp_screen_x-11-398,this.windowy/4-10+2+temp_screen_y-11),this.chattextBackground,alpha

		Put(((this.windowx-410)/2)+400+temp_screen_x-11,this.windowy/4-10+2+temp_screen_y-11),scrollBackground,alpha
	
		Line (((this.windowx-410)/2)+400+1+temp_screen_x,this.windowy/4-10+2+1+temp_scroll_verschiebung+temp_screen_y)-(((this.windowx-410)/2)+420-4+temp_screen_x,this.windowy/4-10+2+1+scroll_balken_ln+temp_scroll_verschiebung+temp_screen_y),RGB(40,60,90),bf
		
		
			
		If mx>((this.windowx-410)/2)+400+1+temp_screen_x And mx<((this.windowx-410)/2)+420-3+temp_screen_x Then
			
			If my>this.windowy/4-10+2+1+temp_scroll_verschiebung+temp_screen_y and my<(this.windowy/4-10+2+1+scroll_balken_ln+temp_scroll_verschiebung+temp_screen_y) Then
				
				If mb=1 And temp_click=0 Then
					temp_click=1
					temp_my=my
					temp_verschiebung=this.chat_text_verschiebung
				EndIf
			EndIf
		EndIf
		
		
		
		' Spielauswahl:
		Put((this.windowx-410)/2-170+temp_screen_x-11,this.windowy/4+temp_screen_y-11),this.table,alpha
		If game(0).enable=0 Then
			Put((this.windowx-410)/2-170+temp_screen_x-11,this.windowy/4+temp_screen_y-11),this.games,Alpha
		Else
			Put((this.windowx-410)/2-170+temp_screen_x-11,this.windowy/4+temp_screen_y-11),this.player,Alpha
			Put((this.windowx-410)/2-170+temp_screen_x-11,this.windowy/4+temp_screen_y-11+150),this.config,Alpha
			Draw String ((this.windowx-410)/2-170+temp_screen_x+5,this.windowy/4+temp_screen_y-11+202),"Max. Tiles:"
			Draw String ((this.windowx-410)/2-170+temp_screen_x+105,this.windowy/4+temp_screen_y-11+202),Str(game(0).max_tile)
			
			this.leftbutton.x_pos=(this.windowx-410)/2-170+temp_screen_x+90
			this.leftbutton.y_pos=(this.windowy/4+temp_screen_y-11+200-2)
			this.rightbutton.x_pos=(this.windowx-410)/2-170+temp_screen_x+140
			this.rightbutton.y_pos=(this.windowy/4+temp_screen_y-11+200-2)

			If game(0).host=1 Then
				this.leftbutton.draw
				this.rightbutton.draw
			EndIf
		EndIf
		
		

		
		If game(0).enable<>0 Then
			If game(0).ready(0)=0 And game(0).host=1 Then
				If this.leftbutton.klick=1 Then 
					game(0).max_tile-=1 
					If game(0).max_tile<10 Then game(0).max_tile=10
					Senddata(1,"conf",str(game(0).max_tile),"---","---",2,1,2,3)
				EndIf
				
				If this.rightbutton.klick=1 Then
					game(0).max_tile+=1 
					If game(0).max_tile>999 Then game(0).max_tile=999
					Senddata(1,"conf",str(game(0).max_tile),"---","---",2,1,2,3)
				EndIf
				
				
				
				
			End If
			
				For p_i As Integer = 1 To 10
					'If game(0).player(p_i)<>0 Then
						If game(0).ready(p_i)=0 Then
							Draw String ((this.windowx-410)/2-160+temp_screen_x,this.windowy/4-1+p_i*10+temp_screen_y+30),":>  "+game(0).player_name(p_i),RGB(255,0,0)
						Else
							Draw String ((this.windowx-410)/2-160+temp_screen_x,this.windowy/4-1+p_i*10+temp_screen_y+30),":>  "+game(0).player_name(p_i),RGB(0,255,0)
						EndIf
					'EndIf
				Next	
			Else
				For g_i As Integer = 1 To UBound(game)
					If game(g_i).enable<>0 Then
						If (g_i Mod 2)=1 then Line ((this.windowx-410)/2-170+temp_screen_x+1,this.windowy/4-1+g_i*10+temp_screen_y+30)-((this.windowx-410)/2-170+149+temp_screen_x-1,this.windowy/4-1+(g_i+1)*10+temp_screen_y+30),RGB(0,0,255),bf
						If (g_i Mod 2)=0 then Line ((this.windowx-410)/2-170+temp_screen_x+1,this.windowy/4-1+g_i*10+temp_screen_y+30)-((this.windowx-410)/2-170+149+temp_screen_x-1,this.windowy/4-1+(g_i+1)*10+temp_screen_y+30),RGB(0,0,125),bf
						
						
						If mx>(this.windowx-410)/2-160+temp_screen_x And mx<(this.windowx-410)/2-160+100+temp_screen_x And my>this.windowy/4-1+g_i*10+temp_screen_y+30 And my<this.windowy/4-1+(g_i+1)*10+temp_screen_y+30 Then
							Line ((this.windowx-410)/2-170+temp_screen_x+1,this.windowy/4-1+g_i*10+temp_screen_y+30)-((this.windowx-410)/2-170+149+temp_screen_x-1,this.windowy/4-1+(g_i+1)*10+temp_screen_y+30),RGB(100,100,255),bf
							If mb=1 Then
								Senddata(1,"stgame",game(0).player_name(0),"---","---",2,1,1,g_i)
								game(0).enable=1
							EndIf
						EndIf
						Draw String ((this.windowx-410)/2-168+temp_screen_x,this.windowy/4-1+g_i*10+temp_screen_y+30),":>"+game(g_i).title+"'s game"
					EndIf
				Next	
			EndIf
		
		If mb=0 Then mb_release=0
		'(((this.windowx-410)/2)-200+30,this.windowy/4+75+250)-(((this.windowx-410)/2)-200+30+150,this.windowy/4+75+280),RGB(50,50,50),bf
		
			If game(0).enable=0 Then
				If this.CreateButton.klick=1 Then
					'Du bist im moment in keinem Spiel!
					'Entweder du erstellst nun ein neues Spiel, oder du tritts einem anderem bei
					
					'Erstellen:
						Senddata(1,"stgame",game(0).player_name(0),"---","---",2,1,1,0)
						game(0).host=1
						game(0).enable=1
						mb_release=1
				EndIf
			Else
				If game(0).ready(0)=0 Then
					If this.ReadyButton.Klick=1 then
						mb_release=1
						game(0).ready(0)=1	
						Senddata(1,"rdgame","","---","---",2,1,2,1)
						
					End if
				Else
					'Start Game
					If this.StartButton.Klick=1 Then
						If game(0).set_ready=0 Then game(0).set_ready=1
						For t_i As Integer = 1 To 10
							If game(0).ready(t_i)=0 And game(0).player(t_i)<>0 Then game(0).set_ready=0
						Next
						If game(0).set_ready<>0 Then
							Senddata(1,"rdgame","---","---","---",2,1,2,2)
							Do 
							Loop Until game(0).set_ready=2
							Exit sub
						EndIf
					EndIf
				EndIf
				'Exit sub
			EndIf		
			
		Draw String ((this.windowx-410)/2+10+temp_screen_x,this.windowy/4+75+280-1-20+temp_screen_y),Mid(temp_input_chat,temp_input_ln,50)
		
		key=InKey
		If key<>"" Then 
			If key<>Chr(8)  Then
				If key>Chr(31) And key<Chr(127) Then temp_input_chat+=key
  		 		If Len(temp_input_chat)>50 Then temp_input_ln=Len(temp_input_chat)-50
  		 	
			ElseIf key=Chr(8) Then
   			temp_input_chat=Str(Mid(temp_input_chat,1,(Len(temp_input_chat)-1)))
   			If temp_input_ln+50>Len(temp_input_chat) And Len(temp_input_chat)>50 Then  temp_input_ln=Len(temp_input_chat)-50
			End If
		EndIf
		
		If MultiKey(&h1C) And temp_input_chat<>"" Then
			'If Mid(temp_input_chat,1,1)="/" Then 
			'	Senddata(Val(Mid(temp_input_chat,2)),"sendnix","","","",3,2,1,game(0).count)
			'EndIf
			If Len(temp_input_chat)<4 Then temp_input_chat+="     "
			If game(0).enable=0 then
				TSNEPlay_SendMSG(0,":>"+game(0).player_name(0)+": "+temp_input_chat)
			Else
				For h As Integer = 1 To 10
					If game(0).player(h)<>0 Then TSNEPlay_SendMSG(game(0).player_id(h),":>"+game(0).player_name(0)+": "+temp_input_chat)
				Next
			End if
			temp_input_chat=""
			temp_input_ln=1
		EndIf
		
		For i As Integer = 1 To 30		
			Draw String ((this.windowx-380)/2+temp_screen_x,this.windowy/4+i*10+temp_screen_y),this.chat_text(i)
			this.chat_text(i)=""
		Next
		

		
		this.verbindung
		this.window_move
		ScreenUnLock

		
		'If MultiKey(1) Then this.destroy
		Sleep 1,1
		WindowTitle "SnowManRunOnline     "+Str(time)
		
	Loop
End Sub

Dim Shared As global_type global

Sub log_chat(input_msg As String)
	Dim As Integer f=FreeFile
	Dim As String open_file
	If game(0).enable=0 Then open_file="ChatLobby.txt"
	If game(0).enable<>0 Then open_file="ChatGame.txt"	
	
	Open open_file For append As #f
			If Len(input_msg)>47 Then
				If Len(input_msg)/47=Len(input_msg)\47 Then
					For i As Integer = 1 To Len(input_msg)/47
						write #f,Mid(input_msg,1+47*(i-1),47)
						'global.chat_text_verschiebung+=1
					Next
				Else
					For i As Integer = 1 To Len(input_msg)\47+1
						write #f,Mid(input_msg,1+47*(i-1),47)
						'global.chat_text_verschiebung+=1
					Next					
				EndIf
			Else
				write #f,input_msg
				'global.chat_text_verschiebung+=1
			EndIf		
	Close #f
End Sub

Sub TSNEPlay_Message(ByVal V_FromPlayerID as UInteger, ByVal V_ToPlayerID as UInteger, ByVal V_Message as String, ByVal V_MessageType as TSNEPlay_MessageType_Enum, V_Nickname as String)
	Dim As Integer temp_pos_text
	If game(0).enable=0 Then
		log_chat(V_Message)
	Else
		For i As Integer = 1 To 10
			If game(0).player_ID(i)=V_FromPlayerID Then
				log_chat(V_Message)
				Exit for
			EndIf
		Next
	EndIf
	
End Sub

Sub TSNEPlay_Player_Disconnected(ByVal V_PlayerID as UInteger)
	For d As Integer = 1 To 10
		If game(0).player_id(d)=V_PlayerID Then
			game(0).player_id(d)=0
			game(0).player(d)=0
			game(0).ready(d)=0
			game(0).player_name(d)=""
			
			Exit for
		EndIf
	Next
End Sub

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
	
	If dt_data(1)=2 Then
		If dt_data(2)=1 Then
			If dt_data(3)=1 Then
				game(0).set_start_game=1
				game(0).count=dt_data(4)
			EndIf
		EndIf
	EndIf
	
	If dt_data(1)=3 Then
		game(0).player(dt_data(3))=dt_data(4)'V_FromPlayerID
		game(0).player_name(dt_data(3))=ds_data(2)
		game(0).player_id(dt_data(3))=dt_data(2)
		game(0).ready(dt_data(3))=Val(ds_data(3))
		game(0).set_ready=Val(ds_data(4))
	EndIf
	
	If dt_data(1)=4 Then
		If dt_data(2)=1 Then
			If dt_data(3)=1 Then
				If game(dt_data(4)).enable=0 then
					game(dt_data(4)).enable=1
					'game(dt_data(4)).player_name(0)="test"
					game(dt_data(4)).title=ds_data(2)	
				EndIf			
			EndIf
			If dt_data(3)=0 Then game(dt_data(4)).enable=0
			
		EndIf
		If dt_data(2)=2 Then
			If dt_data(3)=1 Then
				If dt_data(4)=1 Then
					game(0).enable=0
				EndIf
			EndIf
		EndIf
		If dt_data(2)=3 Then
			If dt_data(3)=1 Then
				game(0).hsc_player_name(dt_data(4))=(ds_data(1))
				'Print game(0).hsc_player_name(dt_data(4))
				game(0).hsc_score(dt_data(4))=Val(ds_data(2))
				game(0).hsc_game_time(dt_data(4))=Val(ds_data(4))/1000
			EndIf
			
		EndIf
		
	EndIf
	
	If dt_data(1)=5 Then
		game(0).max_tile=Val(ds_data(2))
	EndIf
	
	

End Sub

Sub global_type.verbinden
	
	TSNEPlay_CloseAll()
	
	'RV = TSNEPlay_ConnectToServer("127.0.0.1", 9850, game(0).player_name(0),"",0,0,@TSNEPlay_Player_Disconnected,@TSNEPlay_Message,0,@TSNEPlay_Data)
	RV = TSNEPlay_ConnectToServer("klingenbund.org", 9850, game(0).player_name(0), "",0,0,@TSNEPlay_Player_Disconnected,@TSNEPlay_Message,0,@TSNEPlay_Data)
	'If RV <> TSNEPlay_NoError Then Print "[ERROR] "; TSNEPlay_Desc_GetGuruCode(RV):' End -1
End Sub


global.init

global.verbinden

Do
	global.chat
	ScreenUnLock
	game(0).start
	game(0).wait
	global.hsc
	'end
Loop

