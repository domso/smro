Dim Shared As Integer thisVersion=3
#Include "test.bas"
ScreenRes 400,250,32,,16
Color 0,&Hff00ff  
Cls
Dim Shared As Any Ptr logo
logo=ImageCreate(400,200)
For i As Integer = 0 To 399
	For j As Integer = 0 To 199
		Line logo,(i,j)-(i,j),local_logo_img_src(i,j)
	Next
Next

'BLoad "filepatcher_logo.bmp",logo
Put (0,0),logo,Trans



Type file_type
	As Integer version
	As String pfad,titel,url
End Type
Dim Shared As file_type file(0 To 1000)
Dim Shared As file_type file2do(0 To 1000)
Dim Shared As Integer file_count,file_max_count,file_finish

Sub msg(msg_var as string)
	Dim As Integer f=freefile
	Open "patchlog.txt" For Append As #f
			write #f,Str(date)+"||"+Str(time)+" :> "+msg_var
	Close #f
	
	Cls
	Put (0,0),logo,Trans
	Line (20,200)-(380,240),RGB(78,132,222),bf
	Line (21,201)-(379,239),RGB(255,255,255),b

	If file_max_count>0 Then
		Line (23,203)-(377,203+10),rgb(255,0,0),bf
		line (23,203)-(23+((354)*(((file_count/file_max_count)))),203+10),rgb(0,255,0),bf
		Draw String (190,205),str(Cast(Integer,((file_count/file_max_count)*100)))+"%"
	End if
	Draw string (23,203+20),msg_var,rgb(255,255,255)
End Sub

Sub check4updates
	'Download version.txt
	Dim As Integer f=FreeFile,g=FreeFile
	Dim As String input_string
	Dim As Integer temp_version
	Dim As Integer temp_index
	Dim As String temp_pfad
	Dim As String temp_url
	Dim As String temp_titel
	
	Open "version_local.txt" For Input As #f
	
		Do
			Line Input #f,Input_string
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_index=Val(Mid(input_string,1,i-1))
					Input_string=Mid(input_string,i+1)
					Exit for
				EndIf
			Next
			
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_titel=(Mid(input_string,1,i-1))
					if mid(temp_titel,len(temp_titel)-3)=".exe" then temp_titel=mid(temp_titel,1,len(temp_titel)-4)
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next
			
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_version=Val(Mid(input_string,1,i-1))
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next
			
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_pfad=(Mid(input_string,1,i-1))
					if mid(temp_pfad,len(temp_pfad)-3)=".exe" then temp_pfad=mid(temp_pfad,1,len(temp_pfad)-4)
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next
			
			for i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_url=(Mid(input_string,1,i-1))
					
					if mid(temp_url,len(temp_url)-3)=".exe" then temp_url=mid(temp_url,1,len(temp_url)-4)
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next

			file(temp_index).titel=temp_titel
			file(temp_index).version=temp_version
			file(temp_index).pfad=temp_pfad
			file(temp_index).url=temp_url
		
		Loop Until Eof(f)
	Close #f

	Open "version_todo.txt" For Input As #g
		Do
			Line Input #g,Input_string
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_index=Val(Mid(input_string,1,i-1))
					Input_string=Mid(input_string,i+1)
					Exit for
				EndIf
			Next
			
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_titel=(Mid(input_string,1,i-1))
					if mid(temp_titel,len(temp_titel)-3)=".exe" then temp_titel=mid(temp_titel,1,len(temp_titel)-4)
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next
			
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_version=Val(Mid(input_string,1,i-1))
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next
			
			For i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_pfad=(Mid(input_string,1,i-1))
					if mid(temp_pfad,len(temp_pfad)-3)=".exe" then temp_pfad=mid(temp_pfad,1,len(temp_pfad)-4)
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next
			
			for i As Integer = 1 To Len(input_string)
				If Mid(Input_string,i,1)=" " Then
					temp_url=(Mid(input_string,1,i-1))
					if mid(temp_url,len(temp_url)-3)=".exe" then temp_url=mid(temp_url,1,len(temp_url)-4)
					Input_string=Mid(input_string,i+1)
					Exit For
				EndIf
			Next

			'If temp_index=0 Then Exit Do
			file2do(temp_index).titel=temp_titel
			file2do(temp_index).version=temp_version
			file2do(temp_index).pfad=temp_pfad
			file2do(temp_index).url=temp_url

		Loop Until Eof(g)

	Close #g
	
