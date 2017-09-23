;Captain v5 by Herculezz
;
;make sure to do targeting while waiting to move back to plank, also sprit of the deep first before crewmemebers, also sometimes when capatin is away it doesnt target.
;
variable int PustuleSpawnCount=0
variable int Pustule[8]
variable int CrewmemberSpawnCount=0
variable int Crewmember[8]
variable bool AllPustulesSpawned=FALSE
variable bool FirstSpawn=FALSE
variable bool Trigger=FALSE
variable bool DoneMoving=TRUE
variable bool Moved=FALSE
variable float MainCampX=-313.05
variable float MainCampY=-15.25
variable float MainCampZ=-85.39
variable float FighterCampX=-316.80
variable float FighterCampY=-15.25
variable float FighterCampZ=-88.88
variable(global) int HC_Var_Int_Counter = 0
variable(global) int HC_Var_Int_SpawnCounter = 0
variable(global) string HC_Var_String_NameForHud = Pustules Spawn in
variable(global) int SpawnTime=${Time.SecondsSinceMidnight}
variable int CalcVar=0
variable int SpawnSeconds=46
variable int CrewCount=0
variable int CrewmemberWithHighestHealth=0
variable bool RecentlySetTargetCrewMember=FALSE
variable(global) string RI_Var_String_Version=Captain
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
;95,80,65,50,35,20,5 adds -5
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Brokenskull Bay: Fury of the Cursed [Raid]"]} || ${Math.Distance[${Me.Loc},-316.80,-15.25,-88.88]}>100
	{
		echo ${Time}: You must be in Brokenskull Bay: Fury of the Cursed [Raid] and within 100 distance of -316.80,-15.25,-88.88 to run this script.
		Script:End
	}
	
	echo ${Time}: Starting Captain v5

	;disable debugging
	Script:DisableDebugging
	
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
	
	;events
	Event[EQ2_ActorSpawned]:AttachAtom[EQ2_ActorSpawned]
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
		
	;set vars
	;if ${Name(exists)}
		;HC_Var_String_NameForHud:Set["${Name}"]
	HC_Var_Int_Counter:Set[0]
	
	;create hud
	Squelch HUD -add HudCountdown 300,300 ${HC_Var_String_NameForHud}: ${HC_Var_Int_Counter}s
	;HUD -add HudCountdown1 300,315 Saw ${HC_Var_Int_SpawnCounter} pustules
	
	;turn on lockpspot at MainCamp
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot ${Me.Name} ${FighterCampX} ${FighterCampY} ${FighterCampZ}
	else
		RI_Atom_SetLockSpot ${Me.Name} ${MainCampX} ${MainCampY} ${MainCampZ}]
		
	call WaitForCaptainCombat
	
	while ${Actor["Captain Krasnok"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Brokenskull Bay: Fury of the Cursed [Raid]"]} && ${Math.Distance[${Me.Loc},-316.80,-15.25,-88.88]}<100
	{
		;at 95,80,65,50,35,20,5 Move to globules
		if ${Actor["Captain Krasnok"].Health}<97 && ${Actor["Captain Krasnok"].Health}>95
			call TargetSelfAndMove
		if ${Actor["Captain Krasnok"].Health}<82 && ${Actor["Captain Krasnok"].Health}>80
			call TargetSelfAndMove
		if ${Actor["Captain Krasnok"].Health}<67 && ${Actor["Captain Krasnok"].Health}>65
			call TargetSelfAndMove
		if ${Actor["Captain Krasnok"].Health}<52 && ${Actor["Captain Krasnok"].Health}>50
			call TargetSelfAndMove
		if ${Actor["Captain Krasnok"].Health}<37 && ${Actor["Captain Krasnok"].Health}>35
			call TargetSelfAndMove
		if ${Actor["Captain Krasnok"].Health}<22 && ${Actor["Captain Krasnok"].Health}>20
			call TargetSelfAndMove
		if ${Actor["Captain Krasnok"].Health}<7 && ${Actor["Captain Krasnok"].Health}>5
			call TargetSelfAndMove
			
		call CaptainTargeting
		
		if ${Actor[corpse,radius,10](exists)}
		{
			eq2ex apply_verb ${Actor[corpse,radius,10].ID} Destroy Corpse
			eq2ex apply_verb ${Actor[corpse,radius,10].ID} Loot
		}
		;update hud
		call UpdateHUD
		
		;check for captain combat
		if !${Actor["Captain Krasnok"].InCombatMode} && ${Math.Distance[${Actor["Captain Krasnok"].Loc},-284,-16,-53]}>5
			call WaitForCaptainCombat
		wait 2
	}
}

;UpdateHUD function
function UpdateHUD()
{
	CalcVar:Set[${Math.Calc[${SpawnSeconds}-((${Time.SecondsSinceMidnight}-${SpawnTime})+1)]}]
	if ${CalcVar}>0 && ${FirstSpawn}
		HC_Var_Int_Counter:Set[${CalcVar}]
	else
		HC_Var_Int_Counter:Set[0]
}

;CaptainTargeting function
function CaptainTargeting()
{
	if ${Me.Archetype.Equal[fighter]}
	{
		if ${Actor["Spirit of the Deep"](exists)}
			Actor[Spirit of the Deep]:DoTarget
		elseif ${Actor["a Brokenskull crewmember"](exists)}
		{	
			echo ${Time}: Setting Target Crew Member
			CrewmemberWithHighestHealth:Set[${Crewmember[1]}]
			for(CrewCount:Set[1];${CrewCount}<=${Crewmember.Size};CrewCount:Inc)
			{
				if ${Actor[${Crewmember[${CrewCount}]}].Health}>${Actor[${CrewmemberWithHighestHealth}].Health}
					CrewmemberWithHighestHealth:Set[${Crewmember[${CrewCount}]}]
				wait 1
			}
			wait 5
			if ${Target.ID}!=${CrewmemberWithHighestHealth}
				Actor[${CrewmemberWithHighestHealth}]:DoTarget
		}
		elseif ${Actor["Spirit of Greed"](exists)}
			Actor[Spirit of Greed]:DoTarget
		elseif ${Actor["Spirit of Loathing"](exists)}
			Actor[Spirit of Loathing]:DoTarget
		else
			Actor["Captain Krasnok"]:DoTarget
	}
}

;TargetSelfAndMove function
function TargetSelfAndMove()
{
	Actor[${Me.ID}]:DoTarget
	call WaitForPustulesThenMove
	while !${Trigger} && ${Actor["Captain Krasnok"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Brokenskull Bay: Fury of the Cursed [Raid]"]} && ${Math.Distance[${Me.Loc},-316.80,-15.25,-88.88]}<100
	{
		call UpdateHUD
		wait 2
	}
	Trigger:Set[FALSE]
	declare counter int 0
	for(counter:Set[1];${counter}<100;counter:Inc)
	{
		call UpdateHUD
		call CaptainTargeting
		wait 1
	}
	RI_Atom_SetLockSpot ${Me.Name} ${FighterCampX} ${FighterCampY} ${FighterCampZ}
	if ${Me.Archetype.NotEqual[fighter]}
	{
		wait 50 ${Math.Distance[${Me.Loc},${FighterCampX},${FighterCampY},${FighterCampZ}]}<3
		RI_Atom_SetLockSpot ${Me.Name} ${MainCampX} ${MainCampY} ${MainCampZ}
	}
}

;WaitForPustulesThenMove function
function WaitForPustulesThenMove()
{
	RI_Atom_SetLockSpot ${Me.Name} ${FighterCampX} ${FighterCampY} ${FighterCampZ}
	while !${AllPustulesSpawned} && ${Actor["Captain Krasnok"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Brokenskull Bay: Fury of the Cursed [Raid]"]} && ${Math.Distance[${Me.Loc},-316.80,-15.25,-88.88]}<100
	{
		if ${Me.Archetype.Equal[fighter]}
			Actor[${Me.ID}]:DoTarget
		eq2ex pet backoff
		call UpdateHUD
		wait 2
	}
	call MoveToPustules
	Actor["Captain Krasnok"]:DoTarget
	eq2ex pet attack
	eq2ex pet autoassist	
}

;WaitForCaptainCombat function
function WaitForCaptainCombat()
{
	while !${Actor["Captain Krasnok"].InCombatMode} && ${Actor["Captain Krasnok"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Brokenskull Bay: Fury of the Cursed [Raid]"]} && ${Math.Distance[${Me.Loc},-316.80,-15.25,-88.88]}<100
		wait 2
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
   	; if ${Text.Find["Move to globs"](exists)}
	; {
		; echo ${Time}:IncomingText: ${Text}
		; Trigger:Set[TRUE]
	; }
	; if ${Text.Find["stop moving"](exists)}
	; {
		; echo ${Time}:IncomingText: ${Text}
		; Trigger:Set[FALSE]
	; }
	if ${Text.Find["Captain Krasnok the Immortal sends out the power of the greenmist curse against YOU!"](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		Trigger:Set[TRUE]
	}
}
function MoveToPustules()
{
	;if i am in raid positions
	if ${Me.Raid}>21
	{
		if ${Me.Raid[24].Name.Equal[${Me.Name}]} || ${Me.Raid[23].Name.Equal[${Me.Name}]} || ${Me.Raid[22].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[8]}].X} ${Actor[${Pustule[8]}].Y} ${Actor[${Pustule[8]}].Z}
		}
		wait 10
	}
	
	;if i am in raid positions
	if ${Me.Raid}>18
	{
		if ${Me.Raid[21].Name.Equal[${Me.Name}]} || ${Me.Raid[20].Name.Equal[${Me.Name}]} || ${Me.Raid[19].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[7]}].X} ${Actor[${Pustule[7]}].Y} ${Actor[${Pustule[7]}].Z}
		}
		wait 10
	}
	
	;if i am in raid positions
	if ${Me.Raid}>15
	{
		if ${Me.Raid[18].Name.Equal[${Me.Name}]} || ${Me.Raid[17].Name.Equal[${Me.Name}]} || ${Me.Raid[16].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[6]}].X} ${Actor[${Pustule[6]}].Y} ${Actor[${Pustule[6]}].Z}
		}
		wait 10
	}
	
	;if i am in raid positions
	if ${Me.Raid}>12
	{
		if ${Me.Raid[15].Name.Equal[${Me.Name}]} || ${Me.Raid[14].Name.Equal[${Me.Name}]} || ${Me.Raid[13].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[5]}].X} ${Actor[${Pustule[5]}].Y} ${Actor[${Pustule[5]}].Z}
		}
		wait 10
	}
	
	;if i am in raid positions
	if ${Me.Raid}>9
	{
		if ${Me.Raid[12].Name.Equal[${Me.Name}]} || ${Me.Raid[11].Name.Equal[${Me.Name}]} || ${Me.Raid[10].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[4]}].X} ${Actor[${Pustule[4]}].Y} ${Actor[${Pustule[4]}].Z}
		}
		wait 10
	}
	
	if ${Me.Raid}>6
	{
		;if i am in raid positions
		if ${Me.Raid[9].Name.Equal[${Me.Name}]} || ${Me.Raid[8].Name.Equal[${Me.Name}]} || ${Me.Raid[7].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[3]}].X} ${Actor[${Pustule[3]}].Y} ${Actor[${Pustule[3]}].Z}
		}
		wait 10
	}
	
	;if i am in raid positions
	if ${Me.Raid}>3
	{
		if ${Me.Raid[6].Name.Equal[${Me.Name}]} || ${Me.Raid[5].Name.Equal[${Me.Name}]} || ${Me.Raid[4].Name.Equal[${Me.Name}]}
		{
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[2]}].X} ${Actor[${Pustule[2]}].Y} ${Actor[${Pustule[2]}].Z}
		}
		wait 10	
	}
	
	;if i am in raid positions
	if ${Me.Raid[3].Name.Equal[${Me.Name}]} || ${Me.Raid[2].Name.Equal[${Me.Name}]} || ${Me.Raid[1].Name.Equal[${Me.Name}]}
	{
		RI_Atom_SetLockSpot ${Me.Name} ${Actor[${Pustule[1]}].X} ${Actor[${Pustule[1]}].Y} ${Actor[${Pustule[1]}].Z}
	}
	wait 10	
	AllPustulesSpawned:Set[FALSE]
}

