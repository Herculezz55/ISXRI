variable index:item BagIndex
variable index:item InventoryIndex
variable int Bag1
variable int Bag2
variable int Bag3
variable int Bag4
variable int Bag5
variable int Bag6
variable bool OkToTransmute=FALSE
variable int intQuery
variable(global) string RI_Var_String_RITransmuteScriptName=${Script.Filename}
variable(global) bool Debug=FALSE
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if RITransmute.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RITransmute.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RITransmute.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RITransmute.xml" http://www.isxri.com/RITransmute.xml
		wait 50
	}
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RITransmute.xml"
	
	Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
	
	Me:QueryInventory[BagIndex, IsInventoryContainer=TRUE]
	variable iterator BagsIterator
	BagIndex:GetIterator[BagsIterator]
	
	;echo ${BagIndex.Used}
	if ${BagsIterator:First(exists)}
    {
        do
        {
			;echo ${BagsIterator.Value.Name}
			switch ${BagsIterator.Value.Slot}
			{	
				case 0
				{
					Bag1:Set[${BagsIterator.Value.ContainerID}]
					;echo Found Bag 1 - ${Bag1}
					break
				}
				case 1
				{
					Bag2:Set[${BagsIterator.Value.ContainerID}]
					;echo Found Bag 2 - ${Bag2}
					break
				}
				case 2
				{
					Bag3:Set[${BagsIterator.Value.ContainerID}]
					;echo Found Bag 3 - ${Bag3}
					break
				}
				case 3
				{
					Bag4:Set[${BagsIterator.Value.ContainerID}]
					;echo Found Bag 4 - ${Bag4}
					break
				}
				case 4
				{
					Bag5:Set[${BagsIterator.Value.ContainerID}]
					;echo Found Bag 5 - ${Bag5}
					break
				}
				case 5
				{
					Bag6:Set[${BagsIterator.Value.ContainerID}]
					;echo Found Bag 6 - ${Bag6}
					break
				}
			}
		}
		while ${BagsIterator:Next(exists)}
	}
	
	while 1
	{
		call ExecuteQueued
		wait 1
	}
}

function ExecuteQueued()
{
	;execute queued commands
	if ${QueuedCommands}
	{
		ExecuteQueued
	}
}
function Transmute()
{
	UIElement[Start@RISalvage]:SetText[Stop]
	;return
	Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && Quantity=1 && IsFoodOrDrink=FALSE]
	;echo ${InventoryIndex.Used}
	
    if !${UIElement[Bag1@RITransmute].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag2@RITransmute].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag3@RITransmute].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag4@RITransmute].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag5@RITransmute].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag6@RITransmute].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	;echo ${InventoryIndex.Used}
	variable iterator InventoryIterator
	InventoryIndex:GetIterator[InventoryIterator]

	if ${InventoryIterator:First(exists)}
    {
        do
        {
			if (!${InventoryIterator.Value.IsItemInfoAvailable})
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
                ; while (!${InventoryIterator.Value.IsItemInfoAvailable}) && ${Math.Calc[${Time.SecondsSinceMidnight}-10]}<${StartLoopTime}
				
				;changed this method to wait so it ends even if it doesnt return true, vs above methodology
				wait 20 ${InventoryIterator.Value.IsItemInfoAvailable}
				;if !${InventoryIterator.Value.IsItemInfoAvailable}
				;	echo ISXRI: Item Failed to GetInfo
            }
			if ${InventoryIterator.Value.IsItemInfoAvailable}
			{
				if ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Ranged Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Armor]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Spell Scroll]}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
					continue
				}
				
				if ${InventoryIterator.Value.ToItemInfo.NoValue} || ${InventoryIterator.Value.ToItemInfo.Level}<=0 
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[HANDCRAFTED]}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[LEGENDARY]} && !${UIElement[Legendary@RITransmute].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Legendary
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[FABLED]} && !${UIElement[Fabled@RITransmute].Checked} && !${InventoryIterator.Value.ToItemInfo.Type.Equal[Spell Scroll]}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Fabled
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[MYTHICAL]} && !${UIElement[Mythical@RITransmute].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Mythical
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[ETHEREAL]} && !${UIElement[Ethereal@RITransmute].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Ethereal
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[MASTERCRAFTED FABLED]} && !${UIElement[MCFabled@RITransmute].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute MCFabled
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[MASTERCRAFTED LEGENDARY]} && !${UIElement[MCLegendary@RITransmute].Checked} && !${InventoryIterator.Value.ToItemInfo.Type.Equal[Spell Scroll]}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute MCLegendary
					continue
				}
				;echo ${InventoryIterator.Value.Name} - ${InventoryIterator.Value} - ${InventoryIterator.Value.InContainerID} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].IsInventoryContainer} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].Slot} - ${InventoryIterator.Value.ToItemInfo.Tier} - ${InventoryIterator.Value.ToItemInfo.Type}
				if ${InventoryIterator.Value.ToItemInfo.Type.Equal[Spell Scroll]}
				{
					if ${InventoryIterator.Value.Name.Find[(Journeyman)](exists)}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
						continue
					}
					if ${InventoryIterator.Value.Name.Find[(Master)](exists)} && !${UIElement[Master@RITransmute].Checked}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Master
						continue
					}
					if ${InventoryIterator.Value.Name.Find[(Expert)](exists)} && !${UIElement[Expert@RITransmute].Checked}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Expert
						continue
					}
					if ${InventoryIterator.Value.Name.Find[(Adept)](exists)} && !${UIElement[Adept@RITransmute].Checked}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Adept
						continue
					}
				}
				if ${Debug}
					echo ISXRI: Transmuting ${InventoryIterator.Value.Name}
				eq2ex usea Transmute
				wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
				InventoryIterator.Value:Transmute
				wait 10 ${Me.CastingSpell}
				wait 10 !${Me.CastingSpell}
				wait 5
				wait 10
			}
			else
			{
				ISXRI: Skipping ${InventoryIterator.Value.Name}, could not get ItemInfo from server in a timely manner
			}
		}
		while ${InventoryIterator:Next(exists)}
	}
	UIElement[Start@RITransmute]:SetText[Start]
}
atom EQ2_onRewardWindowAppeared()
{
	RewardWindow:Receive
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RITransmute.xml"
}