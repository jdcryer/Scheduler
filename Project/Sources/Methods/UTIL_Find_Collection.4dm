//%attributes = {}

// ----------------------------------------------------
// User name (OS): Tom
// Date and time: 27/08/19, 11:23:56
// ----------------------------------------------------
// Method: UTIL_Find_Collection
// Description
// for use with collection.findIndex()
// Generic method that allows searching any number of properties with any data types.
// Even Parameters ($2, $4 etc) must be strings - these are the properties to test
// Odd Params ($3, $5 etc) can be any datatype - these are the values to test for.
// Parameters
// $1 - Object - contains value to evaluate and 'result' boolean
// $2 - String - property to test
// $3 - Variant - value to test
// ----------------------------------------------------

C_OBJECT:C1216($1)
C_VARIANT:C1683(${2})
C_BOOLEAN:C305($vb_result)
$vb_result:=True:C214
For ($i; 3; Count parameters:C259; 2)
	If (OB Is defined:C1231($1.value; ${$i-1}))
		$vb_result:=$vb_result & ($1.value[${$i-1}]=${$i})
	Else 
		$vb_result:=False:C215
	End if 
End for 
$1.result:=$vb_result
