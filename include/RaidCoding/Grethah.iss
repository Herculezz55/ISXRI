;Grethah v6 by unknown, rewritten by Herculezz
variable bool Stopped=FALSE
variable bool Started=FALSE
variable(global) string RI_Var_String_Version=Grethah
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Castle Highhold: No Quarter [Raid]"]} || ${Math.Distance[${Me.Loc},89.02,-109.40,75.60]}>100
	{
		echo ${Time}: You must be in Castle Highhold: No Quarter [Raid] and within 100 distance of 89.02,-109.40,75.60 to run this script.
		Script:End
	}
	echo ${Time}: Starting Grethah v6
	
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
	
    ;turn off reses
	if ${Me.Archetype.Equal[priest]} || ${Me.Archetype.Equal[scout]}
		RI_CMD_AbilityTypeEnableDisable RES 0
	
	;events
	Event[EQ2_onIncomingText]:AttachAtom[joust]
	
	;turn on lockspot to 89.02,-109.40,75.60 or 86.78,-109.29,80.23 if fighters
	RI_Atom_SetLockSpot ALL 89.02 -109.40 75.60
	RI_Atom_SetLockSpot Fighters 86.78 -109.29 80.23

	
	while ${Actor["Grethah the Frenzied"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Castle Highhold: No Quarter [Raid]"]} && ${Math.Distance[${Me.Loc},89.02,-109.40,75.60]}<100
	{
		if ${Actor["Grethah the Frenzied"].Health}>91 && ${Me.InCombat}
			call stopdps
		elseif ${Actor["Grethah the Frenzied"].Health}<=91 && ${Actor["Grethah the Frenzied"].Health}>=90
			call startdps
		elseif ${Actor["Grethah the Frenzied"].Health}<=71 && ${Actor["Grethah the Frenzied"].Health}>=70
			call startdps	
		elseif ${Actor["Grethah the Frenzied"].Health}<=51 && ${Actor["Grethah the Frenzied"].Health}>=50
			call startdps
		elseif ${Actor["Grethah the Frenzied"].Health}<=31 && ${Actor["Grethah the Frenzied"].Health}>=30
			call startdps
		elseif ${Actor["Grethah the Frenzied"].Health}<=11 && ${Actor["Grethah the Frenzied"].Health}>=10
			call startdps
		elseif ${Actor["Grethah the Frenzied"].Health}<10
			call startdps
		wait 1
	}
}

		
function Grethah()
{
	if ${Math.Distance[${Actor[${Me.ID}].Loc},89.02,-109.40,75.60]} >12
	{
		;;echo spot1
		RI_Atom_SetLockSpot ALL 89.02 -109.40 75.60
		RI_Atom_SetLockSpot Fighters 86.78 -109.29 80.23
	}
	elseif ${Math.Distance[${Actor[${Me.ID}].Loc},103.21,-109.40,75.81]} >12
	{
		;echo spot2
		RI_Atom_SetLockSpot ALL 103.21 -109.40 75.81
		RI_Atom_SetLockSpot Fighters 105.24 -109.29 80.23
	}
}

function stopdps()
{
	if !${Stopped}
	{
		Started:Set[FALSE]
		;echo ${Time}: stoping dps
		
		if ${Me.Archetype.Equal[scout]} || ${Me.Archetype.Equal[mage]}
		{
			RI_CMD_AbilityTypeEnableDisable CA 0
			RI_CMD_AbilityTypeEnableDisable NamedCA 0
			RI_CMD_AbilityTypeEnableDisable Combat 0
		}
		
		if ${Me.Archetype.Equal[priest]}
		{
			RI_CMD_AbilityTypeEnableDisable CA 0
		}
	
		Stopped:Set[TRUE]

	}
}

function startdps()
{
	if !${Started}
	{
		Started:Set[TRUE]
		Stopped:Set[FALSE]
		;echo ${Time}: starting dps
		if ${Me.Archetype.Equal[scout]} || ${Me.Archetype.Equal[mage]}
		{
			RI_CMD_AbilityTypeEnableDisable CA 1
			RI_CMD_AbilityTypeEnableDisable NamedCA 1
			RI_CMD_AbilityTypeEnableDisable Combat 1
		}
		
		if ${Me.Archetype.Equal[priest]}
		{
			RI_CMD_AbilityTypeEnableDisable CA 1
		}
		wait 300 ${Actor["a swarmling"](exists)}
		
		while ${Actor["a swarmling"](exists)}
		{
			wait 2
			;echo ${Time}: waiting while swarmling exists
		}
		call stopdps	
	}
}

atom joust(string Message)
{
	if ${Message.Find["The quivering cocoon gathers near"]} 
	{
		call Grethah
		;echo joust called
	}
	if ${Message.Find["start dps"]} 
	{
		call Grethah
		;echo joust called
	}
}
	
function atexit()
{
	echo ${Time}: Ending Grethah
	
	if ${Me.Archetype.Equal[scout]} || ${Me.Archetype.Equal[mage]}
	{
		RI_CMD_AbilityTypeEnableDisable CA 1
		RI_CMD_AbilityTypeEnableDisable NamedCA 1
		RI_CMD_AbilityTypeEnableDisable Combat 1
		RI_CMD_AbilityTypeEnableDisable Res 1
	}
	
	if ${Me.Archetype.Equal[priest]}
	{
		RI_CMD_AbilityTypeEnableDisable CA 1
		RI_CMD_AbilityTypeEnableDisable Res 1
	}
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
	
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	
}
	