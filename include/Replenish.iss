;Replenish v1 by Herculezz
;need to add common food and drink
;need to add potion replenish
function main()
{
		
	;disable debugging
	Script:DisableDebugging
	
	if ${Actor["Food & Drink Depot"].Distance2D}<15
	{
		variable int FoodQty=${Me.Equipment[23].Quantity}	
		variable int DrinkQty=${Me.Equipment[24].Quantity}
		if ${FoodQty}==100 && ${DrinkQty}==100
		{
			echo ISXRI: Food and Drink already full
			Script:End
		}
		Actor["Food & Drink Depot"]:DoubleClick
		wait 5
		if ${FoodQty}>0
		{
			variable string FoodName=${Me.Equipment[23].Name}
			;echo Food: ${FoodName} is >0 
			if ${ContainerWindow.Item["${FoodName}"](exists)}
			{
				variable int FoodID=0
				while ${FoodID}==0
				{
					FoodID:Set[${ContainerWindow.Item["${FoodName}"].ID}]
					wait 1
				}
				;echo FoodID: ${FoodID}
				;echo ContainerWindow:RemoveItem[${FoodID},${Math.Calc[100-${FoodQty}]}]
				ContainerWindow:RemoveItem[${FoodID},${Math.Calc[100-${FoodQty}]}]
				wait 10
				Me.Inventory["${FoodName}"]:Equip
			}
			else
				echo ISXRI: No ${FoodName} in depot
		}
		else
		{
			if ${ContainerWindow.Item["${RI_Var_String_FoodName}"](exists)}
			{
				variable int StormbornSouffleID=0
				while ${StormbornSouffleID}==0
				{
					StormbornSouffleID:Set[${ContainerWindow.Item["${RI_Var_String_FoodName}"].ID}]
					wait 1
				}
				ContainerWindow:RemoveItem[${StormbornSouffleID},100]
				wait 10
				Me.Inventory["${RI_Var_String_FoodName}"]:Equip
			}
			else
				echo ISXRI: No ${RI_Var_String_FoodName} in depot
		}
		wait 5
		if ${DrinkQty}>0
		{
			variable string DrinkName=${Me.Equipment[24].Name}
			if ${ContainerWindow.Item["${DrinkName}"](exists)}
			{
				variable int DrinkID=${ContainerWindow.Item["${DrinkName}"].ID}
				while ${DrinkID}==0
				{
					DrinkID:Set[${ContainerWindow.Item["${DrinkName}"].ID}]
					wait 1
				}
				ContainerWindow:RemoveItem[${DrinkID},${Math.Calc[100-${DrinkQty}]}]
				wait 10
				Me.Inventory["${DrinkName}"]:Equip
			}
			else
				echo ISXRI: No ${DrinkName} in depot
		}
		else
		{
			if ${ContainerWindow.Item["${RI_Var_String_DrinkName}"](exists)}
			{
				variable int MonsoonID=0
				while ${MonsoonID}==0
				{
					MonsoonID:Set[${ContainerWindow.Item["${RI_Var_String_DrinkName}"].ID}]
					wait 1
				}
				ContainerWindow:RemoveItem[${MonsoonID},100]
				wait 10
				Me.Inventory["${RI_Var_String_DrinkName}"]:Equip
			}
			else
				echo ISXRI: No ${RI_Var_String_DrinkName} in depot
		}
		wait 10
		ContainerWindow:Close
	}
	else
		echo ISXRI: You must be near a food and drink depot
}