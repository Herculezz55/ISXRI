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
variable index:string AddedZonesList
variable index:string _PathFile
variable bool _SoloMode=FALSE
variable bool _HeroicMode=FALSE
variable(global) bool RZ_Var_Bool_Start=FALSE
variable(global) bool RZ_Var_Bool_Paused=FALSE
variable(global) string RZ_Var_String_ZoneVersion=FALSE
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
variable bool START=FALSE
variable bool SOLO=FALSE
variable bool HEROIC=FALSE
variable bool NORESET=FALSE
variable bool RESETALLZONES=FALSE

atom BuildIndexes(string _Expac)
{
	;variable string _IndexBuilder
	;Clear Zone
	_Zone:Clear
	UIElement[ZonesAvail@RZ]:ClearItems
	ZoneFrom:Clear
	ZoneTimer:Clear
	ZoneExit:Clear
	ZoneExitPopupSelection:Clear
	ZoneExitLoc:Clear
	ZoneEntrance:Clear
	ZoneEntranceLoc:Clear
	ZonePathFile:Clear
	ZoneUnlocked:Clear
	ZoneSetTime:Clear
	ZoneUnlockTime:Clear
	
	switch ${_Expac}
	{
		case Planes of Prophecy
		{
			;Zone
			_Zone:Insert["Plane of Innovation: Masks of the Marvelous [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Masks of the Marvelous [Solo]"]
			ZoneFrom:Insert["Coliseum of Valor"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["zone_to_valor"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poi"]
			ZoneEntranceLoc:Insert[-94.540001 2.940000 163.660004]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Plane of Innovation: Parts Not Included [Duo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Parts Not Included [Duo]"]
			ZoneFrom:Insert["Coliseum of Valor"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["zone_to_valor"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
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
			ZoneExitLoc:Insert[""]
			ZoneExitPopupSelection:Insert[0]
			ZoneEntrance:Insert["GUKPORTALCHANGE"]
			ZoneEntranceLoc:Insert[-812.901123 343.110931 1083.182495]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			break
		}
		case Chaos Descending
		{
			;Zone
			_Zone:Insert["Doomfire: The Enkindled Towers [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: The Enkindled Towers [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: The Enkindled Towers [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: The Enkindled Towers [Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: The Enkindled Towers [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: The Enkindled Towers [Expert]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: Elements of Rage [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: Elements of Rage [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: Elements of Rage [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: Elements of Rage [Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: Elements of Rage [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: Elements of Rage [Expert]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: Vengeance of Ro [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: Vengeance of Ro [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: Vengeance of Ro [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: Vengeance of Ro [Event Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Doomfire: Vengeance of Ro [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Doomfire: Vengeance of Ro [Expert Event]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pof"]
			ZoneEntranceLoc:Insert[729.217346 412.283264 -338.457703]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: The Bixel Hive [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: The Bixel Hive [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: The Bixel Hive [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: The Bixel Hive [Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: The Bixel Hive [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: The Bixel Hive [Expert]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: The Midnight Aerie [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: The Midnight Aerie [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: Trials of Air [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: Trials of Air [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: Trials of Air [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: Trials of Air [Event Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Eryslai: Trials of Air [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Eryslai: Trials of Air [Expert Event]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poa"]
			ZoneEntranceLoc:Insert[715.467041 412.379913 -379.292023]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: The Nebulous Deep [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: The Nebulous Deep [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: The Nebulous Deep [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: The Nebulous Deep [Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: The Nebulous Deep [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: The Nebulous Deep [Expert]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: Marr's Ascent [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: Marr's Ascent [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: Marr's Ascent [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: Marr's Ascent [Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: Marr's Ascent [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: Marr's Ascent [Expert]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: The Veiled Precipice [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: The Veiled Precipice [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: The Veiled Precipice [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: The Veiled Precipice [Event Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Awuidor: The Veiled Precipice [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Awuidor: The Veiled Precipice [Expert Event]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_pow"]
			ZoneEntranceLoc:Insert[785.015198 412.282745 -379.708893]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Vegarlson: The Terrene Rift [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Vegarlson: The Terrene Rift [Solo]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poe"]
			ZoneEntranceLoc:Insert[773.789978 412.399994 -336.390015]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]	
			
			;Zone
			_Zone:Insert["Vegarlson: The Terrene Rift [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Vegarlson: The Terrene Rift [Event Heroic]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poe"]
			ZoneEntranceLoc:Insert[773.789978 412.399994 -336.390015]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]	
			
			;Zone
			_Zone:Insert["Vegarlson: The Terrene Rift [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Vegarlson: The Terrene Rift [Expert Event]"]
			ZoneFrom:Insert["Myrist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_poe"]
			ZoneEntranceLoc:Insert[773.789978 412.399994 -336.390015]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]	
			
			break
		}
		case Blood of Luclin
		{
			;Zone
			_Zone:Insert["The Icy Keep (Hard)"]
			UIElement[ZonesAvail@RZ]:AddItem["The Icy Keep (Hard)"]
			ZoneFrom:Insert["Frostfell Wonderland Village"]
			ZoneTimer:Insert[5]
			ZoneExit:Insert["!NONE!"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["The Icy Door"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[300]

			;Zone
			_Zone:Insert["Sanctus Seru: Echelon of Order [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Echelon of Order [Solo]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Sanctus Seru dungeons 1 and 2"]
			ZoneEntranceLoc:Insert[-280.440002 180.720001 0.310000]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Sanctus Seru: Echelon of Order [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Echelon of Order [Heroic]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Sanctus Seru dungeons 1 and 2"]
			ZoneEntranceLoc:Insert[-280.440002 180.720001 0.310000]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Sanctus Seru: Echelon of Order [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Echelon of Order [Expert]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Sanctus Seru dungeons 1 and 2"]
			ZoneEntranceLoc:Insert[-280.440002 180.720001 0.310000]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Sanctus Seru: Echelon of Divinity [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Echelon of Divinity [Solo]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Sanctus Seru dungeons 1 and 2"]
			ZoneEntranceLoc:Insert[-280.440002 180.720001 0.310000]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Sanctus Seru: Echelon of Divinity [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Echelon of Divinity [Heroic]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Sanctus Seru dungeons 1 and 2"]
			ZoneEntranceLoc:Insert[-280.440002 180.720001 0.310000]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Sanctus Seru: Echelon of Divinity [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Echelon of Divinity [Expert]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Sanctus Seru dungeons 1 and 2"]
			ZoneEntranceLoc:Insert[-280.440002 180.720001 0.310000]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Sanctus Seru: Arx Aeturnus [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Arx Aeturnus [Solo]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Arx Seru"]
			ZoneEntranceLoc:Insert[-193.214371 188.161240 -0.116349]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Sanctus Seru: Arx Aeturnus [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Arx Aeturnus [Event Heroic]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Arx Seru"]
			ZoneEntranceLoc:Insert[-193.214371 188.161240 -0.116349]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Sanctus Seru: Arx Aeturnus [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sanctus Seru: Arx Aeturnus [Expert]"]
			ZoneFrom:Insert["Sanctus Seru [City]"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Arx Seru"]
			ZoneEntranceLoc:Insert[-193.214371 188.161240 -0.116349]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Aurelian Coast: Sambata Village [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Sambata Village [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Aurelian Coast: Sambata Village [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Sambata Village [Heroic]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Aurelian Coast: Sambata Village [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Sambata Village [Expert]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Aurelian Coast: Reishi Rumble [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Reishi Rumble [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Aurelian Coast: Reishi Rumble [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Reishi Rumble [Event Heroic]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Aurelian Coast: Reishi Rumble [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Reishi Rumble [Expert]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Aurelian Coast: Maiden's Eye [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Maiden's Eye [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Aurelian Coast: Maiden's Eye [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Maiden's Eye [Heroic]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Aurelian Coast: Maiden's Eye [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Aurelian Coast: Maiden's Eye [Expert]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Zone exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Aurelian Coast dungeons"]
			ZoneEntranceLoc:Insert["113.527733 66.510788 -622.734680|113.730003 57.369999 -657.119995"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Fordel Midst: The Listless Spires [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: The Listless Spires [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Fordel Midst: The Listless Spires [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: The Listless Spires [Event Heroic]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Fordel Midst: The Listless Spires [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: The Listless Spires [Expert]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Fordel Midst: Wayward Manor [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: Wayward Manor [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Fordel Midst: Wayward Manor [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: Wayward Manor [Heroic]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Fordel Midst: Wayward Manor [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: Wayward Manor [Expert]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Fordel Midst: Bizarre Bazaar [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: Bizarre Bazaar [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Fordel Midst: Bizarre Bazaar [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: Bizarre Bazaar [Heroic]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["Fordel Midst: Bizarre Bazaar [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: Bizarre Bazaar [Expert]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Aurelian Coast"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_to_fordel_midst"]
			ZoneEntranceLoc:Insert["156.307556 62.435265 -628.752502|168.404755 62.078152 -642.211670|188.893372 62.086693 -663.790283|169.061646 61.921852 -682.376831"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["The Ruins of Ssraeshza [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Ruins of Ssraeshza [Solo]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["The Ruins of Ssraeshza [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Ruins of Ssraeshza [Heroic]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["The Ruins of Ssraeshza [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Ruins of Ssraeshza [Expert]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["The Venom of Ssraeshza [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Venom of Ssraeshza [Solo]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["The Venom of Ssraeshza [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Venom of Ssraeshza [Event Heroic]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["The Venom of Ssraeshza [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Venom of Ssraeshza [Expert]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["The Vault of Ssraeshza [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Vault of Ssraeshza [Solo]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["The Vault of Ssraeshza [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Vault of Ssraeshza [Heroic]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			_Zone:Insert["The Vault of Ssraeshza [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Vault of Ssraeshza [Expert]"]
			ZoneFrom:Insert["Wracklands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Ssraeshza dungeons"]
			ZoneEntranceLoc:Insert["726.553955 77.960899 664.743958"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			
			break
		}
		case Reign of Shadows
		{
			;Zone
			_Zone:Insert["Echo Caverns: Fungal Foray [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Fungal Foray [Solo]"]
			ZoneFrom:Insert["City of Fordel Midst"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Echo Caverns"]
			ZoneEntranceLoc:Insert["397.221436 -35.983528 748.467163"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Fungal Foray [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Fungal Foray [Heroic]"]
			ZoneFrom:Insert["City of Fordel Midst"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Echo Caverns"]
			ZoneEntranceLoc:Insert["397.221436 -35.983528 748.467163"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Fungal Foray [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Fungal Foray [Expert]"]
			ZoneFrom:Insert["City of Fordel Midst"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Echo Caverns"]
			ZoneEntranceLoc:Insert["397.221436 -35.983528 748.467163"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Quarry Quandary [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Quarry Quandary [Solo]"]
			ZoneFrom:Insert["City of Fordel Midst"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Echo Caverns"]
			ZoneEntranceLoc:Insert["397.221436 -35.983528 748.467163"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Quarry Quandary [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Quarry Quandary [Heroic]"]
			ZoneFrom:Insert["City of Fordel Midst"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Echo Caverns"]
			ZoneEntranceLoc:Insert["397.221436 -35.983528 748.467163"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Quarry Quandary [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Quarry Quandary [Expert]"]
			ZoneFrom:Insert["City of Fordel Midst"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Echo Caverns"]
			ZoneEntranceLoc:Insert["397.221436 -35.983528 748.467163"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Savage Weald: Chaotic Caverns [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Savage Weald: Chaotic Caverns [Solo]"]
			ZoneFrom:Insert["Savage Weald Chaotic Caverns"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["To Grimling Caves"]
			ZoneEntranceLoc:Insert["-896.098450 75.165260 -375.025940"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Savage Weald: Chaotic Caverns [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Savage Weald: Chaotic Caverns [Heroic]"]
			ZoneFrom:Insert["Savage Weald Chaotic Caverns"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["To Grimling Caves"]
			ZoneEntranceLoc:Insert["-896.098450 75.165260 -375.025940"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Savage Weald: Chaotic Caverns [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Savage Weald: Chaotic Caverns [Expert]"]
			ZoneFrom:Insert["Savage Weald Chaotic Caverns"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["To Grimling Caves"]
			ZoneEntranceLoc:Insert["-896.098450 75.165260 -375.025940"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Savage Weald: Fort Grim [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Savage Weald: Fort Grim [Solo]"]
			ZoneFrom:Insert["Savage Weald Fort Grim"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["To Fort Grim"]
			ZoneEntranceLoc:Insert["-81.374565 20.860985 -259.299744"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Savage Weald: Fort Grim [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Savage Weald: Fort Grim [Event Heroic]"]
			ZoneFrom:Insert["Savage Weald Fort Grim"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["To Fort Grim"]
			ZoneEntranceLoc:Insert["-81.374565 20.860985 -259.299744"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Savage Weald: Fort Grim [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Savage Weald: Fort Grim [Expert Event]"]
			ZoneFrom:Insert["Savage Weald Fort Grim"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["To Fort Grim"]
			ZoneEntranceLoc:Insert["-81.374565 20.860985 -259.299744"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Feral Reserve [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Feral Reserve [Solo]"]
			ZoneFrom:Insert["City of Shar Vahl Feral Reserve"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Shadeweaver's Thicket"]
			ZoneEntranceLoc:Insert["-357.383545 91.861389 179.837708"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Feral Reserve [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Feral Reserve [Heroic]"]
			ZoneFrom:Insert["City of Shar Vahl Feral Reserve"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Shadeweaver's Thicket"]
			ZoneEntranceLoc:Insert["-357.383545 91.861389 179.837708"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Feral Reserve [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Feral Reserve [Expert]"]
			ZoneFrom:Insert["City of Shar Vahl Feral Reserve"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Shadeweaver's Thicket"]
			ZoneEntranceLoc:Insert["-357.383545 91.861389 179.837708"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Untamed Lands [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Untamed Lands [Solo]"]
			ZoneFrom:Insert["City of Shar Vahl Untamed Lands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Shadeweaver's Thicket 02"]
			ZoneEntranceLoc:Insert["-139.178238 32.386150 244.650986"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Untamed Lands [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Untamed Lands [Heroic]"]
			ZoneFrom:Insert["City of Shar Vahl Untamed Lands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Shadeweaver's Thicket 02"]
			ZoneEntranceLoc:Insert["-139.178238 32.386150 244.650986"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Untamed Lands [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Untamed Lands [Expert]"]
			ZoneFrom:Insert["City of Shar Vahl Untamed Lands"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Shadeweaver's Thicket 02"]
			ZoneEntranceLoc:Insert["-139.178238 32.386150 244.650986"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Shar Vahl: Siege Break [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shar Vahl: Siege Break [Solo]"]
			ZoneFrom:Insert["Shadeweaver's Thicket"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to City of Shar Vahl"]
			ZoneEntranceLoc:Insert["-544.688782 161.518738 -753.726624"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shar Vahl: Siege Break [Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shar Vahl: Siege Break [Heroic]"]
			ZoneFrom:Insert["Shadeweaver's Thicket"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to City of Shar Vahl"]
			ZoneEntranceLoc:Insert["-544.688782 161.518738 -753.726624"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shar Vahl: Siege Break [Expert]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shar Vahl: Siege Break [Expert]"]
			ZoneFrom:Insert["Shadeweaver's Thicket"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to City of Shar Vahl"]
			ZoneEntranceLoc:Insert["-544.688782 161.518738 -753.726624"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Zelmie Sortie [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Zelmie Sortie [Solo]"]
			ZoneFrom:Insert["Echo Caverns"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Zelmie Sortie"]
			ZoneEntranceLoc:Insert["615.701111 25.766819 -439.633423"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Zelmie Sortie [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Zelmie Sortie [Event Heroic]"]
			ZoneFrom:Insert["Echo Caverns"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Zelmie Sortie"]
			ZoneEntranceLoc:Insert["615.701111 25.766819 -439.633423"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Echo Caverns: Zelmie Sortie [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Echo Caverns: Zelmie Sortie [Expert Event]"]
			ZoneFrom:Insert["Echo Caverns"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Zelmie Sortie"]
			ZoneEntranceLoc:Insert["615.701111 25.766819 -439.633423"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Loda Kai Isle [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Loda Kai Isle [Solo]"]
			ZoneFrom:Insert["Shadeweaver's Thicket Loda Kai Isle"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone to loda kai isle dungeon"]
			ZoneEntranceLoc:Insert["632.874634 13.072926 316.680420"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Loda Kai Isle [Event Heroic]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Loda Kai Isle [Event Heroic]"]
			ZoneFrom:Insert["Shadeweaver's Thicket Loda Kai Isle"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone to loda kai isle dungeon"]
			ZoneEntranceLoc:Insert["632.874634 13.072926 316.680420"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Shadeweaver's Thicket: Loda Kai Isle [Expert Event]"]
			UIElement[ZonesAvail@RZ]:AddItem["Shadeweaver's Thicket: Loda Kai Isle [Expert Event]"]
			ZoneFrom:Insert["Shadeweaver's Thicket Loda Kai Isle"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone to loda kai isle dungeon"]
			ZoneEntranceLoc:Insert["632.874634 13.072926 316.680420"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Vasty Deep: Toil and Trouble [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Vasty Deep: Toil and Trouble [Solo]"]
			ZoneFrom:Insert["Loping Plains"]
			ZoneTimer:Insert[1080]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Entrance"]
			ZoneEntranceLoc:Insert["-312.051636,15.470000,4.626971"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[64800]

			;Zone
			_Zone:Insert["Vasty Deep: Toil and Trouble [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Vasty Deep: Toil and Trouble [Heroic I]"]
			ZoneFrom:Insert["Loping Plains"]
			ZoneTimer:Insert[1080]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Entrance"]
			ZoneEntranceLoc:Insert["-312.051636,15.470000,4.626971"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[64800]

			;Zone
			_Zone:Insert["Vasty Deep: Toil and Trouble [Heroic II]"]
			UIElement[ZonesAvail@RZ]:AddItem["Vasty Deep: Toil and Trouble [Heroic II]"]
			ZoneFrom:Insert["Loping Plains"]
			ZoneTimer:Insert[1080]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Entrance"]
			ZoneEntranceLoc:Insert["-312.051636,15.470000,4.626971"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[64800]

			break
		}
		case Visions of Vetrovia
		{
			;Zone
			_Zone:Insert["Svarni Expanse: Carrion Crag [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Svarni Expanse: Carrion Crag [Solo]"]
			ZoneFrom:Insert["Svarni Expanse"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone to svarni dungeon 01"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Svarni Expanse: Carrion Crag [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Svarni Expanse: Carrion Crag [Heroic I]"]
			ZoneFrom:Insert["Svarni Expanse"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone to svarni dungeon 01"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Karuupa Jungle: Heart of Conflict [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Karuupa Jungle: Heart of Conflict [Solo]"]
			ZoneFrom:Insert["Karuupa Jungle Heart of Conflict"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Karuupa Jungle: Heart of Conflict dungeons"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			;Zone
			_Zone:Insert["Karuupa Jungle: Heart of Conflict [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Karuupa Jungle: Heart of Conflict [Heroic I]"]
			ZoneFrom:Insert["Karuupa Jungle Heart of Conflict"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Karuupa Jungle: Heart of Conflict dungeons"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Karuupa Jungle: Dedraka's Descent [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Karuupa Jungle: Dedraka's Descent [Solo]"]
			ZoneFrom:Insert["Karuupa Jungle Dedrakas Descent"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Karuupa Jungle: Dedraka's Descent dungeons"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Karuupa Jungle: Dedraka's Descent [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Karuupa Jungle: Dedraka's Descent [Heroic I]"]
			ZoneFrom:Insert["Karuupa Jungle Dedrakas Descent"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Karuupa Jungle: Dedraka's Descent dungeons"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Karuupa Jungle: Predator's Perch [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Karuupa Jungle: Predator's Perch [Solo]"]
			ZoneFrom:Insert["Karuupa Jungle Predators Perch"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Karuupa Jungle: Predator's Perch dungeons"]
			ZoneEntranceLoc:Insert[""]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Mahngavi Wastes: Phantasmal Shades [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Mahngavi Wastes: Phantasmal Shades [Solo]"]
			ZoneFrom:Insert["Mahngavi Wastes"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Mahngavi Heroics Doorit"]
			ZoneEntranceLoc:Insert["647.31 48.82 -445.64"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Mahngavi Wastes: Phantasmal Shades [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Mahngavi Wastes: Phantasmal Shades [Heroic I]"]
			ZoneFrom:Insert["Mahngavi Wastes"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Mahngavi Heroics Doorit"]
			ZoneEntranceLoc:Insert["647.31 48.82 -445.64"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Mahngavi Wastes: Warpwood Cairn [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Mahngavi Wastes: Warpwood Cairn [Solo]"]
			ZoneFrom:Insert["Mahngavi Wastes"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Mahngavi Heroics Doorit"]
			ZoneEntranceLoc:Insert["647.31 48.82 -445.64"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Mahngavi Wastes: Warpwood Cairn [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Mahngavi Wastes: Warpwood Cairn [Heroic I]"]
			ZoneFrom:Insert["Mahngavi Wastes"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Mahngavi Heroics Doorit"]
			ZoneEntranceLoc:Insert["647.31 48.82 -445.64"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]
			
			
			;Zone
			_Zone:Insert["Castle Vacrul: Rosy Reverie [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Castle Vacrul: Rosy Reverie [Solo]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Vacrul heroic and solo"]
			ZoneEntranceLoc:Insert["439.47 109.07 267.70"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Castle Vacrul: Rosy Reverie [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Castle Vacrul: Rosy Reverie [Heroic I]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Vacrul heroic and solo"]
			ZoneEntranceLoc:Insert["439.47 109.07 267.70"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Castle Vacrul: Caverns of the Forsaken [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Castle Vacrul: Caverns of the Forsaken [Solo]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Vacrul heroic and solo"]
			ZoneEntranceLoc:Insert["439.47 109.07 267.70"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Castle Vacrul: Caverns of the Forsaken [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Castle Vacrul: Caverns of the Forsaken [Heroic I]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Vacrul heroic and solo"]
			ZoneEntranceLoc:Insert["439.47 109.07 267.70"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Castle Vacrul: Suite of Screams [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Castle Vacrul: Suite of Screams [Solo]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Vacrul heroic and solo"]
			ZoneEntranceLoc:Insert["439.47 109.07 267.70"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Forlorn Gist: Nightmares of Old [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Forlorn Gist: Nightmares of Old [Solo]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Crypt of Forlorn"]
			ZoneEntranceLoc:Insert["460.81 109.83 249.52"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Forlorn Gist: Nightmares of Old [Heroic I]"]
			UIElement[ZonesAvail@RZ]:AddItem["Forlorn Gist: Nightmares of Old [Heroic I]"]
			ZoneFrom:Insert["Forlorn Gist"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Crypt of Forlorn"]
			ZoneEntranceLoc:Insert["460.81 109.83 249.52"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["The Merchant's Den [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["The Merchant's Den [Solo]"]
			ZoneFrom:Insert["Forlorn Gist Merchants Den"]
			ZoneTimer:Insert[1080]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["Zone to Merchant Den"]
			ZoneEntranceLoc:Insert["-289.55 53.67 -345.43"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[64800]

			break
		}
		case Renewal of Ro
		{
			;Raj'Dur Plateaus: The Sultan's Dagger [Signature]
			;_IndexBuilder:Set["Raj'Dur Plateaus: The Sultan's Dagger [Signature]"|"Raj'Dur Plateaus: The Sultan's Dagger [Signature]"|"Raj'Dur Plateaus The Sultan's Dagger"|90|"Exit"|0|""|"zone_portal_to_dun_plateaus_02"|""|0|TRUE|0|5400]
			
			;Zone
			_Zone:Insert["Raj'Dur Plateaus: Blood and Sand [Signature]"]
			UIElement[ZonesAvail@RZ]:AddItem["Raj'Dur Plateaus: Blood and Sand [Signature]"]
			ZoneFrom:Insert["Raj'Dur Plateaus Blood and Sand"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_dun_plateaus_01"]
			ZoneEntranceLoc:Insert["162.720001,-59.590000,477.339996"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Raj'Dur Plateaus: The Sultan's Dagger [Signature]"]
			UIElement[ZonesAvail@RZ]:AddItem["Raj'Dur Plateaus: The Sultan's Dagger [Signature]"]
			ZoneFrom:Insert["Raj'Dur Plateaus The Sultan's Dagger"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_dun_plateaus_02"]
			ZoneEntranceLoc:Insert["60.549999,87.639999,-349.829987"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Buried Takish'Hiz: Terrene Threshold [Signature]"]
			UIElement[ZonesAvail@RZ]:AddItem["Buried Takish'Hiz: Terrene Threshold [Signature]"]
			ZoneFrom:Insert["Raj'Dur Plateaus Buried Takish'Hiz"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_takish_dungeons"]
			ZoneEntranceLoc:Insert["-554.349976,10.960000,427.899994"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Buried Takish'Hiz: The Sacred Gift [Signature]"]
			UIElement[ZonesAvail@RZ]:AddItem["Buried Takish'Hiz: The Sacred Gift [Signature]"]
			ZoneFrom:Insert["Raj'Dur Plateaus Buried Takish'Hiz"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_takish_dungeons"]
			ZoneEntranceLoc:Insert["-554.349976,10.960000,427.899994"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Takish Badlands: Overgrowth [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Takish Badlands: Overgrowth [Solo]"]
			ZoneFrom:Insert["Takish Badlands Overgrowth"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_dun_takish_badlands_01"]
			ZoneEntranceLoc:Insert["742.023987,58.080002,42.790913"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Takish Badlands: Kigathor's Glade [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Takish Badlands: Kigathor's Glade [Solo]"]
			ZoneFrom:Insert["Takish Badlands Kigathor's Glade"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_dun_takish_badlands_02"]
			ZoneEntranceLoc:Insert["-394.227814,245.000000,213.808731"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Sandstone Delta: Eye of the Storm [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sandstone Delta: Eye of the Storm [Solo]"]
			ZoneFrom:Insert["Sandstone Delta Eye of the Storm"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["zone_exit_main"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_dun_sandstone_delta_01"]
			ZoneEntranceLoc:Insert["-47.570000,57.150002,160.699997"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			_Zone:Insert["Sandstone Delta: Eye of Night [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Sandstone Delta: Eye of Night [Solo]"]
			ZoneFrom:Insert["Sandstone Delta Eye of Night"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
			ZoneExitPopupSelection:Insert[0]
			ZoneExitLoc:Insert[""]
			ZoneEntrance:Insert["zone_portal_to_dun_sandstone_delta_02"]
			ZoneEntranceLoc:Insert["589.960022,113.050003,-631.919983"]
			ZonePathFile:Insert[0]
			ZoneUnlocked:Insert[TRUE]
			ZoneSetTime:Insert[0]
			ZoneUnlockTime:Insert[5400]

			;Zone
			;_Zone:Insert[""]
			;UIElement[ZonesAvail@RZ]:AddItem[""]
			;ZoneFrom:Insert[""]
			;ZoneTimer:Insert[90]
			;ZoneExit:Insert["Exit"]
			;ZoneExitPopupSelection:Insert[0]
			;ZoneExitLoc:Insert[""]
			;ZoneEntrance:Insert[""]
			;ZoneEntranceLoc:Insert[""]
			;ZonePathFile:Insert[0]
			;ZoneUnlocked:Insert[TRUE]
			;ZoneSetTime:Insert[0]
			;ZoneUnlockTime:Insert[5400]
			break
		}
	}

	
}
variable(global) int RZ_Var_Int_Count=1
function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	;if ${Devel.Equal[TRUE]}
	Developer:Set[TRUE]
	
	variable int Count=1
	variable string _ZoneNameFormatter
	; variable int _acnt=1
	; variable bool JustZone=0
	; variable string ZoneName
	; variable string ZoneExitActorName
	;load RI_AntiAFK
	relay all -noredirect RI_AntiAFK
	relay all -noredirect RG
	variable bool GotoArg=FALSE
	if ${args.Used}>0
	{
		variable string _argss
		variable int _acnt
		for(_acnt:Set[1];${_acnt}<=${args.Used};_acnt:Inc)
		{
			;echo args ${_acnt} : ${args[${_acnt}]}
			if ${args[${_acnt}].Left[1].Equal[-]}
			{
				switch ${args[${_acnt}].Upper}
				{
					case -START
					{
						START:Set[1]
						break
					}
					case -RESETALLZONES
					{
						RESETALLZONES:Set[1]
						break
					}
					case -NORESET
					{
						NORESET:Set[1]
						break
					}
					case -SOLO
					{
						SOLO:Set[1]
						break
					}
					case -HEROIC
					{
						HEROIC:Set[1]
						break
					}
				}
			}
			else
			{
				GotoArg:Set[1]
				if ${_acnt}>1
					_argss:Concat[" "]
				_argss:Concat["${args[${_acnt}]}"]
			}
		}
		if ${GotoArg}
		{
			call Goto "${_argss}"
			return
		}
	}
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
	UIElement[ExpacComboBox@RZ]:AddItem["Renewal of Ro"]
	UIElement[ExpacComboBox@RZ]:AddItem["Visions of Vetrovia"]
	UIElement[ExpacComboBox@RZ]:AddItem["Reign of Shadows"]
	UIElement[ExpacComboBox@RZ]:AddItem["Blood of Luclin"]
	UIElement[ExpacComboBox@RZ]:AddItem["Chaos Descending"]
	UIElement[ExpacComboBox@RZ]:AddItem["Planes of Prophecy"]
	UIElement[ExpacComboBox@RZ]:SelectItem[1]
	BuildIndexes "Renewal of Ro"
	
	;start RIMovement if it is not running
	relay all -noredirect ${If[!${Script[Buffer:RIMovement](exists)},RIMovement,noop]}
	variable bool ZonesReset=FALSE
	;wait until start is pushed

	if ${SOLO}
	{
		RZObj:Solo
		wait 1
	}
	if ${HEROIC}
	{
		RZObj:Heroic
		wait 1
	}
	if ${START}
	{
		RZObj:Start
		wait 1
	}
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
		
		if ${RESETALLZONES} && !${NORESET}
		{
			relay ${RI_Var_String_RelayGroup} RIMUIObj:ResetAllZones[ALL]
		}
		else
		{
			if !${ZonesReset} && !${NORESET}
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
				relay "${RI_Var_String_RelayGroup}" eq2ex togglezonereuse
				wait 5
				relay "${RI_Var_String_RelayGroup}" eq2ex togglezonereuse
				wait 5
				;if Zone is unlocked run it
				for(RZ_Var_Int_Count:Set[1];${RZ_Var_Int_Count}<=${UIElement[AddedZoneList@RZ].Items};RZ_Var_Int_Count:Inc)
				{
					if ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["[Expert]"]} && ( ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Reishi Rumble"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Listless Spires"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Arx Aeturnus"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["The Venom of Ssraeshza"]} )
						_ZoneNameFormatter:Set["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.ReplaceSubstring["[Expert]","[Event Heroic]"]}"]
					elseif ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["[Expert]"]}
						_ZoneNameFormatter:Set["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.ReplaceSubstring["[Expert]","[Heroic]"]}"]
					elseif ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["[Challenge]"]} && ( ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Reishi Rumble"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Listless Spires"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Arx Aeturnus"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["The Venom of Ssraeshza"]} )
						_ZoneNameFormatter:Set["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.ReplaceSubstring["[Challenge]","[Event Heroic]"]}"]
					elseif ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["[Challenge]"]}
						_ZoneNameFormatter:Set["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.ReplaceSubstring["[Challenge]","[Heroic]"]}"]
					elseif ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Equal["The Icy Keep (Hard)"]}
						_ZoneNameFormatter:Set["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.ReplaceSubstring[" (Hard)",""]}"]
					else
						_ZoneNameFormatter:Set["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]
					echo Reseting: ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]} as ${_ZoneNameFormatter}
					relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${_ZoneNameFormatter}"]
					wait 3
					relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${_ZoneNameFormatter}"]
					wait 3
					relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${_ZoneNameFormatter}"]
					wait 3
					relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${_ZoneNameFormatter}"]
					wait 3
					relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${_ZoneNameFormatter}"]
					wait 3
					relay "${RI_Var_String_RelayGroup}" Me:ResetZoneTimer["${_ZoneNameFormatter}"]
					wait 5
				}
				ZonesReset:Set[1]
			}
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
				;echo \${ZoneUnlocked.Get[${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}]}"]}]}
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
		echo ${_Zone.Get[${_count}]} // ${ZoneUnlocked.Get[${_count}]} // ${ZoneSetTime.Get[${_count}]} // ${ZoneUnlockTime.Get[${_count}]} // Unlocks in ${Math.Calc[((${ZoneSetTime.Get[${_count}]}+${ZoneUnlockTime.Get[${_count}]})-${Time.SecondsSinceMidnight})/60]} mins
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
			;The Icey Keep (Hard)
			if ${Text.Find["${_Zone.Get[${_count}].ReplaceSubstring[" (Hard)",""]}"]}
			{
				echo ISXRI: ${Time}: Succesfully Reset ${_Zone.Get[${_count}]}
				ZoneSetTime.Get[${_count}]:Set[0]
				ZoneUnlocked.Get[${_count}]:Set[TRUE]
			}
			if ${Text.Find["${_Zone.Get[${_count}]}"]} || ${Text.Find["${_Zone.Get[${_count}].ReplaceSubstring[" (Hard)",""]}"]}
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
function BuyFromVendor(string _VendorName, string _Item, int _Qty)
{
	if ${_Qty}<1
		return
	wait 10
	RI_CMD_PauseCombatBots 1
	wait 5
	variable int _failcnt=0
	while ${Target.ID}!=${Actor["${_VendorName}"].ID} && ${_failcnt:Inc}<150
	{
		Actor["${_VendorName}"]:DoTarget
		Actor[${_VendorName}]:DoTarget
		wait 2
	}
	_failcnt:Set[0]
	while !${MerchantWindow.IsVisible} && ${_failcnt:Inc}<150
	{
		Actor["${_VendorName}"]:DoubleClick
		Actor[${_VendorName}]:DoubleClick
		wait 5
	}
	wait 5
	MerchantWindow.MerchantInventory["${_Item}"]:Buy[${_Qty}]
	wait 5
	RI_CMD_PauseCombatBots 0
}
function BuyBauble(string _VendorName, string _Which)
{
	variable int GUCnt=0
	GUCnt:Set[0]
	while ${RIMUIObj.InventoryQuantity["${_Which}"]}<20 && ${GUCnt:Inc}<10
		call BuyFromVendor "${_VendorName}" "${_Which}" ${Math.Calc[20-${RIMUIObj.InventoryQuantity["${_Which}"]}].Precision[0]}
}
function Goto(string _WhereToGo)
{
	;echo ${_WhereToGo}
	wait 10
	if ${_WhereToGo.Upper.Equal[RP]}
	{
		_WhereToGo:Set["Raj'Dur Plateaus"]
		relay "other ${RI_Var_String_RelayGroup}" RZ RPO
	}
	if ${_WhereToGo.Upper.Equal[RPO]}
	{
		_WhereToGo:Set["Raj'Dur Plateaus"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[RPBS]}
	{
		_WhereToGo:Set["Raj'Dur Plateaus Blood and Sand"]
		relay "other ${RI_Var_String_RelayGroup}" RZ RPO
	}
	if ${_WhereToGo.Upper.Equal[RPTSD]}
	{
		_WhereToGo:Set["Raj'Dur Plateaus The Sultan's Dagger"]
		relay "other ${RI_Var_String_RelayGroup}" RZ RPO
	}
	if ${_WhereToGo.Upper.Equal[RPBT]}
	{
		_WhereToGo:Set["Raj'Dur Plateaus Buried Takish'Hiz"]
		relay "other ${RI_Var_String_RelayGroup}" RZ RPO
	}
	if ${_WhereToGo.Upper.Equal[TB]}
	{
		_WhereToGo:Set["Takish Badlands"]
		relay "other ${RI_Var_String_RelayGroup}" RZ TBO
	}
	if ${_WhereToGo.Upper.Equal[TBO]}
	{
		_WhereToGo:Set["Takish Badlands"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[TBKG]}
	{
		_WhereToGo:Set["Takish Badlands Kigathor's Glade"]
		relay "other ${RI_Var_String_RelayGroup}" RZ TBO
	}
	if ${_WhereToGo.Upper.Equal[TBOG]}
	{
		_WhereToGo:Set["Takish Badlands Overgrowth"]
		relay "other ${RI_Var_String_RelayGroup}" RZ TBO
	}
	if ${_WhereToGo.Upper.Equal[SD]}
	{
		_WhereToGo:Set["Sandstone Delta"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SDO
	}
	if ${_WhereToGo.Upper.Equal[SDO]}
	{
		_WhereToGo:Set["Sandstone Delta"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[SDES]}
	{
		_WhereToGo:Set["Sandstone Delta Eye of the Storm"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SDO
	}
	if ${_WhereToGo.Upper.Equal[SDEN]}
	{
		_WhereToGo:Set["Sandstone Delta Eye of Night"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SDO
	}
	if ${_WhereToGo.Upper.Equal[MWG]}
	{
		_WhereToGo:Set["Mahngavi Wastes Ghoulinda"]
	}
	if ${_WhereToGo.Upper.Equal[SE]}
	{
		_WhereToGo:Set["Svarni Expanse"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SEO
	}
	if ${_WhereToGo.Upper.Equal[SEO]}
	{
		_WhereToGo:Set["Svarni Expanse"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[KJDD]}
	{
		_WhereToGo:Set["Karuupa Jungle Dedrakas Descent"]
		relay "other ${RI_Var_String_RelayGroup}" RZ KJO
	}
	if ${_WhereToGo.Upper.Equal[KJHC]}
	{
		_WhereToGo:Set["Karuupa Jungle Heart of Conflict"]
		relay "other ${RI_Var_String_RelayGroup}" RZ KJO
	}
	if ${_WhereToGo.Upper.Equal[KJPP]}
	{
		_WhereToGo:Set["Karuupa Jungle Predators Perch"]
		relay "other ${RI_Var_String_RelayGroup}" RZ KJO
	}
	if ${_WhereToGo.Upper.Equal[KJ]}
	{
		_WhereToGo:Set["Karuupa Jungle"]
	}
	if ${_WhereToGo.Upper.Equal[KJO]}
	{
		_WhereToGo:Set["Karuupa Jungle"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[MW]}
	{
		_WhereToGo:Set["Mahngavi Wastes"]
		relay "other ${RI_Var_String_RelayGroup}" RZ MWO
	}
	if ${_WhereToGo.Upper.Equal[MWO]}
	{
		_WhereToGo:Set["Mahngavi Wastes"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[FG]}
	{
		_WhereToGo:Set["Forlorn Gist"]
		relay "other ${RI_Var_String_RelayGroup}" RZ FGO
	}
	if ${_WhereToGo.Upper.Equal[FGO]}
	{
		_WhereToGo:Set["Forlorn Gist"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[FGMD]}
	{
		_WhereToGo:Set["Forlorn Gist Merchants Den"]
		relay "other ${RI_Var_String_RelayGroup}" RZ FGMDO
	}
	if ${_WhereToGo.Upper.Equal[FGMDO]}
	{
		_WhereToGo:Set["Forlorn Gist Merchants Den"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[B]}
	{
		_WhereToGo:Set["Baubles"]
		relay "other ${RI_Var_String_RelayGroup}" RZ B
	}
	if ${_WhereToGo.Upper.Equal[AC]}
	{
		_WhereToGo:Set["Aurelian Coast"]
		relay "other ${RI_Var_String_RelayGroup}" RZ ACO
	}
	if ${_WhereToGo.Upper.Equal[SSC]}
	{
		_WhereToGo:Set["Sanctus Seru [City]"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SSCO
	}
	if ${_WhereToGo.Upper.Equal[WL]}
	{
		_WhereToGo:Set["Wracklands"]
		relay "other ${RI_Var_String_RelayGroup}" RZ WLO
	}
	if ${_WhereToGo.Upper.Equal[ACO]}
	{
		_WhereToGo:Set["Aurelian Coast"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[SSCO]}
	{
		_WhereToGo:Set["Sanctus Seru [City]"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[WLO]}
	{
		_WhereToGo:Set["Wracklands"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[SVO]}
	{
		_WhereToGo:Set["City of Shar Vahl"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[SV]}
	{
		_WhereToGo:Set["City of Shar Vahl"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SVO
	}
	if ${_WhereToGo.Upper.Equal[SVUL]}
	{
		_WhereToGo:Set["City of Shar Vahl Untamed Lands"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SVO
	}
	if ${_WhereToGo.Upper.Equal[SVFR]}
	{
		_WhereToGo:Set["City of Shar Vahl Feral Reserve"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SVO
	}
	if ${_WhereToGo.Upper.Equal[SWO]}
	{
		_WhereToGo:Set["Savage Weald"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[SW]}
	{
		_WhereToGo:Set["Savage Weald"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SWO
	}
	if ${_WhereToGo.Upper.Equal[SWFG]}
	{
		_WhereToGo:Set["Savage Weald Fort Grim"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SWO
	}
	if ${_WhereToGo.Upper.Equal[SWCC]}
	{
		_WhereToGo:Set["Savage Weald Chaotic Caverns"]
		relay "other ${RI_Var_String_RelayGroup}" RZ SWO
	}
	if ${_WhereToGo.Upper.Equal[FMO]}
	{
		_WhereToGo:Set["City of Fordel Midst"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[FM]}
	{
		_WhereToGo:Set["City of Fordel Midst"]
		relay "other ${RI_Var_String_RelayGroup}" RZ FMO
	}
	if ${_WhereToGo.Upper.Equal[STO]}
	{
		_WhereToGo:Set["Shadeweaver's Thicket"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[ST]}
	{
		_WhereToGo:Set["Shadeweaver's Thicket"]
		relay "other ${RI_Var_String_RelayGroup}" RZ STO
	}
	if ${_WhereToGo.Upper.Equal[STLKI]}
	{
		_WhereToGo:Set["Shadeweaver's Thicket Loda Kai Isle"]
		relay "other ${RI_Var_String_RelayGroup}" RZ STO
	}
	if ${_WhereToGo.Upper.Equal[ECO]}
	{
		_WhereToGo:Set["Echo Caverns"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[EC]}
	{
		_WhereToGo:Set["Echo Caverns"]
		relay "other ${RI_Var_String_RelayGroup}" RZ ECO
	}
	if ${_WhereToGo.Upper.Equal[LPO]}
	{
		_WhereToGo:Set["Loping Plains"]
		Others:Set[TRUE]
	}
	if ${_WhereToGo.Upper.Equal[LP]}
	{
		_WhereToGo:Set["Loping Plains"]
		relay "other ${RI_Var_String_RelayGroup}" RZ LPO
	}
	variable string _WhereToGoShort
	_WhereToGoShort:Set["${_WhereToGo.Replace[" ",""].Replace["[",""].Replace["]",""].Replace["'",""]}"]
	
	if ( !${_WhereToGoShort.Find[SandstoneDeltaEyeoftheStorm](exists)} && !${_WhereToGoShort.Find[SandstoneDeltaEyeofNight](exists)} && !${_WhereToGoShort.Find[SandstoneDelta](exists)} && !${_WhereToGoShort.Find[TakishBadlandsKigathorsGlade](exists)} && !${_WhereToGoShort.Find[TakishBadlandsOvergrowth](exists)} && !${_WhereToGoShort.Find[TakishBadlands](exists)} && !${_WhereToGoShort.Find[RajDurPlateaus](exists)} && !${_WhereToGoShort.Find[RajDurPlateausBloodandSand](exists)} && !${_WhereToGoShort.Find[RajDurPlateausTheSultansDagger](exists)} && !${_WhereToGoShort.Find[RajDurPlateausBuriedTakishHiz](exists)} && !${_WhereToGoShort.Find[MahngaviWastesGhoulinda](exists)} && !${_WhereToGoShort.Find[KaruupaJunglePredatorsPerch](exists)} && !${_WhereToGoShort.Find[KaruupaJungleDedrakasDescent](exists)} && !${_WhereToGoShort.Find[KaruupaJungleHeartofConflict](exists)} && !${_WhereToGoShort.Find[KaruupaJungle](exists)} && !${_WhereToGoShort.Find[MahngaviWastes](exists)} && !${_WhereToGoShort.Find[SvarniExpanse](exists)} && !${_WhereToGoShort.Find[ForlornGist](exists)} && !${_WhereToGoShort.Find[ShadeweaversThicketLodaKaiIsle](exists)} && !${_WhereToGoShort.Find[ShadeweaversThicket](exists)} && ${_WhereToGoShort.NotEqual[LopingPlains]} && ${_WhereToGoShort.NotEqual[EchoCaverns]} && ${_WhereToGoShort.NotEqual[CityofFordelMidst]} && !${_WhereToGoShort.Find[SavageWeald](exists)} && !${_WhereToGoShort.Find[CityofSharVahl](exists)} && ${_WhereToGoShort.NotEqual[Baubles]} && ${_WhereToGoShort.NotEqual[AurelianCoast]} && ${_WhereToGoShort.NotEqual[SanctusSeruCity]} && ${_WhereToGoShort.NotEqual[Wracklands]})
	{
		;echo ${_WhereToGoShort}
		echo ISXRI: ${_WhereToGo} is not a Predetermined Goto Location
		return
	}
	variable string _WhereFrom=NONE
	;first determine where we are at
	
	if ${Zone.Name.Find[Sandstone Delta]} && ${Me.Distance[589.960022,113.050003,-631.919983]}<55
	{
		;we are at Sandstone Delta: Eye of Night
		_WhereFrom:Set["Sandstone Delta Eye of Night"]
	}
	elseif ${Zone.Name.Find[Sandstone Delta]} && ${Me.Distance[-47.570000,57.150002,160.699997]}<55
	{
		;we are at Sandstone Delta: Eye of the Storm
		_WhereFrom:Set["Sandstone Delta Eye of the Storm"]
	}
	elseif ${Zone.Name.Find[Takish Badlands]} && ${Me.Distance[-394.227814,245.000000,213.808731]}<55
	{
		;we are at Kigathor's Glade
		_WhereFrom:Set["Takish Badlands Kigathor's Glade"]
	}
	elseif ${Zone.Name.Find[Takish Badlands]} && ${Me.Distance[742.023987,58.080002,42.790913]}<55
	{
		;we are at Takish Badlands Overgrowth
		_WhereFrom:Set["Takish Badlands Overgrowth"]
	}
	elseif ${Zone.Name.Find[Raj'Dur Plateaus]} && ${Me.Distance[162.720001,-59.590000,477.339996]}<55
	{
		;we are at Blood and Sand
		_WhereFrom:Set["Raj'Dur Plateaus Blood and Sand"]
	}
	elseif ${Zone.Name.Find[Raj'Dur Plateaus]} && ${Me.Distance[60.549999,87.639999,-349.829987]}<55
	{
		;we are at The Sultan's Dagger
		_WhereFrom:Set["Raj'Dur Plateaus The Sultan's Dagger"]
	}
	elseif ${Zone.Name.Find[Raj'Dur Plateaus]} && ${Me.Distance[-554.349976,10.960000,427.899994]}<55
	{
		;we are at The Sultan's Dagger
		_WhereFrom:Set["Raj'Dur Plateaus Buried Takish'Hiz"]
	}
	elseif ${Zone.Name.Find[Svarni Expanse]} && ${Me.Distance[-523.72,89.88,-533.43]}<55
	{
		;we are at Svarni Expanse
		_WhereFrom:Set["Svarni Expanse"]
	}
	elseif ${Zone.Name.Find[Karuupa Jungle]} && ${Me.Distance[-232.49,109.59,-691.35]}<55
	{
		;we are at Karuupa Jungle Dedrakas Descent
		_WhereFrom:Set["Karuupa Jungle Dedrakas Descent"]
	}
	elseif ${Zone.Name.Find[Karuupa Jungle]} && ${Me.Distance[745.53,168.17,-388.38]}<55
	{
		;we are at Karuupa Jungle Heart of Conflict
		_WhereFrom:Set["Karuupa Jungle Heart of Conflict"]
	}
	elseif ${Zone.Name.Find[Karuupa Jungle]} && ${Me.Distance[-746.00,197.57,-284.76]}<55
	{
		;we are at Karuupa Jungle Predators Perch
		_WhereFrom:Set["Karuupa Jungle Predators Perch"]
	}
	elseif ${Zone.Name.Find[Mahngavi Wastes]} && ${Me.Distance[645.20,48.73,-446.90]}<55
	{
		;we are at Mahngavi Wastes
		_WhereFrom:Set["Mahngavi Wastes"]
	}
	elseif ${Zone.Name.Find[Forlorn Gist]} && ${Me.Distance[434.29,108.74,205.00]}<75
	{
		;we are at ForlornGist
		_WhereFrom:Set["Forlorn Gist"]
	}
	elseif ${Zone.Name.Find[Forlorn Gist]} && ${Me.Distance[-289.55,53.67,-345.43]}<75
	{
		;we are at ForlornGist
		_WhereFrom:Set["Forlorn Gist Merchants Den"]
	}
	elseif ${Zone.Name.Find[Loping Plains]} && ${Me.Distance[-312.051636,15.470000,4.626971]}<55
	{
		;we are at VD Entrance
		_WhereFrom:Set["Loping Plains"]
	}
	elseif ${Zone.Name.Find[Echo Caverns]} && ${Me.Distance[615.701111,25.766819,-439.633423]}<55
	{
		;we are at Zelmie Sortie Entrance
		_WhereFrom:Set["Echo Caverns"]
	}
	elseif ${Zone.Name.Find[Shadeweaver's Thicket]} && ${Me.Distance[632.874634,13.072926,316.680420]}<55
	{
		;we are at Loda Kai Isle Entrance
		_WhereFrom:Set["Shadeweaver's Thicket Loda Kai Isle"]
	}
	elseif ${Zone.Name.Find[Shadeweaver's Thicket]} && ${Me.Distance[-544.688782,161.518738,-753.726624]}<55
	{
		;we are at Shar Vahl Entrance
		_WhereFrom:Set["Shadeweaver's Thicket"]
	}
	elseif ${Zone.Name.Find[Savage Weald]} && ${Me.Distance[-896.098450,75.165260,-375.025940]}<55
	{
		;we are at Chaotic Caverns Entrance
		_WhereFrom:Set["SavageWealdChaoticCaverns"]
	}
	elseif ${Zone.Name.Find[Savage Weald]} && ${Me.Distance[-81.374565,20.860985,-259.299744]}<55
	{
		;we are at FortGrim Entrance
		_WhereFrom:Set["SavageWealdFortGrim"]
	}
	elseif ${Zone.Name.Find[City of Shar Vahl]} && ${Me.Distance[-132.810455,30.998365,241.039520]}<20
	{
		;we are at Untamed Lands Entrance
		_WhereFrom:Set["CityofSharVahlUntamedLands"]
	}
	elseif ${Zone.Name.Find[City of Shar Vahl]} && ${Me.Distance[-353.669128,91.861382,178.725586]}<55
	{
		;we are at Feral Reserve Entrance
		_WhereFrom:Set["CityofSharVahlFeralReserve"]
	}
	elseif ${Zone.Name.Find[Aurelian Coast]} && ${Me.Distance[113.730003,57.369999,-657.119995]}<20
	{
		;we are at Sambata Entrance, Move from here
		_WhereFrom:Set["Aurelian Coast"]
	}
	elseif ${Zone.Name.Find[Aurelian Coast]} && ${Me.Distance[169.061646,61.921852,-682.376831]}<20
	{
		;we are at Foredel Mist Entrance, Move from here
		call RIMObj.Move 187.207016 61.893368 -662.309143 2 0 0 0 1 1 1 1
		call RIMObj.Move 164.109650 61.839806 -637.346558 2 0 0 0 1 1 1 1
		_WhereFrom:Set["Aurelian Coast"]
	}
	elseif ${Zone.Name.Find[Aurelian Coast]} && ${Me.Distance[113.153946,66.675789,-622.250977]}<20
	{
		;we are at Aurelian Coast, Move from here
		_WhereFrom:Set["Aurelian Coast"]
	}
	; elseif ${Zone.Name.Find[The Blinding]} && ${Me.Distance[591.000000,428.598633,-581.580017]}<40
	; {
		; ;we are at The Blinding Zone Entrance, Move from here
	; }
	; elseif ${Zone.Name.Find[The Blinding]} && ${Me.Distance[-584.000000,33.517941,358.359985]}<40
	; {
		; ;we are at The Blinding at the 2nd drone, Move from here
	; }
	; elseif ${Zone.Name.Find[The Blinding]} && ${Me.Distance[578.640015,48.419998,580.030029]}<40
	; {
		; ;we are at The Blinding at the serus drone, Move from here
	; }
	elseif ${Zone.Name.Find["Sanctus Seru [City]"]} && ${Me.Distance[-239.133438,179.756027,-1.253709]}<50
	{
		;we are at Sanctus Seru City, Move from here
		_WhereFrom:Set["Sanctus Seru [City]"]
	}
	else
	{
		_WhereFrom:Set["Guild Hall"]
	}
	if ${_WhereFrom.Equal[NONE]}
		return
	
	variable string _WhereFromShort
	_WhereFromShort:Set["${_WhereFrom.Replace[" ",""].Replace["[",""].Replace["]",""].Replace["'",""]}"]
	
	if ${_WhereFromShort.Equal["${_WhereToGoShort}"]}
	{
		echo ISXRI: We are already at ${_WhereToGo}
		return
	}
	;echo ${_WhereFromShort.Equal["${_WhereToGoShort}"]} // ${_WhereFromShort} // ${_WhereToGoShort}
	if ${_WhereToGoShort.Equal[SandstoneDelta]}
	{
		call FastTravel "Takish Badlands"
		wait 50 ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
		call TakishBadlandsSandstoneDelta
		wait 50 ${Zone.ShortName.Find[exp19_rgn_sandstone_delta](exists)}
	}
	elseif ${_WhereToGoShort.Equal[SandstoneDeltaEyeofTheStorm]}
	{
		if ${_WhereFromShort.Equal[SandstoneDeltaEyeofNight]}
		{
			if !${Others}
				call SandstoneDeltaEyeofNightSandstoneDeltaEyeofTheStorm
		}
		elseif ${_WhereFromShort.Equal[TakishBadlandsKigathorsGlade]}
		{
			call TakishBadlandsSandstoneDelta TRUE
			if !${Others}
				call SandstoneDeltaEyeofTheStorm
		}
		elseif ${_WhereFromShort.Equal[TakishBadlandsOvergrowth]}
		{
			call TakishBadlandsOvergrowthTakishBadlandsKigathorsGlade
			call TakishBadlandsSandstoneDelta TRUE
			if !${Others}
				call SandstoneDeltaEyeofTheStorm
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Takish Badlands"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			call TakishBadlandsSandstoneDelta
			wait 50 ${Zone.ShortName.Find[exp19_rgn_sandstone_delta](exists)}
			if !${Others}
				call SandstoneDeltaEyeofTheStorm
		}
	}
	elseif ${_WhereToGoShort.Equal[SandstoneDeltaEyeofNight]}
	{
		if ${_WhereFromShort.Equal[SandstoneDeltaEyeofTheStorm]}
		{
			if !${Others}
				call SandstoneDeltaEyeofTheStormSandstoneDeltaEyeofNight
		}
		elseif ${_WhereFromShort.Equal[TakishBadlandsKigathorsGlade]}
		{
			call TakishBadlandsSandstoneDelta TRUE
			if !${Others}
				call SandstoneDeltaEyeofNight
		}
		elseif ${_WhereFromShort.Equal[TakishBadlandsOvergrowth]}
		{
			call TakishBadlandsOvergrowthTakishBadlandsKigathorsGlade
			call TakishBadlandsSandstoneDelta TRUE
			if !${Others}
				call SandstoneDeltaEyeofNight
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Takish Badlands"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			call TakishBadlandsSandstoneDelta
			wait 50 ${Zone.ShortName.Find[exp19_rgn_sandstone_delta](exists)}
			if !${Others}
				call SandstoneDeltaEyeofNight
		}
	}
	elseif ${_WhereToGoShort.Equal[TakishBadlands]}
	{
		call FastTravel "Takish Badlands"
		wait 50 ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
	}
	elseif ${_WhereToGoShort.Equal[TakishBadlandsOvergrowth]}
	{
		if ${_WhereFromShort.Equal[TakishBadlandsKigathorsGlade]}
		{
			if !${Others}
				call TakishBadlandsKigathorsGladeTakishBadlandsOvergrowth
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Takish Badlands"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			if !${Others}
				call TakishBadlandsOvergrowth
		}
	}
	elseif ${_WhereToGoShort.Equal[TakishBadlandsKigathorsGlade]}
	{
		if ${_WhereFromShort.Equal[TakishBadlandsOvergrowth]}
		{
			if !${Others}
				call TakishBadlandsOvergrowthTakishBadlandsKigathorsGlade
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Takish Badlands"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_takish_badlands](exists)}
			if !${Others}
				call TakishBadlandsKigathorsGlade
		}
	}
	elseif ${_WhereToGoShort.Equal[RajDurPlateaus]}
	{
		call FastTravel "Raj'Dur Plateaus"
		wait 50 ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
	}
	elseif ${_WhereToGoShort.Equal[RajDurPlateausBloodandSand]}
	{
		if ${_WhereFromShort.Equal[RajDurPlateausBuriedTakishHiz]}
		{
			if !${Others}
				call RajDurPlateausBuriedTakishHizRajDurPlateausBloodandSand
		}
		elseif ${_WhereFromShort.Equal[RajDurPlateausTheSultansDagger]}
		{
			if !${Others}
				call RajDurPlateausTheSultansDaggerRajDurPlateausBloodandSand
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Raj'Dur Plateaus"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
			if !${Others}
				call RajDurPlateausBloodandSand
		}
	}
	elseif ${_WhereToGoShort.Equal[RajDurPlateausTheSultansDagger]}
	{
		if ${_WhereFromShort.Equal[RajDurPlateausBuriedTakishHiz]}
		{
			if !${Others}
				call RajDurPlateausBuriedTakishHizRajDurPlateausTheSultansDagger
		}
		elseif ${_WhereFromShort.Equal[RajDurPlateausBloodandSand]}
		{
			if !${Others}
				call RajDurPlateausTheSultansDagger
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Raj'Dur Plateaus"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
			if !${Others}
				call RajDurPlateausTheSultansDagger
		}
	}
	elseif ${_WhereToGoShort.Equal[RajDurPlateausBuriedTakishHiz]}
	{
		if ${_WhereFromShort.Equal[RajDurPlateausTheSultansDagger]}
		{
			if !${Others}
				call RajDurPlateausTheSultansDaggerRajDurPlateausBuriedTakishHiz
		}
		elseif ${_WhereFromShort.Equal[RajDurPlateausBloodandSand]}
		{
			if !${Others}
				call RajDurPlateausBuriedTakishHiz
		}
		else
		{
			if ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
			{
				call FastTravel "Isle of Mara"
				wait 50
			}
			call FastTravel "Raj'Dur Plateaus"
			wait 50 ${Zone.ShortName.Find[exp19_rgn_plateaus](exists)}
			if !${Others}
				call RajDurPlateausBuriedTakishHiz
		}
	}
	if ${_WhereToGoShort.Equal[MahngaviWastesGhoulinda]}
	{
		call UseBauble "Renfry's Basement Bauble" "Renfry's Basement"
		call RenfrysBasementMahngaviWastesEntrance
		call MahngaviWastesEntranceMahngaviWastesGhoulinda
	}
	elseif ${_WhereToGoShort.Equal[SvarniExpanse]}
	{
		call FastTravel "Svarni Expanse"
		wait 50 ${Zone.ShortName.Find[exp18_rgn_svarni_expanse](exists)}
		if !${Others}
			call SvarniExpanseSvarniGatewaySvarniExpanseInstances
	}
	elseif ${_WhereToGoShort.Equal[KaruupaJungle]}
	{
		if ${_WhereFromShort.Equal[SvarniExpanse]}
		{
			call SvarniExpanseInstancesKaruupaJunglePad
		}
		if ${_WhereFromShort.Find[KaruupaJungle]} || ${Zone.Name.Find[Karuupa Jungle]}
		{
			return
		}
		else
		{
			call FastTravel "Svarni Expanse"
			wait 50 ${Zone.ShortName.Find[exp18_rgn_svarni_expanse](exists)}
			call SvarniExpanseSvarniGatewayKaruupaJunglePad
		}
	}
	elseif ${_WhereToGoShort.Equal[KaruupaJungleHeartofConflict]}
	{
		if ${_WhereFromShort.Equal[KaruupaJungleDedrakasDescent]}
		{
			if !${Others}
				call KaruupaJungleDedrakasDescentKaruupaJungleHeartofConflict
		}
		elseif ${_WhereFromShort.Equal[KaruupaJunglePredatorsPerch]}
		{
			if !${Others}
				call KaruupaJunglePredatorsPerchKaruupaJungleHeartofConflict
		}
		elseif ${_WhereFromShort.Equal[SvarniExpanse]}
		{
			call SvarniExpanseInstancesKaruupaJunglePad
			if !${Others}
				call KaruupaJunglePadKaruupaJungleHeartofConflict
		}
		else
		{
			call FastTravel "Svarni Expanse"
			wait 50 ${Zone.ShortName.Find[exp18_rgn_svarni_expanse](exists)}
			call SvarniExpanseSvarniGatewayKaruupaJunglePad
			if !${Others}
				call KaruupaJunglePadKaruupaJungleHeartofConflict
		}
	}
	elseif ${_WhereToGoShort.Equal[KaruupaJungleDedrakasDescent]}
	{
		if ${_WhereFromShort.Equal[KaruupaJungleHeartofConflict]}
		{
			if !${Others}
				call KaruupaJungleHeartofConflictKaruupaJungleDedrakasDescent
		}
		elseif ${_WhereFromShort.Equal[KaruupaJunglePredatorsPerch]}
		{
			if !${Others}
				call KaruupaJunglePredatorsPerchKaruupaJungleDedrakasDescent
		}
		elseif ${_WhereFromShort.Equal[SvarniExpanse]}
		{
			call SvarniExpanseInstancesKaruupaJunglePad
			if !${Others}
				call KaruupaJunglePadKaruupaJungleDedrakasDescent
		}
		else
		{
			call FastTravel "Svarni Expanse"
			wait 50 ${Zone.ShortName.Find[exp18_rgn_svarni_expanse](exists)}
			call SvarniExpanseSvarniGatewayKaruupaJunglePad
			if !${Others}
				call KaruupaJunglePadKaruupaJungleDedrakasDescent
		}
	}
	elseif ${_WhereToGoShort.Equal[KaruupaJunglePredatorsPerch]}
	{
		if ${_WhereFromShort.Equal[KaruupaJungleHeartofConflict]}
		{
			if !${Others}
				call KaruupaJungleHeartofConflictKaruupaJunglePredatorsPerch
		}
		elseif ${_WhereFromShort.Equal[KaruupaJungleDedrakasDescent]}
		{
			if !${Others}
				call KaruupaJungleDedrakasDescentKaruupaJunglePredatorsPerch
		}
		elseif ${_WhereFromShort.Equal[SvarniExpanse]}
		{
			call SvarniExpanseInstancesKaruupaJunglePad
			if !${Others}
				call KaruupaJunglePadKaruupaJunglePredatorsPerch
		}
		else
		{
			call FastTravel "Svarni Expanse"
			wait 50 ${Zone.ShortName.Find[exp18_rgn_svarni_expanse](exists)}
			call SvarniExpanseSvarniGatewayKaruupaJunglePad
			if !${Others}
				call KaruupaJunglePadKaruupaJunglePredatorsPerch
		}
	}
	elseif ${_WhereToGoShort.Equal[MahngaviWastes]}
	{
		call UseBauble "Renfry's Basement Bauble" "Renfry's Basement"
		call RenfrysBasementMahngaviWastesEntrance
		if !${Others}
			call MahngaviWastesEntranceMahngaviWastesInstances
	}
	elseif ${_WhereToGoShort.Equal[ForlornGist]}
	{
		call UseBauble "Renfry's Basement Bauble" "Renfry's Basement"
		call RenfrysBasementForlornGistInstances
	}
	elseif ${_WhereToGoShort.Equal[ForlornGistMerchantsDen]}
	{
		call UseBauble "Renfry's Basement Bauble" "Renfry's Basement"
		call RenfrysBasementForlornGistMerchantsDen
	}
	elseif ${_WhereToGoShort.Equal[LopingPlains]}
	{
		RIMUIObj:FastTravel[${Me.Name},"City of Fordel Midst"]
		wait 5
		RIMUIObj:FastTravel[${Me.Name},"City of Fordel Midst"]
		wait 50 ${EQ2.Zoning}==1
		wait 600 ${EQ2.Zoning}==0
		wait 50 ${Zone.ShortName.Find[exp17_dun_fordel_midst](exists)}
		call RIMObj.Move 263.477509 -27.628996 778.244385
		call Door 10 "Ulteran Spire Portal" 1
		wait 20
		call RIMObj.TravelMap "Loping Plains"
		wait 5
		if ${Zone.Name.Find[Loping Plains]}==0
			call RIMObj.TravelMap "Loping Plains"	
		;if !${Others} -- because of quest giver
			call LopingPlainsSpiresLopingPlainsVDEntrance
	}
	elseif ${_WhereToGoShort.Equal[EchoCaverns]}
	{
		if ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of Echo Caverns"](exists)}
		{
			call UseBauble "Will of Echo Caverns" "Echo Caverns"
			call EchoCavernsZoneEntranceEchoCavernsZelmieSortie
		}
		else
		{
			call Goto Baubles
			call Goto ${_WhereToGoShort}
			return
		}
	}
	elseif ${_WhereToGoShort.Find[ShadeweaversThicket]}
	{
		if ${_WhereFromShort.Equal[ShadeweaversThicket]}
			noop
		else
		{
			if ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of Shadeweaver's Thicket"](exists)}
			{
				call UseBauble "Will of Shadeweaver's Thicket" "Shadeweaver's Thicket"
			}
			else
			{
				call Goto Baubles
				call Goto ${_WhereToGoShort}
				return
			}
		}
		if ${_WhereToGoShort.Find[LodaKaiIsle]}
		{
			;echo cc
			call ShadeweaversThicketZoneEntranceShadeweaversThicketLodaKaiIsle
		}
	}
	elseif ${_WhereToGoShort.Equal[CityofFordelMidst]}
	{
		if ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of Echo Caverns"](exists)}
		{
			call UseBauble "Will of Echo Caverns" "Echo Caverns"
			call RIMObj.Move 36.298523 161.036072 -142.215561
			call ZoneDoor Exit
		}
		else
		{
			call Goto Baubles
			call Goto ${_WhereToGoShort}
			return
		}
	}
	elseif ${_WhereToGoShort.Find[SavageWeald]}
	{
		if ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of the Weald"](exists)}
		{
			if ${_WhereFromShort.Find[ChaoticCaverns]}
			{
				call SavageWealdChaoticCavernsSavageWealdCommonPoint
			}
			elseif ${_WhereFromShort.Find[FortGrim]}
			{
				call SavageWealdFortGrimSavageWealdCommonPoint
			}
			else
			{
				call UseBauble "Will of the Weald" "Savage Weald"
				if ${Others}
					Script:End
				call WilloftheWealdSavageWealdCommonPoint
			}
		}
		else
		{
			call Goto Baubles
			call Goto ${_WhereToGoShort}
			return
		}
		if ${_WhereToGoShort.Find[ChaoticCaverns]}
		{
			;echo cc
			call SavageWealdCommonPointSavageWealdChaoticCaverns
		}
		elseif ${_WhereToGoShort.Find[FortGrim]}
		{
			;echo fort grim
			call SavageWealdCommonPointSavageWealdFortGrim
		}
	}
	elseif ${_WhereToGoShort.Find[CityofSharVahl]}
	{
		if ${Me.Inventory[Query, Location=="Inventory" && Name=="Spirit of the Vah Shir"](exists)}
		{
			if ${_WhereFromShort.Find[UntamedLands]}
			{
				call RIMObj.Move -130.397598 30.134352 210.108673 2 0 0 0 1 0 1 1
				call RIMObj.Move -168.059021 31.653652 187.523453
			}
			elseif ${_WhereFromShort.Find[FeralReserve]}
			{
				call CityofSharVahlEntrance2CityofSharVahlCommonPoint2
				call CityofSharVahlCommonPoint2CityofSharVahlCommonPoint
			}
			else
			{
				call UseBauble "Spirit of the Vah Shir" "City of Shar Vahl"
				if ${Others}
					Script:End
				call CityofSharVahlEntranceCityofSharVahlCommonPoint
			}
		}
		else
		{
			call Goto Baubles
			call Goto ${_WhereToGoShort}
			return
		}
		if ${_WhereToGoShort.Find[UntamedLands]}
		{
			;echo untamed
			call RIMObj.Move -130.397598 30.134352 210.108673 2 0 0 0 1 0 1 1
			call RIMObj.Move -134.994446 31.610161 241.719650
		}
		elseif ${_WhereToGoShort.Find[FeralReserve]}
		{
			;echo feral
			call CityofSharVahlCommonPointCityofSharVahlCommonPoint2
			call CityofSharVahlCommonPoint2CityofSharVahlEntrance2
			call RIMObj.Move -354.965240 91.861389 179.189774
		}
	}
	elseif ${_WhereToGoShort.Equal[SanctusSeruCity]} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of Seru"](exists)}
	{
		echo ISXRI: Moving to ${_WhereToGo} with Will of Seru
		call UseBauble "Will of Seru" "Sanctus Seru [City]"

		call RIMObj.Move 9.140417 180.650330 177.574127 2 0 0 0 1 0 1 1		
		;pause bots
		RI_CMD_PauseCombatBots 1
		
		call BuyBauble "Haylise Madorus" "Will of Seru"
		call BuyBauble "Haylise Madorus" "Will of the Wracklands"
		call BuyBauble "Haylise Madorus" "Will of the Coast"
		call BuyBauble "Haylise Madorus" "Will of The Blinding"
		MerchantWindow:Close
		;unpause bots
		RI_CMD_PauseCombatBots 0
		eq2ex target_none

		if !${Others}
			call WillofSeruToSanctusSeruCity
	}
	elseif ${_WhereToGoShort.Equal[AurelianCoast]} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of the Coast"](exists)}
	{
		echo ISXRI: Moving to ${_WhereToGo} with Will of the Coast
		call UseBauble "Will of the Coast" "Aurelian Coast"
		if !${Others}
			call WilloftheCoastToAurelianCoast
	}
	elseif ${_WhereToGoShort.Equal[Wracklands]} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of the Wracklands"](exists)}
	{
		echo ISXRI: Moving to ${_WhereToGo} with Will of the Wracklands
		call UseBauble "Will of the Wracklands" "Wracklands"
		if !${Others}
			call WilloftheWracklandsToWracklands
	}
	elseif ${_WhereToGoShort.Equal[Baubles]}
	{
		;if ${RIMUIObj.InventoryQuantity["Will of Echo Caverns"]}==0
		;{
			RIMUIObj:FastTravel[${Me.Name},"City of Fordel Midst"]
			wait 50 ${EQ2.Zoning}==1
			wait 600 ${EQ2.Zoning}==0
			wait 50 ${Zone.ShortName.Find[exp17_dun_fordel_midst](exists)}
			;call RIMObj.Move 631.461609 428.167542 -580.186646
			;call Door 10 "Ulteran Spire Portal" 1
			;wait 5
			;call RIMObj.TravelMap "City of Fordel Midst"
			call CityofFordelMidstZoneEntranceCityofFordelMidstBauble
			call BuyBauble "Sarah Polson" "Will of Echo Caverns"
			call BuyBauble "Sarah Polson" "Will of Shadeweaver's Thicket"
			call BuyBauble "Sarah Polson" "Will of the Weald"
			MerchantWindow:Close
		;}
		;elseif ${RIMUIObj.InventoryQuantity["Will of Echo Caverns"]}<20 || ${RIMUIObj.InventoryQuantity["Will of Shadeweaver's Thicket"]}<20 || ${RIMUIObj.InventoryQuantity["Will of the Weald"]}<20
		;{
		;	call UseBauble "Will of Echo Caverns" "Echo Caverns"
		;	call WillofEchoCavernsCityofFordelMidstBauble
		;	call BuyBauble "Sarah Polson" "Will of Echo Caverns"
		;	call BuyBauble "Sarah Polson" "Will of Shadeweaver's Thicket"
		;	call BuyBauble "Sarah Polson" "Will of the Weald"
		;	MerchantWindow:Close
		;}
		if ${RIMUIObj.InventoryQuantity["Spirit of the Vah Shir"]}==0
		{
			call UseBauble "Will of Shadeweaver's Thicket" "Shadeweaver's Thicket"
			call RIMObj.Move -542.492981 161.079468 -753.425476
			Call ZoneDoor "Zone to City of Shar Vahl" 1
			call CityofSharVahlEntrance2CityofSharVahlCommonPoint2
			call CityofSharVahlCommonPoint2CityofSharVahlBauble
			call BuyBauble Chiallar "Spirit of the Vah Shir"
			MerchantWindow:Close
		}
		elseif ${RIMUIObj.InventoryQuantity["Spirit of the Vah Shir"]}<20
		{
			call UseBauble "Spirit of the Vah Shir" "City of Shar Vahl"
			call SpiritoftheVahShirCityofSharVahlBauble
			call BuyBauble Chiallar "Spirit of the Vah Shir"
			MerchantWindow:Close
		}
		if ${Me.Ability[id,3266969222].IsReady}
		{
			;call to guild hall
			call RIMObj.CallToGuildHall 1
		}
	}
	elseif ${DeprecatedBYHERC}
	{	
		;could not detect where we are, calling to guild hall and determining if we can go from there, unless we are in the guildhall
		if ${RIMUIObj.MainIconIDExists[${Me.ID},955,0]}
		{
			echo ISXRI: We are not at any of the predetermined move from locations, using Fast Travel
			while !${Zone.ShortName.Find[exp16_rgn_the_blinding](exists)} || ( ${Zone.ShortName.Find[exp16_rgn_the_blinding](exists)} && ${Me.Distance[621.859985,428.167542,-580.669983]}>50 )
			{
				RIMUIObj:FastTravel[${Me.Name},"Myrist","The Blinding"]
				wait 50 ${EQ2.Zoning}==1
				wait 600 ${EQ2.Zoning}==0
				wait 50 ${Zone.ShortName.Find[exp16_rgn_the_blinding](exists)}
			}
		}
		elseif !${Zone.ShortName.Find[guildhall]} && ${_WhereFrom.Equal["Guild Hall"]}
		{
			echo ISXRI: We are not at any of the predetermined move from locations, calling to the guild hall please ensure your Wizard portal is in direct line of sight and directly passable to the guild hall call location
			;call to guild hall
			call RIMObj.CallToGuildHall 1
		}
		echo ISXRI: Moving from ${_WhereFrom} to ${_WhereToGo}
		call ${_WhereFromShort}${_WhereToGoShort}
	}
	
}
function UseBauble(string _Which, string _ZoneName)
{
	;pause bots
	RI_CMD_PauseCombatBots 1
	eq2ex cancel_spellcast
	wait 2
	if ${_Which.Equal["Renfry's Basement Bauble"]}
	{
		Me.Inventory[Query, Name=-"${_Which}" && Location=="Inventory"]:Examine
		wait 2
		Me.Inventory[Query, Name=-"${_Which}" && Location=="Inventory"]:Examine
		wait 2
		Me.Inventory[Query, Name=-"${_Which}" && Location=="Inventory"]:Examine
		wait 2
		ReplyDialog:Choose[1]
		wait 2
		ReplyDialog:Choose[1]
		wait 2
		ReplyDialog:Choose[1]
	}
	else
	{
		Me.Inventory[Query, Name=-"${_Which}" && Location=="Inventory"]:Use
		wait 5
		Me.Inventory[Query, Name=-"${_Which}" && Location=="Inventory"]:Use
	}
	wait 50 ${EQ2.Zoning}
	wait 600 !${EQ2.Zoning}
	wait 50 ${Zone.Name.Equal["${_ZoneName}"]}
	;unpause bots
	RI_CMD_PauseCombatBots 0
}
function TakishBadlandsSandstoneDelta(bool _SkipTransport=FALSE)
{
	_PathFile:Clear
	if !${_SkipTransport}
	{
		_PathFile:Insert[243.04 48.02 1183.43]
		_PathFile:Insert[Custom|Wait|1]
		_PathFile:Insert[243.04 77.21 1183.43]
		_PathFile:Insert[211.67 73.84 1150.42]
		_PathFile:Insert[179.93 73.84 1111.76]
		_PathFile:Insert[147.16 73.84 1073.71]
		_PathFile:Insert[114.36 73.84 1035.60]
		_PathFile:Insert[85.79 73.84 994.54]
		_PathFile:Insert[77.67 73.80 972.47]
		_PathFile:Insert[Custom|RIMObj.FlyDown]
		_PathFile:Insert[78.09 1.86 974.25]
		_PathFile:Insert[Custom|ClickActor|a transport of Growth]
		_PathFile:Insert[Custom|Wait|50]
		_PathFile:Insert[Custom|WaitWhileMoving]
		_PathFile:Insert[Custom|Wait|10]
		_PathFile:Insert[Custom|WaitWhileMoving]
	}
	_PathFile:Insert[-437.46 246.98 181.05]
	_PathFile:Insert[Custom|ClickActor|Zone to Sandstone Delta]
	_PathFile:Insert[Custom|Wait|50]
	_PathFile:Insert[Custom|TravelMap|Sandstone Delta]
	_PathFile:Insert[Custom|Wait|50]
	_PathFile:Insert[Custom|WaitWhileMoving]

	call NavigatePath
}
function SandstoneDeltaEyeofTheStormSandstoneDeltaEyeofNight()
{
	_PathFile:Clear
	_PathFile:Insert[-58.53 57.37 164.87]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-58.53 107.44 164.87]
	_PathFile:Insert[-58.53 157.58 164.87]
	_PathFile:Insert[-58.53 207.62 164.87]
	_PathFile:Insert[-23.61 214.63 129.67]
	_PathFile:Insert[11.68 214.63 94.09]
	_PathFile:Insert[47.11 214.63 58.38]
	_PathFile:Insert[82.14 214.63 22.53]
	_PathFile:Insert[116.25 214.63 -14.07]
	_PathFile:Insert[150.50 214.63 -50.82]
	_PathFile:Insert[184.74 214.63 -87.56]
	_PathFile:Insert[218.93 214.63 -124.25]
	_PathFile:Insert[253.05 214.63 -160.86]
	_PathFile:Insert[287.15 214.63 -197.46]
	_PathFile:Insert[321.36 214.63 -234.17]
	_PathFile:Insert[355.49 214.63 -270.79]
	_PathFile:Insert[389.61 214.63 -307.41]
	_PathFile:Insert[423.79 214.63 -344.08]
	_PathFile:Insert[458.36 214.63 -381.17]
	_PathFile:Insert[492.55 214.63 -417.86]
	_PathFile:Insert[525.69 214.63 -455.30]
	_PathFile:Insert[549.01 214.63 -499.68]
	_PathFile:Insert[568.60 214.63 -545.70]
	_PathFile:Insert[582.94 214.63 -593.71]
	_PathFile:Insert[593.05 213.47 -642.99]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[590.46 112.36 -633.63]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function SandstoneDeltaEyeofNightSandstoneDeltaEyeofTheStorm()
{
	_PathFile:Clear
	_PathFile:Insert[593.07 113.71 -642.99]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[593.05 163.47 -642.99]
	_PathFile:Insert[593.05 213.47 -642.99]
	_PathFile:Insert[582.94 214.63 -593.71]
	_PathFile:Insert[582.94 214.63 -593.71]
	_PathFile:Insert[568.60 214.63 -545.70]
	_PathFile:Insert[549.01 214.63 -499.68]
	_PathFile:Insert[525.69 214.63 -455.30]
	_PathFile:Insert[492.55 214.63 -417.86]
	_PathFile:Insert[458.36 214.63 -381.17]
	_PathFile:Insert[423.79 214.63 -344.08]
	_PathFile:Insert[389.61 214.63 -307.41]
	_PathFile:Insert[355.49 214.63 -270.79]
	_PathFile:Insert[321.36 214.63 -234.17]
	_PathFile:Insert[287.15 214.63 -197.46]
	_PathFile:Insert[253.05 214.63 -160.86]
	_PathFile:Insert[218.93 214.63 -124.25]
	_PathFile:Insert[184.74 214.63 -87.56]
	_PathFile:Insert[150.50 214.63 -50.82]
	_PathFile:Insert[116.25 214.63 -14.07]
	_PathFile:Insert[82.14 214.63 22.53]
	_PathFile:Insert[47.11 214.63 58.38]
	_PathFile:Insert[11.68 214.63 94.09]
	_PathFile:Insert[-23.61 214.63 129.67]
	_PathFile:Insert[-58.53 207.62 164.87]
	_PathFile:Insert[-58.53 157.58 164.87]
	_PathFile:Insert[-58.53 107.44 164.87]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-48.22 57.54 161.17]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function SandstoneDeltaEyeofTheStorm()
{
	_PathFile:Clear
	_PathFile:Insert[658.81 51.26 171.21]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[658.81 101.54 171.21]
	_PathFile:Insert[609.19 108.52 173.47]
	_PathFile:Insert[559.17 108.52 175.75]
	_PathFile:Insert[509.14 108.52 178.03]
	_PathFile:Insert[466.49 134.71 179.98]
	_PathFile:Insert[419.72 152.72 182.11]
	_PathFile:Insert[370.68 163.09 184.35]
	_PathFile:Insert[320.69 163.09 186.63]
	_PathFile:Insert[270.61 163.09 188.91]
	_PathFile:Insert[220.42 163.09 191.20]
	_PathFile:Insert[170.38 163.09 193.48]
	_PathFile:Insert[120.15 163.09 195.77]
	_PathFile:Insert[71.31 152.50 192.49]
	_PathFile:Insert[25.33 134.45 182.81]
	_PathFile:Insert[-18.42 113.87 169.34]
	_PathFile:Insert[-53.15 94.42 164.63]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-48.22 57.54 161.17]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function SandstoneDeltaEyeofNight()
{
	_PathFile:Clear
	_PathFile:Insert[657.51 51.26 165.78]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[657.51 101.49 165.78]
	_PathFile:Insert[657.51 151.80 165.78]
	_PathFile:Insert[653.40 159.74 116.49]
	_PathFile:Insert[649.18 159.74 65.79]
	_PathFile:Insert[645.01 159.74 15.77]
	_PathFile:Insert[640.86 159.74 -34.06]
	_PathFile:Insert[636.68 159.74 -84.17]
	_PathFile:Insert[632.51 159.74 -134.31]
	_PathFile:Insert[628.34 159.74 -184.40]
	_PathFile:Insert[624.16 159.74 -234.53]
	_PathFile:Insert[619.99 159.74 -284.51]
	_PathFile:Insert[615.84 159.74 -334.43]
	_PathFile:Insert[611.66 159.74 -384.51]
	_PathFile:Insert[607.49 159.74 -434.63]
	_PathFile:Insert[603.92 159.74 -484.78]
	_PathFile:Insert[599.75 159.74 -534.95]
	_PathFile:Insert[595.01 159.74 -584.97]
	_PathFile:Insert[589.94 159.74 -638.56]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[589.82 112.77 -632.45]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function TakishBadlandsKigathorsGladeTakishBadlandsOvergrowth()
{
	_PathFile:Clear
	_PathFile:Insert[-401.80 245.21 214.40]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-401.80 292.28 214.40]
	_PathFile:Insert[-322.34 292.00 216.00]
	_PathFile:Insert[-272.15 292.00 219.04]
	_PathFile:Insert[-222.02 292.00 222.85]
	_PathFile:Insert[-171.84 292.00 225.29]
	_PathFile:Insert[-121.90 292.00 227.72]
	_PathFile:Insert[-71.94 292.00 230.25]
	_PathFile:Insert[-21.93 292.00 233.02]
	_PathFile:Insert[14.14 257.08 235.29]
	_PathFile:Insert[62.86 257.08 223.65]
	_PathFile:Insert[111.51 257.08 212.04]
	_PathFile:Insert[160.05 257.08 199.32]
	_PathFile:Insert[209.00 257.08 189.10]
	_PathFile:Insert[257.36 257.08 175.97]
	_PathFile:Insert[305.93 257.08 162.77]
	_PathFile:Insert[354.48 257.08 149.59]
	_PathFile:Insert[402.96 257.08 136.42]
	_PathFile:Insert[451.55 257.08 123.22]
	_PathFile:Insert[500.08 257.08 110.04]
	_PathFile:Insert[548.46 257.08 96.90]
	_PathFile:Insert[596.98 257.08 83.72]
	_PathFile:Insert[645.26 257.08 70.61]
	_PathFile:Insert[693.84 257.08 57.41]
	_PathFile:Insert[741.87 258.73 42.52]
	_PathFile:Insert[741.87 208.42 42.52]
	_PathFile:Insert[741.87 158.30 42.52]
	_PathFile:Insert[741.87 108.13 42.52]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[741.87 58.08 42.52]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function TakishBadlandsOvergrowthTakishBadlandsKigathorsGlade()
{
	_PathFile:Clear
	_PathFile:Insert[741.87 58.08 42.52]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[741.87 108.13 42.52]
	_PathFile:Insert[741.87 158.30 42.52]
	_PathFile:Insert[741.87 208.42 42.52]
	_PathFile:Insert[741.87 258.73 42.52]
	_PathFile:Insert[693.84 257.08 57.41]
	_PathFile:Insert[645.26 257.08 70.61]
	_PathFile:Insert[596.98 257.08 83.72]
	_PathFile:Insert[548.46 257.08 96.90]
	_PathFile:Insert[500.08 257.08 110.04]
	_PathFile:Insert[451.55 257.08 123.22]
	_PathFile:Insert[402.96 257.08 136.42]
	_PathFile:Insert[354.48 257.08 149.59]
	_PathFile:Insert[305.93 257.08 162.77]
	_PathFile:Insert[257.36 257.08 175.97]
	_PathFile:Insert[209.00 257.08 189.10]
	_PathFile:Insert[160.05 257.08 199.32]
	_PathFile:Insert[111.51 257.08 212.04]
	_PathFile:Insert[62.86 257.08 223.65]
	_PathFile:Insert[14.14 257.08 235.29]
	_PathFile:Insert[-21.93 292.00 233.02]
	_PathFile:Insert[-71.94 292.00 230.25]
	_PathFile:Insert[-121.90 292.00 227.72]
	_PathFile:Insert[-171.84 292.00 225.29]
	_PathFile:Insert[-222.02 292.00 222.85]
	_PathFile:Insert[-272.15 292.00 219.04]
	_PathFile:Insert[-322.34 292.00 216.00]
	_PathFile:Insert[-401.80 292.28 214.40]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-394.50 245.01 213.84]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function TakishBadlandsKigathorsGlade()
{
	_PathFile:Clear
	_PathFile:Insert[243.04 48.02 1183.43]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[243.04 77.21 1183.43]
	_PathFile:Insert[211.67 73.84 1150.42]
	_PathFile:Insert[179.93 73.84 1111.76]
	_PathFile:Insert[147.16 73.84 1073.71]
	_PathFile:Insert[114.36 73.84 1035.60]
	_PathFile:Insert[85.79 73.84 994.54]
	_PathFile:Insert[77.67 73.80 972.47]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[78.09 1.86 974.25]
	_PathFile:Insert[Custom|ClickActor|a transport of Growth]
	_PathFile:Insert[Custom|Wait|50]
	_PathFile:Insert[Custom|WaitWhileMoving]
	_PathFile:Insert[Custom|Wait|10]
	_PathFile:Insert[Custom|WaitWhileMoving]
	_PathFile:Insert[-396.37 249.54 144.74]
	_PathFile:Insert[-426.86 249.36 200.53]
	_PathFile:Insert[-396.58 245.01 212.86]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function TakishBadlandsOvergrowth()
{
	_PathFile:Clear
	_PathFile:Insert[241.60 48.08 1185.47]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[241.60 98.34 1185.47]
	_PathFile:Insert[241.60 148.51 1185.47]
	_PathFile:Insert[241.60 197.88 1185.47]
	_PathFile:Insert[260.45 197.88 1138.82]
	_PathFile:Insert[279.29 197.88 1092.20]
	_PathFile:Insert[298.03 197.88 1045.82]
	_PathFile:Insert[316.87 197.88 999.20]
	_PathFile:Insert[335.63 197.88 952.78]
	_PathFile:Insert[354.38 197.88 906.36]
	_PathFile:Insert[373.16 197.88 859.90]
	_PathFile:Insert[391.96 197.88 813.37]
	_PathFile:Insert[410.78 197.88 766.79]
	_PathFile:Insert[429.55 197.88 720.35]
	_PathFile:Insert[448.33 197.88 673.87]
	_PathFile:Insert[467.18 197.88 627.22]
	_PathFile:Insert[484.57 197.88 580.19]
	_PathFile:Insert[497.81 197.88 531.94]
	_PathFile:Insert[512.78 197.88 484.16]
	_PathFile:Insert[527.78 197.88 436.30]
	_PathFile:Insert[542.75 197.88 388.55]
	_PathFile:Insert[557.72 197.88 340.77]
	_PathFile:Insert[572.67 197.88 293.06]
	_PathFile:Insert[587.64 197.88 245.30]
	_PathFile:Insert[602.62 197.88 197.51]
	_PathFile:Insert[617.60 197.88 149.71]
	_PathFile:Insert[642.84 172.39 114.72]
	_PathFile:Insert[668.64 139.40 87.22]
	_PathFile:Insert[692.97 108.42 61.24]
	_PathFile:Insert[735.53 108.42 46.59]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[741.25 58.08 43.02]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausBloodandSand()
{
	_PathFile:Clear
	_PathFile:Insert[196.21 -60.43 461.32]
	_PathFile:Insert[163.21 -59.76 478.30]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausTheSultansDaggerRajDurPlateausBloodandSand()
{
	_PathFile:Clear
	_PathFile:Insert[67.20 87.57 -348.66]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[67.20 123.17 -348.66]
	_PathFile:Insert[70.30 123.17 -325.09]
	_PathFile:Insert[77.30 123.17 -277.48]
	_PathFile:Insert[82.52 123.17 -227.81]
	_PathFile:Insert[86.06 123.17 -177.65]
	_PathFile:Insert[89.59 123.17 -127.66]
	_PathFile:Insert[93.12 123.17 -77.70]
	_PathFile:Insert[96.64 123.17 -27.82]
	_PathFile:Insert[100.18 123.17 22.36]
	_PathFile:Insert[103.72 123.17 72.54]
	_PathFile:Insert[107.25 123.17 122.59]
	_PathFile:Insert[110.79 123.17 172.75]
	_PathFile:Insert[113.64 123.17 222.74]
	_PathFile:Insert[121.42 123.17 272.36]
	_PathFile:Insert[139.01 123.17 319.26]
	_PathFile:Insert[156.40 115.88 365.64]
	_PathFile:Insert[172.62 96.47 408.92]
	_PathFile:Insert[196.21 90.18 461.32]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[163.21 -59.76 478.30]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausBuriedTakishHizRajDurPlateausBloodandSand()
{
	_PathFile:Clear
	_PathFile:Insert[-535.32 11.28 433.75]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-535.32 46.77 433.75]
	_PathFile:Insert[-535.32 96.77 433.75]
	_PathFile:Insert[-535.32 140.77 433.75]
	_PathFile:Insert[-517.81 140.77 438.81]
	_PathFile:Insert[-475.88 140.77 449.74]
	_PathFile:Insert[-435.46 146.77 459.48]
	_PathFile:Insert[-394.79 146.77 468.60]
	_PathFile:Insert[-351.67 146.77 477.53]
	_PathFile:Insert[-302.77 146.77 487.13]
	_PathFile:Insert[-253.30 146.77 496.00]
	_PathFile:Insert[-203.87 146.77 504.86]
	_PathFile:Insert[-154.37 146.77 513.74]
	_PathFile:Insert[-104.33 146.77 517.96]
	_PathFile:Insert[-55.12 146.77 507.51]
	_PathFile:Insert[-6.12 146.77 497.10]
	_PathFile:Insert[43.13 146.77 486.65]
	_PathFile:Insert[92.26 146.77 476.21]
	_PathFile:Insert[141.21 146.77 465.82]
	_PathFile:Insert[196.21 146.77 461.32]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[163.21 -59.76 478.30]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausTheSultansDagger()
{
	_PathFile:Clear
	_PathFile:Insert[196.21 -60.43 461.32]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[196.21 -9.88 461.32]
	_PathFile:Insert[196.21 40.16 461.32]
	_PathFile:Insert[196.21 90.18 461.32]
	_PathFile:Insert[172.62 96.47 408.92]
	_PathFile:Insert[156.40 115.88 365.64]
	_PathFile:Insert[139.01 123.17 319.26]
	_PathFile:Insert[121.42 123.17 272.36]
	_PathFile:Insert[113.64 123.17 222.74]
	_PathFile:Insert[110.79 123.17 172.75]
	_PathFile:Insert[107.25 123.17 122.59]
	_PathFile:Insert[103.72 123.17 72.54]
	_PathFile:Insert[100.18 123.17 22.36]
	_PathFile:Insert[96.64 123.17 -27.82]
	_PathFile:Insert[93.12 123.17 -77.70]
	_PathFile:Insert[89.59 123.17 -127.66]
	_PathFile:Insert[86.06 123.17 -177.65]
	_PathFile:Insert[82.52 123.17 -227.81]
	_PathFile:Insert[77.30 123.17 -277.48]
	_PathFile:Insert[70.30 123.17 -325.09]
	_PathFile:Insert[67.20 123.17 -348.66]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[60.92 87.57 -349.34]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausBuriedTakishHiz()
{
	_PathFile:Clear
	_PathFile:Insert[196.21 -60.43 461.32]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[196.21 -9.98 461.32]
	_PathFile:Insert[196.21 40.05 461.32]
	_PathFile:Insert[196.21 90.22 461.32]
	_PathFile:Insert[196.21 146.77 461.32]
	_PathFile:Insert[141.21 146.77 465.82]
	_PathFile:Insert[92.26 146.77 476.21]
	_PathFile:Insert[43.13 146.77 486.65]
	_PathFile:Insert[-6.12 146.77 497.10]
	_PathFile:Insert[-55.12 146.77 507.51]
	_PathFile:Insert[-104.33 146.77 517.96]
	_PathFile:Insert[-154.37 146.77 513.74]
	_PathFile:Insert[-203.87 146.77 504.86]
	_PathFile:Insert[-253.30 146.77 496.00]
	_PathFile:Insert[-302.77 146.77 487.13]
	_PathFile:Insert[-351.67 146.77 477.53]
	_PathFile:Insert[-394.79 146.77 468.60]
	_PathFile:Insert[-435.46 146.77 459.48]
	_PathFile:Insert[-475.88 140.77 449.74]
	_PathFile:Insert[-517.81 140.77 438.81]
	_PathFile:Insert[-535.32 140.77 433.75]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-550.38 11.28 429.10]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausBuriedTakishHizRajDurPlateausTheSultansDagger()
{
	_PathFile:Clear

	_PathFile:Insert[-537.16 10.29 433.60]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-537.16 60.45 433.60]
	_PathFile:Insert[-537.16 110.63 433.60]
	_PathFile:Insert[-491.65 130.33 425.88]
	_PathFile:Insert[-442.33 130.33 417.52]
	_PathFile:Insert[-392.77 130.33 409.12]
	_PathFile:Insert[-343.41 130.33 400.76]
	_PathFile:Insert[-303.99 130.33 369.79]
	_PathFile:Insert[-280.41 130.33 325.46]
	_PathFile:Insert[-256.53 130.33 281.48]
	_PathFile:Insert[-232.51 130.33 237.25]
	_PathFile:Insert[-208.59 130.33 193.20]
	_PathFile:Insert[-184.67 130.33 149.16]
	_PathFile:Insert[-160.67 130.33 104.95]
	_PathFile:Insert[-136.77 130.33 60.96]
	_PathFile:Insert[-112.84 130.33 16.88]
	_PathFile:Insert[-88.95 130.33 -27.12]
	_PathFile:Insert[-65.08 130.33 -71.08]
	_PathFile:Insert[-41.12 130.33 -115.19]
	_PathFile:Insert[-17.11 130.33 -159.42]
	_PathFile:Insert[6.87 130.33 -203.57]
	_PathFile:Insert[30.90 130.33 -247.82]
	_PathFile:Insert[49.80 130.33 -293.59]
	_PathFile:Insert[65.78 130.33 -336.14]
	_PathFile:Insert[67.94 130.33 -346.77]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[62.07 87.35 -349.28]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RajDurPlateausTheSultansDaggerRajDurPlateausBuriedTakishHiz()
{
	_PathFile:Clear
	_PathFile:Insert[67.94 86.33 -346.76]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[67.94 130.33 -346.77]
	_PathFile:Insert[65.78 130.33 -336.14]
	_PathFile:Insert[49.80 130.33 -293.59]
	_PathFile:Insert[30.90 130.33 -247.82]
	_PathFile:Insert[6.87 130.33 -203.57]
	_PathFile:Insert[-17.11 130.33 -159.42]
	_PathFile:Insert[-41.12 130.33 -115.19]
	_PathFile:Insert[-65.08 130.33 -71.08]
	_PathFile:Insert[-88.95 130.33 -27.12]
	_PathFile:Insert[-112.84 130.33 16.88]
	_PathFile:Insert[-136.77 130.33 60.96]
	_PathFile:Insert[-160.67 130.33 104.95]
	_PathFile:Insert[-184.67 130.33 149.16]
	_PathFile:Insert[-208.59 130.33 193.20]
	_PathFile:Insert[-232.51 130.33 237.25]
	_PathFile:Insert[-256.53 130.33 281.48]
	_PathFile:Insert[-280.41 130.33 325.46]
	_PathFile:Insert[-303.99 130.33 369.79]
	_PathFile:Insert[-343.41 130.33 400.76]
	_PathFile:Insert[-392.77 130.33 409.12]
	_PathFile:Insert[-442.33 130.33 417.52]
	_PathFile:Insert[-491.65 130.33 425.88]
	_PathFile:Insert[-537.16 130.33 433.60]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-550.38 11.28 429.10]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function RenfrysBasementForlornGistInstances()
{
	_PathFile:Clear
	;_PathFile:Insert[-0.18 0.02 28.59]
	;_PathFile:Insert[Custom|Wait|40]
	;_PathFile:Insert[-0.18 0.02 28.59]
	;_PathFile:Insert[Custom|Wait|10]
	;_PathFile:Insert[Custom|ZoneDoor|zone_from_forlorn_tradeskill]
	if !${Others}
	{
		_PathFile:Insert[-326.30 13.94 52.29]
		_PathFile:Insert[Custom|HailActor|a forlorn stable master|2]
		_PathFile:Insert[Custom|WaitWhileMoving]
	}
	
	call NavigatePath
}
function RenfrysBasementForlornGistMerchantsDen()
{
	_PathFile:Clear
	;_PathFile:Insert[-0.18 0.02 28.59]
	;_PathFile:Insert[Custom|Wait|40]
	;_PathFile:Insert[-0.18 0.02 28.59]
	;_PathFile:Insert[Custom|Wait|10]
	;_PathFile:Insert[Custom|ZoneDoor|zone_from_forlorn_tradeskill]
	if !${Others}
	{
		_PathFile:Insert[-353.74 13.60 60.38]
		_PathFile:Insert[-348.66 13.18 51.72]
		_PathFile:Insert[-343.92 13.43 42.76]
		_PathFile:Insert[-339.10 13.61 33.76]
		_PathFile:Insert[-333.87 13.54 24.93]
		_PathFile:Insert[-328.97 10.47 16.74]
		_PathFile:Insert[-324.22 6.51 8.78]
		_PathFile:Insert[-321.24 5.40 -0.92]
		_PathFile:Insert[-322.89 4.17 -11.00]
		_PathFile:Insert[-325.92 2.97 -20.46]
		_PathFile:Insert[-329.15 2.17 -30.01]
		_PathFile:Insert[-332.45 1.79 -39.69]
		_PathFile:Insert[-335.68 1.01 -49.15]
		_PathFile:Insert[-338.91 0.87 -58.66]
		_PathFile:Insert[-342.21 0.24 -68.32]
		_PathFile:Insert[-345.52 -0.01 -78.06]
		_PathFile:Insert[-348.81 -0.10 -87.70]
		_PathFile:Insert[-352.04 0.31 -97.18]
		_PathFile:Insert[-355.32 0.32 -106.80]
		_PathFile:Insert[-358.70 0.32 -116.49]
		_PathFile:Insert[-362.59 0.49 -126.04]
		_PathFile:Insert[-366.48 0.54 -135.41]
		_PathFile:Insert[-370.56 0.49 -144.55]
		_PathFile:Insert[-375.64 0.32 -153.18]
		_PathFile:Insert[-381.97 0.32 -161.23]
		_PathFile:Insert[-388.46 0.23 -169.30]
		_PathFile:Insert[-394.82 -0.19 -177.20]
		_PathFile:Insert[-400.70 -0.03 -185.52]
		_PathFile:Insert[-401.53 0.03 -195.76]
		_PathFile:Insert[-398.12 0.45 -205.30]
		_PathFile:Insert[-391.82 2.15 -212.95]
		_PathFile:Insert[-384.21 4.19 -219.39]
		_PathFile:Insert[-375.90 6.04 -224.66]
		_PathFile:Insert[-367.07 8.45 -228.95]
		_PathFile:Insert[-357.59 10.14 -233.25]
		_PathFile:Insert[-348.33 11.26 -237.39]
		_PathFile:Insert[-338.90 13.03 -241.29]
		_PathFile:Insert[-329.81 15.02 -245.04]
		_PathFile:Insert[-320.82 16.38 -249.41]
		_PathFile:Insert[-311.94 17.38 -254.84]
		_PathFile:Insert[-304.05 19.30 -260.98]
		_PathFile:Insert[-294.86 21.66 -263.19]
		_PathFile:Insert[-287.64 26.31 -268.68]
		_PathFile:Insert[-282.07 34.00 -272.47]
		_PathFile:Insert[-274.81 38.43 -278.15]
		_PathFile:Insert[-267.48 39.39 -285.00]
		_PathFile:Insert[-260.61 39.47 -292.65]
		_PathFile:Insert[-254.18 38.51 -300.27]
		_PathFile:Insert[-250.09 38.56 -309.66]
		_PathFile:Insert[-246.48 42.92 -318.13]
		_PathFile:Insert[-244.67 48.03 -326.98]
		_PathFile:Insert[-248.03 51.72 -336.89]
		_PathFile:Insert[-251.64 53.64 -344.78]
		_PathFile:Insert[-261.84 53.43 -345.72]
		_PathFile:Insert[-272.11 53.52 -345.08]
		_PathFile:Insert[-282.33 53.52 -345.33]
		_PathFile:Insert[-289.55 53.67 -345.43]
		_PathFile:Insert[Custom|Wait|20]
	}
	
	call NavigatePath
}
function SvarniExpanseInstancesKaruupaJunglePad()
{
	_PathFile:Clear
	_PathFile:Insert[-546.48 81.45 -525.99]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-546.48 131.57 -525.99]
	_PathFile:Insert[-530.42 138.79 -478.99]
	_PathFile:Insert[-514.25 138.79 -431.67]
	_PathFile:Insert[-481.23 138.79 -393.60]
	_PathFile:Insert[-446.08 138.79 -357.64]
	_PathFile:Insert[-411.53 138.79 -321.05]
	_PathFile:Insert[-377.10 138.79 -284.57]
	_PathFile:Insert[-342.64 138.79 -248.06]
	_PathFile:Insert[-308.27 138.79 -211.65]
	_PathFile:Insert[-273.87 138.79 -175.22]
	_PathFile:Insert[-239.30 138.79 -138.59]
	_PathFile:Insert[-204.87 138.79 -102.12]
	_PathFile:Insert[-170.49 138.79 -65.69]
	_PathFile:Insert[-136.05 138.79 -29.21]
	_PathFile:Insert[-101.60 138.79 7.28]
	_PathFile:Insert[-67.13 138.79 43.80]
	_PathFile:Insert[-32.78 138.79 80.19]
	_PathFile:Insert[1.67 138.79 116.69]
	_PathFile:Insert[13.32 138.79 165.47]
	_PathFile:Insert[16.61 138.79 215.77]
	_PathFile:Insert[11.54 138.79 265.59]
	_PathFile:Insert[5.13 128.92 314.45]
	_PathFile:Insert[-0.68 115.74 362.33]
	_PathFile:Insert[-6.51 102.51 410.35]
	_PathFile:Insert[-12.36 89.25 458.52]
	_PathFile:Insert[-18.19 76.04 506.50]
	_PathFile:Insert[-23.35 64.34 548.98]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-31.22 52.50 551.82]
	_PathFile:Insert[Custom|HailActor|a plumedrake keeper|2]
	_PathFile:Insert[Custom|TravelMap|Karuupa Jungle]
	_PathFile:Insert[Custom|WaitWhileMoving]
	
	call NavigatePath
}
function MahngaviWastesEntranceMahngaviWastesGhoulinda()
{
	_PathFile:Clear
	_PathFile:Insert[568.00 142.90 530.19]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[568.00 192.98 530.19]
	_PathFile:Insert[527.52 199.83 501.57]
	_PathFile:Insert[510.72 216.69 457.33]
	_PathFile:Insert[498.01 216.69 408.76]
	_PathFile:Insert[504.91 205.09 360.43]
	_PathFile:Insert[513.85 184.64 315.57]
	_PathFile:Insert[523.12 159.72 273.05]
	_PathFile:Insert[532.48 131.44 232.67]
	_PathFile:Insert[542.69 99.24 177.94]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[540.73 95.51 166.05]
	_PathFile:Insert[Custom|ZoneDoor|Ghoulinda's Lair]
	_PathFile:Insert[-70.07 -3.04 -117.79]
	_PathFile:Insert[-69.66 -3.04 -121.21]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function MahngaviWastesEntranceMahngaviWastesInstances()
{
	_PathFile:Clear
	_PathFile:Insert[559.21 141.63 531.92]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[559.21 191.66 531.92]
	_PathFile:Insert[540.77 225.69 500.06]
	_PathFile:Insert[517.75 222.95 455.52]
	_PathFile:Insert[494.69 222.95 410.92]
	_PathFile:Insert[484.49 222.95 361.89]
	_PathFile:Insert[477.89 222.95 312.14]
	_PathFile:Insert[472.44 222.95 262.31]
	_PathFile:Insert[469.31 222.95 212.32]
	_PathFile:Insert[466.19 222.95 162.29]
	_PathFile:Insert[463.06 222.95 112.19]
	_PathFile:Insert[459.94 222.95 62.16]
	_PathFile:Insert[456.81 222.95 11.95]
	_PathFile:Insert[453.69 222.95 -38.02]
	_PathFile:Insert[450.56 222.95 -88.04]
	_PathFile:Insert[447.43 222.95 -138.21]
	_PathFile:Insert[468.19 212.84 -182.65]
	_PathFile:Insert[492.26 197.17 -223.87]
	_PathFile:Insert[517.70 176.55 -262.00]
	_PathFile:Insert[542.39 154.95 -300.00]
	_PathFile:Insert[566.38 127.96 -334.68]
	_PathFile:Insert[595.06 99.76 -364.49]
	_PathFile:Insert[609.58 69.86 -402.27]
	_PathFile:Insert[631.30 60.71 -447.31]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[645.20 48.73 -446.90]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function RenfrysBasementMahngaviWastesEntrance()
{
	_PathFile:Clear
	;_PathFile:Insert[-0.12 0.02 28.71]
	;_PathFile:Insert[Custom|Wait|40]
	;_PathFile:Insert[-0.12 0.02 28.71]
	;_PathFile:Insert[Custom|Wait|10]
	;_PathFile:Insert[Custom|ZoneDoor|zone_from_forlorn_tradeskill]
	_PathFile:Insert[-349.92 13.21 56.56]
	_PathFile:Insert[-345.51 13.23 47.52]
	_PathFile:Insert[-341.21 13.59 38.49]
	_PathFile:Insert[-336.73 13.80 29.31]
	_PathFile:Insert[-332.03 12.55 20.22]
	_PathFile:Insert[-323.64 8.00 16.11]
	_PathFile:Insert[-314.42 6.76 11.75]
	_PathFile:Insert[-319.09 5.72 2.57]
	_PathFile:Insert[-323.37 4.76 -6.43]
	_PathFile:Insert[-327.40 3.40 -15.77]
	_PathFile:Insert[-330.61 2.36 -25.23]
	_PathFile:Insert[-333.76 1.81 -34.87]
	_PathFile:Insert[-336.92 1.14 -44.65]
	_PathFile:Insert[-339.61 0.90 -54.48]
	_PathFile:Insert[-342.26 0.61 -64.18]
	_PathFile:Insert[-344.93 -0.01 -73.94]
	_PathFile:Insert[-347.66 -0.13 -83.91]
	_PathFile:Insert[-350.36 0.29 -93.78]
	_PathFile:Insert[-353.60 0.32 -103.43]
	_PathFile:Insert[-357.10 0.32 -112.96]
	_PathFile:Insert[-360.83 0.53 -122.38]
	_PathFile:Insert[-364.84 0.50 -131.76]
	_PathFile:Insert[-369.08 0.49 -141.07]
	_PathFile:Insert[-373.61 0.32 -150.24]
	_PathFile:Insert[-379.27 0.32 -158.60]
	_PathFile:Insert[-385.99 0.32 -166.05]
	_PathFile:Insert[-393.68 -0.17 -172.68]
	_PathFile:Insert[-402.00 -0.23 -178.70]
	_PathFile:Insert[-410.91 -0.06 -183.88]
	_PathFile:Insert[-419.90 0.20 -188.30]
	_PathFile:Insert[-429.34 0.39 -192.24]
	_PathFile:Insert[-438.97 0.75 -195.25]
	_PathFile:Insert[-449.04 1.27 -196.94]
	_PathFile:Insert[-459.33 1.74 -196.82]
	_PathFile:Insert[-469.47 1.95 -196.40]
	_PathFile:Insert[-479.65 2.22 -196.25]
	_PathFile:Insert[-489.84 2.13 -196.09]
	_PathFile:Insert[-500.10 2.13 -195.94]
	_PathFile:Insert[-510.17 2.15 -196.10]
	_PathFile:Insert[-520.38 2.15 -196.84]
	_PathFile:Insert[-536.65 1.73 -199.30]
	_PathFile:Insert[Custom|ZoneDoor|Zone to Mahngavi Wastes]
	
	call NavigatePath
}
function KaruupaJunglePredatorsPerchKaruupaJungleDedrakasDescent()
{
	_PathFile:Clear
	_PathFile:Insert[-743.86 196.38 -270.56]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-743.86 229.62 -270.56]
	_PathFile:Insert[-703.68 229.62 -240.58]
	_PathFile:Insert[-703.68 279.71 -240.58]
	_PathFile:Insert[-680.99 314.64 -268.59]
	_PathFile:Insert[-652.20 324.15 -308.39]
	_PathFile:Insert[-620.13 324.15 -347.01]
	_PathFile:Insert[-586.95 324.15 -384.47]
	_PathFile:Insert[-553.63 324.15 -422.08]
	_PathFile:Insert[-520.39 324.15 -459.61]
	_PathFile:Insert[-487.03 324.15 -497.27]
	_PathFile:Insert[-453.77 324.15 -534.83]
	_PathFile:Insert[-420.33 324.15 -572.58]
	_PathFile:Insert[-386.92 324.15 -609.95]
	_PathFile:Insert[-351.03 324.15 -645.09]
	_PathFile:Insert[-309.18 322.17 -673.00]
	_PathFile:Insert[-264.72 304.09 -688.05]
	_PathFile:Insert[-236.59 295.35 -692.65]
	_PathFile:Insert[Custom|RIMObj.FlyDown]]
	_PathFile:Insert[-233.14 109.54 -691.85]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}

function KaruupaJunglePredatorsPerchKaruupaJungleHeartofConflict()
{
	_PathFile:Clear
	_PathFile:Insert[-760.23 195.91 -258.13]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-760.23 246.08 -258.13]
	_PathFile:Insert[-724.53 281.15 -258.10]
	_PathFile:Insert[-682.31 307.97 -258.06]
	_PathFile:Insert[-632.04 307.97 -258.02]
	_PathFile:Insert[-581.89 307.97 -257.98]
	_PathFile:Insert[-531.88 307.97 -254.88]
	_PathFile:Insert[-482.19 309.43 -248.76]
	_PathFile:Insert[-432.31 309.43 -242.80]
	_PathFile:Insert[-382.47 309.43 -236.84]
	_PathFile:Insert[-332.54 309.43 -230.87]
	_PathFile:Insert[-282.83 308.32 -225.04]
	_PathFile:Insert[-234.14 297.10 -220.31]
	_PathFile:Insert[-185.55 285.91 -215.60]
	_PathFile:Insert[-136.91 274.71 -210.89]
	_PathFile:Insert[-87.89 267.41 -203.22]
	_PathFile:Insert[-39.40 263.83 -191.13]
	_PathFile:Insert[9.31 260.20 -178.98]
	_PathFile:Insert[57.83 256.54 -166.89]
	_PathFile:Insert[106.32 252.88 -154.80]
	_PathFile:Insert[154.95 251.12 -142.67]
	_PathFile:Insert[203.48 251.12 -130.56]
	_PathFile:Insert[253.01 251.12 -122.14]
	_PathFile:Insert[293.37 251.12 -151.69]
	_PathFile:Insert[332.53 251.12 -182.83]
	_PathFile:Insert[374.44 251.12 -210.53]
	_PathFile:Insert[418.58 251.12 -234.13]
	_PathFile:Insert[462.78 251.12 -257.79]
	_PathFile:Insert[507.09 251.12 -281.50]
	_PathFile:Insert[551.14 244.23 -304.60]
	_PathFile:Insert[594.79 231.68 -325.98]
	_PathFile:Insert[638.68 218.53 -346.78]
	_PathFile:Insert[681.09 204.54 -369.34]
	_PathFile:Insert[724.60 187.17 -387.62]
	_PathFile:Insert[746.69 180.93 -395.40]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[745.70 168.18 -387.30]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}

function KaruupaJunglePadKaruupaJunglePredatorsPerch()
{
	_PathFile:Clear
	_PathFile:Insert[752.83 194.47 -777.65]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[752.83 244.62 -777.65]
	_PathFile:Insert[721.90 245.60 -738.16]
	_PathFile:Insert[690.86 245.60 -698.54]
	_PathFile:Insert[659.96 245.60 -659.08]
	_PathFile:Insert[629.07 245.60 -619.64]
	_PathFile:Insert[598.08 245.60 -580.06]
	_PathFile:Insert[567.20 245.60 -540.64]
	_PathFile:Insert[536.33 245.60 -501.23]
	_PathFile:Insert[505.31 245.60 -461.62]
	_PathFile:Insert[474.28 245.60 -422.00]
	_PathFile:Insert[443.45 245.60 -382.63]
	_PathFile:Insert[412.58 245.60 -343.23]
	_PathFile:Insert[381.47 245.60 -303.49]
	_PathFile:Insert[350.51 245.60 -263.96]
	_PathFile:Insert[319.57 245.60 -224.46]
	_PathFile:Insert[288.72 245.60 -185.07]
	_PathFile:Insert[257.73 245.60 -145.50]
	_PathFile:Insert[226.76 245.60 -105.95]
	_PathFile:Insert[176.82 245.60 -100.12]
	_PathFile:Insert[129.28 245.60 -115.66]
	_PathFile:Insert[81.75 245.60 -131.19]
	_PathFile:Insert[34.17 245.60 -146.74]
	_PathFile:Insert[-14.19 245.60 -160.17]
	_PathFile:Insert[-62.48 245.60 -173.57]
	_PathFile:Insert[-110.94 245.60 -187.01]
	_PathFile:Insert[-159.12 245.60 -200.38]
	_PathFile:Insert[-207.47 245.60 -213.79]
	_PathFile:Insert[-256.71 245.60 -224.16]
	_PathFile:Insert[-306.24 245.60 -232.30]
	_PathFile:Insert[-355.73 245.60 -240.43]
	_PathFile:Insert[-405.33 245.60 -248.59]
	_PathFile:Insert[-409.79 298.17 -249.48]
	_PathFile:Insert[-458.52 304.29 -259.25]
	_PathFile:Insert[-508.07 304.29 -266.73]
	_PathFile:Insert[-558.14 304.29 -269.56]
	_PathFile:Insert[-608.29 304.29 -272.26]
	_PathFile:Insert[-658.35 304.29 -274.96]
	_PathFile:Insert[-706.11 297.44 -261.41]
	_PathFile:Insert[-733.24 286.40 -220.60]
	_PathFile:Insert[-761.65 245.30 -225.52]
	_PathFile:Insert[-755.23 210.37 -260.71]
	_PathFile:Insert[-752.67 202.92 -269.55]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-746.29 197.41 -284.27]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function KaruupaJungleHeartofConflictKaruupaJunglePredatorsPerch()
{
	_PathFile:Clear
	_PathFile:Insert[748.43 168.32 -395.57]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[748.43 218.50 -395.57]
	_PathFile:Insert[702.83 224.43 -375.30]
	_PathFile:Insert[656.90 224.43 -354.89]
	_PathFile:Insert[610.96 224.43 -334.47]
	_PathFile:Insert[565.11 224.43 -314.10]
	_PathFile:Insert[524.78 248.42 -296.17]
	_PathFile:Insert[481.62 265.61 -276.99]
	_PathFile:Insert[439.47 285.35 -258.26]
	_PathFile:Insert[393.64 285.35 -237.89]
	_PathFile:Insert[348.65 277.50 -217.28]
	_PathFile:Insert[304.22 266.45 -196.72]
	_PathFile:Insert[259.77 255.39 -176.14]
	_PathFile:Insert[214.16 250.83 -155.53]
	_PathFile:Insert[168.27 250.83 -135.14]
	_PathFile:Insert[122.56 250.83 -114.83]
	_PathFile:Insert[74.04 250.83 -127.46]
	_PathFile:Insert[26.25 250.83 -142.91]
	_PathFile:Insert[-20.41 261.81 -157.42]
	_PathFile:Insert[-68.54 265.43 -171.04]
	_PathFile:Insert[-116.87 269.01 -183.70]
	_PathFile:Insert[-164.76 278.80 -194.89]
	_PathFile:Insert[-212.71 288.47 -205.46]
	_PathFile:Insert[-261.70 292.85 -214.84]
	_PathFile:Insert[-311.12 292.85 -223.96]
	_PathFile:Insert[-360.42 292.85 -233.06]
	_PathFile:Insert[-410.26 292.85 -238.62]
	_PathFile:Insert[-460.49 292.85 -240.07]
	_PathFile:Insert[-510.49 289.65 -240.55]
	_PathFile:Insert[-558.07 278.25 -230.15]
	_PathFile:Insert[-602.97 258.28 -219.83]
	_PathFile:Insert[-649.08 239.75 -213.11]
	_PathFile:Insert[-696.09 227.47 -201.06]
	_PathFile:Insert[-729.79 213.38 -235.25]
	_PathFile:Insert[-751.18 202.00 -269.73]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-746.05 197.63 -285.22]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function KaruupaJungleDedrakasDescentKaruupaJunglePredatorsPerch()
{
	_PathFile:Clear
	_PathFile:Insert[-239.49 109.81 -682.80]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-239.49 160.02 -682.80]
	_PathFile:Insert[-261.31 202.98 -669.29]
	_PathFile:Insert[-292.03 238.24 -651.02]
	_PathFile:Insert[-326.96 268.39 -631.66]
	_PathFile:Insert[-360.99 300.26 -612.80]
	_PathFile:Insert[-400.95 320.59 -590.65]
	_PathFile:Insert[-441.03 340.96 -568.28]
	_PathFile:Insert[-479.26 340.96 -535.64]
	_PathFile:Insert[-517.34 340.96 -503.08]
	_PathFile:Insert[-553.07 358.43 -472.53]
	_PathFile:Insert[-591.31 358.43 -439.83]
	_PathFile:Insert[-605.84 346.60 -393.46]
	_PathFile:Insert[-614.50 341.52 -344.48]
	_PathFile:Insert[-624.76 326.77 -297.63]
	_PathFile:Insert[-629.37 308.28 -251.31]
	_PathFile:Insert[-660.44 274.87 -230.62]
	_PathFile:Insert[-698.30 244.80 -216.67]
	_PathFile:Insert[-744.00 240.31 -196.17]
	_PathFile:Insert[-750.20 227.09 -244.29]
	_PathFile:Insert[-750.57 223.98 -268.64]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-746.00 197.57 -284.76]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function KaruupaJungleHeartofConflictKaruupaJungleDedrakasDescent()
{
	_PathFile:Clear
	_PathFile:Insert[749.65 168.32 -397.32]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[749.65 218.47 -397.32]
	_PathFile:Insert[703.94 222.46 -377.18]
	_PathFile:Insert[657.95 222.46 -356.91]
	_PathFile:Insert[611.72 222.46 -336.54]
	_PathFile:Insert[565.50 222.46 -316.17]
	_PathFile:Insert[519.27 222.46 -295.80]
	_PathFile:Insert[473.08 222.46 -275.44]
	_PathFile:Insert[426.86 222.46 -255.07]
	_PathFile:Insert[380.87 222.46 -234.80]
	_PathFile:Insert[334.75 222.46 -214.48]
	_PathFile:Insert[288.53 222.46 -194.11]
	_PathFile:Insert[242.32 222.46 -173.75]
	_PathFile:Insert[196.56 221.05 -153.36]
	_PathFile:Insert[150.53 221.05 -133.08]
	_PathFile:Insert[104.72 221.05 -112.89]
	_PathFile:Insert[54.78 220.76 -117.75]
	_PathFile:Insert[20.79 220.67 -154.44]
	_PathFile:Insert[-10.54 220.57 -193.61]
	_PathFile:Insert[-37.28 220.48 -236.12]
	_PathFile:Insert[-63.93 220.39 -278.48]
	_PathFile:Insert[-90.56 220.30 -320.81]
	_PathFile:Insert[-117.21 220.21 -363.19]
	_PathFile:Insert[-144.01 220.11 -405.78]
	_PathFile:Insert[-170.65 220.02 -448.13]
	_PathFile:Insert[-197.37 219.93 -490.60]
	_PathFile:Insert[-218.69 205.10 -533.57]
	_PathFile:Insert[-232.61 184.63 -577.32]
	_PathFile:Insert[-239.16 162.02 -621.72]
	_PathFile:Insert[-235.21 137.79 -665.61]
	_PathFile:Insert[-234.06 125.48 -686.28]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-232.49 109.59 -691.35]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function KaruupaJungleDedrakasDescentKaruupaJungleHeartofConflict()
{
	_PathFile:Clear
	_PathFile:Insert[-235.41 106.44 -667.19]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-235.41 156.71 -667.19]
	_PathFile:Insert[-227.67 191.24 -631.56]
	_PathFile:Insert[-217.27 195.01 -582.60]
	_PathFile:Insert[-206.85 195.01 -533.57]
	_PathFile:Insert[-196.45 195.01 -484.60]
	_PathFile:Insert[-186.04 195.01 -435.60]
	_PathFile:Insert[-175.60 195.01 -386.44]
	_PathFile:Insert[-165.20 195.01 -337.48]
	_PathFile:Insert[-143.74 188.32 -292.79]
	_PathFile:Insert[-110.69 187.52 -255.00]
	_PathFile:Insert[-77.75 187.52 -217.33]
	_PathFile:Insert[-43.80 187.52 -180.43]
	_PathFile:Insert[-4.81 187.52 -148.84]
	_PathFile:Insert[35.37 187.52 -118.66]
	_PathFile:Insert[83.49 187.52 -104.06]
	_PathFile:Insert[131.38 187.52 -89.52]
	_PathFile:Insert[179.32 187.52 -74.97]
	_PathFile:Insert[229.24 187.62 -78.28]
	_PathFile:Insert[274.32 187.62 -100.44]
	_PathFile:Insert[319.32 187.62 -122.56]
	_PathFile:Insert[364.34 187.62 -144.68]
	_PathFile:Insert[407.32 198.37 -168.24]
	_PathFile:Insert[448.63 202.31 -196.31]
	_PathFile:Insert[490.23 202.31 -224.56]
	_PathFile:Insert[532.15 202.31 -252.21]
	_PathFile:Insert[574.49 202.31 -279.04]
	_PathFile:Insert[616.93 202.31 -305.93]
	_PathFile:Insert[659.17 202.31 -332.70]
	_PathFile:Insert[701.49 202.29 -359.52]
	_PathFile:Insert[739.22 181.54 -385.32]
	_PathFile:Insert[747.70 175.57 -397.53]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[745.79 168.17 -388.36]
	_PathFile:Insert[Custom|Wait|20]
	
	call NavigatePath
}
function KaruupaJunglePadKaruupaJungleDedrakasDescent()
{
	;echo KaruupaJunglePadKaruupaJungleDedrakasDescent
	_PathFile:Clear
	_PathFile:Insert[752.57 194.47 -777.80]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[752.57 240.38 -777.80]
	_PathFile:Insert[721.57 240.38 -738.19]
	_PathFile:Insert[690.61 240.38 -698.65]
	_PathFile:Insert[659.62 240.38 -659.07]
	_PathFile:Insert[628.61 240.38 -619.46]
	_PathFile:Insert[597.79 240.38 -580.09]
	_PathFile:Insert[566.91 240.38 -540.65]
	_PathFile:Insert[535.96 240.38 -501.11]
	_PathFile:Insert[505.03 240.38 -461.61]
	_PathFile:Insert[474.60 230.86 -422.71]
	_PathFile:Insert[445.73 215.03 -384.81]
	_PathFile:Insert[416.92 199.23 -346.99]
	_PathFile:Insert[388.16 183.46 -309.25]
	_PathFile:Insert[359.40 167.69 -271.50]
	_PathFile:Insert[325.42 151.83 -238.05]
	_PathFile:Insert[290.77 136.03 -205.52]
	_PathFile:Insert[255.87 120.90 -172.95]
	_PathFile:Insert[218.19 120.19 -139.67]
	_PathFile:Insert[168.24 120.19 -136.64]
	_PathFile:Insert[118.07 120.19 -139.77]
	_PathFile:Insert[74.48 120.19 -164.60]
	_PathFile:Insert[37.41 120.19 -198.44]
	_PathFile:Insert[-4.05 120.19 -227.04]
	_PathFile:Insert[-45.21 120.19 -255.44]
	_PathFile:Insert[-86.56 120.19 -283.97]
	_PathFile:Insert[-111.28 120.19 -327.47]
	_PathFile:Insert[-132.88 120.19 -372.88]
	_PathFile:Insert[-157.16 124.66 -414.59]
	_PathFile:Insert[-182.22 124.66 -458.10]
	_PathFile:Insert[-207.25 125.64 -501.56]
	_PathFile:Insert[-225.57 159.62 -533.37]
	_PathFile:Insert[-234.07 159.62 -582.98]
	_PathFile:Insert[-234.40 149.11 -632.02]
	_PathFile:Insert[-233.80 127.32 -677.26]
	_PathFile:Insert[-232.65 122.76 -684.40]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-231.94 109.64 -691.18]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
	;echo KaruupaJunglePadKaruupaJungleDedrakasDescent END
}
function KaruupaJunglePadKaruupaJungleHeartofConflict()
{
	;echo KaruupaJunglePadKaruupaJungleHeartofConflict
	_PathFile:Clear
	_PathFile:Insert[752.86 194.48 -777.95]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[752.86 238.03 -777.95]
	_PathFile:Insert[755.85 238.03 -727.93]
	_PathFile:Insert[757.96 238.03 -677.89]
	_PathFile:Insert[759.97 228.69 -628.52]
	_PathFile:Insert[762.01 214.20 -580.54]
	_PathFile:Insert[764.05 199.71 -532.55]
	_PathFile:Insert[758.85 191.23 -483.23]
	_PathFile:Insert[752.05 186.95 -433.52]
	_PathFile:Insert[747.14 186.94 -397.70]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[745.53 168.17 -388.38]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
	;echo KaruupaJunglePadKaruupaJungleHeartofConflict END
}
function SvarniExpanseSvarniGatewayKaruupaJunglePad()
{
	;echo SvarniExpanseSvarniGatewayKaruupaJunglePad
	_PathFile:Clear
	_PathFile:Insert[703.56 5.60 520.86]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[703.56 55.68 520.86]
	_PathFile:Insert[656.85 73.99 520.10]
	_PathFile:Insert[606.76 73.99 519.28]
	_PathFile:Insert[556.48 73.99 518.46]
	_PathFile:Insert[506.40 73.99 518.80]
	_PathFile:Insert[458.37 87.82 521.97]
	_PathFile:Insert[408.43 87.82 524.90]
	_PathFile:Insert[358.23 87.82 527.71]
	_PathFile:Insert[308.22 87.82 530.51]
	_PathFile:Insert[258.14 87.82 533.31]
	_PathFile:Insert[208.21 87.82 536.10]
	_PathFile:Insert[158.00 87.82 538.90]
	_PathFile:Insert[107.94 87.82 540.41]
	_PathFile:Insert[58.48 80.85 544.02]
	_PathFile:Insert[10.13 68.92 548.59]
	_PathFile:Insert[-23.76 59.14 551.38]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-30.34 52.50 552.47]
	_PathFile:Insert[Custom|HailActor|a plumedrake keeper|2]
	_PathFile:Insert[Custom|TravelMap|Karuupa Jungle]
	_PathFile:Insert[Custom|WaitWhileMoving]

	call NavigatePath
	;echo SvarniExpanseSvarniGatewayKaruupaJunglePad END
}
function SvarniExpanseSvarniGatewaySvarniExpanseInstances()
{
	_PathFile:Clear
	_PathFile:Insert[743.32 2.48 518.81]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[743.32 52.83 518.81]
	_PathFile:Insert[712.79 54.11 479.04]
	_PathFile:Insert[684.82 74.27 442.61]
	_PathFile:Insert[655.46 89.69 405.15]
	_PathFile:Insert[623.40 89.69 366.40]
	_PathFile:Insert[585.97 89.69 333.07]
	_PathFile:Insert[546.14 89.69 302.64]
	_PathFile:Insert[507.25 89.69 270.86]
	_PathFile:Insert[469.20 101.58 240.24]
	_PathFile:Insert[428.90 101.58 210.49]
	_PathFile:Insert[388.62 101.58 180.76]
	_PathFile:Insert[348.15 101.58 150.89]
	_PathFile:Insert[307.74 101.58 121.07]
	_PathFile:Insert[267.50 101.58 91.37]
	_PathFile:Insert[225.97 101.58 63.17]
	_PathFile:Insert[183.40 101.58 36.49]
	_PathFile:Insert[140.77 101.58 10.05]
	_PathFile:Insert[97.99 101.58 -16.48]
	_PathFile:Insert[55.27 101.58 -42.97]
	_PathFile:Insert[12.64 101.58 -69.41]
	_PathFile:Insert[-29.84 101.58 -96.19]
	_PathFile:Insert[-70.87 108.38 -123.95]
	_PathFile:Insert[-112.42 108.38 -152.06]
	_PathFile:Insert[-154.05 108.38 -180.22]
	_PathFile:Insert[-195.55 108.38 -208.30]
	_PathFile:Insert[-237.15 108.38 -236.44]
	_PathFile:Insert[-278.83 108.38 -264.64]
	_PathFile:Insert[-320.10 114.13 -292.56]
	_PathFile:Insert[-361.78 114.13 -320.76]
	_PathFile:Insert[-403.31 114.13 -348.86]
	_PathFile:Insert[-444.96 114.13 -377.04]
	_PathFile:Insert[-486.53 114.13 -405.16]
	_PathFile:Insert[-522.26 114.29 -429.26]
	_PathFile:Insert[-536.04 105.08 -476.76]
	_PathFile:Insert[-540.78 102.76 -528.55]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-523.72 89.88 -533.43]
	_PathFile:Insert[Custom|Wait|20]

	call NavigatePath
}
function LopingPlainsSpiresLopingPlainsVDEntrance()
{
	_PathFile:Clear
	_PathFile:Insert[61.994144 94.930382 -307.442352]
	_PathFile:Insert[22.198353 94.930382 -276.838165]
	_PathFile:Insert[-17.629810 94.930382 -246.209381]
	_PathFile:Insert[-57.394810 94.930382 -215.627579]
	_PathFile:Insert[-97.112411 94.930382 -185.082123]
	_PathFile:Insert[-136.956161 94.930382 -154.439728]
	_PathFile:Insert[-176.705948 94.930382 -123.870132]
	_PathFile:Insert[-216.425049 91.054092 -93.283119]
	_PathFile:Insert[-248.828217 70.268761 -60.863991]
	_PathFile:Insert[-278.461731 46.897869 -27.843304]
	_PathFile:Insert[-300.660034 27.695969 -8.953033]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[-311.031647 14.667850 -2.022032]
	_PathFile:Insert[Custom|Wait|1]
	call NavigatePath
}
function ShadeweaversThicketZoneEntranceShadeweaversThicketLodaKaiIsle()
{
	_PathFile:Clear
	_PathFile:Insert[-530.327087 160.488647 -750.221619]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[-530.327087 210.653091 -750.221619]
	_PathFile:Insert[-496.062500 224.012604 -716.068970]
	_PathFile:Insert[-461.529266 236.379547 -681.648254]
	_PathFile:Insert[-426.057251 236.379547 -646.291321]
	_PathFile:Insert[-390.585175 236.379547 -610.934509]
	_PathFile:Insert[-353.400696 236.379547 -577.471008]
	_PathFile:Insert[-315.354919 236.379547 -544.610535]
	_PathFile:Insert[-277.666992 236.379547 -511.380951]
	_PathFile:Insert[-240.084076 236.379547 -478.245331]
	_PathFile:Insert[-202.397064 236.379547 -445.017670]
	_PathFile:Insert[-164.665329 236.379547 -411.750519]
	_PathFile:Insert[-127.022629 236.379547 -378.562317]
	_PathFile:Insert[-89.141228 236.379547 -345.163818]
	_PathFile:Insert[-51.259811 236.379547 -311.765320]
	_PathFile:Insert[-13.378311 236.379547 -278.366821]
	_PathFile:Insert[24.249792 236.379547 -245.191727]
	_PathFile:Insert[61.178482 236.379547 -211.096130]
	_PathFile:Insert[94.980942 226.044266 -175.297516]
	_PathFile:Insert[127.652878 208.947464 -141.435135]
	_PathFile:Insert[161.564987 192.123306 -108.461243]
	_PathFile:Insert[194.798615 175.233231 -74.746078]
	_PathFile:Insert[227.988968 158.349777 -41.014130]
	_PathFile:Insert[263.141785 155.671661 -5.277254]
	_PathFile:Insert[298.374481 155.671661 30.543013]
	_PathFile:Insert[333.752228 155.671661 66.214401]
	_PathFile:Insert[368.433746 149.213028 101.866028]
	_PathFile:Insert[401.304779 135.563889 137.020035]
	_PathFile:Insert[436.007355 121.973488 170.700516]
	_PathFile:Insert[472.936340 120.350365 204.447998]
	_PathFile:Insert[510.010834 120.350365 238.328842]
	_PathFile:Insert[546.525146 103.045258 268.193024]
	_PathFile:Insert[601.394226 44.704529 266.591064]
	_PathFile:Insert[620.763489 27.282532 287.452240]
	_PathFile:Insert[633.387695 17.084553 317.249481]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[632.874634 13.072926 316.680420]
	_PathFile:Insert[Custom|Wait|1]
	call NavigatePath
}
function EchoCavernsZoneEntranceEchoCavernsZelmieSortie()
{
	_PathFile:Clear
	_PathFile:Insert[31.124825 158.263321 -90.925606]
	_PathFile:Insert[Custom|Wait|1]
	_PathFile:Insert[31.124825 208.361938 -90.925606]
	_PathFile:Insert[-1.107052 239.532562 -78.611145]
	_PathFile:Insert[-46.626476 252.256027 -61.549988]
	_PathFile:Insert[-93.390923 259.057800 -44.756596]
	_PathFile:Insert[-113.490158 257.729095 -39.120945]
	_PathFile:Insert[-122.788521 260.333313 -58.822769]
	_PathFile:Insert[-132.357025 264.393921 -60.561466]
	_PathFile:Insert[-164.064835 282.697723 -47.961308]
	_PathFile:Insert[-184.171631 284.389404 -75.830444]
	_PathFile:Insert[-122.939934 280.241272 -125.721039]
	_PathFile:Insert[-208.068283 275.958069 -119.149620]
	_PathFile:Insert[-244.414719 282.122528 -151.605484]
	_PathFile:Insert[-206.450470 281.835052 -184.567764]
	_PathFile:Insert[-171.973846 267.895905 -218.255936]
	_PathFile:Insert[-143.941498 236.968826 -250.911011]
	_PathFile:Insert[-121.578659 202.086700 -279.392151]
	_PathFile:Insert[-95.779114 176.089706 -313.826721]
	_PathFile:Insert[-66.291924 153.095749 -347.358002]
	_PathFile:Insert[-31.146122 135.067963 -378.470520]
	_PathFile:Insert[10.760967 121.721725 -402.459045]
	_PathFile:Insert[53.251289 122.907921 -428.961975]
	_PathFile:Insert[98.325142 122.907921 -450.935577]
	_PathFile:Insert[148.511566 122.907921 -454.209991]
	_PathFile:Insert[198.743210 122.907921 -453.105865]
	_PathFile:Insert[248.006653 122.907921 -461.785095]
	_PathFile:Insert[298.027313 122.907921 -462.235107]
	_PathFile:Insert[348.192535 122.907921 -458.784698]
	_PathFile:Insert[398.397217 122.907921 -455.989136]
	_PathFile:Insert[448.501434 122.907921 -453.511078]
	_PathFile:Insert[497.633026 115.447037 -447.293976]
	_PathFile:Insert[533.055969 83.276955 -432.760529]
	_PathFile:Insert[569.610474 50.119179 -426.383148]
	_PathFile:Insert[Custom|RIMObj.FlyDown]
	_PathFile:Insert[609.422424 25.679279 -442.085327]
	_PathFile:Insert[Custom|Wait|1]
	call NavigatePath
}
function WilloftheWealdSavageWealdCommonPoint()
{
	_PathFile:Clear
	_PathFile:Insert[-415.062805 95.353996 -335.544525]
	_PathFile:Insert[-424.733704 97.925049 -316.905548]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[-424.733704 178.056351 -316.905548]
	call NavigatePath
}
function SavageWealdCommonPointSavageWealdChaoticCaverns()
{
	_PathFile:Clear
	_PathFile:Insert[-424.733704 178.056351 -316.905548]
	_PathFile:Insert[-474.786377 178.056351 -321.350342]
	_PathFile:Insert[-524.714355 178.056351 -325.784271]
	_PathFile:Insert[-574.663086 178.056351 -330.220001]
	_PathFile:Insert[-624.473206 178.056351 -334.643402]
	_PathFile:Insert[-674.303040 178.056351 -339.068390]
	_PathFile:Insert[-718.208801 159.139557 -354.081146]
	_PathFile:Insert[-760.013245 136.192154 -370.050293]
	_PathFile:Insert[-803.343201 113.994545 -382.401245]
	_PathFile:Insert[-848.686157 113.580528 -404.129242]
	_PathFile:Insert[-857.998840 109.528954 -418.773254]
	_PathFile:Insert[Custom|RIMObj.FlyDown|0]
	_PathFile:Insert[-891.849243 74.603668 -379.232208]
	_PathFile:Insert[Custom|Wait|1]
	call NavigatePath
}
function SavageWealdChaoticCavernsSavageWealdCommonPoint()
{
	_PathFile:Clear
	_PathFile:Insert[-857.998840 74.528954 -418.773254]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[Custom|FlyUp|5]
	_PathFile:Insert[-848.686157 113.580528 -404.129242]
	_PathFile:Insert[-803.343201 113.994545 -382.401245]
	_PathFile:Insert[-760.013245 136.192154 -370.050293]
	_PathFile:Insert[-718.208801 159.139557 -354.081146]
	_PathFile:Insert[-674.303040 178.056351 -339.068390]
	_PathFile:Insert[-624.473206 178.056351 -334.643402]
	_PathFile:Insert[-574.663086 178.056351 -330.220001]
	_PathFile:Insert[-524.714355 178.056351 -325.784271]
	_PathFile:Insert[-474.786377 178.056351 -321.350342]
	_PathFile:Insert[-424.733704 178.056351 -316.905548]
	call NavigatePath
}
function SavageWealdCommonPointSavageWealdFortGrim()
{
	_PathFile:Clear
	_PathFile:Insert[-424.733704 178.056351 -316.905548]
	_PathFile:Insert[-371.362427 174.596619 -313.218567]
	_PathFile:Insert[-322.410065 168.087936 -305.321899]
	_PathFile:Insert[-280.488892 142.493011 -294.759644]
	_PathFile:Insert[-238.230804 117.975853 -283.819550]
	_PathFile:Insert[-195.943726 93.359047 -273.040161]
	_PathFile:Insert[-153.621933 68.627686 -262.571014]
	_PathFile:Insert[-111.011963 44.169472 -252.249969]
	_PathFile:Insert[-84.251228 30.642805 -247.387405]
	_PathFile:Insert[Custom|RIMObj.FlyDown|0]
	_PathFile:Insert[-81.817772 20.752132 -258.149445]
	_PathFile:Insert[Custom|Wait|1]
	call NavigatePath
}
function SavageWealdFortGrimSavageWealdCommonPoint()
{
	_PathFile:Clear
	_PathFile:Insert[-84.251228 20.642805 -247.387405]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[Custom|FlyUp|5]
	_PathFile:Insert[-111.011963 44.169472 -252.249969]
	_PathFile:Insert[-153.621933 68.627686 -262.571014]
	_PathFile:Insert[-195.943726 93.359047 -273.040161]
	_PathFile:Insert[-238.230804 117.975853 -283.819550]
	_PathFile:Insert[-280.488892 142.493011 -294.759644]
	_PathFile:Insert[-322.410065 168.087936 -305.321899]
	_PathFile:Insert[-371.362427 174.596619 -313.218567]
	_PathFile:Insert[-424.733704 178.056351 -316.905548]
	call NavigatePath
}
function SpiritoftheVahShirCityofSharVahlBauble()
{
	call CityofSharVahlEntranceCityofSharVahlCommonPoint
	call CityofSharVahlCommonPointCityofSharVahlCommonPoint2
	call CityofSharVahlCommonPoint2CityofSharVahlBauble
}
function WillofEchoCavernsCityofFordelMidstBauble()
{
	call RIMObj.Move 36.298523 161.036072 -142.215561
	call ZoneDoor Exit
	call EchoCavernsZoneEntranceCityofFordelMidstZoneEntrance
	call CityofFordelMidstZoneEntranceCityofFordelMidstBauble
}
function CityofSharVahlEntrance2CityofSharVahlCommonPoint2()
{
	_PathFile:Clear
	_PathFile:Insert[-327.763550 85.146912 175.342087]
	_PathFile:Insert[-311.384155 82.610184 187.859863]
	_PathFile:Insert[-300.919556 76.825539 208.695419]
	_PathFile:Insert[-290.271942 71.488731 223.541260]
	_PathFile:Insert[-268.743835 69.841331 234.716049]
	_PathFile:Insert[-247.512390 70.765724 249.229996]
	_PathFile:Insert[-232.728394 69.963013 258.790405]
	_PathFile:Insert[-218.498581 70.047356 269.017365]
	call NavigatePath
}
function CityofSharVahlCommonPoint2CityofSharVahlEntrance2()
{
	_PathFile:Clear
	_PathFile:Insert[-218.498581 70.047356 269.017365]
	_PathFile:Insert[-232.728394 69.963013 258.790405]
	_PathFile:Insert[-247.512390 70.765724 249.229996]
	_PathFile:Insert[-268.743835 69.841331 234.716049]
	_PathFile:Insert[-290.271942 71.488731 223.541260]
	_PathFile:Insert[-300.919556 76.825539 208.695419]
	_PathFile:Insert[-311.384155 82.610184 187.859863]
	_PathFile:Insert[-327.763550 85.146912 175.342087]
	call NavigatePath
}
function CityofSharVahlEntranceCityofSharVahlCommonPoint()
{
	_PathFile:Clear
	_PathFile:Insert[-187.550003 41.994850 -407.000000]
	_PathFile:Insert[-183.492813 41.663296 -397.526764]
	_PathFile:Insert[-179.469620 41.663296 -388.203369]
	_PathFile:Insert[-175.162201 42.018311 -378.613190]
	_PathFile:Insert[-170.828461 39.565750 -369.406189]
	_PathFile:Insert[-166.575912 36.571030 -360.490601]
	_PathFile:Insert[-162.400391 33.057316 -351.736389]
	_PathFile:Insert[-158.053711 31.286343 -342.623474]
	_PathFile:Insert[-153.589127 31.286343 -333.214600]
	_PathFile:Insert[-149.995209 31.286343 -323.834900]
	_PathFile:Insert[-149.210602 31.286343 -313.460480]
	_PathFile:Insert[-149.452850 31.286343 -302.593018]
	_PathFile:Insert[-150.190735 31.286343 -291.846588]
	_PathFile:Insert[-151.295456 31.286343 -281.251312]
	_PathFile:Insert[-152.770096 31.286343 -271.024567]
	_PathFile:Insert[-154.996323 31.286343 -260.712616]
	_PathFile:Insert[-157.974854 31.286343 -250.816086]
	_PathFile:Insert[-161.164841 31.286343 -240.464767]
	_PathFile:Insert[-164.329590 31.286343 -230.835510]
	_PathFile:Insert[-167.542770 31.286343 -221.347931]
	_PathFile:Insert[-171.034210 31.286343 -211.494110]
	_PathFile:Insert[-174.551727 31.286343 -202.030518]
	_PathFile:Insert[-178.241516 31.286343 -192.291534]
	_PathFile:Insert[-181.804535 31.286343 -182.887100]
	_PathFile:Insert[-185.888641 31.286343 -172.107315]
	_PathFile:Insert[-189.444611 31.860718 -162.721466]
	_PathFile:Insert[-193.239990 31.862347 -152.703705]
	_PathFile:Insert[-196.945145 32.150356 -142.610504]
	_PathFile:Insert[-200.057373 32.438351 -132.964340]
	_PathFile:Insert[-203.168564 32.726345 -122.734413]
	_PathFile:Insert[-206.030823 32.709843 -112.762527]
	_PathFile:Insert[-208.920197 32.631809 -102.343758]
	_PathFile:Insert[-212.064529 32.658173 -91.005684]
	_PathFile:Insert[-214.871902 32.714615 -80.832321]
	_PathFile:Insert[-217.509460 33.760517 -70.860138]
	_PathFile:Insert[-219.844604 34.445980 -60.716496]
	_PathFile:Insert[-220.404846 35.538235 -50.770329]
	_PathFile:Insert[-211.525620 35.317623 -43.204041]
	_PathFile:Insert[-216.397385 34.806271 -30.353971]
	_PathFile:Insert[-216.307007 34.175179 -19.999495]
	_PathFile:Insert[-216.159485 33.164322 -10.003817]
	_PathFile:Insert[-215.411118 32.685249 0.561573]
	_PathFile:Insert[-214.190948 32.626263 11.243955]
	_PathFile:Insert[-211.895218 32.641701 22.306681]
	_PathFile:Insert[-209.112839 32.694649 32.918865]
	_PathFile:Insert[-206.326431 32.722046 43.139217]
	_PathFile:Insert[-203.581299 32.726345 53.288368]
	_PathFile:Insert[-200.808670 32.726345 63.635979]
	_PathFile:Insert[-198.041199 32.438351 73.964386]
	_PathFile:Insert[-195.309723 32.426014 84.158394]
	_PathFile:Insert[-192.209808 31.574352 95.591064]
	_PathFile:Insert[-189.406906 31.286343 105.745056]
	_PathFile:Insert[-186.623764 31.286343 115.780792]
	_PathFile:Insert[-183.877274 31.286343 125.764763]
	_PathFile:Insert[-181.178940 31.286343 135.700089]
	_PathFile:Insert[-178.447464 31.286343 145.894073]
	_PathFile:Insert[-175.626511 31.286343 156.537292]
	_PathFile:Insert[-172.905960 31.286343 166.960297]
	_PathFile:Insert[-170.491150 31.286343 176.988571]
	_PathFile:Insert[-168.059021 31.653652 187.523453]
	call NavigatePath
}
function CityofSharVahlCommonPoint2CityofSharVahlCommonPoint()
{
	_PathFile:Clear
	_PathFile:Insert[-218.498581 70.047356 269.017365]
	_PathFile:Insert[-209.454269 68.479408 265.639679]
	_PathFile:Insert[-202.616745 65.512688 258.497772]
	_PathFile:Insert[-196.109894 61.832634 251.755234]
	_PathFile:Insert[-189.564896 57.491634 244.741730]
	_PathFile:Insert[-183.509583 52.437405 238.044235]
	_PathFile:Insert[-176.696976 47.211323 232.076721]
	_PathFile:Insert[-169.770706 42.635132 225.905304]
	_PathFile:Insert[-164.467117 37.673660 217.250656]
	_PathFile:Insert[-163.145035 34.189014 207.641739]
	_PathFile:Insert[-165.615692 32.262459 197.545013]
	_PathFile:Insert[-168.059021 31.653652 187.523453]
	call NavigatePath
}
function CityofSharVahlCommonPointCityofSharVahlCommonPoint2()
{
	_PathFile:Clear
	_PathFile:Insert[-165.615692 32.262459 197.545013]
	_PathFile:Insert[-163.145035 34.189014 207.641739]
	_PathFile:Insert[-164.467117 37.673660 217.250656]
	_PathFile:Insert[-169.770706 42.635132 225.905304]
	_PathFile:Insert[-176.696976 47.211323 232.076721]
	_PathFile:Insert[-183.509583 52.437405 238.044235]
	_PathFile:Insert[-189.564896 57.491634 244.741730]
	_PathFile:Insert[-196.109894 61.832634 251.755234]
	_PathFile:Insert[-202.616745 65.512688 258.497772]
	_PathFile:Insert[-209.454269 68.479408 265.639679]
	_PathFile:Insert[-218.498581 70.047356 269.017365]
	call NavigatePath
}
function CityofSharVahlCommonPoint2CityofSharVahlBauble()
{
	_PathFile:Clear
	_PathFile:Insert[-214.119232 74.190125 284.684845]
	_PathFile:Insert[-213.382660 77.559181 294.630402]
	_PathFile:Insert[-212.671387 80.914665 304.374329]
	_PathFile:Insert[-210.190201 82.429886 314.071045]
	_PathFile:Insert[-203.223389 84.371117 321.895142]
	_PathFile:Insert[-196.271652 88.027031 329.044281]
	_PathFile:Insert[-188.622116 88.853607 336.094360]
	_PathFile:Insert[-178.759567 88.852379 338.694550]
	_PathFile:Insert[-168.790787 88.851967 340.859009]
	_PathFile:Insert[-158.237915 89.467575 343.116638]
	_PathFile:Insert[-148.803299 93.266052 344.961243]
	_PathFile:Insert[-138.612640 94.048523 346.453461]
	_PathFile:Insert[-128.786057 94.048523 344.217590]
	_PathFile:Insert[-118.934288 94.048225 341.806885]
	_PathFile:Insert[-108.471031 94.048050 339.246521]
	_PathFile:Insert[-97.943214 94.047882 336.309174]
	_PathFile:Insert[-87.897888 94.047546 333.343384]
	_PathFile:Insert[-78.210625 94.046928 330.163513]
	_PathFile:Insert[-68.342133 94.045639 327.324921]
	_PathFile:Insert[-57.603085 94.044579 325.382507]
	_PathFile:Insert[-48.450119 94.478394 329.859222]
	_PathFile:Insert[-48.277153 95.300529 343.743866]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[Custom|ZoneDoor|zone_to_palace_interior]
	_PathFile:Insert[-48.421341 -189.808365 429.402802]
	_PathFile:Insert[-48.392567 -189.808517 430.924988]
	_PathFile:Insert[-56.102077 -190.082336 437.320221]
	_PathFile:Insert[-64.569954 -190.082336 442.730438]
	_PathFile:Insert[-73.541420 -189.875671 447.190979]
	_PathFile:Insert[-83.713211 -189.845520 449.524719]
	_PathFile:Insert[-93.967018 -189.883011 450.440399]
	_PathFile:Insert[-104.646622 -189.843842 451.280884]
	_PathFile:Insert[-115.008118 -189.845520 452.615387]
	_PathFile:Insert[-125.143433 -189.909760 455.658112]
	_PathFile:Insert[-131.111404 -189.900345 464.324219]
	_PathFile:Insert[-131.382965 -189.915466 474.736450]
	_PathFile:Insert[-130.891449 -189.915466 485.474518]
	_PathFile:Insert[-130.677109 -189.849136 495.668152]
	_PathFile:Insert[-130.490524 -189.915466 506.359283]
	_PathFile:Insert[-129.725449 -189.829590 516.703491]
	_PathFile:Insert[-129.769577 -189.879501 527.594238]
	_PathFile:Insert[-130.079132 -189.879639 537.725769]
	_PathFile:Insert[-130.388077 -189.895935 547.837524]
	_PathFile:Insert[-130.820496 -189.915466 558.799255]
	_PathFile:Insert[-131.491791 -189.915466 568.921997]
	_PathFile:Insert[-137.394714 -189.951233 577.129150]
	_PathFile:Insert[-147.360229 -191.645081 576.781128]
	_PathFile:Insert[-157.786469 -194.516815 576.456970]
	_PathFile:Insert[-167.681015 -197.242203 576.380371]
	_PathFile:Insert[-178.284851 -197.979996 576.800171]
	_PathFile:Insert[-184.680954 -198.194962 584.776794]
	_PathFile:Insert[-187.121262 -198.037689 594.536743]
	_PathFile:Insert[Custom|Wait|20]
	call NavigatePath
}
function EchoCavernsZoneEntranceCityofFordelMidstZoneEntrance()
{
	_PathFile:Clear
	_PathFile:Insert[364.429993 -36.132404 756.140015]
	_PathFile:Insert[353.189423 -35.848942 767.678833]
	_PathFile:Insert[338.920197 -36.122105 782.326599]
	_PathFile:Insert[326.272034 -36.151951 795.310364]
	_PathFile:Insert[320.545074 -36.137768 791.936890]
	_PathFile:Insert[308.362061 -34.980869 784.760559]
	_PathFile:Insert[302.679657 -33.632568 781.413391]
	_PathFile:Insert[294.635315 -29.585173 779.767395]
	_PathFile:Insert[290.685944 -27.929811 778.939758]
	_PathFile:Insert[277.814148 -27.531759 778.771423]
	_PathFile:Insert[262.963562 -27.632025 778.576965]
	_PathFile:Insert[263.915649 -27.630001 778.271362]
	call NavigatePath
}
function CityofFordelMidstZoneEntranceCityofFordelMidstBauble()
{
	_PathFile:Clear
	_PathFile:Insert[263.915649 -27.630001 778.271362]
	_PathFile:Insert[253.065353 -27.694517 778.450562]
	_PathFile:Insert[243.046722 -27.775564 778.538086]
	_PathFile:Insert[233.179260 -29.160624 777.499634]
	_PathFile:Insert[224.261993 -33.723534 775.276550]
	_PathFile:Insert[214.922211 -35.730816 770.844727]
	_PathFile:Insert[206.003799 -36.151924 765.020752]
	_PathFile:Insert[196.634293 -36.122105 770.480225]
	_PathFile:Insert[188.819778 -36.122105 778.063904]
	_PathFile:Insert[181.669479 -36.021763 785.716614]
	_PathFile:Insert[174.297867 -35.848759 793.761292]
	_PathFile:Insert[165.594803 -36.132366 800.046082]
	_PathFile:Insert[154.871170 -36.132328 802.608643]
	_PathFile:Insert[144.865265 -36.190830 804.802979]
	_PathFile:Insert[134.468369 -36.190830 807.299011]
	_PathFile:Insert[130.209503 -35.981697 808.301819]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[Custom|Door|10|door_from_nexus_to_shadow_haven]
	_PathFile:Insert[-670.549988 -1.520000 103.320000]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[-670.549988 -1.520000 103.320000]
	_PathFile:Insert[-660.549377 -1.521521 102.794144]
	_PathFile:Insert[-650.116455 -1.521512 102.245552]
	_PathFile:Insert[-648.608337 -1.521534 102.166252]
	_PathFile:Insert[-648.581665 -1.521533 91.690186]
	_PathFile:Insert[-648.125183 -1.521538 81.067154]
	_PathFile:Insert[-648.112549 -1.521538 70.952896]
	_PathFile:Insert[-648.351624 -1.521534 60.083897]
	_PathFile:Insert[-648.571899 -1.521531 50.069321]
	_PathFile:Insert[-648.759705 -1.521528 39.716297]
	_PathFile:Insert[-648.609436 -1.521530 29.681572]
	_PathFile:Insert[-647.829529 -1.521542 18.499243]
	_PathFile:Insert[-645.468689 -1.521557 7.630901]
	_PathFile:Insert[-643.157593 -1.521535 -2.121373]
	_PathFile:Insert[-640.217346 -1.521532 -12.215434]
	_PathFile:Insert[-637.260254 -1.521574 -22.367033]
	_PathFile:Insert[-634.221069 -1.521602 -32.780102]
	_PathFile:Insert[-631.179565 -1.466406 -42.888439]
	_PathFile:Insert[-628.328064 -1.466406 -52.677486]
	_PathFile:Insert[-625.348633 -1.521645 -62.905422]
	_PathFile:Insert[-622.194824 -1.521645 -72.676895]
	_PathFile:Insert[-615.832947 -1.521645 -81.163658]
	_PathFile:Insert[-607.151001 -1.521645 -87.604462]
	_PathFile:Insert[-598.748779 -1.521645 -93.202736]
	_PathFile:Insert[-589.882141 -1.521645 -98.963020]
	_PathFile:Insert[-580.948425 -1.521645 -105.010269]
	_PathFile:Insert[-575.090576 -1.521645 -113.386826]
	_PathFile:Insert[-572.978271 -1.521645 -124.084221]
	_PathFile:Insert[-572.458374 -1.521645 -134.623260]
	_PathFile:Insert[-572.279114 -1.521645 -144.996475]
	_PathFile:Insert[-572.100525 -1.108428 -155.329941]
	_PathFile:Insert[-571.925720 -0.063744 -165.444794]
	_PathFile:Insert[-571.742981 1.843848 -176.016724]
	_PathFile:Insert[-571.564087 1.843080 -186.370041]
	_PathFile:Insert[-571.349365 1.841742 -197.139999]
	_PathFile:Insert[-570.971252 1.835369 -207.845947]
	_PathFile:Insert[-570.374390 1.830348 -218.322845]
	_PathFile:Insert[-569.859253 1.839864 -228.525070]
	_PathFile:Insert[-569.236328 2.759103 -239.396301]
	_PathFile:Insert[-568.137512 2.759531 -249.592590]
	_PathFile:Insert[-565.268066 2.759855 -259.244324]
	_PathFile:Insert[-555.038879 2.759226 -261.531342]
	_PathFile:Insert[-548.607117 2.756661 -261.368317]
	_PathFile:Insert[-537.340637 2.753154 -261.468597]
	_PathFile:Insert[-526.979736 2.753154 -261.560822]
	_PathFile:Insert[-519.207336 2.753154 -261.630035]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[Custom|Door|10|door_from_shadow_haven_to_midst]
	_PathFile:Insert[447.570007 -23.719999 -580.580017]
	_PathFile:Insert[Custom|Wait|20]
	_PathFile:Insert[458.164154 -23.719316 -580.580017]
	_PathFile:Insert[469.037231 -23.709459 -580.580017]
	_PathFile:Insert[479.232697 -23.697718 -580.580017]
	_PathFile:Insert[489.905609 -23.685423 -580.588196]
	_PathFile:Insert[500.002075 -23.452467 -580.632141]
	_PathFile:Insert[510.774200 -23.446840 -580.679138]
	_PathFile:Insert[521.407227 -22.096102 -580.725525]
	_PathFile:Insert[531.722229 -22.081114 -580.770508]
	_PathFile:Insert[543.229553 -22.081114 -580.703674]
	_PathFile:Insert[553.367981 -22.081114 -579.580139]
	_PathFile:Insert[557.487366 -22.522936 -570.243713]
	_PathFile:Insert[560.708801 -23.429367 -560.418823]
	_PathFile:Insert[564.018982 -23.477221 -550.716858]
	_PathFile:Insert[570.415405 -23.002123 -542.674683]
	_PathFile:Insert[577.247986 -22.099480 -535.050171]
	_PathFile:Insert[578.441467 -22.099638 -533.158569]
	_PathFile:Insert[578.467529 -21.295500 -522.232483]
	_PathFile:Insert[578.705933 -17.518921 -512.713928]
	_PathFile:Insert[578.705933 -17.518921 -512.713928]
	_PathFile:Insert[588.421814 -14.251518 -512.387329]
	_PathFile:Insert[593.062744 -13.750305 -512.447998]
	_PathFile:Insert[593.226807 -9.627720 -521.598389]
	_PathFile:Insert[593.414429 -8.371559 -531.970886]
	_PathFile:Insert[593.453857 -8.646982 -534.227173]
	_PathFile:Insert[593.500610 -8.613430 -536.904724]
	_PathFile:Insert[603.657776 -8.613430 -537.939697]
	_PathFile:Insert[612.936340 -8.601758 -541.985046]
	_PathFile:Insert[617.670471 -8.652793 -550.888123]
	_PathFile:Insert[620.482788 -8.654295 -560.667847]
	_PathFile:Insert[626.539795 -8.654413 -568.780518]
	_PathFile:Insert[636.665222 -8.654509 -568.878479]
	_PathFile:Insert[641.912964 -8.654533 -567.809387]
	_PathFile:Insert[640.975708 -8.395555 -547.572205]
	_PathFile:Insert[640.861084 -8.646975 -522.815552]
	_PathFile:Insert[635.749939 -8.578337 -520.537476]
	_PathFile:Insert[Custom|Wait|20]
	call NavigatePath
}
function HailActor(... args)
{

	;move to HailActor location
	;stop follow
	;string _Actor, bool _LoopUntilNoHighlightOnMouseHover=0, bool _LoopUntilDNE=0, int _GiveUpCNT=50
	;echo ClickActor(string _Actor=${_Actor}, int _LoopUntilNoHighlightOnMouseHover=0=${_LoopUntilNoHighlightOnMouseHover}, int _GiveUpCNT=50=${_GiveUpCNT})
	;move to ClickActor location
	;stop follow
	
	variable string _Actor
	variable int _NumberOfResponses=1
	variable int _ResponseNumber=1
	variable int _CameraTime=15
	variable bool _Hail=TRUE
	variable int _acnt=0
	variable bool _Follow=FALSE
	variable bool _ExactName=FALSE
	variable bool _RelayToGroup=FALSE
	variable string _Relay

	for(_acnt:Set[1];${_acnt}<=${args.Used};_acnt:Inc)
	{
		;backwards compatibility
		if ${_acnt}==1 && ${args[1].Left[1].NotEqual[-]}
		{
			_Actor:Set["${args[1]}"]
			continue
		}
		if ${args[2].Left[1].NotEqual[-]} && ${_acnt}==2
		{
			_NumberOfResponses:Set[${Int[${args[2]}]}]
			continue
		}
		if ${args[3].Left[1].NotEqual[-]} && ${_acnt}==3
		{
			_ResponseNumber:Set[${Int[${args[3]}]}]
			continue
		}
		if ${args[4].Left[1].NotEqual[-]} && ${_acnt}==4
		{
			_Hail:Set[${args[4]}]
			continue
		}
		if ${args[5].Left[1].NotEqual[-]} && ${_acnt}==5
		{
			_Follow:Set[${args[5]}]
			continue
		}
		if ${args[6].Left[1].NotEqual[-]} && ${_acnt}==6
		{
			_ExactName:Set[${args[6]}]
			continue
		}
		if ${args[7].Left[1].NotEqual[-]} && ${_acnt}==7
		{
			_CameraTime:Set[${args[7]}]
			continue
		}
		;echo args ${_acnt} : ${args[${_acnt}]}
		switch ${args[${_acnt}]}
		{
			case -Actor
			{
				_Actor:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -NumberofResponses
			{
				_NumberOfResponses:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -ResponseNumber
			{
				_ResponseNumber:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -NoHail
			{
				_Hail:Set[FALSE]
				break
			}
			case -NoFollow
			{
				_Follow:Set[FALSE]
				break
			}
			case -ExactName
			{
				_ExactName:Set[TRUE]
				break
			}
			case -CameraTime
			{
				_CameraTime:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -NoRelayToGroup
			{
				_RelayToGroup:Set[FALSE]
				break
			}
		}
	}
	if ${_RelayToGroup}
		_Relay:Set["${RI_Var_String_RelayGroup}"]
	else
		_Relay:Set["${Session}"]

	if ${_Actor.Left[6].Upper.Equal[GUILD-]}
		_Actor:Set["guild,${_Actor.Right[-6]}"]
	if ${_Actor.Left[6].Upper.Equal[QUERY-]}
		_Actor:Set["Query,${_Actor.Right[-6].Replace["`","\""]}"]

	;echo HailActor(string _Actor=${_Actor}, int _NumberOfResponses=1=${_NumberOfResponses}, int _ResponseNumber=1=${_ResponseNumber}, bool _Hail=TRUE=${_Hail})
	;echo after move
	if ${_Hail}
	{
		wait 20
	}
	if ${_Follow}
		call RIMObj.stopfollow
	if ${Me.FlyingUsingMount}
		call FlyDown
	;make sure _Actor exists so we do not go through the motions for nothign
	;echo \${Actor[${_Actor}](exists)}  //  ${Actor[${_Actor}](exists)}
	if ${Actor[${_Actor}](exists)}
	{
		variable int _ID
		if ${_ExactName}
			_ID:Set[${Actor[Query, Name=="${_Actor}"].ID}]
		else
			_ID:Set[${Actor[${_Actor}].ID}]
		;echo ${_ID}
		;wait until we are out of combat
		if ${StopForCombat}
			call RIMObj.CheckCombat
		
		if ${_Hail}
		{
			wait 10
			;pause bots
			
			relay ${_Relay} -noredirect RI_CMD_PauseCombatBots 1
			;wait 5
			;change camera
			relay ${_Relay} -noredirect Press -hold ${RI_Var_String_LookDownKey}
			wait ${_CameraTime}
			;change camera
			relay ${_Relay} -noredirect Press -release ${RI_Var_String_LookDownKey}
			relay ${_Relay} -noredirect Press -hold ${RI_Var_String_LookUpKey}
			wait 3
			relay ${_Relay} -noredirect Press -release ${RI_Var_String_LookUpKey}
			
			relay ${_Relay} -noredirect Actor[${_ID}]:DoFace
			relay ${_Relay} -noredirect Actor[${_ID}]:DoFace
			wait 5
			;scroll the mouse wheel
			relay ${_Relay} -noredirect MouseWheel -10000
			relay ${_Relay} -noredirect Actor[${_ID}]:DoTarget
			wait 2
			relay ${_Relay} -noredirect Actor[${_ID}]:DoTarget
			wait 2
			relay ${_Relay} -noredirect Actor[${_ID}]:DoTarget
			wait 5
			relay ${_Relay} -noredirect eq2execute hail
			wait 2
			relay ${_Relay} -noredirect eq2execute hail
			wait 2
		}
		variable int count
		variable string _tempbtntxt
		variable int NoReplyExistsCount=-1
		;echo before for
		for(count:Set[1];${count}<=${_NumberOfResponses};count:Inc)
		{
			;echo for count: ${count}
			if !${EQ2UIPage[ProxyActor,Conversation].IsVisible}
				NoReplyExistsCount:Inc
			else
				NoReplyExistsCount:Set[0]
			
			if ${NoReplyExistsCount}>2
			{
				waitframe
				continue	
			}
			
			_tempbtntxt:Set["${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[${_ResponseNumber}].GetProperty[LocalText]}"]
			if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[1](exists)}
				relay ${_Relay} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[${_ResponseNumber}]:LeftClick
			wait 5
			wait 50 ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[${_ResponseNumber}].GetProperty[LocalText].NotEqual["${_tempbtntxt}"]}
			;|| !${EQ2UIPage[ProxyActor,Conversation].IsVisible}
		}
		;unpause bots
		relay ${_Relay} -noredirect RI_CMD_PauseCombatBots 0
	}
	;echo after for
	if ${StopForCombat}
		call RIMObj.CheckCombat
	;follow
	if ${_Follow}
	{
		;echo follow
		call RIMObj.follow
	}
	;echo end of function
}
function TravelMap(string _Zone)
{
	;echo Travel Map
	call RIMObj.TravelMap "${_Zone}"
	;echo Travel Map End
}
function ClickActor(string _ActorName)
{
	call RIMObj.CheckCombat
	wait 10
	;pause bots
	RI_CMD_PauseCombatBots 1
	wait 5
	
	wait 5
	Actor[${_ActorName}]:DoubleClick
	wait 5
	Actor[${_ActorName}]:DoubleClick
	wait 5
	Actor[${_ActorName}]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}

	;unpause bots
	RI_CMD_PauseCombatBots 0
}
function WaitWhileMoving(int _Wait=600)
{
	;echo WaitWhileMoving
	wait ${_Wait} ${Me.IsMoving}
	wait ${_Wait} !${Me.IsMoving}
	;echo WaitWhileMoving End
}
function WaitForZoning(int _Wait=600)
{
	;echo WaitForZoning
	wait ${_Wait} ${EQ2.Zoning}==1
	wait ${_Wait} ${EQ2.Zoning}==0
	;echo WaitForZoningEnd
}
function FlyUp(float _HoldTime=1, bool HoldTimeIsYLoc=FALSE)
{
	if !${Me.FlyingUsingMount}
	{
		press -hold ${RI_Var_String_FlyUpKey}
		if ${HoldTimeIsYLoc}
			wait 1200 ${Math.Distance[${Me.Y},${_HoldTime}]}<5
		else
			wait ${_HoldTime}
		press -release ${RI_Var_String_FlyUpKey}
	}
}

function Door(int distance=10, string _ActorName=NONE, bool _Interactable=FALSE)
{
	wait 10
	;if ${RI_Var_Bool_Debug}
		;echo ISXRI: ${Time} Opening any doors within ${distance}

	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 1	

	if ${_ActorName.Equal[NONE]}
	{
		variable index:actor Actors
		variable iterator ActorIterator
		
		EQ2:QueryActors[Actors, Type !="NPC" && Type !="NamedNPC" && Type !="Pet" && Type !="PC" && Type !="Mercenary" && Type !="Me" && Name !="${Me.Name}" && Distance <= ${distance}]
		Actors:GetIterator[ActorIterator]
	
		if ${ActorIterator:First(exists)}
		{
			do
			{
				relay ${RI_Var_String_RelayGroup} Actor[${ActorIterator.Value}]:DoubleClick
				relay ${RI_Var_String_RelayGroup} Actor[id,${ActorIterator.Value.ID}]:DoubleClick
				waitframe
				relay ${RI_Var_String_RelayGroup} Actor[${ActorIterator.Value}]:DoubleClick
				relay ${RI_Var_String_RelayGroup} Actor[id,${ActorIterator.Value.ID}]:DoubleClick
				waitframe
				relay ${RI_Var_String_RelayGroup} Actor[${ActorIterator.Value}]:DoubleClick
				relay ${RI_Var_String_RelayGroup} Actor[id,${ActorIterator.Value.ID}]:DoubleClick
			}
			while ${ActorIterator:Next(exists)}
		}
	}
	else
	{
		variable int _ActorID
		if ${_Interactable}
			_ActorID:Set[${Actor[Query, Name=-"${_ActorName}" && Interactable=TRUE].ID}]
		else
			_ActorID:Set[${Actor[Query, Name=-"${_ActorName}"].ID}]
		relay ${RI_Var_String_RelayGroup} Actor[${_ActorName}]:DoubleClick
		relay ${RI_Var_String_RelayGroup} Actor[id,${_ActorID}]:DoubleClick
		waitframe
		relay ${RI_Var_String_RelayGroup} Actor[${_ActorName}]:DoubleClick
		relay ${RI_Var_String_RelayGroup} Actor[id,${_ActorID}]:DoubleClick
		waitframe
		relay ${RI_Var_String_RelayGroup} Actor[${_ActorName}]:DoubleClick
		relay ${RI_Var_String_RelayGroup} Actor[id,${_ActorID}]:DoubleClick
	}
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 0
}
function Wait(int _WaitTime=0)
{
	wait ${_WaitTime}
}
function NavigatePath()
{
	variable int _i
	;echo ${_PathFile.Get[1]}
	;echo ${_PathFile.Get[2]}
	for(_i:Set[1];${_i}<=${_PathFile.Used};_i:Inc)
	{
		if ${_PathFile.Get[${_i}].Left[6].Equal[Custom]}
		{
			if ${_PathFile.Get[${_i}].Count[|]}>2
				call ${_PathFile.Get[${_i}].Token[2,|]} "${_PathFile.Get[${_i}].Token[3,|]}" "${_PathFile.Get[${_i}].Token[4,|]}"
			elseif ${_PathFile.Get[${_i}].Count[|]}>1
				call ${_PathFile.Get[${_i}].Token[2,|]} "${_PathFile.Get[${_i}].Token[3,|]}"
			else
				call ${_PathFile.Get[${_i}].Token[2,|]}
		}
		else
		{
			if ${_PathFile.Get[${Math.Calc[${_i}+1]}].Left[6].Equal[Custom]}
			{
				;echo call RIMObj.Move ${_PathFile.Get[${_i}]}
				call RIMObj.Move ${_PathFile.Get[${_i}]}
			}
			else
			{
				;echo call RIMObj.Move ${_PathFile.Get[${_i}]} 2 0 0 0 1 1 1 1
				call RIMObj.Move ${_PathFile.Get[${_i}]} 2 0 0 0 1 1 1 1
			}
		}
	}
}
function TheBlindingZoneEntranceWracklandsEntrance()
{
	call RIMObj.Move 605.302979 455.866028 -582.017822 2 0 0 0 1 1 1 1
	call RIMObj.Move 555.439514 455.866028 -588.152954 2 0 0 0 1 1 1 1
	call RIMObj.Move 505.592194 455.866028 -594.286560 2 0 0 0 1 1 1 1
	call RIMObj.Move 455.723999 455.866028 -600.422607 2 0 0 0 1 1 1 1
	call RIMObj.Move 407.480927 455.866028 -613.920471 2 0 0 0 1 1 1 1
	call RIMObj.Move 359.981140 455.866028 -630.240662 2 0 0 0 1 1 1 1
	call RIMObj.Move 312.192169 455.866028 -645.736511 2 0 0 0 1 1 1 1
	call RIMObj.Move 264.187805 455.866028 -660.570740 2 0 0 0 1 1 1 1
	call RIMObj.Move 216.164764 455.866028 -675.411194 2 0 0 0 1 1 1 1
	call RIMObj.Move 168.388885 455.866028 -690.174744 2 0 0 0 1 1 1 1
	call RIMObj.Move 120.385078 455.866028 -705.009155 2 0 0 0 1 1 1 1
	call RIMObj.Move 124.624466 452.312408 -703.576965 2 0 0 0 1 1 1 1
	call RIMObj.Move 81.712311 428.537476 -714.110413 2 0 0 0 1 1 1 1
	call RIMObj.Move 34.819313 414.589508 -725.619995 2 0 0 0 1 1 1 1
	call RIMObj.Move -8.436390 391.649689 -736.236084 2 0 0 0 1 1 1 1
	call RIMObj.Move -55.348782 377.701508 -747.750366 2 0 0 0 1 1 1 1
	call RIMObj.Move -102.747032 365.776764 -759.384155 2 0 0 0 1 1 1 1
	call RIMObj.Move -149.355545 351.168396 -770.823669 2 0 0 0 1 1 1 1
	call RIMObj.Move -188.121323 320.810425 -780.337097 2 0 0 0 1 1 1 1
	call RIMObj.Move -222.625366 285.282379 -788.804138 2 0 0 0 1 1 1 1
	call RIMObj.Move -257.115692 249.768387 -797.267822 2 0 0 0 1 1 1 1
	call RIMObj.Move -279.764740 236.542099 -840.104065 2 0 0 0 1 1 1 1
	call RIMObj.Move -283.053741 229.363953 -860.226929 2 0 0 0 1 1 1 1
	call RIMObj.FlyDown
	call RIMObj.Move -283.096069 218.103500 -860.525818
	call ZoneTO -284.218506 -868.457214

}
function WracklandsEntranceWracklands()
{
	call RIMObj.Move 568.666504 120.691681 763.049622 2 0 0 0 1 1 1 1
	call RIMObj.Move 611.847778 120.691681 737.411926 2 0 0 0 1 1 1 1
	call RIMObj.Move 655.123779 120.691681 711.846313 2 0 0 0 1 1 1 1
	call RIMObj.Move 694.713379 104.820969 685.377075 2 0 0 0 1 1 1 1
	call RIMObj.Move 727.748413 83.113815 677.870972
	call RIMObj.FlyDown
	call RIMObj.Move 726.713806 77.151840 668.309570
}
function WilloftheWracklandsToWracklands()
{
	call RIMObj.Move 525.834717 37.340607 127.877113 2 0 0 0 1 1 1 1
	call RIMObj.Move 525.834717 87.644356 127.877113 2 0 0 0 1 1 1 1
	call RIMObj.Move 543.097473 116.578781 164.866699 2 0 0 0 1 1 1 1
	call RIMObj.Move 564.286682 116.578781 210.270233 2 0 0 0 1 1 1 1
	call RIMObj.Move 582.616638 116.578781 256.889801 2 0 0 0 1 1 1 1
	call RIMObj.Move 597.516724 116.578781 304.832489 2 0 0 0 1 1 1 1
	call RIMObj.Move 612.382385 116.578781 352.660095 2 0 0 0 1 1 1 1
	call RIMObj.Move 627.229309 116.578781 400.431732 2 0 0 0 1 1 1 1
	call RIMObj.Move 642.134827 116.578781 448.393616 2 0 0 0 1 1 1 1
	call RIMObj.Move 660.214722 116.578781 495.174133 2 0 0 0 1 1 1 1
	call RIMObj.Move 678.175293 116.578781 542.140930 2 0 0 0 1 1 1 1
	call RIMObj.Move 696.079468 116.578781 588.958740 2 0 0 0 1 1 1 1
	call RIMObj.Move 710.822937 102.957024 634.923462 2 0 0 0 1 1 1 1
	call RIMObj.Move 712.436218 90.560585 664.596985
	call RIMObj.FlyDown
	call RIMObj.Move 722.781189 77.151840 664.457886
}
function WilloftheCoastToAurelianCoast()
{
	call RIMObj.Move -88.336327 95.554268 217.260971 2 0 0 0 1 1 1 1
	call RIMObj.Move 23.183502 99.545540 181.425552 2 0 0 0 1 1 1 1
	call RIMObj.Move 97.923958 104.492455 157.408554 2 0 0 0 1 1 1 1
	call RIMObj.Move 152.982285 130.261215 125.503883 2 0 0 0 1 1 1 1
	call RIMObj.Move 238.407227 129.175766 49.113701 2 0 0 0 1 1 1 1
	call RIMObj.Move 298.495422 129.175766 -5.484939 2 0 0 0 1 1 1 1
	call RIMObj.Move 351.464233 148.175980 -53.614754 2 0 0 0 1 1 1 1
	call RIMObj.Move 342.320221 148.186462 -127.683662 2 0 0 0 1 1 1 1
	call RIMObj.Move 322.955475 148.186462 -204.256775 2 0 0 0 1 1 1 1
	call RIMObj.Move 274.576050 148.541229 -266.962311 2 0 0 0 1 1 1 1
	call RIMObj.Move 227.319550 148.541229 -322.917053 2 0 0 0 1 1 1 1
	call RIMObj.Move 189.335068 148.541229 -367.893463 2 0 0 0 1 1 1 1
	call RIMObj.Move 161.486145 130.201385 -422.714386 2 0 0 0 1 1 1 1
	call RIMObj.Move 147.588562 98.298042 -473.792023
	call RIMObj.FlyDown
	call RIMObj.Move 120.431206 85.212440 -528.233398 2 0 0 0 1 1 1 1
	call RIMObj.Move 124.675194 81.743469 -549.212830 2 0 0 0 1 1 1 1
	call RIMObj.Move 97.506111 76.690018 -575.213135 2 0 0 0 1 1 1 1
	call RIMObj.Move 99.035454 70.420067 -604.811768 2 0 0 0 1 1 1 1
	call RIMObj.Move 113.527733 66.510788 -622.734680
}
function WillofSeruToSanctusSeruCity()
{
	;below is the path from using the Will of Seru to the instance spot
	call RIMObj.Move 7.583822 180.673737 186.406372 2 0 0 0 1 1 1 1
	Actor[door priest quarter]:DoubleClick
	wait 2
	Actor[door priest quarter]:DoubleClick
	wait 2
	Actor[door priest quarter]:DoubleClick
	wait 2
	call RIMObj.Move 7.395301 179.858307 204.182999 2 0 0 0 1 1 1 1
	call RIMObj.Move -44.583488 179.785202 215.647934 2 0 0 0 1 1 1 1
	call RIMObj.Move -97.825813 175.767746 183.810455 2 0 0 0 1 1 1 1
	call RIMObj.Move -114.170265 175.680008 161.893539 2 0 0 0 1 1 1 1
	call RIMObj.Move -179.659607 179.771317 135.396118 2 0 0 0 1 1 1 1
	call RIMObj.Move -199.586517 179.903748 65.752113 2 0 0 0 1 1 1 1
	call RIMObj.Move -221.159775 179.768036 25.405567 2 0 0 0 1 1 1 1
	call RIMObj.Move -239.133438 179.756027 -1.253709 2 0 0 0 1 0 1 1
}
function GuildHallWracklands()
{
	call GuildHallTheBlinding
	call TheBlindingZoneEntranceWracklandsEntrance
	if !${Others}
		call WracklandsEntranceWracklands
}
function GuildHallSanctusSeruCity()
{
	call GuildHallTheBlinding
	call TheBlindingZoneEntranceTheBlinding2ndDrone
	call TheBlinding2ndDroneTheBlindingSeruAscent
	call TheBlindingSeruAscentSanctusSeruCityEntrance
	if !${Others}
		call SanctusSeruCityEntranceSanctusSeruCity
}
function GuildHallAurelianCoast()
{
	call GuildHallTheBlinding
	call TheBlindingZoneEntranceTheBlinding2ndDrone
	call TheBlinding2ndDroneTheBlindingSeruAscent
	call TheBlindingSeruAscentAurelianCoastEntrance
	if !${Others}
		call AurelianCoastEntranceAurelianCoast
}
function TheBlindingSeruAscentAurelianCoastEntrance()
{
	call RIMObj.Move 675.924377 40.866390 597.894592 2 0 0 0 1 1 1 1
	call RIMObj.Move 766.428162 35.288147 632.565186
	call ZoneTO 777.793335 626.449219
}
function SanctusSeruCityAurelianCoast()
{
	call SanctusSeruCitySanctusSeruCityEntrance
	call SanctusSeruCityEntranceAurelianCoastEntrance
	if !${Others}
		call AurelianCoastEntranceAurelianCoast
}
function AurelianCoastSanctusSeruCity()
{
	call AurelianCoastAurelianCoastEntrance
	call AurelianCoastEntranceSancrusSeruCityEntrance
	if !${Others}
		call SanctusSeruCityEntranceSanctusSeruCity
}
function AurelianCoastAurelianCoastEntrance()
{
	call RIMObj.Move 113.527733 66.510788 -622.734680 2 0 0 0 1 1 1 1
	call RIMObj.Move 93.623772 72.564613 -594.214966 2 0 0 0 1 1 1 1
	call RIMObj.Move 124.006676 84.969048 -537.790039 2 0 0 0 1 1 1 1
	call RIMObj.Move 121.377472 85.108917 -522.920349 2 0 0 0 1 1 1 1
	call RIMObj.Move 147.423431 84.373482 -482.249329 2 0 0 0 1 1 1 1
	call RIMObj.Move 151.453857 110.809380 -454.130249 2 0 0 0 1 1 1 1
	call RIMObj.Move 165.971420 156.971466 -396.901886 2 0 0 0 1 1 1 1
	call RIMObj.Move 218.984192 165.090775 -276.445953 2 0 0 0 1 1 1 1
	call RIMObj.Move 272.906860 176.708344 -234.567139 2 0 0 0 1 1 1 1
	call RIMObj.Move 346.316650 176.709625 -245.695465 2 0 0 0 1 1 1 1
	call RIMObj.Move 439.036987 176.709625 -280.044098 2 0 0 0 1 1 1 1
	call RIMObj.Move 494.501343 176.709625 -300.591125 2 0 0 0 1 1 1 1
	call RIMObj.Move 568.473999 176.659012 -345.703522 2 0 0 0 1 1 1 1
	call RIMObj.Move 652.481995 172.956558 -385.621460 2 0 0 0 1 1 1 1
	call RIMObj.Move 608.215515 172.508743 -444.370361 2 0 0 0 1 1 1 1
	call RIMObj.Move 602.422668 159.225983 -483.307281 2 0 0 0 1 1 1 1
	call RIMObj.Move 575.660767 157.386658 -536.023193
	call RIMObj.FlyDown
}
function AurelianCoastEntranceSancrusSeruCityEntrance()
{
	call RIMObj.Move 524.416809 131.779938 -509.067474 2 0 0 0 1 1 1 1
	call RIMObj.Move 500.280029 134.175934 -485.524780 2 0 0 0 1 1 1 1
	call RIMObj.Move 455.336761 132.322754 -483.121429
	call ZoneDoor "Zone to Sanctus Seru"
}
function SanctusSeruCitySanctusSeruCityEntrance()
{
	call RIMObj.Move -239.145325 179.756012 -1.491324 2 0 0 0 1 1 1 1
	call RIMObj.Move -238.240143 179.763000 -72.316628
	call Teleporter -240.826004 179.763000 -79.639267
	call RIMObj.Move -317.546478 89.616943 -54.728264 2 0 0 0 1 1 1 1
	call RIMObj.Move -323.931274 89.616943 -27.757401 2 0 0 0 1 1 1 1
	call RIMObj.Move -404.602600 87.997009 -2.327293
	call ZoneDoor "Zone from Sanctus Seru" 1 0 50 0
}
function SanctusSeruCityEntranceAurelianCoastEntrance()
{
	call RIMObj.Move 519.844299 132.766464 -501.667328 2 0 0 0 1 1 1 1
	call RIMObj.Move 575.162231 120.341393 -537.281006 2 0 0 0 1 0 1 1
}
function AurelianCoastEntranceAurelianCoast()
{
	call RIMObj.Move 578.941284 168.162369 -535.075500 2 0 0 0 1 1 1 1
	call RIMObj.Move 614.191162 166.027878 -468.702057 2 0 0 0 1 1 1 1
	call RIMObj.Move 564.862000 164.759354 -410.595825 2 0 0 0 1 1 1 1
	call RIMObj.Move 505.270111 182.090652 -334.451996 2 0 0 0 1 1 1 1
	call RIMObj.Move 470.472015 182.090652 -288.354492 2 0 0 0 1 1 1 1
	call RIMObj.Move 401.111206 182.090652 -261.585693 2 0 0 0 1 1 1 1
	call RIMObj.Move 337.050385 182.090652 -248.277252 2 0 0 0 1 1 1 1
	call RIMObj.Move 278.243958 182.090652 -236.059982 2 0 0 0 1 1 1 1
	call RIMObj.Move 221.443237 160.222961 -319.707642 2 0 0 0 1 1 1 1
	call RIMObj.Move 181.324677 136.416992 -398.983032 2 0 0 0 1 1 1 1
	call RIMObj.Move 152.117996 102.369553 -466.107971 2 0 0 0 1 1 1 1
	call RIMObj.Move 146.067078 95.078445 -480.567047 2 0 0 0 1 0 1 1
	call RIMObj.FlyDown
	call RIMObj.Move 120.431206 85.212440 -528.233398 2 0 0 0 1 1 1 1
	call RIMObj.Move 124.675194 81.743469 -549.212830 2 0 0 0 1 1 1 1
	call RIMObj.Move 97.506111 76.690018 -575.213135 2 0 0 0 1 1 1 1
	call RIMObj.Move 99.035454 70.420067 -604.811768 2 0 0 0 1 1 1 1
	call RIMObj.Move 113.527733 66.510788 -622.734680
}
function TheBlindingSeruAscentSanctusSeruCityEntrance()
{
	call RIMObj.Move 616.171082 42.813335 599.893982 2 0 0 0 1 1 1 1
	call RIMObj.Move 666.435181 45.223640 648.547729 2 0 0 0 1 1 1 1
	call RIMObj.Move 722.108215 57.757050 710.868530 5 0 0 0 1 0 1 1
	call ZoneDoor zone_to_sanctus_seru
}
function SanctusSeruCityEntranceSanctusSeruCity()
{
	call RIMObj.Move -323.697144 89.616943 -27.782698 2 0 0 0 1 1 1 1
	call RIMObj.Move -314.674561 87.660339 -87.339867 2 0 0 0 1 1 1 1
	call RIMObj.Move -329.257263 87.660339 -161.775116
	call Teleporter -332.244385 87.660339 -169.578201
	call RIMObj.Move -239.133438 179.756027 -1.253709 2 0 0 0 1 0 1 1
}
function TheBlindingZoneEntranceTheBlinding2ndDrone()
{
	call RIMObj.Move 591.000000 428.598633 -581.580017 5
	wait 5
	Actor[a tamed Shik'Nar drone]:DoubleClick
	wait 2
	Actor[a tamed Shik'Nar drone]:DoubleClick
	wait 10
	while ${Me.IsMoving}
		wait 10
	wait 10
}
function TheBlinding2ndDroneTheBlindingSeruAscent()
{
	call RIMObj.Move -584.000000 33.517941 358.359985 5
	wait 5
	Actor[a tamed Shik'Nar drone]:DoubleClick
	wait 2
	Actor[a tamed Shik'Nar drone]:DoubleClick
	wait 10
	RIMUIObj:HailOption[ALL,2]
	wait 2
	RIMUIObj:HailOption[ALL,2]
	wait 10
	while ${Me.IsMoving}
		wait 10
	wait 10
}
function GuildHallTheBlinding()
{
	if !${Zone.ShortName.Find[guildhall]}
	{
		if ${Me.Distance[621.859985,428.167542,-580.669983]}<50 && ${Zone.Name.Find[The Blinding]}
			noop
		else
			echo ISXRI: We attempted to call to the guild hall but failed, please call to the guild hall are run Goto again
		return
	}
	if ( !${Actor[Query, Guild=="Guild Portal Wizard"](exists)} && !${Actor[Query, Name=-"Ulteran Spire"](exists)} )
	{
		echo ISXRI: We are at guild hall but did not detect a Wizard Portal
		return
	}
	if ( ${Actor[Query, Guild=="Guild Portal Wizard"].CheckCollision} || ${Actor[Query, Name=-"Ulteran Spire"].CheckCollision} )
	{
		echo ISXRI: We are at guild hall and detected a collision to the wizard portal, please move your wizard portal to line of sight of the call to guild hall location
		return
	}
	variable string _PortalLoc
	if ${Actor[Query, Guild=="Guild Portal Wizard"](exists)}
	{
		_PortalLoc:Set["${Actor[Query, Guild=="Guild Portal Wizard"].Loc}"]
		_PortalLoc:Set["${_PortalLoc.Replace[","," "]}"]
		call RIMObj.Move ${_PortalLoc} 5
		wait 5
		RIMUIObj:Hail[ALL,"${Actor[Query, Guild=="Guild Portal Wizard"].Name}"]
		wait 10
		RIMUIObj:HailOption[ALL,1]
		wait 2
		RIMUIObj:HailOption[ALL,1]
		wait 10
		Actor[Translocator Spires]:DoubleClick
		wait 2
		Actor[Translocator Spires]:DoubleClick
		wait 5
		call RIMObj.TravelMap Blinding
		wait 5
	}
	else
	{
		_PortalLoc:Set["${Actor[Query, Name=-"Ulteran Spire"].Loc}"]
		_PortalLoc:Set["${_PortalLoc.Replace[","," "]}"]
		call RIMObj.Move ${_PortalLoc} 5
		wait 10
		Actor[Ulteran Spire:DoubleClick
		wait 2
		Actor[Ulteran Spire]:DoubleClick
		wait 5
		call RIMObj.TravelMap Blinding
		wait 5
	}
}
function ZoneTO(float _X, float _Z,int _Wait=600)
{
	;if !${RI_Var_Bool_GlobalOthers}
	;	relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call Zone ${_X} ${_Z} ${_Wait}"]
	wait 5
	Face ${_X} ${_Z}
	wait 2
	press -hold ${RI_Var_String_ForwardKey}
	timedcommand 150 press -release ${RI_Var_String_ForwardKey}
	
	variable int _Counter
	_Counter:Set[0]
	while ${EQ2.Zoning}==0 && ${_Counter:Inc}<${_Wait}
	{
		if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
		{
			press -release ${RI_Var_String_ForwardKey}
			RIMUIObj:Door[ALL,0]
		}
		wait 1
	}
	press -release ${RI_Var_String_ForwardKey}
	wait ${_Wait} ${EQ2.Zoning}==0
	press -release ${RI_Var_String_ForwardKey}
}
function Teleporter(float _x, float _y, float _z, int _precision=1, int _maxdistance=10)
{
	if ${Script[Buffer:CoT]}
		endscript Buffer:CoT
	;echo Teleporter(float _x=${_x}, float _y=${_y}, float _z=${_z}, int _precision=1=${_precision}, int _maxdistance=10=${_maxdistance})
	if !${RI_Var_Bool_GlobalOthers}
	{
		wait 20
		call RIMObj.stopfollow
	}
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RZScriptName}]:QueueCommand["call Teleporter ${_x} ${_y} ${_z} ${_precision} ${_maxdistance}"]
	RIMUIObj:SetLockSpot[ALL,${_x},${_y},${_z},${_precision},${_maxdistance}]
	wait 100 ${Math.Distance[${Me.Loc},${_x},${_y},${_z}]}<=${_precision}
	;echo before while ${Math.Distance[${Me.Loc},${_x},${_y},${_z}]}<=${_maxdistance} && !${EQ2.Zoning}
	while ${Math.Distance[${Me.Loc},${_x},${_y},${_z}]}<=${_maxdistance} && !${EQ2.Zoning}
	{
		wait 5
		;echo in while
		press -hold ${RI_Var_String_ForwardKey}
	}
	;echo after while ${Math.Distance[${Me.Loc},${_x},${_y},${_z}]}<=${_precision} && !${EQ2.Zoning}
	press -release ${RI_Var_String_ForwardKey}
	RIMUIObj:SetLockSpot[OFF]
	press -release ${RI_Var_String_ForwardKey}
	wait 600 ${RIMObj.AllGroupWithinRange[10]}
	wait 20
	if !${Script[Buffer:CoT]}
		RI_CoT
}
function FastTravel(string _ZoneName, string _DoorOption=0)
{	
	;echo FastTravel(string _ZoneName=${_ZoneName}, int _RelayToGroup=${_RelayToGroup}, string _DoorOption=${_DoorOption})
	if ${RIMUIObj.MainIconIDExists[${Me.ID},955,0]}==0
	{
		call MessageBox "You must be gold to use the FastTravel feature required for this quest Pausing RQ please resume in ${_ZoneName} at the location FastTravel would normally take you"
	}
	else
	{
		RIMUIObj:FastTravel[${Me.Name},"${_ZoneName}","${_DoorOption}"]
		wait 50 ${EQ2.Zoning}==1
		if ${EQ2.Zoning}==0
		{
			if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
				call DoorOption 0;wait 10
			if ${ChoiceWindow(exists)}
				ChoiceWindow:DoChoice1
		}
		wait 600 ${EQ2.Zoning}==1
		wait 600 ${EQ2.Zoning}==0
	}
}
function ZoneDoor(string _Actor, string _DoorOption=-1, bool _LoopUntilNoHighlightOnMouseHover=0, int _GiveUpCNT=50, bool _ExactName=1)
{
	;echo ZoneDoor(string _Actor=${_Actor}, string _DoorOption=-1=${_DoorOption}, int _LoopUntilNoHighlightOnMouseHover=0=${_LoopUntilNoHighlightOnMouseHover}, int _GiveUpCNT=50=${_GiveUpCNT})
	variable int _Cnt=0
	variable int _ID

	call RIMObj.stopfollow
	;make sure _Actor exists so we do not go through the motions for nothign
	;echo \${Actor[Query, Name=-"${_Actor}"](exists)}  //  ${Actor[Query, Name=-"${_Actor}"](exists)}
	if ${_LoopUntilNoHighlightOnMouseHover}
	{
		if ${Actor[Query, Name=-"${_Actor}" && HighlightOnMouseHover=TRUE](exists)} || ${Actor[Query, Name=="${_Actor}"](exists)}
		{
			if ${_ExactName}
				_ID:Set[${Actor[Query, Name=="${_Actor}" && HighlightOnMouseHover=TRUE].ID}]
			else
				_ID:Set[${Actor[Query, Name=-"${_Actor}" && HighlightOnMouseHover=TRUE].ID}]
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			if ${_LoopUntilNoHighlightOnMouseHover}
			{
				while ${Actor[${_ID}].HighlightOnMouseHover} && ${_Cnt:Inc} <= ${_GiveUpCNT}
				{
					;echo relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
					relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
					wait 5
				}
			}
			else
			{
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
			}
		}
	}
	else
	{
		if ${Actor[Query, Name=-"${_Actor}"](exists)} || ${Actor[Query, Name=="${_Actor}"](exists)}
		{
			if ${_ExactName}
				_ID:Set[${Actor[Query, Name=="${_Actor}"].ID}]
			else
				_ID:Set[${Actor[Query, Name=-"${_Actor}"].ID}]
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			;echo ${_ID}
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			if ${_LoopUntilNoHighlightOnMouseHover}
			{
				while ${Actor[${_ID}].HighlightOnMouseHover} && ${_Cnt:Inc} <= ${_GiveUpCNT}
				{
					relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
				}
			}
			else
			{
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
			}
		}

	}
	relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	
	if ${Int[${_DoorOption}]}==-1
		noop
	else
		call DoorOption "${_DoorOption}"
	wait 50 ${EQ2.Zoning}==1
	if ${EQ2.Zoning}==0
	{
		if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
			call DoorOption 0;wait 10
		if ${ChoiceWindow(Exists)}
			ChoiceWindow:DoChoice1
	}
	wait 600 ${EQ2.Zoning}==1
	wait 600 ${EQ2.Zoning}==0
}
function DoorOption(string _Door)
{
	;echo DoorOption(string _Door=${_Door})
	if ${Int[${_Door}]}==0 && ${_Door.NotEqual[0]} && ${EQ2.Zoning}==0
	{
		;echo Name
		RIObj:GetZoneLists
		wait 5
		if ${RIObj.RowByName["${_Door}"]}==0
		{
			echo ISXRI: Can't find that zone in the Destination list
			return
		}
		wait 5
		relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:Door[ALL,${RIObj.RowByName["${_Door}"]}]
		wait 5
	}
	else
	{
		;echo Number
		relay "${RI_Var_String_RelayGroup}" RIMUIObj:Door[ALL,${Int[${_Door}]}]
		wait 5
		relay "${RI_Var_String_RelayGroup}" RIMUIObj:Door[ALL,${Int[${_Door}]}]
		;EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${Int[${_Door}]}]
		wait 5
		;TimedCommand 5 EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
		;wait 5
	}
}
;Zone function
function Zone(int _IndexPosition)
{
	;echo ${_IndexPosition} // ${ZoneFrom.Get[${_IndexPosition}]}
	wait 60 !${EQ2.Zoning}
	wait 5
	wait 60 !${EQ2.Zoning}
	wait 5
	wait 60 ${Zone.Name(exists)}
	wait 5
	variable string _ZoneNameFormatter
	if ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${_Zone.Get[${_IndexPosition}].Find["[Expert]"]}
	{
		RZ_Var_String_ZoneVersion:Set["Expert"]
		if ( ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Reishi Rumble"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Listless Spires"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Arx Aeturnus"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["The Venom of Ssraeshza"]} )
			_ZoneNameFormatter:Set["${_Zone.Get[${_IndexPosition}].ReplaceSubstring["[Expert]","[Event Heroic]"]}"]
		else
			_ZoneNameFormatter:Set["${_Zone.Get[${_IndexPosition}].ReplaceSubstring["[Expert]","[Heroic]"]}"]
	}
	elseif ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${_Zone.Get[${_IndexPosition}].Find["[Challenge]"]}
	{
		RZ_Var_String_ZoneVersion:Set["Challenge"]
		if ( ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Reishi Rumble"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Listless Spires"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Arx Aeturnus"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["The Venom of Ssraeshza"]} )
			_ZoneNameFormatter:Set["${_Zone.Get[${_IndexPosition}].ReplaceSubstring["[Challenge]","[Event Heroic]"]}"]
		else
			_ZoneNameFormatter:Set["${_Zone.Get[${_IndexPosition}].ReplaceSubstring["[Challenge]","[Heroic]"]}"]
	}
	elseif ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${_Zone.Get[${_IndexPosition}].Find["Heroic]"]}
	{
		RZ_Var_String_ZoneVersion:Set["Heroic"]
		_ZoneNameFormatter:Set["${_Zone.Get[${_IndexPosition}]}"]
	}
	else
	{
		RZ_Var_String_ZoneVersion:Set["FALSE"]
		_ZoneNameFormatter:Set["${_Zone.Get[${_IndexPosition}]}"]
	}
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
	if ${ZoneFrom.Get[${_IndexPosition}].Find[Myrist](exists)} && ( !${Zone.Name.Find[Myrist](exists)} || ${Me.Distance[750.767456,411.093536,-368.339264]}>45 )
	{
		echo ISXRI: We must be in Myrist, the Great Library at the Elemental Portal Gallery in order for RZ to Function for Chaos Descending
		Script:End
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find[Aurelian Coast](exists)} && ( !${Zone.Name.Find[Aurelian Coast](exists)} || ( ${Me.Distance[113.730003,57.369999,-657.119995]}>45 && ${Me.Distance[161.188644,62.000786,-631.729248]}>45 )
	{
		echo ISXRI: We are not in Aurelian Coast we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto AC
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Sanctus Seru [City]"](exists)} && ( !${Zone.Name.Find["Sanctus Seru [City]"](exists)} || ${Me.Distance[-239.133438,179.756027,-1.253709]}>55 )
	{
		echo ISXRI: We are not in Sanctus Seru [City] we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto SSC
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Wracklands"](exists)} && ( !${Zone.Name.Find["Wracklands"](exists)} || ${Me.Distance[726.633362,77.960884,664.408203]}>55 )
	{
		echo ISXRI: We are not in Wracklands we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto WL
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["City of Fordel Midst"](exists)} && ( !${Zone.Name.Find["City of Fordel Midst"](exists)} || ${Me.Distance[397.221436,-35.983528,748.467163]}>55 )
	{
		;echo ISXRI: We are not in City of Fordel Midst we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto FM
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["City of Shar Vahl"](exists)} && ( !${Zone.Name.Find["City of Shar Vahl"](exists)} || ( ${Me.Distance[-139.178238,32.386150,244.650986]}>20 && ${ZoneFrom.Get[${_IndexPosition}].Find["Untamed Lands"](exists)} ) || ( ${Me.Distance[-357.383545,91.861389,179.837708]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Feral Reserve"](exists)} ) )
	{
		;echo ISXRI: We are not in City of Shar Vahl we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		if ${ZoneFrom.Get[${_IndexPosition}].Find["Feral Reserve"]}
			call Goto SVFR
		if ${ZoneFrom.Get[${_IndexPosition}].Find["Untamed Lands"]}
			call Goto SVUL
	}
	;echo ${ZoneFrom.Get[${_IndexPosition}]} // ${ZoneFrom.Get[${_IndexPosition}].Find["Savage Weald"](exists)} && ( !${Zone.Name.Find["Savage Weald"](exists)} || ( ${Me.Distance[-896.098450,75.165260,-375.025940]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Chaotic Caverns"](exists)} ) || ( ${Me.Distance[-81.374565,20.860985,-259.299744]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Fort Grim"](exists)} ) ) 
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Savage Weald"](exists)} && ( !${Zone.Name.Find["Savage Weald"](exists)} || ( ${Me.Distance[-896.098450,75.165260,-375.025940]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Chaotic Caverns"](exists)} ) || ( ${Me.Distance[-81.374565,20.860985,-259.299744]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Fort Grim"](exists)} ) )
	{
		;echo ISXRI: We are not in Savage Weald we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		if ${ZoneFrom.Get[${_IndexPosition}].Find["Fort Grim"]}
			call Goto SWFG
		if ${ZoneFrom.Get[${_IndexPosition}].Find["Chaotic Caverns"]}
			call Goto SWCC
	}
	;echo ${ZoneFrom.Get[${_IndexPosition}].Find["Shadeweaver's Thicket"](exists)} && ( !${Zone.Name.Find["Shadeweaver's Thicket"](exists)} || ( ${Me.Distance[-544.688782,161.518738,-753.726624]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Equal["Shadeweaver's Thicket"]} ) ) || ( !${Zone.Name.Find["Shadeweaver's Thicket"](exists)} || ( ${Me.Distance[632.874634,13.072926,316.680420]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Loda Kai Isle"](exists)} ) )
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Shadeweaver's Thicket"](exists)} && ( !${Zone.Name.Find["Shadeweaver's Thicket"](exists)} || ( ${Me.Distance[-544.688782,161.518738,-753.726624]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Equal["Shadeweaver's Thicket"]} ) || ( !${Zone.Name.Find["Shadeweaver's Thicket"](exists)} || ( ${Me.Distance[632.874634,13.072926,316.680420]}>55 && ${ZoneFrom.Get[${_IndexPosition}].Find["Loda Kai Isle"](exists)} ) )
	{
		;echo ${ZoneFrom.Get[${_IndexPosition}]}
		;echo ${ZoneFrom.Get[${_IndexPosition}].Equal["Shadeweaver's Thicket"]}
		;echo ISXRI: We are not in Shadeweaver's Thicket we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		if ${ZoneFrom.Get[${_IndexPosition}].Find["Loda Kai Isle"](exists)}
			call Goto STLKI
		else
			call Goto ST
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Echo Caverns"](exists)} && ( !${Zone.Name.Find["Echo Caverns"](exists)} || ${Me.Distance[615.701111,25.766819,-439.633423]}>55 )
	{
		;echo ISXRI: We are not in Echo Caverns we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto EC
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Svarni Expanse"](exists)} && ( !${Zone.Name.Find["Svarni Expanse"](exists)} )
	{
		;echo ISXRI: We are not in Svarni Expanse we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto SE
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Karuupa Jungle Heart of Conflict"](exists)} && ( !${Zone.Name.Find["Karuupa Jungle"](exists)} || ${Me.Distance[645.20,48.73,-446.90]}>55 )
	{
		;echo ISXRI: We are not in Karuupa Jungle Heart of Conflict we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto KJHC
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Karuupa Jungle Dedrakas Descent"](exists)} && ( !${Zone.Name.Find["Karuupa Jungle"](exists)} || ${Me.Distance[-232.49,109.59,-691.35]}>55 )
	{
		;echo ISXRI: We are not in Karuupa Jungle Dedrakas Descent we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto KJDD
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Mahngavi Wastes"](exists)} && ( !${Zone.Name.Find["Mahngavi Wastes"](exists)} || ${Me.Distance[645.20,48.73,-446.90]}>55 )
	{
		;echo ISXRI: We are not in Mahngavi Wastes we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto MW
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Forlorn Gist Merchants Den"](exists)} && ( !${Zone.Name.Find["Forlorn Gist"](exists)} || ${Me.Distance[-289.55,53.67,-345.43]}>75 )
	{
		;echo ISXRI: We are not in Forlorn Gist we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto FGMD
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Forlorn Gist"](exists)} && !${ZoneFrom.Get[${_IndexPosition}].Find["Forlorn Gist Merchants Den"](exists)} && ( !${Zone.Name.Find["Forlorn Gist"](exists)} || ${Me.Distance[434.29,108.74,205.00]}>75 )
	{
		;echo ISXRI: We are not in Forlorn Gist we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto FG
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Karuupa Jungle Predators Perch"](exists)} && ( !${Zone.Name.Find["Karuupa Jungle"](exists)} || ${Me.Distance[-746.00,197.57,-284.76]}>55 )
	{
		;echo ISXRI: We are not in Forlorn Gist we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto KJPP
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Raj'Dur Plateaus Blood and Sand"](exists)} && ( !${Zone.Name.Find["Raj'Dur Plateaus"](exists)} || ${Me.Distance[162.720001,-59.590000,477.339996]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto RPBS
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Raj'Dur Plateaus The Sultan's Dagger"](exists)} && ( !${Zone.Name.Find["Raj'Dur Plateaus"](exists)} || ${Me.Distance[60.549999,87.639999,-349.829987]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto RPTSD
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Raj'Dur Plateaus Buried Takish'Hiz"](exists)} && ( !${Zone.Name.Find["Raj'Dur Plateaus"](exists)} || ${Me.Distance[-554.349976,10.960000,427.899994]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto RPBT
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Takish Badlands Kigathor's Glade"](exists)} && ( !${Zone.Name.Find["Takish Badlands"](exists)} || ${Me.Distance[-394.227814,245.000000,213.808731]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto TBKG
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Takish Badlands Overgrowth"](exists)} && ( !${Zone.Name.Find["Takish Badlands"](exists)} || ${Me.Distance[742.023987,58.080002,42.790913]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto TBOG
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Sandstone Delta Eye of Night"](exists)} && ( !${Zone.Name.Find["Sandstone Delta"](exists)} || ${Me.Distance[589.960022,113.050003,-631.919983]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto SDEN
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Sandstone Delta Eye of the Storm"](exists)} && ( !${Zone.Name.Find["Sandstone Delta"](exists)} || ${Me.Distance[-47.570000,57.150002,160.699997]}>55 )
	{
		;echo ISXRI: We are not at ${ZoneFrom.Get[${_IndexPosition}]} we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		call Goto SDES
	}
	wait 6000 ${RIMObj.AllGroupInZone}
	wait 20
	
	variable int _cnt=0
	for(_cnt:Set[1];${_cnt}<=${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Count[|]}+1]};_cnt:Inc)
	{
		;echo "${ZoneEntranceLoc.Get[${_IndexPosition}].Token[${_cnt},|].Replace[","," "]}" // ${ZoneEntranceLoc.Get[${_IndexPosition}].Token[${_cnt},|].Equal[""]}
		if ${ZoneEntranceLoc.Get[${_IndexPosition}].Token[${_cnt},|].Equal[""]}
			noop
		else
			call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}].Token[${_cnt},|].Replace[","," "]} 5 0 0 1 1 0 1 1
	}
	
	
	wait 20

	echo ${Time}: Zoning into ${_Zone.Get[${_IndexPosition}]} as ${_ZoneNameFormatter}
	
	;click Zone1 Zone in
	if ${_Zone.Get[${_IndexPosition}].Equal["The Icy Keep (Hard)"]}
	{
		relay ${RI_Var_String_RelayGroup} Actor[id,${Actor[Query, Name=="The Icy Door"].ID}]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor[id,${Actor[Query, Name=="The Icy Door"].ID}]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor[id,${Actor[Query, Name=="The Icy Door"].ID}]:DoubleClick
	}
	else	
		Actor["${ZoneEntrance.Get[${_IndexPosition}]}"]:DoubleClick
	wait 10
	
	
	RZObj:GetZoneLists
	wait 20
	variable int _ZCNT=0
	while ${RZObj.RowByName["${_ZoneNameFormatter}"]}==0 && ${_ZCNT:Inc}<10
	{
		RZObj:GetZoneLists
		wait 5
	}
	if ${RZObj.RowByName["${_ZoneNameFormatter}"]}==0
	{
		echo ISXRI: Can't find that zone in the Destination list
		Script:End
	}
	wait 10
	if ${_Zone.Get[${_IndexPosition}].Equal["The Icy Keep (Hard)"]}
		relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${RZObj.RowByName["${_ZoneNameFormatter}"]}]
	else
		EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${RZObj.RowByName["${_ZoneNameFormatter}"]}]
	wait 10
	
	;confirm selection and zone
	if ${_Zone.Get[${_IndexPosition}].Equal["The Icy Keep (Hard)"]}
		relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	else
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
	;echo 1 \${Me.GetGameData[Self.ZoneName].Label.NotEqual["\${_ZoneNameFormatter}"]} // \${Me.GetGameData[Self.ZoneName].Label.NotEqual["${_ZoneNameFormatter}"]} // ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${_ZoneNameFormatter}"]}
	;if we are not in the correct zone, exit function
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${_ZoneNameFormatter}"]}
		return
	;echo 2	
	;run runinstances started
	ri
	wait 50
	RI_Var_Bool_Start:Set[TRUE]
	UIElement[Start@RI]:SetText[Pause]
	if ${_ZoneNameFormatter.Find["[Solo]"]}
		eq2ex /merc resume
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
	if ${ZoneExitLoc.Get[${_IndexPosition}].Replace[" ",","].Count}>0
	{
		if ${Math.Distance[${Me.Loc},${ZoneExitLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>
			call RIMObj.Move ${ZoneExitLoc.Get[${_IndexPosition}]} 1 0 0 1 1 0 1 1
	}
	wait 20
	
	;zoneout
	;relay "other ${RI_Var_String_RelayGroup}" -noredirect RZ 0 0 TRUE "${Zone1Exit}" "${Zone1}"
	if ${ZoneExit.Get[${_IndexPosition}].NotEqual["!NONE!"]}
		call ZoneOut "${ZoneExit.Get[${_IndexPosition}]}" "${_ZoneNameFormatter}"
}

function ZoneOut(string ZoneExit, string ZoneName)
{
	;while we are not zoning and in ${_Zone} keep clicking the exit
	relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
	relay ${RI_Var_String_RelayGroup} Actor[${ZoneExit}]:DoubleClick
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
		relay ${RI_Var_String_RelayGroup} Actor[${ZoneExit}]:DoubleClick
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
	
	if ${ZoneName.Find[Aurelian Coast:](exists)}
		call RIMObj.Move 115.025063 63.876396 -632.220154 1 0 0 1 1 0 1 1
}

;RZObj object
objectdef RZObject
{
	method Solo()
	{
		_SoloMode:Set[1]
		_HeroicMode:Set[0]
		UIElement[AddedZoneList@RZ]:ClearItems
		variable int _i
		for(_i:Set[1];${_i}<=${AddedZonesList.Used};_i:Inc)
		{
			if ${AddedZonesList.Get[${_i}].Find["[Solo]"]}
				UIElement[AddedZoneList@RZ]:AddItem["${AddedZonesList.Get[${_i}]}"]
		}
	}
	method Heroic()
	{
		_SoloMode:Set[0]
		_HeroicMode:Set[1]
		UIElement[AddedZoneList@RZ]:ClearItems
		variable int _i
		for(_i:Set[1];${_i}<=${AddedZonesList.Used};_i:Inc)
		{
			if !${AddedZonesList.Get[${_i}].Find["[Solo]"]}
				UIElement[AddedZoneList@RZ]:AddItem["${AddedZonesList.Get[${_i}]}"]
		}
	}
	method Expac(string _Expac)
	{
		BuildIndexes "${_Expac}"
	}
	method Save()
	{
		if ${_SoloMode} || ${_HeroicMode}
			return
		variable string SetName
		SetName:Set[Zones]
		LavishSettings[RZ]:Clear
		LavishSettings:AddSet[RZ]
		LavishSettings[RZ]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RZ/RZSave.xml"]
		LavishSettings[RZ]:AddSetting[Shinys,"${UIElement[GrabShinysCheckBox@RZ].Checked}"]
		LavishSettings[RZ]:AddSetting[RII,"${UIElement[RIICheckBox@RZ].Checked}"]
		LavishSettings[RZ]:AddSet[Loops]
		LavishSettings[RZ].FindSet[Loops]:Clear
		
		if ${UIElement[InfiniteLoopListCheckBox@RZ].Checked}
			LavishSettings[RZ].FindSet[Loops]:AddSetting[Loops,"∞"]
		else
			LavishSettings[RZ].FindSet[Loops]:AddSetting[Loops,"${UIElement[LoopCountTextEntry@RZ].Text}"]
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
			if ${LavishSettings[Zones].FindSetting[Shinys]}
				UIElement[GrabShinysCheckBox@RZ]:SetChecked
			if ${LavishSettings[Zones].FindSetting[RII]}
				UIElement[RIICheckBox@RZ]:SetChecked
			RZSet:Set[${LavishSettings[Zones].GUID}]
			variable settingsetref LoadListSet=${RZSet.FindSet[Loops].GUID}
			LoadListSet:Set[${RZSet.FindSet[Loops].GUID}]
			if ${RZSet.FindSet[Loops](exists)}
			{
				declare _Loops string
				_Loops:Set["${LoadListSet.FindSetting[Loops]}"]
				if ${_Loops.Equal["∞"]}
				{
					UIElement[LoopListCheckBox@RZ]:UnsetChecked
					UIElement[InfiniteLoopListCheckBox@RZ]:SetChecked
					UIElement[LoopCountTextEntry@RZ]:SetText[0]
				}
				else
				{
					UIElement[InfiniteLoopListCheckBox@RZ]:UnsetChecked
					UIElement[LoopListCheckBox@RZ]:SetChecked
					UIElement[LoopCountTextEntry@RZ]:SetText[${_Loops}]
				}
			}
			RZSet:Set[${LavishSettings[Zones].GUID}]
			LoadListSet:Set[${RZSet.FindSet[Zones].GUID}]
			
			variable iterator SettingIterator
			LoadListSet:GetSettingIterator[SettingIterator]
			if ${SettingIterator:First(exists)}
			{
				do
				{
					;;echo "${SettingIterator.Key}=${SettingIterator.Value}"
					UIElement[AddedZoneList@RZ]:AddItem["${SettingIterator.Key}"]
					AddedZonesList:Insert["${SettingIterator.Key}"]
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
		RI_Var_Bool_GrabShinys:Set[${UIElement[GrabShinysCheckBox@RZ].Checked}]
		if ${UIElement[RIICheckBox@RZ].Checked}
		{
			rii -loop -start -noui
		}
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
		if ${_SoloMode} || ${_HeroicMode}
			return
		;echo ${_ZoneName}
		if ${_ZoneName.NotEqual[""]} && ${_ZoneName.NotEqual[NULL]}
		{
			if ${_ZoneName.Equal["The Icy Keep (Hard)"]}
			{
				UIElement[AddedZoneList@RZ]:ClearItems
				UIElement[LoopListCheckBox@RZ]:UnsetChecked
				UIElement[InfiniteLoopListCheckBox@RZ]:SetChecked
				_HeroicMode:Set[1]
			}
			UIElement[AddedZoneList@RZ]:AddItem["${_ZoneName}"]
			This:RefreshAddedZoneIndex
		}
	}
	method AddedZoneListRightClick()
	{
		if ${_SoloMode} || ${_HeroicMode}
			return
		if ${UIElement[AddedZoneList@RZ].SelectedItem(exists)}
		{
			UIElement[AddedZoneList@RZ]:RemoveItem[${UIElement[AddedZoneList@RZ].SelectedItem.ID}]
			This:RefreshAddedZoneIndex
		}
	}
	method RefreshAddedZoneIndex()
	{
		if ${_SoloMode} || ${_HeroicMode}
			return
		AddedZonesList:Clear
		variable int _i
		for(_i:Set[1];${_i}<=${UIElement[AddedZoneList@RZ].Items};_i:Inc)
		{
			AddedZonesList:Insert["${UIElement[AddedZoneList@RZ].OrderedItem[${_i}]}"]
		}
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
	member:int RowByName(string _ZoneName)
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
		variable string _ZoneNameFormatter
		if ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${ZoneName.Find["[Expert]"]}
		{
			if ( ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Reishi Rumble"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Listless Spires"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Arx Aeturnus"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["The Venom of Ssraeshza"]} )
				_ZoneNameFormatter:Set["${ZoneName.ReplaceSubstring["[Expert]","[Event Heroic]"]}"]
			else
				_ZoneNameFormatter:Set["${ZoneName.ReplaceSubstring["[Expert]","[Heroic]"]}"]
		}
		elseif ${UIElement[ExpacComboBox@RZ].SelectedItem.Text.Equal["Blood of Luclin"]} && ${ZoneName.Find["[Challenge]"]}
		{
			if ( ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Reishi Rumble"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Listless Spires"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["Arx Aeturnus"]} || ${UIElement[AddedZoneList@RZ].OrderedItem[${RZ_Var_Int_Count}].Text.Find["The Venom of Ssraeshza"]} )
				_ZoneNameFormatter:Set["${ZoneName.ReplaceSubstring["[Challenge]","[Event Heroic]"]}"]
			else
				_ZoneNameFormatter:Set["${ZoneName.ReplaceSubstring["[Challenge]","[Heroic]"]}"]
		}
		elseif ${ZoneName.Find["The Icy Keep (Hard)"]}
		{
				_ZoneNameFormatter:Set["${ZoneName.ReplaceSubstring[" (Hard)",""]}"]
		}
		else
			_ZoneNameFormatter:Set["${ZoneName}"]
		echo ${Time}: Unlocking ${ZoneName}
		relay ${RI_Var_String_RelayGroup} eq2ex togglezonereuse
		wait 5
		relay ${RI_Var_String_RelayGroup} eq2ex togglezonereuse
		wait 5
		relay ${RI_Var_String_RelayGroup} Me:ResetZoneTimer["${_ZoneNameFormatter}"]
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
	if ${Script[${RI_Var_String_RIInventoryScriptName}](exists)} && ${UIElement[RIICheckBox@RZ].Checked}
		endscript ${RI_Var_String_RIInventoryScriptName}
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