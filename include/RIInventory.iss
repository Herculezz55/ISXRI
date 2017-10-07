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
	
	;set button colors
	UIElement[AddSellButton@RIInventory].Font:SetColor[FF0099FF]
	UIElement[AddDestroyButton@RIInventory].Font:SetColor[FFFF0000]
	UIElement[AddSalvageButton@RIInventory].Font:SetColor[FF33CC33]
	UIElement[AddTransmuteButton@RIInventory].Font:SetColor[FFCC33FF]

	;load inventory list into listbox
	RIInventoryObj:LoadInventoryList
	
	;load saved items list
	RIInventoryObj:Load

	while 1
	{
		
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

	method AddedItemsListboxRightClick()
	{
		if ${UIElement[AddedItemsListbox@RIInventory].SelectedItem.ID(exists)}
		{
			UIElement[AddedItemsListbox@RIInventory]:RemoveItem[${UIElement[AddedItemsListbox@RIInventory].SelectedItem.ID}]
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
	method Load()
	{
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
			
			variable string Color
			if !${Iterator:First(exists)}
				return

			do
			{
				;echo ${Iterator.Key}  //  ${Iterator.Value.FindSetting[Action].String}
				if ${Iterator.Value.FindSetting[Action].String.Find[Transmute](exists)}
					Color:Set[FFCC33FF]
				elseif ${Iterator.Value.FindSetting[Action].String.Find[Sell](exists)}
					Color:Set[FF0099FF]
				elseif ${Iterator.Value.FindSetting[Action].String.Find[Salvage](exists)}
					Color:Set[FF33CC33]
				elseif ${Iterator.Value.FindSetting[Action].String.Find[Destroy](exists)}
					Color:Set[FFFF0000]
				UIElement[AddedItemsListbox@RIInventory]:AddItem[${Iterator.Key}]
				UIElement[AddedItemsListbox@RIInventory].OrderedItem[${UIElement[AddedItemsListbox@RIInventory].Items}]:SetTextColor[${Color}]
			}
			while ${Iterator:Next(exists)}
			
		}
	}

	method Save()
	{
		;if ${UIElement[AddedItemsListbox@RIInventory].Items}>0
		;{
			echo ISXRI Saving RIInventoryList: RIInventorySave.xml
			variable string SetName
			variable string Action
			SetName:Set[RIInventory]
			LavishSettings[RIInventorySaveFile]:Clear
			LavishSettings:AddSet[RIInventorySaveFile]
			LavishSettings[RIInventorySaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			;LavishSettings[RIInventorySaveFile]:AddSetting[ISBCharSetTextEntry,${UIElement[ISBCharSetTextEntry@RIInventory].Text}]
			LavishSettings[RIInventorySaveFile]:AddSet[${SetName}]
			LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			
			for(count:Set[1];${count}<=${UIElement[AddedItemsListbox@RIInventory].Items};count:Inc)
			{
				;determine the colors for what it does
				if ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-3394561
					Action:Set[Transmute]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-16737793
					Action:Set[Sell]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-13382605
					Action:Set[Salvage]
				elseif ${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].TextColor}==-65536
					Action:Set[Destroy]
				LavishSettings[RIInventorySaveFile].FindSet[${SetName}]:AddSet[${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}]
				LavishSettings[RIInventorySaveFile].FindSet[${SetName}].FindSet[${UIElement[AddedItemsListbox@RIInventory].OrderedItem[${count}].Text}]:AddSetting[Action,${Action}]
			}
			LavishSettings[RIInventorySaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIInventory/RIInventorySave.xml"]
			;echo here
		;}
	}
}

function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml"
}