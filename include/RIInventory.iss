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
variable index:string Inventory

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
	
	while ${ArgCount} <= ${args.Used}
	{
		switch ${args[${ArgCount}]}
		{
			case -noui
				LoadUI:Set[FALSE]
				break
			case -loop
			{
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
	echo ISXRI: Starting RI Inventory
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"

	if !${LoadUI}
		UIElement[RIInventory]:Hide
	
	;set button colors
	UIElement[AddSellButton@RIInventory].Font:SetColor[FF0099FF]
	UIElement[AddDestroyButton@RIInventory].Font:SetColor[FFFF0000]
	UIElement[AddSalvageButton@RIInventory].Font:SetColor[FF33CC33]
	UIElement[AddTransmuteButton@RIInventory].Font:SetColor[FFCC33FF]

	;load saved items list
	RIInventoryObj:Load
	
	;load inventory list into listbox
	RIInventoryObj:LoadInventoryList
	
	if ${Start}
		RIInventoryObj:Execute
	
	if !${LoadUI}
	{
		UIElement[RIInventory]:Hide
	}
	;load events
	Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
	
	while 1
	{
		if ${RIInventoryExecuteActions}
			call RIInventoryObj.ExecuteActions
		wait 1
	}
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
	method Execute()
	{
		;build our Query
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
	function ExecuteActions()
	{
		echo ISXRI: Executing Actions
		;UIElement[ExecuteButton@RIInventory].Font:SetColor[FFF9F099]
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
		}
		RI_CMD_Assist 0
		variable int counter
		variable bool _SkipThisItem=0
		for(counter:Set[1];${counter}<=${Items.Used};counter:Inc)
		{
			while ${Me.InCombat}
				wait 1
			;echo ${counter}: ${Items.Get[${counter}]} // ${Items.Get[${counter}].Token[1,|]} // ${Items.Get[${counter}].Token[2,|]}
			_SkipThisItem:Set[0]
			if ${Items.Get[${counter}].Token[2,|].Equal[Transmute]} || ${Items.Get[${counter}].Token[2,|].Equal[Sell]} || ${Items.Get[${counter}].Token[2,|].Equal[Destroy]} || ${Items.Get[${counter}].Token[2,|].Equal[Salvage]}
			{
				;while loop while the item exists after building the inventory query
				while ${Me.Inventory[Query,Location=="Inventory"&&Name=="${Items.Get[${counter}].Token[1,|]}"&&${BagQuery}](exists)} && !${_SkipThisItem}
				{
					while ${Me.InCombat}
						wait 1
					if ${Items.Get[${counter}].Token[2,|].Equal[Sell]} && ( ${Actor[guild,Guild Commodities Exporter].Distance}>12 || !${Actor[guild,Guild Commodities Exporter](exists)} )
						echo ISXRI: Skipping ${Items.Get[${counter}].Token[1,|]} we are not near a vendor;_SkipThisItem:Set[1]
					if ${Items.Get[${counter}].Token[2,|].Equal[Salvage]} && !${Me.Ability[id,2266640201](exists)}
						echo ISXRI: Skipping ${Items.Get[${counter}].Token[1,|]} we do not have salvage ability;_SkipThisItem:Set[1]
					if ${Items.Get[${counter}].Token[2,|].Equal[Transmute]} && !${Me.Ability[id,2266640201](exists)}
						echo ISXRI: Skipping ${Items.Get[${counter}].Token[1,|]} we do not have transmute ability;_SkipThisItem:Set[1]
					call This.${Items.Get[${counter}].Token[2,|]} ${Me.Inventory[Query,Location=="Inventory"&&Name=="${Items.Get[${counter}].Token[1,|]}"&&${BagQuery}].ID}
				}
			}
		}
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
			if ${Actor[Query, Name=="Lore & Legend Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Lore & Legend Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=="Scroll Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Scroll Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=="Harvesting Supply Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Harvesting Supply Depot"].ID} 0
				wait 5
			}
			if ${Actor[Query, Name=="Collectible Depot" && Distance<12](exists)}
			{
				eq2ex container deposit_all ${Actor["Collectible Depot"].ID} 0
				wait 5
			}
		}
		if ${Start} && !${Loop}
			Script:End
	}
	function Transmute(int _ItemID)
	{
		;echo Transmute : : : ${_ItemID}
		;return
		echo ISXRI: Transmuting "${Me.Inventory[id,${_ItemID}]}"
		eq2ex usea Transmute
		wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
		Me.Inventory[id,${_ItemID}]:Transmute
		wait 10 ${Me.CastingSpell}
		wait 10 !${Me.CastingSpell}
		wait 5
		wait 10
	}
	function Salvage(int _ItemID)
	{
		;echo Salvage : : : ${_ItemID}
		;return
		echo ISXRI: Salvaging "${Me.Inventory[id,${_ItemID}]}"
		eq2ex usea Salvage
		wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
		Me.Inventory[id,${_ItemID}]:Salvage
		wait 10 ${Me.CastingSpell}
		wait 10 !${Me.CastingSpell}
		wait 5
		wait 10
	}
	function Destroy(int _ItemID)
	{
		;echo Destroy : : : ${_ItemID}
		;return
		echo ISXRI: Destroying "${Me.Inventory[id,${_ItemID}]}"
		Me.Inventory[id,${_ItemID}]:Destroy
		wait 10
	}
	function Sell(int _ItemID)
	{
		if ${Actor[guild,Guild Commodities Exporter].Distance}<12 && ${Me.Inventory[id,${_ItemID}](exists)}
		{
			if ${Target.ID}!=${Actor[guild,Guild Commodities Exporter].ID}
				Actor[guild,Guild Commodities Exporter]:DoTarget
			if !${EQ2UIPage[Inventory,Merchant].IsVisible}
				Actor[guild,Guild Commodities Exporter]:DoubleClick
			wait 2
			echo ISXRI: Selling "${Me.Inventory[id,${_ItemID}]}"
			;return
			Me.Merchandise["${Me.Inventory[id,${_ItemID}]}"]:Sell[${Me.Inventory[Query,Location=="Inventory"&&Name=="${Me.Inventory[id,${_ItemID}]}"&&${BagQuery}].Quantity}]
		}
		wait 8
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
					UIElement[InventoryListbox@RIInventory]:AddItem["${_TempString}"]
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
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FFcc33ff]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FFcc33ff]
			UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method AddSalvage(string _ItemName)
	{
		;echo ${_ItemName}
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedItemsListbox@RIInventory].Items};i:Inc)
			{
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal["${_ItemName}"]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem["${_ItemName}","${_ItemName}",FF33CC33]
			;change color
			;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FF33CC33]
			UIElement[InventoryListbox@RIInventory]:RemoveItem[${UIElement[InventoryListbox@RIInventory].SelectedItem.ID}]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
			This:Save
		}
	}
	method AddSell(string _ItemName)
	{
		;echo ${_ItemName}
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]}
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
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]}
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
	method Load(bool _PopulateListBox=TRUE)
	{
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
					if ${UIElement[RIInventory](exists)} && ${_PopulateListBox}
					{
						UIElement[AddedItemsListbox@RIInventory]:AddItem["${Iterator.Key}","${Iterator.Key}",${_Color}]
						;UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[${_Color}]
					}
					Items:Insert["${Iterator.Key}|${_Action}"]
				}
			}
			while ${Iterator:Next(exists)}
		}
	}

	method Save()
	{
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
				LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}"]
				LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}"]:AddSetting[Action,${_Action}]
				Items:Insert["${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}"|${_Action}]
			}
			LavishSettings[RIInventorySaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			;echo here
			;This:LoadInventoryList
		;}
	}
}
atom EQ2_onRewardWindowAppeared()
{
	RewardWindow:Receive
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"
	echo ISXRI: Ending RI Inventory
}