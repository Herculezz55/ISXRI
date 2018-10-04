;CoT by Herculezz v2
variable int Counter=0
function main()
{
	;echo Starting CoT v2
		
	;disable debugging
	Script:DisableDebugging
	
	if !${RI_Var_Bool_GlobalOthers}
		return
	
	;main loop
	while ${Script[Buffer:RunInstances](exists)}
	{
		if ${RI_Var_Bool_Paused}
		{
			wait 10
			continue
		}
		;if all group member's are 59m or more away
		if ${Me.Group[1].Distance}>=59 && ${Me.Group[2].Distance}>=59 && ${Me.Group[3].Distance}>=59 && ${Me.Group[4].Distance}>=59 && ${Me.Group[5].Distance}>=59
		{
			if ${Counter}<11
			{
				Counter:Inc
				wait 10
				continue
			}
			else
				Counter:Set[0]
			;if Call of the Tinkerer is ready and I am RIFollowing
			if ${Me.Inventory[Call of the Tinkerer].IsReady} && !${Me.InCombat}
			{
				;turn off assist and target RIFollowing Target
				RI_CMD_Assisting 0
				press esc
				Actor[id,${RI_Var_Int_RIFollowTargetID}]:DoTarget
				
				;Pause bots and cancel casting and clear ability queue
				RI_CMD_PauseCombatBots 1
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue
				press esc
				;PauseRI and use call of the tinkerer
				Script[Buffer:RunInstances]:Pause
				
				;PauseRIMovement and use call of the tinkerer
				Script[Buffer:RIMovement]:Pause
				
				press -release ${RI_Var_String_ForwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				
				;while loop to use call of the tinkerer until its no longer ready
				while ${Me.Inventory["Call of the Tinkerer"].IsReady} && ${Me.Group[1].Distance}>59 && ${Me.Group[2].Distance}>59 && ${Me.Group[3].Distance}>59 && ${Me.Group[4].Distance}>59 && ${Me.Group[5].Distance}>59
				{
					if ${Target.ID}!=${RI_Var_Int_RIFollowTargetID}
						Actor[id,${RI_Var_Int_RIFollowTargetID}]:DoTarget
					Me.Inventory["Call of the Tinkerer"]:Use
					wait 5
				}
				
				;unpause bots after 10s
				TimedCommand 100 RI_CMD_PauseCombatBots 0
				
				;turn on RI after 10s
				TimedCommand 100 Script[Buffer:RunInstances]:Resume
				
				;turn on RIMovement after 10s
				TimedCommand 100 Script[Buffer:RIMovement]:Resume
				
				;turn on auto assist after 10s
				TimedCommand 100 RI_CMD_Assisting 1
			}
		}	
		else
			Counter:Set[0]
		wait 10
	}
}
function atexit()
{
	;echo Ending CoT
}