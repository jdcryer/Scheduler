//%attributes = {}

Use (Storage:C1525)
	Storage:C1525.sch:=New shared object:C1526
	Storage:C1525.tasks:=New shared collection:C1527
	Storage:C1525.schedule:=New shared object:C1526
	Use (Storage:C1525.schedule)
		Storage:C1525.schedule.state:=0
		Storage:C1525.schedule.running:=New shared collection:C1527
	End use 
End use 
Use (Storage:C1525.sch)
	Storage:C1525.sch.intIsInstalled:=False:C215
	Storage:C1525.sch.structure:=New shared object:C1526
End use 

//Use (Storage.sch.structure)
//$vt_tableName:=SCH_Get_Mapped_Table ("schedule")
//If ("jsonFileData")
//Storage.sch.structure.id:="id"
//Storage.sch.structure.name:="name"
//Storage.sch.structure.nextLaunch:="nextLaunch"
//Storage.sch.structure.lastLaunch:="lastLaunch"
//Storage.sch.structure.lastCompleted:="lastCompleted"
//Storage.sch.structure.status:="status"
//Storage.sch.structure.detail:="detail"
//Else 
//Storage.sch.structure.table:=$vt_tableName
//Storage.sch.structure.id:=SCH_Get_Mapped_Field ("schedule";"id")
//Storage.sch.structure.name:=SCH_Get_Mapped_Field ("schedule";"name")
//Storage.sch.structure.nextLaunch:=SCH_Get_Mapped_Field ("schedule";"nextLaunch")
//Storage.sch.structure.lastLaunch:=SCH_Get_Mapped_Field ("schedule";"lastLaunch")
//Storage.sch.structure.lastCompleted:=SCH_Get_Mapped_Field ("schedule";"lastCompleted")
//Storage.sch.structure.status:=SCH_Get_Mapped_Field ("schedule";"status")
//Storage.sch.structure.detail:=SCH_Get_Mapped_Field ("schedule";"detail")
//End if 
//End use 

