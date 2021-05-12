//%attributes = {}
$vo_formEvent:=$1
Case of 
	: ($vo_formEvent.code=On Load:K2:1)
		C_LONGINT:C283(hl_tabs)
		  //Set up Tabs
		hl_tabs:=New list:C375
		APPEND TO LIST:C376(hl_tabs;"General Settings";1)
		APPEND TO LIST:C376(hl_tabs;"Schedule";2)
		APPEND TO LIST:C376(hl_tabs;"Actions";3)
		
		ARRAY TEXT:C222(at_paramType;0)
		APPEND TO ARRAY:C911(at_paramType;"Text")
		APPEND TO ARRAY:C911(at_paramType;"Integer")
		APPEND TO ARRAY:C911(at_paramType;"Real")
		APPEND TO ARRAY:C911(at_paramType;"Date")
		APPEND TO ARRAY:C911(at_paramType;"Time")
		APPEND TO ARRAY:C911(at_paramType;"Boolean")
		
End case 