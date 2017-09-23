;BalanceProtector v2 by Herculezz

;variables
variable bool RecentlyTargeted=FALSE
variable index:actor ActorIndex
variable int count
variable int ID
variable int MobWithHighestHealth
variable(global) string RI_Var_String_Version=Protector

;main function	
function main()
{
	echo BalanceProtector v2

	
	
	;disable debugging
	Script:DisableDebugging
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	UIElement[Start@RI]:SetText[Pause]
	UIElement[AutoLoot@RI]:Hide
	UIElement[RI]:SetHeight[40]
	
	;main loop
	do
	{
		;if we have not recently targeted
		if ${Actor["coagulated gore"](exists)}
			Actor["coagulated gore"]:DoTarget
		elseif !${RecentlyTargeted} 
		{
			;populate actors to our ActorIndex that are NPC and within distance 8
			EQ2:GetActors[ActorIndex,NamedNPC,range,38]
			
			;echo ${Time}: ActorIndexSize: ${ActorIndex.Used}
			
			;for loop to iterate through all actors in our index
			for(count:Set[1];${count}<=${ActorIndex.Used};count:Inc)
			{
				;echo Checking ${ActorIndex[${count}].Name}
				;if the actor is incombatmode and not dead
				if ${ActorIndex[${count}].InCombatMode} && !${ActorIndex[${count}].IsDead}
				{
					
					;if the actor's health is higher than MobWithHighestHealth
					;set them to MobWithHighestHealth
					if ${ActorIndex[${count}].Health}>${Math.Calc[${Actor[${MobWithHighestHealth}].Health}+4]}
						MobWithHighestHealth:Set[${ActorIndex[${count}].ID}]
				}
				waitframe
				;echo checking ${count}
			}
			
			;set RecentlyTargeted true, and false again after 1s
			RecentlyTargeted:Set[TRUE]
			TimedCommand 10 Script[BalanceProtector].Variable[RecentlyTargeted]:Set[FALSE]
			
			;if i am not targeting MobWithHighestHealth and it is not 0 and exists
			;target MobWithHighestHealth
			if ${Target.ID}!=${MobWithHighestHealth} && ${MobWithHighestHealth}!=0 && ${Actor[${MobWithHighestHealth}](exists)}
			{
				;echo ${Time}: Targeting ${MobWithHighestHealth} / ${Actor[${MobWithHighestHealth}]} Health: ${Actor[${MobWithHighestHealth}].Health}
				Actor[${MobWithHighestHealth}]:DoTarget
			}
		}
		wait 1
		;echo Iteration: there are ${EQ2.ActorIndexArraySize}
	}
	while 1
}

;atexit function
function atexit()
{
	echo Ending BalanceProtector
}