//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 10/01/20, 09:33:17
  // ----------------------------------------------------
  // Method: UTIL_OBJ_TO_STORAGE
  // Description
  // Puts given Obj into storage with given property name
  //
  // Parameters
  // $1 - String - Property name
  // $2 - Object - Object to store
  // ----------------------------------------------------

C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_TEXT:C284($vt_prop)
C_OBJECT:C1216($vo_ob)
C_COLLECTION:C1488($vc_col)

If (Not:C34(OB Is defined:C1231(Storage:C1525;$1)))
	Use (Storage:C1525)
		Storage:C1525[$1]:=New shared object:C1526
	End use 
End if 

Use (Storage:C1525[$1])
	For each ($vt_prop;$2)
		Case of 
			: (Value type:C1509($2[$vt_prop])=Is object:K8:27)
				Storage:C1525[$1][$vt_prop]:=New shared object:C1526
				Use (Storage:C1525[$1][$vt_prop])
					$vo_ob:=Storage:C1525[$1][$vt_prop]
					UTIL_OBJ_TO_STORAGE_R ($vo_ob;$2[$vt_prop])
				End use 
				
			: (Value type:C1509($2[$vt_prop])=Is collection:K8:32)
				Storage:C1525[$1][$vt_prop]:=New shared collection:C1527
				Use (Storage:C1525[$1][$vt_prop])
					For ($i;0;$2[$vt_prop].length-1)
						Case of 
							: (Value type:C1509($2[$vt_prop][$i])=Is object:K8:27)
								Storage:C1525[$1][$vt_prop].push(New shared object:C1526)
								$vo_ob:=Storage:C1525[$1][$vt_prop][Storage:C1525[$1][$vt_prop].length-1]
								Use ($vo_ob)
									UTIL_OBJ_TO_STORAGE_R ($vo_ob;$2[$vt_prop][$i])
								End use 
							: (Value type:C1509($2[$vt_prop][$i])=Is collection:K8:32)
								Storage:C1525[$1][$vt_prop].push(New shared collection:C1527)
								$vc_col:=Storage:C1525[$1][$vt_prop][Storage:C1525[$1][$vt_prop].length-1]
								Use ($vc_col)
									UTIL_COL_TO_STORAGE_R ($vc_col;$2[$vt_prop][$i])
								End use 
							Else 
								Storage:C1525[$1][$vt_prop].push($2[$vt_prop][$i])
						End case 
					End for 
				End use 
				
			Else 
				Storage:C1525[$1][$vt_prop]:=$2[$vt_prop]
		End case 
	End for each 
End use 