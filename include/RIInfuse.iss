variable(global) RIInfuseObject RIInfuseObj
variable filepath FP
variable settingsetref RIInfuseSet
variable(global) string RI_Var_String_RIInfuseScriptName=${Script.Filename}
variable index:string Items
variable(global) bool RIInfuseExecuteActions=FALSE
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
variable bool InventoryLoad=FALSE
variable bool CannotInfuseFound=FALSE
function main(... args)
{
	;disable Debugging
	Script:DisableDebugging
	
;	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse"]
;	if !${FP.PathExists}
;	{
;		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
;		FP:MakeSubdirectory[RIInfuse]	
;		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse"]
;	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RIInfuse.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RIInfuse.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse.xml" http://www.isxri.com/RIInfuse.xml
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
	echo ISXRI: Starting RI Infuse
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse.xml"

	UIElement[EquipmentCheckBox@RIInfuse]:SetChecked

	if !${LoadUI}
		UIElement[RIInfuse]:Hide	
	
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	UIElement[RIInfuseConsole@RIInfuse]:Echo["Starting RI Infuse"]
	;load inventory list into listbox
	RIInfuseObj:LoadInventoryList
	
	if ${InventoryLoad}
		call RIInfuseObj.LoadInventoryListSlow
	
	;if ${Start}
	;	RIInfuseObj:Execute
	
	if !${LoadUI}
	{
		UIElement[RIInfuse]:Hide
	}
	;load events
	Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
	
	while 1
	{
		if ${RIInfuseExecuteActions}
			call RIInfuseObj.ExecuteActions
		if ${InventoryLoad}
			call RIInfuseObj.LoadInventoryListSlow
		wait 1
	}
}
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["Cannot Infuse"]}
	{
		CannotInfuseFound:Set[1]
	}
}

