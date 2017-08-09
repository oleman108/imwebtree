#tag Module
Protected Module im
	#tag Method, Flags = &h0
		Function FindFile(name as string) As FolderItem
		  // Look for file in parent folders from executable on
		  
		  Dim parent As FolderItem = app.ExecutableFile.Parent
		  
		  While parent<>Nil
		    
		    Dim file As FolderItem = parent.Child(name)
		    
		    If file<>Nil And file.Exists Then
		      Return file
		    End If
		    
		    parent = parent.Parent
		  Wend
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub logEvent(msg As String)
		  // Write to system log (event log on Windows)
		  // only, if we have received a message to log
		  
		  If msg <> "" Then
		    System.Log(System.LogLevelNotice,"imWebTree : " + msg)
		  End If
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
