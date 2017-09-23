;Ritual v3 By Herculezz
variable(global) string RI_Var_String_Version=Ritual
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ossuary: The Altar of Malice [Raid]"]} || ${Math.Distance[${Me.Loc},359.57,0.01,-583.35]}>100
	{
		echo ${Time}: You must be in Ossuary: The Altar of Malice [Raid] and within 100 distance of 359.57,0.01,-583.35 to run this script.
		Script:End
	}
	
	;disable debugging
	Script:DisableDebugging
	
	echo ${Time}: Starting Ritual v4
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	UIElement[Start@RI]:SetText[Pause]
	UIElement[AutoLoot@RI]:Hide
	UIElement[RI]:SetHeight[40]
		
	;start RaidRelayGroup
	RRG
	
	;stop ogres movement if ogre exists so we can take control
	if ${ISXOgre(exists)}
	{
		OgreBotAtom a_LetsGo all
		OgreBotAtom a_QueueCommand DoNotMove
	}
	
	;start RIMovement
	if !${Script[Buffer:RIMovement]}
		RIMovement
		
	while !${Me.InCombat}
		wait 5
		
	if ${Me.Archetype.NotEqual[fighter]}
		RI_Atom_SetLockSpot ALL 357.57 0.01 -583.35
	
	while ${Actor["Ritual Keeper V'derin"](exists)} && !${Actor["Ritual Keeper V'derin"].IsDead}
	{
		wait 5
		if ${Me.Effect[detrimental,1].MainIconID}==808 || ${Me.Effect[detrimental,3].MainIconID}==808 || ${Me.Effect[detrimental,3].MainIconID}==808 || ${Me.Effect[detrimental,4].MainIconID}==808 || ${Me.Effect[detrimental,5].MainIconID}==808
		{
			;echo Cowardice MainIconID: ${Me.Effect[detrimental,"Cowardice"].MainIconID} BackDropIconID: ${Me.Effect[detrimental,"Cowardice"].BackDropIconID}
			;RI_Atom_SetLockSpot off
			;RI_Atom_MoveInFront 1 ${Actor["Ritual Keeper V'derin"].ID}
			RI_Atom_SetLockSpot ALL ${Actor["Ritual Keeper V'derin"].X} ${Actor["Ritual Keeper V'derin"].Y} ${Actor["Ritual Keeper V'derin"].Z}
			wait 50 ${Math.Distance[${Me.Loc},${Actor["Ritual Keeper V'derin"].X},${Actor["Ritual Keeper V'derin"].Y},${Actor["Ritual Keeper V'derin"].Z}]}<2
			wait 5
			if ${Me.Archetype.Equal[fighter]}
				RI_Atom_SetLockSpot FIGHTERS 352.47 0.00 -583.51
			else
				RI_Atom_SetLockSpot ALL 357.57 0.01 -583.35
			wait 10
			if ${Me.Archetype.Equal[fighter]}
				RI_Atom_SetLockSpot OFF
		}
	}
}
function atexit()
{
	echo Ending Ritual v4
	if ${Script[Buffer:RIMovement](exists)}
		RI_Atom_SetLockSpot off
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}