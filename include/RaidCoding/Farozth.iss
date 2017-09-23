;Farozth v1 by Herculezz

;need to code it to turn off absorb magic and cast it when its up.


variable(global) string CurseName
variable(global) bool RecentlyCured=FALSE
variable(global) bool Trigger=FALSE
variable(global) string RI_Var_String_Version=Farozth
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ssraeshza Temple: Echoes of Time [Raid]"]} || ${Math.Distance[${Me.Loc},61.5,-11.99,-151.69]}>100
	{
		echo ${Time}: You must be in Ssraeshza Temple: Echoes of Time [Raid] and within 100 distance of 61.5,-11.99,-151.69 to run this script.
		Script:End
	}

	echo ${Time}: Starting Farozth v1
	
	;disable debugging
	Script:DisableDebugging
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	UIElement[Start@RI]:SetText[Pause]
	UIElement[AutoLoot@RI]:Hide
	UIElement[RI]:SetHeight[40]
	
	;start RaidRelayGroup
	RRG
	
	;stop ogres movement if ogre exists so we can take control
	if ${ISXOgre(exists)}
	{
		OgreBotAtom a_LetsGo all
		OgreBotAtom a_QueueCommand DoNotMove
	}
	;start RIMovement
	if !${Script[Buffer:RIMovement]}
		RIMovement
		
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;disable cure curse
	RI_CMD_AbilityEnableDisable "Cure Curse" 0
	
	if ${Me.Archetype.Equal[fighter]}
		call MoveC 71 -168
	else
		call MoveC 61.5 -151.69
	while ${Me.GetGameData[Self.ZoneName].Label.Equal["Ssraeshza Temple: Echoes of Time [Raid]"]} && ${Math.Distance[${Me.Loc},61.5,-11.99,-151.69]}<100
	{
		;Me:InitializeEffects
		wait 5
		if ${Me.Effect[detrimental,"Scaled Vengeance"](exists)} && !${RecentlyCured}
		{
			eq2ex r Need a Cure Curse!
			RecentlyCured:Set[TRUE]
			TimedCommand 15 RecentlyCured:Set[FALSE]
		}
		;if ${Me.Archetype.Equal[dirge]} && ${Trigger}
			;call MoveOut
		if ${Me.Archetype.Equal[fighter]} && ${Trigger} && ${Actor[Farozth].Target.ID}!=${Me.ID}
			call MoveOut
		else
			Trigger:Set[FALSE]
		;elseif ${Me.Archetype.NotEqual[fighter]} && ${Trigger}
			;call MoveOut
	}
}
function MoveOut()
{
	;Actor[Farozth]:DoTarget
	if ${Me.Archetype.Equal[fighter]}
		call MoveC 90 -158
	else
		call MoveC 54 -143
	;OgreBotAtom a_CastFromUplink All "Absorb Magic"
	wait 50
	if ${Me.Archetype.Equal[fighter]}
		call MoveC 71 -168
	else
		call MoveC 66 -158
	;Actor[Farozth]:DoTarget
	Trigger:Set[FALSE]
}
function MoveC(float X1, float Z1)
{
	RI_Atom_SetLockSpot ${Me.Name} ${X1} 0 ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>2
	{
		wait 1
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["prepares to release scaled vengeance upon anyone near to his location!"](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		Trigger:Set[TRUE]
	}
}
function atexit()
{
	echo ${Time}: Ending Farozth
	
	;enable cure curse
	RI_CMD_AbilityEnableDisable "Cure Curse" 1
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}