#Include "TSNEplay_V3.bi" 
Randomize timer
Declare Sub Senddata(player As Integer,data_send_1 As string,data_send_2 As String,data_send_3 As String,data_send_4 As String,data_type_1 As Integer,data_type_2 As Integer,data_type_3 As Integer,data_type_4 As Integer)
Dim Shared RV as TSNEPlay_GURUCode
Dim Shared As Integer anzahl_tile=24
Type player_type
	As String nickname
	As Integer online,id,game
End Type

Dim Shared As player_type player(1 To 100)

Type highscore_type
	As Integer score(0 To 11),game_time(1 To 11)
	As String player_name(0 To 11)
	Declare Function new_score(hsc_score As Integer) As Integer
	Declare sub edit_score(hsc_score As Integer,hsc_player_name As String,hsc_time As Integer,hsc_ID As integer)
	'Declare Sub draw_score(x As Integer,y As Integer)
	Declare Sub save_score
	Declare Sub load_score
	'Declare function show As Integer
End Type

Type game_type
	As Integer player(1 To 10),enable,game_playerID(1 To 10),player_id(1 To 10),player_ready(1 To 10),set_ready,max_len=100,aktu_len,game_player_ready(1 To 10),daytime=1
	As String title
	As highscore_type hsc
End Type
Dim Shared As game_type game(1 To 100)




Function highscore_type.new_score(hsc_time As Integer) As Integer
	For hsc_i As Integer = 1 To 10
		If hsc_time<this.game_time(hsc_i) Then Return hsc_i
		If this.game_time(hsc_i)=0 Then Return hsc_i
	Next
	Return 0
End Function

sub highscore_type.edit_score(hsc_score As Integer,hsc_player_name As String,hsc_time As Integer,hsc_ID As Integer)
	Dim As Integer temp_var
	If hsc_ID=0 Then Exit sub
	For hsc_i As Integer = 0 To 11-hsc_ID
		temp_var=11-hsc_i
		this.score(temp_var)=this.score(temp_var-1)
		this.player_name(temp_var)=this.player_name(temp_var-1)
		this.game_time(temp_var)=this.game_time(temp_var-1)
	Next
	
	this.score(hsc_ID)=hsc_score
	this.player_name(hsc_ID)=hsc_player_name
	this.game_time(hsc_ID)=hsc_time
	'this.save_score
	'Print this.player_name(hsc_ID)+" "+Str(this.game_time(hsc_ID)) 

End Sub

Sub highscore_type.load_score
	Dim As Integer f=FreeFile
	Open "highscore" For Binary As #f
		For hsc_i As Integer = 1 To 10
			input #f,this.player_name(hsc_i)
			Input #f,this.score(hsc_i)
			Input #f,this.game_time(hsc_i)
		Next
	Close #f
End Sub

Sub highscore_type.save_score
	Dim As Integer f=FreeFile
	Open "highscore" For Binary As #f
		For hsc_i As Integer = 1 To 10
			print #f,this.player_name(hsc_i)
			Print #f,this.score(hsc_i)
			Print #f,this.game_time(hsc_i)
		Next
	Close #f
End Sub


Sub server_Log(info As String)
	Dim As Integer f=freefile
	Open "serverlog.txt" For Append As #f
			write #f,Str(date)+"||"+Str(time)+" :> "+info
	Close #f
End Sub




sub Senddata(player As Integer,data_send_1 As string,data_send_2 As String,data_send_3 As String,data_send_4 As String,data_type_1 As Integer,data_type_2 As Integer,data_type_3 As Integer,data_type_4 As Integer) 
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
	
	
	TSNEPlay_SendData(player,TSNE_Send_content+"|||")


	


End Sub


Sub TSNEPlay_Player_Connected(ByVal V_PlayerID as UInteger, V_IPA as String, V_Nickname as String)
server_Log("Player connected: "+V_Nickname+" || ID:"+Str(V_PlayerID))

