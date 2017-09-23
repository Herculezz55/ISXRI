function main()
{
	;disable debugging
	Script:DisableDebugging

	;unload ogre extension
	if ${Extension[ISXOgre.dll]}
		relay all -noredirect ext -unload ISXOgre
}