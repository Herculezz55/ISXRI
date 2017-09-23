function main()
{
	;disable debugging
	Script:DisableDebugging

	;unload extension
	ext -unload ISXRI
	
	;wait 1s
	wait 10
	
	;reload extension
	ext ISXRI
}