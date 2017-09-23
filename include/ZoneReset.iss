variable index:string ZoneList
variable(global) string RI_Var_String_ZoneResetScriptName=${Script.Filename}
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if ZoneReset.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[ZoneReset.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting ZoneReset.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/ZoneReset.xml" http://www.isxri.com/ZoneReset.xml
		wait 50
	}
	
	;open zones window to populate zones, then close
	eq2ex togglezonereuse
	wait 5
	eq2ex togglezonereuse
	wait 2
	
	;loadui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/ZoneReset.xml"
	
	;get ZoneList into ZoneList index
	EQ2:GetPersisentZones[ZoneList]
	
	;for loop to add zones to Zones List Box
	variable int count1=0
	for(count1:Set[1];${count1}<=${ZoneList.Used};count1:Inc)
	{
		UIElement[Zones@ZoneReset]:AddItem["${ZoneList[${count1}]}"]
	}
	
	;main while loop
	while 1
	{
		;execute queued commands
		if ${QueuedCommands}
		{
			ExecuteQueued
		}
		
		;wait 1 min or until there are queuedcommands
		wait 600 ${QueuedCommands}
	}
}
atom(global) RI_Atom_ZR_AddZone(string ZoneName)
{
	;add ZoneName to AddedZonesList
	UIElement[AddedZoneList@ZoneReset]:AddItem["${ZoneName}"]
}
function ResetZones()
{
	;open zones window to populate zones, then close
	eq2ex togglezonereuse
	wait 5
	eq2ex togglezonereuse
	wait 2
	
	;forloop to reset zones in AddedZoneList
	variable int count
	for (count:Set[1];${count}<=${UIElement[ZoneReset].FindChild[AddedZoneList].Items};count:Inc)
	{
		Me:ResetZoneTimer["${UIElement[ZoneReset].FindChild[AddedZoneList].Item[${count2}]}"]
		wait 2
	}
}
function RelayResetZones()
{
	;open zones window to populate zones, then close
	relay all eq2ex togglezonereuse
	wait 5
	relay all eq2ex togglezonereuse
	wait 2
	
	;forloop to reset zones in AddedZoneList
	variable int count
	for (count:Set[1];${count}<=${UIElement[ZoneReset].FindChild[AddedZoneList].Items};count:Inc)
	{
		relay all Me:ResetZoneTimer["${UIElement[ZoneReset].FindChild[AddedZoneList].OrderedItem[${count}]}"]
		wait 2
	}
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/ZoneReset.xml"
}