;OgrePlayNice.iss by Herculezz v1 10-27-14
;companion script for RunInstances that will Pause RI when ogre is paused

function main()
{
	;disable debugging
	Script:DisableDebugging
	
	;if our main script is not running echo and end
	if !${Script[Buffer:RunInstances](exists)}
	{
		echo Please type RI in the console, This script cannot be run by itself
		return
	}
	
	;main loop
	do
	{
		;if we pause ogre pause RI
		if ${b_OB_Paused} && ${ISXOgre(exists)}
			RI_Var_Bool_Paused:Set[TRUE]
			
		;if we unpause ogre unpause RI
		if !${b_OB_Paused} && ${ISXOgre(exists)}
			RI_Var_Bool_Paused:Set[FALSE]
			
		;if ogre is not loaded. end script
		elseif !${ISXOgre(exists)}
			Script:End
		wait 1
	}
	while ${RI(exists)}
}