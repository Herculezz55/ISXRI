;Protector v1 by Herculezz

;variables
variable index:actor ActorIndex
variable int count
variable int ID
variable int MobWithHighestHealth
variable int TargetedTime=0
variable(global) string RI_Var_String_Version=Protector

atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;main function	
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ossuary: Cathedral of Bones [Raid]"]} || ${Math.Distance[${Me.Loc},0,0,-241.74]}>100
	{
		echo ${Time}: You must be in Ossuary: Cathedral of Bones [Raid] and within 100 distance of 0,0,-241.74 to run this script.
		Script:End
	}
	
	echo ${Time}: Protector v1

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
	
	;main loop
	do
	{
		;if we have not recently targeted
		if ${Actor["coagulated gore"](exists)}
			Actor["coagulated gore"]:DoTarget
		else
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
			
			;if i am not targeting MobWithHighestHealth and it is not 0 and exists
			;target MobWithHighestHealth
			if ${Target.ID}!=${MobWithHighestHealth} && ${MobWithHighestHealth}!=0 && ${Actor[${MobWithHighestHealth}](exists)} && ${Script.RunningTime}>${Math.Calc[${TargetedTime}+1000]}
			{
				;echo ${Time}: Targeting ${MobWithHighestHealth} / ${Actor[${MobWithHighestHealth}]} Health: ${Actor[${MobWithHighestHealth}].Health}
				Actor[${MobWithHighestHealth}]:DoTarget
				TargetedTime:Set[${Script.RunningTime}]
			}
		}
		wait 1
		;echo Iteration: there are ${EQ2.ActorIndexArraySize}
	}
	while ${Me.GetGameData[Self.ZoneName].Label.Equal["Ossuary: Cathedral of Bones [Raid]"]} && ${Math.Distance[${Me.Loc},0,0,-241.74]}<100
}

;atexit function
function atexit()
{
	echo ${Time}: Ending Protector
}