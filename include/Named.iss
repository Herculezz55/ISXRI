function main(string MobName="NAME", int MainIconID=000)
{
	variable int MobID=0
	variable int CurseCallTime=0
	MobID:Set[${Actor[Query, Name=-"${MobName}" && IsDead=FALSE].ID}]
	if ${Me.Archetype.Equal[priest]}
		RI_CMD_AbilityEnableDisable "Cure Curse" 0
	while ${Actor[Query, ID=${MobID} && IsDead=FALSE](exists)}
	{
		if ${Target.ID}!=${MobID} && ${Me.Archetype.Equal[fighter]}
			Actor[id, ${MobID}]:DoTarget
		
		if ${RIMUIObj.MainIconIDExists[${MainIconID}]}
		{
			if ( ${Script.RunningTime}>${Math.Calc[${CurseCallTime}+10000]} || ${CurseCallTime}==0 )
			{
				eq2ex r need a cure curse
				eq2ex g need a cure curse
				CurseCallTime:Set[${Script.RunningTime}]
			}
		}
		waitframe
	}
	if ${Me.Archetype.Equal[priest]}
		RI_CMD_AbilityEnableDisable "Cure Curse" 1
}