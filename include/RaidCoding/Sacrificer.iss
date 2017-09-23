variable(global) int IncCount=1
variable(global) bool Timed=FALSE
variable(global) string RI_Var_String_Version=Sacrificer
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ossuary: Cathedral of Bones [Raid]"]} || ${Math.Distance[${Me.Loc},434.085452,-11.446360,-17.792808]}>100
	{
		echo ${Time}: You must be in Ossuary: Cathedral of Bones [Raid] and within 100 distance of 434.08,-11.44,-17.79 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Sacrificer v28
	
	;disable debugging
	Script:DisableDebugging
	
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
	
	;Hud -add 1 200,250 Left(exists): ${Me.Effect[detrimental,"Sanguine Chorus"](exists)}  CurrentIncrements: ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}
	;Hud -add 2 200,265 Middle(exists): ${Me.Effect[detrimental,"Sanguine Embrace"](exists)}  CurrentIncrements: ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}
	;Hud -add 3 200,280 Right(exists): ${Me.Effect[detrimental,"Sanguine Touch"](exists)}  CurrentIncrements: ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}
	;Hud -add 4 200,295 Waiting at each spot until we get to ${IncCount}
	;turn on move to area and set up for sacrificer
	; Ogre_CampSpot:Set_CampSpot[ALL]
	; RI_Atom_SetLockSpot ${Me.Name},414.325452,-11.446360,-6.952808]
	; while !${Me.Effect[detrimental,"Sanguine Chorus"](exists)}
	; {
		; if ${Me.Effect[detrimental,"Sanguine Splash"](exists)}
			; call MoveToPools
		; wait 1
	; }
	; TimedCommand 300 Timed:Set[TRUE]
	while ${Me.GetGameData[Self.ZoneName].Label.Equal["Ossuary: Cathedral of Bones [Raid]"]} && ${Math.Distance[${Me.Loc},434.085452,-11.446360,-17.792808]}<100
	{
		
		Me:InitializeEffects
		wait 10
		if ${Me.Effect[detrimental,"Sanguine Splash"](exists)}
			call MoveToPools
		; if ${Timed}
		; {
			; echo ${Time}:Incrementing IncCount
			; IncCount:Inc
			; Timed:Set[FALSE]
			; TimedCommand 300 Timed:Set[TRUE]
		; }
		; if ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}>${IncCount}
		; {
			; echo ${Time}: moving to left side
			; RI_Atom_SetLockSpot ${Me.Name},414.325452,-11.446360,-6.952808]
		; }
		; while 1
		; {
			; if ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}<=${IncCount}
				; break
			; if ${Me.Effect[detrimental,"Sanguine Splash"](exists)}
				; call MoveToPools
			; wait 10
		; }
		; wait 2
		; if ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}>${IncCount}
		; {
			; echo ${Time}: moving to middle
			; RI_Atom_SetLockSpot ${Me.Name},434.085452,-11.446360,-17.792808]
		; }
		; while 1
		; {
			; if ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}<=${IncCount}
					; break
			; if ${Me.Effect[detrimental,"Sanguine Splash"](exists)}
				; call MoveToPools
			; wait 10
		; }
		; wait 2
		; if ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}>${IncCount}
		; {
			; echo ${Time}: moving to right
			; RI_Atom_SetLockSpot ${Me.Name},415.775452,-11.446360,-40.192808]
		; }
		; while 1
		; {
			; if ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}<=${IncCount}
				; break
			; if ${Me.Effect[detrimental,"Sanguine Splash"](exists)}
				; call MoveToPools
			; wait 10
		; }
		wait 2
	}
}
function CastOn(string AbilityName, string PlayerName, bool CancelCast)
{
	;echo ${Time}: Casting ${AbilityName}
	;if Ogre exists
	if ${ISXOgre(exists)}
	{
		OgreBotAtom a_CastFromUplinkOnPlayer ${Me.Name} "${AbilityName}" ${PlayerName} ${CancelCast}
		wait 5 !${Me.Ability["${AbilityName}"].IsReady}
	}
	;if ogre doesn't exists
	else
	{
		;if we want to cancel cast, send in game commands to cancel our cast 
		;and clear the queue until we are no longer casting, then cast AbilityName
		if ${CancelCast}
		{
			while ${Me.CastingSpell}
			{
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				waitframe
			}
			while ${Me.Ability["${AbilityName}"].IsReady}
			{
				eq2ex useabilityonplayer ${PlayerName} "${AbilityName}"
				waitframe
			}
		}
		;if we dont want to cancel cast, wait until we are done casting and
		;cast AbilityName
		else
		{
			while ${Me.CastingSpell}
				waitframe
			while ${Me.Ability["${AbilityName}"].IsReady}
			{
				eq2ex useabilityonplayer ${PlayerName} "${AbilityName}"
				waitframe
			}
		}
	}
}
function Cast(string AbilityName, bool CancelCast)
{
	;echo ${Time}: Casting ${AbilityName}
	;if Ogre exists
	if ${ISXOgre(exists)}
	{
		OgreBotAtom a_CastFromUplink ${Me.Name} "${AbilityName}" ${CancelCast}

		wait 5 !${Me.Ability["${AbilityName}"].IsReady}
	}
	;if ogre doesn't exists
	else
	{
		;if we want to cancel cast, send in game commands to cancel our cast 
		;and clear the queue until we are no longer casting, then cast AbilityName
		if ${CancelCast}
		{
			while ${Me.CastingSpell}
			{
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				waitframe
			}
			while ${Me.Ability["${AbilityName}"].IsReady}
				Me.Ability[${AbilityName}]:Use
		}
		;if we dont want to cancel cast, wait until we are done casting and
		;cast AbilityName
		else
		{
			while ${Me.CastingSpell}
				waitframe
			while ${Me.Ability["${AbilityName}"].IsReady}
				Me.Ability[${AbilityName}]:Use
		}
	}
}
function MoveToPools()
{
	if ${Actor[Sacrificer].Target.ID}==${Me.ID} && ${Me.Archetype.Equal[fighter]}
		relay all -noredirect Script[Buffer:Sacrificer]:QueueCommand["call CastOn ""Sever Hate"" ${Me.Name} TRUE"]
	echo ${Time}: moving to pools
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	RI_Atom_SetLockSpot ${Me.Name} 505.046356 -2.062326 -22.802351
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	while ${Math.Distance[${Me.X},${Me.Z},505.046356,-22.802351]}>3
		wait 1
	wait 1
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	RI_Atom_SetLockSpot ${Me.Name} 506.816071 -1.742864 -15.310714
	while ${Math.Distance[${Me.X},${Me.Z},506.816071,-15.310714]}>3
		wait 1
	wait 1
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	RI_Atom_SetLockSpot ${Me.Name} 482.090759 -0.005361 -20.608763
	while ${Math.Distance[${Me.X},${Me.Z},482.090759,-20.6087634]}>3
		wait 1
	wait 1
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	RI_Atom_SetLockSpot ${Me.Name} 433.224426 -11.446360 -7.722808
	while ${Math.Distance[${Me.X},${Me.Z},433.224426,-7.722808]}>3
		wait 1
	wait 1
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	RI_Atom_SetLockSpot ${Me.Name} 435.579193 -11.446363 34.746151
	while ${Math.Distance[${Me.X},${Me.Z},435.579193,34.746151]}>3
		wait 1
	wait 1
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	RI_Atom_SetLockSpot ${Me.Name} 434.085452 -11.446360 -17.792808
	while ${Math.Distance[${Me.X},${Me.Z},434.085452,-17.792808]}>3
		wait 1
	wait 1
	if !${Me.Maintained[Sprint](exists)}
		call Cast "Sprint" TRUE
	echo ${Time}: done moving to pools
	RI_Atom_SetLockSpot off
	wait 10
	Me.Maintained[Sprint]:Cancel
}
function oldway()
{
;if Sanguine Chorus is highest move there 
		if ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}>${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements} && ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}>${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}
		{
			echo ${Time}: moving to left side
			RI_Atom_SetLockSpot ${Me.Name},414.325452,-11.446360,-6.952808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Chorus"](exists)} )
		}
		;if Sanguine Embrace is highest move there
		elseif ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}>${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements} && ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}>${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}
		{
			echo ${Time}: moving to middle
			RI_Atom_SetLockSpot ${Me.Name},434.085452,-11.446360,-17.792808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Embrace"](exists)} )
		}
		;if Sanguine Touch is highest move there
		elseif ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}>${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements} && ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}>${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}
		{
			echo ${Time}: moving to right
			RI_Atom_SetLockSpot ${Me.Name},415.775452,-11.446360,-40.192808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Touch"](exists)} )
		}
		
		;if Chorus equals any of the rest and we are closest
		elseif ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}==${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements} && ${Math.Distance[${Me.X},${Me.Z},414,-7]}<${Math.Distance[${Me.X},${Me.Z},434,-17]}
		{
			echo ${Time}: moving to left side
			RI_Atom_SetLockSpot ${Me.Name},414.325452,-11.446360,-6.952808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Chorus"](exists)} )
		}
		elseif ${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements}==${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements} && ${Math.Distance[${Me.X},${Me.Z},414,-7]}<${Math.Distance[${Me.X},${Me.Z},415,-40]}
		{
			echo ${Time}: moving to left side
			RI_Atom_SetLockSpot ${Me.Name},414.325452,-11.446360,-6.952808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Chorus"](exists)} )
		}
		
		;if Embrace equals any of the rest and we are closest
		elseif ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}==${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements} && ${Math.Distance[${Me.X},${Me.Z},434,-17]}<${Math.Distance[${Me.X},${Me.Z},414,-7]}
		{
			echo ${Time}: moving to middle
			RI_Atom_SetLockSpot ${Me.Name},434.085452,-11.446360,-17.792808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Embrace"](exists)} )
		}
		elseif ${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements}==${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements} && ${Math.Distance[${Me.X},${Me.Z},434,-17]}<${Math.Distance[${Me.X},${Me.Z},415,-40]}
		{
			echo ${Time}: moving to middle
			RI_Atom_SetLockSpot ${Me.Name},434.085452,-11.446360,-17.792808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Embrace"](exists)} )
		}
		
		;if Touch equals any of the rest and we are closest
		elseif ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}==${Me.Effect[detrimental,"Sanguine Chorus"].CurrentIncrements} && ${Math.Distance[${Me.X},${Me.Z},415,-40]}<${Math.Distance[${Me.X},${Me.Z},414,-7]}
		{
			echo ${Time}: moving to right
			RI_Atom_SetLockSpot ${Me.Name},415.775452,-11.446360,-40.192808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Touch"](exists)} )
		}
		elseif ${Me.Effect[detrimental,"Sanguine Touch"].CurrentIncrements}==${Me.Effect[detrimental,"Sanguine Embrace"].CurrentIncrements} && ${Math.Distance[${Me.X},${Me.Z},415,-40]}<${Math.Distance[${Me.X},${Me.Z},434,-17]}
		{
			echo ${Time}: moving to right
			RI_Atom_SetLockSpot ${Me.Name},415.775452,-11.446360,-40.192808]
			wait 80 ( ${Me.Effect[detrimental,"Sanguine Splash"](exists)} || !${Me.Effect[detrimental,"Sanguine Touch"](exists)} )
		}
		else
			echo ${Time}: we are at correct spot not moving
}
function atexit()
{
	echo ${Time}: Ending Sacrificer v28
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}