//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 24/01/24, 11:28:02
// ----------------------------------------------------
// Method: SCH_Find_Task
// Description
// 
//
// Parameters
// ----------------------------------------------------

#DECLARE($vt_method : Text; $vc_toSearch : Collection)->$vo_response : Object

$vo_response:=New object:C1471
$vo_response.found:=False:C215
$vo_response.task:=New object:C1471

If (Count parameters:C259=1)
	$vc_toSearch:=Storage:C1525.tasks
End if 

$vl_index:=$vc_toSearch.findIndex("UTIL_Find_Collection"; "method"; $vt_method)
If ($vl_index>=0)
	
	$vo_response.found:=True:C214
	$vo_response.task:=OB Copy:C1225($vc_toSearch[$vl_index])
	
Else 
	
	For each ($vo_task; $vc_toSearch)
		
		If (Not:C34($vo_response.found))
			
			If (OB Is defined:C1231($vo_task; "children"))
				
				$vo_response:=SCH_Find_Task($vt_method; $vo_task.children)
				
			End if 
			
		End if 
		
	End for each 
	
	
End if 
