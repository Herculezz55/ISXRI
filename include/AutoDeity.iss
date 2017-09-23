;AutoDeity by Herculezz v1

;Auto balancing of your Deity points based on your current spendage
;Allowed Arguments:
;	0 - Balance ALL (Default)
;	1 - Spend all points in Potency
;   2 - Spend all points in Crit Bonus
; 	3 - Spend all points in Stamina
;	4 - Balance Only Potency and Crit Bonus
;	5 - Balance Only Potency and Stamina
;	6 - Balance Only Crit Bonus and Stamina

;Need to add where it checks the amount's we have in each one. and figure out how many each level takes.
;
;

;variables
variable int PotencyCount=0
variable int CritBonusCount=0
variable int StaminaCount=0
variable int Argument=0
variable string Debug

function main(int Mode=0, string _Debug=Verbose)
{
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]

	Debug:Set[${_Debug}]
	Argument:Set[${Mode}]
	if ${Debug.Upper.NotEqual[SILENT]}
		echo ISXRI: Starting Auto Deity
		
	while 1
	{
		while ${Me.GetGameData["Achievement.AvailableDeityPoints"].Label}>${Int[${UIElement[SettingsDeitySpendTextEntry@SettingsFrame@CombatBotUI].Text}]}
		{	
			if ${RI_Var_Bool_AutoDeityDisabled}==1
				noop
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==0
			{
				if ${PotencyCount}<=${CritBonusCount} && ${PotencyCount}<=${StaminaCount}
					call PotencySpender
				elseif ${CritBonusCount}<=${PotencyCount} && ${CritBonusCount}<=${StaminaCount}
					call CritBonusSpender
				elseif ${StaminaCount}<=${PotencyCount} && ${StaminaCount}<=${CritBonusCount}
					call StaminaSpender
			}
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==1
			{
				call PotencySpender
			}
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==2
			{
				call CritBonusSpender
			}
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==3
			{
				call StaminaSpender
			}
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==4
			{
				if ${PotencyCount}<=${CritBonusCount}
					call PotencySpender
				else
					call CritBonusSpender
			}
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==5
			{
				if ${PotencyCount}<=${StaminaCount}
					call PotencySpender
				else
					call StaminaSpender
			}
			elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==6
			{
				if ${CritBonusCount}<=${StaminaCount}
					call CritBonusSpender
				else
					call StaminaSpender
			}
			wait 1
		}
		wait 50
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;check we have ToT
	if ${Text.Find[You must have expansion 12 to use this feature](exists)}
	{
		echo ISXRI: You do not have Terrors of Thalumbra Expansion
		RI_Var_Bool_AutoDeityDisabled:Set[1]
	}
}
atom(global) RIAutoDeity_ChangeMode(int _Mode=0)
{
	if ${_Mode}>-1
	{
		RI_Var_Bool_AutoDeityDisabled:Set[0]
		UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI]:SetSelection[${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].ItemByValue[${_Mode}].ID}]
	}
	else 
		RI_Var_Bool_AutoDeityDisabled:Set[1]
	if ${_Mode}==-1
	{
		echo ISXRI: AutoDeity: Disabled
	}
	if ${_Mode}==0
	{
		echo ISXRI: AutoDeity: Changing mode to: Balance ALL
	}
	elseif ${_Mode}==1
	{
		echo ISXRI: AutoDeity: Changing mode to: Spend all points in Potency
	}
	elseif ${_Mode}==2
	{
		echo ISXRI: AutoDeity: Changing mode to: Spend all points in Crit Bonus
	}
	elseif ${_Mode}==3
	{
		echo ISXRI: AutoDeity: Changing mode to: Spend all points in Stamina
	}
	elseif ${_Mode}==4
	{
		echo ISXRI: AutoDeity: Changing mode to: Balance Only Potency and Crit Bonus
	}
	elseif ${_Mode}==5
	{
		echo ISXRI: AutoDeity: Changing mode to: Balance Only Potency and Stamina
	}
	elseif ${_Mode}==6
	{
		echo ISXRI: AutoDeity: Changing mode to: Balance Only Crit Bonus and Stamina
	} 
}
function PotencySpender()
{
	if ${Debug.Upper.NotEqual[SILENT]}
		echo ISXRI: Spending 1 point into Potency
	eq2ex spend_deity_point 2951281460 1
	;wait 5
	;ChoiceWindow:DoChoice1
	wait 5
	PotencyCount:Inc
}

function CritBonusSpender()
{
	if ${Debug.Upper.NotEqual[SILENT]}
		echo ISXRI: Spending 1 point into Crit Bonus
	eq2ex spend_deity_point 2479066486 1
	;wait 5
	;ChoiceWindow:DoChoice1
	wait 5
	CritBonusCount:Inc
}

function StaminaSpender()
{
	if ${Debug.Upper.NotEqual[SILENT]}
		echo ISXRI: Spending 1 point into Stamina
	eq2ex spend_deity_point 958976882 1
	;wait 5
	;ChoiceWindow:DoChoice1
	wait 5
	StaminaCount:Inc
}
function atexit()
{
	if ${Debug.Upper.NotEqual[SILENT]}
		echo ISXRI: Ending AutoDeity
}