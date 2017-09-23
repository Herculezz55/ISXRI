;Charanda v7 by Herculezz

;set your crouch key
variable string CrouchKey=z

variable bool UndeadUp=FALSE
variable bool Focuser=FALSE
variable bool Despoiler=FALSE
variable bool Ruiner=FALSE
variable bool EffectSet=FALSE
variable bool Crouched=FALSE
variable(global) string RI_Var_String_Version=Charanda
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) bool RI_Var_Bool_Start=TRUE
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
atom(global) RI_Atom_CharandaCrouchKey(string ckey)
{
	CrouchKey:Set[${ckey}]
}
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["F.S. Distillery: Beggars and Blighters [Raid]"]} || ${Math.Distance[${Me.Loc},-43.33,-97.44,93.56]}>30
	{
		echo ${Time}: You must be in F.S. Distillery: Beggars and Blighters [Raid] and within 30 distance of -43.33,-97.44,93.56 to run this script.
		Script:End
	}
	
	echo Starting Charanda v7
	
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
	
	;Huds
	Squelch Hud -add 1 200,235 Crouching:
	Squelch Hud -add 2 200,250 ${Me.Name}: ${Me.IsCrouching}
	Squelch Hud -add 3 200,265 ${Me.Group[1].Name}: ${Me.Group[1].IsCrouching}
	Squelch Hud -add 4 200,280 ${Me.Group[2].Name}: ${Me.Group[2].IsCrouching}
	Squelch Hud -add 5 200,295 ${Me.Group[3].Name}: ${Me.Group[3].IsCrouching}
	Squelch Hud -add 6 200,310 ${Me.Group[4].Name}: ${Me.Group[4].IsCrouching}
	Squelch Hud -add 7 200,325 ${Me.Group[5].Name}: ${Me.Group[5].IsCrouching}
	
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;crouch
	press ${CrouchKey}
	
	;main loop, while Charanda exists && is not dead
	while ${Actor[Charanda](exists)} && !${Actor[Charanda].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["F.S. Distillery: Beggars and Blighters [Raid]"]} && ${Math.Distance[${Me.Loc},-43.33,-97.44,93.56]}<30
	{
	
		;if i am a fighter
		if ${Me.Archetype.Equal[fighter]}
		{
			
			;if an Undead exists, set var true and call undead, then set vars false
			if ${Actor["an Undead"](exists)}
			{
				;echo ${Time}: Undead Up, Calling Undead Function
				UndeadUp:Set[TRUE]
				call Undead	
				UndeadUp:Set[FALSE]
				Focuser:Set[FALSE]
				Despoiler:Set[FALSE]
				Ruiner:Set[FALSE]
				EffectSet:Set[FALSE]
			}
			elseif ${Actor["Portia Rumuffin's reanimated corpse"](exists)} && !${Actor["Portia Rumuffin's reanimated corpse"].IsDead}
			{
				if ${Target.ID}!=${Actor["Portia Rumuffin's reanimated corpse"].ID}
					Actor["Portia Rumuffin's reanimated corpse"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["Charanda"].ID}
					Actor["Charanda"]:DoTarget
			}
		}
		
		wait 2
	}
}

function Crouch()
{
	press ${CrouchKey}
	Crouched:Set[TRUE]
}

