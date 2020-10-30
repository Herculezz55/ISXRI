variable index:item BagIndex
variable index:item InventoryIndex
variable int Bag1
variable int Bag2
variable int Bag3
variable int Bag4
variable int Bag5
variable int Bag6
variable bool OkToSalvage=FALSE
variable int intQuery
variable(global) string RI_Var_String_RISalvageScriptName=${Script.Filename}
variable(global) bool Debug=FALSE
variable bool Start=FALSE
variable bool Loop=FALSE

function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if RISalvage.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RISalvage.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RISalvage.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RISalvage.xml" http://www.isxri.com/RISalvage.xml
		wait 50
	}
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RISalvage.xml"
	
	variable int ArgCount=0
	variable bool LoadUI=TRUE
	
	while ${ArgCount:Inc} <= ${args.Used}
	{
		switch ${args[${ArgCount}]}
		{
			case -b1
			case -bag1
			{	
				UIElement[Bag1@RISalvage]:SetChecked
				break
			}
			case -b2
			case -bag2
			{
				UIElement[Bag2@RISalvage]:SetChecked
				break
			}
			case -b3
			case -bag3
			{
				UIElement[Bag3@RISalvage]:SetChecked
				break
			}
			case -b4
			case -bag4
			{
				UIElement[Bag4@RISalvage]:SetChecked
				break
			}
			case -b5
			case -bag5
			{
				UIElement[Bag5@RISalvage]:SetChecked
				break
			}
			case -b6
			case -bag6
			{
				UIElement[Bag6@RISalvage]:SetChecked
				break
			}
			case -l
			case -leg
			case -legendary
			{
				UIElement[Legendary@RISalvage]:SetChecked
				break
			}
			case -f
			case -fab
			case -fabled
			{
				UIElement[Fabled@RISalvage]:SetChecked
				break
			}
			case -myth
			case -mythical
			{
				UIElement[Mythical@RISalvage]:SetChecked
				break
			}
			case -eth
			case -ethereal
			{
				UIElement[Ethereal@RISalvage]:SetChecked
				break
			}
			case -mf
			case -mcf
			case -mcfab
			case -mcfabled
			{
				UIElement[MCFabled@RISalvage]:SetChecked
				break
			}
			case -ml
			case -mcl
			case -mcleg
			case -mclegendary
			{
				UIElement[MCLegendary@RISalvage]:SetChecked
				break
			}
			case -m
			case -master
			{
				UIElement[Master@RISalvage]:SetChecked
				break
			}
			case -a
			case -adept
			{
				UIElement[Adept@RISalvage]:SetChecked
				break
			}
			case -e
			case -expert
			{
				UIElement[Expert@RISalvage]:SetChecked
				break
			}
			case -noui
			{
				LoadUI:Set[FALSE]
				break
			}
			case -loop
			{
				Loop:Set[TRUE]
				Start:Set[1]
				break
			}
			case -start
			{
				Start:Set[1]
				break
			}
			default
				break
		}
	}
	
	
	if !${LoadUI}
		UIElement[RISalvage]:Hide
	
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
	
	if ${Start}
		call Salvage
	while 1
	{
		if ${Loop}
		{
			if !${Me.IsMoving} && !${Me.InCombat} && !${Me.CastingSpell}
			{
				call Salvage
				wait 50
			}
		}
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
function Salvage()
{
	UIElement[Start@RISalvage]:SetText[Stop]
	
	Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && Quantity=1 && IsFoodOrDrink=FALSE]
	;echo ${InventoryIndex.Used}
	
    if !${UIElement[Bag1@RISalvage].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag2@RISalvage].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag3@RISalvage].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag4@RISalvage].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag5@RISalvage].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	if !${UIElement[Bag6@RISalvage].Checked}
	{
		intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
		InventoryIndex:RemoveByQuery[${intQuery},TRUE]
		LavishScript:FreeQuery[${intQuery}]
		InventoryIndex:Collapse
	}
	echo ${InventoryIndex.Used}
	variable iterator InventoryIterator
	InventoryIndex:GetIterator[InventoryIterator]

	if ${InventoryIterator:First(exists)}
    {
		
        do
        {
			echo Checking ${InventoryIterator.Value}
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
				if !${InventoryIterator.Value.IsItemInfoAvailable}
					echo ISXRI: Item Failed to GetInfo
            }
			if ${InventoryIterator.Value.IsItemInfoAvailable}
			{
				if ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Shield]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Ranged Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Armor]}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be Salvaged
					continue
				}
				
				if ${InventoryIterator.Value.ToItemInfo.NoValue} || ${InventoryIterator.Value.ToItemInfo.Level}<=0 
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be Salvaged
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[HANDCRAFTED]} && !${UIElement[Handcrafted@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage Handcrafted
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[TREASURED]} && !${UIElement[Treasured@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage Treasured
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[LEGENDARY]} && !${UIElement[Legendary@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage Legendary
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[FABLED]} && !${UIElement[Fabled@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage Fabled
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[MYTHICAL]} && !${UIElement[Mythical@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage Mythical
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[ETHEREAL]} && !${UIElement[Ethereal@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage Ethereal
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[MASTERCRAFTED FABLED]} && !${UIElement[MCFabled@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage MCFabled
					continue
				}
				if ${InventoryIterator.Value.ToItemInfo.Tier.Equal[MASTERCRAFTED LEGENDARY]} && !${UIElement[MCLegendary@RISalvage].Checked}
				{
					if ${Debug}
						echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Salvage MCLegendary
					continue
				}
				;echo ${InventoryIterator.Value.Name} - ${InventoryIterator.Value} - ${InventoryIterator.Value.InContainerID} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].IsInventoryContainer} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].Slot} - ${InventoryIterator.Value.ToItemInfo.Tier} - ${InventoryIterator.Value.ToItemInfo.Type}
				;if ${Debug}
					echo ISXRI: Salvaging ${InventoryIterator.Value.Name}
				eq2ex usea Salvage
				wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
				InventoryIterator.Value:Salvage
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
	UIElement[Start@RISalvage]:SetText[Start]
	if ${Start} && !${Loop}
		Script:End
}
atom EQ2_onRewardWindowAppeared()
{
	RewardWindow:AcceptReward
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RISalvage.xml"
}