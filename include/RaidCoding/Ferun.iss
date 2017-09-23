;Ferun v10 by Herculezz
;260 MainIconID Energized by Luclin
variable bool Trigger=FALSE
variable(global) CheckMaintainedObject CheckMaintained
variable(global) string RI_Var_String_Version=Ferun
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;main function
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ssraeshza Temple: Echoes of Time [Raid]"]} || ${Math.Distance[${Me.Loc},164.91,-47.35,-24.27]}>100
	{
		echo ${Time}: You must be in Ssraeshza Temple: Echoes of Time [Raid] and within 100 distance of 164.91,-47.35,-24.27 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Ferun v10
	
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
	
	;add hud if we are the scout classes
	if ${Me.Archetype.Equal[scout]}
	{
		;cast invis spell depending on class
		switch ${Me.Class}
		{
			case rogue
			{
				squelch hud -add MM 300,300 Sneak: ${CheckMaintained.Exists["Sneak"]}
				break
			}
			case predator
			{
				squelch hud -add MM 300,300 Stealth: ${CheckMaintained.Exists["Stealth"]}
				break
			}
			case bard
			{
				squelch hud -add MM 300,300 Shroud: ${CheckMaintained.Exists["Shroud"]}
				break
			}
			case animalist
			{
				squelch hud -add MM 300,300 Spirit Shroud: ${CheckMaintained.Exists["Spirit Shroud"]}
			}
		}
	}
	
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]

	;turn off cancel invis
	if ${ISXOgre(exists)}
		OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_cancelinvisaftercombat FALSE
	
	;main while loop
	while ${Me.GetGameData[Self.ZoneName].Label.Equal["Ssraeshza Temple: Echoes of Time [Raid]"]} && ${Math.Distance[${Me.Loc},164.91,-47.35,-24.27]}<100
	;${Actor[Ka'Rah Ferun](exists)}
	{
		;if Trigger, call KillDisciple
		if ${Trigger}
		{
			wait 10
			call KillDisciple
			Trigger:Set[FALSE]
		}
		if ${Math.Distance[${Me.Loc},165,-44,-43]}<3 && ${Me.Inventory["Energized Shard of Luclin"](exists)}
			Me.Inventory["Energized Shard of Luclin"]:Use
		wait 1
	}
}

;KillDisciple function
function KillDisciple()
{
	;turn off assist
	RI_CMD_Assisting 0
	 
	;pausebots
	RI_CMD_PauseCombatBots 1

	;target self
	Actor[${Me.ID}]:DoTarget
	
	;determine where the disciple is and goto that click and clickit
	
	;west
	if ${Math.Distance[${Actor["a Disciple of Luclin"].Loc},191.342590,-21.756487,-48.391994]}<10
	{
		;set lockspot to 173,-44,-49
		RI_Atom_SetLockSpot ${Me.Name} 173 -44 -49
		wait 50 ${Math.Distance[${Me.Loc},173,-44,-49]}<4
		
		;click teleporter while we are still below
		
		while ${Math.Distance[${Me.Loc},203,-21,-49]}>3
		{
			Actor[dpo_invisible_cube]:DoubleClick
			wait 1
		}
		
		;set lockspot to 203,-21,-49
		RI_Atom_SetLockSpot ${Me.Name} 203 -21 -49
		wait 50 ${Math.Distance[${Me.Loc},203,-21,-49]}<3
		
		;cast invis spell depending on class
		switch ${Me.Class}
		{
			case rogue
			{
				call CastInvis Sneak
				break
			}
			case predator
			{
				call CastInvis Stealth
				break
			}
			case bard
			{
				call CastInvis Shroud
				break
			}
			case animalist
			{
				call CastInvis "Spirit Shroud"
			}
		}
		
		;set lockspot to 192,-21,-49
		RI_Atom_SetLockSpot ${Me.Name} 192 -21 -49
		wait 50 ${Math.Distance[${Me.Loc},192,-21,-49]}<3
	}
	
	;south
	if ${Math.Distance[${Actor["a Disciple of Luclin"].Loc},163.845032,-21.756487,-23.354019]}<10
	{
		;set lockspot to 165,-45,-41
		RI_Atom_SetLockSpot ${Me.Name} 165 -45 -41
		wait 50 ${Math.Distance[${Me.Loc},165,-45,-41]}<4
		
		;click teleporter while we are still below
		
		while ${Math.Distance[${Me.Loc},164,-21,-10]}>3
		{
			Actor[dpo_invisible_cube]:DoubleClick
			wait 1
		}
		
		;set lockspot to 164,-21,-10
		RI_Atom_SetLockSpot ${Me.Name} 164 -21 -10
		wait 50 ${Math.Distance[${Me.Loc},164,-21,-10]}<3
		
		;cast invis spell depending on class
		switch ${Me.Class}
		{
			case rogue
			{
				call CastInvis Sneak
				break
			}
			case predator
			{
				call CastInvis Stealth
				break
			}
			case bard
			{
				call CastInvis Shroud
				break
			}
			case animalist
			{
				call CastInvis "Spirit Shroud"
			}
		}
		
		;set lockspot to 164,-21,-21
		RI_Atom_SetLockSpot ${Me.Name} 164 -21 -21
		wait 50 ${Math.Distance[${Me.Loc},164,-21,-21]}<3
	}
	
	;east
	if ${Math.Distance[${Actor["a Disciple of Luclin"].Loc},138.732468,-21.762896,-48.966160]}<10
	{
		;set lockspot to 156,-45,-49
		RI_Atom_SetLockSpot ${Me.Name} 156 -45 -49
		wait 50 ${Math.Distance[${Me.Loc},156,-45,-49]}<4
		
		;click teleporter while we are still below
		
		while ${Math.Distance[${Me.Loc},125,-22,-50]}>3
		{
			Actor[dpo_invisible_cube]:DoubleClick
			wait 1
		}
		
		;set lockspot to 125,-22,-50
		RI_Atom_SetLockSpot ${Me.Name} 125 -22 -50
		wait 50 ${Math.Distance[${Me.Loc},125,-22,-50]}<3
		
		;cast invis spell depending on class
		switch ${Me.Class}
		{
			case rogue
			{
				call CastInvis Sneak
				break
			}
			case predator
			{
				call CastInvis Stealth
				break
			}
			case bard
			{
				call CastInvis Shroud
				break
			}
			case animalist
			{
				call CastInvis "Spirit Shroud"
			}
		}
		
		;set lockspot to 136,-21,-49
		RI_Atom_SetLockSpot ${Me.Name} 136 -21 -49
		wait 50 ${Math.Distance[${Me.Loc},136,-21,-49]}<3
	}
	
	;target a Disciple of Luclin
	Actor["a Disciple of Luclin"]:DoTarget
	
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;wait until Disciple is dead
	while ${Actor["a Disciple of Luclin"](exists)}
	{
		Actor["a Disciple of Luclin"]:DoTarget
		wait 1
	}
	
	;wait to ensure chest has appeared
	wait 2
	
	;chest's id
	variable int ChestID=${Actor[Chest,radius,10].ID}
	
	;summon chest
	eq2ex apply_verb ${ChestID} Summon

	;doubleclick chest wait 2 then loot all
	Actor[chest,radius,10]:DoubleClick
	wait 2
	LootWindow:LootAll
	Trigger:Set[FALSE]
	wait 2
	LootWindow:LootAll
	;set lockspot to 
	RI_Atom_SetLockSpot ${Me.Name} 165 -46 -38
	wait 100 ${Math.Distance[${Me.Loc},165,-46,-38]}<3
	
	;turn on assist
	RI_CMD_Assisting 1
	
	;set lockspot to 
	RI_Atom_SetLockSpot ${Me.Name} 165 -44 -43
	wait 100 ${Math.Distance[${Me.Loc},165,-44,-43]}<3
}

function CastInvis(string Ability)
{
	;cancel spellcast and clear ability queue
	eq2ex cancel_spellcast
	eq2ex clearabilityqueue 
	
	;wait until we are not casting
	wait 100 !${Me.CastingSpell}
	
	;check if our maintained is at 30 and cancel until its below
	while ${Me.CountMaintained}==30
	{
		Me.Maintained[30]:Cancel
		waitframe
	}
	
	;keep attempting to cast spell until it is no longer ready (aka casted)
	do
	{
		echo ${Time}: clearing ability queue
		eq2ex clearabilityqueue 
		wait 5
		if !${CheckMaintained.Exists["${Ability}"]}
		{
			echo ${Time}: maintained does not exist
			if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.NotEqual["${Ability}"]}
			{
				echo ${Time}: i am casting but not ${Ability}
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue
				Me.Ability["${Ability}"]:Use
			}
			elseif !${Me.CastingSpell}
			{
				echo ${Time}: i am not casting, casting ${Ability}
				eq2ex usea "${Ability}"
			}
		}
		else
			continue
		echo ${Time}: waiting until i am casting ${Ability}
		wait 50 ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${Ability}"]}
		echo ${Time}: waiting until i am not casting
		wait 50 !${Me.CastingSpell}
		echo ${Time}: waiting until ${Ability} is in my maintained
		wait 100 ${CheckMaintained.Exists["${Ability}"]}
		if ${CheckMaintained.Exists["${Ability}"]}
			echo ${Time}: ${Ability} is in my maintained
		eq2ex clearabilityqueue 
	}
	while !${CheckMaintained.Exists["${Ability}"]}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;if incoming text includes "notices a shadowy figure enter the room, only they can sneak up on them"
   	if ${Text.Find["notices a shadowy figure enter the room, only they can sneak up on them"](exists)}
	{
		;if incomingtext also includes my name, set trigger true.
		if ${Text.Find[${Me.Name}](exists)}
		{
			echo ${Time}:IncomingText: ${Text}
			Trigger:Set[TRUE]
		}
	}
}
;object CheckMaintainedObject
objectdef CheckMaintainedObject
{
	;check if Ability is in Maintained return true or false
	member:bool Exists(string AbilityName)
	{
		declare count int 0
		for (count:Set[1];${count}<=${Me.CountMaintained};count:Inc)
		{
			echo ${Time}: Checking if Maintained #${count} of ${Me.CountMaintained}: ${Me.Maintained[${count}].Name} is ${AbilityName}
			if ${Me.Maintained[${count}].Name.Equal[${AbilityName}]}
				return TRUE
		}
	}
}
function atexit()
{
	echo ${Time}: Ending Ferun
	squelch hud -remove MM
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}