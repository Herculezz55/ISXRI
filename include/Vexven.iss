function main()
{
	;disable debugging
	Script:DisableDebugging
	
	if ${Me.Archetype.NotEqual[fighter]}
		Script:End
	while 1
	{
		if ${CustomActor[rage,radius,15](exists)} && !${CustomActor[rage,radius,15].IsDead}
			CustomActor[rage,radius,15]:DoTarget
		elseif ${CustomActor[Vexven,radius,10](exists)} && !${CustomActor[Vexven,radius,10].IsDead}
			CustomActor[Vexven,radius,10]:DoTarget
		elseif ${CustomActor[shaman,radius,10](exists)} && !${CustomActor[shaman,radius,10].IsDead}
			CustomActor[shaman,radius,10]:DoTarget
	}
}