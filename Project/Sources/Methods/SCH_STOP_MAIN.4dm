//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 24/01/24, 14:43:32
// ----------------------------------------------------
// Method: SCH_STOP_MAIN
// Description
// Ran on server to stop scheduler by setting storage value
//
// Parameters
// ----------------------------------------------------

Use (Storage:C1525.schedule)
	Storage:C1525.schedule.state:=0
End use 
