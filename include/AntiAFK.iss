;AntiAFK v1 by Herculezz
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	;keep from getting booted for afk
	while 1
	{
		echo ${Time}: AntiAFK
		eq2ex who all ${Me.Name}
		;wait between 5 and 7.5 mins
		wait ${Math.Rand[1500]:Inc[3000]}
	}
}