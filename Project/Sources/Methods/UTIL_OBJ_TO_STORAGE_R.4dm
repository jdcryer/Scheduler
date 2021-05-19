//%attributes = {}

  // ----------------------------------------------------
  // User name (OS): Tom
  // Date and time: 10/01/20, 10:19:05
  // ----------------------------------------------------
  // Method: UTIL_OBJ_TO_STORAGE_R
  // Description
  // Puts object into storage,
  // Only to be called by other UTIL Methods
  // Parameters
  // $1 - Object - Stroage Object in which to store data
  // $2 - Object - Data to store in Storage
  // ----------------------------------------------------

C_OBJECT:C1216($1;$2;$vo_ob)
C_TEXT:C284($vt_prop)
C_COLLECTION:C1488($vc_col)

For each ($vt_prop;$2)
	Case of 
		: (Value type:C1509($2[$vt_prop])=Is object:K8:27)
			$1[$vt_prop]:=New shared object:C1526
			Use ($1[$vt_prop])
				$vo_ob:=$1[$vt_prop]
				UTIL_OBJ_TO_STORAGE_R ($vo_ob;$2[$vt_prop])
			End use 
		: (Value type:C1509($2[$vt_prop])=Is collection:K8:32)
			$1[$vt_prop]:=New shared collection:C1527
			$vc_col:=$1[$vt_prop]
			Use ($vc_col)
				UTIL_COL_TO_STORAGE_R ($vc_col;$2[$vt_prop])
			End use 
		Else 
			$1[$vt_prop]:=$2[$vt_prop]
	End case 
End for each 