;Virtuoso v16 by Herculezz

;need to add a call out to cast ST heals on person who goes up.

;rewrote viel of notes to not server call
;changed a bug that was using DyniamicAssist instead of AutoAssist
;rewrote joust curse to check for curse instead of the server call det
;changed a few campspot positions
;made the 2 different cursed members goto opposite sides, and tank stays.
;made tank move to camp then back to tank camp to reposition on knockup and on first pull

variable bool Trigger=FALSE
variable string TriggerMessage
variable int SongCount=0
variable int WaitTime=5
variable int MyNum
variable string BardArray[6]
variable int BardCount=1
variable string OtherCursedToonName
variable int VeilOfNotesMainIconID=39
variable(global) string RI_Var_String_Version=Virtuoso
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE

;C key id now is obtained automatically
variable int cID=${Actor[loc,-512.367798,-25.463463].ID}
variable int dID=${Math.Calc[${cID}+1]}
variable int eID=${Math.Calc[${cID}+2]}
variable int fID=${Math.Calc[${cID}+3]}
variable int gID=${Math.Calc[${cID}+4]}
variable int aID=${Math.Calc[${cID}+5]}
variable int bID=${Math.Calc[${cID}+6]}

;campspots
variable int TankX=-497
variable int TankZ=-23
variable int RaidX=-512
variable int RaidZ=-25
variable int JoustX=-503
variable int JoustZ=-10
variable int Joust2X=-503
variable int Joust2Z=-40
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Ossuary: Cathedral of Bones [Raid]"]} || ${Math.Distance[${Me.Loc},-495.94,-0.47,-23.40]}>100
	{
		echo ${Time}: You must be in Ossuary: Cathedral of Bones [Raid] and within 100 distance of -495.94,-0.47,-23.40 to run this script.
		Script:End
	}
	
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
	
	;if I am a fighter, set my num to 7
	if ${Me.Class.NotEqual[bard]}
		MyNum:Set[7]
				
	;call SetBards if bard
	if ${Me.Class.Equal[bard]}
		call SetBards
	else
		wait 10
		
	echo ${Time}: Starting Virtuoso v16
	echo --------------------
	echo your number is ${MyNum}
	echo to change type MyNum #
	echo on your console
	echo c key's ID is ${cID}
	echo there are ${BardCount} Bards
	echo --------------------
	
	;turn off absorb magic
	RI_CMD_AbilityEnableDisable "Absorb Magic" 1
	
	;event
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;while virtuoso is not in combat
	while !${Actor["Virtuoso Edgar V'Zann"].InCombatMode}
		wait 2	
	
	RI_Atom_SetLockSpot ALL
	
	;if I am a fighter, move to -511,0,-23
	if ${Me.Archetype.Equal[fighter]}
	{
		RI_Atom_SetLockSpot ${Me.Name} ${RaidX} 0 ${RaidZ}
		wait 50 ${Math.Distance[${Me.X},${Me.Z},${RaidX},${RaidZ}}]}<2
		wait 50 ${Actor["Virtuoso Edgar V'Zann"].Distance}<8
		RI_Atom_SetLockSpot ${Me.Name} ${TankX} 0 ${TankZ}
	}
	;else, move to ${RaidX},0,${RaidZ}
	else
		RI_Atom_SetLockSpot ${Me.Name} ${RaidX} 0 ${RaidZ}
	
	declare count int 0
	
	;while Virtuoso Edgar V'Zann exists
	while ${Actor["Virtuoso Edgar V'Zann"](exists)} && ${Me.GetGameData[Self.ZoneName].Label.Equal["Ossuary: Cathedral of Bones [Raid]"]} && ${Math.Distance[${Me.Loc},-495.94,-0.47,-23.40]}<100
	{
		;check our Y
		call CheckY
		
		;if i have a curse
		if ${Me.Cursed}==-1 && ${Me.Archetype.NotEqual[fighter]}
		{
			;wait for others to be cursed
			wait 5
			
			;determine other cursed persons name
			for(count:Set[1];${count}<=${Me.Raid};count:Inc)
			{
				;set other cursed toons name
				if ${Me.Raid[${count}].Cursed}==-1 && ${Me.Raid[${count}].Name.NotEqual[${Me.Name}]}
					OtherCursedToonName:Set[${Me.Raid[${count}].Name}]
				waitframe
			}
			
			if ${OtherCursedToonName.Compare[${Me.Name}]}>0
				RI_Atom_SetLockSpot ${Me.Name} ${JoustX} 0 ${JoustZ}
			else
				RI_Atom_SetLockSpot ${Me.Name} ${Joust2X} 0 ${Joust2Z}
				
			;while our curse exists, wait 5
			while ${Me.Cursed}==-1 && !${Trigger}
				wait 5
				
			;if I am a fighter, move to -511,0,-23
			if ${Me.Archetype.Equal[fighter]}
			{
				RI_Atom_SetLockSpot ${Me.Name} ${RaidX} 0 ${RaidZ}
				wait 50 ${Math.Distance[${Me.X},${Me.Z},${RaidX},${RaidZ}]}<2
				RI_Atom_SetLockSpot ${Me.Name} ${TankX} 0 ${TankZ}
			}
			
			;else, move to ${RaidX},0,${RaidZ}
			else
			{
				RI_Atom_SetLockSpot ${Me.Name} -508 0 -24
				wait 50 ${Math.Distance[${Me.X},${Me.Z},-508,-24]}<2
				RI_Atom_SetLockSpot ${Me.Name} ${RaidX} 0 ${RaidZ}
			}
		}

		;check for veil of notes, if virtuoso is under 51
		if ${Actor["Virtuoso Edgar V'Zann"].Health}<51
			call CheckVeil
			
		if ${Trigger}
		{
			;if we are a bard or fighter
			;if ${Me.Class.Equal[bard]} || ${Me.Archetype.Equal[fighter]}
			;{
				;if we are number 1 && songcount is 1
				if ${MyNum}==1 && ${SongCount}==1
					call Piano
				elseif ${MyNum}==2 && ${SongCount}==2
					call Piano
				elseif ${MyNum}==3 && ${SongCount}==3
					call Piano
				elseif ${MyNum}==4 && ${SongCount}==4
					call Piano
				elseif ${MyNum}==5 && ${SongCount}==5
					call Piano
				elseif ${MyNum}==6 && ${SongCount}==6
					call Piano
					
				;set trigger false
				Trigger:Set[FALSE]
			;}
		}
		wait 2
	}
}

