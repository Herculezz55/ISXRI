;Kerridicus v3 by Herculezz

;v2 - changed only scouts jousting (not ranger)

;v3 - changed targeting, tank targets furthest out globule if its too far asks for coercive shout,
;	- if too close to raid they target themselves.

variable int GlobuleArray[3]
variable int SpawnCount=0
variable(global) string RI_Var_String_Version=Kerridicus
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Zavith'loa: The Molten Pools [Raid]"]} || ${Math.Distance[${Me.Loc},-3404.67,12.11,-80.57]}>100
	{
		echo ${Time}: You must be in Zavith'loa: The Molten Pools [Raid] and within 100 distance of -3404.67,12.11,-80.57 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Kerridicus v1
	
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
		
	;disable debugging
	Script:DisableDebugging
	
	;events
	Event[EQ2_ActorSpawned]:AttachAtom[EQ2_ActorSpawned]
	
	;turn off assist
	RI_CMD_Assisting 0
	
		
	;while Kerridicus Searskin is not in combat
	while !${Actor["Kerridicus Searskin"].InCombatMode}
		wait 2	
	
	;if we are scout but not ranger, turn on move behind, move melee, and turn off ofollow,
	;set ignore npc 100% and move 100%
	if ${Me.Archetype.Equal[scout]} && ${Me.SubClass.NotEqual[ranger]}
	{
		RI_Atom_MoveBehind 1 ${Actor["Kerridicus Searskin"].ID} 30 100
		if ${ISXOgre(exists)}
		{
			OgreFollowOb:SetFollower[off]
			OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_autofollow FALSE
			waitframe
			eq2ex stopfollow
		}
	}
	
	;else if i am a fighter
	elseif ${Me.Archetype.Equal[fighter]}
	{
		;turn on lockspot to -3404.67,12.11,-80.57
		RI_Atom_SetLockSpot ALL -3404.67 12.11 -80.57
	}
	
	;else
	else
	{
		;turn on lockspot to -3423.19,12.11,-76.57
		RI_Atom_SetLockSpot ALL -3423.19 12.11 -76.57

	}
	
	;while Kerridicus Searskin exists and is not dead
	while ${Actor["Kerridicus Searskin"](exists)} && !${Actor["Kerridicus Searskin"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Zavith'loa: The Molten Pools [Raid]"]} && ${Math.Distance[${Me.Loc},-3404.67,12.11,-80.57]}<100
	{
		;if an Unstable Lava Globule exists, target them. if not fighter wait till 95%
		if ${Actor["an Unstable Lava Globule"](exists)}
		{

			if ${Me.Archetype.Equal[fighter]}
			{
				;if the globule is more than 12 away, relay to all bots to cancel casting and cast Coercive Shout on Me
				if ${Actor[id,${GlobuleArray[1]}].Distance}>12 || ${Actor[id,${GlobuleArray[2]}].Distance}>12 || ${Actor[id,${GlobuleArray[3]}].Distance}>12
					relay all OgreBotAtom a_CastFromUplinkOnPlayer ALL "Coercive Shout" ${Me.Name} TRUE 
				;echo ${Time}: Globule's are Up at Distances, 1: ${Actor[id,${GlobuleArray[1]}].Distance} 2: ${Actor[id,${GlobuleArray[2]}].Distance} 3: ${Actor[id,${GlobuleArray[3]}].Distance}
				if ${Actor[id,${GlobuleArray[1]}](exists)} && !${Actor[id,${GlobuleArray[1]}].IsDead} && ${Actor[id,${GlobuleArray[1]}].Distance}>${Actor[id,${GlobuleArray[2]}].Distance} && ${Actor[id,${GlobuleArray[1]}].Distance}>${Actor[id,${GlobuleArray[3]}].Distance}
					Actor[id,${GlobuleArray[1]}]:DoTarget
				elseif ${Actor[id,${GlobuleArray[2]}](exists)} && !${Actor[id,${GlobuleArray[2]}].IsDead} && ${Actor[id,${GlobuleArray[2]}].Distance}>${Actor[id,${GlobuleArray[1]}].Distance} && ${Actor[id,${GlobuleArray[2]}].Distance}>${Actor[id,${GlobuleArray[3]}].Distance}
					Actor[id,${GlobuleArray[2]}]:DoTarget
				elseif ${Actor[id,${GlobuleArray[3]}](exists)} && !${Actor[id,${GlobuleArray[3]}].IsDead} && ${Actor[id,${GlobuleArray[3]}].Distance}>${Actor[id,${GlobuleArray[2]}].Distance} && ${Actor[id,${GlobuleArray[3]}].Distance}>${Actor[id,${GlobuleArray[1]}].Distance}
					Actor[id,${GlobuleArray[3]}]:DoTarget
				else
					Actor[id,${GlobuleArray[1]}]:DoTarget
			}
			if ${Actor[corpse](exists)}
			{
				eq2ex apply_verb ${Actor[corpse,radius,10].ID} Loot
				Actor[corpse,radius,10]:DoubleClick
			}
			if ${Actor["an Unstable Lava Globule"].Health}<96 && ${Me.Archetype.NotEqual[fighter]}
			{
				if ${Actor["an Unstable Lava Globule"].Distance}<10
					Target ${Me.Name}
				else
					Actor["an Unstable Lava Globule"]:DoTarget
			}
		}
			
		;if Lava Titan Exists, target him, if we are not
		elseif ${Actor["Lava Titan"](exists)}
		{
			if ${Target.ID}!=${Actor["Lava Titan"].ID}
				Actor["Lava Titan"]:DoTarget
		}
		
		;if we are not targeting Kerridicus, target him
		elseif ${Target.ID}!=${Actor["Kerridicus Searskin"].ID}
			Actor["Kerridicus Searskin"]:DoTarget
		
		;if we are scout but not ranger
		if ${Me.Archetype.Equal[scout]} && ${Me.SubClass.NotEqual[ranger]}
		{
			;if an Unstable Lava Globule exists
			if ${Actor["an Unstable Lava Globule"](exists)}
			{
				;turn on lockspot to -3423.19,12.11,-76.57
				RI_Atom_SetLockSpot ALL -3423.19 12.11 -76.57
				
				;while an Unstable Lava Globule exists, wait 1
				while ${Actor["an Unstable Lava Globule"](exists)}
					wait 1
				
				wait 150
				
				RI_Atom_SetLockSpot off
				waitframe
				RI_Atom_MoveBehind 1 ${Actor["Kerridicus Searskin"].ID} 30 100
			}
		}
		wait 5
	}
}
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
atom EQ2_ActorSpawned(string ID, string Name, string Level)
{
   ; echo ${Time}: ${Name} Spawned with ID: ${ID} Level: ${Level} and Loc: ${Actor[${ID}].Loc} and Distance ${Actor[${ID}].Distance}
	if ${Actor[${ID}].Name.Equal["an Unstable Lava Globule"]}
	{
		SpawnCount:Inc
		GlobuleArray[${SpawnCount}]:Set[${ID}]
		;echo ${Time}: Globule Spawned Setting to Array GlobuleArray in Element ${SpawnCount}, ID: ${GlobuleArray[${SpawnCount}]}
		if ${SpawnCount}==3
			SpawnCount:Set[0]
	}
}
function atexit()
{
	echo ${Time}: Ending Kerridicus
	;turn on assist, and off movebehind
	RI_CMD_Assisting 1

	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}