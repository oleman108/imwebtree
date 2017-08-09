#tag WebPage
Begin WebContainer imWebTree
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   400
   HelpTag         =   ""
   HorizontalCenter=   0
   Index           =   -2147483648
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   Style           =   "None"
   TabOrder        =   0
   Top             =   0
   VerticalCenter  =   0
   Visible         =   True
   Width           =   300
   ZIndex          =   1
   _DeclareLineRendered=   False
   _HorizontalPercent=   0.0
   _IsEmbedded     =   False
   _Locked         =   False
   _NeedsRendering =   True
   _OfficialControl=   False
   _OpenEventFired =   False
   _ShownEventFired=   False
   _VerticalPercent=   0.0
End
#tag EndWebPage

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Load_Tree()
		  '******************************************************************
		  ' Last change: 31 Mar 2017
		  ' Author : Oliver Osswald
		  ' Purpose: Load hierarchical list from database into webtree object 
		  '******************************************************************
		  
		  // Stop here if database is not connected
		  If Session.imDatabase = Nil Then Return
		  
		  // Clear any existing records from tree
		  RemoveAll
		  
		  Dim rs As RecordSet
		  Dim Tsql As String
		  Dim imNodes() As imTreeNode
		  
		  
		  Tsql = "SELECT id, parent_id, keyword, depth, lang_id FROM keywords WHERE lang_id = 1 ORDER BY depth, parent_id, keyword ASC"
		  rs = Session.imDatabase.SQLSelect(Tsql)
		  
		  If Session.imDatabase.Error Then
		    MsgBox Session.imDatabase.ErrorMessage
		    Return
		  End If
		  
		  // Create an Array of keywords, with all childnodes 
		  // correctly sorted under the parent nodes
		  
		  While Not rs.EOF
		    Dim n As New imTreeNode
		    n.id            = rs.Field("id").IntegerValue
		    n.parent_id     = rs.Field("parent_id").IntegerValue
		    n.keyword       = DefineEncoding(rs.Field("keyword").StringValue,Encodings.UTF8)
		    n.depth         = rs.Field("depth").IntegerValue
		    n.lang_id       = rs.Field("lang_id").IntegerValue
		    
		    
		    If n.parent_id = 0 Then
		      // Append Rootnodes
		      imNodes.Append n
		    Else
		      // Exit-flag for...next
		      Dim IsNodeAppended As Boolean = False
		      
		      // Find last parentnode and insert a new node behind it
		      Dim lastindex As Integer = imNodes.Ubound
		      
		      For i As Integer = 0 To lastindex
		        If imNodes(i).id = n.parent_id Then
		          
		          If i = lastindex Then
		            // if node is last in Array, then append
		            imNodes.Append n
		            IsNodeAppended=True
		          Else
		            
		            // Now search the last childnode under the current parent
		            Dim m As Integer = i+1
		            While m <= lastindex
		              
		              // Search for the first node whose parent_id is different
		              If imNodes(m).parent_id = n.parent_id Then
		                If m = lastindex Then
		                  imNodes.Append n
		                  IsNodeAppended=True
		                  Exit
		                Else
		                  m = m + 1 // go check next parent_id
		                End If
		              Else
		                // otherwise insert new node at position
		                // of first found node with different parent_id
		                imNodes.Insert(m,n)
		                IsNodeAppended=True
		                Exit
		              End If
		            Wend  // m <= lastindex
		            If IsNodeAppended Then Exit
		            
		          End If // i = lastindex
		        End If  // imNodes(i).id = n.parent_id
		      Next  // i As Integer = 0 To lastindex
		      
		    End If
		    rs.MoveNext
		  Wend  // Not rs.EOF
		  
		  // Free up memory
		  rs=Nil
		  
		  ReDim Rows(-1)
		  For j As Integer = 0 To imNodes.Ubound
		    Dim webTree As New imWebTreeNode
		    webTree.DrawNode(imNodes(j),Me,j)
		    Rows.Append webTree
		  Next
		  
		  // Uncomment if you like first record to be selected
		  ' If Rows.Ubound > -1 Then
		  ' 
		  ' // Select First Row
		  ' Dim prevSelect As Integer = Me.LastSelectIdx
		  ' Dim webNode As imWebTreeNode = imWebTreeNode(Rows(0))
		  ' webNode.IsSelected=True
		  ' webNode.Style=RowSelected
		  ' 
		  ' If prevSelect > -1 Then
		  ' imWebTreeNode(Me.Rows(prevSelect)).IsSelected = False
		  ' If prevSelect Mod 2=0 Then
		  ' imWebTreeNode(Me.Rows(prevSelect)).Style = RowEven
		  ' Else
		  ' imWebTreeNode(Me.Rows(prevSelect)).Style = RowOdd
		  ' End If
		  ' End If
		  ' 
		  ' Me.LastSelectIdx = 0
		  ' End If
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveAll()
		  '******************************************************************
		  ' Last change: 31 Mar 2017
		  ' Author : Oliver Osswald
		  ' Purpose: Clear WebTreeView, Remove all Rows and free memory
		  '******************************************************************
		  
		  // Close all rows in this WebTreeView
		  Dim u As Integer = Ubound(Rows) 
		  For i As Integer = u DownTo 0
		    Rows(i).Close
		  Next
		  Redim Rows(-1)
		  
		  // Reset Last Vertical Position for new rows in the Webtree to 0
		  LastY = 0
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		DefaultRowHeight As Integer = 26
	#tag EndProperty

	#tag Property, Flags = &h0
		LastSelectIdx As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		LastY As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		Rows() As WebControl
	#tag EndProperty


#tag EndWindowCode

#tag ViewBehavior
	#tag ViewProperty
		Name="Cursor"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Standard Pointer"
			"2 - Finger Pointer"
			"3 - IBeam"
			"4 - Wait"
			"5 - Help"
			"6 - Arrow All Directions"
			"7 - Arrow North"
			"8 - Arrow South"
			"9 - Arrow East"
			"10 - Arrow West"
			"11 - Arrow Northeast"
			"12 - Arrow Northwest"
			"13 - Arrow Southeast"
			"14 - Arrow Southwest"
			"15 - Splitter East West"
			"16 - Splitter North South"
			"17 - Progress"
			"18 - No Drop"
			"19 - Not Allowed"
			"20 - Vertical IBeam"
			"21 - Crosshair"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultRowHeight"
		Group="Behavior"
		InitialValue="26"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HorizontalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Visible=true
		Group="ID"
		InitialValue="-2147483648"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LastSelectIdx"
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LastY"
		Group="Behavior"
		InitialValue="0"
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
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScrollbarsVisible"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Always"
			"2 - Never"
			"3 - Vertical"
			"4 - Horizontal"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabOrder"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="VerticalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ZIndex"
		Group="Behavior"
		InitialValue="1"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_DeclareLineRendered"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_HorizontalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_IsEmbedded"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_Locked"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_NeedsRendering"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OfficialControl"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OpenEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ShownEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_VerticalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
#tag EndViewBehavior