;CheckVeil function
function CheckVeil()
{
	if ${Actor["Virtuoso Edgar V'Zann"].Effect[1].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[2].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[3].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[4].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[5].MainIconID} == ${VeilOfNotesMainIconID}
	{
		if ${Me.Archetype.Equal[mage]} && ${Me.Ability["Absorb Magic"].IsReady}
		{
			;turn off assist
			RI_CMD_Assisting 0
			waitframe
			
			;pausebots
			RI_CMD_PauseCombatBots 1
			
			;target Virtuoso Edgar V'Zann
			Actor["Virtuoso Edgar V'Zann"]:DoTarget
			

			
			press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;keep attempting to cast absorb magic until it is no longer ready (aka casted)
			do
			{
				Me.Ability["Absorb Magic"]:Use
				wait 1
			}
			while ${Me.Ability["Absorb Magic"].IsReady}
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;unpausebots
			RI_CMD_PauseCombatBots 0
			waitframe
			
			;turn on assist
			RI_CMD_Assisting 1
		}
		if ${Me.Archetype.Equal[fighter]}
		{
			;while Virtuoso Edgar V'Zann has Veil of Notes
			while ${Actor["Virtuoso Edgar V'Zann"].Effect[1].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[2].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[3].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[4].MainIconID} == ${VeilOfNotesMainIconID} || ${Actor["Virtuoso Edgar V'Zann"].Effect[5].MainIconID} == ${VeilOfNotesMainIconID}
			{	
				;if i am not targeting myself, do it
				if ${Target.ID}!=${Me.ID}
					Actor[${Me.ID}]:DoTarget
					
				;check y
				call CheckY
				
				wait 5
			}
			
			;target Virtuoso Edgar V'Zann, if fighter
			Actor["Virtuoso Edgar V'Zann"]:DoTarget
		}
	}
}

