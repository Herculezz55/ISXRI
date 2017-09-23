function main()
{
	;disable debugging
	Script:DisableDebugging
	
	;check to make sure we have armor that needs mending
	; variable int countm=0
	; variable string temp
	; variable bool NeedRepair=FALSE
	; for(countm:Set[1];${countm}<=22;countm:Inc)
	; {
		;;echo ${countm} : 
		; temp:Set[${Me.Equipment[${countm}].Condition}]
		; while ${temp.Equal[NULL]}
		; {
			;;echo null, again
			; wait 2
			; temp:Set[${Me.Equipment[${countm}].Condition}]
		; }
		; echo ISXRI: Checking Gear Condition: ${countm} : ${Me.Equipment[${countm}].Name} : ${Me.Equipment[${countm}].Condition}
		; if ${Me.Equipment[${countm}].Condition}<100
			; NeedRepair:Set[TRUE]
	; }
	; if !${NeedRepair}
		; return
	variable index:actor ActorIndex
	variable bool FoundMender=FALSE
	variable int MenderID=0
	;populate actors to our ActorIndex that are NPC and within distance 8
	EQ2:GetActors[ActorIndex,NoKillNPC,range,10]
	
	;echo ${Time}: ActorIndexSize: ${ActorIndex.Used}
	
	;for loop to iterate through all actors in our index
	variable int count=0
	for(count:Set[1];${count}<=${ActorIndex.Used};count:Inc)
	{
		;echo Checking ${ActorIndex[${count}].Name}
		;if the actor is incombatmode and not dead
		if ${ActorIndex[${count}].Guild.Find[Mender](exists)}
		{
			FoundMender:Set[TRUE]
			MenderID:Set[${ActorIndex[${count}].ID}]
		}
		;echo checking ${count}
	}
	if ${FoundMender} && ${MenderID}>0
	{
		RI_CMD_PauseCombatBots 1
		Actor[${MenderID}]:DoFace
		wait 2
		eq2ex apply_verb ${MenderID} repair
		wait 10
		eq2ex mender_repair_all
		wait 10
		EQ2UIPage[Inventory,Merchant].Child[button,Merchant.WindowFrame.Close]:LeftClick
		eq2ex close_top_window
		RI_CMD_PauseCombatBots 0
	}
	else
		ISXRI: No Mender within 10m
}