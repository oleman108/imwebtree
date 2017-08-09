#tag Class
Protected Class App
Inherits WebApplication
	#tag Event
		Sub Open(args() as String)
		  '******************************************************************
		  ' Last change: 9 Aug 2017
		  ' Author : Oliver Osswald
		  ' Purpose: Run imWebTree as a service and allow it to be included
		  ' in an iFrame. AutoQuit only if the program file has been deleted
		  '******************************************************************
		  
		  Me.AutoQuit=False
		  
		  #If Not DebugBuild Then // Do not try to daemonize a debug build
		    Call Me.Daemonize
		  #EndIf
		  
		  // Allow your app to show up in any iframe
		  Self.Security.FrameEmbedding = WebAppSecurityOptions.FrameOptions.Allow
		  
		End Sub
	#tag EndEvent


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
