variable(global) RICharListObject RICharListObj
variable filepath FP
variable(global) string RI_Var_String_RICharListScriptName=${Script.Filename}

function main(string _Group=~NONE~)
{
	;disable Debugging
	Script:DisableDebugging
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[Private]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private"]
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if xml exists, if not create
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RICharListUI.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RICharListUI.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RICharListUI.xml" http://www.isxri.com/RICharListUI.xml
		wait 50
	}
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RICharListUI.xml"

	RICharListObj:LoadAccountList
	UIElement[AccountsListbox@RICharList]:SelectItem[1]
	RICharListObj:AccountsListboxLeftClick

	while 1
	{
		wait 1
	}
}
objectdef RICharListObject
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
	method LoadAccountList()
	{
		variable int numSets
		LavishSettings[RICharList]:Clear
		LavishSettings:AddSet[RICharList]
		LavishSettings[RICharList]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		variable settingsetref Set2
		Set2:Set[${LavishSettings[RICharList].GUID}]
		;echo Set: ${This.Count[${Set2}]}==0
		numSets:Set[${This.Count[${Set2}]}]
		if ${strSets(exists)}
			deletevariable strSets
		declare strSets[${numSets}] string script
		numSets:Set[${This.Count[${Set2}]}]
		;if ${This.Count[${Set2}]}==0
		;{
		;	MessageBox -skin eq2 "We were unable to read your RICharList.xml file"
		;	Script:End
		;}
		;this is not needed eventually we will delete these temp placeholders but for now just ignore
		; if ${strSets[1].Equal[AccountLogin]}
		; {
			; MessageBox -skin eq2 "You must edit your RICharList.xml file and add your accounts and toons"
			; Script:End
		; }
		This:PopulateAccounts[${Set2}]
	}
	method PopulateAccounts(settingsetref Set4)
	{
		;echo Serching for ${ToonName}
		
		variable int ecCount=0
		variable string _tempVal=""
		
		for(ecCount:Set[1];${ecCount}<=${strSets.Size};ecCount:Inc)
		{
			_tempVal:Set[""]
			;echo ${strSets[${ecCount}]}
			variable settingsetref Set3
			variable settingsetref Set5
			;echo Set3:Set[${Set4.FindSet[${strSets[${ecCount}]}].GUID}]
			Set3:Set[${Set4.FindSet[${strSets[${ecCount}]}].GUID}]
			;echo ${Set3.FindSetting[Password]}
			_tempVal:Concat[${Set3.FindSetting[Password]}|]
			;echo UIElement[PasswordTextEntry@RICharList]:SetText[${Set3.FindSetting[Password]}]
			variable iterator Iterator
			variable iterator Iterator2
			Set3:GetSetIterator[Iterator]
			if !${Iterator:First(exists)}
				continue

			do
			{
				Set5:Set[${Set3.FindSet[${Iterator.Key}].GUID}]
				;echo ${Set5.FindSetting[Server]}
				if ${Iterator:Next(exists)}
				{
					Iterator:Previous
					_tempVal:Concat[${Iterator.Key}|${Set5.FindSetting[Server]}|]
				}
				else
				{
					Iterator:Last
					_tempVal:Concat[${Iterator.Key}|${Set5.FindSetting[Server]}]
				}
			}
			while ${Iterator:Next(exists)}
			;echo ${_tempVal}
			UIElement[AccountsListbox@RICharList]:AddItem[${strSets[${ecCount}]},${_tempVal}]
		}
	}
	method AddToon(string _AccountName, string _Password, string _ToonName, string _Server)
	{
		;echo string _AccountName=${_AccountName}, string _Password=${_Password}, string _ToonName=${_ToonName}, string _Server=${_Server}
		
		;first need to check if the account exists (if there is no selection or if the selection and account do not match)
		_ToonName:Set[${_ToonName.Left[1].Upper}${_ToonName.Right[-1]}]
		if ${_AccountName.NotEqual[NULL]} && ${_AccountName.NotEqual[""]} && ${_Password.NotEqual[NULL]} && ${_Password.NotEqual[""]} && ${_ToonName.NotEqual[NULL]} && ${_ToonName.NotEqual[""]} && ${_Server.NotEqual[NULL]} && ${_Server.NotEqual[""]}
		{
			variable int i=0
			variable bool _foundAccount=0
			variable string _tempVal=""
			for(i:Set[1];${i}<=${UIElement[AccountsListbox@RICharList].Items};i:Inc)
			{
				if ${UIElement[AccountsListbox@RICharList].Item[${i}].Text.Equal[${_AccountName}]}
				{
					UIElement[AccountsListbox@RICharList]:SelectItem[${UIElement[AccountsListbox@RICharList].Item[${i}].ID}]
					This:AccountsListboxLeftClick
					UIElement[AccountsListbox@RICharList].FindUsableChild[Vertical,Scrollbar]:SetValue[${Math.Calc[${UIElement[AccountsListbox@RICharList].Items}-${i}]}]
					_foundAccount:Set[1]
				}
			}
			if !${_foundAccount}
			{
				UIElement[ToonsListbox@RICharList]:ClearItems
				UIElement[AccountsListbox@RICharList]:AddItem[${_AccountName},${_Password}]
				UIElement[AccountsListbox@RICharList].FindUsableChild[Vertical,Scrollbar]:SetValue[0]
				UIElement[AccountsListbox@RICharList]:SelectItem[${UIElement[AccountsListbox@RICharList].Item[${UIElement[AccountsListbox@RICharList].Items}].ID}]
			}
			for(i:Set[1];${i}<=${UIElement[ToonsListbox@RICharList].Items};i:Inc)
			{
				if ${UIElement[ToonsListbox@RICharList].Item[${i}].Text.Equal[${_ToonName} - ${_Server}]}
					UIElement[ToonsListbox@RICharList]:RemoveItem[${UIElement[ToonsListbox@RICharList].Item[${i}].ID}]
			}
			UIElement[ToonsListbox@RICharList]:AddItem[${_ToonName} - ${_Server},${_ToonName}|${_Server}]
			_tempVal:Set[${UIElement[AccountsListbox@RICharList].SelectedItem.Value}|${_ToonName}|${_Server}]
			UIElement[AccountsListbox@RICharList].SelectedItem:SetValue[${_tempVal}]
			;UIElement[ToonsListbox@RICharList]:ClearSelection
		}
	}
	method AccountsListboxLeftClick()
	{
		if ${UIElement[AccountsListbox@RICharList].SelectedItem.ID(exists)}
		{
			UIElement[ToonsListbox@RICharList]:ClearItems
			UIElement[ToonTextEntry@RICharList]:SetText[""]
			;CountSets2:LoadToonList[${UIElement[AccountsListbox@RICharList].SelectedItem.Text}]
			;echo ${UIElement[AccountsListbox@RICharList].SelectedItem.Value}
			UIElement[AccountNameTextEntry@RICharList]:SetText[${UIElement[AccountsListbox@RICharList].SelectedItem.Text}]
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Count[|]};i:Inc)
			{
				if ${i}==1
				{
					;echo Password: ${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${i},|]}
					UIElement[PasswordTextEntry@RICharList]:SetText[${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${i},|]}]
				}
				else
				{
					;echo Toon: ${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${i},|]}
					;echo Server: ${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${Math.Calc[${i}+1]},|]}
					UIElement[ToonsListbox@RICharList]:AddItem[${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${i},|]} - ${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${Math.Calc[${i}+1]},|]},${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${i},|]}|${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${Math.Calc[${i}+1]},|]}]
					i:Inc
				}
			}
		}
		else
		{
			UIElement[ToonsListbox@RICharList]:ClearItems
			UIElement[AccountNameTextEntry@RICharList]:SetText[""]
			UIElement[PasswordTextEntry@RICharList]:SetText[""]
			UIElement[ToonTextEntry@RICharList]:SetText[""]
		}
	}
	method AccountsListboxRightClick()
	{
		if ${UIElement[AccountsListbox@RICharList].SelectedItem.ID(exists)}
		{
			UIElement[AccountsListbox@RICharList]:RemoveItem[${UIElement[AccountsListbox@RICharList].SelectedItem.ID}]
			UIElement[ToonsListbox@RICharList]:ClearItems
			UIElement[AccountNameTextEntry@RICharList]:SetText[""]
			UIElement[PasswordTextEntry@RICharList]:SetText[""]
			UIElement[ToonTextEntry@RICharList]:SetText[""]
		}
	}
	method ToonsListboxRightClick()
	{
		if ${UIElement[ToonsListbox@RICharList].SelectedItem.ID(exists)}
		{
			UIElement[ToonTextEntry@RICharList]:SetText[""]
			UIElement[ToonsListbox@RICharList]:RemoveItem[${UIElement[ToonsListbox@RICharList].SelectedItem.ID}]
			variable int i=0
			variable string _tempVal="${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[1,|]}|"
			for(i:Set[1];${i}<=${UIElement[ToonsListbox@RICharList].Items};i:Inc)
			{
				if ${i}<${UIElement[ToonsListbox@RICharList].Items}
					_tempVal:Concat[${UIElement[ToonsListbox@RICharList].OrderedItem[${i}].Value}|]
				else
					_tempVal:Concat[${UIElement[ToonsListbox@RICharList].OrderedItem[${i}].Value}]
			}
			if ${UIElement[ToonsListbox@RICharList].Items}>0
				UIElement[AccountsListbox@RICharList].SelectedItem:SetValue[${_tempVal}]
			else
			{
				UIElement[AccountsListbox@RICharList]:RemoveItem[${UIElement[AccountsListbox@RICharList].SelectedItem.ID}]
				UIElement[ToonsListbox@RICharList]:ClearItems
				UIElement[AccountNameTextEntry@RICharList]:SetText[""]
				UIElement[PasswordTextEntry@RICharList]:SetText[""]
				UIElement[ToonTextEntry@RICharList]:SetText[""]
			}
		}
	}
	method ToonsListboxLeftClick()
	{
		if ${UIElement[ToonsListbox@RICharList].SelectedItem.ID(exists)}
		{
			;UIElement[ToonsListbox@RICharList]:ClearItems
			;CountSets2:LoadToonList[${UIElement[AccountsListbox@RICharList].SelectedItem.Text}]
			UIElement[ToonTextEntry@RICharList]:SetText[${UIElement[ToonsListbox@RICharList].SelectedItem.Value.Token[1,|]}]
			UIElement[ServerComboBox@RICharList]:SelectItem[${UIElement[ServerComboBox@RICharList].ItemByText[${UIElement[ToonsListbox@RICharList].SelectedItem.Value.Token[2,|]}].ID}]
		}
		else
		{
			UIElement[ToonTextEntry@RICharList]:SetText[""]
		}
	}
	method Save()
	{
		;echo ISXRI Saving RICharList: RICharList.xml
		variable string SetName
		SetName:Set[RICharList]
		LavishSettings[RICharListSaveFile]:Clear
		LavishSettings:AddSet[RICharListSaveFile]
		LavishSettings[RICharListSaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		LavishSettings[RICharListSaveFile]:Clear
		variable int count=0
		variable int count2=0
		for(count:Set[1];${count}<=${UIElement[AccountsListbox@RICharList].Items};count:Inc)
		{
			LavishSettings[RICharListSaveFile]:AddSet[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Text}]
			for(count2:Set[1];${count2}<=${Math.Calc[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Value.Count[|]}+1]};count2:Inc)
			{
				if ${count2}==1
					LavishSettings[RICharListSaveFile].FindSet[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Text}]:AddSetting[Password,${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Value.Token[1,|]}]
				else
				{
					LavishSettings[RICharListSaveFile].FindSet[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Text}]:AddSet[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Value.Token[${count2},|]}]
					LavishSettings[RICharListSaveFile].FindSet[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Text}].FindSet[${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Value.Token[${count2},|]}]:AddSetting[Server,${UIElement[AccountsListbox@RICharList].OrderedItem[${count}].Value.Token[${Math.Calc[${count2}+1]},|]}]
					;echo Toon: ${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${i},|]}
					;echo Server: ${UIElement[AccountsListbox@RICharList].SelectedItem.Value.Token[${Math.Calc[${i}+1]},|]}
					count2:Inc
				}
			}
		}
		LavishSettings[RICharListSaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
	}
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RICharListUI.xml"
}