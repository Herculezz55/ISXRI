;;;; Thinking i want to implement a group alias option so it can be ran ri_Inventory aliasname  or ri_Inventory toon1|toon2|toon3   and we will just doa  .Find[|]
variable(global) RIInventoryObject RIInventoryObj
variable filepath FP
variable settingsetref RIInventorySet
variable(global) string RI_Var_String_RIInventoryScriptName=${Script.Filename}
variable index:string Items
variable(global) bool RIInventoryExecuteActions=FALSE
variable string BagQuery
variable bool Loop=FALSE
variable bool UseBag1=FALSE
variable bool UseBag2=FALSE
variable bool UseBag3=FALSE
variable bool UseBag4=FALSE
variable bool UseBag5=FALSE
variable bool UseBag6=FALSE
variable bool DepositToDepot=FALSE
variable bool Start=FALSE
variable int ALLAmount=0
variable index:string Inventory
variable index:string InventoryMatches
variable(global) bool RII_Var_Bool_SkipThisItem=0
variable(global) string RII_Var_String_ItemName
variable index:item BagIndex
variable index:item InventoryIndex
variable int Bag1
variable int Bag2
variable int Bag3
variable int Bag4
variable int Bag5
variable int Bag6
variable int intQuery
variable iterator InventoryIterator
variable iterator ItemsIterator
function main(... args)
{
	;disable Debugging
	Script:DisableDebugging
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[RIInventory]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory"]
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RIInventory.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RIInventory.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml" http://www.isxri.com/RIInventory.xml
		wait 50
	}
	
	variable int ArgCount=1
	variable bool LoadUI=TRUE
	Event[EQ2_onIncomingText]:AttachAtom[RIIEQ2_onIncomingText]
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"
	echo ISXRI: Starting RI Inventory
	while ${ArgCount} <= ${args.Used}
	{
		switch ${args[${ArgCount}]}
		{
			case -noui
				LoadUI:Set[FALSE]
				break
			case -loop
			{
				UIElement[LoopCheckBox@RIInventory]:SetChecked
				Loop:Set[TRUE]
				Start:Set[1]
				break
			}
			case -start
				Start:Set[1]
				break
			default
				break
		}
		ArgCount:Inc
	}

	if !${LoadUI}
		UIElement[RIInventory]:Hide
		
	Me:QueryInventory[BagIndex, IsInventoryContainer=TRUE]
	variable iterator BagsIterator
	BagIndex:GetIterator[BagsIterator]
	UIElement[DeleteLeftCheckBox@RIInventory]:SetText[<- Delete Leftovers]
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
	
	;set button colors
	UIElement[AddSellButton@RIInventory].Font:SetColor[FF0099FF]
	UIElement[AddDestroyButton@RIInventory].Font:SetColor[FFFF0000]
	UIElement[AddSalvageButton@RIInventory].Font:SetColor[FF33CC33]
	UIElement[AddTransmuteButton@RIInventory].Font:SetColor[FFCC33FF]
	UIElement[AddExtractButton@RIInventory].Font:SetColor[FFFFFF00]

	;load saved items list
	RIInventoryObj:Load
	
	;load inventory list into listbox
	RIInventoryObj:LoadInventoryList
	
	if ${Start} && ${Me.Name(exists)}
		RIInventoryObj:Execute
	
	if !${LoadUI}
	{
		UIElement[RIInventory]:Hide
	}
	;load events
	Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
	
	while 1
	{
		call Ready
		if ${RIInventoryExecuteActions} && ${Me.Name(exists)}
			call RIInventoryObj.ExecuteActions
		wait 50 !${Me.InCombat} && !${Me.IsMoving}
	}
}
function Ready()
{
	while ${Me.InCombat} || ${Me.IsMoving} || ${EQ2.Zoning}!=0
		wait 1
}
atom(global) displayindex()
{
	variable int counter
	for(counter:Set[1];${counter}<=${Items.Used};counter:Inc)
	{
		echo ${counter}: ${Items.Get[${counter}]}
	}
}
atom(global) rii(string _What)
{
	if ${_What.Upper.Equal[END]} || ${_What.Upper.Equal[EXIT]}
		Script:End
	else
		UIElement[RIInventory]:Show
}
objectdef RIInventoryObject
{
	method Hide()
	{
		UIElement[RIInventory]:Hide
	}
	method Execute()
	{
		;build our Query
		if ${UIElement[LoopCheckBox@RIInventory].Checked}
			Loop:Set[TRUE]
		else
			Loop:Set[FALSE]
		echo ISXRI: Executing Actions, Loop=${Loop}
		BagQuery:Set["("]
		if ${UseBag1}
		{
			;echo ${BagQuery[${BagQuery.Length}].Equal[(]} // ${BagQuery[${BagQuery.Length}]} // ${BagQuery.Length} // ${BagQuery} // ${BagQuery.GetAt[1]}==40
			if ${BagQuery.GetAt[${BagQuery.Length}]}==40
				BagQuery:Concat[InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=0].ContainerID}]
			else
				BagQuery:Concat[||InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=0].ContainerID}]
		}
		if ${UseBag2}
		{
			if ${BagQuery.GetAt[${BagQuery.Length}]}==40
				BagQuery:Concat[InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=1].ContainerID}]
			else
				BagQuery:Concat[||InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=1].ContainerID}]
		}
		if ${UseBag3}
		{
			if ${BagQuery.GetAt[${BagQuery.Length}]}==40
				BagQuery:Concat[InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=2].ContainerID}]
			else
				BagQuery:Concat[||InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=2].ContainerID}]
		}
		if ${UseBag4}
		{
			if ${BagQuery.GetAt[${BagQuery.Length}]}==40
				BagQuery:Concat[InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=3].ContainerID}]
			else
				BagQuery:Concat[||InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=3].ContainerID}]
		}
		if ${UseBag5}
		{
			if ${BagQuery.GetAt[${BagQuery.Length}]}==40
				BagQuery:Concat[InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=4].ContainerID}]
			else
				BagQuery:Concat[||InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=4].ContainerID}]
		}
		if ${UseBag6}
		{
			if ${BagQuery.GetAt[${BagQuery.Length}]}==40
				BagQuery:Concat[InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=5].ContainerID}]
			else
				BagQuery:Concat[||InContainerID=${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=5].ContainerID}]
		}
		BagQuery:Concat[")"]
		;echo ${BagQuery}
		RIInventoryExecuteActions:Set[1]
	}
	function SetMatches(string _In)
	{
		echo InventoryMatches:Insert[${_In}]
	}
	function ExecuteActions()
	{
		variable int counter

		if ${UIElement[LoopCheckBox@RIInventory].Checked}
			Loop:Set[TRUE]
		else
			Loop:Set[FALSE]
		
		;UIElement[ExecuteButton@RIInventory].Font:SetColor[FFF9F099]
		if ${Loop}
			UIElement[ExecuteButton@RIInventory]:SetText[Looping]
		else
			UIElement[ExecuteButton@RIInventory]:SetText[Executing]
		RIInventoryObj:Load[0]
		if ${DepositToDepot}
		{
			if ${Actor[Query, Name=-"Lore & Legend Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Lore & Legend Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Scroll Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Scroll Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Harvesting Supply Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Harvesting Supply Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Collectible Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Collectible Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Adornment Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Adornment Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Totem Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Totem Depot"].ID} 0
				wait 5
			}
		}
		RI_CMD_Assist 0
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && ${BagQuery}]
		InventoryMatches:Clear
		;for(counter:Set[1];${counter}<=${InventoryIndex.Used};counter:Inc)
		;{
	;		Items:ForEach["execute \${If[\${ForEach.Value.Token[1,|].Equals[\${InventoryIndex.Get[\${counter}].Name}]},call CheckMatches \"\${InventoryIndex.Get[\${counter}].ID}|\${ForEach.Value.Token[2,|]}\",noop]}"]
	;	}
		for(counter:Set[1];${counter}<=${Items.Used};counter:Inc)
		{
			;echo ${Items.Get[${counter}]}
			if ${Items.Get[${counter}].Token[1,|].Find["*All"]}
				InventoryMatches:Insert[${Items.Get[${counter}]}]
			elseif ${Items.Get[${counter}].Token[1,|].Find["Status Bounty [50"]} && ${Me.Inventory[Query, Name=="Status Bounty [50,000]" && Location=="Inventory"](exists)}
				InventoryMatches:Insert[${Me.Inventory[Query, Name=="Status Bounty [50,000]" && Location=="Inventory"].ID}|${Items.Get[${counter}].Token[2,|]}]
			else				
				InventoryIndex:ForEach["execute \${If[\${ForEach.Value.Name.Equals[\${Items.Get[\${counter}].Token[1,|]}]},\"InventoryMatches:Insert[\${ForEach.Value.ID}|\${Items.Get[\${counter}].Token[2,|]}]\",noop]}"]
		}
		;echo ${InventoryMatches.Used}
		
		variable int GUCnt=0
		
		;InventoryIndex:GetIterator[InventoryIterator]
		ALLAmount:Set[0]
		for(counter:Set[1];${counter}<=${InventoryMatches.Used};counter:Inc)
		{
			call Ready
			;echo ${counter}: ${InventoryMatches.Get[${counter}]} // ${InventoryMatches.Get[${counter}].Token[1,|]} // ${InventoryMatches.Get[${counter}].Token[2,|]}
			
			RII_Var_Bool_SkipThisItem:Set[0]
			if ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Transmute]} || ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Sell]} || ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Destroy]} || ${Items.Get[${counter}].Token[2,|].Equal[Salvage]} || ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Extract]}
			{
				if ${InventoryMatches.Get[${counter}].Find["*All"]}
				{
					ALLAmount:Inc
					continue
				}
				if ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Sell]} && ${Loop}
					continue
				if ${Me.Inventory[id,${InventoryMatches.Get[${counter}].Token[1,|]}](exists)}
				{
					call Ready
					RII_Var_String_ItemName:Set["${Me.Inventory[id,${InventoryMatches.Get[${counter}].Token[1,|]}].Name}"]
					if ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Sell]} && ( ${Actor[guild,Guild Commodities Exporter].Distance}>12 || !${Actor[guild,Guild Commodities Exporter](exists)} )
					{
						echo ISXRI: Skipping ${RII_Var_String_ItemName} we are not near a vendor
						continue
					}
					if ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Salvage]} && !${Me.Ability[id,2266640201](exists)}
					{
						echo ISXRI: Skipping ${RII_Var_String_ItemName} we do not have salvage ability
						continue
					}
					if ${InventoryMatches.Get[${counter}].Token[2,|].Equal[Transmute]} && !${Me.Ability[id,2266640201](exists)}
					{
						echo ISXRI: Skipping ${RII_Var_String_ItemName} we do not have transmute ability
						continue
					}
					GUCnt:Set[0]
					
					while ${Me.Inventory[id,${InventoryMatches.Get[${counter}].Token[1,|]}](exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
						call This.${InventoryMatches.Get[${counter}].Token[2,|]} "${InventoryMatches.Get[${counter}].Token[1,|]}" ${GUCnt}
					;waitframe
				}
			}
		}
		;do alls
		;echo ${ALLAmount}
		
		for(counter:Set[1];${counter}<=${ALLAmount};counter:Inc)
		{
			;echo ${Items.Get[${counter}].Token[1,|].ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"]}
			;echo ${Items.Get[${counter}].Token[2,|]}
			call This.${Items.Get[${counter}].Token[2,|]}ALL "${Items.Get[${counter}].Token[1,|]}"
		}
		if ${UIElement[AddAgentsCheckBox@RIInventory].Checked}
			call AddAgents
		if ${UIElement[ConvertAgentsCheckBox@RIInventory].Checked}
			call ConvertAgents
		if ${UIElement[AddFamiliarsCheckBox@RIInventory].Checked}
			call AddFamiliars
		if ${UIElement[DeleteLeftCheckBox@RIInventory].Checked}
			call DeleteLeft

		if !${Loop}
		{
			RIInventoryExecuteActions:Set[0]
			echo ISXRI: Done Executing Actions
			UIElement[ExecuteButton@RIInventory].Font:SetColor[FFF9F099]
			UIElement[ExecuteButton@RIInventory]:SetText[Execute]
			if ${EQ2UIPage[Inventory,Merchant].IsVisible}
				EQ2UIPage[Inventory,Merchant]:Close
		}
		RI_CMD_Assist 1
		if ${DepositToDepot}
		{
			if ${Actor[Query, Name=-"Lore & Legend Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Lore & Legend Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Scroll Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Scroll Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Harvesting Supply Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Harvesting Supply Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Collectible Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Collectible Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Adornment Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Adornment Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=-"Totem Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Totem Depot"].ID} 0
				wait 5
			}
		}
		if ${Start} && !${Loop}
			Script:End
	}
	function Transmute(int _ItemID, int _Cnt=1)
	{
		;echo Transmute : : : ${_ItemID}
		;return
		call Ready
		if ${_Cnt}==1
			echo ISXRI: Transmuting "${Me.Inventory[id,${_ItemID}]}"
		eq2ex usea Transmute
		wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
		Me.Inventory[id,${_ItemID}]:Transmute
		wait 10 ${Me.CastingSpell}
		wait 10 !${Me.CastingSpell}
		wait 5
		wait 10
	}
	function AddFamiliars()
	{
		;echo ISXRI: Adding Familiars
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsFamiliar=TRUE]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}

		variable int GUCnt=0
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]

		if ${InventoryIterator:First(exists)}
		{
			do
			{
				echo ISXRI: Adding Familiar: ${InventoryIterator.Value}
				RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
				GUCnt:Set[0]
				while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
				{
					InventoryIterator.Value:AddFamiliar[confirm]
					wait 10
				}
				if ${RII_Var_Bool_SkipThisItem}
					RII_Var_Bool_SkipThisItem:Set[0]
			}
			while ${InventoryIterator:Next(exists)}
			
		}
	}
	function DeleteLeft()
	{
		;echo ISXRI: Delete Leftovers
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && ( IsAgent=TRUE || IsFamiliar=TRUE )]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}

		variable int GUCnt=0
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]

		if ${InventoryIterator:First(exists)}
		{
			do
			{
				RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
				
				GUCnt:Set[0]
				while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
					call Destroy ${InventoryIterator.Value.ID} ${GUCnt}
				if ${RII_Var_Bool_SkipThisItem}
					RII_Var_Bool_SkipThisItem:Set[0]
			}
			while ${InventoryIterator:Next(exists)}
		}
	}
	function Ready()
	{
		while ${Me.InCombat} || ${Me.IsMoving} || ${EQ2.Zoning}!=0
			wait 1
	}
	function AddAgents()
	{
		;echo ISXRI: Adding Agents
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsAgent=TRUE]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}

		variable int GUCnt=0
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]

		if ${InventoryIterator:First(exists)}
		{
			do
			{

				RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
				echo ISXRI: Adding Agent: ${InventoryIterator.Value.Name}
				GUCnt:Set[0]
				while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
				{
					InventoryIterator.Value:AddAgent[confirm]
					wait 10
				}
				if ${RII_Var_Bool_SkipThisItem}
					RII_Var_Bool_SkipThisItem:Set[0]
			}
			while ${InventoryIterator:Next(exists)}
		}
	}
	function ConvertAgents()
	{
		;echo ISXRI: Converting Agents
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsAgent=TRUE]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}

		variable int GUCnt=0
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
					if ${InventoryIterator.Value.ToItemInfo.NumItemsCreated}<1
					{
						;if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it is not Convertable
						continue
					}
					echo ISXRI: Converting Agent: ${InventoryIterator.Value}
					RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
					GUCnt:Set[0]
					while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
					{
						InventoryIterator.Value:ConvertAgent[confirm]
						wait 10
					}
					if ${RII_Var_Bool_SkipThisItem}
						RII_Var_Bool_SkipThisItem:Set[0]
				}
			}
			while ${InventoryIterator:Next(exists)}
		}
	}
	function TransmuteALL(string _Type)
	{
		;echo ISXRI: Transmuting ${_Type}
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && IsAgent=FALSE && IsFamiliar=FALSE && IsUnpackable=FALSE && IsFoodOrDrink=FALSE]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}

		variable int GUCnt=0
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]

		if ${InventoryIterator:First(exists)}
		{
			do
			{
				call Ready
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
					if ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Shield]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Ranged Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Armor]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Spell Scroll]}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
						continue
					}
					if ${InventoryIterator.Value.ToItemInfo.NoTransmute}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
						continue
					}
					if ${InventoryIterator.Value.ToItemInfo.MercOnly}
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
					if ${InventoryIterator.Value.ToItemInfo.Tier.NotEqual[${_Type.ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"].Upper}]} && !${InventoryIterator.Value.ToItemInfo.Type.Equal[Spell Scroll]}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it is not the correct tier
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
						if ${InventoryIterator.Value.Name.Find[(Master)](exists)} && !${_Type.ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"].Find[Masters]}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Master
							continue
						}
						if ${InventoryIterator.Value.Name.Find[(Expert)](exists)} && !${_Type.ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"].Find[Experts]}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Expert
							continue
						}
						if ${InventoryIterator.Value.Name.Find[(Adept)](exists)} && !${_Type.ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"].Find[Adepts]}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we are not set to Transmute Adept
							continue
						}
						if ${InventoryIterator.Value.Name.Find[(Grandmaster)](exists)}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we do not Transmute Grandmaster
							continue
						}
						if ${InventoryIterator.Value.Name.Find[(Ancient)](exists)}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we do not Transmute Ancient
							continue
						}
						if ${InventoryIterator.Value.Name.Find[(Celestial)](exists)}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because we do not Transmute Celestial
							continue
						}
						if ${InventoryIterator.Value.Name.Find[Accolade](exists)}
						{
							if ${Debug}
								echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be transmuted
							continue
						}
					}
					call Ready
					RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
					while ${InventoryIterator.Value.Quantity}>1 && !${RII_Var_Bool_SkipThisItem}
					{
						GUCnt:Set[0]
						while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10
							call Transmute ${InventoryIterator.Value.ID}
					}
					if ${InventoryIterator.Value.Quantity}>0 && !${RII_Var_Bool_SkipThisItem}
					{
						GUCnt:Set[0]
						while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10
							call Transmute ${InventoryIterator.Value.ID} ${GUCnt}
					}
					if ${RII_Var_Bool_SkipThisItem}
						RII_Var_Bool_SkipThisItem:Set[0]
				}
				else
				{
					ISXRI: Skipping ${InventoryIterator.Value.Name}, could not get ItemInfo from server in a timely manner
				}
			}
			while ${InventoryIterator:Next(exists)}
		}
	}
	function Salvage(int _ItemID, int _Cnt=1)
	{
		if !${Me.Ability[id,2266640201].TimeUntilReady(exists)}
		{
			echo ISXRI: We do not have the Salvage Ability, Skipping Salvage: ${RII_Var_String_ItemName}
			RII_Var_Bool_SkipThisItem:Set[1]
			return
		}
		;echo Salvage : : : ${_ItemID}
		;return
		call Ready
		if ${_Cnt}==1
			echo ISXRI: Salvaging "${Me.Inventory[id,${_ItemID}]}"
		eq2ex usea Salvage
		wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
		Me.Inventory[id,${_ItemID}]:Salvage
		wait 10 ${Me.CastingSpell}
		wait 10 !${Me.CastingSpell}
		wait 5
		wait 10
	}
	function SalvageALL(string _Type)
	{
		if !${Me.Ability[id,2266640201].TimeUntilReady(exists)}
		{
			echo ISXRI: We do not have the Salvage Ability, Skipping Salvage All ${_Type}
			RII_Var_Bool_SkipThisItem:Set[1]
			return
		}
		;echo ISXRI: Salvaging ${_Type}
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && IsAgent=FALSE && IsFamiliar=FALSE && IsUnpackable=FALSE && Quantity=1 && IsFoodOrDrink=FALSE]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}
		variable int GUCnt=0
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]

		if ${InventoryIterator:First(exists)}
		{
			
			do
			{
				call Ready
				;echo Checking ${InventoryIterator.Value}
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
					if ${InventoryIterator.Value.ToItemInfo.NoSalvage}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be Salvaged
						continue
					}
					if ${InventoryIterator.Value.ToItemInfo.MercOnly}
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
					if ${InventoryIterator.Value.ToItemInfo.Tier.NotEqual[${_Type.ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"].Upper}]}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it is not the correct tier
						continue
					}
					call Ready
					RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
					;echo ${InventoryIterator.Value.Name} - ${InventoryIterator.Value} - ${InventoryIterator.Value.InContainerID} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].IsInventoryContainer} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].Slot} - ${InventoryIterator.Value.ToItemInfo.Tier} - ${InventoryIterator.Value.ToItemInfo.Type}
					GUCnt:Set[0]
					while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
						call Salvage ${InventoryIterator.Value.ID} ${GUCnt}

					if ${RII_Var_Bool_SkipThisItem}
						RII_Var_Bool_SkipThisItem:Set[0]
				}
				else
				{
					ISXRI: Skipping ${InventoryIterator.Value.Name}, could not get ItemInfo from server in a timely manner
				}
			}
			while ${InventoryIterator:Next(exists)}
		}
	}
	function ExtractALL(string _Type)
	{
		if !${Me.Ability[id,406528868].TimeUntilReady(exists)}
		{
			echo ISXRI: We do not have the Extract Planar Essence Ability, Skipping Extracting All ${_Type}
			RII_Var_Bool_SkipThisItem:Set[1]
			return
		}
		;echo ISXRI: Extracting ${_Type}
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && IsAgent=FALSE && IsFamiliar=FALSE && IsUnpackable=FALSE && Quantity=1 && IsFoodOrDrink=FALSE]
		;echo ${InventoryIndex.Used}
		
		if !${UseBag1}
		{
			;echo b1nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag1}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag2}
		{
			;echo b2nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag2}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag3}
		{
			;echo b3nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag3}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag4}
		{
			;echo b4nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag4}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag5}
		{
			;echo b5nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag5}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		if !${UseBag6}
		{
			;echo b6nc
			intQuery:Set[${LavishScript.CreateQuery[InContainerID = ${Bag6}]}]
			InventoryIndex:RemoveByQuery[${intQuery},TRUE]
			LavishScript:FreeQuery[${intQuery}]
			InventoryIndex:Collapse
		}
		;echo ${InventoryIndex.Used}
		variable int GUCnt=0
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]
		;echo ${InventoryIndex.Used}
		if ${InventoryIterator:First(exists)}
		{
			do
			{
				call Ready
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
					if ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Ranged Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Weapon]} && ${InventoryIterator.Value.ToItemInfo.Type.NotEqual[Shield]}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be Extracted
						continue
					}
					if ${InventoryIterator.Value.ToItemInfo.MercOnly}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be Extracted
						continue
					}
					if ${InventoryIterator.Value.ToItemInfo.NoValue} || ${InventoryIterator.Value.ToItemInfo.Level}<=100 
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it can not be Extracted
						continue
					}
					if ${InventoryIterator.Value.ToItemInfo.Tier.NotEqual[${_Type.ReplaceSubstring["*All ",""].ReplaceSubstring[" Items*"].Upper}]}
					{
						if ${Debug}
							echo ISXRI: Skipping: ${InventoryIterator.Value.Name}, because it is not the correct tier
						continue
					}
					call Ready
					RII_Var_String_ItemName:Set["${InventoryIterator.Value.Name}"]
					;echo ${InventoryIterator.Value.Name} - ${InventoryIterator.Value} - ${InventoryIterator.Value.InContainerID} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].IsInventoryContainer} - ${Me.Inventory[id,${InventoryIterator.Value.ID}].Slot} - ${InventoryIterator.Value.ToItemInfo.Tier} - ${InventoryIterator.Value.ToItemInfo.Type}
					GUCnt:Set[0]
					while ${InventoryIterator.Value.ID(exists)} && ${GUCnt:Inc}<10 && !${RII_Var_Bool_SkipThisItem}
						call Extract ${InventoryIterator.Value.ID} ${GUCnt}
					if ${RII_Var_Bool_SkipThisItem}
						RII_Var_Bool_SkipThisItem:Set[0]
				}
				else
				{
					ISXRI: Skipping ${InventoryIterator.Value.Name}, could not get ItemInfo from server in a timely manner
				}
			}
			while ${InventoryIterator:Next(exists)}
		}
	}
	function Extract(int _ItemID, int _Cnt=1)
	{
		if !${Me.Ability[id,406528868].TimeUntilReady(exists)}
		{
			echo ISXRI: We do not have the Extract Planar Essence Ability, Skipping Extracting: ${RII_Var_String_ItemName}
			RII_Var_Bool_SkipThisItem:Set[1]
			return
		}
		call Ready
		if ${_Cnt}==1
			echo ISXRI: Extracting "${Me.Inventory[id,${_ItemID}]}"
		eq2ex usea 406528868
		wait 20 ${EQ2.ReadyToRefineTransmuteOrSalvage}
		wait 10
		Me.Inventory[id,${_ItemID}]:Extract
		wait 10 ${Me.CastingSpell}
		wait 10 !${Me.CastingSpell}
		wait 5
		wait 10
	}
	function Destroy(int _ItemID, int _Cnt=1)
	{
		;echo Destroy : : : ${_ItemID}
		;return
		call Ready
		if ${_Cnt}==1
			echo ISXRI: Destroying "${Me.Inventory[id,${_ItemID}]}"
		Me.Inventory[id,${_ItemID}]:Destroy
		wait 10
	}
	function Sell(int _ItemID, int _Cnt=1)
	{
		if ${Actor[guild,Guild Commodities Exporter].Distance}<12 && ${Me.Inventory[id,${_ItemID}](exists)}
		{
			if ${Target.ID}!=${Actor[guild,Guild Commodities Exporter].ID}
				Actor[guild,Guild Commodities Exporter]:DoTarget
			if !${EQ2UIPage[Inventory,Merchant].IsVisible}
				Actor[guild,Guild Commodities Exporter]:DoubleClick
			wait 2
			if ${_Cnt}==1
				echo ISXRI: Selling "${Me.Inventory[id,${_ItemID}]}"
			;return
			;old way Me.Merchandise["${Me.Inventory[id,${_ItemID}]}"]:Sell[${Me.Inventory[Query,Location=="Inventory"&&Name=="${Me.Inventory[id,${_ItemID}]}"&&${BagQuery}].Quantity}]
			MerchantWindow.MyInventory["${Me.Inventory[id,${_ItemID}].Name}"]:Sell[${Me.Inventory[Query,Location=="Inventory"&&Name=="${Me.Inventory[id,${_ItemID}]}"&&${BagQuery}].Quantity}]
		}
		wait 10
	}
	method LoadInventoryList()
	{
		variable index:item InventoryIndex
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && IsFoodOrDrink=FALSE]
		variable int _count
		variable bool _FoundAdded=0
		variable string _TempString
		;echo ${InventoryIndex.Used}
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]
		Inventory:Clear
		UIElement[InventoryListbox@RIInventory]:ClearItems
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Treasured Items*","0",FF93D9FF]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Legendary Items*","1",FFF9C48F]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All MC Legendary Items*","2",FFF9C48F]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Fabled Items*","3",FFFF9D9D]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All MC Fabled Items*","4",FFFF9D9D]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Ethereal Items*","5",FFF36100]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Mythical Items*","6",FFEA93FF]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Adepts*","7",FF93D9FF]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Experts*","8",FFF9C48F]
		UIElement[InventoryListbox@RIInventory]:AddItem["*All Masters*","9",FFFF9D9D]
		
		if ${InventoryIterator:First(exists)}
		{
			do
			{
				Inventory:Insert["${InventoryIterator.Value}"]
				_TempString:Set["${InventoryIterator.Value}"]
				_FoundAdded:Set[0]
				if ${UIElement[FilterAddedCheckBox@RIInventory].Checked}
				{
					;check AddedItemsListbox@RIInventory for This item and if it exists continue
					for(_count:Set[1];${_count}<=${UIElement[AddedItemsListbox@RIInventory].Items};_count:Inc)
					{
						if ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${_count}].Text.Equal[${InventoryIterator.Value}]}
						{
							_FoundAdded:Set[1]
							break
						}
					}
				}
				;check InventoryListbox@RIInventory for This item and if it exists continue
				for(_count:Set[1];${_count}<=${UIElement[AddedItemsListbox@RIInventory].Items};_count:Inc)
				{
					if ${UIElement[InventoryListbox@RIInventory].OrderedItem[${_count}].Text.Equal[${InventoryIterator.Value}]}
					{
						_FoundAdded:Set[1]
						break
					}
				}
				;echo ${_TempString}
				if ${UIElement[FilterInfusersCheckBox@RIInventory].Checked} && ${_TempString.Right[7].Equal[Infuser]}
					continue
				if ${UIElement[FilterGACheckBox@RIInventory].Checked} && ${_TempString.Equal[Guided Ascension]}
					continue
				if ${UIElement[FilterCallsBotCheckBox@RIInventory].Checked} && ( ${_TempString.Left[7].Equal[Call of]} || ${_TempString.Equal[Twark Transport Totem]} || ${_TempString.Equal[Mechanized Platinum Repository of Reconstruction]} )
					continue
				if ${UIElement[FilterIllegibleIncompleteCheckBox@RIInventory].Checked} && ( ${_TempString.Left[22].Equal[Illegible Scroll Page:]} || ${_TempString.Left[18].Equal[Incomplete Scroll:]} )
					continue
				if ${UIElement[FilterAdornsCheckBox@RIInventory].Checked} && ${_TempString.Find[Adornment](exists)}
					continue
				if !${UIElement[Bag1CheckBox@RIInventory].Checked} && ${Me.Inventory[id,${InventoryIterator.Value.ID}].InContainerID}==${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=0].ContainerID}
					continue
				if !${UIElement[Bag2CheckBox@RIInventory].Checked} && ${Me.Inventory[id,${InventoryIterator.Value.ID}].InContainerID}==${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=1].ContainerID}
					continue
				if !${UIElement[Bag3CheckBox@RIInventory].Checked} && ${Me.Inventory[id,${InventoryIterator.Value.ID}].InContainerID}==${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=2].ContainerID}
					continue
				if !${UIElement[Bag4CheckBox@RIInventory].Checked} && ${Me.Inventory[id,${InventoryIterator.Value.ID}].InContainerID}==${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=3].ContainerID}
					continue
				if !${UIElement[Bag5CheckBox@RIInventory].Checked} && ${Me.Inventory[id,${InventoryIterator.Value.ID}].InContainerID}==${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=4].ContainerID}
					continue
				if !${UIElement[Bag6CheckBox@RIInventory].Checked} && ${Me.Inventory[id,${InventoryIterator.Value.ID}].InContainerID}==${Me.Inventory[Query, IsInventoryContainer=TRUE && Slot=5].ContainerID}
					continue
				if !${_FoundAdded}
					UIElement[InventoryListbox@RIInventory]:AddItem["${_TempString}","${_TempString}"]
			}
			while ${InventoryIterator:Next(exists)}
		}		
	}

	method AddedItemsListboxRightClick()
	{
		if ${UIElement[AddedItemsListbox@RIInventory].SelectedItem.ID(exists)}
		{
			UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].SelectedItem.ID}]
			This:Save
		}
	}
	
	method AddTransmute(string _ItemName)
	{
		;echo ${_ItemName}
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedItemsListbox@RIInventory].Items};i:Inc)
			{
				if ${_ItemName.Find["*All"]}
				{
					if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]} && ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].TextColor} == -3394561
						return
				}
				else
				{
					if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
						UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
				}
			}
			if ${_ItemName.Find["*All"]}
				UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","",FFcc33ff]
			else
				UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FFcc33ff]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FFcc33ff]
			if !${_ItemName.Find["*All"]}
				UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method AddSalvage(string _ItemName)
	{
		;echo ${_ItemName} 
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]} && !${_ItemName.Find["*All Adepts"]} && !${_ItemName.Find["*All Masters"]} && !${_ItemName.Find["*All Experts"]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedItemsListbox@RIInventory].Items};i:Inc)
			{
				if ${_ItemName.Find["*All"]}
				{
					if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]} && ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].TextColor} == -13382605
						return				
				}
				else
				{
					if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
						UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
				}
			}
			if ${_ItemName.Find["*All"]}
				UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","",FF33CC33]
			else
				UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FF33CC33]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FF33CC33]
			if !${_ItemName.Find["*All"]}
				UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method AddSell(string _ItemName)
	{
		;echo ${_ItemName}
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]} && !${_ItemName.Find["*All"]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedItemsListbox@RIInventory].Items};i:Inc)
			{
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FF0099ff]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FF0099ff]
			UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method AddDestroy(string _ItemName)
	{
		;echo ${_ItemName}
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]} && !${_ItemName.Find["*All"]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedItemsListbox@RIInventory].Items};i:Inc)
			{
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FFFF0000]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FFFF0000]
			UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method AddExtract(string _ItemName)
	{
		;echo ${_ItemName}
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]} && !${_ItemName.Find["*All Adepts"]} && !${_ItemName.Find["*All Masters"]} && !${_ItemName.Find["*All Experts"]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedItemsListbox@RIInventory].Items};i:Inc)
			{
				if ${_ItemName.Find["*All"]}
				{
					if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]} && ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].TextColor} == -256
						return
				}
				else
				{
					if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
						UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
				}
			}
			if ${_ItemName.Find["*All"]}
				UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","",FFFFFF00]
			else
				UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FFFFFF00]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FFFFFF00]
			if !${_ItemName.Find["*All"]}
				UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method Load(bool _PopulateListBox=TRUE)
	{
		variable int allscnt=0
		Items:Clear
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/"]
		if ${FP.FileExists[RIInventorySave.xml]}
		{
			LavishSettings[RIInventory]:Clear
			LavishSettings:AddSet[RIInventory]
			LavishSettings[RIInventory]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			RIInventorySet:Set[${LavishSettings[RIInventory].GUID}]

			variable settingsetref LoadListSet=${RIInventorySet.FindSet[RIInventory].GUID}
			LoadListSet:Set[${RIInventorySet.FindSet[RIInventory].GUID}]
			
			variable iterator Iterator
			LoadListSet:GetSetIterator[Iterator]
			
			variable string _Color
			variable string _Action
			if !${Iterator:First(exists)}
				return
				
			do
			{
				if ${Iterator.Key.Equal[Bag1]} || ${Iterator.Key.Equal[Bag2]} || ${Iterator.Key.Equal[Bag3]} || ${Iterator.Key.Equal[Bag4]} || ${Iterator.Key.Equal[Bag5]} || ${Iterator.Key.Equal[Bag6]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[${Iterator.Key}CheckBox@RIInventory]:SetChecked;Use${Iterator.Key}:Set[1]
					else
						UIElement[${Iterator.Key}CheckBox@RIInventory]:UnsetChecked;Use${Iterator.Key}:Set[0]
				}
				elseif ${Iterator.Key.Equal[FilterAdded]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterAddedCheckBox@RIInventory]:SetChecked
					else
						UIElement[FilterAddedCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[DeleteLeft]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[DeleteLeftCheckBox@RIInventory]:SetChecked
					else
						UIElement[DeleteLeftCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[AddAgents]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[AddAgentsCheckBox@RIInventory]:SetChecked
					else
						UIElement[AddAgentsCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[AddFamiliars]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[AddFamiliarsCheckBox@RIInventory]:SetChecked
					else
						UIElement[AddFamiliarsCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[ConvertAgents]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[ConvertAgentsCheckBox@RIInventory]:SetChecked
					else
						UIElement[ConvertAgentsCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterInfusers]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterInfusersCheckBox@RIInventory]:SetChecked
					else
						UIElement[FilterInfusersCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterGA]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterGACheckBox@RIInventory]:SetChecked
					else
						UIElement[FilterGACheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterCallsBot]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterCallsBotCheckBox@RIInventory]:SetChecked
					else
						UIElement[FilterCallsBotCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterIllegibleIncomplete]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterIllegibleIncompleteCheckBox@RIInventory]:SetChecked
					else
						UIElement[FilterIllegibleIncompleteCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterAdorns]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterAdornsCheckBox@RIInventory]:SetChecked
					else
						UIElement[FilterAdornsCheckBox@RIInventory]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[DepositToDepot]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
					{
						UIElement[DepositToDepotCheckBox@RIInventory]:SetChecked
						DepositToDepot:Set[1]
					}
					else
					{
						UIElement[DepositToDepotCheckBox@RIInventory]:UnsetChecked
						DepositToDepot:Set[0]
					}
				}
				else
				{
					;echo ${Iterator.Key}  //  ${Iterator.Value.FindSetting[Action].String}
					if ${Iterator.Value.FindSetting[Action].String.Find[Transmute](exists)}
						_Color:Set[FFCC33FF];_Action:Set[Transmute]
					elseif ${Iterator.Value.FindSetting[Action].String.Find[Sell](exists)}
						_Color:Set[FF0099FF];_Action:Set[Sell]
					elseif ${Iterator.Value.FindSetting[Action].String.Find[Salvage](exists)}
						_Color:Set[FF33CC33];_Action:Set[Salvage]
					elseif ${Iterator.Value.FindSetting[Action].String.Find[Destroy](exists)}
						_Color:Set[FFFF0000];_Action:Set[Destroy]
					elseif ${Iterator.Value.FindSetting[Action].String.Find[Extract](exists)}
						_Color:Set[FFFFFF00];_Action:Set[Extract]
					if ${UIElement[RIInventory](exists)} && ${_PopulateListBox}
					{
						if ${Iterator.Key.Find["*All"]}
						{
							UIElement[AddedItemsListbox@RIInventory]:AddItem["${Iterator.Key.ReplaceSubstring["-Transmute",""].ReplaceSubstring["-Extract",""].ReplaceSubstring["-Salvage",""]}",${allscnt},${_Color}]
							allscnt:Inc
						}
						else
							UIElement[AddedItemsListbox@RIInventory]:AddItem["${Iterator.Key}","${Iterator.Key}",${_Color}]
						;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[${_Color}]
					}
					if ${Iterator.Key.Find["*All"]}
					{
						Items:Insert[${Iterator.Key.ReplaceSubstring["-Transmute",""].ReplaceSubstring["-Extract",""].ReplaceSubstring["-Salvage",""]}|${_Action}]
					}
					else
					{
						Items:Insert["${Iterator.Key}"|${_Action}]
					}
				}
			}
			while ${Iterator:Next(exists)}
		}
	}

	method Save()
	{
		if ${UIElement[LoopCheckBox@RIInventory].Checked}
			Loop:Set[TRUE]
		else
			Loop:Set[FALSE]
		;if ${UIElement[AddedItemsListbox@RIInventory].Items}>0
		;{
			Items:Clear
			;echo ISXRI Saving RIInventoryList: RIInventorySave.xml
			variable string SetName
			variable string _Action
			SetName:Set[RIInventory]
			LavishSettings[RIInventorySaveFile]:Clear
			LavishSettings:AddSet[RIInventorySaveFile]
			LavishSettings[RIInventorySaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			;LavishSettings[RIInventorySaveFile]:AddSetting[ISBCharSetTextEntry,${UIElement[ISBCharSetTextEntry@RIInventory].Text}]
			LavishSettings[RIInventorySaveFile]:AddSet[${SetName}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			
			;save bags
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[Bag1]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[Bag1]:AddSetting[Checked,${UIElement[Bag1CheckBox@RIInventory].Checked}]
			UseBag1:Set[${UIElement[Bag1CheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[Bag2]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[Bag2]:AddSetting[Checked,${UIElement[Bag2CheckBox@RIInventory].Checked}]
			UseBag2:Set[${UIElement[Bag2CheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[Bag3]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[Bag3]:AddSetting[Checked,${UIElement[Bag3CheckBox@RIInventory].Checked}]
			UseBag3:Set[${UIElement[Bag3CheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[Bag4]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[Bag4]:AddSetting[Checked,${UIElement[Bag4CheckBox@RIInventory].Checked}]
			UseBag4:Set[${UIElement[Bag4CheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[Bag5]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[Bag5]:AddSetting[Checked,${UIElement[Bag5CheckBox@RIInventory].Checked}]
			UseBag5:Set[${UIElement[Bag5CheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[Bag6]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[Bag6]:AddSetting[Checked,${UIElement[Bag6CheckBox@RIInventory].Checked}]
			UseBag6:Set[${UIElement[Bag6CheckBox@RIInventory].Checked}]
			
			;save filters
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[FilterAdded]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[FilterAdded]:AddSetting[Checked,${UIElement[FilterAddedCheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[FilterInfusers]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[FilterInfusers]:AddSetting[Checked,${UIElement[FilterInfusersCheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[FilterGA]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[FilterGA]:AddSetting[Checked,${UIElement[FilterGACheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[FilterCallsBot]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[FilterCallsBot]:AddSetting[Checked,${UIElement[FilterCallsBotCheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[FilterIllegibleIncomplete]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[FilterIllegibleIncomplete]:AddSetting[Checked,${UIElement[FilterIllegibleIncompleteCheckBox@RIInventory].Checked}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[FilterAdorns]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[FilterAdorns]:AddSetting[Checked,${UIElement[FilterAdornsCheckBox@RIInventory].Checked}]
			
			;save DepositToDepot
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[DepositToDepot]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[DepositToDepot]:AddSetting[Checked,${UIElement[DepositToDepotCheckBox@RIInventory].Checked}]
			
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[AddAgents]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[AddAgents]:AddSetting[Checked,${UIElement[AddAgentsCheckBox@RIInventory].Checked}]
			
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[ConvertAgents]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[ConvertAgents]:AddSetting[Checked,${UIElement[ConvertAgentsCheckBox@RIInventory].Checked}]
			
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[AddFamiliars]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[AddFamiliars]:AddSetting[Checked,${UIElement[AddFamiliarsCheckBox@RIInventory].Checked}]
			
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[DeleteLeft]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[DeleteLeft]:AddSetting[Checked,${UIElement[DeleteLeftCheckBox@RIInventory].Checked}]
			
			for(count:Set[1];${count}<=${UIElement[AddedItemsListbox@RIInventory].Items};count:Inc)
			{
				;determine the colors for what it does
				if ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-3394561
					_Action:Set[Transmute]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-16737793
					_Action:Set[Sell]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-13382605
					_Action:Set[Salvage]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-65536
					_Action:Set[Destroy]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-256
					_Action:Set[Extract]
				if ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text.Find["*All"]}
				{
					LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}-${_Action}"]
					LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}-${_Action}"]:AddSetting[Action,${_Action}]
				}
				else
				{
					LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}"]
					LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}"]:AddSetting[Action,${_Action}]
				}
				Items:Insert[${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}|${_Action}]
			}
			LavishSettings[RIInventorySaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			;echo here
			;This:LoadInventoryList
		;}
	}
}
;atom triggered when incommingtext is detected
atom RIIEQ2_onIncomingText(string Text)
{
	if ${Text.Find["is missing the required classification"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} it cannot be extracted
	}
	if ${Text.Find["cannot be transmuted"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} it cannot be transmuted
	}
	if ${Text.Find["You need at least"]} && ${Text.Find["Transmuting skill to transmute"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} your transmuting skill is too low for this item
	}
	if ${Text.Find["cannot be salvaged"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} it cannot be salvaged/extracted
	}
	if ${Text.Find["You have already added this agent to your collection"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} You have already added this agent to your collection
	}
	if ${Text.Find["You already have this Familiar in your collection"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} You already have this Familiar in your collection
	}
	if ${Text.Find["This spell or ability is no longer available"]}
	{
		RII_Var_Bool_SkipThisItem:Set[1]
		echo ISXRI: Skipping ${RII_Var_String_ItemName} That spell or ability is no longer available
	}
	
}
atom EQ2_onRewardWindowAppeared()
{
	if !${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
		TimedCommand 5 RewardWindow:AcceptReward
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"
	echo ISXRI: Ending RI Inventory
	Event[EQ2_onIncomingText]:DetachAtom[RIIEQ2_onIncomingText]
}