;Harvest v1 by herculezz

function main()
{

	;disable debugging
	Script:DisableDebugging
	
	echo ${Time}: Starting Harvest v1
	
	While 1
	{
		if !${Me.InCombat}
		{
			if ${Actor[resource].Distance} < 7
			{
				Actor[resource]:DoTarget
				while ${Target(exists)} && ${Target.Type.Equal[Resource]} && ${Target.Distance} < 7 && !${Me.IsMoving} && !${Me.FlyingUsingMount}
				{
					waitframe
					Target:DoubleClick
					waitframe
					while ${Me.CastingSpell}
						waitframe
				}
			}
		}
		waitframe
	}
}
;atexit function
function atexit()
{
	echo ${Time}: Ending Harvest
}