;CheckY function
function CheckY()
{
	if ${Math.Distance[${Me.Y},0]}>2 && ${Me.Archetype.Equal[fighter]} && ${Actor["Virtuoso Edgar V'Zann"].Target.ID}==${Me.ID}
	{
		RI_Atom_SetLockSpot ${Me.Name} -508 0 -24
		wait 50 ${Math.Distance[${Me.Y},0]}<1
		RI_Atom_SetLockSpot ${Me.Name} ${RaidX} 0 ${RaidZ}
		wait 10
		RI_Atom_SetLockSpot ${Me.Name} ${TankX} 0 ${TankZ}
		TimedCommand 20 Face Virtuoso
	}
}

function Piano()
{
	;move to -511,0,-25
	RI_Atom_SetLockSpot ${Me.Name} -511 0 -25
		
	;turn off assist
	RI_CMD_Assisting 0
	waitframe
			
	;pausebots
	RI_CMD_PauseCombatBots 1
			
	;wait until we are at the piano
	wait 150 ${Math.Distance[${Me.X},${Me.Z},-511,-25]}<1
	
	wait 10
	
	;if the triggermessage includes ice, or flame or water, call PlayPiano for corresponding
	if ${TriggerMessage.Find[ice](exists)}
		call PlayPiano ice
	elseif ${TriggerMessage.Find[flame](exists)}
		call PlayPiano flame
	elseif ${TriggerMessage.Find[water](exists)}
		call PlayPiano water
		
	;turn off lockspot
	RI_Atom_SetLockSpot ${Me.Name} OFF
	RI_Atom_SetRIFollow ${Me.Name} OFF
	
	;while loop while The Pipe Organ Cleaner does not exist
	while !${Actor["The Pipe Organ Cleaner"](exists)}
		wait 2
	
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;while loop while The Pipe Organ Cleaner exists and is not dead
	while ${Actor["The Pipe Organ Cleaner"](exists)} && !${Actor["The Pipe Organ Cleaner"].IsDead}
	{
	
		;if i am not targeting The Pipe Organ Cleaner, DoTarget
		if ${Target.ID}!=${Actor["The Pipe Organ Cleaner"].ID}
			Actor["The Pipe Organ Cleaner"]:DoTarget
		
		;if my auto attack is not on, turn it on		
		if !${Me.AutoAttackOn}
			eq2ex autoattack 1
	}
	
	;turn on assist
	RI_CMD_Assisting 1
	
	;turn on lockspot to ${RaidX},0,${RaidZ}
	RI_Atom_SetLockSpot ${Me.Name} ${RaidX} 0 ${RaidZ}
}
function SetBards()
{
	;set me to the first element in BardArray
	BardArray[1]:Set[${Me.Name}]
	variable int count=0
	variable int count2=0
	declare temp string
	
	;set bards in bard array
	for(count:Set[1];${count}<=${Me.Raid};count:Inc)
	{
		if ${Me.Raid[${count}].Name.NotEqual[${Me.Name}]}
		{
			echo ${Time}: Checking ${Me.Raid[${count}]} to see if they are a bard / ${Me.Raid[${count}].Class}
			if ${Me.Raid[${count}].Class.Equal[dirge]} || ${Me.Raid[${count}].Class.Equal[troubador]}
			{
				echo ${Time}: Found a Bard in Raid Position ${count} / ${Me.Raid[${count}]}
				BardCount:Inc
				BardArray[${BardCount}]:Set[${Me.Raid[${count}]}]
			}
		}
    }
	
	;sort bard array by raid number
	for(count:Set[1];${count}<=${BardArray.Size};count:Inc)
	{
		for(count2:Set[1];${count2}<=${BardArray.Size};count2:Inc)
		{
			if ${BardArray[${count2}].Compare[${BardArray[${count}]}]}>0
			{
				temp:Set[${BardArray[${count}]}]
				BardArray[${count}]:Set[${BardArray[${count2}]}]
				BardArray[${count2}]:Set[${temp}]
			}
		}
    }
	
	echo ${Time}: There are ${BardCount} Bard's and the Order is As Follows: ${BardArray[1]} / ${BardArray[2]} / ${BardArray[3]} / ${BardArray[4]} / ${BardArray[5]} / ${BardArray[6]} /
	
	if ${BardArray[1].Equal[${Me.Name}]}
		MyNum:Set[1]
	elseif ${BardArray[2].Equal[${Me.Name}]}
		MyNum:Set[2]
	elseif ${BardArray[3].Equal[${Me.Name}]}
		MyNum:Set[3]
	elseif ${BardArray[4].Equal[${Me.Name}]}
		MyNum:Set[4]
	elseif ${BardArray[5].Equal[${Me.Name}]}
		MyNum:Set[5]
	elseif ${BardArray[6].Equal[${Me.Name}]}
		MyNum:Set[6]
		
	relay "all other" Script[Buffer:Virtuoso].Variable[BardCount]:Set[${BardCount}]
}
function PlayPiano(string Song)
{
	;pausebots
	RI_CMD_PauseCombatBots 1
	
	;cancel spellcast and clear queue
	eq2ex cancel_spellcast
	eq2ex clearabilityqueue 
	
	wait 2
	
	eq2ex r Playing Piano
	
	;if Song is ice, call the 8 notes for ice
	if ${Song.Equal[ice]}
	{
		call a
		call g
		call a 
		call g
		call a
		call b
		call c
		call b
	}
	
	;if Song is flame, call the 8 notes for flame
	if ${Song.Equal[flame]}
	{
		call c
		call d
		call d 
		call f
		call g
		call g
		call f
		call f
	}
	
	;if Song is water, call the 8 notes for water
	if ${Song.Equal[water]}
	{
		call d
		call d
		call c 
		call b
		call c
		call d
		call d
		call f
	}
	
	;unpausebots
	RI_CMD_PauseCombatBots 0
}

