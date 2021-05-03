//%attributes = {}
  // DECLARE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
C_TEXT:C284($1;$0)
C_TEXT:C284($vt_tableName)
C_LONGINT:C283($vl_tableNumber)
C_BOOLEAN:C305($vb_noTable)

  //INIT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$vt_tableName:=$1

If (OB Is defined:C1231(Storage:C1525;"structure"))
	If (OB Is defined:C1231(Storage:C1525.structure;$vt_tableName))
		$vl_tableNumber:=Storage:C1525.structure[$vt_tableName].tableNumber
		If (Is table number valid:C999($vl_TableNumber))
			$0:=Table name:C256($vl_tableNumber)
		Else 
			$vb_noTable:=True:C214
		End if 
	Else 
		$vb_noTable:=True:C214
	End if 
Else 
	$vb_noTable:=True:C214
End if 
If ($vb_noTable)
	$0:="jsonFileData"
End if 

