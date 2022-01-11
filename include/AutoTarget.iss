;AutoTarget by Herculezz

variable(global) string RI_Var_String_AutoTargetScriptName=${Script.Filename}
variable(global) RIAutoTargetObject RIAutoTargetObj
variable bool RI_Var_Bool_WaitChanged=FALSE
variable bool RI_Var_Bool_AutoTargetEnabled=TRUE
variable bool RI_Var_Bool_OutOfCombat=FALSE
variable filepath FP
variable settingsetref RIAutoTargetSet
variable CountSetsObject CountSets
variable int intRadiusChange=100
variable string strRadiusChange=100
variable int intHealthChange
variable string strHealthChange
variable int intWaitChange
variable string strWaitChange
function main()
{	
	;disable debugging
	Script:DisableDebugging
	
	;loadfiles and folders and all that mumbojumbo
	;check if RIAutoTarget.xml exists, if not create
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if ${FP.FileExists[RIAutoTarget.xml]}
	{
		noop
	}
	else
	{
		if ${Debug}
			echo ${Time}: Getting RIAutoTarget.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIAutoTarget.xml" http://www.isxri.com/RIAutoTarget.xml
		wait 50
	}

	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		FP:MakeSubdirectory[AutoTarget]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/"]
	}
	
	
	;loadui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIAutoTarget.xml"
	;Script:End
	;main loop
	while 1
	{
		if !${UIElement[Enabled@RIAutoTarget].Checked}
		{
			if ${UIElement[WaitEntry@RIAutoTarget].Text.NotEqual[""]}
			{
				if ${UIElement[WaitEntry@RIAutoTarget].Text}>0
					wait ${Math.Calc[${UIElement[WaitEntry@RIAutoTarget].Text}*10]} ${RI_Var_Bool_WaitChanged}
				else
					wait 5 ${RI_Var_Bool_WaitChanged}
			}
			else
				wait 5 ${RI_Var_Bool_WaitChanged}
			continue
		}
		if ${UIElement[WaitEntry@RIAutoTarget].Text.NotEqual[""]}
		{
			if ${UIElement[WaitEntry@RIAutoTarget].Text}>0
				wait ${Math.Calc[${UIElement[WaitEntry@RIAutoTarget].Text}*10]} ${RI_Var_Bool_WaitChanged}
			else
				wait 5 ${RI_Var_Bool_WaitChanged}
		}
		else
			wait 5 ${RI_Var_Bool_WaitChanged}
		;echo ${Script.RunningTime}: waiting
		if ${RI_Var_Bool_WaitChanged}
			RI_Var_Bool_WaitChanged:Set[FALSE]
		;continue
		variable int intQuery=0
		variable index:actor iactorGA
		variable int atCount=0
		variable string ActorName
		variable int MinHP=0
		;wait until i am incombat or hated
		while ( !${Me.IsHated} && !${Me.InCombat} && !${RI_Var_Bool_OutOfCombat} )
			wait 5
			
		for (atCount:Set[1];${atCount}<=${UIElement[Targets@RIAutoTarget].Items};atCount:Inc)
		{
			if ${UIElement[Targets@RIAutoTarget].OrderedItem[${atCount}].Text.Find[>](exists)}
			{
				;echo has minhp ${UIElement[Targets@RIAutoTarget].OrderedItem[${atCount}].Text.Right[${Math.Calc[-1*${UIElement[Targets@RIAutoTarget].OrderedItem[${atCount}].Text.Find[>]}]}]}
				MinHP:Set[${UIElement[Targets@RIAutoTarget].OrderedItem[${atCount}].Text.Right[${Math.Calc[-1*${UIElement[Targets@RIAutoTarget].OrderedItem[${atCount}].Text.Find[>]}]}]}]
			}
			else
			{
				;echo doesnt
				MinHP:Set[0]
			}
			ActorName:Set[${UIElement[Targets@RIAutoTarget].OrderedItem[${atCount}].Value}]
			;echo ${ActorName} > ${MinHP}
			if ${UIElement[RadiusEntry@RIAutoTarget].Text.NotEqual[""]}
				EQ2:GetActors[iactorGA,range,${UIElement[RadiusEntry@RIAutoTarget].Text},${ActorName}]
			else
				EQ2:GetActors[iactorGA,range,100,${ActorName}]
			;continue if we get none
			if ${iactorGA.Used} <= 0
				continue

				;remove all except Me, NPCs, NamedNPCs, and PCs
			intQuery:Set[${LavishScript.CreateQuery[Type = "NPC" || Type = "NamedNPC" || Type = "PC" || Type = "Me"]}]
			iactorGA:RemoveByQuery[${intQuery},FALSE]
			LavishScript:FreeQuery[${intQuery}]
			iactorGA:Collapse
			
			;continue if none are left
			if ${iactorGA.Used} <= 0
				continue

			;remove if Health is below set amount
			intQuery:Set[${LavishScript.CreateQuery["Health < ${MinHP}"]}]
			iactorGA:RemoveByQuery[${intQuery},true]
			LavishScript:FreeQuery[${intQuery}]
			iactorGA:Collapse
			
			;continue if none are left
			if ${iactorGA.Used} <= 0
				continue

			;finally target the first Actor in the Index
			if ${Target.ID} != ${iactorGA[1].ID}
				Actor[id,${iactorGA[1].ID}]:DoTarget
			
			break
		}
	}
}
objectdef RIAutoTargetObject
{
	method WaitChange()
	{
		if ${UIElement[WaitEntry@RIAutoTarget].Text.Equals["${strWaitChange}"]}
			return
		strWaitChange:Set[${UIElement[WaitEntry@RIAutoTarget].Text}]
		if ${UIElement[WaitEntry@RIAutoTarget].Text.NotEqual[""]} 
		{
			RI_Var_Bool_WaitChanged:Set[TRUE]
			if ${UIElement[WaitEntry@RIAutoTarget].Text.Length}==1
				UIElement[WaitEntry@RIAutoTarget]:SetText[${Int[${UIElement[WaitEntry@RIAutoTarget].Text}]}]
			elseif ${UIElement[WaitEntry@RIAutoTarget].Text.Right[${Math.Calc[-1*(${UIElement[WaitEntry@RIAutoTarget].Text.Length}-1)]}].NotEqual[.]}
			{
				UIElement[WaitEntry@RIAutoTarget]:SetText[${UIElement[WaitEntry@RIAutoTarget].Text.Left[-1]}${Int[${UIElement[WaitEntry@RIAutoTarget].Text.Right[${Math.Calc[-1*(${UIElement[WaitEntry@RIAutoTarget].Text.Length}-1)]}]}]}]
			}
		}
	}
	method RadiusChange(int _Radius=-1)
	{
		if ${_Radius}==-1
		{
			if ${UIElement[RadiusEntry@RIAutoTarget].Text.Equals["${strRadiusChange}"]}
				return
			strRadiusChange:Set[${UIElement[RadiusEntry@RIAutoTarget].Text}]
			if ${UIElement[RadiusEntry@RIAutoTarget].Text.NotEqual[""]}
			{
				intRadiusChange:Set[${Int[${strRadiusChange}]}]
				UIElement[RadiusEntry@RIAutoTarget]:SetText[${intRadiusChange}]
			}
		}
		else
		{
			intRadiusChange:Set[${_Radius}]
			UIElement[RadiusEntry@RIAutoTarget]:SetText[${intRadiusChange}]
		}
	}
	method HealthChange(int _Health=-1)
	{
		if ${_Health}==-1
		{
			if ${UIElement[HealthEntry@RIAutoTarget].Text.Equals["${strHealthChange}"]}
				return
			strHealthChange:Set[${UIElement[HealthEntry@RIAutoTarget].Text}]
			if ${UIElement[HealthEntry@RIAutoTarget].Text.NotEqual[""]}
			{
				intHealthChange:Set[${Int[${strHealthChange}]}]
				UIElement[HealthEntry@RIAutoTarget]:SetText[${intHealthChange}]
			}
		}
		else
		{
			intHealthChange:Set[${_Health}]
			UIElement[HealthEntry@RIAutoTarget]:SetText[${intHealthChange}]
		}
	}
	method ClearTargets()
	{
		UIElement[Targets@RIAutoTarget]:ClearItems
	}
	method AddCurrentTarget()
	{
		if ${Target(exists)}
		{
			UIElement[TargetEntry@RIAutoTarget]:SetText[${Target}]
		}
	}
	method AddTarget(string _Target=-1, int _MinHP=-1)
	{
		if ${_Target.Equal[-1]}
		{
			if ${UIElement[TargetEntry@RIAutoTarget].Text.Equal[""]}
				return
			if ${UIElement[HealthEntry@RIAutoTarget].Text.NotEqual[""]}
				This:AddTargetToList[${UIElement[TargetEntry@RIAutoTarget].Text},${UIElement[HealthEntry@RIAutoTarget].Text}]
			else
				This:AddTargetToList[${UIElement[TargetEntry@RIAutoTarget].Text},0]
		}
		else
		{
			if ${_MinHP}==-1
				This:AddTargetToList[${UIElement[TargetEntry@RIAutoTarget].Text},0]				
			else
				This:AddTargetToList[${UIElement[TargetEntry@RIAutoTarget].Text},${_MinHP}]
		}
	}
	method AddTargetToList(string ActorName, int MinHP)
	{
		if ${MinHP}>0
			UIElement[Targets@RIAutoTarget]:AddItem[${ActorName} > ${MinHP},${ActorName}]
		else
			UIElement[Targets@RIAutoTarget]:AddItem[${ActorName},${ActorName}]
		UIElement[TargetEntry@RIAutoTarget]:SetText[""]
		UIElement[HealthEntry@RIAutoTarget]:SetText[""]
	}
	method RemoveTarget()
	{
		if ${UIElement[Targets@RIAutoTarget].SelectedItem(exists)}
			UIElement[Targets@RIAutoTarget]:RemoveItem[${UIElement[Targets@RIAutoTarget].SelectedItem.ID}]
	}
	method TargetEnter()
	{
		if ${UIElement[TargetEntry@RIAutoTarget].Text.NotEqual[""]}
			RIAutoTargetObj:AddTarget
	}
	method ToggleEnabled()
	{
		if ${UIElement[Enabled@RIAutoTarget].Checked}
			RI_Var_Bool_AutoTargetEnabled:Set[TRUE]
		else
			RI_Var_Bool_AutoTargetEnabled:Set[FALSE]
	}
	method ToggleOutOfCombat()
	{
		if ${UIElement[OutOfCombat@RIAutoTarget].Checked}
			RI_Var_Bool_OutOfCombat:Set[TRUE]
		else
			RI_Var_Bool_OutOfCombat:Set[FALSE]
	}
	method LoadSaves()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/"]
		if ${FP.FileExists[RI_AutoTarget_${Zone}.xml]}
		{
			LavishSettings[RIAutoTarget]:Clear
			LavishSettings:AddSet[RIAutoTarget]
			LavishSettings[RIAutoTarget]:Import["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/RI_AutoTarget_${Zone}.xml"]
			RIAutoTargetSet:Set[${LavishSettings[RIAutoTarget].GUID}]

			CountSets:IterateSets[${RIAutoTargetSet}]
		}
		else
		{
			FP:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/AutoTarget/Save/"]
			if ${FP.FileExists[autotarget_${Zone}.xml]}
			{
				cp "${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/AutoTarget/Save/autotarget_${Zone}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/RI_AutoTarget_${Zone}.xml"
				TimedCommand 5 RIAutoTargetObj:LoadSaves
			}
		}
	}
	method SaveClick()
	{
		if ${UIElement[Saves@RIAutoTarget].SelectedItem(exists)}
			UIElement[SaveEntry@RIAutoTarget]:SetText[${UIElement[Saves@RIAutoTarget].SelectedItem.Text}]
	}
	method LoadList()
	{
		if ${UIElement[SaveEntry@RIAutoTarget].Text.NotEqual[""]}
		{
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/"]
			if ${FP.FileExists[RI_AutoTarget_${Zone}.xml]}
			{
				LavishSettings[RIAutoTarget]:Clear
				LavishSettings:AddSet[RIAutoTarget]
				LavishSettings[RIAutoTarget]:Import["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/RI_AutoTarget_${Zone}.xml"]
				RIAutoTargetSet:Set[${LavishSettings[RIAutoTarget].GUID}]

				;CountSets:IterateSets[${RIAutoTargetSet}]
				;CountSets:EchoSets
				;CountSets:PopulateSets
				;import AnnounceSet
				variable settingsetref LoadListSet=${RIAutoTargetSet.FindSet[${UIElement[SaveEntry@RIAutoTarget].Text}].GUID}
				LoadListSet:Set[${RIAutoTargetSet.FindSet[${UIElement[SaveEntry@RIAutoTarget].Text}].GUID}]
				variable int LoadListCount=${CountSets.Count[${LoadListSet}]}
				LoadListCount:Set[${CountSets.Count[${LoadListSet}]}]
				if ${LoadListCount}>0
				{
					UIElement[Targets@RIAutoTarget]:ClearItems
					CountSets:IterateSettings[${LoadListSet},${LoadListCount}]
				}
			}
		}
	}
	method SaveList(bool Delete=FALSE)
	{
		if ${UIElement[SaveEntry@RIAutoTarget].Text.NotEqual[""]} && ( ${UIElement[Targets@RIAutoTarget].Items}>0 || ${Delete} )
		{
			;echo ISXRI Saving AutoTargetList: RI_AutoTarget_${Zone}.xml
			variable string SetName
			SetName:Set[${UIElement[SaveEntry@RIAutoTarget].Text}]
			LavishSettings[RIAutoTargetSaveFile]:Clear
			LavishSettings:AddSet[RIAutoTargetSaveFile]
			LavishSettings[RIAutoTargetSaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/RI_AutoTarget_${Zone}.xml"]
			LavishSettings[RIAutoTargetSaveFile]:AddSet[${SetName}]
			LavishSettings[RIAutoTargetSaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			variable int MinHP
			variable string ActorName
			for(count:Set[1];${count}<=${UIElement[Targets@RIAutoTarget].Items};count:Inc)
			{
				if ${UIElement[Targets@RIAutoTarget].OrderedItem[${count}].Text.Find[>](exists)}
				{
					;echo has minhp ${UIElement[Targets@RIAutoTarget].OrderedItem[${count}].Text.Right[${Math.Calc[-1*${UIElement[Targets@RIAutoTarget].OrderedItem[${count}].Text.Find[>]}]}]}
					MinHP:Set[${UIElement[Targets@RIAutoTarget].OrderedItem[${count}].Text.Right[${Math.Calc[-1*${UIElement[Targets@RIAutoTarget].OrderedItem[${count}].Text.Find[>]}]}]}]
				}
				else
				{
					;echo doesnt
					MinHP:Set[0]
				}
				ActorName:Set[${UIElement[Targets@RIAutoTarget].OrderedItem[${count}].Value}]
				;echo ${ActorName} > ${MinHP}
				LavishSettings[RIAutoTargetSaveFile].FindSet[${SetName}]:AddSet[${count}]
				LavishSettings[RIAutoTargetSaveFile].FindSet[${SetName}].FindSet[${count}]:AddSetting[ActorName,${ActorName}]
				LavishSettings[RIAutoTargetSaveFile].FindSet[${SetName}].FindSet[${count}]:AddSetting[MinHPToTarget,${MinHP}]
			}
			LavishSettings[RIAutoTargetSaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/AutoTarget/RI_AutoTarget_${Zone}.xml"]
		}
	}
	method DeleteList()
	{
		if ${UIElement[Saves@RIAutoTarget].SelectedItem(exists)}
		{
			UIElement[Targets@RIAutoTarget]:ClearItems
			This:SaveList[TRUE]
			UIElement[Saves@RIAutoTarget]:RemoveItem[${UIElement[Saves@RIAutoTarget].SelectedItem.ID}]
		}
	}
}
;object CountSetsObject
objectdef CountSetsObject
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
				
				if ${SettingIterator.Key.Equal[ActorName]}
				{
					ActorName:Set[${SettingIterator.Value}]
				}
				if ${SettingIterator.Key.Equal[MinHPToTarget]}
				{
					MinHP:Set[${SettingIterator.Value}]
					RIAutoTargetObj:AddTargetToList[${ActorName},${MinHP}]
				}
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
			UIElement[Saves@RIAutoTarget]:AddItem[${Iterator.Key}]
			;echo ${Iterator.Key}
		}
		while ${Iterator:Next(exists)}
	}
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIAutoTarget.xml"
}