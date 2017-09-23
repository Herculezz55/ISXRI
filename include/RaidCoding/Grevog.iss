;Grevog written by Herculezz v3

;added a 5 wait to the heal routine to avoid spam queueing ogre casts
;changed detrimental name check (server call) to a Me.Elemental check

;variables
variable(global) bool Berserk=FALSE
variable bool StartBerserkOffRoutine=FALSE
variable(global) string RI_Var_String_Version=Grevog
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;main function
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Castle Highhold: No Quarter [Raid]"]} || ${Math.Distance[${Me.Loc},206,-109,-96]}>100
	{
		echo ${Time}: You must be in Castle Highhold: No Quarter [Raid] and within 100 distance of 206,-109,-96 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Grevog v3

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
	
	if ${ISXOgre(exists)}
	{
		;disable ogre raid options
		OgreBotAtom aExecuteAtom ${Me} a_UplinkConTHGBoterFunctionAutoType checkbox_settings_raidoptions FALSE
	}
	
	;disable following spells in ogre cast stack
	RI_CMD_AbilityEnableDisable "Sever Hate" 0
	RI_CMD_AbilityEnableDisable "Sentinel Strike" 0
	RI_CMD_AbilityEnableDisable "Sneering Assault" 0
	RI_CMD_AbilityEnableDisable "Plant" 0
	RI_CMD_AbilityEnableDisable "Evasive Maneuvers" 0
	RI_CMD_AbilityEnableDisable "Arcane Bewilderment" 0
	RI_CMD_AbilityEnableDisable "Befuddle" 0
	RI_CMD_AbilityEnableDisable "Paralyzing Strike" 0
	RI_CMD_AbilityEnableDisable "Holy Ground" 0
	RI_CMD_AbilityEnableDisable "Miracle Shot" 0
	RI_CMD_AbilityEnableDisable "Rescue" 0
	RI_CMD_AbilityEnableDisable "Plant"  0
	RI_CMD_AbilityEnableDisable "Cry of the Warrior" 0
	RI_CMD_AbilityEnableDisable "Jeering Onslaught" 0
	RI_CMD_AbilityEnableDisable "Insolence"  0
	RI_CMD_AbilityEnableDisable "Cry of the Warrior" 0
	RI_CMD_AbilityEnableDisable "Provoking Stance" 0
	RI_CMD_AbilityEnableDisable "Peel"  0
	RI_CMD_AbilityEnableDisable "Hidden Opening" 0
	RI_CMD_AbilityEnableDisable "Mantis Leap" 0
	RI_CMD_AbilityEnableDisable "Chaos Cloud" 0
	RI_CMD_AbilityEnableDisable "Grave Sacrament" 0
		
	;set lock spot
	RI_Atom_SetLockSpot ALL 206 -109 -96
	RI_Atom_SetLockSpot Fighters 220 -109 -93
	
	;while we are not in combat, wait
	while !${Me.InCombat}
		wait 1
	
	if ${Me.Archetype.Equal[fighter]}
	{
		while ${Actor["Grevog the Punisher"].Distance}>8
			wait 1
			
		RI_Atom_SetLockSpot ${Me.Name} 206 -109 -96
		
		wait 30
			
		while ${Actor["Grevog the Punisher"].Distance}>8
			wait 1
		
		RI_Atom_SetLockSpot ${Me.Name} 216 -109 -92
	}
	
	;main loop while Grevog the Punisher exists and is not dead
	while ${Actor["Grevog the Punisher"](exists)} && !${Actor["Grevog the Punisher"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Castle Highhold: No Quarter [Raid]"]} && ${Math.Distance[${Me.Loc},206,-109,-96]}<100
	{
		;if I have detrimental Flaming Cocktail, unpause ogre (for fighters)
		;and call pools function, if im not a monk and its not berserk
		if ${Me.Elemental}==-1 
		{
			if ${Me.Archetype.Equal[monk]} && ${Berserk}
			{
				wait 1
			}
			else
			{
				RI_CMD_PauseCombatBots 1
				call Pool
			}
		}
		
		;if I am not a fighter, check if Grevog the Punisher is targeting me, or not
		;and move to the appropriate spot
		if ${Me.Archetype.NotEqual[fighter]}
		{
			if ${Actor["Grevog the Punisher"].Target.ID}==${Me.ID} && ${Math.Distance[${Me.Loc},216,-109,-92]}>3
				RI_Atom_SetLockSpot ${Me.Name} 216 -109 -92
			elseif ${Actor[Grevog the Punisher].Target.ID}!=${Me.ID} && ${Math.Distance[${Me.Loc},206,-109,-96]}>3
				RI_Atom_SetLockSpot ${Me.Name} 206 -109 -96
		}
		
		;if Grevog the Punisher is in Berserk Mode call function Heal
		if ${Berserk}
		{
			if ${Me.Archetype.Equal[priest]}
				call Heal
			
			;if we are an enchanter
			if ${Me.Class.Equal[enchanter]}
			{
				;disable the following spells in Ogre cast stack
				RI_CMD_AbilityEnableDisable "Enraging Demeanor" 0
				RI_CMD_AbilityEnableDisable "Peaceful Link" 0
				
				;cancel maintained of the following spells
				eq2ex cancel_maintained "Peaceful Link"
				eq2ex cancel_maintained "Enraging Demeanor"
				eq2ex cancel_maintained "Peaceful Link"
				eq2ex cancel_maintained "Peaceful Link"
				
				;cancel casting and cast Sever Hate
				call Cast "Sever Hate" TRUE
			}
			
			;if we are a brigand cancel what we are casting and cast Shenanigans
			if ${Me.SubClass.Equal[brigand]}
				call Cast "Shenanigans" TRUE
			
			;if I am a priest call function OgreHeals passing 0
			if ${Me.Archetype.Equal[priest]}
				call OgreHeals 0
			
			;if I am a fighter
			if ${Me.Archetype.Equal[fighter]}
			{
				;if i am a brawler and Grevog the Punisher is Targeting me, Cast Feign Death
				if ${Me.Class.Equal["brawler"]} && ${Actor["Grevog the Punisher"].Target.ID}==${Me.ID}
					call Cast "Feign Death" TRUE

				;if I am a guardian
				if ${Me.SubClass.Equal[guardian]}
				{
					if ${ISXOgre(exists)}
					{
						;disable the following spells in Ogre cast stack
						RI_CMD_AbilityEnableDisable "Moderate" 0
						RI_CMD_AbilityEnableDisable "Improved Moderation" 0
					}
					
					;cancel maintained of the following spells
					eq2ex cancel_maintained "Moderate"
					eq2ex cancel_maintained "Improved Moderation"
				}
				
				;if I am a paladin
				if ${Me.SubClass.Equal[paladin]}
				{
					;disable the following spells in Ogre cast stack
					if ${ISXOgre(exists)}
						RI_CMD_AbilityEnableDisable "Amends" 0
					
					;cancel maintained of the following spells
					eq2ex cancel_maintained "Amends"
				}
				
				;pausebots, turn off melee and ranged attacks in ogre
				;turn off auto attack, cancel casting and clear queue
				RI_CMD_PauseCombatBots 1
				press `
				eq2ex autoattack 0
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue
			}	
		}
		elseif !${Berserk} && ${StartBerserkOffRoutine}
		{
			 ;if we are an enchanter
			if ${Me.Class.Equal[enchanter]}
			{
				;enable the following spells in Ogre cast stack
				if ${ISXOgre(exists)}
				{
					RI_CMD_AbilityEnableDisable "Enraging Demeanor" 1
					RI_CMD_AbilityEnableDisable "Peaceful Link" 1
				}
			}
			
			;if I am a priest call function OgreHeals passing 1
			if ${Me.Archetype.Equal[priest]}
				call OgreHeals 1
				
			;if I am a fighter
			if ${Me.Archetype.Equal[fighter]}
			{
				;relay to all bots to cancel casting and cast Coercive Shout on Me
				relay all -noredirect Script[Buffer:Grevog]:QueueCommand["call CastOn ""Coercive Shout"" ${Me.Name} TRUE"]
			
				;if I am a brawler stand up
				if ${Me.Class.Equal["brawler"]}
					press x
				
				if ${ISXOgre(exists)}
				{
					;if I am a guardian, enable the following ability in ogre cast stack
					if ${Me.SubClass.Equal[guardian]}
						RI_CMD_AbilityEnableDisable "Moderate" 1
					
					;if I am a paladin, enable the following ability in ogre cast stack
					if ${Me.SubClass.Equal[paladin]}
						RI_CMD_AbilityEnableDisable "Amends" 1
				
					;unpause bots
					RI_CMD_PauseCombatBots 0
				}
				
				;call Snap
				call Snap
			}
			StartBerserkOffRoutine:Set[FALSE]
		}
		;execute queued commands
		if ${QueuedCommands}
		{
			ExecuteQueued
		}
		wait 1
	}
}

;atom triggered when Incoming Text is detected
atom EQ2_onIncomingText(string Text)
{
	;if we see Grevog the Punisher goes berserk!
	if ${Text.Find["Grevog the Punisher goes berserk!"](exists)}
	{
		Berserk:Set[TRUE]
	}
	
	;if we see Grevog the Punisher is no longer berserk!
	if ${Text.Find["Grevog the Punisher is no longer berserk!"](exists)}
	{
		Berserk:Set[FALSE]
		StartBerserkOffRoutine:Set[TRUE]
	}
}
function OgreHeals(int OnOff)
{
	if ${ISXOgre(exists)}
	{
		;switch my subclass and turn off or on my Single Target Heal in Ogre Cast Stack
		switch ${Me.SubClass}
		{
			case defiler
			{
				if ${OnOff}==1
					RI_CMD_AbilityEnableDisable "Ancient Shroud" 1
				else
					RI_CMD_AbilityEnableDisable "Ancient Shroud" 0
				break
			}
			case mystic
			{
				if ${OnOff}==1
					RI_CMD_AbilityEnableDisable "Ancestral Ward" 1
				else
					RI_CMD_AbilityEnableDisable "Ancestral Ward" 0
				break
			}
			case warden
			{
				if ${OnOff}==1
					RI_CMD_AbilityEnableDisable "Photosynthesis" 1
				else
					RI_CMD_AbilityEnableDisable "Photosynthesis" 0
				break
			}
			case fury
			{
				if ${OnOff}==1
					RI_CMD_AbilityEnableDisable "Regrowth" 1
				else
					RI_CMD_AbilityEnableDisable "Regrowth" 0
				break
			}
			case inquisitor
			{
				if ${OnOff}==1
					RI_CMD_AbilityEnableDisable "Penance" 1
				else
					RI_CMD_AbilityEnableDisable "Penance" 0
				break
			}
			case templar
			{
				if ${OnOff}==1
					RI_CMD_AbilityEnableDisable "Vital Intercession" 1
				else
					RI_CMD_AbilityEnableDisable "Vital Intercession" 0
				break
			}
		}
	}
}

function Cast(string AbilityName, bool CancelCast)
{
	if ${Me.Ability["${AbilityName}"].IsReady}
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
			variable int GiveUpTimeCast=${Script.RunningTime}
			;pause bots
			RI_CMD_PauseCombatBots 1
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
				while ${Me.Ability["${AbilityName}"].IsReady} && ${Script.RunningTime}<${Math.Calc[${GiveUpTimeCast}+1000]}
					Me.Ability[${AbilityName}]:Use
			}
			;if we dont want to cancel cast, wait until we are done casting and
			;cast AbilityName
			else
			{
				while ${Me.CastingSpell}
					waitframe
				while ${Me.Ability["${AbilityName}"].IsReady} && ${Script.RunningTime}<${Math.Calc[${GiveUpTimeCast}+1000]}
				{
					Me.Ability[${AbilityName}]:Use
					waitframe
				}
			}
			;unpause bots
			RI_CMD_PauseCombatBots 0
		}
	}
}

function CastOn(string AbilityName, string PlayerName, bool CancelCast)
{
	if ${Me.Ability["${AbilityName}"].IsReady}
	{
		;echo ${Time}: Casting ${AbilityName}
		;if Ogre exists
		if ${ISXOgre(exists)}
		{
			OgreBotAtom a_CastFromUplinkOnPlayer ${Me.Name} "${AbilityName}" ${PlayerName} ${CancelCast}
			wait 5 !${Me.Ability["${AbilityName}"].IsReady}
		}
		;if ogre doesn't exists
		else
		{
			variable int GiveUpTimeCastOn=${Script.RunningTime}
			;pause bots
			RI_CMD_PauseCombatBots 1

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
				while ${Me.Ability["${AbilityName}"].IsReady} && ${Script.RunningTime}<${Math.Calc[${GiveUpTimeCastOn}+1000]}
				{
					eq2ex useabilityonplayer ${PlayerName} "${AbilityName}"
					waitframe
				}
			}
			;if we dont want to cancel cast, wait until we are done casting and
			;cast AbilityName
			else
			{
				while ${Me.CastingSpell}
					waitframe
				while ${Me.Ability["${AbilityName}"].IsReady} && ${Script.RunningTime}<${Math.Calc[${GiveUpTimeCastOn}+1000]}
				{
					eq2ex useabilityonplayer ${PlayerName} "${AbilityName}"
					waitframe
				}
			}
			;unpause bots
			RI_CMD_PauseCombatBots 0
		}
	}
}

function Heal()
{
	;switch my sub class and cast my single target heal on Grevog's Target
	switch ${Me.SubClass}
	{
		case defiler
		{
			if ${Me.Ability["Ancient Shroud VIII"].IsReady}
				call CastOn "Ancient Shroud" ${Actor["Grevog the Punisher"].Target.Name}
			break
		}
		case mystic
		{
			if ${Me.Ability["Ancestral Ward IX"].IsReady}
				call CastOn "Ancestral Ward" ${Actor["Grevog the Punisher"].Target.Name}
			break
		}
		case warden
		{
			if ${Me.Ability["Photosynthesis IX"].IsReady}
				call CastOn "Photosynthesis" ${Actor["Grevog the Punisher"].Target.Name}
			break
		}
		case fury
		{
			if ${Me.Ability["Regrowth IX"].IsReady}
				call CastOn "Regrowth" ${Actor["Grevog the Punisher"].Target.Name}
			break
		}
		case inquisitor
		{
			if ${Me.Ability["Penance IX"].IsReady}
				call CastOn "Penance" ${Actor["Grevog the Punisher"].Target.Name}
			break
		}
		case templar
		{
			if ${Me.Ability["Vital Intercession IX"].IsReady}
				call CastOn "Vital Intercession" ${Actor["Grevog the Punisher"].Target.Name}
			break
		}
	}
	wait 5
}
function Pool()
{
	;move to pool
	RI_Atom_SetLockSpot ${Me.Name} 185 -109 -103
	
	;while we are 2m from jump point, wait
	while ${Math.Distance[${Me.Loc},195,-109,-99]}>2
		wait 1
		
	;while we have Flaming Cocktail, keep jumping to make sure we get in pool 
	while ${Me.Elemental}==-1
	{
		press space
		wait 5
	}
	
	wait 5
	
	;if I am a fighter camp spot at 216,-109,-92, else camp spot at 206,-109,-96
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot ${Me.Name} 216 -109 -92
	else
		RI_Atom_SetLockSpot ${Me.Name} 206 -109 -96
	
	;unpause bots
	RI_CMD_PauseCombatBots 0
}


function Snap()
{
	;if I am a fighter
	if ${Me.Archetype.Equal[fighter]}
	{
		;tell ogre to cast the following
		call Cast "Rescue"
		call Cast "Sneering Assault"
		
		;if I am a guardian, tell ogre to cast the following
		if ${Me.SubClass.Equal["guardian"]}
		{
			call Cast "Cry of the Warrior"
			call Cast "Plant"
		}
		
		;if I am a berserker, tell ogre to cast the following
		if ${Me.SubClass.Equal["berserker"]}
		{
			call Cast "Cry of the Warrior"
			call Cast "Insolence"
			call Cast "Jeering Onslaught"
		}
		
		;if I am a monk, tell ogre to cast the following
		if ${Me.SubClass.Equal["monk"]}
		{
			call Cast "Provoking Stance"
			call Cast "Peel"
			call Cast "Hidden Opening"
			call Cast "Mantis Leap"
		}
		
		;if I am a paladin, tell ogre to cast the following
		if ${Me.SubClass.Equal[paladin]}
		{
			call Cast "Holy Ground"
		}
		
		;if I am a shadowknight, tell ogre to cast the following
		if ${Me.SubClass.Equal[shadowknight]}
		{
			if ${Me.Ability["Chaos Cloud"](exists)}
				call Cast "Chaos Cloud"
			else
				call Cast "Grave Sacrament"
		}
	}
}

;function called when script ends
function atexit()
{
	echo ${Time}: Ending Grevog
	
	;unpause bots
	RI_CMD_PauseCombatBots 0
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}
