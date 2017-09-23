;poisonReplenish v1 by Herculezz

function main()
{
	;disable debugging
	Script:DisableDebugging
	
	if ${Me.Class.NotEqual[predator]} && ${Me.Class.NotEqual[rogue]} && ${Me.Class.NotEqual[bard]}
		Script:End
		
	if ${Actor["Poison, Potion, & Totem Depot"].Distance2D}<15
	{
		variable string poison1Name
		variable string poison2Name
		variable string poison3Name
		variable string poison4Name
		variable string poison5Name
		poison1Name:Set["${RI_Var_String_Poison1Name}"]
		poison2Name:Set["${RI_Var_String_Poison2Name}"]
		poison3Name:Set["${RI_Var_String_Poison3Name}"]
		poison4Name:Set["${RI_Var_String_Poison4Name}"]
		poison5Name:Set["${RI_Var_String_Poison5Name}"]
		
		variable int poison1Qty
		poison1Qty:Set[${Me.Inventory[Query, Location=="Inventory" && Name=="${poison1Name}"].Quantity}]
		variable int poison2Qty
		poison2Qty:Set[${Me.Inventory[Query, Location=="Inventory" && Name=="${poison2Name}"].Quantity}]
		variable int poison3Qty
		poison3Qty:Set[${Me.Inventory[Query, Location=="Inventory" && Name=="${poison3Name}"].Quantity}]
		variable int poison4Qty
		poison4Qty:Set[${Me.Inventory[Query, Location=="Inventory" && Name=="${poison4Name}"].Quantity}]
		variable int poison5Qty
		poison5Qty:Set[${Me.Inventory[Query, Location=="Inventory" && Name=="${poison5Name}"].Quantity}]
		if ${poison1Qty}==100 && ${poison2Qty}==100 && ${poison3Qty}==100 && ${poison4Qty}==100 && ${poison5Qty}==100
		{
			echo ISXRI: poison's already full
			Script:End
		}
		Actor["Poison, Potion, & Totem Depot"]:DoubleClick
		wait 5
		if ${ContainerWindow.Item["${poison1Name}"](exists)} && ${poison1Qty}<100 && ${Me.Class.NotEqual[bard]}
		{
			variable int poison1ID=0
			while ${poison1ID}==0
			{
				poison1ID:Set[${ContainerWindow.Item["${poison1Name}"].ID}]
				wait 1
			}
			;echo poison1ID: ${poison1ID}
			;echo ContainerWindow:RemoveItem[${poison1ID},${Math.Calc[100-${poison1Qty}]}]
			ContainerWindow:RemoveItem[${poison1ID},${Math.Calc[100-${poison1Qty}]}]
		}
		elseif !${ContainerWindow.Item["${poison1Name}"](exists)} && ${Me.Class.NotEqual[bard]}
			echo ISXRI: No ${poison1Name} in depot
		elseif ${poison1Qty}==100 && ${Me.Class.NotEqual[bard]}
			echo ISXRI: ${poison1Name} already full
		wait 10
		if ${ContainerWindow.Item["${poison2Name}"](exists)} && ${poison2Qty}<100
		{
			variable int poison2ID=0
			while ${poison2ID}==0
			{
				poison2ID:Set[${ContainerWindow.Item["${poison2Name}"].ID}]
				wait 1
			}
			;echo poison2ID: ${poison2ID}
			;echo ContainerWindow:RemoveItem[${poison2ID},${Math.Calc[100-${poison2Qty}]}]
			ContainerWindow:RemoveItem[${poison2ID},${Math.Calc[100-${poison2Qty}]}]
		}
		elseif !${ContainerWindow.Item["${poison2Name}"](exists)}
			echo ISXRI: No ${poison2Name} in depot
		elseif ${poison2Qty}==100
			echo ISXRI: ${poison2Name} already full
		wait 10
		if ${ContainerWindow.Item["${poison3Name}"](exists)} && ${poison3Qty}<100
		{
			variable int poison3ID=0
			while ${poison3ID}==0
			{
				poison3ID:Set[${ContainerWindow.Item["${poison3Name}"].ID}]
				wait 1
			}
			;echo poison3ID: ${poison3ID}
			;echo ContainerWindow:RemoveItem[${poison3ID},${Math.Calc[100-${poison3Qty}]}]
			ContainerWindow:RemoveItem[${poison3ID},${Math.Calc[100-${poison3Qty}]}]
		}
		elseif !${ContainerWindow.Item["${poison3Name}"](exists)}
			echo ISXRI: No ${poison3Name} in depot
		elseif ${poison3Qty}==100
			echo ISXRI: ${poison3Name} already full
		wait 10
		if ${ContainerWindow.Item["${poison4Name}"](exists)} && ${poison4Qty}<100
		{
			variable int poison4ID=0
			while ${poison4ID}==0
			{
				poison4ID:Set[${ContainerWindow.Item["${poison4Name}"].ID}]
				wait 1
			}
			;echo poison4ID: ${poison4ID}
			;echo ContainerWindow:RemoveItem[${poison4ID},${Math.Calc[100-${poison4Qty}]}]
			ContainerWindow:RemoveItem[${poison4ID},${Math.Calc[100-${poison4Qty}]}]
		}
		elseif !${ContainerWindow.Item["${poison4Name}"](exists)}
			echo ISXRI: No ${poison4Name} in depot
		elseif ${poison4Qty}==100
			echo ISXRI: ${poison4Name} already full
		wait 10
		if ${ContainerWindow.Item["${poison5Name}"](exists)} && ${poison5Qty}<100
		{
			variable int poison5ID=0
			while ${poison5ID}==0
			{
				poison5ID:Set[${ContainerWindow.Item["${poison5Name}"].ID}]
				wait 1
			}
			;echo poison5ID: ${poison5ID}
			;echo ContainerWindow:RemoveItem[${poison5ID},${Math.Calc[100-${poison5Qty}]}]
			ContainerWindow:RemoveItem[${poison5ID},${Math.Calc[100-${poison5Qty}]}]
		}
		elseif !${ContainerWindow.Item["${poison5Name}"](exists)}
			echo ISXRI: No ${poison5Name} in depot
		elseif ${poison5Qty}==100
			echo ISXRI: ${poison5Name} already full
		wait 10
		ContainerWindow:Close
	}
	else
		echo ISXRI: You must be near a Poison, Potion, & Totem Depot
}