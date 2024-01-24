//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 19/05/21, 11:11:46
// ----------------------------------------------------
// Method: SCHEDULE_MANAGER_SET_ENABLED
// Description
// Sets enabled status of form elements using $1
//
// Parameters
// $1 - Boolean - Enabled state to set
// ----------------------------------------------------

C_BOOLEAN:C305($1)

OBJECT SET ENABLED:C1123(*; "input_@"; $1)
OBJECT SET ENABLED:C1123(*; "popup_launch_date"; $1)
OBJECT SET ENABLED:C1123(*; "freq_weekly_@"; $1)
OBJECT SET ENABLED:C1123(*; "freq_monthly_@"; $1)
OBJECT SET ENABLED:C1123(*; "dropdown_@"; $1)
OBJECT SET ENABLED:C1123(*; "timing@"; $1)
OBJECT SET ENABLED:C1123(*; "addTask"; $1)
OBJECT SET ENABLED:C1123(*; "delTask"; $1)
OBJECT SET ENABLED:C1123(*; "addParam"; $1)
OBJECT SET ENABLED:C1123(*; "delParam"; $1)
OBJECT SET ENABLED:C1123(*; "saveSchedule"; $1)
