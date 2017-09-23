;Imbiber written by Herculezz idea by THG v1

atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;main function
function main()
{
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["F.S. Distillery: Beggars and Blighters [Raid]"]} || ${Math.Distance[${Me.Loc},-11.51,-124.08,-5.90]}>100
	{
		echo ${Time}: You must be in F.S. Distillery: Beggars and Blighters [Raid] and within 100 distance of -11.51,-124.08,-5.90 to run this script.
		Script:End
	}
	
	echo Starting Imbiber v1
	
	;start RaidRelayGroup
	RRG
	
	;set lock spot
	RIMUIObj:SetLockSpot[${Me.Name}]
		
	;if I am a fighter camp spot at -18.83 -124.08 -3.77, else camp spot at -12.27,-124.08,-5.92
	if ${Me.Archetype.Equal[fighter]}
		RIMUIObj:SetLockSpot[${Me.Name},-18.83,-124.08,-3.77]
	else
		RIMUIObj:SetLockSpot[${Me.Name},-12.27,-124.08,-5.92]

	;while we are not in combat, wait
	while !${Me.InCombat}
		wait 1
	
	;main loop while Imbiber the Punisher exists and is not dead
	while ${Actor["Brutas the Imbiber"](exists)} && !${Actor["Brutas the Imbiber"].IsDead} && ${Me.GetGameData[Self.ZoneName].Label.Equal["F.S. Distillery: Beggars and Blighters [Raid]"]} && ${Math.Distance[${Me.Loc},-11.51,-124.08,-5.90]}<100
	{
		if ${Me.Raid[6].Name.Equal[${Me.Name}]}
		{
			if !${Me.Inventory["Container of Cold Water"](exists)}
				Actor[loc,-9.871122,-8.039354]:DoubleClick
			if ${Math.Distance[${Me.Raid[3].Loc},-14.10,-123.99,-2.39]}<1 || ${Math.Distance[${Me.Raid[3].Loc},-13.15,-123.99,3.76]}<1 || ${Math.Distance[${Me.Raid[3].Loc},-20.15,-123.99,6.74]}<1 || ${Math.Distance[${Me.Raid[3].Loc},-13.27,-123.99,9.86]}<1 || ${Math.Distance[${Me.Raid[3].Loc},-10.04,-123.99,14.50]}<1
				call Cure ${Me.Raid[3].Name}
		}
		elseif ${Me.Raid[3].Name.Equal[${Me.Name}]}
		{
			if !${Me.Inventory["Container of Cold Water"](exists)}
				Actor[loc,-9.871122,-8.039354]:DoubleClick
			call CheckRaid
		}
		wait 5
	}
}

;checkraid function
function CheckRaid()
{
	declare count int
	for(count:Set[1];${count}<=${Me.Raid};count:Inc)
	{
		if ${Me.Raid[${count}].Name.NotEqual[${Me.Name}]}
		{
			if ${Math.Distance[${Me.Raid[${count}].Loc},-14.10,-123.99,-2.39]}<1 || ${Math.Distance[${Me.Raid[${count}].Loc},-13.15,-123.99,3.76]}<1 || ${Math.Distance[${Me.Raid[${count}].Loc},-19.11,-123.99,6.67]}<1 || ${Math.Distance[${Me.Raid[${count}].Loc},-13.27,-123.99,9.86]}<1 || ${Math.Distance[${Me.Raid[${count}].Loc},-10.04,-123.99,14.50]}<1
				call Cure ${Me.Raid[${count}].Name}
		}
	}
}
;cure function
function Cure(string ToonToCure)
{
	if !${Me.Inventory["Container of Cold Water"](exists)}
	{
		RIMUIObj:SetLockSpot[${Me.Name},-12.27,-124.08,-5.92]
		Actor[loc,-9.871122,-8.039354]:DoubleClick
		wait 5
	}
	;turn off assist and pause bot
	RIMUIObj:Assist[${Me.Name},0]
	RIMUIObj:PauseBot[${Me.Name}]
	RIMUIObj:SetLockSpot[${Me.Name},-18.83,-124.08,-3.77]
	wait 50 ${Math.Distance[${Me.Loc},-18.83,-124.08,-3.77]}<2
	RIMUIObj:SetLockSpot[${Me.Name},-16.26,-123.73,7.66]
	wait 50 ${Math.Distance[${Me.Loc},-16.26,-123.73,7.66]}<2
	wait 5
	Actor[${ToonToCure}]:DoTarget
	wait 2
	Me.Inventory["Container of Cold Water"]:Use
	wait 20
	RIMUIObj:SetLockSpot[${Me.Name},-18.83,-124.08,-3.77]
	wait 50 ${Math.Distance[${Me.Loc},-18.83,-124.08,-3.77]}<2
	RIMUIObj:SetLockSpot[${Me.Name},-12.27,-124.08,-5.92]
	;turn on assist and unpause bot
	RIMUIObj:Assist[${Me.Name},1]
	RIMUIObj:ResumeBot[${Me.Name}]
}

;function called when script ends
function atexit()
{
	echo Ending Imbiber	
	if ${Script[Buffer:RIMovement]}
		RI_Atom_SetLockSpot OFF
	
	press -release ${RI_Var_String_ForwardKey}
	
	;enable ogre cast stack
	OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack FALSE
	if ${Me.Archetype.NotEqual[fighter]}
	{
		;turn on assist and on ogre cast stack
		OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_assist TRUE
		OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack FALSE
	}
}
