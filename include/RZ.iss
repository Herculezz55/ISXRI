;RunZones v7 by Herculezz

variable index:string _Zone
variable index:int ZoneTimer
variable index:string ZoneExit
variable index:string ZoneExitLoc
variable index:int ZoneExitPopupSelection
variable index:string ZoneEntrance
variable index:int ZoneEntrancePopupSelection
variable index:string ZoneEntranceLoc
variable index:string ZonePathFile
variable index:string ZoneFrom
variable index:bool ZoneUnlocked
variable index:int ZoneSetTime
variable index:int ZoneUnlockTime
variable(global) bool RZ_Var_Bool_Start=FALSE
variable(global) bool RZ_Var_Bool_Paused=FALSE
variable(global) string RI_Var_String_RZScriptName=${Script.Filename}
variable int RZ_Var_Int_Loops=1
variable bool ResetConfirmation=FALSE
variable(global) RZObject RZObj
variable bool RecentlyAntiAFK=FALSE
variable bool UnableToZone=FALSE
variable bool InstanceExpired=FALSE
variable bool DontEchoExit=FALSE
variable bool Developer=FALSE
variable bool 6HourZones=FALSE
variable filepath FP
variable int MainArrayCounter
variable index:string istrMain
variable bool Others=FALSE
variable bool StartRZ=TRUE

