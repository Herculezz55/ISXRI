function main()
{
	variable index:actor ActorIndex
	variable bool FoundStrategist=FALSE
	variable int MenderID=0
	;populate actors to our ActorIndex that are NPC and within distance 8
	EQ2:GetActors[ActorIndex,NoKillNPC,range,10]
	
	echo ${Time}: ActorIndexSize: ${ActorIndex.Used}
	
	;for loop to iterate through all actors in our index
	variable int count=0
	for(count:Set[1];${count}<=${ActorIndex.Used};count:Inc)
	{
		echo Checking ${ActorIndex[${count}].Name}
		;if the actor is incombatmode and not dead
		if ${ActorIndex[${count}].Guild.Find[Mender](exists)}
		{
			FoundMender:Set[TRUE]
			MenderID:Set[${ActorIndex[${count}].ID}]
		}
		;echo checking ${count}
	}
	if ${FoundMender} && ${MenderID}>0
	{
		RI_Atom_CB_PauseCombatBots 1
		eq2ex apply_verb ${MenderID} repair
		wait 10
		eq2ex mender_repair_all
		wait 10
		EQ2UIPage[Inventory,Merchant].Child[button,Merchant.WindowFrame.Close]:LeftClick
		RI_Atom_CB_PauseCombatBots 0
	}
	else
		ISXRI: No Mender within 10m
}