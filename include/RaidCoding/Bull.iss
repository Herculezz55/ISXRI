;Bull v3 by Herculezz
variable(global) string RI_Var_String_Version=Bull

atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["F.S. Distillery: Beggars and Blighters [Raid]"]} || ${Math.Distance[${Me.Loc},6.81,-100.98,-6.51]}>50
	{
		echo ${Time}: You must be in F.S. Distillery: Beggars and Blighters [Raid] and within 50 distance of 6.81,-100.98,-6.51 to run this script.
		Script:End
	}

	echo Starting Bull v3
	
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
	
	;events
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncement]
	
	;turn on move into melee and move behind for non fighters
	;OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_movemelee TRUE
	if ${Me.Archetype.NotEqual[fighter]}
		RI_Atom_MoveBehind ${Me.Name} ${Actor["Bull McCleran"].ID} 100 99
		
	;main loop
	while ${Actor["Bull McCleran"](exists)} && !${Actor["Bull McCleran"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["F.S. Distillery: Beggars and Blighters [Raid]"]} && ${Math.Distance[${Me.Loc},6.81,-100.98,-6.51]}<50
	{
		wait 5
	}
}

;atom triggered when an announcement is detected
atom EQ2_onAnnouncement(string Message, string SoundType, float Timer)
{
	;if massive backlash exists in the announce, move in front for XXs then for fighters move back behind
	if ${Message.Find["massive backlash"](exists)}
	{
		echo ${Time}: Moving In Front
		;OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_movemelee TRUE
		;OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_movebehind FALSE
		RI_Atom_MoveInFront ${Me.Name} ${Actor["Bull McCleran"].ID} 100 99
		if ${Me.Archetype.NotEqual[fighter]}
			TimedCommand 80 RI_Atom_MoveBehind ${Me.Name} ${Actor["Bull McCleran"].ID} 100 99
		;TimedCommand 20 OgreBotAtom a_CastFromUplink ${Me.Name} "Call Servant" TRUE
	}
	;elseif massive smash exists in the announce, move behind for XXs then for fighters move back in front
	elseif ${Message.Find["massive smash"](exists)}
	{
		echo ${Time}: Moving Behind
		RI_Atom_MoveBehind ${Me.Name} ${Actor["Bull McCleran"].ID} 100 99
		;OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_movemelee TRUE
		;OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_movebehind TRUE
		;OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_moveinfront FALSE
		if ${Me.Archetype.Equal[fighter]}
			TimedCommand 80 RI_Atom_MoveInFront ${Me.Name} ${Actor["Bull McCleran"].ID} 100 99
		;TimedCommand 20 OgreBotAtom a_CastFromUplink ${Me.Name} "Call Servant" TRUE
	}
}

function atexit()
{
	echo Ending Bull
	if ${Script[Buffer:RIMovement]}
	{
		RI_Atom_MoveBehind ALL OFF
		RI_Atom_MoveInFront ALL OFF
	}
}