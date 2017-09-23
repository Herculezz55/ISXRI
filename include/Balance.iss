;balance v1 by Herculezz

;variables
variable index:actor ActorIndex
variable iterator ActorIterator

variable int BalanceMobWithHighestHealth=0
variable int ScriptTargetTime=0
variable(global) int BalanceHealthVar=0
variable(global) bool BalancePaused=TRUE
variable(global) bool BalanceNamed=FALSE
variable(global) string RI_Var_String_RIBalanceScriptName=${Script.Filename}
;main function	
function main()
{
	echo Balance v1
	;disable debugging
	Script:DisableDebugging
	
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if RIBalance.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RIBalance.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RIBalance.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIBalance.xml" http://www.isxri.com/RIBalance.xml
		wait 50
	}
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIBalance.xml"
	
	;main loop
	do
	{
		;if we are in combat
		if ${Me.InCombat} && !${BalancePaused}
		{
			;QueryActors to our ActorIndex that are NPC or NamedNPC and within distance 20 and InCombatMode and NotDead
			if ${BalanceNamed}
				EQ2:QueryActors[ActorIndex,( Type =="NPC" || Type =="NamedNPC" ) && InCombatMode = TRUE && IsDead = FALSE && Distance <= 20]
			else
				EQ2:QueryActors[ActorIndex,Type =="NPC" && InCombatMode && IsDead != TRUE && Distance <= 20]
			
			ActorIndex:GetIterator[ActorIterator]
			if ${ActorIterator:First(exists)}
			{
				do
				{
					;if the actor's health is higher than BalanceMobWithHighestHealth
					;set them to BalanceMobWithHighestHealth
					if ${ActorIterator.Value.Health}>${Math.Calc[${Actor[${BalanceMobWithHighestHealth}].Health}+${BalanceHealthVar}]}
						BalanceMobWithHighestHealth:Set[${ActorIterator.Value.ID}]
				}
				while ${ActorIterator:Next(exists)}
				;if i am not targeting BalanceMobWithHighestHealth and it is not 0 and exists
				;target BalanceMobWithHighestHealth
				if ${Target.ID}!=${BalanceMobWithHighestHealth} && ${BalanceMobWithHighestHealth}!=0 && ${Actor[${BalanceMobWithHighestHealth}](exists)} && !${Actor[${BalanceMobWithHighestHealth}].IsDead} && ${Script.RunningTime}>${Math.Calc[${ScriptTargetTime}+1000]}
				{
					;echo ${Time}: Targeting ${BalanceMobWithHighestHealth} / ${Actor[${BalanceMobWithHighestHealth}]} Health: ${Actor[${BalanceMobWithHighestHealth}].Health}
					Actor[${BalanceMobWithHighestHealth}]:DoTarget
					ScriptTargetTime:Set[${Script.RunningTime}]
				}
			}
		}
		wait 1
	}
	while 1
}

;atexit function
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIBalance.xml"
	echo Ending Balance
}