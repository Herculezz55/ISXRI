;Jessip v8 by herculezz

variable string Testvar
variable bool Trigger=FALSE
variable float MainCampX=-162.91
variable float MainCampY=7.66
variable float MainCampZ=-159.94
variable float MainCampTankX=-170.22
variable float MainCampTankY=7.61
variable float MainCampTankZ=-159.67
variable float JoustSpotX=-137.42
variable float JoustSpotY=7.30
variable float JoustSpotZ=-160.01
variable(global) string RI_Var_String_Version=Jessip
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Brokenskull Bay: Fury of the Cursed [Raid]"]} || ${Math.Distance[${Me.Loc},-162.91,7.66,-159.94]}>100
	{
		echo ${Time}: You must be in Brokenskull Bay: Fury of the Cursed [Raid] and within 100 distance of -162.91,7.66,-159.94 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Jessip v8
	
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
	
	;disable debugging
	Script:DisableDebugging
	
	;while Jessip Daggerheart is not in combat
	while !${Actor["Jessip Daggerheart"].InCombatMode}
		wait 2
		
	;lockspot at MainCamp
	RI_Atom_SetLockSpot ${Me.Name} ${MainCampX} ${MainCampY} ${MainCampZ}
	
	if ${Me.Archetype.Equal[fighter]}
	{
		wait 100 ${Actor["Jessip Daggerheart"].Distance}<7
		RI_Atom_SetLockSpot ${Me.Name} ${MainCampTankX} ${MainCampTankY} ${MainCampTankZ}
	}
	
	;attach atom for incoming text trigger
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;get Jessip's id
	declare JessipID int ${Actor["Jessip Daggerheart"].ID}
	
	;main loop
	while ${Me.GetGameData[Self.ZoneName].Label.Equal["Brokenskull Bay: Fury of the Cursed [Raid]"]} && ${Math.Distance[${Me.Loc},-162.91,7.66,-159.94]}<100
	;${Actor[${JessipID}](exists)} && !${Actor[${JessipID}].IsDead}
	{
		if ${Trigger}
		{
			call Joust
		}
		if ${Me.Archetype.Equal[fighter]}
		{
			if ${Actor[${JessipID}].Health}<55 && ${Actor[Jessip,notid,${JessipID}](exists)}
				Actor[Jessip,notid,${JessipID}]:DoTarget
			else
				Actor[${JessipID}]:DoTarget
		}
		wait 2
	}
}
;atom triggered when incoming text is detected
atom EQ2_onIncomingText(string Text)
{
   	if ${Text.Find["#FFFF00Jessip Daggerheart is attempting to sneak up on "](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		Testvar:Set[${Text}]
		if ( ${Me.Raid[3].Name.Equal[${Me.Name}]} || ${Me.Raid[6].Name.Equal[${Me.Name}]} )
		{
			eq2ex r ${Testvar.Right[-55]} Joust
			eq2ex tell ${Testvar.Right[-55]} ${Testvar.Right[-55]} Joust
		}
		;irc !c all -cs ${Testvar.Right[-55]} -ccsw ${Testvar.Right[-55]} ${JoustSpotX} ${JoustSpotY} ${JoustSpotZ}
		;put an if statement in here for if they are one of the 6 tank classes to send to tank spot else this one
		;TimedCommand 100 irc !c all -cs ${Testvar.Right[-55]} -ccsw ${Testvar.Right[-55]} ${MainCampX} ${MainCampY} ${MainCampZ}
	}
	if ${Text.Find["${Me.Name} Joust"](exists)}
		Trigger:Set[TRUE]
}
function Joust()
{
	Trigger:Set[FALSE]
	;change campspot to joust spot
	RI_Atom_SetLockSpot ${Me.Name} ${JoustSpotX} ${JoustSpotY} ${JoustSpotZ}
	
	;wait until she gives up	
	wait 80
	
	;change campspot to Main Camp
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot ${Me.Name} ${MainCampTankX} ${MainCampTankY} ${MainCampTankZ}
	else
		RI_Atom_SetLockSpot ${Me.Name} ${MainCampX} ${MainCampY} ${MainCampZ}
}
function atexit()
{
	echo ${Time}: Ending Jessip
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}