function a()
{
	echo Pressing a Key: ${aID}
	Actor[${aID}]:DoubleClick
	wait ${WaitTime}
}
function b()
{
	echo Pressing b Key: ${bID}
	Actor[${bID}]:DoubleClick
	wait ${WaitTime}
}
function c()
{
	echo Pressing c Key: ${cID}
	Actor[${cID}]:DoubleClick
	wait ${WaitTime}
}
function d()
{
	echo Pressing d Key: ${dID}
	Actor[${dID}]:DoubleClick
	wait ${WaitTime}
}
function e()
{
	echo Pressing e Key: ${eID}
	Actor[${eID}]:DoubleClick
	wait ${WaitTime}
}
function f()
{
	echo Pressing f Key: ${fID}
	Actor[${fID}]:DoubleClick
	wait ${WaitTime}
}
function g()
{
	echo Pressing g Key: ${gID}
	Actor[${gID}]:DoubleClick
	wait ${WaitTime}
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	
   	if ${Text.Find["begins to play his song of"](exists)}
	{
		SongCount:Inc
		echo ${Time}:IncomingText: ${Text}
		Trigger:Set[TRUE]
		TriggerMessage:Set[${Text}]
	}
	if ${Text.Find["has slain enough foes to replenish these halls with all new bones and wipes out the rest of your party with ease!"](exists)}
		Script:End
	
	if ${Text.Find["focuses his energy into a protective veil of notes!"](exists)}
	{
		if ${Me.Archetype.Equal[fighter]}
			Target ${Me.Name}
	}
}

;atom to set your number
atom(global) MyNum(int aMyNum)
{
	echo ${Time}: Setting your number to ${aMyNum}
	MyNum:Set[${aMyNum}]
}

;atom to set your cID
atom(global) cID(int cIDs)
{
	echo ${Time}: Setting your cID to ${cIDs}
	cID:Set[${cIDs}}]
}

;at exit
function atexit()
{
	echo ${Time}: Ending Virtuoso
	
	;unpausebots
	RI_CMD_PauseCombatBots 0
	
	;turn on assist
	RI_CMD_Assisting 1
	if ${Script[Buffer:RunInstances](exists)}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}