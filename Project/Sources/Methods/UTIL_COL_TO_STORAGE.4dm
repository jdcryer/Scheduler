//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 10/01/20, 09:33:17
  // ----------------------------------------------------
  // Method: UTIL_COL_TO_STORAGE
  // Description
  // Puts given Col into storage with given property name
  //
  // Parameters
  // $1 - String - Property name
  // $2 - Collection - Collection to store
  // $3 - Replace - Optional flag to clear collection before putting.
  // ----------------------------------------------------

C_TEXT:C284($1)
C_COLLECTION:C1488($2)
C_BOOLEAN:C305($3;$replace)
If (Count parameters:C259>2)
	$replace:=$3
End if 

C_TEXT:C284($vt_prop)
C_OBJECT:C1216($vo_ob)
C_COLLECTION:C1488($vc_col)

If ((Not:C34(OB Is defined:C1231(Storage:C1525;$1))) | ($replace))
	Use (Storage:C1525)
		Storage:C1525[$1]:=New shared collection:C1527
	End use 
End if 

Use (Storage:C1525[$1])
	For ($i;0;$2.length-1)
		Case of 
			: (Value type:C1509($2[$i])=Is object:K8:27)
				Storage:C1525[$1].push(New shared object:C1526)
				$vo_ob:=Storage:C1525[$1][Storage:C1525[$1].length-1]
				Use ($vo_ob)
					UTIL_OBJ_TO_STORAGE_R ($vo_ob;$2[$i])
				End use 
				
			: (Value type:C1509($2[$i])=Is collection:K8:32)
				Storage:C1525[$1].push(New shared collection:C1527)
				$vc_col:=Storage:C1525[$1][Storage:C1525[$1].length-1]
				Use ($vc_col)
					UTIL_COL_TO_STORAGE_R ($vc_col;$2[$i])
				End use 
				
			Else 
				Storage:C1525[$1].push($2[$i])
		End case 
	End for 
End use 