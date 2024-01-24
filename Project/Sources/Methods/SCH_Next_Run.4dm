//%attributes = {}
// ----------------------------------------------------
// User name (OS): Dougie
// Date and time: 03/05/21, 10:49:18
// ----------------------------------------------------
// Method: SCH_Next_Run
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $2; $vt_nextLaunch)
C_OBJECT:C1216($1; $vo_schedule; $vo_detail)
C_DATE:C307($vd_lastDate; $vd_nextDate)
C_TIME:C306($vh_lastTime; $vh_nextTime)

$vo_schedule:=$1
$vt_nextLaunch:=$2  //default
$vo_detail:=$vo_schedule.detail
$vd_lastDate:=Date:C102($vo_schedule.lastCompleted)
$vh_lastTime:=Time:C179($vo_schedule.lastCompleted)
Case of 
	: ($vo_detail.frequency.period="daily")
		If ($vo_detail.frequency.timing="time")  //Just push to the next day
			$vt_nextLaunch:=String:C10(Add to date:C393($vd_lastDate; 0; 0; 1); ISO date:K1:8; Time:C179($vo_detail.frequency.specifiedTime))
		Else   //periodic
			$vh_nextTime:=($vh_lastTime+Time:C179($vo_detail.frequency.interval))
			Case of 
				: ($vh_nextTime>Time:C179($vo_detail.frequency.endTime))
					$vh_nextTime:=Time:C179($vo_detail.frequency.startTime)
					$vt_nextLaunch:=String:C10(Add to date:C393($vd_lastDate; 0; 0; $vo_detail.frequency.every); ISO date:K1:8; $vh_nextTime)
				: ($vh_nextTime>?24:00:00?)
					$vh_nextTime:=($vh_nextTime-?24:00:00?)
					If ($vh_nextTime<Time:C179($vo_detail.frequency.startTime))
						$vh_nextTime:=Time:C179($vo_detail.frequency.startTime)
					End if 
					$vt_nextLaunch:=String:C10(Add to date:C393($vd_lastDate; 0; 0; $vo_detail.frequency.every); ISO date:K1:8; $vh_nextTime)
				Else 
					$vt_nextLaunch:=String:C10($vd_lastDate; ISO date:K1:8; $vh_nextTime)
			End case 
		End if 
		
	: ($vo_detail.frequency.period="weekly")
		$vc_days:=New collection:C1472
		$vc_days:=$vo_detail.frequency.days
		ARRAY LONGINT:C221($al_days; 0)
		COLLECTION TO ARRAY:C1562($vc_days.orderBy(); $al_days)
		$vl_day:=Day number:C114($vd_lastDate)
		$vl_fia:=Find in array:C230($al_days; $vl_day)
		If ($vo_detail.frequency.timing="time")  //Just push to the 
			If ($vl_fia>0)
				If ($vl_fia>=Size of array:C274($al_days))  //Add weeks and remove days
					$vd_date:=Add to date:C393($vd_lastDate; 0; 0; (($vo_detail.frequency.every*7)-($al_days{$vl_fia}-$al_days{1})))
				Else 
					$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($al_days{$vl_fia+1}-$al_days{$vl_fia}))  //Just add days
				End if 
			Else   //No days set so add weeks to the current date
				$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($vo_detail.frequency.every*7))
			End if   //END check that there are days set
			$vt_nextLaunch:=String:C10($vd_date; ISO date:K1:8; Time:C179($vo_detail.frequency.specifiedTime))  //If timing is time use specifiedTime
		Else   //periodic
			If ($vl_fia>0)
				$vh_nextTime:=($vh_lastTime+Time:C179($vo_detail.frequency.interval))
				Case of 
					: ($vh_nextTime>Time:C179($vo_detail.frequency.endTime))
						$vh_nextTime:=Time:C179($vo_detail.frequency.startTime)
						If ($vl_fia>=Size of array:C274($al_days))  //Add weeks and remove days
							$vd_date:=Add to date:C393($vd_lastDate; 0; 0; (($vo_detail.frequency.every*7)-($al_days{$vl_fia}-$al_days{1})))
						Else 
							$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($al_days{$vl_fia+1}-$al_days{$vl_fia}))  //Just add days
						End if 
						
					: ($vh_nextTime>?24:00:00?)
						$vh_nextTime:=($vh_nextTime-?24:00:00?)
						If ($vh_nextTime<Time:C179($vo_detail.frequency.startTime))
							$vh_nextTime:=Time:C179($vo_detail.frequency.startTime)
						End if 
						$vd_date:=Add to date:C393($vd_lastDate; 0; 0; $vo_detail.frequency.every*7)
					Else 
						$vd_date:=$vd_lastDate
				End case 
				
			Else   //No days set so add weeks to the current date
				$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($vo_detail.frequency.every*7))
			End if   //END check that there are days set
			
			$vt_nextLaunch:=String:C10($vd_date; ISO date:K1:8; $vh_nextTime)
			
		End if 
		
	: ($vo_detail.frequency.period="monthly")
		Case of 
			: (OB Is defined:C1231($vo_detail.frequency; "days"))
				$vc_days:=New collection:C1472
				$vc_days:=$vo_detail.frequency.days
				ARRAY LONGINT:C221($al_days; 0)
				COLLECTION TO ARRAY:C1562($vc_days.orderBy(); $al_days)
				$vl_day:=Day number:C114($vd_lastDate)
				$vl_fia:=Find in array:C230($al_days; $vl_day)
				
			: (OB Is defined:C1231($vo_detail.frequency; "onDay"))
				
			Else 
				//Error.  This should not happen if data was written correctly.
		End case 
		
		If ($vo_detail.frequency.timing="time")  //Just push to the 
			If ($vl_fia>0)
				If ($vl_fia>=Size of array:C274($al_days))  //Add weeks and remove days
					$vd_date:=Add to date:C393($vd_lastDate; 0; 0; (($vo_detail.frequency.every*7)-($al_days{$vl_fia}-$al_days{1})))
				Else 
					$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($al_days{$vl_fia+1}-$al_days{$vl_fia}))  //Just add days
				End if 
			Else   //No days set so add weeks to the current date
				$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($vo_detail.frequency.every*7))
			End if   //END check that there are days set
			$vt_nextLaunch:=String:C10($vd_date; ISO date:K1:8; Time:C179($vo_detail.frequency.specifiedTime))
		Else   //periodic
			If ($vl_fia>0)
				$vh_nextTime:=($vh_lastTime+Time:C179($vo_detail.frequency.interval))
				Case of 
					: ($vh_nextTime>Time:C179($vo_detail.frequency.endTime))
						$vh_nextTime:=Time:C179($vo_detail.frequency.startTime)
						If ($vl_fia>=Size of array:C274($al_days))  //Add weeks and remove days
							$vd_date:=Add to date:C393($vd_lastDate; 0; 0; (($vo_detail.frequency.every*7)-($al_days{$vl_fia}-$al_days{1})))
						Else 
							$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($al_days{$vl_fia+1}-$al_days{$vl_fia}))  //Just add days
						End if 
						
					: ($vh_nextTime>?24:00:00?)
						$vh_nextTime:=($vh_nextTime-?24:00:00?)
						If ($vh_nextTime<Time:C179($vo_detail.frequency.startTime))
							$vh_nextTime:=Time:C179($vo_detail.frequency.startTime)
						End if 
						$vd_date:=Add to date:C393($vd_lastDate; 0; 0; $vo_detail.frequency.every*7)
					Else 
						$vd_date:=$vd_lastDate
				End case 
				
			Else   //No days set so add weeks to the current date
				$vd_date:=Add to date:C393($vd_lastDate; 0; 0; ($vo_detail.frequency.every*7))
			End if   //END check that there are days set
			
			$vt_nextLaunch:=String:C10($vd_date; ISO date:K1:8; $vh_nextTime)
			
		End if 
		
End case 
$0:=$vt_nextLaunch


