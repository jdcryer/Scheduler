//%attributes = {}

Use (Storage:C1525)
	
	Storage:C1525.sch:=New shared object:C1526
End use 
Use (Storage:C1525.sch)
	Storage:C1525.sch.structure:=New shared object:C1526
	
End use 

Use (Storage:C1525.sch.structure)
	$vt_tableName:=SCH_Get_Mapped_Table ("schedule")
	If ("jsonFileData")
		Storage:C1525.sch.structure.id:="id"
		Storage:C1525.sch.structure.name:="name"
		Storage:C1525.sch.structure.nextLaunch:="nextLaunch"
		Storage:C1525.sch.structure.lastLaunch: "lastLaunch"
		Storage:C1525.sch.structure.lastCompleted:="lastCompleted"
		Storage:C1525.sch.structure.status:="status"
		Storage:C1525.sch.structure.detail:="detail"
	Else 
		Storage:C1525.sch.structure.table:=$vt_tableName
		Storage:C1525.sch.structure.id:=SCH_Get_Mapped_Field ("schedule";"id")
		Storage:C1525.sch.structure.name:=SCH_Get_Mapped_Field ("schedule";"name")
		Storage:C1525.sch.structure.nextLaunch:=SCH_Get_Mapped_Field ("schedule";"nextLaunch")
		Storage:C1525.sch.structure.lastLaunch:=SCH_Get_Mapped_Field ("schedule";"lastLaunch")
		Storage:C1525.sch.structure.lastCompleted:=SCH_Get_Mapped_Field ("schedule";"lastCompleted")
		Storage:C1525.sch.structure.status:=SCH_Get_Mapped_Field ("schedule";"status")
		Storage:C1525.sch.structure.detail:=SCH_Get_Mapped_Field ("schedule";"detail")
	End if 
End use 

