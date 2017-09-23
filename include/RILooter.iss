;RILooter by Herculezz

function main()
{
	;disable debugging
	Script:DisableDebugging

	;if RI is not running, echo and end
	;if !${Script[Buffer:RunInstances]}
	;{
	;	echo Please type RI in the Console, RILooter cannot be run by itself
	;	return
	;}

	;main while loop
	while 1
	{
		wait 5
		if !${RI_Var_Bool_SkipLoot}
		{
			;if a corpse exists within 8m radius and corpse looting is on
			if ${RI_Var_Bool_CorpseLoot} || ( ${UIElement[SettingsLootingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLootCorpsesCheckBox@SettingsFrame@CombatBotUI].Checked} )
			{
				if ${Actor[corpse,radius,8](exists)}
				{
					if ${RI_Var_Bool_Debug}
						echo ISXRI: ${Time}: Looting ${Actor[corpse,radius,10]}
					
					;loot corpse via apply verb
					eq2ex apply_verb ${Actor[corpse,radius,10].ID} Loot
				}
			}
			
			;if a chest exists within 8m radius and looting is on
			if ${RI_Var_Bool_Loot} || ( ${UIElement[SettingsLootingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLootChestsCheckBox@SettingsFrame@CombatBotUI].Checked} )
			{
				if ${Script[Buffer:RunInstances](exists)} && !${RI_Var_Bool_Loot}
				{
					noop
				}
				else
				{
					if ${Actor[chest,radius,8](exists)}
					{
						if ${RI_Var_Bool_Debug}
							echo ISXRI: ${Time}: Looting ${Actor[chest,radius,7]} because Loot: ${RI_Var_Bool_Loot}
						
						;doubleclick chest wait 2 then loot all
						Actor[chest,radius,7]:DoubleClick
						wait 2
						LootWindow:LootAll
					}
				}
			}
		}
	}
}
