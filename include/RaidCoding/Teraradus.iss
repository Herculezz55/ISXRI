variable bool Trigger=FALSE
variable(global) string RI_Var_String_Version=Teraradus
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Zavith'loa: The Molten Pools [Raid]"]} || ${Math.Distance[${Me.Loc},-3436.017090,18.182951,-164.208328]}>100
	{
		echo ${Time}: You must be in Zavith'loa: The Molten Pools [Raid] and within 100 distance of -3436.017090,18.182951,-164.208328 to run this script.
		Script:End
	}
	
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
	
	echo ${Time}: Starting Teraradus v1
	
	;disable debugging
	Script:DisableDebugging
	
	;announce event
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncement]
	
	;turn on lockspot and set to main camp
	;Ogre_CampSpot:Set_CampSpot[ALL]
	;Ogre_CampSpot:Set_ChangeCampSpot[ALL,-3436.017090,18.182951,-164.208328]
	RI_Atom_SetLockSpot ALL -3436.017090 18.182951 -164.208328
	wait 10
	
	;start aggrocontrol
	if ${Me.Archetype.Equal[fighter]} && !${Script[Buffer:AggroControl]}
		RI_AggroControl
	
	;while Teraradus the Gorer is not in combat
	while !${Actor["Teraradus the Gorer"].InCombatMode}
		wait 2	
	
	;if we are a fighter target Actor
	if ${Me.Archetype.Equal[fighter]}
	{
		Actor["Teraradus the Gorer"]:DoTarget
		;call maincamp function
		call MainCamp
	}
	
	;main do while loop
	while ${Actor["Teraradus the Gorer"](exists)} && !${Actor["Teraradus the Gorer"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Zavith'loa: The Molten Pools [Raid]"]} && ${Math.Distance[${Me.Loc},-3436.017090,18.182951,-164.208328]}<100
	{
		if ${Me.Archetype.Equal[fighter]}
		{
			if ${Target.ID}!=${Actor["Teraradus the Gorer"].ID} && ${Actor["Teraradus the Gorer"](exists)}
				Actor["Teraradus the Gorer"]:DoTarget
			
			;call JoustOut function if trigger
			if ${Trigger}
				call JoustOut
		}
		wait 2
	}
}
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;function to stand at maincamp, wait until the named is within 7m and then move to tank camp
function MainCamp()
{
	;main camp
	;Ogre_CampSpot:Set_ChangeCampSpot[ALL,-3436.017090,18.182951,-164.208328]
	RI_Atom_ChangeLockSpot ALL -3436.017090 18.182951 -164.208328
	
	;wait until we are there
	while ${Math.Distance[${Me.Loc},-3436.017090,18.182951,-164.208328]}>3
		wait 1
	
	;wait until the actor is within 7m
	wait 100 ${Actor["Teraradus the Gorer"].Distance}<8
		
	;tank camp
	;Ogre_CampSpot:Set_ChangeCampSpot[ALL,-3426.582764,18.182951,-158.108902]
	RI_Atom_ChangeLockSpot ALL -3426.582764 18.182951 -158.108902
		
	wait 10
}

;function to joust out to joust 1, wait until the named is within 7m and then move to joust 2
function JoustOut()
{
	;joust 1
	;Ogre_CampSpot:Set_ChangeCampSpot[ALL,-3408.657227,18.182951,-149.843338]
	RI_Atom_ChangeLockSpot ALL -3408.657227 18.182951 -149.843338
	
	;wait until we are there
	wait 100 ${Math.Distance[${Me.Loc},-3408.657227,18.182951,-149.843338]}<3
	
	;wait until the actor is within 7m
	wait 100 ${Actor["Teraradus the Gorer"].Distance}<8
		
	wait 10
	
	;2nd joust
	;Ogre_CampSpot:Set_ChangeCampSpot[ALL,-3419.203613,18.182951,-156.149268]
	RI_Atom_ChangeLockSpot ALL -3419.203613 18.182951 -156.149268
	
	;wait until we are there
	wait 100 ${Math.Distance[${Me.Loc},-3419.203613,18.182951,-156.149268]}<3

	wait 20
	
	;call maincamp function
	call MainCamp
	
	Trigger:Set[FALSE]
}

;atom triggered when an announcement is detected
atom EQ2_onAnnouncement(string Message, string SoundType, float Timer)
{
	echo ${Time}: Announce: ${Message}
		
	;if Teraradus the Gorer prepares to unleash a mighty roar! You may not want to be near him when he does! exists in the announce, execute
	if ${Message.Find["Teraradus the Gorer prepares to unleash a mighty roar! You may not want to be near him when he does!"](exists)}
		Trigger:Set[TRUE]
}

;on exit
function atexit()
{
	echo ${Time}: Ending Teraradus v1
	;end aggrocontrol
	if ${Me.Archetype.Equal[fighter]} && ${Script[Buffer:AggroControl]}
		Endscript Buffer:AggroControl
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}