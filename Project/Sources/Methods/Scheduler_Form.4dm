//%attributes = {}
C_OBJECT:C1216($1;$vo_formEvent)
C_OBJECT:C1216($e_deleteEntity;$e_schedule;$vo_status)
C_BOOLEAN:C305($vb_days;$vb_interval;$vb_OK)
C_LONGINT:C283($vl_fia;$vl_value)
C_TEXT:C284($vt_value)
C_REAL:C285($vr_value)
C_TIME:C306($vh_value)
C_DATE:C307($vd_value)

$vo_formEvent:=$1
If (Not:C34(OB Is defined:C1231($vo_formEvent;"objectName")))
	$vo_formEvent.objectName:="form"
End if 

Case of 
	: ($vo_formEvent.objectName="form")
		Case of 
			: ($vo_formEvent.code=On Load:K2:1)
				C_LONGINT:C283(hl_tabs)
				  //Set up Tabs
				hl_tabs:=New list:C375
				APPEND TO LIST:C376(hl_tabs;"General Settings";1)
				APPEND TO LIST:C376(hl_tabs;"Schedule";2)
				APPEND TO LIST:C376(hl_tabs;"Actions";3)
				
				Form:C1466.paramTypeMenu:=Create menu:C408
				APPEND MENU ITEM:C411(Form:C1466.paramTypeMenu;"Text")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.paramTypeMenu;-1;"Text")
				
				APPEND MENU ITEM:C411(Form:C1466.paramTypeMenu;"Integer")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.paramTypeMenu;-1;"Integer")
				
				APPEND MENU ITEM:C411(Form:C1466.paramTypeMenu;"Real")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.paramTypeMenu;-1;"Real")
				
				APPEND MENU ITEM:C411(Form:C1466.paramTypeMenu;"Date")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.paramTypeMenu;-1;"Date")
				
				APPEND MENU ITEM:C411(Form:C1466.paramTypeMenu;"Time")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.paramTypeMenu;-1;"Time")
				
				APPEND MENU ITEM:C411(Form:C1466.paramTypeMenu;"Boolean")
				SET MENU ITEM PARAMETER:C1004(Form:C1466.paramTypeMenu;-1;"Boolean")
				
				ARRAY TEXT:C222(at_frequency;0)
				APPEND TO ARRAY:C911(at_frequency;"Daily")
				APPEND TO ARRAY:C911(at_frequency;"Weekly")
				APPEND TO ARRAY:C911(at_frequency;"Monthly")
				
				ARRAY TEXT:C222(at_monthlyDayType;0)
				APPEND TO ARRAY:C911(at_monthlyDayType;"Monday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Tuesday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Wednesday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Thursday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Friday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Saturday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Sunday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Day")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Weekday")
				APPEND TO ARRAY:C911(at_monthlyDayType;"Weekend Day")
				
				ARRAY TEXT:C222(at_monthlyDayNum;0)
				APPEND TO ARRAY:C911(at_monthlyDayNum;"First")
				APPEND TO ARRAY:C911(at_monthlyDayNum;"Second")
				APPEND TO ARRAY:C911(at_monthlyDayNum;"Third")
				APPEND TO ARRAY:C911(at_monthlyDayNum;"Fourth")
				APPEND TO ARRAY:C911(at_monthlyDayNum;"Last")
				
				at_frequency:=1
				SCH_MANAGER_FREQ_CHANGE 
				SCH_MANAGER_SET_ENABLED (False:C215)
		End case 
		
		
	: ($vo_formEvent.objectName="Schedule_List")
		Case of 
			: ($vo_formEvent.code=On Selection Change:K2:29) | ($vo_formEvent.code=On Clicked:K2:4)
				
				If (Form:C1466.e_schedule#Null:C1517)
					  //Fill form elements
					$vl_fia:=Find in array:C230(at_frequency;Form:C1466.e_schedule.detail.frequency.period)
					If ($vl_fia>0)
						at_frequency:=$vl_fia
					Else 
						at_frequency:=0
					End if 
					SCH_MANAGER_SET_ENABLED (True:C214)
					
					SCH_MANAGER_FREQ_CHANGE 
					
					Form:C1466.timingInterval:=0
					Form:C1466.timingAt:=0
					If (Form:C1466.e_schedule.detail.frequency.timing="time")
						Form:C1466.timingAt:=1
						OBJECT SET ENABLED:C1123(*;"input_frequency_time_at";True:C214)
						OBJECT SET ENABLED:C1123(*;"input_frequency_time_interval@";False:C215)
					Else 
						Form:C1466.timingInterval:=1
						OBJECT SET ENABLED:C1123(*;"input_frequency_time_at";False:C215)
						OBJECT SET ENABLED:C1123(*;"input_frequency_time_interval@";True:C214)
					End if 
					
					vh_time_at:=Time:C179(Form:C1466.e_schedule.detail.frequency.specifiedTime)
					vh_time_interval:=Time:C179(Form:C1466.e_schedule.detail.frequency.interval)
					vh_time_interval_from:=Time:C179(Form:C1466.e_schedule.detail.frequency.startTime)
					vh_time_interval_to:=Time:C179(Form:C1466.e_schedule.detail.frequency.endTime)
					
					vh_next_launch:=Time:C179(Form:C1466.e_schedule.nextLaunch)
					vh_last_launch:=Time:C179(Form:C1466.e_schedule.lastLaunch)
					vh_last_completed:=Time:C179(Form:C1466.e_schedule.lastCompleted)
					
					vd_next_launch:=Date:C102(Form:C1466.e_schedule.nextLaunch)
					vd_last_launch:=Date:C102(Form:C1466.e_schedule.lastLaunch)
					vd_last_completed:=Date:C102(Form:C1466.e_schedule.lastCompleted)
					
				Else 
					  //None selected, clear values and disable selection
					SCH_MANAGER_SET_ENABLED (False:C215)
					at_frequency:=0
					at_monthlyDayType:=0
					at_monthlyDayNum:=0
					
					vh_time_at:=?00:00:00?
					vh_time_interval:=?00:00:00?
					vh_time_interval_from:=?00:00:00?
					vh_time_interval_to:=?00:00:00?
				End if 
				
		End case 
		
	: ($vo_formEvent.objectName="column_schedule_status")
		If ($vo_formEvent.code=On Clicked:K2:4)
			If (Form:C1466.e_schedule#Null:C1517)
				Form:C1466.e_schedule.status:=Choose:C955((Form:C1466.e_schedule.status=1);0;1)
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="addSchedule")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				$e_schedule:=ds:C1482["schedule"].new()
				$e_schedule.name:="New Schedule"
				$e_schedule.detail:=New object:C1471
				$e_schedule.detail.tasks:=New collection:C1472
				$e_schedule.detail.processSize:=0
				$e_schedule.detail.inactiveOnFailure:=False:C215
				$e_schedule.detail.frequency:=New object:C1471
				$e_schedule.detail.frequency.monthChoice:=""
				$e_schedule.detail.frequency.period:="Daily"
				$e_schedule.detail.frequency.every:=0
				$e_schedule.detail.frequency.timing:=""
				$e_schedule.detail.frequency.interval:=""
				$e_schedule.detail.frequency.startTime:=""
				$e_schedule.detail.frequency.endTime:=""
				$e_schedule.detail.frequency.specifiedTime:=""
				$e_schedule.detail.frequency.days:=New collection:C1472
				$e_schedule.detail.frequency.onDay:=New object:C1471
				$e_schedule.detail.frequency.onDay.dayNum:=""
				$e_schedule.detail.frequency.onDay.dayType:=""
				$e_schedule.save()
				
				Form:C1466.es_schedules.add($e_schedule)
				Form:C1466.es_schedules:=Form:C1466.es_schedules
		End case 
		
		
	: ($vo_formEvent.objectName="delSchedule")
		Case of 
			: ($vo_formEvent.code=On Clicked:K2:4)
				If (Form:C1466.e_schedule#Null:C1517)
					  //Delete selected
					$e_deleteEntity:=Form:C1466.e_schedule
					
					$vo_status:=$e_deleteEntity.drop()
					If ($vo_status.success)
						Form:C1466.es_schedules.minus($e_deleteEntity)
					Else 
						ALERT:C41("Failed to delete schedule. "+$vo_status.statusText)
					End if 
				End if 
		End case 
		
		
	: ($vo_formEvent.objectName="addTask")
		If ($vo_formEvent.code=On Clicked:K2:4)
			  //Display popup menu for selection of method...
			
			If (Form:C1466.e_schedule#Null:C1517)
				$vt_selected:=Dynamic pop up menu:C1006(Form:C1466.tasksMenu)
				If ($vt_selected#"")
					$vo_task:=New object:C1471
					$vo_task.method:=$vt_selected
					$vo_task.parameters:=New collection:C1472
					Form:C1466.e_schedule.detail.tasks.push(OB Copy:C1225($vo_task))
					Form:C1466.e_schedule.detail.tasks:=Form:C1466.e_schedule.detail.tasks
					LISTBOX SELECT ROW:C912(*;"lb_tasks";Form:C1466.e_schedule.detail.tasks.length;lk replace selection:K53:1)
				End if 
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="delTask")
		If ($vo_formEvent.code=On Clicked:K2:4)
			If (Form:C1466.vo_task#Null:C1517)
				Form:C1466.e_schedule.detail.tasks.remove(Form:C1466.taskSelected-1)
				Form:C1466.e_schedule.detail.tasks:=Form:C1466.e_schedule.detail.tasks
				LISTBOX SELECT ROW:C912(*;"lb_tasks";0;lk remove from selection:K53:3)
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="addParam")
		If ($vo_formEvent.code=On Clicked:K2:4)
			If (Form:C1466.vo_task#Null:C1517)
				$vo_param:=New object:C1471
				$vo_param.value:=""
				$vo_param.displayValue:=""
				$vo_param.type:="Text"
				Form:C1466.vo_task.parameters.push(OB Copy:C1225($vo_param))
				Form:C1466.vo_task.parameters:=Form:C1466.vo_task.parameters
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="delParam")
		If ($vo_formEvent.code=On Clicked:K2:4)
			If (Form:C1466.vo_task#Null:C1517)
				If (Form:C1466.vo_parameter#Null:C1517)
					Form:C1466.vo_task.parameters.remove(Form:C1466.parameterSelected-1)
					Form:C1466.vo_task.parameters:=Form:C1466.vo_task.parameters
				End if 
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="column_parameter_value")
		If ($vo_formEvent.code=On Clicked:K2:4)
			If (Form:C1466.vo_parameter#Null:C1517)
				  //Show value entry according to selected type
				
				If (Storage:C1525.sch.intIsInstalled)
					Case of 
						: (Form:C1466.vo_parameter.type="Text")
							$vt_value:=Form:C1466.vo_parameter.value
							EXECUTE METHOD:C1007("INT_Request";$vb_OK;->$vt_value;"Please enter the parameter value")
							If ($vb_OK)
								Form:C1466.vo_parameter.value:=$vt_value
								Form:C1466.vo_parameter.displayValue:=Form:C1466.vo_parameter.value
							End if 
							
						: (Form:C1466.vo_parameter.type="Integer")
							$vl_value:=Form:C1466.vo_parameter.value
							EXECUTE METHOD:C1007("INT_Request";$vb_OK;->$vl_value;"Please enter the parameter value")
							If ($vb_OK)
								Form:C1466.vo_parameter.value:=$vl_value
								Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							End if 
							
						: (Form:C1466.vo_parameter.type="Real")
							$vr_value:=Form:C1466.vo_parameter.value
							EXECUTE METHOD:C1007("INT_Request";$vb_OK;->$vr_value;"Please enter the parameter value")
							If ($vb_OK)
								Form:C1466.vo_parameter.value:=$vr_value
								Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							End if 
							
						: (Form:C1466.vo_parameter.type="Date")
							$vd_value:=Form:C1466.vo_parameter.value
							EXECUTE METHOD:C1007("INT_Request";$vb_OK;->$vd_value;"Please enter the parameter value")
							If ($vb_OK)
								Form:C1466.vo_parameter.value:=$vd_value
								Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							End if 
							
						: (Form:C1466.vo_parameter.type="Time")
							$vh_value:=Form:C1466.vo_parameter.value
							EXECUTE METHOD:C1007("INT_Request";$vb_OK;->$vh_value;"Please enter the parameter value")
							If ($vb_OK)
								Form:C1466.vo_parameter.value:=$vh_value
								Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							End if 
							
						: (Form:C1466.vo_parameter.type="Boolean")
							$m_boolMenu:=Create menu:C408
							APPEND MENU ITEM:C411($m_boolMenu;"True")
							SET MENU ITEM PARAMETER:C1004($m_boolMenu;-1;"True")
							APPEND MENU ITEM:C411($m_boolMenu;"False")
							SET MENU ITEM PARAMETER:C1004($m_boolMenu;-1;"False")
							
							$vt_selected:=Dynamic pop up menu:C1006($m_boolMenu)
							If ($vt_selected#"")
								Form:C1466.vo_parameter.displayValue:=$vt_selected
								Form:C1466.vo_parameter.value:=Choose:C955(($vt_selected="True");True:C214;False:C215)
							End if 
					End case 
					
				Else 
					Case of 
						: (Form:C1466.vo_parameter.type="Text")
							$vt_value:=Request:C163("Please enter the parameter value";Form:C1466.vo_parameter.value)
							If (OK=1)
								Form:C1466.vo_parameter.value:=$vt_value
								Form:C1466.vo_parameter.displayValue:=Form:C1466.vo_parameter.value
							End if 
							
						: (Form:C1466.vo_parameter.type="Integer")
							$vt_value:=Request:C163("Please enter the parameter value";String:C10(Form:C1466.vo_parameter.value))
							If (OK=1)
								Form:C1466.vo_parameter.value:=Int:C8(Num:C11($vt_value))
								Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							End if 
							
						: (Form:C1466.vo_parameter.type="Real")
							$vt_value:=Request:C163("Please enter the parameter value";String:C10(Form:C1466.vo_parameter.value))
							If (OK=1)
								Form:C1466.vo_parameter.value:=Num:C11($vt_value)
								Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							End if 
							
						: (Form:C1466.vo_parameter.type="Date")
							$vt_value:=Request:C163("Please enter the parameter value";String:C10(Form:C1466.vo_parameter.value))
							If (OK=1)
								Form:C1466.vo_parameter.value:=Date:C102($vt_value)
								Form:C1466.vo_parameter.displayValue:=Form:C1466.vo_parameter.value
							End if 
							
						: (Form:C1466.vo_parameter.type="Time")
							$vt_value:=Request:C163("Please enter the parameter value";String:C10(Form:C1466.vo_parameter.value))
							If (OK=1)
								Form:C1466.vo_parameter.value:=Time:C179($vt_value)
								Form:C1466.vo_parameter.displayValue:=Form:C1466.vo_parameter.value
							End if 
							
						: (Form:C1466.vo_parameter.type="Boolean")
							$m_boolMenu:=Create menu:C408
							APPEND MENU ITEM:C411($m_boolMenu;"True")
							SET MENU ITEM PARAMETER:C1004($m_boolMenu;-1;"True")
							APPEND MENU ITEM:C411($m_boolMenu;"False")
							SET MENU ITEM PARAMETER:C1004($m_boolMenu;-1;"False")
							
							$vt_selected:=Dynamic pop up menu:C1006($m_boolMenu)
							If ($vt_selected#"")
								Form:C1466.vo_parameter.displayValue:=$vt_selected
								Form:C1466.vo_parameter.value:=Choose:C955(($vt_selected="True");True:C214;False:C215)
							End if 
					End case 
				End if 
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="column_parameter_type")
		If ($vo_formEvent.code=On Clicked:K2:4)
			If (Form:C1466.vo_parameter#Null:C1517)
				$vt_selected:=Dynamic pop up menu:C1006(Form:C1466.paramTypeMenu)
				If ($vt_selected#"")
					Form:C1466.vo_parameter.type:=$vt_selected
					Case of 
						: (Form:C1466.vo_parameter.type="Text")
							Form:C1466.vo_parameter.value:=String:C10(Form:C1466.vo_parameter.value)
							Form:C1466.vo_parameter.displayValue:=Form:C1466.vo_parameter.value
							
						: (Form:C1466.vo_parameter.type="Integer")
							Form:C1466.vo_parameter.value:=Int:C8(Num:C11(Form:C1466.vo_parameter.value))
							Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							
						: (Form:C1466.vo_parameter.type="Real")
							Form:C1466.vo_parameter.value:=Num:C11(Form:C1466.vo_parameter.value)
							Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							
							
						: (Form:C1466.vo_parameter.type="Date")
							Form:C1466.vo_parameter.value:=Date:C102(Form:C1466.vo_parameter.value)
							Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							
						: (Form:C1466.vo_parameter.type="Time")
							Form:C1466.vo_parameter.value:=Time:C179(Form:C1466.vo_parameter.value)
							Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							
						: (Form:C1466.vo_parameter.type="Boolean")
							Form:C1466.vo_parameter.value:=False:C215
							Form:C1466.vo_parameter.displayValue:=String:C10(Form:C1466.vo_parameter.value)
							
					End case 
				End if 
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="input_next_launch_date") | ($vo_formEvent.objectName="input_next_launch_time")
		If ($vo_formEvent.code=On Data Change:K2:15)
			Form:C1466.e_schedule.nextLaunch:=String:C10(vd_next_launch;ISO date:K1:8;vh_next_launch)
		End if 
		
		
	: ($vo_formEvent.objectName="freq_monthly_button_@")
		If ($vo_formEvent.code=On Clicked:K2:4)
			$vl_buttonNum:=Num:C11(Replace string:C233($vo_formEvent.objectName;"freq_monthly_button_";""))
			$vl_index:=Form:C1466.e_schedule.detail.frequency.days.indexOf($vl_buttonNum)
			If ($vl_index=-1)
				Form:C1466.e_schedule.detail.frequency.days.push($vl_buttonNum)
				OBJECT SET RGB COLORS:C628(*;$vo_formEvent.objectName;"#0000FF";"#6DC9C5")
			Else 
				Form:C1466.e_schedule.detail.frequency.days.remove($vl_index)
				OBJECT SET RGB COLORS:C628(*;$vo_formEvent.objectName;"#000000")
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="freq_weekly_button_@")
		If ($vo_formEvent.code=On Clicked:K2:4)
			$vl_buttonNum:=Num:C11(Replace string:C233($vo_formEvent.objectName;"freq_weekly_button_";""))
			$vl_index:=Form:C1466.e_schedule.detail.frequency.days.indexOf($vl_buttonNum)
			If ($vl_index=-1)
				Form:C1466.e_schedule.detail.frequency.days.push($vl_buttonNum)
				OBJECT SET RGB COLORS:C628(*;$vo_formEvent.objectName;"#0000FF";"#6DC9C5")
			Else 
				Form:C1466.e_schedule.detail.frequency.days.remove($vl_index)
				OBJECT SET RGB COLORS:C628(*;$vo_formEvent.objectName;"#000000")
			End if 
		End if 
		
		
	: ($vo_formEvent.objectName="freq_monthly_on") | ($vo_formEvent.objectName="freq_monthly_on_the")
		If ($vo_formEvent.code=On Data Change:K2:15) | ($vo_formEvent.code=On Clicked:K2:4)
			$vb_days:=(Form:C1466.frequencyOn=1)
			
			Form:C1466.e_schedule.detail.frequency.monthChoice:=Choose:C955($vb_days;"days";"onDay")
			
			OBJECT SET ENABLED:C1123(*;"freq_monthly_day_@";Not:C34($vb_days))
			OBJECT SET ENABLED:C1123(*;"freq_monthly_button_@";$vb_days)
		End if 
		
		
	: ($vo_formEvent.objectName="freq_monthly_day_num")
		If ($vo_formEvent.code=On Data Change:K2:15) | ($vo_formEvent.code=On Clicked:K2:4)
			Form:C1466.e_schedule.detail.frequency.onDay.dayNum:=at_monthlyDayNum{at_monthlyDayNum}
		End if 
		
		
	: ($vo_formEvent.objectName="freq_monthly_day_type")
		If ($vo_formEvent.code=On Data Change:K2:15) | ($vo_formEvent.code=On Clicked:K2:4)
			Form:C1466.e_schedule.detail.frequency.onDay.dayNum:=at_monthlyDayType{at_monthlyDayType}
		End if 
		
		
	: ($vo_formEvent.objectName="dropdown_frequency")
		If ($vo_formEvent.code=On Data Change:K2:15) | ($vo_formEvent.code=On Clicked:K2:4)
			Form:C1466.e_schedule.detail.frequency.period:=at_frequency{at_frequency}
			SCH_MANAGER_FREQ_CHANGE 
		End if 
		
		
	: ($vo_formEvent.objectName="timingInterval") | ($vo_formEvent.objectName="timingAt")
		If ($vo_formEvent.code=On Data Change:K2:15) | ($vo_formEvent.code=On Clicked:K2:4)
			$vb_interval:=(Form:C1466.timingInterval=1)
			
			Form:C1466.e_schedule.detail.frequency.timing:=Choose:C955($vb_interval;"periodic";"time")
			
			OBJECT SET ENABLED:C1123(*;"input_frequency_time_at";Not:C34($vb_interval))
			OBJECT SET ENABLED:C1123(*;"input_frequency_time_interval@";$vb_interval)
		End if 
		
		
	: ($vo_formEvent.objectName="input_frequency_time_at")
		If ($vo_formEvent.code=On Data Change:K2:15)
			Form:C1466.e_schedule.detail.frequency.specifiedTime:=String:C10(Form:C1466.time_at;HH MM:K7:2)
		End if 
		
		
	: ($vo_formEvent.objectName="input_frequency_time_interval")
		If ($vo_formEvent.code=On Data Change:K2:15)
			Form:C1466.e_schedule.detail.frequency.interval:=String:C10(Form:C1466.time_interval;HH MM:K7:2)
		End if 
		
		
	: ($vo_formEvent.objectName="input_frequency_time_interval_from")
		If ($vo_formEvent.code=On Data Change:K2:15)
			Form:C1466.e_schedule.detail.frequency.startTime:=String:C10(Form:C1466.time_interval_from;HH MM:K7:2)
		End if 
		
		
	: ($vo_formEvent.objectName="input_frequency_time_interval_to")
		If ($vo_formEvent.code=On Data Change:K2:15)
			Form:C1466.e_schedule.detail.frequency.endTime:=String:C10(Form:C1466.time_interval_to;HH MM:K7:2)
		End if 
		
End case 
