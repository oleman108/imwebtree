#tag WebPage
Begin WebContainer imWebTreeNode
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   26
   HelpTag         =   ""
   HorizontalCenter=   0
   Index           =   -2147483648
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   True
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
   Begin WebLabel lblText
      Cursor          =   1
      Enabled         =   True
      HasFocusRing    =   True
      Height          =   22
      HelpTag         =   ""
      HorizontalCenter=   0
      Index           =   -2147483648
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      Style           =   "0"
      TabOrder        =   0
      Text            =   "."
      TextAlign       =   0
      Top             =   2
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
      _VerticalPercent=   0.0
   End
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub MouseDown(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  ' Dim msg As String = _
		  ' "id = " + Str(Self.RowTag.id) + EndOfLine + _
		  ' "parent_id = " + Str(Self.RowTag.parent_id) + EndOfLine + _
		  ' "lang_id = " + Str(Self.RowTag.lang_id) + EndOfLine + _
		  ' "keyword = " + Self.RowTag.keyword + EndOfLine + _
		  ' "depth = " + Str(Self.RowTag.depth) 
		  ' MsgBox(msg)
		  
		  
		  Dim prevSelect As Integer = Tree.LastSelectIdx
		  
		  Me.IsSelected=True
		  Me.Style=RowSelected
		  
		  If prevSelect > -1 Then
		    imWebTreeNode(Tree.Rows(prevSelect)).IsSelected = False
		    If prevSelect Mod 2=0 Then
		      imWebTreeNode(Tree.Rows(prevSelect)).Style = RowEven
		    Else
		      imWebTreeNode(Tree.Rows(prevSelect)).Style = RowOdd
		    End If
		  End If
		  
		  Tree.LastSelectIdx = Tree.Rows.IndexOf(Me)
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub DrawNode(treenode As imTreeNode, treeContainer As imWebTree, j As Integer)
		  '******************************************************************
		  ' Last change: 31 Mar 2017
		  ' Author : Oliver Osswald
		  ' Purpose: Appends a node
		  '******************************************************************
		  
		  Me.RowTag = treenode
		  Tree = treeContainer
		  Dim indent As Integer = 20
		  Dim firstIndent As Integer = 10
		  
		  Dim l As Integer = ((treenode.depth-1) * indent) + firstIndent
		  Me.lblText.Left = l
		  Me.lblText.Width = Tree.Width - l
		  
		  Dim t As Integer = Tree.LastY
		  Dim w As Integer = Tree.Width
		  Dim h As Integer = Tree.DefaultRowHeight
		  
		  Me.Height = h
		  Me.Width  = w
		  
		  If j Mod 2=0 Then
		    Me.Style = RowEven
		  Else
		    Me.Style = RowOdd
		  End If
		  
		  
		  Dim collapse As String = "‣︎"
		  Dim nocollapse As String = "▾"
		  
		  If treenode.parent_id = 0 Then
		    Me.lblText.Text = nocollapse + " " + treenode.keyword.Uppercase
		  Else
		    Me.lblText.Text = collapse + " " + treenode.keyword
		  End If
		  
		  Me.EmbedWithin(Tree,0,t,w-firstIndent-5,h)
		  Tree.LastY = Tree.LastY + h
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		HasChildren As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		IsCollapsed As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		IsSelected As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		RowTag As imTreeNode
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Tree As imWebTree
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
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasChildren"
		Group="Behavior"
		InitialValue="False"
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
		Name="IsCollapsed"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="IsSelected"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
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
