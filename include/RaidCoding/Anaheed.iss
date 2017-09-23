function main()
{
	while ${Actor[Query, Name=="Anaheed the Dreamkeeper" && IsDead=FALSE](exists)}
	{
		if ${RIMUIObj.MainIconIDExists[${Me.ID},293]}
		{
			RI_CMD_Assist 0
			Actor[${Me.ID}]:DoTarget
			while ${RIMUIObj.MainIconIDExists[${Me.ID},293]}
			{
				if ${Target.ID}!=${Actor[A Waking Dream].ID}
					Actor[A Waking Dream]:DoTarget
				RIMUIObj:SetLockSpot[${Me.Name},${Actor[A Waking Dream].Loc},5,500]
				wait 1
			}
			RI_CMD_Assist 1
			RIMUIObj:SetLockSpot[${Me.Name},${Me.Group[5].Loc},1,500]
		}
		;elseif ${Me.Archetype.Equal[fighter]} && ${Me.InCombat}
		;{
		;	if ${Target.ID}!=${Actor[Query, Name=="Anaheed the Dreamkeeper" && IsDead=FALSE].ID}
		;		Actor[Query, Name=="Anaheed the Dreamkeeper" && IsDead=FALSE]:DoTarget
		;}
		wait 5
	}
}