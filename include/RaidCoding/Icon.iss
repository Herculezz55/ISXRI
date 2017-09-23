;Icon  v2 by Herculezz
;still need to work on a few things, aggro control, also another thing the targeting when low to make sure he doesnt heal, the call out is an announce, uise it and use death ropevents

variable int FighterCount=1
variable(global) string RI_Var_String_Version=Icon
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
variable bool EquilibriumUP=FALSE
variable bool HolySalvationUP=FALSE
variable bool AncestralSaviorUP=FALSE
variable bool RedemptionUP=FALSE
variable bool AncestralAvengerUP=FALSE
variable int InPoolTime=-15000
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;atom triggered when an IncomingText is detected
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["Equilibrium Is UP"]}
		EquilibriumUP:Set[TRUE]
	if ${Text.Find["Holy Salvation Is UP"]}
		HolySalvationUP:Set[TRUE]
	if ${Text.Find["Ancestral Savior Is UP"]}
		AncestralSaviorUP:Set[TRUE]
	if ${Text.Find["Redemption Is UP"]}
		RedemptionUP:Set[TRUE]
	if ${Text.Find["Ancestral Avenger Is UP"]}
		AncestralAvengerUP:Set[TRUE]
	if ${Text.Find["Equilibrium Is DOWN"]}
		EquilibriumUP:Set[FALSE]
	if ${Text.Find["Holy Salvation Is DOWN"]}
		HolySalvationUP:Set[FALSE]
	if ${Text.Find["Ancestral Savior Is DOWN"]}
		AncestralSaviorUP:Set[FALSE]
	if ${Text.Find["Redemption Is DOWN"]}
		RedemptionUP:Set[FALSE]
	if ${Text.Find["Ancestral Avenger Is DOWN"]}
		AncestralAvengerUP:Set[FALSE]
}
atom CheckDPs()
{
	if ${Me.Archetype.Equal[priest]}
	{
		if ${Me.Ability[Equilibrium].IsReady} && !${EquilibriumUP}
			eq2ex g Equilibrium Is UP
		if ${Me.Ability["Holy Salvation"].IsReady} && !${HolySalvationUP}
			eq2ex g Holy Salvation Is UP
		if ${Me.Ability["Ancestral Savior"].IsReady} && !${AncestralSaviorUP}
			eq2ex g Ancestral Savior Is UP
		if ${Me.Ability[Redemption].IsReady} && !${RedemptionUP}
			eq2ex g Redemption Is UP
		if ${Me.Ability["Ancestral Avenger"].IsReady} && !${AncestralAvengerUP}
			eq2ex g Ancestral Avenger Is UP
		if !${Me.Ability[Equilibrium].IsReady} && ${Me.Ability[Equilibrium].TimeUntilReady}>0 && ${EquilibriumUP} && ${Me.Class.Equal[cleric]} && ${Me.Ability[Equilibrium](exists)}
			eq2ex g Equilibrium Is DOWN
		if !${Me.Ability["Holy Salvation"].IsReady} && ${Me.Ability["Holy Salvation"].TimeUntilReady}>0 && ${HolySalvationUP} && ${Me.SubClass.Equal[templar]}
			eq2ex g Holy Salvation Is DOWN
		if !${Me.Ability["Ancestral Savior"].IsReady} && ${Me.Ability["Ancestral Savior"].TimeUntilReady}>0 && ${AncestralSaviorUP} && ${Me.SubClass.Equal[mystic]}
			eq2ex g Ancestral Savior Is DOWN
		if !${Me.Ability[Redemption].IsReady} && ${Me.Ability[Redemption].TimeUntilReady}>0 && ${RedemptionUP} && ${Me.SubClass.Equal[inquisitor]}
			eq2ex g Redemption Is DOWN
		if !${Me.Ability["Ancestral Avenger"].IsReady} && ${Me.Ability["Ancestral Avenger"].TimeUntilReady}>0 && ${AncestralAvengerUP} && ${Me.SubClass.Equal[defiler]}
			eq2ex g Ancestral Avenger Is DOWN
	}
}
;atom triggered when an announcement is detected
atom EQ2_onAnnouncement(string Message, string SoundType, float Timer)
{
	echo ${Time}:Announce: ${Message}
	;if exists in the announce, execute
	if ${Message.Find["The crumbling icon shouts the name, "](exists)}
	{
		
		variable string temp
		temp:Set[${Message.Right[${Math.Calc[-1*(${Message.Find["The crumbling icon shouts the name, "]}+35)]}].Left[-1]}]
		echo ${temp}
		variable int count=0
		variable bool inmygroup
		inmygroup:Set[FALSE]
		for(count:Set[1];${count}<${Me.Group};count:Inc)
		{
			if ${temp.Equal[${Me.Group[${count}]}]}
				inmygroup:Set[TRUE]
		}
		if ${temp.Equal[${Me.Name}]}
			inmygroup:Set[TRUE]
		if ${inmygroup}
		{
			echo in my group
			if ${Me.Archetype.Equal[priest]}
			{
				if ${EquilibriumUP}
					TimedCommand 30 RI_CMD_Cast Equilibrium 1
				elseif ${HolySalvationUP}
					RI_CMD_CastOn "Holy Salvation" ${temp} 1
				elseif ${AncestralAvengerUP}
					RI_CMD_CastOn "Ancestral Avenger" ${temp} 1
				elseif ${AncestralSaviorUP}
					RI_CMD_CastOn "Ancestral Savior" ${temp} 1
				elseif ${RedemptionUP}
					RI_CMD_CastOn "Redemption" ${temp} 1
			}
		}
	}
}
atom CastDP(string CastOn)
{
	switch ${Me.SubClass}
	{
		case Templar
		{
			if ${Me.Ability["Equilibrium"].IsReady}
				TimedCommand 30 RI_Obj_CB:Cast["Equilibrium",1]
			elseif ${Me.Ability[Holy Salvation].IsReady}
				RI_Obj_CB:CastOn["Holy Salvation",${CastOn}1]
			break
		}
		case Mystir
		{
			if ${Me.Ability["Ancestral Savior"].IsReady}
				RI_Obj_CB:CastOn["Ancestral Savior",${CastOn},1]
			break
		}
		case Inquisitor
		{
			if ${Me.Ability["Redemption"].IsReady}
				RI_Obj_CB:CastOn["Redemption",${CastOn},1]
			break
		}
		case Defiler
		{
			if ${Me.Ability["Ancestral Avenger"].IsReady}
				RI_Obj_CB:CastOn["Ancestral Avenger",${CastOn},1]
			break
		}
	}
}
function main()
{
	
	; if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Zavith'loa: The Molten Pools [Raid]"]} || ${Math.Distance[${Me.Loc},-3337.95,12.25,98.60]}>100
	; {
		; echo ${Time}: You must be in Zavith'loa: The Molten Pools [Raid] and within 100 distance of -3337.95,12.25,98.60 to run this script.
		; Script:End
	; }
	
	echo ${Time}: Starting Icon v2
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	UIElement[Start@RI]:SetText[Pause]
	UIElement[AutoLoot@RI]:Hide
	UIElement[RI]:SetHeight[40]
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncement]
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
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
	
	;check DPs
	CheckDPs
		
	call Move -3323.3 12.53 86.62
	call Move -3331.9 15.32 101.29 
	call Move -3337.95 12.25 98.60
	
	;turn off assist
	RI_CMD_Assisting 0
	
	if ${Me.Archetype.Equal[fighter]}
	{
		;while The Crumbling Icon is not in combat
		while !${Actor["The Crumbling Icon"].InCombatMode}
			wait 2
			
		;call set fighters function
		call SetFighters
	}	
	
	;while The Crumbling Icon is not in combat
	while !${Actor["The Crumbling Icon"].InCombatMode}
		wait 2
		
	;main loop
	while ${Actor["The Crumbling Icon"](exists)} && !${Actor["The Crumbling Icon"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Zavith'loa: The Molten Pools [Raid]"]} && ${Math.Distance[${Me.Loc},-3337.95,12.25,98.60]}<300
	{	
		;while Icon is above 50 health
		while ${Actor["The Crumbling Icon"].Health}>50
		{
			;check DPs
			CheckDPs
			
			;check my distance
			; if ${Me.Archetype.NotEqual[fighter]} && ${Math.Distance[${Me.Loc},-3341.08,10,85.26]}<10 && ${Script.RunningTime}>${Math.Calc[${InPoolTime}+15000]}
			; {
				; echo i am in pool calling for DP
				; if ${EquilibriumUP}
					; relay all RI_CMD_Cast Equilibrium 1
				; elseif ${HolySalvationUP}
					; relay all RI_CMD_CastOn "Holy Salvation" ${Me.Name} 1
				; elseif ${AncestralAvengerUP}
					; relay all RI_CMD_CastOn "Ancestral Avenger" ${Me.Name} 1
				; elseif ${AncestralSaviorUP}
					; relay all RI_CMD_CastOn "Ancestral Savior" ${Me.Name} 1
				; elseif ${RedemptionUP}
					; relay all RI_CMD_CastOn "Redemption" ${Me.Name} 1
				; InPoolTime:Set[${Script.RunningTime}]
			; }
			if ${Me.Archetype.Equal[fighter]}
			{
				if ${Me.Effect[detrimental,1].MainIconID}==561
				{
					if ${Me.Effect[detrimental,1].CurrentIncrements}>3
						press f1
					elseif ${Me.Effect[detrimental,1].CurrentIncrements}<2
						Actor["The Crumbling Icon"]:DoTarget
				}
				elseif ${Me.Effect[detrimental,2].MainIconID}==561
				{
					if ${Me.Effect[detrimental,2].CurrentIncrements}>3
						press f1
					elseif ${Me.Effect[detrimental,2].CurrentIncrements}<2
						Actor["The Crumbling Icon"]:DoTarget
				}
				elseif ${Me.Effect[detrimental,3].MainIconID}==561
				{
					if ${Me.Effect[detrimental,3].CurrentIncrements}>3
						press f1
					elseif ${Me.Effect[detrimental,3].CurrentIncrements}<2
						Actor["The Crumbling Icon"]:DoTarget
				}
				elseif ${Me.Effect[detrimental,4].MainIconID}==561
				{
					if ${Me.Effect[detrimental,4].CurrentIncrements}>3
						press f1
					elseif ${Me.Effect[detrimental,4].CurrentIncrements}<2
						Actor["The Crumbling Icon"]:DoTarget
				}
				elseif ${Me.Effect[detrimental,5].MainIconID}==561
				{
					if ${Me.Effect[detrimental,5].CurrentIncrements}>3
						press f1
					elseif ${Me.Effect[detrimental,5].CurrentIncrements}<2
						Actor["The Crumbling Icon"]:DoTarget
				}
				;elseif !${Me.Effect[detrimental,"Overheating"](exists)}
				;	Actor["The Crumbling Icon"]:DoTarget
			}
			else 
				Actor["The Crumbling Icon"]:DoTarget
			
			wait 10
		}
		
		;turn on assist
		RI_CMD_Assisting 1
		
		if ${Me.Archetype.Equal[fighter]}
			call Move -3337.95 12.25 98.60
		while ${Actor["The Crumbling Icon"].Health}<51
		{	
			;check DPs
			CheckDPs
			
			;check group distance
			; if ${Me.Archetype.NotEqual[fighter]} && ${Math.Distance[${Me.Loc},-3337.95,12.25,98.60]}>5
			; {
				; echo i am too far calling for heal
				; CastMainSTHeal
				; wait 10
			; }
			if ${Me.Archetype.Equal[fighter]} && ${Actor[worshiper,radius,20](exists)} && ${Actor[worshiper,radius,20].Health}>97 && ${Actor["The Crumbling Icon"].Health}>5
				Actor[worshiper,radius,20]:DoTarget
			elseif ${Me.Archetype.Equal[fighter]} && ${Actor[fear,radius,20](exists)} && ${Actor["The Crumbling Icon"].Health}>5
				Actor[fear]:DoTarget
			elseif ${Me.Archetype.Equal[fighter]}
				Actor["The Crumbling Icon"]:DoTarget
			;if i am more than 100 from campspot and dead  Revive and run back
			if ${Me.IsDead}
				wait 20
			wait 2
			if ${Math.Distance[${Me.Loc},-3335,10,67]}>100 && ${Me.IsDead}
			{
				;echo ${Time}: Reviving
				eq2ex "select_junction 0"
				;wait until we start zoning
				wait 20000 ${EQ2.Zoning}
				;wait until we are not zoning
				wait 20000 !${EQ2.Zoning}
				wait 5
				;echo ${Time}: Starting to run
				call Move -3467.51 20.33 -144.93 
				call Move -3444 18.27 -147 
				call Move -3434.63 17.75 -134.43 
				call Move -3429.4 11.99 -95.73 
				call Move -3387.94 12.11 -73.68 
				call Move -3367.8 14.38 -47.82 
				call Move -3362.36 21.24 -20.99 
				call Move -3323.15 20.62 -9.29 
				call Move -3321.66 9.81 27.84 
				call Move -3333.3 10 66.62 
				call Move -3323.3 12.53 86.62 
				call Move -3331.9 15.32 101.29 
				call Move -3337.95 12.25 98.60  
			}
			wait 1
		}
		wait 1
	}
}
atom CastMainSTHeal()
{
	relay all RI_CMD_CastOn "Vital Intercession" ${Me.Name} 1
	relay all RI_CMD_CastOn "Ancestral Ward" ${Me.Name} 1
	relay all RI_CMD_CastOn "Penance" ${Me.Name} 1
	relay all RI_CMD_CastOn "Ancient Shroud" ${Me.Name} 1
}
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function Move(float mX,float mY,float mZ)
{
	if ${Math.Distance[${Me.Loc},-3337.95,12.25,98.60]}>10
		RI_Atom_SetLockSpot ${Me.Name} ${mX} ${mY} ${mZ}
	else
		RI_Atom_SetLockSpot ${Me.Name} -3337.95 12.25 98.60
	while ${Math.Distance[${Me.Loc},${mX},${mY},${mZ}]}>2 && ${Math.Distance[${Me.Loc},-3337.95,12.25,98.60]}>10
		wait 2
}
function Move2(float mX,float mY,float mZ)
{
	RI_Atom_SetLockSpot ${Me.Name} ${mX} ${mY} ${mZ}
	while ${Math.Distance[${Me.Loc},${mX},${mY},${mZ}]}>2 && ${Math.Distance[${Me.Loc},-3337.95,12.25,98.60]}>10
		wait 2
}
function SetFighters()
{
	;set me to the first element in FighterArray
	FighterArray[1]:Set[${Me.Name}]
	variable int count=0
	variable int count2=0
	declare temp string
	
	;count Fighters in raid
	for(count:Set[1];${count}<=${Me.Raid};count:Inc)
	{
		if ${Me.Raid[${count}].Name.NotEqual[${Me.Name}]}
		{
			echo ${Time}: Checking ${Me.Raid[${count}]} to see if they are a bard / ${Me.Raid[${count}].Class}
			if ${Me.Raid[${count}].Class.Equal[monk]} || ${Me.Raid[${count}].Class.Equal[bruiser]} || ${Me.Raid[${count}].Class.Equal[guardian]} || ${Me.Raid[${count}].Class.Equal[berserker]} || ${Me.Raid[${count}].Class.Equal[paladin]} || ${Me.Raid[${count}].Class.Equal[shadowknight]}
			{
				echo ${Time}: Found a Fighter in Raid Position ${count} / ${Me.Raid[${count}]}
				FighterCount:Inc
			}
		}
    }
	
	declare FighterArray[${FighterCount}] string
	FighterArray[1]:Set[${Me.Name}]
	declare FighterCount2 int 1
	;set Fighters in raid to FighterArray
	for(count:Set[1];${count}<=${Me.Raid};count:Inc)
	{
		if ${Me.Raid[${count}].Name.NotEqual[${Me.Name}]}
		{
			echo ${Time}: Checking ${Me.Raid[${count}]} to see if they are a bard / ${Me.Raid[${count}].Class}
			if ${Me.Raid[${count}].Class.Equal[monk]} || ${Me.Raid[${count}].Class.Equal[bruiser]} || ${Me.Raid[${count}].Class.Equal[guardian]} || ${Me.Raid[${count}].Class.Equal[berserker]} || ${Me.Raid[${count}].Class.Equal[paladin]} || ${Me.Raid[${count}].Class.Equal[shadowknight]}
			{
				echo ${Time}: Found a Fighter in Raid Position ${count} / ${Me.Raid[${count}]}
				FighterCount2:Inc
				FighterArray[${FighterCount2}]:Set[${Me.Raid[${count}]}]
			}
		}
    }
	
	;sort Fighter array by name
	for(count:Set[1];${count}<=${FighterArray.Size};count:Inc)
	{
		for(count2:Set[1];${count2}<=${FighterArray.Size};count2:Inc)
		{
			if ${FighterArray[${count2}].Compare[${FighterArray[${count}]}]}>0
			{
				temp:Set[${FighterArray[${count}]}]
				FighterArray[${count}]:Set[${FighterArray[${count2}]}]
				FighterArray[${count2}]:Set[${temp}]
			}
		}
    }
	
	echo ${Time}: There are ${FighterCount} Fighter's and the Order is As Follows: ${FighterArray[1]} Goes to Spot 1 / ${FighterArray[2]} Goes to Spot 2/ ${FighterArray[3]} stays and casts Subtle Strikes / ${FighterArray[4]} stays and casts Subtle Strikes
	
	if ${FighterArray[1].Equal[${Me.Name}]}
	{
		echo i am fighter one
		call Move2 -3327.62 12.77 95.96
		call Move2 -3322.32 11.88 83.01
		call Move2 -3331.71 12.13 77.12
	}
	elseif ${FighterArray[2].Equal[${Me.Name}]}
	{
		echo i am fighter 2
		call Move2 -3353.05 13.86 98.98
		call Move2 -3358.31 11.92 90.52
		call Move2 -3352.97 12.18 81.95
	}
	else
	{
		eq2ex usea "Subtle Strikes"
	}
}

function atexit()
{
	echo ${Time}: Ending Icon 
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}