If Mid(V_Nickname,1,4)="game" Then
	'Benutzer ist wohl ein game-client!
	'Print "new game user"
	For i As Integer = 1 To UBound(player)
			If player(i).nickname=Mid(V_Nickname,6+Val(Mid(V_Nickname,5,1))) And player(i).online=1 Then
				
				For j As Integer = 1 To 10
					If game(Val(Mid(V_Nickname,4+Val(Mid(V_Nickname,5,1)),Val(Mid(V_Nickname,5,1))))).player(j)=i Then
						game(Val(Mid(V_Nickname,4+Val(Mid(V_Nickname,5,1)),Val(Mid(V_Nickname,5,1))))).game_playerID(j)=V_PlayerID
		
						'player(
						Exit sub
					EndIf
					
				Next
				
				
				
				'game().game_playerID(j)=i
				'val(Mid(V_Nickname,4+Val(Mid(V_Nickname,5,1)),Val(Mid(V_Nickname,5,1))))
				'player(j).game=val(Mid(V_Nickname,4+Val(Mid(V_Nickname,5,1)),Val(Mid(V_Nickname,5,1))))
				'player(j).id=V_PlayerID
				'Exit sub
				'Print "User: "+Str(player(j).id)+"/"+Str(player(j).game)

			EndIf

	Next
	
EndIf


For i As Integer = 1 To UBound(player)
	If player(i).online=0 And Mid(V_Nickname,1,4)<>"game" Then
		player(i).online=1
		player(i).id=V_PlayerID
		player(i).nickname=V_Nickname
		TSNEPlay_SendMSG(V_playerID,"Welcome to this server")
		'Senddata(V_PlayerID,"gameuser","--","--","--",3,1,1,i)
		Exit for
	EndIf
Next

End Sub

Sub TSNEPlay_Player_Disconnected(ByVal V_PlayerID as UInteger)

For i As Integer = 1 To UBound(player)
	If player(i).id=V_PlayerID Then
		Senddata(0,"users",player(i).nickname,Str(player(i).game),"",7,2,1,i)
		server_Log("Player disconnected: "+player(i).nickname+" || ID:"+Str(V_PlayerID))
		player(i).online=0
		player(i).id=0
		player(i).nickname=""
		player(i).game=0
		Exit for
	EndIf	
Next

For i As Integer = 1 To UBound(game)
	For j As Integer = 1 To 10
		If (game(i).game_playerID(j)=V_PlayerID) Then

	
						
			Senddata(game(i).player_id(j),"gaClOff","---","---","---",4,2,1,1)
			game(i).game_playerID(j)=0
			'game(i).player_id(j)=0
			game(i).player(j)=0
			game(i).aktu_len=0
			game(i).max_len=100
			For k As Integer = 1 To 10
				If game(i).game_playerID(k)<>0 Then Exit sub
			Next
			
			
			'Es ist kein Spieler mehr im game, daher kann es gelöscht werden

			For k As Integer = 1 To 10
 				game(k).player(k)=0
 				game(k).game_playerID(k)=0
 				game(k).player_id(k)=0
 				game(k).player_ready(k)=0				
			Next
			game(i).enable=0
			game(i).set_ready=0
			Exit for
		EndIf
		
		If game(i).player_ID(j)=V_PlayerID Then
			
			'Senddata(game(i).player_id(j),"gaClOff","---","---","---",4,2,1,1)
			game(i).player_id(j)=0
			game(i).player(j)=0
			game(i).aktu_len=0
			game(i).max_len=100
			For k As Integer = 1 To 10
				If  game(i).player_ID(k)<>0 Then Exit sub
			Next
			
			
			'Es ist kein Spieler mehr im game, daher kann es gelöscht werden

			For k As Integer = 1 To 10
 				game(k).player(k)=0
 				game(k).game_playerID(k)=0
 				game(k).player_id(k)=0
 				game(k).player_ready(k)=0				
			Next
			game(i).enable=0
			game(i).set_ready=0
			Exit For
			
		EndIf
	Next
Next


End Sub



Sub TSNEPlay_Message(ByVal V_FromPlayerID as UInteger, ByVal V_ToPlayerID as UInteger, ByVal V_Message as String, ByVal V_MessageType as TSNEPlay_MessageType_Enum, V_Nickname as String)

For i As Integer = 1 To Len(V_Message)+1
	If Mid(V_Message,i,1)="/" Then 'Befehle

		If Mid(V_Message,i+1,10)="start_game" Then
			'Start
			
			For j As Integer = 1 To UBound(player)
				If player(j).nickname=Mid(V_Message,i+12) Then
					player(j).game=1
					For k As Integer = 1 To UBound(player)
						If player(k).id=V_FromPlayerID Then
							player(k).game=1
							Exit for
						EndIf
					Next
					If Int(Rnd*2)+1=1 Then
						Senddata(V_FromPlayerID,"start",Str(player(j).ID),"1","",1,1,1,1)
						Senddata(player(j).ID,"start",Str(V_FromPlayerID),"","",1,2,1,1)

					Else
						Senddata(V_FromPlayerID,"start",Str(player(j).ID),"","",1,1,1,1)
						Senddata(player(j).ID,"start",Str(V_FromPlayerID),"1","",1,2,1,1)

					EndIf
					
					Exit for	
				EndIf
				
			Next
						
			Exit for
		EndIf
		
		
		
		
	EndIf
	
