;collection.iss by Herculezz v1
variable index:item InventoryIndex
function main(... args)
{
	if ${args[1].Upper.Find[INV](exists)} || ${args[1].Upper.Find[BAG](exists)}
		call Inv
	elseif ${args[1].Upper.Find[DEPOT](exists)}
		call Depot
	else
		echo ISXRI: You must specify bag or depot, usage RI_Collection bag or RI_Collection depot
}

function Inv()
{
	Me:QueryInventory[InventoryIndex, Location=="Inventory" && IsContainer=FALSE && IsFoodOrDrink=FALSE && IsUsable=FALSE && IsScribeable=FALSE && IsAutoConsumeable=FALSE && CanBeRedeemed=FALSE]
	
	echo ISXRI: Checking ${InventoryIndex.Used} items from your inventory
	variable iterator InventoryIterator
	InventoryIndex:GetIterator[InventoryIterator]

	if ${InventoryIterator:First(exists)}
    {
        do
        {
			;echo checking ${InventoryIterator.Value.Name}
			if (!${InventoryIterator.Value.IsItemInfoAvailable})
				wait 20 ${InventoryIterator.Value.IsItemInfoAvailable}

			if ${InventoryIterator.Value.IsItemInfoAvailable}
			{
				if ${InventoryIterator.Value.ToItemInfo.IsCollectible}
				{
					if !${InventoryIterator.Value.ToItemInfo.AlreadyCollected}
					{
						echo ISXRI: Collecting ${InventoryIterator.Value.Name}
						InventoryIterator.Value:Examine
						wait 5
						EQ2UIPage[Journals,JournalsQuest].Child[Page,TabPages].Child[Page,2].Child[Page,6].Child[Composite,2].Child[Page,1].Child[Button,1]:LeftClick
					}
					else
						echo ISXRI: ${InventoryIterator.Value.Name} Already Collected
				}
			}
			waitframe
		}
		while ${InventoryIterator:Next(exists)}
	}
	EQ2UIPage[Journals,JournalsQuest]:Close
	echo ISXRI: Done collecting
}
function Depot()
{
	if ${Me.InventorySlotsFree}<1
	{
		echo ISXRI: You must have a free slot in your inventory
		return
	}
	if !${Actor[Query, Name=-"Collectible Depot" && Distance<12](exists)}
	{
		echo ISXRI: You must be within 12 of a collectible depot
		return
	}
	variable string TempName
	Actor[Collectible Depot]:DoubleClick
	wait 5
	do
	{
		declare num int ${ContainerWindow.NumItems}
		waitframe
	}
	while ${num}==0

	echo ISXRI: Checking ${num} items from collectible depot
	
	declare i int 0
	for (i:Set[1] ; ${i} <= ${num}; i:Inc)
	{
		if !${ContainerWindow.Item[${i}].IsItemInfoAvailable}
			wait 30 ${ContainerWindow.Item[${i}].IsItemInfoAvailable}
		TempName:Set[${ContainerWindow.Item[${i}]}]
		wait 10 ${ContainerWindow.Item[${i}].ToItemInfo.AlreadyCollected}
		if ${ContainerWindow.Item[${i}].IsItemInfoAvailable}
		{
			if !${ContainerWindow.Item[${i}].ToItemInfo.AlreadyCollected} && !${Me.Inventory[Query, Location=="Inventory" && Name=="${TempName}"](exists)}
			{
				echo ISXRI: Collecting ${TempName}
				
				ContainerWindow:RemoveItem["${ContainerWindow.Item[${i}].ID}",1]
				wait 30 ${Me.Inventory[Query, Location=="Inventory" && Name=="${TempName}"](exists)}
				;echo ${ContainerWindow.Item[${i}]}
				Me.Inventory[Query, Location=="Inventory" && Name=="${TempName}"]:Examine
				wait 5
				EQ2UIPage[Journals,JournalsQuest].Child[Page,TabPages].Child[Page,2].Child[Page,6].Child[Composite,2].Child[Page,1].Child[Button,1]:LeftClick
			}
			else
				echo ISXRI: ${TempName} Already Collected
		}
		waitframe
	}
	EQ2UIPage[Journals,JournalsQuest]:Close
	ContainerWindow:Close
	echo ISXRI: Done collecting
}