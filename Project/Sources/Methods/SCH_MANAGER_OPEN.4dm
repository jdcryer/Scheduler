//%attributes = {"shared":true}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 14/05/21, 14:41:06
  // ----------------------------------------------------
  // Method: SCHEDULE_MANAGER_OPEN
  // Description
  // Opens the Schedule manager interface
  //
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($vo_formData;$vo_task)
C_TIME:C306(vh_time_at;vh_time_interval;vh_time_interval_from;vh_time_interval_to;\
vh_next_launch;vh_last_launch;vh_last_completed)
C_DATE:C307(vd_next_launch;vd_last_launch;vd_last_completed)
C_TEXT:C284($m_submenu;$vt_label;$vt_method)

$vo_formData:=New object:C1471
$vo_formData.es_schedules:=ds:C1482["schedule"].all()

vh_time_at:=?00:00:00?
vh_time_interval:=?00:00:00?
vh_time_interval_from:=?00:00:00?
vh_time_interval_to:=?00:00:00?
vh_next_launch:=?00:00:00?
vh_last_launch:=?00:00:00?
vh_last_completed:=?00:00:00?

vd_next_launch:=!00-00-00!
vd_last_launch:=!00-00-00!
vd_last_completed:=!00-00-00!

$vo_formData.frequencyOn:=0
$vo_formData.frequencyOnThe:=0
$vo_formData.timingInterval:=0
$vo_formData.timingAt:=0

$vo_formData.tasksMenu:=SCH_Create_Task_Menu (Storage:C1525.tasks)

  //For each ($vo_task;Storage.sch.tasks)
  //$vt_label:=""
  //$vt_method:=""
  //$m_submenu:=Create menu

  //If (OB Is defined($vo_task;"children"))
  //If ($vo_task.children.length>0)
  //$m_submenu:=SCH_Create_Task_Menu ($vo_task.children)
  //End if 
  //End if 

  //If (OB Is defined($vo_task;"label"))
  //$vt_label:=$vo_task.label
  //End if 
  //If (OB Is defined($vo_task;"method"))
  //If ($vt_label="")
  //$vt_label:=$vo_task.method
  //End if 
  //$vt_method:=$vo_task.method
  //End if 

  //If ($vt_label="")
  //$vt_label:="LABEL MISSING"
  //End if 

  //If (Count menu items($m_submenu)>0)
  //APPEND MENU ITEM($vo_formData.tasksMenu;$vt_label;$m_submenu)
  //Else 
  //APPEND MENU ITEM($vo_formData.tasksMenu;$vt_label)
  //SET MENU ITEM PARAMETER($vo_formData.tasksMenu;-1;$vt_method)
  //End if 
  //End for each 

DIALOG:C40("SCHEDULE_MANAGER";$vo_formData)
