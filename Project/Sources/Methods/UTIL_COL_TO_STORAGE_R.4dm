//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 10/01/20, 10:23:13
  // ----------------------------------------------------
  // Method: UTIL_COL_TO_STORAGE_R
  // Description
  // Puts collection into storage
  // Only to be called by other UTIL Methods
  // Parameters
  // ----------------------------------------------------

C_COLLECTION:C1488($1;$2;$vc_col)
C_OBJECT:C1216($vo_ob)

For ($i;0;$2.length-1)
	Case of 
		: (Value type:C1509($2[$i])=Is object:K8:27)
			$1.push(New shared object:C1526)
			$vo_ob:=$1[$1.length-1]
			Use ($vo_ob)
				UTIL_OBJ_TO_STORAGE_R ($vo_ob;$2[$i])
			End use 
		: (Value type:C1509($2[$i])=Is collection:K8:32)
			$1.push(New shared collection:C1527)
			$vc_col:=$1[$1.length-1]
			Use ($vc_col)
				UTIL_COL_TO_STORAGE_R ($vc_col;$2[$i])
			End use 
		Else 
			$1.push($2[$i])
	End case 
End for 
