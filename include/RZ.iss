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
			;Zone
			;_Zone:Insert[""]
			;UIElement[ZonesAvail@RZ]:AddItem[""]
			;ZoneFrom:Insert["Myrist"]
			;ZoneTimer:Insert[90]
			;ZoneExit:Insert[""]
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
		case Blood of Luclin
		{
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
			_Zone:Insert["Fordel Midst: The Listless Spires [Solo]"]
			UIElement[ZonesAvail@RZ]:AddItem["Fordel Midst: The Listless Spires [Solo]"]
			ZoneFrom:Insert["Aurelian Coast"]
			ZoneTimer:Insert[90]
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
			ZoneExit:Insert["Exit"]
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
	UIElement[ExpacComboBox@RZ]:AddItem["Blood of Luclin"]
	UIElement[ExpacComboBox@RZ]:AddItem["Chaos Descending"]
	UIElement[ExpacComboBox@RZ]:AddItem["Planes of Prophecy"]
	UIElement[ExpacComboBox@RZ]:SelectItem[1]
	BuildIndexes "Blood of Luclin"
	
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
function BuyWills(string _WhichWill)
{
	variable int GUCnt=0
	GUCnt:Set[0]
	while ${RIMUIObj.InventoryQuantity["${_WhichWill}"]}<20 && ${GUCnt:Inc}<10
		call BuyFromVendor "Haylise Madorus" "${_WhichWill}" ${Math.Calc[20-${RIMUIObj.InventoryQuantity["${_WhichWill}"]}].Precision[0]}
}
function Goto(string _WhereToGo)
{
	wait 10
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
	variable string _WhereToGoShort
	_WhereToGoShort:Set["${_WhereToGo.Replace[" ",""].Replace["[",""].Replace["]",""]}"]
	
	if ( ${_WhereToGoShort.NotEqual[AurelianCoast]} && ${_WhereToGoShort.NotEqual[SanctusSeruCity]} && ${_WhereToGoShort.NotEqual[Wracklands]})
	{
		;echo ${_WhereToGoShort}
		echo ISXRI: ${_WhereToGo} is not a Predetermined Goto Location
		return
	}
	variable string _WhereFrom=NONE
	;first determine where we are at 
	if ${Zone.Name.Find[Aurelian Coast]} && ${Me.Distance[113.730003,57.369999,-657.119995]}<20
	{
		;we are at Sambata Entrance, Move from here
		_WhereFrom:Set["Aurelian Coast"]
	}
	elseif ${Zone.Name.Find[Aurelian Coast]} && ${Me.Distance[169.061646,61.921852,-682.376831]}<20
	{
		;we are at Foredel Mist Entrance, Move from here
		call RIMObj.Move 187.207016 61.893368 -662.309143  2 0 0 0 1 1 1 1
		call RIMObj.Move 164.109650 61.839806 -637.346558  2 0 0 0 1 1 1 1
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
	_WhereFromShort:Set["${_WhereFrom.Replace[" ",""].Replace["[",""].Replace["]",""]}"]
	
	if ${_WhereFromShort.Equal["${_WhereToGoShort}"]}
	{
		echo ISXRI: We are already at ${_WhereToGo}
		return
	}
	;echo ${_WhereFromShort.Equal["${_WhereToGoShort}"]} // ${_WhereFromShort} // ${_WhereToGoShort}
	
	
	if ${_WhereToGoShort.Equal[SanctusSeruCity]} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of Seru"](exists)}
	{
		echo ISXRI: Moving to ${_WhereToGo} with Will of Seru
		;pause bots
		RI_CMD_PauseCombatBots 1
		eq2ex cancel_spellcast
		wait 2
		Me.Inventory[Query, Name=-"Will of Seru" && Location=="Inventory"]:Use
		wait 5
		Me.Inventory[Query, Name=-"Will of Seru" && Location=="Inventory"]:Use
		wait 50 ${EQ2.Zoning}
		wait 600 !${EQ2.Zoning}
		wait 50 ${Zone.Name.Equal["Sanctus Seru [City]"]}
		call RIMObj.Move 9.140417 180.650330 177.574127 2 0 0 0 1 0 1 1
		
		call BuyWills "Will of Seru"
		call BuyWills "Will of the Wracklands"
		call BuyWills "Will of the Coast"
		call BuyWills "Will of The Blinding"

		;unpause bots
		RI_CMD_PauseCombatBots 0
		eq2ex target_none
		if !${Others}
			call WillofSeruToSanctusSeruCity
	}
	elseif ${_WhereToGoShort.Equal[AurelianCoast]} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of the Coast"](exists)}
	{
		echo ISXRI: Moving to ${_WhereToGo} with Will of the Coast
		;pause bots
		RI_CMD_PauseCombatBots 1
		eq2ex cancel_spellcast
		wait 2
		Me.Inventory[Query, Name=-"Will of the Coast" && Location=="Inventory"]:Use
		wait 5
		Me.Inventory[Query, Name=-"Will of the Coast" && Location=="Inventory"]:Use
		wait 50 ${EQ2.Zoning}
		wait 600 !${EQ2.Zoning}
		wait 50 ${Zone.Name.Equal["Aurelian Coast"]}
		;unpause bots
		RI_CMD_PauseCombatBots 0
		if !${Others}
			call WilloftheCoastToAurelianCoast
	}
	elseif ${_WhereToGoShort.Equal[Wracklands]} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Will of the Wracklands"](exists)}
	{
		echo ISXRI: Moving to ${_WhereToGo} with Will of the Wracklands
		;pause bots
		RI_CMD_PauseCombatBots 1
		eq2ex cancel_spellcast
		wait 2
		Me.Inventory[Query, Name=-"Will of the Wracklands" && Location=="Inventory"]:Use
		wait 5
		Me.Inventory[Query, Name=-"Will of the Wracklands" && Location=="Inventory"]:Use
		wait 50 ${EQ2.Zoning}
		wait 600 !${EQ2.Zoning}
		wait 50 ${Zone.Name.Equal["Wracklands"]}
		;unpause bots
		RI_CMD_PauseCombatBots 0
		if !${Others}
			call WilloftheWracklandsToWracklands
	}
	else
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
	
	if ${Int[{_DoorOption}]}==-1
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
		;relay "other ${RI_Var_String_RelayGroup}" RZ ACO
		call Goto AC
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Sanctus Seru [City]"](exists)} && ( !${Zone.Name.Find["Sanctus Seru [City]"](exists)} || ${Me.Distance[-239.133438,179.756027,-1.253709]}>55 )
	{
		echo ISXRI: We are not in Sanctus Seru [City] we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		;relay "other ${RI_Var_String_RelayGroup}" RZ SSCO
		call Goto SSC
	}
	if ${ZoneFrom.Get[${_IndexPosition}].Find["Wracklands"](exists)} && ( !${Zone.Name.Find["Wracklands"](exists)} || ${Me.Distance[726.633362,77.960884,664.408203]}>55 )
	{
		echo ISXRI: We are not in Wracklands we are in ${Zone.Name} or not near the Entrance Loc we are at ${Me.Loc}, Moving there
		;relay "other ${RI_Var_String_RelayGroup}" RZ SSCO
		call Goto WL
	}
	
	wait 6000 ${RIMObj.AllGroupInZone}
	wait 20
	
	variable int _cnt=0
	for(_cnt:Set[1];${_cnt}<=${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Count[|]}+1]};_cnt:Inc)
	{
		call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}].Token[${_cnt},|]} 5 0 0 1 1 0 1 1
	}
	
	
	wait 20

	echo ${Time}: Zoning into ${_Zone.Get[${_IndexPosition}]} as ${_ZoneNameFormatter}
	
	;click Zone1 Zone in
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
	EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${RZObj.RowByName["${_ZoneNameFormatter}"]}]
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
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${_ZoneNameFormatter}"]}
		return
		
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