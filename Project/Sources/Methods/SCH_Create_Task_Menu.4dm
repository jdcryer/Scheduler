//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 19/05/21, 16:48:06
  // ----------------------------------------------------
  // Method: SCH_Create_Task_Menu
  // Description
  // Creates menu for given collection of tasks
  //
  // Parameters
  // $0 - Text       - Menu
  // $1 - Collection - Tasks
  // ----------------------------------------------------

C_TEXT:C284($0;$m_menu)
C_COLLECTION:C1488($1;$vc_tasks)

C_OBJECT:C1216($vo_task)
C_TEXT:C284($m_submenu;$vt_label;$vt_method)

$m_menu:=Create menu:C408
$vc_tasks:=$1

For each ($vo_task;$vc_tasks)
	$vt_label:=""
	$vt_method:=""
	$m_submenu:=Create menu:C408
	
	If (OB Is defined:C1231($vo_task;"children"))
		If ($vo_task.children.length>0)
			$m_submenu:=SCH_Create_Task_Menu ($vo_task.children)
		End if 
	End if 
	
	If (OB Is defined:C1231($vo_task;"label"))
		$vt_label:=$vo_task.label
	End if 
	If (OB Is defined:C1231($vo_task;"method"))
		If ($vt_label="")
			$vt_label:=$vo_task.method
		End if 
		$vt_method:=$vo_task.method
	End if 
	
	If ($vt_label="")
		$vt_label:="LABEL MISSING"
	End if 
	
	If (Count menu items:C405($m_submenu)>0)
		APPEND MENU ITEM:C411($m_menu;$vt_label;$m_submenu)
	Else 
		APPEND MENU ITEM:C411($m_menu;$vt_label)
		SET MENU ITEM PARAMETER:C1004($m_menu;-1;$vt_method)
	End if 
End for each 

$0:=$m_menu