End Sub

Sub updateVersion

	Dim As Integer f=FreeFile

	Open "version_local.txt" For output As #f
		For i As Integer = 1 To UBound(file)
			If file(i).titel<>"" Then
				print #f,Str(i)+" "+file(i).titel+" "+Str(file(i).version)+" "+file(i).pfad+" "+file(i).url+" "
			EndIf
		Next

	Close #f

End Sub

Dim as integer wgetReturn
Dim as string tmpWgetFile,tmpOutput

		msg("Get version")
		shell("rm version_todo.txt")
		wgetReturn=shell("wget https://raw.github.com/domso/smro/master/version_todo.txt")
		do
		loop until wgetReturn=0

msg("Check for updates...")
check4updates


For i As Integer = 1 To UBound(file)
	If file2do(i).version<>file(i).version Then
		file_max_count+=1
	EndIf
Next

msg("Found "+str(file_max_count)+" updates!")


For i As Integer = 1 To UBound(file)
	If file2do(i).version<>file(i).version And file2do(i).titel<>"" Then	
		For j As Integer = 0 To Len(file2do(i).pfad)-1
			If Mid(file2do(i).pfad,Len(file2do(i).pfad)-j,1)="/" Then
				MkDir (Mid(file2do(i).pfad,1,Len(file2do(i).pfad)-j))
				Exit for
			EndIf
		Next
		
		If file2do(i).titel<>"SnowManRun" then 
			
			msg("update "+file2do(i).titel+" from version "+Str(file(i).version)+" to "+Str(file2do(i).version))
			'lR = URLDownloadToFile(0, file2do(i).url,file2do(i).pfad, 0, 0)
			tmpOutput=file2do(i).pfad
		
			for j as integer = 0 to len(tmpOutput)
				if mid(tmpOutput,len(tmpOutput)-j,1)="/" then tmpOutput=mid(tmpOutput,1,len(tmpOutput)-j):exit for
			next
			
			if tmpOutput="" or tmpOutput=file2do(i).pfad then
				shell("rm "+file2do(i).pfad)
				tmpWgetFile="wget "+file2do(i).url
			
			else
				shell("rm "+file2do(i).pfad)
				tmpWgetFile="wget "+file2do(i).url+" -P "+tmpOutput
			end if
			wgetReturn=shell(tmpWgetFile)
			do
			loop until wgetReturn=0
			shell ("chmod u=rwx "+file2do(i).pfad)
		End if

		file_count+=1
		file(i).version=file2do(i).version
		file(i).titel=file2do(i).titel
		file(i).url=file2do(i).url
		file(i).pfad=file2do(i).pfad
		
		line (23,203)-(377,203+10),rgb(255,0,0),bf
		line (23,203)-(23+((354)*(((file_count/file_max_count)))),203+10),rgb(0,255,0),bf
		Draw String (190,205),str(Cast(Integer,((file_count/file_max_count)*100)))+"%"
		
		updateVersion
		
		If file(i).titel="SnowManRun" Then
			'Patcher update!
			If file2do(i).version<>thisVersion Then
				msg("Client update!")
				
				shell("rm "+file2do(i).pfad)
				tmpWgetFile="wget "+file2do(i).url
				wgetReturn=shell(tmpWgetFile)
				do
				loop until wgetReturn=0
				
				Shell("./bin/patcherupdater")
				End
			Else
				Shell("rm SnowManRun.1")
			End if
		EndIf
	EndIf
Next

msg("Finish")

If (file_count=file_max_count)Then run("./bin/client")
