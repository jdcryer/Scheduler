//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 14/05/21, 12:14:04
  // ----------------------------------------------------
  // Method: SCHEDULE_MANAGER_FREQ_CHANGE
  // Description
  // Sets up form elements according to selected Freqency
  // Called when freqency changes, schedule selected, new schedule created
  // Parameters
  // ----------------------------------------------------

  //freq_monthly_
  //freq_weekly_
  //freq_daily_

C_LONGINT:C283($vl_fia;$vl_day)
C_TEXT:C284($vt_button)

OBJECT SET VISIBLE:C603(*;"freq_monthly_@";False:C215)
OBJECT SET VISIBLE:C603(*;"freq_weekly_@";False:C215)
OBJECT SET VISIBLE:C603(*;"freq_daily_@";False:C215)

OBJECT SET RGB COLORS:C628(*;"freq_weekly_button_@";"#000000")
OBJECT SET RGB COLORS:C628(*;"freq_monthly_button_@";"#000000")

Case of 
	: (at_frequency=1)  // Daily
		OBJECT SET VISIBLE:C603(*;"freq_daily_@";True:C214)
		
	: (at_frequency=2)  // Weekly
		OBJECT SET VISIBLE:C603(*;"freq_weekly_@";True:C214)
		
		If (Form:C1466.selectedSchedule#Null:C1517)
			  //Highlight buttons according to frequency.days
			For each ($vl_day;Form:C1466.selectedSchedule.detail.frequency.days)
				$vt_button:="freq_weekly_button_"+String:C10($vl_day)
				OBJECT SET RGB COLORS:C628(*;$vt_button;"#0000FF";"#6DC9C5")
			End for each 
		End if 
	: (at_frequency=3)  // Monthly
		OBJECT SET VISIBLE:C603(*;"freq_monthly_@";True:C214)
		
		If (Form:C1466.selectedSchedule#Null:C1517)
			  //Highlight buttons according to frequency.days
			For each ($vl_day;Form:C1466.selectedSchedule.detail.frequency.days)
				$vt_button:="freq_monthly_button_"+String:C10($vl_day)
				OBJECT SET RGB COLORS:C628(*;$vt_button;"#0000FF";"#6DC9C5")
			End for each 
			
			  //Select relevant radio button
			Form:C1466.frequencyOn:=0
			Form:C1466.frequencyOnThe:=0
			If (Form:C1466.selectedSchedule.detail.frequency.monthChoice="onDay")
				Form:C1466.frequencyOnThe:=1
			Else 
				Form:C1466.frequencyOn:=1
			End if 
			
			OBJECT SET ENABLED:C1123(*;"freq_monthly_day_@";Not:C34((Form:C1466.frequencyOn=1)))
			OBJECT SET ENABLED:C1123(*;"freq_monthly_button_@";(Form:C1466.frequencyOn=1))
			
			  //Set dropdown values
			$vl_fia:=Find in array:C230(at_monthlyDayNum;Form:C1466.selectedSchedule.detail.frequency.onDay.dayNum)
			If ($vl_fia>0)
				at_monthlyDayNum:=$vl_fia
			Else 
				at_monthlyDayNum:=0
			End if 
			
			$vl_fia:=Find in array:C230(at_monthlyDayType;Form:C1466.selectedSchedule.detail.frequency.onDay.dayType)
			If ($vl_fia>0)
				at_monthlyDayType:=$vl_fia
			Else 
				at_monthlyDayType:=0
			End if 
		End if 
End case 