atom(global) rii(string _What)
{
	if ${_What.Upper.Equal[END]} || ${_What.Upper.Equal[EXIT]}
		Script:End
	else
		UIElement[RIInfuse]:Show
}
objectdef RIInfuseObject
{
	method Execute()
	{
		RIInfuseExecuteActions:Set[1]
	}
	function ExecuteActions()
	{
		if ${UIElement[InventoryListbox@RIInfuse].SelectedItem.Text.Equal[NULL]} || !${UIElement[InventoryListbox@RIInfuse].SelectedItem(exists)}
		{
			UIElement[RIInfuseConsole@RIInfuse]:Echo["You must have an item selected"]
			RIInfuseExecuteActions:Set[0]
			return
		}
		if ${UIElement[AddedInfusersListbox@RIInfuse].Items}<1
		{
			UIElement[RIInfuseConsole@RIInfuse]:Echo["You must have added some infusers"]
			RIInfuseExecuteActions:Set[0]
			return
		}
		echo ISXRI: Executing Actions
		UIElement[RIInfuseConsole@RIInfuse]:Echo["Executing Actions"]
		;UIElement[ExecuteButton@RIInfuse].Font:SetColor[FFF9F099]
		UIElement[ExecuteButton@RIInfuse]:SetText[Executing]
		
		variable int counter
		for(counter:Set[1];${counter}<=${UIElement[AddedInfusersListbox@RIInfuse].Items};counter:Inc)
		{
			CannotInfuseFound:Set[0]
			;echo "${UIElement[AddedInfusersListbox@RIInfuse].OrderedItem[${counter}].Text}" #${counter}/${UIElement[AddedInfusersListbox@RIInfuse].Items}
			UIElement[RIInfuseConsole@RIInfuse]:Echo["Infusing: ${UIElement[InventoryListbox@RIInfuse].SelectedItem.Text} with ${UIElement[AddedInfusersListbox@RIInfuse].OrderedItem[${counter}].Text}"]
			while !${CannotInfuseFound} && ${Me.Inventory[Query, Location=="Inventory" && Name=="${UIElement[AddedInfusersListbox@RIInfuse].OrderedItem[${counter}].Text}"](exists)}
			{
				while ${Me.InCombat}
					wait 1
				;echo ${counter}: ${Items.Get[${counter}]} // ${Items.Get[${counter}].Token[1,|]} // ${Items.Get[${counter}].Token[2,|]}
				Me.Inventory[Query, Location=="Inventory" && Name=="${UIElement[AddedInfusersListbox@RIInfuse].OrderedItem[${counter}].Text}"]:Use
				wait 5
				if ${UIElement[EquipmentCheckBox@RIInfuse].Checked}
					Me.Equipment[name,"${UIElement[InventoryListbox@RIInfuse].SelectedItem.Text}"]:Transmute
				else
					Me.Inventory[name,"${UIElement[InventoryListbox@RIInfuse].SelectedItem.Text}"]:Transmute
				wait 20
			}
			UIElement[RIInfuseConsole@RIInfuse]:Echo["Done Infusing: ${UIElement[InventoryListbox@RIInfuse].SelectedItem.Text} with ${UIElement[AddedInfusersListbox@RIInfuse].OrderedItem[${counter}].Text}"]
		}
		RIInfuseExecuteActions:Set[0]
		echo ISXRI: Done Executing Actions
		UIElement[RIInfuseConsole@RIInfuse]:Echo["Done Executing Actions"]
		UIElement[ExecuteButton@RIInfuse].Font:SetColor[FFF9F099]
		UIElement[ExecuteButton@RIInfuse]:SetText[Execute]
		RI_CMD_Assist 1
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
		UIElement[InfusersListbox@RIInfuse]:ClearItems
		UIElement[InventoryListbox@RIInfuse]:ClearItems
		
		if ${UIElement[EquipmentCheckBox@RIInfuse].Checked}
		{
			for(_count:Set[1];${_count}<=22;_count:Inc)
			{
				if ${_count}==18
					continue
				if ${Me.Equipment[${_count}](exists)}
					UIElement[InventoryListBox@RIInfuse]:AddItem["${Me.Equipment[${_count}].Name}"]
			}
		}
		if ${InventoryIterator:First(exists)}
		{
			do
			{
				
				Inventory:Insert["${InventoryIterator.Value}"]
				_TempString:Set["${InventoryIterator.Value}"]
				;echo ${_TempString}
				if ${_TempString.Right[7].Equal[Infuser]}
				{
					UIElement[InfusersListbox@RIInfuse]:AddItem["${_TempString}"]
					continue
				}
				if ${UIElement[InventoryCheckBox@RIInfuse].Checked}
				{
					InventoryLoad:Set[1]
				}
			}
			while ${InventoryIterator:Next(exists)}
		}		
	}
	function LoadInventoryListSlow()
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
		UIElement[InfusersListbox@RIInfuse]:ClearItems
		UIElement[InventoryListbox@RIInfuse]:ClearItems
		
		if ${UIElement[EquipmentCheckBox@RIInfuse].Checked}
		{
			for(_count:Set[1];${_count}<=22;_count:Inc)
			{
				if ${_count}==18
					continue
				if ${Me.Equipment[${_count}](exists)}
					UIElement[InventoryListBox@RIInfuse]:AddItem["${Me.Equipment[${_count}].Name}"]
			}
		}
		if ${InventoryIterator:First(exists)}
		{
			do
			{
				Inventory:Insert["${InventoryIterator.Value}"]
				_TempString:Set["${InventoryIterator.Value}"]
				;echo ${_TempString}
				if ${_TempString.Right[7].Equal[Infuser]}
				{
					UIElement[InfusersListbox@RIInfuse]:AddItem["${_TempString}"]
					continue
				}
				if ${UIElement[InventoryCheckBox@RIInfuse].Checked}
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
						if ${InventoryIterator.Value.ToItemInfo.Type.Equal[Ranged Weapon]} || ${InventoryIterator.Value.ToItemInfo.Type.Equal[Weapon]} || ${InventoryIterator.Value.ToItemInfo.Type.Equal[Armor]}
							UIElement[InventoryListbox@RIInfuse]:AddItem["${_TempString}"]
					}
				}
			}
			while ${InventoryIterator:Next(exists)}
		}
		InventoryLoad:Set[0]
	}
	method AddedInfusersListboxRightClick()
	{
		if ${UIElement[AddedInfusersListbox@RIInfuse].SelectedItem.ID(exists)}
		{
			UIElement[AddedInfusersListbox@RIInfuse]:RemoveItem[${UIElement[AddedInfusersListbox@RIInfuse].SelectedItem.ID}]
			;This:Save
		}
	}
	method AddInfuser(string _ItemName)
	{
		if ${_ItemName.NotEqual[NULL]} && ${_ItemName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedInfusersListbox@RIInfuse].Items};i:Inc)
			{
				if ${UIElement[AddedInfusersListbox@RIInfuse].Item[${i}].Text.Equal["${_ItemName}"]}
					UIElement[AddedInfusersListbox@RIInfuse]:RemoveItem[${UIElement[AddedInfusersListbox@RIInfuse].Item[${i}].ID}]
			}
			UIElement[AddedInfusersListbox@RIInfuse]:AddItem["${_ItemName}"]
			;This:Save
		}
	}
	method Equipment()
	{
		UIElement[EquipmentCheckBox@RIInfuse]:SetChecked
		UIElement[InventoryCheckBox@RIInfuse]:UnsetChecked
		This:LoadInventoryList
	}
	method Inventory()
	{
		UIElement[EquipmentCheckBox@RIInfuse]:UnsetChecked
		UIElement[InventoryCheckBox@RIInfuse]:SetChecked
		This:LoadInventoryList
	}
	method Load(bool _PopulateListBox=TRUE)
	{
		Items:Clear
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse/"]
		if ${FP.FileExists[RIInfuseSave.xml]}
		{
			LavishSettings[RIInfuse]:Clear
			LavishSettings:AddSet[RIInfuse]
			LavishSettings[RIInfuse]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse/RIInfuseSave.xml"]
			RIInfuseSet:Set[${LavishSettings[RIInfuse].GUID}]

			variable settingsetref LoadListSet=${RIInfuseSet.FindSet[RIInfuse].GUID}
			LoadListSet:Set[${RIInfuseSet.FindSet[RIInfuse].GUID}]
			
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
						UIElement[${Iterator.Key}CheckBox@RIInfuse]:SetChecked;Use${Iterator.Key}:Set[1]
					else
						UIElement[${Iterator.Key}CheckBox@RIInfuse]:UnsetChecked;Use${Iterator.Key}:Set[0]
				}
				elseif ${Iterator.Key.Equal[FilterAdded]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterAddedCheckBox@RIInfuse]:SetChecked
					else
						UIElement[FilterAddedCheckBox@RIInfuse]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterInfusers]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterInfusersCheckBox@RIInfuse]:SetChecked
					else
						UIElement[FilterInfusersCheckBox@RIInfuse]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterGA]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterGACheckBox@RIInfuse]:SetChecked
					else
						UIElement[FilterGACheckBox@RIInfuse]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterCallsBot]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterCallsBotCheckBox@RIInfuse]:SetChecked
					else
						UIElement[FilterCallsBotCheckBox@RIInfuse]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterIllegibleIncomplete]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterIllegibleIncompleteCheckBox@RIInfuse]:SetChecked
					else
						UIElement[FilterIllegibleIncompleteCheckBox@RIInfuse]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[FilterAdorns]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
						UIElement[FilterAdornsCheckBox@RIInfuse]:SetChecked
					else
						UIElement[FilterAdornsCheckBox@RIInfuse]:UnsetChecked
				}
				elseif ${Iterator.Key.Equal[DepositToDepot]}
				{
					if ${Iterator.Value.FindSetting[Checked].String.Equal[TRUE]}
					{
						UIElement[DepositToDepotCheckBox@RIInfuse]:SetChecked
						DepositToDepot:Set[1]
					}
					else
					{
						UIElement[DepositToDepotCheckBox@RIInfuse]:UnsetChecked
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
					if ${UIElement[RIInfuse](exists)} && ${_PopulateListBox}
					{
						UIElement[AddedItemsListbox@RIInfuse]:AddItem["${Iterator.Key}","${Iterator.Key}",${_Color}]
						;UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${UIElement[AddedItemsListbox@RIInfuse].Items}]:SetTextColor[${_Color}]
					}
					Items:Insert["${Iterator.Key}|${_Action}"]
				}
			}
			while ${Iterator:Next(exists)}
		}
	}

	method Save()
	{
		;if ${UIElement[AddedItemsListbox@RIInfuse].Items}>0
		;{
			Items:Clear
			;echo ISXRI Saving RIInfuseList: RIInfuseSave.xml
			variable string SetName
			variable string _Action
			SetName:Set[RIInfuse]
			LavishSettings[RIInfuseSaveFile]:Clear
			LavishSettings:AddSet[RIInfuseSaveFile]
			LavishSettings[RIInfuseSaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse/RIInfuseSave.xml"]
			;LavishSettings[RIInfuseSaveFile]:AddSetting[ISBCharSetTextEntry,${UIElement[ISBCharSetTextEntry@RIInfuse].Text}]
			LavishSettings[RIInfuseSaveFile]:AddSet[${SetName}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			
			;save bags
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[Bag1]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[Bag1]:AddSetting[Checked,${UIElement[Bag1CheckBox@RIInfuse].Checked}]
			UseBag1:Set[${UIElement[Bag1CheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[Bag2]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[Bag2]:AddSetting[Checked,${UIElement[Bag2CheckBox@RIInfuse].Checked}]
			UseBag2:Set[${UIElement[Bag2CheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[Bag3]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[Bag3]:AddSetting[Checked,${UIElement[Bag3CheckBox@RIInfuse].Checked}]
			UseBag3:Set[${UIElement[Bag3CheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[Bag4]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[Bag4]:AddSetting[Checked,${UIElement[Bag4CheckBox@RIInfuse].Checked}]
			UseBag4:Set[${UIElement[Bag4CheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[Bag5]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[Bag5]:AddSetting[Checked,${UIElement[Bag5CheckBox@RIInfuse].Checked}]
			UseBag5:Set[${UIElement[Bag5CheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[Bag6]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[Bag6]:AddSetting[Checked,${UIElement[Bag6CheckBox@RIInfuse].Checked}]
			UseBag6:Set[${UIElement[Bag6CheckBox@RIInfuse].Checked}]
			
			;save filters
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[FilterAdded]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[FilterAdded]:AddSetting[Checked,${UIElement[FilterAddedCheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[FilterInfusers]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[FilterInfusers]:AddSetting[Checked,${UIElement[FilterInfusersCheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[FilterGA]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[FilterGA]:AddSetting[Checked,${UIElement[FilterGACheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[FilterCallsBot]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[FilterCallsBot]:AddSetting[Checked,${UIElement[FilterCallsBotCheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[FilterIllegibleIncomplete]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[FilterIllegibleIncomplete]:AddSetting[Checked,${UIElement[FilterIllegibleIncompleteCheckBox@RIInfuse].Checked}]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[FilterAdorns]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[FilterAdorns]:AddSetting[Checked,${UIElement[FilterAdornsCheckBox@RIInfuse].Checked}]
			
			;save DepositToDepot
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet[DepositToDepot]
			LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet[DepositToDepot]:AddSetting[Checked,${UIElement[DepositToDepotCheckBox@RIInfuse].Checked}]
			
			for(count:Set[1];${count}<=${UIElement[AddedItemsListbox@RIInfuse].Items};count:Inc)
			{
				;determine the colors for what it does
				if ${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].TextColor}==-3394561
					_Action:Set[Transmute]
				elseif ${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].TextColor}==-16737793
					_Action:Set[Sell]
				elseif ${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].TextColor}==-13382605
					_Action:Set[Salvage]
				elseif ${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].TextColor}==-65536
					_Action:Set[Destroy]
				LavishSettings[RIInfuseSaveFile].FindSet[${SetName}]:AddSet["${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].Text}"]
				LavishSettings[RIInfuseSaveFile].FindSet[${SetName}].FindSet["${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].Text}"]:AddSetting[Action,${_Action}]
				Items:Insert["${UIElement[AddedItemsListbox@RIInfuse].OrderedItem[${count}].Text}"|${_Action}]
			}
			LavishSettings[RIInfuseSaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse/RIInfuseSave.xml"]
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
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIInfuse.xml"
	echo ISXRI: Ending RI Infuse
}