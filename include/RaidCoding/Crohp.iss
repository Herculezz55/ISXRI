variable bool Trigger=FALSE
variable(global) string RI_Var_String_Version=Crohp
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Stygian Threshold: Edge of Underfoot [Raid]"]} || ${Math.Distance[${Me.Loc},365.156586,44.082176,-231.246872]}>100
	{
		echo ${Time}: You must be in Stygian Threshold: Edge of Underfoot [Raid] and within 100 distance of 365.156586,44.082176,-231.246872 to run this script.
		Script:End
	}
	
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
	
	echo ${Time}: Starting Crohp v1
	
	;disable debugging
	Script:DisableDebugging
	
	;announce event
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;turn on lockspot and set to main camp
	RI_Atom_SetLockSpot ALL 365.156586 44.082176 -231.246872
	wait 10
	
	;while Crohp is not in combat
	while !${Actor["Crohp"].InCombatMode}
		wait 2	
	
	;if we are a fighter target Actor
	if ${Me.Archetype.Equal[fighter]}
	{
		Actor["Crohp"]:DoTarget
	}
	
	;main do while loop
	while ${Actor["Crohp"](exists)} && !${Actor["Crohp"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Stygian Threshold: Edge of Underfoot [Raid]"]} && ${Math.Distance[${Me.Loc},365.156586,44.082176,-231.246872]}<100
	{
		if ${Me.Archetype.Equal[fighter]}
		{
			if ${Target.ID}!=${Actor["Crohp"].ID} && ${Actor["Crohp"](exists)}
				Actor["Crohp"]:DoTarget
			
			;call JoustOut function if trigger
			if ${Trigger}
			{
				if ${Math.Distance[${Me.Loc},365.156586,44.082176,-231.246872]}<10
					RI_Atom_SetLockSpot ${Me.Name} 425.746460 44.098557 -238.593552 1 100
				else
					RI_Atom_SetLockSpot ${Me.Name} 365.156586 44.082176 -231.246872 1 100
				Trigger:Set[FALSE]
			}
		}
		wait 2
	}
}
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	
   	if ${Text.Find[${IncomingText}](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		Trigger:Set[TRUE]
		TriggerMessage:Set[${Text}]
	}
}

;on exit
function atexit()
{
	echo ${Time}: Ending Crohp v1
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}