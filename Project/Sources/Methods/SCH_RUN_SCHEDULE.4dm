//%attributes = {}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 03/05/21, 10:48:05
// ----------------------------------------------------
// Method: SCH_RUN_SCHEDULE
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1; $vo_schedule; $e_schedule; $e_task)
C_LONGINT:C283($cp; $vl_procesSize; $vl_schIndex)
C_TEXT:C284($vt_procHandle; $vt_lastLaunch)
$cp:=Count parameters:C259
$vo_schedule:=OB Copy:C1225($1)

$vt_procHandle:=$vo_schedule.name+":"+$vo_schedule.id
$vl_schProcess:=Process number:C372($vt_procHandle)
If ($vl_schProcess=0)
	Use (Storage:C1525.schedule)  //Stops the calling method from running the schedule again.
		Storage:C1525.schedule.running.push($vo_schedule.id)
	End use 
	If (OB Is defined:C1231($vo_schedule.detail; "processSize"))  //If zero then the default process size will be set by 4D
		$vl_procesSize:=$vo_schedule.detail.processSize
	End if 
	$vl_schProcess:=New process:C317("SCH_RUN_SCHEDULE"; $vl_procesSize; $vt_procHandle; $vo_schedule; *)
Else 
	
	$vc_taskErrors:=New collection:C1472
	$vt_lastLaunch:=String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))  //Put in local variable to set later.
	For each ($vo_task; $vo_schedule.detail.tasks)  //Loop for each task in the schedule.
		$vc_parameters:=New collection:C1472
		If (OB Is defined:C1231($vo_task; "parameters"))
			$vc_parameters:=$vo_task.parameters
		End if 
		EXECUTE METHOD:C1007($vo_task.method; $vo_runStatus; $vo_schedule; $vc_parameters)
		If (Not:C34($vo_runStatus.success))
			$vc_taskErrors.push(New object:C1471("method"; $e_task.method; "message"; $vo_runStatus.error))
			$vb_abort:=True:C214
		Else 
			If (OB Is defined:C1231($vo_runStatus; "result"))
				$vo_task.result:=$vo_runStatus.result
			End if 
		End if 
	End for each   //END Task Loop
	If ($vb_abort)
		$vo_schedule.errors:=$vc_taskErrors
	Else 
		$vo_schedule.lastLaunch:=$vt_lastLaunch  //Set here now so the lastLaunch can be used in the next schedule.
		$vo_schedule.lastCompleted:=String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))
		$vo_schedule.nextLaunch:=SCH_Next_Run($vo_schedule; $vo_schedule.lastCompleted)
	End if 
	$e_schedule:=ds:C1482["schedule"].get($vo_schedule.id)
	If ($e_schedule#Null:C1517)
		$e_schedule.fromObject($vo_schedule)
		$vo_status:=$e_schedule.save()
	End if 
	$vl_schIndex:=Storage:C1525.schedule.running.indexOf($vo_schedule.id)
	If ($vl_schIndex>-1)
		Use (Storage:C1525.schedule)  //Stops the calling method from running the schedule again.
			Storage:C1525.schedule.running.remove($vl_schIndex)
		End use 
	End if 
End if   //END New process check

