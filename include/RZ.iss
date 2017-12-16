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
variable index:bool ZoneUnlocked
variable index:int ZoneSetTime
variable index:int ZoneUnlockTime
variable(global) bool RZ_Var_Bool_Start=FALSE
variable(global) bool RZ_Var_Bool_Paused=FALSE
variable(global) string RI_Var_String_RZScriptName=${Script.Filename}

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
	_Zone:Insert["Plane of Innovation: Masks of the Marvelous [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Masks of the Marvelous [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Return to Coliseum of Valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-90.543472 2.938255 156.630249]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Masks of the Marvelous [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Masks of the Marvelous [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Return to Coliseum of Valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-90.543472 2.938255 156.630249]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Gears in the Machine [Solo]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Gears in the Machine [Solo]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Return to Coliseum of Valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-90.543472 2.938255 156.630249]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	;Zone
	_Zone:Insert["Plane of Innovation: Gears in the Machine [Heroic]"]
	UIElement[ZonesAvail@RZ]:AddItem["Plane of Innovation: Gears in the Machine [Heroic]"]
	ZoneFrom:Insert["Coliseum of Valor"]
	ZoneTimer:Insert[90]
	ZoneExit:Insert["Return to Coliseum of Valor"]
	ZoneExitPopupSelection:Insert[0]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert["zone_to_poi"]
	ZoneEntranceLoc:Insert[-90.543472 2.938255 156.630249]
	ZonePathFile:Insert[0]
	ZoneUnlocked:Insert[TRUE]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
	return
	
	;Zone
	_Zone:Insert[""]
	UIElement[ZonesAvail@RZ]:AddItem[""]
	ZoneFrom:Insert[""]
	ZoneTimer:Insert[]
	ZoneExit:Insert[""]
	ZoneExitLoc:Insert[]
	ZoneEntrance:Insert[""]
	ZoneEntranceLoc:Insert[]
	ZonePathFile:Insert[]
	ZoneUnlocked:Insert[]
	ZoneSetTime:Insert[0]
	ZoneUnlockTime:Insert[5400]
	
}

function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	;if ${Devel.Equal[TRUE]}
	Developer:Set[TRUE]
	
	variable int Count=1
	variable int _acnt=1
	variable bool JustZone=0
	variable string ZoneName
	variable string ZoneExitActorName
	
	for(_acnt:Set[1];${_acnt}<=${args.Used};_acnt:Inc)
	{
		;echo args ${_acnt} : ${args[${_acnt}]}
		switch ${args[${_acnt}]}
		{
			case -JustZone
			{
				JustZone:Set[1]
				ZoneName:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				ZoneExitActorName:Set["${args[${Math.Calc[${_acnt}+2]}]}"]
				break
			}
		}
	}
	
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
	RZObj:Maximize
	
	UIElement[ExpacComboBox@RZ]:AddItem["Planes of Prophecy"]
	UIElement[ExpacComboBox@RZ]:SelectItem[1]
	call BuildIndexes
	
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
			;call RZObj.CheckZones
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
				echo ISXRI: ${Time}: Succesfully Reset ${_one.Get[${_count}]}
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
	;if we are more than 10 away from EntranceLoc move closer, but check collision and not more than 200 else, call to guild hall and run path to zonein
	;${ZoneEntranceLoc.Get[${_IndexPosition}].Token[1," "]}
	;${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Token[2," "]}+2]}
	;${ZoneEntranceLoc.Get[${_IndexPosition}].Token[3," "]}
	
	if ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}>10 && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[1," "]},${Math.Calc[${ZoneEntranceLoc.Get[${_IndexPosition}].Token[2," "]}+2]},${ZoneEntranceLoc.Get[${_IndexPosition}].Token[3," "]}]} && ${Math.Distance[${Me.Loc},${ZoneEntranceLoc.Get[${_IndexPosition}].Replace[" ",","]}]}<200
		call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 10 0 0 1 1 0 1 1
	else
	{
		call RIMObj.Move 0.199857 6.007895 -0.344092 3 0 0 1 1 0 1 1
		call RIMObj.Move ${ZoneEntranceLoc.Get[${_IndexPosition}]} 10 0 0 1 1 0 1 1
	}
		
	wait 20

	echo ${Time}: Zoning into ${_Zone.Get[${_IndexPosition}]}
	
	;click Zone1 Zone in
	Actor["${ZoneEntrance.Get[${_IndexPosition}]}"]:DoubleClick
	wait 10
	
	
	RZObj:GetZoneLists
	wait 20
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
	method Start()
	{
		UIElement[StartButton@RZ]:SetText[Pause]
		RZ_Var_Bool_Start:Set[1]
		This:Minimize
	}
	method Pause()
	{
		UIElement[StartButton@RZ]:SetText[Resume]
		RZ_Var_Bool_Paused:Set[1]
	}
	method Resume()
	{
		UIElement[StartButton@RZ]:SetText[Pause]
		RZ_Var_Bool_Paused:Set[0]
	}
	method Maximize()
	{
		UIElement[StartButton@RZ]:SetX[535]
		UIElement[StartButton@RZ]:SetX[535]
		UIElement[MinButton@RZ]:SetX[535]
		UIElement[MinButton@RZ]:SetText[Minimize]
		UIElement[RZ]:SetWidth[600]
		UIElement[RZ]:SetHeight[400]
		UIElement[ZonesAvailText@RZ]:Show
		UIElement[ZonesAvail@RZ]:Show
		UIElement[AddedZoneText@RZ]:Show
		UIElement[AddedZoneList@RZ]:Show
		UIElement[ExpacText@RZ]:Show
		UIElement[ExpacComboBox@RZ]:Show
		UIElement[SaveButton@RZ]:Show
		UIElement[LoopListCheckBox@RZ]:Show
		UIElement[InfiniteLoopListCheckBox@RZ]:Show
		UIElement[LoopCountText@RZ]:Show
		UIElement[LoopCountTextEntry@RZ]:Show
	}
	method Minimize()
	{
		UIElement[StartButton@RZ]:SetX[15]
		
		UIElement[MinButton@RZ]:SetX[15]
		UIElement[MinButton@RZ]:SetText[Maximize]
		UIElement[RZ]:SetWidth[80]
		UIElement[RZ]:SetHeight[70]
		UIElement[ZonesAvailText@RZ]:Hide
		UIElement[ZonesAvail@RZ]:Hide
		UIElement[AddedZoneText@RZ]:Hide
		UIElement[AddedZoneList@RZ]:Hide
		UIElement[ExpacText@RZ]:Hide
		UIElement[ExpacComboBox@RZ]:Hide
		UIElement[SaveButton@RZ]:Hide
		UIElement[LoopListCheckBox@RZ]:Hide
		UIElement[InfiniteLoopListCheckBox@RZ]:Hide
		UIElement[LoopCountText@RZ]:Hide
		UIElement[LoopCountTextEntry@RZ]:Hide
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
			for(_count2:Set[1];${_count2}<=${_Zone.Used};_count2:Inc)
			{
				if ${_Zone.Get[${_count2}].Equal["${UIElement[AddedZoneList@RZ].OrderedItem[${_count}]}"]}
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
	}
}