function SortPustules()
{
	echo ${Time}: Sorting Pustules
	declare TempID int
	
	variable int count=0
	variable int count2=0
	for(count:Set[1];${count}<=${Pustule.Size};count:Inc)
	{
		for(count2:Set[1];${count2}<=${Pustule.Size};count2:Inc)
		{
			;echo ${Time}: ${Math.Distance[${Actor[${Pustule[${count2}]}].Loc},-316.80,-15.25,-88.88]}>${Math.Distance[${Actor[${Pustule[${count}]}].Loc},-316.80,-15.25,-88.88]}
			if ${Math.Distance[${Actor[${Pustule[${count2}]}].Loc},-316.80,-15.25,-88.88]}>${Math.Distance[${Actor[${Pustule[${count}]}].Loc},-316.80,-15.25,-88.88]}
			{
				TempID:Set[${Pustule[${count}]}]
				Pustule[${count}]:Set[${Pustule[${count2}]}]
				Pustule[${count2}]:Set[${TempID}]
			}
		}
    }
	echo ${Time}: Pustules Distance:
	echo ${Time}: ${Actor[${Pustule[1]}]}1: ${Math.Distance[${Actor[${Pustule[1]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[1]}].Loc}
	echo ${Time}: ${Actor[${Pustule[2]}]}2: ${Math.Distance[${Actor[${Pustule[2]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[2]}].Loc}
	echo ${Time}: ${Actor[${Pustule[3]}]}3: ${Math.Distance[${Actor[${Pustule[3]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[3]}].Loc}
	echo ${Time}: ${Actor[${Pustule[4]}]}4: ${Math.Distance[${Actor[${Pustule[4]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[4]}].Loc}
	echo ${Time}: ${Actor[${Pustule[5]}]}5: ${Math.Distance[${Actor[${Pustule[5]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[5]}].Loc}
	echo ${Time}: ${Actor[${Pustule[6]}]}6: ${Math.Distance[${Actor[${Pustule[6]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[6]}].Loc}
	echo ${Time}: ${Actor[${Pustule[7]}]}7: ${Math.Distance[${Actor[${Pustule[7]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[7]}].Loc}
	echo ${Time}: ${Actor[${Pustule[8]}]}8: ${Math.Distance[${Actor[${Pustule[8]}].Loc},-316.80,-15.25,-88.88]} : Loc: ${Actor[${Pustule[8]}].Loc}
}

atom EQ2_ActorSpawned(string ID, string Name, string Level)
{
	if ${Actor[${ID}].Name.Equal["a greenmist pustule"]}
	{
		if !${FirstSpawn}
			FirstSpawn:Set[TRUE]
		declare TempID int ${ID}
		echo ${TempID}
		echo ${Time}: ${Name} Spawned with ID: ${ID} Level: ${Level} and Loc: ${Actor[${ID}].Loc} and Distance ${Actor[${ID}].Distance}
		PustuleSpawnCount:Inc
		Pustule[${PustuleSpawnCount}]:Set[${TempID}]
		echo ${Time}: Pustule Spawned Setting to Variable Pustule[${PustuleSpawnCount}] which is  ${Pustule[${PustuleSpawnCount}]}
		if ${PustuleSpawnCount}==8
		{
			echo ${Time}:We reached 8
			PustuleSpawnCount:Set[0]
			AllPustulesSpawned:Set[TRUE]
			TimedCommand 20 Script[Buffer:Captain].Variable[AllPustulesSpawned]:Set[FALSE]
			call SortPustules
		}
		SpawnTime:Set[${Time.SecondsSinceMidnight}]
		if ${HC_Var_Int_SpawnCounter}<8
			HC_Var_Int_SpawnCounter:Inc
		else
			HC_Var_Int_SpawnCounter:Set[1]
	}
	if ${Actor[${ID}].Name.Equal["a Brokenskull crewmember"]}
	{
		declare TempID int ${ID}
		echo ${TempID}
		echo ${Time}: ${Name} Spawned with ID: ${ID} Level: ${Level} and Loc: ${Actor[${ID}].Loc} and Distance ${Actor[${ID}].Distance}
		CrewmemberSpawnCount:Inc
		Crewmember[${CrewmemberSpawnCount}]:Set[${TempID}]
		if ${CrewmemberSpawnCount}==6
		{
			echo ${Time}:We reached 6
			CrewmemberSpawnCount:Set[0]
		}
	}
}

;;;;;; OLD

function MoveToPustulesold(int PustuleNum)
{
	variable int count=0
	variable int Lowest=${Math.Distance[${Me.Raid[1].X},${Me.Raid[1].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}
	variable string LowestName=${Me.Raid[1]}
	variable int SecondLowest=${Math.Distance[${Me.Raid[2].X},${Me.Raid[2].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}
	variable string SecondLowestName=${Me.Raid[2]}
	variable int ThirdLowest=${Math.Distance[${Me.Raid[3].X},${Me.Raid[3].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}
	variable string ThirdLowestName=${Me.Raid[3]}
	;for loop to mark the 3 closest toons to pustule${PustuleNum}
	
	for(count:Set[1];${count}<=${Me.Raid};count:Inc)
	{
		if ${Math.Distance[${Me.Raid[${count}].X},${Me.Raid[${count}].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}<${Lowest}
		{
			Lowest:Set[${Math.Distance[${Me.Raid[${count}].X},${Me.Raid[${count}].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}]
			LowestName:Set[${Me.Raid[${count}]}]
		}
		elseif ${Math.Distance[${Me.Raid[${count}].X},${Me.Raid[${count}].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}<${SecondLowest}
		{
			SecondLowest:Set[${Math.Distance[${Me.Raid[${count}].X},${Me.Raid[${count}].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}]
			SecondLowestName:Set[${Me.Raid[${count}]}]
		}
		elseif ${Math.Distance[${Me.Raid[${count}].X},${Me.Raid[${count}].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}<${ThirdLowest}
		{
			ThirdLowest:Set[${Math.Distance[${Me.Raid[${count}].X},${Me.Raid[${count}].Z},${Actor[${Pustule[${PustuleNum}]}].X},${Actor[${Pustule[${PustuleNum}]}].Z}]}]
			ThirdLowestName:Set[${Me.Raid[${count}]}]
		}
	}
	echo ${Time}: ${LowestName} , ${SecondLowestName} , ${ThirdLowestName} are Closest to Pustule ${PustuleNum} at Distances: ${Lowest} , ${SecondLowest} , ${ThirdLowest}
	irc !c all -cs ${LowestName} -ccsw ${LowestName} ${Actor[${Pustule[${PustuleNum}]}].X} ${Actor[${Pustule[${PustuleNum}]}].Y} ${Actor[${Pustule[${PustuleNum}]}].Z}
	irc !c all -cs ${SecondLowestName} -ccsw ${SecondLowestName} ${Actor[${Pustule[${PustuleNum}]}].X} ${Actor[${Pustule[${PustuleNum}]}].Y} ${Actor[${Pustule${PustuleNum}8]}].Z}
	irc !c all -cs ${ThirdLowestName} -ccsw ${ThirdLowestName} ${Actor[${Pustule[${PustuleNum}]}].X} ${Actor[${Pustule[${PustuleNum}]}].Y} ${Actor[${Pustule[${PustuleNum}]}].Z}
}

;atexit function
function atexit()
{
	echo ${Time}: Ending Captain
	Squelch HUD -remove HudCountdown
	;HUD -remove HudCountdown1
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF	
	
	press -release ${RI_Var_String_ForwardKey}

		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}