Next



End Sub



Sub TSNEPlay_Data(ByVal V_FromPlayerID as UInteger, ByVal V_ToPlayerID as UInteger, ByRef V_Data as String)
		
	Dim As String tmpData
	tmpData = V_Data
	Do
		If Left(tmpData,3)="|||" Then tmpData = Mid(tmpData,4)
		If tmpData = "" Then Return
		If InStr(tmpData,"|||") = 0 Then return
		tmpData = Mid(tmpData,1,InStr(tmpData,"|||")-1)
		'
	
		
		Dim As String ds_data(1 To 4)
		Dim As Integer dt_data(1 To 4),anzahl_ds,anzahl_dt,aktu_stelle,ds_len(1 To 4),dt_len(1 To 4)
		
		anzahl_ds=Val(Mid(tmpData,1,1))
		
		
		If anzahl_ds>=1 Then ds_len(1)=Val(Mid(tmpData,2,1))
		If anzahl_ds>=2 Then ds_len(2)=Val(Mid(tmpData,3,1))
		If anzahl_ds>=3 Then ds_len(3)=Val(Mid(tmpData,4,1))
		If anzahl_ds>=4 Then ds_len(4)=Val(Mid(tmpData,5,1))
		
		
		If anzahl_ds>=1 Then ds_data(1)=Mid(tmpData,2+anzahl_ds,ds_len(1))
		aktu_stelle=ds_len(1)+2+anzahl_ds
		If anzahl_ds>=2 Then ds_data(2)=Mid(tmpData,aktu_stelle,ds_len(2))
		aktu_stelle+=ds_len(2)
		If anzahl_ds>=3 Then ds_data(3)=Mid(tmpData,aktu_stelle,ds_len(3))
		aktu_stelle+=ds_len(3)
		If anzahl_ds>=4 Then ds_data(4)=Mid(tmpData,aktu_stelle,ds_len(4))
		aktu_stelle+=ds_len(4)
		
		anzahl_dt=Val(Mid(tmpData,aktu_stelle,1))
		If anzahl_dt>=1 Then dt_len(1)=Val(Mid(tmpData,aktu_stelle+1,1))
		If anzahl_dt>=2 Then dt_len(2)=Val(Mid(tmpData,aktu_stelle+2,1))
		If anzahl_dt>=3 Then dt_len(3)=Val(Mid(tmpData,aktu_stelle+3,1))
		If anzahl_dt>=4 Then dt_len(4)=Val(Mid(tmpData,aktu_stelle+4,1))
		
		If anzahl_dt>=1 Then dt_data(1)=Val(Mid(tmpData,aktu_stelle+anzahl_dt+1,dt_len(1)))
		aktu_stelle+=dt_len(1)+anzahl_dt+1
		If anzahl_dt>=2 Then dt_data(2)=Val(Mid(tmpData,aktu_stelle,dt_len(2)))
		aktu_stelle+=dt_len(2)
		If anzahl_dt>=3 Then dt_data(3)=Val(Mid(tmpData,aktu_stelle,dt_len(3)))
		aktu_stelle+=dt_len(3)
		If anzahl_dt>=4 Then dt_data(4)=Val(Mid(tmpData,aktu_stelle,dt_len(4)))
		aktu_stelle+=dt_len(4)
		
		'####################################################################################
		
		Dim As string temp_send_item(1 To 3)
		If dt_data(1)=1 Then 'programm
			If dt_data(2)=1 Then
				If dt_data(3)=1 Then
					If dt_data(4)=1 Then
						For i As Integer = 1 To UBound(game)
							For j As Integer = 1 To 10
								If game(i).game_playerID(j)=V_FromPlayerID Then
									For k As Integer = 1 To 10
										If j<>k And game(i).game_playerID(k)<>0 Then
											Senddata(game(i).game_playerID(k),ds_data(1),ds_data(2),ds_data(3),ds_data(4),1,1,1,k)
										EndIf
									Next
									
									Exit sub
								EndIf
							Next
						Next
					EndIf
					
					If dt_data(4)=2 Then
						For i As Integer = 1 To UBound(game)
							For j As Integer = 1 To 10
								If game(i).game_playerID(j)=V_FromPlayerID Then
									For k As Integer = 1 To 10
										If j<>k And game(i).game_playerID(k)<>0 Then
											Senddata(game(i).game_playerID(k),ds_data(1),ds_data(2),ds_data(3),ds_data(4),1,1,2,k)
										EndIf
									Next
									
									Exit sub
								EndIf
							Next
						Next
					EndIf
				ElseIf dt_data(3)=2 Then
					If dt_data(4)=1 Then
						For i As Integer = 1 To UBound(game)
							For j As Integer = 1 To 10
								If game(i).game_playerID(j)=V_FromPlayerID Then
									
									
									temp_send_item(1)=Chr(Int(Rnd*anzahl_tile)+1)
									If game(i).aktu_len+1>=game(i).max_len Then temp_send_item(1)=Chr(0)
									game(i).aktu_len+=1
									temp_send_item(2)=Chr(Int(Rnd*anzahl_tile)+1)
									If game(i).aktu_len+1>=game(i).max_len Then temp_send_item(2)=Chr(0)
									game(i).aktu_len+=1
									temp_send_item(3)=Chr(Int(Rnd*anzahl_tile)+1)
									If game(i).aktu_len+1>=game(i).max_len Then temp_send_item(3)=Chr(0)
									game(i).aktu_len+=1
									
									
									
									For k As Integer = 1 To 10
										If game(i).game_playerID(k)<>0 Then
											Senddata(game(i).game_playerID(k),ds_data(1),temp_send_item(1),temp_send_item(2),temp_send_item(3),1,1,3,1)
										EndIf
									Next
									
									Exit sub
								EndIf
							Next
						Next
					EndIf
				EndIf
			EndIf
		
			If dt_data(2)=2 Then
				If dt_data(3)=1 Then
					If dt_data(4)=1 Then
						For i As Integer = 1 To UBound(game)
							For j As Integer = 1 To 10
								If game(i).game_playerID(j)=V_FromPlayerID Then
									game(i).game_player_ready(j)=1
									
									For k As Integer = 1 To 10
										If game(i).player(k)<>0 Then
											If game(i).player_ready(k)<>game(i).game_player_ready(k) Then
												Exit Sub
											End If
										EndIf
									Next
									For k As Integer = 1 To 10
										If game(i).game_playerID(k)<>0 Then 
											Senddata(game(i).game_playerID(k),ds_data(1),ds_data(2),ds_data(3),ds_data(4),1,1,4,k)
										EndIf
									Next
									Exit sub
								EndIf
							Next			
						next
					EndIf
				EndIf
			EndIf	
	
			If dt_data(2)=3 Then
				If dt_data(3)=1 Then
					If dt_data(4)=1 Then 
						For i As Integer = 1 To UBound(game)
							For j As Integer = 1 To 10
								If game(i).game_playerID(j)=V_FromPlayerID Then 'hsc
									'Print ds_data(4)
									
									If game(i).hsc.new_score(Val(ds_data(4)))=0 Then Exit sub 
									'Print "a"
									game(i).hsc.edit_score(Val(ds_data(2)),ds_data(1),Val(ds_data(4)),game(i).hsc.new_score(Val(ds_data(4))))
									'Print "b"
										For hsc_i As Integer = 1 To 10
											If game(i).player_ID(hsc_i)<>0 Then 
												For hsc_j As Integer = 1 To 10
													Senddata(game(i).player_ID(hsc_i),game(i).hsc.player_name(hsc_j),Str(game(i).hsc.score(hsc_j)),"",Str(game(i).hsc.game_time(hsc_j)),4,3,1,hsc_j)
												Next											
											EndIf
											
										Next
									'Print "c"
									
									
									Exit sub
								EndIf
							Next			
						Next		
					EndIf
				EndIf
			EndIf
		
		EndIf
		
		If dt_data(1)=2 Then 'client
			If dt_data(2)=1 Then
				If dt_data(3)=1 Then
					If dt_data(4)=0 Then
	
						For gi As Integer = 1 To UBound(game)
							If game(gi).enable=0 then
								For i As Integer = 1 To 10
									If game(gi).player(i)=0 Then
										For j As Integer = 1 To UBound(player)
											If player(j).id=V_FromPlayerID Then
													game(gi).set_ready=0
												For l As Integer = 1 To 10											
													game(gi).player(l)=0
													game(gi).player_ready(l)=0
													game(gi).game_playerID(l)=0
													game(gi).game_player_ready(l)=0
													game(gi).player_ID(l)=0
	 												game(gi).hsc.score(l)=0
													game(gi).hsc.game_time(l)=0
													game(gi).hsc.player_name(l)=""
												Next
												game(gi).player(i)=j
												game(gi).player_id(i)=V_FromPlayerID
												game(gi).title=ds_data(2)
												Senddata(V_FromPlayerID,ds_data(1),game(gi).title,"","",2,1,1,gi)
												game(gi).enable=1
												'Print "Game"+Str(gi)+" created with player:"+Str(i)
												Exit sub
											EndIf
										Next
				
									EndIf
								Next
							End If
						next
					Else	
						For i As Integer = 1 To 10
							If game(dt_data(4)).player(i)=0 Then
								For j As Integer = 1 To UBound(player)
									If player(j).id=V_FromPlayerID Then
										game(dt_data(4)).player(i)=j
										game(dt_data(4)).player_id(i)=V_FromPlayerID
										Senddata(V_FromPlayerID,ds_data(1),"","","",2,1,1,dt_data(4))
										game(dt_data(4)).enable=1
										
										'Print "Game"+Str(dt_data(4))+" joined player:"+Str(i)
										Exit sub
									EndIf
								Next
		
							EndIf
						Next					
					EndIf
				ElseIf dt_data(3)=2 Then
					If dt_data(4)=1 Then
						For gi As Integer = 1 To UBound(game)
							If game(gi).enable=1 then
								For i As Integer = 1 To 10
									If game(gi).player(i)<>0 And game(gi).player_id(i)=V_FromPlayerID Then
										game(gi).player_ready(i)=1
										
										Exit sub
									EndIf
								Next
							End If
						Next
					ElseIf dt_data(4)=2 Then
						For gi As Integer = 1 To UBound(game)
							If game(gi).enable=1 then
								For i As Integer = 1 To 10
									If game(gi).player(i)<>0 And game(gi).player_id(i)=V_FromPlayerID Then
										game(gi).set_ready=2
										Exit sub
									EndIf
								Next
							End If
						Next
					ElseIf dt_data(4)=3 Then
						For gi As Integer = 1 To UBound(game)
							If game(gi).enable=1 then
								For i As Integer = 1 To 10
									If game(gi).player(i)<>0 And game(gi).player_id(i)=V_FromPlayerID Then
										If ds_data(2)<>"" Then game(gi).max_len=Val(ds_data(2))
					
										
										Exit sub
									EndIf
								Next
							End If
						Next
					ElseIf dt_data(4)=4 Then
						For gi As Integer = 1 To UBound(game)
							If game(gi).enable=1 then
								For i As Integer = 1 To 10
									If game(gi).player(i)<>0 And game(gi).player_id(i)=V_FromPlayerID Then
										If ds_data(2)<>"" Then game(gi).daytime=Val(ds_data(2))
					
										
										Exit sub
									EndIf
								Next
							End If
						Next	
					EndIf
				EndIf
			EndIf
		EndIf

	loop

