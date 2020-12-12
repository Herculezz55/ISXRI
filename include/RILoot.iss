variable(global) RILootObject RILootObj
variable filepath FP
function main()
{
	;disable Debugging
	Script:DisableDebugging
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[RILoot]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot"]
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if xml exists, if not create
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RILoot.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RILoot.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RILoot.xml" http://www.isxri.com/RILoot.xml
		wait 50
	}
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RILoot.xml"
	RILootObj:LoadRILootOn
	RILootObj:LoadItems
	RILootObj:LoadAddedItems
	RILootObj:Group[1]
	UIElement[LootedTextEntry@RILoot]:SetText[0]

	while 1
	{
		wait 1
	}
}

;RILoot Object
objectdef RILootObject
{
	variable settingsetref RILootSet
	method LoadRILootOn()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[RILootSet]:Clear
			LavishSettings:AddSet[RILootSet]
			LavishSettings[RILootSet]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[RILootSet].GUID}]
			if ${RILootSet.FindSetting[RILootOn]}
				UIElement[RILootOnCheckbox@RILoot]:SetChecked
			else
				UIElement[RILootOnCheckbox@RILoot]:UnsetChecked
		}
	}
	method SaveRILootOn()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[RILootSet]:Clear
			LavishSettings:AddSet[RILootSet]
			LavishSettings[RILootSet]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[RILootSet].GUID}]
			LavishSettings[RILootSet]:AddSetting[RILootOn,${UIElement[RILootOnCheckbox@RILoot].Checked}]
			LavishSettings[RILootSet]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
		}
	}
	
	method LoadToonList()
	{
		LavishSettings[RILoot]:Clear
		LavishSettings:AddSet[RILoot]
		LavishSettings[RILoot]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		variable settingsetref Set2
		Set2:Set[${LavishSettings[RILoot].GUID}]

		variable settingsetref Set3
		
		variable iterator Iterator
		variable iterator Iterator2
		Set2:GetSetIterator[Iterator]
		
		if ${Iterator:First(exists)}
		{
			do
			{
				Set3:Set[${Set2.FindSet[${Iterator.Key}].GUID}]
				Set3:GetSetIterator[Iterator2]

				if ${Iterator2:First(exists)}
				{
					do
					{
						;;echo ${Iterator2.Key} // ${Iterator2.Value}
						UIElement[ToonsListbox@RILoot]:AddItem["${Iterator2.Key}"]
					}
					while ${Iterator2:Next(exists)}
				}
			}
			while ${Iterator:Next(exists)}
		}
	}
	method LoadItems()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[ItemsList]:Clear
			LavishSettings:AddSet[ItemsList]
			LavishSettings[ItemsList]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[ItemsList].GUID}]

			variable settingsetref LoadListSet=${RILootSet.FindSet[ItemsList].GUID}
			LoadListSet:Set[${RILootSet.FindSet[ItemsList].GUID}]
			
			variable iterator SettingIterator
			LoadListSet:GetSettingIterator[SettingIterator]
			if ${SettingIterator:First(exists)}
			{
				do
				{
					;;echo "${SettingIterator.Key}=${SettingIterator.Value}"
					UIElement[ItemsListbox@RILoot]:AddItem["${SettingIterator.Key}"]
				}
				while ${SettingIterator:Next(exists)}
			}
		}
	}
	method LoadAddedItems()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[AddedItemsList]:Clear
			LavishSettings:AddSet[AddedItemsList]
			LavishSettings[AddedItemsList]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[AddedItemsList].GUID}]

			variable settingsetref LoadListSet=${RILootSet.FindSet[AddedItemsList].GUID}
			LoadListSet:Set[${RILootSet.FindSet[AddedItemsList].GUID}]
			
			variable iterator SettingIterator
			LoadListSet:GetSettingIterator[SettingIterator]
			if ${SettingIterator:First(exists)}
			{
				do
				{
					;echo "${SettingIterator.Key}=${SettingIterator.Value}"
					UIElement[AddedItemsListbox@RILoot]:AddItem["${SettingIterator.Key}"]
				}
				while ${SettingIterator:Next(exists)}
			}
		}
	}
	method ItemsListboxLeftClick()
	{
		if ${UIElement[ItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[ItemTextEntry@RILoot]:SetText[${UIElement[ItemsListbox@RILoot].SelectedItem}]
		}
	}
	method ToonsListboxLeftClick()
	{
		if ${UIElement[ToonsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[GroupTextEntry@RILoot]:SetText[${UIElement[ToonsListbox@RILoot].SelectedItem}]
		}
	}
	method AddedItemsListboxLeftClick()
	{
		if ${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[AddButton@RILoot]:SetText[Edit]
			UIElement[ItemTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[1,|]}]
			UIElement[GroupTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[2,|]}]
			UIElement[QuantityTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[3,|]}]
			UIElement[LootedTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[4,|]}]
		}
		else
		{
			This:Clear
		}
	}
	method AddedItemsListboxRightClick()
	{
		if ${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[AddedItemsListbox@RILoot]:RemoveItem[${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID}]
			This:SaveList
			This:Clear
		}
	}
	method Group(int _GroupOnly)
	{
		if ${_GroupOnly}==1
		{
			UIElement[AllToonsCheckBox@RILoot]:UnsetChecked
			UIElement[GroupOnlyCheckBox@RILoot]:SetChecked
			UIElement[ToonsListbox@RILoot]:ClearItems
			variable int i=0
			;UIElement[ToonsListbox@RILoot]:AddItem[${Me.Name}]
			for(i:Set[1];${i}<${Me.Group};i:Inc)
				UIElement[ToonsListbox@RILoot]:AddItem[${Me.Group[${i}].Name}]
		}
		else
		{	
			UIElement[GroupOnlyCheckBox@RILoot]:UnsetChecked
			UIElement[AllToonsCheckBox@RILoot]:SetChecked
			UIElement[ToonsListbox@RILoot]:ClearItems
			This:LoadToonList
		}
	}
	;need to add code that IF the Item does not exist in our ItemsListBox to Add it and save to file. And if the item|toon combo already exists on the right select it and edit it
	method Add()
	{
		if ${UIElement[QuantityTextEntry@RILoot].Text.Equal[NULL]} || ${UIElement[QuantityTextEntry@RILoot].Text.Equal[""]} || ${Int[${UIElement[QuantityTextEntry@RILoot].Text}]}==0
		{
			UIElement[QuantityTextEntry@RILoot]:SetText[~]
		}
		else
		{
			UIElement[QuantityTextEntry@RILoot]:SetText[${Int[${UIElement[QuantityTextEntry@RILoot].Text}]}]
		}
		if ${UIElement[LootedTextEntry@RILoot].Text.Equal[NULL]} || ${UIElement[LootedTextEntry@RILoot].Text.Equal[""]}
		{
			UIElement[LootedTextEntry@RILoot]:SetText[0]
		}
		else
		{
			UIElement[LootedTextEntry@RILoot]:SetText[${Int[${UIElement[LootedTextEntry@RILoot].Text}]}]
		}
		if ${UIElement[ItemTextEntry@RILoot].Text.NotEqual[NULL]} && ${UIElement[ItemTextEntry@RILoot].Text.NotEqual[""]} && ${UIElement[GroupTextEntry@RILoot].Text.NotEqual[NULL]} && ${UIElement[GroupTextEntry@RILoot].Text.NotEqual[""]}
		{
			if ${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID(exists)}
				UIElement[AddedItemsListbox@RILoot].SelectedItem:SetText["${UIElement[ItemTextEntry@RILoot].Text}|${UIElement[GroupTextEntry@RILoot].Text}|${UIElement[QuantityTextEntry@RILoot].Text}|${UIElement[LootedTextEntry@RILoot].Text}"]
			else
				UIElement[AddedItemsListbox@RILoot]:AddItem["${UIElement[ItemTextEntry@RILoot].Text}|${UIElement[GroupTextEntry@RILoot].Text}|${UIElement[QuantityTextEntry@RILoot].Text}|${UIElement[LootedTextEntry@RILoot].Text}"]
			This:Clear
			This:SaveList
		}
	}
	method Clear()
	{
		UIElement[ItemTextEntry@RILoot]:SetText[""]
		UIElement[GroupTextEntry@RILoot]:SetText[""]
		UIElement[QuantityTextEntry@RILoot]:SetText[""]
		UIElement[LootedTextEntry@RILoot]:SetText[0]
		UIElement[ItemsListbox@RILoot]:ClearSelection
		UIElement[ToonsListbox@RILoot]:ClearSelection
		UIElement[AddedItemsListbox@RILoot]:ClearSelection
		UIElement[AddButton@RILoot]:SetText[Add]
		UIElement[AddButton@RILoot]:SetFocus
	}
	method SaveList()
	{
		variable string SetName
		SetName:Set[AddedItemsList]
		LavishSettings[RILoot]:Clear
		LavishSettings:AddSet[RILoot]
		LavishSettings[RILoot]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
		LavishSettings[RILoot]:AddSet[${SetName}]
		LavishSettings[RILoot].FindSet[${SetName}]:Clear
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[AddedItemsListbox@RILoot].Items};count:Inc)
		{
			LavishSettings[RILoot].FindSet[${SetName}]:AddSetting["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${count}].Text}",""]
		}
		LavishSettings[RILoot]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
	}
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RILoot.xml"
}