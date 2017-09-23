;Zadune v14 by Herculezz

;variables
variable bool RecentlySprinted=FALSE
variable bool TriggerAgility=FALSE
variable bool TriggerIntelligence=FALSE
variable bool TriggerStrength=FALSE
variable bool TriggerWisdom=FALSE
variable(global) string RI_Var_String_Version=Zadune
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;main function
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ssraeshza Temple: Echoes of Time [Raid]"]} || ${Math.Distance[${Me.Loc},109.66,-48.87,55.18]}>100
	{
		echo ${Time}: You must be in Ssraeshza Temple: Echoes of Time [Raid] and within 100 distance of 109.66,-48.87,55.18 to run this script.
		Script:End
	}

	echo ${Time}: Starting Zadune v14
	
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
	
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;while Arch Lich Rhag'Zadune is not in combat
	while !${Me.InCombat}
		wait 2
	
	;move to camp
	call MoveC 109 55 FALSE
	
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot off
	
	;main while loop, while Arch Lich Rhag'Zadune exists
	while ${Actor["Arch Lich Rhag'Zadune"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Ssraeshza Temple: Echoes of Time [Raid]"]} && ${Math.Distance[${Me.Loc},109.66,-48.87,55.18]}<100
	{
		;if i am called for Strength totem call MoveStrength
		if ${TriggerStrength}
		{
			call MoveStrength
			TriggerStrength:Set[FALSE]
		}
		
		;if i am called for Wisdom totem call MoveWisdom
		if ${TriggerWisdom}
		{
			call MoveWisdom
			TriggerWisdom:Set[FALSE]
		}
		
		;if i am called for Intelligence totem call MoveIntelligence
		if ${TriggerIntelligence}
		{
			call MoveIntelligence
			TriggerIntelligence:Set[FALSE]
		}
		
		;if i am called for Agility totem call MoveAgility
		if ${TriggerAgility}
		{
			call MoveAgility
			TriggerAgility:Set[FALSE]
		}
		
		wait 2
	}
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;if incoming text includes has been given the Mark of Strength!
   	if ${Text.Find["has been given the Mark of Strength!"](exists)}
	{
		;if incomingtext also includes my name, set trigger true.
		if ${Text.Find[${Me.Name}](exists)}
		{
			echo ${Time}:IncomingText: ${Text}
			TriggerStrength:Set[TRUE]
		}
	}
	
	;if incoming text includes has been given the Mark of Wisdom!
   	if ${Text.Find["has been given the Mark of Wisdom!"](exists)}
	{
		;if incomingtext also includes my name, set trigger true.
		if ${Text.Find[${Me.Name}](exists)}
		{
			echo ${Time}:IncomingText: ${Text}
			TriggerWisdom:Set[TRUE]
		}
	}
	
	;if incoming text includes has been given the Mark of Intelligence!
   	if ${Text.Find["has been given the Mark of Intelligence!"](exists)}
	{
		;if incomingtext also includes my name, set trigger true.
		if ${Text.Find[${Me.Name}](exists)}
		{
			echo ${Time}:IncomingText: ${Text}
			TriggerIntelligence:Set[TRUE]
		}
	}
	
	;if incoming text includes has been given the Mark of Agility!
   	if ${Text.Find["has been given the Mark of Agility!"](exists)}
	{
		;if incomingtext also includes my name, set trigger true.
		if ${Text.Find[${Me.Name}](exists)}
		{
			echo ${Time}:IncomingText: ${Text}
			TriggerAgility:Set[TRUE]
		}
	}
}

;MoveStrength function
function MoveStrength()
{
	;turn off assist
	;RI_CMD_Assisting 0
	 
	;pausebots
	RI_CMD_PauseCombatBots 1
	
	;target self
	Actor[${Me.ID}]:DoTarget
	
	;move to totem
	call MoveC 137 55
	call MoveC 152 19
	wait 5
	;while the totem is clickable, keep clicking
	while ${Actor[loc,154.327042,16.265736].Interactable}
	{
		Actor[loc,154.327042,16.265736]:DoubleClick
		wait 1
	}
	wait 2
	;move back to camp
	call MoveC 137 55
	call MoveC 109 55
	
	;turn on assist
	 ;RI_CMD_Assisting 1
	 
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;clear target
	eq2ex target_none
	
	;if we are a fighter, free us
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot off
}

;MoveWisdom function
function MoveWisdom()
{
	;turn off assist
	 ;RI_CMD_Assisting 0
	 
	;pausebots
	RI_CMD_PauseCombatBots 1
	
	;move to totem
	call MoveC 137 55
	call MoveC 151 92
	wait 5
	;while the totem is clickable, keep clicking
	while ${Actor[loc,153.800125,94.661392].Interactable}
	{
		Actor[loc,153.800125,94.661392]:DoubleClick
		wait 1
	}
	wait 2
	;move back to camp
	call MoveC 137 55
	call MoveC 109 55
	
	;turn on assist
	 ;RI_CMD_Assisting 1
	 
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;clear target
	eq2ex target_none
	
	;if we are a fighter, free us
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot off
}

;MoveAgility function
function MoveAgility()
{
	;turn off assist
	 ;RI_CMD_Assisting 0
	 
	;pausebots
	RI_CMD_PauseCombatBots 1
	
	;move to totem
	call MoveC 81 55
	call MoveC 67 93
	wait 5
	;while the totem is clickable, keep clicking
	while ${Actor[loc,65.589027,95.061432].Interactable}
	{
		Actor[loc,65.589027,95.061432]:DoubleClick
		wait 1
	}
	wait 2
	;move back to camp
	call MoveC 81 55
	call MoveC 109 55
	
	;turn on assist
	 ;RI_CMD_Assisting 1
	 
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;clear target
	eq2ex target_none
	
	;if we are a fighter, free us
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot off
}

;MoveIntelligence function
function MoveIntelligence()
{
	;turn off assist
	 ;RI_CMD_Assisting 0
	 
	;pausebots
	RI_CMD_PauseCombatBots 1
	
	;move to totem
	call MoveC 81 55
	call MoveC 67 19
	wait 5
	;while the totem is clickable, keep clicking
	while ${Actor[loc,65.110703,16.095146].Interactable}
	{
		Actor[loc,65.110703,16.095146]:DoubleClick
		wait 1
	}
	wait 2
	;move back to camp
	call MoveC 81 55
	call MoveC 109 55
	
	;turn on assist
	; ;RI_CMD_Assisting 1
	 
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;clear target
	eq2ex target_none
	
	;if we are a fighter free us
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot off
}

;move function
function MoveC(float X1, float Z1, bool TargetSelf=TRUE)
{
	;set lockspot to X1 Z1
	RI_Atom_SetLockSpot ${Me.Name} ${X1} 0 ${Z1}
	
	variable int SprintTime=0
	
	;while we are move than 2 from X1 Z1
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>2
	{
		;if Sprint is not in our maintained and we have not recently sprinted 
		;and our power is above 10%
		if !${Me.Maintained[Sprint](exists)} && ${Script.RunningTime}>${Math.Calc[${SprintTime}+500]}
		{
			;use ability sprint, set RecentlySprinted true and set RecentlySprinted false after .5s
			Me.Ability[Sprint]:Use
			SprintTime:Set[${Script.RunningTime}]
		}
		if ${TargetSelf}
			Actor[${Me.ID}]:DoTarget
		wait 1
	}
}

;atexit function
function atexit()
{
	echo ${Time}: Ending Zadune
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}
