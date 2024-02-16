//%attributes = {"shared":true}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 03/05/21, 10:47:32
// ----------------------------------------------------
// Method: SCH_RUN_MAIN
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($e_schedule; $es_schedule; $vo_task)
C_COLLECTION:C1488($vc_tasks; $vc_parameters; $vc_taskErrors; $vc_schRunning)
C_BOOLEAN:C305($vb_abort)

$vt_procHandle:="Scheduler Main"
$vl_schProcess:=Process number:C372($vt_procHandle)
If ($vl_schProcess=0)
	$vl_schProcess:=New process:C317("SCH_RUN_MAIN"; 0; $vt_procHandle; *)
Else 
	
	Use (Storage:C1525.schedule)
		Storage:C1525.schedule.state:=1
	End use 
	
	Repeat 
		$vc_schRunning:=Storage:C1525.schedule.running
		$es_schedule:=ds:C1482["schedule"].query("status == :1 && nextLaunch <= :2"; \
			1; String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))).minus(ds:C1482["schedule"].query("id in :1"; $vc_schRunning))  //Get all the active schedules that need to run.
		For each ($e_schedule; $es_schedule)  //Loop for each schedule found
			$vb_abort:=False:C215
			If (Storage:C1525.schedule.state#0)
				SCH_RUN_SCHEDULE($e_schedule.toObject())
			End if 
		End for each   //END Schedule loop
		DELAY PROCESS:C323(Current process:C322; 300)
		
	Until (Storage:C1525.schedule.state=0)
	
End if   //END create Scheduler Main process