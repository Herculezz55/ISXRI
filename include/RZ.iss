;RunZones v7 by Herculezz

variable index:string Zone
variable index:int ZoneTimer
variable index:string ZoneExit
variable index:string ZoneExitLoc
variable index:int ZoneExitPopupSelection
variable index:string ZoneEntrance
variable index:int ZoneEntrancePopupSelection
variable index:string ZoneEntranceLoc
variable index:string ZonePathFile
variable index:bool ZoneUnlocked
variable index:int ZoneSetTime
variable index:int ZoneUnlockTime
variable(global) bool RZ_Var_Bool_Start=FALSE
variable(global) bool RZ_Var_Bool_Paused=FALSE
variable(global) string RI_Var_String_RZScriptName=${Script.Filename}
variable bool MalduraZone=FALSE

variable bool ResetConfirmation=FALSE
variable(global) RZObject RZObj
variable bool RecentlyAntiAFK=FALSE
variable bool UnableToZone=FALSE
variable bool InstanceExpired=FALSE
variable bool DontEchoExit=FALSE
variable bool Developer=FALSE
variable bool 6HourZones=FALSE

variable int MainArrayCounter
variable index:string istrMain
variable bool Others=FALSE
variable bool StartRZ=TRUE

function BuildIndexes()
{
	;Zone
	Zone:Insert["Arcanna'se Spire: Forgotten Sanctum [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Arcanna'se Spire: Forgotten Sanctum [Heroic]"]
	ZoneFrom:Insert["Thalumbra, the Ever Deep"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert[invis_wall]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["Arcanna'se Spire Portal"]
	ZoneEntranceLoc:Insert[]
	ZonePathFile:Insert[ZoneToArcannase]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	Zone:Insert["Arcanna'se Spire: Repository of Secrets [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Arcanna'se Spire: Repository of Secrets [Heroic]"]
	ZoneFrom:Insert["Thalumbra, the Ever Deep"]
	ZoneTimer:Insert[]
	ZoneExit:Insert["Exit"]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["Arcanna'se Spire Portal"]
	ZoneEntranceLoc:Insert[]
	ZonePathFile:Insert[ZoneToArcannase]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	Zone:Insert["Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]"]
	ZoneFrom:Insert["Thalumbra, the Ever Deep"]
	ZoneTimer:Insert[]
	ZoneExit:Insert["Exit Door Left"]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["Arcanna'se Spire Portal"]
	ZoneEntranceLoc:Insert[]
	ZonePathFile:Insert[ZoneToArcannase]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
}

function PreGo(string _EXTVar)
{
	echo ISXRI: ${Time} Importing ZoneFile from Extension
	istrMain:Clear
	for(MainArrayCounter:Set[0];${MainArrayCounter}<${${_EXTVar}[#]};MainArrayCounter:Inc)
		istrMain:Insert[${${_EXTVar}[${MainArrayCounter}]}]
	echo ISXRI: ${Time} Done Importing ZoneFile from Extension, to Load from File type ImportZoneFile filename.dat (omitting filename.dat, will attempt to load WriteLocs default file for the zone)
}
atom(global) ImportZoneFile(string ZoneFileName="${Me.GetGameData[Self.ZoneName].Label.Replace[" ",""].Replace["'",""].Replace[":",""].Replace["[",,""].Replace["]",""].Replace[",",""]}.dat")
{
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"
	;check if ZineFileName exists, if not end
	if !${FP.FileExists[${ZoneFileName}]}
	{
		echo ISXRI: ${Time} Missing ZoneFile: "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"
		if ${QuestMode}
			Script:End
		else
			return
	}
	else
	{
		echo ISXRI: ${Time} Loading ZoneFile: "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"
	}
	
	variable file Filename
	variable int Count
	
	variable string TempString
	istrMain:Clear
	Count:Set[1]
	;set file to read in to Filename variable
	Filename:SetFilename["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"]

	;open the file
	Filename:Open
	
	;seek to the beginning of file
	Filename:Seek[0]
	
	;while we are not at the end of file
	while !${Filename.EOF}
	{
		;store each line of the file in var
		TempString:Set[${Filename.Read}]
		if ${TempString.Equal[NULL]}
			continue
		istrMain:Insert[${TempString.Left[-1]}]
		;echo Adding ${istrMain.Get[${Count}]} to istrMain Variable in Element ${Count} : Length ${istrMain.Get[${Count}].Length}
		Count:Inc
		;waitframe
	}
	
	;close file
	Filename:Close
	
	echo ISXRI: ${Time} Done Loading ZoneFile
}
function StartR(string _r)
{
	relay all -noredirect RG
	wait 20
	relay "other ${RI_Var_String_RelayGroup}" rz -${_r} -others
}
function RunK()
{
	if !${Others}
		call StartR rk

	if ${KaesoraEntrance[1](exists)}
		call PreGo "KaesoraEntrance"
	else
		ImportZoneFile "KaesoraEntrance.dat"
	
	call CheckNearStart "Fens of Nathsar"
	
	
	variable bool _AllHere
	_AllHere:Set[FALSE]
	
	variable int _count
	while !${_AllHere}
	{
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		wait 2
	}
	wait 10

	call follow

	wait 20

	;echo ${istrMain.Used}
	for(_count:Set[1];${_count}<=${istrMain.Used};_count:Inc)
	{
		;echo ${_count}: call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		
		waitframe
	}
	call Move ${istrMain.Get[${istrMain.Used}]} 2 0 1 1 1 0

	wait 20 

	call FlyDown

	Script:End
}
function TravelMap(string _ZoneToZoneName, int _ZoneOption=0, int _BellWizardDruid=0)
{
	;echo TravelMap(string _ZoneToZoneName=${_ZoneToZoneName}, int _ZoneOption=${_ZoneOption}, int _BellWizardDruid=${_BellWizardDruid})
	if !${Actor[Query, Name=="Ole Salt's Mariner Bell" && Distance<=13](exists)} && !${Actor[Query, Name=="Navigator's Globe of Norrath" && Distance<=13](exists)} && !${Actor[Query, Name=="Pirate Captain's Helmsman" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
	{
		MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Travel Bell within 13"
		Script:End
	}
	
	if ${_BellWizardDruid}==0
	{
		Actor[mariners_bell]:DoubleClick
		Actor[mariner_bell_city_travel_qeynos]:DoubleClick
		Actor[zone_to_guildhall_tier3]:DoubleClick
		Actor[Zone to Friend]:DoubleClick
		Actor[flight_cloud_large_1_to_medium_1]:DoubleClick
		Actor[mariner_bell_city_travel_freeport]:DoubleClick
		Actor["Ole Salt's Mariner Bell"]:DoubleClick
		Actor["Navigator's Globe of Norrath"]:DoubleClick
		Actor["Pirate Captain's Helmsman"]:DoubleClick
		wait 10
	}
	elseif ${_BellWizardDruid}==1
	{
		Actor["Large Ulteran Spire"]:DoubleClick
		wait 10
	}
	elseif ${_BellWizardDruid}==2
	{
		Actor[guild,"Guild Portal Druid"]:DoFace
		Actor[guild,"Guild Portal Druid"]:DoTarget
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 20
	}
	RIMUIObj:TravelMap[${Me.Name},${_ZoneToZoneName},${_ZoneOption}]
	wait 600 ${EQ2.Zoning}==1
	wait 600 ${EQ2.Zoning}==0
	wait 600 ${Zone.Name.Find[${_ZoneToZoneName}](exists)}
	wait 10
}
function CheckNearStart(string _ZoneToZoneName, int _ZoneOption=0, int _BellWizardDruid=0)
{
	if ${Math.Distance[${Me.Loc},${istrMain.Get[1].Replace[" ",","]}]}>50 
;|| ${EQ2.CheckCollision[${Me.Loc},${istrMain.Get[1].Replace[" ",","]}]}
	{
		if !${Zone.ShortName.Find[guildhall](exists)}
		{
			while ${Me.Ability[Call to Guild Hall].IsReady}
			{
				Me.Ability[Call to Guild Hall]:Use
				wait 5
			}
		
			wait 600 ${EQ2.Zoning}==1
			wait 600 ${EQ2.Zoning}==0
			wait 600 ${Zone.ShortName.Find[guildhall](exists)}
			wait 10
			if !${Zone.ShortName.Find[guildhall](exists)}
			{
				MessageBox -skin eq2 "We attempted to Call to Guild Hall but did not end up in the Guild Hall"
				Script:End
			}
		}
		if !${Actor[Query, Name=="Ole Salt's Mariner Bell" && Distance<=13](exists)} && !${Actor[Query, Name=="Navigator's Globe of Norrath" && Distance<=13](exists)} && !${Actor[Query, Name=="Pirate Captain's Helmsman" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
		{
			MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Travel Bell within 13"
			Script:End
		}
		
		call TravelMap "${_ZoneToZoneName}" ${_ZoneOption} ${_BellWizardDruid}

		;move to QuestGiver, check which dock we are on first
		if !${Zone.Name.Find[${_ZoneToZoneName}](exists)}
		{
			MessageBox -skin eq2 "We were unable to succesfully zone to ${_ZoneToZoneName}, please try again or zone there manually"
			Script:End
		}
	}
	if ${Others}
		Script:End
}

atom(global) displayindex()
{
	variable int counter
	for(counter:Set[1];${counter}<=${istrMain.Used};counter:Inc)
	{
		echo ${counter}: ${istrMain.Get[${counter}]}
	}
}
function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	;if ${Devel.Equal[TRUE]}
	Developer:Set[TRUE]
	
	variable int Count=1
	variable int ArgCount=1
	variable bool RunK=FALSE
	variable bool RunC=FALSE
	variable bool RunL=FALSE
	while ${ArgCount} <= ${args.Used}
	{
		switch ${args[${ArgCount}]}
		{
			case -rk
				RunK:Set[TRUE]
				break
			case -rc
				RunC:Set[TRUE]
				break
			case -rl
				RunL:Set[TRUE]
				break
			case -others
				Others:Set[TRUE]
				break
			default
				break
		}
		ArgCount:Inc
	}
	if ${RunK}
		call RunK
	if ${RunC}
		call RunC
	if ${RunL}
		call RunL		
	;echo ${Zones} // ${Exclusions} // ${JustZone} // ${ZoneExitActorName} // ${ZoneName}
	if ${JustZone}
	{
		echo Zoning Out of "${ZoneName}" using "${ZoneExitActorName}"
		call ZoneOut "${ZoneExitActorName}" "${ZoneName}"
		DontEchoExit:Set[TRUE]
		Script:End
		;echo done zoning out
	}

	echo ISXRI: ${Time}: Starting RZ
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml"
	
	UIElement[ExpacComboBox@RZ]:AddItem["Kunark Ascending"]
	UIElement[ExpacComboBox@RZ]:SelectItem[1]
	call BuildIndexes
	
	;wait 787878787
	
	;set zones checked
	;UIElement[RunZ1@RZ]:SetChecked
	;UIElement[RunZ2@RZ]:SetChecked
	;UIElement[RunZ3@RZ]:SetChecked
	;UIElement[RZ]:SetHeight[160]
	
	;start RIMovement if it is not running
	relay all -noredirect ${If[!${Script[Buffer:RIMovement](exists)},RIMovement,noop]}
	
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
	
	;main loop
	while 1
	{
		;if we are not zoning
		if ${EQ2.Zoning}==0
		{
			;if Zone is unlocked run it
			
			for(Count:Set[1];${Count}<=${UIElement[AddedZoneList@RZ].Items};Count:Inc)
			{
				echo checking if ${UIElement[AddedZoneList@RZ].OrderedItem[${Count}]} at ${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${Count}]}"]} is unlocked: ${ZoneUnlocked.Get[${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${Count}]}"]}]}
				;if ${ZoneUnlocked.Get[${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${Count}]}"]}]}
				;	call Zone ${RZObj.ZoneIndexPosition["${UIElement[AddedZoneList@RZ].OrderedItem[${Count}]}"]}
			}
			
			;call CheckZones function
			call RZObj.CheckZones
			wait 50
		}
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
		for(_count:Set[1];${_count}<=${Zone.Used};_count:Inc)
		{
			if ${Text.Find["${Zone.Get[${_count}]}"]}
			{
				echo ISXRI: ${Time}: Setting ${Zone.Get[${_count}]} zone reuse timer to: ${Time.SecondsSinceMidnight} Seconds since midnight
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
		for(_count:Set[1];${_count}<=${Zone.Used};_count:Inc)
		{
			if ${Text.Find["${Zone.Get[${_count}]}"]}
			{
				echo ISXRI: ${Time}: Succesfully Reset ${Zone.Get[${_count}]}
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
	;if we are more than // away from EntranceLoc move closer, but check collision and not more than 200 else, call to guild hall and run path to zonein
	if ${MalduraZone}
		call MalduraFinder "${Zone1}"
	elseif ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Replace[" ",","]}]}>
		call Move ${ZoneEntranceLoc} 1 0 0 1 1 0 1 1
		
	wait 20

	echo ${Time}: Zoning into ${Zone.Get[${_IndexPosition}]}
	
	;click Zone1 Zone in
	Actor["${ZoneEntrance.Get[${_IndexPosition}]}"]:DoubleClick
	wait 10
	
	
	RZObj:GetZoneLists
	wait 20
	if ${RZObj.RowByName["${Zone.Get[${_IndexPosition}]}"]}==0
	{
		echo ISXRI: Can't find that zone in the Destination list
		Script:End
	}
	wait 10
	EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${RZObj.RowByName["${Zone.Get[${_IndexPosition}]}"]}]
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
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${Zone.Get[${_IndexPosition}]}"]}
		return
		
	;run runinstances started
	ri
	wait 50
	RI_Var_Bool_Start:Set[TRUE]
	UIElement[Start@RI]:SetText[Pause]
	wait 50
	
	;while runinstances is running wait
	while ${Script[Buffer:RunInstances](exists)}
		wait 20
	wait 10
	
	;if we are not a developer and all zones first runs are done, exit script
	; if !${Developer} && ${Zone1FirstRunDone} && ${Zone2FirstRunDone} && ${Zone3FirstRunDone}
	; {
		; echo ${Time}: Full set complete please rerun rz
		; Script:End
	; }
	
	;wait until we have a zone open so we stay hidden.
	if !${RZObj.CheckAllZonesUnlocked}
		echo ${Time}: No Zones are Unlocked, Waiting to Zone Out
		
	while !${RZObj.CheckAllZonesUnlocked}
	{
		echo ISXRI: ${Time}: Waiting until a zone is unlocked

		;call CheckZones function
		call RZObj.CheckZones

		wait 50
	}
	
	;if we are more than // away from zone exit
	if ${Math.Distance[${Me.Loc},${ZoneExitLoc.Replace[" ",","]}]}>
		call Move ${ZoneExitLoc} 1 0 0 1 1 0 1 1
	
	wait 20
	
	;zoneout
	;relay "other ${RI_Var_String_RelayGroup}" -noredirect RZ 0 0 TRUE "${Zone1Exit}" "${Zone1}"
	call ZoneOut "${ZoneExit.Get[${_IndexPosition}]}" "${Zone.Get[${_IndexPosition}]}"
}

function ZoneOut(string ZoneExit, string ZoneName)
{
	;while we are not zoning and in ${Zone} keep clicking the exit
	relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
	wait 5
	;select row 1
	relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[1]
	wait 5
	;confirm selection and zone
	relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	wait 20
	while !${EQ2.Zoning} && ${Me.GetGameData[Self.ZoneName].Label.Equal["${ZoneName}"]}
	{
		relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
		wait 10
		if ${EQ2.Zoning}==0
		{
			if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
			{
				;select row 1
				relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[1]
				wait 5
				;confirm selection and zone
				relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
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
	member:int ZoneIndexPosition(string _ZoneName)
	{
		variable int _count2
		;find the zone in our index's
		for(_count2:Set[1];${_count2}<=${Zone.Used};_count2:Inc)
		{
			if ${Zone.Get[${_count2}].Equal["${_ZoneName}"]}
			{
				return ${_count2}
			}
		}
		return 0
	}
	method AddZone(string _ZoneName)
	{
		echo ${_ZoneName}
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
			for(_count2:Set[1];${_count2}<=${Zone.Used};_count2:Inc)
			{
				if ${Zone.Get[${_count2}].Equal["${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}"]}
				{
					;echo Checking ${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]} is Unlocked: ${RZObj.Unlocked[${ZoneSetTime.Get[${_count2}]}]} && ${ZoneSetTime.Get[${_count2}]}!=0
					if !${ZoneUnlocked.Get[${_count2}]} && ${ZoneSetTime.Get[${_count2}]}!=0
					{
						echo ISXRI: ${Time}: ${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}, Unlocked: ${RZObj.Unlocked[${ZoneSetTime.Get[${_count2}]}]}
						if ${RZObj.Unlocked[${ZoneSetTime.Get[${_count2}]}]}
							call RZObj.Unlock "${Zone.Get[${_count2}]}"
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
			for(_count2:Set[1];${_count2}<=${Zone.Used};_count2:Inc)
			{
				if ${Zone.Get[${_count2}].Equal["${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}"]}
				{
					if !${ZoneUnlocked.Get[${_count2}]}
						_AllUnLocked:Set[FALSE]
				}
			}
		}
		return ${_AllUnLocked}
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
	call RIFollow
	wait 5
	echo ${Time}: Moving to ${X1} ${Z1}
	
	;set lock spot to X1 Z1
	RI_Atom_SetLockSpot ${Me.Name} ${X1} 0 ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>3
	{
		waitframe
	}
}
function MoveNF3(float X1, float Y1, float Z1)
{
	;wait 20

	;start group following
	;call RIFollow
	;wait 5
	;echo ${Time}: Moving to ${X1} ${Y1} ${Z1}
	
	;set lock spot to X1 Y1 Z1
	RI_Atom_SetLockSpot ${Me.Name} ${X1} ${Y1} ${Z1}
	while ${Math.Distance[${Me.Loc},${X1},${Y1},${Z1}]}>2
	{
		wait 1
	}
}
function MalduraFinder(string ZoneTo)
{
	echo ISXRI: Going To: ${ZoneTo}
	if ${ZoneTo.Find[Bar](exists)}
	{
		;i am at District
		if ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}<15
		{
			echo ISXRI: Moving From: Maldura: District of Ash [Heroic]
			call MoveFromDistrictToBB
		}
		;i am at Alg
		if ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}<15
		{
			echo ISXRI: Moving From: Maldura: Algorithm for Destruction [Heroic]
			call MoveFromAlgToBB
		}
		;i am at Palace
		if ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}<15
		{
			echo ISXRI: Moving From: Maldura: Palace Foray [Event Heroic]
			call MoveFromPalaceToBB
		}
	}
	elseif ${ZoneTo.Find[Algorithm](exists)}
	{
		;i am at District
		if ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}<15
		{
			echo ISXRI: Moving From: Maldura: District of Ash [Heroic]
			call MoveFromDistrictToAlg
		}
		;i am at BB
		if ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}<15
		{
			echo ISXRI: Moving From: Maldura: Bar Brawl [Event Heroic]
			call MoveFromBBToAlg
		}
		;i am at Palace
		if ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}<15
		{
			echo ISXRI: Moving From: Maldura: Palace Foray [Event Heroic]
			call MoveFromPalaceToAlg
		}
	}
	elseif ${ZoneTo.Find[District](exists)}
	{
		;i am at BB
		if ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}<15
		{
			echo ISXRI: Moving From: Maldura: Bar Brawl [Event Heroic]
			call MoveFromBBToDistrict
		}
		;i am at Alg
		if ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}<15
		{
			echo ISXRI: Moving From: Maldura: Algorithm for Destruction [Heroic]
			call MoveFromAlgToDistrict
		}
		;i am at Palace
		if ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}<15
		{
			echo ISXRI: Moving From: Maldura: Palace Foray [Event Heroic]
			call MoveFromPalaceToDistrict
		}
	}
	elseif ${ZoneTo.Find[Palace](exists)}
	{
		;i am at District
		if ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}<15
		{
			echo ISXRI: Moving From: Maldura: District of Ash [Heroic]
			call MoveFromDistrictToPalace
		}
		;i am at Alg
		if ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}<15
		{
			echo ISXRI: Moving From: Maldura: Algorithm for Destruction [Heroic]
			call MoveFromAlgToPalace
		}
		;i am at BB
		if ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}<15
		{
			echo ISXRI: Moving From: Maldura: Bar Brawl [Event Heroic]
			call MoveFromBBToPalace
		}
	}
}
function MoveFromBBToAlg()
{
	call MoveFromBBToCenterEast
	call MoveFromCenterEastToAlgorithm
}
function MoveFromBBToDistrict()
{
	call MoveFromBBToCenterEast
	call MoveFromCenterEastToDistrict
}
function MoveFromBBToPalace()
{
	call MoveFromBBToCenterEast
	call MoveFromCenterEastToCenterWest
	call MoveFromCenterWestToPalace
}
function MoveFromAlgToBB()
{
	call MoveFromAlgorithmToCenterEast
	call MoveFromCenterEastToBB
}
function MoveFromAlgToDistrict()
{
	call MoveFromAlgorithmToCenterEast
	call MoveFromCenterEastToDistrict
}
function MoveFromAlgToPalace()
{
	call MoveFromAlgorithmToCenterWest
	call MoveFromCenterWestToPalace
}
function MoveFromDistrictToBB()
{
	call MoveFromDistrictToCenterEast
	call MoveFromCenterEastToBB
}
function MoveFromDistrictToAlg()
{
	call MoveFromDistrictToCenterWest
	call MoveFromCenterWestToAlgorithm
}
function MoveFromDistrictToPalace()
{
	call MoveFromDistrictToCenterWest
	call MoveFromCenterWestToPalace
}
function MoveFromPalaceToAlg()
{
	call MoveFromPalaceToCenterWest
	call MoveFromCenterWestToAlgorithm
}
function MoveFromPalaceToDistrict()
{
	call MoveFromPalaceToCenterWest
	call MoveFromCenterWestToDistrict
}
function MoveFromPalaceToBB()
{
	call MoveFromPalaceToCenterWest
	call MoveFromCenterWestToCenterEast
	call MoveFromCenterEastToBB
}
function MoveFromCenterWestToCenterEast()
{
	call MoveNF3 -96.561684 1.333169 2.435470
	call MoveNF3 -101.754234 1.333471 11.028763
	call MoveNF3 -111.592079 1.333889 13.133477
	call MoveNF3 -118.659782 1.333385 5.781046
	call MoveNF3 -119.749695 1.333358 0.398619
}
function MoveFromBBToCenterEast()
{
	call MoveNF3 -74.987793 8.953678 121.594414
	call MoveNF3 -84.854172 8.741453 119.465195
	call MoveNF3 -94.254158 7.550994 115.606918
	call MoveNF3 -102.937462 5.106602 111.125481
	call MoveNF3 -111.784805 2.941614 106.436958
	call MoveNF3 -119.963387 0.421129 101.066185
	call MoveNF3 -127.897781 -2.980700 95.388550
	call MoveNF3 -135.921967 -4.219001 89.157715
	call MoveNF3 -142.551773 -7.624911 82.107994
	call MoveNF3 -147.927673 -8.031591 73.413498
	call MoveNF3 -153.103882 -7.718341 64.181427
	call MoveNF3 -157.727295 -7.699974 54.570038
	call MoveNF3 -161.447632 -7.545240 45.128490
	call MoveNF3 -165.033966 -7.571215 35.616474
	call MoveNF3 -167.568115 -7.745778 25.339172
	call MoveNF3 -168.498322 -7.555120 15.165951
	call MoveNF3 -165.485611 -6.921866 5.490453
	call MoveNF3 -157.057266 -6.081460 -0.326506
	call MoveNF3 -147.792191 -1.905953 -1.152804
	call MoveNF3 -137.853607 -1.811615 0.231563
	call MoveNF3 -128.031769 0.868079 0.545507
	call MoveNF3 -119.745110 1.333356 0.574359

}
function MoveFromDistrictToCenterEast()
{
	call MoveNF3 -107.588409 1.464843 -45.882183
	call MoveNF3 -107.518822 1.544127 -35.855019
	call MoveNF3 -107.688492 1.544120 -25.837738
	call MoveNF3 -109.189613 1.483117 -15.816957
	call MoveNF3 -115.078377 1.332909 -7.555491
	call MoveNF3 -119.443909 1.333226 1.046711
}
function MoveFromDistrictToCenterWest()
{
	call MoveNF3 -108.110458 1.527551 -46.323360
	call MoveNF3 -106.414383 1.544125 -36.299629
	call MoveNF3 -106.109436 1.544121 -26.292387
	call MoveNF3 -105.414413 1.494619 -16.239443
	call MoveNF3 -100.335434 1.333001 -7.507511
	call MoveNF3 -96.269058 1.333248 1.470333
}
function MoveFromAlgorithmToCenterEast()
{
	call MoveNF3 -107.899620 1.360249 45.699463
	call MoveNF3 -108.552261 1.541995 35.522964
	call MoveNF3 -109.209106 1.519127 25.540161
	call MoveNF3 -110.352814 1.498703 15.539167
	call MoveNF3 -115.465210 1.332481 6.891775
	call MoveNF3 -118.796013 1.332946 0.674744
}
function MoveFromAlgorithmToCenterWest()
{
	call MoveNF3 -107.932632 1.547165 48.023392
	call MoveNF3 -107.219864 1.541990 38.003262
	call MoveNF3 -107.019325 1.541988 27.986483
	call MoveNF3 -105.920990 1.511162 17.820841
	call MoveNF3 -101.354004 1.332714 8.708767
}
function MoveFromPalaceToCenterWest()
{
	call MoveNF3 192.761948 63.795761 -1.046231
	call MoveNF3 182.744354 63.796738 -1.104314
	call MoveNF3 172.533356 63.807709 -1.117245
	call MoveNF3 162.307053 63.759064 -1.130196
	call MoveNF3 152.353470 61.701675 -1.142801
	call MoveNF3 142.112000 62.258053 -1.155771
	call MoveNF3 131.933136 62.177505 -1.069386
	call MoveNF3 121.778931 61.686459 -0.333621
	call MoveNF3 111.776169 61.630856 0.395978
	call MoveNF3 101.758301 61.337959 1.126680
	call MoveNF3 91.891518 59.751373 1.846360
	call MoveNF3 82.033752 57.700142 1.369395
	call MoveNF3 72.557419 54.833401 -0.610031
	call MoveNF3 62.993145 51.995277 -2.612994
	call MoveNF3 53.409676 49.945824 -5.118948
	call MoveNF3 42.956539 49.320534 -6.211683
	call MoveNF3 33.878460 45.383678 -3.559703
	call MoveNF3 25.548120 41.218243 0.104685
	call MoveNF3 15.825115 38.574142 -0.653403
	call MoveNF3 6.605190 34.685101 -0.850443
	call MoveNF3 -2.450275 30.065004 -0.597008
	call MoveNF3 -11.413877 25.637964 -0.291770
	call MoveNF3 -21.304764 22.576492 -0.124891
	call MoveNF3 -30.864052 19.224083 -0.041291
	call MoveNF3 -40.241554 14.907271 0.040719
	call MoveNF3 -49.194870 10.069301 0.119020
	call MoveNF3 -58.890507 6.697672 0.203812
	call MoveNF3 -68.843689 4.274456 0.290857
	call MoveNF3 -79.054451 4.087050 0.373791
	call MoveNF3 -89.248512 3.231163 0.289442
	call MoveNF3 -96.261322 1.333251 0.441733
}
function MoveFromCenterEastToDistrict()
{
	call MoveNF3 -118.796013 1.332946 0.674744
	call MoveNF3 -114.393547 1.332971 -8.334318
	call MoveNF3 -109.788170 1.527551 -17.528275
	call MoveNF3 -107.456436 1.544124 -27.415716
	call MoveNF3 -107.164772 1.544123 -37.508636
	call MoveNF3 -107.588409 1.464843 -45.882183
}
function MoveFromCenterEastToAlgorithm()
{
	call MoveNF3 -118.328964 1.333039 4.647811
	call MoveNF3 -111.849747 1.333648 12.492848
	call MoveNF3 -106.485893 1.360261 21.116299
	call MoveNF3 -105.274956 1.541993 31.181787
	call MoveNF3 -107.614853 1.527540 40.921227
	call MoveNF3 -107.899620 1.360249 45.699463
}
function MoveFromCenterEastToBB()
{
	call MoveNF3 -122.441010 1.498703 0.474294
	call MoveNF3 -132.529449 -0.415226 0.004875
	call MoveNF3 -142.639618 -1.857636 0.256313
	call MoveNF3 -152.627243 -4.049346 0.725432
	call MoveNF3 -162.461166 -6.586624 1.333190
	call MoveNF3 -168.980423 -6.933326 9.138783
	call MoveNF3 -168.672958 -7.888989 19.327946
	call MoveNF3 -165.479126 -7.616230 29.035858
	call MoveNF3 -162.259827 -7.072036 38.660103
	call MoveNF3 -159.025543 -7.545322 48.329437
	call MoveNF3 -154.942352 -7.718052 57.696407
	call MoveNF3 -150.388641 -7.718277 66.852715
	call MoveNF3 -145.427628 -7.842994 75.837799
	call MoveNF3 -139.628647 -6.933485 84.238777
	call MoveNF3 -132.694412 -3.029800 90.384697
	call MoveNF3 -124.822319 -2.584181 96.839294
	call MoveNF3 -117.498993 1.587271 102.223701
	call MoveNF3 -108.872444 4.243935 106.902153
	call MoveNF3 -100.000893 5.106598 111.580147
	call MoveNF3 -91.437553 8.659725 116.095612
	call MoveNF3 -82.293884 8.574335 120.176414
	call MoveNF3 -72.427734 9.132478 121.798759
	call MoveNF3 -68.632019 9.525129 118.591179
}
function MoveFromCenterWestToDistrict()
{
	call MoveNF3 -96.655060 1.333081 0.716211
	call MoveNF3 -101.269440 1.333009 -8.378657
	call MoveNF3 -106.372986 1.527551 -17.175358
	call MoveNF3 -108.776642 1.544123 -27.055979
	call MoveNF3 -108.344147 1.544124 -37.177406
	call MoveNF3 -107.588409 1.464843 -45.882183
}
function MoveFromCenterWestToAlgorithm()
{
	call MoveNF3 -96.966721 1.333022 2.642747
	call MoveNF3 -102.270111 1.333547 11.541652
	call MoveNF3 -106.911255 1.360490 20.586712
	call MoveNF3 -108.066223 1.541993 30.541306
	call MoveNF3 -107.957497 1.528404 40.872646
	call MoveNF3 -107.899620 1.360249 45.699463
}
function MoveFromCenterWestToPalace()
{
	call MoveNF3 -96.564697 1.333120 0.045436
	call MoveNF3 -86.925285 4.021127 0.132103
	call MoveNF3 -76.545097 4.087046 0.194072
	call MoveNF3 -66.379692 4.826190 0.145704
	call MoveNF3 -56.623211 7.378497 0.099282
	call MoveNF3 -47.063675 11.035548 0.053797
	call MoveNF3 -37.988934 16.053326 0.010618
	call MoveNF3 -28.535440 20.128014 -0.034362
	call MoveNF3 -18.703203 23.377699 -0.081145
	call MoveNF3 -9.098212 26.810278 -0.126846
	call MoveNF3 0.097734 31.404289 -0.170601
	call MoveNF3 9.263380 35.987278 -0.214212
	call MoveNF3 18.747171 39.928371 -0.259337
	call MoveNF3 28.539454 42.695728 -1.256736
	call MoveNF3 37.373001 46.593834 -4.018705
	call MoveNF3 46.676357 49.742569 -6.095671
	call MoveNF3 56.641201 50.857754 -5.265169
	call MoveNF3 66.335556 52.678940 -3.540220
	call MoveNF3 75.752686 56.332909 -1.728288
	call MoveNF3 85.668022 58.539101 -0.444260
	call MoveNF3 95.690346 60.553802 0.539063
	call MoveNF3 105.837959 61.560116 0.406833
	call MoveNF3 115.968864 61.630840 0.105912
	call MoveNF3 126.283028 61.686424 -0.135682
	call MoveNF3 136.568420 62.258053 -0.305492
	call MoveNF3 146.581207 62.197403 -0.470801
	call MoveNF3 156.684799 61.701645 -0.637610
	call MoveNF3 166.576431 63.878624 -0.800918
	call MoveNF3 176.770905 63.808289 -0.972683
	call MoveNF3 186.842346 63.796539 -1.155712
	call MoveNF3 197.021561 63.791595 -0.978441
	call MoveNF3 202.524216 66.070686 -1.015480
}
function MoveFromCenterEastToCenterWest()
{
	call MoveNF3 -119.443909 1.333226 1.046711
	call MoveNF3 -114.377823 1.333057 9.698290
	call MoveNF3 -104.747360 1.333647 12.699495
	call MoveNF3 -98.039307 1.332917 5.236200
	call MoveNF3 -96.564697 1.333120 0.045436
}
function RIFollow()
{
	echo ${Time}: Setting RIFollow

	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} 1 100
}
function atexit()
{
	if !${DontEchoExit}
	{
		echo ISXRI: ${Time}: Ending RZ
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml"
	}
}