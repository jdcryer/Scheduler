//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 19/05/21, 16:06:44
// ----------------------------------------------------
// Method: SCH_SET_TASKS_COLLECTION
// Description
// Called from Host Database to set list of available tasks
//
// Parameters
// $1 - Collection - [{
//                      label: '',
//                      method: '',
//                      children: [],
//                      parameters: [{ label: '', type: '' }]
//                   }]
// ----------------------------------------------------

C_COLLECTION:C1488($1)

UTIL_COL_TO_STORAGE("tasks"; $1; True:C214)
