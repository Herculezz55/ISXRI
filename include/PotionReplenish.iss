;PotionReplenish v1 by Herculezz

function main()
{
		
	;disable debugging
	Script:DisableDebugging
	
	if ${Actor["Poison, Potion, & Totem Depot"].Distance2D}<15 
	{
		variable string potionName
		potionName:Set[${RI_Var_String_PotionName}]
		
		variable int PotionQty
		PotionQty:Set[${Me.Inventory[Query, Location=="Inventory" && Name=="${potionName}"].Quantity}]
		;echo ${PotionQty}
		if ${PotionQty}==100
		{
			echo ISXRI: Potion already full
			Script:End
		}
		Actor["Poison, Potion, & Totem Depot"]:DoubleClick
		wait 5
		if ${ContainerWindow.Item["${potionName}"](exists)}
		{
			variable int PotionID=0
			while ${PotionID}==0
			{
				PotionID:Set[${ContainerWindow.Item["${potionName}"].ID}]
				wait 1
			}
			;echo PotionID: ${PotionID}
			;echo ContainerWindow:RemoveItem[${FoodID},${Math.Calc[100-${FoodQty}]}]
			ContainerWindow:RemoveItem[${PotionID},${Math.Calc[100-${PotionQty}]}]
		}
		else
			echo ISXRI: No ${potionName} in depot
		
		wait 10
		ContainerWindow:Close
	}
	else
		echo ISXRI: You must be near a Poison, Potion, & Totem Depot
}