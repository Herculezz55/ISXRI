;Torso v1 by Herculezz

;variables
variable int VileBuildUpMainIconID=353
variable bool Jousting=FALSE
variable bool ShackleCast=FALSE
variable(global) string RI_Var_String_Version=Torso
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;main function
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Castle Highhold: No Quarter [Raid]"]} || ${Math.Distance[${Me.Loc},-12,-110,-77]}>100
	{
		echo ${Time}: You must be in Castle Highhold: No Quarter [Raid] and within 100 distance of -12,-110,-77 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Torso v1

	;disable debugging
	Script:DisableDebugging
	
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
	
	
	;disable ogre raid options
	if ${ISXOgre(exists)}
		OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_raidoptions	FALSE
	
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;turn on lockspot to -12 -110 -77, and fighters to -18 -110 -82
	RI_Atom_SetLockSpot ALL -12 -110 -77
	RI_Atom_SetLockSpot Fighters -18 -110 -82
	
	;disable cloak of divinity and soul shackle
	RI_CMD_AbilityEnableDisable "Cloak of Divinity" 0
	RI_CMD_AbilityEnableDisable "Soul Shackle" 0
	
	;count variable
	declare count int local 0
			
	;main while loop, while Zebrun the Torso exists and is not dead
	while ${Actor["Zebrun the Torso"](exists)} && !${Actor["Zebrun the Torso"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Castle Highhold: No Quarter [Raid]"]} && ${Math.Distance[${Me.Loc},-12,-110,-77]}<100
	{
		;for loop to check the first 5 Effects for Vile Build Up
		for(count:Set[1];${count}<5;count:Inc)
		{
			;if we find vile buildup
			if ${Actor["Zebrun the Torso"].Effect[${count}].MainIconID} == ${VileBuildUpMainIconID}
			{
				;if vilebuildup is at 9 inc joust
				if ${Actor["Zebrun the Torso"].Effect[${count}].CurrentIncrements} == 9 && !${Jousting}
				{						
					Jousting:Set[TRUE]
					call Joust
				}
				
				;if vilebuildup is at 7 inc and shackle is available and not cast cast it with cloak of divinity
				if ${Actor["Zebrun the Torso"].Effect[${count}].CurrentIncrements} == 7 && !${ShackleCast} && !${Me.Maintained["Soul Shackle"](exists)}
				{
					call Cast "Cloak of Divinity" TRUE
					wait 2
					call Cast "Soul Shackle" TRUE
					ShackleCast:Set[TRUE]
				}
			}
			wait 1
		}
		wait 1
	}
}
function Cast(string AbilityName, bool CancelCast)
{
	;echo ${Time}: Casting ${AbilityName}
	;if Ogre exists
	if ${ISXOgre(exists)}
	{
		OgreBotAtom a_CastFromUplink ${Me.Name} "${AbilityName}" ${CancelCast}

		wait 5 !${Me.Ability["${AbilityName}"].IsReady}
	}
	;if ogre doesn't exists
	else
	{
		;if we want to cancel cast, send in game commands to cancel our cast 
		;and clear the queue until we are no longer casting, then cast AbilityName
		if ${CancelCast}
		{
			while ${Me.CastingSpell}
			{
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				waitframe
			}
			while ${Me.Ability["${AbilityName}"].IsReady}
				Me.Ability[${AbilityName}]:Use
		}
		;if we dont want to cancel cast, wait until we are done casting and
		;cast AbilityName
		else
		{
			while ${Me.CastingSpell}
				waitframe
			while ${Me.Ability["${AbilityName}"].IsReady}
				Me.Ability[${AbilityName}]:Use
		}
	}
}
function Joust()
{
	call Cast "Quick Tempo"
	call Cast "Ancestral Channeling"
	call Cast "Spirit Aegis"
	call Cast "Umbral Barrier"
	call Cast "Carrion Warding"
	call Cast "Tunare's Watch"
	call Cast "Healstorm"
	eq2ex pet backoff	
	
	if ${Math.Distance[${Actor[${Me.ID}].Loc},-12,-110,-77]}>60
	{
		RI_Atom_SetLockSpot ALL -12 -110 -77
		RI_Atom_SetLockSpot Fighters -8 -110 -86
		wait 5
	}
	elseif ${Math.Distance[${Actor[${Me.ID}].Loc},-9,-110,-9]}>60
	{
		RI_Atom_SetLockSpot ALL -9 -110 -9
		RI_Atom_SetLockSpot Fighters -3 -110 0.1
		;irc !c Me -CCS -9 -110 29 -ccsw fighters -3 -110 0
		wait 5
	}
	while ${Jousting}
	{
		call CastHeals
		wait 10
	}
}

function CastHeals()
{
	call Cast "Maximized Protection"
	;call Cast "Soul Shackle"
	call Cast "Spirit Aegis"
	call Cast "Umbral Barrier"
	;irc !c Me -cast all "Maximized Protection" -cast all "Soul Shackle" -cast all "Spirit Aegis" -cast all "Umbral Barrier"
	;wait 20
	call Cast "Healstorm"
	call Cast "Winds of Healing"
	call Cast "Healing Barrage"
	call Cast "Salubrious Invocation"
	call Cast "Prophetic Ward"
	call Cast "Transcendence"
	call Cast "Champion's Interception"
	call Cast "Unholy Warding"
	call Cast "Carrion Warding"
	;call Cast "Spirit Aegis"
	call Cast "Wild Accretion"
	
	;irc !c Me -cast all "Healstorm" -cast all "Winds of Healing" -cast all "Healing Barrage" -cast all "Salubrious Invocation" -cast all "Prophetic Ward" -cast all "Transcendence" -cast all "Champion's Interception" -cast all "Unholy Warding"
	;wait 30
	call Cast "Redirection"
	;irc !c Me -cast all "Redirection"
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["Zebrun the Torso is no longer able to slay players at will!"](exists)}
	{
		Jousting:Set[FALSE]
		ShackleCast:Set[FALSE]
		relay all eq2ex pet attack
		relay all eq2ex pet autoassist		
	}
}

;atexit function
function atexit()
{
	echo ${Time}: Ending Torso
	
	;turn cloak and soulshackle back on
	RI_CMD_AbilityEnableDisable "Cloak of Divinity" 1
	RI_CMD_AbilityEnableDisable "Soul Shackle" 1
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}