;Harvest v1 by herculezz

function main()
{

	;disable debugging
	Script:DisableDebugging
	
	echo ${Time}: Starting Harvest v2
	
	While 1
	{
		if !${Me.InCombat} && !${Me.IsHated}
		{
			;echo 1
			if ${Actor[resource].Distance} < 7
			{
				if !${Me.InCombat} && !${Me.IsHated}
					Actor[resource]:DoTarget
				while ${Target(exists)} && ${Target.Type.Equal[Resource]} && ${Target.Distance} < 7 && !${Me.IsMoving} && !${Me.FlyingUsingMount} && !${Me.InCombat} && !${Me.IsHated}
				{
					;echo 2
					waitframe
					Target:DoubleClick
					waitframe
					while ${Me.CastingSpell}
						waitframe
				}
			}
		}
		else
		{
			if ${Target.Type.Equal[Resource]}
				eq2ex target_none
		}
		waitframe
	}
}
atom(global) ri_harvest(string _what)
{
	if ${_what.Upper.EqualCS[END]}
		Script:End
}
;atexit function
function atexit()
{
	echo ${Time}: Ending Harvest
}