;Undead function
function Undead()
{
	;initialize actor Charanda's effects.
	Actor[Charanda]:InitializeEffects

	;wait 2 while we are initializing effects
	while ${ISXEQ2.InitializingActorEffects}
	{	
		;echo ${Time}: Initializing Actor's Effects
		wait 5
	}
	
	while !${EffectSet}
	{
		;if Charanda has Ruiner's Assistance
		if ${Actor[Charanda].Effect["Ruiner's Assistance"](exists)}
		{
			Ruiner:Set[TRUE]
			EffectSet:Set[TRUE]
			;echo ${Time}: Ruiner Set: ${Ruiner}
		}
		
		;elseif Charanda has Focuser's Assistance
		elseif ${Actor[Charanda].Effect["Focuser's Assistance"](exists)}
		{
			Focuser:Set[TRUE]
			EffectSet:Set[TRUE]
			;echo ${Time}: Focuser Set: ${Focuser}
		}
		
		;elseif Charanda has Despoiler's Assistance
		elseif ${Actor[Charanda].Effect["Despoiler's Assistance"](exists)}
		{		
			Despoiler:Set[TRUE]
			EffectSet:Set[TRUE]
			;echo ${Time}: Despoiler Set: ${Despoiler}
		}
		;else wait 5 and try again
		else
			wait 5
		;echo ${Time}: Setting Effect
	}	
	
	while ${Actor["an Undead"](exists)}
	{
		;if Ruiner is protected target other 2, then Portia Rumuffin's reanimated corpse then Charanda
		if ${Ruiner}
		{
			;;echo ${Time}: Ruiner
			if ${Actor["an Undead Focuser"](exists)} && !${Actor["an Undead Focuser"].IsDead}
			{
				if ${Target.ID}!=${Actor["an Undead Focuser"].ID}
					Actor["an Undead Focuser"]:DoTarget
			}
			elseif ${Actor["an Undead Despoiler"](exists)} && !${Actor["an Undead Despoiler"].IsDead}
			{
				if ${Target.ID}!=${Actor["an Undead Despoiler"].ID}
					Actor["an Undead Despoiler"]:DoTarget
			}
			elseif ${Actor["Portia Rumuffin's reanimated corpse"](exists)} && !${Actor["Portia Rumuffin's reanimated corpse"].IsDead}
			{
				if ${Target.ID}!=${Actor["Portia Rumuffin's reanimated corpse"].ID}
					Actor["Portia Rumuffin's reanimated corpse"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["Charanda"].ID}
					Actor["Charanda"]:DoTarget
			}
		}
		
		;elseif Focuser is protected target other 2, then Portia Rumuffin's reanimated corpse then Charanda
		elseif ${Focuser}
		{
			;echo ${Time}: Focuser
			if ${Actor["an Undead Ruiner"](exists)} && !${Actor["an Undead Ruiner"].IsDead}
			{
				if ${Target.ID}!=${Actor["an Undead Ruiner"].ID}
					Actor["an Undead Ruiner"]:DoTarget
			}
			elseif ${Actor["an Undead Despoiler"](exists)} && !${Actor["an Undead Despoiler"].IsDead}
			{
				if ${Target.ID}!=${Actor["an Undead Despoiler"].ID}
					Actor["an Undead Despoiler"]:DoTarget
			}
			elseif ${Actor["Portia Rumuffin's reanimated corpse"](exists)} && !${Actor["Portia Rumuffin's reanimated corpse"].IsDead}
			{
				if ${Target.ID}!=${Actor["Portia Rumuffin's reanimated corpse"].ID}
					Actor["Portia Rumuffin's reanimated corpse"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["Charanda"].ID}
					Actor["Charanda"]:DoTarget
			}
		}
		
		;elseif Despoiler is protected target other 2, then Portia Rumuffin's reanimated corpse then Charanda
		elseif ${Despoiler}
		{
			;echo ${Time}: Despoiler
			if ${Actor["an Undead Focuser"](exists)} && !${Actor["an Undead Focuser"].IsDead}
			{
				if ${Target.ID}!=${Actor["an Undead Focuser"].ID}
					Actor["an Undead Focuser"]:DoTarget
			}
			elseif ${Actor["an Undead Ruiner"](exists)} && !${Actor["an Undead Ruiner"].IsDead}
			{
				if ${Target.ID}!=${Actor["an Undead Ruiner"].ID}
					Actor["an Undead Ruiner"]:DoTarget
			}
			elseif ${Actor["Portia Rumuffin's reanimated corpse"](exists)} && !${Actor["Portia Rumuffin's reanimated corpse"].IsDead}
			{
				if ${Target.ID}!=${Actor["Portia Rumuffin's reanimated corpse"].ID}
					Actor["Portia Rumuffin's reanimated corpse"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["Charanda"].ID}
					Actor["Charanda"]:DoTarget
			}
		}
		;;echo ${Time}: Targeting WLoop
		wait 5
	}
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;if we find noxious gas cloud burns your lungs, and we are not crouching, press z
   	if ${Text.Find["noxious gas cloud burns your lungs"](exists)}
	{
		;echo ${Time}:IncomingText: ${Text}
		;if !${Me.IsCrouching}
			press ${CrouchKey}
	}
	
	;if we find The noxious gas cloud dissipates, and we are crouching, press z
	if ${Text.Find["The noxious gas cloud dissipates"](exists)}
	{
		;echo ${Time}:IncomingText: ${Text}
		;if ${Me.IsCrouching}
		;{
			press space
			TimedCommand 2 press space
			Crouched:Set[FALSE]
			TimedCommand 100 press ${CrouchKey}
		;}
	}
}

function atexit()
{
	echo Ending Charanda
	Squelch hud -remove 1
	Squelch hud -remove 2
	Squelch hud -remove 3
	Squelch hud -remove 4
	Squelch hud -remove 5
	Squelch hud -remove 6
	Squelch hud -remove 7
	press space
	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF	
	
	press -release ${RI_Var_String_ForwardKey}

		
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
}