function BuildIndexes()
{
	;Zone
	_Zone:Insert["Plane of Innovation: Masks of the Marvelous [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Masks of the Marvelous [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Masks of the Marvelous [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Masks of the Marvelous [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Masks of the Marvelous [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Masks of the Marvelous [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Gears in the Machine [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Gears in the Machine [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Gears in the Machine [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Gears in the Machine [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Gears in the Machine [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Gears in the Machine [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Parts Not Included [Duo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Parts Not Included [Duo]]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Parts Not Included [Event Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Parts Not Included [Event Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Parts Not Included [Expert Event]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Parts Not Included [Expert Event]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]

	;Zone
	_Zone:Insert["Plane of Disease: Outbreak [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: Outbreak [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: Outbreak [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: Outbreak [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: Outbreak [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: Outbreak [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: The Source [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: The Source [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: The Source [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: The Source [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: The Source [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: The Source [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: Infested Mesa [Duo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: Infested Mesa [Duo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Zone Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: Infested Mesa [Event Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: Infested Mesa [Event Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Zone Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Disease: Infested Mesa [Expert Event]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Disease: Infested Mesa [Expert Event]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Zone Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_pod"]
	ZoneEntranceLoc:Insert[-190.139999 2.940000 0.0900004]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Torden, Bastion of Thunder: Tower Breach [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Torden, Bastion of Thunder: Tower Breach [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_bot"]
	ZoneEntranceLoc:Insert[-94.660004 2.940000 -164.080002]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Torden, Bastion of Thunder: Tower Breach [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Torden, Bastion of Thunder: Tower Breach [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_bot"]
	ZoneEntranceLoc:Insert[-94.660004 2.940000 -164.080002]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Torden, Bastion of Thunder: Tower Breach [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Torden, Bastion of Thunder: Tower Breach [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_bot"]
	ZoneEntranceLoc:Insert[-94.660004 2.940000 -164.080002]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Torden, Bastion of Thunder: Winds of Change [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Torden, Bastion of Thunder: Winds of Change [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_bot"]
	ZoneEntranceLoc:Insert[-94.660004 2.940000 -164.080002]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Torden, Bastion of Thunder: Winds of Change [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Torden, Bastion of Thunder: Winds of Change [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Exit"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_bot"]
	ZoneEntranceLoc:Insert[-94.660004 2.940000 -164.080002]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Torden, Bastion of Thunder: Winds of Change [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Torden, Bastion of Thunder: Winds of Change [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_bot"]
	ZoneEntranceLoc:Insert[-94.660004 2.940000 -164.080002]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	_Zone:Insert["Solusek Ro's Tower: The Obsidian Core [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Solusek Ro's Tower: The Obsidian Core [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_ro_tower"]
	ZoneEntranceLoc:Insert[94.830002 2.940000 -164.320007]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	_Zone:Insert["Solusek Ro's Tower: The Obsidian Core [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Solusek Ro's Tower: The Obsidian Core [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_ro_tower"]
	ZoneEntranceLoc:Insert[94.830002 2.940000 -164.320007]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	_Zone:Insert["Solusek Ro's Tower: The Obsidian Core [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Solusek Ro's Tower: The Obsidian Core [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_ro_tower"]
	ZoneEntranceLoc:Insert[94.830002 2.940000 -164.320007]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	_Zone:Insert["Solusek Ro's Tower: Monolith of Fire [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Solusek Ro's Tower: Monolith of Fire [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_ro_tower"]
	ZoneEntranceLoc:Insert[94.830002 2.940000 -164.320007]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	
	_Zone:Insert["Solusek Ro's Tower: Monolith of Fire [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Solusek Ro's Tower: Monolith of Fire [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_ro_tower"]
	ZoneEntranceLoc:Insert[94.830002 2.940000 -164.320007]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	_Zone:Insert["Solusek Ro's Tower: Monolith of Fire [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["Solusek Ro's Tower: Monolith of Fire [Expert]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["zone_to_valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_ro_tower"]
	ZoneEntranceLoc:Insert[94.830002 2.940000 -164.320007]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Shard of Hate: Utter Contempt [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Shard of Hate: Utter Contempt [Solo]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["Shard of Hate Portal"]
	ZoneEntranceLoc:Insert[-763.766663 347.377350 1048.609009]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Shard of Hate: Utter Contempt [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Shard of Hate: Utter Contempt [Heroic]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["Shard of Hate Portal"]
	ZoneEntranceLoc:Insert[-763.766663 347.377350 1048.609009]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[21600]
	
	;Zone
	_Zone:Insert["Shard of Hate: Udder Contempt [Herd Mode]"]
	UIElement[ZonesAvail@RZ]:AddItem["Shard of Hate: Udder Contempt [Herd Mode]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["Shard of Hate Portal"]
	ZoneEntranceLoc:Insert[-763.766663 347.377350 1048.609009]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[21600]
	
	return
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: Halls of the Fallen [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: Halls of the Fallen [Solo]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: Halls of the Fallen [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: Halls of the Fallen [Heroic]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: Halls of the Fallen [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: Halls of the Fallen [Expert]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: Halls of the Fallen [Frenzied]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: Halls of the Fallen [Frenzied]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: The Lower Corridors [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: The Lower Corridors [Solo]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: The Lower Corridors [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: The Lower Corridors [Heroic]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: The Lower Corridors [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: The Lower Corridors [Expert]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk: The Lower Corridors [Frenzied]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Ruins of Guk: The Lower Corridors [Frenzied]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	return
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk:  [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Guk [Solo]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk:  [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Guk [Heroic]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk:  [Expert]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Guk [Expert]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["The Fabled Ruins of Guk:  [Frenzied]"]
	UIElement[ZonesAvail@RZ]:AddItem["The Fabled Guk [Frenzied]"]
	ZoneFrom:Insert["Plane of Magic"]
	ZoneTimer:Insert[1080]
	ZoneExit:Insert[Exit]
	ZoneExitLoc:Insert[]
	ZoneExitPopupSelection:Insert[0]
	ZoneEntrance:Insert["GUKPORTALCHANGE"]
	ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
}
variable(global) int RZ_Var_Int_Count=1
function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	;if ${Devel.Equal[TRUE]}
	Developer:Set[TRUE]
	
	variable int Count=1
	; variable int _acnt=1
	; variable bool JustZone=0
	; variable string ZoneName
	; variable string ZoneExitActorName
	
	; for(_acnt:Set[1];${_acnt}<=${args.Used};_acnt:Inc)
	; {
		; ;echo args ${_acnt} : ${args[${_acnt}]}
		; switch ${args[${_acnt}]}
		; {
			; case -JustZone
			; {
				; JustZone:Set[1]
				; ZoneName:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				; ZoneExitActorName:Set["${args[${Math.Calc[${_acnt}+2]}]}"]
				; break
			; }
		; }
	; }
	
	; ;echo ${Zones} // ${Exclusions} // ${JustZone} // ${ZoneExitActorName} // ${ZoneName}
	; if ${JustZone}
	; {
		; echo Zoning Out of "${ZoneName}" using "${ZoneExitActorName}"
		; call ZoneOut "${ZoneExitActorName}" "${ZoneName}"
		; DontEchoExit:Set[TRUE]
		; Script:End
		; ;echo done zoning out
	; }
	;check if RZ.xml exists, if not create
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RZ"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[RZ]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RZ"]
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.FileExists[RZ.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RZ.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml" http://www.isxri.com/RZ.xml
		wait 50
	}
	if !${FP.FileExists[RZm.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RZm.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RZm.xml" http://www.isxri.com/RZm.xml
		wait 50
	}
	echo ISXRI: ${Time}: Starting RZ
	
	if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
		endscript ${RI_Var_String_RunInstancesScriptName}
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RZm.xml"
	RZObj:Maximize
	RZObj:LoadSave
	UIElement[ExpacComboBox@RZ]:AddItem["Planes of Prophecy"]
	UIElement[ExpacComboBox@RZ]:SelectItem[1]
	call BuildIndexes
	
	;start RIMovement if it is not running
	relay all -noredirect ${If[!${Script[Buffer:RIMovement](exists)},RIMovement,noop]}
	variable bool ZonesReset=FALSE
	;wait until start is pushed
	while !${RZ_Var_Bool_Start}
	{
		;execute queued commands
		if ${QueuedCommands}
		{
			ExecuteQueued
		}
		wait 5
	}
			
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;buildrelaygroup
	RG
	
	;load RI_AntiAFK
	relay all -noredirect RI_AntiAFK
	relay all -noredirect RG
	;main loop
	while 1
	{
		;wait while paused
		if ${RZ_Var_Bool_Paused}
		{
			wait 5
			continue
		}
		;wait until start is pushed
		if !${RZ_Var_Bool_Start}
		{
			;execute queued commands
			if ${QueuedCommands}
			{
				ExecuteQueued
			}
			wait 5
			continue
		}
		
		if !${ZonesReset}
		{
			;open zones window to populate zones, then close
			relay "${RI_Var_String_RelayGroup}" eq2ex togglezonereuse
			wait 5
			relay "${RI_Var_String_RelayGroup}" eq2ex togglezonereuse
			wait 5
			relay "${RI_Var_String_RelayGroup}" eq2ex togglezonereuse
			wait 5
			relay "${RI_Var_String_RelayGroup}" eq2ex togglezonereuse
			wait 5
			;if Zone is unlocked run it
			for(RZ_Var_Int_Count:Set[1];${RZ_Var_Int_Count}<=${UIElement[AddedZoneList@RZ].Items};RZ_Var_Int_Count:Inc)
			{
				echo Reseting: ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}
				relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
				wait 3
				relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
				wait 3
				relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
				wait 3
				relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
				wait 3
				relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
				wait 3
				relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
				wait 5
			}
			ZonesReset:Set[1]
		}
		
		;if we are not zoning
		if ${EQ2.Zoning}==0
		{
			;if Zone is unlocked run it
			for(RZ_Var_Int_Count:Set[1];${RZ_Var_Int_Count}<=${UIElement[AddedZoneList@RZ].Items};RZ_Var_Int_Count:Inc)
			{
				;wait while paused
				while ${RZ_Var_Bool_Paused}
				{
					wait 5
				}
				;if not start exit for loop
				if !${RZ_Var_Bool_Start}
				{
					RZ_Var_Int_Count:Set[${Math.Calc[${UIElement[AddedZoneList@RZ].Items}+1]}]
					continue
				}
				if ${RZ_Var_Int_Count}==1 && !${UIElement[InfiniteLoopListCheckBox@RZ].Checked}
				{
					;echo limited loops checking ${RZ_Var_Int_Loops}<=${UIElement[LoopCountTextEntry@RZ].Text}
					if ${RZ_Var_Int_Loops}<=${UIElement[LoopCountTextEntry@RZ].Text}
						RZ_Var_Int_Loops:Inc
					else
					{
						RZObj:Stop
						RZ_Var_Int_Count:Set[${Math.Calc[${UIElement[AddedZoneList@RZ].Items}+1]}]
						continue
					}
				}
				;call CheckZones function
				call RZObj.CheckZones
				;echo checking if ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]} at ${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]} is unlocked: ${ZoneUnlocked.Get[${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]}]}
				if ${ZoneUnlocked.Get[${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]}]}
					call Zone ${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]}
			}
			
			;call CheckZones function
			;call RZObj.CheckZones
			wait 50
		}
	}
}
atom(global) displayindexes()
{
	variable int _count
	;go through our index and find the zone that was just locked
	for(_count:Set[1];${_count}<=${_Zone.Used};_count:Inc)
	{
		echo ${_Zone.Get[${_count}]} // ${ZoneUnlocked.Get[${_count}]} // ${ZoneSetTime.Get[${_count}]} // ${ZoneUnlockTime.Get[${_count}]}
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	variable int _count
	;check Text for Zone timer confirmation message
   	if ${Text.Find["Your zone reuse timer for "](exists)}
	{
		;go through our index and find the zone that was just locked
		for(_count:Set[1];${_count}<=${_Zone.Used};_count:Inc)
		{
			if ${Text.Find["${_Zone.Get[${_count}]}"]}
			{
				echo ISXRI: ${Time}: Setting ${_Zone.Get[${_count}]} zone reuse timer to: ${Time.SecondsSinceMidnight} Seconds since midnight
				ZoneSetTime.Get[${_count}]:Set[${Time.SecondsSinceMidnight}]
				ZoneUnlocked.Get[${_count}]:Set[FALSE]
			}
		}
	}
	;check Text for Zone reset timer confirmation message
   	if ${Text.Find["You reset your entrance timer for "](exists)}
	{
		ResetConfirmation:Set[TRUE]
		;go through our index and find the zone that was just unlocked
		for(_count:Set[1];${_count}<=${_Zone.Used};_count:Inc)
		{
			if ${Text.Find["${_Zone.Get[${_count}]}"]}
			{
				echo ISXRI: ${Time}: Succesfully Reset ${_Zone.Get[${_count}]}
				ZoneSetTime.Get[${_count}]:Set[0]
				ZoneUnlocked.Get[${_count}]:Set[TRUE]
			}
		}
	}
	;check Text for unable to zone message
   	if ${Text.Find["The following group members are already saved to this instance"](exists)}
	{
		UnableToZone:Set[TRUE]
	}
	;check Text for unable to zone message
   	if ${Text.Find["is already saved to this instance"](exists)}
	{
		UnableToZone:Set[TRUE]
	}
	;check Text for instance expired message
   	if ${Text.Find["This instance will expire in 0.0 seconds"](exists)} || ${Text.Find["You may not enter an instance created prior to when your previous instance's minimum lockout timer expired"](exists)}
	{
		InstanceExpired:Set[TRUE]
	}
}

;Zone function
function Zone(int _IndexPosition)
{
	;echo Zone Function
	;if we are more than 10 away from EntranceLoc move closer, but check collision and not more than 200 else, call to guild hall and run path to zonein - UM NOPE
	;${ZoneEntranceLoc.Get[${_IndexPosition}].Token[1," "]}
	;${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Token[2," "]}+2]}
	;${ZoneEntranceLoc.Get[${_IndexPosition}].Token[3," "]}
	;echo if ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>10 && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[1," "]},${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Token[2," "]}+2]},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[3," "]}]} && ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}<200
	;echo ${ZoneFrom.Get[${_IndexPosition}]}
	if ${ZoneFrom.Get[${_IndexPosition}].Find[Coliseum of Valor](exists)}
	{
		;echo if
		if ${Zone.Name.Find[Coliseum of Valor](exists)}
		{
			if ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>10 && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[1," "]},${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Token[2," "]}+2]},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[3," "]}]} && ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}<200
				call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 10 0 0 1 1 0 1 1
			elseif ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>10
			{
				call RIMObj.Move 0.199857 6.007895 -0.344092 3 0 0 1 1 0 1 1
				call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 10 0 0 1 1 0 1 1
			}
		}
		elseif ${Zone.Name.Find[Plane of Magic](exists)} && ${Me.Distance[-787.492065,344.555206,1113.450806]}<85
		{
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
			wait 2
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
			call RIMObj.Move -787.492065 344.555206 1113.450806 2 0 0 1 1 0 1 1
			;wait for group members
			if ${Me.Group}>1 && ${Me.Group[1].Type.Equal[PC]}
			{
				while !${RIMObj.AllGroupWithinRange[5]}
				{
					relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
					relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
					wait 5
				}
			}
			call ZoneOut "zone_to_pov" "Coliseum of Valor"
			
			;wait 5s
			wait 50
			
			;if we are not in the correct zone, exit function
			if ${Me.GetGameData[Self.ZoneName].Label.Left[17].NotEqual["Coliseum of Valor"]}
				return
				
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			relay "${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,OFF]
				
			if ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>10 && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[1," "]},${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Token[2," "]}+2]},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[3," "]}]} && ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}<200
				call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 10 0 0 1 1 0 1 1
			elseif ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>10
			{
				call RIMObj.Move 0.199857 6.007895 -0.344092 3 0 0 1 1 0 1 1
				call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 10 0 0 1 1 0 1 1
			}
		}
		else
		{
			MessageBox -skin eq2 "You must be either in Coliseum of Valor or in Plane of Magic (within 85 of Valor Portal)"
			RZObj:Stop
			return
		}
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find[Plane of Magic](exists)}
	{
		if ${Zone.Name.Find[Coliseum of Valor](exists)}
		{
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
			;zoneout loc
			if ${Math.Distance[${Me.Loc},92.623001,2.938255,160.673553}]}>10 && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},92.623001,4.938255,160.673553]} && ${Math.Distance[${Me.Loc},92.623001,2.938255,160.673553]}<200
				call RIMObj.Move 92.623001 2.938255 160.673553 4 0 0 1 1 0 1 1
			;center then to zoneout
			elseif ${Math.Distance[${Me.Loc},92.623001,2.938255,160.673553]}>10
			{
				call RIMObj.Move 0.199857 6.007895 -0.344092 3 0 0 1 1 0 1 1
				;wait for group members
				if ${Me.Group}>1 && ${Me.Group[1].Type.Equal[PC]}
				{
					while !${RIMObj.AllGroupWithinRange[5]}
					{
						relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
						relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
						wait 5
					}
				}
				call RIMObj.Move 92.623001 2.938255 160.673553 4 0 0 1 1 0 1 1
			}
			;wait for group members
			if ${Me.Group}>1 && ${Me.Group[1].Type.Equal[PC]}
			{
				while !${RIMObj.AllGroupWithinRange[5]}
				{
					relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
					relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
					wait 5
				}
			}
			call ZoneOut "zone_to_pom" "Plane of Magic"
			
			;wait 5s
			wait 50
			
			;if we are not in the correct zone, exit function
			if ${Me.GetGameData[Self.ZoneName].Label.Left[14].NotEqual["Plane of Magic"]}
				return
				
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			relay "${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,OFF]
			
			call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 3 0 0 1 1 0 1 1
		}
		elseif ${Zone.Name.Find[Plane of Magic](exists)} && ${Me.Distance[-787.492065,344.555206,1113.450806]}<85
		{	
			call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 3 0 0 1 1 0 1 1
		}
		else
		{
			MessageBox -skin eq2 "You must be either in Coliseum of Valor or in Plane of Magic (within 85 of Valor Portal)"
			RZObj:Stop
			return
		}
	}
	wait 20

	echo ${Time}: Zoning into ${_Zone.Get[${_IndexPosition}]}
	
	;click Zone1 Zone in
	Actor["${ZoneEntrance.Get[${_IndexPosition}]}"]:DoubleClick
	wait 10
	
	
	RZObj:GetZoneLists
	wait 20
	variable int _ZCNT=0
	while ${RZObj.RowByName["${_Zone.Get[${_IndexPosition}]}"]}==0 && ${_ZCNT:Inc}<10
	{
		RZObj:GetZoneLists
		wait 5
	}
	if ${RZObj.RowByName["${_Zone.Get[${_IndexPosition}]}"]}==0
	{
		echo ISXRI: Can't find that zone in the Destination list
		Script:End
	}
	wait 10
	EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${RZObj.RowByName["${_Zone.Get[${_IndexPosition}]}"]}]
	wait 10
	
	;confirm selection and zone
	EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	
	;wait until we start zoning, or are unable to zone
	wait 6000 ${EQ2.Zoning} || ${UnableToZone} || ${InstanceExpired}
	
	;if we are unable to zone because someone is still locked, unlock again and return
	if ${UnableToZone}
	{
		;try again to unlock
		call RZObj.Unlock "${Zone1}"
		
		;set UnableToZone False
		UnableToZone:Set[FALSE]
		
		;exit function
		return
	}
	elseif ${InstanceExpired}
	{
		;wait 5s
		wait 50
		
		;wait until we are done zoning
		wait 6000 !${EQ2.Zoning}
		
		;set InstanceExpired false
		InstanceExpired:Set[FALSE]
		
		;exit function
		return
	}
	
	;wait until we are not zoning
	wait 6000 !${EQ2.Zoning}
	
	;wait until all the group is in the zone
	call RZObj.CheckAllHere
	
	;wait 5s
	wait 50
	
	;if we are not in the correct zone, exit function
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${_Zone.Get[${_IndexPosition}]}"]}
		return
		
	;run runinstances started
	ri
	wait 50
	RI_Var_Bool_Start:Set[TRUE]
	UIElement[Start@RI]:SetText[Pause]
	wait 50
	
	;if it was our last zone Stop RZ
	if ${RZ_Var_Int_Count}>=${UIElement[AddedZoneList@RZ].Items} && ${RZ_Var_Int_Loops}>=${UIElement[LoopCountTextEntry@RZ].Text} && !${UIElement[InfiniteLoopListCheckBox@RZ].Checked}
	{
		RZObj:Stop
		return
	}
	;while runinstances is running wait
	while ${Script[Buffer:RunInstances](exists)} || ${RZ_Var_Bool_Paused}
		wait 20
	wait 10
	
	;if we are not a developer and all zones first runs are done, exit script
	; if !${Developer} && ${Zone1FirstRunDone} && ${Zone2FirstRunDone} && ${Zone3FirstRunDone}
	; {
		; echo ${Time}: Full set complete please rerun rz
		; Script:End
	; }
	
	;wait until we have a zone open so we stay hidden.
	if ${RZObj.CheckAllZonesLocked}
		echo ${Time}: No Zones are Unlocked, Waiting to Zone Out
		
	while ${RZObj.CheckAllZonesLocked}
	{
		;call CheckZones function
		;call RZObj.CheckZones
		;echo ISXRI: ${Time}: Waiting until a zone is unlocked

		wait 50
	}
	
	;if we are more than // away from zone exit
	if ${Math.Distance[${Me.Loc},${ZoneExitLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>
		call RIMObj.Move ${ZoneExitLoc.Get[${_IndexPosition}]} 1 0 0 1 1 0 1 1
	
	wait 20
	
	;zoneout
	;relay "other ${RI_Var_String_RelayGroup}" -noredirect RZ 0 0 TRUE "${Zone1Exit}" "${Zone1}"
	call ZoneOut "${ZoneExit.Get[${_IndexPosition}]}" "${_Zone.Get[${_IndexPosition}]}"
}

function ZoneOut(string ZoneExit, string ZoneName)
{
	;while we are not zoning and in ${_Zone} keep clicking the exit
	relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
	wait 5
	;;;;changed to select last zone
	;select row 1
	;relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[1]
	;wait 5
	;confirm selection and zone
	;relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	;;;;;changed to select last zone
	
	relay ${RI_Var_String_RelayGroup} RIMUIObj:Door[ALL,0]
	wait 20
	while !${EQ2.Zoning} && ${Me.GetGameData[Self.ZoneName].Label.Equal["${ZoneName}"]}
	{
		relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
		wait 10
		if ${EQ2.Zoning}==0
		{
			if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
			{
				;;;;;changed to select last zone
				;select row 1
				;relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[1]
				;wait 5
				;confirm selection and zone
				;relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
				;;;;;changed to select last zone
	
				relay ${RI_Var_String_RelayGroup} RIMUIObj:Door[ALL,0]
			}
		}
		wait 20
	}
	;wait until we start zoning
	wait 6000 ${EQ2.Zoning}
	;wait until we are not zoning
	wait 6000 !${EQ2.Zoning}
	;wait until all the group is in the zone
	call RZObj.CheckAllHere
}

;RZObj object
objectdef RZObject
{
	method Save()
	{
		variable string SetName
		SetName:Set[Zones]
		LavishSettings[RZ]:Clear
		LavishSettings:AddSet[RZ]
		LavishSettings[RZ]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RZ/RZSave.xml"]
		LavishSettings[RZ]:AddSet[${SetName}]
		LavishSettings[RZ].FindSet[${SetName}]:Clear
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[AddedZoneList@RZ].Items};count:Inc)
		{
			LavishSettings[RZ].FindSet[${SetName}]:AddSetting["${UIElement[AddedZoneList@RZ].OrderedItem[${count}].Text}",""]
		}
		LavishSettings[RZ]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RZ/RZSave.xml"]
	}
	method LoadSave()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RZ/"]
		variable settingsetref RZSet
		if ${FP.FileExists[RZSave.xml]}
		{
			LavishSettings[Zones]:Clear
			LavishSettings:AddSet[Zones]
			LavishSettings[Zones]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RZ/RZSave.xml"]
			RZSet:Set[${LavishSettings[Zones].GUID}]
			variable settingsetref LoadListSet=${RZSet.FindSet[Zones].GUID}
			LoadListSet:Set[${RZSet.FindSet[Zones].GUID}]
			
			variable iterator SettingIterator
			LoadListSet:GetSettingIterator[SettingIterator]
			if ${SettingIterator:First(exists)}
			{
				do
				{
					;;echo "${SettingIterator.Key}=${SettingIterator.Value}"
					UIElement[AddedZoneList@RZ]:AddItem["${SettingIterator.Key}"]
				}
				while ${SettingIterator:Next(exists)}
			}
		}
	}
	method Start()
	{
		if ${UIElement[AddedZoneList@RZ].Items}<1
			return
		UIElement[StartButton@RZm]:SetText[Pause]
		UIElement[StartButton@RZm]:SetFocus
		UIElement[AddedZoneList@RZ]:ClearSelection
		UIElement[ZonesAvail@RZ]:ClearSelection
		RZ_Var_Int_Loops:Set[1]
		RZ_Var_Bool_Start:Set[1]
		This:Minimize
	}
	method Stop()
	{
		UIElement[StartButton@RZm]:SetText[Start]
		RZ_Var_Bool_Start:Set[0]
		This:Maximize
	}
	method Pause()
	{
		UIElement[StartButton@RZm]:SetText[Resume]
		RZ_Var_Bool_Paused:Set[1]
		Script:Pause
	}
	method Resume()
	{
		Script:Resume
		UIElement[StartButton@RZm]:SetText[Pause]
		RZ_Var_Bool_Paused:Set[0]
	}
	method Maximize()
	{
		UIElement[MinButton@RZm]:SetText[Minimize]
		UIElement[RZ]:Show
	}
	method Minimize()
	{
		UIElement[MinButton@RZm]:SetText[Maximize]
		UIElement[RZ]:Hide
	}
	member:int ZoneIndexPosition(string _ZoneName)
	{
		variable int _count2
		;find the zone in our index's
		for(_count2:Set[1];${_count2}<=${_Zone.Used};_count2:Inc)
		{
			if ${_Zone.Get[${_count2}].Equal["${_ZoneName}"]}
			{
				return ${_count2}
			}
		}
		return 0
	}
	method AddZone(string _ZoneName)
	{
		;echo ${_ZoneName}
		if ${_ZoneName.NotEqual[""]} && ${_ZoneName.NotEqual[NULL]}
			UIElement[AddedZoneList@RZ]:AddItem["${_ZoneName}"]
	}
	
	;CheckZones function
	function CheckZones()
	{
		variable int _count
		variable int _count2
		;check the list of added zones for locks  
		;go through our list and find the zones that are unlocked
		for(_count:Set[1];${_count}<=${UIElement[AddedZoneList@RZ].Items};_count:Inc)
		{
			;find each zone in our index's
			for(_count2:Set[1];${_count2}<=${_Zone.Used};_count2:Inc)
			{
				if ${_Zone.Get[${_count2}].Equal["${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}"]}
				{
					;echo Checking ${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]} is Unlocked: ${RZObj.Unlocked[${ZoneSetTime.Get[${_count2}]},${ZoneUnlockTime.Get[${_count2}]}]} && ${ZoneSetTime.Get[${_count2}]}!=0
					if !${ZoneUnlocked.Get[${_count2}]} && ${ZoneSetTime.Get[${_count2}]}!=0
					{
						;echo ISXRI: ${Time}: ${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}, Unlocked: ${RZObj.Unlocked[${ZoneUnlockTime.Get[${_count2}]},${ZoneSetTime.Get[${_count2}]}]}
						if ${RZObj.Unlocked[${ZoneSetTime.Get[${_count2}]},${ZoneUnlockTime.Get[${_count2}]}]}
							call RZObj.Unlock "${_Zone.Get[${_count2}]}"
					}
				}
			}
		}
	}
	
	member:bool _CheckAllHere()
	{
		variable bool _AllHere
		
		variable int _count
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		return ${_AllHere}
	}
	function CheckAllHere()
	{
		while !${This._CheckAllHere}
		{
			wait 10
		}
	}
	member:bool CheckAllZonesUnlocked()
	{
		variable bool _AllUnLocked
		variable int _count
		variable int _count2
		_AllUnLocked:Set[TRUE]
		;check the list of added zones for locks  
		;go through our list and find the zones that are unlocked
		for(_count:Set[1];${_count}<=${UIElement[AddedZoneList@RZ].Items};_count:Inc)
		{
			;find each zone in our index's
			for(_count2:Set[1];${_count2}<=${_Zone.Used};_count2:Inc)
			{
				if ${_Zone.Get[${_count2}].Equal["${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}"]}
				{
					if !${ZoneUnlocked.Get[${_count2}]}
						_AllUnLocked:Set[FALSE]
				}
			}
		}
		return ${_AllUnLocked}
	}
	member:bool CheckAllZonesLocked()
	{
		variable bool _AllLocked
		variable int _count
		variable int _count2
		_AllLocked:Set[TRUE]
		;check the list of added zones for locks  
		;go through our list and find the zones that are unlocked
		for(_count:Set[1];${_count}<=${UIElement[AddedZoneList@RZ].Items};_count:Inc)
		{
			;find each zone in our index's
			for(_count2:Set[1];${_count2}<=${_Zone.Used};_count2:Inc)
			{
				if ${_Zone.Get[${_count2}].Equal["${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}"]}
				{
					if ${ZoneUnlocked.Get[${_count2}]} || ${RZObj.Unlocked[${ZoneSetTime.Get[${_count2}]},${ZoneUnlockTime.Get[${_count2}]}]}
						_AllLocked:Set[FALSE]
				}
			}
		}
		return ${_AllLocked}
	}
	variable index:string ZoneList
	method GetZoneLists()
	{
		variable index:collection:string _Zones
		variable iterator _ZonesIterator

		EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:GetOptions[_Zones]

		ZoneList:Clear
		
		_Zones:GetIterator[_ZonesIterator]
		if ${_ZonesIterator:First(exists)}
		{
			do
			{
				ZoneList:Insert["${_ZonesIterator.Value.Element[text]}"]
			}
			while ${_ZonesIterator:Next(exists)}
		}
	}
	member(int) RowByName(string _ZoneName)
	{
		variable iterator _ZonesIterator
		ZoneList:GetIterator[_ZonesIterator]
		if ${_ZonesIterator:First(exists)}
		{
			do
			{
				if ${_ZonesIterator.Value.Upper.Find["${_ZoneName.Upper}"](exists)}
					return ${_ZonesIterator.Key}
			}
			while ${_ZonesIterator:Next(exists)}
		}
		return 0
	}
	;check current seconds since midnight against locktimer return true or false
	member:bool Unlocked(int SecondsSinceMidnightTheZoneWasSetAt, int UnlockTime)
	{
		;set the unlock time 5400=1.5 hours, 21600=6 hours

		;echo ${Time}: Checking ${SecondsSinceMidnightTheZoneWasSetAt}
		if ${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${UnlockTime}]}<86400
		{
			;echo ${Time} Reset timer is not past midnight
			
			if ${Time.SecondsSinceMidnight}>${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${UnlockTime}]}
				return TRUE
			else
				return FALSE
			;return ${Time.SecondsSinceMidnight}>${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${UnlockTime}]}

		}
		else
		{
			;echo ${Time} Reset timer is past midnight
			
			if ${Time.SecondsSinceMidnight}>${UnlockTime}
				return FALSE
			else
			{
				if ${Time.SecondsSinceMidnight}>${Math.Calc[${UnlockTime}-(86400-${SecondsSinceMidnightTheZoneWasSetAt})]}
					return TRUE
				else
					return FALSE
			}
		}
	}

	;open then close the zone timers window then, unlock zone ZoneName, 
	;wait 5 seconds or until confirmation is seen
	function Unlock(string ZoneName)
	{	
		echo ${Time}: Unlocking ${ZoneName}
		relay ${RI_Var_String_RelayGroup} eq2ex togglezonereuse
		wait 5
		relay ${RI_Var_String_RelayGroup} eq2ex togglezonereuse
		wait 5
		relay ${RI_Var_String_RelayGroup} Me:ResetZoneTimer["${ZoneName}"]
		wait 50 ${ResetConfirmation}
		ResetConfirmation:Set[FALSE]
	}
}

function MoveC(float X1, float Z1)
{
	wait 20
	;start group following
	;call RIMObj.follow
	wait 5
	echo ${Time}: Moving to ${X1} ${Z1}
	
	;set lock spot to X1 Z1
	RI_Atom_SetLockSpot ${Me.Name} ${X1} 0 ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>3
	{
		waitframe
	}
}

function atexit()
{
	if !${DontEchoExit}
	{
		echo ISXRI: ${Time}: Ending RZ
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml"
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RZm.xml"
	}
	Squelch press -release ${RI_Var_String_ForwardKey}
	Squelch press -release ${RI_Var_String_BackwardKey}
	Squelch press -release ${RI_Var_String_FlyUpKey}
	if ${Me.IsMoving}
	{
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
	}
	press -release ${RI_Var_String_StrafeLeftKey}
	press -release ${RI_Var_String_StrafeRightKey}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
}