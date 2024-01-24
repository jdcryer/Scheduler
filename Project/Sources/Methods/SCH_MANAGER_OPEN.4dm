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

C_OBJECT:C1216($vo_formData; $vo_task)
C_TIME:C306(vh_time_at; vh_time_interval; vh_time_interval_from; vh_time_interval_to; \
vh_next_launch; vh_last_launch; vh_last_completed)
C_DATE:C307(vd_next_launch; vd_last_launch; vd_last_completed)
C_TEXT:C284($m_submenu; $vt_label; $vt_method)

$vo_formData:=New object:C1471
$vo_formData.es_schedules:=ds:C1482["schedule"].all().copy()  //.copy to make selection alterable

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

$vo_formData.pendingChanges:=False:C215
$vo_formData.selectedSchedule:=Null:C1517
$vo_formData.lastSelectedScheduleIndex:=0

$vo_formData.tasksMenu:=SCH_Create_Task_Menu(Storage:C1525.tasks)

DIALOG:C40("SCHEDULE_MANAGER"; $vo_formData)
