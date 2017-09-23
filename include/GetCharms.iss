function main()
{
	;disable debugging
	Script:DisableDebugging
	
	while ${EQ2.Zoning}!=0
		wait 2
	
	if !${Script[${RI_Var_String_CombatBotScriptName}](exists)}
	{
		echo ISXRI: GetCharms can not be ran without CombatBot
		Script:End
	}
	
	echo ISXRI: Populating Charms ${Time}
	UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI]:ClearItems
	UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI]:ClearItems

    variable index:item Items
    variable iterator ItemIterator
    variable int Counter = 1
    
    Me:QueryInventory[Items, Location == "Inventory" || Location == "Equipment"]
    Items:GetIterator[ItemIterator]
 
 
    if ${ItemIterator:First(exists)}
    {
        do
        {
			if !${Script[${RI_Var_String_CombatBotScriptName}](exists)}
			{
				echo ISXRI: GetCharms can not be ran without CombatBot
				Script:End
			}
			while ${EQ2.Zoning}!=0
				wait 2
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; This routine is echoing the item "Description", so we must ensure that the iteminfo 
            ;; datatype is available.
            if (!${ItemIterator.Value.IsItemInfoAvailable})
            {
                ;; When you check to see if "IsItemInfoAvailable", ISXEQ2 checks to see if it's already
                ;; cached (and immediately returns true if so).  Otherwise, it spawns a new thread 
                ;; to request the details from the server.   
				; variable float StartLoopTime
				; StartLoopTime:Set[${Time.SecondsSinceMidnight}]
                ; do
                ; {
                    ; waitframe
                    ; It is OK to use waitframe here because the "IsItemInfoAvailable" will simply return
                    ; FALSE while the details acquisition thread is still running.   In other words, it 
                    ; will not spam the server, or anything like that.
                ; }
                ; while (!${ItemIterator.Value.IsItemInfoAvailable}) && ${Math.Calc[${Time.SecondsSinceMidnight}-10]}<${StartLoopTime}
				
				;changed this method to wait so it ends even if it doesnt return true, vs above methodology
				wait 20 ${ItemIterator.Value.IsItemInfoAvailable} || ${EQ2.Zoning}!=0
				;if !${ItemIterator.Value.IsItemInfoAvailable}
				;	echo ISXRI: Item Failed to GetInfo
				while ${EQ2.Zoning}!=0
					wait 2
            }
            ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; At this point, the "ToItemInfo" MEMBER of this object will be immediately available.  It should
            ;; remain available until the cache is cleared/reset (which is not very often.)
 
            variable string temp
			variable int count2
			for(count2:Set[1];${count2}<=${ItemIterator.Value.ToItemInfo.NumEffectStrings};count2:Inc)
			{
				;echo ${ItemIterator.Value.ToItemInfo.Name} : ${ItemIterator.Value.ToItemInfo.EffectString[${count2}].Text}
				if ${ItemIterator.Value.ToItemInfo.EffectString[${count2}].Text.Find[Applies](exists)} && ${ItemIterator.Value.ToItemInfo.EffectString[${count2}].Text.Find[when Activated](exists)} && !${ItemIterator.Value.ToItemInfo.Name.Find[Call of the](exists)} && ${ItemIterator.Value.ToItemInfo.Name.NotEqual[Mechanized Platinum Repository of Reconstruction]} && ${ItemIterator.Value.ToItemInfo.Name.NotEqual[Guided Ascension]} && !${ItemIterator.Value.ToItemInfo.Name.Find[a crate containing](exists)} && !${ItemIterator.Value.ToItemInfo.Name.Find[summoning charm](exists)} && !${ItemIterator.Value.ToItemInfo.Name.Find[patch kit](exists)} && !${ItemIterator.Value.ToItemInfo.Name.Find[standard of](exists)}
				{
					while ${EQ2.Zoning}!=0
						wait 2
					UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI]:AddItem["${ItemIterator.Value.ToItemInfo.Name}"]
					UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI]:AddItem["${ItemIterator.Value.ToItemInfo.Name}"]
					break
				}
			}
        }
        while ${ItemIterator:Next(exists)}
    }
	while ${EQ2.Zoning}!=0
		wait 2
	UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI]:SelectItem[${UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI].ItemByText[${RI_Var_String_Charm_1}].ID}]
	UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI]:SelectItem[${UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI].ItemByText[${RI_Var_String_Charm_2}].ID}]
	echo ISXRI: Done Populating Charms ${Time}
}