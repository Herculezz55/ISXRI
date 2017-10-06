;;;; Thinking i want to implement a group alias option so it can be ran ri_Inventory aliasname  or ri_Inventory toon1|toon2|toon3   and we will just doa  .Find[|]
variable(global) RIInventoryObject RIInventoryObj
variable filepath FP
variable settingsetref RIInventorySet
variable CountSetsObject2 CountSets
variable CountSetsObject CountSets2
variable(global) string RI_Var_String_RIInventoryScriptName=${Script.Filename}
variable string TempGroup
variable bool WaitForSessions=FALSE
variable int TimeOutCNT=0
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
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"
	
	UIElement[AddSellButton@RIInventory].Font:SetColor[FF0099ff]
	UIElement[AddDestroyButton@RIInventory].Font:SetColor[FFFF0000]
	UIElement[AddSalvageButton@RIInventory].Font:SetColor[FF33CC33]
	UIElement[AddTransmuteButton@RIInventory].Font:SetColor[FFcc33ff]

	;trash items: UIElement[InventoryListbox@RIInventory].OrderedItem[#]:SetTextColor[FFC0C0C0]
	;spells: UIElement[InventoryListbox@RIInventory].OrderedItem[#]:SetTextColor[FF8C5B00]
	;gear: UIElement[InventoryListbox@RIInventory].OrderedItem[#]:SetTextColor[FFFF0000]
	;collection: UIElement[InventoryListbox@RIInventory].OrderedItem[#]:SetTextColor[FFE8E200]

	
	RIInventoryObj:LoadInventoryList
	;RIInventoryObj:LoadSaves
		
	while 1
		wait 1
	UIElement[AccountsAvailListbox@RIInventory]:SelectItem[1]
	RIInventoryObj:AccountsAvailListboxLeftClick
	;RIInventoryObj:LoadCharSet
	; if ${UIElement[SaveListbox@RIInventory].OrderedItem[1](exists)}
	; {
		; UIElement[SaveListbox@RIInventory]:SelectItem[1]
		; UIElement[SaveTextEntry@RIInventory]:SetText[${UIElement[SaveListbox@RIInventory].SelectedItem.Text}]
		; RIInventoryObj:LoadList
	; }
	RIInventoryObj:LoadCharSet
	RIInventoryObj:LoadList
	while 1
	{
		if ${WaitForSessions}
		{
			TimeOutCNT:Set[0]
			while ${Sessions}<${Math.Calc[${TempGroup.Count[|]}+1]} && ${TimeOutCNT:Inc}<=300
				wait 10
			if ${Sessions}>=${Math.Calc[${TempGroup.Count[|]}+1]}
				RIInventoryObj:LaunchGroup[${TempGroup}]
			else
				ISXRI: RIInventory: Timed out waiting for ${Math.Calc[${TempGroup.Count[|]}+1]} sessions
			WaitForSessions:Set[0]
			TempGroup:Set[""]
			Script:End
		}
		wait 1
	}
}
function Transmute(int _ItemID)
{
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
	Me.Inventory[id,${_ItemID}]:Destroy
	wait 10
}


function LoadAccountList()
{
	;variable CountSetsObject CountSets2
	variable int numSets
	LavishSettings[RIInventory]:Clear
	LavishSettings:AddSet[RIInventory]
	LavishSettings[RIInventory]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
	variable settingsetref Set2
	Set2:Set[${LavishSettings[RIInventory].GUID}]
	;echo Set: ${CountSets2.Count[${Set2}]}==0
	numSets:Set[${CountSets2.Count[${Set2}]}]
	declare strSets[${numSets}] string script
	if ${CountSets2.Count[${Set2}]}==0
	{
		MessageBox -skin eq2 "We were unable to read your RICharList.xml file"
		Script:End
	}
	if ${strSets[1].Equal[AccountLogin]}
	{
		MessageBox -skin eq2 "You must edit your RICharList.xml file and add your accounts and toons"
		Script:End
	}
	CountSets2:PopulateAccounts[${Set2}]
}
function DumpSubsets(settingsetref Set)
{
	variable iterator Iterator
	Set:GetSetIterator[Iterator]
	countds:Inc
	echo strSets[${countds}]:Set[${Set.Name}]
	strSets[${countds}]:Set[${Set.Name}]

	if !${Iterator:First(exists)}
		return
	do
	{
		call DumpSubsets ${Iterator.Value.GUID}
	}
	while ${Iterator:Next(exists)}
}

function echoSets()
{
	variable int ecCount=0
	for(ecCount:Set[1];${ecCount}<=${strSets.Size};ecCount:Inc)
	{
		echo ${strSets[${ecCount}]}
	}
}
;object CountSetsObject
objectdef CountSetsObject
{
	;countsettings in set
	member:int Count(settingsetref Set)
	{
		variable iterator Iterator
		Set:GetSetIterator[Iterator]
		variable int csoCount
		if !${Iterator:First(exists)}
			return

		do
		{
			csoCount:Inc
			strSets[${csoCount}]:Set[${Iterator.Key}]
			;if ${RI_Var_Bool_RILoginDebug}
			;{
				;echo strSets[${csoCount}]:Set[${Iterator.Key}]
			;}
		}
		while ${Iterator:Next(exists)}
		return ${csoCount}
	}
	method LoadToonList(string _Account)
	{
		;variable int numSets
		LavishSettings[RIInventory]:Clear
		LavishSettings:AddSet[RIInventory]
		LavishSettings[RIInventory]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		variable settingsetref Set2
		Set2:Set[${LavishSettings[RIInventory].GUID}]
		;echo Set: ${This.Count[${Set2}]}==0
		;numSets:Set[${This.Count[${Set2}]}]
		;declare strSets[${numSets}] string script
		if ${This.Count[${Set2}]}==0
		{
			MessageBox -skin eq2 "We were unable to read your RICharList.xml file"
			Script:End
		}
		if ${strSets[1].Equal[AccountLogin]}
		{
			MessageBox -skin eq2 "You must edit your RICharList.xml file and add your accounts and toons"
			Script:End
		}
		This:PopulateToons[${Set2},${_Account}]
	}
	method PopulateToons(settingsetref Set4, string _Account)
	{
		;echo Serching for ${ToonName}
		variable int ecCount=0
		for(ecCount:Set[1];${ecCount}<=${strSets.Size};ecCount:Inc)
		{
			if ${strSets[${ecCount}].Equal[${_Account}]} || ${_Account.Equal[*ALL*]}
			{
				;echo ${strSets[${ecCount}]}
				variable settingsetref Set3
				;echo Set3:Set[${Set4.FindSet[${strSets[${ecCount}]}].GUID}]
				Set3:Set[${Set4.FindSet[${strSets[${ecCount}]}].GUID}]
				;echo ${Set3}
				variable iterator Iterator
				Set3:GetSetIterator[Iterator]
				if !${Iterator:First(exists)}
					continue

				do
				{
					UIElement[ToonsAvailListbox@RIInventory]:AddItem[${Iterator.Key}]
				}
				while ${Iterator:Next(exists)}
			}
		}
	}
	method PopulateAccounts(settingsetref Set4)
	{
		;echo Serching for ${ToonName}
		UIElement[AccountsAvailListbox@RIInventory]:AddItem[*ALL*]
		variable int ecCount=0
		for(ecCount:Set[1];${ecCount}<=${strSets.Size};ecCount:Inc)
		{
			UIElement[AccountsAvailListbox@RIInventory]:AddItem[${strSets[${ecCount}]}]
		}
	}
}
objectdef RIInventoryObject
{
	method LoadInventoryList()
	{
		variable index:item InventoryIndex
		Me:QueryInventory[InventoryIndex, Location == "Inventory" && IsContainer=FALSE && IsFoodOrDrink=FALSE]
		
		;echo ${InventoryIndex.Used}
		variable iterator InventoryIterator
		InventoryIndex:GetIterator[InventoryIterator]

		if ${InventoryIterator:First(exists)}
		{
			do
			{
				UIElement[InventoryListbox@RIInventory]:AddItem[${InventoryIterator.Value}]
			}
			while ${InventoryIterator:Next(exists)}
		}		
	}
	
	method AddedGroupsListboxDoubleLeftClick()
	{
		if ${UIElement[AddedGroupsListbox@RIInventory].SelectedItem(exists)}
		{
			This:LaunchGroup[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text}]
		}
	}
	method AddedGroupsListboxLeftClick()
	{
		if ${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.ID(exists)}
		{
			UIElement[AddedToonsListbox@RIInventory]:ClearItems
			UIElement[ToonsAvailListbox@RIInventory]:ClearSelection
			variable int i=0
			for(i:Set[1];${i}<=${Math.Calc[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Count[|]}+1]};i:Inc)
			{
				if ${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Token[${i},|].Find[:](exists)}
				{
					UIElement[GroupAliasTextEntry@RIInventory]:SetText[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Token[${i},|].Left[${Math.Calc[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Token[${i},|].Find[:]}-1]}]}]
					UIElement[AddedToonsListbox@RIInventory]:AddItem[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Token[${i},|].Right[${Math.Calc[-1*${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Token[${i},|].Find[:]}]}]}]
				}
				else
				{
					UIElement[AddedToonsListbox@RIInventory]:AddItem[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.Text.Token[${i},|]}]
				}
			}
		}
		else
		{
			UIElement[AddedToonsListbox@RIInventory]:ClearItems
			UIElement[ToonsAvailListbox@RIInventory]:ClearSelection
			UIElement[GroupAliasTextEntry@RIInventory]:SetText[""]
		}
	}
	method AddedGroupsListboxRightClick()
	{
		if ${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.ID(exists)}
		{
			UIElement[AddedGroupsListbox@RIInventory]:RemoveItem[${UIElement[AddedGroupsListbox@RIInventory].SelectedItem.ID}]
			This:SaveList
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
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal[${_ItemName}]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem[${_ItemName}]
			;change color
			UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FFcc33ff]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
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
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal[${_ItemName}]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem[${_ItemName}]
			;change color
			UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FF33CC33]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
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
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal[${_ItemName}]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem[${_ItemName}]
			;change color
			UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FF0099ff]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
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
				if ${UIElement[AddedItemsListbox@RIInventory].Item[${i}].Text.Equal[${_ItemName}]}
					UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].Item[${i}].ID}]
			}
			UIElement[AddedItemsListbox@RIInventory]:AddItem[${_ItemName}]
			;change color
			UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[FFFF0000]
			UIElement[InventoryListbox@RIInventory]:ClearSelection
		}
	}
	method LoadList()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/"]
		if ${FP.FileExists[RIInventorySave.xml]}
		{
			LavishSettings[RIInventory]:Clear
			LavishSettings:AddSet[RIInventory]
			LavishSettings[RIInventory]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			RIInventorySet:Set[${LavishSettings[RIInventory].GUID}]

			;CountSets:IterateSets[${RIInventorySet}]
			;CountSets:EchoSets
			;CountSets:PopulateSets
			;import AnnounceSet
			variable settingsetref LoadListSet=${RIInventorySet.FindSet[RIInventory].GUID}
			LoadListSet:Set[${RIInventorySet.FindSet[RIInventory].GUID}]
			variable int LoadListCount=${CountSets.Count[${LoadListSet}]}
			LoadListCount:Set[${CountSets.Count[${LoadListSet}]}]

			if ${LoadListCount}>0
			{
				CountSets:IterateSettings[${LoadListSet},${LoadListCount}]
			}
		}
	}
	method SaveList()
	{
		;if ${UIElement[AddedGroupsListbox@RIInventory].Items}>0
		;{
			;echo ISXRI Saving RIInventoryList: RIInventorySave.xml
			variable string SetName
			SetName:Set[RIInventory]
			LavishSettings[RIInventorySaveFile]:Clear
			LavishSettings:AddSet[RIInventorySaveFile]
			LavishSettings[RIInventorySaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			;LavishSettings[RIInventorySaveFile]:AddSetting[ISBCharSetTextEntry,${UIElement[ISBCharSetTextEntry@RIInventory].Text}]
			LavishSettings[RIInventorySaveFile]:AddSet[${SetName}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			
			for(count:Set[1];${count}<=${UIElement[AddedGroupsListbox@RIInventory].Items};count:Inc)
			{
				LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[${count}]
				LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[${count}]:AddSetting[Group,${UIElement[AddedGroupsListbox@RIInventory].OrderedItem[${count}].Text}]
			}
			LavishSettings[RIInventorySaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			if !${_Delete}
				UIElement[SaveListbox@RIInventory]:AddItem[${UIElement[SaveTextEntry@RIInventory].Text}]
			UIElement[SaveTextEntry@RIInventory]:SetText[""]
			;echo here
		;}
	}
	method DeleteList()
	{
		if ${UIElement[SaveListbox@RIInventory].SelectedItem(exists)}
		{
			UIElement[AddedGroupsListbox@RIInventory]:ClearItems
			This:SaveList[TRUE]
			UIElement[SaveListbox@RIInventory]:RemoveItem[${UIElement[SaveListbox@RIInventory].SelectedItem.ID}]
			UIElement[SaveTextEntry@RIInventory]:SetText[""]
		}
	}
}
;object CountSetsObject
objectdef CountSetsObject2
{
	;countsets in set
	member:int Count(settingsetref csoSet)
	{
		variable iterator Iterator
		csoSet:GetSetIterator[Iterator]
		variable int csoCount=0
		;echo ${Set.Name}

		if !${Iterator:First(exists)}
			return

		do
		{
			csoCount:Inc
			;waitframe
			;echo ${Iterator.Key}
		}
		while ${Iterator:Next(exists)}
		 
		return ${csoCount}
	}
	method IterateSettings(settingsetref Set, int Count)
	{
		variable string temp
		variable settingsetref Set4
		variable int icCount=0
		for(icCount:Set[1];${icCount}<=${Count};icCount:Inc)
		{
			;echo checking ${icCount}
			Set4:Set[${Set.FindSet[${icCount}].GUID}]
			variable iterator SettingIterator
			Set4:GetSettingIterator[SettingIterator]
			variable int MinHP=0
			variable string ActorName
			if ${SettingIterator:First(exists)}
			{
				do
				{
				;echo "${SettingIterator.Key}=${SettingIterator.Value}"
				;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
					UIElement[AddedGroupsListbox@RIInventory]:AddItem[${SettingIterator.Value}]
				}
				while ${SettingIterator:Next(exists)}
			}
		}
	}
	method IterateSets(settingsetref ipSet)
	{
		variable iterator Iterator
		ipSet:GetSetIterator[Iterator]
		if !${Iterator:First(exists)}
			return
		do
		{	
			UIElement[SaveListbox@RIInventory]:AddItem[${Iterator.Key}]
			;echo ${Iterator.Key}
		}
		while ${Iterator:Next(exists)}
	}
	method PopulateToons(settingsetref Set4)
	{
		;echo Serching for ${ToonName}
		variable int ecCount=0
		for(ecCount:Set[1];${ecCount}<=${strSets.Size};ecCount:Inc)
		{
			;echo ${strSets[${ecCount}]}
			variable settingsetref Set3
			;echo Set3:Set[${Set4.FindSet[${strSets[${ecCount}]}].GUID}]
			Set3:Set[${Set4.FindSet[${strSets[${ecCount}]}].GUID}]
			;echo ${Set3}
			variable iterator Iterator
			Set3:GetSetIterator[Iterator]
			if !${Iterator:First(exists)}
				continue

			do
			{
				UIElement[ToonsAvailListbox@RIInventory]:AddItem[${Iterator.Key}]
			}
			while ${Iterator:Next(exists)}
		}
	}
}

function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"
}