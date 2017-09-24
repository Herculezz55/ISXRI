;RunInstances Script by Herculezz

variable(global) string help=Written by Herculezz, Join #ISXRI, or visit www.isxri.com
variable(global) string about=Written by Herculezz, Join #ISXRI, or visit www.isxri.com

variable(global) bool RI_Var_Bool_AcceptLoot=TRUE
variable(global) bool RI_Var_Bool_Loot=TRUE
variable(global) bool RI_Var_Bool_CorpseLoot=TRUE
variable(global) bool RI_Var_Bool_CancelMovement=FALSE
variable string PauseMovementKey=Shift
variable(global) bool RI_Var_Bool_BreakPathFunction=FALSE
variable(global) bool RI_Var_Bool_PauseMovement=FALSE
variable(global) string RI_Var_String_RunInstancesScriptName=${Script.Filename}
variable(global) bool RI_Var_Bool_QuestMode=FALSE
variable(global) bool RI_Var_Bool_PathDebug=FALSE
variable(global) bool RI_Var_Bool_RemoveAfterTrigger=FALSE
variable int Distance=2
variable int MDistance=4
variable string CurrentLootWindowID=0
variable(global) bool ICantSeeMyTarget=FALSE
variable int ICantSeeMyTargetCNT=0
variable(global) bool RI_Var_Bool_Follow=TRUE
variable float TempX=0
variable float TempY=0
variable float TempZ=0
variable float TempOX=0
variable float TempOY=0
variable float TempOZ=0
variable int ShinyID=0
variable int Precision=2
variable int LockSpotMax=125
variable string LineRead
variable file Filename
variable string CustomFunction
variable string CustomLoc
variable int WaitTime
variable string WaitLoc
variable string ClickActorName
variable string ClickActorLoc
variable string HailActorName
variable string HailActorLoc
variable string NamedName
variable bool LOD
variable string LODXYZ="2 2 2"
variable bool StandardNamed
variable bool CustomNamed
variable string NamedLoc
variable int ArrayPosition=0
variable int TempArrayPosition=0
variable bool FoundCloserWaypoint=FALSE
variable int64 ClosestWaypointDistance=999999
variable string ClosestWaypoint
variable string GarbageCollector
variable string AddName
variable bool KillAdd
variable bool LockForCombat=TRUE
variable bool DontStopForCombat=FALSE
variable bool Trigger=FALSE

variable bool MoveBehind=FALSE

variable(global) bool GlobalMoveBehind=TRUE
variable(global) bool GlobalRunQuests=FALSE
variable index:string IncomingText
variable index:string IncomingText2
variable index:string AnnounceText
variable string TriggerMessage
variable(global) int NameID
variable(global) int MobID
variable(global) bool GlobalExitInstance=FALSE
variable bool Developer=FALSE
variable bool Consuming=FALSE
variable bool RecentlyCheckedGatherRemains=FALSE
variable bool LockSpottingWasOff=FALSE
variable int ShinyScanDistance=20
;ArrayCounter variable
variable(global) int MainArrayCounter=0
variable int MyGroupSize
variable index:string MainQuestName
variable(global) RunInstancesObject RIObj
variable index:string istrMain
variable bool NoFile=FALSE
variable string MyZone=${Me.GetGameData[Self.ZoneName].Label}
variable string MyName=${Me.Name}
variable(global) bool IJustZonedLessThan10SecondsAgo=FALSE
variable(global) bool RI_Var_Bool_LoopZoneFile=FALSE
variable bool LoadedTLO=FALSE
variable string LoadedTLOName
variable(global) bool _RI_LootImmunity_=FALSE
;; Including what i need from these files directly

; #ifndef _PositionUtils_
	; #define _IncludePositionUtils_
	; #include "${LavishScript.HomeDirectory}/Scripts/EQ2Common/PositionUtils.iss"
; #endif
; #ifndef _CustomNamedToV_
	; #define _IncludeCustomNamedToV_
	; #include "${LavishScript.HomeDirectory}/Scripts/RunInstances/CustomNamedToV.iss"
; #endif
; #ifndef _CustomNamedAoM_
	; #define _IncludeCustomNamedAoM_
	; #include "${LavishScript.HomeDirectory}/Scripts/RunInstances/CustomNamedAoM.iss"
; #endif

;main function
function main(string FunctionToRun=NONE)
{
	;echo ${FunctionToRun}
	;disable RI_Var_Bool_Debugging
	Script:DisableDebugging

	RI_Var_Bool_CancelMovement:Set[FALSE]
	RI_Var_Bool_PauseMovement:Set[FALSE]
	RI_Var_Bool_GlobalOthers:Set[FALSE]
	RI_Var_Bool_Start:Set[FALSE]
	RI_Var_Bool_Paused:Set[FALSE]
	
	;set my groupsize
	;MyGroupSize:Set[${Me.Group}]
	
	;remove outdated files and folders
	declare count int
	declare FP filepath "${LavishScript.HomeDirectory}/Extensions/ISXDK34/"
	if ${FP.FileExists[ISXRIold.dll]}
		rm "${LavishScript.HomeDirectory}/Extensions/ISXDK34/ISXRIold.dll"
	if ${FP.FileExists[RI.dll]}
		rm "${LavishScript.HomeDirectory}/Extensions/ISXDK34/RI.dll"
	if ${FP.FileExists[RIold.dll]}
		rm "${LavishScript.HomeDirectory}/Extensions/ISXDK34/RIold.dll"
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RunInstances/Zones/"]
	declare FL filelist 
	FL:GetFiles[${FP}*.*]

	if ${FP.PathExists}
	{
		if ${FL.Files}>0
		{

			for(count:Set[1];${count}<=${FL.Files};count:Inc)
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Removing file ${count}: ${FL.File[${count}].Filename}
				rm "${LavishScript.HomeDirectory}/Scripts/RunInstances/Zones/${FL.File[${count}].Filename}"
			}
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Removing directory ${FP}
			rmdir "${FP}"
		}
		else
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Removing directory ${FP}
			rmdir "${FP}"
		}
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RunInstances/"]
	FL:Reset
	FL:GetFiles[${FP}*.*]

	if ${FP.PathExists}
	{
		if ${FL.Files}>0
		{

			for(count:Set[1];${count}<=${FL.Files};count:Inc)
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Removing file ${count}: ${FL.File[${count}].Filename}
				rm "${LavishScript.HomeDirectory}/Scripts/RunInstances/${FL.File[${count}].Filename}"
			}
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Removing directory ${FP}
			rmdir "${FP}"
		}
		else
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Removing directory ${FP}
			rmdir "${FP}"
		}
	}
	;check if RI.xml exists, if not create
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RI.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml" http://www.isxri.com/RI.xml
		wait 50
	}
	if !${FP.FileExists[RZ.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RZ.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml" http://www.isxri.com/RZ.xml
		wait 50
	}
	
	;events
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncement]
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	Event[EQ2_ReplyDialogAppeared]:AttachAtom[EQ2_ReplyDialogAppeared]
	Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
	Event[EQ2_onQuestOffered]:AttachAtom[EQ2_onQuestOffered]
	Event[EQ2_onLootWindowAppeared]:AttachAtom[EQ2_onLootWindowAppeared]
	
	if ${Exit}
		GlobalExitInstance:Set[TRUE]
	
	if ${Devel.Equal[TRUE]}
	{
		Developer:Set[TRUE]
		; if ${Me.Equipment[Food].AutoConsumeOn}
			; relay ${RI_Var_String_RelayGroup} Me.Equipment[Food]:ToggleAutoConsume
		; if ${Me.Equipment[Drink].AutoConsumeOn}
			; relay ${RI_Var_String_RelayGroup} Me.Equipment[Drink]:ToggleAutoConsume
		; if ${Me.Inventory[Elixir of Piety](exists)} && ${Me.Archetype.Equal[priest]} && ${Me.Inventory[Elixir of Piety].AutoConsumeOn}
			; Me.Inventory[Elixir of Piety]:ToggleAutoConsume
		; if ${Me.Inventory[Elixir of Deftness](exists)} && ${Me.Archetype.Equal[scout]} && ${Me.Inventory[Elixir of Deftness].AutoConsumeOn}
			; Me.Inventory[Elixir of Deftness]:ToggleAutoConsume
		; if ${Me.Inventory[Elixir of Intellect](exists)} && ${Me.Archetype.Equal[mage]} && ${Me.Inventory[Elixir of Intellect].AutoConsumeOn}
			; Me.Inventory[Elixir of Intellect]:ToggleAutoConsume
		; if ${Me.Inventory[Elixir of Fortitude](exists)} && !${RI_Var_Bool_GlobalOthers} && ${Me.Inventory[Elixir of Fortitude].AutoConsumeOn}
			; Me.Inventory[Elixir of Fortitude]:ToggleAutoConsume
	}
	variable bool Solo=FALSE
	if ${Me.Group}==1 || ${Me.GetGameData[Self.ZoneName].Label.Find["Solo]"](exists)} || ${Me.GetGameData[Self.ZoneName].Label.Equal["Arcanna'se Spire: Revealed"]}
		Solo:Set[TRUE]

	;turn off ogre loot
	; if ${ISXOgre(exists)}
		; OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_loot FALSE
	
	;changeloot options to round robin if developer
	if ${Developer} && ${FunctionToRun.NotEqual[RI_Var_Bool_GlobalOthers]} && ${FunctionToRun.Equal[NONE]} && ${Me.IsGroupLeader} && ( ( !${Solo} && ${Me.Group}>2 ) || ( ${Solo} && ${Me.Group}==2 && ${Me.Group[2].Type.Equal[PC]} )
		call LootOptions RoundRobin
	
	;echo ${FunctionToRun}
	
	;enable LockSpotting if not enabled
	if ${Script[${RI_Var_String_CombatBotScriptName}](exists)} && ${RI_Obj_CB.GetUISetting[SettingsLockSpottingCheckBox].Equal[FALSE]}
	{
		RI_Obj_CB:SetUISetting[SettingsLockSpottingCheckBox,TRUE]
		LockSpottingWasOff:Set[TRUE]
	}
	;if we are not the main/////this is a bandaid for now, need to think of better way of doing this now that inside dll
	if ( ${FunctionToRun.Equal[RI_Var_Bool_GlobalOthers]} || !${Solo} ) && ( ${FunctionToRun.Equal[RI_Var_Bool_GlobalOthers]} || ${FunctionToRun.NotEqual[NONE]} ) && !${FunctionToRun.Find[QUEST-](exists)}
	{
		ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
		UIElement[Start@RI]:SetText[Pause]
		UIElement[AutoLoot@RI]:Hide
		UIElement[RI]:SetHeight[40]
		UIElement[RI]:SetWidth[102]
		;;UIElement[RI]:SetWidth[112]
		;;UIElement[Start@RI]:SetX[26]
		;one our relaygroup is set, transfer over our relaygroup string and close RelayGroup
		;while !${RG_Var_Bool_RelayGroupSet}
		;wait 20
		;RI_Var_String_RelayGroup:Set[${RG_Var_String_RelayGroup}]
		;endscript Buffer:RelayGroup
		
		;turn on start bool and set RI_Var_Bool_GlobalOthers to true
		RI_Var_Bool_Start:Set[TRUE]
		RI_Var_Bool_GlobalOthers:Set[TRUE]
		RI_Var_Bool_Loot:Set[FALSE]
		;run movement script
		RIMovement
		
		if ${FunctionToRun.NotEqual[NONE]} && ${FunctionToRun.NotEqual[RI_Var_Bool_GlobalOthers]}
		{
			if ${FunctionToRun.Upper.Find[NAMEDLIST](exists)}
			{
				echo Available Nameds: Vhankmin, Eghonz, Janosz, Vihgoh, Queshaun, Caelan'Gael, Lachina, Tabor'Zaai, Sorceress, Haze, Reaver, Tootooz, Googantuan, Enchanted, Baron
			}
			else
			{
				if ${FunctionToRun.Left[5].EqualCS[MAIN-]}
				{
					RI_Var_Bool_GlobalOthers:Set[FALSE]
					RIMUIObj:SetRIFollow[OFF]
					;RI_Atom_SetRIFollow OFF
					relay all -noredirect RG
					wait 20
					relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_RunInstances ${FunctionToRun.Right[-5].Left[1].Upper}${FunctionToRun.Right[-5].Right[-1].Lower}
					if ${FunctionToRun.Find[Tabor](exists)}
						call ${FunctionToRun.Right[-5].Left[1].Upper}${FunctionToRun.Right[-5].Right[-1]}
					call ${FunctionToRun.Right[-5].Left[1].Upper}${FunctionToRun.Right[-5].Right[-1].Lower}
				}
				else
					call ${FunctionToRun}
			}
			Script:End
		}
		;run looter script - Now Part of RI
		;RILooter
		
		;run ogreplaynice
		;OgrePlayNice
		
		;run RI_CoT
		RI_CoT
		echo ISXRI: Starting RI v${RI_Var_Float_Version.Precision[2]}
		while 1
		{
			call ExecuteQueued
			; if !${Consuming} && !${Developer}
			; {
				; if !${Me.Equipment[Food].AutoConsumeOn}
					; Me.Equipment[Food]:ToggleAutoConsume
				; if !${Me.Equipment[Drink].AutoConsumeOn}
					; Me.Equipment[Drink]:ToggleAutoConsume
				; if !${Me.Inventory[Elixir of Piety](exists)} && ${Me.Archetype.Equal[priest]} && ${Me.Inventory[Elixir of Piety].AutoConsumeOn}
					; Me.Inventory[Elixir of Piety]:ToggleAutoConsume
				; if !${Me.Inventory[Elixir of Deftness](exists)} && ${Me.Archetype.Equal[scout]} && ${Me.Inventory[Elixir of Deftness].AutoConsumeOn}
					; Me.Inventory[Elixir of Deftness]:ToggleAutoConsume
				; if !${Me.Inventory[Elixir of Intellect](exists)} && ${Me.Archetype.Equal[mage]} && ${Me.Inventory[Elixir of Intellect].AutoConsumeOn}
					; Me.Inventory[Elixir of Intellect]:ToggleAutoConsume
				; if !${Me.Inventory[Elixir of Fortitude](exists)} && !${RI_Var_Bool_GlobalOthers} && ${Me.Inventory[Elixir of Fortitude].AutoConsumeOn}
					; Me.Inventory[Elixir of Fortitude]:ToggleAutoConsume
				; Consuming:Set[TRUE]
			; }
				
			if ${Me.Archetype.Equal[priest]} && !${RecentlyCheckedGatherRemains}
			{
				call CheckGatherRemains
				RecentlyCheckedGatherRemains:Set[TRUE]
				TimedCommand 100 Script[${RI_Var_String_RunInstancesScriptName}].Variable[RecentlyCheckedGatherRemains]:Set[FALSE]
			}
			wait 2
		}
	}
	else
	{	
		ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
		UIElement[AutoLoot@RI]:SetChecked
		UIElement[RI]:SetHeight[60]
		UIElement[RI]:SetWidth[102]
		;;UIElement[RI]:SetWidth[112]
		;;UIElement[AutoLoot@RI]:SetX[20]
		;;UIElement[Start@RI]:SetX[26]
		echo ISXRI: Starting RI v${RI_Var_Float_Version.Precision[2]}
		if ${Developer}
			echo Developer Mode
		echo ${about}
		
		;set and join our relaygroup, and wait a few
		relay all -noredirect RG
		;while !${RG_Var_Bool_RelayGroupSet}
		wait 20
		;RI_Var_String_RelayGroup:Set[${RG_Var_String_RelayGroup}]
		;endscript Buffer:RelayGroup
		
		if ${FunctionToRun.Find[QUEST-](exists)}
		{
			;wait until we start
			RI_Var_Bool_QuestMode:Set[TRUE]
			UIElement[RI]:SetTitle[RQv${RI_Var_Float_Version.Precision[2]}]
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_RunInstances RI_Var_Bool_GlobalOthers
			while !${RI_Var_Bool_Start}
				wait 1
			call QuestM "${FunctionToRun.Right[-6]}"
			return
		}
		
		;invoke RI on all other in our relaygroup
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_RunInstances RI_Var_Bool_GlobalOthers
		
		;run movement script
		RIMovement
		;run looter script - NOW Part of RI
		;RILooter
		;run ogreplaynice
		;OgrePlayNice
		;run RI_AggroControl
		;RI_AggroControl
		RIMUIObj:SetRIFollow[OFF]
		;RI_Atom_SetRIFollow OFF
		wait 10
		if ${Started}
		{
			RI_Var_Bool_Start:Set[TRUE]
			UIElement[RunInstances].FindChild[RunInstances].FindChild[Main].FindChild[Start]:SetText[Pause]
		}
		
		;get the zoneset
		call PreGo
		if !${NoFile}
			echo ISXRI: ${Time} Done Importing ZoneFile from Extension, to Load from File type ImportZoneFile filename (omitting filename, will attempt to load WriteLocs default file for the zone)
		else
			ImportZoneFile
			
		do
		{
			;check for commands in que if so execute
			
			;check if Start has been triggered and Start script
			while !${RI_Var_Bool_Start}
			{
				wait 10
				call ExecuteQueued
			}
			;{
				;turn on food,drink and potion consumption
				; if !${Consuming} && !${Developer}
				; {
					; if !${Me.Equipment[Food].AutoConsumeOn}
						; Me.Equipment[Food]:ToggleAutoConsume
					; if !${Me.Equipment[Drink].AutoConsumeOn}
						; Me.Equipment[Drink]:ToggleAutoConsume
					; if !${Me.Inventory[Elixir of Piety](exists)} && ${Me.Archetype.Equal[priest]} && ${Me.Inventory[Elixir of Piety].AutoConsumeOn}
						; Me.Inventory[Elixir of Piety]:ToggleAutoConsume
					; if !${Me.Inventory[Elixir of Deftness](exists)} && ${Me.Archetype.Equal[scout]} && ${Me.Inventory[Elixir of Deftness].AutoConsumeOn}
						; Me.Inventory[Elixir of Deftness]:ToggleAutoConsume
					; if !${Me.Inventory[Elixir of Intellect](exists)} && ${Me.Archetype.Equal[mage]} && ${Me.Inventory[Elixir of Intellect].AutoConsumeOn}
						; Me.Inventory[Elixir of Intellect]:ToggleAutoConsume
					; if !${Me.Inventory[Elixir of Fortitude](exists)} && !${RI_Var_Bool_GlobalOthers} && ${Me.Inventory[Elixir of Fortitude].AutoConsumeOn}
						; Me.Inventory[Elixir of Fortitude]:ToggleAutoConsume
					; Consuming:Set[TRUE]
				; }
				;start script
				if ${RI_Var_Bool_Start}
					call Go
			;}
			;wait 1
		}
		while ${RI_Var_Bool_LoopZoneFile}
	}
}
atom(global) WhereWeAt()
{
	echo ISXRI: We are at ${MainArrayCounter} position in the index and it reads:
	echo ISXRI: ${istrMain.Get[${MainArrayCounter}]}
}
atom(global) RI_Atom_AutoLoot(bool TF)
{
	relay ${RI_Var_String_RelayGroup} RI_Var_Bool_Loot:Set[${TF}]
	RI_Var_Bool_AcceptLoot:Set[${TF}]
}
;atom triggered when a loot window is detected
atom EQ2_onLootWindowAppeared(string LootWindowID)
{
	if ${UIElement[SettingsAcceptLootCheckBox@SettingsFrame@CombatBotUI].Checked}
;	&& !${_RI_LootImmunity_}
	;&& ${CurrentLootWindowID.NotEqual[${LootWindowID}]}
	{
;		_RI_LootImmunity_:Set[TRUE]
;		TimedCommand 50 _RI_LootImmunity_:Set[FALSE]
;		TimedCommand 100 _RI_LootImmunity_:Set[FALSE]
		;CurrentLootWindowID:Set[${LootWindowID}]
		;LootWindow[${LootWindowID}]:LootAll
		LootWindow[${LootWindowID}]:RequestAll
	}
}
atom EQ2_onQuestOffered(string Name, string Description, int Level, int StatusReward)
{
	if ${RewardWindow.NumRewards}==1
		relay ${RI_Var_String_RelayGroup} RewardWindow:Receive
	relay ${RI_Var_String_RelayGroup} EQ2:AcceptPendingQuest
	TimedCommand 10 QuestJournalWindow.ActiveQuest[${Name}]:Share
}
;atom triggered when an announcement is detected
atom EQ2_onAnnouncement(string Message, string SoundType, float Timer)
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}:AnnounceText: ${Message}
	;if ${AnnounceText} exists in the announce, execute
	variable int _count
	for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	{
		;echo ${Time}:AnnounceText: checking ${AnnounceText.Get[${_count}]} in ${Message}
		if ${Message.Find[${AnnounceText.Get[${_count}]}](exists)}
		{
			;echo ${Time}:AnnounceText: Found ${AnnounceText.Get[${_count}]} in ${Message}
			Trigger:Set[TRUE]
			TriggerMessage:Set["${Message}"]
			if ${RI_Var_Bool_RemoveAfterTrigger}
				AnnounceText:Remove[${_count}]
		}
	}
	if ${RI_Var_Bool_RemoveAfterTrigger} && ${Trigger}
		AnnounceText:Collapse
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["You cannot see your target"](exists)} || ${Text.Find["Can't see target"](exists)}
	{
		if ${ICantSeeMyTargetCNT}<3
			ICantSeeMyTargetCNT:Inc
		else
		{
			ICantSeeMyTargetCNT:Set[0]
			ICantSeeMyTarget:Set[TRUE]
			TimedCommand 5 ICantSeeMyTarget:Set[FALSE]
			TimedCommand 5 ICantSeeMyTarget:Set[FALSE]
			TimedCommand 5 ICantSeeMyTarget:Set[FALSE]
		}
	}
	if ${RI_Var_Bool_Debug}
		echo ${Time}:IncomingText: ${Text}
	;if ${IncomingText} exists in the Incoming, execute
	variable int _count
	for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
	{
		;echo ${Time}:IncomingText: checking ${IncomingText.Get[${_count}]} in ${Text}
		if ${IncomingText2.Used}>=${_count}
		{
			if ${Text.Find[${IncomingText.Get[${_count}]}](exists)} && ${Text.Find[${IncomingText2.Get[${_count}]}](exists)}
			{
				;echo ${Time}:IncomingText: Found ${IncomingText.Get[${_count}]} in ${Text}
				Trigger:Set[TRUE]
				TriggerMessage:Set["${Text}"]
				if ${RI_Var_Bool_RemoveAfterTrigger}
					IncomingText:Remove[${_count}];IncomingText2:Remove[${_count}]
			}
		}
		else
		{
			if ${Text.Find[${IncomingText.Get[${_count}]}](exists)}
			{
				;echo ${Time}:IncomingText: Found ${IncomingText.Get[${_count}]} in ${Text}
				Trigger:Set[TRUE]
				TriggerMessage:Set["${Text}"]
				if ${RI_Var_Bool_RemoveAfterTrigger}
					IncomingText:Remove[${_count}]
			}
		}
	}	
	if ${RI_Var_Bool_RemoveAfterTrigger} && ${Trigger}
		IncomingText:Collapse;IncomingText2:Collapse
}
atom EQ2_ReplyDialogAppeared(string ID)
{
   	relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
}
atom EQ2_onRewardWindowAppeared()
{
	if ${EQ2.PendingQuestName.Equal[None]} && ${RewardWindow.NumRewards}<2
		relay ${RI_Var_String_RelayGroup} RewardWindow:Receive
	;relay ${RI_Var_String_RelayGroup} -noredirect 
}

function PreGo(string _EXTVar=~NONE~, bool _Verbose=TRUE)
{
;echo prego
	if ${_EXTVar.NotEqual[~NONE~]}
	{
		if ${_Verbose}
			echo ISXRI: ${Time} Importing ZoneFile from Extension
		istrMain:Clear
		for(MainArrayCounter:Set[0];${MainArrayCounter}<${${_EXTVar}[3rtZdjv7,#]};MainArrayCounter:Inc)
			istrMain:Insert[${${_EXTVar}[3rtZdjv7,${MainArrayCounter}]}]
		if ${_Verbose}
			echo ISXRI: ${Time} Done Importing ZoneFile from Extension, to Load from File type ImportZoneFile filename (omitting filename, will attempt to load WriteLocs default file for the zone)
		return
	}
	if ${_Verbose}
		echo ISXRI: ${Time} Importing ZoneFile from Extension
	istrMain:Clear
	switch ${Me.GetGameData[Self.ZoneName].Label}
	{
		case Brokenskull Bay: Bilgewater Falls [Solo]
		case Brokenskull Bay: Bilgewater Falls [Advanced Solo]
		case Brokenskull Bay: Bilgewater Falls [Heroic]
		{
			RI_CMD_Hidden_AddTLO Bilgewater
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Bilgewater]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Bilgewater[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Bilgewater[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Fabled Acadechism [Heroic]
		{
			RI_CMD_Hidden_AddTLO Acadechism
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Acadechism]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Acadechism[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Acadechism[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Brokenskull Bay: Hoist the Yellow Jack [Heroic]
		{
			RI_CMD_Hidden_AddTLO Hoist
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Hoist]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Hoist[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Hoist[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Brokenskull Bay: Bosun's Private Stock [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Bosun
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Bosun]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Bosun[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Bosun[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Zavith'loa: The Lost Caverns [Heroic]
		{
			RI_CMD_Hidden_AddTLO Caverns
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Caverns]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Caverns[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Caverns[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Zavith'loa: The Hidden Caldera [Heroic]
		case Zavith'loa: The Hidden Caldera [Solo]
		case Zavith'loa: The Hidden Caldera [Advanced Solo]
		{
			RI_CMD_Hidden_AddTLO Caldera
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Caldera]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Caldera[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Caldera[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Zavith'loa: The Hunt [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Hunt
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Hunt]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Hunt[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Hunt[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Castle Highhold [Solo]
		case Castle Highhold [Advanced Solo]
		case Castle Highhold [Heroic]
		{
			RI_CMD_Hidden_AddTLO Highhold
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Highhold]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Highhold[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Highhold[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Castle Highhold: Thresinet's Den [Heroic]
		{
			RI_CMD_Hidden_AddTLO Thresinets
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Thresinets]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Thresinets[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Thresinets[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Castle Highhold: Insider Treachery [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Treachery
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Treachery]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Treachery[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Treachery[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Ossuary: Resonance of Malice [Heroic]
		{
			RI_CMD_Hidden_AddTLO Resonance
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Resonance]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Resonance[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Resonance[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Ossuary: Sanguine Fountains [Heroic]
		{
			RI_CMD_Hidden_AddTLO Sanguine
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Sanguine]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Sanguine[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Sanguine[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Ssraeshza Temple [Heroic]
		{
			RI_CMD_Hidden_AddTLO Temple
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Temple]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Temple[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Temple[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Ssraeshza Temple: Inner Sanctum [Heroic]
		{
			RI_CMD_Hidden_AddTLO InnerSanctum
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[InnerSanctum]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${InnerSanctum[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${InnerSanctum[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Ssraeshza Temple: Taskmaster's ;echo [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Taskmaster
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Taskmaster]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Taskmaster[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Taskmaster[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Ossuary of Malevolence [Contested]
		{
			RI_CMD_Hidden_AddTLO OssCon
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[OssCon]
			if ${Developer}
			{
				for(MainArrayCounter:Set[0];${MainArrayCounter}<${OssCon[3rtZdjv7,#]};MainArrayCounter:Inc)
					istrMain:Insert[${OssCon[3rtZdjv7,${MainArrayCounter}]}]
			}
			else
			{
				MessageBox "This is not a supported zone, please contact Herculezz on Either forums or IRC and let him know the zone name: ${Me.GetGameData[Self.ZoneName].Label} to be added, Best to get and post a screenshot of this."
				Script:End
			}
			break
		}
		case F.S. Distillery: Stowaways [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Stowaways
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Stowaways]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Stowaways[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Stowaways[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case F.S. Distillery: Stowaways [Challenge]
		{
			RI_CMD_Hidden_AddTLO StowawaysHM
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[StowawaysHM]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${StowawaysHM[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${StowawaysHM[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case F.S. Distillery: Distill or Be Killed [Heroic]
		{
			RI_CMD_Hidden_AddTLO Distill
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Distill]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Distill[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Distill[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Fabled Crypt of Valdoon [Heroic]
		{
			RI_CMD_Hidden_AddTLO Valdoon
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Valdoon]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Valdoon[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Valdoon[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Fabled Court of Innovation [Heroic]
		{
			RI_CMD_Hidden_AddTLO Court
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Court]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Court[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Court[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Stygian Threshold [Heroic] 
		case Stygian Threshold [Agnostic]
		{
			RI_CMD_Hidden_AddTLO Stygian
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Stygian]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Stygian[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Stygian[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Maldura: Bar Brawl [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO BarBrawl
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[BarBrawl]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${BarBrawl[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${BarBrawl[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Maldura: District of Ash [Heroic]
		case Maldura: District of Ash [Agnostic]
		{
			RI_CMD_Hidden_AddTLO Ash
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Ash]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Ash[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Ash[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Maldura: Palace Foray [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Foray
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Foray]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Foray[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Foray[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Stygian Threshold: The Howling Gateway [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO Howling
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Howling]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Howling[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Howling[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Kralet Penumbra: Rise to Power [Heroic]
		{
			RI_CMD_Hidden_AddTLO RiseToPower
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[RiseToPower]
			ShinyScanDistance:Set[10]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${RiseToPower[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Revealed[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Kralet Penumbra: Temple of the Ill-Seen [Heroic]
		{
			RI_CMD_Hidden_AddTLO IllSeen
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[IllSeen]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${IllSeen[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${IllSeen[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Kaesora: Xalgozian Stronghold [Expert]
		case Kaesora: Xalgozian Stronghold [Heroic]
		case Kaesora: Xalgozian Stronghold [Solo]
		{
			RI_CMD_Hidden_AddTLO Xalgozian
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Xalgozian]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Xalgozian[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Xalgozian[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Arcanna'se Spire: Forgotten Sanctum [Solo]
		case Arcanna'se Spire: Forgotten Sanctum [Heroic]
		case Arcanna'se Spire: Forgotten Sanctum [Expert]
		{
			RI_CMD_Hidden_AddTLO Sanctum
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Sanctum]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Sanctum[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Sanctum[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Arcanna'se Spire: Revealed
		{
			RI_CMD_Hidden_AddTLO Revealed
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Revealed]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Revealed[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Revealed[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Arcanna'se Spire: Repository of Secrets [Solo]
		case Arcanna'se Spire: Repository of Secrets [Heroic]
		case Arcanna'se Spire: Repository of Secrets [Expert]
		{
			RI_CMD_Hidden_AddTLO Repository
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Repository]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Repository[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Repository[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Arcanna'se Spire: Vessel of the Sorceress [Advanced Solo]
		case Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]
		case Arcanna'se Spire: Vessel of the Sorceress [Expert Event]
		{
			RI_CMD_Hidden_AddTLO Vessel
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[Vessel]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${Vessel[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${Vessel[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Crypt of Dalnir: Baron's Workshop [Expert]
		case Crypt of Dalnir: Baron's Workshop [Heroic]
		case Crypt of Dalnir: Baron's Workshop [Solo]
		{
			RI_CMD_Hidden_AddTLO CryptofDalnirBaronsWorkshop
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[CryptofDalnirBaronsWorkshop]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${CryptofDalnirBaronsWorkshop[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${CryptofDalnirBaronsWorkshop[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Crypt of Dalnir: Ritual Chamber [Expert]
		case Crypt of Dalnir: Ritual Chamber [Heroic]
		case Crypt of Dalnir: Ritual Chamber [Solo]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Crypt of Dalnir: Wizard's Den [Advanced Solo]
		case Crypt of Dalnir: Wizard's Den [Event Heroic]
		case Crypt of Dalnir: Wizard's Den [Expert Event]
		{
			RI_CMD_Hidden_AddTLO WizardsDen
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[WizardsDen]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${WizardsDen[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${WizardsDen[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Ruins of Cabilis [Expert]
		case The Ruins of Cabilis [Heroic]
		case The Ruins of Cabilis [Solo]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Kaesora: Tomb of the Venerated [Expert Event]
		case Kaesora: Tomb of the Venerated [Event Heroic]
		case Kaesora: Tomb of the Venerated [Advanced Solo]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Lost City of Torsis: The Spectral Market [Expert]
		case Lost City of Torsis: The Spectral Market [Heroic]
		case Lost City of Torsis: The Spectral Market [Solo]
		{
			RI_CMD_Hidden_AddTLO LostCityofTorsisTheSpectralMarket
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[LostCityofTorsisTheSpectralMarket]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${LostCityofTorsisTheSpectralMarket[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${LostCityofTorsisTheSpectralMarket[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Lost City of Torsis: Reaver's Remnants [Expert Challenge]
		case Lost City of Torsis: Reaver's Remnants [Expert]
		case Lost City of Torsis: Reaver's Remnants [Challenge Heroic]
		case Lost City of Torsis: Reaver's Remnants [Heroic]
		case Lost City of Torsis: Reaver's Remnants [Solo]
		{
			RI_CMD_Hidden_AddTLO LostCityofTorsisReaversRemnants
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[LostCityofTorsisReaversRemnants]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${LostCityofTorsisReaversRemnants[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${LostCityofTorsisReaversRemnants[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Lost City of Torsis: The Shrouded Temple [Advanced Solo]
		case Lost City of Torsis: The Shrouded Temple [Expert Event]
		case Lost City of Torsis: The Shrouded Temple [Event Heroic]
		{
			RI_CMD_Hidden_AddTLO ShroudedTemple
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[ShroudedTemple]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${ShroudedTemple[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${ShroudedTemple[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Befallen: Cavern of the Afflicted [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Charasis: Maiden's Chamber [Agnostic]
		{
			RI_CMD_Hidden_AddTLO CharasisMaidensChamberAgnostic
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[CharasisMaidensChamberAgnostic]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${CharasisMaidensChamberAgnostic[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${CharasisMaidensChamberAgnostic[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case Crypt of Valdoon [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Iceshard Keep [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Kralet Penumbra: Tepid Depths [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Kralet Penumbra: The Master's Chosen [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Library of Erudin [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Maldura: Algorithm For Destruction [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Temple of the Faceless [Agnostic]
		{ 
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case The Crypt of Agony [Agnostic]
		{
			RI_CMD_Hidden_AddTLO CoA
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[CoA]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${CoA[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${CoA[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Deep Forge [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case The Ruins of Guk: Halls of the Fallen [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Vasty Deep: The Conservatory [Agnostic]
		{
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
		case Vaedenmoor, Realm of Despair
		{
			RI_CMD_Hidden_AddTLO VaedenmoorRealmofDespair
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[VaedenmoorRealmofDespair]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${VaedenmoorRealmofDespair[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${VaedenmoorRealmofDespair[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Frillik Tide
		{
			RI_CMD_Hidden_AddTLO TheFrillikTide
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[TheFrillikTide]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${TheFrillikTide[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${TheFrillikTide[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		case The Underdepths [Proving Ground]
		{
			RI_CMD_Hidden_AddTLO TheUnderdepthsProvingGround
			LoadedTLO:Set[TRUE]
			LoadedTLOName:Set[TheUnderdepthsProvingGround]
			for(MainArrayCounter:Set[0];${MainArrayCounter}<${TheUnderdepthsProvingGround[3rtZdjv7,#]};MainArrayCounter:Inc)
				istrMain:Insert[${TheUnderdepthsProvingGround[3rtZdjv7,${MainArrayCounter}]}]
			break
		}
		default
		{
		;need to put in here for default loading of zones with names stripping [Heroic] [Event Heroic] [Solo] [Advanced Solo] [Agnostic] [Expert] etc
			;MessageBox "This is not a supported zone, please contact Herculezz on Either forums or IRC and let him know the zone name: ${Me.GetGameData[Self.ZoneName].Label} to be added, Best to get and post a screenshot of this."
			;Script:End
			echo ISXRI: ${Time} There is no ZoneFile in the Extension for ${Me.GetGameData[Self.ZoneName].Label}, Attempting to import default ZoneFile, or you can type ImportZoneFile filename to import a file (omitting filename, will attempt to load WriteLocs default file for the zone)
			NoFile:Set[TRUE]
			break
		}
	}
}
atom(global) ImportZoneFile(string ZoneFileName="${Me.GetGameData[Self.ZoneName].Label.Replace[" ",""].Replace["'",""].Replace[":",""].Replace["[",,""].Replace["]",""].Replace[",",""]}", bool _Verbose=TRUE)
{
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"
	;check if ZineFileName exists, if not end
	if !${FP.FileExists[${ZoneFileName}.dat]}
	{
		echo ISXRI: ${Time} Missing ZoneFile: "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}.dat"
		if ${RI_Var_Bool_QuestMode}
			Script:End
		else
			return
	}
	else
	{
		if ${_Verbose}
			echo ISXRI: ${Time} Loading ZoneFile: "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}.dat"
	}
	
	variable file Filename
	variable int Count
	
	variable string TempString
	istrMain:Clear
	Count:Set[1]
	;set file to read in to Filename variable
	Filename:SetFilename["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}.dat"]

	;open the file
	Filename:Open
	
	;seek to the beginning of file
	Filename:Seek[0]
	
	;while we are not at the end of file
	while !${Filename.EOF}
	{
		;store each line of the file in var
		TempString:Set[${Filename.Read}]
		if ${TempString.Equal[NULL]}
			continue
		istrMain:Insert[${TempString.Left[-1]}]
		;echo Adding ${istrMain.Get[${Count}]} to istrMain Variable in Element ${Count} : Length ${istrMain.Get[${Count}].Length}
		Count:Inc
		;waitframe
	}
	
	;close file
	Filename:Close
	if ${_Verbose}
		echo ISXRI: ${Time} Done Loading ZoneFile
}
function CheckImReady()
{
	while ${EQ2.Zoning}!=0
	{
		IJustZonedLessThan10SecondsAgo:Set[TRUE]
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Waiting while zoning
		wait 10
	}
	if ${IJustZonedLessThan10SecondsAgo}
		TimedCommand 100 IJustZonedLessThan10SecondsAgo:Set[FALSE]
	while ${Me.IsCamping}
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Waiting while camping
		wait 10
	}
	while !${Me.InGameWorld} && ${EQ2.Zoning}==0
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Waiting while not in game world
		wait 10
	}
	while ${Zone.Name.Equal[LoginScene]}
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Waiting while at LoginScene
		wait 10
	}
	while ${Me.IsDead}
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Waiting while dead
		wait 10 !${Me.IsDead}
	}
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${MyZone}"]} && !${RI_Var_Bool_QuestMode} && !${InstanceMode}
	{
		echo ISXRI: ${Time} We are no longer in ${MyZone}, exiting RunInstances
		Script:End
	}
}
function Go(bool _Quest=FALSE)
{
	;make sure we are not dead or zoning or in the incorrect zone
	call CheckImReady

	;start group follow
	call RIMObj.follow
	
	;find closestwaypoint to our current location that we have LOS to
	;call FindClosestWaypoint
	
	;read istrMain until the end -1 (no need to check last waypoint) or start has been pressed
	if !${_Quest}
	{
		echo ISXRI: ${Time} Reading ZoneFile to find closest waypoint
		for(MainArrayCounter:Set[1];${MainArrayCounter}<${Math.Calc[${istrMain.Used}-1]};MainArrayCounter:Inc)
			call FindClosestWaypoint "${istrMain.Get[${MainArrayCounter}]}"
		echo ISXRI: ${Time} Done Reading ZoneFile
		MainArrayCounter:Set[1]
	}
	else
	{
		if ${istrMain.Get[2].Equal[Repeatable]}
			MainArrayCounter:Set[3]
		else
			MainArrayCounter:Set[2]
		wait 50
	}
	for(;${MainArrayCounter}<=${istrMain.Used};MainArrayCounter:Inc)
	{
		;make sure we are not dead or zoning or in the incorrect zone
		call CheckImReady
		
		if ${ArrayPosition}!=0
		{
			MainArrayCounter:Set[${Math.Calc[${ArrayPosition}-1]}]
			ArrayPosition:Set[0]
			continue
		}
		;read a line from Array
		LineRead:Set[${istrMain.Get[${MainArrayCounter}]}]
				
		if ${RI_Var_Bool_Debug}
		{
			echo ${Time}: Inside ArrayRead For Loop
			echo ${Time}: "${MainArrayCounter}: ${LineRead}//${LineRead.Length}"
		}
		if ${LineRead.Left[17].Equal[DontStopForCombat]}
			DontStopForCombat:Set[TRUE]
		elseif ${LineRead.Left[13].Equal[StopForCombat]}
			DontStopForCombat:Set[FALSE]
		elseif ${LineRead.Left[6].Equal[Custom]}
		{
			MainArrayCounter:Inc
			CustomFunction:Set[${istrMain.Get[${MainArrayCounter}]}]
			MainArrayCounter:Inc
			CustomLoc:Set[${istrMain.Get[${MainArrayCounter}]}]
			call CustomFunction
		}
		;elseif LineRead equals wait, set waitfunction variables and call WaitFunction
		elseif ${LineRead.Left[4].Equal[Wait]}
		{
			MainArrayCounter:Inc
			WaitTime:Set[${istrMain.Get[${MainArrayCounter}]}]
			MainArrayCounter:Inc
			WaitLoc:Set[${istrMain.Get[${MainArrayCounter}]}]
			call WaitFunction
		}
		elseif ${LineRead.Left[10].Equal[ClickActor]}
		{
			MainArrayCounter:Inc
			ClickActorName:Set[${istrMain.Get[${MainArrayCounter}]}]
			MainArrayCounter:Inc
			ClickActorLoc:Set[${istrMain.Get[${MainArrayCounter}]}]
			call ClickActorFunction
		}
		elseif ${LineRead.Left[9].Equal[HailActor]}
		{
			MainArrayCounter:Inc
			HailActorName:Set[${istrMain.Get[${MainArrayCounter}]}]
			MainArrayCounter:Inc
			HailActorLoc:Set[${istrMain.Get[${MainArrayCounter}]}]
			call HailActorFunction
		}
		elseif ${LineRead.Left[5].Equal[Named]}
		{
			MainArrayCounter:Inc
			NamedName:Set[${istrMain.Get[${MainArrayCounter}]}]
			MainArrayCounter:Inc
			if ${istrMain.Get[${MainArrayCounter}].Left[13].Equal[StandardNamed]}
			{
				StandardNamed:Set[TRUE]
				CustomNamed:Set[FALSE]
				MainArrayCounter:Inc
				if ${istrMain.Get[${MainArrayCounter}].Left[8].Equal[SameLock]}
					LOD:Set[FALSE]
				else
				{
					LOD:Set[TRUE]
					MainArrayCounter:Inc
					LODXYZ:Set[${istrMain.Get[${MainArrayCounter}]}]
				}
				MainArrayCounter:Inc
				if ${istrMain.Get[${MainArrayCounter}].Left[7].Equal[KillAdd]}
				{
					KillAdd:Set[TRUE]
					MainArrayCounter:Inc
					AddName:Set[${istrMain.Get[${MainArrayCounter}]}]
				}
				else
					KillAdd:Set[FALSE]
				MainArrayCounter:Inc
				if ${istrMain.Get[${MainArrayCounter}].Left[10].Equal[MoveBehind]}
					MoveBehind:Set[TRUE]
				else
					MoveBehind:Set[FALSE]
			}
			else
			{
				StandardNamed:Set[FALSE]
				CustomNamed:Set[TRUE]
			}
			MainArrayCounter:Inc
			NamedLoc:Set[${istrMain.Get[${MainArrayCounter}]}]
			call NamedFunction
		}
		else
			call EndForFunction
		wait 1
	}
	wait 5
}
atom(global) displayindex()
{
	variable int counter
	for(counter:Set[1];${counter}<=${istrMain.Used};counter:Inc)
	{
		echo ${counter}: ${istrMain.Get[${counter}]}
	}
}
function CustomFunction(string arg1="", string arg2="", string arg3="", string arg4="", string arg5="")
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Calling custom function ${CustomFunction}
	;move to custom location
	if ${DontStopForCombat}
		call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE FALSE TRUE FALSE TRUE
	else
		call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
	call ${CustomFunction} ${arg1} ${arg2} ${arg3} ${arg4} ${arg5}
	wait 5
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
}
function FlyDown(bool _AllToons=TRUE)
{
	wait 5
	call RIMObj.FlyDown ${_AllToons}
}
;WaitFunction
function WaitFunction()
{
	;move to custom location
	if ${DontStopForCombat}
		call RIMObj.Move ${WaitLoc} ${Precision} 0 TRUE FALSE TRUE FALSE TRUE
	else
		call RIMObj.Move ${WaitLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Wait ${WaitTime}
	wait ${WaitTime}
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
}
atom(global) RI_Atom_RIXMLClose()
{
	Script:End
}
;ClickActorFunction
function ClickActorFunction()
{
	if ${Script[Buffer:CoT]}
		endscript Buffer:CoT
	
	RI_Var_Bool_Follow:Set[FALSE]
	relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.Move ${ClickActorLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE"]
	call RIMObj.Move ${ClickActorLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
	wait 20
	;stop follow
	call RIMObj.stopfollow
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
	;echo Clicking: ${ClickActorName}
	variable int _ID=${Actor[Query, Name=-"${ClickActorName}"].ID}
	wait 5
	relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
	wait 5
	relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
	wait 5
	relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
	wait 20
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
	;cancel others movement if they are still trying to move
	;to avoid ping ponging
	relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Var_Bool_CancelMovement:Set[TRUE]
	;follow
	RI_Var_Bool_Follow:Set[TRUE]
	call RIMObj.follow
	wait 5
	relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Var_Bool_CancelMovement:Set[FALSE]
	wait 5
	if !${Script[Buffer:CoT]}
		RI_CoT
}

;HailActorFunction
function HailActorFunction()
{
	;move to HailActor location
	;stop follow
	
	;echo Moving to ${HailActorLoc} and Clicking ${HailActorName}
	relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.Move ${HailActorLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE"]
	call RIMObj.Move ${HailActorLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
	wait 20
	call RIMObj.stopfollow
	;make sure HailActorName exists so we do not go through the motions for nothign
	if ${Actor[${HailActorName},radius,20](exists)}
	{
		;wait until we are out of combat
		if !${DontStopForCombat}
			call RIMObj.CheckCombat
		;wait 10
		;pause bots
		relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
		;wait 5
		relay ${RI_Var_String_RelayGroup} -noredirect Actor[${HailActorName}]:DoFace
		;wait 2
		relay ${RI_Var_String_RelayGroup} -noredirect Actor[${HailActorName}]:DoTarget
		wait 2
		relay ${RI_Var_String_RelayGroup} -noredirect eq2execute hail
		wait 2
		if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)}
			relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		;unpause bots
		relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	}
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
	;follow
	call RIMObj.follow
}

;NamedFunction
function NamedFunction()
{
	;move to Named location
	if ${DontStopForCombat}
		call RIMObj.Move ${NamedLoc} ${Precision} 0 TRUE FALSE TRUE FALSE TRUE
	else
		call RIMObj.Move ${NamedLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
	wait 10
	if ${StandardNamed}
	{
		;echo call Named ${NamedName} TRUE ${NamedLoc} ${LOD} ${LODXYZ} ${MoveBehind} FALSE 0 ${KillAdd} ${AddName}
		call Named ${NamedName} TRUE ${NamedLoc} ${LOD} ${LODXYZ} ${MoveBehind} FALSE 0 ${KillAdd} ${AddName}
	}
	elseif ${CustomNamed}
		call Named ${NamedName} FALSE 0 0 0 FALSE 0 0 0 FALSE TRUE ${NamedName} FALSE 0
}


;object RunInstancesObject
objectdef RunInstancesObject
{
	method SetShinyScanDistance(int _Distance)
	{
		ShinyScanDistance:Set[${_Distance}]
	}
	method BreakPathFunction()
	{
		RI_Var_Bool_BreakPathFunction:Set[1]
	}
	variable index:string ZoneList
	method GetZoneLists()
	{
		if !${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
			return
		variable index:collection:string _Zones
		variable iterator _ZonesIterator

		EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:GetOptions[_Zones]

		ZoneList:Clear
		
		_Zones:GetIterator[_ZonesIterator]
		if ${_ZonesIterator:First(exists)}
		{
			do
			{
				ZoneList:Insert["${_ZonesIterator.Value.Element[text]}"]
			}
			while ${_ZonesIterator:Next(exists)}
		}
	}
	member(int) RowByName(string _ZoneName)
	{
		variable iterator _ZonesIterator
		ZoneList:GetIterator[_ZonesIterator]
		if ${_ZonesIterator:First(exists)}
		{
			do
			{
				if ${_ZonesIterator.Value.Upper.Find["${_ZoneName.Upper}"](exists)}
					return ${_ZonesIterator.Key}
			}
			while ${_ZonesIterator:Next(exists)}
		}
		return 0
	}
	member:bool MainIconIDExists(int _ActorID, int _MainIconID, bool _Det=TRUE)
	{
		variable int Counter=1
		variable int NumActorEffects
		if ${_ActorID}==${Me.ID}
		{
			if ${_Det}
				NumActorEffects:Set[${Me.CountEffects[detrimental]}]
			else
				NumActorEffects:Set[${Me.CountEffects}]
				
			if (${NumActorEffects} > 0)
			{
				do
				{
					if ${_Det}
					{
						if ${Me.Effect[detrimental,${Counter}].MainIconID}==${_MainIconID}
						{
							return TRUE
						}
					}
					else
					{
						if ${Me.Effect[${Counter}].MainIconID}==${_MainIconID}
						{
							return TRUE
						}
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				return FALSE
			}
			else
				return FALSE
		}
		elseif (${Actor[id,${_ActorID}](exists)})
		{
			NumActorEffects:Set[${Actor[id,${_ActorID}].NumEffects}]
			
			if (${NumActorEffects} > 0)
			{
				do
				{
					if ${Actor[id,${_ActorID}].Effect[${Counter}].MainIconID}==${_MainIconID}
					{
						return TRUE
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				return FALSE
			}
			else
				return FALSE
		}
		else
			return FALSE
	}
	method BalanceMobs(string MobName=ALL)
	{
		if !${RI_Var_Bool_BalanceTrash}
			return
		variable index:actor ActorIndex
		variable iterator ActorIterator
		variable int BalanceMobWithHighestHealth=0
		variable int ScriptTargetTime=0
		
		;QueryActors to our ActorIndex that are NPC or NamedNPC and within distance 20 and InCombatMode and NotDead
		
		if ${MobName.Equal[ALL]}	
			EQ2:QueryActors[ActorIndex,( Type =="NPC" || Type =="NamedNPC" ) && InCombatMode = TRUE && IsDead = FALSE && Distance <= 20]
		else
			EQ2:QueryActors[ActorIndex,( Type =="NPC" || Type =="NamedNPC" ) && Name=-"${MobName}" && InCombatMode = TRUE && IsDead = FALSE && Distance <= 20]
			
		ActorIndex:GetIterator[ActorIterator]
		
		
		if ${ActorIterator:First(exists)}
		{
			do
			{
				;if the actor's health is higher than BalanceMobWithHighestHealth
				;set them to BalanceMobWithHighestHealth
				if ${ActorIterator.Value.Health}>${Math.Calc[${Actor[${BalanceMobWithHighestHealth}].Health}+2]}
					BalanceMobWithHighestHealth:Set[${ActorIterator.Value.ID}]
			}
			while ${ActorIterator:Next(exists)}
			;if i am not targeting BalanceMobWithHighestHealth and it is not 0 and exists
			;target BalanceMobWithHighestHealth
			if ${Target.ID}!=${BalanceMobWithHighestHealth} && ${BalanceMobWithHighestHealth}!=0 && ${Actor[${BalanceMobWithHighestHealth}](exists)} && !${Actor[${BalanceMobWithHighestHealth}].IsDead} && ${Script.RunningTime}>${Math.Calc[${ScriptTargetTime}+1000]}
			{
				;echo ${Time}: Targeting ${BalanceMobWithHighestHealth} / ${Actor[${BalanceMobWithHighestHealth}]} Health: ${Actor[${BalanceMobWithHighestHealth}].Health}
				Actor[${BalanceMobWithHighestHealth}]:DoTarget
				ScriptTargetTime:Set[${Script.RunningTime}]
			}
		}
	}
	member(bool) QuestStepExists(string _QuestStep)
	{
		variable index:collection:string Details    
		variable iterator DetailsIterator
		variable int DetailsCounter = 0
		variable bool _FoundIt = FALSE
	;    echo "Journal Current Quest:"
	;    echo "- Name: ${QuestJournalWindow.CurrentQuest.Name.GetProperty["LocalText"]}"
	;    echo "- Level: ${QuestJournalWindow.CurrentQuest.Level.GetProperty["LocalText"]}"
	;    echo "- Category: ${QuestJournalWindow.CurrentQuest.Category.GetProperty["LocalText"]}"
	;    echo "- CurrentZone: ${QuestJournalWindow.CurrentQuest.CurrentZone.GetProperty["LocalText"]}"
	;    echo "- TimeStamp: ${QuestJournalWindow.CurrentQuest.TimeStamp.GetProperty["LocalText"]}"
	;    echo "- MissionGroup: ${QuestJournalWindow.CurrentQuest.MissionGroup.GetProperty["LocalText"]}"
	;    echo "- Status: ${QuestJournalWindow.CurrentQuest.Status.GetProperty["LocalText"]}"
	;    echo "- ExpirationTime: ${QuestJournalWindow.CurrentQuest.ExpirationTime.GetProperty["LocalText"]}"
	;    echo "- Body: ${QuestJournalWindow.CurrentQuest.Body.GetProperty["LocalText"]}"
		
		QuestJournalWindow.CurrentQuest:GetDetails[Details]
		Details:GetIterator[DetailsIterator]
	;    echo "- Details:"
		if (${DetailsIterator:First(exists)})
		{
			do
			{
				if (${DetailsIterator.Value.FirstKey(exists)})
				{
					do
					{
						; echo "-- ${DetailsCounter}::  '${DetailsIterator.Value.CurrentKey}' => '${DetailsIterator.Value.CurrentValue}'"
						;echo \${DetailsIterator.Value.CurrentValue.Find[${_QuestStep}](exists)} // ${DetailsIterator.Value.CurrentValue}
						if ${DetailsIterator.Value.CurrentKey.Equal[Text]} && ${DetailsIterator.Value.CurrentValue.Find[${_QuestStep}](exists)}
							_FoundIt:Set[TRUE]
					}
					while ${DetailsIterator.Value.NextKey(exists)}
					; echo "------"
				}
				DetailsCounter:Inc
			}
			while ${DetailsIterator:Next(exists)}
		}
		if ${_FoundIt}
			return TRUE
		else
			return FALSE
	}
	
	member(bool) QuestExists(string _QuestName)
	{
		variable index:quest Quests
		variable iterator QuestsIterator
		
		QuestJournalWindow:GetActiveQuests[Quests]
		Quests:GetIterator[QuestsIterator]
	  
		if ${QuestsIterator:First(exists)}
		{
			do
			{
				;echo ${QuestsIterator.Value.Name}==${_QuestName} :: ${QuestsIterator.Value.Name.Equal[${_QuestName}]}
				if ${QuestsIterator.Value.Name.Equal["${_QuestName}"]}
				{
					return TRUE
				}
			}
			while ${QuestsIterator:Next(exists)}
		}
		return FALSE
	}
	member(bool) CompletedQuestExists(string _QuestName)
	{
		variable index:quest Quests
		variable iterator QuestsIterator
		
		QuestJournalWindow:GetCompletedQuests[Quests]
		Quests:GetIterator[QuestsIterator]
	  
		if ${QuestsIterator:First(exists)}
		{
			do
			{
				;echo ${QuestsIterator.Value.Name}==${_QuestName} :: ${QuestsIterator.Value.Name.Equal[${_QuestName}]}
				if ${QuestsIterator.Value.Name.Equal["${_QuestName}"]}
				{
					return TRUE
				}
			}
			while ${QuestsIterator:Next(exists)}
		}
		return FALSE
	}
	method EndScript()
	{
		Script:End
	}
}

;EndForFunction
function EndForFunction()
{
	if ${LineRead.Equal[DontStopForCombat]}
		DontStopForCombat:Set[TRUE]
	elseif ${LineRead.Equal[StopForCombat]}
		DontStopForCombat:Set[FALSE]
	elseif ${LineRead.NotEqual[Custom]} && ${LineRead.NotEqual[Wait]} && ${LineRead.NotEqual[ClickActor]} && ${LineRead.NotEqual[HailActor]} && ${LineRead.NotEqual[Named]} && ${LineRead.NotEqual[DontStopForCombat]} && ${LineRead.NotEqual[StopForCombat]} && ${LineRead.NotEqual[StartQuest]} && ${LineRead.NotEqual[StopQuest]} && ${LineRead.NotEqual[NULL]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Move ${LineRead}
		if ${DontStopForCombat}
			call RIMObj.Move ${LineRead} ${Precision} 0 TRUE FALSE FALSE TRUE TRUE
		else
			call RIMObj.Move ${LineRead} ${Precision} 0 TRUE TRUE FALSE TRUE TRUE
	}
	wait 1
}

;CheckGatherRemains function
function CheckGatherRemains()
{
	;Gather Remains ID=2607033953
	if !${Me.InCombat}
	{
		if (${Me.Group[1].IsDead} || ${Me.Group[2].IsDead} || ${Me.Group[3].IsDead} || ${Me.Group[4].IsDead} || ${Me.Group[5].IsDead})
		{
			if (${Me.Group[1].Distance}>30 || ${Me.Group[2].Distance}>30 || ${Me.Group[3].Distance}>30 || ${Me.Group[4].Distance}>30 || ${Me.Group[5].Distance}>30 )
			{
				if ${Me.Ability[id,2607033953].IsReady}
					Me.Ability[id,2607033953]:Use
			}
		}
	}
}


function FindClosestWaypoint(string InputArrayElement)
{
	
	TempArrayPosition:Set[${MainArrayCounter}]
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Checking Array at ${TempArrayPosition} Element: ${InputArrayElement}

	if ${InputArrayElement.Equal[Custom]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Equal[Wait]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Equal[ClickActor]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Equal[HailActor]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Equal[Named]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Equal[DiffLock]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Equal[KillAdd]}
		MainArrayCounter:Inc
	elseif ${InputArrayElement.Length}<10
		MainArrayCounter:Inc
	;found waypoint on line call waypointchecker
	elseif ${InputArrayElement.NotEqual[Custom]} && ${InputArrayElement.NotEqual[Wait]} && ${InputArrayElement.NotEqual[ClickActor]} && ${InputArrayElement.NotEqual[HailActor]} && ${InputArrayElement.NotEqual[Named]} && ${InputArrayElement.NotEqual[CustomNamed]} && ${InputArrayElement.NotEqual[StandardNamed]} && ${InputArrayElement.NotEqual[SameLock]} && ${InputArrayElement.NotEqual[DontMoveBehind]} && ${InputArrayElement.NotEqual[MoveBehind]} && ${InputArrayElement.NotEqual[StopForCombat]} && ${InputArrayElement.NotEqual[DontStopForCombat]} && ${InputArrayElement.NotEqual[DontKillAdd]}
		call WaypointChecker ${InputArrayElement}
}
function WaypointChecker(float WX, float WY, float WZ)
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}: TempArrayPosition is ${TempArrayPosition} and ArrayPosition is: ${ArrayPosition} ClosestWaypointDistance is ${ClosestWaypointDistance} and ClosestWaypoint is ${ClosestWaypoint}, Checking Waypoint ${WX} ${WY} ${WZ}
	;set vars if we are at begining of file
	if ${TempArrayPosition}==1
	{
		ArrayPosition:Set[${TempArrayPosition}]
		ClosestWaypointDistance:Set[${Math.Distance[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]}]
		ClosestWaypoint:Set[${WX} ${WY} ${WZ}]
	}
	;compare waypoint with current position and store them in variables if they are closer
	if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]}<${ClosestWaypointDistance} && !${Me.CheckCollision[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: We found a closter waypoint at ${TempArrayPosition}, position in the array it is ${ClosestWaypoint} at a distance of ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]} and our collision is ${Me.CheckCollision[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]}
		ArrayPosition:Set[${TempArrayPosition}]
		ClosestWaypointDistance:Set[${Math.Distance[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]}]
		ClosestWaypoint:Set[${ClosestWaypoint}]
		FoundCloserWaypoint:Set[TRUE]
	}
	;else
	;	echo the waypoint is ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${WX},${WY},${WZ}]} away and is smaller than ${ClosestWaypointDistance}
}
function Named(string Name, bool Lock, float LockMXN, float LockMYN, float LockMZN, bool LockOthersDiff, float LockOXN, float LockOYN, float LockOZN, bool NMoveBehind, bool RunSpecificFunction, string NameofSpecificFunction, bool NKillAdd, string NAddName)
{
	;echo Named(string Name=${Name}, bool Lock=${Lock}, float LockMXN=${LockMXN}, float LockMYN=${LockMYN}, float LockMZN=${LockMZN}, bool LockOthersDiff=${LockOthersDiff}, float LockOXN=${LockOXN}, float LockOYN=${LockOYN}, float LockOZN=${LockOZN}, bool NMoveBehind=${NMoveBehind}, bool RunSpecificFunction=${RunSpecificFunction}, string NameofSpecificFunction=${NameofSpecificFunction}, bool NKillAdd=${NKillAdd}, string NAddName=${NAddName})
	if ${Actor[NamedNPC,${Name}](exists)}
		NameID:Set[${Actor[NamedNPC,${Name}].ID}]
	else
		NameID:Set[${Actor[${Name}].ID}]
	wait 5
	if ${NameID} == 0
	{
		wait 5 
		if ${Actor[NamedNPC,${Name}](exists)}
			NameID:Set[${Actor[NamedNPC,${Name}].ID}]
		else
			NameID:Set[${Actor[${Name}].ID}]
		wait 5
	}
	if ${NameID} == 0
	{
		wait 5
		if ${Actor[NamedNPC,${Name}](exists)}
			NameID:Set[${Actor[NamedNPC,${Name}].ID}]
		else
			NameID:Set[${Actor[${Name}].ID}]
		wait 5
	}
	if ${NameID} == 0
	{
		wait 5
		if ${Actor[NamedNPC,${Name}](exists)}
			NameID:Set[${Actor[NamedNPC,${Name}].ID}]
		else
			NameID:Set[${Actor[${Name}].ID}]
		wait 5
	}
	variable int TargetID
	wait 5
	if ${NameID} == 0
	{
		wait 5
		if ${Actor[${Name}].Type.Equal[NoKill NPC]}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Named: ${Name} is NoKill NPC, Moving on
			return
		}
		NameID:Set[${Actor[${Name}].ID}]
		wait 5
		if ${NameID} == 0 && !${Actor[${Name}](exists)}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Named: ${Name} Does Not Exist
			return
		}
		else
		{
			while ${NameID} == 0
			{
				NameID:Set[${Actor[${Name}].ID}]
				wait 5
			}
		}
	}
	if ${Actor[id,${NameID}](exists)} && !${Actor[id,${NameID}].IsDead}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: We are at ${Name}, waiting for ${Name} to die!
		if ${Script[Buffer:CoT]}
			endscript Buffer:CoT
		;Script[Buffer:AggroControl].Variable[TrashTargeting]:Set[FALSE]
		call RIMObj.stopfollow
		RI_Var_Bool_Follow:Set[FALSE]
		if !${RunSpecificFunction} && ${NMoveBehind}
		{
			;target named
			if !${RI_Var_Bool_GlobalOthers}
				Actor[id,${NameID}]:DoTarget
				
			;lockspot to ${LockMXN} ${LockMYN} ${LockMZN}
			RIMUIObj:SetLockSpot[ALL,${LockMXN},${LockMYN},${LockMZN},${Precision},${LockSpotMax}]
			;RI_Atom_SetLockSpot ${Me.Name} ${LockMXN} ${LockMYN} ${LockMZN} ${Precision} ${LockSpotMax}
			
			;wait until we are at lockspot
			wait 50 ${Math.Distance[${Me.Loc},${LockMXN},${LockMYN},${LockMZN}}]}<${Precision}
			
			;wait until named is within 10m
			wait 50 ${Math.Distance[${Me.Loc},${Actor[id,${NameID}].Loc}]}<11
			
			;move others behind named
			;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${NameID} 15 99 ${Me.Name}
			relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call MoveBehind 1"]
		}
		if ${LockOthersDiff} && !${RunSpecificFunction} && !${NMoveBehind}
		{
			;echo relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetLockSpot[ALL,${LockOXN},${LockOYN},${LockOZN},${Precision},${LockSpotMax}]
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetLockSpot[ALL,${LockOXN},${LockOYN},${LockOZN},${Precision},${LockSpotMax}]
			;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetLockSpot ALL ${LockOXN} ${LockOYN} ${LockOZN} ${Precision} ${LockSpotMax}
			RIMUIObj:SetLockSpot[ALL,${LockMXN},${LockMYN},${LockMZN},${Precision},${LockSpotMax}]
			;RI_Atom_SetLockSpot ${Me.Name} ${LockMXN} ${LockMYN} ${LockMZN} ${Precision} ${LockSpotMax}
		}
		elseif !${RunSpecificFunction} && !${NMoveBehind}
			relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[ALL,${LockMXN},${LockMYN},${LockMZN},${Precision},${LockSpotMax}]
			;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ALL ${LockMXN} ${LockMYN} ${LockMZN} ${Precision} ${LockSpotMax}
		while ${Actor[id,${NameID}](exists)} && !${Actor[id,${NameID}].IsDead} && ${RI_Var_Bool_Start}
		{
			;check if we are paused
			call RIMObj.CheckPause
			;echo Named ${Name} exists we are killing
			if ${RunSpecificFunction}
			{	
				relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call ${NameofSpecificFunction}"]
				call ${NameofSpecificFunction}
			}
			if !${RunSpecificFunction}
			{
				;if ${NKillAdd} && ${Actor[${NAddName},radius,35](exists)} && ${Actor[${NAddName},radius,35].IsAggro} && !${Actor[${NAddName},radius,35].IsDead} && !${RI_Var_Bool_GlobalOthers}
				if ${NKillAdd} && ${Actor[Query, Name =- "${NAddName}" && Distance <= 35 && IsDead = FALSE && IsAggro = TRUE](exists)} && !${RI_Var_Bool_GlobalOthers}
				{
					
					;balance mobs, if set or just target
					if ${RI_Var_Bool_BalanceTrash}
						RIObj:BalanceMobs["${NAddName}"]
					else
						Actor[Query, Name =- "${NAddName}"]:DoTarget
				}
				elseif ${NKillAdd} && ${Actor[Query, Name =- "${NAddName}" && Distance <= 35 && IsDead = TRUE](exists)} && !${RI_Var_Bool_GlobalOthers}
					Actor[Query, Name =- "${NAddName}"]:DoubleClick
				elseif !${RI_Var_Bool_GlobalOthers}
					Actor[id,${NameID}]:DoTarget
				if ${TargetID}!=${Target.ID} && ${Target.ID}!=0
				{
					TargetID:Set[${Target.ID}]
					relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Var_Int_MoveBehindMobID:Set[${Target.ID}]
				}
				;if (${Target.Type.Equal[NPC]} || ${Target.Type.Equal[NamedNPC]})
				;	Face ${Target.X} ${Target.Z}
				;elseif ${Target.Type.Equal[PC]} && (${Target.Target.Type.Equal[NPC]} || ${Target.Target.Type.Equal[NamedNPC]})
				;	Face ${Target.Target.X} ${Target.Target.Z}
				;if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LockMXN},${LockMYN},${LockMZN}]}>2
				;	call RIMObj.Move ${LockMXN} ${LockMYN} ${LockMZN} ${Precision} 0 FALSE FALSE TRUE FALSE TRUE
			}
			call ExecuteQueued
			wait 1
		}
		wait 10
		if !${RunSpecificFunction} && ${NMoveBehind}
		{
			;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL OFF
			relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call MoveBehind 0"]
			RIMUIObj:SetLockSpot[OFF]
			;RI_Atom_SetLockSpot OFF
		}
		else
			relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[OFF]
			;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot OFF
		; if ${ISXOgre(exists)}
			; relay "other ${RI_Var_String_RelayGroup}" -noredirect OgreBotAtom a_LetsGo all
		RI_Var_Bool_Follow:Set[TRUE]
		call RIMObj.follow
		if !${RI_Var_Bool_SkipLoot}
			call RIMObj.LootChest
		if !${Script[Buffer:CoT]}
			RI_CoT
		;Script[Buffer:AggroControl].Variable[TrashTargeting]:Set[TRUE]
	}
}
function MoveBehind(bool _On)
{
	if ${_On}
	{
		declare RI_MoveBehind bool global ${RI_Obj_CB.GetUISetting[SettingsMoveBehindCheckBox]}
		declare RI_SkipMoveHealthCheck bool global ${RI_Obj_CB.GetUISetting[SettingsSkipMobMoveHealthCheckBox]}
		declare RI_MoveHealth int global ${RI_Obj_CB.GetUISetting[SettingsMoveHealthTextEntry]}
		RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,1]
		RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,0]
		RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,99]
	}
	else
	{
		if !${RI_MoveBehind}
			RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,0]
		if ${RI_SkipMoveHealthCheck}
			RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,1]
		if ${RI_MoveHealth(exists)}
			RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${RI_MoveHealth}]
		deletevariable RI_MoveBehind
		deletevariable RI_SkipMoveHealthCheck
		deletevariable RI_MoveHealth
	}
}
;OLD WAY
; function LockSpot(float LX, float LY, float LZ, string LName)
; {
	;lock to LX LY LZ until LName is dead
	; while ${Actor[${LName},radius,150](exists)} && !${Actor[${LName},radius,150].IsDead} && !${LockSpotting}
	; {
		;check if we are paused
		; call RIMObj.CheckPause
		; call ExecuteQueued
		; if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LX},${LY},${LZ}]}>2
			; call RIMObj.Move ${LX} ${LY} ${LZ} ${Precision} 0 FALSE FALSE TRUE FALSE TRUE
		; wait 1
	; }
	;lock to LX LY LZ until LockSpotting is set FALSE
	; while ${LockSpotting}
	; {
		;check if we are paused
		; call RIMObj.CheckPause
		; call ExecuteQueued
		; if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LX},${LY},${LZ}]}>2
			; call RIMObj.Move ${LX} ${LY} ${LZ} ${Precision} 0 FALSE FALSE TRUE FALSE TRUE
		; wait 1
	; }
; }
function WaitMob(string WMName, int _distance=25)
{
	;set ID number of closest mob named WMName
	variable int WMID = ${Actor[${WMName},radius,${_distance}].ID}
	;wait for mob to die if exists is in range and is not dead
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z}]
	;relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z}
	
	while ${Actor[id,${WMID}](exists)} && !${Actor[id,${WMID}].IsDead} && ${RI_Var_Bool_Start} && ${WMID}!=0
	{
		call ExecuteQueued
		wait 1
	}
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
	;relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot OFF
}
function WaitForMob(string WMName, int WMDistance=100, bool Aggro=FALSE, bool CheckExists=FALSE)
{
	;set ID number of closest mob named WMName
	;variable int WMID = ${Actor[Query, Name=-"${WMName}" && Distance<=${WMDistance}].ID}
	;wait for mob to exist
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z}]
	;relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z}
	if ${Aggro}
	{
		if ${CheckExists} && !${Actor[Query,Name=-"${WMName}"](exists)}
			return
		while !${Actor[Query,Name=-"${WMName}" && Distance<=${WMDistance} && IsDead=FALSE && IsAggro=TRUE](exists)} && ${RI_Var_Bool_Start}
		{
			call ExecuteQueued
			if ${Me.InCombat}
				RIObj:BalanceMobs[ALL]
			wait 1
			if ${RI_Var_Bool_Debug}
				echo ISXRI: ${Time} Waiting for Mob ${WMName} to exist
		}
	}
	else
	{
		if ${CheckExists} && !${Actor[Query,Name=-"${WMName}"](exists)}
			return
		while !${Actor[Query,Name=-"${WMName}" && Distance<=${WMDistance} && IsDead=FALSE](exists)} && ${RI_Var_Bool_Start}
		{
			call ExecuteQueued
			if ${Me.InCombat}
				RIObj:BalanceMobs[ALL]
			wait 1
			if ${RI_Var_Bool_Debug}
				echo ISXRI: ${Time} Waiting for Mob ${WMName} to exist or be in range
			if ${CheckExists} && !${Actor[Query,Name=-"${WMName}"](exists)}
				return
		}
	}
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
	;relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot OFF
}
function WaitForMobAway(string WMName, int WMDistance=100)
{
	;set ID number of closest mob named WMName
	;wait for mob to exist
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z}]

	while ${Actor[Query,Name=-"${WMName}" && Distance<=${WMDistance} && IsDead=FALSE](exists)} && ${RI_Var_Bool_Start}
	{
		call ExecuteQueued
		if ${Me.InCombat}
			RIObj:BalanceMobs[ALL]
		wait 1
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Waiting for Mob ${WMName} to NOT exist
	}
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
}
function PreHeal()
{
	if ( ${Me.Group}==1 || ( ${Me.Group}==2 && ${Me.Group[1].Type.NotEqual[PC]} ) ) && ${Me.Archetype.NotEqual[priest]}
		return
	wait 20
	relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:PreHeal[ALL,${Me.Name}]
	wait 70
}

;script to change loot options
function LootOptions(string Options)
{
	;open group options window
	eq2ex groupoptions
	wait 5
	
	;switch which options was requested
	switch ${Options.Upper}
	{
		case LEADERONLY
		{
			EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[0]
			break
		}
		case FREEFORALL
		{
			EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[1]
			break
		}
		case LOTTO
		{
			EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[2]
			break
		}
		case NEEDBEFOREGREED
		{
			EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[3]
			break
		}
		case ROUNDROBIN
		{
			EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[4]
			break
		}
	}
	wait 1
	;set to all items
	EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.ItemTierCombo]:Set[0]
	
	wait 5
	
	;press Apply
	EQ2UIPage[popup,groupoptions].Child[Button,GroupOptions.ApplyButton]:LeftClick
	
	wait 5
}
;script to target a specific mob
function Target(string TName, bool StayTargeted, int Distance=1000)
{
	;set TargetsID
	;echo ${TName}
	;echo "${TName}"
	if ${Actor[${TName},radius,${Distance}](exists)}
	{
		;echo ${Actor[${TName},radius,${Distance}].ID}
		variable int TID = ${Actor[${TName},radius,${Distance}].ID}
	}
	else
		return
	;echo ${TID}
	;target
	if !${RI_Var_Bool_GlobalOthers}
		Actor[id,${TID}]:DoTarget
	while ${Actor[id,${TID}](exists)} && !${Actor[id,${TID}].IsDead} && !${RI_Var_Bool_GlobalOthers} && ${StayTargeted}
	{
		;check if we are paused
		call RIMObj.CheckPause
		Actor[id,${TID}]:DoTarget
		wait 1
	}
	;echo end target
}
function SpireDoor()
{
	call Door
}
function Door(int distance=10)
{
	wait 10
	if ${RI_Var_Bool_Debug}
		echo ISXRI: ${Time} Opening any doors within ${distance}
		
	variable index:actor Actors
    variable iterator ActorIterator
    
	EQ2:QueryActors[Actors, Type !="Pet" && Type !="PC" && Name !="${Me.Name}" && Distance <= ${distance}]
    Actors:GetIterator[ActorIterator]
  
    if ${ActorIterator:First(exists)}
    {
        do
        {
            ActorIterator.Value:DoubleClick
        }
        while ${ActorIterator:Next(exists)}
    }
}
function HailActorFast(string _Actor, int _NumberOfResponses=1, int _ResponseNumber=1, bool _Hail=TRUE)
{
	;move to HailActor location
	;stop follow
	call RIMObj.stopfollow
	;echo Moving to ${CustomLoc} and Clicking ${_Actor}
	relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE"]
	if ${CustomLoc.NotEqual[0 0 0]}
	{
		call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
		;wait 20
	}
	;make sure _Actor exists so we do not go through the motions for nothing
	if ${Actor["${_Actor}",radius,20](exists)}
	{
		;wait until we are out of combat
		if !${DontStopForCombat}
			call RIMObj.CheckCombat
		;wait 10
		;pause bots
		
		relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
		wait 2
		if ${_Hail}
		{
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["${_Actor}"]:DoFace
			;wait 5
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["${_Actor}"]:DoTarget
			wait 2
			relay ${RI_Var_String_RelayGroup} -noredirect eq2execute hail
			wait 5
		}
		variable int count
		for(count:Set[1];${count}<=${_NumberOfResponses};count:Inc)
		{
			if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)}
				relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}]:LeftClick
			wait 5
		}
		;unpause bots
		relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	}
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
	;follow
	call RIMObj.follow
}
function HailActorMultiOption(string _Actor, ... args)
{
	variable int _count
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echo ${args[${_count}]}
		if ${_count}==1
			call HailActor "${_Actor}" 1 ${args[${_count}]} 1
		else
			call HailActor "${_Actor}" 1 ${args[${_count}]} 0
		wait 1
	}
}
function HailActor(string _Actor, int _NumberOfResponses=1, int _ResponseNumber=1, bool _Hail=TRUE, bool _Follow=TRUE, bool _ExactName=FALSE)
{
	;echo HailActor(string _Actor=${_Actor}, int _NumberOfResponses=1=${_NumberOfResponses}, int _ResponseNumber=1=${_ResponseNumber}, bool _Hail=TRUE=${_Hail})
	;move to HailActor location
	;stop follow

	;echo Moving to ${CustomLoc} and Clicking ${_Actor}
	if ${CustomLoc.NotEqual[0 0 0]} && ${Math.Distance[${Me.Loc},${CustomLoc.Replace[" ",","]}]}>5
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE"]
		call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
	}
	if ${_Hail}
	{
		wait 20
	}
	if ${_Follow}
		call RIMObj.stopfollow
	;make sure _Actor exists so we do not go through the motions for nothign
	;echo \${Actor[${_Actor}](exists)}  //  ${Actor[${_Actor}](exists)}
	if ${Actor[${_Actor}](exists)}
	{
		variable int _ID
		if ${_ExactName}
			_ID:Set[${Actor[Query, Name=="${_Actor}"].ID}]
		else
			_ID:Set[${Actor[${_Actor}].ID}]
		;wait until we are out of combat
		if !${DontStopForCombat}
			call RIMObj.CheckCombat
		
		if ${_Hail}
		{
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			;wait 5
			;change camera
			relay ${RI_Var_String_RelayGroup} -noredirect Press -hold "Page Down"
			wait 15
			;change camera
			relay ${RI_Var_String_RelayGroup} -noredirect Press -release "Page Down"
			relay ${RI_Var_String_RelayGroup} -noredirect Press -hold "Page Up"
			wait 3
			relay ${RI_Var_String_RelayGroup} -noredirect Press -release "Page Up"
			
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoFace
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoFace
			wait 5
			;scroll the mouse wheel
			relay ${RI_Var_String_RelayGroup} -noredirect MouseWheel -10000
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoTarget
			wait 5
			relay ${RI_Var_String_RelayGroup} -noredirect eq2execute hail
			wait 5
		}
		variable int count
		variable string _tempbtntxt
		for(count:Set[1];${count}<=${_NumberOfResponses};count:Inc)
		{
			_tempbtntxt:Set["${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText]}"]
			if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)}
				relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}]:LeftClick
			wait 5
			wait 20 ( ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText].NotEqual["${_tempbtntxt}"]} || !${EQ2UIPage[ProxyActor,Conversation].IsVisible} )
		}
		;unpause bots
		relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	}
	if !${DontStopForCombat}
		call RIMObj.CheckCombat
	;follow
	if ${_Follow}
		call RIMObj.follow
}
function ClickActor(string _Actor, bool _LoopUntilNoHighlightOnMouseHover=0, bool _LoopUntilDNE=0, int _GiveUpCNT=50)
{
	;echo ClickActor(string _Actor=${_Actor}, int _LoopUntilNoHighlightOnMouseHover=0=${_LoopUntilNoHighlightOnMouseHover}, int _GiveUpCNT=50=${_GiveUpCNT})
	;move to ClickActor location
	;stop follow
	variable int _Cnt=0
	variable int _ID
	if ${_Actor.Left[10].Equal[TintFlags-]} && ${_HighlightOnMouseHover}
		_ID:Set[${Actor[Query, TintFlags=${_Actor.Right[-10]} && HighlightOnMouseHover=TRUE].ID}]
	elseif ${_Actor.Left[10].Equal[TintFlags-]}
		_ID:Set[${Actor[Query, TintFlags=${_Actor.Right[-10]}].ID}]
	elseif ${_HighlightOnMouseHover}
		_ID:Set[${Actor[Query, Name=-"${_Actor}" && HighlightOnMouseHover=TRUE].ID}]
	else
		_ID:Set[${Actor[Query, Name=-"${_Actor}"].ID}]
	;echo Moving to ${CustomLoc} and Clicking ${_Actor} with Actor ID: ${_ID}
	relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE"]
	if ${CustomLoc.NotEqual[0 0 0]}
	{
		call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
		wait 20
	}
	call RIMObj.stopfollow
	;make sure _Actor exists so we do not go through the motions for nothign
	;echo \${Actor[Query, Name=-"${_Actor}"](exists)}  //  ${Actor[Query, Name=-"${_Actor}"](exists)}
	if ${_LoopUntilNoHighlightOnMouseHover}
	{
		if ${Actor[id,${_ID}](exists)}
		{
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			while ${Actor[${_ID}].HighlightOnMouseHover} && ${_Cnt:Inc} <= ${_GiveUpCNT}
			{
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5 ${Me.CastingSpell}
				wait 50 !${Me.CastingSpell}
				wait 5
			}
		}
	}
	elseif ${_LoopUntilDNE}
	{
		if ${Actor[id,${_ID}](exists)}
		{
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			while ${Actor[${_ID}](exists)} && ${_Cnt:Inc} <= ${_GiveUpCNT}
			{
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5 ${Me.CastingSpell}
				wait 50 !${Me.CastingSpell}
			}
		}
	}
	else
	{
		if ${Actor[id,${_ID}](exists)}
		{
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			wait 5
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
			wait 5
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
			wait 5
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
		}

	}
	relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
}
function ClickNoNameActor(int distance=5)
{
	;wait 20
	;echo ISXRI: ${Time} Clicking any Actors within ${distance}
		
	variable index:actor Actors
    variable iterator ActorIterator
    
	EQ2:QueryActors[Actors, Type !="Pet" && Type !="PC" && Name !="${Me.Name}" && Distance <= ${distance} && Name==""]
    Actors:GetIterator[ActorIterator]
  
    if ${ActorIterator:First(exists)}
    {
        do
        {
			;echo ISXRI: ${Time} Clicking Actor ID: ${ActorIterator.Value.ID} at ${ActorIterator.Value.Loc}
			;if ${ActorIterator.Value.Name.Equal[""]}
			;	echo this one has no name
            ; relay ${RI_Var_String_RelayGroup} -noredirect execute noop ${Actor[Query, ID=${ActorIterator.Value.ID}]:DoubleClick}
			; wait 1
			; relay ${RI_Var_String_RelayGroup} -noredirect execute noop ${Actor[Query, ID=${ActorIterator.Value.ID}]:DoubleClick}
			; wait 1
			; relay ${RI_Var_String_RelayGroup} -noredirect execute noop ${Actor[Query, ID=${ActorIterator.Value.ID}]:DoubleClick}
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${ActorIterator.Value.ID}]:DoubleClick
			wait 1
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${ActorIterator.Value.ID}]:DoubleClick
			wait 1
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[${ActorIterator.Value.ID}]:DoubleClick
			wait 20
        }
        while ${ActorIterator:Next(exists)}
    }
	;wait 20
}
function MoveToNoNameActor(int _Precision=2, bool _SkipCollisionCheck=FALSE)
{
	call RIMObj.Move ${Actor[Query, Type !="Pet" && Type !="PC" && Name !="${Me.Name}" && Name==""].X} ${Actor[Query, Type !="Pet" && Type !="PC" && Name !="${Me.Name}" && Name==""].Y} ${Actor[Query, Type !="Pet" && Type !="PC" && Name !="${Me.Name}" && Name==""].Z}  ${_Precision} 0 0 0 1 0 1 ${_SkipCollisionCheck}
}
;function to handle lifts in FSD Heroic
function Lift(int onX, int onZ, int offFace, string lVerb)
{
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call Lift ${onX} ${onZ} ${offFace}"]
		call RIMObj.stopfollow
	}
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Moving onto lift by facing ${onX},${onZ}, Pressing forward until we reach destination point, then ApplyVerb: ${lVerb} to ${Actor[Lever]}: ${Actor[Lever].ID}, then Move off via facing ${offFace} and moving until we are more than 8m away
	wait 20
	Face ${onX} ${onZ}
	press -hold ${RI_Var_String_ForwardKey}
	wait 30 ${Math.Distance[${Me.X},${Me.Z},${onX},${onZ}]}<2
	press -release ${RI_Var_String_ForwardKey}
	wait 20
	if ${lVerb(exists)}
		eq2ex apply_verb ${Actor[Lever].ID} "${lVerb}"
	wait 100
	Face ${offFace}
	press -hold ${RI_Var_String_ForwardKey}
	wait 30 ${Math.Distance[${Me.X},${Me.Z},${onX},${onZ}]}>8
	press -release ${RI_Var_String_ForwardKey}
	wait 20
	if !${RI_Var_Bool_GlobalOthers}
	{
		call RIMObj.follow
	}
}
;function to run a custom script
function RunCustomScript(string ScriptName, string arg1="", string arg2="", string arg3="", string arg4="", string arg5="")
{
	;echo ${ScriptName} ${arg1} ${arg2} ${arg3} ${arg4} ${arg5}
	if !${Script[Buffer:${ScriptName}](exists)}
		execute ${ScriptName} ${arg1} ${arg2} ${arg3} ${arg4} ${arg5}
}
;function to end a custom script
function EndCustomScript(string ScriptName)
{
	if ${Script[Buffer:${ScriptName}](exists)}
		endscript Buffer:${ScriptName}
}
;function to toggle between walk and run
function ToggleWalkRun(bool ALL)
{
	wait 20
	;toggle Walk Run
	if ${ALL}
		relay ${RI_Var_String_RelayGroup} -noredirect press shift+r
	else
		press shift+r
	wait 10
}
;function to target called named and relay a cast of severhate 
function SeverHate(string SHTarget)
{
	if ${Actor[${SHTarget}](exists)}
	{
		variable int SHTargetID=${Actor[${SHTarget}].ID}
		if ${SHTargetID} == 0
		{
			wait 5
			SHTargetID:Set[${Actor[${SHTarget}].ID}]
			wait 5
			if ${SHTargetID} == 0 && !${Actor[${SHTarget}](exists)}
			{
				if ${RI_Var_Bool_Debug}
					 SeverHate Target: ${SHTarget} Does Not Exist, Skipping Sever Hate
				return
			}
		}

		wait 20
		Actor[${SHTargetID}]:DoTarget
		wait 5
		relay ${RI_Var_String_RelayGroup} -noredirect Me.Ability["Sever Hate"]:Use
		while ${Actor[${SHTargetID}](exists)} && !${Actor[${SHTargetID}].Target(exists)}
		{
			Actor[${SHTargetID}]:DoTarget
			wait 5
			relay ${RI_Var_String_RelayGroup} -noredirect Me.Ability["Sever Hate"]:Use
		}
	}
	else
		echo ${Time}: SeverHate Target: ${SHTarget} Does Not Exist, Skipping Sever Hate
}
;function to end RI
function EndScript()
{
	if !${InstanceMode} && !${RI_Var_Bool_QuestMode}
	{
		wait 20
		Script:End
	}
}
;function to evac and end ri if requested
function Evac(bool EndScript)
{
	wait 10
	relay ${RI_Var_String_RelayGroup} RI_Evac
	wait 5
	relay ${RI_Var_String_RelayGroup} RI_Evac
	wait 45
	if ${Me.Group}>1 && ${Me.Group[1].Type.Equal[PC]}
		wait 50000 ${RIMObj.AllGroupInZone}
	wait 200
	;check for a Shiny if set
	if ${RI_Var_Bool_GrabShinys} && ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}](exists)}
	{
		if ( !${Actor[NamedNPC,radius,50](exists)} || ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}>10 ) && ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Me.Y}]}<3
		{
			ShinyID:Set[${Actor[?,radius,${ShinyScanDistance}].ID}]
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Closest Shiny ID: ${ShinyID} @ ${Actor[${ShinyID}].X} ${Actor[${ShinyID}].Y} ${Actor[${ShinyID}].Z} Which is ${Actor[${ShinyID}].Distance} Away
			;press -release ${RI_Var_String_ForwardKey}
			call RIMObj.CheckShiny
		}
	}
	if ${EndScript} && !${InstanceMode} && !${RI_Var_Bool_QuestMode}
		relay ${RI_Var_String_RelayGroup} -noredirect endscript ${RI_Var_String_RunInstancesScriptName}
}
function ExecuteQueued()
{
	;execute queued commands
	if ${QueuedCommands}
	{
		ExecuteQueued
	}
}

;code to execute when close is pressed on ui
function atexit()
{
	squelch HUD -remove east
	squelch HUD -remove west
	if ${LoadedTLO} && ${Extension[ISXRI](exists)}
		squelch RI_CMD_Hidden_RemoveTLO ${LoadedTLOName}

	; if ${ISXOgre(exists)}
	; {
		; OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack FALSE
		; OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_combat FALSE
		; OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_ca FALSE
		; OgreBotAtom aExecuteAtom ${Me} a_UplinkControllerFunctionAutoType checkbox_settings_disablecaststack_namedca FALSE
	; }
			
	;disable LockSpotting if it was originally off
	if ${Script[${RI_Var_String_CombatBotScriptName}](exists)} && ${LockSpottingWasOff} && !${Script[Buffer:RZ](exists)}
		RI_Obj_CB:SetUISetting[SettingsLockSpottingCheckBox,FALSE]

			
	;if ${Script[Buffer:RIMovement]}
	;	endscript Buffer:RIMovement
	relay ${RI_Var_String_RelayGroup} Squelch RIMUIObj:SetLockSpot[OFF]
	relay ${RI_Var_String_RelayGroup} Squelch RIMUIObj:SetRIFollow[OFF]
	;relay ${RI_Var_String_RelayGroup} Squelch RI_Atom_SetLockSpot OFF
	;relay ${RI_Var_String_RelayGroup} Squelch RI_Atom_SetRIFollow OFF
	relay ${RI_Var_String_RelayGroup} Squelch press -release ${RI_Var_String_ForwardKey}
	relay ${RI_Var_String_RelayGroup} Squelch press -release ${RI_Var_String_BackwardKey}
	relay ${RI_Var_String_RelayGroup} Squelch press -release ${RI_Var_String_FlyUpKey}
	
	;if ${Script[Buffer:RILooter]}
	;	endscript Buffer:RILooter
	;if ${Script[Buffer:OgrePlayNice]}
		;endscript Buffer:OgrePlayNice
	if ${Script[Buffer:Detarget]}
		endscript Buffer:Detarget
	if ${Script[Buffer:Vexven]}
		endscript Buffer:Vexven
	if ${Script[Buffer:CoT]}
		endscript Buffer:CoT
	if ${Script[Buffer:AggroControl]}
		endscript Buffer:AggroControl
		
	if ${RI_Var_Bool_GlobalOthers}
	{
		echo Ending RI
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	}
	else
	{
		echo Ending RI
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RIObj:EndScript
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	}
	if ${Me.IsMoving}
	{
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
	}
	press -release ${RI_Var_String_StrafeLeftKey}
	press -release ${RI_Var_String_StrafeRightKey}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	;if ${Script[Buffer:Craft](exists)}
	;	Script[Buffer:Craft]:End
	
	;turn off food,drink and potion consumption   ---- ADD THIS TO RZ and Make Optional
;	if ${Me.Equipment[Food].AutoConsumeOn} 
;		Me.Equipment[Food]:ToggleAutoConsume
;	if ${Me.Equipment[Drink].AutoConsumeOn}
;		Me.Equipment[Drink]:ToggleAutoConsume
;	if ${Me.Inventory[Elixir of Piety](exists)} && ${Me.Archetype.Equal[priest]} && ${Me.Inventory[Elixir of Piety].AutoConsumeOn}
;		Me.Inventory[Elixir of Piety]:ToggleAutoConsume
;	if ${Me.Inventory[Elixir of Deftness](exists)} && ${Me.Archetype.Equal[scout]} && ${Me.Inventory[Elixir of Deftness].AutoConsumeOn}
;		Me.Inventory[Elixir of Deftness]:ToggleAutoConsume
;	if ${Me.Inventory[Elixir of Intellect](exists)} && ${Me.Archetype.Equal[mage]} && ${Me.Inventory[Elixir of Intellect].AutoConsumeOn}
;		Me.Inventory[Elixir of Intellect]:ToggleAutoConsume
;	if ${Me.Inventory[Elixir of Fortitude](exists)} && !${RI_Var_Bool_GlobalOthers} && ${Me.Inventory[Elixir of Fortitude].AutoConsumeOn}
;		Me.Inventory[Elixir of Fortitude]:ToggleAutoConsume
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; AOM NAMED CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

variable(global) string CurseName
variable(global) bool RecentlyCured=FALSE
variable(global) int Tapestry=1
variable(global) bool NeedsBotDisable=TRUE
variable bool CastAntidote=TRUE
variable bool CastAntidote2=FALSE
variable string InterruptAbility
variable string AbilityToInterrupt=Symptomatic Dementia
variable bool SenshaliEngaged=FALSE
variable int PerisID
variable int AchionID
variable int UrsherID
variable int AltoID
variable int BassID
variable int SopranoID
variable int TenorID
variable int ValdimusID

;#define _CustomNamedAoM_

function Mo'iana()
{
	echo Mo'iana Script v3
	variable int CurseCallTime=0
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} -3653.846680 -78.433472 140.835564 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[1].Name} -3664.163330 -80.522331 149.706558 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[2].Name} -3666.393311 -81.096672 138.827965 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[3].Name} -3655.729736 -78.304756 153.642868 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[4].Name} -3646.757324 -76.068604 149.589691 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[5].Name} -3658.892578 -79.401596 130.722755 1 100
	}
	echo ${Time}: Waiting for Mo'iana the Ravenous
	wait 2000000 ${Actor["Mo'iana the Ravenous"](exists)}
	echo ${Time}: Done Waiting for Mo'iana the Ravenous
	if ${Me.Archetype.Equal[priest]}
		RI_CMD_AbilityEnableDisable "Cure Curse" 0
	while ${Actor["Mo'iana"](exists)} && !${Actor["Mo'iana"].IsDead}
	{
		if ${Target.ID}!=${Actor["Mo'iana"].ID} && !${RI_Var_Bool_GlobalOthers}
			Actor["Mo'iana"]:DoTarget
		Me:InitializeEffects
		wait 5
		if ( ${Me.Effect[detrimental,1].BackDropIconID}==315 && ${Me.Effect[detrimental,1].MainIconID}==207  ) || ( ${Me.Effect[detrimental,2].BackDropIconID}==315 && ${Me.Effect[detrimental,2].MainIconID}==207  ) || ( ${Me.Effect[detrimental,3].BackDropIconID}==315 && ${Me.Effect[detrimental,3].MainIconID}==207  ) || ( ${Me.Effect[detrimental,4].BackDropIconID}==315 && ${Me.Effect[detrimental,4].MainIconID}==207  ) || ( ${Me.Effect[detrimental,5].BackDropIconID}==315 && ${Me.Effect[detrimental,5].MainIconID}==207  )
		{
			;echo i have bad curse
			if ( ${Script.RunningTime}>${Math.Calc[${CurseCallTime}+10000]} || ${CurseCallTime}==0 )
			{
				eq2ex g need a cure curse
				CurseCallTime:Set[${Script.RunningTime}]
			}
		}
	}
	if ${Me.Archetype.Equal[priest]}
		RI_CMD_AbilityEnableDisable "Cure Curse" 1
}
function ClickRiders()
{
	wait 20
	call RIMObj.stopfollow
	;pause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 1
	eq2ex cancel_spellcast
	eq2execute clearabilityqueue 
	wait 200 !${Me.CastingSpell}
	relay ${RI_Var_String_RelayGroup} -noredirect Actor[Special]:DoubleClick
	wait 5
	while !${Me.IsMoving}
	{
		relay ${RI_Var_String_RelayGroup} -noredirect Actor[Special]:DoubleClick
		wait 2
	}
	while ${Me.IsMoving}
		wait 2
	wait 20
	;unpause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 0
}
;need to code to disable these spells!!!
function Telaris()
{
	echo ISXRI: Starting Telaris 
	RI_Atom_SetLockSpot ${Me.Name} -35 0 71 2 100
	call _MoveC -35 71
	call _MoveC -47 89
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetLockSpot off
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor[Telaris].ID} 30 99 ${Me.Name}
		RI_Atom_SetLockSpot ${Me.Name} -47 0 89 2 100
	}
	;main loop
	do
	{
		if (${Me.GetGameData[Target.Casting].Label.Equal[${AbilityToInterrupt}]} || ${Me.GetGameData[ImpliedTarget.Casting].Label.Equal[${AbilityToInterrupt}]})
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Detected interrupt ability: ${AbilityToInterrupt} casting 
			call SetInterruptSpell
			call Interrupt
		}
		wait 1
	}
	while ${Actor[Telaris](exists)} && !${Actor[Telaris].IsDead}
	;reload Bots
	RI_CMD_ReloadBots
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL OFF	
}
function Interrupt()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Interrupting ability: ${AbilityToInterrupt} with ability: ${InterruptAbility}
	;pause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 1
	eq2ex cancel_spellcast
	eq2execute clearabilityqueue 
	wait 200 !${Me.CastingSpell}
	if ${RI_Var_Bool_Debug}
		echo ${Time}: We are not casting and ${InterruptAbility} IsReady: ${Me.Ability[${InterruptAbility}].IsReady}
	while ${Me.Ability[${InterruptAbility}].IsReady}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Casting ${InterruptAbility}
		Me.Ability[${InterruptAbility}]:Use
		wait 1
	}
	wait 200 !${Me.CastingSpell}
	;unpause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 0
}
function SetInterruptSpell()
{
	variable bool NeedsBotDisable=TRUE
	;based on subclass, and if their ability is ready, set interruptability
	switch ${Me.SubClass}
	{
		case guardian
			if ${Me.Ability[Provoke IX].IsReady}
				InterruptAbility:Set[Provoke IX]
			elseif ${Me.Ability[Gut Kick VIII].IsReady}
				InterruptAbility:Set[Gut Kick VIII]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Provoke" 0
				RI_CMD_AbilityEnableDisable "Gut Kick" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case berserker
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case paladin
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case shadowknight
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case monk
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case bruiser
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case swashbuckler
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case brigand
			if ${Me.Ability[Bum Rush VIII].IsReady}
				InterruptAbility:Set[Bum Rush VIII]
			elseif ${Me.Ability[Barroom Negotiation VIII].IsReady}
				InterruptAbility:Set[Barroom Negotiation VIII]
			elseif ${Me.Ability[Cuss VII].IsReady}
				InterruptAbility:Set[Cuss VII]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Bum Rush" 0
				RI_CMD_AbilityEnableDisable "Barroom Negotiation" 0
				RI_CMD_AbilityEnableDisable "Cuss" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case ranger
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case assassin
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case dirge
			if ${Me.Ability[Tarven's Crippling Crescendo VIII].IsReady}
				InterruptAbility:Set[Tarven's Crippling Crescendo VIII]
			elseif ${Me.Ability[Hymn of Horror III].IsReady}
				InterruptAbility:Set[Hymn of Horror III]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Tarven's Crippling Crescendo VIII" 0
				RI_CMD_AbilityEnableDisable "Hymn of Horror III" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case troubador
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case templar
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case inquisitor
			if ${Me.Ability[Invocation Strike].IsReady}
				InterruptAbility:Set[Invocation Strike]
			elseif ${Me.Ability[Skull Crack].IsReady}
				InterruptAbility:Set[Skull Crack]
			elseif ${Me.Ability[Litany Circle].IsReady}
				InterruptAbility:Set[Litany Circle]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Invocation Strike" 0
				RI_CMD_AbilityEnableDisable "Skull Crack" 0
				RI_CMD_AbilityEnableDisable "Litany Circle" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case defiler
			if ${Me.Ability[Absolute Corruption VI].IsReady}
				InterruptAbility:Set[Absolute Corruption VI]
			elseif ${Me.Ability[Leg Bite].IsReady}
				InterruptAbility:Set[Leg Bite]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Absolute Corruption" 0
				RI_CMD_AbilityEnableDisable "Leg Bite" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case mystic
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case warden
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case fury
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case warlock
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case wizard
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case nercomancer
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case conjurer
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case coercer
			if ${Me.Ability[Spellblade's Counter].IsReady}
				InterruptAbility:Set[Spellblade's Counter]
			elseif ${Me.Ability[Hemorrhage X].IsReady}
				InterruptAbility:Set[Hemorrhage X]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Spellblade's Counter" 0
				RI_CMD_AbilityEnableDisable "Hemorrhage" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
		case illusionist
			if ${Me.Ability[Ability1].IsReady}
				InterruptAbility:Set[Ability1]
			elseif ${Me.Ability[Ability2].IsReady}
				InterruptAbility:Set[Ability2]
			if ${NeedsBotDisable}
			{
				RI_CMD_AbilityEnableDisable "Ability" 0
				NeedsBotDisable:Set[FALSE]
			}
			break
	}
}
function Senshali()
{
	SenshaliEngaged:Set[TRUE]
	echo ISXRI: Starting Senshali v2
	;events
	AnnounceText:Clear
	AnnounceText:Insert["lights glow about"]
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		Actor["Sa'Dax Senshali"]:DoTarget
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot all 95 0 45 2 100
		wait 20
		;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Var_Bool_LockSpotting:Set[FALSE]	
		;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor["Sa'Dax Senshali"].ID} 30 99 ${Me.Name}	
	}
	;main loop
	do
	{
		;if we get text call orbs
		if ${Trigger}
			call Orbs
		if ${Actor["Dark Luclinite"].Distance}<10
			Actor["Dark Luclinite"]:DoubleClick
		wait 1
	}
	while ${Actor[Query, Name=="Sa'Dax Senshali" && IsDead=FALSE](exists)}
	SenshaliEngaged:Set[FALSE]
}
;click orbs
function Orbs()
{
	; if ${RI_Var_Bool_GlobalOthers}
	; {
		; RI_Var_Bool_MovingBehind:Set[FALSE]
		; RI_Var_Bool_LockSpotting:Set[TRUE]
	; }
	wait 5
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Clicking Orbs, ${TriggerMessage}, ${TriggerMessage.Find[Green]}, ${TriggerMessage.Find[Orange]}, ${TriggerMessage.Find[Purple]}
	Trigger:Set[FALSE]
	;pause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 1
	eq2execute cancel_spellcast 
	eq2execute clearabilityqueue 
	wait 5
	if ${TriggerMessage.Find[Green]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Needs Green	
		wait 10
		while ${Math.Distance[${Me.Y},-109.4]}<2 && ${Actor[Query, Name=="Sa'Dax Senshali" && IsDead=FALSE](exists)}
		{
			Actor[Blue]:DoubleClick
			Actor[Yellow]:DoubleClick
			waitframe
		}
	}
	if ${TriggerMessage.Find[Orange]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Needs Orange
		wait 10
		while ${Math.Distance[${Me.Y},-109.4]}<2 && ${Actor[Query, Name=="Sa'Dax Senshali" && IsDead=FALSE](exists)}
		{
			Actor[Red]:DoubleClick
			Actor[Yellow]:DoubleClick
			waitframe
		}
	}
	if ${TriggerMessage.Find[Purple]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Needs Purple
		wait 10
		while ${Math.Distance[${Me.Y},-109.4]}<2 && ${Actor[Query, Name=="Sa'Dax Senshali" && IsDead=FALSE](exists)}
		{
			Actor[Blue]:DoubleClick
			Actor[Red]:DoubleClick
			waitframe
		}
	}
	;unpause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 0
	while ${Math.Distance[${Me.Y},-109.4]}>2 && ${Actor[Query, Name=="Sa'Dax Senshali" && IsDead=FALSE](exists)}
	{
		;if ${RI_Var_Bool_LockSpotting}
		;	RI_Var_Bool_LockSpotting:Set[FALSE]
		RI_Atom_SetLockSpot ALL OFF
		press -release ${RI_Var_String_ForwardKey}
		wait 5
		if !${Actor[platform](exists)}
		{
			press -hold ${RI_Var_String_ForwardKey}
			wait 2
			press -release ${RI_Var_String_ForwardKey}
		}
		elseif !${RI_Var_Bool_GlobalOthers}
			target platform
	}
	; if ${RI_Var_Bool_GlobalOthers}
		; RI_Var_Bool_MovingBehind:Set[TRUE]
	; else
		;RI_Var_Bool_LockSpotting:Set[TRUE]
	RI_Atom_SetLockSpot ALL 95 0 45 2 100
}
function _MoveC(float X1, float Z1, bool CheckDeath, bool TargetSelf)
{
	RI_Atom_SetLockSpot ${Me.Name}
	wait 1
	RI_Atom_ChangeLockSpot ALL ${X1} 0 ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>2
	{
		if ${CheckDeath}
			call RIMObj.checktoons
		if ${TargetSelf}
			Actor[${Me.ID}]:DoTarget
		call RIMObj.CheckPause
		wait 1
	}
}
function _Move3(float X1, float Y1, float Z1, bool CheckDeath=0, bool TargetSelf=0)
{
	RI_Atom_SetLockSpot ${Me.Name}
	wait 1
	RI_Atom_ChangeLockSpot ALL ${X1} 0 ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>2
	{
		if ${CheckDeath}
			call RIMObj.checktoons
		if ${TargetSelf}
			Actor[${Me.ID}]:DoTarget
		call RIMObj.CheckPause
		wait 1
	}
}
function Blackhand()
{
	echo ISXRI: Starting Blackhand v6
	
	RI_Atom_SetLockSpot ${Me.Name} 96.219154 -85.600647 -177.131744
	;target blackhand and turn on ranged auto
	if !${RI_Var_Bool_GlobalOthers}
		target blackhand
	while !${Me.RangedAutoAttackOn} && !${RI_Var_Bool_GlobalOthers}
	{
		eq2ex togglerangedattack
		wait 2
	}
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect call _MoveC 96.219154 -177.131744
		wait 2
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetLockSpot ALL OFF
		wait 5
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor["Gudre Blackhand"].ID} 50 100 ${Me.Name}
		wait 2
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor["Gudre Blackhand"].ID} 50 100 ${Me.Name}
		wait 2
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor["Gudre Blackhand"].ID} 50 100 ${Me.Name}
	}
	;if !${RI_Var_Bool_GlobalOthers} && !${Script[Blackhandaggro]}
	;	run "${LavishScript.HomeDirectory}/Scripts/RunInstances/BlackhandAggro.iss"
	;main loop
	do
	{
		if (${Me.GetGameData[Target.Casting].Label.Equal[Centien Favor]} || ${Me.GetGameData[ImpliedTarget.Casting].Label.Equal[Centien Favor]})
			relay ${RI_Var_String_RelayGroup} -noredirect Actor[Blackhand]:DoubleClick
	}
	while ${Actor[Blackhand](exists)} && !${Actor[Blackhand].IsDead}
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL OFF	
	}
}
;function to move to appropriate tapestry and burn it
function Tapestry()
{
	echo tapestry
	Trigger:Set[FALSE]
	;pause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 1
	if ${RI_Var_Bool_GlobalOthers}
	{
		RI_Var_Bool_LockSpotting:Set[TRUE]
		RI_Var_Bool_MovingBehind:Set[FALSE]
	}
	;switch for which tapestry is active, then advance the count and move to and click tapestry then move back
	Switch ${Tapestry}
	{
		case 1
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 1"].X} ${Actor["Tapestry 1"].Z}
			wait 2
			Actor["Tapestry 1"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 2
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 2"].X} ${Actor["Tapestry 2"].Z}
			wait 2
			Actor["Tapestry 2"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 3
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 3"].X} ${Actor["Tapestry 3"].Z}
			wait 2
			Actor["Tapestry 3"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 4
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 4"].X} ${Actor["Tapestry 4"].Z}
			wait 2
			Actor["Tapestry 4"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 5
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 5"].X} ${Actor["Tapestry 5"].Z}
			wait 2
			Actor["Tapestry 5"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 6
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 6"].X} ${Actor["Tapestry 6"].Z}
			wait 2
			Actor["Tapestry 6"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 7
			call AdvanceCount
			call _MoveC ${Actor["Tapestry 7"].X} ${Actor["Tapestry 7"].Z}
			wait 2
			Actor["Tapestry 7"]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
		case 8
			call _MoveC 63 -155
			wait 2
			Actor[Tapestry]:DoubleClick
			wait 15
			call _MoveC 95.84 -177.59
			break
	}
	;unpause bots
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 0
	Trigger:Set[FALSE]
	if ${RI_Var_Bool_GlobalOthers}
	{
		RI_Var_Bool_LockSpotting:Set[FALSE]
		RI_Var_Bool_MovingBehind:Set[TRUE]
	}
}
function AdvanceCount()
{
	;increment tapestry
	if ${Tapestry}<8
		relay ${RI_Var_String_RelayGroup} -noredirect Tapestry:Inc
	else
		Tapestry:Set[8]
}
variable bool BipsieCasting=FALSE
function Bipsie()
{
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[Oh... boys! these scallywags are givin me a hard time... Do me a favor and sink them]
	echo ISXRI: Starting Bipsie v2
			
	;target her and turn on ranged auto
	target bipsie
	while !${Me.RangedAutoAttackOn}
	{
		eq2ex togglerangedattack
		wait 2
	}
	RI_Atom_SetLockSpot ${Me.Name} 50 0 -60 2 100
	;move to her and grab her
	if !${RI_Var_Bool_GlobalOthers}
		call _MoveToHerSpawnPoint
	wait 20

	
	do
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}:Main Loop
		;keep us in position where we are supposed to be
		if ${Math.Distance[${Me.X},${Me.Z},50,-60]}>2
			call _MoveC 50 -60
		if (${Me.GetGameData[Target.Casting].Label.Equal[Long Distance Relations]} || ${Me.GetGameData[ImpliedTarget.Casting].Label.Equal[Long Distance Relations]})
		{
			;pause bots, turn off melee and ranged attacks
			;turn off auto attack, cancel casting and clear queue
				
			RI_CMD_PauseCombatBots 1
			press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			eq2ex target_none
			wait 2
			Target Bipsie
			BipsieCasting:Set[TRUE]
			TimedCommand 150 Script[${RI_Var_String_RunInstancesScriptName}].Variable[BipsieCasting]:Set[FALSE]
			call CheckBipsie
		}
		if ${Actor[brokenskull,radius,15](exists)} && !${Actor[brokenskull,radius,15].IsDead} && !${Trigger}
			Actor[brokenskull,radius,15]:DoTarget
		if ${Actor[rat,radius,15](exists)} && !${Actor[rat,radius,15].IsDead} && !${Trigger}
			Actor[rat,radius,15]:DoTarget
		if ${Trigger}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Targeting Bipsie for 10s or Until she Starts Casting
			
			;pause bots, turn off melee and ranged attacks
			;turn off auto attack, cancel casting and clear queue
			RI_CMD_PauseCombatBots 1
			press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			eq2ex target_none
			wait 2
			Target Bipsie
			wait 100 ( ${Me.GetGameData[Target.Casting].Label.Equal[Long Distance Relations]} || ${Me.GetGameData[ImpliedTarget.Casting].Label.Equal[Long Distance Relations]} )
			BipsieCasting:Set[TRUE]
			TimedCommand 150 Script[${RI_Var_String_RunInstancesScriptName}].Variable[BipsieCasting]:Set[FALSE]
			Trigger:Set[FALSE]
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Bipsie has Started Casting, Moving to her location
			call CheckBipsie
		}
		wait 1
	}
	while ${Actor[Bipsie](exists)} && !${Actor[Bipsie].IsDead}
	;unpause bots
	RI_CMD_PauseCombatBots 0
}
function CheckBipsie()
{
	wait 10
	if ${RI_Var_Bool_Debug}
		echo ${Time}:Function Check Bipse
	if ${Math.Distance[${Actor[Bipsie].X},${Actor[Bipsie].Z},47,23]}<15
		call _MoveToHerSpawnPoint
	elseif ${Math.Distance[${Actor[Bipsie].X},${Actor[Bipsie].Z},40,8]}<15
		call _MoveToBottomOfRampByCorner
	elseif ${Math.Distance[${Actor[Bipsie].X},${Actor[Bipsie].Z},44,-46]}<15
		call _MoveToTopOfRamp
	elseif ${Math.Distance[${Actor[Bipsie].X},${Actor[Bipsie].Z},57,-17]}<15
		call _MoveToRats
	elseif ${Math.Distance[${Actor[Bipsie].X},${Actor[Bipsie].Z},-14,-58]}<15
		call _MoveToOutlook
		
	;unpause bots
	RI_CMD_PauseCombatBots 0
}
function _MoveToTopOfRamp()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Moving to top of ramp
	call _MoveC 44 -46
	wait 5
	while ${BipsieCasting}
		wait 2
	wait 15
}
function _MoveToHerSpawnPoint()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}:Moving to her spawn
	call _MoveC 44 -46
	call _MoveC 38 7
	call _MoveC 47 8
	call _MoveC 47 23
	wait 5
	while ${BipsieCasting}
		wait 2
	wait 15
	call _MoveC 47 8
	call _MoveC 38 7
	call _MoveC 44 -46
}
function _MoveToBottomOfRampByCorner()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}:Moving to Bottom of Ramp by Corner
	call _MoveC 44 -46
	call _MoveC 40 8
	wait 5
	while ${BipsieCasting}
		wait 2
	wait 15
	call _MoveC 44 -46
}
function _MoveToRats()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}:Moving to rats
	call _MoveC 56 -47
	call _MoveC 57 -17
	wait 5
	while ${BipsieCasting}
		wait 2
	wait 15
	call _MoveC 56 -47
	
}
function _MoveToOutlook()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}:Moving to outlook
	call _MoveC -14 -58
	wait 5
	while ${BipsieCasting}
		wait 2
	wait 15
}
function Pheris()
{
	echo Running Pheris 
		
	RI_Atom_SetLockSpot ${Me.Name} -137 0 -24 2 100
	do
	{
		if ${Math.Distance[${Actor["Praetor Pheris"].X},${Actor["Praetor Pheris"].Z},-148,32]}<6
			call _MoveToSouth
		elseif ${Math.Distance[${Actor["Praetor Pheris"].X},${Actor["Praetor Pheris"].Z},-148,-80]}<6
			call _MoveToNorth
		wait 1
	}
	while ${Actor["Praetor Pheris"](exists)} && !${Actor["Praetor Pheris"].IsDead}
}
function _MoveToSouth()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Moving to South Cubby
	call _MoveC -137 15 TRUE
	call _MoveC -148 32 TRUE
	wait 100
	call _MoveC -137 15
	call _MoveC -137 -24
	wait 100
}
function _MoveToNorth()
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Moving to North Cubby
	call _MoveC -137 -64 TRUE
	call _MoveC -148 -80 TRUE
	wait 100
	call _MoveC -137 -64
	call _MoveC -137 -24
	wait 100
}
function Verish()
{
	echo Running Verish 
	
	Actor["Elder Senistus Verish"]:DoTarget
	wait 20
	if !${RI_Var_Bool_GlobalOthers}
	{
			RI_Atom_SetLockSpot ${Me.Name} -205 -24 -24 1 100
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[1].Name} -208 -24 -14 1 100
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[2].Name} -197 -24 -18 1 100
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[3].Name} -198 -24 -30 1 100
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[4].Name} -209 -24 -34 1 100
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[5].Name} -216 -24 -24 1 100
	}
	
	do
	{
		if ${Target.ID}!=${Actor["Elder Senistus Verish"].ID}
			Actor["Elder Senistus Verish"]:DoTarget
		wait 1
	}
	while ${Actor["Elder Senistus Verish"](exists)}
}
function Ursher()
{
	echo Running Ursher 
	
	PerisID:Set[${Actor["Peris K'dal"].ID}]
	AchionID:Set[${Actor["Achiun K'dal"].ID}]
	UrsherID:Set[${Actor["Ursher K'dal"].ID}]
	;turn off assisting
	RI_CMD_Assisting 0
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${UrsherID} 30 100 ${Me.Name}
		RI_Atom_SetLockSpot ${Me.Name} -320 0 -21 2 100
	}
	Actor[id,${UrsherID}]:DoTarget
	do
	{
		while (${Me.Archetype.Equal[priest]} || ${Me.SubClass.Equal[dirge]} || ${Me.SubClass.Equal[necromancer]} || ${Me.SubClass.Equal[paladin]}) && (${Me.Group[1].IsDead} || ${Me.Group[2].IsDead} || ${Me.Group[3].IsDead} || ${Me.Group[4].IsDead} || ${Me.Group[5].IsDead})
			wait 1
		
		if ${Actor[id,${PerisID}](exists)} && !${Actor[id,${PerisID}].IsDead}
		{
			if ${Target.ID}!=${PerisID} 
				Actor[id,${PerisID}]:DoTarget
			;RI_Var_Int_MoveBehindMobID:Set[${PerisID}]
		}
		elseif ${Actor[id,${AchionID}](exists)} && !${Actor[id,${AchionID}].IsDead}
		{
			if ${Target.ID}!=${AchionID}
				Actor[id,${AchionID}]:DoTarget
			;RI_Var_Int_MoveBehindMobID:Set[${AchionID}]
		}
		elseif ${Actor[id,${UrsherID}](exists)}
		{
			if ${Target.ID}!=${UrsherID}
				Actor[id,${UrsherID}]:DoTarget
			;RI_Var_Int_MoveBehindMobID:Set[${UrsherID}]
		}
		wait 1
	}
	while ${Actor[id,${UrsherID}](exists)} && !${Actor[id,${UrsherID}].IsDead}
	
	;turn on assisting
	RI_CMD_Assisting 1
}
function Valdimus()
{
	AltoID:Set[${Actor["Malice Alto"].ID}]
	BassID:Set[${Actor["Malice Bass"].ID}]
	SopranoID:Set[${Actor["Malice Soprano"].ID}]
	TenorID:Set[${Actor["Malice Tenor"].ID}]
	ValdimusID:Set[${Actor["Valdimus V'Derun"].ID}]
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${ValdimusID} 30 99 ${Me.Name}
		RI_Atom_SetLockSpot ${Me.Name} -504.978699 0.643444 -23.940384 2 100
	}

	do
	{
		while (${Me.Archetype.Equal[priest]} || ${Me.SubClass.Equal[dirge]} || ${Me.SubClass.Equal[necromancer]} || ${Me.SubClass.Equal[paladin]}) && (${Me.Group[1].IsDead} || ${Me.Group[2].IsDead} || ${Me.Group[3].IsDead} || ${Me.Group[4].IsDead} || ${Me.Group[5].IsDead})
			wait 1
		if !${RI_Var_Bool_GlobalOthers}
		{
			; if ${Actor[id,${AltoID}].Health}>20
			; {
				; if ${Target.ID}!=${AltoID} 
					; Actor[id,${AltoID}]:DoTarget
				; relay ${RI_Var_String_RelayGroup} -noredirect RI_Var_Int_MoveBehindMobID:Set[${AltoID}]
			; }
			; elseif ${Actor[id,${BassID}].Health}>15
			; {
				; if ${Target.ID}!=${BassID}
					; Actor[id,${BassID}]:DoTarget
				; relay ${RI_Var_String_RelayGroup} -noredirect RI_Var_Int_MoveBehindMobID:Set[${BassID}]
			; }
			; elseif ${Actor[id,${SopranoID}].Health}>10
			; {
				; if ${Target.ID}!=${SopranoID}
					; Actor[id,${SopranoID}]:DoTarget
				; relay ${RI_Var_String_RelayGroup} -noredirect RI_Var_Int_MoveBehindMobID:Set[${SopranoID}]
			; }
			; elseif ${Actor[id,${TenorID}].Health}>5
			; {
				; if ${Target.ID}!=${TenorID}
					; Actor[id,${TenorID}]:DoTarget
				; relay ${RI_Var_String_RelayGroup} -noredirect RI_Var_Int_MoveBehindMobID:Set[${TenorID}]
			; }
			; else
			; {
				if ${Target.ID}!=${ValdimusID}
					Actor[id,${ValdimusID}]:DoTarget
				relay ${RI_Var_String_RelayGroup} -noredirect RI_Var_Int_MoveBehindMobID:Set[${ValdimusID}]
			;}
		}
		wait 1
	}
	while ${Actor[id,${ValdimusID}](exists)} && !${Actor[id,${ValdimusID}].IsDead}
}
function Kaimanu()
{
	RI_Atom_SetLockSpot ALL -3395.301270 17.157639 -140.931152 2 100
	do
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["Obsidian Warrior Koa"].ID} && ${Actor["Obsidian Warrior Koa"](exists)} && !${Actor["Obsidian Warrior Koa"].IsDead}
				Actor["Obsidian Warrior Koa"]:DoTarget
			elseif ${Target.ID}!=${Actor["Lavacrafter Peleaina"].ID} && ${Actor["Lavacrafter Peleaina"](exists)} && !${Actor["Lavacrafter Peleaina"].IsDead} && !${Actor["Obsidian Warrior Koa"](exists)}
				Actor["Lavacrafter Peleaina"]:DoTarget
		}
		wait 1
	}
	while ( ${Actor["Obsidian Warrior Koa"](exists)} && !${Actor["Obsidian Warrior Koa"].IsDead} )|| ( ${Actor["Lavacrafter Peleaina"](exists)} && !${Actor["Lavacrafter Peleaina"].IsDead} )
	;move to Augur
	RI_Atom_ChangeLockSpot ALL -3405.95 18.18 -159.69
	wait 50 ${Math.Distance[${Me.Loc},-3405.95,18.18,-159.69]}<2
	RI_Atom_ChangeLockSpot ALL -3415.95 18.18 -158.69
	do
	{
		if ${Target.ID}!=${Actor["Augur Kaimanu"].ID} && ${Actor["Augur Kaimanu"](exists)} && !${RI_Var_Bool_GlobalOthers}
			Actor["Augur Kaimanu"]:DoTarget
		wait 1
	}
	while ${Actor["Augur Kaimanu"](exists)} && !${Actor["Augur Kaimanu"].IsDead}
}

function Clotl'thoa()
{
	RI_Atom_SetLockSpot ALL -3334.001270 11.490292 76.188400 1 100
	if ${RI_Var_Bool_GlobalOthers}
		return
	RI_Atom_ChangeLockSpot ALL -3337.714844 11.281310 91.941048
	wait 10
	RI_Atom_ChangeLockSpot ALL -3334.001270 11.490292 76.188400
	wait 30
	do
	{	
		;initialize actor Fiery Effigy of Clotl'thoa's effects.
		;Actor["Fiery Effigy of Clotl'thoa"]:InitializeEffects

		;wait 2 while we are initializing effects`
		while ${ISXEQ2.InitializingActorEffects}
			wait 5
		;while Lavatar on Fiery Effigy of Clotl'thoa is less than 9 increments
		while ${Actor["Fiery Effigy of Clotl'thoa"].Effect[1].CurrentIncrements}<8 && ${Actor["Fiery Effigy of Clotl'thoa"](exists)} 
		{
			;if ${Math.Distance[]}>2
				RI_Atom_ChangeLockSpot ALL -3338.872559 10.002500 86.951920
			if ${Target.ID}!=${Actor["Fiery Effigy of Clotl'thoa"].ID} && ${Actor["Fiery Effigy of Clotl'thoa"](exists)} && !${RI_Var_Bool_GlobalOthers}
				Actor["Fiery Effigy of Clotl'thoa"]:DoTarget
			wait 5
		}
		;while Lavatar increments are greater than 0
		while ${Actor["Fiery Effigy of Clotl'thoa"].Effect[1].CurrentIncrements}>0 && ${Actor["Fiery Effigy of Clotl'thoa"](exists)} 
		{
			;if ${Math.Distance[]}>2
				RI_Atom_ChangeLockSpot ALL -3327.887939 10.002500 63.727303
			if ${Actor[fanatic,radius,35](exists)} && !${Actor[fanatic,radius,35].IsDead}
				target fanatic
			elseif ${Actor[hunter,radius,15](exists)} && !${Actor[hunter,radius,15].IsDead}
				target hunter
			elseif ${Actor[lavacrafter,radius,15](exists)} && !${Actor[lavacrafter,radius,15].IsDead}
				target lavacrafter
			elseif ${Target.ID}!=${Actor["Fiery Effigy of Clotl'thoa"].ID} && ${Actor["Fiery Effigy of Clotl'thoa"](exists)}
				Actor["Fiery Effigy of Clotl'thoa"]:DoTarget
			wait 5
		}
		wait 5
	}
	while ${Actor["Fiery Effigy of Clotl'thoa"](exists)} && !${Actor["Fiery Effigy of Clotl'thoa"].IsDead}
	RI_Atom_ChangeLockSpot ALL -3334.001270 11.490292 76.188400
	wait 30
}
function Bitterman()
{
	AnnounceText:Clear
	AnnounceText:Insert["has a gross barnacle growing on their neck"]
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} 1.62 17.330944 -35.689749 2 100
		while ${Actor[Query, Name=="Barnacle Bitterman" && IsDead=FALSE].Distance}>10
		{
			if ${Target.ID}!=${Actor["Barnacle Bitterman"].ID}
				Actor["Barnacle Bitterman"]:DoTarget
			wait 1
		}
		RI_Atom_SetLockSpot ${Me.Name} -23.322641 17.330944 -36.689749 2 100
		wait 100 ${Math.Distance[${Me.Loc},-23.322641,17.330944,-36.689749]}<2
		wait 100 ${Actor["Barnacle Bitterman"].Distance}<10
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor["Barnacle Bitterman"].ID} 30 99 ${Me.Name}
	}
	while ${Actor[Query, Name=="Barnacle Bitterman" && IsDead=FALSE](exists)} && ${Start}
	{
		if ${Trigger}
		{
			;echo ${Time}: Saw Announce, Waiting for a barnacle to appear
			wait 50 ${Actor["a barnacle"](exists)}
			;echo ${Time}: Saw a barnacle, targeting
			eq2ex target "a barnacle"
			;echo ${Time}: Waiting while a barnacle exists or is dead
			wait 100 !${Actor["a barnacle"](exists)} || ${Actor["a barnacle"].IsDead}
			;echo ${Time}: a barnacle is gone.
			Trigger:Set[FALSE]
		}
		elseif !${RI_Var_Bool_GlobalOthers}
			Actor["Barnacle Bitterman"]:DoTarget
		;if ${TargetID}!=${Target.ID} && ${Target.ID}!=0
		wait 1
	}
}
function D'Nari()
{
	AnnounceText:Clear
	AnnounceText:Insert["You feel a chill"]
	Trigger:Set[FALSE]
	RI_Atom_SetLockSpot ALL 260 0 -10 2 100
	wait 20
	if !${RI_Var_Bool_GlobalOthers}
		Target Sculpted
	wait 10
	while ${Actor["D'Nari"](exists)} && !${Actor["D'Nari"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["D'Nari"].ID}
				Actor["D'Nari"]:DoTarget
			if ${Trigger}
			{
				Trigger:Set[FALSE]
				if ${Math.Distance[${Me.X},${Me.Z},260,-10]}<10
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_ChangeLockSpot ALL 260 0 -35
				if ${Math.Distance[${Me.X},${Me.Z},260,-35]}<10
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_ChangeLockSpot ALL 260 0 -10
				wait 30
			}
		}
		if ${Me.SubClass.Equal[coercer]} && ${Me.Ability[Silence VII].IsReady}
		{
			;pause bots
			RI_CMD_PauseCombatBots 1
			
			;cancel spellcast and clear ability queue
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue 
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;keep attempting to cast Silence VII until it is no longer ready (aka casted)
			do
			{
				Me.Ability["Silence VII"]:Use
				waitframe
			}
			while ${Me.Ability["Silence VII"].IsReady}
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;unpause bots
			RI_CMD_PauseCombatBots 0
		}
		wait 2
	}
}
function BilgewaterSigCheck()
{
	if ${QuestJournalWindow.ActiveQuest[Shattered Seas: Pirates' Plot](exists)}
	{
		wait 50
		call ClickActor "treasure chest"
		wait 50
		call _Move3 29.190001 146.789993 -432.470001
		call _Move3 19.200871 146.794250 -431.640961
		call _Move3 9.285765 145.558548 -432.394592
		call _Move3 0.140608 146.540344 -436.983978
		call _Move3 -9.566537 148.135559 -438.805328
		call _Move3 -18.144396 146.794250 -436.691406
		call ClickActor exp11_sig_ts_x3_shissar_artifact
		call _Move3 -18.144396 146.794250 -436.691406
		wait 20
		call _Move3 -18.144396 146.794250 -436.691406
		call UseItem "Ancient Arcane Artifact"
		call _Move3 -18.144396 146.794250 -436.691406
		call ReplyDialog 3
		call _Move3 -18.144396 146.794250 -436.691406
		wait 50
		call _Move3 -8.516136 146.865738 -433.447266
		call _Move3 1.124704 147.371826 -430.521515
		call _Move3 11.027602 146.794266 -429.241058
		call _Move3 21.025633 146.794250 -431.802307
		call _Move3 29.013916 146.794250 -431.079285
		call ClickActor "treasure chest"
		wait 50
	}
}
function Bilgewater()
{
	if !${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ${Me.Name} 125 149.59 -361.48 2 100 ${Me.Name}
	else
		RI_Atom_MoveBehind ALL ${Actor["Captain Berlon Bilgewater"].ID} 100 100
	while ${Actor["Captain Berlon Bilgewater"](exists)} && !${Actor["Captain Berlon Bilgewater"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a skeletal crew member"](exists)}
				Actor["a skeletal crew member"]:DoTarget
			elseif ${Target.ID}!=${Actor["Captain Berlon Bilgewater"].ID} 
				Actor["Captain Berlon Bilgewater"]:DoTarget
		}
		wait 1
	}
}
function Cruikshank()
{
	RI_Atom_SetLockSpot ${Me.Name} -166.73 7.62 -160.22 2 100
	
	while ${Actor["Torturer Cruikshank the Mad"](exists)} && !${Actor["Torturer Cruikshank the Mad"].IsDead}
	{
		if ${Math.Distance[${Me.Loc},-166.73,7.62,-160.22]}>5
			press ${RI_Var_String_JumpKey}
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["Torturer Cruikshank the Mad"].ID} 
				Actor["Torturer Cruikshank the Mad"]:DoTarget
		}
		wait 1
	}
	press ${RI_Var_String_JumpKey}
	wait 2
	press ${RI_Var_String_JumpKey}
}
function Krasnok()
{
	echo ISXRI: Starting Krasnok 
	
	;turn on lockspot
	RI_Atom_SetLockSpot ${Me.Name} -309.81 15.26 -83.11 2 100
	
	;if i am a fighter target captain
	if !${RI_Var_Bool_GlobalOthers}
		Actor["Captain Krasnok the Immortal"]:DoTarget
		
	;wait until we are at camp
	wait 500 ${Math.Distance[${Me.Loc},-309.81,15.26,-83.11]}<3
	
	;if i am a bard move cannons
	if ${Me.Class.Equal[bard]}
		call _MoveCannons
		
	;while captain exists and is alive
	while ${Actor["Captain Krasnok the Immortal"](exists)} && !${Actor["Captain Krasnok the Immortal"].IsDead}
	{
		;if i am a bard and cannoneer exists, get cannonball and find and kill them
		if ${Me.Class.Equal[bard]} && ${Actor["Bloodskull Cannoneer"](exists)}
		{
			call GetCannonBall
			call FindCannoneerAndKill
		}
		
		;if i am a fighter target crewmembers then captain
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a Brokenskull crewmember"](exists)}
				Actor["a Brokenskull crewmember"]:DoTarget
			elseif ${Target.ID}!=${Actor["Torturer Cruikshank the Mad"].ID} 
				Actor["Torturer Cruikshank the Mad"]:DoTarget
		}
		wait 1
	}
	echo Ending Krasnok
}
function FindCannoneerAndKill()
{
	declare CannoneerX int ${Actor["Bloodskull Cannoneer"].X}
	switch ${CannoneerX}
	{
		case -307
		{
			call KillCannoneer -302.96 -99.02
			break
		}
		case -262
		{
			call KillCannoneer -286.70 -84.10
			break
		}
		case -282
		{
			call KillCannoneer -301.16 -68.67
			break
		}
		case -347
		{
			call KillCannoneer -329.67 -72.20
			break
		}
		case -366
		{
			call _MoveC -335.53 -61.68
			call _MoveC -339.36 -58.03
			call _MoveC -334.21 -53.06
			call _MoveC -343.31 -48.07
			call _MoveC -343.28 -44.36
			wait 10
			Face -341.76 -45.42
			wait 10
			call KillCannoneer -341.76 -45.42
			break
		}
		case -303
		{
			call KillCannoneer -319.51 -53.92
			break
		}
	}
}
function KillCannoneer(float kcX, float kcZ)
{
	;move to Cannon
	call _MoveC ${kcX} ${kcZ}
	
	wait 5
	
	;load and fire cannon
	eq2ex apply_verb ${Actor["a cannon"].ID} "Load Cannon"
	wait 10
	eq2ex apply_verb ${Actor["a cannon"].ID} "Fire Cannon"
	wait 10
	
	;move back to camp
	call _MoveC -309.81 -83.11
	
	;turn on assisting
	RI_CMD_Assisting 1
	
	;wait 15s
	wait 150
}
function GetCannonBall()
{
	;turn off assisting
	RI_CMD_Assisting 0
	
	;target self
	Actor[${Me.ID}]:DoTarget

	if !${Me.Inventory["a heavy cannonball"](exists)}
	{
		;move to cannonball
		call _MoveC -311.85 -74.5
		
		;get cannonball
		while !${Me.Inventory["a heavy cannonball"](exists)}
		{
			Actor[cannonballs]:DoubleClick
			wait 5
		}
				
		;move back to camp
		call _MoveC -309.81 -83.11
	}
}
function _MoveCannons()
{
	;turn off assisting
	RI_CMD_Assisting 0
	
	;target self
	Actor[${Me.ID}]:DoTarget
	
	;move cannon1
	call _MoveCannon	-301.40 -98.80 -302.96 -99.02
	
	;move cannon2
	call _MoveCannon -288.70 -87.26 -286.70 -84.10
	
	;move cannon3
	call _MoveCannon -309.65 -70.37 -301.16 -68.67 
	
	;move cannon4
	call _MoveCannon -315.13 -75.17 -329.67 -72.20
	
	;move cannon5
	;move to cannon
	call _MoveC -331.23 -62.59
	
	;change camera, pick up Cannon
	Press -hold "Page Down"
	wait 5
	Actor["a cannon"]:DoubleClick
	wait 5
	
	;move to and face position
	call _MoveC -335.53 -61.68
	call _MoveC -339.36 -58.03
	call _MoveC -334.21 -53.06
	call _MoveC -343.31 -48.07
	call _MoveC -343.28 -44.36
	wait 10
	Face -341.76 -45.42
	wait 10
	
	;move mouse to just above center of screen aka on top of you and up
	Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[(${Display.Height}/2)-((${Display.Height}/2)*.1)]}]
	wait 2
	
	;click to place
	Mouse:LeftClick
	
	wait 10
	
	;move cannon6
	call _MoveCannon -328.29 -57.28 -319.51 -53.92
	
	;turn on assisting
	RI_CMD_Assisting 1
	
	wait 5
	Press -release "Page Down"
	Press -hold "Page Up"
	wait 2
	Press -release "Page Up"
	
	;move back to camp
	call _MoveC -309.81 -83.11

}
function _MoveCannon(float mcX, float mcZ, float mcX2, float mcZ2)
{
	echo Moving To ${mcX} ${mcZ} and Placing Cannon at {mcX2} ${mcZ2}
	;move to cannon
	call _MoveC ${mcX} ${mcZ}
	
	;change camera, pick up Cannon
	Press -hold "Page Down"
	wait 5
	Actor["a cannon"]:DoubleClick
	wait 5
	
	;move to and face position
	call _MoveC ${mcX2} ${mcZ2}
	Face ${mcX2} ${mcZ2}
	wait 10
	
	;move mouse to just above center of screen aka on top of you and up
	Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[(${Display.Height}/2)-((${Display.Height}/2)*.1)]}]
	wait 2
	
	;click to place
	Mouse:LeftClick
	
	wait 10
}
function K'Deru()
{
	if ${RI_Var_Bool_GlobalOthers}
		RI_Atom_MoveBehind ALL ${Actor["K'Deru"].ID} 100 100
	else
		RI_Atom_MoveBehind ALL ${Actor["K'Deru"].ID} 100 100
	while ${Actor["K'Deru"](exists)} && !${Actor["K'Deru"].IsDead}
	{
		if ${Target.ID}!=${Actor["K'Deru"].ID} && !${RI_Var_Bool_GlobalOthers}
			Actor["K'Deru"]:DoTarget
		wait 1
	}
}
;
;
;;;;;; Ossuary: Sanguine Fountains
;
;
function Sanguine()
{
	;if we are mage turn off absorb magic in bots
	if ${Me.Archetype.Equal[mage]}
		RI_CMD_AbilityEnableDisable "Absorb Magic" 0
	;set announce trigger
	AnnounceText:Clear
	AnnounceText:Insert[The Sanguine Fiend aims his splinters]
	RI_Atom_SetLockSpot all 70 0 -24 2 100
	wait 20
	variable int _SanguineID=${Actor["The Sanguine Fiend"].ID}
	if ${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot off
		RI_Atom_MoveBehind ALL ${Actor["The Sanguine Fiend"].ID} 100 99
	}
	while ${Actor["The Sanguine Fiend"](exists)} && !${Actor["The Sanguine Fiend"].IsDead}
	{
		if ${Actor[welp](exists)} && !${Actor[welp].IsDead} && !${RI_Var_Bool_GlobalOthers}
		{
			Actor[welp]:DoTarget
			if ( ${Math.Distance[${Actor[welp].X},${Actor[welp].Z},91,-52]}<10 || ${Math.Distance[${Actor[welp].X},${Actor[welp].Z},91,2]}<10 )
			{
				RI_Atom_ChangeLockSpot ALL 82.68 -0.46 -23.51
				while ${Actor[welp](exists)}
					wait 1
				RI_Atom_ChangeLockSpot ALL 70 0 -24
			}
			while ${Actor[welp](exists)}
				wait 1
		}
		elseif ${Actor["a Sanguine Fiend",radius,20](exists)} && !${Actor["a Sanguine Fiend",radius,20].IsDead} && !${RI_Var_Bool_GlobalOthers}
			Actor["a Sanguine Fiend",radius,20]:DoTarget
		elseif ${Target.ID}!=${Actor["The Sanguine Fiend"].ID} && !${RI_Var_Bool_GlobalOthers}
			Actor["The Sanguine Fiend"]:DoTarget
		if ${Trigger} && ${RI_Var_Bool_GlobalOthers}
		{
			Trigger:Set[FALSE]
			echo ${TriggerMessage}
			if ${TriggerMessage.Equal[The Sanguine Fiend aims his splinters behind him! WATCHOUT!]}
			{
				echo moving in front
				RI_Atom_SetLockSpot off
				RI_Atom_MoveBehind ALL OFF
				RI_Atom_MoveInFront ALL ${Actor["The Sanguine Fiend"].ID} 100 100
			}
			if ${TriggerMessage.Equal[The Sanguine Fiend aims his splinters in front of him! WATCHOUT!]}
			{
				echo Moving behind
				RI_Atom_SetLockSpot off
				RI_Atom_MoveInFront ALL OFF
				RI_Atom_MoveBehind ALL ${Actor["The Sanguine Fiend"].ID} 100 100
			}
			if ${TriggerMessage.Equal[The Sanguine Fiend aims his splinters far from him! WATCHOUT!]} && ${Actor["The Sanguine Fiend"].Distance}>10
			{
				RI_Atom_SetLockSpot off
				RI_Atom_MoveBehind ALL OFF
				RI_Atom_MoveInFront ALL OFF
				echo moving close
				while ${Actor["The Sanguine Fiend"].Distance}>4
				{
					Actor["The Sanguine Fiend"]:DoFace
					press -hold ${RI_Var_String_ForwardKey}
					wait 1
				}
				press -release ${RI_Var_String_ForwardKey}
			}
			if ${TriggerMessage.Equal[The Sanguine Fiend aims his splinters close to him! WATCHOUT!]} && ${Actor["The Sanguine Fiend"].Distance}<10
			{
				RI_Atom_SetLockSpot off
				RI_Atom_MoveBehind ALL OFF
				RI_Atom_MoveInFront ALL OFF
				echo moving away
				while ${Actor["The Sanguine Fiend"].Distance}<16
				{
					Actor["The Sanguine Fiend"]:DoFace
					press -hold ${RI_Var_String_BackwardKey}
					wait 1
				}
				press -release ${RI_Var_String_BackwardKey}
			}
			TimedCommand 120 RI_Atom_MoveBehind ALL ${Actor["The Sanguine Fiend"].ID} 100 99
		}
		;if we are a mage watch for hardened bones and cast absorb magic
		if ${Me.Archetype.Equal[mage]}
		{
		
			;if we see "hardened bones" (MainIconID=) on "The Sanguine Fiend", pause bot, stop casting and cast Absorb Magic
			if ${RIObj.MainIconIDExists[${_SanguineID},]} && ${Me.Ability[id,1812025739].IsReady}
			{
				;turn off assisting
				RI_CMD_Assisting 0
				
				;pause bots
				RI_CMD_PauseCombatBots 1
				
				;target "The Sanguine Fiend"
				Actor[Query, ID="${_SanguineID}"]:DoTarget
				
				;cancel spellcast and clear ability queue
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;keep attempting to cast absorb magic (ID=1812025739) until it is no longer ready (aka casted)
				do
				{
					if ${Target.ID}==${_SanguineID}
						Me.Ability[id,1812025739]:Use
					else
						Actor[Query, ID="${_SanguineID}"]:DoTarget
					wait 1
				}
				while ${Me.Ability[id,1812025739].IsReady}
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;turn on assisting
				RI_CMD_Assisting 1
				
				;unpause bots
				RI_CMD_PauseCombatBots 0
			}
		}
		wait 5
	}
	;if we are mage turn on absorb magic
	if ${Me.Archetype.Equal[mage]}
		RI_CMD_AbilityEnableDisable "Absorb Magic" 1
}
function V'Raudin()
{
	if ${Me.Ability[Singular Focus].IsReady}
		Me.Ability[Singular Focus]:Use
	elseif ${Me.Ability[Focus Offensive].IsReady}
		Me.Ability[Focus Offensive]:Use
	wait 20
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[screams at]
	RI_Atom_SetLockSpot ${Me.Name} 414 -11 -24 2 100
	call _MoveC 414 -24
	if ${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot OFF
		RI_Atom_MoveBehind ALL ${Actor["V'Raudin"].ID} 30 99
	}
	wait 20
	;if we are an enchanter, disable manasoul in ogre for 60s
	; if ${Me.Class.Equal[enchanter]}
	; {
		; OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Manasoul" FALSE
		; TimedCommand 600 OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Manasoul" TRUE
	; }
	while ${Actor["V'Raudin"](exists)} && !${Actor["V'Raudin"].IsDead}
	{
		if ${Trigger} && ${Me.Class.Equal[enchanter]}
		{
			echo ${Time}: Found Trigger: ${TriggerMessage}: Casting Mana Flow on ${TriggerMessage.Left[${Math.Calc[${TriggerMessage.Find[screams]}-2]}]}
			Trigger:Set[FALSE]
			
			;pause bots
			RI_CMD_PauseCombatBots 1
			
			;cancel spellcast and clear ability queue
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue 
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;keep attempting to cast Manasoul until it is no longer ready (aka casted)
			do
			{
				;eq2ex useabilityonplayer ${TriggerMessage.Left[${Math.Calc[${TriggerMessage.Find[screams]}-2]}]} "Mana Flow"
				Me.Ability[Manasoul]:Use
				wait 1
			}
			while ${Me.Ability["Manasoul"].IsReady}
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;unpause bots
			RI_CMD_PauseCombatBots 0
		}
		if ${Target.ID}!=${Actor["V'Raudin"].ID} && !${RI_Var_Bool_GlobalOthers}
			Actor["V'Raudin"]:DoTarget
	}
	Me.Maintained[Singular Focus]:Cancel
	Me.Maintained[Focused Offensive]:Cancel
}
function Embodiment()
{
	;if we are mage turn off absorb magic
	if ${Me.Archetype.Equal[mage]}
		RI_CMD_AbilityEnableDisable "Absorb Magic" 0
		
	;set lockspots
	RI_Atom_SetLockSpot ALL 498.28 -0.05 -27.28 2 100
	wait 20
	call _MoveC 517.60 -66.26
	if ${RI_Var_Bool_GlobalOthers}
		RI_Atom_ChangeLockSpot ALL 511.39 -0.05 -53.79
	wait 20		
	variable int _EmbodimentID=${Actor["Embodiment"].ID}
	;while Emodiment exists and is not dead, target him or his adds if there up and absorb Enriched Blood
	while ${Actor["Embodiment"](exists)} && !${Actor["Embodiment"].IsDead}
	{
		while ${Actor["sanguine spray",radius,30](exists)} && !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["sanguine spray",radius,30].IsDead}
			{
				Actor["sanguine spray",radius,30]:DoubleClick
				eq2ex apply_verb ${Actor["sanguine spray",radius,30].ID} Loot
			}
			RI_Atom_ChangeLockSpot ALL 511.39 -0.05 -53.79
			Actor["sanguine spray",radius,30]:DoTarget
			wait 2
		}
		if !${RI_Var_Bool_GlobalOthers}
		{
			RI_Atom_ChangeLockSpot ALL 517.60 -0.47 -66.26
			if ${Target.ID}!=${Actor["Embodiment"].ID} && !${RI_Var_Bool_GlobalOthers}
				Actor["Embodiment"]:DoTarget
		}
		;if we are a mage watch for Enriched Blood and cast absorb magic
		if ${Me.Archetype.Equal[mage]}
		{
		
			;if we see "Enriched Blood" (MainIconID=) on "The Embodiment of Gore", pause bot, stop casting and cast Absorb Magic
			if ${RIObj.MainIconIDExists[${_EmbodimentID},]} && ${Me.Ability[id,1812025739].IsReady}
			{
				;turn off assisting
				RI_CMD_Assisting 0
				
				;pause bots
				RI_CMD_PauseCombatBots 1
				
				;target "The Sanguine Fiend"
				Actor[Query, ID="${_EmbodimentID}"]:DoTarget
				
				;cancel spellcast and clear ability queue
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;keep attempting to cast absorb magic (ID=1812025739) until it is no longer ready (aka casted)
				do
				{
					if ${Target.ID}==${_SanguineID}
						Me.Ability[id,1812025739]:Use
					else
						Actor[Query, ID="${_EmbodimentID}"]:DoTarget
					wait 1
				}
				while ${Me.Ability[id,1812025739].IsReady}
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;turn on assisting
				RI_CMD_Assisting 1
				
				;unpause bots
				RI_CMD_PauseCombatBots 0
			}
		}
		wait 5
	}
	;if we are mage turn on absorb magic
	if ${Me.Archetype.Equal[mage]}
		RI_CMD_AbilityEnableDisable "Absorb Magic" 1
}
function BosunRing()
{
	if !${RI_Var_Bool_GlobalOthers}
		relay ${RI_Var_String_RelayGroup} RI_Atom_SetLockSpot ALL -305.27 -123.61 -317.21
	while !${Actor[Bosun](exists)}
	{
		if ${Actor["Garrut Berogg"](exists)} && !${Actor["Garrut Berogg"].IsDead}
		{
			if ${Target.ID}!=${Actor["Garrut Berogg"].ID}
				Actor["Garrut Berogg"]:DoTarget
		}
		elseif ${Actor["a ruby emperor"](exists)}
		{
			if ${Target.ID}!=${Actor["a ruby emperor"].ID} && !${Actor["a ruby emperor"].IsDead}
				Actor["a ruby emperor"]:DoTarget
		}
		elseif ${Actor["Eggtender Varogg"](exists)} && ${Actor["Eggtender Varogg"].Distance}<10 && !${Actor["Eggtender Varogg"].IsDead}
		{
			if ${Target.ID}!=${Actor["Eggtender Varogg"].ID}
				Actor["Eggtender Varogg"]:DoTarget
		}
		elseif ${Actor["an urzarach webweaver"](exists)} && !${Actor["an urzarach webweaver"].IsDead}
		{
			if ${Target.ID}!=${Actor["an urzarach webweaver"].ID}
				Actor["an urzarach webweaver"]:DoTarget
		}
		wait 1
	}
	while ${Actor["Bosun Broogle"].Health}>25
		wait 2
		
	if !${RI_Var_Bool_GlobalOthers}
		call _MoveC ${Actor["Bosun Broogle"].X} ${Actor["Bosun Broogle"].Z}
	wait 10
	Actor["Bosun Broogle"]:DoubleClick
	wait 20
	if !${RI_Var_Bool_GlobalOthers}
	{
		echo moving behind
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetLockSpot off
		wait 2
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor["Veerach the Vile"].ID} 30 99
	}
	;echo right before while loop
	while ${Actor["Veerach the Vile"](exists)} && !${Actor["Veerach the Vile"].IsDead}
	{
		;echo in loop
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["Veerach the Vile"].ID}
				Actor["Veerach the Vile"]:DoTarget
			if ${CastAntidote}
			{
				Me.Ability["Vial of Antidote"]:Use
				CastAntidote:Set[FALSE]
				TimedCommand 100 Scripts[${RI_Var_String_RunInstancesScriptName}].Variable[CastAntidote2]:Set[TRUE]
			}
			elseif ${CastAntidote2}
			{
				eq2ex usea "Vial of Antidote"
				CastAntidote2:Set[FALSE]
			}
		}
		wait 1
	}
}
function Pinboggle()
{
	variable int PinboggleID=${Actor[Pinboggle].ID}
	while ${Actor[id,${PinboggleID}](exists)} && !${Actor[id,${PinboggleID}].IsDead} && ${RI_Var_Bool_Start}
	{
		if ${Actor["an electro-cell warbot",radius,35](exists)} && ${Actor["an electro-cell warbot",radius,35].IsAggro} && !${Actor["an electro-cell warbot",radius,35].IsDead} && !${RI_Var_Bool_GlobalOthers}
			Actor["an electro-cell warbot"]:DoTarget
		elseif !${RI_Var_Bool_GlobalOthers}
			Actor[id,${PinboggleID}]:DoTarget
		wait 1
	}
}
function Kaas()
{
	Actor[Zona]:DoTarget
	wait 40
	if !${RI_Var_Bool_GlobalOthers}
	{
		while ${Actor["Zona"].Distance}>2
		{
			Actor["Zona"]:DoFace
			press -hold ${RI_Var_String_ForwardKey}
			wait 1
		}
		press -release ${RI_Var_String_ForwardKey}
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z} 2 100
	}
	wait 20
	;pause bots
	RI_CMD_PauseCombatBots 1
	eq2ex cancel_spellcast
	eq2ex clearabilityqueue
	wait 2
	relay ${RI_Var_String_RelayGroup} -noredirect Me.Inventory["Zov'Vyl Crystal"]:Use
	wait 2
	relay ${RI_Var_String_RelayGroup} -noredirect Me.Inventory["Zov'Vyl Crystal"]:Use
	wait 2
	relay ${RI_Var_String_RelayGroup} -noredirect Me.Inventory["Zov'Vyl Crystal"]:Use
	;unpause bots
	RI_CMD_PauseCombatBots 0
	if ${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot OFF
		RI_Atom_MoveBehind ALL ${Actor["Zona"].ID} 30 100
	}
	while ${Actor[Kaas](exists)} && !${Actor[Kaas].IsDead} && ${RI_Var_Bool_Start}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			while ${Actor[Zona](exists)}
			{
				Actor[Zona]:DoTarget
				wait 1
			}
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor[Zom].ID} 30 100
			while ${Actor[Zom](exists)}
			{
				Actor[Zom]:DoTarget
				wait 1
			}
		}
		wait 1
	}
}
function Vaz'Din()
{
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} 139.20 -50.35 27.42 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[1].Name} 159.35 -50.18 21.75 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[2].Name} 148.19 -50.18 10.59 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[3].Name} 152.51 -50.31 31.19 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[4].Name} 153.34 -50.18 17.12 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[5].Name} 142.08 -50.35 17.50 1 100
	}
	while ${Actor["Vaz'Din"](exists)} && !${Actor["Vaz'Din"].IsDead} && ${RI_Var_Bool_Start}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor["Vaz'Din"]:DoTarget
		}
		wait 1
	}
}
function Sha'Kaz()
{
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} 139.20 -50.35 27.42 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[1].Name} 159.35 -50.18 21.75 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[2].Name} 148.19 -50.18 10.59 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[3].Name} 152.51 -50.31 31.19 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[4].Name} 153.34 -50.18 17.12 1 100
		relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ${Me.Group[5].Name} 142.08 -50.35 17.50 1 100
	}
	declare ShakazID int ${Actor["Sha'Kaz"].ID}
	while ${Actor[${ShakazID}](exists)} && !${Actor[${ShakazID}].IsDead} && ${RI_Var_Bool_Start}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor[${ShakazID}]:DoTarget
		}
		wait 1
	}
}
function Echo()
{	

	;set lockspot at 88.45 -49.44 45.85
	RI_Atom_SetLockSpot ${Me.Name} 88.45 -49.44 45.85 1 100
	
	;if we are a fighter target
	if !${RI_Var_Bool_GlobalOthers}
		Actor["Echo of Mikazha"]:DoTarget
		
	;wait while we are more than 2 away from 88.45 45.85, and cast rescue
	while ${Math.Distance[${Me.X},${Me.Z},88.45,45.85]}>2
	{
		if ${Me.Ability[Rescue].IsReady}
			Me.Ability[Rescue]:Use
		wait 1
	}
	
	;if we are not a fighter turn off lockspot and move behind
	if ${Me.Archetype.NotEqual[fighter]}
	{
		RI_Atom_SetLockSpot off
		RI_Atom_MoveBehind ALL ${Actor["Echo of Mikazha"].ID} 30 100
	}
	
	;while Echo of Mikazha exists and is not dead, wait
	while ${Actor["Echo of Mikazha"](exists)} && !${Actor["Echo of Mikazha"].IsDead}
	{
		if ${EQ2.CustomActorArraySize}<1
			EQ2:CreateCustomActorArray[byDist,25]
		variable int count
		variable int ID
		for(count:Set[1];${count}<=${EQ2.CustomActorArraySize};count:Inc)
		{
			ID:Set[${CustomActor[${count}].ID}]
			if (${Actor[id,${ID}].Type.Equal[NPC]} || ${Actor[id,${ID}].Type.Equal[NamedNPC]}) && ${Actor[id,${ID}].InCombatMode} && ${Actor[id,${ID}].Target.ID}!=${Me.ID} && !${Actor[id,${ID}].IsDead}
			{
				;echo targeting ${Actor[id,${ID}]} because they are not targeting me
				while ${Actor[id,${ID}].Target.ID}!=${Me.ID} && ${Actor[id,${ID}](exists)} && !${Actor[id,${ID}].IsDead}
				{
					if ${Target.ID}!=${ID}
						Actor[id,${ID}]:DoTarget
					wait 2
				}
			}
			wait 1
			;echo checking ${count}
		}
		Actor["Echo of Mikazha"]:DoTarget
		wait 2
	}
}

;TargetSelf Function
function TargetSelf()
{
	;target Me
	Target ${Me}
	
	;while We have the detrimental Taskmaster's Reprimand I, wait 1
	while ${Me.Effect[detrimental,Taskmaster's Reprimand I](exists)}
	{
		Target ${Me}
		wait 1
	}
	
	Actor["Echo of Mikazha"]:DoTarget
}

;
;
;;;;;; SSRA InnerSanctum
;
;
function Pov()
{
	echo ISXRI: ${Time}: Starting Pov

	RIMUIObj:SetLockSpot[ALL,378.702728,-88.344337,66.403709]
	wait 5

	;else
	;{
		Actor[Pov]:DoTarget
		while !${Me.RangedAutoAttackOn}
		{
			eq2ex togglerangedattack
			wait 1
		}
	;}
	wait 50
	if ${RI_Var_Bool_GlobalOthers}
		RI_Obj_CB:SetUISetting[SettingsSkipMobAttackHealthCheckBox,0]
		
	while ${Actor[Pov](exists)} && !${Actor[Pov].IsDead} && ${RI_Var_Bool_Start}
	{
		if ${Actor["a Senshali Shadow",radius,35](exists)} && ${Actor["a Senshali Shadow",radius,35].IsAggro} && !${Actor["a Senshali Shadow",radius,35].IsDead} && !${RI_Var_Bool_GlobalOthers}
		{
			RIObj:BalanceMobs["a Senshali Shadow"]	
		}
		elseif !${RI_Var_Bool_GlobalOthers}
			Actor[Pov]:DoTarget
		wait 1
		if (${Me.GetGameData[Target.Casting].Label.Equal[Will of the Senshali]} || ${Me.GetGameData[ImpliedTarget.Casting].Label.Equal[Will of the Senshali]})
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetLockSpot[ALL,377.9,-114.55,78.01]
				RIMUIObj:SetLockSpot[${Me.Name},377.5,-116.16,103.75]
				while ${Math.Distance[${Me.X},${Me.Z},377.5,104.75]}>3
					wait 1
				while ${Actor[Pov].Distance}>8
					wait 1
				wait 10
				RIMUIObj:SetLockSpot[${Me.Name},377.25,-116.16,105.75]
				relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetLockSpot[OFF]
				relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor[Pov].ID} 30 100
			}
		}
	}
	call _Move3 373.265991 -116.161865 95.464760
	relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[OFF]
	
}

function Stonefang()
{
	AnnounceText:Insert[Stonefang starts shedding his stoney scales!]
	;AnnounceText:Insert[You find safety behind the wall!]
	AnnounceText:Insert[Stonefang fills each room with clouds of poisonous dust!]

	RIMUIObj:SetLockSpot[ALL,229.427933,-101.081787,53.755280]
	
	wait 10
	Actor[Stonefang]:DoTarget
	while ${Actor[Stonefang](exists)} && !${Actor[Stonefang].IsDead} && ${RI_Var_Bool_Start}
	{
		if !${RI_Var_Bool_GlobalOthers}
			Actor[Stonefang]:DoTarget
		
		if ${Trigger}
		{
			Trigger:Set[FALSE]
			call _Move3 246.832962 -103.415260 54.349815
			call _Move3 244.436279 -101.384964 57.843193
			
			; if ${TriggerMessage.Find[stoney scales](exists)}
			; {
				; while !${TriggerMessage}
					; wait 2
				; Trigger:Set[FALSE]
			; }
			; else
			;{
				wait 50
			;}
			if !${Trigger}
			{
				call _Move3 246.832962 -103.415260 54.349815
				RIMUIObj:SetLockSpot[ALL,229.427933,-101.081787,53.755280]
			}
		}
		wait 1
	}
	relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom a_LetsGo all
}

function Kessatras()
{
	echo ISXRI: Starting Kessatras v1
	
	;turn on lockspot at 223.42 -83.34 55.40
	RIMUIObj:SetLockSpot[ALL,223.42,-83.34,55.40]
	
	;main loop, while Kessatras is alive and exists
	while ${Actor["Kessatras Sonssiu"](exists)} && !${Actor["Kessatras Sonssiu"].IsDead}
	{
		;if im a fighter, keep my target on Kessatras
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["Kessatras Sonssiu"].ID}
				Actor["Kessatras Sonssiu"]:DoTarget
		}
		
		;if i have the detrimental Hypnoitic Vision
		if ${RIMUIObj.MainIconIDExists[${Me.ID},577]}
		{
			;reset Lockspot and move the group to my location
			relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z}]
			
			;while I still have the detrimental, loop
			while ${RIMUIObj.MainIconIDExists[${Me.ID},577]}
			{
				;while the group is more than 3 units from me, loop
				while ${Me.Group[1].Distance}>3 && ${Me.Group[2].Distance}>3 && ${Me.Group[3].Distance}>3 && ${Me.Group[4].Distance}>3 && ${Me.Group[5].Distance}>3
				{	
					relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z}]
					wait 1
				}	
				;everyone click the statue
				relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
				wait 1
			}
			
			;set lockspot to original location, 223.42 -83.34 55.40
			relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,223.42,-83.34,55.40]
		}
		
		;if I have the detrimental Manic Mind (aka, Fear)
		;if ${Me.Effect[detrimental,"Manic Mind"](exists)}
		;{
			;start walking
		;	press shift+r
			
			;loop while I have the detrimental, Manic Mind
		;	while ${Me.Effect[detrimental,"Manic Mind"](exists)}
		;		wait 1
				
			;start running
		;	press shift+r
		;}
		wait 1
	}
	echo ISXRI: Ending Kessatras v1
}

function Xon'Xiu()
{
	echo ISXRI: ${Time}: Starting XonXiu
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert["lest the spirits herein tear apart your mortal form"]
	;set lockspot and engage mob
	RIMUIObj:SetLockSpot[ALL,244.075272,-65.208748,55.773190]
	
	while ${Actor["Kesa'Tra Xon'Xiu"](exists)} && !${Actor["Kesa'Tra Xon'Xiu"].IsDead}
	{
		if ${Trigger}
		{
			if ${Actor["Kesa'Tra Xon'Xiu"].Health}>12 && !${RI_Var_Bool_GlobalOthers}
				call DodgeEchoes
			else
			{
				if !${RI_Var_Bool_GlobalOthers}
				{
					RIMUIObj:SetLockSpot[${Me.Name},207.51,-65.128748,54.273190]
					wait 10
					relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetLockSpot[ALL,207.51,-65.128748,54.273190]
				}
			}
		}
	}
}

function DodgeEchoes()
{
	variable bool MovingToSecond=FALSE
	wait 50
	echo ${Time}: Waiting for Kesa'Tra Xon'Xiu to Become Aggro Again
	while !${Actor["Kesa'Tra Xon'Xiu"].IsAggro} && ${Actor["Kesa'Tra Xon'Xiu"](exists)} && !${Actor["Kesa'Tra Xon'Xiu"].IsDead}
		wait 1
	echo ${Time}: Kesa'Tra Xon'Xiu Has Become Aggro Again, Starting Dodging
	wait 10 
	while ${Actor["an echo reflection"](exists)}
	{
		if ${Actor["an echo reflection"](exists)}
		{
			echo ${Time}: Moving to first corner
			RIMUIObj:SetLockSpot[${Me.Name},211.538010,-65.634575,102.540901]
			wait 10
			relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[ALL,211.538010,-65.634575,102.540901]
			echo ${Time}: Waiting until we get to first corner
			while ${Math.Distance[${Me.X},${Me.Z},212,102]}>5 && ${Actor["an echo reflection"](exists)}
				wait 1
			wait 20
			echo ${Time}: Waiting until Kesa'Tra Xon'Xiu is within 10m
			while ${Math.Distance[${Me.X},${Me.Z},${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z}]}>10 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until an echo is within 15m of Kesa'Tra Xon'Xiu
			while ${Actor["an echo reflection"](exists)} && ${Math.Distance[${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z},${Actor["an echo reflection"].X},${Actor["an echo reflection"].Z}]}>15
				wait 1
		}
		if ${Actor["an echo reflection"](exists)}
		{
			MovingToSecond:Set[TRUE]
			echo ${Time}: Moving to second corner
			relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[ALL,274.871124,-65.617584,102.805832]
			echo ${Time}: Waiting until we get to second corner
			while ${Math.Distance[${Me.X},${Me.Z},275,102]}>5 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until Kesa'Tra Xon'Xiu is within 10m
			while ${Math.Distance[${Me.X},${Me.Z},${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z}]}>10 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until an echo is within 15m of Kesa'Tra Xon'Xiu
			while ${Actor["an echo reflection"](exists)} && ${Math.Distance[${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z},${Actor["an echo reflection"].X},${Actor["an echo reflection"].Z}]}>15
				wait 1
		}
		if ${Actor["an echo reflection"](exists)}
		{
			MovingToSecond:Set[FALSE]
			echo ${Time}: Moving to third corner
			relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[ALL,274.762207,-65.616768,6.784461]
			echo ${Time}: Waiting until we get to third corner
			while ${Math.Distance[${Me.X},${Me.Z},275,7]}>5 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until Kesa'Tra Xon'Xiu is within 10m
			while ${Math.Distance[${Me.X},${Me.Z},${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z}]}>10 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until an echo is within 15m of Kesa'Tra Xon'Xiu
			while ${Actor["an echo reflection"](exists)} && ${Math.Distance[${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z},${Actor["an echo reflection"].X},${Actor["an echo reflection"].Z}]}>15
				wait 1
		}
		if ${Actor["an echo reflection"](exists)}
		{
			echo ${Time}: Moving to fourth corner
			relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[ALL,216.707535,-65.606873,7.913361]
			echo ${Time}: Waiting until we get to fourth corner
			while ${Math.Distance[${Me.X},${Me.Z},217,8]}>5 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until Kesa'Tra Xon'Xiu is within 10m
			while ${Math.Distance[${Me.X},${Me.Z},${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z}]}>10 && ${Actor["an echo reflection"](exists)}
				wait 1
			echo ${Time}: Waiting until an echo is within 15m of Kesa'Tra Xon'Xiu
			while ${Actor["an echo reflection"](exists)} && ${Math.Distance[${Actor["Kesa'Tra Xon'Xiu"].X},${Actor["Kesa'Tra Xon'Xiu"].Z},${Actor["an echo reflection"].X},${Actor["an echo reflection"].Z}]}>15
				wait 1
		}

		wait 1
	}
	Trigger:Set[FALSE]
	if ${MovingToSecond}
	{
		wait 30
		MovingToSecond:Set[FALSE]
	}
	echo ${Time}: Moving to center
	relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:SetLockSpot[ALL,244.075272,-65.208748,55.773190]
}

function Lich()
{
	;IncomingText:Clear
	;IncomingText2:Clear
	;IncomingText:Insert["Need a cure curse!"]
	
	RIMUIObj:SetLockSpot[ALL,124.466675,-49.157383,55.329491]
	wait 10
	Actor[Lich]:DoTarget
	while ${Actor[Lich](exists)} && !${Actor[Lich].IsDead} && ${RI_Var_Bool_Start}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a portal defender",radius,35](exists)} && ${Actor["a portal defender",radius,35].IsAggro} && !${Actor["a portal defender",radius,35].IsDead}
				Actor["a portal defender"]:DoTarget
			elseif ${Actor["Vhen Ras Centien",radius,35](exists)} && ${Actor["Vhen Ras Centien",radius,35].IsAggro} && !${Actor["Vhen Ras Centien",radius,35].IsDead}
				Actor["Vhen Ras Centien"]:DoTarget
			elseif ${Actor["Toz Nak Xakra",radius,35](exists)} && ${Actor["Toz Nak Xakra",radius,35].IsAggro} && !${Actor["Toz Nak Xakra",radius,35].IsDead}
				Actor["Toz Nak Xakra"]:DoTarget
			elseif ${Actor["Des Kas Xakra",radius,35](exists)} && ${Actor["Des Kas Xakra",radius,35].IsAggro} && !${Actor["Des Kas Xakra",radius,35].IsDead}
				Actor["Des Kas Xakra"]:DoTarget
			elseif ${Actor["Rhag'Vozgath",radius,35](exists)}
				call Rhags
			else
				Actor[Lich]:DoTarget
		}
		if ${Actor["Vhen Ras Centien",radius,35](exists)} && ${Actor["Vhen Ras Centien",radius,35].IsAggro} && !${Actor["Vhen Ras Centien",radius,35].IsDead}
		{
			if ${Math.Distance[${Me.Loc},124.427200,-49.157383,69.211929]}>5
				call _Move3 124.427200 -49.157383 69.211929
		}
		elseif ${Actor["Toz Nak Xakra",radius,35](exists)} && ${Actor["Toz Nak Xakra",radius,35].IsAggro} && !${Actor["Toz Nak Xakra",radius,35].IsDead}
		{
			if ${Actor["Toz Nak Xakra",radius,35].Distance}>5
			{
				call _Move3 124.427200 -49.157383 69.211929
				call _Move3 ${Actor["Toz Nak Xakra",radius,35].X} ${Actor["Toz Nak Xakra",radius,35].Y} ${Actor["Toz Nak Xakra",radius,35].Z}
			}
		}
		elseif ${Actor["Des Kas Xakra",radius,35](exists)} && ${Actor["Des Kas Xakra",radius,35].IsAggro} && !${Actor["Des Kas Xakra",radius,35].IsDead}
		{
			if ${Actor["Des Kas Xakra",radius,35].Distance}>5
			{
				call _Move3 124.427200 -49.157383 69.211929
				call _Move3 ${Actor["Des Kas Xakra",radius,35].X} ${Actor["Des Kas Xakra",radius,35].Y} ${Actor["Des Kas Xakra",radius,35].Z}
			}
		}
		;if ${Trigger} && ${Me.Archetype.Equal[priest]} && ${Me.Ability[Cure Curse].IsReady} && ${Me.Cursed}!=0
		;	call CureMyCurse
		;else
		;	Trigger:Set[FALSE]
		wait 1
	}
}

function CureMyCurse()
{
	;pause bot
	RI_CMD_PauseCombatBots 1
	
	;cancel spellcast and clear ability queue
	eq2ex cancel_spellcast
	eq2ex clearabilityqueue 
	
	;wait until we are not casting
	wait 200 !${Me.CastingSpell}
	
	Actor[id,${Me.ID}]:DoTarget
	wait 1
	
	;keep attempting to cast Cure Curse until it is no longer ready (aka casted)
	do
	{
		Actor[id,${Me.ID}]:DoTarget
		eq2ex useabilityonplayer ${Me.Name} Cure Curse
		wait 1
	}
	while ${Me.Cursed}!=0
	
	;unpause ogre
	RI_CMD_PauseCombatBots 0
	
	Trigger:Set[FALSE]
}

function Rhags()
{
	;if !${RI_Var_Bool_GlobalOthers}
	;	relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${Actor[Pov].ID} 30 100
	while ${Actor["Rhag",radius,35](exists)} && !${RI_Var_Bool_GlobalOthers}
	{
		;initialize actor Fiery Effigy of Clotl'thoa's effects.
		;Actor["Rhag'Yalzzen"]:InitializeEffects

		;wait 2 while we are initializing effects`
		;while ${ISXEQ2.InitializingActorEffects}
		;	wait 2
		;;while Lavatar on Fiery Effigy of Clotl'thoa is less than 9 increments
		while ${Actor["Rhag'Yalzzen"].Effect["Infected Coating"].CurrentIncrements}<10 && ${Actor["Rhag'Yalzzen"](exists)} && !${Actor["Rhag'Yalzzen"].IsDead}
		{
			Actor["Rhag'Yalzzen"]:DoTarget
			wait 1
		}
		while ${Actor["Rhag'Yalzzen"].Effect["Infected Coating"].CurrentIncrements}>1 && ${Actor["Rhag'Yalzzen"](exists)} && !${Actor["Rhag'Yalzzen"].IsDead}
		{
			if ${Actor["Rhag'Vozgath"](exists)} && !${Actor["Rhag'Vozgath"].IsDead}
				Actor["Rhag'Vozgath"]:DoTarget
			else
				Actor[id,${Me.ID}]:DoTarget
			wait 1
		}
		Actor["Rhag"]:DoubleClick
		Actor["Rhag'Vozgath"]:DoTarget
		wait 5
	}
}
; function OgreGrindOptions(int OnOff)
; {
	; if ${ISXOgre(exists)}
	; {
		; if ${OnOff}==1
			; relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_grindoptions TRUE
		; else
			; relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom aExecuteAtom ALL a_UplinkControllerFunctionAutoType checkbox_settings_grindoptions FALSE
	; }
; }
function InnerSanctumCharm(int OnOff)
{
	if ${OnOff}==1
	{
		relay ${RI_Var_String_RelayGroup} -noredirect RI_DeTarget
	}
	else
	{
		if ${Script[Buffer:DeTarget](exists)}
			relay ${RI_Var_String_RelayGroup} -noredirect EndScript Buffer:Detarget
	}
}
function Kladnog()
{
	variable float CSX=6.79
	variable float CSY=-109.29
	variable float CSZ=29.98
	variable int CSpot=0
	echo ISXRI: Starting Kladnog v2
	RI_Atom_SetLockSpot ${Me.Name} ${CSX} ${CSY} ${CSZ} 1 100
	while ${Math.Distance[${Me.X},${Me.Z},${CSX},${CSZ}]}>2
		wait 1
	if ${Me.Archetype.NotEqual[fighter]}
	{
		;turn off assisting
		RI_CMD_Assisting 0
		; RI_Atom_SetLockSpot off
		; RI_Atom_MoveBehind ALL ${Actor["Kladnog"].ID} 30 100
		; removed move behind because it was causing issue with the puddles.
	}
	;main loop, while Kladnog is alive and exists
	while ${Actor["Kladnog Shralok"](exists)} && !${Actor["Kladnog Shralok"].IsDead}
	{
		if ${Actor["Disease Puddle",radius,10](exists)}
		{
			CSpot:Inc
			echo ${Time}: Disease Pool Found Incrementing CSpot to ${CSpot}
			switch ${CSpot}
			{
				case 1
					CSX:Set[3.06]
					CSY:Set[-109.52]
					CSZ:Set[12.62]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 2
					CSX:Set[-3.26]
					CSY:Set[-109.52]
					CSZ:Set[-2.76]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 3
					CSX:Set[-5.77]
					CSY:Set[-109.52]
					CSZ:Set[-25.48]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 4
					CSX:Set[-7.80]
					CSY:Set[-109.51]
					CSZ:Set[-45.36]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 5
					CSX:Set[-9.81]
					CSY:Set[-109.52]
					CSZ:Set[-64.36]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 6
					CSX:Set[2.10]
					CSY:Set[-109.52]
					CSZ:Set[-83.88]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 7
					CSX:Set[-22.13]
					CSY:Set[-109.52]
					CSZ:Set[-76.78]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 8
					CSX:Set[-21.20]
					CSY:Set[-109.51]
					CSZ:Set[-50.44]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 9
					CSX:Set[-2.75]
					CSY:Set[-109.52]
					CSZ:Set[-20.58]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 10
					CSX:Set[0.89]
					CSY:Set[-109.52]
					CSZ:Set[4.39]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
				case 11
					CSX:Set[6.79]
					CSY:Set[-109.29]
					CSZ:Set[29.98]
					echo ${Time}: Changing CampSpot to ${CSX} ${CSY} ${CSZ}
					break
			}
			; if ${Actor["Kladnog Shralok"].Target.ID}==${Me.ID} || !${RI_Var_Bool_GlobalOthers}
			; {
			RI_Atom_SetLockSpot ${Me.Name} ${CSX} ${CSY} ${CSZ} 1 100
			while ${Math.Distance[${Me.X},${Me.Z},${CSX},${CSZ}]}>2
				wait 1
			; }
			; else
				; wait 30
		}
		if ${Target.ID}!=${Actor["Kladnog Shralok"].ID}
			Actor["Kladnog Shralok"]:DoTarget
		;if Kladnog starts casting 
		if ${Me.GetGameData[Target.Casting].Label.Equal["Shralok Infection"]}
			call KMove
		; if ${Actor["Kladnog Shralok"].Target.ID}==${Me.ID}
			; RI_Atom_SetLockSpot ${Me.Name} ${CSX} ${CSY} ${CSZ} 1 100
		; elseif ${Me.Archetype.NotEqual[fighter]}
			; RI_Atom_SetLockSpot off
		wait 1
	}
	;turn on assisting
	RI_CMD_Assisting 1

		echo Ending Kladnog v2
}
function KMove()
{
	; RI_Var_Bool_MovingBehind:Set[FALSE]
	RI_Atom_SetLockSpot off
	while ${Target.Distance}<25 && ${Actor["Kladnog Shralok"](exists)} && !${Actor["Kladnog Shralok"].IsDead}
	{	
		Actor["Kladnog Shralok"]:DoFace
		Actor["Kladnog Shralok"]:DoTarget
		press -hold ${RI_Var_String_BackwardKey}
		wait 1
	}
	press -release ${RI_Var_String_BackwardKey}
	while ${Me.GetGameData[Target.Casting].Label.Equal["Shralok Infection"]}
		wait 1
	
	RI_Atom_SetLockSpot ${Me.Name} 6.79 -109.29 29.98 1 100
	while ${Math.Distance[${Me.X},${Me.Z},6.79,29.98]}>4
		wait 1
	; if ${Me.Archetype.NotEqual[fighter]}
	; {
		; RI_Atom_SetLockSpot off
		; RI_Var_Bool_MovingBehind:Set[TRUE]
	; }
}
function Thresinet()
{
;;;
;
;still need to perfect this fight, make the tank keep targeting himself while moving, and
;fix the bard routine to check that he is behind before attacking and not doing the wait 5
;
;need to fix 2,3,4. Maybe just set specific move to poitns for each deathdent then wait until he is not targeting
;check to make sure we are behind and hit him, but not while in front and not moving behind mob
;
;;;
	variable int ThresinetID=${Actor[namednpc,"Thresinet"].ID}
	variable float Angle
	variable float Heading
	variable float HeadingTo
	
	echo ${Time}: ${ThresinetID}
	;set announce trigger
	AnnounceText:Clear
	AnnounceText:Insert[Thresinet targets]
	if !${RI_Var_Bool_GlobalOthers}
		press f1
	RI_Atom_SetLockSpot ${Me.Name} 112.75 -87.60 -150.75 1 100
	call _MoveC 112.75 -150.75
	call _MoveC 112.81 -203.10
	wait 20
	variable int DeathDenID=${Actor[deathden,radius,10].ID}
	;echo ${DeathDenID}
	DeathDenID:Set[${Actor[deathden,radius,10].ID}]
	;echo ${DeathDenID}
	while ${Actor[id,${DeathDenID}](exists)}
	{
		;here we need to target the deathden while he is targetable 
		;and if not send our bard behind the named and attack, while tank
		;targets himself
		if ${Me.Class.Equal[bard]} && ${Actor[id,${ThresinetID}].IsAggro}
		{
			echo ${Time}: Thresinet is Aggro Again, Starting My Routine
			;bard butt punch
			
			;pause bots
			RI_CMD_PauseCombatBots 1
						
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 5
			;press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue

				
			RI_Atom_ChangeLockSpot ALL 91.11 -85.78 -181.51
			while ${Math.Distance[${Me.Loc},91.11,-85.78,-181.51]}>2
			{
				if ${Me.AutoAttackOn}
					eq2ex autoattack 0
				press f1
				wait 1
			}
			;echo ${Time}: I am in position, checking if i am behing and not being targeted and attacking
			while ${Actor[id,${ThresinetID}].IsAggro}
			{
				while ${TriggerMessage.Find[you!](exists)}
				{
					press f1
					eq2ex autoattack 0
					wait 2
				}
				;if i am behind the mob
				Heading:Set[${Actor[${ThresinetID}].Heading}]
				HeadingTo:Set[${Actor[${ThresinetID}].HeadingTo}]
				Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
				Angle:Set[${Math.Acos[${Angle}]}]
				;echo ${Time}: Angle: ${Angle}
				if ${Angle}<30 && !${TriggerMessage.Find[you!](exists)}
				{
					;echo ${Time}: I must be behind, my Angle is ${Angle}, TARGETING AND HITTING
					Actor[id,${ThresinetID}]:DoFace
					Actor[id,${ThresinetID}]:DoTarget
					eq2ex autoattack 1
				}
				wait 2
			}
			;turn off movebehind from thresinet, turn on AA, turn back on cast stack,
			;turn on melee and ranged and move back to deathden
			RI_Atom_MoveBehind ALL OFF
			
			;unpause bots
			RI_CMD_PauseCombatBots 0

			RI_Atom_SetLockSpot ${Me.Name} 112.81 0 -203.10 1 100
			call _MoveC 112.81 -203.10
		}
		if !${RI_Var_Bool_GlobalOthers} && !${Actor[Thresinet].IsAggro}
			Actor[id,${DeathDenID}]:DoTarget
		if !${RI_Var_Bool_GlobalOthers} && ${Actor[Thresinet].IsAggro} 
			press f1
		wait 1
	}
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_ChangeLockSpot ALL 81.52 0 -202.52
		while ${Math.Distance[${Me.X},${Me.Z},81.52,-202.52]}>2
		{
			press f1
			wait 1
		}
	}
	else
		call _MoveC 81.52 -202.52
	wait 5
	DeathDenID:Set[${Actor[deathden,radius,10].ID}]
	while ${Actor[id,${DeathDenID}](exists)}
	{
		;here we need to target the deathden while he is targetable 
		;and if not send our bard behind the named and attack, while tank
		;targets himself
		if ${Me.Class.Equal[bard]} && ${Actor[id,${ThresinetID}].IsAggro}
		{
			echo ${Time}: Thresinet is Aggro Again, Starting My Routine
			;bard butt punch
			
			;pause bots
			RI_CMD_PauseCombatBots 1
						
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 5
			;press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			
			
			RI_Atom_ChangeLockSpot ALL 100.88 -85.77 -179.71
			while ${Math.Distance[${Me.Loc},100.88,-85.77,-179.71]}>2
			{
				if ${Me.AutoAttackOn}
					eq2ex autoattack 0
				press f1
				wait 1
			}
			;echo ${Time}: I am in position, checking if i am behing and not being targeted and attacking
			while ${Actor[id,${ThresinetID}].IsAggro}
			{
				while ${TriggerMessage.Find[you!](exists)}
				{
					press f1
					eq2ex autoattack 0
					wait 2
				}
				;if i am behind the mob
				Heading:Set[${Actor[${ThresinetID}].Heading}]
				HeadingTo:Set[${Actor[${ThresinetID}].HeadingTo}]
				Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
				Angle:Set[${Math.Acos[${Angle}]}]
				;echo ${Time}: Angle: ${Angle}
				if ${Angle}<30 && !${TriggerMessage.Find[you!](exists)}
				{
					;echo ${Time}: I must be behind, my Angle is ${Angle}, TARGETING AND HITTING
					Actor[id,${ThresinetID}]:DoFace
					Actor[id,${ThresinetID}]:DoTarget
					eq2ex autoattack 1
				}
				wait 2
			}
			;turn off movebehind from thresinet, turn on AA, turn back on cast stack,
			;turn on melee and ranged and move back to deathden
			RI_Atom_MoveBehind ALL OFF
			;unpause bots
			RI_CMD_PauseCombatBots 0
			
			RI_Atom_SetLockSpot ${Me.Name} 81.52 0 -202.52 1 100
			call _MoveC 81.52 -202.52
		}
		if !${RI_Var_Bool_GlobalOthers} && !${Actor[Thresinet].IsAggro}
			Actor[id,${DeathDenID}]:DoTarget
		if !${RI_Var_Bool_GlobalOthers} && ${Actor[Thresinet].IsAggro} 
			press f1
		wait 1
	}
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_ChangeLockSpot ALL 121.80 0 -165.39
		while ${Math.Distance[${Me.X},${Me.Z},121.80,-165.39]}>2
		{
			press f1
			wait 1
		}
	}
	else
		call _MoveC 121.80 -165.39
	wait 5
	DeathDenID:Set[${Actor[deathden,radius,10].ID}]
	while ${Actor[id,${DeathDenID}](exists)}
	{
		;here we need to target the deathden while he is targetable 
		;and if not send our bard behind the named and attack, while tank
		;targets himself
		if ${Me.Class.Equal[bard]} && ${Actor[id,${ThresinetID}].IsAggro}
		{
			echo ${Time}: Thresinet is Aggro Again, Starting My Routine
			;bard butt punch
			
			;pause bots
			RI_CMD_PauseCombatBots 1
						
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 5
			;press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			
			;change lockspot
			RI_Atom_ChangeLockSpot ALL 90.69 -85.66 -190.58
			while ${Math.Distance[${Me.Loc},90.69,-85.66,-190.58]}>2
			{
				if ${Me.AutoAttackOn}
					eq2ex autoattack 0
				press f1
				wait 1
			}
			;echo ${Time}: I am in position, checking if i am behing and not being targeted and attacking
			while ${Actor[id,${ThresinetID}].IsAggro}
			{
				while ${TriggerMessage.Find[you!](exists)}
				{
					press f1
					eq2ex autoattack 0
					wait 2
				}
				;if i am behind the mob
				Heading:Set[${Actor[${ThresinetID}].Heading}]
				HeadingTo:Set[${Actor[${ThresinetID}].HeadingTo}]
				Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
				Angle:Set[${Math.Acos[${Angle}]}]
				;echo ${Time}: Angle: ${Angle}
				if ${Angle}<30 && !${TriggerMessage.Find[you!](exists)}
				{
					;echo ${Time}: I must be behind, my Angle is ${Angle}, TARGETING AND HITTING
					Actor[id,${ThresinetID}]:DoFace
					Actor[id,${ThresinetID}]:DoTarget
					eq2ex autoattack 1
				}
				wait 2
			}
			;turn off movebehind from thresinet, turn on AA, turn back on cast stack,
			;turn on melee and ranged and move back to deathden
			RI_Atom_MoveBehind ALL OFF
			
			;unpause bots
			RI_CMD_PauseCombatBots 0
			
			RI_Atom_SetLockSpot ${Me.Name} 121.80 0 -165.39 1 100
			call _MoveC 121.80 -165.39
		}
		if !${RI_Var_Bool_GlobalOthers} && !${Actor[Thresinet].IsAggro}
			Actor[id,${DeathDenID}]:DoTarget
		if !${RI_Var_Bool_GlobalOthers} && ${Actor[Thresinet].IsAggro} 
			press f1
		wait 1
	}
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_ChangeLockSpot ALL 71.68 0 -166.21
		while ${Math.Distance[${Me.X},${Me.Z},71.68,-166.21]}>2
		{
			press f1
			wait 1
		}
	}
	else
		call _MoveC 71.68 -166.21
	wait 5
	DeathDenID:Set[${Actor[deathden,radius,10].ID}]
	while ${Actor[id,${DeathDenID}](exists)}
	{
		;here we need to target the deathden while he is targetable 
		;and if not send our bard behind the named and attack, while tank
		;targets himself
		if ${Me.Class.Equal[bard]} && ${Actor[id,${ThresinetID}].IsAggro}
		{
			echo ${Time}: Thresinet is Aggro Again, Starting My Routine
			;bard butt punch
			
			;pause bots
			RI_CMD_PauseCombatBots 1
						
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 5
			;press `
			eq2ex autoattack 0
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			
			;change lockspot
			RI_Atom_ChangeLockSpot ALL 101.52 -85.67 -189.27
			while ${Math.Distance[${Me.Loc},101.52,-85.67,-189.27]}>2
			{
				if ${Me.AutoAttackOn}
					eq2ex autoattack 0
				press f1
				wait 1
			}
			;echo ${Time}: I am in position, checking if i am behing and not being targeted and attacking
			while ${Actor[id,${ThresinetID}].IsAggro}
			{
				while ${TriggerMessage.Find[you!](exists)}
				{
					press f1
					eq2ex autoattack 0
					wait 2
				}
				;if i am behind the mob
				Heading:Set[${Actor[${ThresinetID}].Heading}]
				HeadingTo:Set[${Actor[${ThresinetID}].HeadingTo}]
				Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
				Angle:Set[${Math.Acos[${Angle}]}]
				;echo ${Time}: Angle: ${Angle}
				if ${Angle}<30 && !${TriggerMessage.Find[you!](exists)}
				{
					;echo ${Time}: I must be behind, my Angle is ${Angle}, TARGETING AND HITTING
					Actor[id,${ThresinetID}]:DoFace
					Actor[id,${ThresinetID}]:DoTarget
					eq2ex autoattack 1
				}
				wait 2
			}
			;turn off movebehind from thresinet, turn on AA, turn back on cast stack,
			;turn on melee and ranged and move back to deathden
			RI_Atom_MoveBehind ALL OFF
			;unpause bots
			RI_CMD_PauseCombatBots 0
			RI_Atom_SetLockSpot ${Me.Name} 71.68 0 -166.21 1 100
			call _MoveC 71.68 -166.21
		}
		if !${RI_Var_Bool_GlobalOthers} && !${Actor[Thresinet].IsAggro}
			Actor[id,${DeathDenID}]:DoTarget
		if !${RI_Var_Bool_GlobalOthers} && ${Actor[Thresinet].IsAggro} 
			press f1
		wait 1
	}
	
	;if i am a fighter and not targeting thresinet target her
	if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[id,${ThresinetID}].ID}
		Actor[id,${ThresinetID}]:DoTarget
			
	;move lockspot to the center of the room and wait 3 secs to thresinet to arrive
	RI_Atom_SetLockSpot ${Me.Name} 96.60 0 -194.81 1 100
	call _MoveC 96.60 -194.81
	wait 30
	
	;if we are not a fighter turn off lockspot and turn on movebehind
	if ${Me.Archetype.NotEqual[fighter]}
	{
		RI_Atom_SetLockSpot off
		RI_Atom_MoveBehind ALL ${ThresinetID} 30 100
	}
	
	;while thresinet exists and is not dead
	while ${Actor[id,${ThresinetID}](exists)} && !${Actor[id,${ThresinetID}].IsDead}
	{
		;if i am a fighter and not targeting thresinet target her
		if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[id,${ThresinetID}].ID}
			Actor[id,${ThresinetID}]:DoTarget
	}
}
function Kavis()
{
	RI_Atom_SetLockSpot ${Me.Name} 149.47 -47.35 -25.76 1 100
	call _MoveC 149.47 -25.76
	while ${Actor[namednpc,"Kavis Set'Ra"](exists)} && !${Actor[namednpc,"Kavis Set'Ra"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[namednpc,"Kavis Set'Ra"].ID}
			Actor[namednpc,"Kavis Set'Ra"]:DoTarget
		wait 1
	}
	echo ${Time}: Kavis is Gone, Waiting for Bubbles
	while !${Actor[Kavis,radius,3](exists)}
		wait 1
	echo ${Time}: Bubbles are here Moving to 149.47 -25.76
	call _MoveC 145.17 -30.13
	echo ${Time}: We are at 149.47 -25.76, waiting until we are swimming
	while !${Me.IsSwimming}
		wait 1
	echo ${Time}: We are swimming, Holding space until we are less than 5m from 10y
	while ${Math.Distance[${Me.Y},-10]}>5
	{
		echo ${Time}: ${Math.Distance[${Me.Y},-10]}>5
		press -hold space
		wait 1
	}
	press -release space
	echo ${Time}: we are at the correct height, moving to 124.22 -50.72
	call _MoveC 133.80 -47.70
	call _MoveC 124.22 -50.72
	wait 20
	echo ${Time}: we are at 124.22 -50.72, targeting and killing reflection
	while ${Actor[npc,Kavis,radius,15](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[npc,Kavis,radius,15].ID}
			Actor[npc,Kavis,radius,15]:DoTarget
		wait 1
	}
	echo ${Time}: reflection is dead moving to 149.47 -25.76
	call _MoveC 149.47 -25.76
	while !${Actor[Kavis,radius,3](exists)}
		wait 1
	call _MoveC 145.17 -30.13
	while !${Me.IsSwimming}
		wait 1
	while ${Math.Distance[${Me.Y},-10]}>5
	{
		press -hold space
		wait 1
	}
	press -release space
	call _MoveC 162.75 -18.50
	call _MoveC 164.67 -12.13
	wait 20
	while ${Actor[npc,Kavis,radius,15](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[npc,Kavis,radius,15].ID}
			Actor[npc,Kavis,radius,15]:DoTarget
		wait 1
	}
	call _MoveC 184.66 -64.16
	while !${Actor[Kavis,radius,3](exists)}
		wait 1
	call _MoveC 183.23 -69.04
	while !${Me.IsSwimming}
		wait 1
	while ${Math.Distance[${Me.Y},-10]}>5
	{
		press -hold space
		wait 1
	}
	press -release space
	call _MoveC 195.52 -50.48
	call _MoveC 203.96 -47.74
	wait 20
	while ${Actor[npc,Kavis,radius,15](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[npc,Kavis,radius,15].ID}
			Actor[npc,Kavis,radius,15]:DoTarget
		wait 1
	}
	call _MoveC 157.03 -29.95
	wait 20
	press -hold d
	wait 5
	press -release d
	while ${Actor[namednpc,"Kavis Set'Ra"](exists)} && !${Actor[namednpc,"Kavis Set'Ra"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers} && ${Target.ID}!=${Actor[namednpc,"Kavis Set'Ra"].ID}
			Actor[namednpc,"Kavis Set'Ra"]:DoTarget
		wait 1
	}
}
function HuntRingEvent()
{
	if !${RI_Var_Bool_GlobalOthers}
		relay ${RI_Var_String_RelayGroup} RI_Atom_SetLockSpot ALL -3930.33 -87.27 95.71 1 100
	while !${Actor[Sharptooth](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a compsognathus",radius,25](exists)} && !${Actor["a compsognathus",radius,25].IsDead}
			{	
				if ${Target.ID}!=${Actor["a compsognathus",radius,25].ID}
					Actor["a compsognathus",radius,25]:DoTarget
			}
			elseif ${Actor["an elite Allu'thoa prowler",radius,50](exists)} && !${Actor["an elite Allu'thoa prowler",radius,50].IsDead}
			{	
				if ${Target.ID}!=${Actor["an elite Allu'thoa prowler",radius,50].ID}
					Actor["an elite Allu'thoa prowler",radius,50]:DoTarget
			}
			elseif ${Actor["an elite Allu'thoa tracker",radius,50](exists)} && !${Actor["an elite Allu'thoa tracker",radius,50].IsDead}
			{	
				if ${Target.ID}!=${Actor["an elite Allu'thoa tracker",radius,50].ID}
					Actor["an elite Allu'thoa tracker",radius,50]:DoTarget
			}
			elseif ${Actor["The Unnamed Hunter"](exists)} && !${Actor["The Unnamed Hunter"].IsDead}
			{	
				if ${Target.ID}!=${Actor["The Unnamed Hunter"].ID}
					Actor["The Unnamed Hunter"]:DoTarget
			}
			elseif ${Actor["a cowed stegoplatodon",radius,50](exists)} && !${Actor["a cowed stegoplatodon",radius,50].IsDead}
			{	
				if ${Target.ID}!=${Actor["a cowed stegoplatodon",radius,50].ID}
					Actor["a cowed stegoplatodon",radius,50]:DoTarget
			}
			elseif ${Actor["a subjugated pterrorsaur",radius,50](exists)} && !${Actor["a subjugated pterrorsaur",radius,50].IsDead}
			{	
				if ${Target.ID}!=${Actor["a subjugated pterrorsaur",radius,50].ID}
					Actor["a subjugated pterrorsaur",radius,50]:DoTarget
			}
			elseif ${Actor["a fearful ipsumodon",radius,50](exists)} && !${Actor["a fearful ipsumodon",radius,50].IsDead}
			{	
				if ${Target.ID}!=${Actor["a fearful ipsumodon",radius,50].ID}
					Actor["a fearful ipsumodon",radius,50]:DoTarget
			}
			elseif ${Actor["an Allu'thoa deino-tyrant",radius,50](exists)} && !${Actor["an Allu'thoa deino-tyrant",radius,50].IsDead}
			{	
				if ${Target.ID}!=${Actor["an Allu'thoa deino-tyrant",radius,50].ID}
					Actor["an Allu'thoa deino-tyrant",radius,50]:DoTarget
			}
			elseif ${Actor[Scytheclaw](exists)} && !${Actor[Scytheclaw].IsDead}
			{	
				if ${Target.ID}!=${Actor[Scytheclaw].ID}
					Actor[Scytheclaw]:DoTarget
			}
			elseif ${Actor[Boneskull](exists)} && !${Actor[Boneskull].IsDead}
			{	
				if ${Target.ID}!=${Actor[Boneskull].ID}
					Actor[Boneskull]:DoTarget
			}
			elseif ${Actor[namednpc,Littlefoot](exists)} && !${Actor[namednpc,Littlefoot].IsDead}
			{	
				if ${Target.ID}!=${Actor[namednpc,Littlefoot].ID}
					Actor[namednpc,Littlefoot]:DoTarget
			}
			elseif ${Actor[Petri](exists)} && !${Actor[Petri].IsDead}
			{	
				if ${Target.ID}!=${Actor[Petri].ID}
					Actor[Petri]:DoTarget
			}
		}
		wait 5
	}
	while ${Actor[Sharptooth](exists)} || ${Actor[Maw](exists)}
	{
		if ${Actor[Sharptooth].Health}>80 && !${Actor[Sharptooth].IsDead}
		{	
			if ${Target.ID}!=${Actor[Sharptooth].ID}
				Actor[Sharptooth]:DoTarget
		}
		elseif ${Actor[Maw].Health}>80 && !${Actor[Maw].IsDead}
		{	
			if ${Target.ID}!=${Actor[Maw].ID}
				Actor[Maw]:DoTarget
		}
		elseif ${Actor[Sharptooth].Health}>60 && !${Actor[Sharptooth].IsDead}
		{	
			if ${Target.ID}!=${Actor[Sharptooth].ID}
				Actor[Sharptooth]:DoTarget
		}
		elseif ${Actor[Maw].Health}>60 && !${Actor[Maw].IsDead}
		{	
			if ${Target.ID}!=${Actor[Maw].ID}
				Actor[Maw]:DoTarget
		}
		elseif ${Actor[Sharptooth].Health}>40 && !${Actor[Sharptooth].IsDead}
		{	
			if ${Target.ID}!=${Actor[Sharptooth].ID}
				Actor[Sharptooth]:DoTarget
		}
		elseif ${Actor[Maw].Health}>40 && !${Actor[Maw].IsDead}
		{	
			if ${Target.ID}!=${Actor[Maw].ID}
				Actor[Maw]:DoTarget
		}
		elseif ${Actor[Sharptooth].Health}>20 && !${Actor[Sharptooth].IsDead}
		{	
			if ${Target.ID}!=${Actor[Sharptooth].ID}
				Actor[Sharptooth]:DoTarget
		}
		elseif ${Actor[Maw].Health}>20 && !${Actor[Maw].IsDead}
		{	
			if ${Target.ID}!=${Actor[Maw].ID}
				Actor[Maw]:DoTarget
		}
		elseif ${Actor[Sharptooth].Health}>10 && !${Actor[Sharptooth].IsDead}
		{	
			if ${Target.ID}!=${Actor[Sharptooth].ID}
				Actor[Sharptooth]:DoTarget
		}
		elseif ${Actor[Maw].Health}>10 && !${Actor[Maw].IsDead}
		{	
			if ${Target.ID}!=${Actor[Maw].ID}
				Actor[Maw]:DoTarget
		}
		elseif ${Actor[Sharptooth](exists)} && !${Actor[Sharptooth].IsDead}
		{	
			if ${Target.ID}!=${Actor[Sharptooth].ID}
				Actor[Sharptooth]:DoTarget
		}
		elseif !${Actor[Maw].IsDead}
		{	
			if ${Target.ID}!=${Actor[Maw].ID}
				Actor[Maw]:DoTarget
		}
		elseif ${Actor[Maw].IsDead} || ${Actor[Sharptooth].IsDead}
		{
			Actor[Maw]:DoubleClick
			Actor[Sharptooth]:DoubleClick
			eq2ex apply_verb ${Actor[Maw].ID} Loot
			eq2ex apply_verb ${Actor[Sharptooth].ID} Loot
		}
		wait 2
	}
	if !${RI_Var_Bool_GlobalOthers}
		relay ${RI_Var_String_RelayGroup} RI_Atom_SetLockSpot ALL -3935.20 -88 101.25 1 100
}
function Qworux()
{
	;if namednpc qworox exists and is not dead
	if ${Actor[namednpc,Qworux](exists)} && !${Actor[namednpc,Qworux].IsDead}
	{
		;set lockspot
		RI_Atom_SetLockSpot ${Me.Name} 95.905545 -86.061654 -97.862258 1 100
		
		;set our NameID to the Correct Qworox
		NameID:Set[${Actor[namednpc,Qworux].ID}]
		
		;target the namednpc Qworux
		if !${RI_Var_Bool_GlobalOthers}
			Actor[namednpc,Qworux]:DoTarget
		wait 5
		
		;relay to everyone to cast SeverHate to pull Qworux
		relay ${RI_Var_String_RelayGroup} -noredirect Me.Ability["Sever Hate"]:Use
		
		;while the namednpc Qworux exists and is not dead
		while ${Actor[namednpc,Qworux](exists)} && !${Actor[namednpc,Qworux].IsDead}
		{
			;if i am a fighter, target a den guardarach if it exists within 25 raidus 
			;otherwise target Qworux if i am not targeting her
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Actor["a den guardarach",radius,25](exists)}
					Actor["a den guardarach",radius,25]:DoTarget
				elseif ${Target.ID}!=${Actor[namednpc,Qworux].ID}
					Actor[namednpc,Qworux]:DoTarget
			}
			wait 5
		}
	}
}
function WaitForKladnog()
{
	echo ${Time}: Waiting for Kladnog Shralok to arrive
	wait 2000000 ${Actor["Kladnog Shralok"](exists)}
	while ${Actor["Kladnog Shralok"].Distance}>30
		wait 1
	echo ${Time}: Done Waiting for Kladnog Shralok
}

function Doof()
{
	echo ISXRI: Starting Doof 
	;first as long as Doof is more than 55 away from us pull dockers, there are 6 sets that need pulled
	
	;turn on lockspot to -239 -62 98
	RI_Atom_SetLockSpot ${Me.Name} -239 -62 98 1 100
	
	while ${Actor[docker](exists)} && !${Actor["Oofgoof Doof"].InCombatMode}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if !${Target.Name.Find[docker](exists)}
				Actor[docker]:DoTarget
			elseif !${Target.Target(exists)}
			{
				relay ${RI_Var_String_RelayGroup} -noredirect Me.Ability["Sever Hate"]:Use
				wait 20
			}
		}
		wait 2
	}
	AnnounceText:Clear
	AnnounceText:Insert["You've been targeted by Oofgoof!"]
	
	;if i am a priest, turn off curse
	if ${Me.Archetype.Equal[priest]}
		RI_CMD_AbilityEnableDisable "Cure Curse" 0
	
	;turn on lockspot to -232 -61 97
	RI_Atom_SetLockSpot ${Me.Name} -232 -61 97 1 100
	
	if !${RI_Var_Bool_GlobalOthers}
		Actor["Oofgoof Doof"]:DoTarget

	wait 5
		
	;while Oofgoof Doof is not targeting someone, cast severhate
	while !${Actor["Oofgoof Doof"].Target(exists)}
	{
		relay ${RI_Var_String_RelayGroup} -noredirect Me.Ability["Sever Hate"]:Use
		wait 5
	}
	
	while ${Actor["Oofgoof Doof"](exists)} && !${Actor["Oofgoof Doof"].IsDead}
	{
		;if Trigger is true, move to joust spot, wait 15s then move back behind
		if ${Trigger}
		{
			;turn on lockspot to -251 -61 92
			RI_Atom_SetLockSpot ${Me.Name} -251 -61 92 1 100
			
			wait 170
				
			;turn on lockspot to -232 -61 97
			RI_Atom_SetLockSpot ${Me.Name} -232 -61 97 1 100
			
			;set Trigger False
			Trigger:Set[FALSE]
		}
		if !${RI_Var_Bool_GlobalOthers}
		{	
			if ${Target.ID}!=${Actor["Oofgoof Doof"].ID}
				Actor["Oofgoof Doof"]:DoTarget
		}
		wait 2
	}
	if ${Me.Archetype.Equal[priest]}
		RI_CMD_AbilityEnableDisable "Cure Curse" 1
	
	echo Ending Doof
}
variable bool TriggerWharfie=FALSE
function Wharfie()
{
	if !${RI_Var_Bool_GlobalOthers}
		RI_AggroControl
	declare DRCount int 0
	declare Crate int
	declare ArmoredSpikesMainIconID int 965

	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingTextWharfie]

	;turn off walk the plank
	RI_CMD_AbilityEnableDisable "Walk the Plank" 0
	
	wait 10
	Actor["Sir Wharfie"]:DoTarget
	
	;lock fighter to -205 -49 168
	RI_Atom_SetLockSpot ALL -205 -49 168
	wait 200 ${Actor["Sir Wharfie"].Distance}<10
	
	;lock fighter to -225 -49 185
	RI_Atom_SetLockSpot ALL -225 -49 185
	wait 200 ${Math.Distance[${Me.Loc},-225,-49,185]}<3
	wait 200 ${Actor["Sir Wharfie"].Distance}<9
	
	;lock fighter to -223 -49 191
	RI_Atom_SetLockSpot ALL -223 -49 191
	wait 200 ${Math.Distance[${Me.Loc},-223,-49,191]}<3
	wait 200 ${Actor["Sir Wharfie"].Distance}<9
	
	;lock fighter to -208 -49 182
	RI_Atom_SetLockSpot FIGHTER -208 -49 182
	
	;if i am a bard lock to -227 -49 186
	if ${Me.Class.Equal[bard]}
		RI_Atom_SetLockSpot ${Me.Name} -216 -49 186
		
	;if i am an enchanter lock to -206 -49 165
	elseif ${Me.Class.Equal[enchanter]}
		RI_Atom_SetLockSpot ${Me.Name} -237 -48.88 192.81
	
	;if i am a scout
	elseif ${Me.Archetype.Equal[scout]}
	{
		;count our scouts first(ignoring bards), then decide where i go
		declare count int 0
		declare AnotherScout bool FALSE
		declare OtherScout string
		
		for(count:Set[1];${count}<${Me.Group};count:Inc)
		{
			if ${Me.Group[${count}].Class.Equal[swashbuckler]} || ${Me.Group[${count}].Class.Equal[brigand]} || ${Me.Group[${count}].Class.Equal[assassin]} || ${Me.Group[${count}].Class.Equal[ranger]} || ${Me.Group[${count}].Class.Equal[beastlord]}
			{
				AnotherScout:Set[TRUE]
				OtherScout:Set[${Me.Group[${count}]}]
			}
			wait 1
		}
		
		;if we have another scout, compare our names and decide who goes where
		if ${AnotherScout}
		{
			if ${OtherScout.Compare[${Me.Name}]}>0
				RI_Atom_SetLockSpot ${Me.Name} -226 -49 190
			else
				RI_Atom_SetLockSpot ${Me.Name} -236 -49 195
		}
		else
			RI_Atom_SetLockSpot ${Me.Name} -226 -49 190
	}
	
	;if i am a mage
	elseif ${Me.Archetype.Equal[mage]}
	{
		;count our magess first(ignoring chanters), then decide where i go
		declare count int 0
		declare AnotherMage bool FALSE
		declare OtherMage string
		
		for(count:Set[1];${count}<${Me.Group};count:Inc)
		{
			if ${Me.Group[${count}].Class.Equal[warlock]} || ${Me.Group[${count}].Class.Equal[wizard]} || ${Me.Group[${count}].Class.Equal[necromancer]} || ${Me.Group[${count}].Class.Equal[conjuror]}
			{
				AnotherMage:Set[TRUE]
				OtherMage:Set[${Me.Group[${count}]}]
			}
			wait 1
		}
		
		;if we have another scout, compare our names and decide who goes where
		if ${AnotherMage}
		{
			if ${OtherMage.Compare[${Me.Name}]}>0
				RI_Atom_SetLockSpot ${Me.Name} -246 -49 183
			else
			{
				RI_Atom_SetLockSpot ${Me.Name} -246 -49 183
				wait 200 ${Math.Distance[${Me.Loc},-246,-49,183}]}<2
				RI_Atom_SetLockSpot ${Me.Name} -250 -49 169
			}
		}
		else
			RI_Atom_SetLockSpot ${Me.Name} -246 -49 183
	}
	;if i am a healer
	elseif ${Me.Archetype.Equal[priest]}
	{
		;count our priests first, then decide where i go
		declare count int 0
		declare AnotherPriest bool FALSE
		declare OtherPriest string
		
		for(count:Set[1];${count}<${Me.Group};count:Inc)
		{
			if ${Me.Group[${count}].Class.Equal[inquisitor]} || ${Me.Group[${count}].Class.Equal[templar]} ||${Me.Group[${count}].Class.Equal[defiler]} || ${Me.Group[${count}].Class.Equal[mystic]} || ${Me.Group[${count}].Class.Equal[fury]} || ${Me.Group[${count}].Class.Equal[warden]} || ${Me.Group[${count}].Class.Equal[channeler]}
			{
				AnotherPriest:Set[TRUE]
				OtherPriest:Set[${Me.Group[${count}]}]
			}
			wait 1
		}
		
		;if we have another scout, compare our names and decide who goes where
		if ${AnotherPriest}
		{
			if ${OtherPriest.Compare[${Me.Name}]}>0
				RI_Atom_SetLockSpot ${Me.Name} -228.19 -48.88 180.29
			else
				RI_Atom_SetLockSpot ${Me.Name} -213.52 -48.87 184.90
		}
		else
			RI_Atom_SetLockSpot ${Me.Name} -228.19 -48.88 180.29
	}
	
	;while wharfie exists, isnot dead and RI is started.
	while ${Actor["Sir Wharfie"](exists)} && !${Actor["Sir Wharfie"].IsDead}
	{
		if !${RI_Var_Bool_Start}
		{
			wait 2
			continue
		}
		
		;Armored Spikes MainIconID is 965
		if !${RI_Var_Bool_GlobalOthers}
		{
			; Actor["Sir Wharfie"]:InitializeEffects - REMOVED MAY NOT BE NEEDED
			; ;wait 2 while we are initializing effects
			; while ${ISXEQ2.InitializingActorEffects}
			; {
				; wait 2
				; if ${TriggerWharfie}
				; {
					; wait 15
					; RI_Atom_SetLockSpot off
					; RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[TRUE]
					; wait 2
					; RI_Atom_MoveBehind ALL ${Actor["Wharfie"].ID} 30 100
					; echo ${Time}: Moving Behind ${Actor["Wharfie"]} / ${Actor["Wharfie"].ID} 
					; wait 25
					; RI_Atom_MoveBehind ALL OFF
					; RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[FALSE]
					; wait 10
					; RI_Atom_SetLockSpot FIGHTER -208 -49 182
					; TriggerWharfie:Set[FALSE]
				; }
			; }
			if ${Trigger}
			{
				Actor[${Me.ID}]:DoTarget
				relay ${RI_Var_String_RelayGroup} eq2ex cancel_spellcast
				relay ${RI_Var_String_RelayGroup} eq2ex clearabilityqueue
				while ${Actor["Sir Wharfie"].Effect[1].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[2].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[3].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[4].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[5].MainIconID}!=${ArmoredSpikesMainIconID}
				{
					Actor[${Me.ID}]:DoTarget
					relay ${RI_Var_String_RelayGroup} eq2ex cancel_spellcast
					relay ${RI_Var_String_RelayGroup} eq2ex clearabilityqueue
					if ${TriggerWharfie}
					{
						wait 15
						RI_Atom_SetLockSpot off
						RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[TRUE]
						wait 2
						RI_Atom_MoveBehind ALL ${Actor["Wharfie"].ID} 30 100
						echo ${Time}: Moving Behind ${Actor["Wharfie"]} / ${Actor["Wharfie"].ID} 
						wait 25
						RI_Atom_MoveBehind ALL OFF
						RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[FALSE]
						wait 10
						RI_Atom_SetLockSpot FIGHTER -208 -49 182
						TriggerWharfie:Set[FALSE]
					}
					; Actor["Sir Wharfie"]:InitializeEffects - REMOVED MAY NOT BE NEEDED
					; ;wait 2 while we are initializing effects
					; while ${ISXEQ2.InitializingActorEffects}
					; {
						; wait 2
						; if ${TriggerWharfie}
						; {
							; wait 15
							; RI_Atom_SetLockSpot off
							; RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[TRUE]
							; wait 2
							; RI_Atom_MoveBehind ALL ${Actor["Wharfie"].ID} 30 100
							; echo ${Time}: Moving Behind ${Actor["Wharfie"]} / ${Actor["Wharfie"].ID} 
							; wait 25
							; RI_Atom_MoveBehind ALL OFF
							; RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[FALSE]
							; wait 10
							; RI_Atom_SetLockSpot FIGHTER -208 -49 182
							; TriggerWharfie:Set[FALSE]
						; }
					; }
					wait 2
				}
				Trigger:Set[FALSE]
			}
			if ${Actor["Sir Wharfie"].Effect[1].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[2].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[3].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[4].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[5].MainIconID}==${ArmoredSpikesMainIconID}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: ${Actor["Sir Wharfie"].Effect[1].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[2].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[3].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[4].MainIconID}==${ArmoredSpikesMainIconID} || ${Actor["Sir Wharfie"].Effect[5].MainIconID}==${ArmoredSpikesMainIconID}
				Actor[${Me.ID}]:DoTarget
			}
			elseif ${Actor["Sir Wharfie"].Effect[1].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[2].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[3].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[4].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[5].MainIconID}!=${ArmoredSpikesMainIconID}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: ${Actor["Sir Wharfie"].Effect[1].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[2].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[3].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[4].MainIconID}!=${ArmoredSpikesMainIconID} && ${Actor["Sir Wharfie"].Effect[5].MainIconID}!=${ArmoredSpikesMainIconID}
				Trigger:Set[FALSE]
				if ${Target.ID}!=${Actor["Sir Wharfie"].ID}
					Actor["Sir Wharfie"]:DoTarget
			}
			if ${TriggerWharfie}
			{
				wait 15
				RI_Atom_SetLockSpot off
				RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[TRUE]
				wait 2
				RI_Atom_MoveBehind ALL ${Actor["Wharfie"].ID} 30 100
				echo ${Time}: Moving Behind ${Actor["Wharfie"]} / ${Actor["Wharfie"].ID} 
				wait 25
				RI_Atom_MoveBehind ALL OFF
				RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[FALSE]
				wait 10
				RI_Atom_SetLockSpot FIGHTER -208 -49 182
				TriggerWharfie:Set[FALSE]
			}
		}
		if ${Trigger} && ${Me.Archetype.NotEqual[fighter]}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Package delivered, starting keg routine
			wait 60
			DRCount:Inc
			if ${DRCount}==1 && ${Me.Class.Equal[enchanter]}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Enchanter
				;move to first barrel
				;call _MoveC -232 192 FALSE TRUE
				
				;turn off assisting
				RI_CMD_Assisting 0
				
				;set first crate's ID
				Crate:Set[${Actor["a heavy crate"].ID}]
				
				;target crate
				;relay ${RI_Var_String_RelayGroup} 
				Actor[id,${Crate}]:DoTarget
				
				;while the crate exists target it
				while ${Actor[id,${Crate}](exists)}
				{
					;relay ${RI_Var_String_RelayGroup} 
					Actor[id,${Crate}]:DoTarget
					wait 1
				}
				
				;target self and wait 1s 
				;relay ${RI_Var_String_RelayGroup} 
				Actor[${Me.ID}]:DoTarget
				wait 10
				
				;change camera, pick up keg
				Press -hold "Page Down"
				wait 5
				Actor[keg]:DoubleClick
				
				;move to wharfiespot and wait until we are there
				call _MoveC -216 184 FALSE TRUE
				wait 5
				
				;move mouse to center of screen aka on top of you
				Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[${Display.Height}/2]}]
				wait 2
				
				;click to place
				Mouse:LeftClick
				
				wait 5
				Press -release "Page Down"
				Press -hold "Page Up"
				wait 2
				Press -release "Page Up"
				
				;move back to our position and turn on assisting
				call _MoveC -236 195 FALSE TRUE
				;relay ${RI_Var_String_RelayGroup} 
				RI_CMD_Assisting 1
			}
			if ${DRCount}==2 && ${Me.Class.Equal[enchanter]}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Enchanter
				;move to 2nd barrel
				call _MoveC -240 183 FALSE TRUE
				wait 5
				call _MoveC -256 187 FALSE TRUE
				
				
				;turn off assisting
				RI_CMD_Assisting 0
				
				;set second crate's ID
				Crate:Set[${Actor["a heavy crate"].ID}]
				
				;target crate
				;relay ${RI_Var_String_RelayGroup} 
				Actor[id,${Crate}]:DoTarget
				
				;while the crate exists target it
				while ${Actor[id,${Crate}](exists)}
				{
					;relay ${RI_Var_String_RelayGroup} 
					Actor[id,${Crate}]:DoTarget
					wait 1
				}
								
				;target self and wait 1s
				;relay ${RI_Var_String_RelayGroup} 
				Actor[${Me.ID}]:DoTarget
				wait 10
				
				;change camera, pick up keg
				Press -hold "Page Down"
				wait 5
				Actor[keg]:DoubleClick
				
				;move to wharfiespot and wait until we are there
				call _MoveC -216 184 FALSE TRUE
				wait 5
				
				;move mouse to center of screen aka on top of you
				Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[${Display.Height}/2]}]
				wait 2
				
				;click to place
				Mouse:LeftClick
				
				wait 5
				Press -release "Page Down"
				Press -hold "Page Up"
				wait 2
				Press -release "Page Up"
				
				;move back to our position
				call _MoveC -236 195 FALSE TRUE
				
				;turn on assisting
				RI_CMD_Assisting 1
			}
			if ${DRCount}==3 && ${Me.Class.Equal[enchanter]}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Enchanter
				;move to 3rd barrel
				call _MoveC -240 183 FALSE TRUE
				wait 5
				call _MoveC -271 155 FALSE TRUE
				
				
				;turn off assisting
				RI_CMD_Assisting 0
				
				;set third crate's ID
				Crate:Set[${Actor["a heavy crate"].ID}]
				
				;target crate
				;relay ${RI_Var_String_RelayGroup} 
				Actor[id,${Crate}]:DoTarget
				
				;while the crate exists target it
				while ${Actor[id,${Crate}](exists)}
				{
					;relay ${RI_Var_String_RelayGroup} 
					Actor[id,${Crate}]:DoTarget
					wait 1
				}
								
				;target self and wait 1s
				;relay ${RI_Var_String_RelayGroup} 
				Actor[${Me.ID}]:DoTarget
				wait 10
				
				;change camera, pick up keg
				Press -hold "Page Down"
				wait 2
				Actor[keg]:DoubleClick
				
				;move to ourspot then wharfiespot and wait until we are there
				call _MoveC -240 183 FALSE TRUE
				wait 5
				call _MoveC -216 184 FALSE TRUE
				wait 5
				
				;move mouse to center of screen aka on top of you
				Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[${Display.Height}/2]}]
				wait 2
				
				;click to place
				Mouse:LeftClick
				
				wait 5
				Press -release "Page Down"
				Press -hold "Page Up"
				wait 2
				Press -release "Page Up"
				
				;move back to our position
				call _MoveC -236 195 FALSE TRUE
				
				;turn on assisting
				RI_CMD_Assisting 1
			}
			Trigger:Set[FALSE]
		}
		wait 2
	}
	;move mages to -246 -49 183
	if ${Me.Archetype.Equal[mage]} && ${Me.Class.NotEqual[enchanter]}
		RI_Atom_SetLockSpot ${Me.Name} -246 -49 183
	wait 20
	
	;detach atom
	Event[EQ2_onIncomingText]:DetachAtom[EQ2_onIncomingTextWharfie]
	
	;turn walk the plank back on
	RI_CMD_AbilityEnableDisable "Walk the Plank" 1
	if !${RI_Var_Bool_GlobalOthers}
		endscript Buffer:AggroControl
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingTextWharfie(string Text)
{
	
   	if ${Text.Find["Deliver the package!"](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		Trigger:Set[TRUE]
		relay ${RI_Var_String_RelayGroup} Actor[${Me.ID}]:DoTarget
		relay ${RI_Var_String_RelayGroup} eq2ex cancel_spellcast
		relay ${RI_Var_String_RelayGroup} eq2ex clearabilityqueue
	}
	if ${Text.Find["stops to attack everyone in front of him"](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		TriggerWharfie:Set[TRUE]
	}
}

variable(global) bool Jousted=FALSE
function Zaxfalump()
{
	echo ISXRI: Starting Zaxfalump 
	
	declare ReleasedTank bool FALSE
	declare FwumpSpawned bool FALSE
	declare Stowaway1 int
	declare Stowaway2 int
	
	;turn on lockspot to -251 -61 92
	RI_Atom_SetLockSpot ALL -217 -49 134 1 100
	RI_Atom_SetLockSpot FIGHTER -214 -49 141 1 100
	
	while ${Actor["Zaxfalump"](exists)} && !${Actor["Zaxfalump"].IsDead}
	{
		;if Trigger is true, move to joust spot, wait 15s then move back behind
		if !${Jousted} && ${Actor["AE Warning Area"](exists)} && ${Actor["AE Warning Area"].Distance}<2
		{
			;if we are at -217,-49,134 move to -222 -49 122
			if ${Math.Distance[${Me.Loc},-217,-49,134]}<2 || ${Math.Distance[${Me.Loc},-214,-49,141]}<2
			{
				RI_Atom_SetLockSpot ALL -222 -49 122 1 100
				RI_Atom_SetLockSpot FIGHTER -224 -49 115 1 100
			}
			;elseif we are at -222,-49,122 move to -217 -49 134
			elseif ${Math.Distance[${Me.Loc},-222,-49,122]}<2 || ${Math.Distance[${Me.Loc},-224,-49,115]}<2
			{
				RI_Atom_SetLockSpot ALL -217 -49 134 1 100
				RI_Atom_SetLockSpot FIGHTER -214 -49 141 1 100
			}
			
			Jousted:Set[TRUE]
			TimedCommand 20 Jousted:Set[FALSE]
		}
		
		;if i am a tank and not targeting sepcific targets and they exists target them
		if !${RI_Var_Bool_GlobalOthers}
		{

			if ${Actor[namednpc,Fwump](exists)} && !${Actor[namednpc,Fwump].IsDead}
			{
				Stowaway1:Set[${Actor["a stowaway stalker"].ID}]
				Stowaway2:Set[${Actor["a stowaway stalker",notid,${Stowaway1}].ID}]
				if ${Actor[${Stowaway1}].Health}>95
					Actor[${Stowaway1}]:DoTarget
				elseif ${Actor[${Stowaway2}].Health}>95
					Actor[${Stowaway2}]:DoTarget	
				elseif ${Target.ID}!=${Actor[namednpc,Fwump].ID}
					Actor[namednpc,Fwump]:DoTarget
				FwumpSpawned:Set[TRUE]
			}
			else
			{
				if ${FwumpSpawned} && !${ReleasedTank}
				{
					;echo ${Time}: releasing tank
					relay ${RI_Var_String_RelayGroup} RI_Atom_SetLockSpot ALL -217 -49 134
					call _MoveC -217 134
					wait 5
					RI_Atom_SetLockSpot ${Me.Name} -210 -49 133 1 100

					wait 30
					; echo ${Time}: Waiting for Zaxfalump to be within 7
					; wait 50 ${Actor["Zaxfalump"].Distance}<7
					; if ${Math.Distance[${Me.Loc},-222,-49,122]}<2
						; RI_Atom_SetLockSpot ${Me.Name} -218 -49 120 1 100
					; if ${Math.Distance[${Me.Loc},-217,-49,134]}<2
						; RI_Atom_SetLockSpot ${Me.Name} -212 -49 132 1 100
					; wait 50 ${Actor["Zaxfalump"].Distance}<7
					; if ${Math.Distance[${Me.Loc},-218,-49,120]}<2
						; RI_Atom_SetLockSpot ${Me.Name} -222 -49 122 1 100
					; if ${Math.Distance[${Me.Loc},-212,-49,132]}<2
						; RI_Atom_SetLockSpot ${Me.Name} -217 -49 134 1 100
					; wait 50 ${Actor["Zaxfalump"].Distance}<7
					; echo ${Time}: Zaxfalump is within 7
					; RI_Atom_SetLockSpot off
					; RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[TRUE]
					; RI_Atom_MoveBehind ALL ${Actor["Zaxfalump"].ID} 30 100
					; echo ${Time}: Moving Behind ${Actor["Zaxfalump"]} / ${Actor["Zaxfalump"].ID} 
					; wait 50
					; RI_Atom_MoveBehind ALL OFF
					; RI_Var_Bool_MoveBehindIgnoreAggroCheck:Set[FALSE]
					; ReleasedTank:Set[TRUE]
					; echo ${Time}: Done Moving Behind ${Actor["Zaxfalump"]} / ${Actor["Zaxfalump"].ID} 
					; RI_Atom_SetLockSpot ${Me.Name}
					if ${Me.GetGameData[Self.ZoneName].Label.Find[Challenge](exists)}
						RI_Atom_SetLockSpot off
					ReleasedTank:Set[TRUE]
				}
				if ${Target.ID}!=${Actor[Zaxfalump].ID}
					Actor[Zaxfalump]:DoTarget
			}
		}
		wait 2
	}
}

function Bull()
{
	echo ISXRI: Starting BullHeroic 
	
	declare BardDone string FALSE
	;lockspot to -30,-124,-76
	RI_Atom_SetLockSpot ${Me.Name} -30 -124 -76 1 100
	wait 10
	while ${Actor["Bull McCleran"](exists)} && !${Actor["Bull McCleran"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a Brokenskull Pirate",radius,15](exists)}
			{
				if ${Target.ID}!=${Actor["a Brokenskull Pirate"].ID}
					Actor["a Brokenskull Pirate"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["Bull McCleran"].ID}
					Actor["Bull McCleran"]:DoTarget
			}
		}
		elseif ${Me.Class.Equal[bard]} && !${BardDone}
		{
			;need to add code in here to wait until you are casting both.
			wait 100
			
			;turn off assisting
			RI_CMD_Assisting 0
				
			;pause bots
			RI_CMD_PauseCombatBots 1
			
			press f1
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -29.95 -80.29
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -35.15 -80.76
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -37.48 -72.40
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -41.58 -80.22
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -43.01 -72.27
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -44.56 -79.94
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -46.78 -72.74
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -49.02 -79.23
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -51.72 -73.33
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -52.35 -80.09
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			
			;move to brazier, click it, move to crate, click it
			call _MoveC -22.34 -74.97
			wait 10
			while ${Actor["Boss 1 Brazier"].Interactable}
			{
				Actor["Boss 1 Brazier"]:DoubleClick
				wait 2
			}
			wait 20
			call _MoveC -54.94 -80.59
			wait 10
			while ${Actor[Crate].Interactable}
			{
				Actor[Crate]:DoubleClick
				wait 2
			}
			wait 20
			BardDone:Set[TRUE]
			
			;turn on assisting
			RI_CMD_Assisting 1
				
			;unpause bots
			RI_CMD_PauseCombatBots 0
			
			;move back to camp
			call _MoveC -30 -76
		}
	}
	echo Ending BullHeroic
}
function Yipnik()
{
	echo ISXRI: Starting Yipnik 
	
	;turn on lockspot to 11.78 -101.06 -5.20
	RI_Atom_SetLockSpot ${Me.Name} 11.78 -101.06 -5.20 1 100
	wait 10
	;code here to move behind / or not
	while ${Actor[Yipnik](exists)} && !${Actor[Yipnik].IsDead}
	{
		;if i am a fighter
		if !${RI_Var_Bool_GlobalOthers}
		{
			;if thick molasses exists and i am not targeting, target
			if ${Actor["thick molasses"](exists)}
			{
				if ${Target.ID}!=${Actor["thick molasses"].ID}
					Actor["thick molasses"]:DoTarget
			}
			
			;else, if i am not targeting yipnik target him
			else
			{
				if ${Target.ID}!=${Actor[Yipnik].ID}
					Actor[Yipnik]:DoTarget
			}
		}
		if ${Me.Class.Equal[bard]} || ${Me.Class.Equal[enchanter]}
		{
			if ${Actor["Boss 8 Press Click Area"].Interactable}
			{
				;pause bots
				RI_CMD_PauseCombatBots 1
				
				;move to 4.31 0.81
				call _MoveC 4.31 0.81
								
				;while the clicky is clickable keep clicking
				while ${Actor["Boss 8 Press Click Area"].Interactable}
				{
					Actor["Boss 8 Press Click Area"]:DoubleClick
					wait 2
				}
				
				;move back to camp
				call _MoveC 11.78 -5.20
				
				;unpause bots
				RI_CMD_PauseCombatBots 0
			}
		}
		wait 2
	}
	echo Ending Yipnik
}
function Grogmogo()
{
	echo ISXRI: Starting Grogmogo 
	
	;turn onm lockspot to 149.99,-23.99,119.10
	RI_Atom_SetLockSpot ${Me.Name} 149.99 -23.99 119.10 1 100
	wait 10
	
	if ${Me.Class.Equal[bard]}
	{
		;move to keg
		call _MoveC 136.77 115.04
		
		;change camera, pick up keg
		Press -hold "Page Down"
		wait 5
		Actor[keg]:DoubleClick
		wait 5
		
		;move to position
		call _MoveC 156.86 112.55
		wait 10
		
		;move mouse to center of screen aka on top of you
		Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[${Display.Height}/2]}]
		wait 2
		
		;click to place
		Mouse:LeftClick
		
		wait 5
		Press -release "Page Down"
		Press -hold "Page Up"
		wait 2
		Press -release "Page Up"
		
		;move back to camp
		call _MoveC 149.99 119.10
	}
	
	wait 300 ${Actor[Grogmogo].IsAggro}
	
	while ${Actor[Grogmogo](exists)} && !${Actor[Grogmogo].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Grogmogo].ID}
				Actor[Grogmogo]:DoTarget
		}
		if ${Me.Class.Equal[bard]} && !${Actor[Grogmogo].IsAggro}
		{
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			if ${Actor[loc,130.382996,117.239197].Interactable}
			{
				call _MoveC 131 118
				wait 2
				while ${Actor[loc,130.382996,117.239197].Interactable}
				{
					Actor[loc,130.382996,117.239197]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,133.386200,108.503899].Interactable}
			{
				call _MoveC 134.37 109.82
				wait 2
				while ${Actor[loc,133.386200,108.503899].Interactable}
				{
					Actor[loc,133.386200,108.503899]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,141.726395,110.440498].Interactable}
			{
				call _MoveC 142.90 111.60
				wait 2
				while ${Actor[loc,141.726395,110.440498].Interactable}
				{
					Actor[loc,141.726395,110.440498]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,142.751602,100.730904].Interactable}
			{
				call _MoveC 142.88 101.80
				wait 2
				while ${Actor[loc,142.751602,100.730904].Interactable}
				{
					Actor[loc,142.751602,100.730904]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,150.384399,99.167526].Interactable}
			{
				call _MoveC 150.05 100.63
				wait 2
				while ${Actor[loc,150.384399,99.167526].Interactable}
				{
					Actor[loc,150.384399,99.167526]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,159.124893,105.567299].Interactable}
			{
				call _MoveC 157.57 107.10
				wait 2
				while ${Actor[loc,159.124893,105.567299].Interactable}
				{
					Actor[loc,159.124893,105.567299]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,164.136395,107.803497].Interactable}
			{
				call _MoveC 162.64 108.51
				wait 2
				while ${Actor[loc,164.136395,107.803497].Interactable}
				{
					Actor[loc,164.136395,107.803497]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,165.475693,117.599602].Interactable}
			{
				call _MoveC 163.67 117.46
				wait 2
				while ${Actor[loc,165.475693,117.599602].Interactable}
				{
					Actor[loc,165.475693,117.599602]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,164.914902,123.747597].Interactable}
			{
				call _MoveC 163.74 123.90
				wait 2
				while ${Actor[loc,164.914902,123.747597].Interactable}
				{
					Actor[loc,164.914902,123.747597]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,163.712204,128.786606].Interactable}
			{
				call _MoveC 162.26 127.58
				wait 2
				while ${Actor[loc,163.712204,128.786606].Interactable}
				{
					Actor[loc,163.712204,128.786606]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,160.756104,133.981506].Interactable}
			{
				call _MoveC 159.87 132.40
				wait 2
				while ${Actor[loc,160.756104,133.981506].Interactable}
				{
					Actor[loc,160.756104,133.981506]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,152.699600,136.929504].Interactable}
			{
				call _MoveC 152.46 135.66
				wait 2
				while ${Actor[loc,152.699600,136.929504].Interactable}
				{
					Actor[loc,152.699600,136.929504]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,145.878098,138.649796].Interactable}
			{
				call _MoveC 146.03 137.89
				wait 2
				while ${Actor[loc,145.878098,138.649796].Interactable}
				{
					Actor[loc,145.878098,138.649796]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,143.169495,134.121994].Interactable}
			{
				call _MoveC 144.01 132.37
				wait 2
				while ${Actor[loc,143.169495,134.121994].Interactable}
				{
					Actor[loc,143.169495,134.121994]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			;check if rum bottle is interactable (clickable) and if so move to it and click it
			elseif ${Actor[loc,139.131805,131.914093].Interactable}
			{
				call _MoveC 140.22 130.58
				wait 2
				while ${Actor[loc,139.131805,131.914093].Interactable}
				{
					Actor[loc,139.131805,131.914093]:DoubleClick
					Actor["Boss 7 Rum Bottle"]:DoubleClick
					wait 2
				}
			}
			wait 20
			
			;move back to camp
			call _MoveC 149.99 119.10
		}
		wait 2
	}
	echo Ending Grogmogo
}
function Charanda()
{
	echo ISXRI: Starting CharandaHeroic 
	
	;turn on lockspot to -46.66,-97.14,81.65
	RI_Atom_SetLockSpot ${Me.Name} -46.66 -97.14 81.65
	wait 10
	;code here to move behind
	while ${Actor[Charanda](exists)} && !${Actor[Charanda].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["Portia Rumuffin's Corpse"](exists)} && ${Actor["Portia Rumuffin's Corpse"].IsAggro}
			{
				if ${Target.ID}!=${Actor["Portia Rumuffin's Corpse"].ID}
					Actor["Portia Rumuffin's Corpse"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor[Charanda].ID}
					Actor[Charanda]:DoTarget
			}
		}
		if ${Actor["Curse"](exists)}
		{
			RI_Atom_SetLockSpot ${Me.Name} -41.15 -97.44 99.51
			wait 110 !${Actor["Curse"](exists)}
			RI_Atom_SetLockSpot ${Me.Name} -46.66 -97.14 81.65
			wait 20
		}
		wait 2
	}
	echo Ending CharandaHeroic
	RI_Atom_SetLockSpot ${Me.Name} -45.15 -97.44 86.51
}

function Corsair()
{
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingTextCorsair]
	;RI_Var_Bool_Loot:Set[FALSE]
	;RI_Var_Bool_CorpseLoot:Set[FALSE]
	echo ISXRI: Starting "The Red Corsair" v2
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[The Red Corsair/a says, FIRE!]
	;turn on lockspot too -112.53 190.01
	RI_Atom_SetLockSpot ${Me.Name} -111.53 -101.08 190.01
	
	wait 10
	;tank run to cannon, grab it, place it
	if !${RI_Var_Bool_GlobalOthers}
	{
		;move to cannon
		call _MoveC -72.13 217.45
		call _MoveC -33.07 210.90
		
		;change camera, pick up Cannon
		Press -hold "Page Down"
		wait 5
		Actor[Cannon]:DoubleClick
		wait 5
		
		;move to position
		call _MoveC -33.07 210.90
		call _MoveC -72.13 217.45
		call _MoveC -110.53 193.01
		call _MoveC -117.38 185.46
		call _MoveC -105.01 170.01
		wait 10
		
		;move mouse to just above center of screen aka on top of you and up
		Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[(${Display.Height}/2)-((${Display.Height}/2)*.1)]}]
		wait 2
		
		;click to place
		Mouse:LeftClick
		
		wait 10
		
		;code to point cannon.
		while ${Actor[Cannon Placement 1](exists)}
		{
			;pickup the cannon again
			eq2ex apply_verb ${Actor["Movable Cannon"].ID} Move
			wait 5
			
			;scroll the mouse wheel
			MouseWheel -500
			wait 5
			
			;move mouse to just above center of screen aka on top of you and up
			Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[(${Display.Height}/2)-((${Display.Height}/2)*.1)]}]
			wait 5
			
			;click to place
			Mouse:LeftClick
		}
		Press -release "Page Down"
		wait 5
		Press -hold "Page Up"
		wait 2
		Press -release "Page Up"
		call _MoveC -105.01 170.91
		call _MoveC -117.38 185.46
		call _MoveC -111.53 190.01
	}
	while ${Actor[Cannon Placement 1](exists)}
		wait 2
	;AnnounceText:Clear
	;AnnounceText:Insert[FIRE!]
	
	declare ActorIndex index:actor
	
	while ${Actor["The Red Corsair"](exists)} && !${Actor["The Red Corsair"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a corsair cannoneer"](exists)}
			{
				EQ2:GetActors[ActorIndex,"a corsair cannoneer"]
				if ${Target.ID}!=${ActorIndex[1].ID} && !${ActorIndex[1].IsDead}
					ActorIndex[1]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["The Red Corsair"].ID}
					Actor["The Red Corsair"]:DoTarget
			}
		}
		if ${Me.Archetype.NotEqual[fighter]}
		{
			if ${Actor[cannoneer,radius,7](exists)}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Looting ${Actor[cannoneer,radius,10]}
				eq2ex apply_verb ${Actor[cannoneer,radius,10].ID} Loot
				wait 5
				LootWindow:LootAll
			}
			;if she begins firing move back to camp
			;if ${Trigger} 
			;&& ${Math.Distance[${Me.X},${Me.Z},-110.53,193.01]}>5
			;{
				;call _MoveC -112.53 190.01
				;wait 60
				;Trigger:Set[FALSE]
			;}
			;bard when we have a cannonball, move to cannon when not ${Trigger}, and fire
			if ${Trigger}
			{
				wait 70
				Trigger:Set[FALSE]
			}
			if ${Me.Inventory["a cannonball"](exists)} && !${Trigger}
			{
				;turn off assisting
				RI_CMD_Assisting 0
				
				;pause bots
				RI_CMD_PauseCombatBots 1
				
				Actor["The Red Corsair"]:DoTarget
				if ${Math.Distance[${Me.X},${Me.Z},-105.01,170.91]}>5
					call _MoveC -105.01 170.91
				wait 10 ${Trigger}
				Actor["Cannon 1"]:DoubleClick
				wait 15 ${Trigger}
				Actor["Cannon 1"]:DoubleClick
				wait 15 ${Trigger}
				press f1
				wait 2 ${Trigger}
				Actor["The Red Corsair"]:DoubleClick
				wait 1 ${Trigger}
				Actor["The Red Corsair"]:DoTarget
				eq2ex apply_verb ${Actor["The Red Corsair"].ID} Fire
				wait 35 ${Trigger}
				
				;unpause bots
				RI_CMD_PauseCombatBots 0
				
				;turn on assisting
				RI_CMD_Assisting 1
				
			}
			if ${Math.Distance[${Me.X},${Me.Z},-112.53,190.01]}>5
				RI_Atom_ChangeLockSpot ALL -111.53 0 190.01
		}
		wait 2
	}
	;change lootoptions to roundrobin,turn looting back on, 
	;reenable caststack
	;call LootOptions RoundRobin
	wait 5
	;RI_Var_Bool_CorpseLoot:Set[TRUE]
	;RI_Var_Bool_Loot:Set[TRUE]
	
	;unpause bots
	RI_CMD_PauseCombatBots 0
	
	;turn on assisting
	RI_CMD_Assisting 1
	
	;detach atom
	Event[EQ2_onIncomingText]:DetachAtom[EQ2_onIncomingTextCorsair]
	
	echo Ending "The Red Corsair"
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingTextCorsair(string Text)
{
	
   	if ${Text.Find["The Red Corsair"](exists)} && ${Text.Find["says"](exists)} && ${Text.Find["FIRE!"](exists)}
	{
		echo ${Time}:IncomingText: ${Text}
		Trigger:Set[TRUE]
	}
}
function Grogmaga()
{
	echo ISXRI: Starting Grogmaga 
	
	;turn on lockspot to -170.655060 -70.852097 89.121651
	RI_Atom_SetLockSpot ${Me.Name} -170.655060 -70.852097 89.121651
	wait 10
	;code here to move behind
	while ${Actor[Grogmaga](exists)} && !${Actor[Grogmaga].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Grogmaga].ID}
				Actor[Grogmaga]:DoTarget
		}
		if ${Actor["Bed 11"].Interactable}
		{
			;pause bots
			RI_CMD_PauseCombatBots 1
				
			;click bed 11 until its no longer clickable
			while ${Actor["Bed 11"].Interactable}
			{
				Actor["Bed 11"]:DoubleClick
				wait 2
			}
			
			;unpause bots
			RI_CMD_PauseCombatBots 0
		}
		wait 1
	}
	echo Ending Grogmaga
	;RI_Atom_SetLockSpot ${Me.Name} -45.15 -97.44 86.51
}

function D'Vinn()
{
	echo ISXRI: Starting D'Vinn 
	
	;turn on lockspot to -166.672516 11.480156 -8.964397
	RI_Atom_SetLockSpot ${Me.Name} -166.672516 11.480156 -8.964397
	wait 10
	if ${Me.Archetype.NotEqual[fighter]}
	{
		RI_Atom_SetLockSpot OFF
		RI_Atom_MoveBehind ALL ${Actor["Emperor D'Vinn"].ID} 30 100
	}
	while ${Actor["Emperor D'Vinn"](exists)} || ${Actor["Shadow of D'Vinn"](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["Shadow of D'Vinn"](exists)}
				Actor["Shadow of D'Vinn"]:DoTarget
			elseif ${Target.ID}!=${Actor["Emperor D'Vinn"].ID}
				Actor["Emperor D'Vinn"]:DoTarget
		}
		wait 1
	}
	echo Ending D'Vinn
}
function CourtPowerCells()
{	
	;Script[Buffer:AggroControl].Variable[TrashTargeting]:Set[FALSE]
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call CourtPowerCells"]
	RI_Atom_SetLockSpot ALL -6.453318 14.054948 309.695282
	AnnounceText:Clear
	AnnounceText:Insert["Force shield for Power Cell D has been deactivated"]
	declare CourtFighterDone bool FALSE
	declare CourtBardDone bool FALSE
	while !${Trigger} 
	{
		;echo ${Time}: in first loop
		if !${RI_Var_Bool_GlobalOthers} && !${CourtFighterDone}
		{
			call _MoveC 13.21 310.44
			wait 10
			call _MoveC 11.48 257.18
			wait 10
			call _MoveC 5.39 256.77
			wait 10
			call _MoveC 4.49 269.57
			wait 5
			call _MoveC 8.43 270.42
			wait 5
			call _MoveC 8.75 278.51
			call _MoveC -6.26 279.96
			call _MoveC -6.453318 309.695282
			CourtFighterDone:Set[TRUE]
		}
		wait 50
		if ${Me.Class.Equal[bard]} && !${CourtBardDone}
		{
			;pause bots
			RI_CMD_PauseCombatBots 1
				
			;turn off assisting
			RI_CMD_Assisting 0
			
			Actor[${Me.ID}]:DoTarget
			call _MoveC 13.21 310.44 FALSE TRUE
			wait 10
			call _MoveC 11.48 257.18 FALSE TRUE
			wait 10
			call _MoveC 5.39 256.77 FALSE TRUE
			wait 10
			call _MoveC 4.49 269.57 FALSE TRUE
			wait 5
			call _MoveC 8.43 270.42 FALSE TRUE
			wait 5
			call _MoveC 8.75 278.51 FALSE TRUE
			wait 10
			;activate PCD
			;lever1
			Actor[loc,10.226260,279.910187]:DoubleClick
			wait 20
			;lever2
			Actor[loc,9.127361,279.860901]:DoubleClick
			wait 20
			;lever1
			Actor[loc,10.226260,279.910187]:DoubleClick
			wait 20
			;lever2
			Actor[loc,9.127361,279.860901]:DoubleClick
			wait 20
			;activate PCA
			;lever3
			Actor[loc,8.028465,279.811493]:DoubleClick
			wait 20
			;lever4
			Actor[loc,6.929599,279.762085]:DoubleClick
			wait 20
			;lever3
			Actor[loc,8.028465,279.811493]:DoubleClick
			wait 20
			;lever4
			Actor[loc,6.929599,279.762085]:DoubleClick
			wait 20
			;activate PCB
			;lever1
			Actor[loc,10.226260,279.910187]:DoubleClick
			wait 20
			;lever3
			Actor[loc,8.028465,279.811493]:DoubleClick
			wait 20
			;lever1
			Actor[loc,10.226260,279.910187]:DoubleClick
			wait 20
			;lever3
			Actor[loc,8.028465,279.811493]:DoubleClick
			wait 20
			;activate PCC
			;lever2
			Actor[loc,9.127361,279.860901]:DoubleClick
			wait 20
			;lever4
			Actor[loc,6.929599,279.762085]:DoubleClick
			wait 20
			call _MoveC -6.26 279.96 FALSE TRUE
			call _MoveC -6.453318 309.695282
			CourtBardDone:Set[TRUE]
			;unpause bots
			RI_CMD_PauseCombatBots 0
				
			;turn on assisting
			RI_CMD_Assisting 1
		}
		wait 1
	}
	while ${Actor[npc,"Power Cell D"](exists)}
	{
		;echo ${Time}: in d loop
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[npc,"Power Cell D"].ID}
				Actor[npc,"Power Cell D"]:DoTarget
		}
		wait 1
	}
	wait 600 ${Actor[npc,"Power Cell A"](exists)}
	while ${Actor[npc,"Power Cell A"](exists)}
	{
		;echo ${Time}: in a loop
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[npc,"Power Cell A"].ID}
				Actor[npc,"Power Cell A"]:DoTarget
		}
		wait 1
	}
	wait 600 ${Actor[npc,"Power Cell C"](exists)} 
	while ${Actor[npc,"Power Cell C"](exists)} 
	{
		;echo ${Time}: in c loop
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[npc,"Power Cell C"].ID}
				Actor[npc,"Power Cell C"]:DoTarget
		}
		wait 1
	}
	wait 600 ${Actor[npc,"Power Cell B"](exists)} 
	while ${Actor[npc,"Power Cell B"](exists)}
	{
		;echo ${Time}: in b loop
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[npc,"Power Cell B"].ID}
				Actor[npc,"Power Cell B"]:DoTarget
		}
		wait 1
	}
	;Script[Buffer:AggroControl].Variable[TrashTargeting]:Set[TRUE]
}
function King()
{
	echo ISXRI: Starting King 
	
	;turn on lockspot to -166.672516 11.480156 -8.964397
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} -31.312376 58.702354 -60.230434
	}
	else
	{
		RI_Atom_SetLockSpot ${Me.Name} -37.171376 58.702354 -51.880434
	}
	;king1 section
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} -39.88 58.69 -30.51
		wait 100 ${Math.Distance[${Me.Loc},-39.88,58.69,-30.51]}<3
		wait 10
		Actor[King]:DoTarget
		wait 50 ${Actor[King].Distance}<10
		RI_Atom_SetLockSpot ${Me.Name} -31.312376 58.702354 -60.230434
	}
	while ${Actor[King](exists)} && !${Actor[King].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["King"].ID}
				Actor["King"]:DoTarget
		}
	}
	wait 50
	relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
	relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
	wait 500 ${Actor["Master Clockwork Protocol"](exists)}
	relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
	relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
	declare MCPID int ${Actor["Master Clockwork Protocol"].ID}
	while ${Actor[${MCPID}](exists)} && !${Actor[${MCPID}].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a mechnamagica seeker-destroyer",radius,20](exists)}
				Actor["a mechnamagica seeker-destroyer",radius,20]:DoTarget
			elseif ${Actor["a klakdyne omega magus",radius,20](exists)}
				Actor["a klakdyne omega magus",radius,20]:DoTarget
			elseif ${Target.ID}!=${Actor["Master Clockwork Protocol"].ID}
				Actor["Master Clockwork Protocol"]:DoTarget
		}
		if ${Actor["Master Clockwork Protocol"].Health}<=16 && ${Me.Inventory["Energized Clockwork Gear"](exists)}
			Me.Inventory["Energized Clockwork Gear"]:Use
		wait 1
	}
	wait 600 ${Actor["Master Clockwork Protocol",notid,${MCPID}](exists)}
	if ${Me.Archetype.NotEqual[fighter]}
	{
		RI_Atom_MoveBehind ALL ${Actor["Master Clockwork Protocol",notid,${MCPID}].ID} 30 100
	}
	while ${Actor["Master Clockwork Protocol",notid,${MCPID}](exists)} && !${Actor["Master Clockwork Protocol",notid,${MCPID}].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["Master Clockwork Protocol",notid,${MCPID}].ID}
				Actor["Master Clockwork Protocol",notid,${MCPID}]:DoTarget
		}
		wait 1
	}
	echo Ending Protocol
}
function War()
{
	echo ISXRI: Starting War 
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		;turn on lockspot to -52.12 -0.42 -11.60
		RI_Atom_SetLockSpot ${Me.Name} -52.12 -0.42 -11.60
		wait 20
		Actor["The War Ancient of Zek"]:DoTarget
		while !${Me.RangedAutoAttackOn}
		{
			eq2ex togglerangedattack
			wait 2
		}
		wait 50 ${Math.Distance[${Me.Loc},-52.12,-0.42,-11.60}]}<2
		wait 20
	}
	else
	{
		;turn off assisting
		RI_CMD_Assisting 0
		
		wait 1
		;target self
		Actor[${Me.ID}]:DoTarget
		RI_Atom_SetLockSpot ${Me.Name} -1.615160 -0.661638 -11.359447
		wait 50
		RI_Atom_SetLockSpot OFF
		wait 1
		RI_Atom_MoveBehind ALL ${Actor["The War Ancient of Zek"].ID} 60 100
		
		;turn on assisting
		RI_CMD_Assisting 1
	}
	Actor[Mission]:DoubleClick
	while ${Actor["The War Ancient of Zek"](exists)} && !${Actor["The War Ancient of Zek"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["Crushbone",radius,10](exists)} && !${Actor["Crushbone",radius,10].IsDead}
				Actor["Crushbone",radius,10]:DoTarget
			elseif ${Target.ID}!=${Actor["The War Ancient of Zek"].ID}
				Actor["The War Ancient of Zek"]:DoTarget
		}
		wait 1
	}
	echo Ending War
}
function ValdoonRing()
{
	echo ISXRI: Starting ValdoonRing 
	
	;turn on lockspot to 175.551132 -3.739999 -51.235317
	RI_Atom_SetLockSpot ${Me.Name} 175.551132 -3.739999 -51.235317
	
	wait 50 ${Math.Distance[${Me.Loc},-52.12,-0.42,-11.60]}<2
	
	wait 10
	
	Actor[Valdoon]:DoubleClick
	wait 2
	Actor[Valdoon]:DoubleClick
	wait 2
	Actor[Valdoon]:DoubleClick
	wait 2
	Actor[Valdoon]:DoubleClick
	wait 2
	
	wait 1200 ${Actor["crypt guardian",radius,50](exists)}
	
	while ${Actor["crypt guardian",radius,50](exists)}
	{
		Actor["crypt guardian",radius,50]:DoTarget
		wait 5
	}
	
	;turn on lockspot to 178.247620 -3.779751 -48.961185
	RI_Atom_SetLockSpot ${Me.Name} 178.247620 -3.779751 -48.961185
	
	while ${Actor[Valdoon](exists)} && !${Actor[Valdoon].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Valdoon].ID}
				Actor[Valdoon]:DoTarget
		}
		wait 1
	}
	echo Ending ValdoonRing
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; END OF AOM NAMED CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; START OF TOT NAMED CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


function InkLurkerFN()
{
	;AnnounceText:Clear
	;AnnounceText:Insert["Force shield for Power Cell D has been deactivated"]
	;declare GotAll6 bool FALSE
	declare cnt int 0
	declare MobWithFurthestDistance int 0
	
	variable index:actor ActorIndex
	
	;while !${GotAll6}
	while ${Actor["The Ink Walker"].Type.NotEqual[NamedNPC]}
	{
		;populate actors to our ActorIndex that are NPC and within distance 8
		EQ2:GetActors[ActorIndex,NoKillNPC,"an ink lurker"]
		
		;echo ${Time}: ActorIndexSize: ${ActorIndex.Used}
			
		;for loop to iterate through all actors in our index
		for(cnt:Set[1];${cnt}<=${ActorIndex.Used};cnt:Inc)
		{
			;echo Checking ${ActorIndex[${cnt}].Name}
			
			if ${Math.Distance[${ActorIndex[${cnt}].Loc},-136.33,3.84,128.67]}>${Math.Distance[${Actor[${MobWithFurthestDistance}].Loc},-136.33,3.84,128.67]}
				MobWithFurthestDistance:Set[${ActorIndex[${cnt}].ID}]
			
			;echo checking ${cnt}
		}
		;turn on lockspot to ${MobWithFurthestDistance}
		if ${MobWithFurthestDistance}>0
			RI_Atom_SetLockSpot ${Me.Name} ${Actor[${MobWithFurthestDistance}].X} ${Actor[${MobWithFurthestDistance}].Y} ${Actor[${MobWithFurthestDistance}].Z}
			
		;check if we are incombat
		call RIMObj.CheckCombat TRUE

		wait 5
	}
}
function Nocturna()
{
	echo ISXRI: Starting Nocturna 
	
	declare ElementalConfinementMainIconID int 755
	
	RI_Atom_SetLockSpot FIGHTER 127.60 87.86 279.65

	while ${Actor["Nocturna"](exists)} && !${Actor["Nocturna"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["Diurna"](exists)} && !${Actor["Diurna"].IsDead}
			{
				if ${Target.ID}!=${Actor["Diurna"].ID}
					Actor["Diurna"]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor["Nocturna"].ID}
					Actor["Nocturna"]:DoTarget
			}
		}

		if ${Actor["Diurna"].Effect[1].MainIconID}==${ElementalConfinementMainIconID} || ${Actor["Diurna"].Effect[2].MainIconID}==${ElementalConfinementMainIconID} || ${Actor["Diurna"].Effect[3].MainIconID}==${ElementalConfinementMainIconID} || ${Actor["Diurna"].Effect[4].MainIconID}==${ElementalConfinementMainIconID} || ${Actor["Diurna"].Effect[5].MainIconID}==${ElementalConfinementMainIconID} 
		{
			RI_Atom_SetLockSpot ALL ${Actor["Diurna"].X} ${Actor["Diurna"].Y} ${Actor["Diurna"].Z}
			wait 300 ${Actor["Diurna"].Distance}<10
			RI_CMD_Cast "Absorb Magic" 1
			wait 30
		}
		else
		{
			RI_Atom_SetLockSpot ALL 204.44 31.45 -514.38
			wait 30
		}

		wait 1
	}
	
	echo Ending Nocturna
}
function Heracyne()
{
	echo ISXRI: Starting Heracyne 
	
	;turn on lockspot to -319.170471 51.213074 -60.860703
	RI_Atom_SetLockSpot ${Me.Name} -319.170471 51.213074 -60.860703
	
	wait 50 ${Math.Distance[${Me.Loc},-319.170471,51.213074,-60.860703]}<2
	
	while ${Actor[Heracyne](exists)} && !${Actor[Heracyne].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Heracyne].ID}
				Actor[Heracyne]:DoTarget
		}
		wait 1
		if ${Me.IsFD}
			press x
	}
	echo Ending Heracyne
}
function Mawz()
{
	echo ISXRI: Starting Mawz 
	
	declare BardDone string FALSE
	declare FervorOfTheUnderfootMainIconID int 485
	
	RI_Atom_SetLockSpot ALL 53.84 87.86 234.10
	
	;target mawz, wait until he is aggro on us.
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor["Mawz Harak"].ID}
			Actor["Mawz Harak"]:DoTarget
	}
	
	wait 300 ${Actor["Mawz Harak"].Distance}<15
	
	RI_Atom_SetLockSpot ALL 47.132492 87.863281 219.655853
	wait 300 ${Actor["Mawz Harak"].Distance}<12
	RI_Atom_SetLockSpot FIGHTER 46.50 87.86 210.11

	while ${Actor["Mawz Harak"](exists)} && !${Actor["Mawz Harak"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor["Mawz Harak"].ID}
				Actor["Mawz Harak"]:DoTarget
		}
		elseif ${Me.Class.Equal[bard]}
		{
			if ${Actor["Mawz Harak"].Effect[1].MainIconID}==${FervorOfTheUnderfootMainIconID} && ${Actor["Mawz Harak"].Effect[1].CurrentIncrements}>50
				call ClearFervor
			elseif ${Actor["Mawz Harak"].Effect[2].MainIconID}==${FervorOfTheUnderfootMainIconID} && ${Actor["Mawz Harak"].Effect[2].CurrentIncrements}>50
				call ClearFervor
			elseif ${Actor["Mawz Harak"].Effect[3].MainIconID}==${FervorOfTheUnderfootMainIconID} && ${Actor["Mawz Harak"].Effect[3].CurrentIncrements}>50
				call ClearFervor
			elseif ${Actor["Mawz Harak"].Effect[4].MainIconID}==${FervorOfTheUnderfootMainIconID} && ${Actor["Mawz Harak"].Effect[4].CurrentIncrements}>50 
				call ClearFervor
			elseif ${Actor["Mawz Harak"].Effect[5].MainIconID}==${FervorOfTheUnderfootMainIconID} && ${Actor["Mawz Harak"].Effect[5].CurrentIncrements}>50
				call ClearFervor
			else
				wait 50
		}
		wait 1
	}
	echo Ending Mawz
}

function ClearFervor()
{
	;declare actor index
	variable index:actor ActorIndex
	;pause bots
	RI_CMD_PauseCombatBots 1
	call _MoveC 62.95 228.54 FALSE TRUE
	call _MoveC 94.72 209.26 FALSE TRUE
	call _MoveC 74.73 189.84 FALSE TRUE
	call _MoveC 61.07 183.44 FALSE TRUE
	call _MoveC 53.81 190.52 FALSE TRUE
	call _MoveC 61.64 220.99 FALSE TRUE
	Actor[Crystal]:DoubleClick
	wait 2
	Actor[Crystal]:DoubleClick
	wait 30
	call _MoveC 53.81 190.52 FALSE TRUE
	call _MoveC 59.55 184.39 FALSE TRUE
	call _MoveC 86.29 191.10 FALSE TRUE
	call _MoveC 92.18 211.79 FALSE TRUE
	call _MoveC 67.07 246.26 FALSE TRUE
	
	wait 10
	;populate actors to our ActorIndex that are a snarling spirit
	EQ2:GetActors[ActorIndex,"a snarling spirit"]
	
	call _MoveC ${ActorIndex[1].X} ${ActorIndex[1].Z}
	wait 10
	Actor["a snarling spirit"]:DoubleClick
	wait 2
	Actor["a snarling spirit"]:DoubleClick
	wait 50
	;wait 100 !${Actor["a snarling spirit"].IsIdle}
	call _MoveC ${ActorIndex[2].X} ${ActorIndex[2].Z}
	wait 10
	Actor["a snarling spirit"]:DoubleClick
	wait 2
	Actor["a snarling spirit"]:DoubleClick
	wait 50
	;wait 100 !${Actor["a snarling spirit"].IsIdle}
	call _MoveC ${ActorIndex[3].X} ${ActorIndex[3].Z}
	wait 10
	Actor["a snarling spirit"]:DoubleClick
	wait 2
	Actor["a snarling spirit"]:DoubleClick
	wait 50
	call _MoveC 47.132492 219.655853
	;unpause bots
	RI_CMD_PauseCombatBots 0
	eq2ex clear_target
}

function Bailey()
{
	echo ISXRI: Starting Bailey 

	declare YellowBackDropIconID int 485
	declare RedBackDropIconID int 485
	declare BlueBackDropIconID int 485
	declare MainIconID int 357
	
	RI_Atom_SetLockSpot ALL 1.62 -9.56 15.22
	
	;target Bailey, wait until he is aggro on us.
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor[NamedNPC,"Barnum Bingling"].ID}
			Actor["Barnum Bingling"]:DoTarget
	}

	while ${Actor[NamedNPC,"Bailey Bingling"](exists)} && !${Actor[NamedNPC,"Bailey Bingling"].IsDead}
	{
		if ${Actor[NamedNPC,"Barnum Bingling"](exists)} && !${Actor[NamedNPC,"Barnum Bingling"].IsDead}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.ID}!=${Actor[NamedNPC,"Barnum Bingling"].ID}
					Actor["Barnum Bingling"]:DoTarget
			}
			if ${Actor[NamedNPC,"Barnum Bingling"].Effect[1].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Barnum Bingling"].Effect[1].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Barnum Bingling"].Effect[2].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Barnum Bingling"].Effect[2].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Barnum Bingling"].Effect[3].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Barnum Bingling"].Effect[3].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Barnum Bingling"].Effect[4].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Barnum Bingling"].Effect[4].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Barnum Bingling"].Effect[5].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Barnum Bingling"].Effect[5].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
		}
		else
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.ID}!=${Actor[NamedNPC,"Bailey Bingling"].ID}
					Actor["Bailey Bingling"]:DoTarget
			}
			if ${Actor[NamedNPC,"Bailey Bingling"].Effect[1].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Bailey Bingling"].Effect[1].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Bailey Bingling"].Effect[2].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Bailey Bingling"].Effect[2].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Bailey Bingling"].Effect[3].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Bailey Bingling"].Effect[3].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Bailey Bingling"].Effect[4].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Bailey Bingling"].Effect[4].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
			elseif ${Actor[NamedNPC,"Bailey Bingling"].Effect[5].MainIconID}==${MainIconID}
			{
				switch ${Actor[NamedNPC,"Bailey Bingling"].Effect[5].BackDropIconID}
				{
					;yellow
					case 33085
					{
						if ${Math.Distance[${Me.Loc},-43.544041,-10.345064,17.085676]}>5
						{
							call _MoveC -43.54 17.09 TRUE
						}
						break
					}
					;red
					case 33083
					{
						if ${Math.Distance[${Me.Loc},-10.018149,-10.345072,-5.996769]}>5
						{
							call _MoveC -10.02 -6 FALSE TRUE
						}
						break
					}
					;blue
					case 33081
					{
						if ${Math.Distance[${Me.Loc},17.392654,-6.107872,23.880922]}>5
						{
							call _MoveC 19.52 15.78 FALSE TRUE
							call _MoveC 17.39 23.88 FALSE TRUE
						}
						break
					}
				}
			}
		}
		wait 1
	}
	call _MoveC 2.51 15.64 FALSE FALSE
	;Actor[fungal]:DoTarget
	echo Ending Bailey
}
function Tothrak()
{
	echo ISXRI: Starting Tothrak 
	
	RI_Atom_SetLockSpot ALL 71.158806 34.857967 -172.700897
	Actor[Tothrak]:DoTarget
	
	call _MoveC 71.158806 -172.700897
	wait 50
	while ${Actor[armorsmith,radius,5](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor[armorsmith,radius,5]:DoTarget
		}
		wait 5
	}
	call _MoveC 72 -183
	while ${Actor[armorsmith,radius,5](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor[armorsmith,radius,5]:DoTarget
		}
		wait 5
	}
	call _MoveC 77 -168
	while ${Actor[armorsmith,radius,5](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor[armorsmith,radius,5]:DoTarget
		}
		wait 5
	}
	call _MoveC 71 -173
	while ${Actor[Tothrak](exists)} && !${Actor[Tothrak].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!= ${Actor[Tothrak].ID}
				Actor[Tothrak]:DoTarget
		}
		wait 1
	}
	echo Ending Tothrak
}
function Gavitzle()
{
	echo ISXRI: Starting Gavitzle 
	Actor[animated,radius,20]:DoTarget
	RI_Atom_SetLockSpot ALL -164.219162 -2.514840 -143.597137
	
	while ${Actor[Gavitzle](exists)} && !${Actor[Gavitzle].IsDead}
	{
		while ${Actor[animated,radius,20](exists)}
		{
			Actor[animated,radius,20]:DoTarget
			wait 1
		}
		if ${Actor[Gavitzle].Distance}>10
			call GavitzleFinder
		wait 1
	}
	echo Ending Gavitzle
	;we are at top
	if ${Math.Distance[${Me.Loc},-202.007523,4.663108,-137.058838]}<5
	{
		call GavitzleMoveFromTop
	}
	;we are at front
	if ${Math.Distance[${Me.Loc},-159.020706,-2.961447,-105.893440]}<5
	{
		call GavitzleMoveFromFront
	}
	call GavitzleMoveCenter
}
function GavitzleFinder()
{
	;first lets move if we are at top or front
	;we are at top
	if ${Math.Distance[${Me.Loc},-202.007523,4.663108,-137.058838]}<5
	{
		call GavitzleMoveFromTop
		call GavitzleMoveCenter
	}
	;we are at front
	elseif ${Math.Distance[${Me.Loc},-159.020706,-2.961447,-105.893440]}<5
	{
		call GavitzleMoveFromFront
		call GavitzleMoveCenter
	}
	else
		call GavitzleMoveCenter
	;gavitzle is at the center
	if ${Math.Distance[${Actor[Gavitzle].Loc},-171.729034,-2.832729,-127.309723]}<5
	{
		call GavitzleMoveCenter
	}
	;gavitzle is at the spawn
	if ${Math.Distance[${Actor[Gavitzle].Loc},-164.219162,-2.514840,-143.597137]}<5
	{
		call GavitzleMoveSpawn
	}
	;gavitzle is at the front
	if ${Math.Distance[${Actor[Gavitzle].Loc},-159.020706,-2.961447,-105.893440]}<5
	{
		call GavitzleMoveFront
	}
	;gavitzle is at the top
	if ${Math.Distance[${Actor[Gavitzle].Loc},-202.007523,4.663108,-137.058838]}<5
	{
		call GavitzleMoveTop
	}
}
function GavitzleMoveCenter()
{
	call _MoveC -171.729034 -127.309723
}
function GavitzleMoveFront()
{
	call _MoveC -158.635156 -115.427090
	call _MoveC -159.020706 -105.893440
}
function GavitzleMoveFromFront()
{
	call _MoveC -158.635156 -115.427090
}
function GavitzleMoveSpawn()
{
	call _MoveC -164.219162 -143.597137
}
function GavitzleMoveTop()
{
	call _MoveC -185.549162 -126.467137
	call _MoveC -192.991478 -121.954142
	call _MoveC -202.007523 -137.058838
}
function GavitzleMoveFromTop()
{
	call _MoveC -198.761252 -132.431245
	wait 10
	call _MoveC -192.991478 -121.954142
	call _MoveC -185.549162 -126.467137
}
function Cugdava()
{
	echo ISXRI: Starting Cugdava 
	
	RI_Atom_SetLockSpot ALL -164.219162 -2.514840 -143.597137
	
	while ${Actor[Cugdava](exists)} && !${Actor[Cugdava].IsDead}
	{
		Actor[Cugdava]:DoTarget
		wait 750 ${Actor[Cugdava].IsDead}
		if ${Actor[Cugdava](exists)} && !${Actor[Cugdava].IsDead}
		{
			call _MoveC 58.87 -144.53
			wait 750 ${Actor[Cugdava].IsDead}
		}
		if ${Actor[Cugdava](exists)} && !${Actor[Cugdava].IsDead}
		{
			call _MoveC 42.97 -160.57
			wait 750 ${Actor[Cugdava].IsDead}
		}
		if ${Actor[Cugdava](exists)} && !${Actor[Cugdava].IsDead}
		{
			call _MoveC 37.87 -171.57
			wait 750 ${Actor[Cugdava].IsDead}
		}
		if ${Actor[Cugdava](exists)} && !${Actor[Cugdava].IsDead}
		{
			call _MoveC 25.47 -186.33
			wait 750 ${Actor[Cugdava].IsDead}
		}
		call _MoveC 26.17 -164.33
		while ${Actor["Gavitzle the Charbroiled"](exists)} && !${Actor["Gavitzle the Charbroiled"].IsDead}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.ID}!=${Actor["Gavitzle the Charbroiled"].ID}
					Actor["Gavitzle the Charbroiled"]:DoTarget
			}
			wait 1
		}
		return
	}
	echo Ending Cugdava
}
function SpawnDreadtusk()
{
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call SpawnDreadtusk"]
	press f1
	RI_CMD_PauseCombatBots 1
	RI_Atom_SetRIFollow OFF
	
	variable int _Counter
	_Counter:Set[1]
	variable int _PullTime
	_PullTime:Set[${Time.SecondsSinceMidnight}]
	variable bool _Moved
	_Moved:Set[FALSE]
	variable int _MyNum
	variable int P2G
	declare GroupArray[${Me.Group}] string
	declare Group string
	variable int count=0
	for(count:Set[1];${count}<=${Me.Group};count:Inc)
		GroupArray[${count}]:Set[${Me.Group[${Math.Calc[${count}-1]}]}]
	variable int count2=0
	declare temp string
	for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
	{
		for(count2:Set[1];${count2}<=${GroupArray.Size};count2:Inc)
		{
			if ${GroupArray[${count2}].Compare[${GroupArray[${count}]}]}>0
			{
				temp:Set[${GroupArray[${count}]}]
				GroupArray[${count}]:Set[${GroupArray[${count2}]}]
				GroupArray[${count2}]:Set[${temp}]
			}
		}
    }
	for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
	{
		if ${Me.Name.Equal[${GroupArray[${count}]}]}
			_MyNum:Set[${count}]
	}
	if ${Actor[Query, Name == "${GroupArray[1]}" && Type == "PC"].Archetype.Equal[fighter]}
		P2G:Set[2]
	else
		P2G:Set[1]
	
	while !${Actor[NamedNPC,Dreadtusk](exists)}
	{	
		if ${Me.Class.Equal[bard]}
		{
			press shift+r
			RI_Atom_SetLockSpot ${Me.Name} 309.662445 69.212280 -90.328735 1 100
			call _MoveC 308.587830 -91.312325
			wait 10
			press shift+r
			Actor[aggressive]:DoTarget
			wait 4
			Me.Inventory[a boar horn]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			call _MoveC 292.764008 -106.594910
			wait 10
			RI_Atom_SetLockSpot OFF
			Actor["a primordial shackler"]:DoTarget
			wait 2
			Me.Ability[id,201991618]:Use
						wait 50
			RI_Atom_SetLockSpot ${Me.Name} 317.851013 0 -68.816887
			call _MoveC 317.851013 -68.816887
			wait 150 ${Actor["A primordial shackler"].Distance}<10
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["A primordial shackler"]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
			while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
			{
				wait 1
			}
			while ${Actor["aggressive",radius,10](exists)}
			{
				wait 1
			}
			wait 50
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			relay ${RI_Var_String_RelayGroup} -noredirect press f1
			press shift+r
			call _MoveC 308.587830 -91.312325
			wait 10
			press shift+r
			Actor[aggressive]:DoTarget
			wait 4
			Me.Inventory[a boar horn]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			call _MoveC 284.765503 -115.217926
			wait 10
			RI_Atom_SetLockSpot OFF
			Actor["a primordial shackler"]:DoTarget
			wait 2
			Me.Ability[id,201991618]:Use
			wait 50
			RI_Atom_SetLockSpot ${Me.Name} 317.851013 0 -68.816887
			call _MoveC 317.851013 -68.816887
			wait 150 ${Actor["A primordial shackler"].Distance}<10
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["A primordial shackler"]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
			while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
			{
				wait 1
			}
			while ${Actor["aggressive",radius,10](exists)}
			{
				wait 1
			}
			wait 50
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			relay ${RI_Var_String_RelayGroup} -noredirect press f1
			press shift+r
			call _MoveC 308.587830 -91.312325
			wait 10
			press shift+r
			Actor[aggressive]:DoTarget
			wait 4
			Me.Inventory[a boar horn]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			call _MoveC 280.233276 -106.611359
			wait 10
			RI_Atom_SetLockSpot OFF
			Actor["a primordial shackler"]:DoTarget
			wait 2
			Me.Ability[id,201991618]:Use
			wait 50
			RI_Atom_SetLockSpot ${Me.Name} 317.851013 69.127251 -68.816887 1 100
			call _MoveC 317.851013 -68.816887
			wait 150 ${Actor["A primordial shackler"].Distance}<10
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["A primordial shackler"]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
			while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
			{
				wait 1
			}
			RI_Atom_SetLockSpot OFF
			return
		}
		while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.Name.NotEqual["A primordial shackler"]}
					Actor["A primordial shackler",radius,10]:DoTarget
			}
			wait 1
		}
		while ${Actor["aggressive",radius,10](exists)}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				Actor["aggressive",radius,10]:DoTarget
			}
			wait 1
		}
		wait 1
	}
	relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	while ${Actor["aggressive",radius,40](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor["aggressive",radius,40]:DoTarget
		}
		wait 1
	}
}
function Dreadtusk()
{
	echo ISXRI: Starting Dreadtusk 
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor[Dreadtusk].ID}
			Actor[Dreadtusk]:DoTarget
	}

	wait 200 ${Actor[Dreadtusk].Distance}<10
	wait 50
	
	RI_Atom_MoveBehind NONFIGHTER ${Actor[Dreadtusk].ID} 30 99
	
	while ${Actor[Dreadtusk](exists)} && !${Actor[Dreadtusk].IsDead}
	{
		if ${Me.Cursed}==-1
		{
			RI_CMD_PauseCombatBots 1
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			wait 2
			Me.Inventory["a boar horn"]:Use
			wait 1
			Me.Inventory["a boar horn"]:Use
			wait 1
			Me.Inventory["a boar horn"]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			RI_CMD_PauseCombatBots 0
		}
		wait 1
	}
	echo Ending Dreadtusk
}
function SpawnDreadmaw()
{
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call SpawnDreadmaw"]
	press f1
	RI_CMD_PauseCombatBots 1
	RI_Atom_SetRIFollow OFF
	variable int _Counter
	_Counter:Set[1]
	variable int _PullTime
	_PullTime:Set[${Time.SecondsSinceMidnight}]
	variable bool _Moved
	_Moved:Set[FALSE]
	variable int _MyNum
	variable int P2G
	declare GroupArray[${Me.Group}] string
	declare Group string
	variable int count=0
	for(count:Set[1];${count}<=${Me.Group};count:Inc)
		GroupArray[${count}]:Set[${Me.Group[${Math.Calc[${count}-1]}]}]
	variable int count2=0
	declare temp string
	for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
	{
		for(count2:Set[1];${count2}<=${GroupArray.Size};count2:Inc)
		{
			if ${GroupArray[${count2}].Compare[${GroupArray[${count}]}]}>0
			{
				temp:Set[${GroupArray[${count}]}]
				GroupArray[${count}]:Set[${GroupArray[${count2}]}]
				GroupArray[${count2}]:Set[${temp}]
			}
		}
    }
	for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
	{
		if ${Me.Name.Equal[${GroupArray[${count}]}]}
			_MyNum:Set[${count}]
	}
	if ${Actor[Query, Name == "${GroupArray[1]}" && Type == "PC"].Archetype.Equal[fighter]}
		P2G:Set[2]
	else
		P2G:Set[1]
	
	while !${Actor[NamedNPC,Dreadmaw](exists)}
	{	
		if ${_MyNum}==${P2G}
		{
			press shift+r
			RI_Atom_SetLockSpot ${Me.Name} 306.469269 69.342041 85.171989 1 100
			call _MoveC 305.615021 86.921913
			wait 10
			press shift+r
			Actor[aggressive]:DoTarget
			wait 4
			Me.Inventory[a wolf whistle]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			call _MoveC 291.515289 103.210007
			wait 10
			RI_Atom_SetLockSpot OFF
			Actor["a primordial shackler"]:DoTarget
			wait 2
			Me.Ability[id,1353985953]:Use
			wait 2
			RI_Atom_SetLockSpot ALL 299.721375 69.122292 94.175537 1 100
			call _MoveC 299.721375 94.175537
			wait 5
			RI_Atom_SetLockSpot OFF
			wait 40
			RI_Atom_SetLockSpot ALL 318.002350 0 67.266739 1 100
			call _MoveC 318.002350 67.266739
			wait 150 ${Actor["A primordial shackler"].Distance}<10
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["A primordial shackler"]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
			while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
			{
				wait 1
			}
			while ${Actor["aggressive",radius,10](exists)}
			{
				wait 1
			}
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			relay ${RI_Var_String_RelayGroup} -noredirect press f1
			press shift+r
			call _MoveC 305.615021 86.921913
			wait 10
			press shift+r
			Actor[aggressive]:DoTarget
			wait 4
			Me.Inventory[a wolf whistle]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			call _MoveC 281.610474 105.429169
			wait 10
			RI_Atom_SetLockSpot OFF
			Actor["a primordial shackler"]:DoTarget
			wait 2
			Me.Ability[id,1353985953]:Use
			wait 2
			RI_Atom_SetLockSpot ALL 299.721375 69.122292 94.175537 1 100
			call _MoveC 299.721375 94.175537
			wait 5
			RI_Atom_SetLockSpot OFF
			wait 40
			RI_Atom_SetLockSpot ALL 318.002350 0 67.266739 1 100
			call _MoveC 318.002350 67.266739
			wait 150 ${Actor["A primordial shackler"].Distance}<10
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["A primordial shackler"]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
			while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
			{
				wait 1
			}
			while ${Actor["aggressive",radius,10](exists)}
			{
				wait 1
			}
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			relay ${RI_Var_String_RelayGroup} -noredirect press f1
			press shift+r
			call _MoveC 305.615021 86.921913
			wait 10
			press shift+r
			Actor[aggressive]:DoTarget
			wait 4
			Me.Inventory[a wolf whistle]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			call _MoveC 285.824677 112.243462
			wait 10
			RI_Atom_SetLockSpot OFF
			Actor["a primordial shackler"]:DoTarget
			wait 2
			Me.Ability[id,1353985953]:Use
			wait 2
			RI_Atom_SetLockSpot ALL 299.721375 69.122292 94.175537 1 100
			call _MoveC 299.721375 94.175537
			wait 5
			RI_Atom_SetLockSpot OFF
			wait 40
			RI_Atom_SetLockSpot ALL 318.002350 0 67.266739 1 100
			call _MoveC 318.002350 67.266739
			wait 150 ${Actor["A primordial shackler"].Distance}<10
			relay ${RI_Var_String_RelayGroup} -noredirect Actor["A primordial shackler"]:DoTarget
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
			while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
			{
				wait 1
			}
			RI_Atom_SetLockSpot OFF
			return
		}
		while ${Actor["A primordial shackler",radius,10](exists)} && !${Actor["A primordial shackler",radius,10].IsDead}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.Name.NotEqual["A primordial shackler"]}
					Actor["A primordial shackler",radius,10]:DoTarget
			}
			wait 1
		}
		while ${Actor["aggressive",radius,10](exists)}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				Actor["aggressive",radius,10]:DoTarget
			}
			wait 1
		}
		wait 1
	}
	relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	while ${Actor["aggressive",radius,40](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			Actor["aggressive",radius,40]:DoTarget
		}
		wait 1
	}

}
function Dreadmaw()
{
	AnnounceText:Clear
	AnnounceText:Insert["You reach for your wolf whistle as Dreadmaw stares in your direction"]
	echo ISXRI: Starting Dreadmaw 
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor[Dreadmaw].ID}
			Actor[Dreadmaw]:DoTarget
	}
	wait 200 ${Actor[Dreadmaw].Distance}<10
	wait 50
	RI_Atom_MoveBehind NONFIGHTER ${Actor[Dreadmaw].ID} 30 99
	while ${Actor[Dreadmaw](exists)} && !${Actor[Dreadmaw].IsDead}
	{
		if ${Trigger}
		{
			wait 40
			RI_CMD_PauseCombatBots 1
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue
			wait 2
			Me.Inventory["a wolf whistle"]:Use
			wait 1
			Me.Inventory["a wolf whistle"]:Use
			wait 1
			Me.Inventory["a wolf whistle"]:Use
			wait 5
			wait 100 !${Me.CastingSpell}
			RI_CMD_PauseCombatBots 0
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo Ending Dreadmaw
}
function Hagrash()
{
	;AnnounceText:Clear
	;AnnounceText:Insert["combat abilities will soon be purged"]
	echo ISXRI: Starting Hagrash 
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor[NamedNPC,Hagrash].ID}
			Actor[NamedNPC,Hagrash]:DoTarget
	}
	wait 200 ${Actor[NamedNPC,Hagrash].Distance}<10
	;RI_Atom_MoveBehind NONFIGHTER ${Actor[NamedNPC,Hagrash].ID} 30 99
	while ${Actor[NamedNPC,Hagrash](exists)} && !${Actor[NamedNPC,Hagrash].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[NamedNPC,Hagrash].ID}
				Actor[NamedNPC,Hagrash]:DoTarget
			if ${Me.Group[1].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[1].Name},TRUE]
			elseif ${Me.Group[2].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[2].Name},TRUE]
			elseif ${Me.Group[3].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[3].Name},TRUE]
			elseif ${Me.Group[4].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[4].Name},TRUE]
			elseif ${Me.Group[5].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[5].Name},TRUE]
			if ${Me.Maintained[Intercept III](exists)}
				Me.Maintained[Intercept III]:Cancel
		}
		else
		{
			if ${Me.Cursed}==-1
			{
				RI_CMD_PauseCombatBots 1
				while ${Me.Cursed}==-1
					wait 1
				RI_CMD_PauseCombatBots 0
			}
		}
		; if ${Trigger}
		; {
			; if !${RI_Var_Bool_GlobalOthers}
			; {
				; wait 30
				; if ${TriggerMessage.Find[${Me.Group[1].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[1].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[2].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[2].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[3].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[3].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[4].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[4].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[5].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[5].Name},TRUE]
			; }
			; elseif ${TriggerMessage.Find[${Me.Name}](exists)}
			; {
				; RI_CMD_PauseCombatBots 1
				; eq2ex cancel_spellcast
				; eq2ex clearabilityqueue
				; wait 50
				; RI_CMD_PauseCombatBots 0
			; }
			; Trigger:Set[FALSE]
		; }
		wait 1
	}
	echo Ending Hagrash
}
function Gagrash()
{
	;AnnounceText:Clear
	;AnnounceText:Insert["spells will soon be purged"]
	echo ISXRI: Starting Gagrash 
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor[NamedNPC,Gagrash].ID}
			Actor[NamedNPC,Gagrash]:DoTarget
	}
	wait 200 ${Actor[NamedNPC,Gagrash].Distance}<10
	;RI_Atom_MoveBehind NONFIGHTER ${Actor[NamedNPC,Gagrash].ID} 30 99
	while ${Actor[NamedNPC,Gagrash](exists)} && !${Actor[NamedNPC,Gagrash].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[NamedNPC,Gagrash].ID}
				Actor[NamedNPC,Gagrash]:DoTarget
			if ${Me.Group[1].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[1].Name},TRUE]
			elseif ${Me.Group[2].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[2].Name},TRUE]
			elseif ${Me.Group[3].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[3].Name},TRUE]
			elseif ${Me.Group[4].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[4].Name},TRUE]
			elseif ${Me.Group[5].Cursed}==-1 && ${Me.Ability[id,101378472].IsReady}
				RI_Obj_CB:CastOn[Intercept III,${Me.Group[5].Name},TRUE]
			if ${Me.Maintained[Intercept III](exists)}
				Me.Maintained[Intercept III]:Cancel
		}
		else
		{
			if ${Me.Cursed}==-1
			{
				RI_CMD_PauseCombatBots 1
				while ${Me.Cursed}==-1
					wait 1
				RI_CMD_PauseCombatBots 0
			}
		}
		; if ${Trigger}
		; {
			; if !${RI_Var_Bool_GlobalOthers}
			; {
				; wait 40
				; if ${TriggerMessage.Find[${Me.Group[1].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[1].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[2].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[2].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[3].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[3].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[4].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[4].Name},TRUE]
				; elseif ${TriggerMessage.Find[${Me.Group[5].Name}](exists)}
					; RI_Obj_CB:CastOn[Intercept III,${Me.Group[5].Name},TRUE]
			; }
			; elseif ${TriggerMessage.Find[${Me.Name}](exists)}
			; {
				; RI_CMD_PauseCombatBots 1
				; eq2ex cancel_spellcast
				; eq2ex clearabilityqueue
				; wait 100
				; RI_CMD_PauseCombatBots 0
			; }
			; Trigger:Set[FALSE]
		; }
		wait 1
	}
	echo Ending Gagrash
}
function HowlingClickDoors()
{
	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot Fighters 45.214859 80.415894 188.262909
	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot Scouts 45.214859 80.415894 188.262909
	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot Mages 62.237350 80.415894 184.549194
	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot Priests 62.237350 80.415894 184.549194
	wait 100
	relay ${RI_Var_String_RelayGroup} -noredirect Actor["Hunter's Door"]:DoubleClick;relay ${RI_Var_String_RelayGroup} -noredirect Actor["Gatherer's Door"]:DoubleClick
	wait 2
	relay ${RI_Var_String_RelayGroup} -noredirect Actor["Hunter's Door"]:DoubleClick;relay ${RI_Var_String_RelayGroup} -noredirect Actor["Gatherer's Door"]:DoubleClick
	wait 50
}
function Bagarash()
{
	echo ISXRI: Starting Bagarash 
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert["takes on the Form of the"]
	RI_Atom_SetLockSpot ${Me.Name} 66.657990 87.863281 243.086624
	if !${RI_Var_Bool_GlobalOthers}
	{
		if ${Target.ID}!=${Actor[NamedNPC,Bagarash].ID}
			Actor[NamedNPC,Bagarash]:DoTarget
	}
	wait 200 ${Actor[NamedNPC,Bagarash].Distance}<15
	;RI_Atom_MoveBehind NONFIGHTER ${Actor[NamedNPC,Bagarash].ID} 30 99
	while ${Actor[NamedNPC,Bagarash](exists)} && !${Actor[NamedNPC,Bagarash].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["a stalking hunt master"](exists)}
				Actor["a stalking hunt master"]:DoTarget
			elseif ${Target.ID}!=${Actor[NamedNPC,Bagarash].ID}
				Actor[NamedNPC,Bagarash]:DoTarget
		}
		if ${Trigger}
		{
			;echo TRIGGER: TriggerMessage: ${TriggerMessage} / Gatherer: ${TriggerMessage.Find[Gatherer](exists)} / Hunter: ${TriggerMessage.Find[Hunter](exists)}
			if ${Me.Class.Equal[bard]}
			{
				wait 50
				if ${TriggerMessage.Find[Gatherer](exists)}
				{
					;echo gatherer
					RI_CMD_PauseCombatBots 1
					eq2ex cancel_spellcast
					eq2ex clearabilityqueue
					wait 5
					Actor["a dead Barkgut Gatherer"]:DoubleClick
					wait 1
					Actor["a dead Barkgut Gatherer"]:DoubleClick
					wait 1
					Actor["a dead Barkgut Gatherer"]:DoubleClick
					wait 50
					Me.Inventory["gatherer's trinket"]:Use
					wait 1
					Me.Inventory["gatherer's trinket"]:Use
					wait 1
					Me.Inventory["gatherer's trinket"]:Use
					wait 5
					RI_CMD_PauseCombatBots 0
				}
				if ${TriggerMessage.Find[Hunter](exists)}
				{
					;echo hunter
					RI_CMD_PauseCombatBots 1
					eq2ex cancel_spellcast
					eq2ex clearabilityqueue
					wait 5
					Actor["a dead Barkgut Hunter"]:DoubleClick
					wait 1
					Actor["a dead Barkgut Hunter"]:DoubleClick
					wait 1
					Actor["a dead Barkgut Hunter"]:DoubleClick
					wait 50
					Me.Inventory["hunter's trinket"]:Use
					wait 1
					Me.Inventory["hunter's trinket"]:Use
					wait 1
					Me.Inventory["hunter's trinket"]:Use
					wait 50
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Ancient Shroud",0]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Vital Intercession",0]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Ancestral Ward",0]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Penance",0]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Photosynthesis",0]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Regrowth",0]
					;wait 30
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:CastOn["Ancient Shroud",${Me.Name},TRUE]
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:CastOn["Vital Intercession",${Me.Name},TRUE]
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:CastOn["Ancestral Ward",${Me.Name},TRUE]
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:CastOn["Penance",${Me.Name},TRUE]
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:CastOn["Photosynthesis",${Me.Name},TRUE]
					relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:CastOn["Regrowth",${Me.Name},TRUE]
					wait 20
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Ancient Shroud",1]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Vital Intercession",1]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Ancestral Ward",1]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Penance",1]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Photosynthesis",1]
					;relay ${RI_Var_String_RelayGroup} -noredirect RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem["Regrowth",1]
					;find then goto the mob and hit it then come back.
					if ${Math.Distance[${Actor["a stalking hunt master"].Loc},69.416451,80.415901,197.044250]}<5
					{
						;echo west
						RI_Atom_SetLockSpot ${Me.Name}
						call _MoveC 93.750549 202.269318
						call _MoveC 92.018515 185.248505
						wait 5
						Actor["a stalking hunt master"]:DoTarget
						Actor["a stalking hunt master"]:DoFace
						if !${Me.RangedAutoAttackOn}
						{
							;echo turning on ranged
							eq2execute setautoattackmode 2
							eq2execute togglerangedattack
						}
						wait 10
						call _MoveC 93.750549 202.269318
						call _MoveC 66.657990 243.086624
					}
					elseif ${Math.Distance[${Actor["a stalking hunt master"].Loc},43.858452,80.415901,201.793488]}<5
					{
						;echo east
						RI_Atom_SetLockSpot ${Me.Name}
						call _MoveC 22.119884 220.012970
						call _MoveC 21.994549 198.313599
						wait 5
						Actor["a stalking hunt master"]:DoTarget
						Actor["a stalking hunt master"]:DoFace
						if !${Me.RangedAutoAttackOn}
						{
							;echo turning on ranged
							eq2execute setautoattackmode 2
							eq2execute togglerangedattack
						}
						wait 10
						call _MoveC 22.119884 220.012970
						call _MoveC 66.657990 243.086624
					}
					else
					{
						RI_Atom_SetLockSpot ${Me.Name} ${Actor["a stalking hunt master"].X} 0 ${Actor["a stalking hunt master"].Z} 30 100
						wait 5
						Actor["a stalking hunt master"]:DoTarget
						Actor["a stalking hunt master"]:DoFace
						if !${Me.AutoAttackOn}
						{
							;echo turning on melee
							eq2execute setautoattackmode 1
							eq2execute toggleautoattack
						}
						wait 10
						call _MoveC 66.657990 243.086624
					}
					RI_CMD_PauseCombatBots 0
				}
			}
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo Ending Bagarash
}
function Xacx-Kahda()
{
	AnnounceText:Clear
	AnnounceText:Insert["As if from your very mind, a spout of mental power begins to erupt!"]
	RI_Atom_SetLockSpot ALL -14.243855 54.840542 -133.589493
	echo ISXRI: Starting Xacx-Kahda 
	while ${Actor[NamedNPC,Xacx-Kahda](exists)} && !${Actor[NamedNPC,Xacx-Kahda].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[NamedNPC,Xacx-Kahda].ID}
				Actor[NamedNPC,Xacx-Kahda]:DoTarget
		}
		if ${Trigger}
		{
			wait 30
			if ${Math.Distance[${Me.Loc},-14.243855,54.840542,-133.589493]}<5
				call _MoveC 16.662451 -133.136246
			else
				call _MoveC -14.243855 -133.589493
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo Ending Xacx-Kahda
}
function Z'Koz()
{
	AnnounceText:Clear
	AnnounceText:Insert["Run! Get beyond 80 meters of your allies!"]
	RI_Atom_SetLockSpot ALL 326.238098 67.772087 -0.761757
	echo ISXRI: Starting Z'Koz 
	if ${Target.ID}!=${Actor[NamedNPC,Z'Koz].ID}
		Actor[NamedNPC,Z'Koz]:DoTarget
	while ${Actor[NamedNPC,Z'Koz](exists)} && !${Actor[NamedNPC,Z'Koz].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["Hound of Malice",radius,15](exists)}
			{
				if ${Target.ID}!=${Actor["Hound of Malice"].ID}
					Actor["Hound of Malice"]:DoTarget		
			}
			else
			{
				if ${Target.ID}!=${Actor[NamedNPC,Z'Koz].ID}
					Actor[NamedNPC,Z'Koz]:DoTarget
			}
		}
		if ${Trigger}
		{
			wait 30
			if ${Me.Cursed}!=0
			{
				RI_Atom_SetLockSpot ${Me.Name} 236.456039 0 -1.102375 1 100
				wait 300 ( ${Math.Distance[${Me.X},${Me.Z},236.456039,-1.102375]}<2 || ${Me.Cursed}==0 )
				wait 100 ${Me.Cursed}==0
				call _MoveC 326.238098 -0.761757
			}	
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo Ending Z'Koz
}
;;;;;;;;;;;;

;You have drawn the ire of the queen of dawn!
;You have drawn the ire of the queen of dusk! (NEED TO CHECK)
;The queens of dawn and dusk await you!
;;;;;;;;;;;;;

atom SFITAtom(string Text)
{
	if ${Text.Find["a bundle of treant branches"](exists)}
	{
		treecnt:Inc
		echo Looted a branch at ${treecnt}
	}
}
function StygianForest()
{
	;echo StygianForestFN
	RI_Atom_SetLockSpot ${Me.Name}
	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} 1 100
	AnnounceText:Clear
	AnnounceText:Insert["The queens of dawn and dusk await you!"]
	Event[EQ2_onIncomingText]:AttachAtom[SFITAtom]
	DeclareVariable treecnt int script 0

	while !${Trigger}
	{
		;echo ${Time}: StygianForestLOOP
		call _MoveSF 164.942093 28.733509 -253.051163
		;call _MoveSF 174.786926 30.167599 -254.699890
		;call _MoveSF 184.039291 31.379860 -258.383820
		call _MoveSF 193.351440 32.142834 -262.346130
		;call _MoveSF 202.779984 32.600147 -266.531403
		;call _MoveSF 211.947769 33.028885 -270.888367
		call _MoveSF 221.317764 33.642918 -274.726593
		;call _MoveSF 225.462616 35.058964 -265.651398
		;call _MoveSF 228.245209 36.376114 -256.058685
		call _MoveSF 230.961258 37.082279 -246.310669
		;call _MoveSF 233.471924 38.166523 -236.584991
		;call _MoveSF 235.986359 39.449902 -226.844696
		call _MoveSF 238.416992 41.097103 -217.054047
		;call _MoveSF 239.765732 42.425522 -207.100845
		;call _MoveSF 241.252106 44.127377 -197.046082
		call _MoveSF 250.278687 44.371017 -201.343216
		;call _MoveSF 257.906036 43.916672 -208.007797
		;call _MoveSF 265.549530 43.726280 -214.686523
		call _MoveSF 273.261627 43.132748 -221.425186
		;call _MoveSF 281.336243 42.810818 -227.598068
		;call _MoveSF 291.021423 43.233448 -230.429489
		call _MoveSF 301.103516 43.149364 -230.792282
		;call _MoveSF 311.147797 43.075035 -230.840759
		;call _MoveSF 321.389221 42.994251 -230.865479
		call _MoveSF 331.554840 43.225471 -230.920761
		;call _MoveSF 341.720581 43.485088 -230.940643
		;call _MoveSF 351.901337 43.732925 -230.960556
		call _MoveSF 361.990723 43.965694 -230.893951
		;call _MoveSF 371.988647 44.316833 -229.160431
		;call _MoveSF 381.127991 44.576302 -224.731506
		call _MoveSF 389.164093 45.027222 -218.461075
		;call _MoveSF 399.133331 45.088264 -219.832901
		;call _MoveSF 409.442108 45.211559 -219.584946
		call _MoveSF 419.402771 45.293278 -218.417160
		;call _MoveSF 429.464508 44.970055 -217.199646
		;call _MoveSF 439.766846 44.441383 -215.953033
		call _MoveSF 449.768494 44.211712 -214.742813
		;call _MoveSF 459.845245 43.824341 -213.523468
		;call _MoveSF 469.486145 43.837608 -216.195602
		call _MoveSF 472.473938 44.693855 -225.796463
		;call _MoveSF 471.900543 45.572330 -235.972641
		;call _MoveSF 471.041534 45.483429 -246.025589
		call _MoveSF 471.109497 45.634861 -256.154144
		;call _MoveSF 471.686096 46.362869 -266.257874
		;call _MoveSF 473.607635 47.375607 -276.032318
		call _MoveSF 476.171417 49.565174 -285.586975
		;call _MoveSF 475.721008 50.952450 -295.741608
		;call _MoveSF 467.277496 50.398205 -301.676971
		call _MoveSF 457.356598 49.215527 -303.629486
		;call _MoveSF 447.323669 47.605572 -303.150421
		;call _MoveSF 439.480438 46.079723 -296.785248
		call _MoveSF 434.413910 45.230663 -288.182281
		;call _MoveSF 428.922913 44.636837 -279.773743
		;call _MoveSF 423.150726 44.018333 -271.332916
		call _MoveSF 416.371796 43.896904 -263.981628
		;call _MoveSF 406.437378 43.886002 -262.282166
		;call _MoveSF 398.934509 44.345169 -269.087952
		call _MoveSF 393.200623 44.434746 -277.630707
		;call _MoveSF 388.131531 44.056900 -286.442383
		;call _MoveSF 383.047424 43.676617 -295.280334
		call _MoveSF 378.001038 42.981270 -304.052643
		;call _MoveSF 373.043488 41.957493 -312.683807
		;call _MoveSF 367.333496 41.655724 -321.173584
		call _MoveSF 358.995087 41.272217 -327.416504
		;call _MoveSF 348.939209 40.623058 -328.857208
		;call _MoveSF 339.248352 39.758919 -326.459320
		call _MoveSF 331.553436 38.807953 -319.772034
		;call _MoveSF 326.223572 38.694782 -311.189117
		;call _MoveSF 322.977905 38.927807 -301.592346
		call _MoveSF 320.450134 39.232658 -291.698883
		;call _MoveSF 318.147980 39.643803 -281.751251
		;call _MoveSF 317.001862 39.969177 -271.569366
		call _MoveSF 316.393982 40.661251 -261.588898
		;call _MoveSF 315.738312 41.448357 -251.444931
		;call _MoveSF 311.415741 40.760880 -260.575775
		call _MoveSF 307.470947 40.041977 -269.871063
		call _MoveSF 303.541016 39.327839 -279.131470
		;call _MoveSF 299.594452 37.972397 -288.334900
		;call _MoveSF 293.710632 37.242249 -296.419464
		call _MoveSF 284.813507 36.636822 -301.253845
		;call _MoveSF 274.561096 35.724350 -302.092651
		;call _MoveSF 264.517273 34.743843 -302.855621
		call _MoveSF 254.382843 34.109329 -304.045990
		;call _MoveSF 244.346558 33.306236 -305.561066
		;call _MoveSF 234.487717 32.856606 -307.229065
		call _MoveSF 227.386032 32.690083 -314.336914
		;call _MoveSF 227.207870 32.670143 -324.375671
		;call _MoveSF 227.537750 32.458374 -334.585541
		call _MoveSF 229.360687 32.280506 -344.421753
		;call _MoveSF 232.187592 32.300671 -354.085480
		;call _MoveSF 236.454102 32.770187 -363.221924
		call _MoveSF 242.471329 33.479561 -371.405853
		;call _MoveSF 249.991943 34.369083 -378.058533
		;call _MoveSF 256.105316 35.476261 -385.965912
		call _MoveSF 248.394653 34.806396 -392.395111
		;call _MoveSF 238.233063 33.969810 -392.449005
		;call _MoveSF 228.174362 33.005905 -390.732635
		call _MoveSF 218.473694 32.236961 -388.371490
		;call _MoveSF 208.822296 31.564415 -385.780273
		;call _MoveSF 199.292801 31.220263 -381.879395
		call _MoveSF 190.069519 31.030638 -377.713959
		;call _MoveSF 180.956635 31.174498 -373.598450
		;call _MoveSF 171.841599 31.508018 -369.487854
		call _MoveSF 162.125824 31.536377 -366.254211
		;call _MoveSF 152.432388 31.234886 -363.230072
		;call _MoveSF 142.143250 31.598885 -364.437653
		call _MoveSF 132.756302 32.813091 -368.048218
		;call _MoveSF 124.673042 34.664261 -373.980011
		;call _MoveSF 115.495506 36.283283 -378.259491
		call _MoveSF 107.922295 36.312225 -371.290222
		;call _MoveSF 106.350601 35.258675 -361.341583
		;call _MoveSF 106.675591 33.951397 -351.246094
		call _MoveSF 107.486084 32.226032 -341.204315
		;call _MoveSF 108.134811 30.460272 -331.303375
		;call _MoveSF 106.607635 29.163507 -321.205139
		call _MoveSF 101.479942 28.076540 -312.538269
		;call _MoveSF 93.344612 27.305920 -306.183960
		;call _MoveSF 84.621101 26.576220 -300.671173
		call _MoveSF 75.471497 26.040712 -296.320099
		;call _MoveSF 65.290985 26.298632 -295.874786
		;call _MoveSF 56.406281 27.663876 -300.415619
		call _MoveSF 46.282360 28.136585 -300.268341
		;call _MoveSF 41.990398 25.883179 -291.497192
		;call _MoveSF 42.688236 23.234257 -281.712280
		call _MoveSF 44.419079 20.813883 -271.955688
		;call _MoveSF 49.528709 18.652727 -263.632294
		;call _MoveSF 58.205929 18.071201 -258.376099
		call _MoveSF 67.807602 17.970163 -255.083588
		;call _MoveSF 77.901138 19.145428 -256.327698
		;call _MoveSF 87.873833 20.159639 -258.049347
		call _MoveSF 97.712143 21.150074 -259.747803
		;call _MoveSF 107.578102 22.318644 -261.464294
		;call _MoveSF 117.527504 23.582079 -262.034454
		call _MoveSF 127.465012 24.745640 -260.157837
		;call _MoveSF 136.304047 25.557760 -255.212692
		;call _MoveSF 144.562515 26.267101 -249.418335
		call _MoveSF 153.291168 27.180939 -243.949066
		wait 1
	}
	Trigger:Set[FALSE]
	call _MoveSF 155.827209 27.795170 -242.797562
	;call _MoveSF 150.888489 27.045366 -251.703369
	;call _MoveSF 146.262146 26.874533 -260.570984
	call _MoveSF 142.705811 27.042294 -270.091461
	;call _MoveSF 139.291672 27.396313 -279.730713
	;call _MoveSF 136.196350 27.881411 -289.333313
	call _MoveSF 133.889542 28.304192 -299.104858
	;call _MoveSF 132.759460 28.982281 -309.127625
	;call _MoveSF 132.165344 29.851683 -319.123016
	call _MoveSF 132.072128 30.010572 -329.333527
	;call _MoveSF 133.075287 30.636055 -339.427338
	;call _MoveSF 137.129074 30.990072 -348.698517
	call _MoveSF 144.783463 31.066422 -355.465149
	;call _MoveSF 152.824631 31.118851 -361.505707
	;call _MoveSF 161.450211 31.456791 -366.708313
	call _MoveSF 170.141724 31.417252 -371.803345
	
	DeleteVariable treecnt
}
function _MoveSF(float X1, float Y1, float Z1)
{
	variable float _X
	variable float _Z
	variable int _ID
	;echo ${Time}: MoveSFFN  ${X1} ${Y1} ${Z1}
	RI_Atom_SetLockSpot ${Me.Name}
	wait 1
	RI_Atom_ChangeLockSpot ALL ${X1} ${Y1} ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>2
	{
		;echo ${Time}: MoveSFLOOP ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}
		call RIMObj.checktoons
		call RIMObj.CheckPause
		if !${RI_Var_Bool_SkipLoot}
			call RIMObj.LootChest
		;check for a Shiny if set
		if ${RI_Var_Bool_GrabShinys} && !${RI_Var_Bool_GlobalOthers} && ${Actor[?,radius,${ShinyScanDistance}](exists)}
		{
			if ( !${Actor[NamedNPC,radius,50](exists)} || ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}>10 ) && ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Me.Y}]}<3
			{
				ShinyID:Set[${Actor[?,radius,${ShinyScanDistance}].ID}]
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Closest Shiny ID: ${ShinyID} @ ${Actor[${ShinyID}].X} ${Actor[${ShinyID}].Y} ${Actor[${ShinyID}].Z} Which is ${Actor[${ShinyID}].Distance} Away
				;press -release ${RI_Var_String_ForwardKey}
				call RIMObj.CheckShiny
			}
		}
		RI_Atom_SetLockSpot ${Me.Name} ${X1} ${Y1} ${Z1}
		;echo ${Time}: MoveSFLOOP After Checks
		;if treecnt is less than 5 and the actor exists, and there is no collision between us, move to and kill them
		_ID:Set[${Actor["a wanderer amongst the detritus"].ID}]
		if ${_ID}!=0 && ${treecnt}<5 && ${Actor[id,${_ID}].Distance}<80 && ${Actor[id,${_ID}](exists)} && !${Actor[id,${_ID}].IsDead} && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${Actor[id,${_ID}].X},${Math.Calc[${Actor[id,${_ID}].Y}+2]},${Actor[id,${_ID}].Z}]}
		{
			_X:Set[${Me.X}]
			_Z:Set[${Me.Z}]
			while ${Actor[id,${_ID}](exists)} && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${Actor[id,${_ID}].X},${Math.Calc[${Actor[id,${_ID}].Y}+2]},${Actor[id,${_ID}].Z}]}
			{
				;echo ${Time}: Tree LOOP
				if ${Math.Distance[${Me.Loc},${Actor[id,${_ID}].Loc}]}<8
				{
					if ${Actor[id,${_ID}](exists)} && !${Actor[id,${_ID}].IsDead} && ${Target.ID}!=${_ID} && !${RI_Var_Bool_GlobalOthers}
						Actor[id,${_ID}]:DoTarget
				}
				call _MoveC ${Actor[id,${_ID}].X} ${Actor[id,${_ID}].Z}
				wait 2
			}
			wait 20
			;echo ${Time}: MoveSFLOOP TREE Before CombatCheck
			call RIMObj.CheckCombat
			;echo ${Time}: MoveSFLOOP TREE After CombatCheck / Before LS/RIFL
			RI_Atom_SetLockSpot ${Me.Name}
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} 1 100
			;echo ${Time}: MoveSFLOOP TREE AFTER LS/RIFL / Before First MOVEC
			call _MoveC ${_X} ${_Z}
			;echo ${Time}: MoveSFLOOP TREE AFTER First MOVEC / Before Second MOVEC
			call _MoveC ${X1} ${Z1}
			;echo ${Time}: MoveSFLOOP TREE AFTER Second MOVEC
		}
		;if the sphere of actor exists, and there is no collision between us, move to and kill them
		_ID:Set[${Actor["sphere of"].ID}]
		if ${_ID}!=0 && ${Actor[id,${_ID}].Distance}<80 && ${Actor[id,${_ID}](exists)} && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${Actor[id,${_ID}].X},${Math.Calc[${Actor[id,${_ID}].Y}+2]},${Actor[id,${_ID}].Z}]}
		{
			_X:Set[${Me.X}]
			_Z:Set[${Me.Z}]
			while ${Actor[id,${_ID}](exists)} && !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${Actor[id,${_ID}].X},${Math.Calc[${Actor[id,${_ID}].Y}+2]},${Actor[id,${_ID}].Z}]}
			{
				;echo ${Time}: Sphere loop
				call _MoveC ${Actor[id,${_ID}].X} ${Actor[id,${_ID}].Z}
				wait 2
			}
			wait 50
			;echo ${Time}: MoveSFLOOP TREE Before CombatCheck
			call RIMObj.CheckCombat
			;echo ${Time}: MoveSFLOOP TREE After CombatCheck / Before LS/RIFL
			RI_Atom_SetLockSpot ${Me.Name}
			relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} 1 100
			;echo ${Time}: MoveSFLOOP TREE AFTER LS/RIFL / Before First MOVEC
			call _MoveC ${_X} ${_Z}
			;echo ${Time}: MoveSFLOOP TREE AFTER First MOVEC / Before Second MOVEC
			call _MoveC ${X1} ${Z1}
			;echo ${Time}: MoveSFLOOP TREE AFTER Second MOVEC
		}
		waitframe
	}
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; End OF TOT NAMED CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; START OF KA NAMED CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;; START Kaesora: Xalgozian Stronghold

function Vhankmin()
{
	echo ISXRI: Starting Vhankmin 
	
	if !${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ${Me.Name} -180.570053 49.220165 422.158478
	else
		RI_Atom_SetLockSpot ALL -179.618195 48.901855 427.573242
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		Actor[Vhankmin]:DoTarget
		wait 100 ${Actor[Vhankmin].Distance}<8
		RI_Atom_SetLockSpot ${Me.Name} -185.950378 48.913849 427.578949
	}
	
	while ${Actor[Vhankmin](exists)} && !${Actor[Vhankmin].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[crocodile,radius,50](exists)}
			{
				if ${Target.ID}!=${Actor[crocodile,radius,50].ID}
					Actor[crocodile,radius,50]:DoTarget		
			}
			elseif ${Actor[fallen,radius,20](exists)}
			{
				if ${Target.ID}!=${Actor[fallen,radius,20].ID}
					Actor[fallen,radius,20]:DoTarget		
			}
			elseif ${Actor[spectral,radius,20](exists)}
			{
				if ${Target.ID}!=${Actor[spectral,radius,20].ID}
					Actor[spectral,radius,20]:DoTarget		
			}
			else
			{
				if ${Target.ID}!=${Actor[NamedNPC,Vhankmin].ID}
					Actor[Vhankmin]:DoTarget
			}
		}
		wait 1
	}
	echo Ending Vhankmin
}

function Eghonz()
{
	AnnounceText:Clear
	AnnounceText:Insert[bulwark]
	echo ISXRI: Starting Eghonz 
	
	RI_Atom_SetLockSpot ALL -350.053131 -17.721470 510.971222
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		Actor[Eghonz]:DoTarget
		wait 100 ${Actor[Eghonz].Distance}<8
		RI_Atom_SetLockSpot ${Me.Name} -343.833862 -17.118542 518.056519
	}
	
	while ${Actor[Eghonz](exists)} && !${Actor[Eghonz].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Eghonz].ID}
				Actor[Eghonz]:DoTarget
		}
		if ${Trigger}
		{
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 1
			;target self
			Actor[${Me.ID}]:DoTarget
			;back pet off
			eq2ex pet backoff
			eq2ex pet backoff
			
			Trigger:Set[FALSE]
			
			while !${Trigger}
				wait 1
				
			;turn on assisting
			RI_CMD_Assisting 1
			
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo Ending Eghonz
}

function Janosz()
{
	AnnounceText:Clear
	AnnounceText:Insert[bulwark]
	echo ISXRI: Starting Janosz 
	
	RI_Atom_SetLockSpot ALL -554.776917 -2.819610 258.928375
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		Actor[Janosz]:DoTarget
		wait 100 ${Actor[Janosz].Distance}<10
		RI_Atom_SetLockSpot ${Me.Name} -561.612244 -2.201538 265.963348
	}
	
	while ${Actor[Janosz](exists)} && !${Actor[Janosz].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor["General's Reaver",radius,50](exists)}
			{
				if ${Target.ID}!=${Actor["General's Reaver",radius,50].ID}
					Actor["General's Reaver",radius,50]:DoTarget		
			}
			else
			{
				if ${Target.ID}!=${Actor[Janosz].ID}
					Actor[Janosz]:DoTarget
			}
		}
		if ${Trigger}
		{
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 1
			;target self
			Actor[${Me.ID}]:DoTarget
			;back pet off
			eq2ex pet backoff
			eq2ex pet backoff
			
			Trigger:Set[FALSE]
			
			while !${Trigger}
				wait 1
				
			;turn on assisting
			RI_CMD_Assisting 1
			
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo Ending Janosz
}
function Vihgoh()
{
	declare VihgohID int ${Actor[Query, Name=="Over-General Vihgoh"].ID}
	echo ISXRI: Starting Vihgoh 
	;turn on Singular Focus 4026518400  or if guardian Focused Offensive 1432018334
	if ${Me.SubClass.Equal[guardian]} && ${Me.Ability[id,1432018334].IsReady}
	{
		while !${Me.Maintained[Focused Offensive](exists)}
		{
			while ${Me.Ability[id,1432018334].IsReady}
			{
				Me.Ability[id,1432018334]:Use
				wait 5 ${Me.Maintained[Focused Offensive](exists)}
			}
			wait 5 ${Me.Maintained[Focused Offensive](exists)}
		}
	}
	elseif ${Me.Ability[id,4026518400].IsReady}
	{
		
		while !${Me.Maintained[Singular Focus](exists)}
		{
			while ${Me.Ability[id,4026518400].IsReady}
			{
				Me.Ability[id,4026518400]:Use
				wait 5 ${Me.Maintained[Singular Focus](exists)}
			}
			wait 5 ${Me.Maintained[Singular Focus](exists)}
		}
	}

	wait 10
	
	;turn off ae's in CB
	;if ${Me.Archetype.NotEqual[fighter]}
	;{
		RI_Obj_CB:DoNotCastEncounter[TRUE]
		RI_Obj_CB:DoNotCastAE[TRUE]
	;}
	Actor[${VihgohID}]:DoTarget
	
	;move to position
	RI_Atom_SetLockSpot ALL -540.560303 11.131656 -39.861198 
	wait 50
	;if ${Me.Archetype.NotEqual[fighter]}
	;	relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${VihgohID} 30 99 ${Me.Name}
	
	while ${Actor[Query, ID=${VihgohID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${VihgohID}
				Actor[${VihgohID}]:DoTarget
		}
		wait 2
	}
	
	;turn on ae's in CB
	RI_Obj_CB:DoNotCastEncounter[FALSE]
	RI_Obj_CB:DoNotCastAE[FALSE]
	
	if ${Me.SubClass.Equal[guardian]}
		Me.Maintained[Focused Offensive]:Cancel
	else
		Me.Maintained[Singular Focus]:Cancel
		
	wait 10
	echo Ending Vihgoh
}
function XalgozianWrit()
{
	if ${RIObj.QuestExists["Kunark Ascending: Reading Assignment"]}
	{
		RI_Atom_SetLockSpot ALL ${Actor[Writ].X} ${Actor[Writ].Y} ${Actor[Writ].Z} 5 100
		while ${Actor[Query, Name =="Writ of War" && IsDead = FALSE](exists)}
		{
			if ${Target.ID}!=${Actor[Query, Name =="Writ of War"].ID}
				Actor[Query, Name =="Writ of War"]:DoTarget
			wait 1
		}
	}
}
;;;;;;;; END Kaesora: Xalgozian Stronghold


function Queshaun()
{
	AnnounceText:Clear
	AnnounceText:Insert[en]
	echo ISXRI: Starting Queshaun 
	
	RI_Atom_SetLockSpot ALL -549.282593 9.066755 -81.277527
	
	Actor[Query, Name=-"Queshaun" && Type=="NamedNPC" && IsDead=FALSE]:DoTarget
	
	while ${Actor[Query, Name=-"Queshaun" && Type=="NamedNPC" && IsDead=FALSE].Distance}>9
		wait 2
	
	if !${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ${Me.Name} -559.911865 9.464098 -79.087914
	;else
	;	RI_Atom_SetLockSpot ALL -549.282593 9.066755 -81.277527
	
	while ${Actor[Query, Name=-"Queshaun" && Type=="NamedNPC" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Query, Name=-"Queshaun" && Type=="NamedNPC" && IsDead=FALSE].ID}
				Actor[Query, Name=-"Queshaun" && Type=="NamedNPC" && IsDead=FALSE]:DoTarget
		}
		if ${Trigger} && ${TriggerMessage.Find[plagues](exists)}
		{
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 1
			;target self
			Actor[${Me.ID}]:DoTarget
			;back pet off
			eq2ex pet backoff
			eq2ex pet backoff
			
			Trigger:Set[FALSE]
			
			while !${Trigger}
				wait 1
				
			;turn on assisting
			RI_CMD_Assisting 1
			
			Trigger:Set[FALSE]
			
		}
		wait 1
	}
	echo Ending Qeushaun
}

function Caelan'Gael()
{
	echo ISXRI: Starting Caelan'Gael 
	
	;press shift+r
	if !${Me.IsCrouching}
		press ${RI_Var_String_CrouchKey}
		
	if !${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ${Me.Name} -602.302917 -8.299364 13.011220
	else
		RI_Atom_SetLockSpot ALL -606.482300 -8.309934 12.990896
	
	while ${Actor[Query, Name=-"Caelan'Gael" && Type=="NamedNPC" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, Name=="vile prison" && Distance<=50 && IsDead=FALSE && ( Type=="NPC" || Type=="NamedNPC" )](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=="vile prison" && Distance<=50 && IsDead=FALSE && ( Type=="NPC" || Type=="NamedNPC" )].ID}
					Actor[Query, Name=="vile prison" && Distance<=50 && IsDead=FALSE && ( Type=="NPC" || Type=="NamedNPC" )]:DoTarget		
			}
			elseif ${Actor[Query, Name=="Elite Protector" && Distance<=20 && IsDead=FALSE && ( Type=="NPC" || Type=="NamedNPC" )](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=="Elite Protector" && Distance<=20 && IsDead=FALSE && ( Type=="NPC" || Type=="NamedNPC" )].ID}
					Actor[Query, Name=="Elite Protector" && Distance<=20 && IsDead=FALSE && ( Type=="NPC" || Type=="NamedNPC" )]:DoTarget		
			}
			else
			{
				if ${Target.ID}!=${Actor[Query, Name=-"Caelan'Gael" && Type=="NamedNPC" && IsDead=FALSE].ID}
					Actor[Query, Name=-"Caelan'Gael" && Type=="NamedNPC" && IsDead=FALSE]:DoTarget
			}
		}
		wait 1
	}
	
	;press shift+r
	if ${Me.IsCrouching}
		press ${RI_Var_String_CrouchKey}
	press ${RI_Var_String_JumpKey}
	echo Ending Caelan'Gael
}
function Lachina()
{
	AnnounceText:Clear
	AnnounceText:Insert["Lachina envelopes herself in a 1,000 plagues!"]
	AnnounceText:Insert["Endemic Redoubt fades!"]
	echo ISXRI: Starting Lachina 
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} -346.727081 -8.355633 14.342555
		Actor[NamedNPC,Lachina]:DoTarget
		wait 50
		RI_Atom_SetLockSpot ${Me.Name} -347.559875 -8.278683 11.910580
	}
	else
	{
		RI_Atom_SetLockSpot ALL -352.526703 -8.355646 17.103048
		;turn off assisting
		RI_CMD_Assisting 0
		
		wait 1
		;target self
		Actor[${Me.ID}]:DoTarget
		
		wait 50
		;turn on assisting
		RI_CMD_Assisting 1
		
		RI_Atom_SetLockSpot ALL -344.327759 -8.355633 17.309353
	}
	while ${Actor[Query, Name=-"Lachina" && Type =="NamedNPC" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, Name=-"Protector" && Distance <=20 && IsDead=FALSE && Type!="Pet"](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"Protector" && Distance <=20 && IsDead=FALSE && Type!="Pet"].ID}
					RIObj:BalanceMobs["Protector"]	
			}
			else
			{
				if ${Target.ID}!=${Actor[Query, Name=-"Lachina" && IsDead=FALSE && Type =="NamedNPC"].ID}
					Actor[Query, Name=-"Lachina" && IsDead=FALSE && Type =="NamedNPC"]:DoTarget
			}
		}
		if ${Trigger} && ${TriggerMessage.Find[plagues](exists)}
		{
			;turn off assisting
			RI_CMD_Assisting 0
			
			wait 1
			;target self
			Actor[${Me.ID}]:DoTarget
			;back pet off
			eq2ex pet backoff
			eq2ex pet backoff
			
			Trigger:Set[FALSE]

			while !${Trigger}
				wait 1
				
			eq2ex target_none
			
			;turn on assisting
			RI_CMD_Assisting 1
			
			Trigger:Set[FALSE]
		}
		wait 1
	}
	while ${Actor[Query, Name=="an ancient familiar" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Query, Name=="an ancient familiar" && IsDead=FALSE].ID}
				Actor[Query, Name=="an ancient familiar" && IsDead=FALSE]:DoTarget
		}
		wait 1
	}
	echo Ending Lachina
}
function Tabor'zaai()
{
	call Tabor'Zaai
}
function Tabor'Zaai()
{
	AnnounceText:Clear
	AnnounceText:Insert[glyphs]
	echo ISXRI: Starting Tabor'Zaai 
	
	;turn off assisting
	RI_CMD_Assisting 0
	
	if !${RI_Var_Bool_GlobalOthers}
	{
		RI_Atom_SetLockSpot ${Me.Name} -14.001640 8.738635 -166.310944
	}
	else
	{
		RI_Atom_SetLockSpot ALL -13.980902 8.654903 -162.166992
	}
	while ${Actor[Tabor'Zaai](exists)} && !${Actor[Tabor'Zaai].IsDead}
	{
		;if !${RI_Var_Bool_GlobalOthers}
		;{
			if ${Target.ID}!=${Actor[NamedNPC,Tabor'Zaai].ID}
				Actor[NamedNPC,Tabor'Zaai]:DoTarget
		;}
		if ${Trigger}
		{
			;target remnant
			Actor[remnant]:DoTarget
						
			Trigger:Set[FALSE]
			while !${Trigger}
				wait 1
			
			Trigger:Set[FALSE]
		}
		wait 1
	}
					
	;turn on assisting
	RI_CMD_Assisting 1
	
	echo Ending Tabor'Zaai
}
;;;;;;;; Start Arcanna'se Spire: Vessel of the Sorceress

function VesselSentry()
{
	while !${Actor[Query, Name=="an Arcanna'se sentry" && IsAggro=TRUE && Distance < 100](exists)}
		waitframe
		
	relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z}
	
	while ${Actor[Query, Name=="an Arcanna'se sentry" && Distance < 100](exists)} && !${Actor[Query, Name=="The Crystallized Construct" && IsAggro=TRUE && Distance < 100](exists)}
	{
		if ${Actor[Query, Name=="an Arcanna'se sentry" && IsAggro=TRUE && IsDead=FALSE && Distance < 100](exists)}
		{
			if ${Target.ID}!=${Actor[Query, Name=="an Arcanna'se sentry" && IsAggro=TRUE && IsDead=FALSE && Distance < 100].ID}
				Actor[Query, Name=="an Arcanna'se sentry" && IsAggro=TRUE && IsDead=FALSE && Distance < 100]:DoTarget
		}
		wait 2
	}
	;relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot OFF
}

function VesselSulite()
{
	while !${Actor[Query, Name=="an animated Sulite" && IsAggro=TRUE && Distance < 100](exists)}
		waitframe
		
	relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z}
	
	while ${Actor[Query, Name=="an animated Sulite" && IsAggro=TRUE && IsDead=FALSE && Distance < 100](exists)}
	{
		if ${Target.ID}!=${Actor[Query, Name=="an animated Sulite" && IsAggro=TRUE && IsDead=FALSE && Distance < 100].ID}
			Actor[Query, Name=="an animated Sulite" && IsAggro=TRUE && IsDead=FALSE && Distance < 100]:DoTarget
		wait 2
	}
	
	relay "${RI_Var_String_RelayGroup}" RI_Atom_SetLockSpot OFF
}
function Armor()
{
	echo ISXRI: Starting Armor 
	
	RI_Atom_SetLockSpot ALL -470.887695 35.104889 5.288488 1 100
	wait 50
	RI_Atom_SetLockSpot ALL -470.898621 35.104885 7.664916 1 100
	
	variable int _ArmorID
	_ArmorID:Set[${Actor["The Armor of Sul"].ID}]
	; while ${Actor[Query, ID=${_ArmorID} && IsDead=FALSE](exists)} && !${RIObj.MainIconIDExists[${_ArmorID},25]}
	; {
		; if !${RI_Var_Bool_GlobalOthers}
		; {
			; if ${Target.ID}!=${_ArmorID}
				; Actor[Query, ID=${_ArmorID}]:DoTarget
		; }
		; wait 2
	; }
	
	; while ${Actor[Query, ID=${_ArmorID} && IsDead=FALSE](exists)} && ${RIObj.MainIconIDExists[${_ArmorID},25]}
	; {
		; if !${RI_Var_Bool_GlobalOthers}
		; {
			; if ${Target.ID}!=${_ArmorID}
				; Actor[Query, ID=${_ArmorID}]:DoTarget
		; }
		; wait 2
	; }
	;RI_Atom_SetLockSpot ALL -470.684479 35.104889 18.014343 1 100
	while ${Actor[Query, ID=${_ArmorID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${_ArmorID}
				Actor[Query, ID=${_ArmorID}]:DoTarget
		}
		wait 2
	}
}
function Sorceress()
{
	echo ISXRI: Starting Sorceress 
	
	RIMUIObj:SetLockSpot[ALL,-458.240021,30.551283,-34.363510]
	variable int _MoveTime=0
	variable int _SorceressID
	_SorceressID:Set[${Actor["Sorceress Gwen'vae"].ID}]
	
	while ${Actor[Query, ID=${_SorceressID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[id,${_SorceressID},radius,30](exists)}
			{
				if ${Target.ID}!=${_SorceressID}
					Actor[id,${_SorceressID}]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor[vestigial,radius,30].ID}
					Actor[vestigial,radius,30]:DoTarget
			}
			if ${Actor[Query, Name=="Gwen'vae's whirlwind" && Distance <5](exists)} && ${Script.RunningTime}>${Math.Calc[${_MoveTime}+5000]}
			{
				_MoveTime:Set[${Script.RunningTime}]
				if ${Math.Distance[${Me.Loc},-458.240021,30.551283,-34.363510]}<5
				{
					relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,-483.319397,30.502533,-76.777069]
					wait 50 ${Math.Distance[${Me.Loc},-483.319397,30.502533,-76.777069]}<5
				}
				elseif ${Math.Distance[${Me.Loc},-483.319397,30.502533,-76.777069]}<5
				{
					relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,-484.295990,30.551153,-34.123516]
					relay ${RI_Var_String RelayGroup} wait 50 ${Math.Distance[${Me.Loc},-484.295990,30.551153,-34.123516]}<5
				}
				elseif ${Math.Distance[${Me.Loc},-484.295990,30.551153,-34.123516]}<5
				{
					relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,-458.502533,30.492809,-77.323051]
					relay ${RI_Var_String RelayGroup} wait 50 ${Math.Distance[${Me.Loc},-458.502533,30.492809,-77.323051]}<5
				}
				elseif ${Math.Distance[${Me.Loc},-458.502533,30.492809,-77.323051]}<5
				{
					relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,-458.240021,30.551283,-34.363510]
					relay ${RI_Var_String RelayGroup} wait 50 ${Math.Distance[${Me.Loc},-458.240021,30.551283,-34.363510]}<5
				}
			}
		}
		;need to add in code for mages to dispell with absorb magic, need to get named and id's of det
		;if we are a mage watch for spell's MainIconID and cast absorb magic
		if ${Me.Archetype.Equal[mage]}
		{
			echo ${RIMUIObj.MainIconIDExists[${_SorceressID},22]} && ${Me.Ability[id,1812025739].IsReady}
			;if we see "Astral Dominion" (MainIconID=22) on "Sorceress Gwen'vae", pause bot, stop casting and cast Absorb Magic
			if ${RIMUIObj.MainIconIDExists[${_SorceressID},22]} && ${Me.Ability[id,1812025739].IsReady}
			{
				;echo ${Time}: Astral Dominion Found
				
				;turn off assisting
				RI_CMD_Assisting 0
				
				;pause bots
				RI_CMD_PauseCombatBots 1
				
				;target "Sorceress Gwen'vae"
				Actor[Query, ID=${_SorceressID}]:DoTarget
				
				;cancel spellcast and clear ability queue
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;keep attempting to cast absorb magic (ID=1812025739) until it is no longer ready (aka casted)
				do
				{
					if ${Target.ID}==${_SorceressID}
						Me.Ability[id,1812025739]:Use
					else
						Actor[Query, ID=${_SorceressID}]:DoTarget
					wait 1
				}
				while ${Me.Ability[id,1812025739].IsReady}
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;turn on assisting
				RI_CMD_Assisting 1
				
				;unpause bots
				RI_CMD_PauseCombatBots 0
			}
		}
		wait 1
	}
	echo Ending Sorceress
}
function 148685214SorceressOLD()
{
	echo ISXRI: Starting Sorceress 
	
	RI_Atom_SetLockSpot ALL -425.161926 30.653168 -56.651722
	
	variable int _SorceressID
	_SorceressID:Set[${Actor["Sorceress Gwen'vae"].ID}]
	
	while ${Actor[Query, ID=${_SorceressID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[id,${_SorceressID},radius,30](exists)}
			{
				if ${Target.ID}!=${_SorceressID}
					Actor[id,${_SorceressID}]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor[vestigial,radius,30].ID}
					Actor[vestigial,radius,30]:DoTarget
			}
		}
		;need to add in code for mages to dispell with absorb magic, need to get named and id's of det
		;if we are a mage watch for spell's MainIconID and cast absorb magic
		if ${Me.Archetype.Equal[mage]}
		{
		
			;if we see "Astral Dominion" (MainIconID=22) on "Sorceress Gwen'vae", pause bot, stop casting and cast Absorb Magic
			if ${RIObj.MainIconIDExists[${_SorceressID},22]} && ${Me.Ability[id,1812025739].IsReady}
			{
				;echo ${Time}: Astral Dominion Found
				
				;turn off assisting
				RI_CMD_Assisting 0
				
				;pause bots
				RI_CMD_PauseCombatBots 1
				
				;target "Sorceress Gwen'vae"
				Actor[Query, ID="${_SorceressID}"]:DoTarget
				
				;cancel spellcast and clear ability queue
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;keep attempting to cast absorb magic (ID=1812025739) until it is no longer ready (aka casted)
				do
				{
					if ${Target.ID}==${_SorceressID}
						Me.Ability[id,1812025739]:Use
					else
						Actor[Query, ID="${_SorceressID}"]:DoTarget
					wait 1
				}
				while ${Me.Ability[id,1812025739].IsReady}
				
				;wait until we are not casting
				wait 200 !${Me.CastingSpell}
				
				;turn on assisting
				RI_CMD_Assisting 1
				
				;unpause bots
				RI_CMD_PauseCombatBots 0
			}
		}
		wait 1
	}
	echo Ending Sorceress
}

;;;;;;;; END Arcanna'se Spire: Vessel of the Sorceress
function Xerxes'kade()
{
	call Xerxes'Kade
}
function Xerxes'Kade()
{
	echo ISXRI: Starting Xerxes'Kade 
	if !${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ALL -5.626295 5.593339 -101.020767
	else
		RI_Atom_SetLockSpot ALL -0.011539 5.593339 -92.666107
	while ${Actor[Xerxes'Kade](exists)} && !${Actor[Xerxes'Kade].IsDead}
	{
		if ${Actor[Protector,radius,30](exists)}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.ID}!=${Actor[Protector,radius,30].ID}
					Actor[Protector,radius,30]:DoTarget
			}
			relay all "RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Item:Bottled Endless Courage,TRUE]"
		}
		else
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Target.ID}!=${Actor[NamedNPC,Xerxes'Kade].ID}
					Actor[NamedNPC,Xerxes'Kade]:DoTarget
			}
			relay all "RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Item:Bottled Endless Courage,FALSE]"
		}
		wait 1
	}
	relay all "RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Item:Bottled Endless Courage,TRUE]"
	echo Ending Xerxes'Kade
}

function RevealedFindArcaneSpell()
{
	if ${Math.Distance[${Actor[Unseal].Loc},123.540756,1.947796,0.800853]}<40
	{
		;WEST
		call RIMObj.Move 77.482826 1.717356 -26.178192 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 86.197166 1.638179 -21.221401 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 94.981010 1.638179 -16.297430 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 103.808449 1.638178 -11.353998 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 112.489334 1.638181 -6.124079 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 121.018738 1.947796 -0.839703 2 0 TRUE FALSE FALSE TRUE
		;find and move to Actor[Unseal].Loc
		if ${Actor[Unseal](exists)}
		{
			call RIMObj.Move ${Actor[Unseal].X} ${Actor[Unseal].Y} ${Actor[Unseal].Z} 2 0 TRUE FALSE FALSE FALSE
			wait 5
			Actor[Unseal]:DoubleClick
			wait 50
		}
		call RIMObj.Move 123.484497 1.947796 0.663286 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 132.204590 1.947796 5.729712 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 140.788422 2.527645 10.918268 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 144.479919 2.928718 13.130285 2 0 TRUE FALSE FALSE FALSE
		wait 5
		;click Actor[podium] twice
		Actor[podium]:DoubleClick
		wait 50
		Actor[podium]:DoubleClick
		wait 50
		call RIMObj.Move 135.732285 1.638182 8.366315 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 127.119965 1.947796 3.278051 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 118.382446 1.947796 -1.884159 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 109.707520 1.638178 -7.009406 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 101.005760 1.638178 -12.150508 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 92.348701 1.638179 -17.265188 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 83.715500 1.638180 -22.379244 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 75.027573 1.646889 -27.473829 2 0 TRUE FALSE FALSE TRUE
	}
	else
	{
		;NORTH
		call RIMObj.Move 76.252930 3.402782 -30.794004 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 76.952385 3.561481 -31.880140 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 82.134666 3.522867 -40.513153 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 87.309296 3.522867 -49.133415 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 92.130203 3.522867 -57.928806 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 102.062469 3.522870 -59.966686 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 112.082451 2.324602 -59.150764 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 122.194351 2.324602 -58.433834 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 131.987000 2.324602 -60.561306 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 139.905151 3.555652 -66.618797 2 0 TRUE FALSE FALSE TRUE
		;find and move to Actor[Unseal].Loc
		if ${Actor[Unseal](exists)}
		{
			call RIMObj.Move ${Actor[Unseal].X} ${Actor[Unseal].Y} ${Actor[Unseal].Z} 2 0 TRUE FALSE FALSE FALSE
			wait 5
			Actor[Unseal]:DoubleClick
			wait 50
		}
		call RIMObj.Move 145.551605 3.760696 -70.976471 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 138.719864 3.041158 -63.690674 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 130.200073 2.324602 -58.402435 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 120.062363 2.324602 -57.908882 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 109.989723 2.324602 -58.741211 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 99.948135 3.522869 -59.570980 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 89.830872 3.522867 -60.030056 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 84.258102 3.522867 -51.635406 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 80.737923 3.522867 -42.155495 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 77.850090 3.552786 -32.529354 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 74.546089 1.638181 -23.495798 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 83.778847 1.638180 -19.301407 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 93.072083 1.638179 -15.098880 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 102.048218 1.638178 -10.615721 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 111.027519 1.638179 -6.005989 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 119.848701 1.947796 -1.180086 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 128.572372 1.947796 3.736161 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 137.374527 1.638182 8.639326 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 145.907043 2.928718 13.471667 2 0 TRUE FALSE FALSE FALSE
		wait 5
		;click Actor[podium] twice
		Actor[podium]:DoubleClick
		wait 50
		Actor[podium]:DoubleClick
		wait 50
		call RIMObj.Move 137.198853 1.638182 8.718538 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 128.396057 1.947796 3.904975 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 119.498909 1.947796 -0.911943 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 110.648750 1.638181 -5.832401 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 101.900375 1.638178 -10.975382 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 93.349808 1.638179 -16.245651 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 84.707489 1.638179 -21.523640 2 0 TRUE FALSE FALSE TRUE
		call RIMObj.Move 76.085960 1.638180 -26.796047 2 0 TRUE FALSE FALSE TRUE
	}
}
function RevealedFindOrb()
{
	if ${Actor[crystal](exists)}
	{
		variable string LeftRight=NO
		if ${Math.Distance[${Actor[crystal].Loc},-63.366535,4.268709,46.043556]}<5
		{
			if ${Math.Distance[${Actor[crystal].Loc},-67.985870,4.102995,42.497650]}>6
			{
				LeftRight:Set[Right]
				call _Move3 -52.537910 4.324533 30.953112 FALSE FALSE
			}
			else
			{
				LeftRight:Set[Left]
				call _Move3 -63.451752 4.383376 33.048817 FALSE FALSE
			}
		}
		call _Move3 ${Actor[crystal].X} ${Actor[crystal].Y} ${Actor[crystal].Z} FALSE FALSE
		wait 5
		Actor[crystal]:DoubleClick
		wait 50
		if ${LeftRight.Equal[Right]}
		{
			call _Move3 -52.537910 4.324533 30.953112 FALSE FALSE
		}
		elseif ${LeftRight.Equal[Left]}
		{
			call _Move3 -63.451752 4.383376 33.048817 FALSE FALSE
		}
	}
}
function RevealedQueenInteract()
{
	Actor["Queen Alwenielle"]:DoTarget
	wait 5
	eq2ex Hail
	wait 5
	EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	wait 5
	EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	wait 5
	EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	wait 5
	RewardWindow:Receive
	wait 5
	RewardWindow:Receive
}
function Gooblin()
{
	echo ISXRI: Starting Gooblin 
	
	variable int _GooblinID
	_GooblinID:Set[${Actor[Query, Name="The Gooblin King", Type="NamedNPC"].ID}]
	variable int _Counter
	_Counter:Set[1]
	variable int _PullTime
	_PullTime:Set[${Time.SecondsSinceMidnight}]
	variable bool _Moved
	_Moved:Set[FALSE]
	variable int _MyNum

	declare GroupArray[${Me.Group}] string
	declare Group string
	variable int count=0
	for(count:Set[1];${count}<=${Me.Group};count:Inc)
		GroupArray[${count}]:Set[${Me.Group[${Math.Calc[${count}-1]}]}]
	variable int count2=0
	declare temp string
	for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
	{
		for(count2:Set[1];${count2}<=${GroupArray.Size};count2:Inc)
		{
			if ${GroupArray[${count2}].Compare[${GroupArray[${count}]}]}>0
			{
				temp:Set[${GroupArray[${count}]}]
				GroupArray[${count}]:Set[${GroupArray[${count2}]}]
				GroupArray[${count2}]:Set[${temp}]
			}
		}
    }
	for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
	{
		if ${Me.Name.Equal[${GroupArray[${count}]}]}
			_MyNum:Set[${count}]
	}
	
	RI_Atom_SetLockSpot ALL 514.938843 -59.220978 79.529190
	
	while ${Actor[Query, ID="${_GooblinID}"](exists)} && !${Actor[Query, ID="${_GooblinID}"].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${_GooblinID}
				Actor[Query, ID="${_GooblinID}"]:DoTarget
						
			;echo ( ${Math.Distance[${_PullTime}-30]}>${Time.SecondsSinceMidnight} || ${Actor[Query, ID="${_GooblinID}"].Distance}<10 ) && !${_Moved}
			if  !${_Moved}
			{
				if ( ${Math.Distance[${_PullTime}-30]}>${Time.SecondsSinceMidnight} || ${Actor[Query, ID="${_GooblinID}"].Distance}<10 )
				{
					RI_Atom_SetLockSpot ALL 527.659973 -59.227776 74.717911
					_Moved:Set[TRUE]
				}
			}
		}
		if ${RIObj.MainIconIDExists[${_GooblinID},897]}
		{
			if  ${_Counter}==${_MyNum}
			{
			;turn off assisting
			RI_CMD_Assisting 0
			
			;pause bots
			RI_CMD_PauseCombatBots 1
			
			;target
			Actor[Query, ID="${_GooblinID}"]:DoTarget
			
			;cancel spellcast and clear ability queue
			eq2ex cancel_spellcast
			eq2ex clearabilityqueue 
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;keep attempting to cast/use until no longer ready (aka casted/used)
			do
			{
				if ${Target.ID}==${_GooblinID}
					Me.Inventory[Query, Name="Soothsayer's Bomb Dispenser"]:Use
				else
					Actor[Query, ID="${_GooblinID}"]:DoTarget
				wait 3
			}
			while ${Me.Inventory[Query, Name="Soothsayer's Bomb Dispenser"].IsReady}
			
			;wait until we are not casting
			wait 200 !${Me.CastingSpell}
			
			;turn on assisting
			RI_CMD_Assisting 1
			
			;unpause bots
			RI_CMD_PauseCombatBots 0
			
			if ${_Counter}==6
				_Counter:Set[1]
			else
			_Counter:Inc
			
			wait 10
			}
			else
			{
				if ${_Counter}==6
					_Counter:Set[1]
				else
				_Counter:Inc
				wait 300 !${RIObj.MainIconIDExists[${_GooblinID},897]}
			}
		}

		wait 1
	}
	echo Ending Gooblin
}
function UseItem(string _ItemName, int _Repeats=2)
{
	;pause bots
	relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
	relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
	wait 2
	relay "${RI_Var_String_RelayGroup}" Me.Inventory["${_ItemName}"]:Use
	wait 5
	if ${_Repeats}>1
		relay "${RI_Var_String_RelayGroup}" Me.Inventory["${_ItemName}"]:Use
	wait 20
	;unpause bots
	relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
}

;;;;;;;;;;;;;;;; Start Crypt of Dalnir: Ritual Chamber [Heroic] ;;;;;;;;;;;;;;;;;;;;;;
function Rector()
{
	echo Starting Rector v1
	variable int _RectorID=${Actor[Query, Name=-"Rector Droz'Kzar" && IsDead=FALSE].ID}
	RI_Atom_SetLockSpot ALL -37.306847 -38.695023 -342.903687
	
	if !${RI_Var_Bool_GlobalOthers}
		Actor[Query, ID=${_RectorID} && IsDead=FALSE]:DoTarget

	while ${Actor[Query, ID=${_RectorID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, Name=-"a Kly believer" && Distance<=40 && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"a Kly believer" && Distance<=40 && IsDead=FALSE].ID}
					Actor[Query, Name=-"a Kly believer" && Distance<=40 && IsDead=FALSE]:DoTarget
			}
			elseif ${Actor[Query, Name=-"a Kly" && Distance<=10 && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"a Kly" && Distance<=10 && IsDead=FALSE].ID}
					Actor[Query, Name=-"a Kly" && Distance<=10 && IsDead=FALSE]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${_RectorID}
					Actor[Query, ID=${_RectorID} && IsDead=FALSE]:DoTarget
			}
		}
		if ${Actor[Query, Name=-"Droz'kar's totem" && Distance<=20](exists)}
		{
			if ${Math.Distance[${Me.Loc},-37.306847,-38.695023,-342.903687]}<25
			{
				RI_Atom_SetLockSpot ALL 39.722591 -38.682175 -342.767426
				wait 100 ${Math.Distance[${Me.Loc},39.722591,-38.682175,-342.767426]}<3
			}
			elseif ${Math.Distance[${Me.Loc},39.722591,-38.682175,-342.767426]}<25
			{
				RI_Atom_SetLockSpot ALL 39.284538 -38.676414 -407.823883
				wait 100 ${Math.Distance[${Me.Loc},39.284538,-38.676414,-407.823883]}<3
			}
			elseif ${Math.Distance[${Me.Loc},39.284538,-38.676414,-407.823883]}<25
			{
				RI_Atom_SetLockSpot ALL -38.440502 -38.672028 -408.496338
				wait 100 ${Math.Distance[${Me.Loc},-38.440502,-38.672028,-408.496338]}<3
			}
		}
		wait 2
	}
	
	echo Ending Rector v1
}
function Izzak()
{
	echo Starting Izzak v1

	declare Rune3Color string global
	declare Rune2Color string global
	declare Rune1Color string global
	variable string RCColor
	variable int CurrentRune
	variable int CurrentRuneToMoveFrom
	
	RIMUIObj:SetLockSpot[ALL,-120.142761,-38.725399,-404.647614]
	if !${RI_Var_Bool_GlobalOthers}
	{
		Actor[Rune Base 3]:DoubleClick
		wait 2
		Actor[Rune Base 3]:DoubleClick
		wait 2
		Actor[Rune Base 3]:DoubleClick
		wait 25
		if ${Actor[Query, Name=-"Purple Ritual Rune" && Distance<=25](exists)}
			Rune3Color:Set[purple];echo ISXRI: Rune 3 Color is purple
		elseif ${Actor[Query, Name=-"Yellow Ritual Rune" && Distance<=25](exists)}
			Rune3Color:Set[yellow];echo ISXRI: Rune 3 Color is yellow
		elseif ${Actor[Query, Name=-"Green Ritual Rune" && Distance<=25](exists)}
			Rune3Color:Set[green];echo ISXRI: Rune 3 Color is green
		elseif ${Actor[Query, Name=-"Red Ritual Rune" && Distance<=25](exists)}
			Rune3Color:Set[red];echo ISXRI: Rune 3 Color is red
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,OFF]
		;relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
		call RIMObj.Move -59.003780 -38.732059 -398.872070 1 0 0 0 1 1 1 1
		call RIMObj.Move -49.839794 -38.821129 -309.264923 1 0 0 0 1 1 1 1
		call RIMObj.Move -87.385818 -38.950321 -271.605042 1 0 0 0 1 0 1 1
		call RIMObj.CheckCombat
		if ${Actor[Query, Name=-"a rune keeper" && Distance<=75](exists)}
			Actor[Query, Name=-"a rune keeper" && Distance<=75]:DoTarget
		wait 50
		call RIMObj.CheckCombat
		Actor[Rune Base 2]:DoubleClick
		wait 2
		Actor[Rune Base 2]:DoubleClick
		wait 2
		Actor[Rune Base 2]:DoubleClick
		wait 25
		if ${Actor[Query, Name=-"Purple Ritual Rune" && Distance<=25](exists)}
			Rune2Color:Set[purple];echo ISXRI: Rune 2 Color is purple
		elseif ${Actor[Query, Name=-"Yellow Ritual Rune" && Distance<=25](exists)}
			Rune2Color:Set[yellow];echo ISXRI: Rune 2 Color is yellow
		elseif ${Actor[Query, Name=-"Green Ritual Rune" && Distance<=25](exists)}
			Rune2Color:Set[green];echo ISXRI: Rune 2 Color is green
		elseif ${Actor[Query, Name=-"Red Ritual Rune" && Distance<=25](exists)}
			Rune2Color:Set[red];echo ISXRI: Rune 2 Color is red
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,OFF]
		;relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]	
		call RIMObj.Move -43.327141 -38.723545 -315.968689 1 0 0 0 1 1 1 1
		call RIMObj.Move 52.124790 -38.850292 -307.441772 1 0 0 0 1 1 1 1
		call RIMObj.Move 86.053574 -38.950344 -273.199799 1 0 0 0 1 0 1 1
		call RIMObj.CheckCombat
		if ${Actor[Query, Name=-"a rune keeper" && Distance<=75](exists)}
			Actor[Query, Name=-"a rune keeper" && Distance<=75]:DoTarget
		wait 50
		call RIMObj.CheckCombat
		Actor[Rune Base 1]:DoubleClick
		wait 2
		Actor[Rune Base 1]:DoubleClick
		wait 2
		Actor[Rune Base 1]:DoubleClick
		wait 25
		if ${Actor[Query, Name=-"Purple Ritual Rune" && Distance<=25](exists)}
			Rune1Color:Set[purple];echo ISXRI: Rune 1 Color is purple
		elseif ${Actor[Query, Name=-"Yellow Ritual Rune" && Distance<=25](exists)}
			Rune1Color:Set[yellow];echo ISXRI: Rune 1 Color is yellow
		elseif ${Actor[Query, Name=-"Green Ritual Rune" && Distance<=25](exists)}
			Rune1Color:Set[green];echo ISXRI: Rune 1 Color is green
		elseif ${Actor[Query, Name=-"Red Ritual Rune" && Distance<=25](exists)}
			Rune1Color:Set[red];echo ISXRI: Rune 1 Color is red
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,OFF]
		;relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]	
		call RIMObj.Move 49.130096 -38.768909 -312.693054 1 0 0 0 1 1 1 1
		call RIMObj.Move 61.758938 -38.729225 -399.447205 1 0 0 0 1 1 1 1
		call RIMObj.Move 124.083481 -38.726044 -406.049316 1 0 0 0 1 1 1 1
		call RIMObj.Move 147.064316 -38.725487 -401.148499 1 0 0 0 1 0 1 1
		if ${Actor[Query, Name=-"a gooblin" && Distance<=35](exists)}
			Actor[Query, Name=-"a gooblin" && Distance<=75]:DoTarget
		wait 50
		call RIMObj.CheckCombat
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,OFF]
		;relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]	
		call RIMObj.Move 267.796814 -38.724056 -400.933228 1 0 0 0 1 1 1 1
		call RIMObj.Move 267.342682 -38.723660 -333.526550 1 0 0 0 1 0 1 1
		wait 50
		call RIMObj.CheckCombat
		call RIMObj.Move 267.618073 -38.574669 -300.583923 1 0 0 0 1 0 1 1
		wait 50
		call RIMObj.CheckCombat
		while !${Actor[Query, Name=-"Izzak Sira" && IsDead=FALSE && Distance<=50](exists)}
			wait 2
		relay ${RI_Var_String_RelayGroup} RI_Obj_CB:CastWhileMoving[1]
		variable int _IzzakID=${Actor[Query, Name=-"Izzak Sira" && IsDead=FALSE].ID}
		if !${RI_Var_String_GlobalOthers}
			Actor[Query, ID=${_IzzakID} && IsDead=FALSE]:DoTarget
		
		while ${Actor[Query, Name=-"Rune Circle" && Distance<=50].Overlay.Right[-19].Equal[""]}
			wait 2
		
		;Rune Circle
		;Purple Overlay=design_ring_dragon_purple
		;Red Overlay=design_ring_dragon_red
		;Green Overlay=design_ring_dragon_green
		
		call RIMObj.Move 267.494659 -38.723606 -330.392670 1 0 0 0 1 0 1 1
		wait 50
		RCColor:Set[${Actor[Query, Name=-"Rune Circle" && Distance<=50].Overlay.Right[-19]}]
		echo ISXRI: Rune Circle Color is ${RCColor}
		call RIMObj.Move 262.068939 -38.724697 -396.927765 1 0 0 0 1 0 1 1
		wait 50;call IzzakCheckAdds
		call RIMObj.Move 199.829590 -38.725895 -400.151184 1 0 0 0 1 0 1 1
		wait 50;call IzzakCheckAdds
		call RIMObj.Move 135.818924 -38.730408 -414.746277 1 0 0 0 1 0 1 1
		wait 50;call IzzakCheckAdds
		call RIMObj.Move 103.001060 -38.723740 -400.356812 1 0 0 0 1 0 1 1
		wait 50;call IzzakCheckAdds
		call RIMObj.Move 53.915699 -38.724609 -400.820740 1 0 0 0 1 0 1 1
		wait 50;call IzzakCheckAdds
		
		;now need to determine which room to move too
		if ${RCColor.Equal[${Rune3Color}]}
			CurrentRune:Set[3];call Rune4ToRune3
		elseif ${RCColor.Equal[${Rune2Color}]}
			CurrentRune:Set[2];call Rune4ToRune2
		elseif ${RCColor.Equal[${Rune1Color}]}
			CurrentRune:Set[1];call Rune4ToRune1
	}
	
	while ${Actor[Query, ID=${_IzzakID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_String_GlobalOthers}
		{
			if ${Target.ID}!=${_IzzakID}
				Actor[Query, ID=${_IzzakID} && IsDead=FALSE]:DoTarget
			
			;check current Rune Circle Overlay against Stored if it changes, check which room we in and which to move too
			if ${Actor[Query, Name=-"Rune Circle"].Overlay.Right[-19].NotEqual[${RCColor}]} && ${Actor[Query, Name=-"Rune Circle"].Overlay.Right[-19].NotEqual[""]} ${Actor[Query, Name=-"Rune Circle"](exists)}
			{
				relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,OFF]
				;relay "other ${RI_Var_String_RelayGroup}" RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
				RCColor:Set[${Actor[Query, Name=-"Rune Circle"].Overlay.Right[-19]}]
				echo ISXRI: Rune Circle Color is ${RCColor}
				;now need to determine which room to move too
				CurrentRuneToMoveFrom:Set[${CurrentRune}]
				if ${RCColor.Equal[${Rune3Color}]}
					CurrentRune:Set[3];call Rune${CurrentRuneToMoveFrom}ToRune3
				elseif ${RCColor.Equal[${Rune2Color}]}
					CurrentRune:Set[2];call Rune${CurrentRuneToMoveFrom}ToRune2
				elseif ${RCColor.Equal[${Rune1Color}]}
					CurrentRune:Set[1];call Rune${CurrentRuneToMoveFrom}ToRune1
			}
		}
		
		wait 2
	}
	call Rune${CurrentRune}ToRune4
	relay ${RI_Var_String_RelayGroup} RI_Obj_CB:CastWhileMoving[0]
	echo Ending Izzak v1
}
function Rune1Spread()
{
	;spread to runes
	RIMUIObj:SetLockSpot[${Me.Name},83.342293,-38.952065,-273.159302]
	wait 30
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[1].Name},92.858215,-38.956055,-276.594238]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[2].Name},81.786659,-38.956318,-265.158997]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[3].Name},89.641335,-38.954987,-256.695709]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[4].Name},97.177101,-38.951221,-259.603577]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[5].Name},100.382172,-38.954205,-270.127838]
	wait 50
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,83.342293,-38.952065,-273.159302]
}
function Rune4ToRune1()
{
	echo ISXRI: Moving from Rune 4 to Rune 1
	call RIMObj.Move 56.835205 -38.723545 -359.974792 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 44.137169 -38.723545 -316.960724 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 84.067093 -38.950638 -274.708374 5 0 0 0 1 0 1 1
	call Rune1Spread
}

function Rune3ToRune1()
{	
	echo ISXRI: Moving from Rune 3 to Rune 1
	call RIMObj.Move -56.210438 -38.728661 -399.561615 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -59.454144 -38.723545 -357.618683 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -41.744484 -38.723545 -316.415833 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 0.394581 -38.723545 -305.481354 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 44.137169 -38.723545 -316.960724 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 84.067093 -38.950638 -274.708374 5 0 0 0 1 0 1 1
	call Rune1Spread
}
function Rune2ToRune1()
{
	echo ISXRI: Moving from Rune 2 to Rune 1
	call RIMObj.Move -41.744484 -38.723545 -316.415833 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 0.394581 -38.723545 -305.481354 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 44.137169 -38.723545 -316.960724 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 84.067093 -38.950638 -274.708374 5 0 0 0 1 0 1 1
	call Rune1Spread
}
function Rune2Spread()
{
	;spread to runes
	RIMUIObj:SetLockSpot[${Me.Name},-82.972740,-38.955830,-267.231079]
	wait 30
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[1].Name},-89.250496,-38.953705,-275.331909]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[2].Name},-84.984138,-38.955116,-259.173828]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[3].Name},-98.785721,-38.954678,-273.920685]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[4].Name},-94.920250,-38.952499,-257.920319]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[5].Name},-100.295395,-38.951611,-262.473602]
	wait 50
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,-82.972740,-38.955830,-267.231079]
}
function Rune4ToRune2()
{
	echo ISXRI: Moving from Rune 4 to Rune 2
	call RIMObj.Move 56.835205 -38.723545 -359.974792 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 44.137169 -38.723545 -316.960724 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 0.394581 -38.723545 -305.481354 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -41.744484 -38.723545 -316.415833 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -82.274704 -38.955997 -267.662262 5 0 0 0 1 0 1 1
	call Rune2Spread
}
function Rune1ToRune2()
{
	echo ISXRI: Moving from Rune 1 to Rune 2
	call RIMObj.Move 44.137169 -38.723545 -316.960724 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 0.394581 -38.723545 -305.481354 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -41.744484 -38.723545 -316.415833 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -82.274704 -38.955997 -267.662262 5 0 0 0 1 0 1 1
	call Rune2Spread
}
function Rune3ToRune2()
{
	echo ISXRI: Moving from Rune 3 to Rune 2
	call RIMObj.Move -56.210438 -38.728661 -399.561615 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -59.454144 -38.723545 -357.618683 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -41.949459 -38.723545 -317.303955 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -113.591309 -38.725742 -404.902100 5 0 0 0 1 0 1 1
	call Rune2Spread
}
function Rune3Spread()
{
	;spread to runes
	RIMUIObj:SetLockSpot[${Me.Name},-113.591309,-38.725742,-404.902100]
	wait 30
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[1].Name},-120.864731,-38.729694,-414.016785]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[2].Name},-116.989716,-38.725212,-396.962585]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[3].Name},-129.951187,-38.732758,-410.980804]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[4].Name},-125.213203,-38.728214,-395.339355]
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[${Me.Group[5].Name},-131.445450,-38.724316,-399.597443]
	wait 50
	relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,-113.591309,-38.725742,-404.902100]
}
function Rune4ToRune3()
{
	echo ISXRI: Moving from Rune 4 to Rune 3
	call RIMObj.Move -0.850155 -38.668236 -411.436340 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -56.216011 -38.729515 -401.816833 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -113.591309 -38.725742 -404.902100 5 0 0 0 1 0 1 1
	call Rune3Spread
}
function Rune2ToRune3()
{
	echo ISXRI: Moving from Rune 2 to Rune 3
	call RIMObj.Move -41.949459 -38.723545 -317.303955 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -59.454144 -38.723545 -357.618683 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -56.210438 -38.728661 -399.561615 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -113.591309 -38.725742 -404.902100 5 0 0 0 1 0 1 1
	call Rune3Spread
}
function Rune1ToRune3()
{
	echo ISXRI: Moving from Rune 1 to Rune 3
	call RIMObj.Move 44.137169 -38.723545 -316.960724 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move 0.394581 -38.723545 -305.481354 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -41.744484 -38.723545 -316.415833 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -59.454144 -38.723545 -357.618683 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -56.210438 -38.728661 -399.561615 1 0 0 0 1 0 1 1
	wait 50;call IzzakCheckAdds
	call RIMObj.Move -113.591309 -38.725742 -404.902100 5 0 0 0 1 0 1 1
	call Rune3Spread
}
function Rune3ToRune4()
{
	echo ISXRI: Moving from Rune 3 to Rune 4
	call RIMObj.Move -55.197220 -38.725742 -400.153961 1 0 0 0 1 0 1 1
	call RIMObj.Move -0.737747 -38.658245 -411.872620 1 0 0 0 1 0 1 1
	call RIMObj.Move 60.601391 -38.724205 -400.739014 1 0 0 0 1 0 1 1
}
function Rune1ToRune4()
{
	echo ISXRI: Moving from Rune 1 to Rune 4
	call RIMObj.Move 49.050411 -38.804855 -310.460358 1 0 0 0 1 0 1 1
	call RIMObj.Move 60.601391 -38.724205 -400.739014 1 0 0 0 1 0 1 1
}
function Rune2ToRune4()
{
	echo ISXRI: Moving from Rune 2 to Rune 4
	call RIMObj.Move -47.204666 -38.780640 -311.168488 1 0 0 0 1 0 1 1
	call RIMObj.Move 49.050411 -38.804855 -310.460358 1 0 0 0 1 0 1 1
	call RIMObj.Move 60.601391 -38.724205 -400.739014 1 0 0 0 1 0 1 1
}
function IzzakCheckAdds()
{
	while ${Actor[Query, ( Name=-"a Kly" || Name=-"an exhumed" ) && IsDead=FALSE && Distance<=10](exists)}
	{
		if ${Target.ID}!=${Actor[Query, ( Name=-"a Kly" || Name=-"an exhumed" ) && IsDead=FALSE && Distance<=10].ID}	
			Actor[Query, ( Name=-"a Kly" || Name=-"an exhumed" ) && IsDead=FALSE && Distance<=10]:DoTarget
		wait 2
	}
}
function Amalgam()
{
	call MessageBox "The order is: ${Rune3Color} , ${Rune2Color} , ${Rune1Color} Go click in that order and kill then return to this spot and resume"
	DeleteVariable Rune1Color
	DeleteVariable Rune2Color
	DeleteVariable Rune3Color
}
function Kly()
{
	squelch HUD -add east 500,400 East: ${Actor[Ritual Power Source Main 2].Overlay.Right[-14]}
	squelch HUD -add west 500,420 West: ${Actor[Ritual Power Source Main 1].Overlay.Right[-14]}
	
	while ${Zone.Name.Find["Crypt of Dalnir: Ritual Chamber"](exists)}
		wait 5
		
	squelch HUD -remove east
	squelch HUD -remove west
}
;;;;;;;;;;;;;;;; End Crypt of Dalnir: Ritual Chamber [Heroic] ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Start Crypt of Dalnir: Baron's Workshop [Heroic] ;;;;;;;;;;;;;;;;;;;;;;
function Frenzied()
{
	echo ISXRI: Starting Frenzied 
	
	RI_Atom_SetLockSpot ${Me.Name} -600.047791 0.769289 -282.796021
	
	while ${Actor[Frenzied](exists)} && !${Actor[Frenzied].IsDead}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[ravenous,radius,50](exists)}
			{
				if ${Target.ID}!=${Actor[ravenous,radius,50].ID}
					Actor[ravenous,radius,50]:DoTarget		
			}
			elseif ${Actor[devourer,radius,20](exists)}
			{
				if ${Target.ID}!=${Actor[devourer,radius,20].ID}
					Actor[devourer,radius,20]:DoTarget		
			}
			else
			{
				if ${Target.ID}!=${Actor[Frenzied].ID}
					Actor[Frenzied]:DoTarget
			}
		}
		wait 1
	}
	echo Ending Frenzied
}

variable index:string blamed
variable bool AlreadyAddedMe=FALSE
function Tootooz()
{
	variable int _TootoozID=${Actor[Query, Name=-"Tootooz" && IsDead=FALSE].ID}
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncementTootooz]
	RIMUIObj:SetLockSpot[ALL,-242.036407,26.464846,-0.067954]
	if ${RI_Var_Bool_GlobalOthers}
	{
		wait 50 !${Me.IsMoving}
		RIMUIObj:SetLockSpot[ALL,-232.236496,26.495329,11.387039]
		;RIMUIObj:SetLockSpot[OFF]
		;RIMUIObj:SetRIFollow[OFF]
		;RI_Atom_MoveBehind ALL ${_TootoozID} 15 99 ${Me.Name}
	}
	else
		Actor[id,${_TootoozID}]:DoTarget
		
	while ${Actor[Query, Name=-"Tootooz" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${_TootoozID}
				Actor[id,${_TootoozID}]:DoTarget
		}
		wait 1
	}
}
;atom triggered when an announcement is detected
atom EQ2_onAnnouncementTootooz(string Message, string SoundType, float Timer)
{
	;if ${RI_Var_Bool_Debug}
	;	echo ${Time}:AnnounceText: ${Message}
	;if ${AnnounceText} exists in the announce, execute
	if ${Message.Find["Tootooz thinks"](exists)}
	{
		variable string Temp
		variable bool alreadyinindex
		alreadyinindex:Set[FALSE]
		Temp:Set[${Message.Right[-15]}]
		Temp:Set[${Temp.Left[-16]}]
		if ${Message.Find["You"](exists)} && !${AlreadyAddedMe}
		{
			blamed:Insert[${Me.Name}]
			AlreadyAddedMe:Set[TRUE]
		}	
		else
		{
			;check if they are in the index
			variable int count
			for(count:Set[1];${count}<=${blamed.Used};count:Inc)
			{
				;echo checking ${blamed.Get[${count}]} against ${Temp}
				if ${blamed.Get[${count}].Equal[${Temp}]}
					alreadyinindex:Set[TRUE]
			}
			if !${alreadyinindex}
			{
				;echo adding ${Temp} to index
				blamed:Insert[${Temp}]
			}
		}		
	}
	if ${Message.Find["point at someone else to blame"](exists)}
	{
		;check if group 1 is in the index and so on and so forth
		variable int gcount
		variable bool gtg
		gtg:Set[FALSE]
		gcount:Set[1]
		while ${gcount}<=5 && !${gtg}
		{
			variable int count2
			for(count2:Set[1];${count2}<=${blamed.Used};count2:Inc)
			{
				;echo 2: checking ${blamed.Get[${count2}]} against ${Me.Group[${gcount}]}
				if ${blamed.Get[${count2}].Equal[${Me.Group[${gcount}]}]}
				{
					gtg:Set[TRUE]
					continue
				}
			}
			gcount:Inc
		}
		;turn off assisting
		RI_CMD_Assisting 0
		
		;pause bots
		RI_CMD_PauseCombatBots 1
		
		;target
		TimedCommand 3 Target ${Me.Group[${gcount}]}
		;wait 2
		TimedCommand 6 eq2ex point
		;wait 1
				
		;unpause bots
		TimedCommand 10 RI_CMD_PauseCombatBots 0
		
		;turn on assisting
		TimedCommand 10 RI_CMD_Assisting 1
	}
}
function Googantuan()
{
	variable int _GoogantuanID=${Actor[Query, && Name=-"Googantuan" && IsDead=FALSE].ID}
	variable bool _GotValves=FALSE
	RIMUIObj:SetLockSpot[OFF]
	echo ISXRI: Starting Googantuan 
	relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},1,100]
	call RIMObj.Move -423.743500 1.228983 -195.665985 1 0 0 0 1 0 1 1
	RI_CMD_PauseCombatBots 1
	while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
	{
		Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
		wait 2
	}
	RI_CMD_PauseCombatBots 0
	wait 20
	_GoogantuanID:Set[${Actor[Query, && Name=-"Googantuan" && IsDead=FALSE].ID}]
	while ${Actor[Query, Name=-"Googantuan" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if !${_GotValves} && !${Zone.Name.Find["[Solo]"](exists)}
			{
				relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},1,100]
				RIMUIObj:SetLockSpot[OFF]
				RIMUIObj:SetRIFollow[OFF]
				call RIMObj.Move -423.743500 1.228983 -195.665985 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -422.953339 1.228984 -183.556915 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -412.846069 1.229390 -183.372772 1 0 0 0 1 1 1 1
				call RIMObj.Move -402.701874 1.229717 -183.358627 1 0 0 0 1 1 1 1
				call RIMObj.Move -393.441742 1.229717 -183.718185 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -393.496704 1.229717 -193.839325 1 0 0 0 1 1 1 1
				call RIMObj.Move -393.629456 1.229717 -196.658813 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -383.286285 1.229717 -196.326172 1 0 0 0 1 1 1 1
				call RIMObj.Move -373.043243 1.229717 -196.168442 1 0 0 0 1 1 1 1
				call RIMObj.Move -362.852203 1.229717 -196.050262 1 0 0 0 1 1 1 1
				call RIMObj.Move -352.644623 1.229811 -196.082504 1 0 0 0 1 1 1 1
				call RIMObj.Move -342.643768 1.230334 -196.139282 1 0 0 0 1 1 1 1
				call RIMObj.Move -340.355316 1.230443 -196.459000 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -340.457672 1.230448 -186.440872 1 0 0 0 1 1 1 1
				call RIMObj.Move -340.345917 1.230441 -183.257614 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -330.252472 1.229717 -181.858521 1 0 0 0 1 1 1 1
				call RIMObj.Move -320.326233 1.230079 -178.762466 1 0 0 0 1 1 1 1
				call RIMObj.Move -312.260742 1.229631 -172.687546 1 0 0 0 1 1 1 1
				call RIMObj.Move -305.106598 1.229717 -165.296753 1 0 0 0 1 1 1 1
				call RIMObj.Move -298.174286 1.229716 -158.044174 1 0 0 0 1 1 1 1
				call RIMObj.Move -291.125854 1.229717 -150.815231 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.169891 1.229714 -142.937469 1 0 0 0 1 1 1 1
				call RIMObj.Move -283.301636 1.229610 -142.100891 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -283.668152 1.229717 -152.392914 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.025452 1.229716 -162.424133 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.384338 1.229716 -172.498154 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.744293 1.229653 -182.604156 1 0 0 0 1 1 1 1
				call RIMObj.Move -285.033722 1.229619 -192.696228 1 0 0 0 1 1 1 1
				call RIMObj.Move -285.053345 1.229618 -202.712906 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.992554 1.229716 -212.761093 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.597961 1.229716 -223.072601 1 0 0 0 1 1 1 1
				call RIMObj.Move -284.006287 1.229717 -233.119827 1 0 0 0 1 1 1 1
				call RIMObj.Move -283.861542 1.229676 -239.032883 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -277.544037 1.229716 -231.255127 1 0 0 0 1 1 1 1
				call RIMObj.Move -271.144104 1.229716 -223.462326 1 0 0 0 1 1 1 1
				call RIMObj.Move -264.372650 1.229717 -215.803024 1 0 0 0 1 1 1 1
				call RIMObj.Move -257.164825 1.229537 -208.509537 1 0 0 0 1 1 1 1
				call RIMObj.Move -249.776520 1.229981 -201.606079 1 0 0 0 1 1 1 1
				call RIMObj.Move -242.232407 1.229745 -194.968262 1 0 0 0 1 1 1 1
				call RIMObj.Move -234.805359 1.229717 -188.271347 1 0 0 0 1 1 1 1
				call RIMObj.Move -229.634811 1.230220 -184.578461 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -230.145538 1.230185 -194.872375 1 0 0 0 1 1 1 1
				call RIMObj.Move -230.248947 1.227926 -195.544739 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -222.110184 1.229717 -189.563309 1 0 0 0 1 1 1 1
				call RIMObj.Move -214.028488 1.229863 -183.348450 1 0 0 0 1 1 1 1
				call RIMObj.Move -206.193359 1.229835 -176.710144 1 0 0 0 1 1 1 1
				call RIMObj.Move -198.886627 1.229429 -169.628479 1 0 0 0 1 1 1 1
				call RIMObj.Move -191.817810 1.229716 -162.531219 1 0 0 0 1 1 1 1
				call RIMObj.Move -184.499435 1.229716 -154.966736 1 0 0 0 1 1 1 1
				call RIMObj.Move -177.612579 1.229716 -147.453629 1 0 0 0 1 1 1 1
				call RIMObj.Move -171.501846 1.229422 -141.083725 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -172.856415 1.229717 -151.151566 1 0 0 0 1 1 1 1
				call RIMObj.Move -173.393265 1.229716 -161.381409 1 0 0 0 1 1 1 1
				call RIMObj.Move -173.795288 1.229716 -171.374298 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.084488 1.229714 -181.512985 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.033096 1.229709 -191.720596 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.132584 1.229714 -201.816315 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.236847 1.229716 -211.943909 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.294785 1.229716 -222.183289 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.352386 1.229718 -232.359070 1 0 0 0 1 1 1 1
				call RIMObj.Move -174.334351 1.229690 -239.372330 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -168.503983 1.229716 -231.012238 1 0 0 0 1 1 1 1
				call RIMObj.Move -162.210754 1.229716 -223.200546 1 0 0 0 1 1 1 1
				call RIMObj.Move -155.094604 1.229717 -216.151230 1 0 0 0 1 1 1 1
				call RIMObj.Move -147.439682 1.229513 -209.648254 1 0 0 0 1 1 1 1
				call RIMObj.Move -139.590363 1.229989 -203.373978 1 0 0 0 1 1 1 1
				call RIMObj.Move -131.658188 1.229718 -197.284454 1 0 0 0 1 1 1 1
				call RIMObj.Move -123.560265 1.229717 -191.307831 1 0 0 0 1 1 1 1
				call RIMObj.Move -115.542801 1.229717 -185.241348 1 0 0 0 1 1 1 1
				call RIMObj.Move -114.752487 1.229717 -184.764374 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -114.885887 1.229717 -194.986008 1 0 0 0 1 1 1 1
				call RIMObj.Move -114.891426 1.229717 -195.405701 1 0 0 0 1 0 1 1
				RI_CMD_PauseCombatBots 1
				while ${Actor[Query, Name=-"Valve" && Distance<=5].HighlightOnMouseHover}
				{
					Actor[Query, Name=-"Valve" && Distance<=5]:DoubleClick
					wait 2
				}
				RI_CMD_PauseCombatBots 0
				wait 20
				call RIMObj.Move -124.886337 1.229717 -193.252991 1 0 0 0 1 1 1 1
				call RIMObj.Move -134.834396 1.229899 -191.915985 1 0 0 0 1 1 1 1
				call RIMObj.Move -144.994232 1.229716 -190.776840 1 0 0 0 1 1 1 1
				call RIMObj.Move -151.129150 1.229716 -190.127319 1 0 0 0 1 0 1 1
				_GotValves:Set[TRUE]
				RIMUIObj:SetLockSpot[ALL,-151.129150,1.229716,-190.127319]
				relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_MoveBehind ALL ${_GoogantuanID} 30 100 ${Me.Name}
				
			}
			; if ${Actor[Query, Name=-"" && Distance<=15](exists)}
			; {
				; if ${Target.ID}!=${Actor[Query, Name=-"" && Distance<=15].ID}
					; Actor[Query, Name=-"" && Distance<=15]:DoTarget
			; }
			; else 
			; {
			_GoogantuanID:Set[${Actor[Query, && Name=-"Googantuan" && IsDead=FALSE].ID}]
			if ${Target.ID}!=${_GoogantuanID} && ${_GoogantuanID}!=0
				Actor[id,${_GoogantuanID}]:DoTarget
			; }
		}
		wait 5
	}
	echo Ending Googantuan
}
function BaronHuntForKey()
{
	if ${Zone.Name.Find["[Solo]"](exists)}
	{
		call RIMObj.Move -409.615448 1.229717 -195.947357 1 0 0 0 1 1 1 1
		call RIMObj.Move -386.737213 1.229717 -190.916397 1 0 0 0 1 1 1 1
		call RIMObj.Move -348.310181 1.230038 -188.412079 1 0 0 0 1 1 1 1
		call RIMObj.Move -320.265015 1.230082 -182.446259 1 0 0 0 1 1 1 1
		call RIMObj.Move -297.468872 1.229716 -152.824005 1 0 0 0 1 0 1 1
		wait 20
		call UseItem slimeskin
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call UseItem slimeskin"]
		wait 20
		call RIMObj.Move -301.104828 2.097103 -143.956879 1 0 0 0 1 1 1 1
		call RIMObj.Move -306.350800 -4.749633 -128.618073 1 0 0 0 1 1 1 1
		call RIMObj.Move -307.698425 -4.572316 -130.183746 1 0 0 0 1 0 1 1
		wait 20
		relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor[special]:DoubleClick
		wait 20
		call RIMObj.Move -300.445709 -4.521551 -129.519836 1 0 0 0 1 1 1 1
		call RIMObj.Move -279.833649 -4.577335 -133.163544 1 0 0 0 1 1 1 1
		call RIMObj.Move -260.664642 -4.458849 -136.322083 1 0 0 0 1 1 1 1
		call RIMObj.Move -247.069443 -4.473476 -165.692169 1 0 0 0 1 1 1 1
		call RIMObj.Move -229.735809 -4.537671 -169.130798 1 0 0 0 1 1 1 1
		call RIMObj.Move -229.363480 -0.599283 -173.984924 1 0 0 0 1 1 1 1
		call RIMObj.Move -229.098022 2.096683 -179.941284 1 0 0 0 1 1 1 1
		call RIMObj.Move -207.819443 1.229930 -191.406036 1 0 0 0 1 1 1 1
		call RIMObj.Move -173.949326 1.229701 -190.505600 1 0 0 0 1 1 1 1
		call RIMObj.Move -152.905701 1.229716 -190.025620 1 0 0 0 1 1 1 1
	}
	else
	{
		Actor["Key Spotlight"]:WaypointTo
		call MessageBox "Go find the key, hit resume once done near the foremans door"
	}
}
function Baron()
{
	echo ISXRI: Starting Baron
	variable int _BaronID=${Actor[Query, Name=="Haggle Baron Dalnir" && IsDead=FALSE].ID}
	if ${Zone.Name.Find["[Solo]"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest[Kunark Ascending: A Chosen Weapon](exists)}
		{
			CustomLoc:Set[0 0 0]
			call HailActor Baron 2
			wait 100
			call HailActor Baron 8
			wait 50
			_BaronID:Set[${Actor[Query, Name=="Haggle Baron Dalnir" && IsDead=FALSE].ID}]
			while ${Actor[Query, Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${_BaronID}
					Actor[id,${_BaronID}]:DoTarget
				wait 5
			}
			;gograb resources and craft
			call RIMObj.Move -229.486160 26.307547 -488.759766 1 0 0 0 1 1 1 1
			call RIMObj.Move -229.028534 26.950857 -464.146454 1 0 0 0 1 1 1 1
			call RIMObj.Move -258.085724 27.090219 -448.304535 1 0 0 0 1 0 1 1
			wait 20
			call ClickActor "Forge Door 2 - Right"
			wait 20
			call RIMObj.Move -280.575745 26.937538 -441.575165 1 0 0 0 1 0 1 1
			wait 20
			call ClickActor "Dalnir's work chest"
			wait 20
			call ScribeBook "Greenmist Design Pattern"
			relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call ScribeBook \"Greenmist Design Pattern\""]
			wait 20
			call RIMObj.Move -281.516937 26.942476 -462.364258 1 0 0 0 1 0 1 1
			wait 20
			call MoveToActor "khukri blade mold" 10 1
			wait 20
			call ClickActor "khukri blade mold"
			wait 20
			call RIMObj.Move -280.575745 26.937538 -441.575165 1 0 0 0 1 1 1 1
			call RIMObj.Move -229.607101 26.950447 -458.346405 1 0 0 0 1 1 1 1
			call RIMObj.Move -197.857803 27.122066 -449.059906 1 0 0 0 1 1 1 1
			call RIMObj.Move -168.722046 26.945513 -444.427368 1 0 0 0 1 0 1 1
			wait 20
			call ClickActor "Coal Bin 1"
			wait 20
			call RIMObj.Move -168.736649 26.948915 -455.388245 1 0 0 0 1 0 1 1
			wait 20
			call MoveToActor "imbued tynnonium" 8 1
			wait 20
			call ClickActor "imbued tynnonium"
			wait 20
			call RIMObj.Move -168.736649 26.948915 -455.388245 1 0 0 0 1 0 1 1
			wait 20
			call MoveToActor "imbued tynnonium" 8 1
			wait 20
			call ClickActor "imbued tynnonium"
			wait 20
			call RIMObj.Move -168.736649 26.948915 -455.388245 1 0 0 0 1 0 1 1
			wait 20
			call MoveToActor "imbued tynnonium" 8 1
			wait 20
			call ClickActor "imbued tynnonium"
			wait 20
			call RIMObj.Move -168.736649 26.948915 -455.388245 1 0 0 0 1 0 1 1
			wait 20
			call MoveToActor "fear-soaked leather" 8 1
			wait 20
			call ClickActor "fear-soaked leather"
			wait 20
			call RIMObj.Move -168.736649 26.948915 -455.388245 1 0 0 0 1 1 1 1
			call RIMObj.Move -183.176331 26.950291 -448.932922 1 0 0 0 1 1 1 1
			call RIMObj.Move -217.260590 26.941422 -453.835602 1 0 0 0 1 1 1 1
			call RIMObj.Move -227.800613 26.911406 -473.455170 1 0 0 0 1 1 1 1
			call RIMObj.Move -226.124969 25.181273 -503.485443 1 0 0 0 1 1 1 1
			call RIMObj.Move -221.105560 25.181273 -525.897339 1 0 0 0 1 1 1 1
			call RIMObj.Move -215.866608 25.181273 -526.432373 1 0 0 0 1 0 1 1
			wait 20
			call CraftIt "Greenmist Design Pattern"
			relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call CraftIt \"Greenmist Design Pattern\""]
			wait 50
			call RIMObj.Move -229.251068 25.181273 -525.721619 1 0 0 0 1 0 1 1
		}
		else 
		{
			call HailActor Baron 2 1 1 0
			wait 50
			_BaronID:Set[${Actor[Query, Name=="Haggle Baron Dalnir" && IsDead=FALSE].ID}]
			while ${Actor[Query, Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${_BaronID}
					Actor[id,${_BaronID}]:DoTarget
				wait 5
			}
		}
	}
	else
	{
		;if !${RI_Var_Bool_GlobalOthers}
		call HailActor Baron 2 1 1 0
				
	;	RIMUIObj:LootOptions[ALL,FFA]
		variable bool SettingsAssistingCheckBox=${RI_Obj_CB.GetUISetting[SettingsAssistingCheckBox]}

		RIMUIObj:SetLockSpot[ALL,-229.639999,25.181273,-521.262268]
		
		RI_Var_Bool_SkipLoot:Set[TRUE]
		RIMUIObj:SetRIFollow[OFF]
		wait 50
		_BaronID:Set[${Actor[Query, Name=="Haggle Baron Dalnir" && IsDead=FALSE].ID}]
		while ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Actor[Query, Name=="an extrusive rock golem" && IsDead=FALSE](exists)}
				{
					if ${Target.ID}!=${Actor[Query, Name=="an extrusive rock golem" && IsDead=FALSE].ID}
						Actor[Query, Name=="an extrusive rock golem" && IsDead=FALSE]:DoTarget
				}
				else 
				{
					if ${Target.ID}!=${_BaronID}
						Actor[id,${_BaronID}]:DoTarget
				}
			}
			;if we are a bard, do crafting stuffs
			if ${Me.Class.Equal[bard]} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
			{
				;echo check the levers
				if ${Actor[Query, Name=-"Broken Forge Lever 1"].HighlightOnMouseHover}
				{
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
					RIMUIObj:SetLockSpot[OFF]
					Actor[${Me.ID}]:DoTarget
					eq2ex cancel_spellcast
								
					;move to resources
					wait 2 !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					if !${Me.Maintained[Sprint](exists)}
						Me.Ability[Sprint]:Use
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -207.236526 26.942169 -451.216156 1 0 0 1 1 1 1 1
					call RIMObj.Move -191.574722 26.950871 -448.685089 1 0 0 1 1 0 1 1
					RIMUIObj:SetLockSpot[${Me.Name},-157.140182,26.946106,-446.409851]
					while ${Actor[Query, Name=="Coal Bin 1"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Coal Bin 1"]:DoubleClick
						wait 2
					}
					while ${Actor[Query, Name=="pail of water"].HighlightOnMouseHover} && !${Me.Inventory[a pail of water](exists)} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="pail of water"]:DoubleClick
						wait 5
					}
					RIMUIObj:SetLockSpot[OFF]
					call RIMObj.Move -191.574722 26.950871 -448.685089 1 0 0 1 1 1 1 1
					call RIMObj.Move -207.236526 26.942169 -451.216156 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 1 1 1
					
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 0 1 1
					while !${Me.Inventory[Query, Name=="molten Obulus ore"](exists)} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						if ${Actor[Query, Name=="an extrusive rock golem" && IsDead=TRUE](exists)}
							Actor[Query, Name=="an extrusive rock golem" && IsDead=TRUE]:DoubleClick
						wait 2
						;echo waiting for dead golem
					}
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
					Actor[${Me.ID}]:DoTarget
					eq2ex cancel_spellcast
					call RIMObj.Move -215.293152 25.181273 -526.250610 2 0 0 0 1 0 1 1
					wait 10
					while ${Actor[Query, Name=-"Broken Forge Lever 1"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=-"Broken Forge Lever 1"]:DoubleClick
						wait 5
						;echo clicking lever
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
				
					if ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
						Actor[Query, Name=="Dalnir's Forge" && Distance<=15]:DoTarget
					;wait 5
					if ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
						call CraftIt "Repair Forge Maw Control Lever"
					
					wait 5
					
					while ${Actor[Query, Name=="Forge Lever Base 1"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Forge Lever Base 1"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					while ${Actor[Query, Name=="Forge Lever 1"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Forge Lever 1"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 0 1 1
					RIMUIObj:SetLockSpot[ALL,-229.639999,25.181273,-521.262268]
									
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]

				}
				;call RIMObj.Move -220.733398 25.181273 -555.388245 1 0 0 0 1 0 1 1
				elseif ${Actor[Query, Name=-"Broken Forge Lever 2"].HighlightOnMouseHover}
				{
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
					RIMUIObj:SetLockSpot[OFF]
					Actor[${Me.ID}]:DoTarget
					eq2ex cancel_spellcast
									
					;move to resources
					wait 2 !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					if !${Me.Maintained[Sprint](exists)}
						Me.Ability[Sprint]:Use
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -207.236526 26.942169 -451.216156 1 0 0 1 1 1 1 1
					call RIMObj.Move -191.574722 26.950871 -448.685089 1 0 0 1 1 0 1 1
					RIMUIObj:SetLockSpot[${Me.Name},-157.140182,26.946106,-446.409851]
					while ${Actor[Query, Name=="Coal Bin 1"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Coal Bin 1"]:DoubleClick
						wait 2
					}
					while ${Actor[Query, Name=="pail of water"].HighlightOnMouseHover} && !${Me.Inventory[a pail of water](exists)} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="pail of water"]:DoubleClick
						wait 5
					}
					RIMUIObj:SetLockSpot[OFF]
					call RIMObj.Move -191.574722 26.950871 -448.685089 1 0 0 1 1 1 1 1
					call RIMObj.Move -207.236526 26.942169 -451.216156 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 1 1 1
					
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 0 1 1
					while !${Me.Inventory[Query, Name=="molten Obulus ore"](exists)} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						if ${Actor[Query, Name=="an extrusive rock golem" && IsDead=TRUE](exists)}
							Actor[Query, Name=="an extrusive rock golem" && IsDead=TRUE]:DoubleClick
						wait 2
						;echo waiting for dead golem
					}
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
					Actor[${Me.ID}]:DoTarget
					eq2ex cancel_spellcast
					call RIMObj.Move -220.733398 25.181273 -555.388245 1 0 0 0 1 0 1 1
					wait 10
					while ${Actor[Query, Name=-"Broken Forge Lever 2"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=-"Broken Forge Lever 2"]:DoubleClick
						wait 5
						;echo clicking lever
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}

					if ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
						Actor[Query, Name=="Dalnir's Forge" && Distance<=15]:DoTarget
					;wait 5
					if ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
						call CraftIt "Repair Forge Maw Control Lever"
					
					wait 5
					
					while ${Actor[Query, Name=="Forge Lever Base 2"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Forge Lever Base 2"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					while ${Actor[Query, Name=="Forge Lever 2"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Forge Lever 2"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 0 1 1
					RIMUIObj:SetLockSpot[ALL,-229.639999,25.181273,-521.262268]
									
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]
				}
				;call RIMObj.Move -243.049377 25.181273 -526.469727 2 0 0 0 1 0 1 1
				elseif ${Actor[Query, Name=-"Broken Forge Lever 3"].HighlightOnMouseHover}
				{
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
					RIMUIObj:SetLockSpot[OFF]
					Actor[${Me.ID}]:DoTarget
					eq2ex cancel_spellcast
					
					;move to resources
					wait 2 !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					if !${Me.Maintained[Sprint](exists)}
						Me.Ability[Sprint]:Use
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -207.236526 26.942169 -451.216156 1 0 0 1 1 1 1 1
					call RIMObj.Move -191.574722 26.950871 -448.685089 1 0 0 1 1 0 1 1
					RIMUIObj:SetLockSpot[${Me.Name},-157.140182,26.946106,-446.409851]
									while ${Actor[Query, Name=="Coal Bin 1"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Coal Bin 1"]:DoubleClick
						wait 2
					}
					while ${Actor[Query, Name=="pail of water"].HighlightOnMouseHover} && !${Me.Inventory[a pail of water](exists)} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="pail of water"]:DoubleClick
						wait 5
					}
					RIMUIObj:SetLockSpot[OFF]
					call RIMObj.Move -191.574722 26.950871 -448.685089 1 0 0 1 1 1 1 1
					call RIMObj.Move -207.236526 26.942169 -451.216156 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.254974 26.960962 -472.571930 1 0 0 1 1 1 1 1
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 1 1 1
					
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 0 1 1
					while !${Me.Inventory[Query, Name=="molten Obulus ore"](exists)} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						if ${Actor[Query, Name=="an extrusive rock golem" && IsDead=TRUE](exists)}
							Actor[Query, Name=="an extrusive rock golem" && IsDead=TRUE]:DoubleClick
						wait 2
						;echo waiting for dead golem
					}
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
					Actor[${Me.ID}]:DoTarget
					eq2ex cancel_spellcast
					call RIMObj.Move -243.049377 25.181273 -526.469727 2 0 0 0 1 0 1 1
					wait 10
					while ${Actor[Query, Name=-"Broken Forge Lever 3"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=-"Broken Forge Lever 3"]:DoubleClick
						wait 5
						;echo clicking lever
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					
					if ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
						Actor[Query, Name=="Dalnir's Forge" && Distance<=15]:DoTarget
					;wait 5
					if ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
						call CraftIt "Repair Forge Maw Control Lever"
					
					wait 5
					
					while ${Actor[Query, Name=="Forge Lever Base 3"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Forge Lever Base 3"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					while ${Actor[Query, Name=="Forge Lever 3"].HighlightOnMouseHover} && ${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					{
						Actor[Query, Name=="Forge Lever 3"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					wait 50 !${Me.CastingSpell} || !${Actor[Query, Type=="NamedNPC" && Name=="Haggle Baron Dalnir" && IsDead=FALSE](exists)}
					
					call RIMObj.Move -229.639999 25.181273 -521.262268 1 0 0 0 1 0 1 1
					RIMUIObj:SetLockSpot[ALL,-229.639999,25.181273,-521.262268]
									
					RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
					if ${SettingsAssistingCheckBox}
						RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]
				}
			}
			wait 1
		}
		RIMUIObj:LootOptions[ALL,RR]
		RI_Var_Bool_SkipLoot:Set[FALSE]
	}
	echo Ending Baron
	
}
function Enchanted()
{
	variable int _ShieldID=${Actor[Query, Name=="Enchanted Shield" && IsDead=FALSE].ID}
	variable int _SwordID=${Actor[Query, Name=="Enchanted Sword" && IsDead=FALSE].ID}
	;Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert["prepares to flurry with arcanic energy!"]
	RIMUIObj:SetLockSpot[ALL,-266.234802,26.919926,-382.241852]

	echo ISXRI: Starting Enchanted 
	while ${Actor[Query, Name=-"Enchanted" && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, ID=${_ShieldID} && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${_ShieldID}
					Actor[Query, ID=${_ShieldID} && IsDead=FALSE]:DoTarget
			}
			else 
			{
				if ${Target.ID}!=${_SwordID}
					Actor[Query, ID=${_SwordID} && IsDead=FALSE]:DoTarget
			}
		}
		if ${Trigger}
;		&& ${Actor[id,${_SwordID}].Distance}<30
		{
			if ${Math.Distance[${Me.Loc},-276.715881,26.919044,-412.841095]}<5
				RIMUIObj:SetLockSpot[ALL,-266.234802,26.919926,-382.241852]
			else
				RIMUIObj:SetLockSpot[ALL,-276.715881,26.919044,-412.841095]
			Trigger:Set[FALSE]
		}
		;if we are a mage watch for spell's MainIconID and cast absorb magic
		if ${Me.Archetype.Equal[mage]}
		{
			if ${Actor[id,${_ShieldID}](exists)}
			{
				;if we see "Defensive Infusion" (MainIconID=846) on "Enchanted Shield", pause bot, stop casting and cast Absorb Magic
				if ${RIObj.MainIconIDExists[${_ShieldID},846]} && ${Me.Ability[id,1812025739].IsReady} && ${Actor[id,${_ShieldID}].Distance}<25
				{
					;turn off assisting
					RI_CMD_Assisting 0
					
					;pause bots
					RI_CMD_PauseCombatBots 1
					
					;target
					Actor[Query, ID=${_ShieldID}]:DoTarget
					
					;cancel spellcast and clear ability queue
					eq2ex cancel_spellcast
					eq2ex clearabilityqueue 
					
					;wait until we are not casting
					wait 200 !${Me.CastingSpell}
					
					;keep attempting to cast absorb magic (ID=1812025739) until it is no longer ready (aka casted)
					do
					{
						if ${Target.ID}==${_ShieldID}
							Me.Ability[id,1812025739]:Use
						else
							Actor[Query, ID=${_ShieldID}]:DoTarget
						wait 1
					}
					while ${Me.Ability[id,1812025739].IsReady}
					
					;wait until we are not casting
					wait 200 !${Me.CastingSpell}
					
					;turn on assisting
					RI_CMD_Assisting 1
					
					;unpause bots
					RI_CMD_PauseCombatBots 0
				}
			}
			else
			{
				;if we see "Offensive Infusion" (MainIconID=264) on "Enchanted Sword", pause bot, stop casting and cast Absorb Magic
				if ${RIObj.MainIconIDExists[${_SwordID},264]} && ${Me.Ability[id,1812025739].IsReady} && ${Actor[id,${_SwordID}].Distance}<25
				{
					;turn off assisting
					RI_CMD_Assisting 0
					
					;pause bots
					RI_CMD_PauseCombatBots 1
					
					;target
					Actor[Query, ID=${_SwordID}]:DoTarget
					
					;cancel spellcast and clear ability queue
					eq2ex cancel_spellcast
					eq2ex clearabilityqueue 
					
					;wait until we are not casting
					wait 200 !${Me.CastingSpell}
					
					;keep attempting to cast absorb magic (ID=1812025739) until it is no longer ready (aka casted)
					do
					{
						if ${Target.ID}==${_SwordID}
							Me.Ability[id,1812025739]:Use
						else
							Actor[Query, ID=${_SwordID}]:DoTarget
						wait 1
					}
					while ${Me.Ability[id,1812025739].IsReady}
					
					;wait until we are not casting
					wait 200 !${Me.CastingSpell}
					
					;turn on assisting
					RI_CMD_Assisting 1
					
					;unpause bots
					RI_CMD_PauseCombatBots 0
				}
			}
		}
		wait 1
	}
	echo Ending Enchanted
	IncomingText:Clear
	IncomingText2:Clear
}


function Baronwall()
{
	declare BWRDone bool global FALSE
	declare BWLDone bool global FALSE
	if !${RI_Var_Bool_GlobalOthers}
	{
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call Baronwall"]
		wait 5
	}
	RI_Var_Bool_Follow:Set[FALSE]
	ShinyScanDistance:Set[2]
	eq2execute stopfollow
	RI_Atom_SetRIFollow OFF
	RI_Atom_SetLockSpot OFF
	squelch hud -add BWRDone 300,400 Right Wall Done: ${BWRDone}  InCombat: ${Me.InCombat}
	squelch hud -add BWLDone 300,420 Left Wall Done: ${BWLDone}  InCombat: ${Me.InCombat}
	call RIMObj.CheckCombat
	while ${Me.Y}<31
	{
		while ${Me.Y}<28
		{
			if ${Math.Distance[${Me.Loc},-145.118179,26.472359,18.922091]}>3
				call RIMObj.Move -145.118179 26.472359 18.922091 1 0 1 1 1 0 1 1
			Face 180
			wait 2
			;jump part
			press space
			wait 5 ${Me.Y}>27
			press -hold w
			wait 5 
			;${Me.Z}<30
			press -release w
			wait 10
		}
		while ${Me.Y}<30
		{
			if ${Math.Distance[${Me.Loc},-145.255798,28.823061,22.496674]}>3
				call RIMObj.Move -145.255798 28.823061 22.496674 1 0 1 1 1 0 1 1
			Face 180
			wait 2
			;jump part
			press space
			wait 5 ${Me.Y}>28
			press -hold w
			wait 5 
			;${Me.Z}<30
			press -release w
			wait 2
		}
		wait 1
	}
	if !${Me.IsCrouching}
		press z
	call RIMObj.Move -145.198410 31.587963 27.682356 1 0 1 1 1 0 1 1
	;wait for group members
	if ${Me.Group}>1 && ${Me.Group[1].Type.Equal[PC]}
	{
		while !${RIMObj.AllGroupWithinRange[3]}
			wait 5
	}
	;echo we are all here
	
	wait 2
	variable int WallID
	WallID:Set[${Actor[Query, Name=="a cracked wall" && IsDead=FALSE && Distance<10].ID}]
	while ${Actor[Query, ID=${WallID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${WallID}
				Actor[Query, ID=${WallID}]:DoTarget
		}
		waitframe
	}
	
	wait 20
	call RIMObj.Move -145.174988 31.587963 36.560928 1 0 1 1 1 0 1 1
	wait 5
	if ${RI_Var_Bool_GlobalOthers}
	{
		while !${BWRDone} || ${Me.InCombat}
			wait 5
	}
	else
	{
		variable index:actor VasesIndex
		variable iterator VasesIterator
		EQ2:QueryActors[VasesIndex, Name=="an obulus vase"]
		;echo ${VasesIndex.Used}
		VasesIndex:GetIterator[VasesIterator]
		variable int VasesIndexCounter
		VasesIndexCounter:Set[1]
		if ${VasesIterator:First(exists)}
		{
			do
			{
				;echo ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}
				if ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}>=21
				{
					;echo removing ${VasesIterator.Value.ID} because its ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}
					VasesIndex:Remove[${VasesIndexCounter}]
				}
				VasesIndexCounter:Inc
			}
			while ${VasesIterator:Next(exists)}
		}
		VasesIndex:Collapse
		;echo ${VasesIndex.Used}
		
		while ${VasesIndex.Used}>0
		{
			;first remove all non existing actors from the index and collapse it
			VasesIndex:GetIterator[VasesIterator]
			
			VasesIndexCounter:Set[1]
			if ${VasesIterator:First(exists)}
			{
				do
				{
					;echo ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}
					if ${VasesIterator.Value.IsDead} || !${VasesIterator.Value(exists)}
					{
						;echo removing ${VasesIterator.Value.ID} because its either gone or dead
						VasesIndex:Remove[${VasesIndexCounter}]
					}
					VasesIndexCounter:Inc
				}
				while ${VasesIterator:Next(exists)}
			}
			VasesIndex:Collapse
			
			;now target the first in the index
			VasesIndex.Get[1]:DoTarget
			
			wait 5
		}
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,-145.171860,31.587963,28.740166]
		wait 50 !${Me.InCombat}
		wait 100 ( ${Me.InCombat} || ${Me.IsHated} )
		while ( ${Me.InCombat} || ${Me.IsHated} )
			wait 10
		relay ${RI_Var_String_RelayGroup} BWRDone:Set[TRUE]
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[OFF]
	}
	
	if ${QuestJournalWindow.ActiveQuest[Kunark Ascending: A Chosen Weapon](exists)}
	{
		call RIMObj.Move -145.174988 31.587963 36.560928 1 0 1 1 1 1 1 1
		call RIMObj.Move -141.244858 26.488461 51.834408 1 0 1 1 1 0 1 1
		wait 20
		call RIMObj.CheckCombat
		relay ${RI_Var_String_RelayGroup} Actor["Caszire the Dark"]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor["Caszire the Dark"]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor["Caszire the Dark"]:DoubleClick
		wait 20
		call RIMObj.CheckCombat
		relay ${RI_Var_String_RelayGroup} Actor[Mirror]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor[Mirror]:DoubleClick
		wait 2
		relay ${RI_Var_String_RelayGroup} Actor[Mirror]:DoubleClick
		wait 20
		call RIMObj.Move -145.153519 26.499077 43.594463 1 0 1 1 1 0 1 1
		;function JumpUp(float _X, float _Y, float _Z, float _YTarget, int _FaceDegree, int _GiveUpCNT=10)
		call JumpUp -145.153519 26.499077 43.594463 27 0
		call RIMObj.Move -145.035965 28.907936 41.006645 1 0 1 1 1 0 1 1
		call JumpUp -145.035965 28.907936 41.006645 30 0
		call RIMObj.Move -145.126526 31.558907 37.396252 1 0 1 1 1 1 1 1
		call RIMObj.Move -145.228027 31.587963 33.517056 1 0 1 1 1 0 1 1
	}
	; call RIMObj.Move -137.719009 30.427376 38.753876 1 0 1 1 1 1 1 1
	; call RIMObj.Move -132.712616 30.469751 54.015369 1 0 1 1 1 1 1 1
	; call RIMObj.Move -136.557693 30.539661 69.682091 1 0 1 1 1 1 1 1
	; call RIMObj.Move -153.262985 30.529211 69.709412 1 0 1 1 1 1 1 1
	; call RIMObj.Move -157.574280 31.407291 54.851101 1 0 1 1 1 1 1 1
	; call RIMObj.Move -153.409042 31.640842 37.751358 1 0 1 1 1 1 1 1
	; call RIMObj.Move -148.499649 32.630344 37.621799 1 0 1 1 1 1 1 1
	; call RIMObj.Move -144.186783 31.492989 37.558567 1 0 1 1 1 1 1 1
	call RIMObj.Move -145.270111 31.587963 26.126577 1 0 1 1 1 1 1 1
	call RIMObj.Move -153.792191 26.492765 16.001835 1 0 1 1 1 1 1 1
	call RIMObj.Move -176.571930 26.471821 19.243248 1 0 1 1 1 0 1 1
	call RIMObj.CheckCombat
	while ${Me.Y}<31
	{
		while ${Me.Y}<28
		{
			if ${Math.Distance[${Me.Loc},-176.571930,26.471821,19.243248]}>3
				call RIMObj.Move -176.571930 26.471821 19.243248 1 0 1 1 1 0 1 1
			Face 180
			wait 2
			;jump part
			press space
			wait 5 ${Me.Y}>27
			press -hold w
			wait 5 
			;${Me.Z}<30
			press -release w
			wait 10
		}
		while ${Me.Y}<30
		{
			if ${Math.Distance[${Me.Loc},-176.042984,28.828899,22.569334]}>3
				call RIMObj.Move -176.042984 28.828899 22.569334 1 0 1 1 1 0 1 1
			Face 180
			wait 2
			;jump part
			press space
			wait 5 ${Me.Y}>28
			press -hold w
			wait 5 
			;${Me.Z}<30
			press -release w
			wait 2
		}
	}
	if !${Me.IsCrouching}
		press z
	call RIMObj.Move -176.492737 31.587963 28.741343 1 0 1 1 1 0 1 1
	;wait for group members
		;wait for group members
	if ${Me.Group}>1 && ${Me.Group[1].Type.Equal[PC]}
	{
		while !${RIMObj.AllGroupWithinRange[3]}
			wait 5
	}
	;echo we are all here
	
	wait 2
	
	WallID:Set[${Actor[Query, Name=="a cracked wall" && IsDead=FALSE && Distance<10].ID}]
	while ${Actor[Query, ID=${WallID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${WallID}
				Actor[Query, ID=${WallID}]:DoTarget
		}
		waitframe
	}
	wait 20
	call RIMObj.Move -176.480270 31.587963 36.729984 1 0 1 1 1 0 1 1
	wait 5
	if ${RI_Var_Bool_GlobalOthers}
	{
		while !${BWLDone} || ${Me.InCombat}
			wait 5
	}
	else
	{
		VasesIndex:Clear

		EQ2:QueryActors[VasesIndex, Name=="an obulus vase"]
		;echo ${VasesIndex.Used}
		VasesIndex:GetIterator[VasesIterator]

		VasesIndexCounter:Set[1]
		if ${VasesIterator:First(exists)}
		{
			do
			{
				;echo ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}
				if ${Math.Distance[${VasesIterator.Value.Loc},-176.332199,26.496981,54.435680]}>=21
				{
					;echo removing ${VasesIterator.Value.ID} because its ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}
					VasesIndex:Remove[${VasesIndexCounter}]
				}
				VasesIndexCounter:Inc
			}
			while ${VasesIterator:Next(exists)}
		}
		VasesIndex:Collapse
		;echo ${VasesIndex.Used}
		
		while ${VasesIndex.Used}>0
		{
			;first remove all non existing actors from the index and collapse it
			VasesIndex:GetIterator[VasesIterator]
			
			VasesIndexCounter:Set[1]
			if ${VasesIterator:First(exists)}
			{
				do
				{
					;echo ${Math.Distance[${VasesIterator.Value.Loc},-144.996704,26.496861,53.632210]}
					if ${VasesIterator.Value.IsDead} || !${VasesIterator.Value(exists)}
					{
						;echo removing ${VasesIterator.Value.ID} because its either gone or dead
						VasesIndex:Remove[${VasesIndexCounter}]
					}
					VasesIndexCounter:Inc
				}
				while ${VasesIterator:Next(exists)}
			}
			VasesIndex:Collapse
			
			;now target the first in the index
			VasesIndex.Get[1]:DoTarget
			
			wait 5
		}
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[ALL,-176.674576,31.587963,28.945089]
		wait 50 !${Me.InCombat}
		wait 100 ( ${Me.InCombat} || ${Me.IsHated} )
		while ( ${Me.InCombat} || ${Me.IsHated} )
			wait 5
		relay ${RI_Var_String_RelayGroup} BWLDone:Set[TRUE]
		relay ${RI_Var_String_RelayGroup} RIMUIObj:SetLockSpot[OFF]
	}
	; call RIMObj.Move -173.128159 30.471457 39.199783 1 0 1 1 1 1 1 1
	; call RIMObj.Move -167.412735 30.632805 38.296242 1 0 1 1 1 1 1 1
	; call RIMObj.Move -163.289764 32.311440 54.203190 1 0 1 1 1 1 1 1
	; call RIMObj.Move -166.744644 31.306763 69.268204 1 0 1 1 1 1 1 1
	; call RIMObj.Move -185.523605 31.176176 69.935356 1 0 1 1 1 1 1 1
	; call RIMObj.Move -188.900085 32.329926 56.012989 1 0 1 1 1 1 1 1
	; call RIMObj.Move -184.613403 31.601589 37.851025 1 0 1 1 1 1 1 1
	; call RIMObj.Move -175.966354 31.587963 37.028351 1 0 1 1 1 1 1 1
	call RIMObj.Move -176.602280 31.587963 26.228256 1 0 1 1 1 1 1 1
	call RIMObj.Move -175.679520 26.475712 18.188866 1 0 1 1 1 0 1 1
	
	if ${Me.IsCrouching}
		press z
	
	ShinyScanDistance:Set[50]
	RI_Var_Bool_Follow:Set[TRUE]
	squelch hud -remove BWRDone
	squelch hud -remove BWLDone
	deletevariable BWRDone
	deletevariable BWLDone
}
; function BaronRightWall()
; {
	; echo ISXRI: Starting Right Wall, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	; ;this script gets all toons into the right room to get mirror, but only if on the quest
	;IncomingText:Clear
	;IncomingText2:Clear
	; IncomingText:Insert[IM DONE]
	; while !${Trigger}
		; wait 2
	; Trigger:Set[FALSE]
	; echo Ending Right Wall
; }
function BaronGetResources()
{
	echo ISXRI: Starting Get Resources, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;this script goes and gets the resources, but only if on the quest
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending Get Resources
}

function BaronHaggleActivator()
{
	echo ISXRI: Starting Haggle Activator, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;this script show haggle the mirror and then hail and go through dialog, but only if on the quest, else just kill
	
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending Haggle Activator
}

function BaronGetBookandCraft()
{
	echo ISXRI: Starting Grab Book and Craft, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;this script will go into the other room grab the book and run back and craft the weapon then move back to teleporter, but only if on the quest
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending Grab Book and Craft
}

;;;;;;;;;;;;;;;; End Crypt of Dalnir: Baron's Workshop [Heroic] ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Start Crypt of Dalnir: Wizard's Den [Event Heroic] ;;;;;;;;;;;;;;;;;;;;;;
function WizardsDenSigCheck1()
{
	CustomLoc:Set[0 0 0]
	RI_Atom_SetLockSpot OFF
	if ${QuestJournalWindow.ActiveQuest[Ghosts and Gooblins](exists)}
	{
		call ToggleWalkRun 1
		call RIMObj.Move 405.418365 -50.445290 -16.195228 1 0 1 1 1 0 1 1
		wait 20
		call ClickActor "Cage Door 1"
		wait 20
		call ToggleWalkRun 1
		call RIMObj.Move 396.187073 -47.662983 -56.322746 1 0 1 1 1 0 1 1
		call ToggleWalkRun 1
		call RIMObj.Move 400.479736 -45.592010 -57.835278 1 0 1 1 1 1 1 1
		call RIMObj.Move 402.696686 -45.314312 -58.115300 1 0 1 1 1 0 1 1
		wait 20
		call ClickActor "Cage Door 2"
		wait 20
		call ToggleWalkRun 1
		call RIMObj.Move 390.497681 -47.229462 -130.442154 1 0 1 1 1 1 1 1
		call RIMObj.Move 427.011505 -46.429970 -147.428574 1 0 1 1 1 0 1 1
		call ToggleWalkRun 1
		call RIMObj.Move 435.081238 -45.326229 -149.611069 1 0 1 1 1 0 1 1
		wait 20
		call ClickActor "Cage Door 4"
		wait 20
		call ToggleWalkRun 1
		call RIMObj.Move 375.328461 -46.766254 -134.036346 1 0 1 1 1 1 1 1
	}
}

function WizardsDenSigCheck2()
{
	CustomLoc:Set[0 0 0]
	if ${QuestJournalWindow.ActiveQuest[Ghosts and Gooblins](exists)}
	{
		call RIMObj.Move 345.072144 -38.727089 -214.231476 1 0 1 1 1 0 1 1
		wait 20
		call RIMObj.Move 343.478241 -38.729622 -217.265320 1 0 1 1 1 0 1 1
		wait 20
		call HailActor Wreek 5
		call RIMObj.Move 349.550568 -38.731476 -163.174728 1 0 1 1 1 1 1 1
		call RIMObj.Move 371.893860 -46.969345 -131.764709 1 0 1 1 1 1 1 1
		call RIMObj.Move 384.455536 -48.833115 -93.887444 1 0 1 1 1 1 1 1
		call RIMObj.Move 388.928284 -48.713097 -61.081169 1 0 1 1 1 1 1 1
		call RIMObj.Move 392.626129 -52.607872 -15.824572 1 0 1 1 1 1 1 1
		call RIMObj.Move 385.840668 -54.144047 -1.462285 1 0 1 1 1 1 1 1
		call RIMObj.Move 360.779266 -53.860722 3.782473 1 0 1 1 1 1 1 1
		call RIMObj.Move 329.591309 -54.586620 -1.278129 1 0 1 1 1 1 1 1
		call RIMObj.Move 302.613251 -52.982571 -4.778679 1 0 1 1 1 1 1 1
		call RIMObj.Move 279.020111 -46.419823 -22.439344 1 0 1 1 1 1 1 1
		call RIMObj.Move 249.563690 -45.372128 -19.639872 1 0 1 1 1 1 1 1
		call RIMObj.Move 251.667923 -45.166569 -11.163614 1 0 1 1 1 0 1 1
		wait 20
		call RIMObj.Move 248.429993 -44.830002 -4.530000 1 0 1 1 1 1 1 1
		call RIMObj.Move 247.872055 -44.784355 -3.562286 1 0 1 1 1 0 1 1
		wait 20
		call RIMObj.Move 78.324219 26.479950 -55.841972 1 0 1 1 1 0 1 1
		wait 20
		call RIMObj.Move 77.871758 26.471060 -60.555004 1 0 1 1 1 0 1 1
		call JumpUp 77.871758 26.471060 -60.555004 27 360 
		;function JumpUp(float _X, float _Y, float _Z, float _YTarget, int _FaceDegree, int _GiveUpCNT=10)
		call RIMObj.Move 78.126015 28.826199 -63.095081 1 0 1 1 1 0 1 1
		call JumpUp 78.126015 28.826199 -63.095081 29 360
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call JumpUp 78.126015 28.826199 -63.095081 29 360"]
		relay ${RI_Var_String_RelayGroup} TimedCommand 20 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 22 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 24 Press ${RI_Var_String_JumpKey}
		call RIMObj.Move 78.232033 31.048355 -65.420967 1 0 1 1 1 1 1 1
		call RIMObj.Move 78.397430 31.587963 -69.462357 1 0 1 1 1 0 1 1
		Actor["a cracked wall"]:DoTarget
		wait 50
		call RIMObj.Move 79.778320 31.587963 -77.451225 1 0 1 1 1 1 1 1
		call RIMObj.Move 68.833588 30.669708 -80.494041 1 0 1 1 1 1 1 1
		call RIMObj.Move 78.009811 31.582218 -77.897171 1 0 1 1 1 1 1 1
		call RIMObj.Move 78.486794 31.587967 -66.593536 1 0 1 1 1 1 1 1
		call RIMObj.Move 77.922188 26.493315 -51.594086 1 0 1 1 1 1 1 1
		call RIMObj.Move 140.638443 26.493362 -49.953506 1 0 1 1 1 0 1 1
		wait 20
		call RIMObj.Move 146.278610 26.779022 -50.040245 1 0 1 1 1 1 1 1
		call RIMObj.Move 259.987274 -45.435520 -32.814690 1 0 1 1 1 1 1 1
		call RIMObj.Move 296.764069 -50.512154 -14.226505 1 0 1 1 1 1 1 1
		call RIMObj.Move 330.622101 -53.892300 -3.625979 1 0 1 1 1 1 1 1
		call RIMObj.Move 367.933228 -53.832020 2.380923 1 0 1 1 1 1 1 1
		call RIMObj.Move 389.365356 -53.973129 -4.171980 1 0 1 1 1 1 1 1
		call RIMObj.Move 395.504608 -50.822731 -34.257175 1 0 1 1 1 1 1 1
		call RIMObj.Move 378.372589 -47.922321 -109.895523 1 0 1 1 1 1 1 1
		call RIMObj.Move 369.708130 -43.562149 -145.827637 1 0 1 1 1 1 1 1
		call RIMObj.Move 348.123413 -38.724445 -169.363342 1 0 1 1 1 1 1 1
		call RIMObj.Move 343.350616 -38.729244 -216.870789 1 0 1 1 1 0 1 1
		wait 20
		call HailActor Wreek 5
		call RIMObj.Move 347.204926 -38.724422 -201.745361 1 0 1 1 1 1 1 1
	}
}
function WizardsDenSigCheck3()
{
	CustomLoc:Set[0 0 0]
	if ${QuestJournalWindow.ActiveQuest[Ghosts and Gooblins](exists)}
	{
		call RIMObj.Move 77.871758 26.471060 -60.555004 1 0 1 1 1 0 1 1
		call JumpUp 77.871758 26.471060 -60.555004 27 360 
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call JumpUp 77.871758 26.471060 -60.555004 27 360 "]
		relay ${RI_Var_String_RelayGroup} TimedCommand 20 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 22 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 24 Press ${RI_Var_String_JumpKey}
		;function JumpUp(float _X, float _Y, float _Z, float _YTarget, int _FaceDegree, int _GiveUpCNT=10)
		call RIMObj.Move 78.126015 28.826199 -63.095081 1 0 1 1 1 0 1 1
		call JumpUp 78.126015 28.826199 -63.095081 29 360
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call JumpUp 78.126015 28.826199 -63.095081 29 360"]
		relay ${RI_Var_String_RelayGroup} TimedCommand 20 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 22 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 24 Press ${RI_Var_String_JumpKey}
		call RIMObj.Move 78.232033 31.048355 -65.420967 1 0 1 1 1 1 1 1
		call RIMObj.Move 78.397430 31.587963 -69.462357 1 0 1 1 1 0 1 1
		Actor["a cracked wall"]:DoTarget
		wait 50
		call RIMObj.Move 79.778320 31.587963 -77.451225 1 0 1 1 1 1 1 1
		call RIMObj.Move 68.833588 30.669708 -80.494041 1 0 1 1 1 1 1 1
		call RIMObj.Move 73.796402 26.483061 -95.183884 1 0 1 1 1 0 1 1
		wait 20
		call HailActor Wreek 5
		call RIMObj.Move 77.992607 26.496368 -84.157974 1 0 1 1 1 0 1 1
		call JumpUp 77.992607 26.496368 -84.157974 27 180
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call JumpUp 77.992607 26.496368 -84.157974 27 180"]
		call RIMObj.Move 77.992126 28.902409 -81.510399 1 0 1 1 1 0 1 1
		call JumpUp 77.992126 28.902409 -81.510399 29 180
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call JumpUp 77.992126 28.902409 -81.510399 29 180"]
		relay ${RI_Var_String_RelayGroup} TimedCommand 20 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 22 Press ${RI_Var_String_JumpKey}
		relay ${RI_Var_String_RelayGroup} TimedCommand 24 Press ${RI_Var_String_JumpKey}
		call RIMObj.Move 77.989189 30.592825 -79.153793 1 0 1 1 1 1 1 1
		call RIMObj.Move 77.989189 31.587875 -77.815720 1 0 1 1 1 1 1 1
		call RIMObj.Move 77.998444 31.587963 -66.562157 1 0 1 1 1 0 1 1
	}
}
function Nazkra()
{
; Custom
; Target Nazkra
; 357.543213 -38.445255 -190.009628
; Custom
; WaitForMob Nazkra 9 0 1
; 357.543213 -38.445255 -190.009628
; Wait
; 50
; 357.543213 -38.445255 -190.009628
	declare NazkraID int ${Actor[Query, Name=-"Nazkra"].ID}
	echo ISXRI: Starting Nazkra 
	if ${Zone.Name.Find["[Advanced Solo]"](exists)}
	{
		;move to position
		RI_Atom_SetLockSpot ALL 352.365875 -38.576962 -239.860672
		wait 20
		Actor[${NazkraID}]:DoTarget
		while ${Actor[Query, ID=${NazkraID} && IsDead=FALSE](exists)} && ${Actor[Query, ID=${NazkraID} && IsDead=FALSE].Distance}>9
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Actor[Query, Name=-"vicar" && Distance<=20 && IsDead=FALSE](exists)}
				{
					if ${Target.ID}!=${Actor[Query, Name=-"vicar" && Distance<=20 && IsDead=FALSE].ID}
						Actor[Query, Name=-"vicar" && Distance<=20 && IsDead=FALSE]:DoTarget
				}
				else
				{
					if ${Target.ID}!=${NazkraID}
						Actor[${NazkraID}]:DoTarget
				}
			}
			wait 2
		}
	}
	else
	{
		;turn off assisting
		RI_CMD_Assisting 0
		;turn on Singular Focus 4026518400  or if guardian Focused Offensive 1432018334
		if ${Me.SubClass.Equal[guardian]} && ${Me.Ability[id,1432018334].IsReady}
		{
			while !${Me.Maintained[Focused Offensive](exists)}
			{
				while ${Me.Ability[id,1432018334].IsReady}
				{
					Me.Ability[id,1432018334]:Use
					wait 5 ${Me.Maintained[Focused Offensive](exists)}
				}
				wait 5 ${Me.Maintained[Focused Offensive](exists)}
			}
		}
		elseif ${Me.Ability[id,4026518400].IsReady}
		{
			while !${Me.Maintained[Singular Focus](exists)}
			{
				while ${Me.Ability[id,4026518400].IsReady}
				{
					Me.Ability[id,4026518400]:Use
					wait 5 ${Me.Maintained[Singular Focus](exists)}
				}
				wait 5 ${Me.Maintained[Singular Focus](exists)}
			}
		}

		wait 10
		
		;turn off ae's in CB
		;if ${Me.Archetype.NotEqual[fighter]}
		;{
			RI_Obj_CB:DoNotCastEncounter[TRUE]
			RI_Obj_CB:DoNotCastAE[TRUE]
		;}
		Actor[${NazkraID}]:DoTarget
		
		;move to position
		RI_Atom_SetLockSpot ALL 357.946594 -38.758297 -190.028015 
		wait 50
		while ${Actor[Query, ID=${NazkraID} && IsDead=FALSE](exists)} && ${Actor[Query, ID=${NazkraID} && IsDead=FALSE].Distance}>9
		{
			;if !${RI_Var_Bool_GlobalOthers}
			;{
				if ${Actor[Query, Name=-"vicar" && Distance<=30 && IsDead=FALSE](exists)}
				{
					if ${Target.ID}!=${Actor[Query, Name=-"vicar" && Distance<=30 && IsDead=FALSE].ID}
						Actor[Query, Name=-"vicar" && Distance<=30 && IsDead=FALSE]:DoTarget
				}
				elseif ${Actor[Query, Name=-"centurion" && Distance<=30 && IsDead=FALSE && Target.ID!=${Me.ID}](exists)} && !${RI_Var_Bool_GlobalOthers}
				{
					if ${Target.ID}!=${Actor[Query, Name=-"centurion" && Distance<=30 && IsDead=FALSE && Target.ID!=${Me.ID}].ID}
						Actor[Query, Name=-"centurion" && Distance<=30 && IsDead=FALSE && Target.ID!=${Me.ID}]:DoTarget
				}
				else
				{
					if ${Target.ID}!=${NazkraID}
						Actor[${NazkraID}]:DoTarget
				}
			;}
			wait 2
		}
		wait 20
		
		if ${RI_Var_Bool_GlobalOthers}
			RI_Atom_SetLockSpot ALL 357.946594 -38.758297 -200.028015 
		else
			RI_Atom_SetLockSpot ALL 349.821960 -38.730247 -195.833969
		while ${Actor[Query, ID=${NazkraID} && IsDead=FALSE](exists)}
		{
			;if !${RI_Var_Bool_GlobalOthers}
			;{
				if ${Actor[Query, Name=-"vicar" && Distance<=30 && IsDead=FALSE](exists)}
				{
					if ${Target.ID}!=${Actor[Query, Name=-"vicar" && Distance<=30 && IsDead=FALSE].ID}
						Actor[Query, Name=-"vicar" && Distance<=30 && IsDead=FALSE]:DoTarget
				}
				elseif ${Actor[Query, Name=-"centurion" && Distance<=30 && IsDead=FALSE && Target.ID!=${Me.ID}](exists)} && !${RI_Var_Bool_GlobalOthers}
				{
					if ${Target.ID}!=${Actor[Query, Name=-"centurion" && Distance<=30 && IsDead=FALSE && Target.ID!=${Me.ID}].ID}
						Actor[Query, Name=-"centurion" && Distance<=30 && IsDead=FALSE && Target.ID!=${Me.ID}]:DoTarget
				}
				else
				{
					if ${Target.ID}!=${NazkraID}
						Actor[${NazkraID}]:DoTarget
				}
			;}
			wait 2
		}
		;turn on assisting
		RI_CMD_Assisting 1
		
		;turn on ae's in CB
		RI_Obj_CB:DoNotCastEncounter[FALSE]
		RI_Obj_CB:DoNotCastAE[FALSE]
		
		if ${Me.SubClass.Equal[guardian]}
			Me.Maintained[Focused Offensive]:Cancel
		else
			Me.Maintained[Singular Focus]:Cancel
			
		wait 10
	}
	echo Ending Nazkra
}
function WizardsDenShinyHunt1()
{
	return
	; SpecialShiny:Set[TRUE]
	; 351.922852 -38.728672 -209.882217
	; 349.468994 -38.728992 -219.808487
	; 347.821747 -38.723907 -229.809692
	; 346.519562 -38.560799 -240.055252
	; 345.550842 -38.725292 -250.121704
	; 347.149567 -38.725346 -260.182556
	; 349.280182 -38.725346 -270.154144
	; 341.903992 -38.725346 -277.075409
	; 332.650269 -38.725346 -272.818268
	; 324.930603 -38.729382 -266.188904
	; 315.458191 -38.728542 -261.927521
	; 305.201355 -38.730652 -261.379211
	; 295.356628 -38.723869 -263.322906
	; 287.221588 -38.725346 -269.516937
	; 278.891449 -38.725346 -275.267700
	; 268.642334 -38.725346 -273.935425
	; 259.682587 -38.736847 -269.200104
	; 250.887314 -38.727840 -264.441467
	; 241.207458 -38.731339 -261.527649
	; 231.128860 -38.725922 -259.907074
	; 223.490326 -38.725346 -266.388367
	; 213.345795 -38.725346 -267.837799
	; 204.459137 -38.725349 -262.966766
	; 199.887711 -38.725346 -253.936111
	; 207.527649 -38.725346 -247.044022
	; 217.371582 -38.725346 -249.442856
	; 225.441116 -38.725346 -255.528778
	; 233.728333 -38.724895 -261.345032
	; 243.749298 -38.555614 -263.681702
	; 254.002884 -38.724598 -262.936646
	; 264.341675 -38.725346 -262.844086
	; 274.582031 -38.725346 -262.609802
	; 284.619873 -38.725346 -262.393494
	; 294.642120 -38.727383 -262.499298
	; 304.645294 -38.725277 -262.747375
	; 314.943390 -38.724361 -263.261719
	; 325.151276 -38.725571 -264.474274
	; 334.713593 -38.725346 -268.129883
	; 344.660614 -38.725346 -266.012665
	; 349.908264 -38.725632 -257.335449
	; 350.249542 -38.732006 -247.258759
	; 350.078613 -38.733665 -237.220657
	; 350.242584 -38.731750 -227.215622
	; 350.238953 -38.726738 -217.125305
	; 349.969269 -38.726086 -207.020920
	; SpecialShiny:Set[FALSE]
}
function WizardsDenShinyHunt2()
{
	return
	; SpecialShiny:Set[TRUE]
	
; 518.995056 -59.215076 68.350739
; 509.187622 -59.217205 65.879791
; 499.186340 -59.218754 64.651016
; 492.748993 -59.216049 72.338463
; 492.426849 -59.216454 82.504105
; 491.249176 -59.224277 92.620132
; 489.934113 -59.231094 102.556747
; 489.417267 -59.239655 112.664330
; 489.035858 -59.217377 122.765076
; 488.654449 -58.645226 132.865829
; 488.276855 -56.375469 142.865097
; 488.129089 -56.375702 153.025681
; 490.798370 -53.877270 162.368652
; 492.915222 -52.737579 172.225830
; 493.993774 -52.722889 182.429291
; 494.446960 -52.722408 192.482803
; 494.405182 -52.724064 202.556885
; 494.493988 -52.723282 212.643387
; 502.323273 -52.725826 219.392944
; 512.382019 -52.724632 218.299149
; 522.687561 -52.700672 217.976608
; 532.876770 -52.583160 217.714890
; 543.116943 -52.737518 217.451950
; 552.882935 -50.376930 217.201126
; 563.106140 -49.534718 216.938583
; 573.261597 -48.991333 216.677811
; 583.163147 -46.289463 216.423553
; 593.352356 -46.112881 216.161850
; 603.457092 -46.258362 215.902344
; 613.629639 -46.274933 215.641113
; 623.869690 -46.270802 215.378159
; 633.906738 -46.270855 215.120361
; 643.926636 -46.270939 214.863052
; 654.032166 -46.272484 214.659180
; 664.036499 -46.277706 214.864151
; 674.260498 -46.264233 215.102554
; 684.382874 -46.290379 215.338593
; 694.521973 -46.289463 215.574997
; 704.339539 -49.313522 215.803955
; 714.444946 -49.535843 216.039597
; 724.397827 -50.576248 216.271805
; 734.332825 -52.740669 216.542801
; 744.556641 -52.580280 216.741959
; 754.697144 -52.697170 216.624237
; 764.729980 -52.716297 216.987686
; 774.807739 -52.722870 216.575516
; 784.729492 -52.726368 216.414276
; 784.387878 -52.725941 206.414383
; 784.043701 -52.729988 196.340576
; 783.699341 -52.726604 186.258881
; 783.354919 -52.742527 176.175690
; 783.013062 -52.741913 166.175323
; 782.686279 -56.289383 156.614899
; 782.338745 -56.367737 146.445313
; 781.997559 -57.463676 136.461838
; 781.654114 -59.212368 126.410660
; 781.118469 -59.047813 116.200287
; 780.957886 -59.216454 106.092773
; 781.557739 -59.214317 96.104393
; 782.174744 -59.214565 85.981316
; 782.093628 -59.213680 75.757507
; 776.340027 -59.215305 67.346115
; 766.425964 -59.218483 65.284798
; 756.210327 -59.222763 65.743629
; 745.921509 -59.225235 66.422256
; 735.738159 -59.221638 67.152763
; 725.453430 -59.045368 67.890556
; 715.270081 -59.196159 68.621063
; 705.472351 -59.198841 71.426353
; 701.672424 -59.227306 80.829155
; 700.769287 -59.213535 90.877953
; 699.869873 -59.187313 100.894783
; 698.862549 -59.207531 110.968887
; 697.081909 -59.210377 120.981133
; 693.376404 -57.794491 130.382629
; 687.888367 -54.299633 138.261032
; 681.013489 -51.163147 144.835602
; 672.990784 -47.670475 149.832138
; 663.202209 -46.295914 152.592133
; 653.072693 -46.305714 154.035446
; 642.824524 -46.306347 154.237793
; 632.813660 -46.306290 153.731934
; 622.650574 -46.305653 153.218384
; 612.584717 -46.295868 152.544281
; 602.944092 -47.847122 149.784134
; 594.618103 -51.448761 144.945541
; 585.259583 -54.272930 142.430359
; 577.653809 -57.608715 136.820724
; 575.680237 -58.707428 126.806313
; 575.689697 -59.228016 116.579948
; 575.678711 -59.182770 106.573601
; 575.742798 -59.209637 96.347603
; 577.599365 -59.218494 86.269913
; 585.242249 -59.214882 79.571754
; 595.049805 -59.197170 77.220459
; 605.077087 -59.118927 78.289856
; 614.872192 -59.037266 81.276878
; 618.698730 -58.890812 90.539948
; 620.000244 -58.300869 100.620255
; 619.596008 -57.451672 108.819618
; 621.463745 -59.206203 98.929077
; 625.054199 -58.902714 89.447517
; 633.974548 -58.956150 84.530807
; 644.194519 -58.952744 84.841988
; 653.772705 -58.919590 87.888588
; 659.773743 -59.379204 95.977219
; 657.415588 -57.532619 105.671051
; 656.477905 -57.447906 108.947052
; 657.059509 -59.012569 99.067406
; 657.027283 -58.909008 88.863800
; 656.667725 -59.018265 78.796165
; 656.374756 -59.139217 68.607811
; 656.207947 -59.014725 58.552425
; 656.224060 -58.905212 48.461407
; 656.240784 -58.884075 38.184151
; 656.256409 -57.472633 29.362982
; 655.602600 -59.623020 39.171227
; 650.023804 -58.896282 47.629082
; 640.608337 -58.934402 51.127838
; 630.301636 -58.937508 51.430382
; 621.712708 -58.881191 46.246609
; 619.254517 -57.817863 36.387157
; 619.987854 -57.458462 28.803160
; 618.872192 -59.410690 38.860699
; 616.109802 -58.929523 48.717464
; 608.572021 -59.094391 55.532673
; 599.425354 -59.159851 59.744305
; 589.153198 -59.212921 59.791107
; 579.802734 -59.221966 56.167366
; 574.338013 -59.218475 47.693489
; 572.592407 -59.193104 37.483456
; 573.223511 -59.193985 27.336035
; 575.180908 -59.196190 17.353924
; 579.375916 -58.132309 8.163203
; 585.751221 -55.458309 0.486182
; 592.777283 -52.285122 -6.018360
; 600.354736 -48.793468 -11.815230
; 609.546326 -46.296127 -15.296391
; 619.639893 -46.305462 -16.941912
; 629.752563 -46.306107 -18.318483
; 639.830872 -46.306526 -18.763004
; 650.036377 -46.305912 -18.494934
; 660.073059 -46.303047 -16.828587
; 669.657898 -46.595642 -13.529822
; 678.211426 -49.848034 -9.270086
; 685.729858 -53.117016 -3.391882

	; SpecialShiny:Set[FALSE]
}
function WizardsDenChasm()
{
	echo ISXRI: Starting Chasm, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;do this if the Quest Ghosts and Gooblins exists
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending Chasm
}
function WizardsDenCrypt()
{
	echo ISXRI: Starting Crypt, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;do this if the Quest Ghosts and Gooblins exists
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending Crypt
}
function WizardsDenMutationHall()
{
	echo ISXRI: Starting MutationHall, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;do this if the Quest Ghosts and Gooblins exists
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending MutationHall
}
function WizardsDenMutationHallEND()
{
	;on this one evac and then go talk to wreek if quest exists otherwise just evac
	wait 20
	call Evac TRUE
	echo ISXRI: Starting MutationHallEND, This has not been coded yet, for now do this manually then return to this position and say IM DONE and RI will continue
	;do this if the Quest Ghosts and Gooblins exists
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert[IM DONE]
	while !${Trigger}
		wait 2
	Trigger:Set[FALSE]
	echo Ending MutationHallEND
}

;;;;;;;;;;;;;;;; End Crypt of Dalnir: Wizard's Den [Event Heroic] ;;;;;;;;;;;;;;;;;;;;;;
	
;;;;;;;;;;;;;;;; Start Frillik Tide ;;;;;;;;;;;;;;;;;;;;;;

variable bool CaptainDoneTrigger=FALSE
variable bool RatTrigger=FALSE
variable int ScriptStartTime
variable bool NoFire=TRUE
variable int GoodSlaver
variable(global) bool NotPastFirstSlaver=FALSE
variable int ropecount=0



function Frillik(bool caughtstart=FALSE, bool Fire=FALSE)
{
	if !${Me.Inventory["Totem of the Deadly Sabertooth"](exists)} && ${Me.Speed}<75
	{
		echo ISXRI: Frillik Tide script requires Totem of the Deadly Sabertooth, please get and rerun
		Script:End
	}
	wait 20
	;pause bots
	RI_CMD_PauseCombatBots 1
	ScriptStartTime:Set[${Time.SecondsSinceMidnight}]
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncementFrillik]
	if ${Fire}
	{
		NoFire:Set[FALSE]
	}
	else
		Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingTextFrillik]
	press x
	if !${caughtstart}
	{
		;target slave and hail him and go through his dialog
		Actor[iksar slave]:DoTarget
		Actor[iksar slave]:DoFace
		wait 3
		eq2ex hail
		wait 3
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 3
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 3
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 3
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		call RIMObj.Move 4.199240 13.058523 65.906937 1 0 TRUE FALSE TRUE FALSE TRUE
		
		while !${CaptainDoneTrigger}
			waitframe
		; while !${Actor[Query, Name="Captain Zythox" && X=4.220000 && Y=12.823201 && Z=62.090000](exists)}
		; {
			; waitframe
			;;echo ${Time}: waiting for captain to be in position
		; }
		; while ${Actor[Query, Name="Captain Zythox" && X=4.220000 && Y=12.823201 && Z=62.090000](exists)}
		; {
			; waitframe
			;;echo ${Time}: waiting for captain to be out of position aka done talking
		; }
		
		call RIMObj.Move -0.356917 12.978796 71.040215 1 0 TRUE FALSE TRUE FALSE TRUE
		;waitfor rat
		while !${RatTrigger}
			waitframe
		; while !${Actor[Query, Name="a hungry bilge rat" && X=-1.370000 && ( Y=12.978795 || Y=12.978796 ) && Z=70.919998](exists)}
		; {
			; waitframe
			;;echo ${Time}: waiting for Killten to be in position 1
		; }
		;;waitfor slave
		; while !${Actor[Query, Name="iksar slave" && X=-2.390000 && Y=12.978795 && Z=71.940002](exists)}
		; {
			; waitframe
			;;echo ${Time}: waiting for slave to be in position by rat
		; }
		wait 20
		;hail slave
		Actor[iksar slave]:DoTarget
		Actor[iksar slave]:DoFace
		wait 3
		eq2ex hail
		wait 3
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4	
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		;hail Killten
		Actor[Killten]:DoTarget
		Actor[Killten]:DoFace
		wait 3
		;hail Killten
		Actor[Killten]:DoTarget
		Actor[Killten]:DoFace
		eq2ex hail
		wait 3
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 4
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		if ${Me.Speed}<75
		{
			if ${Me.Inventory["Totem of the Deadly Sabertooth"].AutoConsumeOn}
				Me.Inventory["Totem of the Deadly Sabertooth"]:ToggleAutoConsume
			wait 5
			if !${Me.Maintained["Totem of the Deadly Sabertooth"](exists)}
				Me.Inventory["Totem of the Deadly Sabertooth"]:Use
			wait 5 ${Me.CastingSpell}
			wait 50 !${Me.CastingSpell}
		}
		; if !${Me.Maintained["Mystic Moppet Disguise"](exists)}
			; Me.Inventory["Mystic Moppet Billy"]:Use
		; wait 5 ${Me.CastingSpell}
		; wait 50 !${Me.CastingSpell}
		call RIMObj.Move -0.361686 12.978795 69.112900 1 0 TRUE FALSE TRUE FALSE TRUE
		while !${Actor[Query, Name="Killten" && X=-1.180000 && Y=12.978796 && Z=67.480003](exists)}
		{
			waitframe
			;echo ${Time}: waiting for Killten to be in position 2
		}
		
		;hail Killten
		Actor[Killten]:DoTarget
		wait 3
		eq2ex hail
		wait 10 (${Actor["Keys"](exists)} && ${Actor["Keys"].HighlightOnMouseHover})
		Actor["Keys"]:DoubleClick
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
	}
	
	call RIMObj.Move -4.229080 13.075517 65.861664 1 0 TRUE FALSE TRUE FALSE TRUE
	
	;wait until the a slaver thats within 20 that is not at loc, 1.760000,12.823201,58.520000 and -1.940000,12.823201,58.520000 is at either -7.900000,12.775447,53.450001 or 8.140000,12.775640,53.459999
	variable int BadSlaver1
	variable int BadSlaver2
	
	BadSlaver1:Set[${Actor[Query, X=1.760000 && Y=12.823201 && Z=58.520000].ID}]
	BadSlaver2:Set[${Actor[Query, X=-1.940000 && Y=12.823201 && Z=58.520000].ID}]
	GoodSlaver:Set[${Actor[Query, Type =="NoKill NPC" && Name =="a slaver" && Distance <= 20 && ID != ${BadSlaver1} && ID != ${BadSlaver2}].ID}]
	variable string WaitLoc
	;Actor[Query, Type =="NoKill NPC" && Name =="a slaver" && Distance <= 20 && ID != ${BadSlaver1} && ID != ${BadSlaver2}]
	; while ${Math.Distance[${Actor[${GoodSlaver}].Loc},-7.900000,12.775447,53.450001]}<1 || ${Math.Distance[${Actor[${GoodSlaver}].Loc},8.140000,12.775640,53.459999]}<1
	; {
		; waitframe
		; echo ${Time}: waiting while she is not moving
	; }
    ; while ${Math.Distance[${Actor[${GoodSlaver}].Loc},-7.900000,12.775447,53.450001]}>1 && ${Math.Distance[${Actor[${GoodSlaver}].Loc},8.140000,12.775640,53.459999]}>1
	; {
		; waitframe
		; echo ${Time}: Waiting till she is in loc
	; }
	;ok now move to the pick
	while ${Actor[${GoodSlaver}].Distance}<10
		waitframe
	NotPastFirstSlaver:Set[TRUE]
	;crouch
	if !${Me.IsCrouching}
		press ${RI_Var_String_CrouchKey}
	;click door
	Actor["Jail Door 2"]:DoubleClick
	wait 10
	call RIMObj.Move -4.329436 12.823201 62.133392 1 0 TRUE FALSE TRUE FALSE TRUE
	Actor["Jail Door 2"]:DoubleClick
	if !${caughtstart}
	{
		call RIMObj.Move -15.784875 13.046762 61.256355 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -15.737808 12.801471 54.083921 1 0 TRUE FALSE TRUE FALSE TRUE
		;click pick
		while ${Actor["Hook 1"].HighlightOnMouseHover}
		{
			Actor["Hook 1"]:DoubleClick
			wait 2
		}
		NotPastFirstSlaver:Set[TRUE]
		;now wait for her to start moving if she isnt then wait to be stopped again, if she is more than 10 away
		if ${Actor[${GoodSlaver}].Distance}>10
		{
			while ${Math.Distance[${Actor[${GoodSlaver}].Loc},-7.900000,12.775447,53.450001]}<1 || ${Math.Distance[${Actor[${GoodSlaver}].Loc},8.140000,12.775640,53.459999]}<1
			{
				waitframe
				;echo ${Time}: waiting while she is not moving
			}
			while ${Math.Distance[${Actor[${GoodSlaver}].Loc},-7.900000,12.775447,53.450001]}>1 && ${Math.Distance[${Actor[${GoodSlaver}].Loc},8.140000,12.775640,53.459999]}>1
			{
				waitframe
				;echo ${Time}: waiting while she is moving
			}
		}
		else
		{
			;wait while she is closer than 15
			while ${Actor[${GoodSlaver}].Distance}<=10
			{
				waitframe
				;echo ${Time}: Waiting while she is closer than 10
			}
		}
		call RIMObj.Move -14.784875 13.046762 61.256355 1 0 TRUE FALSE TRUE TRUE TRUE
	}
	call RIMObj.Move 15.784875 13.046762 61.256355 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 14.784875 13.046762 55.256355 1 0 TRUE FALSE TRUE FALSE TRUE
	;wait while she is closer than 10
	while ${Actor[${GoodSlaver}].Distance}<=8
	{
		waitframe
		;echo ${Time}: Waiting while she is closer than 8
	}
	NotPastFirstSlaver:Set[FALSE]
	RI_Var_Bool_PauseMovement:Set[FALSE]
	call RIMObj.Move 14.322284 12.728871 51.427574 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 13.239384 13.657516 53.919724 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 12.179470 16.077772 61.031151 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 3.072405 20.715483 62.643726 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 3.031507 21.914351 69.082947 1 0 TRUE FALSE TRUE TRUE TRUE
	;;here
	if !${caughtstart}
	{
		call RIMObj.Move -5.369265 21.715471 68.350357 1 0 TRUE FALSE TRUE FALSE TRUE
		wait 2
		while ${Actor["Coiled Rope 1"].HighlightOnMouseHover}
		{
			Actor["Coiled Rope 1"]:DoubleClick
			wait 2
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
		call RIMObj.Move 5.967175 23.853840 76.227226 1 0 TRUE FALSE TRUE FALSE TRUE
		Me.Inventory["a pick"]:Examine
		wait 20 ${ReplyDialog(exists)}
		if ${ReplyDialog(exists)}
			ReplyDialog:Choose[1]
	}
	;tohere
	call RIMObj.Move 5.967175 23.853840 76.227226 1 0 TRUE FALSE TRUE FALSE TRUE
	call RIMObj.Move 3.527576 24.891460 81.401016 1 0 TRUE FALSE TRUE FALSE TRUE
	wait 1
	while ${Actor["Grappling Hook Loc 1"].HighlightOnMouseHover}
	{
		Actor["Grappling Hook Loc 1"]:DoubleClick
		wait 2
	}
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 10 ${Actor["Rope Lead 1"](exists)}
	Actor["Rope Lead 1"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	Actor["Hook 2"]:DoubleClick
	while ${Actor["Hook 2"].HighlightOnMouseHover}
	{
		Actor["Hook 2"]:DoubleClick
		wait 2
	}
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	if !${Me.IsCrouching}
		press ${RI_Var_String_CrouchKey}
	call RIMObj.Move 0.515797 30.161861 72.118927 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 0.563775 23.810001 47.881618 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 0.024945 19.774984 31.972771 1 0 TRUE FALSE TRUE FALSE TRUE
	variable int SlaverID
	SlaverID:Set[${Actor[Query,Name=="a slaver" && Y>20.806990].ID}]
	;wait for the slaver to be more than 7 away
	while ${Actor[${SlaverID}].Distance}<=9
;	|| ${Math.Distance[${Actor[${SlaverID}].Loc},-17.423025 21.378036 20.832853]}<20 || ( ${Actor[${SlaverID}].Heading}>90 && ${Actor[${SlaverID}].Heading}<175 )
	{
		waitframe
		;echo ${Time}: waiting for slaver to be more than 7 away, and be more than 20 away from the right side or not be heading in that direction
	}
	press ${RI_Var_String_JumpKey}
	wait 5 ${Me.Y}>21
	press -hold ${RI_Var_String_ForwardKey}
	wait 20 ${Me.Z}<30
	press -release ${RI_Var_String_ForwardKey}
	
	;if her x is less than 0 she is on the right side, greater than 0 she is on the left side
	;90-145 facing right
	;235-320 facing right
	variable bool RightSide
	if ${Actor[${SlaverID}].X}<0
		RightSide:Set[FALSE]
	else
		RightSide:Set[TRUE]
	
	;right side
	if ${RightSide}
	{
		call RIMObj.Move 0.016925 21.482214 25.802683 1 0 TRUE FALSE TRUE FALSE TRUE
		call RIMObj.Move -20.404013 21.286058 25.802683 1 0 TRUE FALSE TRUE FALSE TRUE
		call RIMObj.Move -20.002357 21.285793 14.430608 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -19.373775 17.781965 7.233285 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -19.025507 15.425480 0.922158 1 0 TRUE FALSE TRUE TRUE TRUE
		;crouch
		if !${Me.IsCrouching}
			press ${RI_Var_String_CrouchKey}
		call RIMObj.Move -7.268117 11.841710 3.067219 1 0 TRUE FALSE TRUE FALSE TRUE
		wait 50 
		;uncrouch
		if ${Me.IsCrouching}
			press ${RI_Var_String_CrouchKey}
		call RIMObj.Move -4.142550 11.861944 0.408315 1 0 TRUE FALSE TRUE FALSE TRUE
	}
	else
	{
		;left side
		call RIMObj.Move 0.016925 21.482214 25.802683 1 0 TRUE FALSE TRUE FALSE TRUE
		call RIMObj.Move 20.529879 21.140528 25.802683 1 0 TRUE FALSE TRUE FALSE TRUE
		call RIMObj.Move 19.963270 21.313950 14.258084 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move 20.006660 17.782124 8.088594 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move 18.787842 15.304472 1.495919 1 0 TRUE FALSE TRUE TRUE TRUE
		;crouch
		if !${Me.IsCrouching}
			press ${RI_Var_String_CrouchKey}
		call RIMObj.Move 7.900301 11.841710 3.569994 1 0 TRUE FALSE TRUE FALSE TRUE
		wait 50
		;uncrouch
		if ${Me.IsCrouching}
			press ${RI_Var_String_CrouchKey}
		call RIMObj.Move 5.194847 11.850047 0.472899 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -1.345220 11.863390 0.294330 1 0 TRUE FALSE TRUE FALSE TRUE
	}
	if ${NoFire}
	{
		wait 5
		while ${Actor["Empty Crate 1"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Get in the crate"]}
		{
			Actor["Empty Crate 1"]:DoubleClick
			wait 2
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
		call RIMObj.Move 0.851901 11.005648 1.946329 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -11.219849 12.749181 16.340488 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -13.417069 12.749181 20.641178 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move -13.897795 12.749181 26.209665 1 0 TRUE FALSE TRUE TRUE TRUE
		Me.Maintained[Crate Disguise]:Cancel
		call RIMObj.Move 3.109101 12.713674 26.397009 1 0 TRUE FALSE TRUE FALSE TRUE
		call RIMObj.Move 3.109101 12.713674 26.397009 1 0 TRUE FALSE TRUE FALSE TRUE
		wait 5 !${Me.IsMoving}
		wait 2
		while ${Actor["Brew Barrel Strike 1"].HighlightOnMouseHover}
		{
			Actor["Brew Barrel Strike 1"]:DoubleClick
			wait 2
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
		;call RIMObj.Move 4.960749 12.713675 26.364101 1 0 TRUE FALSE TRUE FALSE TRUE
		;wait 5 !${Me.IsMoving}
		wait 20 ${Actor["Brewery Lantern 1"].HighlightOnMouseHover}
		while ${Actor["Brewery Lantern 1"].HighlightOnMouseHover}
		{
			Actor["Brewery Lantern 1"]:DoubleClick
			wait 2
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
		call RIMObj.Move -13.848736 12.749181 26.095110 1 0 TRUE FALSE TRUE FALSE TRUE
		wait 5 !${Me.IsMoving}
		wait 2
		while ${Actor["Empty Crate 1"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Get in the crate"]}
		{
			Actor["Empty Crate 1"]:DoubleClick
			wait 2
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
		;wait 100
		call RIMObj.Move -11.250031 12.749182 15.083492 1 0 TRUE FALSE TRUE TRUE TRUE
		call RIMObj.Move 0.027929 12.089749 5.387205 1 0 TRUE FALSE TRUE TRUE TRUE
	}
	
	call RIMObj.Move -4.642479 12.232176 -26.550085 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move -0.357533 12.170499 -41.523327 1 0 TRUE FALSE TRUE FALSE TRUE
	if !${Me.IsCrouching}
		press ${RI_Var_String_CrouchKey}
	;set movebehind a slaver
	variable int HeadSlaverID
	HeadSlaverID:Set[${Actor["a slaver"].ID}]
	
	while !${Me.GetGameData[Spells.Casting].Label.Equal["Take head gear"]}
	{
		while ${Math.Distance[${Actor[${HeadSlaverID}].Loc},8.070000,12.108114,-46.770000]}>3 && ${Math.Distance[${Actor[${HeadSlaverID}].Loc},-7.410000,12.108114,-53.660000]}>3 && ${Math.Distance[${Actor[${HeadSlaverID}].Loc},-5.390000,12.108114,-64.260002]}>3 && ${Math.Distance[${Actor[${HeadSlaverID}].Loc},4.640000,12.108114,-64.790001]}>3
		{
			waitframe
			;echo ${Time}: waiting while the slaver is not in position
		}
		;he's at SW
		if ${Math.Distance[${Actor[${HeadSlaverID}].Loc},8.070000,12.108114,-46.770000]}<3
		{
			call RIMObj.Move 7.070000 12.108114 -46.770000 1 0 TRUE FALSE TRUE FALSE TRUE
		}
		;he's at SE
		if ${Math.Distance[${Actor[${HeadSlaverID}].Loc},-7.410000,12.108114,-53.660000]}<3
		{
			call RIMObj.Move -7.410000 12.108114 -51.660000 1 0 TRUE FALSE TRUE FALSE TRUE
		}
		;he's at NE
		if ${Math.Distance[${Actor[${HeadSlaverID}].Loc},-5.390000,12.108114,-64.260002]}<3
		{
			call RIMObj.Move -5.390000 12.108114 -62.260002 1 0 TRUE FALSE TRUE FALSE TRUE
		}
		;he's at NW
		if ${Math.Distance[${Actor[${HeadSlaverID}].Loc},-5.390000,12.108114,-64.260002]}<3
		{
			call RIMObj.Move 6.070000 12.108114 -46.770000 1 0 TRUE FALSE TRUE FALSE TRUE
			call RIMObj.Move -5.390000 12.108114 -62.260002 1 0 TRUE FALSE TRUE FALSE TRUE
		}
		; while ${Actor[${HeadSlaverID}].Distance}>5 || ${Actor[${HeadSlaverID}].IsMoving}
		; {
			; waitframe
			; echo ${Time}: waiting until we are closer than 5
		; }
		while !${Me.GetGameData[Spells.Casting].Label.Equal["Knock out the slaver"]}
		{	
			if ${Actor[${HeadSlaverID}].Distance}<10 && !${Me.GetGameData[Spells.Casting].Label.Equal["Knock out the slaver"]}
				eq2ex apply_verb ${HeadSlaverID} "Knock out the slaver"
			wait 5 ${Me.GetGameData[Spells.Casting].Label.Equal["Knock out the slaver"]}
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
		wait 50 ( ${Actor["Player Head Gear"](exists)} && ${Actor["Player Head Gear"].HighlightOnMouseHover} )
		call RIMObj.Move ${Actor["Player Head Gear"].X} ${Actor["Player Head Gear"].Y} ${Actor["Player Head Gear"].Z} 2 0 TRUE FALSE TRUE FALSE TRUE
		wait 50 ${Actor["Player Head Gear"].HighlightOnMouseHover}
		while ${Actor["Player Head Gear"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Take head gear"]}
		{
			Actor["Player Head Gear"]:DoubleClick
			wait 2
		}
		wait 5 ${Me.CastingSpell}
		wait 50 !${Me.CastingSpell}
	}
	if ${Me.IsCrouching}
		press ${RI_Var_String_CrouchKey}
	if ${Math.Distance[${Me.Loc},-6.812572,12.108113,-62.804375]}<5
		call RIMObj.Move -5.723879 12.108114 -49.875088 1 0 TRUE FALSE TRUE TRUE TRUE
	if ${Math.Distance[${Me.Loc},6.049448,12.108114,-63.603703]}<5
		call RIMObj.Move 5.917499 12.108114 -50.097019 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move -0.357533 12.170499 -41.523327 1 0 TRUE FALSE TRUE TRUE TRUE
	;;;;;
	
	call RIMObj.Move 9.667832 11.845428 1.366835 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 19.379438 15.353472 1.437072 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 19.024715 17.781967 11.507267 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 5.839572 21.017689 11.064613 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 9.604992 21.346867 19.345922 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 21.881687 21.341799 19.104168 1 0 TRUE FALSE TRUE FALSE TRUE
	wait 5 !${Me.IsMoving}
	wait 2
	Actor["Rigging"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 10
	Actor["Crows Nest Tight Rope"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 10
	Me.Ability[Sprint]:Use
	Me.Ability[Sprint]:Use
	call RIMObj.Move -0.053792 101.689331 -18.892773 1 0 TRUE FALSE TRUE FALSE TRUE
	Me.Maintained[Sprint]:Cancel
	; jump part
	; press ${RI_Var_String_JumpKey}
	; wait 5 
	;;;${Me.Y}>21
	; press -hold ${RI_Var_String_ForwardKey}
	; wait 5 
	;;;${Me.Z}<30
	; press -release ${RI_Var_String_ForwardKey}
	wait 5 !${Me.IsMoving}
	wait 5
	Actor["Zipline Start 1"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 50
	;wait 30
	Actor["Zipline Start 2"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 50
	;wait 2
	while !${Actor["Cannonball sign"].HighlightOnMouseHover}
		waitframe
	Actor["Cannonball sign"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}

	call RIMObj.Move 2.586564 48.929527 -103.580338 1 0 TRUE FALSE TRUE FALSE TRUE
	while !${Actor["Cannonball drop"](exists)}
	{
		waitframe
		;echo ${Time}: waiting for Cannonball drop
	}
	Actor["Cannonball drop"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 5
	;jump part
	press ${RI_Var_String_JumpKey}
	wait 5 ${Me.Y}>49
	press -hold ${RI_Var_String_ForwardKey}
	wait 5 
	;${Me.Z}<30
	press -release ${RI_Var_String_ForwardKey}
	wait 2
	call RIMObj.Move 2.379748 50.103252 -100.839066 1 0 TRUE FALSE TRUE TRUE TRUE
	call RIMObj.Move 1.407784 34.368313 -95.783409 1 0 TRUE FALSE TRUE FALSE TRUE
	if ${Me.Y}>40
		call RIMObj.Move 1.407784 34.368313 -95.783409 1 0 TRUE FALSE TRUE FALSE TRUE
	wait 50 ${Actor["a K.O.d Captain Zythox"](exists)}
	echo moving to zythox
	call RIMObj.Move ${Actor["a K.O.d Captain Zythox"].X} ${Actor["a K.O.d Captain Zythox"].Y} ${Actor["a K.O.d Captain Zythox"].Z} 1 0 TRUE FALSE TRUE FALSE TRUE
	Actor["a K.O.d Captain Zythox"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 10 ${Actor["Grappling Hook Loc 2"](exists)}
	Actor["Grappling Hook Loc 2"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 10 ${Actor["Rope Lead 2"](exists)}
	Actor["Rope Lead 2"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 10 ${Me.Y}>50

	call RIMObj.Move 14.407750 51.040039 -113.536392 1 0 TRUE FALSE TRUE FALSE TRUE
	wait 2
	Actor["Barrel"]:DoubleClick
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}
	wait 50 ${Actor["cannon"](exists)} && ${Actor["cannon"].HighlightOnMouseHover}
	while ${Actor["cannon"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Light the cannon's fuse"]}
	{
		Actor["cannon"]:DoubleClick
		wait 2
	}
	wait 5 ${Me.CastingSpell}
	wait 50 !${Me.CastingSpell}	
	;unpause bots
	RI_CMD_PauseCombatBots 0
	Script:End
}

;atom triggered when an announcement is detected
atom EQ2_onAnnouncementFrillik(string Message, string SoundType, float Timer)
{
	if ${RI_Var_Bool_Debug}
		echo ${Time}:AnnounceText: ${Message}
	;if ${AnnounceText} exists in the announce, execute
	if ${Message.Find["Hold still!"](exists)}
	{
		RI_Var_Bool_PauseMovement:Set[TRUE]
		TimedCommand 125 RI_Var_Bool_PauseMovement:Set[FALSE]
	}
	if ${Message.Find["The winds pick up!"](exists)}
	{
		ropecount:Inc
		if ${ropecount}>1
		{
			RI_Var_Bool_PauseMovement:Set[TRUE]
			Actor["Tight Rope"]:DoubleClick
			TimedCommand 5 Actor["Tight Rope"]:DoubleClick
			TimedCommand 10 Actor["Tight Rope"]:DoubleClick
			TimedCommand 15 Actor["Tight Rope"]:DoubleClick
			TimedCommand 30 RI_Var_Bool_PauseMovement:Set[FALSE]
		}
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingTextFrillik(string Text)
{
	
   	if ${Text.Find["Can just run across this now"](exists)}
	{	
		if ${RI_Var_Bool_Debug}
			echo ${Time}:IncomingText: ${Text}
		NoFire:Set[FALSE]
	}
	if ${Text.Find["Welcome to The Frillik Tide."](exists)}
		CaptainDoneTrigger:Set[TRUE]
	if ${Text.Find["orry little guy, I've got no leftovers for you. They haven't fed us yet."](exists)}
		RatTrigger:Set[TRUE]
}

;;;;;;;;;;;;;;;; End Frillik Tide ;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; Start The Lost City of Torsis: The Shrouded Temple ;;;;;;;;;;;;;;;;;;;;;;

function Haze()
{
	echo ISXRI: Starting Haze
	"RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Open Wounds,0]"
	variable int MirageID
	variable string FORKEAST
	variable string FORKWEST
	variable string TEMPFORKEAST
	variable string TEMPFORKWEST
	variable int LowestIndexEAST
	variable float LowestDistanceEAST
	variable float LowestDistanceEASTY
	variable int EastCount
	variable int LowestIndexWEST
	variable float LowestDistanceWEST
	variable float LowestDistanceWESTY
	variable int WestCount
	variable bool InFork
	variable bool Skip100NotChecked
	variable index:string EAST
	variable index:string WEST
	variable int MirageTime
	variable index:actor Mirages
	variable int count
	variable int ClosestMirageIndex
	variable float ClosestMirageDistance
	variable float FurthestAwayGroupMemberDistance
	AnnounceText:Clear
	AnnounceText:Insert["A mirage of yourself has appeared somewhere within the fog. Find and destroy it!"]
	
	if !${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
	{
		Skip100NotChecked:Set[TRUE]
		UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI]:SetChecked
	}

	;build our indexs
	
	EAST:Insert[-184.900620 3.612629 -364.686615]
	EAST:Insert[-194.956909 3.306251 -364.575867]
	EAST:Insert[-205.104218 3.306251 -364.647430]
	EAST:Insert[-215.199051 3.306250 -364.718536]
	EAST:Insert[-220.535233 3.306250 -364.756134]
	EAST:Insert[FORK-EASTBEFOREGAZEBO]
	EAST:Insert[-219.030350 3.306250 -374.856537]
	EAST:Insert[-218.281342 3.306251 -381.889343]
	;EAST:Insert[FORK-EASTGAZEBO]
	;EAST:Insert[-207.951309 4.135114 -381.914734]
	;EAST:Insert[-198.013779 4.518423 -382.002441]
	;EAST:Insert[-208.215393 4.135114 -381.602966]
	;EAST:Insert[-218.766663 3.306250 -381.189087]
	;EAST:Insert[FORK-EASTGAZEBO]
	EAST:Insert[-212.670303 3.306251 -392.940247]
	EAST:Insert[-207.310638 3.306251 -398.006958]
	EAST:Insert[-197.309418 3.306251 -397.697906]
	EAST:Insert[-187.114639 3.306251 -397.737091]
	EAST:Insert[-183.444656 3.306251 -397.751190]
	EAST:Insert[-193.575775 3.306251 -397.669739]
	EAST:Insert[-203.534485 3.306251 -396.301025]
	EAST:Insert[-212.897644 3.306251 -392.735840]
	EAST:Insert[-213.567032 3.306251 -392.369232]
	EAST:Insert[-219.926682 3.306251 -384.641052]
	EAST:Insert[-220.418381 3.306249 -374.929169]
	EAST:Insert[-220.908432 3.306250 -364.141113]
	EAST:Insert[FORK-EASTBEFOREGAZEBO]
	EAST:Insert[-220.810730 3.306250 -364.678741]
	EAST:Insert[-223.708649 3.306250 -354.998505]
	EAST:Insert[-226.596115 3.306249 -345.353363]
	EAST:Insert[-229.457214 3.306249 -335.427063]
	EAST:Insert[-231.543060 3.306249 -325.390289]
	EAST:Insert[-233.033386 3.306249 -315.072266]
	EAST:Insert[-233.943161 3.306249 -305.034271]
	EAST:Insert[-234.601501 3.306250 -294.865417]
	EAST:Insert[FORK-EASTLAKE]
	EAST:Insert[-234.692596 3.306250 -293.419312]
	EAST:Insert[-243.206284 3.306248 -288.051788]
	EAST:Insert[-251.709930 3.306247 -282.690765]
	EAST:Insert[-260.288147 3.534184 -277.468079]
	EAST:Insert[-269.453064 2.750447 -273.214722]
	EAST:Insert[-276.199860 2.190441 -265.812927]
	EAST:Insert[-279.262634 2.189841 -260.235016]
	EAST:Insert[-272.360413 2.190678 -267.973755]
	EAST:Insert[-265.548828 3.534047 -275.413086]
	EAST:Insert[-258.253906 3.306247 -282.418152]
	EAST:Insert[-249.842148 3.306248 -288.136597]
	EAST:Insert[-240.274551 3.306249 -291.741608]
	EAST:Insert[FORK-EASTLAKE]
	EAST:Insert[-234.691788 3.306250 -293.591156]
	EAST:Insert[-229.991470 3.306250 -284.473785]
	EAST:Insert[-225.003906 3.306250 -275.527679]
	EAST:Insert[-219.350845 3.306250 -267.029358]
	EAST:Insert[FORK-EASTAFTERSTAIRS]
	EAST:Insert[-219.018509 3.306250 -266.534241]
	EAST:Insert[-218.741196 3.306250 -256.338409]
	EAST:Insert[-218.461853 3.306249 -246.068954]
	EAST:Insert[-218.168900 3.306249 -235.804337]
	EAST:Insert[-216.751068 3.306248 -226.197784]
	EAST:Insert[-215.776993 3.306249 -230.267578]
	EAST:Insert[-217.884109 3.306249 -240.197372]
	EAST:Insert[-219.270035 3.306249 -250.178574]
	EAST:Insert[-220.034683 3.306250 -260.353088]
	EAST:Insert[FORK-EASTAFTERSTAIRS]
	EAST:Insert[-219.699127 3.306250 -266.466675]
	EAST:Insert[-210.141830 3.306251 -269.480713]
	EAST:Insert[-200.599487 4.895166 -272.781799]
	EAST:Insert[-193.621719 4.895164 -276.037079]
	EAST:Insert[-194.216873 9.137593 -285.146606]
	EAST:Insert[-194.439011 9.857175 -290.442902]
	EAST:Insert[-184.820724 13.664171 -289.187836]
	EAST:Insert[-177.427414 14.870481 -288.808838]
	EAST:Insert[-178.150162 18.968010 -298.267059]
	EAST:Insert[-178.195328 23.724838 -307.433624]
	EAST:Insert[-178.169800 28.305532 -316.362366]
	EAST:Insert[-178.379135 29.526823 -326.497223]
	EAST:Insert[-178.573776 29.526823 -329.877899]
	EAST:Insert[-188.569244 29.526823 -330.187866]
	EAST:Insert[-197.800659 25.591040 -330.006805]
	EAST:Insert[-206.620316 20.555073 -330.032135]
	EAST:Insert[-214.841553 16.681242 -329.867188]
	EAST:Insert[-214.656174 16.195103 -323.303619]
	EAST:Insert[-218.415298 16.194664 -323.364746]

	WEST:Insert[-169.494110 3.306249 -362.992065]
	WEST:Insert[-159.638275 3.306249 -364.886169]
	WEST:Insert[-149.686508 3.306247 -366.368561]
	WEST:Insert[-142.328522 3.306248 -362.892944]
	WEST:Insert[FORK-WESTBEFOREGAZEBO]
	WEST:Insert[-142.539566 3.306247 -373.065643]
	WEST:Insert[-142.776260 3.306249 -382.577484]
	;WEST:Insert[FORK-WESTGAZEBO]
	;WEST:Insert[-151.396988 4.516153 -382.186340]
	;WEST:Insert[-157.731186 4.518423 -381.839630]
	;WEST:Insert[-147.649902 3.698921 -381.663879]
	;WEST:Insert[-143.074890 3.306248 -382.388855]
	;WEST:Insert[FORK-WESTGAZEBO]
	WEST:Insert[-144.985733 3.306250 -392.557098]
	WEST:Insert[-146.842133 3.306251 -401.334991]
	WEST:Insert[-157.074463 3.306251 -400.599487]
	WEST:Insert[-167.082352 3.306251 -399.934357]
	WEST:Insert[-169.450470 3.306251 -399.795288]
	WEST:Insert[-159.281952 3.306251 -399.257324]
	WEST:Insert[-149.013321 3.306251 -398.261169]
	WEST:Insert[-142.251404 3.306249 -390.666626]
	WEST:Insert[-140.859482 3.306248 -380.708313]
	WEST:Insert[-140.537918 3.306247 -370.634827]
	WEST:Insert[-142.776917 3.306248 -362.662964]
	WEST:Insert[FORK-WESTBEFOREGAZEBO]
	WEST:Insert[-143.223312 3.306248 -362.513214]
	WEST:Insert[-139.090698 3.306251 -353.196198]
	WEST:Insert[-135.052887 3.306251 -343.736481]
	WEST:Insert[-130.665024 3.306251 -334.597076]
	WEST:Insert[-125.287148 3.306251 -326.165680]
	WEST:Insert[-121.943123 3.306249 -316.383789]
	WEST:Insert[-124.056190 3.306248 -306.368164]
	WEST:Insert[-127.781219 3.306250 -296.742828]
	WEST:Insert[-133.032715 3.306251 -287.774536]
	WEST:Insert[-138.080887 3.306251 -279.141296]
	WEST:Insert[-142.635818 3.306251 -270.238739]
	WEST:Insert[FORK-WESTAFTERSTAIRS]
	WEST:Insert[-145.002197 3.306251 -265.312347]
	WEST:Insert[-144.940002 3.306250 -255.027435]
	WEST:Insert[-145.346848 3.306249 -244.824814]
	WEST:Insert[-145.680786 3.306249 -234.782166]
	WEST:Insert[-145.817612 3.306248 -224.656219]
	WEST:Insert[-145.840042 3.306248 -221.159790]
	WEST:Insert[-145.046371 3.306248 -231.367981]
	WEST:Insert[-144.899597 3.306249 -241.373047]
	WEST:Insert[-144.958694 3.306250 -251.562958]
	WEST:Insert[-145.071259 3.306250 -261.689575]
	WEST:Insert[FORK-WESTAFTERSTAIRS]
	WEST:Insert[-145.090805 3.306251 -265.271820]
	WEST:Insert[-154.602722 4.210486 -268.871307]
	WEST:Insert[-162.428482 4.895164 -275.095703]
	WEST:Insert[-162.662796 4.893470 -275.669159]
	WEST:Insert[-162.085052 9.113820 -285.017639]
	WEST:Insert[-162.005096 9.857175 -289.881775]
	WEST:Insert[-171.278732 13.723725 -289.502808]
	WEST:Insert[-178.669159 14.870481 -289.474213]
	WEST:Insert[-178.061279 19.126575 -298.607574]
	WEST:Insert[-177.964798 24.003613 -307.975311]
	WEST:Insert[-177.991364 28.604815 -316.936676]
	WEST:Insert[-178.010315 29.526823 -327.126953]
	WEST:Insert[-178.002167 29.526823 -330.293213]
	WEST:Insert[-167.825531 29.526823 -330.135284]
	WEST:Insert[-158.279587 25.681774 -329.912537]
	WEST:Insert[-149.511292 20.555073 -329.668304]
	WEST:Insert[-141.315063 16.681242 -329.419006]
	WEST:Insert[-141.583588 16.194313 -322.180115]
	WEST:Insert[-137.334915 16.194410 -323.101532]
	
	RI_Atom_SetLockSpot ${Me.Name} -177.866241 3.306249 -359.220947
			
	if !${RI_Var_Bool_GlobalOthers}
	{
		Actor[Query, Name=="The Meld of Haze" && IsDead=FALSE]:DoTarget
	
		while ${Actor[Query, Name="The Meld of Haze"].Distance}>9
			wait 2
		wait 5
		RI_Atom_SetLockSpot ${Me.Name} -178.779922 3.612629 -369.184631
	}
	
	while ( ${Actor[Query, Name="The Meld of Haze" && IsDead=FALSE](exists)} || ${Me.InCombat} || ${Me.IsDead} )
	{
		waitframe
		FORKEAST:Set[NONE]
		TEMPFORKEAST:Set[NONE]
		FORKWEST:Set[NONE]
		TEMPFORKWEST:Set[NONE]
		InFork:Set[FALSE]
		
		while !${Actor[Query,Name=="${Me.Name}'s mirage"](exists)} && !${Trigger} && ${Actor[Query, Name="The Meld of Haze" && IsDead=FALSE](exists)}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				if ${Actor[Query, Name=="a haze hunter" && IsDead=FALSE](exists)}
				{
					if ${Target.ID}!=${Actor[Query, Name=="a haze hunter" && IsDead=FALSE].ID}
						Actor[Query, Name=="a haze hunter" && IsDead=FALSE]:DoTarget
				}
				else
				{
					if ${Target.ID}!=${Actor[Query, Name=="The Meld of Haze" && IsDead=FALSE].ID}
						Actor[Query, Name=="The Meld of Haze" && IsDead=FALSE]:DoTarget
				}
			}
			if ${Me.Maintained[Sprint](exists)}
				Me.Maintained[Sprint]:Cancel
			waitframe
		}
		MirageTime:Set[${Script.RunningTime}]

		wait 100 ${Trigger}
		Trigger:Set[FALSE]
		wait 10
		
		;get ID of our Mirage, if we cant find, return
		MirageID:Set[${Actor[Query,Name=="${Me.Name}'s mirage"].ID}]
		if ${MirageID}==0
		{
			;echo ISXRI: We are unable to find our Mirage, Please ensure your redering distance in game is set to at least 200 (recommend 1000)
			;wait ${Math.Calc[(${Math.Calc[${MirageTime}+41000]}-${Script.RunningTime})/100]} ${Actor[Query, Name="The Meld of Haze" && IsDead=FALSE](exists)}
			wait 50
			continue
		}

		;put all mirage's into an index
		EQ2:QueryActors[Mirages, Name=-"mirage"]
		;echo MirageCount: ${Mirages.Used}
		;find the closest mirage
		ClosestMirageDistance:Set[1000]
		ClosestMirageIndex:Set[0]
		for(count:Set[1];${count}<=${Mirages.Used};count:Inc)
		{
			if ${Math.Distance[${Mirages.Get[${count}].Loc},-177.866241,3.306249,-359.220947]}<${ClosestMirageDistance}
			{
				ClosestMirageDistance:Set[${Math.Distance[${Mirages.Get[${count}].Loc},-177.866241,3.306249,-359.220947]}]
				ClosestMirageIndex:Set[${count}]
			}
		}
		
		;echo my Mirage is AT: ${Actor[Query, ID=${MirageID}].Loc}
			
		;turn off assisting
		RI_CMD_Assisting 0
		
		RI_Atom_SetLockSpot OFF
		RI_Atom_SetRIFollow OFF
		
		;target self
		Actor[${Me.ID}]:DoTarget
		
		;check for ${Math.Distance[${Actor[${Me}Mirage].Loc},${EAST.Get[${EastCount}]}]} to find the lowest
		LowestIndexEAST:Set[0]
		LowestDistanceEAST:Set[500]
		LowestDistanceEASTY:Set[3]
		
		for(EastCount:Set[1];${EastCount}<=${EAST.Used};EastCount:Inc)
		{
			if ${EAST.Get[${EastCount}].Find[FORK-](exists)}
			{
				if ${TEMPFORKEAST.NotEqual[${EAST.Get[${EastCount}]}]}
					TEMPFORKEAST:Set[${EAST.Get[${EastCount}]}]
				else
					TEMPFORKEAST:Set[NONE]
				continue
			}
			;echo ${LowestDistanceEASTY} // ${Math.Distance[${Actor[Query, ID=${MirageID}].Y},${EAST.Get[${EASTCount}].Replace[" ",","].Token[2,","]}]}<5
			;echo checking if ${Math.Distance[${Actor[Query, ID=${MirageID}].Loc},${EAST.Get[${EastCount}].Replace[" ",","]}]}<${LowestDistanceEAST}
			if ${Math.Distance[${Actor[Query, ID=${MirageID}].Loc},${EAST.Get[${EastCount}].Replace[" ",","]}]}<${LowestDistanceEAST}
			{
				 ; if ${Math.Distance[${Actor[Query, ID=${MirageID}].Y},16]}<3 && ${Math.Distance[16,${EAST.Get[${EASTCount}].Replace[" ",","].Token[2,","]}]}>3
					; return
				 
				;echo it is lower
				LowestDistanceEAST:Set[${Math.Distance[${Actor[Query, ID=${MirageID}].Loc},${EAST.Get[${EastCount}].Replace[" ",","]}]}]
				LowestDistanceEASTY:Set[${EAST.Get[${EastCount}].Replace[" ",","].Token[2,","]}]
				LowestIndexEAST:Set[${EastCount}]
				if ${TEMPFORKEAST.NotEqual[NONE]}
					FORKEAST:Set[${TEMPFORKEAST}]
				else
					FORKEAST:Set[NONE]
			}
		}
		
		;check for ${Math.Distance[${Actor[${Me}Mirage].Loc},${WEST.Get[${WestCount}]}]} to find the lowest
		LowestIndexWEST:Set[0]
		LowestDistanceWEST:Set[500]
		LowestDistanceWESTY:Set[3]
		
		for(WestCount:Set[1];${WestCount}<=${WEST.Used};WestCount:Inc)
		{
			if ${WEST.Get[${WestCount}].Find[FORK-](exists)}
			{
				if ${TEMPFORKWEST.NotEqual[${WEST.Get[${WestCount}]}]}
					TEMPFORKWEST:Set[${WEST.Get[${WestCount}]}]
				else
					TEMPFORKWEST:Set[NONE]
				continue
			}
			;echo ${LowestDistanceWESTY} // ${Math.Distance[${Actor[Query, ID=${MirageID}].Y},${WEST.Get[${WestCount}].Replace[" ",","].Token[2,","]}]}<5
			;echo checking if ${Math.Distance[${Actor[Query, ID=${MirageID}].Loc},${WEST.Get[${WestCount}].Replace[" ",","]}]}<${LowestDistanceWEST}
			if ${Math.Distance[${Actor[Query, ID=${MirageID}].Loc},${WEST.Get[${WestCount}].Replace[" ",","]}]}<${LowestDistanceWEST}
			{
				; if ${Math.Distance[${Actor[Query, ID=${MirageID}].Y},16]}<3 && ${Math.Distance[16,${WEST.Get[${WESTCount}].Replace[" ",","].Token[2,","]}]}>3
					; return
				;echo it is lower
				LowestDistanceWEST:Set[${Math.Distance[${Actor[Query, ID=${MirageID}].Loc},${WEST.Get[${WestCount}].Replace[" ",","]}]}]
				LowestDistanceWESTY:Set[${WEST.Get[${WestCount}].Replace[" ",","].Token[2,","]}]
				LowestIndexWEST:Set[${WestCount}]
				if ${TEMPFORKWEST.NotEqual[NONE]}
					FORKWEST:Set[${TEMPFORKWEST}]
				else
					FORKWEST:Set[NONE]
			}
		}
		
		;see if we should be going east
		if ${LowestDistanceEAST}<${LowestDistanceWEST}
		{
			;go east up to LowestIndexEAST
			for(EastCount:Set[1];${EastCount}<=${LowestIndexEAST};EastCount:Inc)
			{
				if ${EAST.Get[${EastCount}].Find[FORK-](exists)}
				{
					if ${TEMPFORKEAST.NotEqual[${EAST.Get[${EastCount}]}]}
					{
						TEMPFORKEAST:Set[${EAST.Get[${EastCount}]}]
						InFork:Set[TRUE]
					}
					else
					{
						TEMPFORKEAST:Set[NONE]
						InFork:Set[FALSE]
					}
					continue
				}

				if ${InFork} && ${FORKEAST.NotEqual[${TEMPFORKEAST}]}
					continue

				call RIMObj.Move ${EAST.Get[${EastCount}]} 1 0 FALSE FALSE TRUE TRUE
				waitframe
			}
			;goto our mirage and kill
			
			call RIMObj.Move ${Actor[Query, ID=${MirageID}].X} ${Actor[Query, ID=${MirageID}].Y} ${Actor[Query, ID=${MirageID}].Z} 1 0 FALSE FALSE TRUE FALSE

			;if my mirage is the closest, wait until everyone else is done killing
			if ${Mirages.Get[${ClosestMirageIndex}].Name.Find[${Me.Name}](exists)}
			{
				if ${Target.ID}!=${Me.ID}
					Actor[id,${Me.ID}]:DoTarget
				FurthestAwayGroupMemberDistance:Set[${Math.Distance[${Actor[id,${MirageID}].Loc},-177.866241,3.306249,-359.220947]}]
				;echo ISXRI: MyMirage is the closest waiting
				while ${Mirages.Used}>1
				{
					if ${Target.ID}!=${Me.ID}
						Actor[id,${Me.ID}]:DoTarget
					wait 10
					EQ2:QueryActors[Mirages, Name=-"mirage"]
				}
				;now wait until the furthest away groupmember is closer than my mirage
				while ${FurthestAwayGroupMemberDistance}>=${Math.Distance[${Actor[id,${MirageID}].Loc},-177.866241,3.306249,-359.220947]} && ${Math.Calc[(${Script.RunningTime}-${MirageTime})/100]}<400
				{
					FurthestAwayGroupMemberDistance:Set[0]
					;now get and set the furthest away groupmembers distance
					for(count:Set[1];${count}<${Me.Group};count:Inc)
					{
						;echo ${count}: ${Me.Group[${count}].Name}: ${Math.Distance[${Me.Group[${count}].Loc},-177.866241,3.306249,-359.220947]}
						if ${Math.Distance[${Me.Group[${count}].Loc},-177.866241,3.306249,-359.220947]}>${FurthestAwayGroupMemberDistance}
							FurthestAwayGroupMemberDistance:Set[${Math.Distance[${Me.Group[${count}].Loc},-177.866241,3.306249,-359.220947]}]
					}
					wait 1
					if ${Target.ID}!=${Me.ID}
						Actor[id,${Me.ID}]:DoTarget
					;echo ${FurthestAwayGroupMemberDistance}>=${Math.Distance[${Actor[id,${MirageID}].Loc},-177.866241,3.306249,-359.220947]}
					;echo ${Math.Calc[(${Script.RunningTime}-${MirageTime})/100]}
				}
			}
			
			while ${Actor[Query, ID=${MirageID} && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${MirageID}
					Actor[Query, ID=${MirageID} && IsDead=FALSE]:DoTarget
				waitframe
			}
			if !${Me.Maintained[Sprint](exists)}
				Me.Ability[Sprint]:Use
			;go backwards east to 1 from LowestIndexEAST
			;go east down to LowestIndexEAST
			for(EastCount:Set[${LowestIndexEAST}];${EastCount}>=1;EastCount:Dec)
			{
				if ${EAST.Get[${EastCount}].Find[FORK-](exists)}
				{
					if ${TEMPFORKEAST.NotEqual[${EAST.Get[${EastCount}]}]}
					{
						TEMPFORKEAST:Set[${EAST.Get[${EastCount}]}]
						InFork:Set[TRUE]
					}
					else
					{
						TEMPFORKEAST:Set[NONE]
						InFork:Set[FALSE]
					}
					continue
				}
				if ${InFork} && ${FORKEAST.NotEqual[${TEMPFORKEAST}]}
					continue
				call RIMObj.Move ${EAST.Get[${EastCount}]} 1 0 FALSE FALSE TRUE TRUE
				if !${Me.Maintained[Sprint](exists)}
					Me.Ability[Sprint]:Use
				waitframe
			}
			
			RI_Atom_SetLockSpot ${Me.Name} -177.866241 3.306249 -359.220947
			
			if !${RI_Var_Bool_GlobalOthers}
			{
				while ${Actor[Query, Name="The Meld of Haze"].Distance}>9
					wait 2
				wait 5
				RI_Atom_SetLockSpot ${Me.Name} -178.729904 3.612629 -369.953461
			}
		}
		;else west
		else
		{
			;go west up to LowestIndexWEST
			for(WestCount:Set[1];${WestCount}<=${LowestIndexWEST};WestCount:Inc)
			{
				if ${WEST.Get[${WestCount}].Find[FORK-](exists)}
				{
					if ${TEMPFORKWEST.NotEqual[${WEST.Get[${WestCount}]}]}
					{
						TEMPFORKWEST:Set[${WEST.Get[${WestCount}]}]
						InFork:Set[TRUE]
					}
					else
					{
						InFork:Set[FALSE]
						TEMPFORKWEST:Set[NONE]
					}
					continue
				}
				if ${InFork} && ${FORKWEST.NotEqual[${TEMPFORKWEST}]}
					continue
				call RIMObj.Move ${WEST.Get[${WestCount}]} 1 0 FALSE FALSE TRUE TRUE
				waitframe
			}
			;goto our mirage and kill
			
			call RIMObj.Move ${Actor[Query, ID=${MirageID}].X} ${Actor[Query, ID=${MirageID}].Y} ${Actor[Query, ID=${MirageID}].Z} 1 0 FALSE FALSE TRUE FALSE
			
			;if my mirage is the closest, wait until everyone else is done killing
			if ${Mirages.Get[${ClosestMirageIndex}].Name.Find[${Me.Name}](exists)}
			{
				if ${Target.ID}!=${Me.ID}
					Actor[id,${Me.ID}]:DoTarget
				FurthestAwayGroupMemberDistance:Set[${Math.Distance[${Actor[id,${MirageID}].Loc},-177.866241,3.306249,-359.220947]}]
				;echo ISXRI: MyMirage is the closest waiting
				while ${Mirages.Used}>1
				{
					if ${Target.ID}!=${Me.ID}
						Actor[id,${Me.ID}]:DoTarget
					wait 10
					EQ2:QueryActors[Mirages, Name=-"mirage"]
				}
				;now wait until the furthest away groupmember is closer than my mirage
				while ${FurthestAwayGroupMemberDistance}>=${Math.Distance[${Actor[id,${MirageID}].Loc},-177.866241,3.306249,-359.220947]} && ${Math.Calc[(${Script.RunningTime}-${MirageTime})/100]}<400
				{
					FurthestAwayGroupMemberDistance:Set[0]
					;now get and set the furthest away groupmembers distance
					for(count:Set[1];${count}<${Me.Group};count:Inc)
					{
						echo ${count}: ${Me.Group[${count}].Name}: ${Math.Distance[${Me.Group[${count}].Loc},-177.866241,3.306249,-359.220947]}
						if ${Math.Distance[${Me.Group[${count}].Loc},-177.866241,3.306249,-359.220947]}>${FurthestAwayGroupMemberDistance}
							FurthestAwayGroupMemberDistance:Set[${Math.Distance[${Me.Group[${count}].Loc},-177.866241,3.306249,-359.220947]}]
					}
					wait 1
					if ${Target.ID}!=${Me.ID}
						Actor[id,${Me.ID}]:DoTarget
					;echo ${FurthestAwayGroupMemberDistance}>=${Math.Distance[${Actor[id,${MirageID}].Loc},-177.866241,3.306249,-359.220947]}
					;echo ${Math.Calc[(${Script.RunningTime}-${MirageTime})/100]}
				}
			}
			
			while ${Actor[Query, ID=${MirageID} && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${MirageID}
					Actor[Query, ID=${MirageID} && IsDead=FALSE]:DoTarget
				waitframe
			}
			if !${Me.Maintained[Sprint](exists)}
				Me.Ability[Sprint]:Use
			;go backwards west to 1 from LowestIndexWEST
			;go west down to LowestIndexWEST
			for(WestCount:Set[${LowestIndexWEST}];${WestCount}>=1;WestCount:Dec)
			{
				if ${WEST.Get[${WestCount}].Find[FORK-](exists)}
				{
					if ${TEMPFORKWEST.NotEqual[${WEST.Get[${WestCount}]}]}
					{
						TEMPFORKWEST:Set[${WEST.Get[${WestCount}]}]
						InFork:Set[TRUE]
					}
					else
					{
						InFork:Set[FALSE]
						TEMPFORKWEST:Set[NONE]
					}
					continue
				}
				if ${InFork} && ${FORKWEST.NotEqual[${TEMPFORKWEST}]}
					continue
				call RIMObj.Move ${WEST.Get[${WestCount}]} 1 0 FALSE FALSE TRUE TRUE
				if !${Me.Maintained[Sprint](exists)}
					Me.Ability[Sprint]:Use
				waitframe
			}
			
			RI_Atom_SetLockSpot ${Me.Name} -177.866241 3.306249 -359.220947
			
			if !${RI_Var_Bool_GlobalOthers}
			{
				while ${Actor[Query, Name="The Meld of Haze"].Distance}>9
					wait 2
				wait 5
				RI_Atom_SetLockSpot ${Me.Name} -178.729904 3.612629 -369.953461
			}
		}
		;turn on assisting
		RI_CMD_Assisting 1
		;echo waiting ${Math.Calc[(${Math.Calc[${MirageTime}+41000]}-${Script.RunningTime})/100]}
		;wait ${Math.Calc[(${Math.Calc[${MirageTime}+41000]}-${Script.RunningTime})/100]} ${Actor[Query, Name="The Meld of Haze" && IsDead=FALSE](exists)}
		wait 1
	}
	if ${Skip100NotChecked}
		UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI]:UnsetChecked
	"RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Open Wounds,1]"
	echo ISXRI: Ending Haze
}

function Reaver()
{
	variable int ReaverID
	ReaverID:Set[${Actor[Query, Name=="The Mist Reaver" && IsDead=FALSE].ID}]
	"RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Absorb Magic,TRUE]"
	;#2FE83C - Noxious
	;#943BFF - Arcane
	;#FF930C - Elemental
	;#E8E31D - Physical
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert["The Mist Reaver alters its defense!"]
	AnnounceText:Clear
	AnnounceText:Insert["A lantern alights nearby while the reaver's defense to all damage but"]
	RI_Obj_CB:CastWhileMoving[1]
	if !${RI_Var_Bool_GlobalOthers}
		Actor[Query, ID=${ReaverID} && IsDead=FALSE]:DoTarget
	
	call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE FALSE
	RI_Atom_SetLockSpot ${Me.Name} -178.027634 14.870481 -288.785919 1 100
	
	if !${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ${Me.Name} -178.101105 14.874979 -277.427063 1 100
	
	if !${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
	{
		Skip100NotChecked:Set[TRUE]
		UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI]:SetChecked
	}
	
	while ${Actor[Query, ID=${ReaverID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Target.ID}!=${Actor[Query, ID=${ReaverID} && IsDead=FALSE].ID}
				Actor[Query, ID=${ReaverID} && IsDead=FALSE]:DoTarget
		}

		if ${RIObj.MainIconIDExists[${Me.ID},822]}
		{
			RI_Atom_SetLockSpot OFF
			RI_Atom_SetRIFollow OFF
			;turn off assist and target self
			RI_CMD_Assisting 0
			wait 2
			Actor[${Me.ID}]:DoTarget
			wait 2
			
			switch ${Me.Archetype}
			{
				case fighter
				{
					while ${Actor[Query, Name=="smothering mist" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=="smothering mist" && IsDead=FALSE].ID}
							Actor[Query, Name=="smothering mist" && IsDead=FALSE]:DoTarget
						wait 2
					}
					break
				}
				case mage
				{
					call RIMObj.Move -177.825836 15.086945 -290.888245 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					;crouch
					if !${Me.IsCrouching}
						press z
					call RIMObj.Move -214.374695 16.681242 -330.082001 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -214.430405 16.195002 -323.426300 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					while ${Actor[Query, Name=="smothering mist" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=="smothering mist" && IsDead=FALSE].ID}
							Actor[Query, Name=="smothering mist" && IsDead=FALSE]:DoTarget
						wait 2
					}
					wait 2
					;crouch
					press ${RI_Var_String_JumpKey}
					Actor[${Me.ID}]:DoTarget
					call RIMObj.Move -214.374695 16.681242 -330.082001 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -178.027634 14.870481 -288.785919 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					RI_Atom_SetLockSpot ${Me.Name} -178.027634 14.870481 -288.785919 1 100
					break
				}
				case scout
				{
					call RIMObj.Move -177.825836 15.086945 -290.888245 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					;crouch
					if !${Me.IsCrouching}
						press z
					call RIMObj.Move -141.842484 16.681242 -329.691162 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -141.959213 16.194778 -322.741150 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					while ${Actor[Query, Name=="smothering mist" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=="smothering mist" && IsDead=FALSE].ID}
							Actor[Query, Name=="smothering mist" && IsDead=FALSE]:DoTarget
						wait 2
					}
					wait 2
					;crouch
					press ${RI_Var_String_JumpKey}
					Actor[${Me.ID}]:DoTarget
					call RIMObj.Move -141.842484 16.681242 -329.691162 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -178.027634 14.870481 -288.785919 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					RI_Atom_SetLockSpot ${Me.Name} -178.027634 14.870481 -288.785919 1 100
					break
				}
				case priest
				{
					call RIMObj.Move -177.825836 15.086945 -290.888245 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					wait 5
					;crouch
					if !${Me.IsCrouching}
						press z
					call RIMObj.Move -178.092209 29.253181 -354.290558 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					while ${Actor[Query, Name=="smothering mist" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=="smothering mist" && IsDead=FALSE].ID}
							Actor[Query, Name=="smothering mist" && IsDead=FALSE]:DoTarget
						wait 2
					}
					wait 5
					;crouch
					press ${RI_Var_String_JumpKey}
					Actor[${Me.ID}]:DoTarget
					call RIMObj.Move -178.000427 29.526823 -330.363922 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -178.027634 14.870481 -288.785919 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					RI_Atom_SetLockSpot ${Me.Name} -178.027634 14.870481 -288.785919 1 100
					break
				}
			}
			wait 2
			;turn on assist
			RI_CMD_Assisting 1

		}
		if ${Trigger}
		{
			if ${RI_Var_Bool_GlobalOthers} && ${Me.Archetype.NotEqual[priest]}
			{
				RI_Atom_SetLockSpot OFF
				RI_Atom_SetRIFollow OFF
				;turn off assist and target self
				RI_CMD_Assisting 0
				wait 2
				Actor[${Me.ID}]:DoTarget
								
				;#2FE83C - Noxious
				if ${TriggerMessage.Find["#2FE83C"](exists)} || ${TriggerMessage.Find["noxious"](exists)}
				{
					call RIMObj.Move -180.556152 14.870481 -289.069733 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -195.793991 9.857199 -290.183380 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -194.741547 4.295166 -269.713654 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -211.196976 3.306250 -242.338394 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -198.641052 4.518423 -241.238815 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					;;;;click lantern
					wait 5
					wait 50 !${Me.CastingSpell}
					while ${Actor["Noxious Lantern"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Harness the power"]}
					{
						Actor["Noxious Lantern"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
					Actor[${Me.ID}]:DoTarget
					;;;
					call RIMObj.Move -211.196976 3.306250 -242.338394 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -194.741547 4.295166 -269.713654 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -195.793991 9.857199 -290.183380 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -177.973831 14.870481 -288.75830 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
				}
				;#943BFF - Arcane
				if ${TriggerMessage.Find["#943BFF"](exists)} || ${TriggerMessage.Find["arcane"](exists)}
				{
					call RIMObj.Move -175.892654 14.870481 -289.195099 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -161.362015 9.857175 -290.102911 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -161.010803 3.995815 -268.542023 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -133.532089 3.490905 -308.118652 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -150.434357 4.135114 -381.931427 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -159.073273 4.518423 -381.956451 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					;;;;click lantern
					wait 5
					wait 50 !${Me.CastingSpell}
					while ${Actor["Arcane Lantern"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Harness the power"]}
					{
						Actor["Arcane Lantern"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
					Actor[${Me.ID}]:DoTarget
					;;;;
					call RIMObj.Move -150.434357 4.135114 -381.931427 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -133.532089 3.490905 -308.118652 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -161.010803 3.995815 -268.542023 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -161.362015 9.857175 -290.102911 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -177.973831 14.870481 -288.75830 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
				}
				;#FF930C - Elemental
				if ${TriggerMessage.Find["#FF930C"](exists)} || ${TriggerMessage.Find["elemental"](exists)}
				{
					call RIMObj.Move -175.892654 14.870481 -289.195099 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -161.362015 9.857175 -290.102911 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -161.010803 3.995815 -268.542023 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -146.769302 3.542819 -241.710602 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -158.963928 4.518423 -240.829620 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					;;;;click lantern
					wait 5
					wait 50 !${Me.CastingSpell}
					while ${Actor["Elemental Lantern"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Harness the power"]}
					{
						Actor["Elemental Lantern"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
					Actor[${Me.ID}]:DoTarget
					;;;;
					call RIMObj.Move -146.769302 3.542819 -241.710602 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -161.010803 3.995815 -268.542023 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -161.362015 9.857175 -290.102911 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -177.973831 14.870481 -288.75830 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
				}
				;#E8E31D - Physical
				if ${TriggerMessage.Find["#E8E31D"](exists)} || ${TriggerMessage.Find["physical"](exists)}
				{
					call RIMObj.Move -180.556152 14.870481 -289.069733 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move -195.793991 9.857199 -290.183380 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -194.741547 4.295166 -269.713654 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -228.827774 3.306250 -313.161041 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -207.220673 4.135114 -381.874481 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -197.607407 4.518423 -381.870697 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					;;;;click lantern
					wait 5
					wait 50 !${Me.CastingSpell}
					while ${Actor["Physical Lantern"].HighlightOnMouseHover} && !${Me.GetGameData[Spells.Casting].Label.Equal["Harness the power"]}
					{
						Actor["Physical Lantern"]:DoubleClick
						wait 2
					}
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
					Actor[${Me.ID}]:DoTarget
					;;;;
					call RIMObj.Move -207.220673 4.135114 -381.874481 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -228.827774 3.306250 -313.161041 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -194.741547 4.295166 -269.713654 1 0 FALSE FALSE TRUE TRUE TRUE TRUE
					call RIMObj.Move -195.793991 9.857199 -290.183380 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
					call RIMObj.Move  -177.973831 14.870481 -288.75830 1 0 FALSE FALSE TRUE FALSE TRUE TRUE
				}
				RI_Atom_SetLockSpot ${Me.Name} -178.027634 14.870481 -288.785919 1 100
			}
			Trigger:Set[FALSE]
			;turn on assist
			RI_CMD_Assisting 1
		}
		wait 2
			
	}
	if ${Skip100NotChecked}
		UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI]:UnsetChecked
	"RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Absorb Magic,FALSE]"
	RI_Obj_CB:CastWhileMoving[0]
}
;;;;;;;;;;;;;;;; End The Lost City of Torsis: The Shrouded Temple ;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;; Start The Lost City of Torsis: The Spectral Market ;;;;;;;;;;;;;;;;;;;;;;
function Champion()
{
	echo Starting Champion v1
	variable int Championcounter=0
	IncomingText:Clear
	IncomingText2:Clear
	variable int _ChampionID=${Actor[Query, Name=-"Champion" && IsDead=FALSE].ID}
	IncomingText:Insert["The Torsis Champion eyes"]
	Trigger:Set[FALSE]
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot ALL -58.031300 5.120734 -103.061249
	else
		RI_Atom_SetLockSpot ALL -54.041054 4.150457 -104.316826
	while ${Actor[Query, ID=${_ChampionID} && IsDead=FALSE](exists)}
	{
		if ${Me.Archetype.Equal[fighter]}
		{
			if ${Target.ID}!=${_ChampionID}
				Actor[Query, ID=${_ChampionID} && IsDead=FALSE]:DoTarget
		}
		if ${Trigger}
		{
			wait 20
			Trigger:Set[FALSE]
			Championcounter:Inc
			if ${Championcounter}==1
			{
				if ${Me.Archetype.Equal[fighter]}
					RI_Atom_SetLockSpot ALL -4.821387 5.125111 -102.906876
				else
					RI_Atom_SetLockSpot ALL -8.195525 4.150457 -105.909523
			}
			elseif ${Championcounter}==2
			{
				if ${Me.Archetype.Equal[fighter]}
					RI_Atom_SetLockSpot ALL -58.028660 5.114992 -131.063004
				else
					RI_Atom_SetLockSpot ALL -53.093727 4.150457 -128.019821
			}
			elseif ${Championcounter}==3
			{
				if ${Me.Archetype.Equal[fighter]}
					RI_Atom_SetLockSpot ALL -4.821387 5.125111 -131.906876
				else
					RI_Atom_SetLockSpot ALL -8.195525 4.150457 -128.909523
			}
		}
		wait 2
	}
	
	echo Ending Champion v1
}
function Ongnissim()
{
	echo Starting Ongnissim v1
	IncomingText:Clear
	IncomingText2:Clear
	variable int _OngnissimID=${Actor[Query, Name=-"Ongnissim" && IsDead=FALSE].ID}
	IncomingText:Insert["Ongnissim the Unseen prepares to unleash a massive crashing fist on the ground near him!"]
	Trigger:Set[FALSE]
	RI_Atom_SetLockSpot ALL -10.128205 16.373989 -289.764923
	if !${RI_Var_Bool_GlobalOthers}
		Actor[Query, ID=${_OngnissimID} && IsDead=FALSE]:DoTarget
	wait 100 ${Actor[Query, ID=${_OngnissimID} && IsDead=FALSE].Distance}<9
	wait 5
	if ${RI_Var_Bool_GlobalOthers}
		RI_Atom_SetLockSpot ALL 3.287242 16.841909 -289.514893
	while ${Actor[Query, ID=${_OngnissimID} && IsDead=FALSE](exists)}
	{
		if ${Me.Archetype.Equal[fighter]}
		{
			if ${Target.ID}!=${_OngnissimID}
				Actor[Query, ID=${_OngnissimID} && IsDead=FALSE]:DoTarget
		}
		if ${Trigger}
		{
			Trigger:Set[FALSE]
			if ${Math.Distance[${Me.Loc},-10.128205,16.373989,-289.764923]}<25
			{
				RI_Atom_SetLockSpot ALL 38.233021 16.389023 -289.664032
				if !${RI_Var_Bool_GlobalOthers}
				{
					wait 50
					wait 50 !${Me.IsMoving}
					wait 100 ${Actor[Query, ID=${_OngnissimID} && IsDead=FALSE].Distance}<9
					;wait 5
					RI_Atom_SetLockSpot ALL 49.687565 16.374567 -289.614075
				}
			}
			else
			{
				RI_Atom_SetLockSpot ALL 3.287242 16.841909 -289.514893
				if !${RI_Var_Bool_GlobalOthers}
				{
					wait 50
					wait 50 !${Me.IsMoving}
					wait 100 ${Actor[Query, ID=${_OngnissimID} && IsDead=FALSE].Distance}<9
					;wait 5
					RI_Atom_SetLockSpot ALL -10.128205 16.373989 -289.764923
				}
			}
		}
		wait 2
	}
	
	echo Ending Ongnissim v1
}
;;;;;;;;;;;;;;;; End The Lost City of Torsis: The Spectral Market ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Start The Ruins of Cabilis ;;;;;;;;;;;;;;;;;;;;;;
function Smithy()
{
	echo Starting Smithy v1
	AnnounceText:Clear
	AnnounceText:Insert["Time seems to stop and stand still around"]
	Trigger:Set[FALSE]
	if ${Me.Archetype.Equal[fighter]}
		RI_Atom_SetLockSpot ALL 213.440582 95.755623 249.844040
	else
		RI_Atom_SetLockSpot ALL 214.999786 96.036880 242.236938
	while ${Actor[Smithy](exists)} && !${Actor[Smithy].IsDead}
	{
		if ${Me.Archetype.Equal[fighter]}
		{
			; if ${Actor["a fallen apprentice",radius,50](exists)}
			; {
				; if ${Target.ID}!=${Actor["a fallen apprentice",radius,50].ID}
					; Actor["a fallen apprentice",radius,50]:DoTarget
			; }
			if ${Target.ID}!=${Actor[Smithy].ID}
				Actor[Smithy]:DoTarget
		}
		if ${Trigger}
		{
			Trigger:Set[FALSE]
			if ${Math.Distance[${Me.X},${Me.Z},213,250]}<10
			{
				if ${Me.Archetype.Equal[fighter]}
					RI_Atom_ChangeLockSpot ALL 220.344635 95.754509 214.686325
				else
					RI_Atom_ChangeLockSpot ALL 218.647171 96.036858 221.176727
			}
			if ${Math.Distance[${Me.X},${Me.Z},220,215]}<10
			{
				if ${Me.Archetype.Equal[fighter]}
					RI_Atom_ChangeLockSpot ALL 213.440582 95.755623 249.844040
				else
					RI_Atom_ChangeLockSpot ALL 214.999786 96.036880 242.236938
			}
		}
		wait 2
	}
	
	echo Ending Smithy v1
}
;;;;;;;;;;;;;;;; End The Ruins of Cabilis ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;; Start Kaesora: Tomb of the Venerated ;;;;;;;;;;;;;;;;;;;;;;
function Chatizad()
{
	echo Starting Chatizad v1
	variable int _ChatizadID=${Actor[Query, Name=-"Chatizad" && IsDead=FALSE].ID}
	RIMUIObj:SetLockSpot[ALL,-518.479980,89.105713,-531.070007]
	
	if !${RI_Var_Bool_GlobalOthers}
		Actor[Query, ID=${_ChatizadID} && IsDead=FALSE]:DoTarget

	while ${Actor[Query, ID=${_ChatizadID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, Name=-"guardian" && Distance<=10 && IsAggro=TRUE && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"guardian" && Distance<=10 && IsDead=FALSE].ID}
					Actor[Query, Name=-"guardian" && Distance<=10 && IsDead=FALSE]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${_ChatizadID}
					Actor[Query, ID=${_ChatizadID} && IsDead=FALSE]:DoTarget
			}
		}
		if ${Actor[Query, ID=${_ChatizadID} && IsDead=FALSE && Distance>=7](exists)}
		{
			RIMUIObj:SetLockSpot[ALL,${Actor[Query, ID=${_ChatizadID} && IsDead=FALSE].Loc}]
			wait 20
		}
		wait 2
	}
	
	echo Ending Chatizad v1
}
function Zannaska()
{
	echo Starting Zannaska v1
	variable int _ZannaskaID=${Actor[Query, Name=-"Zannaska" && IsDead=FALSE].ID}
	RIMUIObj:SetLockSpot[ALL,-416.278992,100.679871,-603.322815]
	relay all RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Absorb Magic,1]
	if !${RI_Var_Bool_GlobalOthers}
		Actor[Query, ID=${_ZannaskaID} && IsDead=FALSE]:DoTarget

	while ${Actor[Query, ID=${_ZannaskaID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, Name=-"warden" && Distance<=10 && IsAggro=TRUE && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"warden" && Distance<=10 && IsDead=FALSE].ID}
					Actor[Query, Name=-"warden" && Distance<=10 && IsDead=FALSE]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${_ZannaskaID}
					Actor[Query, ID=${_ZannaskaID} && IsDead=FALSE]:DoTarget
			}
		}
		if ${Actor[Query, ID=${_ZannaskaID} && IsDead=FALSE && Distance>=7](exists)}
		{
			RIMUIObj:SetLockSpot[ALL,${Actor[Query, ID=${_ZannaskaID} && IsDead=FALSE].Loc}]
			wait 20
		}
		wait 2
	}
	relay all RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Absorb Magic,0]
	echo Ending Zannaska v1
}
function Zann()
{
	echo Starting Zann v1
	variable int _ZannID=${Actor[Query, Name=-"Zannaska" && IsDead=FALSE].ID}
	RIMUIObj:SetLockSpot[ALL,-419.499969,111.456451,-355.859009]
	if !${RI_Var_Bool_GlobalOthers}
		Actor[Query, ID=${_ZannID} && IsDead=FALSE]:DoTarget

	while ${Actor[Query, ID=${_ZannID} && IsDead=FALSE](exists)}
	{
		if !${RI_Var_Bool_GlobalOthers}
		{
			if ${Actor[Query, Name=-"spectral" && Distance<=100 && IsAggro=TRUE && IsDead=FALSE](exists)} && ${Actor[Query, Name=-"Chatizad" && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"spectral" && Distance<=100 && IsAggro=TRUE && IsDead=FALSE].ID}
					Actor[Query, Name=-"spectral" && Distance<=100 && IsAggro=TRUE && IsDead=FALSE]:DoTarget
			}
			elseif ${Actor[Query, Name=-"Chatizad" && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"Chatizad" && IsDead=FALSE].ID}
					Actor[Query, Name=-"Chatizad" && IsDead=FALSE]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${_ZannID}
					Actor[Query, ID=${_ZannID} && IsDead=FALSE]:DoTarget
			}
		}
		wait 2
	}
	echo Ending Zann v1
}
;;;;;;;;;;;;;;;; End Kaesora: Tomb of the Venerated ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; End OF KA NAMED CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; Start OF Quest CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function QuestM(string QuestOrTimeLineName=~NONE~)
{
	MainQuestName:Clear
	variable bool _Skip100NotChecked=FALSE
	if !${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
	{
		_Skip100NotChecked:Set[TRUE]
		UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI]:SetChecked
	}
	
	if ${QuestOrTimeLineName.Equal[~NONE~]}
	{
		echo ISXRI: You must specify a quest name or timeline name, USAGE: RI Quest "Quest or Timeline Name", Example RI Quest \"Sokokar Timeline Crafting\" 
		; echo ISXRI: Available Quests or Timelines:
		; echo ISXRI: Sokokar Timeline Crafting
		; echo ISXRI: Fangs Away!
		; echo ISXRI: An Eye in the Sky
		; echo ISXRI: Sticking My Ore In
		; echo ISXRI: Preparations for the Rescue
		; echo ISXRI: Is It Good News?
		; echo ISXRI: Artisan Epic Timeline
		; echo ISXRI: New Lands New Profits
		Script:End
	}
	else
	{
		if ${QuestOrTimeLineName.Replace[" ",""].Find[SokokarTimelineCrafting]} || ${QuestOrTimeLineName.Replace[" ",""].Find[SokokarCraftingTimeline]}
			call SokokarTimelineCrafting
		;if ${QuestOrTimeLineName.Replace["'",""].Replace[" ",""].Find[BathezidsWatchFactionCrafting]}
			;call BathezidsWatchFactionCrafting
		else
			call QuestDefault "${QuestOrTimeLineName}"
		; switch "${QuestOrTimeLineName}"
		; {
			; case Sokokar Timeline Crafting
			; {
				; call SokokarTimelineCrafting
				; break
			; }
			; case Fangs Away!
			; {
				; call FangsAway
				; break
			; }
			; case An Eye in the Sky
			; {
				; call AnEyeInTheSky
				; break
			; }
			; case Sticking My Ore In
			; {
				; call StickingMyOreIn
				; break
			; }
			; case Preparations for the Rescue
			; {
				; call PreparationsForTheRescue
				; break
			; }
			; case Is It Good News?
			; {
				; call IsItGoodNews
				; break
			; }
			; case Artisan Epic Timeline
			; {
				; call ArtisanEpicTimeline
				; break
			; }
		; }
	}
	if ${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked} && !${_Skip100NotChecked}
		UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI]:SetChecked
	Script:End
}
function ExecuteCommand(string CommandName)
{
	;echo ${CommandName}
	if ${CommandName.Left[5].Upper.Equal[RELAY]}
	{
		variable int leftnum
		leftnum:Set[${Math.Calc[6+${CommandName.Right[-6].Find[" "]}]}]
		noop ${Execute[${CommandName.Left[${leftnum}]} "${CommandName.Right[${Math.Calc[-1*${leftnum}]}]}"]}
	}
	else
		noop ${Execute["${CommandName}"]}
}
function Zone(float _X, float _Z,int _Wait=600)
{
	if !${RI_Var_String_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call Zone ${_X} ${_Z} ${_Wait}"]
	wait 5
	Face ${_X} ${_Z}
	wait 2
	press -hold ${RI_Var_String_ForwardKey}
	timedcommand 150 press -release ${RI_Var_String_ForwardKey}
	
	variable int _Counter
	_Counter:Set[0]
	while ${EQ2.Zoning}==0 && ${_Counter:Inc}<${_Wait}
	{
		if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
		{
			press -release ${RI_Var_String_ForwardKey}
			RIMUIObj:Door[ALL,0]
		}
		wait 1
	}
	press -release ${RI_Var_String_ForwardKey}
	wait ${_Wait} ${EQ2.Zoning}==0
	press -release ${RI_Var_String_ForwardKey}
}
function OpenDoor(string _DoorName, float _ClosedHeading, bool _WaitTilClosed=FALSE, int _WaitTimeOut=15)
{
	;echo OpenDoor(string _DoorName=${_DoorName}, float _ClosedHeading=${_ClosedHeading}, bool _WaitTilClosed=${_WaitTilClosed}, int _WaitTimeOut=${_WaitTilClosed})
	if ${_WaitTilClosed}
	{
		;echo waiting till closed
		variable int _WaitCount=0
		while ${Actor[Query, Name=-"${_DoorName}"].Heading}!=${_ClosedHeading} && ${_WaitCount:Inc}<=${_WaitTimeOut}
			wait 10
			;echo ${Actor[Query, Name=-"${_DoorName}"].Heading}!=${_ClosedHeading} && ${_WaitCount}<=${_WaitTimeOut}
		echo done waiting
	}
	_WaitCount:Set[0]
	if ${Actor[Query, Name=-"${_DoorName}"].Heading}==${_ClosedHeading}
	{
		;echo door is closed opening
		while ${Actor[Query, Name=-"${_DoorName}"].Heading}==${_ClosedHeading} && ${_WaitCount:Inc}<=${_WaitTimeOut}
		{
			;echo ${Actor[Query, Name=-"${_DoorName}"].Heading}==${_ClosedHeading} && ${_WaitCount:Inc}<=${_WaitTimeOut}
			Actor[Query, Name=-"${_DoorName}"]:DoubleClick
			wait 10
		}
	}
}
function ExamineItem(string _ItemName, int _ReplyOption=0)
{
	wait 5
	Me.Inventory[${_ItemName}]:Examine
	wait 5
	if ${_ReplyOption}>0
	{
		wait 20 ${ReplyDialog(exists)}
		if ${ReplyDialog(exists)}
			ReplyDialog:Choose[${_ReplyOption}]
		wait 5
		if ${ReplyDialog(exists)}
			ReplyDialog:Choose[${_ReplyOption}]
	}
}
function TravelMap(string _ZoneToZoneName, int _ZoneOption=0, int _BellWizardDruid=0)
{
	if !${RI_Var_String_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.TravelMap \"${_ZoneToZoneName}\" ${_ZoneOption} ${_BellWizardDruid}"]
	call RIMObj.TravelMap "${_ZoneToZoneName}" ${_ZoneOption} ${_BellWizardDruid}	
}
function DoorOption(string _Door)
{
	if ${Int[${_Door}]}==0 && ${_Door.NotEqual[0]} && ${EQ2.Zoning}==0
	{
		RIObj:GetZoneLists
		wait 5
		if ${RIObj.RowByName["${_Door}"]}==0
		{
			echo ISXRI: Can't find that zone in the Destination list
			return
		}
		wait 5
		relay ${RI_Var_String_RelayGroup} -noredirect RIMUIObj:Door[ALL,${RIObj.RowByName["${_Door}"]}]
	}
	else
		relay "${RI_Var_String_RelayGroup}" RIMUIObj:Door[ALL,${_Door}]
}
function CallToGuildHall(bool _WaitTillReady=TRUE)
{
	call RIMObj.CallToGuildHall ${_WaitTillReady}
}
function FlyUp(int _HoldTime=1)
{
	if !${Me.FlyingUsingMount}
	{
		press -hold ${RI_Var_String_FlyUpKey}
		wait ${_HoldTime}
		press -release ${RI_Var_String_FlyUpKey}
	}
}
function Harvest(string _Node, string _ItemNeeded, int _Amount=1)
{
	while ${Me.Inventory[Query, Location=="Inventory" && Name=-"${_ItemNeeded}"].Quantity}<${_Amount}
	{
		Actor[Query, Name=-"${_Node}"]:DoTarget
		wait 10
		Actor[Query, Name=-"${_Node}"]:DoubleClick
		wait 50
	}
}
function WaitForZoning(int _Wait=600)
{
	;echo waitforzoning
	if ${IJustZonedLessThan10SecondsAgo}
		return
	wait ${_Wait} ${EQ2.Zoning}==1
	wait ${_Wait} ${EQ2.Zoning}==0
}
function CraftIt(string _Recipe, int _Amount=1)
{
	; while !${Actor[Query,(Type=="Tradeskill Unit" && Distance<=4) || (Name=-"Dalnir's Forge" && Distance <15)](exists)}
	; {
		; MessageBox -skin eq2 "You must be within 4 of a tradeskill device, please move closer and unpause"
		; MainArrayCounter:Set[${Math.Calc[${MainArrayCount}-2]}]
		; RI_Var_Bool_Paused:Set[TRUE]
		; UIElement[Start@RI]:SetText[Resume]
		; while ${RI_Var_Bool_Paused}
		; {
			; wait 1
		; }
		; wait 5
	; }
	variable int _counter
	_counter:Set[1]
	if !${Me.Recipe["${_Recipe}"](exists)} && !${Me.Recipe[1](exists)}
	{
		EQ2Execute /toggletradeskills
		wait 50 ${Me.Recipe["${_Recipe}"](exists)}
		EQ2Execute /toggletradeskills
	}
	wait 5
	
	while !${Me.Recipe["${_Recipe}"](exists)} && ${_counter:Inc}<=6
	{
		EQ2Execute /toggletradeskills
		wait 50 ${Me.Recipe["${_Recipe}"](exists)}
		EQ2Execute /toggletradeskills
	}
	;first check our resources
	if ${Me.Recipe[${_Recipe}](exists)}
	{
		;make sure we have the components needed
		wait 50 ${Me.Recipe[${_Recipe}].IsRecipeInfoAvailable}
		if ${Me.Recipe[${_Recipe}].IsRecipeInfoAvailable}
		{
			if ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent1.Name.NotEqual[N/A]}
			{
				while ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent1.QuantityOnHand} < ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent1.Quantity}
				{
					MessageBox -skin eq2 "You need ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent1.Quantity} of ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent1.Name} and only have ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent1.QuantityOnHand}"
					eq2ex start_broker
					wait 10
				}
			}
			if ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent2.Name.NotEqual[N/A]}
			{
				while ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent2.QuantityOnHand} < ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent2.Quantity}
				{
					MessageBox -skin eq2 "You need ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent2.Quantity} of ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent2.Name} and only have ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent2.QuantityOnHand}"
					eq2ex start_broker
					wait 10
				}
			}
			if ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent3.Name.NotEqual[N/A]}
			{
				while ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent3.QuantityOnHand} < ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent3.Quantity}
				{
					MessageBox -skin eq2 "You need ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent3.Quantity} of ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent3.Name} and only have ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent3.QuantityOnHand}"
					eq2ex start_broker
					wait 10
				}
			}
			if ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent4.Name.NotEqual[N/A]}
			{
				while ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent4.QuantityOnHand} < ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent4.Quantity}
				{
					MessageBox -skin eq2 "You need ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent4.Quantity} of ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent4.Name} and only have ${Me.Recipe[${_Recipe}].ToRecipeInfo.BuildComponent4.QuantityOnHand}"
					eq2ex start_broker
					wait 10
				}
			}
			while ${Me.Recipe[${_Recipe}].ToRecipeInfo.Fuel.QuantityOnHand} < ${Me.Recipe[${_Recipe}].ToRecipeInfo.Fuel.Quantity}
			{
				MessageBox -skin eq2 "You need ${Me.Recipe[${_Recipe}].ToRecipeInfo.Fuel.Quantity} of ${Me.Recipe[${_Recipe}].ToRecipeInfo.Fuel.Name} and only have ${Me.Recipe[${_Recipe}].ToRecipeInfo.Fuel.QuantityOnHand}"
				eq2ex start_broker
				wait 10
			}
		}
		else
		{
			MessageBox -skin eq2 "We were unable to retrieve recipe info"
			Script:End
		}
	}
	else
	{
		MessageBox -skin eq2 "Can not find Recipe: ${_Recipe}"
		Script:End
	}
	
	;start craft lite no ui
	if !${Script[Buffer:Craft](exists)} || !${Script[EQ2Craft](exists)}
		craft -lite -hideui
	
	if !${Me.Recipe[1](exists)}
		wait 60
	else
		wait 10
	if ${MainQuestName.Get[${MainQuestName.Used}].NotEqual[Containing the Stone]} && ${MainQuestName.Get[${MainQuestName.Used}].NotEqual[Forging Onwards]}
	{
		Actor[Query,Type=="Tradeskill Unit"]:DoTarget
		Actor[Query,Type=="Tradeskill Unit"]:DoubleClick
	}
	wait 5
	;create recipes
	variable int _count
	for(_count:Set[1];${_count}<=${_Amount};_count:Inc)
	{
		Me.Recipe["${_Recipe}"]:Create
		wait 10
		EQ2UIPage[Tradeskills,Tradeskills].Child[button,Tradeskills.TabPages.Craft.Prepare.SummaryPage.BeginButton]:LeftClick
		wait 50 ${C.Q}<1
		wait 6000 ${C.Q}>3
		wait 10
	}

	relay "${RI_Var_String_RelayGroup}" eq2ex /hide_window TradeSkills.TradeSkills
}
function ScribeBook(string _BookName)
{
	wait 10
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:ScribeBook[ALL,"${_BookName}"]
	wait 2
	relay "${RI_Var_String_RelayGroup}" RIMUIObj:ScribeBook[ALL,"${_BookName}"]
	wait 5
}
function SokokarTimelineCrafting()
{
	if ${QuestJournalWindow.CompletedQuest["Fangs Away!"](exists)} && ${QuestJournalWindow.CompletedQuest["An Eye in the Sky"](exists)} && ${QuestJournalWindow.CompletedQuest["Sticking My Ore In"](exists)} && ${QuestJournalWindow.CompletedQuest["Preparations for the Rescue"](exists)} && ${QuestJournalWindow.CompletedQuest["Is It Good News?"](exists)}
	{
		;show messagebox 
		MessageBox -skin eq2 "You have already completed the Sokokar Timeline Crafting"
		Script:End
	}
	if ${Me.TSLevel}<65
	{
		;show messagebox 
		MessageBox -skin eq2 "You must be Tradeskill Level 65 or higher to start this timeline"
		Script:End
	}
	if ${Me.Inventory[Query,Location=="Inventory" && Name=="ferrite cluster"].Quantity}<38
	{
		;show messagebox 
		MessageBox -skin eq2 "You must have at least 38 ferrite cluster in your inventory"
		eq2ex start_broker
		Script:End
	}
	if ${Me.Inventory[Query,Location=="Inventory" && Name=-"redwood lumber"].Quantity}<28
	{
		;show messagebox 
		MessageBox -skin eq2 "You must have at least 28 redwood lumber in your inventory"
		eq2ex start_broker
		Script:End
	}
	if ${Me.Inventory[Query,Location=="Inventory" && Name=-"smoldering coal"].Quantity}<28
	{
		;show messagebox 
		MessageBox -skin eq2 "You must have at least 70 Smoldering Coal in your inventory"
		eq2ex start_broker
		Script:End
	}
	
	;call SKTimelineStarter
	
	echo ISXRI: Starting Sokokar Timeline (Crafting)
	
	;call RIMObj.Move 836 12 252 1 0 FALSE FALSE TRUE FALSE
	
	wait 20
	
	;if not completed "Fangs Away!"
	if !${QuestJournalWindow.CompletedQuest["Fangs Away!"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["Fangs Away!"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Fangs Away!"]:Delete
			wait 5
		}
		call QuestDefault FangsAway
	}
	else
		echo ISXRI: Fangs Away! already Completed moving on
		
	;if not completed "An Eye in the Sky"
	if !${QuestJournalWindow.CompletedQuest["An Eye in the Sky"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["An Eye in the Sky"](exists)}
		{
			QuestJournalWindow.ActiveQuest["An Eye in the Sky"]:Delete
			wait 5
		}
		call QuestDefault AnEyeintheSky
	}
	else
		echo ISXRI: An Eye in the Sky already Completed moving on
		
	;if not completed "Sticking My Ore In"
	if !${QuestJournalWindow.CompletedQuest["Sticking My Ore In"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["Sticking My Ore In"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Sticking My Ore In"]:Delete
			wait 5
		}
		call QuestDefault StickingMyOreIn
	}
	else
		echo ISXRI: Sticking My Ore In already Completed moving on
		
	;if not completed "Preperations for the Rescue"
	if !${QuestJournalWindow.CompletedQuest["Preparations for the Rescue"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["Preparations for the Rescue"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Preparations for the Rescue"]:Delete
			wait 5
		}
		
		call QuestDefault PreperationsfortheRescue
	}
	else
		echo ISXRI: Preperations for the Rescue already Completed moving on
		
	;if not completed "Is It Good News?"
	if !${QuestJournalWindow.CompletedQuest["Is It Good News?"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["Is It Good News?"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Is It Good News?"]:Delete
			wait 5
		}
		
		call QuestDefault IsItGoodNews
		
	}
	else
		echo ISXRI: Is It Good News? already Completed timeline done!
		
	echo ISXRI: Ending Sokokar Timeline (Crafting)
}
function Quest(string _QuestName, int _ElementToJumpTo=0, bool _CheckQuestCompleted=TRUE)
{
	MainQuestName:Insert["${_QuestName}"]
	
	;echo Start of Quest: MainQuestName Size: ${MainQuestName.Used}
	press -release ${RI_Var_String_ForwardKey}
	variable string _ConvertedQuestName
	;echo ${_QuestName} // ${ElementToJumpTo}
	if ${_ElementToJumpTo}==0
		variable int _OriginalMAC=${MainArrayCounter}
	if ${_QuestName.Equal[101 Things to Do With a Dead Grindhoof]}
		_ConvertedQuestName:Set["ThingstoDoWithaDeadGrindhoof"]
	else
		_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
	
	RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}
	
	if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
		call PreGo "${_ConvertedQuestName.Upper}" 0
	else
		ImportZoneFile "${_ConvertedQuestName}" 0
	
	_QuestName:Set[${istrMain.Get[1]}]
	variable int _GiveUpCNT=0
	while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual[${_QuestName.Replace[\",""]}]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
	{
		squelch QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
		squelch wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
	}
	_ConvertedQuestName:Set["${_QuestName.Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
	;echo ${_QuestName} // \${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)} // ${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}
	variable bool _Repeatable
	if ${istrMain.Get[2].Equal[Repeatable]}
		_Repeatable:Set[TRUE]
	if ${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)} && !${_Repeatable}
	{
		;MessageBox -skin eq2 "${_QuestName} is already completed"
		echo ISXRI: ${_QuestName.Replace[\",""]} already Completed moving on
		;skip here
		_QuestName:Set["${MainQuestName.Get[${Math.Calc[${MainQuestName.Used}-1]}]}"]
		
		_GiveUpCNT:Set[0]
		while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual["${_QuestName.Replace[\",""]}"]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
		{
			QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
			wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
		}
		_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
		
		RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}
		
		if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
			call PreGo "${_ConvertedQuestName.Upper}" 0
		else
			ImportZoneFile "${_ConvertedQuestName}" 0
		if ${_ElementToJumpTo}==0
			MainArrayCounter:Set[${_OriginalMAC}]
		else
			MainArrayCounter:Set[${_ElementToJumpTo}]
		
		;echo Setting ${_ElementToJumpTo} its now ${MainArrayCounter}
		MainQuestName:Remove[${MainQuestName.Used}]
		MainQuestName:Collapse
		;echo End of Quest: MainQuestName Size: ${MainQuestName.Used}
		return
	}
	else
	{
		echo ISXRI: Starting ${_QuestName.Replace[\",""]}
		
		call Go TRUE
		
		echo ISXRI: Ending ${_QuestName.Replace[\",""]}
		
		RI_CMD_Hidden_RemoveTLO ${_ConvertedQuestName.Upper}
	}
	if ${_CheckQuestCompleted} && !${_QuestName.Replace[\",""].Find["Access to Tower of the Four Winds"](exists)} && !${_QuestName.Replace[\",""].Find["Yun Zi"](exists)} && !${_QuestName.Replace[\",""].Find[Timeline](exists)} && !${_QuestName.Replace[\",""].Find["Losers Weepers"](exists)} && !${_QuestName.Replace[\",""].Find["New Lands New Profits"](exists)}
	{
		squelch wait 100 ${QuestJournalWindow.CompletedQuest[${_QuestName}](exists)}
		;echo \${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}  \\  ${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}
		if !${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}
			call MessageBox "Quest: ${_QuestName.Replace[\",""]} not showing completed, check steps and finish manually and resume rq at ${Me.Loc}"
	}
	_QuestName:Set["${MainQuestName.Get[${Math.Calc[${MainQuestName.Used}-1]}]}"]
	
	_GiveUpCNT:Set[0]
	while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual["${_QuestName.Replace[\",""]}"]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
	{
		Squelch QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
		Squelch wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
	}
	_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
	
	RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}
	
	if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
		call PreGo "${_ConvertedQuestName.Upper}" 0
	else
		ImportZoneFile "${_ConvertedQuestName}" 0
		
	;if ${_ElementToJumpTo}==0
		MainArrayCounter:Set[${_OriginalMAC}]
	;else
	;	MainArrayCounter:Set[${_ElementToJumpTo}]
	
	;echo Set MainArrayCounter back to ${MainArrayCounter}
	MainQuestName:Remove[${MainQuestName.Used}]
	MainQuestName:Collapse
	;echo End of Quest: MainQuestName Size: ${MainQuestName.Used}
	if ${Me.IsMoving}
	{
		press -release ${RI_Var_String_ForwardKey}
	}
	
}
function QuestRepeat(string _QuestName, int _NumRepeats=1, int _ElementToJumpTo=0)
{
	MainQuestName:Insert["${_QuestName}"]
	variable int _qcount=1
	for(_qcount:Set[1];${_qcount}<=${_NumRepeats};_qcount:Inc)
	{
		;echo Start of Quest: MainQuestName Size: ${MainQuestName.Used}
		press -release ${RI_Var_String_ForwardKey}
		variable string _ConvertedQuestName
		;echo ${_QuestName} // ${ElementToJumpTo}
		if ${_ElementToJumpTo}==0
			variable int _OriginalMAC=${MainArrayCounter}
		if ${_QuestName.Equal[101 Things to Do With a Dead Grindhoof]}
			_ConvertedQuestName:Set["ThingstoDoWithaDeadGrindhoof"]
		else
			_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
		
		RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}
		
		if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
			call PreGo "${_ConvertedQuestName.Upper}" 0
		else
			ImportZoneFile "${_ConvertedQuestName}" 0
		
		_QuestName:Set[${istrMain.Get[1]}]
		variable int _GiveUpCNT=0
		while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual[${_QuestName.Replace[\",""]}]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
		{
			squelch QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
			squelch wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
		}
		_ConvertedQuestName:Set["${_QuestName.Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
		;echo ${_QuestName} // \${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)} // ${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}
		variable bool _Repeatable
		if ${istrMain.Get[2].Equal[Repeatable]}
			_Repeatable:Set[TRUE]
		
		echo ISXRI: Starting ${_QuestName.Replace[\",""]}
		
		call Go TRUE
		
		echo ISXRI: Ending ${_QuestName.Replace[\",""]}
		
		if ${Me.IsMoving}
		{
			press -release ${RI_Var_String_ForwardKey}
		}
	}
	
	RI_CMD_Hidden_RemoveTLO ${_ConvertedQuestName.Upper}

	_QuestName:Set["${MainQuestName.Get[${Math.Calc[${MainQuestName.Used}-1]}]}"]
	
	_GiveUpCNT:Set[0]
	while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual["${_QuestName.Replace[\",""]}"]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
	{
		Squelch QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
		Squelch wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
	}
	_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
	
	RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}
	
	if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
		call PreGo "${_ConvertedQuestName.Upper}" 0
	else
		ImportZoneFile "${_ConvertedQuestName}" 0
		
	;if ${_ElementToJumpTo}==0
		MainArrayCounter:Set[${_OriginalMAC}]
	;else
	;	MainArrayCounter:Set[${_ElementToJumpTo}]
	
	;echo Set MainArrayCounter back to ${MainArrayCounter}
	MainQuestName:Remove[${MainQuestName.Used}]
	MainQuestName:Collapse
	;echo End of Quest: MainQuestName Size: ${MainQuestName.Used}
	
	if ${Me.IsMoving}
	{
		press -release ${RI_Var_String_ForwardKey}
	}
}
function SetActiveQuest(string _QuestName)
{
	variable int _GiveUpCNT=0
	while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual[${_QuestName.Replace[\",""]}]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
	{
		QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
		wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
	}
}
function QuestDefault(string _QuestName, int _ElementToJumpTo=0, bool _CheckQuestCompleted=TRUE)
{
	variable string _ConvertedQuestName
	MainQuestName:Insert["${_QuestName}"]
	if ${_QuestName.Equal[101 Things to Do With a Dead Grindhoof]}
		_ConvertedQuestName:Set["ThingstoDoWithaDeadGrindhoof"]
	else
		_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]
	;open dat or var and do all of it
	;echo ${_QuestName}  //  ${_QuestName.Replace[" ",""].Replace["?",""]}
	
	RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}
	
	if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
		call PreGo "${_ConvertedQuestName.Upper}"
	else
		ImportZoneFile "${_ConvertedQuestName}"
	
	_QuestName:Set[${istrMain.Get[1]}]
	
	variable int _GiveUpCNT=0
	while ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].NotEqual[${_QuestName.Replace[\",""]}]} && ${QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"](exists)} && ${_GiveUpCNT:Inc}<=10
	{
		Squelch QuestJournalWindow.ActiveQuest["${_QuestName.Replace[\",""]}"]:MakeCurrentActiveQuest
		Squelch wait 5 ${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Equal[${_QuestName}]}
	}
	
	variable bool _Repeatable
	if ${istrMain.Get[2].Equal[Repeatable]}
		_Repeatable:Set[TRUE]
	
	if ${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)} && !${_Repeatable}
	{
		;MessageBox -skin eq2 "${_QuestName} is already completed"
		echo ISXRI: ${_QuestName.Replace[\",""]} already Completed moving on
		;skip here
		if ${_ElementToJumpTo}>0
			MainArrayCounter:Set[${_ElementToJumpTo}]
		return
	}
	echo ISXRI: Starting ${_QuestName.Replace[\",""]}
	
	call Go TRUE
	
	echo ISXRI: Ending ${_QuestName.Replace[\",""]}
	
	RI_CMD_Hidden_RemoveTLO ${_ConvertedQuestName.Upper}
	
	MainQuestName:Clear	
	if ${Me.IsMoving}
	{
		press -release ${RI_Var_String_ForwardKey}
	}
	
	if ${_CheckQuestCompleted} && !${_QuestName.Replace[\",""].Find["Yun Zi"](exists)} && !${_QuestName.Replace[\",""].Find[Timeline](exists)} && !${_QuestName.Replace[\",""].Find["Losers Weepers"](exists)} && !${_QuestName.Replace[\",""].Find["New Lands New Profits"](exists)}
	{
		squelch wait 100 ${QuestJournalWindow.CompletedQuest[${_QuestName}](exists)}
		;echo \${QuestJournalWindow.CompletedQuest[${_QuestName.Replace[\",""]}](exists)}  \\  ${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}
		if !${QuestJournalWindow.CompletedQuest["${_QuestName.Replace[\",""]}"](exists)}
			call MessageBox "Quest: ${_QuestName.Replace[\",""]} not showing completed, check steps and finish manually and resume rq at ${Me.Loc}"
	}
}
function CheckActiveQuest(string _QuestName, int _Element=0, bool _Pause=FALSE, string _Message="We were unable to get the quest. Get it and resume")
{
	;echo checking quest: ${_QuestName}: ${QuestJournalWindow.ActiveQuest["${_QuestName}"](exists)} and MAC: ${MainArrayCounter}
	if ${QuestJournalWindow.ActiveQuest["${_QuestName}"](exists)}
	{
		if ${_Element}!=0 && !${_Pause}
			MainArrayCounter:Set[${_Element}]
	}
	else
	{
		if ${_Pause}
		{
			if ${_Element}!=0
				MainArrayCounter:Set[${_Element}]
			call MessageBox "${_Message}"
		}
	}
	;echo MAC: ${MainArrayCounter}
}
function SKTimelineStarter()
{
	call QuestStarter 835 12 253 25 "Kylong Plains" "Kylong Plains"

	if ${Math.Distance[${Me.Loc},1026.497314,2.487710,363.238342]}<50
	{
		call RIMObj.Move 1000.098389 2.487606 336.962097 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 992.919067 2.487540 329.848999 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 985.499207 2.487472 322.497101 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 978.056396 2.487402 315.122681 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 970.714478 2.487335 307.810211 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 963.571533 2.487268 300.672333 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 956.451965 5.243187 293.557831 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 949.448975 8.025568 286.559845 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 942.329285 8.490232 279.445343 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 935.209656 8.541517 272.330780 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 928.101624 10.597463 265.227844 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 920.958557 12.213704 258.089996 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 913.792358 12.213704 250.928864 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 905.560059 12.070804 245.095123 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 895.471375 12.070803 244.195068 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 885.174805 12.070807 244.981842 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 875.232056 12.070809 246.316345 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 865.170410 12.070811 247.864594 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 855.164246 12.070813 249.336899 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 845.270020 12.070813 250.885101 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 840.914307 12.070807 251.647583 1 0 FALSE FALSE TRUE TRUE
	}
	elseif ${Math.Distance[${Me.Loc},843.804749,2.524284,419.947662]}<50
	{
		call RIMObj.Move 843.817200 2.487676 393.542633 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.430481 2.487610 383.413635 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.934692 2.457964 373.229218 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.855103 2.476295 363.214691 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.662964 2.487411 353.135040 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.471985 2.487345 343.121460 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.275940 2.487278 332.843903 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.086426 4.795813 322.912750 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.905823 7.531281 313.179443 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.840271 8.490232 303.164063 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.777649 8.490232 292.868103 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.716309 10.281334 282.786743 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.655640 12.213704 272.787781 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.127686 12.213705 262.661926 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 841.796814 12.070813 252.741623 1 0 FALSE FALSE TRUE FALSE
	}
	else
	{
		MessageBox -skin eq2 "We are on neither Dock of Kylong Plains and unable to move to Jones (835, 12, 253), please move to Jones (835, 12, 253) and re run"
		Script:End
	}

	if ${Math.Distance[${Me.Loc},835,12,253]}>25
	{
		MessageBox -skin eq2 "We were unable to move to Jones (835, 12, 253), please move to Jones (835, 12, 253) and re run"
		Script:End
	}
}
function NewLandsNewProfitsStarter()
{
    call QuestStarter 2116 520 -912 25 "Kylong Plains" "Kylong Plains" 0
	if ${Math.Distance[${Me.Loc},1026.497314,2.487710,363.238342]}<50
	{
		call RIMObj.Move 1000.098389 2.487606 336.962097 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 992.919067 2.487540 329.848999 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 985.499207 2.487472 322.497101 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 978.056396 2.487402 315.122681 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 970.714478 2.487335 307.810211 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 963.571533 2.487268 300.672333 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 956.451965 5.243187 293.557831 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 949.448975 8.025568 286.559845 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 942.329285 8.490232 279.445343 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 935.209656 8.541517 272.330780 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 928.101624 10.597463 265.227844 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 920.958557 12.213704 258.089996 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 913.792358 12.213704 250.928864 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 905.560059 12.070804 245.095123 1 0 FALSE FALSE TRUE TRUE
	}
	elseif ${Math.Distance[${Me.Loc},843.804749,2.524284,419.947662]}<50
	{
		call RIMObj.Move 843.817200 2.487676 393.542633 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.430481 2.487610 383.413635 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.934692 2.457964 373.229218 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.855103 2.476295 363.214691 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.662964 2.487411 353.135040 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.471985 2.487345 343.121460 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.275940 2.487278 332.843903 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.086426 4.795813 322.912750 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.905823 7.531281 313.179443 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.840271 8.490232 303.164063 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.777649 8.490232 292.868103 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.716309 10.281334 282.786743 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.655640 12.213704 272.787781 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 843.127686 12.213705 262.661926 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 841.796814 12.070813 252.741623 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 873.479736 12.070809 245.388855 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 905.560059 12.070804 245.095123 1 0 FALSE FALSE TRUE TRUE
	}
	else
	{
		MessageBox -skin eq2 "We are on neither Dock of Kylong Plains and unable to move to Taskmaster Greeblentus (2115,520,-912), please move to Taskmaster Greeblentus (2115,520,-912) and re run"
		Script:End
	}
	;now move to SokoKar if 
	if ${QuestJournalWindow.CompletedQuest["Is It Good News?"](exists)} || ${QuestJournalWindow.CompletedQuest["Here in my Sokokar I Feel Safest of All"](exists)}
	{
		call RIMObj.Move 909.371582 12.070813 233.928955 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 909.673889 12.070813 223.827698 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 910.139526 12.070812 213.710434 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 910.957764 12.070813 203.552917 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 911.877502 12.070814 193.533051 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 912.815674 12.070812 183.352921 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 913.743591 10.952544 173.285172 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 913.768982 10.002501 163.203308 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 908.838928 10.002500 154.407532 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 901.575928 10.159660 147.190842 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 898.023926 10.239155 143.789261 1 0 FALSE FALSE TRUE FALSE
		wait 20
		Actor[a sokokar tamer]:DoFace
		Actor[a sokokar tamer]:DoTarget
		eq2ex apply_verb ${Actor[a sokokar tamer].ID} hail
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		call TravelMap "Teren's Grasp Post" 0
		wait 600 ${Me.IsMoving}
		wait 1200 !${Me.IsMoving}
		wait 10
		
	}
	else
	{
		call RIMObj.Move 896.857422 89.991859 201.492645 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 899.051025 125.442322 173.892395 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 921.449829 161.002945 146.346146 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 948.308350 194.949692 120.974899 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 982.909546 212.605133 89.359772 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1009.422119 247.619980 65.122482 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1044.474854 263.499725 33.079937 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1075.263550 291.120148 4.934069 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1110.369629 307.024750 -27.158226 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1139.463623 338.190216 -53.755089 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1171.969604 362.031067 -83.470192 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1207.131592 377.960480 -115.612411 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1242.279541 393.883789 -147.742081 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1277.374023 409.782104 -179.821793 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1312.550537 424.027771 -212.561508 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1347.267700 432.372009 -247.778595 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1381.752563 439.349152 -283.718781 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1415.566040 445.112793 -320.205383 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1436.721680 447.579376 -365.718842 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1456.062134 450.509216 -411.922729 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1475.402222 453.439301 -458.126556 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1494.755127 456.372314 -504.365906 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1514.085938 459.301575 -550.551636 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1533.433716 462.232819 -596.773865 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1557.989746 465.173248 -640.301392 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1587.452881 468.104492 -680.831055 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1616.910156 469.963104 -721.345032 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1646.417603 469.963104 -761.919861 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1675.503662 469.963104 -803.009705 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1701.412109 469.963104 -846.112427 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1727.210205 469.963104 -889.031067 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1745.873169 470.103485 -919.990051 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1792.389160 488.883209 -920.436340 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1842.755493 488.883209 -920.919983 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1892.452515 494.453796 -920.275208 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1938.683472 494.453796 -900.265686 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1974.703979 494.552795 -881.582458 1 0 FALSE FALSE TRUE TRUE
	}
	call RIMObj.Move 1989.776855 494.081390 -884.589722 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 2016.781616 522.399109 -882.945251 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 2065.376221 534.184692 -881.833252 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 2107.165283 522.143860 -906.675232 1 0 FALSE FALSE TRUE FALSE
	wait 20
	call RIMObj.FlyDown
	wait 5
	call RIMObj.Move 2115.739990 520.002502 -911.474976 1 0 FALSE FALSE TRUE FALSE
	wait 20
}
function QuestStarter(float _X, float _Y, float _Z, int _Distance, string _ZoneName, string _ZoneToZoneName, int _ArrayCounterSetter, int _ZoneToDeviceOption=1, int _DoorOption=0, bool _CheckZone=TRUE)
{
	if ${Math.Distance[${Me.Loc},${_X},${_Y},${_Z}]}<${_Distance}
	{	
		MainArrayCounter:Set[${_ArrayCounterSetter}]
		;echo we are already at the loc setting our array counter to: ${_ArrayCounterSetter} its now: ${MainArrayCounter}
		return
	}
	if ( ${Math.Distance[${Me.Loc},${_X},${_Y},${_Z}]}>${_Distance} || !${Zone.Name.Find[${_ZoneName}](exists)} ) && !${Me.Ability[id,3266969222].IsReady} && !${Zone.ShortName.Find[guildhall](exists)}
	{
		;show messagebox 
		MessageBox -skin eq2 "We are not within ${_Distance} of ${_X},${_Y},${_Z} in ${_ZoneName}, waiting for Call to Guild Hall to be ready or for us to be in our guild hall"
		while !${Me.Ability[id,3266969222].IsReady} && !${Zone.ShortName.Find[guildhall](exists)} 
			wait 10
		while ${EQ2.Zoning}!=0 
			wait 10
		wait 20
	}
	if ( ${Math.Distance[${Me.Loc},${_X},${_Y},${_Z}]}>${_Distance} || !${Zone.Name.Find[${_ZoneName}](exists)} ) && ( ${Me.Ability[id,3266969222].IsReady} || ${Zone.ShortName.Find[guildhall](exists)} }
	{
		if !${Zone.ShortName.Find[guildhall](exists)}
		{
			while ${Me.Ability[id,3266969222].IsReady}
			{
				Me.Ability[id,3266969222]:Use
				wait 5
			}
		
			wait 600 ${EQ2.Zoning}==1
			wait 600 ${EQ2.Zoning}==0
			wait 600 ${Zone.ShortName.Find[guildhall](exists)}
			wait 10
			if !${Zone.ShortName.Find[guildhall](exists)}
			{
				MessageBox -skin eq2 "We attempted to Call to Guild Hall but did not end up in the Guild Hall"
				Script:End
			}
		}
		if !${Actor[Query, Name=="Ole Salt's Mariner Bell" && Distance<=13](exists)} && !${Actor[Query, Name=="Navigator's Globe of Norrath" && Distance<=13](exists)} && !${Actor[Query, Name=="Pirate Captain's Helmsman" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
		{
			MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Travel Bell within 13"
			Script:End
		}
		;echo call TravelMap "${_ZoneToZoneName}" ${_DoorOption} ${_ZoneToDeviceOption}

		call TravelMap "${_ZoneToZoneName}" ${_DoorOption} ${_ZoneToDeviceOption}

		if !${Zone.Name.Find[${_ZoneToZoneName}](exists)} && ${_CheckZone}
		{
			MessageBox -skin eq2 "We were unable to succesfully zone to ${_ZoneToZoneName}, please try again or zone there manually"
			Script:End
		}
	}
}
function FensBellToBathezidsWatchCraft()
{
	call QuestStarter 1197.725586 203.421692 1442.044189 35 "Fens of Nathsar" "Fens of Nathsar"
	if ${Math.Distance[${Me.Loc},182.752274,-118.825874,-158.184448]}<50
	{
		call RIMObj.Move 182.752274 -118.825874 -158.184448 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 189.500046 -76.626198 -131.689743 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 201.475876 -44.594776 -95.034386 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 213.361115 -9.151187 -61.774502 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 225.741119 26.334534 -28.653875 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 241.661316 59.083679 5.769442 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 266.695892 73.750237 46.835613 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 286.071259 107.386559 78.757782 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 311.839294 114.868080 121.213387 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 337.637878 122.358490 163.719391 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 363.396240 129.836670 206.158112 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 389.164886 137.317108 248.613571 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 414.934052 144.797546 291.070099 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 444.368988 147.208221 331.497040 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 479.681610 148.868683 367.087799 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 514.994446 150.529068 402.678467 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 550.088318 156.106216 438.048645 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 575.057129 191.577209 463.215088 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 609.232910 199.912796 499.051178 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 645.093872 201.669296 534.036072 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 684.437012 201.279160 565.148132 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 724.400818 200.810272 595.387268 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 764.501465 200.337875 625.660583 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 804.595459 200.015106 655.870300 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 844.628052 200.017410 686.002258 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 884.756226 200.019730 716.205627 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 924.741089 200.022034 746.301819 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 964.821350 200.024323 776.469604 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1004.809265 202.176712 806.567810 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1041.953979 221.539673 834.239075 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1085.791626 225.180954 858.682495 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1129.484619 226.892288 883.026978 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1173.125000 226.901123 907.566589 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1216.766357 226.909409 932.442261 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1247.772339 226.909409 971.841858 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1269.291870 226.909409 1017.175537 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1290.735107 226.909409 1062.345215 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1305.667236 226.909409 1110.092773 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1291.856689 232.418411 1158.177368 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1260.651733 232.418411 1197.477173 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1222.971558 232.418411 1230.553711 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1181.469482 232.418411 1258.689209 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1141.247925 230.068634 1288.561768 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1103.266724 222.742157 1320.639282 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1080.702148 217.886749 1339.476074 1 0 FALSE FALSE TRUE FALSE
		wait 20
		call RIMObj.FlyDown
		wait 5
		call RIMObj.Move 1068.066528 206.911804 1350.599976 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1053.230469 206.624649 1364.125366 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1056.158569 209.183655 1384.076416 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1064.725464 209.730896 1402.462891 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1073.445801 209.730896 1420.521729 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1081.434204 209.730896 1439.045166 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1094.479736 206.614563 1454.313354 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1111.055786 206.614563 1465.709473 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1124.023926 206.614563 1474.625244 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1142.513428 206.614563 1466.377441 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1160.938965 206.614563 1457.715454 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1179.347290 206.614563 1449.597534 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1191.312988 203.421692 1443.039429 1 0 FALSE FALSE TRUE TRUE
		call RIMObj.Move 1197.725586 203.421692 1442.044189 1 0 FALSE FALSE TRUE TRUE
	}
	elseif ${Math.Distance[${Me.Loc},1197.725586,203.421692,1442.044189]}<50
	{
		return
	}
	else
	{
		MessageBox -skin eq2 "We are unable to move to Quest Giver, please move to Quest Giver and re run"
		Script:End
	}
}
variable(global) string BWFactionRecipeName
function BathezidsWatchFactionCrafting()
{
	if !${RIMUIObj.FactionsInitialized}
	{
		echo ISXRI: Initializing Faction Data
		wait 100 ${RIMUIObj.FactionsInitialized}
		echo ISXRI: Done Initializing Faction Data
	}
	wait 50
	if ${RIMUIObj.FactionAmount[Bathezid's Watch]}>-20000
	{
		;show messagebox 
		MessageBox -skin eq2 "You have enough faction to start Artisan Epic Timeline"
		Script:End
	}
	if ${Me.TSLevel}<70
	{
		;show messagebox 
		MessageBox -skin eq2 "You must be Tradeskill Level 70 or higher to start this timeline"
		Script:End
	}
	;check Fuels and Resource Quantities for each TSClass, Fuel = 810 Resources = 648
	; Outiftters (Armorer, Weaponsmith, Tailor)
	; lichenclover root, bristled pelt, redwood lumber, ferrite cluster, rough kunzite
	; Fuel: smoldering filament and smoldering coal
	; Craftsman (Carpenter, Woodworker, Provisioner)
	; lichenclover root, raw succulent petal, raw cranberry, Torsis tea leaf, king prawn, Cabilis cocoa bean, redwood lumber, deklium cluster, ferrite cluster, bristled pelt
	; Fuel: Aerated mineral water, Dough, smoldering kindling, smoldering sandpaper and smoldering coal
	; Scholar (Alchemist, Jeweler, Sage)
	; lichenclover root, Mineral salt loam, Rough kunzite, Deklium cluster, redwood lumber, deklium cluster , ferrite cluster
	; Fuel: Smoldering candle, smoldering coal, smoldering incense
	RI_Var_Bool_SSSInScript:Set[TRUE]
	RI_Var_Bool_SSSGTG:Set[FALSE]
	switch ${Me.TSClass}
	{
		case outfitter
		{
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "lichenclover root" 648 "bristled pelt" 648 "redwood lumber" 648 "ferrite cluster" 648 "rough kunzite" 648
				call RemoveFromDepot "Fuel Depot" "smoldering filament" 810 "smoldering coal" 810
				call CheckPreReqs -itemqty "lichenclover root" 648 -itemqty "bristled pelt" 648 -itemqty "redwood lumber" 648 -itemqty "ferrite cluster" 648 -itemqty "rough kunzite" 648 -itemqty "smoldering filament" 810 -itemqty "smoldering coal" 810
				wait 5
			}
			break
		}
		case craftsman
		{
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "lichenclover root" 648 "raw succulent petal" 648 "raw cranberry" 648 "Torsis tea leaf" 648 "king prawn" 648 "Cabilis cocoa bean" 648 "redwood lumber" 648 "deklium cluster" 648 "ferrite cluster" 648 "bristled pelt" 648
				call RemoveFromDepot "Fuel Depot" "aerated mineral water" 810 "Dough" 810 "smoldering kindling" 810 "smoldering sandpaper" 810 "smoldering coal" 810
				call CheckPreReqs -itemqty "lichenclover root" 648 -itemqty "raw succulent petal" 648 -itemqty "raw cranberry" 648 -itemqty "Torsis tea leaf" 648 -itemqty "king prawn" 648 -itemqty "Cabilis cocoa bean" 648 -itemqty "redwood lumber" 648 -itemqty "deklium cluster" 648 -itemqty "ferrite cluster" 648 -itemqty "bristled pelt" 648 -itemqty "aerated mineral water" 810 -itemqty "Dough" 810 -itemqty "smoldering kindling" 810 -itemqty "smoldering sandpaper" 810 -itemqty "smoldering coal" 810
				wait 5
			}
			break
		}
		case scholar
		{
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "lichenclover root" 648 "mineral salt loam" 648 "rough kunzite" 648 "deklium cluster" 648 "redwood lumber" 648 "ferrite cluster" 648
				call RemoveFromDepot "Fuel Depot" "smoldering candle" 810 "smoldering coal" 810 "smoldering incense" 810
				call CheckPreReqs -itemqty "lichenclover root" 648 -itemqty "mineral salt loam" 648 -itemqty "rough kunzite" 648 -itemqty "deklium cluster" 648 -itemqty "redwood lumber" 648 -itemqty "ferrite cluster" 648 -itemqty "smoldering candle" 810 -itemqty "smoldering coal" 810 -itemqty "smoldering incense" 810
				wait 5
			}
			break
		}
	}
	call FensBellToBathezidsWatchCraft
	call RIMObj.Move 1202.758301 203.421692 1439.231201 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1184.667358 203.421692 1426.231445 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
	
	Event[EQ2_onQuestUpdate]:AttachAtom[EQ2_BWFonQuestUpdate]
	
	variable int _count
	variable int _Reps
	variable string CraftingStation

	if !${RIMUIObj.FactionsInitialized}
	{
		echo ISXRI: Initializing Faction Data
		wait 100 ${RIMUIObj.FactionsInitialized}
		echo ISXRI: Done Initializing Faction Data
	}
	wait 50
	; if ${RIMUIObj.FactionAmount[Bathezid's Watch]}==0
		; echo ISXRI: Your Bathezid's Watch Faction is 0 (or your faction was not read open your faction window and goto each dropdown and scroll all the way down)
	; else
		; echo ISXRI: Your Bathezid's Watch Faction is ${RIMUIObj.FactionAmount[Bathezid's Watch]}
		
	if ${RIMUIObj.FactionAmount[Bathezid's Watch]}==0 && ${QuestJournalWindow.CompletedQuest["New Lands, New Profits"](exists)}
	{
		MessageBox -skin eq2 "You have already completed New Lands, New Profits and your Bathezid's Watch faction is reporting 0, which means we are not reading it, open your faction window and goto each dropdown and scroll all the way down the re run"
		Script:End
	}
	
	;_Reps:Set[${Int[${Math.Calc[(-20000-${RIMUIObj.FactionAmount[Bathezid's Watch]})/750]}]}]
	;_Reps:Inc
	
	;echo ISXRI: Repeating Bathezid's Watch Tradeskill Writs ${_Reps} Times
	
	;for(_count:Set[1];${_count}<${_Reps};_count:Inc)
	while ${RIMUIObj.FactionAmount[Bathezid's Watch]}<-20000
	{
		if ${QuestJournalWindow.ActiveQuest["Bathezid Apprentice ${Me.TSClass} Work Requisition"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Bathezid Apprentice ${Me.TSClass} Work Requisition"]:Delete
			wait 5
		}
		if ${QuestJournalWindow.ActiveQuest["Bathezid Journeyman ${Me.TSClass} Work Requisition"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Bathezid Journeyman ${Me.TSClass} Work Requisition"]:Delete
			wait 5
		}
		if ${QuestJournalWindow.ActiveQuest["Bathezid Senior ${Me.TSClass} Work Requisition"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Bathezid Senior ${Me.TSClass} Work Requisition"]:Delete
			wait 5
		}
		if ${QuestJournalWindow.ActiveQuest["Bathezid Master ${Me.TSClass} Work Requisition"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Bathezid Master ${Me.TSClass} Work Requisition"]:Delete
			wait 5
		}
		echo ISXRI: Starting Bathezid Master Scholar Work Requisition, Current Faction: ${RIMUIObj.FactionAmount[Bathezid's Watch]}, Faction Needed: -20000
		;(${_count} of ${_Reps})
		CustomLoc:Set["0 0 0"]
		call HailActor Anuhadux 2 4
		wait 20
		Actor[tradeskill_work_order_desk]:DoubleClick
		wait 35
		if !${Me.Recipe[${BWFactionRecipeName}](exists)} && !${Me.Recipe[1](exists)}
		{
			EQ2Execute /toggletradeskills
			wait 50 ${Me.Recipe[1](exists)}
			EQ2Execute /toggletradeskills
		}
		if !${Me.Recipe[${BWFactionRecipeName}](exists)} && ${Me.Inventory[Query, Location=="Inventory" && Name=-"bathezid master ${Me.TSClass} recipes"](exists)}
			Me.Inventory[Query, Location=="Inventory" && Name=-"bathezid master ${Me.TSClass} recipes"]:Scribe
		wait 5
		if ${Me.Recipe[${BWFactionRecipeName}](exists)}
		{
			;make sure we have the components needed
			wait 300 ${Me.Recipe[${BWFactionRecipeName}].IsRecipeInfoAvailable}
			if ${Me.Recipe[${BWFactionRecipeName}].IsRecipeInfoAvailable}
			{
				if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent1.Name.NotEqual[N/A]}
				{
					if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent1.QuantityOnHand} < ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent1.Quantity}
					{
						MessageBox -skin eq2 "You need ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent1.Quantity} of ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent1.Name} and only have ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent1.QuantityOnHand}"
						eq2ex start_broker
						Script:End
					}
				}
				if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent2.Name.NotEqual[N/A]}
				{
					if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent2.QuantityOnHand} < ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent2.Quantity}
					{
						MessageBox -skin eq2 "You need ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent2.Quantity} of ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent2.Name} and only have ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent2.QuantityOnHand}"
						eq2ex start_broker
						Script:End
					}
				}
				if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent3.Name.NotEqual[N/A]}
				{
					if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent3.QuantityOnHand} < ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent3.Quantity}
					{
						MessageBox -skin eq2 "You need ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent3.Quantity} of ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent3.Name} and only have ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent3.QuantityOnHand}"
						eq2ex start_broker
						Script:End
					}
				}
				if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent4.Name.NotEqual[N/A]}
				{
					if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent4.QuantityOnHand} < ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent4.Quantity}
					{
						MessageBox -skin eq2 "You need ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent4.Quantity} of ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent4.Name} and only have ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.BuildComponent4.QuantityOnHand}"
						eq2ex start_broker
						Script:End
					}
				}
				if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Fuel.QuantityOnHand} < ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Fuel.Quantity}
				{
					MessageBox -skin eq2 "You need ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Fuel.Quantity} of ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Fuel.Name} and only have ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Fuel.QuantityOnHand}"
					eq2ex start_broker
					Script:End
				}
			}
			else
			{
				MessageBox -skin eq2 "We were unable to retrieve recipe info"
				Script:End
			}
		}
		else
		{
			variable int _rbcount
			_rbcount:Set[0]
			while ${Me.Inventory[Query, Location=="Inventory" && Name=-"bathezid master ${Me.TSClass} recipes"](exists)} && ${_rbcount:Inc}<30
			{
				Me.Inventory[Query, Location=="Inventory" && Name=-"bathezid master ${Me.TSClass} recipes"]:Scribe
				wait 10
			}
			if !${Me.Recipe[${BWFactionRecipeName}](exists)}
			{
				MessageBox -skin eq2 "Can not find Recipe: ${BWFactionRecipeName}"
				Script:End
			}
		}
		wait 5
		;move to correct device
		if ${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Device.Replace[" ",""].Replace["&",""].Equal[""]}
		{
			wait 30
		}
		CraftingStation:Set[${Me.Recipe[${BWFactionRecipeName}].ToRecipeInfo.Device.Replace[" ",""].Replace["&",""]}]
		wait 5
		call BWFMoveTo${CraftingStation}
		wait 5
		call CraftIt "${BWFactionRecipeName}" 6
		wait 5
		call BWFMoveBack${CraftingStation}
		wait 5
		call HailActor Anuhadux 1 1
		echo ISXRI: Ending Bathezid Master Scholar Work Requisition
		wait 10
	}
	Event[EQ2_onQuestUpdate]:DetachAtom[EQ2_BWFonQuestUpdate]
}
function BWFMoveToWorkBench()
{
	call RIMObj.Move 1207.273804 203.421692 1430.444580 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackWorkBench()
{
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveToChemistryTable()
{
	call RIMObj.Move 1175.273193 203.421692 1424.706177 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackChemistryTable()
{
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveToEngravedDesk()
{
	call RIMObj.Move 1180.608398 203.421692 1431.976929 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackEngravedDesk()
{
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveToStoveandKeg()
{
	call RIMObj.Move 1202.381470 203.421692 1416.117310 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackStoveandKeg()
{
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveToWoodworkingTable()
{
	call RIMObj.Move 1211.615845 203.421692 1442.128906 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackWoodworkingTable()
{
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveToLoom()
{
	call RIMObj.Move 1183.704834 203.421692 1427.211914 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1217.168945 203.421692 1452.466919 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackLoom()
{
	call RIMObj.Move 1183.704834 203.421692 1427.211914 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
	
}
function BWFMoveToForge()
{
	call RIMObj.Move 1183.704834 203.421692 1427.211914 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1198.801758 203.421692 1465.820313 1 0 FALSE FALSE TRUE FALSE
}
function BWFMoveBackForge()
{
	call RIMObj.Move 1183.704834 203.421692 1427.211914 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1174.555908 203.421692 1429.830811 1 0 FALSE FALSE TRUE FALSE
}
function CheckResourceQuantityOnHand(string _ResourceName, int _Quantity)
{
	if ${Me.Inventory[Query, Location=="Inventory" && Name=="${_ResourceName}"].Quantity}<${_Quantity}
	{
		;show messagebox 
		MessageBox -skin eq2 "You must have at least ${_Quantity} ${_ResourceName} in your inventory"
		eq2ex start_broker
		Script:End
	}
}
variable(global) bool RI_Var_Bool_SSSInScript=FALSE
variable(global) bool RI_Var_Bool_SSSGTG=FALSE
function SarnakSupplyStocking()
{
	RI_Var_Bool_SSSInScript:Set[TRUE]
	RI_Var_Bool_SSSGTG:Set[FALSE]
	if ${Me.TSLevel}<80
	{
		;show messagebox 
		MessageBox -skin eq2 "You must be Tradeskill Level 80 or higher to start this timeline"
		Script:End
	}
	switch ${Me.TSSubClass}
	{
		case alchemist
		{
			;40 mineral salt loam, 20 rough kunzite, 10 deklium cluster, 20 smoldering candle
			;40 mineral salt loam, 20 rough kunzite, 10 deklium cluster, 50 smoldering candle
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "mineral salt loam" 80 "rough kunzite" 40 "deklium cluster" 20
				call RemoveFromDepot "Fuel Depot" "smoldering candle" 70
				call CheckPreReqs -itemqty "mineral salt loam" 80 -itemqty "rough kunzite" 40 -itemqty "deklium cluster" 20 -itemqty "smoldering candle" 70
				wait 5
			}
			break
		}
		case armorer
		{
			;40 ferrite cluster, 20 bristled pelt , 10 lichenclover root , 50 smoldering coal
			;40 ferrite cluster, 20 bristled pelt , 10 lichenclover root , 50 smoldering coal
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "ferrite cluster" 80 "bristled pelt" 40 "lichenclover root" 20
				call RemoveFromDepot "Fuel Depot" "smoldering coal" 100
				call CheckPreReqs -itemqty "ferrite cluster" 80 -itemqty "bristled pelt" 40 -itemqty "lichenclover root" 20 -itemqty "smoldering coal" 100
				wait 5
			}
			break
		}
		case carpenter
		{
			;40 redwood lumber, 20 bristled pelt, 10 ferrite cluster, 50 smoldering sandpaper
			;40 redwood lumber, 20 bristled pelt, 10 ferrite cluster, 50 smoldering sandpaper
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "redwood lumber" 80 "bristled pelt" 40 "ferrite cluster" 20
				call RemoveFromDepot "Fuel Depot" "smoldering sandpaper" 100
				call CheckPreReqs -itemqty "redwood lumber" 80 -itemqty "bristled pelt" 40 -itemqty "ferrite cluster" 20 -itemqty "smoldering sandpaper" 100
				wait 5
			}
			break
		}
		case jeweler
		{
			;40 mineral salt loam, 20 rough kunzite, 10 deklium cluster, 50 smoldering coal 
			;40 mineral salt loam, 20 rough kunzite, 10 deklium cluster, 50 smoldering coal 
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "mineral salt loam" 80 "rough kunzite" 40 "deklium cluster" 20
				call RemoveFromDepot "Fuel Depot" "smoldering coal" 100
				call CheckPreReqs -itemqty "mineral salt loam" 80 -itemqty "rough kunzite" 40 -itemqty "deklium cluster" 20 -itemqty "smoldering coal" 100
				wait 5
			}
			break
		}
		case provisioner
		{
			;uses 20 raw succulent petal, 50 lichenclover root, 10 raw cranberry, 60 king prawn, 10xLiquid, 10xDough, and 120 smoldering kindling.
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "raw succulent petal" 20 "lichenclover root" 50 "raw cranberry" 10 "king prawn" 60
				call RemoveFromDepot "Fuel Depot" "aerated mineral water" 10 "dough" 10 "smoldering kindling" 120
				call CheckPreReqs -itemqty "raw succulent petal" 20 -itemqty "lichenclover root" 50 -itemqty "raw cranberry" 10 -itemqty "king prawn" 60 -itemqty "aerated mineral water" 10 -itemqty "dough" 10 -itemqty "smoldering kindling" 120
				wait 5
			}
			break
		}
		case sage
		{
			;uses 60 redwood lumber, 40 lichenclover root, 20 deklium cluster and 100 smoldering incense.
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "redwood lumber" 60 "lichenclover root" 40 "deklium cluster" 20
				call RemoveFromDepot "Fuel Depot" "smoldering incense" 100
				call CheckPreReqs -itemqty "redwood lumber" 60 -itemqty "lichenclover root" 40 -itemqty "deklium cluster" 20 -itemqty "smoldering incense" 100
				wait 5
			}
			break
		}
		case tailor
		{
			;uses 50 lichenclover root, 80 bristled pelt, 10 redwood lumber, and 100 smoldering filament.
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "bristled pelt" 80 "lichenclover root" 50 "redwood lumber" 10
				call RemoveFromDepot "Fuel Depot" "smoldering filament" 100
				call CheckPreReqs -itemqty "bristled pelt" 80 -itemqty "lichenclover root" 50 -itemqty "redwood lumber" 10 -itemqty "smoldering filament" 100
				wait 5
			}
			break
		}
		case woodworker
		{
			;uses 80 redwood lumber, 40 deklium cluster, 20 bristled pelt and 100 smoldering sandpaper.
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "redwood lumber" 80 "deklium cluster" 40 "bristled pelt" 20
				call RemoveFromDepot "Fuel Depot" "smoldering sandpaper" 100
				call CheckPreReqs -itemqty "redwood lumber" 80 -itemqty "deklium cluster" 40 -itemqty "bristled pelt" 20 -itemqty "smoldering sandpaper" 100
				wait 5
			}
			break
		}
		case weaponsmith
		{
			;40 ferrite cluster, 20 bristled leather, 10 kunzite, 50 smoldering coal
			;40 ferrite cluster, 20 bristled leather, 10 kunzite, 50 smoldering coal
			while !${RI_Var_Bool_SSSGTG}
			{
				call RemoveFromDepot "Harvesting Supply Depot" "ferrite cluster" 80 "bristled pelt" 40 "rough kunzite" 20
				call RemoveFromDepot "Fuel Depot" "smoldering coal" 100
				call CheckPreReqs -itemqty "ferrite cluster" 80 -itemqty "bristled pelt" 40 -itemqty "rough kunzite" 20 -itemqty "smoldering coal" 100
				wait 5
			}
			break
		}
	}
	call FensBellToBathezidsWatchCraft
	call RIMObj.Move 1202.758301 203.421692 1439.231201 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
	;echo ISXRI: Starting Sarnak Supply Stocking
	CustomLoc:Set["0 0 0"]
	call HailActor Danelak 2 1
	wait 20
	switch ${Me.TSSubClass}
	{
		case alchemist
		{
			call SSSMoveToChemistryTable
			wait 20
			;40 mineral salt loam, 20 rouch kunzite, 10 deklium cluster, 20 smoldering candle
			call CraftIt "Dedicated Elixir of Intellect" 10
			;40 mineral salt loam, 20 rouch kunzite, 10 deklium cluster, 50 smoldering candle
			call CraftIt "Smoldering Fists VI (Journeyman)" 10
			wait 5
			call SSSMoveBackChemistryTable
			break
		}
		case armorer
		{
			call SSSMoveToForge
			wait 20
			;40 ferrite cluster, 20 bristled pelt , 10 lichenclover root , 50 smoldering coal
			call CraftIt "Pristine Ferrite Plate Spaulders" 10
			;40 ferrite cluster, 20 bristled pelt , 10 lichenclover root , 50 smoldering coal
			call CraftIt "Pristine Ferrite Melodic Mantle" 10
			wait 5
			call SSSMoveBackForge
			break
		}
		case carpenter
		{
			call SSSMoveToWoodworkingTable
			wait 20
			;40 redwood lumber, 20 bristled pelt, 10 ferrite cluster, 50 smoldering sandpaper
			call CraftIt "Redwood Stool" 10
			;40 redwood lumber, 20 bristled pelt, 10 ferrite cluster, 50 smoldering sandpaper
			call CraftIt "Redwood Strong Box" 10
			wait 5
			call SSSMoveBackWoodworkingTable
			break
		}
		case jeweler
		{
			call SSSMoveToWorkBench
			wait 20
			;40 mineral salt loam, 20 rough kunzite, 10 deklium cluster, 50 smoldering coal 
			call CraftIt "Rune of Torture VI (Journeyman)" 10
			;40 mineral salt loam, 20 rough kunzite, 10 deklium cluster, 50 smoldering coal 
			call CraftIt "Rune of Double-Cross VI (Journeyman)" 10
			wait 5
			call SSSMoveBackWorkBench
			break
		}
		case provisioner
		{
			call SSSMoveToStoveandKeg
			wait 20
			;uses 20 raw succulent petal, 50 lichenclover root, 10 raw cranberry, 60 king prawn, 10xLiquid, 10xDough, and 120 smoldering kindling.
			call CraftIt "Steamed King Prawn Dumplings" 10
			call CraftIt "Succulent Mead" 10
			wait 5
			call SSSMoveBackStoveandKeg
			break
		}
		case sage
		{
			call SSSMoveToEngravedDesk
			wait 20
			;uses 60 redwood lumber, 40 lichenclover root, 20 deklium cluster and 100 smoldering incense.
			;Craft 10 Grim Sorcerer V Journeyman
			;Craft 10 Synergism IV Journeyman
			call CraftIt "Grim Sorcerer V (Journeyman)" 10
			call CraftIt "Synergism IV (Journeyman)" 10
			wait 5
			call SSSMoveBackEngravedDesk
			break
		}
		case tailor
		{
			call SSSMoveToSewingTableMannequin
			wait 20
			;uses 50 lichenclover root, 80 bristled pelt, 10 redwood lumber, and 100 smoldering filament.
			;Craft 10 Pristine Tailored Dexterous Bristled Leather Shoulder Pads
			;Craft 10 Pristine Tranquil Damask Shawl
			call CraftIt "Pristine Tailored Dexterous Bristled Leather Shoulder Pads" 10
			call CraftIt "Pristine Tranquil Damask Shawl" 10
			wait 5
			call SSSMoveBackSewingTableMannequin
			break
		}
		case woodworker
		{
			call SSSMoveToWoodworkingTable
			wait 20
			;uses 80 redwood lumber, 40 deklium cluster, 20 bristled pelt and 100 smoldering sandpaper.
			;Craft 10 Redwood Sorcerer's Staffs
			;Craft 10 Redwood Wands
			call CraftIt "redwood sorcerer's staff" 10
			call CraftIt "redwood wand" 10
			wait 5
			call SSSMoveBackWoodworkingTable
			break
		}
		case weaponsmith
		{
			call SSSMoveToForge
			wait 20
			;40 ferrite cluster, 20 bristled leather, 10 kunzite, 50 smoldering coal
			call CraftIt "ferrite morning star" 10
			;40 ferrite cluster, 20 bristled leather, 10 kunzite, 50 smoldering coal
			call CraftIt "ferrite war maul" 10
			wait 5
			call SSSMoveBackForge
			break
		}
	}
	wait 20
	CustomLoc:Set["0 0 0"]
	call HailActor Danelak 2 1
	call HailActor Danelak 1 2 FALSE
	call HailActor Danelak 4 1 FALSE
	;echo ISXRI: Ending Sarnak Supply Stocking
	RI_Var_Bool_InScript:Set[FALSE]
}
function SSSMoveToForge()
{
	return
}
function SSSMoveBackForge()
{
	return
}
function SSSMoveToWorkBench()
{
	call RIMObj.Move 1207.828613 203.421692 1432.514526 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveBackWorkBench()
{
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveToChemistryTable()
{
	call RIMObj.Move 1197.451782 203.421692 1441.105713 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1174.973633 203.421692 1424.090576 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveBackChemistryTable()
{
	call RIMObj.Move 1197.451782 203.421692 1441.105713 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveToEngravedDesk()
{
	call RIMObj.Move 1197.451782 203.421692 1441.105713 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1183.156982 203.421692 1432.790283 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveBackEngravedDesk()
{
	call RIMObj.Move 1197.451782 203.421692 1441.105713 1 0 FALSE FALSE TRUE TRUE
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveToStoveandKeg()
{
	call RIMObj.Move 1204.017822 203.421692 1418.705444 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveBackStoveandKeg()
{
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveToWoodworkingTable()
{
	call RIMObj.Move 1212.295410 203.421692 1444.353638 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveBackWoodworkingTable()
{
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveToSewingTableMannequin()
{
	call RIMObj.Move 1217.660400 203.421692 1455.146973 1 0 FALSE FALSE TRUE FALSE
}
function SSSMoveBackSewingTableMannequin()
{
	call RIMObj.Move 1196.660400 203.421692 1466.146973 1 0 FALSE FALSE TRUE FALSE
}

atom(script) EQ2_BWFonQuestUpdate(string ID, string Name, string CurrentZone, string Category, string Description, ... ProgressText)
{
	if ${ProgressText[3].NotEqual[""]}
	{
		;echo ISXRI: ${Time}: ${ProgressText[3]}
		if ${ProgressText[3].Find[I need to create some ](exists)}
		{
			;echo ${ProgressText[3].Left[20]}
			;echo ${ProgressText[3].Right[-20].Left[-1]}
			BWFactionRecipeName:Set[${ProgressText[3].Right[-22].Left[-1]}]
		}
		elseif ${ProgressText[3].Find[I need to create an ](exists)}
		{
			;echo ${ProgressText[3].Left[20]}
			;echo ${ProgressText[3].Right[-20].Left[-1]}
			BWFactionRecipeName:Set[${ProgressText[3].Right[-20].Left[-1]}]
		}
		elseif ${ProgressText[3].Find[I need to create a ](exists)}
		{
			;echo ${ProgressText[3].Left[19]}
			;echo ${ProgressText[3].Right[-19].Left[-1]}
			BWFactionRecipeName:Set[${ProgressText[3].Right[-19].Left[-1]}]
		}
		elseif ${ProgressText[3].Find[I need to create ](exists)}
		{
			;echo ${ProgressText[3].Left[17]}
			;echo ${ProgressText[3].Right[-17].Left[-1]}
			BWFactionRecipeName:Set[${ProgressText[3].Right[-17].Left[-1]}]
		}
		;echo ISXRI: ${Time}: ${BWFactionRecipeName}
	}
}
function ArtisanEpicTimeline()
{
	if !${QuestJournalWindow.CompletedQuest["Sarnak Supply Stocking"](exists)}
	{
		if !${RIMUIObj.FactionsInitialized}
		{
			echo ISXRI: Initializing Faction Data
			wait 100 ${RIMUIObj.FactionsInitialized}
			echo ISXRI: Done Initializing Faction Data
		}
		wait 50
		; if ${RIMUIObj.FactionAmount[Bathezid's Watch]}==0
			; echo ISXRI: Your Bathezid's Watch Faction is 0 (or your faction was not read open your faction window and goto each dropdown and scroll all the way down)
		; else
			; echo ISXRI: Your Bathezid's Watch Faction is ${RIMUIObj.FactionAmount[Bathezid's Watch]}
			
		if ${RIMUIObj.FactionAmount[Bathezid's Watch]}==0 && ${QuestJournalWindow.CompletedQuest["New Lands, New Profits"](exists)}
		{
			call MessageBox "You have already completed New Lands, New Profits and your Bathezid's Watch faction is reporting 0, which means we are not reading it, open your faction window and goto each dropdown and scroll all the way down the re run"
		}
		;change these to the correct quests
		if ${QuestJournalWindow.CompletedQuest["The Proof of the Pudding"](exists)} || ${QuestJournalWindow.ActiveQuest["The Proof of the Pudding"](exists)}
		{
			;show messagebox 
			MessageBox -skin eq2 "You have already completed the Artisan Epic Timeline or are on The Proof of the Pudding"
			Script:End
		}
		if ${Me.TSLevel}<80
		{
			;show messagebox 
			MessageBox -skin eq2 "You must be Tradeskill Level 80 or higher to start this timeline"
			Script:End
		}
		;if not completed "New Lands, New Profits"
		if !${QuestJournalWindow.CompletedQuest["New Lands, New Profits"](exists)}
;		&& ( ${RIMUIObj.FactionAmount[Bathezid's Watch]}==0 || ${RIMUIObj.FactionAmount[Bathezid's Watch]}<-39750 )
		{
			if ${QuestJournalWindow.ActiveQuest["New Lands, New Profits"](exists)}
			{
				QuestJournalWindow.ActiveQuest["New Lands, New Profits"]:Delete
				wait 5
			}
			call QuestDefault NewLandsNewProfits
		}
		else
			echo ISXRI: New Lands, New Profits already Completed, moving on
		;if BW FActions is <-20000
		
		if ${RIMUIObj.FactionAmount[Bathezid's Watch]}<-20000
		{
			if ${QuestJournalWindow.ActiveQuest["Bathezid Master Scholar Work Requisition"](exists)}
			{
				QuestJournalWindow.ActiveQuest["Bathezid Master Scholar Work Requisition"]:Delete
				wait 5
			}
			call BathezidsWatchFactionCrafting
		}
		else
			echo ISXRI: we already have -20000 or greater Bathezid's Watch Faction, moving on
		
		;if not completed "Sarnak Supply Stocking"
		if !${QuestJournalWindow.CompletedQuest["Sarnak Supply Stocking"](exists)}
		{
			if ${QuestJournalWindow.ActiveQuest["Sarnak Supply Stocking"](exists)}
			{
				QuestJournalWindow.ActiveQuest["Sarnak Supply Stocking"]:Delete
				wait 5
			}
			call QuestDefault SarnakSupplyStocking
		}
		else
			echo ISXRI: Sarnak Supply Stocking already Completed, moving on
	}
	else
		echo ISXRI: Sarnak Supply Stocking already Completed, moving on
	;if not completed "Bixie Distraction"
	if !${QuestJournalWindow.CompletedQuest["Bixie Distraction"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["Bixie Distraction"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Bixie Distraction"]:Delete
			wait 5
		}
		call QuestDefault BixieDistraction
	}
	else
		echo ISXRI: Bixie Distraction already Completed, moving on
	;if not completed "Anything for Jumjum"
	if !${QuestJournalWindow.CompletedQuest["Anything for Jumjum"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["Anything for Jumjum"](exists)}
		{
			QuestJournalWindow.ActiveQuest["Anything for Jumjum"]:Delete
			wait 5
		}
		call QuestDefault AnythingforJumjum
	}
	else
		echo ISXRI: Anything for Jumjum already Completed, moving on
	;if not completed "${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]} Errands"
	if !${QuestJournalWindow.CompletedQuest["${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]} Errands"](exists)}
	{
		if ${QuestJournalWindow.ActiveQuest["${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]} Errands"](exists)}
		{
			QuestJournalWindow.ActiveQuest["${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]} Errands"]:Delete
			wait 5
		}
		call QuestDefault ${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]}Errands
	}
	else
		echo ISXRI: ${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]} Errands Completed, moving on
}
function BixieDistractionGatherItems()
{
	;load zonefile
	AnnounceText:Clear
	AnnounceText:Insert[Quest item found!]
	;now start running the path and check for the items 
	variable index:string _WayPoints
	_WayPoints:Insert[-49.662468 91.542755 894.094360]
	_WayPoints:Insert[-46.910034 91.931801 903.125061]
	_WayPoints:Insert[-56.830036 91.979240 904.553406]
	_WayPoints:Insert[-67.027771 92.491302 905.338135]
	_WayPoints:Insert[-77.173477 93.855072 905.404053]
	_WayPoints:Insert[-87.171974 94.072044 905.302734]
	_WayPoints:Insert[-97.201691 94.273682 905.359192]
	_WayPoints:Insert[-107.134979 93.384682 907.369202]
	_WayPoints:Insert[-115.615326 92.908913 913.147827]
	_WayPoints:Insert[-123.463387 92.265930 919.331543]
	_WayPoints:Insert[-132.673370 92.153206 923.977234]
	_WayPoints:Insert[-142.895966 92.154121 925.540955]
	_WayPoints:Insert[-152.988266 92.657417 925.740662]
	_WayPoints:Insert[-162.970795 94.087242 925.255676]
	_WayPoints:Insert[-172.862366 94.513023 923.609985]
	_WayPoints:Insert[-182.773788 94.551270 921.766418]
	_WayPoints:Insert[-192.722061 93.093224 922.841248]
	_WayPoints:Insert[-202.785889 92.211311 923.554504]
	_WayPoints:Insert[-212.167542 91.994621 927.022705]
	_WayPoints:Insert[-217.115402 92.009811 935.986450]
	_WayPoints:Insert[-224.906677 91.938187 942.810425]
	_WayPoints:Insert[-234.766052 91.628212 944.622559]
	_WayPoints:Insert[-244.845535 91.509651 943.546204]
	_WayPoints:Insert[-253.015625 91.002502 937.751160]
	_WayPoints:Insert[-259.882202 92.563507 928.546082]
	_WayPoints:Insert[-266.235565 92.601219 920.386108]
	_WayPoints:Insert[-272.920990 91.023926 913.065796]
	_WayPoints:Insert[-279.341461 91.047821 905.018433]
	_WayPoints:Insert[-289.327728 91.351646 904.223938]
	_WayPoints:Insert[-294.749390 91.208313 913.102539]
	_WayPoints:Insert[-300.312469 93.453285 921.661011]
	_WayPoints:Insert[-307.088715 94.010162 929.385437]
	_WayPoints:Insert[-314.623322 94.304474 936.109192]
	_WayPoints:Insert[-324.914948 93.814911 937.127319]
	_WayPoints:Insert[-335.312103 93.804604 936.813293]
	_WayPoints:Insert[-345.655853 94.406914 936.242310]
	_WayPoints:Insert[-355.904419 94.898270 935.443787]
	_WayPoints:Insert[-364.821228 94.816605 930.403748]
	_WayPoints:Insert[-373.132141 94.388542 924.340759]
	_WayPoints:Insert[-382.574371 96.259720 927.319519]
	_WayPoints:Insert[-392.222229 97.451286 930.580872]
	_WayPoints:Insert[-402.087921 97.068756 932.200928]
	_WayPoints:Insert[-412.005737 96.336830 933.911682]
	_WayPoints:Insert[-421.984375 95.405060 935.051270]
	_WayPoints:Insert[-431.678497 94.702728 931.536316]
	_WayPoints:Insert[-435.392944 94.694107 922.152161]
	_WayPoints:Insert[-443.763458 95.582527 916.524841]
	_WayPoints:Insert[-453.526581 97.341736 913.513123]
	_WayPoints:Insert[-462.930725 97.868904 909.797607]
	_WayPoints:Insert[-469.864349 98.374321 902.259949]
	_WayPoints:Insert[-478.826630 101.299500 898.360291]
	_WayPoints:Insert[-486.805969 103.587036 892.121216]
	_WayPoints:Insert[-494.738281 105.601151 886.291931]
	_WayPoints:Insert[-499.015839 105.948486 877.052673]
	_WayPoints:Insert[-494.311554 104.115440 868.249207]
	_WayPoints:Insert[-488.252563 102.222382 860.509216]
	_WayPoints:Insert[-481.964783 101.379204 852.692383]
	_WayPoints:Insert[-475.494873 101.590034 844.955566]
	_WayPoints:Insert[-466.091248 101.908813 841.189087]
	_WayPoints:Insert[-456.831604 100.954803 837.389038]
	_WayPoints:Insert[-466.705505 100.458611 835.123413]
	_WayPoints:Insert[-476.991913 99.931953 834.045776]
	_WayPoints:Insert[-487.149811 101.436584 832.981445]
	_WayPoints:Insert[-496.721191 103.756653 836.166687]
	_WayPoints:Insert[-504.791504 106.415184 842.248962]
	_WayPoints:Insert[-512.728577 109.358864 848.189941]
	_WayPoints:Insert[-520.468994 112.251320 853.872009]
	_WayPoints:Insert[-528.931946 116.206726 857.541870]
	_WayPoints:Insert[-538.170898 120.295265 859.460693]
	_WayPoints:Insert[-547.884033 124.106247 859.623779]
	_WayPoints:Insert[-550.500366 125.189590 856.166077]
	_WayPoints:Insert[-547.937195 124.154305 846.381226]
	_WayPoints:Insert[-552.046082 126.653503 837.484314]
	_WayPoints:Insert[-561.651123 129.619400 836.725342]
	_WayPoints:Insert[-571.012390 131.988068 839.412781]
	_WayPoints:Insert[-580.810059 133.948364 837.740784]
	_WayPoints:Insert[-590.899902 132.972672 836.424866]
	_WayPoints:Insert[-600.214966 131.735901 839.996765]
	_WayPoints:Insert[-607.010742 131.646744 847.345642]
	_WayPoints:Insert[-613.975830 132.730103 854.926270]
	_WayPoints:Insert[-620.975159 133.811844 862.544678]
	_WayPoints:Insert[-627.918701 134.386078 870.102356]
	_WayPoints:Insert[-634.572144 135.116852 877.718689]
	_WayPoints:Insert[-641.205811 134.942673 885.309265]
	_WayPoints:Insert[-647.546326 133.685852 893.313904]
	_WayPoints:Insert[-656.601746 132.213379 897.472229]
	_WayPoints:Insert[-665.393860 132.098663 892.257629]
	_WayPoints:Insert[-671.854065 132.095306 884.137451]
	_WayPoints:Insert[-673.503174 133.810196 874.284790]
	_WayPoints:Insert[-672.072449 135.180466 864.243530]
	_WayPoints:Insert[-670.845520 134.907562 854.063721]
	_WayPoints:Insert[-668.186035 133.915344 844.435852]
	_WayPoints:Insert[-663.815857 132.946854 835.357361]
	_WayPoints:Insert[-656.548889 132.607559 828.432739]
	_WayPoints:Insert[-646.305054 132.348801 829.173279]
	_WayPoints:Insert[-636.395935 130.850113 827.850464]
	_WayPoints:Insert[-627.033081 129.162231 824.690491]
	_WayPoints:Insert[-617.191772 129.155624 822.286072]
	_WayPoints:Insert[-608.783203 129.357254 816.830139]
	_WayPoints:Insert[-612.681458 133.112793 808.008667]
	_WayPoints:Insert[-617.717468 134.313797 799.433533]
	_WayPoints:Insert[-622.966003 133.639191 790.729858]
	_WayPoints:Insert[-627.808899 132.386093 782.059021]
	_WayPoints:Insert[-630.619995 130.777496 772.556091]
	_WayPoints:Insert[-639.380554 129.730743 767.592651]
	_WayPoints:Insert[-639.152344 129.944656 757.481812]
	_WayPoints:Insert[-634.901855 130.349747 748.034424]
	_WayPoints:Insert[-632.276245 130.067047 738.160156]
	_WayPoints:Insert[-630.235657 129.002502 728.175415]
	_WayPoints:Insert[-630.857483 129.876709 717.930908]
	_WayPoints:Insert[-633.158325 129.444489 707.884094]
	_WayPoints:Insert[-623.645203 130.554352 704.770081]
	_WayPoints:Insert[-613.348022 130.651596 704.891235]
	_WayPoints:Insert[-603.071106 130.983612 706.078064]
	_WayPoints:Insert[-592.970276 130.670120 706.965454]
	_WayPoints:Insert[-582.789856 130.487701 706.893921]
	_WayPoints:Insert[-572.914917 129.303146 708.593140]
	_WayPoints:Insert[-563.266724 128.695847 705.215820]
	_WayPoints:Insert[-556.246033 128.229401 697.972717]
	_WayPoints:Insert[-551.462891 128.129288 688.784363]
	_WayPoints:Insert[-546.783691 128.060684 679.804443]
	_WayPoints:Insert[-540.263062 128.015900 671.957764]
	_WayPoints:Insert[-533.582275 128.045212 664.280945]
	_WayPoints:Insert[-527.884766 127.884171 655.971252]
	_WayPoints:Insert[-522.376953 127.859161 647.354309]
	_WayPoints:Insert[-516.613708 127.701813 638.880554]
	_WayPoints:Insert[-510.778595 127.475769 630.607117]
	_WayPoints:Insert[-505.634003 127.059219 621.845520]
	_WayPoints:Insert[-503.428223 126.781990 612.077332]
	_WayPoints:Insert[-495.921326 126.161148 618.891907]
	_WayPoints:Insert[-494.847015 126.626099 629.100525]
	_WayPoints:Insert[-498.377502 127.116745 638.466675]
	_WayPoints:Insert[-504.400665 127.210266 646.565430]
	_WayPoints:Insert[-511.464783 127.052216 653.641846]
	_WayPoints:Insert[-518.456055 127.140656 661.086243]
	_WayPoints:Insert[-525.203430 127.143150 668.791077]
	_WayPoints:Insert[-530.648804 127.079132 677.463806]
	_WayPoints:Insert[-534.546936 127.296524 686.683716]
	_WayPoints:Insert[-537.647400 127.687637 696.362244]
	_WayPoints:Insert[-541.389282 127.195946 705.824036]
	_WayPoints:Insert[-545.654907 126.922989 715.085938]
	_WayPoints:Insert[-545.106873 124.886253 724.958740]
	_WayPoints:Insert[-544.288208 123.585152 735.034180]
	_WayPoints:Insert[-537.105957 122.581291 742.149597]
	_WayPoints:Insert[-528.284424 121.993355 746.965637]
	_WayPoints:Insert[-520.126831 119.449539 752.238159]
	_WayPoints:Insert[-511.899628 116.248871 756.942566]
	_WayPoints:Insert[-503.775024 113.668083 762.698730]
	_WayPoints:Insert[-495.614655 111.295929 768.478577]
	_WayPoints:Insert[-488.802460 110.129143 775.743713]
	_WayPoints:Insert[-481.956024 108.060493 782.871765]
	_WayPoints:Insert[-473.874237 104.756584 787.859436]
	_WayPoints:Insert[-465.319641 101.991928 792.885132]
	_WayPoints:Insert[-456.047974 100.040810 796.928711]
	_WayPoints:Insert[-445.977448 99.572296 797.585144]
	_WayPoints:Insert[-436.022644 101.389267 798.260925]
	_WayPoints:Insert[-427.956390 101.887344 804.564941]
	_WayPoints:Insert[-419.882599 102.314224 810.928894]
	_WayPoints:Insert[-413.428436 101.602394 818.792603]
	_WayPoints:Insert[-411.112518 98.873970 828.134460]
	_WayPoints:Insert[-413.336304 97.560783 837.928467]
	_WayPoints:Insert[-415.508850 97.217018 847.770874]
	_WayPoints:Insert[-411.522064 96.227829 856.898132]
	_WayPoints:Insert[-401.791290 95.808678 859.872803]
	_WayPoints:Insert[-391.680206 95.048668 859.967224]
	_WayPoints:Insert[-381.783752 93.517891 860.793335]
	_WayPoints:Insert[-371.348480 93.487732 862.139282]
	_WayPoints:Insert[-361.698364 93.137848 865.399170]
	_WayPoints:Insert[-352.103210 93.307915 869.040710]
	_WayPoints:Insert[-342.223663 93.651039 872.119812]
	_WayPoints:Insert[-332.604156 92.925262 875.303650]
	_WayPoints:Insert[-322.383514 93.598244 876.841736]
	_WayPoints:Insert[-312.509369 93.134613 873.884644]
	_WayPoints:Insert[-302.516907 92.890251 871.299133]
	_WayPoints:Insert[-292.451355 92.696136 869.295715]
	_WayPoints:Insert[-282.498810 92.548813 867.315796]
	_WayPoints:Insert[-272.457489 92.729485 864.851868]
	_WayPoints:Insert[-262.802094 92.777924 861.643860]
	_WayPoints:Insert[-253.666275 92.723770 857.038269]
	_WayPoints:Insert[-245.541809 92.623726 850.876709]
	_WayPoints:Insert[-237.666534 92.784103 844.423584]
	_WayPoints:Insert[-227.539063 92.922684 844.500610]
	_WayPoints:Insert[-222.519775 92.852676 853.399658]
	_WayPoints:Insert[-222.219864 93.047562 863.708801]
	_WayPoints:Insert[-221.067581 92.817001 873.822083]
	_WayPoints:Insert[-218.681137 92.928101 883.573853]
	_WayPoints:Insert[-215.405289 92.806091 893.259399]
	_WayPoints:Insert[-209.603149 92.893219 901.786255]
	_WayPoints:Insert[-200.079300 92.889221 905.928162]
	_WayPoints:Insert[-189.967148 92.928734 908.601074]
	_WayPoints:Insert[-180.809967 93.079269 913.092651]
	_WayPoints:Insert[-171.153473 93.190140 916.236755]
	_WayPoints:Insert[-161.309006 93.072548 913.741821]
	_WayPoints:Insert[-152.330017 92.721725 909.268311]
	_WayPoints:Insert[-142.959915 92.509903 905.513489]
	_WayPoints:Insert[-133.554611 92.570770 901.932556]
	_WayPoints:Insert[-124.759148 94.891350 897.554626]
	_WayPoints:Insert[-115.763779 95.971855 892.947449]
	_WayPoints:Insert[-110.536247 98.785645 884.740662]
	_WayPoints:Insert[-103.485954 99.253868 877.432617]
	_WayPoints:Insert[-97.564758 99.719749 869.081482]
	_WayPoints:Insert[-91.809029 99.248970 860.886108]
	_WayPoints:Insert[-85.588448 98.242111 852.744263]
	_WayPoints:Insert[-78.904411 97.294678 844.972534]
	_WayPoints:Insert[-71.984535 96.344910 837.687866]
	_WayPoints:Insert[-62.087696 94.681801 835.686401]
	_WayPoints:Insert[-52.467262 93.509628 838.709106]
	_WayPoints:Insert[-46.695778 92.436844 846.910278]
	_WayPoints:Insert[-48.361198 92.024956 856.993774]
	_WayPoints:Insert[-50.686729 91.824814 866.933777]
	_WayPoints:Insert[-54.312256 91.347206 876.565186]
	_WayPoints:Insert[-59.231129 91.325134 885.456482]
	_WayPoints:Insert[-60.043591 91.298309 884.257996]
	_WayPoints:Insert[-51.246338 91.159653 879.287842]
	_WayPoints:Insert[-41.819420 91.386887 882.755188]
	_WayPoints:Insert[-37.099842 91.753654 889.345154]
	
	variable int _count
	variable int _count2
	;gnomish bolt - 1580
	variable bool _BoltsDone
	_BoltsDone:Set[FALSE]
	;oil - 6946
	variable bool _GreaseDone
	_GreaseDone:Set[FALSE]
	;water pump - 8089
	variable bool _WPDone
	_WPDone:Set[FALSE]
	;power - 6333
	variable bool _PowerDone
	_PowerDone:Set[FALSE]
	variable int _WPCnt
	_WPCnt:Set[0]
	for(_count:Set[1];${_count}<=${_WayPoints.Used};_count:Inc)
	{
		if ${_BoltsDone} && ${_GreaseDone} && ${_WPDone} && ${_PowerDone}
		{
			_count2:Set[${_count}]
			_count:Set[${Math.Calc[${_WayPoints.Used}+1]}]
			continue
		}
		call RIMObj.Move ${_WayPoints.Get[${_count}]} 1 0 FALSE FALSE TRUE TRUE
		call BDCheckForItem ${_BoltsDone} ${_GreaseDone} ${_WPDone} ${_PowerDone}
		if ${Trigger}
		{
			if ${TriggerMessage.Find[gnomish bolt (20/20)](exists)}
				_BoltsDone:Set[TRUE]
			if ${TriggerMessage.Find[sample of used grease (10/10)](exists)}
				_GreaseDone:Set[TRUE]
			if ${TriggerMessage.Find[rusted water pump](exists)}
			{
				_WPCnt:Inc
				if ${_WPCnt}>1
					_WPDone:Set[TRUE]
			}
			if ${TriggerMessage.Find[rusted water pump (2/2)](exists)}
				_WPDone:Set[TRUE]
			if ${TriggerMessage.Find[used power source](exists)}
				_PowerDone:Set[TRUE]
			Trigger:Set[FALSE]
			TriggerMessage:Set[NA]
		}
		wait 1
	}
	for(;${_count2}>=1;_count2:Dec)
	{
		call RIMObj.Move ${_WayPoints.Get[${_count2}]} 1 0 FALSE FALSE TRUE TRUE
	}
	call RIMObj.Move ${_WayPoints.Get[${_WayPoints.Used}]} 1 0 FALSE FALSE TRUE FALSE
}
function BDCheckForItem(bool _BD, bool _GD, bool _WPD, bool _PD)
{
	variable int _ID
	variable string _temp
	_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
	variable string _Query
	_Query:Set["Name==\"scrap heap\" && Distance<=50 && ( "]
	if !${_BD}
		_Query:Concat["TintFlags=1580"]
	if !${_BD} && ( !${_GD} || !${_WPD} || !${_PD} )
		_Query:Concat["||"]
	if !${_GD}
		_Query:Concat["TintFlags=6946"]
	if !${_GD} && ( !${_WPD} || !${_PD} )
		_Query:Concat["||"]
	if !${_WPD}
		_Query:Concat["TintFlags=8089"]
	if !${_WPD} && !${_PD}
		_Query:Concat["||"]
	if !${_PD}
		_Query:Concat["TintFlags=6333"]
	_Query:Concat[" )"]
	;echo ${_Query}  //  ${_BD}  ${_GD}  ${_WPD}  ${_PD}
	if ${Actor[Query, ${_Query}](exists)}
	{
		_ID:Set[${Actor[Query, ${_Query}].ID}]
		if !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+2]},${Actor[Query, ID=${_ID}].Z}]}
		{
			call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+2]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
			wait 5
			while ${Actor[Query, ID=${_ID}](exists)}
			{
				Actor[Query, ID=${_ID}]:DoTarget
				wait 1
				Actor[Query, ID=${_ID}]:DoubleClick
				wait 9
			}
			call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
		}
	}
}
function BixieDistractionGatherNightshade()
{
	;load zonefile
	AnnounceText:Clear
	AnnounceText:Insert[Quest item found!]
	;now start running the path and check for the items 
	variable index:string _WayPoints
	_WayPoints:Insert[-375.797546 17.600355 63.116295]
	_WayPoints:Insert[-380.549774 16.692076 53.740112]
	_WayPoints:Insert[-381.643005 16.703724 50.401638]
	_WayPoints:Insert[-391.184021 16.452175 47.399757]
	_WayPoints:Insert[-400.991730 16.172081 45.171528]
	_WayPoints:Insert[-411.027802 15.456699 44.240471]
	_WayPoints:Insert[-421.119110 14.804485 44.948818]
	_WayPoints:Insert[-431.071106 14.636902 46.417751]
	_WayPoints:Insert[-440.996521 14.365783 48.673439]
	_WayPoints:Insert[-450.643036 13.976727 51.515270]
	_WayPoints:Insert[-460.133698 14.051115 54.996773]
	_WayPoints:Insert[-462.106354 14.420191 64.872673]
	_WayPoints:Insert[-461.688080 14.879245 74.928009]
	_WayPoints:Insert[-452.495422 15.273214 79.019012]
	_WayPoints:Insert[-442.274231 15.812521 80.336906]
	_WayPoints:Insert[-432.267548 16.520985 81.000877]
	_WayPoints:Insert[-421.956970 17.009665 81.002716]
	_WayPoints:Insert[-411.887726 17.676796 80.854965]
	_WayPoints:Insert[-401.828888 17.941278 80.822540]
	_WayPoints:Insert[-393.139282 17.730619 75.564171]
	_WayPoints:Insert[-386.154358 17.440544 68.200356]
	_WayPoints:Insert[-379.965942 17.023417 61.020550]
	
	
	variable int _count
	variable int _count2
	variable bool _GoBW
	_GoBW:Set[FALSE]
	variable bool _NightshadeDone
	_NightshadeDone:Set[FALSE]
	for(_count:Set[1];${_count}<=${_WayPoints.Used};_count:Inc)
	{
		if ${_NightshadeDone} && ${_count}<11
		{
			_count2:Set[${_count}]
			_count:Set[${Math.Calc[${_WayPoints.Used}+1]}]
			_GoBW:Set[TRUE]
			continue
		}
		call RIMObj.Move ${_WayPoints.Get[${_count}]} 1 0 FALSE FALSE TRUE TRUE
		if !${_NightshadeDone}
			call BDCheckForShade
		if ${Trigger}
		{
			if ${TriggerMessage.Find[eternal nightshade (15/15)](exists)}
				_NightshadeDone:Set[TRUE]
			Trigger:Set[FALSE]
			TriggerMessage:Set[NA]
		}
		wait 1
	}
	if ${_GoBW}
	{
		for(;${_count2}>=1;_count2:Dec)
		{
			call RIMObj.Move ${_WayPoints.Get[${_count2}]} 1 0 FALSE FALSE TRUE TRUE
		}
		call RIMObj.Move ${_WayPoints.Get[${_WayPoints.Used}]} 1 0 FALSE FALSE TRUE FALSE
	}
}
function BDCheckForShade()
{
	variable int _ID
	variable string _temp
	_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
	variable string _Query
	_Query:Set["Name==\"eternal nightshade\" && Distance<=15"]

	;echo ${_Query}  //  ${_BD}  ${_GD}  ${_WPD}  ${_PD}
	if ${Actor[Query, ${_Query}](exists)}
	{
		_ID:Set[${Actor[Query, ${_Query}].ID}]
		if !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
		{
			call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
			wait 5
			while ${Actor[Query, ID=${_ID}](exists)}
			{
				Actor[Query, ID=${_ID}]:DoTarget
				wait 1
				Actor[Query, ID=${_ID}]:DoubleClick
				wait 9
			}
			call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
		}
	}
}
function PathHail(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _Node, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable int _Precision=2
	variable string _Query
	variable int _ID
	;variable string _tempName
	variable string _temp
	variable bool _IWasFlying=FALSE
	variable bool _Done
	
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat[" ${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}: ${args[${Math.Calc[${_count}+3]}]}"]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
			IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		else
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
			
		;echo inserted ${args[${Math.Calc[${_count}+1]}].Right[-3]} // ${AnnounceText.Get[1]} // ${IncomingText.Get[1]}
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
	; {
		; echo ${IncomingText.Get[${_count}]}
	; }
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	;echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${RI_Var_Bool_BreakPathFunction}
			{
				RI_Var_Bool_BreakPathFunction:Set[0]
				return
			}
			;check for our node and if we are
			if !${_Done}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 5
						;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while !${Trigger}
						{
							if ${RI_Var_Bool_BreakPathFunction}
							{
								RI_Var_Bool_BreakPathFunction:Set[0]
								return
							}
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
							{
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								continue
							}
							RI_CMD_PauseCombatBots 1
							wait 5
							Actor[Query, ID=${_ID}]:DoFace
							wait 5
							Actor[Query, ID=${_ID}]:DoTarget
							wait 5
							eq2execute hail
							wait 5
						
							variable int _counth
							for(_counth:Set[1];${_counth}<=${args[${Math.Calc[${_count}+2]}]};_counth:Inc)
							{
								if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
									EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
								wait 5
							}
							;unpause bots
							RI_CMD_PauseCombatBots 0
						}
						wait 5
						_Done:Set[TRUE]
						; if ${Trigger}
						; {
							; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							; Trigger:Set[FALSE]
						; }
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
					}
				}
			}
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_Done} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				if ${RI_Var_Bool_BreakPathFunction}
				{
					RI_Var_Bool_BreakPathFunction:Set[0]
					return
				}
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if !${_Done}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]} 
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								;wait 5
								;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while !${Trigger}
								{
									if ${RI_Var_Bool_BreakPathFunction}
									{
										RI_Var_Bool_BreakPathFunction:Set[0]
										return
									}
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
									{
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
										continue
									}
									RI_CMD_PauseCombatBots 1
									wait 5
									Actor[Query, ID=${_ID}]:DoFace
									wait 5
									Actor[Query, ID=${_ID}]:DoTarget
									wait 5
									eq2execute hail
									wait 5
								
									variable int count
									for(count:Set[1];${count}<=${args[${Math.Calc[${_count}+2]}]};count:Inc)
									{
										if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
											EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
										wait 5
									}
									;unpause bots
									RI_CMD_PauseCombatBots 0
								}
								wait 5
								_Done:Set[TRUE]
								;if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								; {
									; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									; Trigger:Set[FALSE]
								; }
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
							}
						}
					}
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_Done}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathHailCast(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _Mob, string _Trigger, int _Quantity, string _CastID
	variable int _start
	variable int _end
	variable int _count
	variable int _Precision=2
	variable string _Query
	variable int _ID
	;variable string _tempName
	variable string _temp
	variable bool _IWasFlying=FALSE
	variable bool _Done
	variable int _endcnt=0
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat[" ${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}: ${args[${Math.Calc[${_count}+3]}]}"]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
			IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		else
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
			
		;echo inserted ${args[${Math.Calc[${_count}+1]}].Right[-3]} // ${AnnounceText.Get[1]} // ${IncomingText.Get[1]}
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
	; {
		; echo ${IncomingText.Get[${_count}]}
	; }
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	;echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if !${_Done}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 5
						;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while !${Trigger}
						{
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
							{
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								continue
							}
							RI_CMD_PauseCombatBots 1
							wait 2
							Actor[Query, ID=${_ID}]:DoFace
							;wait 5
							Actor[Query, ID=${_ID}]:DoTarget
							wait 2
							eq2execute hail
							wait 5
						
							; variable int _counth
							; for(_counth:Set[1];${_counth}<=${args[${Math.Calc[${_count}+3]}]};_counth:Inc)
							; {
								; if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
									; EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
								; wait 5
							; }
							; wait 5
							_endcnt:Set[0]
							while ${Me.Ability[id,${args[${Math.Calc[${_count}+3]}]}].IsReady} && ${_endcnt:Inc}<50
							{
								Me.Ability[id,${args[${Math.Calc[${_count}+3]}]}]:Use
								wait 1
							}
							wait 50 !${Me.CastingSpell}
							eq2ex target_none
							;unpause bots
							RI_CMD_PauseCombatBots 0
						}
						wait 5
						_Done:Set[TRUE]
						; if ${Trigger}
						; {
							; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							; Trigger:Set[FALSE]
						; }
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_Done} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if !${_Done}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]} 
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								;wait 5
								;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while !${Trigger}
								{
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
									{
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
										continue
									}
									RI_CMD_PauseCombatBots 1
									wait 2
									Actor[Query, ID=${_ID}]:DoFace
									;wait 5
									Actor[Query, ID=${_ID}]:DoTarget
									wait 2
									eq2execute hail
									wait 5
								
									; variable int count
									; for(count:Set[1];${count}<=${args[${Math.Calc[${_count}+2]}]};count:Inc)
									; {
										; if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
											; EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
										; wait 5
									; }
									
									_endcnt:Set[0]
									while ${Me.Ability[id,${args[${Math.Calc[${_count}+3]}]}].IsReady} && ${_endcnt:Inc}<50
									{
										Me.Ability[id,${args[${Math.Calc[${_count}+3]}]}]:Use
										wait 1
									}
									wait 50 !${Me.CastingSpell}
									eq2ex target_none
									;unpause bots
									RI_CMD_PauseCombatBots 0
								}
								wait 5
								_Done:Set[TRUE]
								;if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								; {
									; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									; Trigger:Set[FALSE]
								; }
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_Done}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathHailExists(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _Node, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable int _Precision=2
	variable string _Query
	variable int _ID
	;variable string _tempName
	variable string _temp
	variable bool _IWasFlying=FALSE
	variable bool _Done
	
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat[" ${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}: ${args[${Math.Calc[${_count}+3]}]}"]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
			IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		else
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
			
		;echo inserted ${args[${Math.Calc[${_count}+1]}].Right[-3]} // ${AnnounceText.Get[1]} // ${IncomingText.Get[1]}
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
	; {
		; echo ${IncomingText.Get[${_count}]}
	; }
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	;echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if !${_Done}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 5
						;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, Name=-\"${args[${_count}]}\" && ID=${_ID}](exists)}
						{
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
							{
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								continue
							}
							if !${Me.InCombat}
							{
								RI_CMD_PauseCombatBots 1
								wait 5
								Actor[Query, ID=${_ID}]:DoFace
								wait 5
								Actor[Query, ID=${_ID}]:DoTarget
								wait 5
								eq2execute hail
								wait 25
								RI_CMD_PauseCombatBots 0
								wait 25
							}
							
						
							; variable int _counth
							; for(_counth:Set[1];${_counth}<=${args[${Math.Calc[${_count}+2]}]};_counth:Inc)
							; {
								; if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
									; EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
								; wait 5
							; }
						}
						wait 5
						if ${Trigger}
							_Done:Set[TRUE]
						; if ${Trigger}
						; {
							; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							; Trigger:Set[FALSE]
						; }
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
					}
				}
			}
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_Done} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if !${_Done}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]} 
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								;wait 5
								;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, Name=-\"${args[${_count}]}\" && ID=${_ID}](exists)}
								{
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
									{
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
										continue
									}
									if !${Me.InCombat}
									{
										RI_CMD_PauseCombatBots 1
										wait 5
										Actor[Query, ID=${_ID}]:DoFace
										wait 5
										Actor[Query, ID=${_ID}]:DoTarget
										wait 5
										eq2execute hail
										wait 25
										RI_CMD_PauseCombatBots 0
										wait 25
									}
									; variable int count
									; for(count:Set[1];${count}<=${args[${Math.Calc[${_count}+2]}]};count:Inc)
									; {
										; if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
											; EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
										; wait 5
									; }
								}
								wait 5
								if ${Trigger}
									_Done:Set[TRUE]
								;if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								; {
									; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									; Trigger:Set[FALSE]
								; }
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
							}
						}
					}
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_Done}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathHailDistance(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _Node, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable int _Precision=2
	variable string _Query
	variable int _ID
	;variable string _tempName
	variable string _temp
	variable bool _IWasFlying=FALSE
	variable bool _Done
	
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat[" ${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}: ${args[${Math.Calc[${_count}+3]}]}"]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		; _AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
			IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		else
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
			
		;echo inserted ${args[${Math.Calc[${_count}+1]}].Right[-3]} // ${AnnounceText.Get[1]} // ${IncomingText.Get[1]}
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
	; {
		; echo ${IncomingText.Get[${_count}]}
	; }
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	;echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if !${_Done}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 5
						;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, Name=-\"${args[${_count}]}\" && ID=${_ID} && Distance<=10](exists)}
						{
							; if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
							; {
								; call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								; continue
							; }
							if !${Me.InCombat}
							{
								RI_CMD_PauseCombatBots 1
								wait 5
								Actor[Query, ID=${_ID}]:DoFace
								wait 5
								Actor[Query, ID=${_ID}]:DoTarget
								wait 5
								eq2execute hail
							}
							wait 25
						
							; variable int _counth
							; for(_counth:Set[1];${_counth}<=${args[${Math.Calc[${_count}+2]}]};_counth:Inc)
							; {
								; if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
									; EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
								; wait 5
							; }
							;unpause bots
							RI_CMD_PauseCombatBots 0
						}
						wait 5
						if ${Trigger}
							_Done:Set[TRUE]
						; if ${Trigger}
						; {
							; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							; Trigger:Set[FALSE]
						; }
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
					}
				}
			}
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_Done} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if !${_Done}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<20 && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]} 
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								;wait 5
								;_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, Name=-\"${args[${_count}]}\" && ID=${_ID} && Distance<=10](exists)}
								{
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
									{
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
										continue
									}
									if !${Me.InCombat}
									{
										RI_CMD_PauseCombatBots 1
										wait 5
										Actor[Query, ID=${_ID}]:DoFace
										wait 5
										Actor[Query, ID=${_ID}]:DoTarget
										wait 5
										eq2execute hail
										wait 25
									}
									; variable int count
									; for(count:Set[1];${count}<=${args[${Math.Calc[${_count}+2]}]};count:Inc)
									; {
										; if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}](exists)}
											; EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${args[${Math.Calc[${_count}+3]}]}]:LeftClick
										; wait 5
									; }
									;unpause bots
									RI_CMD_PauseCombatBots 0
								}
								wait 5
								if ${Trigger}
									_Done:Set[TRUE]
								;if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								; {
									; _AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									; echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									; Trigger:Set[FALSE]
								; }
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
							}
						}
					}
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_Done}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathKill(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable bool _CheckQuestStep=FALSE
	variable string _QuestStep=""
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	variable int _countor=0
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[QS-]}
			{
				_QuestStep:Set[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
				_CheckQuestStep:Set[1]
			}
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	; echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		if ${RI_Var_Bool_BreakPathFunction}
		{
			RI_Var_Bool_BreakPathFunction:Set[0]
			return
		}
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				;need to make this unlimited via build query reference the CharmMob function in combatbot
				if ${args[${_count}].Find[|](exists)}
				{
					_Query:Set["( "]
					for(_countor:Set[1];${_countor}<=${Math.Calc[${args[${_count}].Count[|]}+1]};_countor:Inc)
					{
						if ${_countor}==${Math.Calc[${args[${_count}].Count[|]}+1]}
							_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" ) && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
						else
							_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" || "]
					}
				}
				else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						;wait 5
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							if ${RI_Var_Bool_BreakPathFunction}
							{
								RI_Var_Bool_BreakPathFunction:Set[0]
								return
							}
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							wait 2
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							if ${Target.ID}==${Actor[Query, ID=${_ID}].ID} && ( !${Me.TargetLOS} || ${ICantSeeMyTarget} )
							{
								eq2ex target_none
								break
							}
						}
						call RIMObj.CheckCombat
						wait 15
						if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${Trigger}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
							wait 1
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
				if ${Trigger}
				{
					_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
					;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
					echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
					Trigger:Set[FALSE]
				}
			}
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				if ${RI_Var_Bool_BreakPathFunction}
				{
					RI_Var_Bool_BreakPathFunction:Set[0]
					return
				}
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						if ${args[${_count}].Find[|](exists)}
						{
							_Query:Set["( "]
							for(_countor:Set[1];${_countor}<=${Math.Calc[${args[${_count}].Count[|]}+1]};_countor:Inc)
							{
								if ${_countor}==${Math.Calc[${args[${_count}].Count[|]}+1]}
									_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" ) && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
								else
									_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" || "]
							}
						}
						else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 5
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${RI_Var_Bool_BreakPathFunction}
									{
										RI_Var_Bool_BreakPathFunction:Set[0]
										return
									}
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									wait 2
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
									if ${Target.ID}==${Actor[Query, ID=${_ID}].ID} && ( !${Me.TargetLOS} || ${ICantSeeMyTarget} )
									{
										eq2ex target_none
										break
									}
								}
								call RIMObj.CheckCombat
								wait 15
								if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
									wait 1
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
						if ${Trigger}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
					}
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathApplyVerb(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _ActorName, string _TriggerText, string _Verb, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}: ${args[${Math.Calc[${_count}+3]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
	; {
		; echo ${IncomingText.Get[${_count}]}
	; }
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	; echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+3]}]}<${args[${Math.Calc[${_count}+3]}]}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						;wait 5
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+3]}]}<${args[${Math.Calc[${_count}+3]}]}
						{
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							wait 2
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							;echo eq2ex apply_verb ${_ID} "${args[${Math.Calc[${_count}+2]}]}"
							eq2ex apply_verb ${_ID} "${args[${Math.Calc[${_count}+2]}]}"
							wait 5
						}
						call RIMObj.CheckCombat
						wait 15
						if ${Trigger}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+3]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+3]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+3]}]}<${args[${Math.Calc[${_count}+3]}]}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 5
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+3]}]}<${args[${Math.Calc[${_count}+3]}]}
								{
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									wait 2
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
									eq2ex apply_verb ${_ID} "${args[${Math.Calc[${_count}+2]}]}"
									wait 5
								}
								call RIMObj.CheckCombat
								wait 15
								if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+3]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathKillClick(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity, string _ActorToClick
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	;echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						;wait 5
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							wait 2
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						}
						wait 50
						while ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10](exists)}
						{
							call RIMObj.CheckCombat
							if ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].Distance}>4
								call RIMObj.Move ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].X} ${Math.Calc[${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].Y}+1]} ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].Z} 4 0 0 0 1 0 1 1
							Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10]:DoTarget
							wait 2
							Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10]:DoubleClick
							wait 5
							
						}
						if ${Trigger}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 5
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									wait 2
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								}
								wait 50
								while ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10](exists)}
								{
									call RIMObj.CheckCombat
									if ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].Distance}>4
										call RIMObj.Move ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].X} ${Math.Calc[${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].Y}+1]} ${Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10].Z} 4 0 0 0 1 0 1 1
									Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10]:DoTarget
									wait 2
									Actor[Query, Name=-"${args[${Math.Calc[${_count}+3]}]}" && Distance <=10]:DoubleClick
									wait 5
								}
								if ${Trigger} 
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}

function PathItemHail(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity, string _HailOption, string _ItemName
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable bool _ItemCast=FALSE
	variable int count
	variable string _tempbtntxt
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}-_MobName: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}-_TriggerText: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}-_Quantity: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}-_HealthTrigger: ${args[${Math.Calc[${_count}+3]}]} ${Math.Calc[${_count}+4].Precision[0]}-_ItemName: ${args[${Math.Calc[${_count}+4]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	; echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					;echo query exists
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							;echo start of while loop ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} // ${Actor[Query, ID=${_ID} && IsDead=FALSE]} // ${_ID}
							if !${_ItemCast}
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							if !${_ItemCast}
								eq2ex pet backoff
							wait 5
							if !${_ItemCast}
								eq2ex pet backoff
							;echo ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							if ${Target.Health}>0 && !${_ItemCast} && ${Me.TargetLOS}
							{
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
								relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
								wait 2
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5 ${Me.CastingSpell}
								wait 50 !${Me.CastingSpell}
								wait 50
								;unpause bots
								;relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
								_ItemCast:Set[TRUE]
							}
							if ${_ItemCast}
							{
								if ${Actor[Query, ID=${_ID}].Distance}>7
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 7 0 0 0 1 0 1 1
								wait 10
								relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
								;wait 5
								;change camera
								relay ${RI_Var_String_RelayGroup} -noredirect Press -hold "Page Down"
								wait 15
								;change camera
								relay ${RI_Var_String_RelayGroup} -noredirect Press -release "Page Down"
								relay ${RI_Var_String_RelayGroup} -noredirect Press -hold "Page Up"
								wait 3
								relay ${RI_Var_String_RelayGroup} -noredirect Press -release "Page Up"
								
								relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoFace
								relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoFace
								wait 5
								;scroll the mouse wheel
								relay ${RI_Var_String_RelayGroup} -noredirect MouseWheel -10000
								relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoTarget
								relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoTarget
								wait 5
								relay ${RI_Var_String_RelayGroup} -noredirect eq2execute hail
								wait 5
								for(count:Set[1];${count}<=${args[${Math.Calc[${_count}+3]}]};count:Inc)
								{
									_tempbtntxt:Set["${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText]}"]
									if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)}
										relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
									wait 5
									wait 20 ( ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1].GetProperty[LocalText].NotEqual["${_tempbtntxt}"]} || !${EQ2UIPage[ProxyActor,Conversation].IsVisible} )
								}
								;unpause bots
								relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
							}
							else
							{
								if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							}
							;echo end of while loop
						}
						_ItemCast:Set[FALSE]
						call RIMObj.CheckCombat
						wait 15
						if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									;echo start of while loop ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} // ${Actor[Query, ID=${_ID} && IsDead=FALSE]} // ${_ID}
									if !${_ItemCast}
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									if !${_ItemCast}
										eq2ex pet backoff
									wait 5
									if !${_ItemCast}
										eq2ex pet backoff
									;echo ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
									if ${Target.Health}>0 && !${_ItemCast} && ${Me.TargetLOS}
									{
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
										relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
										wait 2
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5 ${Me.CastingSpell}
										wait 50 !${Me.CastingSpell}
										wait 50
										;unpause bots
										;relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
										_ItemCast:Set[TRUE]
									}
									if ${_ItemCast}
									{
										if ${Actor[Query, ID=${_ID}].Distance}>7
											call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 7 0 0 0 1 0 1 1
										wait 10
										relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
										;wait 5
										;change camera
										relay ${RI_Var_String_RelayGroup} -noredirect Press -hold "Page Down"
										wait 15
										;change camera
										relay ${RI_Var_String_RelayGroup} -noredirect Press -release "Page Down"
										relay ${RI_Var_String_RelayGroup} -noredirect Press -hold "Page Up"
										wait 3
										relay ${RI_Var_String_RelayGroup} -noredirect Press -release "Page Up"
										
										relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoFace
										relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoFace
										wait 5
										;scroll the mouse wheel
										relay ${RI_Var_String_RelayGroup} -noredirect MouseWheel -10000
										relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoTarget
										relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoTarget
										wait 5
										relay ${RI_Var_String_RelayGroup} -noredirect eq2execute hail
										wait 5
										for(count:Set[1];${count}<=${args[${Math.Calc[${_count}+3]}]};count:Inc)
										{
											_tempbtntxt:Set["${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText]}"]
											if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)}
												relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
											wait 5
											wait 20 ( ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1].GetProperty[LocalText].NotEqual["${_tempbtntxt}"]} || !${EQ2UIPage[ProxyActor,Conversation].IsVisible} )
										}
										;unpause bots
										relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
									}
									else
									{
										if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
											call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
									}
									;echo end of while loop
								}
								_ItemCast:Set[FALSE]
								call RIMObj.CheckCombat
								wait 15
								if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathItemKillApplyVerb(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity, int _HealthTrigger, string _ItemName, string _Verb
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable bool _ItemCast=FALSE
	variable bool _CheckQuestStep=FALSE
	variable string _QuestStep=""
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}-_MobName: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}-_TriggerText: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}-_Quantity: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}-_HealthTrigger: ${args[${Math.Calc[${_count}+3]}]} ${Math.Calc[${_count}+4].Precision[0]}-_ItemName: ${args[${Math.Calc[${_count}+4]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[QS-]}
			{
				_QuestStep:Set[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
				_CheckQuestStep:Set[1]
			}
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	; echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					;echo query exists
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							;echo start of while loop ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} // ${Actor[Query, ID=${_ID} && IsDead=FALSE]} // ${_ID}
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								eq2ex pet backoff
							wait 5
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								eq2ex pet backoff
							;echo ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							if ${Target.Health}>0 && ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							{
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
								relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
								wait 2
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5 ${Me.CastingSpell}
								wait 50 !${Me.CastingSpell}
								wait 50
								;unpause bots
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
								_ItemCast:Set[TRUE]
							}
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							if !${Actor[Query, ID=${_ID}].IsAggro}
							{
								if ${Actor[Query, ID=${_ID}].Distance}>5
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 5 0 0 0 1 0 1 1
								eq2ex apply_verb ${_ID} "${args[${Math.Calc[${_count}+5]}]}"
								wait 10
							}
							;echo end of while loop
						}
						_ItemCast:Set[FALSE]
						call RIMObj.CheckCombat
						wait 15
						if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
			_count:Inc
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										eq2ex pet backoff
									wait 5
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										eq2ex pet backoff
									if ${Target.Health}>0 && ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
									{
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
										relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
										wait 2
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5 ${Me.CastingSpell}
										wait 50 !${Me.CastingSpell}
										wait 50
										;unpause bots
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
										_ItemCast:Set[TRUE]
									}
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
									if !${Actor[Query, ID=${_ID}].IsAggro}
									{
										if ${Actor[Query, ID=${_ID}].Distance}>5
											call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 5 0 0 0 1 0 1 1
										eq2ex apply_verb ${_ID} "${args[${Math.Calc[${_count}+5]}]}"
										wait 10
									}
								}
								_ItemCast:Set[FALSE]
								call RIMObj.CheckCombat
								wait 15
								if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
					_count:Inc
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathItemKillClick(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity, int _HealthTrigger, string _ItemName
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable bool _ItemCast=FALSE
	variable bool _CheckQuestStep=FALSE
	variable string _QuestStep=""
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}-_MobName: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}-_TriggerText: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}-_Quantity: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}-_HealthTrigger: ${args[${Math.Calc[${_count}+3]}]} ${Math.Calc[${_count}+4].Precision[0]}-_ItemName: ${args[${Math.Calc[${_count}+4]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[QS-]}
			{
				_QuestStep:Set[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
				_CheckQuestStep:Set[1]
			}
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	; echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				; if ${_HighlightOnMouseHover}
					; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				; else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					;echo query exists
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							;echo start of while loop ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} // ${Actor[Query, ID=${_ID} && IsDead=FALSE]} // ${_ID}
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								eq2ex pet backoff
							wait 5
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								eq2ex pet backoff
							;echo ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							if ${Target.Health}>0 && ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							{
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
								relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
								wait 2
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5 ${Me.CastingSpell}
								wait 50 !${Me.CastingSpell}
								wait 50
								;unpause bots
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
								_ItemCast:Set[TRUE]
							}
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							if !${Actor[Query, ID=${_ID}].IsAggro}
							{
								if ${Actor[Query, ID=${_ID}].Distance}>5
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 5 0 0 0 1 0 1 1
								Actor[Query, ID=${_ID}]:DoubleClick
								wait 50
							}
							;echo end of while loop
						}
						_ItemCast:Set[FALSE]
						call RIMObj.CheckCombat
						wait 15
						if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						; if ${_HighlightOnMouseHover}
							; _Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						; else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										eq2ex pet backoff
									wait 5
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										eq2ex pet backoff
									if ${Target.Health}>0 && ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
									{
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
										relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
										wait 2
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5 ${Me.CastingSpell}
										wait 50 !${Me.CastingSpell}
										wait 50
										;unpause bots
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
										_ItemCast:Set[TRUE]
									}
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
									if !${Actor[Query, ID=${_ID}].IsAggro}
									{
										if ${Actor[Query, ID=${_ID}].Distance}>5
											call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 5 0 0 0 1 0 1 1
										Actor[Query, ID=${_ID}]:DoubleClick
										wait 50
									}
								}
								_ItemCast:Set[FALSE]
								call RIMObj.CheckCombat
								wait 15
								if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathItemKill(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity, int _HealthTrigger, string _ItemName
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable bool _ItemCast=FALSE
	variable bool _CheckQuestStep=FALSE
	variable string _QuestStep=""
	variable int _countor=0
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}-_MobName: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}-_TriggerText: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}-_Quantity: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}-_HealthTrigger: ${args[${Math.Calc[${_count}+3]}]} ${Math.Calc[${_count}+4].Precision[0]}-_ItemName: ${args[${Math.Calc[${_count}+4]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[QS-]}
			{
				_QuestStep:Set[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
				_CheckQuestStep:Set[1]
			}
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	; echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				if ${args[${_count}].Find[|](exists)}
				{
					_Query:Set["( "]
					for(_countor:Set[1];${_countor}<=${Math.Calc[${args[${_count}].Count[|]}+1]};_countor:Inc)
					{
						if ${_countor}==${Math.Calc[${args[${_count}].Count[|]}+1]}
							_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" ) && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
						else
							_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" || "]
					}
				}
				else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					;echo query exists
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							;echo start of while loop ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} // ${Actor[Query, ID=${_ID} && IsDead=FALSE]} // ${_ID}
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								eq2ex pet backoff
							wait 5
							if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
								eq2ex pet backoff
							;echo ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							if ${Target.Health}>0 && ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							{
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
								relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
								wait 2
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5
								eq2ex pet backoff
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
								wait 5 ${Me.CastingSpell}
								wait 50 !${Me.CastingSpell}
								wait 50
								;unpause bots
								relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
								_ItemCast:Set[TRUE]
							}
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							;echo end of while loop
						}
						_ItemCast:Set[FALSE]
						call RIMObj.CheckCombat
						wait 15
						if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						if ${args[${_count}].Find[|](exists)}
						{
							_Query:Set["( "]
							for(_countor:Set[1];${_countor}<=${Math.Calc[${args[${_count}].Count[|]}+1]};_countor:Inc)
							{
								if ${_countor}==${Math.Calc[${args[${_count}].Count[|]}+1]}
									_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" ) && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
								else
									_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" || "]
							}
						}
						else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										eq2ex pet backoff
									wait 5
									if ${args[${Math.Calc[${_count}+3]}]}==100 && !${_ItemCast}
										eq2ex pet backoff
									if ${Target.Health}>0 && ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
									{
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 1
										relay "${RI_Var_String_RelayGroup}" eq2ex cancel_spellcast
										wait 2
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5
										eq2ex pet backoff
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"]:Use
										wait 5 ${Me.CastingSpell}
										wait 50 !${Me.CastingSpell}
										wait 50
										;unpause bots
										relay "${RI_Var_String_RelayGroup}" RI_CMD_PauseCombatBots 0
										_ItemCast:Set[TRUE]
									}
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								}
								_ItemCast:Set[FALSE]
								call RIMObj.CheckCombat
								wait 15
								if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathItem(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
{	
	Trigger:Set[FALSE]
	;variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, int _Precision=${_Precision}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _MobName, string _TriggerText, int _Quantity, int _HealthTrigger, string _ItemName
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountKilled
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable bool _ItemCast=FALSE
	variable bool _CheckQuestStep=FALSE
	variable string _QuestStep=""
	variable int _countor=0
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	_start:Set[${MainArrayCounter}]

	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		;echostr:Concat["${_count}-_MobName: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}-_TriggerText: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}-_Quantity: ${args[${Math.Calc[${_count}+2]}]} ${Math.Calc[${_count}+3].Precision[0]}-_HealthTrigger: ${args[${Math.Calc[${_count}+3]}]} ${Math.Calc[${_count}+4].Precision[0]}-_ItemName: ${args[${Math.Calc[${_count}+4]}]}"]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		_AmountKilled:Insert[0]
		
		if ${args[${Math.Calc[${_count}+1]}].NotEqual[0]}
		{
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3]}
			;echo ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			if ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
				IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
			elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[QS-]}
			{
				_QuestStep:Set[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
				_CheckQuestStep:Set[1]
			}
			else
				AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		}
		else
		{
			IncomingText:Insert["You have killed"]
			IncomingText2:Insert["${args[${_count}]}"]
		}
		_count:Inc
		_count:Inc
		_count:Inc
		_count:Inc
	}
	; for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
	; {
		; echo ${AnnounceText.Get[${_count}]}
	; }
	;echo ${echostr}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		call RIMObj.CheckCombat
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;check for our node and if we are
			if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				if ${args[${_count}].Find[|](exists)}
				{
					_Query:Set["( "]
					for(_countor:Set[1];${_countor}<=${Math.Calc[${args[${_count}].Count[|]}+1]};_countor:Inc)
					{
						if ${_countor}==${Math.Calc[${args[${_count}].Count[|]}+1]}
							_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" ) && Distance<=${_Distance}"]
						else
							_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" || "]
					}
				}
				else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					;echo query exists
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<${_Precision} || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							;echo start of while loop ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} // ${Actor[Query, ID=${_ID} && IsDead=FALSE]} // ${_ID}
							if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
								Actor[Query, ID=${_ID}]:DoTarget
							wait 5
							;echo ${Target.Health}<=${args[${Math.Calc[${_count}+3]}]} && !${_ItemCast} && ${Me.TargetLOS}
							if !${_ItemCast} && ${Me.TargetLOS}
							{

								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+3]}]}"]:Use
								wait 5
								relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+3]}]}"]:Use
								wait 5 ${Me.CastingSpell}
								wait 50 !${Me.CastingSpell}
								wait 50
								;unpause bots
								_ItemCast:Set[TRUE]
							}
							if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
							;echo end of while loop
						}
						_ItemCast:Set[FALSE]
						call RIMObj.CheckCombat
						wait 15
						if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
						{
							_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
							;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
					}
				}
			}
			_count:Inc
			_count:Inc
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
			if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
			_count:Inc
			_count:Inc
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						if ${args[${_count}].Find[|](exists)}
						{
							_Query:Set["( "]
							for(_countor:Set[1];${_countor}<=${Math.Calc[${args[${_count}].Count[|]}+1]};_countor:Inc)
							{
								if ${_countor}==${Math.Calc[${args[${_count}].Count[|]}+1]}
									_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" ) && Distance<=${_Distance}"]
								else
									_Query:Concat["Name=-\"${args[${_count}].Token[${_countor},|]}\" || "]
							}
						}
						else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance}"]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<15 || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) && !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							;( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 FALSE FALSE TRUE FALSE TRUE TRUE
								;wait 5
								;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID} && IsDead=FALSE](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${Target.ID}!=${Actor[Query, ID=${_ID}].ID}
										Actor[Query, ID=${_ID}]:DoTarget
									if !${_ItemCast} && ${Me.TargetLOS}
									{
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+3]}]}"]:Use
										wait 5
										relay "${RI_Var_String_RelayGroup}" Me.Inventory["${args[${Math.Calc[${_count}+3]}]}"]:Use
										wait 5 ${Me.CastingSpell}
										wait 50 !${Me.CastingSpell}
										wait 50
										_ItemCast:Set[TRUE]
									}
									if ${Actor[Query, ID=${_ID}].Distance}>${Math.Calc[${_Precision}+5]}
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} ${_Precision} 0 0 0 1 0 1 1
								}
								_ItemCast:Set[FALSE]
								call RIMObj.CheckCombat
								wait 15
								if ${_CheckQuestStep} && ${RIObj.QuestStepExists[${_QuestStep}]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${_QuestStep} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${Trigger} || ( ${args[${Math.Calc[${_count}+1]}].Equal[*ITEMGONE*]} && !${Me.Inventory["${args[${Math.Calc[${_count}+4]}]}"](exists)} )
								;|| ${args[${Math.Calc[${_count}+1]}].Equal[0]}
								{
									_AmountKilled.Get[${Math.Calc[${_count}+2]}]:Inc
									;echo ISXRI: Killed ${_AmountKilled.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 0 0 1 0 1 1
							}
						}
					}
					_count:Inc
					_count:Inc
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
					if ${_AmountKilled.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
					_count:Inc
					_count:Inc
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathHarvest(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, bool _HighlightOnMouseHover=FALSE, ... args)
{	
	Trigger:Set[FALSE]
	if ${RI_Var_Bool_PathDebug}
		variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _Node, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountHarvested
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable int _YINC=2
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
	
	if ${QuestJournalWindow.ActiveQuest["Borrowing From The Dead"](exists)}
		AnnounceText:Insert[I found some rusty armor scraps]
	if ${QuestJournalWindow.ActiveQuest["Dying of Bore-dom"](exists)}
	{
		AnnounceText:Insert["You notice larvae in the soil!"]
		AnnounceText:Insert["I didn't find any adult beetles, but I did find larvae"]
	}
	if ${QuestJournalWindow.ActiveQuest["Process of Elimination"](exists)}
		AnnounceText:Insert["fungal samples"]
	if ${QuestJournalWindow.ActiveQuest["The Final Blow"](exists)}	
		AnnounceText:Insert["arcanna'se precious metal"]
	if ${QuestJournalWindow.ActiveQuest["Kunark Ascending: History in Stone"](exists)}
	{
		if ${args[1].Equal[stolen pylon]}
			_YINC:Set[5]
	}
	_start:Set[${MainArrayCounter}]
	
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		if ${RI_Var_Bool_PathDebug}
			echostr:Concat["${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]}"]
		_AmountHarvested:Insert[0]
		_AmountHarvested:Insert[0]
		_AmountHarvested:Insert[0]
		;echo ${args[${Math.Calc[${_count}+1]}]} // ${args[${Math.Calc[${_count}+1]}].Find[AT-](exists)}
		if ${args[${Math.Calc[${_count}+1]}].Equal[0]}
		{
			AnnounceText:Insert[You have]
			AnnounceText:Insert[You receive]
		}
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
			IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		else
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		_count:Inc
		_count:Inc
	}
	if ${RI_Var_Bool_PathDebug}
		echo ${echostr}
	if ${RI_Var_Bool_PathDebug}
	{
		for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
		{
			echo Announce: ${AnnounceText.Get[${_count}]}
		}
		for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
		{
			echo IncomingText: ${IncomingText.Get[${_count}]}
		}
		echo Qty's:
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			echo ${args[${_count}]}
		}
	}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${RI_Var_Bool_BreakPathFunction}
			{
				RI_Var_Bool_BreakPathFunction:Set[0]
				return
			}
			call RIMObj.CheckCombat
			;check for our node and if we are
			;echo 1: ${args[${Math.Calc[${_count}+0]}]}
			;echo 2: ${args[${Math.Calc[${_count}+1]}]}
			;echo 3: ${args[${Math.Calc[${_count}+2]}]}
			if ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				if ${args[${_count}].Find[|](exists)}
				{
					;eventually need to code it to .Count[|] and add 1 and concat the query with Each element until it has all of them
					;echo ${args[${_count}].Token[1,|].Left[10]} // ${args[${_count}].Token[1,|].Left[10].Equal[TintFlags-]}
					if ${args[${_count}].Token[1,|].Left[10].Equal[TintFlags-]} && ${_HighlightOnMouseHover}
						_Query:Set["( TintFlags=${args[${_count}].Token[1,|].Right[-10]} || TintFlags=${args[${_count}].Token[2,|].Right[-10]} ) && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
					elseif ${args[${_count}].Token[1,|].Left[10].Equal[TintFlags-]}
						_Query:Set["( TintFlags=${args[${_count}].Token[1,|].Right[-10]} || TintFlags=${args[${_count}].Token[2,|].Right[-10]} ) && Distance<=${_Distance}"]
					elseif ${_HighlightOnMouseHover}
						_Query:Set["( Name=-\"${args[${_count}].Token[1,|]}\" || Name=-\"${args[${_count}].Token[2,|]}\" ) && Distance<=${_Distance} && HighlightOnMouseHover=TRUE && Type!=\"NPC\" && Type!=\"NamedNPC\""]
					else
						_Query:Set["( Name=-\"${args[${_count}].Token[1,|]}\" || Name=-\"${args[${_count}].Token[2,|]}\" ) && Distance<=${_Distance} && Type!=\"NPC\" && Type!=\"NamedNPC\""]
				}
				else
				{
					if ${args[${_count}].Left[10].Equal[TintFlags-]} && ${_HighlightOnMouseHover}
						_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
					elseif ${args[${_count}].Left[10].Equal[TintFlags-]}
						_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance}"]
					elseif ${_HighlightOnMouseHover}
						_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE && Type!=\"NPC\" && Type!=\"NamedNPC\""]
					else
						_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && Type!=\"NPC\" && Type!=\"NamedNPC\""]
				}
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+${_YINC}]},${Actor[Query, ID=${_ID}].Z}]}
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						{
							if ${Me.FlyingUsingMount}
								_IWasFlying:Set[TRUE]
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							if ${Me.FlyingUsingMount}
								call RIMObj.FlyDown
						}
						else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID}](exists)} && ( ${Me.CastingSpell} ||${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							if ${RI_Var_Bool_BreakPathFunction}
							{
								RI_Var_Bool_BreakPathFunction:Set[0]
								return
							}
							call RIMObj.CheckCombat
							relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoTarget
							wait 5
							relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoubleClick
							wait 5 ${Me.CastingSpell}
							wait 50 !${Me.CastingSpell}
							wait 2
							;echo ${Time}: Before: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
							;echo ${Trigger} // ${TriggerMessage}
							if ${Trigger}
							{
								_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
								echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
								Trigger:Set[FALSE]
								wait 1
							}
							if ${Actor[Query, ID=${_ID}].Distance}>2
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							;echo ${Time}: After: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
						}
						wait 5
						if ${Me.IsSwimming}
							call SwimUp
						if ${_IWasFlying}
						{
							press -hold ${RI_Var_String_FlyUpKey}
							wait 1
							press -release ${RI_Var_String_FlyUpKey}
							_IWasFlying:Set[FALSE]
						}
						call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
					}
				}
				if ${Trigger}
				{
					_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
					echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
					Trigger:Set[FALSE]
				}
			}
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
			if ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				if ${RI_Var_Bool_BreakPathFunction}
				{
					RI_Var_Bool_BreakPathFunction:Set[0]
					return
				}
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						if ${args[${_count}].Left[10].Equal[TintFlags-]} && ${_HighlightOnMouseHover}
							_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						elseif ${args[${_count}].Left[10].Equal[TintFlags-]}
							_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance}"]
						elseif ${_HighlightOnMouseHover}
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE && Type!=\"NPC\" && Type!=\"NamedNPC\""]
						else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && Type!=\"NPC\" && Type!=\"NamedNPC\""]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+${_YINC}]},${Actor[Query, ID=${_ID}].Z}]}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								{
									if ${Me.FlyingUsingMount}
										_IWasFlying:Set[TRUE]
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
									if ${Me.FlyingUsingMount}
										call RIMObj.FlyDown
								}
								else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID}](exists)} && ( ${Me.CastingSpell} || ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									if ${RI_Var_Bool_BreakPathFunction}
									{
										RI_Var_Bool_BreakPathFunction:Set[0]
										return
									}
									call RIMObj.CheckCombat
									relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoTarget
									wait 5
									relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoubleClick
									wait 5 ${Me.CastingSpell}
									wait 50 !${Me.CastingSpell}
									wait 2
									;echo ${Time}: Before: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
									;echo ${Trigger} // ${TriggerMessage}
									if ${Trigger}
									{
										_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
										;echo ISXRI: Harvested ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
										echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
										Trigger:Set[FALSE]
										wait 1
									}
									;echo ${Time}: After: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
									if ${Actor[Query, ID=${_ID}].Distance}>2
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								}
								wait 5
								if ${Me.IsSwimming}
									call SwimUp
								if ${_IWasFlying}
								{
									press -hold ${RI_Var_String_FlyUpKey}
									wait 1
									press -release ${RI_Var_String_FlyUpKey}
									_IWasFlying:Set[FALSE]
								}
								call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
							}
						}
						if ${Trigger}
						{
							_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
					}
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
					if ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function PathFlyHarvest(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, bool _HighlightOnMouseHover=FALSE, ... args)
{	
	Trigger:Set[FALSE]
	if ${RI_Var_Bool_PathDebug}
		variable string echostr="int _PathLines=${_PathLines}, int _Distance=${_Distance}, bool _Loop=${_Loop}, bool _GoReverseAfterAllQuantitiesMet=${_GoReverseAfterAllQuantitiesMet}, bool _GoReverseAtLoopOrEnd=${_GoReverseAtLoopOrEnd}, ... args="
	;string _Node, int _Quantity,
	variable int _start
	variable int _end
	variable int _count
	variable string _Query
	variable int _ID
	variable string _tempName
	variable string _temp
	variable index:int _AmountHarvested
	variable bool _AllQuantitiesMet
	variable bool _IWasFlying=FALSE
	variable int _YINC=2
	AnnounceText:Clear
	IncomingText:Clear
	IncomingText2:Clear
		
	if ${QuestJournalWindow.ActiveQuest["Borrowing From The Dead"](exists)}
		AnnounceText:Insert[I found some rusty armor scraps]
	if ${QuestJournalWindow.ActiveQuest["Dying of Bore-dom"](exists)}
	{
		AnnounceText:Insert["You notice larvae in the soil!"]
		AnnounceText:Insert["I didn't find any adult beetles, but I did find larvae"]
	}
	if ${QuestJournalWindow.ActiveQuest["Process of Elimination"](exists)}
		AnnounceText:Insert["fungal samples"]
	if ${QuestJournalWindow.ActiveQuest["The Final Blow"](exists)}	
		AnnounceText:Insert["arcanna'se precious metal"]
	if ${QuestJournalWindow.ActiveQuest["Kunark Ascending: History in Stone"](exists)}
	{
		if ${args[1].Equal[stolen pylon]}
			_YINC:Set[5]
	}
	_start:Set[${MainArrayCounter}]
	
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		if ${RI_Var_Bool_PathDebug}
			echostr:Concat["${_count}: ${args[${_count}]} ${Math.Calc[${_count}+1].Precision[0]}: ${args[${Math.Calc[${_count}+1]}]} ${Math.Calc[${_count}+2].Precision[0]}: ${args[${Math.Calc[${_count}+2]}]}"]
		_AmountHarvested:Insert[0]
		_AmountHarvested:Insert[0]
		_AmountHarvested:Insert[0]
		;echo ${args[${Math.Calc[${_count}+1]}]} // ${args[${Math.Calc[${_count}+1]}].Find[AT-](exists)}
		if ${args[${Math.Calc[${_count}+1]}].Equal[0]}
		{
			AnnounceText:Insert[You have]
			AnnounceText:Insert[You receive]
		}
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[AT-]}
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		elseif ${args[${Math.Calc[${_count}+1]}].Left[3].Equal[IT-]}
			IncomingText:Insert[${args[${Math.Calc[${_count}+1]}].Right[-3]}]
		else
			AnnounceText:Insert[${args[${Math.Calc[${_count}+1]}]}]
		_count:Inc
		_count:Inc
	}
	if ${RI_Var_Bool_PathDebug}
		echo ${echostr}
	if ${RI_Var_Bool_PathDebug}
	{
		for(_count:Set[1];${_count}<=${AnnounceText.Used};_count:Inc)
		{
			echo Announce: ${AnnounceText.Get[${_count}]}
		}
		for(_count:Set[1];${_count}<=${IncomingText.Used};_count:Inc)
		{
			echo IncomingText: ${IncomingText.Get[${_count}]}
		}
		echo Qty's:
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			echo ${args[${_count}]}
		}
	}
	_end:Set[${Math.Calc[${MainArrayCounter}+${_PathLines}]}]
	for(;${MainArrayCounter}<=${_end};MainArrayCounter:Inc)
	{
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			call RIMObj.CheckCombat
			;check for our node and if we are
			;echo 1: ${args[${Math.Calc[${_count}+0]}]}
			;echo 2: ${args[${Math.Calc[${_count}+1]}]}
			;echo 3: ${args[${Math.Calc[${_count}+2]}]}
			if ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
			{
				if ${args[${_count}].Left[10].Equal[TintFlags-]} && ${_HighlightOnMouseHover}
					_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
				elseif ${args[${_count}].Left[10].Equal[TintFlags-]}
					_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance}"]
				elseif ${_HighlightOnMouseHover}
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE && Type!=\"NPC\" && Type!=\"NamedNPC\""]
				else
					_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && Type!=\"NPC\" && Type!=\"NamedNPC\""]
				;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
				if ${Actor[Query, ${_Query}](exists)}
				{
					_ID:Set[${Actor[Query, ${_Query}].ID}]
					;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
					if !${Actor[Query, ID=${_ID}].CheckCollision}
					{
						_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
						; if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
						; {
							; if ${Me.FlyingUsingMount}
								; _IWasFlying:Set[TRUE]
							; call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							; if ${Me.FlyingUsingMount}
								; call RIMObj.FlyDown
						; }
						; else
							call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						;wait 5
						;call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
						wait 20
						_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
						while ${Actor[Query, ID=${_ID}](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
						{
							call RIMObj.CheckCombat
							relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoTarget
							wait 5
							relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoubleClick
							wait 5 ${Me.CastingSpell}
							wait 50 !${Me.CastingSpell}
							wait 2
							;echo ${Time}: Before: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
							;echo ${Trigger} // ${TriggerMessage}
							if ${Trigger}
							{
								_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
								echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
								Trigger:Set[FALSE]
							}
							if ${Actor[Query, ID=${_ID}].Distance}>2
								call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
							;echo ${Time}: After: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
						}
						wait 5
						if ${Trigger}
						{
							_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
							echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
							Trigger:Set[FALSE]
						}
						; if ${_IWasFlying}
						; {
							; press -hold ${RI_Var_String_FlyUpKey}
							; wait 1
							; press -release ${RI_Var_String_FlyUpKey}
							; _IWasFlying:Set[FALSE]
						; }
						call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
					}
				}
			}
			_count:Inc
			_count:Inc
		}
		call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
		_AllQuantitiesMet:Set[TRUE]
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			_count:Inc
			_count:Inc
			;echo ${_count}: ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
			if ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
				_AllQuantitiesMet:Set[FALSE]
		}
		; if ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet}
		; {
			; MainArrayCounter:Set[${_end}]
			; echo TimeToEnd
		; }
		if ( ${MainArrayCounter}==${_end} && ${_GoReverseAtLoopOrEnd} ) || ( ${_GoReverseAfterAllQuantitiesMet} && ${_AllQuantitiesMet} )
		{
			MainArrayCounter:Dec
			for(;${MainArrayCounter}>=${_start};MainArrayCounter:Dec)
			{
				call RIMObj.CheckCombat
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					;check for our node and if we are
					if ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
					{
						if ${args[${_count}].Left[10].Equal[TintFlags-]} && ${_HighlightOnMouseHover}
							_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance} && HighlightOnMouseHover=TRUE"]
						elseif ${args[${_count}].Left[10].Equal[TintFlags-]}
							_Query:Set["TintFlags=${args[${_count}].Right[-10]} && Distance<=${_Distance}"]
						elseif ${_HighlightOnMouseHover}
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && HighlightOnMouseHover=TRUE && Type!=\"NPC\" && Type!=\"NamedNPC\""]
						else
							_Query:Set["Name=-\"${args[${_count}]}\" && Distance<=${_Distance} && Type!=\"NPC\" && Type!=\"NamedNPC\""]

						;echo ${_Query} // ${Actor[Query, ${_Query}](exists)}
						if ${Actor[Query, ${_Query}](exists)}
						{
							_ID:Set[${Actor[Query, ${_Query}].ID}]
							;echo if ( ( ${Me.FlyingUsingMount} && (${Me.Y}<${Actor[Query, ID=${_ID}].Y} && ${Math.Distance[${Me.Y},${Actor[Query, ID=${_ID}].Y}]}<5 ) || ${Me.Y}>${Actor[Query, ID=${_ID}].Y} ) || !${Me.FlyingUsingMount} )&& !${EQ2.CheckCollision[${Me.Loc},${Actor[Query, ID=${_ID}].X},${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]},${Actor[Query, ID=${_ID}].Z}]}
							if !${Actor[Query, ID=${_ID}].CheckCollision}
							{
								_temp:Set["${Me.X} ${Me.Y} ${Me.Z}"]
								; if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
								; {
									; if ${Me.FlyingUsingMount}
										; _IWasFlying:Set[TRUE]
									; call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Me.Y} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
									; if ${Me.FlyingUsingMount}
										; call RIMObj.FlyDown
								; }
								; else
									call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								wait 20
								_tempName:Set[${Actor[Query, ID=${_ID}].Name}]
								while ${Actor[Query, ID=${_ID}](exists)} && ( ${Actor[Query, ID=${_ID}].HighlightOnMouseHover} || !${_HighlightOnMouseHover} ) && ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}<${args[${Math.Calc[${_count}+2]}]}
								{
									call RIMObj.CheckCombat
									relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoTarget
									wait 5
									relay ${RI_Var_String_RelayGroup} Actor[${_ID}]:DoubleClick
									wait 5 ${Me.CastingSpell}
									wait 50 !${Me.CastingSpell}
									wait 2
									;echo ${Time}: Before: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
									;echo ${Trigger} // ${TriggerMessage}
									if ${Trigger}
									{
										_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
										;echo ISXRI: Harvested ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]} of ${_tempName}
										echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
										Trigger:Set[FALSE]
									}
									;echo ${Time}: After: ${_AmountHarvested.Get[${Math.Calc[${_count}+2]}]}
									if ${Actor[Query, ID=${_ID}].Distance}>2
										call RIMObj.Move ${Actor[Query, ID=${_ID}].X} ${Math.Calc[${Actor[Query, ID=${_ID}].Y}+1]} ${Actor[Query, ID=${_ID}].Z} 2 0 FALSE FALSE TRUE FALSE TRUE TRUE
								}
								wait 5
								if ${Trigger}
								{
									_AmountHarvested.Get[${Math.Calc[${_count}+2]}]:Inc
									echo ISXRI: Triggered: ${TriggerMessage} from ${_tempName}
									Trigger:Set[FALSE]
								}
								; if ${_IWasFlying}
								; {
									; press -hold ${RI_Var_String_FlyUpKey}
									; wait 1
									; press -release ${RI_Var_String_FlyUpKey}
									; _IWasFlying:Set[FALSE]
								; }
								call RIMObj.Move ${_temp} 1 0 FALSE FALSE TRUE FALSE
							}
						}
					}
					_count:Inc
					_count:Inc
				}
				call RIMObj.Move ${istrMain.Get[${MainArrayCounter}]} 1 0 0 0 1 1 1 1
				_AllQuantitiesMet:Set[TRUE]
				for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
				{
					_count:Inc
					_count:Inc
					;echo ${_count}: ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
					if ${_AmountHarvested.Get[${_count}]}<${args[${_count}]}
						_AllQuantitiesMet:Set[FALSE]
				}
			}
			;if !${_Loop}
				MainArrayCounter:Set[${_end}]
		}
		if ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
		{
			;echo looping because ${_Loop} && ${MainArrayCounter}==${_end} && !${_AllQuantitiesMet}
			MainArrayCounter:Set[${_start}]
		}
	}
	press -release ${RI_Var_String_ForwardKey}
	AnnounceText:Clear
	Trigger:Set[FALSE]
}
function SwimUp()
{
	press -hold ${RI_Var_String_FlyUpKey}
	while ${Me.WaterDepth}>=2
	{
		wait 5
	}
	wait 10
	press -release ${RI_Var_String_FlyUpKey}
}
function SwimDown(int _Wait)
{
	press -hold ${RI_Var_String_FlyDownKey}
	wait ${_Wait}
	press -release ${RI_Var_String_FlyDownKey}
}
function MoveToActor(string _ActorName, int _Precision=2, bool _SkipCollisionCheck=FALSE)
{
	if ${Actor[Query, Name=-"${_ActorName}"](exists)}
		call RIMObj.Move ${Actor[Query, Name=-"${_ActorName}"].X} ${Math.Calc[${Actor[Query, Name=-"${_ActorName}"].Y}+2]} ${Actor[Query, Name=-"${_ActorName}"].Z} ${_Precision} 0 0 0 1 0 1 ${_SkipCollisionCheck}
}
function MoveToActorHail(string _ActorName, int _Precision=2, bool _SkipCollisionCheck=FALSE)
{
	if ${Actor[Query, Name=-"${_ActorName}"](exists)}
		call RIMObj.Move ${Actor[Query, Name=-"${_ActorName}"].X} ${Math.Calc[${Actor[Query, Name=-"${_ActorName}"].Y}+2]} ${Actor[Query, Name=-"${_ActorName}"].Z} ${_Precision} 0 0 0 1 0 1 ${_SkipCollisionCheck}
	Actor[${_ActorName}]:DoTarget
	wait 1
	Actor[${_ActorName}]:DoTarget
	wait 2
	eq2ex hail
	wait 2
	eq2ex hail
}
function JumpUp(float _X, float _Y, float _Z, float _YTarget, int _FaceDegree, int _GiveUpCNT=10)
{	
	call RIMObj.JumpUp ${_X} ${_Y} ${_Z} ${_YTarget} ${_FaceDegree} ${_GiveUpCNT}
}
function JumpOver(float _X, float _Y, float _Z, int _FaceDegree)
{	
	call RIMObj.JumpOver ${_X} ${_Y} ${_Z} ${_FaceDegree}
}
function CheckPreReqs(... args)
{
	;echo start
	variable int _count
	variable int _count2
	variable index:string _Fails
	variable index:item _Items
	variable bool _Failed
	variable int _ItemCount=0
	variable string _FailMessage
	for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
	{
		;echo ${_count}
		if ${args[${_count}].Upper.Equal[-COMPLETED]}
		{
			;echo ${args[${_count}]} // ${args[${Math.Calc[${_count}+1]}]}
			if !${QuestJournalWindow.CompletedQuest["${args[${Math.Calc[${_count}+1]}]}"](exists)}
			{
				_Failed:Set[TRUE]
				_Fails:Insert["You need to have completed ${args[${Math.Calc[${_count}+1]}]}"]
			}
			_count:Inc
		}
		if ${args[${_count}].Upper.Equal[-ACTIVE]}
		{
			;echo ${args[${_count}]} // ${args[${Math.Calc[${_count}+1]}]}
			if !${QuestJournalWindow.ActiveQuest["${args[${Math.Calc[${_count}+1]}]}"](exists)} && !${QuestJournalWindow.CompletedQuest["${args[${Math.Calc[${_count}+1]}]}"](exists)}
			{
				_Failed:Set[TRUE]
				_Fails:Insert["You need to have started or completed ${args[${Math.Calc[${_count}+1]}]}"]
			}
			_count:Inc
		}
		if ${args[${_count}].Upper.Equal[-ITEMQTY]}
		{
			;echo ${args[${_count}]} // ${args[${Math.Calc[${_count}+1]}]} // ${args[${Math.Calc[${_count}+2]}]}
			_Items:Clear
			Me:QueryInventory[_Items, Location=="Inventory" && Name=="${args[${Math.Calc[${_count}+1]}]}"]
			;echo ${_Items.Used}
			for(_count2:Set[1];${_count2}<=${_Items.Used};_count2:Inc)
			{
				_ItemCount:Set[${Math.Calc[${_ItemCount}+${_Items.Get[${_count2}].Quantity}]}]
			}
			if ${_ItemCount}<${Int[${args[${Math.Calc[${_count}+2]}]}]}
			{
				_Failed:Set[TRUE]
				_Fails:Insert["You must have at least ${args[${Math.Calc[${_count}+2]}]} of ${args[${Math.Calc[${_count}+1]}]} and you have ${_ItemCount}"]
			}
			_count:Inc
			_count:Inc
		}
		;echo end loop
	}
	if ${_Failed}
	{
		RI_Var_Bool_SSSGTG:Set[FALSE]
		for(_count:Set[1];${_count}<=${_Fails.Used};_count:Inc)
		{
			if ${_count}<${_Fails.Used}
				_FailMessage:Concat["${_Fails.Get[${_count}]}\n"]
			else
				_FailMessage:Concat["${_Fails.Get[${_count}]}"]
		}
		MessageBox -skin eq2 "${_FailMessage}"
		if !${RI_Var_Bool_SSSInScript}
			MainArrayCounter:Set[${Math.Calc[${MainArrayCount}-2]}]
		RI_Var_Bool_Paused:Set[TRUE]
		UIElement[Start@RI]:SetText[Resume]
		while ${RI_Var_Bool_Paused}
		{
			wait 1
		}
	}
	elseif ${RI_Var_Bool_SSSInScript}
		RI_Var_Bool_SSSGTG:Set[TRUE]
}
function TFB(string _What)
{
	if ${_What.Upper.Equal[COLLECTION]}
		MessageBox -skin eq2 "This has not been coded yet, finish the collection, when done unpause RQ and it will resume the quest."
	elseif ${_What.Upper.Equal[CRAFTING]}
		MessageBox -skin eq2 "You are at the stage where you need other crafters to make you items (or you can buy from broker), do this, and resume RI and it will continue the quest"
	elseif ${_What.Upper.Equal[DALNIR]}
		MessageBox -skin eq2 "You are at the stage where you need finish Crypt of Dalnir, do this, and resume RI and it will continue the quest"
	RI_Var_Bool_Paused:Set[TRUE]
	UIElement[Start@RI]:SetText[Resume]
	while ${RI_Var_Bool_Paused}
	{
		wait 1
	}
	wait 5
}
function RemoveFromDepot(string _DepotName,... args)
{
	; echo RemoveFromDepot(string _DepotName=${_DepotName},... args)
	; echo ${args.Size}
	; for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	; {
		; echo ${args[${_count}]}
	; }
	if ${Actor[Query, Name=-"${_DepotName}" && Distance<=12](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
	{
		Actor[Query, Name=-"${_DepotName}" && Distance<=12]:DoubleClick
		wait 20
		variable int _count
		variable int _qty
		
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${ContainerWindow.Item["${args[${_count}]}"].Quantity}>${args[${Math.Calc[${_count}+1]}]}
			{
				_qty:Set[${args[${Math.Calc[${_count}+1]}]}]
				do
				{
					ContainerWindow:RemoveItem["${ContainerWindow.Item["${args[${_count}]}"].ID}",${_qty}]
					wait 5
					
				}
				while ${_qty:Dec[200]}>0
				echo ISXRI: Removing ${args[${Math.Calc[${_count}+1]}]} of ${args[${_count}]}
			}
			else
				echo ISXRI: You only have ${Int[${ContainerWindow.Item["${args[${_count}]}"].Quantity}]} of ${args[${_count}]} and you wanted ${args[${Math.Calc[${_count}+1]}]}, skipping
			wait 5
			_count:Inc
		}
		ContainerWindow:Close
	}
	elseif ${Zone.ShortName.Find[guildhall](exists)}
	{
		MessageBox -skin eq2 "You are more than 12 away from the ${_DepotName} depot, please move closer and unpause RQ"
		RI_Var_Bool_Paused:Set[TRUE]
		MainArrayCounter:Dec
		MainArrayCounter:Dec
		UIElement[Start@RI]:SetText[Resume]
		while ${RI_Var_Bool_Paused}
		{
			wait 1
		}
		wait 5
	}
	else
		echo ISXRI: We are not in a guild hall, skipping Remove From Depot
}
function ReplyDialog(int _Repetitions=1, int _Option=1)
{
	variable int _count
	wait 20 ${ReplyDialog(exists)}
	if ${ReplyDialog(exists)}
	{
		for(_count:Set[1];${_count}<=${_Repetitions};_count:Inc)
		{
			relay ${RI_Var_String_RelayGroup} ReplyDialog:Choose[${_Option}]
			wait 5
		}
	}
}
function PlaceHouseItem()
{
	;change camera
	Press -hold "Page Down"
	wait 20
	;move mouse to just above center of screen aka on top of you and up
	Mouse:SetPosition[${Math.Calc[${Display.Width}/2]},${Math.Calc[(${Display.Height}/2)-((${Display.Height}/2)*.1)]}]
	wait 2
	
	;click to place
	Mouse:LeftClick
	
	wait 10
	
	;change camera
	Press -release "Page Down"
	Press -hold "Page Up"
	wait 3
	Press -release "Page Up"
}
function MessageBox(string _Message, bool _Pause=1)
{
	MessageBox -skin eq2 "${_Message}"
	if ${_Pause}
	{
		RI_Var_Bool_Paused:Set[TRUE]
		UIElement[Start@RI]:SetText[Resume]
		while ${RI_Var_Bool_Paused}
		{
			wait 1
		}
	}
	wait 5
}
function ApplyVerb(string _Actor, string _Verb)
{
	if ${Actor[Query, Name=-"${_Actor}"](exists)}
		eq2ex apply_verb ${Actor[Query, Name=-"${_Actor}"].ID} ${_Verb}
}
function ReaversSigCheck()
{
	if ${QuestJournalWindow.ActiveQuest[Kunark Ascending: Seeking Reassurance](exists)}
	{
		;go to the guy and hail him then go back to the spot
		call RIMObj.Move -0.384015 -1.754801 -1115.690796 1 0 0 0 1 1 1 1
		call RIMObj.Move -17.538403 -4.995497 -1135.468994 1 0 0 0 1 1 1 1
		call RIMObj.Move -17.917027 -5.219389 -1158.058960 1 0 0 0 1 1 1 1
		call RIMObj.Move -16.785690 -4.971283 -1177.287109 1 0 0 0 1 1 1 1
		call RIMObj.Move -0.729423 -4.971283 -1178.138306 1 0 0 0 1 1 1 1
		call RIMObj.Move -0.321138 -5.149948 -1207.141235 1 0 0 0 1 1 1 1
		call RIMObj.Move 12.802125 -5.149916 -1219.629150 1 0 0 0 1 1 1 1
		call RIMObj.Move 35.759937 -5.149971 -1216.970337 1 0 0 0 1 0 1 1
		call HailActor Chosooth 14
		call RIMObj.Move 11.669339 -5.149916 -1218.828125 1 0 0 0 1 1 1 1
		call RIMObj.Move -0.584382 -5.165592 -1200.475830 1 0 0 0 1 1 1 1
		call RIMObj.Move -0.992143 -4.971283 -1179.257568 1 0 0 0 1 1 1 1
		call RIMObj.Move -17.032045 -4.971283 -1177.873047 1 0 0 0 1 1 1 1
		call RIMObj.Move -16.716248 -4.995886 -1131.974243 1 0 0 0 1 1 1 1
		call RIMObj.Move 6.298306 -1.754801 -1118.231689 1 0 0 0 1 1 1 1
	}
}
function TargetUntilAnnounce(string _TargetName, int _Distance, string _Announce)
{
	TriggerMessage:Set[""]
	while !${TriggerMessage.Find["${_Announce}"](exists)}
	{
		if ${Actor[Query, Name=-"${_TargetName}" && Distance<=${_Distance} && IsDead=FALSE](exists)}
			Actor[Query, Name=-"${_TargetName}" && Distance<=${_Distance} && IsDead=FALSE]:DoTarget
		waitframe
	}
}
function TargetUntilQuestStepExists(string _TargetName, int _Distance, string _QuestStep)
{
	TriggerMessage:Set[""]
	while !${RIObj.QuestStepExists["${_QuestStep}"]}
	{
		if ${Actor[Query, Name=-"${_TargetName}" && Distance<=${_Distance} && IsDead=FALSE](exists)}
			Actor[Query, Name=-"${_TargetName}" && Distance<=${_Distance} && IsDead=FALSE]:DoTarget
		wait 2
	}
}

function Instance(string _InstanceName="${Me.GetGameData[Self.ZoneName].Label.Replace[" ",""].Replace["'",""].Replace[":",""].Replace["[",,""].Replace["]",""].Replace[",",""]}")
{
	variable string _ConvertedQuestName
	variable string _QuestName
	variable int _OriginalMAC
	declare InstanceMode bool script TRUE
	_OriginalMAC:Set[${MainArrayCounter}]
	RI_Var_Bool_QuestMode:Set[FALSE]
	press -release ${RI_Var_String_ForwardKey}
	declare _FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"

	RI_CMD_Hidden_AddTLO ${_InstanceName}
	
	;echo ${_InstanceName}
	
	if ${${_InstanceName}[3rtZdjv7,1](exists)}
		call PreGo "${_InstanceName}" 0
	elseif ${_FP.FileExists[${_InstanceName}]}
		ImportZoneFile "${_InstanceName}" 0
	else
		call MessageBox "${Me.GetGameData[Self.ZoneName].Label} is not coded, run manually and resume at exit door" 1

	MainArrayCounter:Set[0]
	echo ISXRI: Starting ${Me.GetGameData[Self.ZoneName].Label}
		
	call Go TRUE
	
	echo ISXRI: Ending ${Me.GetGameData[Self.ZoneName].Label}

	RI_CMD_Hidden_RemoveTLO ${_InstanceName}
	
	;echo _QuestName:Set["${MainQuestName.Get[${MainQuestName.Used}]}"]
	_QuestName:Set["${MainQuestName.Get[${MainQuestName.Used}]}"]

	_ConvertedQuestName:Set["${_QuestName.Replace[".",""].Replace["(",""].Replace[")",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}"]

	RI_CMD_Hidden_AddTLO ${_ConvertedQuestName.Upper}

	if ${${_ConvertedQuestName.Upper}[3rtZdjv7,1](exists)}
		call PreGo "${_ConvertedQuestName.Upper}" 0
	else
		ImportZoneFile "${_ConvertedQuestName}" 0
		
	MainArrayCounter:Set[${_OriginalMAC}]

	if ${Me.IsMoving}
	{
		press -release ${RI_Var_String_ForwardKey}
	}
	RI_Var_Bool_QuestMode:Set[TRUE]
	deletevariable InstanceMode
}
function DrusellaSigCheck1()
{
	if ${QuestJournalWindow.ActiveQuest[Kunark Ascending: Resurrection Machination](exists)}
	{
		call UseItem "Middle Shard of an Obulus Medallion"
		wait 5
		call UseItem "Middle Shard of an Obulus Medallion"
		wait 50
		call ReplyDialog 3
		wait 50
		RI_Var_Bool_SkipLoot:Set[TRUE]
	}
}
function DrusellaSigCheck2()
{
	if ${QuestJournalWindow.ActiveQuest[Kunark Ascending: Resurrection Machination](exists)}
	{
		wait 50
		call MoveToNoNameActor
		wait 50
		call ClickNoNameActor
		wait 5
		call ClickNoNameActor
		wait 5
		call ClickNoNameActor
		wait 20
		RI_Var_Bool_SkipLoot:Set[FALSE]
	}
}
function PressKey(string _Key, int _HoldTime=1)
{
	press -hold ${_Key}
	wait ${_HoldTime}
	press -release ${_Key}
}
function WaitDeath()
{
	while !${Me.IsDead}
		wait 10
}
function WaitWhileMoving()
{
	while ${Me.IsMoving}
		wait 10
}
function Revive()
{
	eq2ex "select_junction 0"
}
function KAANRGotoQueen()
{
	call MessageBox "Return to your queen!"
}
function Collection(... args)
{
	variable int _count
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		if ${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"](exists)}
		{
			if (!${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].IsItemInfoAvailable})
				wait 20 ${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].IsItemInfoAvailable}
			wait 5
			if ${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].IsItemInfoAvailable}
			{
				if ${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].ToItemInfo.IsCollectible}
				{
					if !${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].ToItemInfo.AlreadyCollected}
					{
						echo ISXRI: Collecting ${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].Name}
						Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"]:Examine
						wait 5
						EQ2UIPage[Journals,JournalsQuest].Child[Page,TabPages].Child[Page,2].Child[Page,6].Child[Composite,2].Child[Page,1].Child[Button,1]:LeftClick
					}
					else
						echo ISXRI: ${Me.Inventory[Query, Location=="Inventory" && Name=-"${args[${_count}]}"].Name} Already Collected
				}
			}
		}
		wait 1
	}
	EQ2UIPage[Journals,JournalsQuest]:Close
}
function EquipItem(string _ItemName, int _slot=1, bool _StoreOldItem=0)
{
	variable int _count=0
	if ${_ItemName.Upper.Equal[STORED]} && ${OldItemStore(exists)}
	{
		do
		{
			Me.Inventory[Query, Name=-"${OldItemStore}"]:Equip
			wait 5 ${Me.Equipment[${_slot}].Name.Find[${OldItemStore}](exists)}
		}
		while !${Me.Equipment[${_slot}].Name.Find[${OldItemStore}](exists)} && ${_count:Inc}<10
		
		deletevariable OldItemStore
	}
	elseif ${Me.Inventory[Query, Name=-"${_ItemName}"](exists)}
	{
		if ${_StoreOldItem}
			declare OldItemStore string globalkeep "${Me.Equipment[${_slot}].Name}"

		do
		{
			Me.Inventory[Query, Name=-"${_ItemName}"]:Equip
			wait 5 ${Me.Equipment[${_slot}].Name.Find[${_ItemName}](exists)} || ${_slot}==0
		}
		while !${Me.Equipment[${_slot}].Name.Find[${_ItemName}](exists)} && ${_count:Inc}<10 && ${_slot}>0
	}
}
function SummonMount()
{
	if !${Me.OnHorse} && !${Me.OnFlyingMount}
		eq2ex summon_mount
	wait 20
}
function HailCollector()
{
	if !${Actor[Query, Guild=="Collector"](exists)}
		return
	variable int _CollectorID=${Actor[Query, Guild=="Collector"].ID}
	
	RI_CMD_PauseCombatBots 1
	wait 20
	relay ${RI_Var_String_RelayGroup} Actor[${_CollectorID}]:DoFace
	relay ${RI_Var_String_RelayGroup} Actor[${_CollectorID}]:DoFace
	wait 5
	relay ${RI_Var_String_RelayGroup} Actor[${_CollectorID}]:DoTarget
	relay ${RI_Var_String_RelayGroup} Actor[${_CollectorID}]:DoTarget
	wait 5
	relay ${RI_Var_String_RelayGroup} eq2ex hail
	wait 5
	variable int count
	variable string _tempbtntxt
	for(count:Set[1];${count}<=3;count:Inc)
	{
		_tempbtntxt:Set["${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2].GetProperty[LocalText]}"]
		if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2](exists)}
			relay ${RI_Var_String_RelayGroup} -noredirect EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2]:LeftClick
		wait 5
		wait 20 ( ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2].GetProperty[LocalText].NotEqual["${_tempbtntxt}"]} || !${EQ2UIPage[ProxyActor,Conversation].IsVisible} )
	}
	;unpause bots
	relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0	
}
function ClimbLadder(int _FaceDegree, int _TopY, int _GiveUpCNT=300)
{
	variable int _count=0
	Face ${_FaceDegree}
	wait 2
	press -hold ${RI_Var_String_ForwardKey}
	while ${Me.Y}<${_TopY} && ${_count:Inc}<=${_GiveUpCNT}
	{
		wait 1
	}
	press -release ${RI_Var_String_ForwardKey}
}
function FaceAndMoveForward(int _FaceDegree, int _StopX, int _StopY, int _StopZ, int _GiveUpCNT=300)
{
	variable int _count=0
	Face ${_FaceDegree}
	wait 2
	press -hold ${RI_Var_String_ForwardKey}
	while ${Math.Distance[${Me.Loc},${_StopX},${_StopY},${_StopZ}]}>5 && ${_count:Inc}<=${_GiveUpCNT}
	{
		wait 1
	}
	press -release ${RI_Var_String_ForwardKey}
}
function TimeStampEcho(string _Message)
{
	echo ISXRI: ${Time} ${_Message}
}
function ZoneDoor(string _Actor, int _DoorOption=-1, bool _LoopUntilNoHighlightOnMouseHover=0, int _GiveUpCNT=50, bool _ExactName=1)
{
	;echo ClickActor(string _Actor=${_Actor}, int _LoopUntilNoHighlightOnMouseHover=0=${_LoopUntilNoHighlightOnMouseHover}, int _GiveUpCNT=50=${_GiveUpCNT})
	;move to ClickActor location
	;stop follow
	variable int _Cnt=0
	variable int _ID

	;echo Moving to ${CustomLoc} and Clicking ${_Actor}
	relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE"]
	if ${CustomLoc.NotEqual[0 0 0]}
	{
		call RIMObj.Move ${CustomLoc} ${Precision} 0 TRUE TRUE TRUE FALSE TRUE
		wait 20
	}
	call RIMObj.stopfollow
	;make sure _Actor exists so we do not go through the motions for nothign
	;echo \${Actor[Query, Name=-"${_Actor}"](exists)}  //  ${Actor[Query, Name=-"${_Actor}"](exists)}
	if ${_LoopUntilNoHighlightOnMouseHover}
	{
		if ${Actor[Query, Name=-"${_Actor}" && HighlightOnMouseHover=TRUE](exists)} || ${Actor[Query, Name=="${_Actor}"](exists)}
		{
			if ${_ExactName}
				_ID:Set[${Actor[Query, Name=="${_Actor}" && HighlightOnMouseHover=TRUE].ID}]
			else
				_ID:Set[${Actor[Query, Name=-"${_Actor}" && HighlightOnMouseHover=TRUE].ID}]
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			if ${_LoopUntilNoHighlightOnMouseHover}
			{
				while ${Actor[${_ID}].HighlightOnMouseHover} && ${_Cnt:Inc} <= ${_GiveUpCNT}
				{
					;echo relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
					relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
					wait 5
				}
			}
			else
			{
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
			}
		}
	}
	else
	{
		if ${Actor[Query, Name=-"${_Actor}"](exists)} || ${Actor[Query, Name=="${_Actor}"](exists)}
		{
			if ${_ExactName}
				_ID:Set[${Actor[Query, Name=="${_Actor}"].ID}]
			else
				_ID:Set[${Actor[Query, Name=-"${_Actor}"].ID}]
			;wait until we are out of combat
			if !${DontStopForCombat}
				call RIMObj.CheckCombat
			wait 10
			;pause bots
			
			relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 1
			wait 5
			
			if ${_LoopUntilNoHighlightOnMouseHover}
			{
				while ${Actor[${_ID}].HighlightOnMouseHover} && ${_Cnt:Inc} <= ${_GiveUpCNT}
				{
					relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
					wait 5 ${Me.CastingSpell}
					wait 50 !${Me.CastingSpell}
				}
			}
			else
			{
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
				wait 5
				relay ${RI_Var_String_RelayGroup} -noredirect Actor[${_ID}]:DoubleClick
			}
		}

	}
	relay ${RI_Var_String_RelayGroup} -noredirect RI_CMD_PauseCombatBots 0
	
	if ${_DoorOption}>-1
		relay ${RI_Var_String_RelayGroup} -noredirect TimedCommand 50 RIMUIObj:Door[ALL,${_DoorOption}]
	wait 50
	if ${ChoiceWindow(Exists)} && ${EQ2.Zoning}==0
		ChoiceWindow:DoChoice1
	wait 600 ${EQ2.Zoning}==1
	wait 600 ${EQ2.Zoning}==0
}
function Teleporter(float _x, float _y, float _z, int _precision=1, int _maxdistance=10)
{
	;echo Teleporter(float _x=${_x}, float _y=${_y}, float _z=${_z}, int _precision=1=${_precision}, int _maxdistance=10=${_maxdistance})
	if !${RI_Var_Bool_GlobalOthers}
	{
		wait 20
		call RIMObj.stopfollow
	}
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call Teleporter ${_x} ${_y} ${_z} ${_precision} ${_maxdistance}"]
	RIMUIObj:SetLockSpot[ALL,${_x},${_y},${_z},${_precision},${_maxdistance}]
	wait 100 ${Math.Distance[${Me.Loc},${_x},${_y},${_z}]}<=${_precision}
	while ${Math.Distance[${Me.Loc},${_x},${_y},${_z}]}<=${_precision} && !${EQ2.Zoning}
	{
		wait 5
		press -hold ${RI_Var_String_ForwardKey}
	}
	press -release ${RI_Var_String_ForwardKey}
	RIMUIObj:SetLockSpot[OFF]
	press -release ${RI_Var_String_ForwardKey}
	wait 600 ${RIMObj.AllGroupWithinRange[5]}
	wait 20
}
function RingEvent(int _Distance, ... args)
{
	variable int _countor
	variable string _Query
	;first build our add's Query
	_Query:Set["( "]

	for(_countor:Set[1];${_countor}<${args.Used};_countor:Inc)
	{
		if ${_countor}==${Math.Calc[${args.Used}-1]}
			_Query:Concat["Name=-\"${args[${_countor}]}\" ) && Distance<=${_Distance} && IsLocked=FALSE && IsDead=FALSE && ( Type==\"NPC\" || Type==\"NamedNPC\" )"]
		else
			_Query:Concat["Name=-\"${args[${_countor}]}\" || "]
	}
	while !${Actor[Query, Name=-"${args[${args.Used}]}" && Distance<=${_Distance}](exists)}
	{
		if ${Actor[Query, ${_Query}](exists)} && ${Target.ID}!=${Actor[Query, ${_Query}].ID}
			Actor[Query, ${_Query}]:DoTarget
		wait 2
	}
	while ${Actor[Query, Name=-"${args[${args.Used}]}" && Distance<=${_Distance} && IsDead=FALSE](exists)}
	{
		if ${Target.ID}!=${Actor[Query, Name=-"${args[${args.Used}]}" && Distance<=${_Distance} && IsDead=FALSE].ID}
			Actor[Query, Name=-"${args[${args.Used}]}" && Distance<=${_Distance} && IsDead=FALSE]:DoTarget
		wait 2
	}
}
function BuyFromVendor(string _VendorName, string _Item, int _Qty)
{
	echo ${_VendorName}
	wait 20
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 1
	wait 20
	relay ${RI_Var_String_RelayGroup} Actor["${_VendorName}"]:DoTarget
	relay ${RI_Var_String_RelayGroup} Actor[${_VendorName}]:DoTarget
	wait 2
	relay ${RI_Var_String_RelayGroup} Actor["${_VendorName}"]:DoTarget
	relay ${RI_Var_String_RelayGroup} Actor[${_VendorName}]:DoTarget
	wait 2
	relay ${RI_Var_String_RelayGroup} Actor["${_VendorName}"]:DoubleClick
	relay ${RI_Var_String_RelayGroup} Actor[${_VendorName}]:DoubleClick
	wait 2
	relay ${RI_Var_String_RelayGroup} Actor["${_VendorName}"]:DoubleClick
	relay ${RI_Var_String_RelayGroup} Actor[${_VendorName}]:DoubleClick
	wait 20
	relay ${RI_Var_String_RelayGroup} Vendor.Item["${_Item}"]:Buy[${_Qty}]
	wait 20
	relay ${RI_Var_String_RelayGroup} RI_CMD_PauseCombatBots 0
}
function CancelInvis()
{
	relay ${RI_Var_String_RelayGroup} eq2execute usea Transmute
	wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
	relay ${RI_Var_String_RelayGroup} press esc
}
function CastInvis()
{
	if !${RI_Var_Bool_GlobalOthers}
		relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call CastInvis"]
	
	switch ${Me.SubClass}
	{
		case beastlord
		{
			Me.Ability[id,3010698346]:Use
			break
		}
		case dirge
		{
			Me.Ability[id,2958443420]:Use
			break
		}
		case ranger
		{
			Me.Ability[id,601425776]:Use
			break
		}
		case swashbuckler
		{
			Me.Ability[id,978081226]:Use
			break
		}
		case assassin
		{
			Me.Ability[id,601425776]:Use
			break
		}
		case troubador
		{
			Me.Ability[id,2958443420]:Use
			break
		}
		case brigand
		{
			Me.Ability[id,978081226]:Use
			break
		}
	}
}
function CheckQuestStep(string _Step, int _ArrayCounterSetter=0)
{
    variable index:collection:string Details    
    variable iterator DetailsIterator
    variable int DetailsCounter = 0
    variable bool _FoundIt = FALSE
;    echo "Journal Current Quest:"
;    echo "- Name: ${QuestJournalWindow.CurrentQuest.Name.GetProperty["LocalText"]}"
;    echo "- Level: ${QuestJournalWindow.CurrentQuest.Level.GetProperty["LocalText"]}"
;    echo "- Category: ${QuestJournalWindow.CurrentQuest.Category.GetProperty["LocalText"]}"
;    echo "- CurrentZone: ${QuestJournalWindow.CurrentQuest.CurrentZone.GetProperty["LocalText"]}"
;    echo "- TimeStamp: ${QuestJournalWindow.CurrentQuest.TimeStamp.GetProperty["LocalText"]}"
;    echo "- MissionGroup: ${QuestJournalWindow.CurrentQuest.MissionGroup.GetProperty["LocalText"]}"
;    echo "- Status: ${QuestJournalWindow.CurrentQuest.Status.GetProperty["LocalText"]}"
;    echo "- ExpirationTime: ${QuestJournalWindow.CurrentQuest.ExpirationTime.GetProperty["LocalText"]}"
;    echo "- Body: ${QuestJournalWindow.CurrentQuest.Body.GetProperty["LocalText"]}"
    
    QuestJournalWindow.CurrentQuest:GetDetails[Details]
    Details:GetIterator[DetailsIterator]
;    echo "- Details:"
    if (${DetailsIterator:First(exists)})
    {
        do
        {
            if (${DetailsIterator.Value.FirstKey(exists)})
            {
                do
                {
                    ; echo "-- ${DetailsCounter}::  '${DetailsIterator.Value.CurrentKey}' => '${DetailsIterator.Value.CurrentValue}'"
					;echo \${DetailsIterator.Value.CurrentValue.Find[${_Step}](exists)} // ${DetailsIterator.Value.CurrentValue}
					if ${DetailsIterator.Value.CurrentKey.Equal[Text]} && ${DetailsIterator.Value.CurrentValue.Find[${_Step}](exists)}
						_FoundIt:Set[TRUE]
                }
                while ${DetailsIterator.Value.NextKey(exists)}
                ; echo "------"
            }
            DetailsCounter:Inc
        }
        while ${DetailsIterator:Next(exists)}
    }
	if ${_FoundIt}
		MainArrayCounter:Set[${_ArrayCounterSetter}]
	;else
	;	echo didnt find it
}
function SetMainArrayCounter(int _ArrayCounterSetter=0)
{
	MainArrayCounter:Set[${_ArrayCounterSetter}]
}
function WaitForIncomingText(... args)
{
	IncomingText:Clear
	variable int _count
	
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		IncomingText:Insert[${args[${_count}]}]
	}
	while !${Trigger}
		wait 2
}
function WaitForAnnounceText(... args)
{
	AnnounceText:Clear
	variable int _count
	
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		AnnounceText:Insert[${args[${_count}]}]
	}
	while !${Trigger}
		wait 2
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; End OF Quest CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;; Start of RAID CODING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
function Blackreaver()
{
	echo ISXRI: Starting Black Reaver
	while !${Me.InCombat} && !${Target.InCombatMode}
		wait 5
	if ${Me.Archetype.Equal[fighter]}
	{
		RIMUIObj:SetLockSpot[ALL,-177.693054,29.179466,-350.950958]
		while ${Math.Distance[${Me.Loc},-177.693054,29.179466,-350.950958]}>3
			wait 1
		wait 5
		RIMUIObj:SetLockSpot[OFF]
	}
	else
	{
		RIMUIObj:SetLockSpot[ALL,-178.088577,29.087303,-341.900818]
	}
	while ${Actor[Query, Name=="A Black Reaver" && Distance<=100](exists)}
	{
		if ${Me.Archetype.Equal[fighter]}
		{
			if ${Actor[Query, Name=-"a Black Stone Shard" && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${Actor[Query, Name=-"a Black Stone Shard" && IsDead=FALSE].ID}
					Actor[Query, Name=="a Black Stone Shard" && IsDead=FALSE]:DoTarget
			}
			else
			{
				if ${Target.ID}!=${Actor[Query, Name=="A Black Reaver" && Distance<=100].ID}
					Actor[Query, Name=="A Black Reaver" && IsDead=FALSE && Distance<=100]:DoTarget
			}
		}
		if ${RIMUIObj.MainIconIDExists[${Me.ID},496]}
		{
			RIMUIObj:SetLockSpot[ALL,-177.750214,29.526823,-320.352386]
			while ${RIMUIObj.MainIconIDExists[${Me.ID},496]}
			{
				if ${Me.Archetype.Equal[fighter]}
				{
					if ${Actor[Query, Name=-"a Black Stone Shard" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=-"a Black Stone Shard" && IsDead=FALSE].ID}
							Actor[Query, Name=="a Black Stone Shard" && IsDead=FALSE]:DoTarget
					}
					else
					{
						if ${Target.ID}!=${Actor[Query, Name=="A Black Reaver" && Distance<=100].ID}
							Actor[Query, Name=="A Black Reaver" && IsDead=FALSE && Distance<=100]:DoTarget
					}
				}
				wait 2
			}
			if ${Me.Archetype.Equal[fighter]}
			{
				RIMUIObj:SetLockSpot[ALL,-177.693054,29.179466,-350.950958]
				while ${Math.Distance[${Me.Loc},-177.693054,29.179466,-350.950958]}>3
					wait 1
				wait 5
				RIMUIObj:SetLockSpot[OFF]
			}
			else
			{
				RIMUIObj:SetLockSpot[ALL,-178.088577,29.087303,-341.900818]
			}
		}
		wait 2
	}
	if ${Me.Archetype.Equal[fighter]}
	{
		RIMUIObj:SetLockSpot[ALL,-178.088577,29.087303,-341.900818]
		wait 10
		while ${Math.Distance[${Me.Loc},-178.088577,29.087303,-341.900818]}>3
			wait 1
		wait 5
		RIMUIObj:SetLockSpot[OFF]
	}
	echo ISXRI: Ending Black Reaver
}
function Slime()
{
	echo ISXRI: Starting Slime
	IncomingText:Clear
	IncomingText:Insert["prepares to spray gunk to those around him!"]
	RIMUIObj:SetLockSpot[ALL,41.181149,-6.196420,-651.539246]
	while ${Math.Distance[${Me.Loc},41.181149,-6.196420,-651.539246]}>3
		wait 1
	wait 5
	if ${Me.Archetype.Equal[fighter]}
	{
		wait 30
		RIMUIObj:SetLockSpot[OFF]
	}
	while ${Actor[Query, Name=="A Gyrating Green Slime" && IsDead=FALSE](exists)}
	{
		if ${Trigger}
		{
			eq2ex cancel_spellcast
			Me.Ability[Sprint]:Use
			if ${Actor[Query, Name=="A Gyrating Green Slime" && IsDead=FALSE].Target.Name.Equal[${Me.Name}]}
				wait 40
			else
				wait 20
			if ${Math.Distance[${Me.Loc},48.976913,-6.196415,-647.433899]}<35
			{
				RIMUIObj:SetLockSpot[ALL,-12.401492,-6.196422,-649.468689]
				while ${Math.Distance[${Me.Loc},-12.401492,-6.196422,-649.468689]}>3
					wait 1
				wait 5
				if ${Me.Archetype.Equal[fighter]}
				{
					RIMUIObj:SetLockSpot[OFF]
					wait 30
				}
				wait 20
			}
			else
			{
				RIMUIObj:SetLockSpot[ALL,41.181149,-6.196420,-651.539246]
				while ${Math.Distance[${Me.Loc},41.181149,-6.196420,-651.539246]}>3
					wait 1
				wait 5
				if ${Me.Archetype.Equal[fighter]}
				{
					RIMUIObj:SetLockSpot[OFF]
					wait 30
				}
				wait 20
			}
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo ISXRI: Ending Slime
}
function Chomp()
{
	echo ISXRI: Starting Chomp
	
	IncomingText:Insert["Chomp prepares to unleash a nasty bloody bite to all those nearby in his thirst for blood"]
	RIMUIObj:SetLockSpot[ALL,-323.196747,11.774687,317.118469]
	while ${Math.Distance[${Me.Loc},-323.196747,11.774687,317.118469]}>3
		wait 1
	wait 5
	if ${Me.Archetype.Equal[fighter]}
		RIMUIObj:SetLockSpot[OFF]
	while ${Actor[Query, Name=="Chomp" && IsDead=FALSE](exists)}
	{
		if ${Trigger}
		{
			if ${Actor[Query, Name=="Chomp" && IsDead=FALSE].Target.Name.Equal[${Me.Name}]}
				wait 50
			if ${Math.Distance[${Me.Loc},-323.196747,11.774687,317.118469]}<25
			{
				RIMUIObj:SetLockSpot[ALL,-273.333435,11.774687,317.906952]
				while ${Math.Distance[${Me.Loc},-273.333435,11.774687,317.906952]}>3
					wait 1
				wait 5
				if ${Me.Archetype.Equal[fighter]}
				{
					RIMUIObj:SetLockSpot[OFF]
					wait 30
				}
				wait 20
			}
			else
			{
				RIMUIObj:SetLockSpot[ALL,-323.196747,11.774687,317.118469]
				while ${Math.Distance[${Me.Loc},-323.196747,11.774687,317.118469]}>3
					wait 1
				wait 5
				if ${Me.Archetype.Equal[fighter]}
				{
					RIMUIObj:SetLockSpot[OFF]
					wait 30
				}
				wait 20
			}
			Trigger:Set[FALSE]
		}
		wait 1
	}
	echo ISXRI: Ending Chomp
}
function Primatious()
{
	echo ISXRI: Starting Primatious
	
	IncomingText:Insert["prepares to unleash a nasty bloody bite to all those nearby in his thirst for blood"]
	RIMUIObj:SetLockSpot[ALL,-523.602600,11.180099,-56.043617]
	wait 10
	while ${Math.Distance[${Me.Loc},-523.602600,11.180099,-56.043617]}>3
		wait 1
	wait 5
	if ${Me.Archetype.Equal[fighter]}
		RIMUIObj:SetLockSpot[OFF]
	while ${Actor[Query, Name=="Sentinel Primatious" && IsDead=FALSE](exists)}
	{
		if ${RIMUIObj.MainIconIDExists[${Me.ID},540]}
		{
			RI_CMD_Assist 0
			Actor[${Me.ID}]:DoTarget
			while ${RIMUIObj.MainIconIDExists[${Me.ID},540]}
			{
				if ${Target.ID}!=${Me.ID}
					Actor[${Me.ID}]:DoTarget
				call CheckTriggerPrimatious
				wait 5
			}
			RI_CMD_Assist 1
		}
		elseif ${Me.Archetype.Equal[fighter]} && ${Me.InCombat}
		{
			if ${Target.ID}!=${Actor[Query, Name=="Sentinel Primatious" && IsDead=FALSE].ID}
				Actor[Query, Name=="Sentinel Primatious" && IsDead=FALSE]:DoTarget
		}
		call CheckTriggerPrimatious
		wait 5
	}
	echo ISXRI: Ending Primatious
}
function CheckTriggerPrimatious()
{
	if ${Trigger}
	{
		if ${Actor[Query, Name=="Sentinel Primatious" && IsDead=FALSE].Target.Name.Equal[${Me.Name}]} || ${Me.Archetype.Equal[fighter]}
			wait 50
		if ${Math.Distance[${Me.Loc},-523.602600,11.180099,-56.043617]}<25
		{
			RIMUIObj:SetLockSpot[ALL,-555.931274,11.180054,-25.864149]
			while ${Math.Distance[${Me.Loc},-555.931274,11.180054,-25.864149]}>3
				wait 1
			wait 5
			if ${Me.Archetype.Equal[fighter]}
			{
				RIMUIObj:SetLockSpot[OFF]
				wait 30
			}
			wait 20
		}
		else
		{
			RIMUIObj:SetLockSpot[ALL,-523.602600,11.180099,-56.043617]
			while ${Math.Distance[${Me.Loc},-523.602600,11.180099,-56.043617]}>3
				wait 1
			wait 5
			if ${Me.Archetype.Equal[fighter]}
			{
				RIMUIObj:SetLockSpot[OFF]
				wait 30
			}
			wait 20
		}
		Trigger:Set[FALSE]
	}
}
function Runelord()
{
	echo ISXRI: Starting Runelord
	while ${Actor[Query, Name=="The Strathbone Runelord" && IsDead=FALSE](exists)}
	{
		if ${RIMUIObj.MainIconIDExists[${Me.ID},540]}
		{
			RI_CMD_Assist 0
			Actor[${Me.ID}]:DoTarget
			while ${RIMUIObj.MainIconIDExists[${Me.ID},540]}
			{
				if ${Target.ID}!=${Me.ID}
					Actor[${Me.ID}]:DoTarget
				wait 1
			}
			RI_CMD_Assist 1
		}
		elseif ${Me.Archetype.Equal[fighter]} && ${Me.InCombat}
		{
			if ${Target.ID}!=${Actor[Query, Name=="The Strathbone Runelord" && IsDead=FALSE].ID}
				Actor[Query, Name=="The Strathbone Runelord" && IsDead=FALSE]:DoTarget
		}
		wait 5
	}
	echo ISXRI: Ending Runelord
}
function Shanaira()
{
	echo ISXRI: Starting Shanaira
	
	RI_CMD_Assist 0
	
	if ${Me.Archetype.NotEqual[fighter]}
	{
		RIMUIObj:SetLockSpot[ALL,0.355797,4.718675,-7.988738]
	}
	
	while !${Me.InCombat}
		wait 1
	
	IncomingText:Clear
	IncomingText2:Clear
	IncomingText:Insert["aligns her magic into a ring of blazing winds around ${Me.Name}"]
	
	while ${Actor[Query, Name=-"Shanaira" && Distance<=100](exists)}
	{
		if ${Actor[Query, Name=-"swarm" && IsDead=FALSE](exists)}
		{
			if ${Target.ID}!=${Actor[Query, Name=-"swarm" && IsDead=FALSE].ID}
				Actor[Query, Name=-"swarm" && IsDead=FALSE]:DoTarget
		}
		elseif ${Actor[Query, Name=-"Illusion of ${Me.Name}" && IsDead=FALSE](exists)}
		{
			if ${Target.ID}!=${Actor[Query, Name=-"Illusion of ${Me.Name}" && IsDead=FALSE].ID}
				Actor[Query, Name=-"Illusion of ${Me.Name}" && IsDead=FALSE]:DoTarget
		}
		else
		{
			if ${Target.ID}!=${Actor[Query, Name=-"Shanaira" && Distance<=100].ID}
				Actor[Query, Name=-"Shanaira" && IsDead=FALSE && Distance<=100]:DoTarget
		}
		if ${RIMUIObj.MainIconIDExists[${Me.ID},488]} || ${Trigger}
		{
			RIMUIObj:SetLockSpot[ALL,9.978826,5.179579,22.060690]
			if ${Trigger}
			{
				wait 100
				Trigger:Set[FALSE]
			}
			else
			{
				while ${RIMUIObj.MainIconIDExists[${Me.ID},488]}
				{
					if ${Actor[Query, Name=-"swarm" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=-"swarm" && IsDead=FALSE].ID}
							Actor[Query, Name=-"swarm" && IsDead=FALSE]:DoTarget
					}
					elseif ${Actor[Query, Name=-"Illusion of ${Me.Name}" && IsDead=FALSE](exists)}
					{
						if ${Target.ID}!=${Actor[Query, Name=-"Illusion of ${Me.Name}" && IsDead=FALSE].ID}
							Actor[Query, Name=-"Illusion of ${Me.Name}" && IsDead=FALSE]:DoTarget
					}
					else
					{
						if ${Target.ID}!=${Actor[Query, Name=-"Shanaira" && Distance<=100].ID}
							Actor[Query, Name=-"Shanaira" && IsDead=FALSE && Distance<=100]:DoTarget
					}
					wait 2
				}
			}
			RIMUIObj:SetLockSpot[ALL,0.355797,4.718675,-7.988738]
		}
		wait 2
	}
	echo ISXRI: Ending Shanaira
}