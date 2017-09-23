function main()
{
	;disable debugging
	Script:DisableDebugging

	;unload extension
	if ${Extension[ISXRI.dll]}
		relay all -noredirect ext -unload ISXRI
	if ${Extension[RI.dll]}
		relay all -noredirect ext -unload RI
}