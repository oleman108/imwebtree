# imWebTree
Version: Development 2017.1.1
 
## A sample project for Xojo Web Edition. 
It displays a TreeView from hierarchical data, pulled from a self-referenced SQLite database table:

![<Display Name>](<https://www.osswald.com/github/imwebtree.png>)
 
## How to use
1. Create a new Web project in Xojo
2. Copy the **webtreeview.sqlite** database file next to your new project 
3. Copy/Paste the WebTree folder from the sample project **imWebTree.xojo_project** to your new project
4. Copy/Paste the **im** module from the sample project to your new project
5. From the WebTree folder, drag & drop a ```imWebTree``` onto WebPage1
file
6. Add an Shown Event Handler to your new imWebTree1 object and add the command ``` Me.Load_Tree```
7. In the Session object, add a Public property of type SQLiteDatabase with the name ```imDatabase```
8. Insert a new "Copy Files" Build Step for your current platform. Name it CopyDatabase and drag the database file into the list. For its Behavior choose: 

    Applies to : ```Both```   
    Destination: ```App Parent Folder ```
 
9. Add an ```Open``` Event Handler to the Session object with the following code:

		Me.imDatabase = New SQLiteDatabase
		
		// open db-file in same folder as app
		Me.imDatabase.DatabaseFile = GetFolderItem("webtreeview.sqlite")

		If Not Me.imDatabase.Connect Then
  			Me.imDatabase = Nil
  			Me.MsgBox "Could not connect to database"
		End If
10. Run your project in Xojo

## Remarks
* From the Recordset we fill an Array of type imTreeNode in the right order of appearence of the nodes
* From the array we call the DrawNode method for each imWebTreeNode and store the node in the Rows() Array of the imWebTree object
* Each imWebTreeNode has a RowTag property of type imTreeNode where all its database values are stored 
* See imWebTreeNode.DrawNode for details on how each row is drawn
