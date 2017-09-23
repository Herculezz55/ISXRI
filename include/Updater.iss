function main()
{
	;disable debugging
	Script:DisableDebugging

	;unload extension
	if ${Extension[ISXRI.dll]}
		relay all -noredirect ext -unload ISXRI
	if ${Extension[RI.dll]}
		relay all -noredirect ext -unload RI
	
	;wait 5s
	wait 50
	
	;reload extension
	relay all -noredirect ext ISXRI
	
	;remove ISXRIold.dll if it exists
	declare FP filepath "${LavishScript.HomeDirectory}/Extensions/ISXDK34"
	if ${FP.FileExists[ISXRIold.dll]}
		rm "${LavishScript.HomeDirectory}/Extensions/ISXDK34/ISXRIold.dll"
	if ${FP.FileExists[RI.dll]}
		rm "${LavishScript.HomeDirectory}/Extensions/ISXDK34/RI.dll"
	if ${FP.FileExists[RIold.dll]}
		rm "${LavishScript.HomeDirectory}/Extensions/ISXDK34/RIold.dll"
}