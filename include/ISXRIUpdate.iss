;update script for isxri, by herculezz 

function main(string ScriptName, string Full)
{
	;disable debugging
	Script:DisableDebugging
	
	echo ${Time}: ISXRI: Updating Extension
	relay all ext -unload isxri
	wait 10
	if ${Full.Upper.Equal[FULL]}
	{
		echo ${Time}: ISXRI: Downloading: RI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml" http://www.isxri.com/RI.xml
	}
	echo ${Time}: ISXRI: Downloading: ISXRI.dll, When complete reload Extension
	http -file "${LavishScript.HomeDirectory}/Extensions/ISXDK34/ISXRI.dll" http://www.isxri.com/ISXRI.dll
}