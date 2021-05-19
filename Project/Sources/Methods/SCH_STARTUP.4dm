//%attributes = {"shared":true}

SCH_INIT_STORAGE 

  //Get component List to check if INT_Interface is installed, if so, we can use INT_Request instead of default 4D Request
ARRAY TEXT:C222($at_compList;0)
COMPONENT LIST:C1001($at_compList)

Use (Storage:C1525.sch)
	Storage:C1525.sch.intIsInstalled:=(Find in array:C230($at_compList;"INT_Interface")>0)
End use 
