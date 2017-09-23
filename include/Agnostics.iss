;Agnostics.iss by Herculezz v1

variable(global) RAObject RAObj
variable bool _AllHere=FALSE
variable int _count

function main(string ZoneName, bool main=TRUE)
{
	;disable debugging
	Script:DisableDebugging
	
	if ${ZoneName.Upper.Equal["EXIT"]} || ${ZoneName.Upper.Equal["END"]}
		Script:End
	echo ISXRI: Starting RA
	
	if ${ZoneName.Equal[""]}
	{
		echo ISXRI: You must enter a zone name, if your zone name has spaces please enclose the entire zone name in ""
		Script:End
	}
	
	if ${main}
	{
		relay all -noredirect RG
		wait 20
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RA "${ZoneName}" FALSE
	}
	
	;first store all members of the group's named
	; variable index:string GroupNames
	
	; variable int count
	; for(count:Set[1];${count}<${Me.GroupCount};count:Inc)
	; {
		; GroupNames:Insert[${Me.Group[${count}].Name}]
		; echo Inserting ${Me.Group[${count}].Name}
	; }
	; echo GroupNames Index has ${GroupNames.Used}

	; for(count:Set[1];${count}<${GroupNames.Used};count:Inc)
	; {
		; echo #${count} of ${GroupNames.Used}: ${Me.Group[${count}].Name}
	; }
	
	while 1
	{
		while ${EQ2.Zoning}!=0
		{
			wait 5
		}
		if ( ${Me.GetGameData[Self.ZoneName].Label.Equal["Qeynos Province District"]} || ${Me.GetGameData[Self.ZoneName].Label.Equal["The City of Freeport"]} ) && ${Actor[Query, Name="Agnostic Portal"].Distance}<45
		{
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			if !${main}
				continue
			;if ${main}
			;	wait 100
			;else 
				wait 100
			; _AllHere:Set[FALSE]
			; while !${_AllHere}
			; {
				; _AllHere:Set[TRUE]
				; for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
				; {
					; if !${Me.Group[${_count}].Health(exists)}
						; _AllHere:Set[FALSE]
				; }
				; wait 10
			; }
			
			if ${EQ2.Zoning}==0 && ( ${Me.GetGameData[Self.ZoneName].Label.Equal["Qeynos Province District"]} || ${Me.GetGameData[Self.ZoneName].Label.Equal["The City of Freeport"]} ) && ${Actor[Query, Name="Agnostic Portal"].Distance}<45
				relay ${RI_Var_String_RelayGroup} -noredirect Actor["Agnostic Portal"]:DoubleClick
			wait 50
			if ${EQ2.Zoning}==0 && ( ${Me.GetGameData[Self.ZoneName].Label.Equal["Qeynos Province District"]} || ${Me.GetGameData[Self.ZoneName].Label.Equal["The City of Freeport"]} ) && ${Actor[Query, Name="Agnostic Portal"].Distance}<45
			{
				RAObj:GetZoneLists
				wait 50
				if ${RAObj.RowByName["${ZoneName}"]}==0
				{
					echo ISXRI: Can't find that zone in the Destination list
					Script:End
				}
				wait 50
				relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:Door[ALL,${RAObj.RowByName["${ZoneName}"]}]
			}
			;echo waiting to zone
			;echo 1
			wait 600 ${EQ2.Zoning}!=0
			;echo 2
			wait 600 ${EQ2.Zoning}==0
			;echo 3
			wait 600 ${Me.GetGameData[Self.ZoneName].Label.Equal["${RAObj.ZoneList.Get[${RAObj.RowByName["${ZoneName}"]}]}"]}
			;echo 4
			
			if ${Me.GetGameData[Self.ZoneName].Label.Equal["${RAObj.ZoneList.Get[${RAObj.RowByName["${ZoneName}"]}]}"]}
			{
				;first check our group and make sure its all the same, if not disband
				;check the size is the same first 
				; if ${Me.GroupCount}!=${Math.Calc[${GroupNames.Used}+1]}
					; RAObj:DisbandAndReInvite[${Main}]
				
				;now check that everyone in group is in groupnames index
				; for(count:Set[1];${count}<${GroupNames.Used};count:Inc)
				; {
					; echo Checking ${Me.Group[${count}].Name} is in Group: ${RAObj.GroupCheck[${Me.Group[${count}].Name}]}
					; if !${RAObj.GroupCheck[${Me.Group[${count}].Name}]}
						; RAObj:DisbandAndReInvite[${Main}]
				; }
				
				; echo we made it this far which means our group is right
				;echo 5
				_AllHere:Set[FALSE]
				while !${_AllHere}
				{
					_AllHere:Set[TRUE]
					for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
					{
						if !${Me.Group[${_count}].Health(exists)}
							_AllHere:Set[FALSE]
					}
					wait 10
				}
				;echo 6
				relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
				if ${main}
				{
					wait 50
					;run runinstances started
					ri
					wait 50
					RI_Var_Bool_Start:Set[TRUE]
					UIElement[Start@RI]:SetText[Pause]
					wait 50
				}
			}
		}
		wait 5
	}
}
atom(global) RA(string what)
{
	if ${what.Upper.Equal[EXIT]} || ${what.Upper.Equal[END]}
		relay ${RI_Var_String_RelayGroup} -noredirect Script[${Script.Filename}]:End
}

objectdef RAObject
{
	variable index:string ZoneList
	variable index:string group
	variable string zone
	variable string currentzone
	method StoreGroup()
	{
		;get group names and sessions numbers 
		;use a method of this to relay all toon name that toon then responds with their session number
		;then wait 5 and do me.Group[2], etc ,etc
	}
	method SetData()
	{
		if ${main}
		{
			;set group
		}
		;set zone, current zone
		relay all RAObj:GetData[${zone},${Zone.Name}]
	}
	method GetData(string _zone, string _currentzone)
	{
		if ${_zone.NotEqual[NULL]} && ${_zone.NotEqual[""]} && ${_zone.NotEqual[LoginScene]}
			zone:Set[${_zone}]
		if ${_currentzone.NotEqual[NULL]} && ${_currentzone.NotEqual[""]} && ${_currentzone.NotEqual[LoginScene]}
			_currentzone:Set[${_currentzone}]
	}
	method GetGroup(... args)
	{
		
	}
	method GetZoneLists()
	{
		if !${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
			return
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
	; member(bool) GroupCheck(string _Name)
	; {
		; variable int _count
		; for(_count:Set[1];${_count}<${GroupNames.Used};_count:Inc)
		; {
			; if ${GroupNames.Get[${_count}].Equal[${_Name}]}
				; return TRUE
		; }
		; return FALSE
	; }
	; method DisbandAndReInvite(bool _Main)
	; {
		; echo Disbanding and Reinviting ${_Main}
	; }
}

function atexit()
{
	echo ISXRI: Ending RA
}