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

C_OBJECT:C1216($vo_formData)

C_TIME:C306(vh_time_at;vh_time_interval;vh_time_interval_from;vh_time_interval_to;\
vh_next_launch;vh_last_launch;vh_last_completed)
C_DATE:C307(vd_next_launch;vd_last_launch;vd_last_completed)

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

DIALOG:C40("SCHEDULE_MANAGER";$vo_formData)
