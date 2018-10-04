;;;; Thinking i want to implement a group alias option so it can be ran ri_groupLogin aliasname  or ri_grouplogin toon1|toon2|toon3   and we will just doa  .Find[|]
variable(global) RIGroupLoginObject RIGroupLoginObj
variable filepath FP
variable settingsetref RIGroupLoginSet
variable CountSetsObject2 CountSets
variable CountSetsObject CountSets2
variable(global) string RI_Var_String_RIGroupLoginScriptName=${Script.Filename}
variable string TempGroup
variable bool WaitForSessions=FALSE
variable int TimeOutCNT=0
variable int ISStart=0
variable string _Group=~NONE~
function main(... args)
{
	;disable Debugging
	Script:DisableDebugging
	variable int _count
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		if ${args[${_count}].Upper.Equal[-IS]}
		{
			ISStart:Set[${args[${Math.Calc[${_count}+1]}]}]
			_count:Inc
		}
		elseif ${args[${_count}].Upper.Equal[-SESSION]}
		{
			ISStart:Set[${args[${Math.Calc[${_count}+1]}]}]
			_count:Inc
		}
		else
			_Group:Set["${args[${_count}]}"]
	}
	;echo ${_Group} // ${ISStart}
	if ${_Group.NotEqual[~NONE~]} && ${_Group.NotEqual[""]}
	{
		if !${_Group.Find[|](exists)}
			_Group:Set[${RIGroupLoginObj.FindGroupAlias[${_Group}]}]
		;echo ${_Group}
		if ${_Group.NotEqual[""]} && ${_Group.NotEqual[NULL]}
		{
			;echo ${_Group.Count[|]}
			;echo ${ISBoxerCharacterSet(exists)} && ${Sessions}<${Math.Calc[${ISBoxerSlots}-1]}
			;echo ${Sessions}<${_Group.Count[|]} && ${TimeOutCNT:Inc}<=300
			TimeOutCNT:Set[0]
			if ${ISBoxerCharacterSet(exists)} && ${Sessions}<${Math.Calc[${ISBoxerSlots}-1]}
				squelch osexecute "${LavishScript.HomeDirectory}/InnerSpace.exe" run isboxer -launch "${ISBoxerCharacterSet}"
			while ${ISBoxerCharacterSet(exists)} && ${Sessions}<${_Group.Count[|]} && ${TimeOutCNT:Inc}<=300 && ${_Group.Count[|]}<=${Math.Calc[${ISBoxerSlots}-1]}
				wait 10
			if ${Sessions}>=${_Group.Count[|]}
			{
				if ${ISStart}>0
					RIGroupLoginObj:LaunchGroup[${_Group},${ISStart}]
				else
					RIGroupLoginObj:LaunchGroup[${_Group}]
			}
			elseif !${ISBoxerCharacterSet(exists)}
				echo ISXRI: RIGroupLogin: ISBoxer Character Set not loaded and you do not have enough sessions to login
			elseif ${_Group.Count[|]}>${Math.Calc[${ISBoxerSlots}-1]}
				echo ISXRI: RIGroupLogin: Your ISBoxer Character Set does not have ${Int[${Math.Calc[${_Group.Count[|]}+1]}]} sessions
			else
				echo ISXRI: RIGroupLogin: Timed out waiting for ${Int[${Math.Calc[${_Group.Count[|]}+1]}]} sessions
		}
		Script:End
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[RIGroupLogin]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin"]
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
	if !${FP.FileExists[RIGroupLogin.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RIGroupLogin.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin.xml" http://www.isxri.com/RIGroupLogin.xml
		wait 50
	}
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin.xml"
	
	;RIGroupLoginObj:LoadSaves
	;call LoadToonList
	call LoadAccountList
	UIElement[AccountsAvailListbox@RIGroupLogin]:SelectItem[1]
	RIGroupLoginObj:AccountsAvailListboxLeftClick
	;RIGroupLoginObj:LoadCharSet
	; if ${UIElement[SaveListbox@RIGroupLogin].OrderedItem[1](exists)}
	; {
		; UIElement[SaveListbox@RIGroupLogin]:SelectItem[1]
		; UIElement[SaveTextEntry@RIGroupLogin]:SetText[${UIElement[SaveListbox@RIGroupLogin].SelectedItem.Text}]
		; RIGroupLoginObj:LoadList
	; }
	RIGroupLoginObj:LoadCharSet
	RIGroupLoginObj:LoadList
	while 1
	{
		if ${WaitForSessions}
		{
			TimeOutCNT:Set[0]
			while ${Sessions}<${Math.Calc[${TempGroup.Count[|]}+1]} && ${TimeOutCNT:Inc}<=300
				wait 10
			if ${Sessions}>=${Math.Calc[${TempGroup.Count[|]}+1]}
			{
				if ${ISStart}>0
					RIGroupLoginObj:LaunchGroup[${_Group},${ISStart}]
				else
					RIGroupLoginObj:LaunchGroup[${_Group}]
			}
			else
				ISXRI: RIGroupLogin: Timed out waiting for ${Math.Calc[${TempGroup.Count[|]}+1]} sessions
			WaitForSessions:Set[0]
			TempGroup:Set[""]
			Script:End
		}
		wait 1
	}
}
function LoadToonList(string _Account)
{
	variable CountSetsObject CountSets2
	variable int numSets
	LavishSettings[RIGroupLogin]:Clear
	LavishSettings:AddSet[RIGroupLogin]
	LavishSettings[RIGroupLogin]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
	variable settingsetref Set2
	Set2:Set[${LavishSettings[RIGroupLogin].GUID}]
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
	CountSets2:PopulateToons[${Set2},${_Account}]
}
function LoadAccountList()
{
	;variable CountSetsObject CountSets2
	variable int numSets
	LavishSettings[RIGroupLogin]:Clear
	LavishSettings:AddSet[RIGroupLogin]
	LavishSettings[RIGroupLogin]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
	variable settingsetref Set2
	Set2:Set[${LavishSettings[RIGroupLogin].GUID}]
	;echo Set: ${CountSets2.Count[${Set2}]}==0
	numSets:Set[${CountSets2.Count[${Set2}]}]
	declare strSets[${numSets}] string script
	numSets:Set[${CountSets2.Count[${Set2}]}]
	; if ${CountSets2.Count[${Set2}]}==0
	; {
		; MessageBox -skin eq2 "We were unable to read your RICharList.xml file"
		; Script:End
	; }
	; if ${strSets[1].Equal[AccountLogin]}
	; {
		; MessageBox -skin eq2 "You must edit your RICharList.xml file and add your accounts and toons"
		; Script:End
	; }
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
		LavishSettings[RIGroupLogin]:Clear
		LavishSettings:AddSet[RIGroupLogin]
		LavishSettings[RIGroupLogin]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		variable settingsetref Set2
		Set2:Set[${LavishSettings[RIGroupLogin].GUID}]
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
					UIElement[ToonsAvailListbox@RIGroupLogin]:AddItem[${Iterator.Key}]
				}
				while ${Iterator:Next(exists)}
			}
		}
	}
	method PopulateAccounts(settingsetref Set4)
	{
		;echo Serching for ${ToonName}
		UIElement[AccountsAvailListbox@RIGroupLogin]:AddItem[*ALL*]
		variable int ecCount=0
		for(ecCount:Set[1];${ecCount}<=${strSets.Size};ecCount:Inc)
		{
			UIElement[AccountsAvailListbox@RIGroupLogin]:AddItem[${strSets[${ecCount}]}]
		}
	}
}
objectdef RIGroupLoginObject
{
	member:string FindGroupAlias(string _Alias)
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/"]
		if ${FP.FileExists[RIGroupLoginSave.xml]}
		{
			LavishSettings[RIGroupLogin]:Clear
			LavishSettings:AddSet[RIGroupLogin]
			LavishSettings[RIGroupLogin]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/RIGroupLoginSave.xml"]
			RIGroupLoginSet:Set[${LavishSettings[RIGroupLogin].GUID}]

			variable settingsetref LoadListSet=${RIGroupLoginSet.FindSet[RIGroupLogin].GUID}
			LoadListSet:Set[${RIGroupLoginSet.FindSet[RIGroupLogin].GUID}]
			variable int LoadListCount=${CountSets.Count[${LoadListSet}]}
			LoadListCount:Set[${CountSets.Count[${LoadListSet}]}]

			if ${LoadListCount}>0
			{
				variable string temp
				variable settingsetref Set4
				variable int icCount=0
				for(icCount:Set[1];${icCount}<=${LoadListCount};icCount:Inc)
				{
					;echo checking ${icCount}
					Set4:Set[${LoadListSet.FindSet[${icCount}].GUID}]
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
							temp:Set[${SettingIterator.Value}]
							if ${temp.Find[${_Alias}:](exists)}
								return ${temp}
						}
						while ${SettingIterator:Next(exists)}
					}
				}
				return
			}
		}
	}
	method AddedGroupsListboxDoubleLeftClick()
	{
		if ${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem(exists)}
		{
			This:LaunchGroup[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text}]
		}
	}
	method AddedGroupsListboxLeftClick()
	{
		if ${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.ID(exists)}
		{
			UIElement[AddedToonsListbox@RIGroupLogin]:ClearItems
			UIElement[ToonsAvailListbox@RIGroupLogin]:ClearSelection
			variable int i=0
			for(i:Set[1];${i}<=${Math.Calc[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Count[|]}+1]};i:Inc)
			{
				if ${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Token[${i},|].Find[:](exists)}
				{
					UIElement[GroupAliasTextEntry@RIGroupLogin]:SetText[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Token[${i},|].Left[${Math.Calc[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Token[${i},|].Find[:]}-1]}]}]
					UIElement[AddedToonsListbox@RIGroupLogin]:AddItem[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Token[${i},|].Right[${Math.Calc[-1*${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Token[${i},|].Find[:]}]}]}]
				}
				else
				{
					UIElement[AddedToonsListbox@RIGroupLogin]:AddItem[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.Text.Token[${i},|]}]
				}
			}
		}
		else
		{
			UIElement[AddedToonsListbox@RIGroupLogin]:ClearItems
			UIElement[ToonsAvailListbox@RIGroupLogin]:ClearSelection
			UIElement[GroupAliasTextEntry@RIGroupLogin]:SetText[""]
		}
	}
	method AddedGroupsListboxRightClick()
	{
		if ${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.ID(exists)}
		{
			UIElement[AddedGroupsListbox@RIGroupLogin]:RemoveItem[${UIElement[AddedGroupsListbox@RIGroupLogin].SelectedItem.ID}]
			This:SaveList
		}
	}
	method LaunchGroup(string _Group, int _ISStart=1)
	{
		;echo ${_Group} ${_ISStart}
		if ${_Group.NotEqual[NULL]} && ${_Group.NotEqual[""]}
		{
			if ${ISBoxerCharacterSet(exists)} && ${Sessions}<${Math.Calc[${ISBoxerSlots}-1]}
			{
				TempGroup:Set[${_Group}]
				WaitForSessions:Set[1]
				ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin.xml"
				return
			}
			variable int i=0
			variable int j=${_ISStart}
			for(i:Set[1];${i}<=${Math.Calc[${_Group.Count[|]}+1]};i:Inc)
			{
				if ${_Group.Token[${i},|].Find[:](exists)}
					relay is${j} CB ${_Group.Token[${i},|].Right[${Math.Calc[-1*${_Group.Token[${i},|].Find[:]}]}]}
				else
					relay is${j} CB ${_Group.Token[${i},|]}
				j:Inc
			}
			Script:End
		}
	}
	method AddToon(string _ToonName)
	{
		;echo ${_ToonName}
		if ${_ToonName.NotEqual[NULL]} && ${_ToonName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedToonsListbox@RIGroupLogin].Items};i:Inc)
			{
				if ${UIElement[AddedToonsListbox@RIGroupLogin].Item[${i}].Text.Equal[${_ToonName}]}
					UIElement[AddedToonsListbox@RIGroupLogin]:RemoveItem[${UIElement[AddedToonsListbox@RIGroupLogin].Item[${i}].ID}]
			}
			UIElement[AddedToonsListbox@RIGroupLogin]:AddItem[${_ToonName}]
			UIElement[ToonsAvailListbox@RIGroupLogin]:ClearSelection
		}
	}
	method AddGroup()
	{
		if ${UIElement[AddedToonsListbox@RIGroupLogin].Items}>0
		{
			variable int i=0
			variable string _GroupString
			;variable string _GroupDisplayString
			if ${UIElement[GroupAliasTextEntry@RIGroupLogin].Text.NotEqual[NULL]} && ${UIElement[GroupAliasTextEntry@RIGroupLogin].Text.NotEqual[""]}
			{
				_GroupString:Set["${UIElement[GroupAliasTextEntry@RIGroupLogin].Text}: "]
				;_GroupDisplayString:Set["${UIElement[GroupAliasTextEntry@RIGroupLogin].Text}: "]
			}
			else
			{
				_GroupDisplayString:Set[""]
				;_GroupString:Set[""]
			}
			for(i:Set[1];${i}<=${UIElement[AddedToonsListbox@RIGroupLogin].Items};i:Inc)
			{
				if ${i}<${UIElement[AddedToonsListbox@RIGroupLogin].Items}
				{
					_GroupString:Concat[${UIElement[AddedToonsListbox@RIGroupLogin].OrderedItem[${i}].Text}|]
					;_GroupDisplayString:Concat[${UIElement[AddedToonsListbox@RIGroupLogin].OrderedItem[${i}].Text}|]
				}
				else
				{
					_GroupString:Concat[${UIElement[AddedToonsListbox@RIGroupLogin].OrderedItem[${i}].Text}]
					;_GroupDisplayString:Concat[${UIElement[AddedToonsListbox@RIGroupLogin].OrderedItem[${i}].Text}]
				}
			}
			for(i:Set[1];${i}<=${UIElement[AddedGroupsListbox@RIGroupLogin].Items};i:Inc)
			{
				if ${UIElement[AddedGroupsListbox@RIGroupLogin].Item[${i}].Text.Equal[${_GroupString}]}
					UIElement[AddedGroupsListbox@RIGroupLogin]:RemoveItem[${UIElement[AddedGroupsListbox@RIGroupLogin].Item[${i}].ID}]
			}
			UIElement[AddedGroupsListbox@RIGroupLogin]:AddItem[${_GroupString}]
			UIElement[AddedToonsListbox@RIGroupLogin]:ClearItems
			UIElement[GroupAliasTextEntry@RIGroupLogin]:SetText[""]
			This:SaveList
		}
	}
	method AccountsAvailListboxLeftClick()
	{
		if ${UIElement[AccountsAvailListbox@RIGroupLogin].SelectedItem.ID(exists)}
		{
			UIElement[ToonsAvailListbox@RIGroupLogin]:ClearItems
			CountSets2:LoadToonList[${UIElement[AccountsAvailListbox@RIGroupLogin].SelectedItem.Text}]
		}
		else
			UIElement[ToonsAvailListbox@RIGroupLogin]:ClearItems
	}
	method LoadCharSet()
	{
		; FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/"]
		; if ${FP.FileExists[RIGroupLoginSave.xml]}
		; {
			; LavishSettings[RIGroupLogin]:Clear
			; LavishSettings:AddSet[RIGroupLogin]
			; LavishSettings[RIGroupLogin]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/RIGroupLoginSave.xml"]
			; RIGroupLoginSet:Set[${LavishSettings[RIGroupLogin].GUID}]
			;CountSets:IterateSets[${RIGroupLoginSet}]
			;echo ${RIGroupLoginSet.FindSetting[ISBCharSetTextEntry]}
			if ${ISBoxerCharacterSet(exists)}
				UIElement[ISBCharSetTextEntry@RIGroupLogin]:SetText[${ISBoxerCharacterSet}]
		;}
	}
	method LoadList()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/"]
		if ${FP.FileExists[RIGroupLoginSave.xml]}
		{
			LavishSettings[RIGroupLogin]:Clear
			LavishSettings:AddSet[RIGroupLogin]
			LavishSettings[RIGroupLogin]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/RIGroupLoginSave.xml"]
			RIGroupLoginSet:Set[${LavishSettings[RIGroupLogin].GUID}]

			;CountSets:IterateSets[${RIGroupLoginSet}]
			;CountSets:EchoSets
			;CountSets:PopulateSets
			;import AnnounceSet
			variable settingsetref LoadListSet=${RIGroupLoginSet.FindSet[RIGroupLogin].GUID}
			LoadListSet:Set[${RIGroupLoginSet.FindSet[RIGroupLogin].GUID}]
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
		;if ${UIElement[AddedGroupsListbox@RIGroupLogin].Items}>0
		;{
			;echo ISXRI Saving RIGroupLoginList: RIGroupLoginSave.xml
			variable string SetName
			SetName:Set[RIGroupLogin]
			LavishSettings[RIGroupLoginSaveFile]:Clear
			LavishSettings:AddSet[RIGroupLoginSaveFile]
			LavishSettings[RIGroupLoginSaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/RIGroupLoginSave.xml"]
			;LavishSettings[RIGroupLoginSaveFile]:AddSetting[ISBCharSetTextEntry,${UIElement[ISBCharSetTextEntry@RIGroupLogin].Text}]
			LavishSettings[RIGroupLoginSaveFile]:AddSet[${SetName}]
			LavishSettings[RIGroupLoginSaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			
			for(count:Set[1];${count}<=${UIElement[AddedGroupsListbox@RIGroupLogin].Items};count:Inc)
			{
				LavishSettings[RIGroupLoginSaveFile].FindSet[${SetName}]:AddSet[${count}]
				LavishSettings[RIGroupLoginSaveFile].FindSet[${SetName}].FindSet[${count}]:AddSetting[Group,${UIElement[AddedGroupsListbox@RIGroupLogin].OrderedItem[${count}].Text}]
			}
			LavishSettings[RIGroupLoginSaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin/RIGroupLoginSave.xml"]
			if !${_Delete}
				UIElement[SaveListbox@RIGroupLogin]:AddItem[${UIElement[SaveTextEntry@RIGroupLogin].Text}]
			UIElement[SaveTextEntry@RIGroupLogin]:SetText[""]
			;echo here
		;}
	}
	method DeleteList()
	{
		if ${UIElement[SaveListbox@RIGroupLogin].SelectedItem(exists)}
		{
			UIElement[AddedGroupsListbox@RIGroupLogin]:ClearItems
			This:SaveList[TRUE]
			UIElement[SaveListbox@RIGroupLogin]:RemoveItem[${UIElement[SaveListbox@RIGroupLogin].SelectedItem.ID}]
			UIElement[SaveTextEntry@RIGroupLogin]:SetText[""]
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
					UIElement[AddedGroupsListbox@RIGroupLogin]:AddItem[${SettingIterator.Value}]
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
			UIElement[SaveListbox@RIGroupLogin]:AddItem[${Iterator.Key}]
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
				UIElement[ToonsAvailListbox@RIGroupLogin]:AddItem[${Iterator.Key}]
			}
			while ${Iterator:Next(exists)}
		}
	}
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin.xml"
}