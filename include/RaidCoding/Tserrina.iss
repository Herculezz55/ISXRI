variable bool ShadowySpawed=FALSE
variable int ShadowyID=0
;Tserrina v5
function main()
{
	echo Starting Tserrina v7
	
	RI_CMD_AbilityEnableDisable "Possess Essence" 0
	Me.Maintained["Possess Essence"]:Cancel
	
	;events
	Event[EQ2_ActorSpawned]:AttachAtom[EQ2_ActorSpawned]
	
	if ${Me.RaidGroupNum}==4
	{
		if ${Me.Inventory["Vision Totem of the Cat"](exists)}
		{
			;get a custom inventory index with that ^ name only in it for loop through to get AutoConsumeOn and QTY,a nd if none on then turn on toggleautocosume on one with highest qty, then atexit run through same index turning off autoconsume
			if !${Me.Inventory["Vision Totem of the Cat"].AutoConsumeOn}
				Me.Inventory["Vision Totem of the Cat"]:ToggleAutoConsume
		}
		else	
		echo ISXRI: This encounter requires See Stealth for the shadowy cultists, you do not have Vision Totem of the Cat making this fight exponentially harder, GOOD LUCK
	}
	
	while !${Actor["Tserrina Syl'tor"].InCombatMode}
		wait 1
		
	RI_Atom_SetLockSpot NONFIGHTERS 405.04 0 -583.62 1 200
	
	while ${Math.Distance[${Me.Loc},401.31,0,-583.33]}<250
	{
		wait 1
		if ${Me.RaidGroupNum}!=4 && ${Me.SubClass.Equal[coercer]} && ${Actor[NPC,"a summoned shadowbeast"](exists)} && ( ${Me.Pet.Name.NotEqual["a summoned shadowbeast"]} || !${Me.Pet(exists)} )
		{
			RI_CMD_PauseCombatBots 1
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			wait 1
			Me.Maintained["Possess Essence"]:Cancel
			wait 3
			Actor["a summoned shadowbeast"]:DoTarget
			wait 2
			while !${Me.CastingSpell} && ${Me.Ability[id,3409447030].IsReady} && ${Actor[NPC,"a summoned shadowbeast"](exists)}
			{
				Me.Ability[id,3409447030]:Use
				wait 2
			}
			wait 5 ${Me.CastingSpell}}
			wait 100 !${Me.CastingSpell}
			RI_CMD_PauseCombatBots 0
		}
		if ${Me.RaidGroupNum}!=4 && ${Me.SubClass.Equal[coercer]} && ${Actor["a shadowy brazier"](exists)} && ${Me.Pet.Name.Equal["a summoned shadowbeast"]}
		{
			RI_CMD_Assisting 0
			while ${Actor["a shadowy brazier"](exists)} && !${Actor["a shadowy brazier"].IsDead}
			{
				Actor["a shadowy brazier"]:DoTarget
				wait 1
			}
			RI_CMD_Assisting 1
		}
		if ${ShadowySpawed}
		{
			RI_CMD_Assisting 0
			while ${Actor[id,${ShadowyID}](exists)} && !${Actor[id,${ShadowyID}].IsDead}
			{
				Actor[id,${ShadowyID}]:DoTarget
				echo ${Time}: ${ShadowyID} : ${Actor[id,${ShadowyID}].Name} is UP
				if ${Actor[id,${ShadowyID}].Distance}<32 && ( ${Math.Distance[${Me.Loc},352.48,0,-605.04]}<15 || ${Math.Distance[${Me.Loc},351.08,-0,-561.18]}<15 || ${Math.Distance[${Me.Loc},380.59,0,-535.04]}<15 || ${Math.Distance[${Me.Loc},423.69,0,-534.80]}<15 || ${Math.Distance[${Me.Loc},449.25,0,-560.31]}<15 || ${Math.Distance[${Me.Loc},449.01,0,-605.66]}<15 || ${Math.Distance[${Me.Loc}424.12,0,-631.50]}<15 || ${Math.Distance[${Me.Loc},379.26,0,-631.04]}<15 ) && !${Me.TargetLOS}
				{
					press -hold ${RI_Var_String_StrafeLeftKey}
					variable int cnt=0
					while !${Me.TargetLOS} && ${cnt:Inc}<5
					{
						wait 10
					}
					press -release ${RI_Var_String_StrafeLeftKey}
				}
				wait 1
			}
			RI_CMD_Assisting 1
			RI_Atom_SetLockSpot ${Me.Name} 405.04 0 -583.62 1 200
			ShadowySpawned:Set[FALSE]
		}
	}
}
atom EQ2_ActorSpawned(string ID, string Name, string Level)
{
	if ${Actor[id,${ID}].Name.Equal["a shadowy cultist"]}
	{	
		variable int TempID=${ID}
		echo ${Time}: ${Name} Spawned : ${Actor[id,${ID}].Loc}
		echo ${Time}: ${Actor[id,${ID}].Type} : ${ID}
		if ${Me.RaidGroupNum}==4 && ${Actor[id,${TempID}].Type.Equal[NPC]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[id,${TempID}].X} ${Actor[id,${TempID}].Y} ${Actor[id,${TempID}].Z} 30 200
			ShadowySpawed:Set[TRUE]
			ShadowyID:Set[${TempID}]
		}
	}
}

function atexit()
{
	echo Ending Tserrina
	RI_CMD_AbilityEnableDisable "Possess Essence" 1
	if ${Me.Inventory["Vision Totem of the Cat"].AutoConsumeOn}
		Me.Inventory["Vision Totem of the Cat"]:ToggleAutoConsume
}