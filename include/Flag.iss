function main(string Action=TAKE)
{
	;disable debugging
	Script:DisableDebugging
	
	if ${Action.Upper.NotEqual[TAKE]} && ${Action.Upper.NotEqual[GET]}
	{
		echo ISXRI: Usage RI_Flag Take/Get
		Script:End
	}
	variable index:actor ActorIndex
	variable bool FoundStrategist=FALSE
	variable int StrategistID=0
	;populate actors to our ActorIndex that are NPC and within distance 8
	EQ2:GetActors[ActorIndex,NoKillNPC,range,10]
	
	;echo ${Time}: ActorIndexSize: ${ActorIndex.Used}
	
	;for loop to iterate through all actors in our index
	variable int count=0
	for(count:Set[1];${count}<=${ActorIndex.Used};count:Inc)
	{
		;echo Checking ${ActorIndex[${count}].Name}
		;if the actor is incombatmode and not dead
		if ${ActorIndex[${count}].Guild.Find[Strategist](exists)}
		{
			FoundStrategist:Set[TRUE]
			StrategistID:Set[${ActorIndex[${count}].ID}]
		}
		;echo checking ${count}
	}
	if ${FoundStrategist} && ${StrategistID}>0
	{
		RI_CMD_PauseCombatBots 1
		Actor[${StrategistID}]:DoFace
		wait 2
		eq2ex apply_verb ${StrategistID} hail
		wait 10
		if ${Action.Upper.Equal[TAKE]}
			EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2]:LeftClick
		elseif ${Action.Upper.Equal[GET]}
			EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,3]:LeftClick
		RI_CMD_PauseCombatBots 0
	}
	else
		ISXRI: No Strategist within 10m
}