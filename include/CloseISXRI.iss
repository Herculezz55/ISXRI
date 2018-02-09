function main()
{
	;disable debugging
	Script:DisableDebugging

	;unload extension
	if ${Extension[ISXRI.dll]}
		relay "all local" -noredirect ext -unload ISXRI
	if ${Extension[RI.dll]}
		relay "all local" -noredirect ext -unload RI
}