End Sub
Dim As Integer ServerPort=9850
If Command(1)<>"" Then
	ServerPort=Val(Command(1))
EndIf

server_Log("Initial server")
RV = TSNEPlay_CreateServer(UBound(player), ServerPort, "server", "", 0, @TSNEPlay_Player_Connected, @TSNEPlay_Player_Disconnected, @TSNEPlay_Message,0, @TSNEPlay_Data)
server_Log("Server online")

Do
	For p_i As Integer = 1 To UBound(player)
		If player(P_i).online=1 Then
			'Senddata(0,"users",player(p_i).nickname,Str(player(p_i).game),"",7,1,1,p_i)
		EndIf
	Next
	For g_i As Integer = 1 To UBound(game)
		Senddata(0,"games",game(g_i).title,"","",4,1,game(g_i).enable,g_i)
		If game(g_i).enable=1 Then
			'If game(g_i).set_ready<>0 Then Print game(g_i).set_ready 
			For p_i As Integer = 1 To 10
				For p_j As Integer = 1 To 10
					If game(g_i).player(p_i)<>0 And game(g_i).player(p_j)<>0 Then
						For p_k As Integer = 1 To UBound(player)
							If player(p_k).id=game(g_i).player_id(p_j) Then
								Senddata(game(g_i).player_id(p_i),"users",player(p_k).nickname,Str(game(g_i).player_ready(p_j)),Str(game(g_i).set_ready),3,game(g_i).player_id(p_j),p_j,game(g_i).player(p_j))
								
								Senddata(game(g_i).player_id(p_i),"config",Str(game(g_i).max_len),Str(game(g_i).daytime),"",5,1,1,1)
							End if
						Next
					End If	
				Next
			Next
		EndIf
	Next
	Sleep 1000,1
Loop

