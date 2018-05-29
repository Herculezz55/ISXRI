;CombatBot by Herculezz
;

;Grim Aura MainIconID = 899, have it check for the ID and if not exist, and not in combat, equip the item, use it, set a 1min timer, reequip other ear (keep try to equip until its equipped) 

;need to put update for raid/group lists into the main loop maybe call it once every cpl secs or something.

;;;;;;;;change the add methods to take in the Text and The Value to add to the list box so it can also be done via code. -- DONE
;
;my thoughts to add the name of the alias to the value in the assist box will not work because of multiple aliases and changing on the fly etc. SO need to change back to just the assist name and have it search through the alias list box each time -- DONE
;
;also i want to make it so when you click on the raidgroup list of aliases it unselects on the other list, also if you click on an item in the added list it populates the text entries AND if the text entries are populated and something is selected change the add button text to edit and when clicked edit that entry, when an item in teh added list is deselected change edit back to add. -- DONE Except the ADD button they can move and remove if they want at least for now

;;also the IEP import is not working fix it. --- DONE

;also need to read in the settings and modify those values --- Done need to code them now (Done With Most)

;also need to think of better casting logic that also incorporates watching for the cast of the ability. except for instant cast stuffs

;need to finish with InvisAbilities - - - need to find the ExportPosition and add it as the Value to the list -- DONE - Coding DONE

;code Pre/Post CAST to use the list box - DONE


; :Clear clears an index
;

;want to make object's to check for raid and group healths and cures and stuff, and maintained, and all the checks basically
;


;change log
;v1.20b Changes - Fixed a bug in Targeting that would cause the toon to stop targeting checks when assist was set to them
;v1.20b Changes - Fixed a bug in Item cast that was turning on Assist even on toon that previously did not have them
;v1.20b Changes - Added Max Increments Abilities for Wizard/Warlock/Conjuror/Necromancer/Monk/Guardian/Brigand/Mystic
;v1.20b Changes - Added Cure Curse when Seen "need a cure curse"
;v1.20b Changes - Added Confront Fear when Seen "need a confront fear"
;v1.20b Changes - Added Confront Fear call out when have revive sickness

;v1.21b Changes - Fixed a bug in CombatBotCastOn Atom
;v1.21b Changes - Added Negative Void Logic to Warlock
;v1.21b Changes - Fixed a bug in CF Logic that was making it call out on Revive

;v1.22b Changes - Fixed a bug in CombatBotChangeAssist Atom

;v1.23b Changes - Added Debug booleans - 
;v1.23b Changes - Added the classes that can cast while moving
;v1.23b Changes - Modified casting routine to help prevent toggling of abilities
;v1.23b Changes - Added Raid/Group Name-Distance-Target HUD
;v1.23b Changes - Added PreCast PostCast

;v1.24b Changes - Added Savagery checks for Beastlord
;v1.24b Changes - Added Dissonance checks for Channeler

;v1.25b Changes - Added paladin/shadowknight to cast while moving

;v1.26b Changes - Fixed an issue with CombatBotAssisting that was causing the tank to not TargetNearestAggroMob
;v1.26b Changes - Added announce

;v1.27b Changes - Fixed a bug in Pre/Post cast that was ignoring Disabled Setting

;v1.28b Changes - Fixed a bug in CheckAssist on fighters that was erroring

;v1.29b Changes - Added CombatBotChangeFaceNPC and CombatBotChangeFaceNPCGlobal
;v1.29b Changes - Added Exploit Weakness for Predators

;v1.30b Changes - Added CharmInfo

;v1.31b Changes - Internal Testing Build (Move To CombatBot)

;v2.35 Changes - Fixed a bug in abilities that do not allowraid and heals to other groups
;v1.32b Changes - Drastically Changed Checking Routine
;v1.32b Changes - Added Ability to change Profiles (dynamically)
;v1.32b Changes - Added Auto Attack Timing
;v1.32b Changes - Added Close and Reload of the bot when a different Toon Name is detected
;v1.32b Changes - Added Ability to Change Aliases (dynamically)
;v1.32b Changes - Added CombatBotAutoAttackTiming global bool to turn on/off auto attack timing (default is on)
;v1.32b Changes - Added CombatBotCastExploitWeakness global bool to turn on/off exploit weakness for predators (default is on)
;v1.32b Changes - Fixed a bug that was not getting a KillTarget, causing all flanking/back abilities to try to cast when not behind
;v1.32b Changes - Fixed a bug in Negative Void code
;v1.32b Changes - Fixed a bug in req flanking code
;v1.32b Changes - Fixed a bug in KillTargetID code
;v1.32b Changes - Fixed a bug in AllowRaid check
;v1.32b Changes - Tweaked a few things for better performance
;v1.32b Changes - Added real ismoving checks and only allow CA's to cast while moving
;v1.32b Changes - Added invis casting, and In Plain Sight Detection for Assassin's
;v1.32b Changes - Fixed a bug that was cycling Item Maintained Effect Items that had a target of Self (Vigor Charm)
;v1.32b Changes - Removed auto loading of RI's Raid/Group and Closest Named/NPC/PC hud's (per request)
;v1.32b Changes - Added cancel invis after combat
;v1.32b Changes - Fixed a bug that was causing you to target yourself when using an item that was set with no target (on tanks this would cause them to target themselves forever)
;v1.32b Changes - Fixed a bug that was not retargeting your target after casting an item
;v1.32b Changes - Added a Cast Stack Editor, Enable/Disable Abilities, Remove Abilities, Reorder Abilities, Add/Edit Abilities

;v4.27 changes
;	Updated version to Match RI version
;	Added New UI
;	Revamped Items Routine to read from ListBox Value and read in values from profile
;	Revamped Aliases Routine to read from ListBox Value and read in values from profile
;	Revamped CastStack Routine to read from ListBox Value and read in values from profile
;	Revamped Assist Routine to read from ListBox Value and read in values from profile
;	Revamped PrePostCast Routine to read from ListBox Value and read in values from profile
;	Revamped InvisAbilities Routine to read from ListBox Value and read in values from profile
;	Revamped Announce Routine to read from ListBox Value and read in values from profile
;	Revamped OnEvents Routine to read from ListBox Value and read in values from profile
;	CharmSwap Tab now gets items and highlights the settings from your profile, Changing the highligh in the listbox changes the Variable
;	Huds tab loads from profile and reacts to the settings
;	Added Load RI_AutoTarget button in AutoTarget Tab for now.
;	Added CB ImportOgre command
;
;v4.28 changes
;		Added Save/Delete Profile Features, Added changing of Default Profile
;		Fixed a bug in reading of the list of profiles from the profile file.
;		Fixed KeyMappings

;	Fixed Confront Fear call out, still need to develop some logic for multiple bards in raid setting. and code to store everyone who calls it out in a index, Then cure 5 times, or until the index is empty, use virtuoso bard method, then cure the person that corresponds to the element in the array of your bard #, then once the 22.5s is up and the spell is back, then cure 2* your number then 3* and so on and so forth.


;;MAX Settings
;Warlcok
;(if max)Skull Foci -- cast all the time until at 3 increments then only cast if down an increment OR if at 3 and in AE fight then CAST it to blow it up
;(if max)Caustic Detonation when Toxic Aura is 180 
;(if max)Toxic Assault when Toxic Aura is 180
;(if max)Rift - Toxic Aura 180
;(if max)Appocalypse - Toxic Aura 180
;(if max)Anything - Toxic Aura 180

;Wizard
;(if max)Skull Foci -- cast all the time until at 3 increments then only cast if down an increment OR if at 3 and in AE fight then CAST it to blow it up
;(if max)Frozen Detonation when Frozen Solid 150 
;(if max)Frozen Rain when Frozen Solid 150
;(if max)Rift - Frozen Solid 150
;(if max)Blast of Devastation - Frozen Solid 150
;(if max)E'Ci's Frozen Wrath - Frozen Solid 150
;(if max)

;Conjuror
;(if max)World Ablaze -- cast all the time until at 3 increments then only cast if down an increment OR if at 3 and in AE fight then CAST it to blow it up
;(if max)Planar Burst - Planar Wrack 5

;Monk
;(if max)Fluid Combination - Waveform 5

;Guardian
;(if max)Champion's Interception - Champion's Sight 50

;Brigand
;(if max)Shred - Thug's Poison 5



;once we get all the basics good, theres more: need to add a command to turn off assist, and change assist, need to fix spell cast command, maybe make it an atom, need to add a command to turn off certain types, just everything needed for all coded fights in ri.
;
;need to fix so it casts on Toons and not dummyfirepets -DONE
;need to fix minduration for if its 0 dont check -- DONE
;need to add EffectRadius and Check it for AE Abilities instead of MaxRange. - DONE
;need to finish fixing range's using the formula from combat or ca. done with those 2
;still need to recode RZ to use RIMovement instead of Ogrefollow and CS - DONE
;
;fix auto target when hated -- DONE
;need to code to send in pets (same place as turning on auto attack) -- DONE
;need to code auto face mobs (maybe in cast routine? or actually in the CA/NamedHostile Routines so we arent trying to face when casting heals. Or maybe even in teh routine where we are getting the KillTargetID) --- DONE
;need to code auto accept rezes (at beginning of for loop do a death check and offered res check) 
;
;need to fix the else's to add raid as well checks to check for targets. and check allowraid flag - dont think this is necessary because ogre doesnt allow it to be set to raid if its not - skipping until an issue arrises
;
;need to add minRange and code for it as well -- DONE
;find out why CA's are not casting on priests -- Still Testing - DONE
;
;need to code Flanking and behind checks for abilities that require them -- DONE
;check valid rear position
			;Heading:Set[${Actor[${KillTargetID}].Heading}]
			;HeadingTo:Set[${Actor[${KillTargetID}].HeadingTo}]
			;Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
			;Angle:Set[${Math.Acos[${Angle}]}]
			
			; ${Math.Acos[${Math.Cos[${Target.Heading}]} * ${Math.Cos[${Target.HeadingTo}]} + ${Math.Sin[${Target.Heading}]} * ${Math.Sin[${Target.HeadingTo}]}]}
			;if the angle is below 120 we are good to cast any behind/flank ability
			;if the angle is greater than 60 we are good for infront/flanking
			
			;----DONE
			
;need to code AE and Encounter Checking - DONE
;need to add a atom to disable/enable spells in cast stack -- DONE
;need to fix cast obj --- Still Working
;need to add invis casting, and pre/post cast  --  Maybe Not / for now disabled stealth abilities if not stealthed
;ITEM Casting DONE, except in CURES -- Skipping For Now
;need to code, OutOfCombatBuffs -- DONE
;need to move incombat checking to CA,NamedHostile and Combat routines because the rest cast out of combat.  -- DONE
;also need to move kill target check to those as well because the others dont require it -- DONE
;
;
;check into waterdepth method of me instead of .isswimming also there is .InWater -- FOR RI
;use .IsInvis for invis checking -- DONE
;
;
;===================================================
;===          AutoAttack Timing                 ====
;===================================================
variable(global) bool CombatBotDoBackFlankCalcs=TRUE
variable float RI_Var_Float_LocalCBVersion=${RI_Var_Float_Version.Precision[2]}
variable float PrimaryDelay
variable float LastAutoAttack
variable(global) float TimeUntilNextAutoAttack
variable float RunningTimeInSeconds
variable bool AutoAttackReady
variable CalcAutoAttackTimerObject CalcAutoAttackTimerObj
variable DirgeNumberObject DirgeNumObj
variable(global) RI_Object_CB RI_Obj_CB
;Variables
variable(global) string RI_Var_String_Charm_1=None
variable(global) string RI_Var_String_Charm_2=None
variable bool CombatBotFullDebug=FALSE
variable bool CombatBotCastingDebug=FALSE
variable bool CombatBotDebug=FALSE
variable bool CombatBotDebugTargeting=FALSE
variable(global) string RI_Var_String_CombatBotScriptName=${Script.Filename}
variable(global) MobsObject Mobs
variable PrePostCheckerObject PrePostChecker
variable(global) ConvertAbilityObject ConvertAbilityObj
variable AnnounceObject AnnounceObj
variable CheckAbilitiesObject CheckAbilitiesObj
variable int AliasesCount
variable(global) bool RI_Var_Bool_CastWhileMoving=FALSE
variable(global) bool RI_Var_Bool_OnEventsEnabled=TRUE
variable index:string istrProfiles
variable index:string istrExportList
variable index:string istrExportListPosition
variable index:string istrExport
variable index:string istrExportID
variable index:string istrExportLevel
variable index:string istrExportAllowRaid
variable index:string istrExportDissonanceCost
variable index:string istrExportDoesNotExpire
variable index:string istrExportIsAE
variable index:string istrExportIsAEncounterHostile
variable index:string istrExportIsBeneficial
variable index:string istrExportMinRange
variable index:string istrExportMaxRange
variable index:string istrExportMaxDuration
variable index:string istrExportSavageryCost
variable index:string istrExportReqFlanking
variable index:string istrExportReqStealth
variable index:string istrExportCastingTime
variable index:string istrExportSpellBookType
variable index:string istrExportISPCCure
variable index:string istrExportIsABuff
variable index:string istrExportIsASingleTargetBeneficial
variable index:string istrExportIsASingleTargetHostile
variable index:string istrExportIsOtherGroupAbility
variable index:string istrExportIsPCCureCurse
variable index:string istrExportIsRes
variable index:string istrExportIsSingleTargetAbility
variable index:string istrExportIsPetAbility
variable index:string istrExportIsGroupAbility
variable index:string istrExportIsRaidAbility
variable index:string istrExportIsSelfAbility
variable index:string istrExportMaxAOETargets
variable index:string istrExportFeral
variable index:string istrExportSpiritual

variable index:string istrCurses
variable(global) index:string istrConfrontFear
variable int intCFQuery

variable(global) index:string istrCastStackAbiltiesListBoxOriginalColor
variable string strMyName=${Me.Name}
variable(global) string RI_Var_String_MySubClass=${Me.SubClass.Left[1].Upper}${Me.SubClass.Right[-1]}
variable int intMyLevel=${Me.Level}
variable settingsetref setProfile
variable settingsetref setExport
variable string CastTarget
variable bool FoundTarget=FALSE
variable int KillTargetID=0
variable int KillTargetHealth=-1
variable int mainCount=1
variable int count2
variable bool ItemRIE=FALSE
variable bool ItemEquiped=FALSE
variable(global) bool CombatBotStarted=TRUE
variable(global) bool CombatBotPaused=FALSE
variable string strCastName
variable string strCastNameShort
variable string strCastID
variable string strCastTarget
variable bool boolItemCast=FALSE
variable bool boolAbilityCast=FALSE
variable bool boolFoundMaintained=FALSE
variable float Angle
variable float Heading
variable float HeadingTo
variable float RangeCalc
variable float MinDist
variable float MaxDist
variable int AEcount=0
variable int ENCcount=0
variable bool QuestOffered=FALSE
variable int AssistID=0
variable string ScriptFileName=${Script.Filename}
variable int LastTargetedTime=0
variable int LastValidTargetTime=0
variable float KillTargetMeleeMaxRange=0
variable int intTimeChecks=0
variable int intTimeChecksSF=0
variable string MeleeAttk
variable string RangedAttk
variable string FaceNPC
variable bool FaceNPCNow=TRUE
variable(global) bool CombatBotAssisting=TRUE
variable bool boolCastHostile=TRUE
variable bool boolCastNamedHostile=TRUE
variable bool boolCastInCombatTargeted=TRUE
variable bool boolCastHeal=TRUE
variable bool boolCastPower=TRUE
variable bool boolCastCure=TRUE
variable bool boolCastBuff=TRUE
variable bool boolCastRes=TRUE
variable bool boolCastOutOfCombatBuff=TRUE
variable bool boolInstantCast=FALSE
variable bool boolBuff=FALSE
variable string strMaxIncrementAbility
variable int intMaxIncrements
variable bool boolTBCMatchFound=FALSE
variable bool DoCasting=FALSE
variable bool DoCastingItem=FALSE
variable bool boolCancelCast=FALSE
variable string strDoCastName
variable string strDoCastNameShort
variable string strDoCastID
variable string strDoCastTarget
variable int SawCFTime=0
variable(global) index:string RaidGroupName
variable(global) index:string RaidGroupDistance
variable(global) index:string RaidGroupTarget
variable bool boolPreCast=FALSE
variable bool boolPostCast=FALSE
variable string strPreCastName
variable string strPreCastNameShort
variable string strPreCastID
variable string strPostCastName
variable string strPostCastNameShort
variable string strPostCastID
variable bool boolAnnounce=FALSE
variable string strAnnounceText
variable int CheckAbilitiesTime=0
variable int LastFaceTime=0
variable string CombatBotDefaultProfile
variable CountSetsObject CountSets
variable CountSettingsObject CountSettings
variable settingsetref Set
variable settingsetref SaveSet
variable(global) bool CombatBotCastExploitWeakness=TRUE
variable(global) bool CombatBotAutoAttackTiming=TRUE
variable int InPlainStealthUPTime=-7000
;variable bool GetItems=TRUE
;variable bool GetCharms=TRUE
variable bool IWasResed=FALSE
variable(global) bool CombatBotIDied=FALSE
variable(global) string RI_Var_String_CB_ConfrontFearText="need a confront fear"
variable(global) bool RI_Var_Bool_CB_CallForConfrontFear=1
variable string ImportingOgre=FALSE
variable bool WasRIFollowing=FALSE
variable(global) bool CombatBotCSCDebug=FALSE
;variable bool SummonMount=FALSE
variable int LastSavageryCastTime=1
variable bool SavageryAbility=FALSE
variable string CurrentLootWindowID=0
;variable(global) bool RI_Var_Bool_AutoDeityDisabled=0
variable int PotencyCount=0
variable int CritBonusCount=0
variable int StaminaCount=0
variable(global) bool _CB_LootImmunity_=FALSE
variable bool CB_Bool_MoveBehindOn=0

atom(global) RI_Atom_CB_SetUISetting(string _SettingName, string Value)
{	
	RI_Obj_CB:SetUISetting[${_SettingName},${Value}]
}
objectdef RI_Object_CB
{
	member:string ConvertBattleGroundsName(string _Name)
	{
		if ${_Name.Find[Halls_of_Fate](exists)}
			return ${_Name.Right[-14]}
		elseif ${_Name.Find[Antonia_Bayle](exists)}
			return ${_Name.Right[-14]}
		elseif ${_Name.Find[Isle_of_Refuge](exists)}
			return ${_Name.Right[-15]}
		elseif ${_Name.Find[Maj'Dul](exists)}
			return ${_Name.Right[-8]}
		elseif ${_Name.Find[Skyfire](exists)}
			return ${_Name.Right[-8]}
		elseif ${_Name.Find[Thurgadin](exists)}
			return ${_Name.Right[-10]}
		else
			return ${_Name}
	}
	
	member:string ConvertAbilityID(string _AbilityName)
	{
		return ${ConvertAbilityObj.ConvertID["${_AbilityName}"]}
	}
	member:string ConvertAbility(string _AbilityName)
	{
		return ${ConvertAbilityObj.ConvertName["${_AbilityName}"]}
	}
	method CastWhileMoving(bool Enabled)
	{
		RI_Var_Bool_CastWhileMoving:Set[${Enabled}]
	}
	method DoNotCastAE(bool Enabled)
	{
		;RI_Var_Bool_DoNotCastAE
		if ${Enabled}
			RI_Obj_CB:SetUISetting[SettingsDoNotCastAECheckBox,1]
		else
			RI_Obj_CB:SetUISetting[SettingsDoNotCastAECheckBox,0]
	}
	method DoNotCastEncounter(bool Enabled)
	{
		;RI_Var_Bool_DoNotCastEncounter
		if ${Enabled}
			RI_Obj_CB:SetUISetting[SettingsDoNotCastEncounterCheckBox,1]
		else
			RI_Obj_CB:SetUISetting[SettingsDoNotCastEncounterCheckBox,0]
	}
	;need to have this change the profile in the drop down, also if the profile doesnt exist return
	method ChangeProfile(string ProfileName)
	{
		if ${UIElement[ProfilesComboBox@BottomFrame@CombatBotUI].ItemByText[${ProfileName}](exists)}
		{
			UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:SelectItem[${UIElement[ProfilesComboBox@BottomFrame@CombatBotUI].ItemByText[${ProfileName}].ID}]
			if ${CombatBotDefaultProfile.NotEqual[${ProfileName}]}
			{
				CombatBotDefaultProfile:Set[${ProfileName}]
				LoadProfile
			}
		}
	}
	method ImportOgre()
	{
		ImportingOgre:Set[TRUE]
		declare FP filepath "${LavishScript.HomeDirectory}/"
		declare ImportFile string ""
		FP:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/"]
		if ${FP.FileExists["EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
		elseif ${EQ2.ServerName.Equal[Halls of Fate]} && ${FP.FileExists["EQ2Save_Everfrost_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_Everfrost_${strMyName}.xml"]
		elseif ${EQ2.ServerName.Equal[Halls of Fate]} && ${FP.FileExists["EQ2Save_Guk_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_Guk_${strMyName}.xml"]
		elseif ${EQ2.ServerName.Equal[Halls of Fate]} && ${FP.FileExists["EQ2Save_Unrest_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_Unrest_${strMyName}.xml"]
		elseif ${EQ2.ServerName.Equal[Maj'Dul]} && ${FP.FileExists["EQ2Save_Crushbone_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_Crushbone_${strMyName}.xml"]
		elseif ${EQ2.ServerName.Equal[Maj'Dul]} && ${FP.FileExists["EQ2Save_Butcherblock_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_Butcherblock_${strMyName}.xml"]
		elseif ${EQ2.ServerName.Equal[Maj'Dul]} && ${FP.FileExists["EQ2Save_Oasis_${strMyName}.xml"]}
			ImportFile:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_Oasis_${strMyName}.xml"]
		
		elseif !${FP.FileExists["EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]} && !${FP.FileExists["EQ2Save_Everfrost_${strMyName}.xml"]} && !${FP.FileExists["EQ2Save_Guk_${strMyName}.xml"]} && !${FP.FileExists["EQ2Save_Unrest_${strMyName}.xml"]} && !${FP.FileExists["EQ2Save_Crushbone_${strMyName}.xml"]} && !${FP.FileExists["EQ2Save_Butcherblock_${strMyName}.xml"]} && !${FP.FileExists["EQ2Save_Oasis_${strMyName}.xml"]}
		{
			echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml" Can not import
			return
		}
			if ${ImportFile.Equal[""]}
				return
			echo ISXRI: CombatBot: Importing "${ImportFile}"
			
			variable int i=0
			variable int j=0
			variable int k=0
			variable index:string _istrItemEffectPairsItemName		
			variable index:string _istrItemEffectPairsEffectName
			variable index:string _istrProfiles
			variable index:string _istrAbilities
			variable index:string _istrAbilityExportPosition
			variable index:string _istrAbilityType
			variable index:string _istrAbilityTarget
			variable index:string _istrAbility%
			variable index:string _istrAbility#
			variable index:string _istrAbilityIgnoreDuration
			variable index:string _istrAbilityIE
			variable index:string _istrAbilityIAE
			variable index:string _istrAbilityIsItem
			variable index:string _istrAbilityItemName
			variable index:string _istrAbilityRIE
			variable index:string _istrAbilityDisabled
			variable index:string _istrAbilityMax
			variable index:string _istrAbilitySavagery
			variable index:string _istrAbilityDissonanceLess
			variable index:string _istrAbilityDissonanceGreater
			
			variable index:string _istrAliasName
			variable index:string _istrAliasFor
			
			;Import IEP
			LavishSettings[IEP]:Clear
			LavishSettings:AddSet[IEP]
			LavishSettings[IEP]:Import["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/ItemInformation/Item_Effect_Pairs.xml"]
			
			;Iterating IEP
			variable iterator Iterator
			LavishSettings[IEP]:GetSettingIterator[Iterator]

			if ${Iterator:First(exists)}
			{
				do
				{
					_istrItemEffectPairsItemName:Insert[${Iterator.Key}]
					_istrItemEffectPairsEffectName:Insert[${Iterator.Value}]
					
					;echo "${Iterator.Key}=${Iterator.Value}"
				}
				while ${Iterator:Next(exists)}
				;Done Iterating Export
			}	
			LavishSettings[IEP]:Clear
			
			;import set
			LavishSettings[ImportSet]:Clear
			LavishSettings:AddSet[ImportSet]
			LavishSettings[ImportSet]:Import["${ImportFile}"]
			
			;export set
			LavishSettings[ExportSet]:Clear
			LavishSettings:AddSet[ExportSet]
			
			;iterate through profiles and store in temp index to retrieval
			LavishSettings[ImportSet].FindSet[Profiles]:GetSetIterator[Iterator]
			if ${Iterator:First(exists)}
			{
				do
				{	
					_istrProfiles:Insert[${Iterator.Key}]
					;echo ${Iterator.Key}
				}
				while ${Iterator:Next(exists)}
			}
			;echo ${LavishSettings[ImportSet].FindSet[Profiles].FindSetting[DefaultProfiles]}
			;add profile set
			LavishSettings[ExportSet]:AddSet[Profiles]
			LavishSettings[ExportSet].FindSet[Profiles]:AddSetting[DefaultProfile,${LavishSettings[ImportSet].FindSet[Profiles].FindSetting[DefaultProfiles]}]
			
			
			
			;for loop to import everything from each profile

			for(i:Set[1];${i}<=${_istrProfiles.Used};i:Inc)
			{
				;clear the indexes
				_istrAbilities:Clear
				_istrAbilityExportPosition:Clear
				_istrAbilityType:Clear
				_istrAbilityTarget:Clear
				_istrAbility%:Clear
				_istrAbility#:Clear
				_istrAbilityIgnoreDuration:Clear
				_istrAbilityIE:Clear
				_istrAbilityIAE:Clear
				_istrAbilityIsItem:Clear
				_istrAbilityItemName:Clear
				_istrAbilityRIE:Clear
				_istrAbilityDisabled:Clear
				_istrAbilityMax:Clear
				_istrAbilitySavagery:Clear
				_istrAbilityDissonanceLess:Clear
				_istrAbilityDissonanceGreater:Clear
				
				_istrAliasName:Clear
				_istrAliasFor:Clear
				
				;add the sets
				LavishSettings[ExportSet].FindSet[Profiles]:AddSet[${_istrProfiles.Get[${i}]}]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Settings]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[CastStack]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Items]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Aliases]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Assist]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[PrePostCast]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[InvisAbilities]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Announce]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Button]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[CharmSwap]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[OnEvents]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Loot]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Huds]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[Misc]
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}]:AddSet[SubClass]
				
				;grab settings we use
				
				;checkbox_settings_rangedattack
				;echo ${_istrProfiles.Get[${i}]}
				;echo ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_meleeattack]}
			
				;SettingsRangedAutoCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_rangedattack](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsRangedAutoCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_rangedattack]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsRangedAutoCheckBox,FALSE]
				
				;SettingsMeleeAutoCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_meleeattack](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMeleeAutoCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_meleeattack]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMeleeAutoCheckBox,FALSE]
					
				;SettingsCancelAutoCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_turnoffattack](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCancelAutoCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_turnoffattack]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCancelAutoCheckBox,FALSE]
				
				;SettingsTimeAutoCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_autoattacktiming](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsTimeAutoCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_autoattacktiming]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsTimeAutoCheckBox,FALSE]
				
				;SettingsSkipMobAttackHealthCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_ignoretargettoattackhealthcheck](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipMobAttackHealthCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_ignoretargettoattackhealthcheck]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipMobAttackHealthCheckBox,FALSE]
					
				;SettingsAttackHealthTextEntry
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_percenttoattack](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAttackHealthTextEntry,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_percenttoattack]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAttackHealthTextEntry,100]
				
				;SettingsMoveBehindCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_movebehind](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveBehindCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_movebehind]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveBehindCheckBox,FALSE]
				
				;SettingsMoveInFrontCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_moveinfront](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveInFrontCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_moveinfront]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveInFrontCheckBox,FALSE]
				
				;SettingsMoveInCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_movemelee](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveInCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_movemelee]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveInCheckBox,FALSE]
				
				;SettingsSkipMobMoveHealthCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_ignoremovetoattackhealthcheck](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipMobMoveHealthCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_ignoremovetoattackhealthcheck]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipMobMoveHealthCheckBox,FALSE]
					
				;SettingsMoveHealthTextEntry
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_moveintoattackrangehealthpercent](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveHealthTextEntry,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_moveintoattackrangehealthpercent]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsMoveHealthTextEntry,100]
				
				;SettingsSkipEncounterCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_encountersmartnukes].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipEncounterCheckBox,FALSE]
				elseif !${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_encountersmartnukes](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipEncounterCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipEncounterCheckBox,TRUE]
				;SettingsEncounter#TextEntry
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_encountertargets](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsEncounter#TextEntry,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_encountertargets]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsEncounter#TextEntry,3]
				
				;SettingsSkipAECheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_aesmartnukes].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipAECheckBox,FALSE]
				elseif !${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_aesmartnukes](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipAECheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipAECheckBox,TRUE]
				
				;SettingsAE#TextEntry
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_pbaetargets](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAE#TextEntry,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Setup].FindSetting[textentry_setup_pbaetargets]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAE#TextEntry,3]
				
				;SettingsFaceMobCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_facenpc](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsFaceMobCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_facenpc]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsFaceMobCheckBox,FALSE]
				
				;SettingsSendPetsCheckBox
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSendPetsCheckBox,TRUE]
				
				;SettingsRecallPetsCheckBox
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsRecallPetsCheckBox,TRUE]
				
				;SettingsCastAbilitiesCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastAbilitiesCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastAbilitiesCheckBox,TRUE]
				
				;SettingsCastHostileCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_ca].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastHostileCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastHostileCheckBox,TRUE]
				
				;SettingsCastNamedHostileCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_NamedHostile].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastNamedHostileCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastNamedHostileCheckBox,TRUE]
				
				;SettingsCastInCombatTargetCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_combat].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastInCombatTargetCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastInCombatTargetCheckBox,TRUE]
				
				;SettingsCastHealCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_heal].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastHealCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastHealCheckBox,TRUE]
				
				;SettingsCastPowerCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_Power].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastPowerCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastPowerCheckBox,TRUE]
				
				;SettingsCastCureCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_cure].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastCureCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastCureCheckBox,TRUE]
				
				;SettingsCastResCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_res].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastResCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastResCheckBox,TRUE]
				
				;SettingsCastBuffCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disablecaststack_buffs].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastBuffCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastBuffCheckBox,TRUE]
				
				;SettingsCastOutOfCombatBuffCheckBox
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastOutOfCombatBuffCheckBox,TRUE]
				
				
				;SettingsCastInvisCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_noinviscasting].String.Equal[TRUE]}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastInvisCheckBox,FALSE]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCastInvisCheckBox,TRUE]
				
				;SettingsCancelInvisCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_cancelinvisaftercombat](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCancelInvisCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_cancelinvisaftercombat]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCancelInvisCheckBox,FALSE]
				
				;checkbox_settings_cancelabilitiestogroupcure
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_cancelabilitiestogroupcure](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCancelCastingGroupCureCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_cancelabilitiestogroupcure]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCancelCastingGroupCureCheckBox,FALSE]
				
				;SettingsAlwaysCastNamedHostileCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_forceNamedHostiletab](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAlwaysCastNamedHostileCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_forceNamedHostiletab]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAlwaysCastNamedHostileCheckBox,FALSE]
					
				;SettingsStartHeroicCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_doho](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsStartHeroicCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_doho]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsStartHeroicCheckBox,FALSE]
				
				;SettingsAssistingCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_assist](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAssistingCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_assist]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAssistingCheckBox,FALSE]
				
				;SettingsLootingCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_loot](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLootingCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_loot]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLootingCheckBox,FALSE]
				
				;SettingsLootCorpsesCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_loot](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLootCorpsesCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_loot]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLootCorpsesCheckBox,FALSE]
				
				;SettingsLootChestsCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_loot](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLootChestsCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_loot]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLootChestsCheckBox,FALSE]
				
				;SettingsLockSpottingCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_movetoarea](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLockSpottingCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_movetoarea]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsLockSpottingCheckBox,FALSE]
					
				;SettingsAutoLoadRIMUICheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_enableogremcp](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoLoadRIMUICheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_enableogremcp]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoLoadRIMUICheckBox,FALSE]
				
				;SettingsAutoLoadRIMobHudCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_enableonscreenassistant](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoLoadRIMobHudCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_enableonscreenassistant]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoLoadRIMobHudCheckBox,FALSE]
				
				;SettingsAcceptRessesCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptres](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptRessesCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptres]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptRessesCheckBox,FALSE]
				
				;SettingsAcceptInvitesCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptinvites](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptInvitesCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptinvites]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptInvitesCheckBox,FALSE]
				
				;SettingsAcceptTradesCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptinvites](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptTradesCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptinvites]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptTradesCheckBox,FALSE]
				
				;SettingsAcceptLootCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptloot](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptLootCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_acceptloot]}]
				else 
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAcceptLootCheckBox,FALSE]
				
				;SettingsSkipAbilityCollisionCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disableabilitycollisionchecks](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipAbilityCollisionCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_disableabilitycollisionchecks]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsSkipAbilityCollisionCheckBox,FALSE]
				
				;SettingsAutoTargetMobsCheckBox
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_autotargetwhenhated](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoTargetMobsCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings].FindSetting[checkbox_settings_autotargetwhenhated]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoTargetMobsCheckBox,FALSE]
				
				;SettingsAutoRunKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsAutoRunKeyTextEntry,Num Lock]
				
				;SettingsForwardKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsForwardKeyTextEntry,W]
				
				;SettingsBackwardKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsBackwardKeyTextEntry,S]
				
				;SettingsStrafeLeftKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsStrafeLeftKeyTextEntry,Q]
				
				;SettingsStrafeRightKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsStrafeRightKeyTextEntry,E]
				
				;SettingsJumpKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsJumpKeyTextEntry,Space]
				
				;SettingsCrouchKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsCrouchKeyTextEntry,Z]
				
				;SettingsFlyUpKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsFlyUpKeyTextEntry,Home]
				
				;SettingsFlyDownKeyTextEntry
				LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Settings]:AddSetting[SettingsFlyDownKeyTextEntry,End]
				
				
				
				;grab cast stack
				
				variable int CSCount=0
				CSCount:Set[0]
				;iterate through CastStack and store count in temp index for retrieval
				LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack]:GetSetIterator[Iterator]
				if ${Iterator:First(exists)}
				{
					do
					{	
						CSCount:Inc
						;echo ${Iterator.Key} / ${Iterator.Value}
					}
					while ${Iterator:Next(exists)}
				}
				
				;now iterate through everyset in caststack
				for(j:Set[1];${j}<=${CSCount};j:Inc)
				{
					;add set
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack]:AddSet[${j}]
					
					;iterate through CastStack and store values in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:GetSettingIterator[Iterator]
					_istrAbilityTarget:Insert[FALSE]
					_istrAbility%:Insert[0]
					_istrAbility#:Insert[0]
					_istrAbilityIgnoreDuration:Insert[FALSE]
					_istrAbilityIE:Insert[FALSE]
					_istrAbilityIAE:Insert[FALSE]
					_istrAbilityIsItem:Insert[FALSE]
					_istrAbilityItemName:Insert[FALSE]
					_istrAbilityRIE:Insert[FALSE]
					_istrAbilityDisabled:Insert[FALSE]
					_istrAbilityMax:Insert[FALSE]
					_istrAbilitySavagery:Insert[0]
					_istrAbilityDissonanceLess:Insert[0]
					_istrAbilityDissonanceGreater:Insert[0]
					if ${Iterator:First(exists)}
					{
						do
						{	
							;echo ${Iterator.Key} / ${Iterator.Value}
							if ${Iterator.Key.Equal[__Disabled]}
								_istrAbilityDisabled:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[__IsItem]}
								_istrAbilityIsItem:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[__ItemName]}
								_istrAbilityItemName:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[RIE]}
								_istrAbilityRIE:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[IAE]}
								_istrAbilityIAE:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[IE]}
								_istrAbilityIE:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[ID]}
								_istrAbilityIgnoreDuration:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[#]}
								_istrAbility#:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[%]}
								_istrAbility%:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[__SourceName]}
								_istrAbilities:Insert[${Iterator.Value}]
							if ${Iterator.Key.Equal[Type]}
							{
								switch ${Iterator.Value}
								{
									case CA
									{
										_istrAbilityType:Insert[Hostile]
										break
									}
									case NamedCA
									{
										_istrAbilityType:Insert[NamedHostile]
										break
									}
									case Combat
									{
										_istrAbilityType:Insert[InCombatTargeted]
										break
									}
									case Heal
									{
										_istrAbilityType:Insert[Heal]
										break
									}
									case PowerHeal
									{
										_istrAbilityType:Insert[Power]
										break
									}
									case Buff
									{
										_istrAbilityType:Insert[Buff]
										break
									}
									case NonCombatBuff
									{
										_istrAbilityType:Insert[OutOfCombatBuff]
										break
									}
									case Res
									{
										_istrAbilityType:Insert[Res]
										break
									}		
									case Cure
									{
										_istrAbilityType:Insert[Cure]
										break
									}									
								}
							}
							if ${Iterator.Key.Equal[Target]}
								_istrAbilityTarget:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[MAX]}
								_istrAbilityMax:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Equal[Sav]} && ${RI_Var_String_MySubClass.Equal[beastlord]}
								_istrAbilitySavagery:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Find[D<](exists)} && ${RI_Var_String_MySubClass.Equal[channeler]}
								_istrAbilityDissonanceLess:Set[${j},${Iterator.Value}]
							if ${Iterator.Key.Find[D>](exists)} && ${RI_Var_String_MySubClass.Equal[channeler]}
								_istrAbilityDissonanceGreater:Set[${j},${Iterator.Value}]
						}
						while ${Iterator:Next(exists)}
						
						;CastStackAbilityName
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityName,${_istrAbilities.Get[${j}]}]
						
						;CastStackAbilityType
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityType,${_istrAbilityType.Get[${j}]}]
						
						;CastStackAbilityDisabled
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityDisabled,${_istrAbilityDisabled.Get[${j}]}]
				
						;CastStackAbilityRequiresItemEquipped
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityRequiresItemEquipped,${_istrAbilityRIE.Get[${j}]}]
						
						;CastStackAbilityIgnoreEncounter
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilitySkipEncounter,${_istrAbilityIE.Get[${j}]}]
						
						;CastStackAbilitySkipAE
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilitySkipAE,${_istrAbilityIAE.Get[${j}]}]
						
						;CastStackAbilitySkipDuration
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilitySkipDuration,${_istrAbilityIgnoreDuration.Get[${j}]}]
						
						;CastStackAbilityRequired#
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityRequired#,${_istrAbility#.Get[${j}]}]
						
						;CastStackAbilityRequired%
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityRequired%,${_istrAbility%.Get[${j}]}]
						
						;CastStackAbilityTarget
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityTarget,${_istrAbilityTarget.Get[${j}]}]
						
						;CastStackAbilityRequiresMaxIncrements
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityRequiresMaxIncrements,${_istrAbilityMax.Get[${j}]}]
						
						;CastStackAbilitySavagery
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilitySavagery,${_istrAbilitySavagery.Get[${j}]}]
						
						;CastStackAbilityDissonanceGreater
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityDissonanceGreater,${_istrAbilityDissonanceGreater.Get[${j}]}]
							
						;CastStackAbilityDissonanceLess
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CastStack].FindSet[${j}]:AddSetting[CastStackAbilityDissonanceLess,${_istrAbilityDissonanceLess.Get[${j}]}]
					}
				}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items](exists)}
				{
					;grab items
					
					variable int ItemsCount=0
					ItemsCount:Set[0]
					;iterate through Items and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							ItemsCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					
					;now iterate through everyset in Items
					for(j:Set[1];${j}<=${ItemsCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items]:AddSet[${j}]
						
						;iterate through Items and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{	
								if ${Iterator.Key.Equal[__SourceName]}
								{
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items].FindSet[${j}]:AddSetting[ItemName,${Iterator.Value}]
									for(k:Set[1];${k}<=${_istrItemEffectPairsItemName.Used};k:Inc)
									{
										;echo checking 1 : ${_istrItemEffectPairsItemName.Get[${k}]} against ${Iterator.Value}
										if ${Iterator.Value.String.Equal[${_istrItemEffectPairsItemName.Get[${k}]}]}
										{
											;echo found
											LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items].FindSet[${j}]:AddSetting[ItemEffect,${_istrItemEffectPairsEffectName.Get[${k}]}]
											break
										}
										else
											LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Items].FindSet[${j}]:AddSetting[ItemEffect,${Iterator.Value}]
									}
								}
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Aliases](exists)}
				{
					;grab Aliases
					
					variable int AliasesCount=0
					AliasesCount:Set[0]
					;iterate through Aliases and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Aliases]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							AliasesCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					
					;now iterate through everyset in Aliases
					for(j:Set[1];${j}<=${AliasesCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Aliases]:AddSet[${j}]
						
						;iterate through Aliases and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Aliases].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{	
								if ${Iterator.Key.Equal[__SourceName]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Aliases].FindSet[${j}]:AddSetting[AliasName,${Iterator.Value}]
								if ${Iterator.Key.Equal[For]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Aliases].FindSet[${j}]:AddSetting[AliasFor,${Iterator.Value}]
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Assist](exists)}
				{
					;grab Assist
					
					variable int AssistCount=0
					AssistCount:Set[0]
					;iterate through Assist and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Assist]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							AssistCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					
					;now iterate through everyset in Assist
					for(j:Set[1];${j}<=${AssistCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Assist]:AddSet[${j}]
						
						;iterate through Assist and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Assist].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{	
								if ${Iterator.Key.Equal[__SourceName]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Assist].FindSet[${j}]:AddSetting[AssistName,${Iterator.Value}]
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				variable int PrecastCount=0
				PrecastCount:Set[0]
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Precast](exists)}
				{
					;grab Precast
					
					
					;iterate through Precast and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Precast]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							PrecastCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					;echo ${PrecastCount}
					;now iterate through everyset in Precast
					for(j:Set[1];${j}<=${PrecastCount};j:Inc)
					{
						;echo checking #${j}
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast]:AddSet[${j}]
						
						;iterate through Precast and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Precast].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{	
								;echo ${Iterator.Key} / ${Iterator.Value}
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast].FindSet[${j}]:AddSetting[PrePostCastDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast].FindSet[${j}]:AddSetting[PrePostCastName,${Iterator.Value}]
								if ${Iterator.Key.Equal[On]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast].FindSet[${j}]:AddSetting[PrePostCastBefore,${Iterator.Value}]
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Postcast](exists)}
				{
					;grab Postcast
					
					variable int PostcastCount=0
					PostcastCount:Set[${PrecastCount}]
					
					;iterate through Postcast and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Postcast]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							PostcastCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					;now iterate through everyset in Postcast
					j:Set[0]
					;echo ${Math.Calc[${PrecastCount}+1]}
					variable int temp
					temp:Set[${Math.Calc[${PrecastCount}+1]}]
					;echo Temp:${temp}
					for(k:Set[${temp}];${k}<=${PostcastCount};k:Inc)
					{
						j:Inc
						;echo K: ${k}
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast]:AddSet[${k}]
						
						;iterate through Postcast and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Postcast].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{	
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast].FindSet[${k}]:AddSetting[PrePostCastDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast].FindSet[${k}]:AddSetting[PrePostCastName,${Iterator.Value}]
								if ${Iterator.Key.Equal[After]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[PrePostCast].FindSet[${k}]:AddSetting[PrePostCastAfter,${Iterator.Value}]
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[SetupInvis](exists)}
				{
					;grab InvisAbilities
					
					variable int InvisAbilitiesCount=0
					InvisAbilitiesCount:Set[0]
					;iterate through InvisAbilities and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[SetupInvis]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							InvisAbilitiesCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					
					;now iterate through everyset in InvisAbilities
					for(j:Set[1];${j}<=${InvisAbilitiesCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[InvisAbilities]:AddSet[${j}]
						
						;iterate through InvisAbilities and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[SetupInvis].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{
								;echo ${Iterator.Key} / ${Iterator.Value}
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[InvisAbilities].FindSet[${j}]:AddSetting[InvisAbilityDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[InvisAbilities].FindSet[${j}]:AddSetting[InvisAbilityName,${Iterator.Value}]
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce](exists)}
				{
					;grab Announce
					
					variable int AnnounceCount=0
					AnnounceCount:Set[0]
					;iterate through Announce and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							AnnounceCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					
					;now iterate through everyset in Announce
					for(j:Set[1];${j}<=${AnnounceCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce]:AddSet[${j}]
						
						;iterate through Announce and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{
								;echo ${Iterator.Key} / ${Iterator.Value}
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce].FindSet[${j}]:AddSetting[AnnounceDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce].FindSet[${j}]:AddSetting[AnnounceName,${Iterator.Value}]
								if ${Iterator.Key.Equal[Target]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce].FindSet[${j}]:AddSetting[AnnounceTarget,${Iterator.Value}]
								if ${Iterator.Key.Equal[Txt]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Announce].FindSet[${j}]:AddSetting[Announcement,${Iterator.Value}]
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				variable int LoadExecuteCount=0
				LoadExecuteCount:Set[0]
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[LoadExecute](exists)}
				{
					;grab LoadExecute
					;iterate through LoadExecute and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[LoadExecute]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							LoadExecuteCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					;echo ${LoadExecuteCount}
					;now iterate through everyset in LoadExecute
					for(j:Set[1];${j}<=${LoadExecuteCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents]:AddSet[${j}]
						
						;iterate through LoadExecute and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[LoadExecute].FindSet[${j}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{
								;echo ${Iterator.Key} / ${Iterator.Value}
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
								{
									;echo here
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsEvent,Run]
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsCommand,${Iterator.Value}]
								}
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
									
				variable int UnLoadExecuteCount
				UnLoadExecuteCount:Set[${LoadExecuteCount}]
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[UnLoadExecute](exists)}
				{
					;grab UnLoadExecute

					;iterate through UnLoadExecute and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[UnLoadExecute]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							UnLoadExecuteCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					;echo ${UnLoadExecuteCount}
					;now iterate through everyset in UnLoadExecute
					for(j:Set[${Math.Calc[${LoadExecuteCount}+1]}];${j}<=${UnLoadExecuteCount};j:Inc)
					{
						;echo c:${j}
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents]:AddSet[${j}]
						
						;iterate through UnLoadExecute and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[UnLoadExecute].FindSet[${Int[${Math.Calc[${j}-${LoadExecuteCount}]}]}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{
								;echo ${Iterator.Key} / ${Iterator.Value}
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
								{
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsEvent,End]
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsCommand,${Iterator.Value}]
								}
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				;;echo ${UnLoadExecuteCount}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnZoneExecute](exists)}
				{
					;grab OnZoneExecute
					
					variable int OnZoneExecuteCount=0
					OnZoneExecuteCount:Set[${UnLoadExecuteCount}]
					;iterate through OnZoneExecute and store count in temp index for retrieval
					LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnZoneExecute]:GetSetIterator[Iterator]
					if ${Iterator:First(exists)}
					{
						do
						{	
							OnZoneExecuteCount:Inc
							;echo ${Iterator.Key} / ${Iterator.Value}
						}
						while ${Iterator:Next(exists)}
					}
					;echo ${OnZoneExecuteCount}
					;now iterate through everyset in OnZoneExecute
					for(j:Set[${Math.Calc[${UnLoadExecuteCount}]}];${j}<=${OnZoneExecuteCount};j:Inc)
					{
						;add set
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents]:AddSet[${j}]
						
						;iterate through OnZoneExecute and store Values in Settings
						LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnZoneExecute].FindSet[${Int[${Math.Calc[${j}-${UnLoadExecuteCount}]}]}]:GetSettingIterator[Iterator]
						
						if ${Iterator:First(exists)}
						{
							do
							{
								;echo ${Iterator.Key} / ${Iterator.Value}
								if ${Iterator.Key.Equal[__Disabled]}
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsDisabled,${Iterator.Value}]
								if ${Iterator.Key.Equal[__SourceName]}
								{
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsEvent,Zone]
									LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[OnEvents].FindSet[${j}]:AddSetting[OnEventsCommand,${Iterator.Value}]
								}
							}
							while ${Iterator:Next(exists)}
						}
					}
				}
				;echo ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[EquipmentInfo].FindSetting[combobox_equipmentinfo_charmoption1](exists)}  //  ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[EquipmentInfo].FindSetting[combobox_equipmentinfo_charmoption1]}
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[EquipmentInfo].FindSetting[combobox_equipmentinfo_charmoption1](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CharmSwap]:AddSetting[CharmSwapCharm1ComboBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[EquipmentInfo].FindSetting[combobox_equipmentinfo_charmoption1]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CharmSwap]:AddSetting[CharmSwapCharm1ComboBox,NONE]
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[EquipmentInfo].FindSetting[combobox_equipmentinfo_charmoption2](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CharmSwap]:AddSetting[CharmSwapCharm2ComboBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[EquipmentInfo].FindSetting[combobox_equipmentinfo_charmoption2]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[CharmSwap]:AddSetting[CharmSwapCharm2ComboBox,NONE]
				
				
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_raid](exists)} || ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_group](exists)}
				{
					if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_raid].String.Equal[TRUE]} || ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_group].String.Equal[TRUE]}
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsRaidGroupCheckBox,TRUE]
					else
						LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsRaidGroupCheckBox,FALSE]
				}
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsRaidGroupCheckBox,FALSE]
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_pc](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsNearestPlayerCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_pc]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsNearestPlayerCheckBox,FALSE]
				if ${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_npc](exists)}
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsNearestNPCCheckBox,${LavishSettings[ImportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[HUDs].FindSetting[checkbox_hud_npc]}]
				else
					LavishSettings[ExportSet].FindSet[Profiles].FindSet[${_istrProfiles.Get[${i}]}].FindSet[Huds]:AddSetting[HudsNearestNPCCheckBox,FALSE]
			}
			LavishSettings[ExportSet]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
		
		TimedCommand 10 RI_CB
		Script:End
	}
	method EndBot()
	{
		if ${Script[Buffer:RILooter](exists)} && !${Script[Buffer:RunInstances](exists)}
			Script[Buffer:RILooter]:End
		;if ${Script[Buffer:RIAutoDeity](exists)}
			;Script[Buffer:RIAutoDeity]:End	
		Script:End
	}
	
	method Assist(string OnOff, string AssName=FALSE)
	{
		if ${OnOff.Equal["0"]}
		{
			UIElement[SettingsInstancedAssistingCheckBox@SettingsFrame@CombatBotUI]:UnsetChecked
			CombatBotAssisting:Set[FALSE]
		}
		elseif ${OnOff.Equal["1"]} && ${AssName.Equal[FALSE]}
		{
			UIElement[SettingsInstancedAssistingCheckBox@SettingsFrame@CombatBotUI]:SetChecked
			CombatBotAssisting:Set[TRUE]
		}
		elseif ${AssName.Equal[${Me.Name}]}
		{
			CombatBotAssisting:Set[TRUE]
			UIElement[SettingsInstancedAssistingCheckBox@SettingsFrame@CombatBotUI]:SetChecked
			AssistID:Set[${Me.ID}]
		}
		elseif ${AssName.NotEqual[FALSE]}
		{
			CombatBotAssisting:Set[TRUE]
			UIElement[SettingsInstancedAssistingCheckBox@SettingsFrame@CombatBotUI]:SetChecked
			if ${Me.Raid}>0
			{
				if ${Me.Raid[${AssName}](exists)}
					AssistID:Set[${Me.Raid[${AssName}].ID}]
			}
			else
			{
				if ${Me.Group[${AssName}](exists)}
					AssistID:Set[${Me.Group[${AssName}].ID}]
			}
		}
	}
	member:string GetUISetting(string _SettingName)
	{
		if ${_SettingName.Left[8].Upper.Equal[SETTINGS]} && ${_SettingName.Find[CheckBox](exists)}
		{
			return ${UIElement[${_SettingName}@SettingsFrame@CombatBotUI].Checked}
		}
		elseif ${_SettingName.Left[8].Upper.Equal[SETTINGS]} && ${_SettingName.Find[TextEntry](exists)}
		{
			return ${UIElement[${_SettingName}@SettingsFrame@CombatBotUI].Text}
		}
		elseif ${_SettingName.Left[4].Upper.Equal[HUDS]} && ${_SettingName.Find[CheckBox](exists)}
		{
			return ${UIElement[${_SettingName}@HudsFrame@CombatBotUI].Checked}
		}
		elseif ${_SettingName.Left[4].Upper.Equal[HUDS]} && ${_SettingName.Find[TextEntry](exists)}
		{
			return ${UIElement[${_SettingName}@HudsFrame@CombatBotUI].Text}
		}
	}
	method SetUISetting(string _SettingName, string Value)
	{
		if ${_SettingName.Left[8].Upper.Equal[SETTINGS]} && ${_SettingName.Find[CheckBox](exists)}
		{
			if ${Value.Equal[1]} || ${Value.Equal[TRUE]}
				UIElement[${_SettingName}@SettingsFrame@CombatBotUI]:SetChecked
			elseif ${Value.Equal[0]} || ${Value.Equal[FALSE]}
				UIElement[${_SettingName}@SettingsFrame@CombatBotUI]:UnsetChecked
		}
		elseif ${_SettingName.Left[8].Upper.Equal[SETTINGS]} && ${_SettingName.Find[TextEntry](exists)} && !${_SettingName.Find[Key](exists)} && !${_SettingName.Find[Confront](exists)}
		{
			if ${Value.NotEqual[""]} && ${Int[${Value}]}>=0 && ${Int[${Value}]}<=100
				UIElement[${_SettingName}@SettingsFrame@CombatBotUI]:SetText[${Int[${Value}]}]
		}
		elseif ${_SettingName.Left[8].Upper.Equal[SETTINGS]} && ${_SettingName.Find[TextEntry](exists)} && ( ${_SettingName.Find[Key](exists)} || ${_SettingName.Find[Confront](exists)} )
		{
			if ${Value.NotEqual[""]}
			{
				UIElement[${_SettingName}@SettingsFrame@CombatBotUI]:SetText[${Value}]
			}
		}
		elseif ${_SettingName.Left[4].Upper.Equal[HUDS]} && ${_SettingName.Find[CheckBox](exists)}
		{
			if ${Value.Equal[1]} || ${Value.Equal[TRUE]} && !${UIElement[${_SettingName}@HudsFrame@CombatBotUI].Checked}
				UIElement[${_SettingName}@HudsFrame@CombatBotUI]:LeftClick
			elseif ${Value.Equal[0]} || ${Value.Equal[FALSE]} && ${UIElement[${_SettingName}@HudsFrame@CombatBotUI].Checked}
				UIElement[${_SettingName}@HudsFrame@CombatBotUI]:LeftClick
		}
		elseif ${_SettingName.Left[4].Upper.Equal[HUDS]} && ${_SettingName.Find[TextEntry](exists)}
		{
			if ${Value.NotEqual[""]} && ${Int[${Value}]}>=0 && ${Int[${Value}]}<=9999
				UIElement[${_SettingName}@HudsFrame@CombatBotUI]:SetText[${Int[${Value}]}]
		}
		;${UIElement[SettingsAssistingCheckBox@SettingsFrame@CombatBotUI].Name.Left[8]}
	}
	method FaceNPC(int OnOff)
	{
		if ${OnOff}>0
		{
			FaceNPCNow:Set[TRUE]
		}
		elseif ${OnOff}==0
		{
			FaceNPCNow:Set[FALSE]
		}
	}
	method CastOn(string _CastName, string coCastTarget=FALSE, bool CastNow=FALSE)
	{
		variable string CastName
		CastName:Set[${_CastName.Replace[\",""]}]
		;echo CombatBot: Cast called for ${CastName} Target: ${coCastTarget} CastNow: ${CastNow}
		;ConvertAbility "${CastName}"
		variable int _ExportPosition
		_ExportPosition:Set[${ConvertAbilityObj.Convert["${CastName}"]}]
		strDoCastName:Set[${istrExport.Get[${_ExportPosition}]}]
		strDoCastID:Set[${istrExportID.Get[${_ExportPosition}]}]
		if ${_ExportPosition}>0 && ${Me.Ability[id,${strDoCastID}].IsReady}
		{
			boolCancelCast:Set[${CastNow}]
			if ${coCastTarget.Equal[${Me.Name}]}
			{
				strDoCastTarget:Set[${Me.ID}]
			}
			elseif ${Me.Raid}>0 && ${Me.Raid[${coCastTarget}](exists)}
			{
				;echo raid
				strDoCastTarget:Set[${Me.Raid[${coCastTarget}].ID}]
			}
			elseif ${Me.Group[${coCastTarget}](exists)}
			{
				;echo group
				strDoCastTarget:Set[${Me.Group[${coCastTarget}].ID}]
			}
			else
			{
				if ${CombatBotDebug}
					echo CombatBot: ${coCastTarget} Does not exist in your group or Raid
				return
			}
			boolItemCast:Set[FALSE]
			boolAbilityCast:Set[FALSE]
			strDoCastNameShort:Set["${CastName}"]
			DoCasting:Set[TRUE]
			DoCastingItem:Set[FALSE]
			if ${CastNow}
			{
				eq2execute cancel_spellcast
				eq2execute clearabilityqueue
			}
			;echo ${strDoCastID}
			;echo casting ${CastName} as ${strDoCastName} with ID ${strDoCastID} On ${strDoCastTarget}
		}
		elseif ${_ExportPosition}==0 && ${CombatBotDebug}
			echo CombatBot: ${CastName} Not found in Export File, Skipping
		elseif !${Me.Ability[id,${strDoCastID}].IsReady} && ${CombatBotDebug}
			echo CombatBot: ${CastName} Not Ready
	}
	method Cast(string _CastName, bool CastNow=FALSE)
	{
		variable string CastName
		CastName:Set[${_CastName.Replace[\",""]}]
		;echo ${CastName}
		;echo CombatBot: Cast called for ${CastName} CastNow: ${CastNow}
		;ConvertAbility "${CastName}"
		;echo ${CastName.Left[5]} // "${CastName.Right[-5]}"
		;echo if ${CastName.Left[5].Equal[Item:]} && ( ${Me.Equipment["${CastName.Right[-5]}"].TimeUntilReady}<0 || ${Me.Inventory["${CastName.Right[-5]}"].TimeUntilReady}<0 )
		if ${CastName.Left[5].Equal[Item:]} && ( ${Me.Equipment["${CastName.Right[-5]}"].TimeUntilReady}<0 || ${Me.Inventory["${CastName.Right[-5]}"].TimeUntilReady}<0 )
		{
			;echo TUR: ( ${Me.Equipment["${CastName.Right[-5]}"].TimeUntilReady}<=0 || ${Me.Inventory["${CastName.Right[-5]}"].TimeUntilReady}<=0 )
			;echo item
			boolCancelCast:Set[${CastNow}]
			strDoCastTarget:Set[FALSE]
			strDoCastNameShort:Set["${CastName}"]
			boolItemCast:Set[FALSE]
			boolAbilityCast:Set[FALSE]
			DoCasting:Set[TRUE]
			DoCastingItem:Set[TRUE]
			strDoCastName:Set[${CastName.Right[-5]}]
			;echo ${Me.Equipment["${CastName.Right[-5]}"](exists)}
			if ${Me.Equipment["${CastName.Right[-5]}"](exists)}
				ItemEquiped:Set[TRUE]
			else
				ItemEquiped:Set[FALSE]
			;echo ${ItemEquiped}
			;echo ${strDoCastName}
			return
		}
		variable int _ExportPosition
		_ExportPosition:Set[${ConvertAbilityObj.Convert["${CastName}"]}]
		strDoCastName:Set[${istrExport.Get[${_ExportPosition}]}]
		strDoCastID:Set[${istrExportID.Get[${_ExportPosition}]}]
		if ${_ExportPosition}>0 && ${Me.Ability[id,${strDoCastID}].IsReady}
		{
			boolCancelCast:Set[${CastNow}]
			strDoCastTarget:Set[FALSE]
			strDoCastNameShort:Set["${CastName}"]
			boolItemCast:Set[FALSE]
			boolAbilityCast:Set[FALSE]
			DoCasting:Set[TRUE]
			DoCastingItem:Set[FALSE]
			if ${CastNow}
			{
				eq2execute cancel_spellcast
				eq2execute clearabilityqueue
			}
			;echo casting ${CastName} as ${strDoCastName} with ID ${strDoCastID}
		}
		elseif ${_ExportPosition}==0 && ${CombatBotDebug}
			echo CombatBot: ${CastName} Not found in Export File, Skipping
		elseif !${Me.Ability[id,${strDoCastID}].IsReady} && ${CombatBotDebug}
			echo CombatBot: ${CastName} Not Ready
	}
	method Pause(int OnOff, int pauseRIM=0)
	{
		if ${OnOff}>0
		{
			UIElement[Pause@CombatBotMiniUI]:SetText[Resume]
			UIElement[PauseButton@BottomFrame@CombatBotUI]:SetText[Resume]
			CombatBotPaused:Set[TRUE]
			if ${pauseRIM}>0
				RI_CMD_PauseRIMovement 1
			Script:Pause
		}
		else
		{
			UIElement[Pause@CombatBotMiniUI]:SetText[Pause]
			UIElement[PauseButton@BottomFrame@CombatBotUI]:SetText[Pause]
			CombatBotPaused:Set[FALSE]
			RI_CMD_PauseRIMovement 0
			Script:Resume
		}
	}

	;still need to make this grey it out in the cast stack - DONE
	method ModifyCastStackAbiltiesListBoxItem(string AbilityName, bool Enabled)
	{
		if ${Int[${AbilityName}]}>0
		{
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
			{
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				{
					switch ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|]}
					{
						case Hostile
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FFFF8080]
							break
						}
						case NamedHostile
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FFFF0000]
							break
						}
						case InCombatTargeted
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF3F4591]
							break
						}
						case Power
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF5DA5CF]
							break
						}
						case Heal
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF00CD00]
							break
						}
						case Cure
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF8C5B00]
							break
						}
						case Res
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF992588]
							break
						}
						case Buff
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FFE8E200]
							break
						}
						case OutOfCombatBuff
						{
							UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF75753B]

							break
						}
					}
				}
				else
				{
					TimedCommand 1 RI_Obj_CB:TimedDisableFromCS[TRUE]
					UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
				}
			}
		}
		else
		{
			;echo param1: ${AbilityName} param2: ${EnableDisable}
			variable int tdaCount=0
			if ${Enabled}
			{
				;echo Enabling ${AbilityName}
				for(tdaCount:Set[1];${tdaCount}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items};tdaCount:Inc)
				{
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}].Value.Token[1,|].Equal[${AbilityName}]}
					{
						switch ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}].Value.Token[3,|]}
						{
							case Hostile
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FFFF8080]
								break
							}
							case NamedHostile
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FFFF0000]
								break
							}
							case InCombatTargeted
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF3F4591]
								break
							}
							case Power
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF5DA5CF]
								break
							}
							case Heal
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF00CD00]
								break
							}
							case Cure
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF8C5B00]
								break
							}
							case Res
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF992588]
								break
							}
							case Buff
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FFE8E200]
								break
							}
							case OutOfCombatBuff
							{
								UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF75753B]

								break
							}
						}
					}
				}
			}
			else
			{
				;echo Disabling ${AbilityName}
				for(tdaCount:Set[1];${tdaCount}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items};tdaCount:Inc)
				{
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}].Value.Token[1,|].Equal[${AbilityName}]}
					{
						;echo found ${Script.RunningTime}
						UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${tdaCount}]:SetTextColor[FF636363]
						;echo ${istrAbilityDisabled.Get[${tdaCount}]} ${Script.RunningTime}
					}
				}
			}
			
			;else
			;	echo CombatBot: Incorrect Paramaters, On=1 Off=0
		}
	}
	method CancelAllMaintained()
	{
		;echo Canceling all maint
		variable int i=0
		variable int j=0
		variable int MaintaintedCount=${Me.CountMaintained}
		MaintaintedCount:Set[${Me.CountMaintained}]
		for(i:Set[1];${i}<=${MaintaintedCount};i:Inc)
		{
			for(j:Set[1];${j}<=${istrExport.Used};j:Inc)
			{
				if ${Me.Maintained[${i}].Name.Equal[${istrExport.Get[${j}]}]}
				{
					Me.Maintained[${i}]:Cancel
					break
				}
			}
		}
	}
	method Debug(bool Enabled)
	{
		if ${Enabled}
		{
			CombatBotDebug:Set[TRUE]
		}
		else
		{
			CombatBotDebug:Set[FALSE]
		}
	}
	method CastingDebug(bool Enabled)
	{
		if ${Enabled}
		{
			CombatBotCastingDebug:Set[TRUE]
		}
		else
		{
			CombatBotCastingDebug:Set[FALSE]
		}
	}
	method ModifyCastStackAbilityType(string AbilityType, bool Enabled)
	{
		if ${Enabled}
		{
			switch ${AbilityType.Upper}
			{
				case CA
				case Hostile
				{
					;echo ISXRI: CombatBot: Enabling Hostile Abilities
					RI_Obj_CB:SetUISetting[SettingsCastHostileCheckBox,TRUE]
					break
				}
				case NamedCA
				case NamedHostile
				{
					;echo CombatBot: Enabling NamedHostile Abilities
					RI_Obj_CB:SetUISetting[SettingsCastNamedHostileCheckBox,TRUE]
					break
				}
				case Combat
				case InCombatTarget
				{
					;echo CombatBot: Enabling Combat Abilities
					RI_Obj_CB:SetUISetting[SettingsCastInCombatTargetCheckBox,TRUE]
					break
				}
				case Heal
				{
					;echo CombatBot: Enabling Heal Abilities
					RI_Obj_CB:SetUISetting[SettingsCastHealCheckBox,TRUE]
					break
				}
				case Power
				case PowerHeal
				{
					;echo CombatBot: Enabling Power Abilities
					RI_Obj_CB:SetUISetting[SettingsCastPowerCheckBox,TRUE]
					break
				}
				case Cure
				{
					;echo CombatBot: Enabling Cure Abilities
					RI_Obj_CB:SetUISetting[SettingsCastCureCheckBox,TRUE]
					break
				}
				case Buff
				{
					;echo CombatBot: Enabling Buff Abilities
					RI_Obj_CB:SetUISetting[SettingsCastBuffCheckBox,TRUE]
					break
				}
				case OutOfCombatBuff
				case NonCombatBuff
				{
					;echo CombatBot: Enabling OutOfCombatBuff Abilities
					RI_Obj_CB:SetUISetting[SettingsCastOutOfCombatBuffCheckBox,TRUE]
					break
				}
				case Res
				{
					;echo CombatBot: Enabling Res Abilities
					RI_Obj_CB:SetUISetting[SettingsCastResCheckBox,TRUE]
					break
				}
			}
		}
		else
		{
			switch ${AbilityType.Upper}
			{
				case CA
				case Hostile
				{
					;echo ISXRI: CombatBot: Enabling Hostile Abilities
					RI_Obj_CB:SetUISetting[SettingsCastHostileCheckBox,FALSE]
					break
				}
				case NamedCA
				case NamedHostile
				{
					;echo CombatBot: Enabling NamedHostile Abilities
					RI_Obj_CB:SetUISetting[SettingsCastNamedHostileCheckBox,FALSE]
					break
				}
				case Combat
				case InCombatTarget
				{
					;echo CombatBot: Enabling Combat Abilities
					RI_Obj_CB:SetUISetting[SettingsCastInCombatTargetCheckBox,FALSE]
					break
				}
				case Heal
				{
					;echo CombatBot: Enabling Heal Abilities
					RI_Obj_CB:SetUISetting[SettingsCastHealCheckBox,FALSE]
					break
				}
				case Power
				case PowerHeal
				{
					;echo CombatBot: Enabling Power Abilities
					RI_Obj_CB:SetUISetting[SettingsCastPowerCheckBox,FALSE]
					break
				}
				case Cure
				{
					;echo CombatBot: Enabling Cure Abilities
					RI_Obj_CB:SetUISetting[SettingsCastCureCheckBox,FALSE]
					break
				}
				case Buff
				{
					;echo CombatBot: Enabling Buff Abilities
					RI_Obj_CB:SetUISetting[SettingsCastBuffCheckBox,FALSE]
					break
				}
				case OutOfCombatBuff
				case NonCombatBuff
				{
					;echo CombatBot: Enabling OutOfCombatBuff Abilities
					RI_Obj_CB:SetUISetting[SettingsCastOutOfCombatBuffCheckBox,FALSE]
					break
				}
				case Res
				{
					;echo CombatBot: Enabling Res Abilities
					RI_Obj_CB:SetUISetting[SettingsCastResCheckBox,FALSE]
					break
				}
			}
		}
		;else
		;	echo CombatBot: Incorrect Paramaters, AbilityTypes=CA,NamedHostile,Combat,Heal,Power,Cure,Buff,OutOfCombatBuff,Res On=1 Off=0
	}
	member:string PrePostCastAbility1(int Item)
	{
		if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}](exists)}
		{
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|Before|](exists)}
			{
				return ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Left[${Math.Calc[${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|Before|]}-2]}]} 
			}
			else
			{
				return ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Left[${Math.Calc[${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|After|]}-2]}]} 
			}
		}
	}
	member:string PrePostCastAbility2(int Item)
	{
		if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}](exists)}
		{
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|Before|](exists)}
			{
				return ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Right[${Math.Calc[-1*(${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|Before|]}+8)]}]}  
			}
			else
			{
				return ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Right[${Math.Calc[-1*(${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|After|]}+7)]}]} 
			}
		}
	}
	member:bool PrePostCastBefore(int Item)
	{
		if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}](exists)}
		{
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Text.Find[|Before|](exists)}
			{
				return TRUE 
			}
			else
			{
				return FALSE
			}
		}
	}
	member:int PrePostCastAbility1ExportPosition(int Item)
	{
		if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}](exists)}
		{
			return ${Int[${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${Item}].Value}]}
		}
	}
	method AddOnEvents(string _OnEventsType, string _OnEventsCommand, bool _Disabled=FALSE)
	{
		;echo ${_OnEventsCommand.Escape}
		if ${_OnEventsType.NotEqual[NULL]} && ${_OnEventsCommand.NotEqual[NULL]} && ${_OnEventsType.NotEqual[""]} && ${_OnEventsCommand.NotEqual[""]}
		{
			if ( ${_OnEventsType.Equal[IncomingText]} || ${_OnEventsType.Equal[Announcement]} ) && !${_OnEventsCommand.Find[|]}
				return
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Item[${i}].Text.Equal["OnEvent:${_OnEventsType} Command:${_OnEventsCommand}"]}
					UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI]:RemoveItem[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI]:AddItem[OnEvent:${_OnEventsType} Command:"${_OnEventsCommand.Escape}",${_OnEventsType}|"${_OnEventsCommand.Escape}"]
			UIElement[OnEventsCommandTextEntry@OnEventsFrame@CombatBotUI]:SetText[""]
			if ${Disabled}
				UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
		}
	}
	method DisableOnEvents()
	{
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].SelectedItem(exists)}
		{
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI]:ClearSelection
		}
	}
	method RemoveOnEvents()
	{
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI]:RemoveItem[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].SelectedItem.ID}]
	}
	method AddPrePostCast(string FirstAbility, string SecondAbility, bool Before, bool Disabled=FALSE)
	{
		if ${FirstAbility.NotEqual[NULL]} && ${SecondAbility.NotEqual[NULL]} && ${FirstAbility.NotEqual[""]} && ${SecondAbility.NotEqual[""]}
		{
			variable string PPAbility
			PPAbility:Set[""]
			;echo ${Before}
			;echo${ConvertAbilityObj.Convert[""]}
			;for before need to convert ability 1 and add the export position as the value
			;for after need to convert ability 2 and add the export position as the value
			if ${Before}
			{
				PPAbility:Set["${FirstAbility}"]
				UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI]:AddItem[${FirstAbility} |Before| ${SecondAbility},${ConvertAbilityObj.Convert["${FirstAbility}"]}]
			}
			else
				UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI]:AddItem[${FirstAbility} |After| ${SecondAbility},${ConvertAbilityObj.Convert["${FirstAbility}"]}]
			if ${Disabled}
			{
				UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
			}
			UIElement[PrePostCastFirstAbilityListBox@PrePostCastFrame@CombatBotUI]:ClearSelection
			UIElement[PrePostCastSecondAbilityListBox@PrePostCastFrame@CombatBotUI]:ClearSelection
		}
	}
	method AddItem(string ItemName, string ItemEffect)
	{
		if ${ItemName.NotEqual[NULL]} && ${ItemName.NotEqual[""]} && ${ItemEffect.NotEqual[NULL]} && ${ItemEffect.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${i}].Text.Equal["${ItemName}"]}
					UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI]:RemoveItem[${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${i}].ID}]
			}
			;need to rewrite item maintained check routine to use the listbox -DONE
			UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI]:AddItem["${ItemName}","${ItemEffect}"]
			for(i:Set[1];${i}<=${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].Item[${i}].Text.Equal[${ItemName}]}
					UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI]:RemoveItem[${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI]:AddItem["Item:${ItemName}","${ItemEffect}"]
			for(i:Set[1];${i}<=${UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI].Item[${i}].Text.Equal["${ItemName}"]}
					UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI]:RemoveItem[${UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI]:AddItem["Item:${ItemName}","${ItemEffect}"]
		}
	}
	method AddAssist(string AssistName, bool Disabled=FALSE)
	{
		if ${AssistName.NotEqual[NULL]} && ${AssistName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Item[${i}].Text.Equal[${AssistName}]}
					UIElement[AssistAddedListBox@AssistFrame@CombatBotUI]:RemoveItem[${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[AssistAddedListBox@AssistFrame@CombatBotUI]:AddItem["${AssistName}"]
			UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:ClearSelection
			if ${Disabled}
				UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
		}
	}
	method AddCharmMob(string _CharmMobName, bool _Disabled=FALSE)
	{
		if ${_CharmMobName.NotEqual[NULL]} && ${_CharmMobName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Item[${i}].Text.Equal[${_CharmMobName}]}
					UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI]:RemoveItem[${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI]:AddItem["${_CharmMobName}"]
			if ${Disabled}
				UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].OrderedItem[${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
			UIElement[SubClassCharmMobsTextEntry@SubClassFrame@CombatBotUI]:SetText[""]
		}
	}
	method EnableDisableListBoxItem(string _ListBoxName, string _ListBoxItem, int _EnableDisableToggle)
	{
		
		if ${Int[${_ListBoxItem}]}>0
		{
			if ${_EnableDisableToggle}==-1
			{
				if ${UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${Int[${_ListBoxItem}]}].TextColor}==-10263709
					UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${Int[${_ListBoxItem}]}]:SetTextColor[FFF9F099]
				else
					UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${Int[${_ListBoxItem}]}]:SetTextColor[FF636363]
			}
			else
			{
				if ${_EnableDisableToggle}==1
					UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${Int[${_ListBoxItem}]}]:SetTextColor[FFF9F099]
				else
					UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${Int[${_ListBoxItem}]}]:SetTextColor[FF636363]
			}
			UIElement[${_ListBoxName}@CombatBotUI]:ClearSelection
		}
		elseif ${_ListBoxItem.NotEqual[0]}
		{
			variable int _count
			for(_count:Set[1];${_count}<=${UIElement[${_ListBoxName}@CombatBotUI].Items};_count:Inc)
			{
				if ${UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${_count}].Text.Equal[${_ListBoxItem}]}
				{
					if ${_EnableDisableToggle}==-1
					{
						if ${UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${_count}].TextColor}==-10263709
							UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${_count}]:SetTextColor[FFF9F099]
						else
							UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${_count}]:SetTextColor[FF636363]
					}
					else
					{
						if ${_EnableDisableToggle}==1
							UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${_count}]:SetTextColor[FFF9F099]
						else
							UIElement[${_ListBoxName}@CombatBotUI].OrderedItem[${_count}]:SetTextColor[FF636363]
					}
					UIElement[${_ListBoxName}@CombatBotUI]:ClearSelection
				}
			}
		}
	}
	
	method AddAnnounce(string AnnounceName, string AnnounceTarget, string Announcement, bool Disabled=FALSE)
	{
		;echo add anounce
		variable string temp
		if ${AnnounceTarget.Equal[Tell]} && ${Announcement.Left[8].NotEqual[*Target*]}
			return
			
		temp:Set["${AnnounceName}|${AnnounceTarget}|${Announcement}"]
		;echo ${temp}
		if ${AnnounceName.NotEqual[NULL]} && ${AnnounceName.NotEqual[""]} && ${AnnounceTarget.NotEqual[NULL]} && ${AnnounceTarget.NotEqual[""]} && ${Announcement.NotEqual[NULL]} && ${Announcement.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].Item[${i}].Text.Equal["Announce: ${Announcement} For ${AnnounceName} To ${AnnounceTarget}"]}
					UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI]:RemoveItem[${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].Item[${i}].ID}]
			}
			;echo here
			UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI]:AddItem["Announce: ${Announcement} For ${AnnounceName} To ${AnnounceTarget}","${temp}"]
			;UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI]:ClearSelection
			if ${Disabled}
				UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
		}
	}
	method DisableAnnounce()
	{
		if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].SelectedItem(exists)}
		{
			if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI]:ClearSelection
		}
	}
	method RemoveAnnounce()
	{
		if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI]:RemoveItem[${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].SelectedItem.ID}]
	}
	method RemoveAssist()
	{
		if ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[AssistAddedListBox@AssistFrame@CombatBotUI]:RemoveItem[${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].SelectedItem.ID}]
	}
	method RemoveItem()
	{
		if ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI]:RemoveItem[${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].SelectedItem.ID}]
	}
	method DisableAlias()
	{
		if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem(exists)}
		{
			if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI]:ClearSelection
		}
	}
	method DisableAssist()
	{
		if ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].SelectedItem(exists)}
		{
			if ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			UIElement[AssistAddedListBox@AssistFrame@CombatBotUI]:ClearSelection
		}
	}
	method DisablePrePostCast()
	{
		if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].SelectedItem(exists)}
		{
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI]:ClearSelection
		}
	}
	method DisableInvisAbility()
	{
		if ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].SelectedItem(exists)}
		{
			if ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].SelectedItem.TextColor}==-10263709
				UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI]:ClearSelection
		}
	}
	method RemovePrePostCast()
	{
		if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI]:RemoveItem[${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].SelectedItem.ID}]
	}
	method GetEligibleCharms()
	{
		;GetCharms:Set[TRUE]
		RI_CMD_Hidden_GetCharms
	}
	method GetEligibleItems()
	{
		;GetItems:Set[TRUE]
		RI_CMD_Hidden_GetItems
	}
	method SetCSL()
	{
		istrAbilityLBID:Clear
		variable int count=0
		;copy ID to istristrAbilityLBID
		for(count:Set[1];${count}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items};count:Inc)
		{
			istrAbilityLBID:Insert[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${count}].ID}]
		}
	}
	method LoadCastStack()
	{	
		; variable int count=0
		;;populate CSL
		; UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI]:ClearItems
		; for(count:Set[1];${count}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items};count:Inc)
		; {
			;;echo adding ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}
			; RI_Obj_CB:AddItemToCastStackAbiltiesListBox[${count}]
		; }
		; This:SetCSL
	}
	method TypeSelect()
	{
		if ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[InCombatTargeted]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Hostile]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[NamedHostile]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Buff]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[OutOfCombatBuff]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Res]}
		{
			UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
		}
		if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[5].Equal[Item:]} && ( ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Buff]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[OutOfCombatBuff]} )
		{
			UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
		}
		if ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[InCombatTargeted]}
		{
			UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show
		}
		if ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Hostile]} || ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[NamedHostile]}
		{
			UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
		}
	}
	method CastStackClick()
	{
		if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
		{
			; if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[12].Equal[Summon Mount]}
			; {	
				; UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Show
				; UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Show
				; UIElement[Add@CastStackFrame@CombatBotUI]:Show
				; UIElement[Edit@CastStackFrame@CombatBotUI]:Show
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Buff]
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[OutOfCombatBuff]
				; return
			; }
			;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value}
			;echo AllowRaid: ${istrExportAllowRaid[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} CastingTime: ${istrExportCastingTime[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} DissonanceCost: ${istrExportDissonanceCost[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} DoesNotExpire: ${istrExportDoesNotExpire[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} ID: ${istrExportID[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsPCCure: ${istrExportISPCCure[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsABuff: ${istrExportIsABuff[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsAE: ${istrExportIsAE[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsAEncounterHostile: ${istrExportIsAEncounterHostile[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsASingleTargetBeneficial: ${istrExportIsASingleTargetBeneficial[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsASingleTargetHostile: ${istrExportIsASingleTargetHostile[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsBeneficial: ${istrExportIsBeneficial[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsGroupAbility: ${istrExportIsGroupAbility[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsOtherGroupAbility: ${istrExportIsOtherGroupAbility[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} 
			;echo IsPCCureCurse: ${istrExportIsPCCureCurse[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsPetAbility: ${istrExportIsPetAbility[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsRaidAbility: ${istrExportIsRaidAbility[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsRes: ${istrExportIsRes[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsSelfAbility: ${istrExportIsSelfAbility[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} IsSingleTargetAbility: ${istrExportIsSingleTargetAbility[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} Level: ${istrExportLevel[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} List: ${istrExportList[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} ListPosition: ${istrExportListPosition[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} MaxAOETargets: ${istrExportMaxAOETargets[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} MaxDuration: ${istrExportMaxDuration[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} MaxRange: ${istrExportMaxRange[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} ReqFlanking: ${istrExportReqFlanking[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} ReqStealth: ${istrExportReqStealth[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} SavageryCost: ${istrExportSavageryCost[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]} SpellBookType: ${istrExportSpellBookType[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]}	This:ClearOptions
			variable string temp
			variable int IndexPosition
			variable int ExportPosition
			UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:Hide
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
			{
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Show
				UIElement[Add@CastStackFrame@CombatBotUI]:Show
				UIElement[Edit@CastStackFrame@CombatBotUI]:Show
				;echo CSC --${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[5]}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[5].Equal[Item:]}
				{
					;echo item
					UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:Show
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| RIE"](exists)}
					{
						;echo RIE
						UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:SetChecked
					}
					else
					{
						;echo no rie
						UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:UnsetChecked
					}
				}
				IndexPosition:Set[0]
				;echo ${IndexPosition}
				ExportPosition:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]
				;echo ${ExportPosition}
				;echo ${istrExport.Get[${ExportPosition}]}
				;echo ${istrAbilities.Get[${IndexPosition}]} / ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|]}
				
				This:CastStackExportAbilitiesListBoxClick["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value}",${ExportPosition},TRUE]
				
				;set the type
				;temp:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| Target: "]}]
				temp:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Right[${Math.Calc[-1*(${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| Type: "]}+7)]}]}]
				;echo ${temp}
				;temp:Set[${temp.Left[${Math.Calc[-1*(${temp.Length}-${temp.Find[" "]})]}]}]
				;echo | Type:${temp}
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:SelectItem[${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].ItemByText[${temp}].ID}]
		
				if ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]}>0
				{
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| SD"](exists)}
					{
						;echo ID
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:SetChecked
					}
				}
				else
				{
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
				}
				if ${istrExportIsAEncounterHostile.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]}
				{
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Show
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| SE"](exists)}
					{
						;echo IE
						UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:SetChecked
					}
				}
				else
				{
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				}
				if ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} && ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[FALSE]} && ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]}
				{
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Show
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| SAE"](exists)}
						UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:SetChecked
				}
				else
				{
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
				}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Hostile]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[NamedHostile]} 
				{
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| MAX"](exists)}
						UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:SetChecked
				}
				else
				{
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
				}
				if ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} || ${istrExportMaxAOETargets.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]}>0 || ( ${istrExportIsGroupAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} && ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} )
				{
					if ${istrExportIsABuff.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].NotEqual[TRUE]} && ${istrExportIsSingleTargetAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].NotEqual[TRUE]}
;					&& ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].NotEqual[InCombatTargeted]}
					{
						;echo showing the elements
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| #="](exists)}
					{
						;echo here
						temp:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Right[${Math.Calc[-1*(${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| #="]}+3)]}]}]
						;echo ${temp}
						temp:Set[${temp.Left[${Math.Calc[-1*(${temp.Length}-${temp.Find[" "]})]}]}]
						;echo | #=${temp}
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:SetText[${temp}]
					}
				}
				else
				{
				;echo ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} || ${istrExportMaxAOETargets.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]}>0 || ( ${istrExportIsGroupAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} && ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[TRUE]} )
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
				}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Heal]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Power]}
				{
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| %="](exists)}
					{
						temp:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Right[${Math.Calc[-1*(${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| %="]}+3)]}]}]
						;echo ${temp.Find[" "]}
						temp:Set[${temp.Left[${Math.Calc[-1*(${temp.Length}-${temp.Find[" "]})]}]}]
						;echo | %=${temp}
						UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:SetText["${temp}"]
					}
				}
				else
				{
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
				}
				if ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Buff]} && ${istrExportIsGroupAbility.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsSelfAbility.Get[${ExportPosition}].NotEqual[TRUE]} ) || ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Cure]} && ${istrExportIsGroupAbility.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsSelfAbility.Get[${ExportPosition}].NotEqual[TRUE]} ) || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Res]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[InCombatTargeted]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[Heal]}
				{
					;echo ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}]}
					if ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[2,|]}].Equal[FALSE]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[InCombatTargeted]}
					{
						UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
					}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| Target: "](exists)}
					{
						;temp:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| Target: "]}]
						temp:Set[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Right[${Math.Calc[-1*(${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Find["| Target: "]}+9)]}]}]
						;echo ${temp.Find[" "]}
						temp:Set[${temp.Left[${Math.Calc[-1*(${temp.Length}-${temp.Find[" "]})]}]}]
						;echo | Target:${temp}
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:SelectItem[${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].ItemByText[${temp}].ID}]
					}
				}
				else
				{
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
				}
				;if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[3,|].Equal[InCombatTargeted]}
				;{
				;	UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
				;	UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
				;}
			}
			else
			{
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[Add@CastStackFrame@CombatBotUI]:Hide
				UIElement[Edit@CastStackFrame@CombatBotUI]:Hide
			}
		}
	}
	method AddCastStackAbilitiesListBoxItem(string _AbilityDisabled, string _AbilityName, int _ExportPosition, string _Type, string _Target, string _%, string _#, string _SD, string _SE, string _SAE, string _RIE , string _MAX, int _Savagery, int _DissonanceLess,int _DissonanceGreater)
	{
		variable string temp=""
		temp:Set["${_AbilityName}"]
		if ${_SD.Equal[TRUE]}
			temp:Concat[" | SD"]
		if ${_SE.Equal[TRUE]}
			temp:Concat[" | SE"]
		if ${_SAE.Equal[TRUE]}
			temp:Concat[" | SAE"]
		if ${_RIE.Equal[TRUE]}
			temp:Concat[" | RIE"]
		if ${_#.NotEqual[FALSE]}
		{
			if ${_#}>0
				temp:Concat[" | #=${_#}"]
		}
		if ${_%.NotEqual[FALSE]}>0
		{
			if ${_%}>0
				temp:Concat[" | %=${_%}"]
		}
		if ${_MAX.Equal[TRUE]}
			temp:Concat[" | Max"]
		if ${RI_Var_String_MySubClass.Equal[beastlord]}
		{
			if ${_Savagery}>0
				temp:Concat[" | SAV=${_Savagery}"]
		}
		if ${RI_Var_String_MySubClass.Equal[channeler]}
		{
			if ${_DissonanceLess}>0
				temp:Concat[" | D<=${_DissonanceLess}"]
			if ${_DissonanceGreater}>0
				temp:Concat[" | D>=${_DissonanceGreater}"]
		}
		if ${_Target.NotEqual[FALSE]}
			temp:Concat[" | Target: ${_Target}"]
		temp:Concat[" | Type: ${_Type}"]
		
		variable string tempcolor
		switch ${_Type}
		{
			case Hostile
			{
				tempcolor:Set[FFFF8080]
				break
			}
			case NamedHostile
			{
				tempcolor:Set[FFFF0000]
				break
			}
			case InCombatTargeted
			{
				tempcolor:Set[FF3F4591]
				break
			}
			case Power
			{
				tempcolor:Set[FF5DA5CF]
				break
			}
			case Heal
			{
				tempcolor:Set[FF00CD00]
				break
			}
			case Cure
			{
				tempcolor:Set[FF8C5B00]
				break
			}
			case Res
			{
				tempcolor:Set[FF992588]
				break
			}
			case Buff
			{
				tempcolor:Set[FFE8E200]
				break
			}
			case OutOfCombatBuff
			{
				tempcolor:Set[FF75753B]

				break
			}
		}
		if ${_AbilityDisabled.Equal[TRUE]}
			UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI]:AddItem["${temp}","${_AbilityName}|${_ExportPosition}|${_Type}|${_Target}|${_%}|${_#}|${_SD}|${_SE}|${_SAE}|${_RIE}|${_MAX}|${_Savagery}|${_DissonanceLess}|${_DissonanceGreater}",FF636363]
		else
			UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI]:AddItem["${temp}","${_AbilityName}|${_ExportPosition}|${_Type}|${_Target}|${_%}|${_#}|${_SD}|${_SE}|${_SAE}|${_RIE}|${_MAX}|${_Savagery}|${_DissonanceLess}|${_DissonanceGreater}",${tempcolor}]
		;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}]} -- ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}].Value}
		
		
		;if ${_AbilityDisabled.Equal[TRUE]}
		;{
			;UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
			;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}].TextColor}
		;}
	}
	method CastStackAddAbility()
	{
		variable bool GoodToGo
		GoodToGo:Set[TRUE]
		if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
		{
			; if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Summon Mount]}
			; {
				; variable string _strAbilityType2
				; _strAbilityType2:Set[""]
				; _strAbilityType2:Set[${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem}]
				; This:AddCastStackAbilitiesListBoxItem[FALSE,Summon Mount,0,${_strAbilityType2},FALSE,0,0,FALSE,FALSE,FALSE,FALSE,FALSE,0,0,0]
				; return 
			; }
			;echo theres a selected item
			
			if ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
			{
				;echo CastStackTypeComboBox Item exists
				noop
			}
			else
			{
				GoodToGo:Set[FALSE]
			}
			if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Visible}
			{
				;echo CastStackTargetComboBox visible
				if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
				{
					;echo CastStackTargetComboBox Item exists
					noop
				}
				else
				{
					GoodToGo:Set[FALSE]
				}
			}
			if ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackRequired#TextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackRequired#TextEntry text
					;GoodToGo:Set[FALSE]
				}
				;echo CastStackRequired#TextEntry visible
			}
			if ${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStack%TextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStack%TextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStack%TextEntry visible
			}
			if ${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackSavageryTextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackSavageryTextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStackSavageryTextEntry visible
			}
			if ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]} || ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackDissonanceLessTextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackDissonanceLessTextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStackDissonanceLessTextEntry visible
			}
			if ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]} || ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackDissonanceGreaterTextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackDissonanceGreaterTextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStackDissonanceGreaterTextEntry visible
			}
			; if ${UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipDurationCheckBox visible
			; if ${UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackRequiresMaxIncrementsCheckBox visible
			; if ${UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipEncounterCheckBox visible
			; if ${UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipAECheckBox visible
			; if ${UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipEncounterCheckBox visible
			if ${GoodToGo}
			{
				variable string _strAbilityDisabled
				variable string _strAbilityName
				variable string _strAbilityExportPosition
				variable string _strAbilityType
				variable string _strAbilityTarget
				variable string _strAbility%
				variable string _strAbility#
				variable string _strAbilityIgnoreDuration
				variable string _strAbilityIE
				variable string _strAbilityIAE
				variable string _strAbilityRIE
				variable string _strAbilityMAXer
				variable string _strAbilitySavagery
				variable string _strAbilityDissonanceLess
				variable string _strAbilityDissonanceGreater
				
				_strAbilityDisabled:Set[""]
				_strAbilityName:Set[""]
				_strAbilityExportPosition:Set[""]
				_strAbilityType:Set[""]
				_strAbilityTarget:Set[""]
				_strAbility%:Set[""]
				_strAbility#:Set[""]
				_strAbilityIgnoreDuration:Set[""]
				_strAbilityIE:Set[""]
				_strAbilityIAE:Set[""]
				_strAbilityRIE:Set[""]
				_strAbilityMAXer:Set[""]
				_strAbilitySavagery:Set[""]
				_strAbilityDissonanceLess:Set[""]
				_strAbilityDissonanceGreater:Set[""]
				
				_strAbilityName:Set["${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem}"]
				_strAbilityType:Set[${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem}]
				if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Visible}
					_strAbilityTarget:Set[${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].SelectedItem}]
				else
					_strAbilityTarget:Set[FALSE]
				if ${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Visible}
					_strAbility%:Set[${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbility%:Set[0]
				if ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Visible} && ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
					_strAbility#:Set[${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbility#:Set[0]
				_strAbilityIgnoreDuration:Set[${UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI].Checked}]
				_strAbilityIE:Set[${UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI].Checked}]
				_strAbilityIAE:Set[${UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI].Checked}]
				;needs to be modified when i add items
				if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[5].Equal[Item:]}
				{
					_strAbilityRIE:Set[${UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI].Checked}]
					_strAbilityExportPosition:Set[0]
				}
				else
				{
					_strAbilityRIE:Set[FALSE]
					_strAbilityExportPosition:Set[${ConvertAbilityObj.Convert[${_strAbilityName}]}]
				}
				
				_strAbilityDisabled:Set[FALSE]
				;echo ${UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI].Checked}
				_strAbilityMAXer:Set[${UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI].Checked}]
				;echo ${_strAbilityMAXer}
				if ${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Visible}
					_strAbilitySavagery:Set[${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbilitySavagery:Set[0]
				if ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Visible} && ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
					_strAbilityDissonanceLess:Set[${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbilityDissonanceLess:Set[0]
				if ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Visible} && ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
					_strAbilityDissonanceGreater:Set[${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbilityDissonanceGreater:Set[0]	
				;add to caststack listbox
				;(string _AbilityDisabled, string _AbilityName, int _ExportPosition, string _Type, string _Target, string _%, string _#, string _SD, string _SE, string _SAE, string _RIE , string _MAX, int _Savagery, int _DissonanceLess,int _DissonanceGreater)
				This:AddCastStackAbilitiesListBoxItem[${_strAbilityDisabled},"${_strAbilityName}",${_strAbilityExportPosition},${_strAbilityType},${_strAbilityTarget},${_strAbility%},${_strAbility#},${_strAbilityIgnoreDuration},${_strAbilityIE},${_strAbilityIAE},${_strAbilityRIE},${_strAbilityMAXer},${_strAbilitySavagery},${_strAbilityDissonanceLess},${_strAbilityDissonanceGreater}]
			}
			else
				noop
				;echo somethings missing
		}
	}
	method CastStackEditAbility(int OrderedItem=-1)
	{
		;echo ${OrderedItem}
		; if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equal[Summon Mount]}
		; {
			; variable string _strAbilityType2
			; _strAbilityType2:Set[""]
			; _strAbilityType2:Set[${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem}]
			; This:EditCastStackAbilitiesListBoxItem[FALSE,Summon Mount,0,${_strAbilityType2},FALSE,0,0,FALSE,FALSE,FALSE,FALSE,FALSE,0,0,0]
			; return
		; }
		if ${OrderedItem}==-1 && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
			return
		OrderedItem:Inc
		;echo ${OrderedItem}
		variable bool GoodToGo
		GoodToGo:Set[TRUE]
		if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
		{
			;echo theres a selected item
			if ${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
			{
				;echo CastStackTypeComboBox Item exists
				noop
			}
			else
			{
				GoodToGo:Set[FALSE]
			}
			if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Visible}
			{
				;echo CastStackTargetComboBox visible
				if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].SelectedItem(exists)}
				{
					;echo CastStackTargetComboBox Item exists
					noop
				}
				else
				{
					GoodToGo:Set[FALSE]
				}
			}
			if ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackRequired#TextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackRequired#TextEntry text
					;GoodToGo:Set[FALSE]
				}
				;echo CastStackRequired#TextEntry visible
			}
			if ${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStack%TextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStack%TextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStack%TextEntry visible
			}
			if ${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackSavageryTextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackSavageryTextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStackSavageryTextEntry visible
			}
			if ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackDissonanceLessTextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackDissonanceLessTextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStackDissonanceLessTextEntry visible
			}
			if ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Visible}
			{
				if ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
				{
					;echo CastStackDissonanceGreaterTextEntry text exists
					noop
				}
				else
				{
					;echo Missing CastStackDissonanceGreaterTextEntry text
					GoodToGo:Set[FALSE]
				}
				;echo CastStackDissonanceGreaterTextEntry visible
			}
			; if ${UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipDurationCheckBox visible
			; if ${UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackRequiresMaxIncrementsCheckBox visible
			; if ${UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipEncounterCheckBox visible
			; if ${UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipAECheckBox visible
			; if ${UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI].Visible}
				; echo CastStackSkipEncounterCheckBox visible
			if ${GoodToGo}
			{
				variable string _strAbilityDisabled
				variable string _strAbilityName
				variable string _strAbilityExportPosition
				variable string _strAbilityType
				variable string _strAbilityTarget
				variable string _strAbility%
				variable string _strAbility#
				variable string _strAbilityIgnoreDuration
				variable string _strAbilityIE
				variable string _strAbilityIAE
				variable string _strAbilityRIE
				variable string _strAbilityMAXer
				variable string _strAbilitySavagery
				variable string _strAbilityDissonanceLess
				variable string _strAbilityDissonanceGreater
				
				_strAbilityDisabled:Set[""]
				_strAbilityName:Set[""]
				_strAbilityExportPosition:Set[""]
				_strAbilityType:Set[""]
				_strAbilityTarget:Set[""]
				_strAbility%:Set[""]
				_strAbility#:Set[""]
				_strAbilityIgnoreDuration:Set[""]
				_strAbilityIE:Set[""]
				_strAbilityIAE:Set[""]
				_strAbilityRIE:Set[""]
				_strAbilityMAXer:Set[""]
				_strAbilitySavagery:Set[""]
				_strAbilityDissonanceLess:Set[""]
				_strAbilityDissonanceGreater:Set[""]
				
				_strAbilityName:Set["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Value.Token[1,|]}"]
				_strAbilityType:Set[${UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI].SelectedItem}]
				if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Visible}
					_strAbilityTarget:Set[${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].SelectedItem}]
				else
					_strAbilityTarget:Set[FALSE]
				if ${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Visible}
					_strAbility%:Set[${UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbility%:Set[0]
				if ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Visible} && ${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Text.NotEqual[""]}
					_strAbility#:Set[${UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbility#:Set[0]
				_strAbilityIgnoreDuration:Set[${UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI].Checked}]
				_strAbilityIE:Set[${UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI].Checked}]
				_strAbilityIAE:Set[${UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI].Checked}]
				;needs to be modified when i add items
				;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[5]}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Left[5].Equal[Item:]}
				{
					
					_strAbilityRIE:Set[${UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI].Checked}]
					_strAbilityExportPosition:Set[0]
					;echo setting RIE: to: ${UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI].Checked} it is now ${_strAbilityRIE}
				}
				else
				{
					_strAbilityRIE:Set[FALSE]
					_strAbilityExportPosition:Set[${ConvertAbilityObj.Convert[${_strAbilityName}]}]
				}
				
				_strAbilityDisabled:Set[FALSE]
				;echo ${UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI].Checked}
				_strAbilityMAXer:Set[${UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI].Checked}]
				;echo ${_strAbilityMAXer}
				if ${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Visible}
					_strAbilitySavagery:Set[${UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbilitySavagery:Set[0]
				if ${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Visible}
					_strAbilityDissonanceLess:Set[${UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbilityDissonanceLess:Set[0]
				if ${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Visible}
					_strAbilityDissonanceGreater:Set[${UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI].Text}]
				else
					_strAbilityDissonanceGreater:Set[0]	
				;add to caststack listbox
				;(string _AbilityDisabled, string _AbilityName, int _ExportPosition, string _Type, string _Target, string _%, string _#, string _SD, string _SE, string _SAE, string _RIE , string _MAX, int _Savagery, int _DissonanceLess,int _DissonanceGreater)
				This:EditCastStackAbilitiesListBoxItem[${_strAbilityDisabled},"${_strAbilityName}",${_strAbilityExportPosition},${_strAbilityType},${_strAbilityTarget},${_strAbility%},${_strAbility#},${_strAbilityIgnoreDuration},${_strAbilityIE},${_strAbilityIAE},${_strAbilityRIE},${_strAbilityMAXer},${_strAbilitySavagery},${_strAbilityDissonanceLess},${_strAbilityDissonanceGreater}]
				;echo This:EditCastStackAbilitiesListBoxItem[_strAbilityDisabled=${_strAbilityDisabled},_strAbilityName=${_strAbilityName},_strAbilityExportPosition=${_strAbilityExportPosition},_strAbilityType=${_strAbilityType},_strAbilityTarget=${_strAbilityTarget},_strAbility%=${_strAbility%},_strAbility#=${_strAbility#},_strAbilityIgnoreDuration=${_strAbilityIgnoreDuration},_strAbilityIE=${_strAbilityIE},_strAbilityIAE=${_strAbilityIAE},_strAbilityRIE=${_strAbilityRIE},_strAbilityMAXer=${_strAbilityMAXer},_strAbilitySavagery=${_strAbilitySavagery},_strAbilityDissonanceLess=${_strAbilityDissonanceLess},_strAbilityDissonanceGreater=${_strAbilityDissonanceGreater}]
			}
			else
				noop
				;echo somethings missing
		}
	}
	method EditCastStackAbilitiesListBoxItem(string _AbilityDisabled, string _AbilityName, int _ExportPosition, string _Type, string _Target, string _%, string _#, string _SD, string _SE, string _SAE, string _RIE, string _MAX, int _Savagery, int _DissonanceLess,int _DissonanceGreater, int OrderedItem)
	{
		;echo EditCastStackAbilitiesListBoxItem(string _AbilityDisabled=${_AbilityDisabled}, string _AbilityName=${_AbilityName}, int _ExportPosition=${_ExportPosition}, string _Type=${_Type}, string _Target=${_Target}, string _%=${_%}, string _#=${_#}, string _SD=${_SD}, string _SE=${_SE}, string _SAE=${_SAE}, string _RIE=${_RIE}, string _MAX=${_MAX}, int _Savagery=${_Savagery}, int _DissonanceLess=${_DissonanceLess},int _DissonanceGreater=${_DissonanceGreater}, int OrderedItem=${OrderedItem})
		variable string temp=""
		temp:Set["${_AbilityName}"]
		if ${_SD.Equal[TRUE]}
			temp:Concat[" | SD"]
		if ${_SE.Equal[TRUE]}
			temp:Concat[" | SE"]
		if ${_SAE.Equal[TRUE]}
			temp:Concat[" | SAE"]
		if ${_RIE.Equal[TRUE]}
			temp:Concat[" | RIE"]
		if ${_#.NotEqual[FALSE]}
		{
			if ${_#}>0
				temp:Concat[" | #=${_#}"]
		}
		if ${_%.NotEqual[FALSE]}>0
		{
			if ${_%}>0
				temp:Concat[" | %=${_%}"]
		}
		if ${_MAX.Equal[TRUE]}
			temp:Concat[" | Max"]
		if ${RI_Var_String_MySubClass.Equal[beastlord]}
		{
			if ${_Savagery}>0
				temp:Concat[" | SAV=${_Savagery}"]
		}
		if ${RI_Var_String_MySubClass.Equal[channeler]}
		{
			if ${_DissonanceLess}>0
				temp:Concat[" | D<=${_DissonanceLess}"]
			if ${_DissonanceGreater}>0
				temp:Concat[" | D>=${_DissonanceGreater}"]
		}
		if ${_Target.NotEqual[FALSE]}
			temp:Concat[" | Target: ${_Target}"]
		temp:Concat[" | Type: ${_Type}"]
		
		UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetText["${temp}"]
		UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetValue["${_AbilityName}|${_ExportPosition}|${_Type}|${_Target}|${_%}|${_#}|${_SD}|${_SE}|${_SAE}|${_RIE}|${_MAX}|${_Savagery}|${_DissonanceLess}|${_DissonanceGreater}"]
		;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}]} -- ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}].Value}
		
		switch ${_Type}
		{
			case Hostile
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FFFF8080]
				break
			}
			case NamedHostile
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FFFF0000]
				break
			}
			case InCombatTargeted
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF3F4591]
				break
			}
			case Power
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF5DA5CF]
				break
			}
			case Heal
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF00CD00]
				break
			}
			case Cure
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF8C5B00]
				break
			}
			case Res
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF992588]
				break
			}
			case Buff
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FFE8E200]
				break
			}
			case OutOfCombatBuff
			{
				UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF75753B]

				break
			}
		}
		if ${_AbilityDisabled.Equal[TRUE]}
		{
			UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].SelectedItem:SetTextColor[FF636363]
			;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Item[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}].TextColor}
		}
	}
	method LoadExport()
	{	
		variable int count2=0
		for(count2:Set[1];${count2}<=${istrExportList.Used};count2:Inc)
		{
			;echo Index ${count2}: ${istrExportList.Get[${count2}]} Position: ${istrExportListPosition.Get[${count2}]} : ExportName: ${istrExport.Get[${istrExportListPosition.Get[${count2}]}]} Level: ${istrExportLevel.Get[${istrExportListPosition.Get[${count2}]}]}
			UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI]:AddItem[${istrExportList.Get[${count2}]},${istrExportListPosition.Get[${count2}]}]
			UIElement[InvisAbilitiesAbilityListBox@InvisAbilitiesFrame@CombatBotUI]:AddItem[${istrExportList.Get[${count2}]},${istrExportListPosition.Get[${count2}]}]
			UIElement[PrePostCastFirstAbilityListBox@PrePostCastFrame@CombatBotUI]:AddItem[${istrExportList.Get[${count2}]},${istrExportListPosition.Get[${count2}]}]
			UIElement[PrePostCastSecondAbilityListBox@PrePostCastFrame@CombatBotUI]:AddItem[${istrExportList.Get[${count2}]},${istrExportListPosition.Get[${count2}]}]
			UIElement[AnnounceAbilityListBox@AnnounceFrame@CombatBotUI]:AddItem[${istrExportList.Get[${count2}]},${istrExportListPosition.Get[${count2}]}]
		}
	}
	method AddAlias(string AliasName, string AliasFor, bool Disabled=FALSE)
	{
		if ${AliasName.NotEqual[NULL]} && ${AliasFor.NotEqual[NULL]} && ${AliasName.NotEqual[""]} && ${AliasFor.NotEqual[""]}
		{
			UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI]:AddItem[${AliasName} For: ${AliasFor},${AliasFor}]
			UIElement[AliasesAliasNameTextEntry@AliasesFrame@CombatBotUI]:SetText[""]
			UIElement[AliasesAliasForTextEntry@AliasesFrame@CombatBotUI]:SetText[""]
			UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:ClearSelection
			UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:SetFocus
			if ${Disabled}
			{
				UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
			}
		}
	}
	method AliasListClick()
	{
		if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem(exists)}
		{
			UIElement[AliasesAliasNameTextEntry@AliasesFrame@CombatBotUI]:SetText[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem.Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem.Text.Find[" For"]}-1]}]}]
			UIElement[AliasesAliasForTextEntry@AliasesFrame@CombatBotUI]:SetText[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem.Value}]
			UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:ClearSelection
		}
	}
	method AddInvisAbility(string AbilityName, bool Disabled=FALSE)
	{
		if ${AbilityName.NotEqual[NULL]}
		{
			;echo ${AbilityName}
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Item[${i}].Text.Equal[${AbilityName}]}
					UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI]:RemoveItem[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI]:AddItem["${AbilityName}",${ConvertAbilityObj.Convert["${AbilityName}"]}]
			if ${Disabled}
			{
				UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Items}]:SetTextColor[FF636363]
			}
		}
	}
	method RemoveInvisAbility()
	{
		if ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI]:RemoveItem[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].SelectedItem.ID}]
	}
	method RemoveAlias()
	{
		if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem(exists)}
			UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI]:RemoveItem[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].SelectedItem.ID}]
	}
	method AliasesLoadRaidGroupList()
	{
		UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:ClearItems
		variable int i=0
		if ${Me.Raid}>0
		{
			for(i:Set[1];${i}<=${Me.Raid};i:Inc)
				UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:AddItem[${Me.Raid[${i}].Name}]
		}
		else	
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
				UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:AddItem[${Me.Group[${i}].Name}]
		}
	}
	method LoadRaidGroupList()
	{
		UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:ClearItems
		UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:ClearItems
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:ClearItems
		variable int i=0
		if ${Me.Raid}>0
		{
			for(i:Set[1];${i}<=${Me.Raid};i:Inc)
			{
				if !${UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI].ItemByText[${Me.Raid[${i}]}](exists)}
					UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:AddItem[${Me.Raid[${i}].Name}]
				if !${UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI].ItemByText[${Me.Raid[${i}]}](exists)}
					UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:AddItem[${Me.Raid[${i}].Name}]
				if !${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].ItemByText[${Me.Raid[${i}]}](exists)}
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${Me.Raid[${i}].Name}]
			}
		}
		else	
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
			{
				if !${UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI].ItemByText[${Me.Group[${i}]}](exists)}
					UIElement[AliasesRaidGroupListBox@AliasesFrame@CombatBotUI]:AddItem[${Me.Group[${i}].Name}]
				if !${UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI].ItemByText[${Me.Group[${i}]}](exists)}
					UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:AddItem[${Me.Group[${i}].Name}]
				if !${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].ItemByText[${Me.Group[${i}]}](exists)}
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${Me.Group[${i}].Name}]
			}
		}
		This:LoadAliases
	}
	method LoadAliases()
	{
		variable int iaCount=0
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:ClearItems
		for(iaCount:Set[1];${iaCount}<=${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].Items};iaCount:Inc)
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI].Item[${i}].Text.Equal[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Find[" For"]}-1]}]}]}
					UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:RemoveItem[${UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:AddItem[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Find[" For"]}-1]}]}]
			for(i:Set[1];${i}<=${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Item[${i}].Text.Equal[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Find[" For"]}-1]}]}]}
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:RemoveItem[${UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI].Item[${i}].ID}]
			}
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${iaCount}].Text.Find[" For"]}-1]}]}]
		}
		This:LoadTargetList
	}
	method AssistLoadRaidGroupList()
	{
		variable int i=0
		UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:ClearItems
		if ${Me.Raid}>0
		{
			for(i:Set[1];${i}<=${Me.Raid};i:Inc)
				UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:AddItem[${Me.Raid[${i}].Name}]
		}
		else	
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
				UIElement[AssistRaidGroupListBox@AssistFrame@CombatBotUI]:AddItem[${Me.Group[${i}].Name}]
		}
		This:LoadAliases
	}
	method LoadTargetList()
	{
		variable int count=0
		
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[@Group]
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[@Me]
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[@NotSelfGroup]
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[@PCTarget]
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[@Raid]

		if ${ME.Raid}>0
		{
			for(count:Set[1];${count}<=${Me.Raid};count:Inc)
				UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${Me.Raid[${count}]}]
		}
		elseif ${Me.Group}>1
		{
			for(count:Set[0];${count}<${Me.Group};count:Inc)
			{
				if ${Me.Group[${count}].Pet(exists)}
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[Pet:${Me.Group[${count}].Pet.Name}]
				UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${Me.Group[${count}]}]
			}
		}
		elseif ${Me.Pet(exists)}
		{
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[Pet:${Me.Pet.Name}]
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${Me.Name}]
		}
		else
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:AddItem[${Me.Name}]
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:SetAutoSort[TRUE]
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:SetSortType[value]
	}
	method ClearOptions()
	{
		UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:ClearSelection 
		UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
		UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:SetText[""]
		UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:SetText[""]
		UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:UnsetChecked
		UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:UnsetChecked
		UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:UnsetChecked
		UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:UnsetChecked
		UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:UnsetChecked
		UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:SetText[""]
		UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:SetText[""]
		UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:SetText[""]
	}
	method CastStackExportAbilitiesListBoxClick(string AbilityName, int ExportPosition, bool NoClick)
	{
		if !${NoClick}
			UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI]:ClearSelection
		if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem(exists)} || ${NoClick}
		{
			;echo istrExport=${istrExport.Get[${ExportPosition}]} istrExportID=${istrExportID.Get[${ExportPosition}]} istrExportLevel=${istrExportLevel.Get[${ExportPosition}]} istrExportAllowRaid=${istrExportAllowRaid.Get[${ExportPosition}]} istrExportDissonanceCost=${istrExportDissonanceCost.Get[${ExportPosition}]} istrExportDoesNotExpire=${istrExportDoesNotExpire.Get[${ExportPosition}]} istrExportIsAE=${istrExportIsAE.Get[${ExportPosition}]} istrExportIsAEncounterHostile=${istrExportIsAEncounterHostile.Get[${ExportPosition}]} istrExportIsBeneficial=${istrExportIsBeneficial.Get[${ExportPosition}]} istrExportMinRange=${istrExportMinRange.Get[${ExportPosition}]} istrExportMaxRange=${istrExportMaxRange.Get[${ExportPosition}]} istrExportMaxDuration=${istrExportMaxDuration.Get[${ExportPosition}]} istrExportSavageryCost=${istrExportSavageryCost.Get[${ExportPosition}]} istrExportReqFlanking=${istrExportReqFlanking.Get[${ExportPosition}]} istrExportReqStealth=${istrExportReqStealth.Get[${ExportPosition}]} istrExportCastingTime=${istrExportCastingTime.Get[${ExportPosition}]} istrExportSpellBookType=${istrExportSpellBookType.Get[${ExportPosition}]} istrExportISPCCure=${istrExportISPCCure.Get[${ExportPosition}]} istrExportIsABuff=${istrExportIsABuff.Get[${ExportPosition}]} istrExportIsASingleTargetBeneficial=${istrExportIsASingleTargetBeneficial.Get[${ExportPosition}]} istrExportIsASingleTargetHostile=${istrExportIsASingleTargetHostile.Get[${ExportPosition}]} istrExportIsOtherGroupAbility=${istrExportIsOtherGroupAbility.Get[${ExportPosition}]} istrExportIsPCCureCurse=${istrExportIsPCCureCurse.Get[${ExportPosition}]} istrExportIsRes=${istrExportIsRes.Get[${ExportPosition}]} istrExportIsSingleTargetAbility=${istrExportIsSingleTargetAbility.Get[${ExportPosition}]} istrExportIsPetAbility=${istrExportIsPetAbility.Get[${ExportPosition}]} istrExportIsGroupAbility=${istrExportIsGroupAbility.Get[${ExportPosition}]} istrExportIsRaidAbility=${istrExportIsRaidAbility.Get[${ExportPosition}]} istrExportIsSelfAbility=${istrExportIsSelfAbility.Get[${ExportPosition}]} istrExportMaxAOETargets=${istrExportMaxAOETargets.Get[${ExportPosition}]}
			; if ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equals[Summon Mount]}
			; {	
				; UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Show
				; UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Show
				; UIElement[Add@CastStackFrame@CombatBotUI]:Show
				; UIElement[Edit@CastStackFrame@CombatBotUI]:Show
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Buff]
				; UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[OutOfCombatBuff]
				; return
			; }
			if ${AbilityName.Left[5].Equal[Item:]}
			{
				This:ClearOptions
				UIElement[Add@CastStackFrame@CombatBotUI]:Show
				UIElement[Edit@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Buff]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[OutOfCombatBuff]
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Cure]
				UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
				UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:Show
			}
			else
			{
				UIElement[CastStackRequiresItemEquippedCheckBox@CastStackFrame@CombatBotUI]:Hide
				UIElement[Add@CastStackFrame@CombatBotUI]:Show
				UIElement[Edit@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Show
				UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Show
				if ${CombatBotCSCDebug}
					echo ISXRI: CombatBot: ${AbilityName} - ${ExportPosition} - ${istrExport.Get[${ExportPosition}]}
				
				if ${istrExport.Get[${ExportPosition}].Find["Zealous Smite"](exists)}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsACure
					This:ClearOptions
					;if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					;else
					;	UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Cure]
					;if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]}
					;{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					;}
					;else
					;{
					;	UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
				;		UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
			;		}
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					; if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					; {
						; UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						; UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					; }
					; else
					; {
						; UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						; UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					; }
					; if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					; {
						; UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						; UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						; UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						; UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					; }
					; else
					; {
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					;}
					return
				}
				if ${istrExport.Get[${ExportPosition}].Find["Adrenaline Boost"](exists)}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsABuff
					This:ClearOptions
					if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					else
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems	
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Buff]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[OutOfCombatBuff]
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					return
				}
				if ${istrExport.Get[${ExportPosition}].Find["Aherin's Mighty Slam"](exists)}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsASingleTargetHostile
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					return
				}
				if ${istrExportIsABuff.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${istrExport.Get[${ExportPosition}].Equal[Smite of Consistency]}
					{
						if ${CombatBotCSCDebug}
							echo ISXRI: CombatBot: IsASingleTargetHostile
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					else
					{
						if ${CombatBotCSCDebug}
							echo ISXRI: CombatBot: IsABuff
						This:ClearOptions
						if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
							UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
						else
							UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems	
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Buff]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[OutOfCombatBuff]
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
						if ${istrExportSavageryCost.Get[${ExportPosition}]}>0 || 
						{
							UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
							UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
						}
						else
						{
							UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
							UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
						}
						if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
						{
							UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
							UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
							UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
							UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
						}
						else
						{
							UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
							UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
							UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
							UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
						}
					}
				}
				if ${istrExportISPCCure.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsACure
					This:ClearOptions
					if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					else
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Cure]
					if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]}
					{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				;echo \${istrExportIsASingleTargetBeneficial.Get[${ExportPosition}].Equal[TRUE]} && \${istrExportISPCCure.Get[${ExportPosition}].NotEqual[TRUE]} && \${istrExportIsPCCureCurse.Get[${ExportPosition}].NotEqual[TRUE]} && \${istrExportIsABuff.Get[${ExportPosition}].NotEqual[TRUE]} ${istrExportIsASingleTargetBeneficial.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportISPCCure.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsPCCureCurse.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsABuff.Get[${ExportPosition}].NotEqual[TRUE]}
				if ${istrExportIsASingleTargetBeneficial.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportISPCCure.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsPCCureCurse.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsABuff.Get[${ExportPosition}].NotEqual[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsASingleTargetBeneficial
					This:ClearOptions
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					if ${istrExportSpellBookType.Get[${ExportPosition}].Equal[6]}
					{
						;echo this is an ascension ability
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
						if ${istrExport.Get[${ExportPosition}].Equal[Ethereal Conduit]} || ${istrExport.Get[${ExportPosition}].Equal[Recapture]}
							UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
					}
					else
					{
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
					}
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsASingleTargetHostile.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsASingleTargetHostile
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsOtherGroupAbility.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsOtherGroupAbility
					This:ClearOptions
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsPCCureCurse.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsPCCureCurse
					This:ClearOptions
					if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					else
						UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Cure]
					if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]}
					{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsRes.Get[${ExportPosition}].Equal[TRUE]}
				{	
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsRes
					This:ClearOptions
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Res]
					if ${istrExportMaxAOETargets.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
			;	if ${istrExportIsSingleTargetAbility.Get[${ExportPosition}].Equal[TRUE]}
			;		echo IsSingleTargetAbility
				if ${istrExportIsPetAbility.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsPetAbility
					This:ClearOptions
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				;if ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]}
				;	echo IsGroupAbility
				if ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportIsAE.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportIsABuff.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportISPCCure.Get[${ExportPosition}].NotEqual[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsSelfAbility
					This:ClearOptions
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0 || ${UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI].SelectedItem.Text.Equals[Savagery Freeze]}
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsAE.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportIsBeneficial.Get[${ExportPosition}].Equal[FALSE]} && ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsAE
					This:ClearOptions
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				;echo if ( ${istrExportIsAE.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportMaxAOETargets.Get[${ExportPosition}]}>0 ) && ${istrExportIsBeneficial.Get[${ExportPosition}].Equal[TRUE]} && ( ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsRaidAbility.Get[${ExportPosition}].Equal[TRUE]} )
				if ( ${istrExportIsAE.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportMaxAOETargets.Get[${ExportPosition}]}>0 ) && ${istrExportIsBeneficial.Get[${ExportPosition}].Equal[TRUE]} && ( ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]} || ${istrExportIsRaidAbility.Get[${ExportPosition}].Equal[TRUE]} )
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsAE and Beneficial, Spells like Defile/Porcupine
					This:ClearOptions
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportIsRaidAbility.Get[${ExportPosition}].Equal[TRUE]}
					{
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
						UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					}
					
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportIsSelfAbility.Get[${ExportPosition}].Equal[TRUE]}
						UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Show
					else 
						UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsAEncounterHostile.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportIsABuff.Get[${ExportPosition}].NotEqual[TRUE]}
				{
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsAEncounterHostile
					This:ClearOptions
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide;UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
				if ${istrExportIsBeneficial.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportIsGroupAbility.Get[${ExportPosition}].Equal[TRUE]} && ${istrExportIsABuff.Get[${ExportPosition}].NotEqual[TRUE]} && ${istrExportISPCCure.Get[${ExportPosition}].NotEqual[TRUE]}
				{	
					if ${CombatBotCSCDebug}
						echo ISXRI: CombatBot: IsBeneficial && IsGroupAbility
					This:ClearOptions
					UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:ClearItems
					
					if ${istrExportSpellBookType.Get[${ExportPosition}].Equal[6]}
					{
						;echo this is an ascension ability
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
					}
					else
					{
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Hostile]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[NamedHostile]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[InCombatTargeted]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Heal]
						UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:AddItem[Power]
					}
					
					UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Show
					if ${istrExportMaxDuration.Get[${ExportPosition}]}>0
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Show
					else
						UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Show
					UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
					UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
					if ${istrExportSavageryCost.Get[${ExportPosition}]}>0
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
					if ${istrExportDissonanceCost.Get[${ExportPosition}]}>0 || 
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Show
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Show
					}
					else
					{
						UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
						UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
					}
				}
			}
		}
		else
		{
			UIElement[CastStackTypeComboBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackTypeText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackTargetComboBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackTargetText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStack%Text@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStack%TextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSkipDurationCheckBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackRequired#Text@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackRequired#TextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackRequiresMaxIncrementsCheckBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSkipAECheckBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSkipEncounterCheckBox@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSavageryText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackSavageryTextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceLessText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceLessTextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceGreaterText@CastStackFrame@CombatBotUI]:Hide
			UIElement[CastStackDissonanceGreaterTextEntry@CastStackFrame@CombatBotUI]:Hide
			UIElement[Add@CastStackFrame@CombatBotUI]:Hide
			UIElement[Edit@CastStackFrame@CombatBotUI]:Hide
		}
	}
	method SetDefaulProfile(string _Profile)
	{
		if ${CombatBotLoading}
			return
		if ${_Profile.Equal[NULL]} || ${_Profile.Equal[""]}
			return
		if ${UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI].ItemByText[${_Profile}](exists)}
		{
			LavishSettings[SaveFile]:Clear
			LavishSettings:AddSet[SaveFile]
			if ${Me.Name.Find[Skyshrine Guardian](exists)}
				LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml"]
			elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
				LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml"]
			else
				LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
			LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
			LavishSettings[SaveFile]:AddSet[Profiles]
			LavishSettings[SaveFile].FindSet[Profiles]:AddSetting[DefaultProfile,${_Profile}]
			if ${Me.Name.Find[Skyshrine Guardian](exists)}
				LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml"]
			elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
				LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml"]
			else
				LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
			
		}
	}
	method DeleteProfile(string _Profile)
	{
		if ${_Profile.Equal[NULL]} || ${_Profile.Equal[""]}
		{
			MessageBox -skin eq2 "You must specify a profile to DELETE"
			return
		}
		if ${QueueCommands}
			FlushQueued
		Script[${Script.Filename}]:QueueCommand["call RI_Obj_CB.DeleteProfileFN ${_Profile}"]
	}
	method CreateProfile(string _Profile)
	{
		MessageBox -skin eq2 "Coming Soon"
		UIElement[ProfileNameTextEntry@BottomFrame@CombatBotUI]:SetText[""]
		UIElement[CombatBotUI]:SetFocus
		if ${_Profile.Equal[NULL]} || ${_Profile.Equal[""]}
		{
			MessageBox -skin eq2 "You must specify a profile to create"
			return
		}
	}
	function DeleteProfileFN(string _Profile) 
	;save profile
	{
		MessageBox -skin eq2 -YesNo "Are you sure you want to DELETE ${_Profile}?"
		if ${UserInput.Equal[Yes]}
			This:DeleteProfileYes[${_Profile}]
	}
	method DeleteProfileYes(string _Profile)
	{
		LavishSettings[SaveFile]:Clear
		LavishSettings:AddSet[SaveFile]
		if ${Me.Name.Find[Skyshrine Guardian](exists)}
			LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml"]
		elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml"]
		else
			LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
		LavishSettings[SaveFile]:AddSet[Profiles]
		LavishSettings[SaveFile].FindSet[Profiles]:AddSet[${_Profile}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:Clear
		if ${Me.Name.Find[Skyshrine Guardian](exists)}
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml"]
		elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml"]
		else
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
		UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:RemoveItem[${UIElement[ProfilesComboBox@BottomFrame@CombatBotUI].ItemByText[${_Profile}].ID}]
		UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI]:RemoveItem[${UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI].ItemByText[${_Profile}].ID}]
		UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:SelectItem[1]
		UIElement[ProfileNameTextEntry@BottomFrame@CombatBotUI]:SetText[""]
		UIElement[CombatBotUI]:SetFocus
	}
	method SaveProfile(string _Profile)
	{
		if ${_Profile.Equal[NULL]} || ${_Profile.Equal[""]}
		{
			MessageBox -skin eq2 "You must specify a profile to save"
			return
		}
		if ${QueueCommands}
			FlushQueued
		Script[${Script.Filename}]:QueueCommand["call RI_Obj_CB.SaveProfileFN ${_Profile}"]
	}
	method CreateProfile(string _Profile)
	{
		;MessageBox -skin eq2 "Coming Soon"
		UIElement[ProfileNameTextEntry@BottomFrame@CombatBotUI]:SetText[""]
		UIElement[CombatBotUI]:SetFocus
		if ${_Profile.Equal[NULL]} || ${_Profile.Equal[""]}
		{
			MessageBox -skin eq2 "You must specify a profile to create"
			return
		}
		if ${QueueCommands}
			FlushQueued
		Script[${Script.Filename}]:QueueCommand["call RI_Obj_CB.CreateProfileFN ${_Profile}"]
	}
	function CreateProfileFN(string _Profile) 
	;save profile
	{
		MessageBox -skin eq2 -YesNo "Are you sure you want to create a new profile named ${_Profile}?"
		if ${UserInput.Equal[Yes]}
			This:SaveProfileYes[${_Profile}]
	}
	function SaveProfileFN(string _Profile) 
	;save profile
	{
		MessageBox -skin eq2 -YesNo "Are you sure you want to save ${_Profile}?"
		if ${UserInput.Equal[Yes]}
			This:SaveProfileYes[${_Profile}]
	}
	method SaveProfileYes(string _Profile) 
	;save profile
	{
		echo CombatBot Saving: ${_Profile}
		LavishSettings[SaveFile]:Clear
		LavishSettings:AddSet[SaveFile]
		if ${Me.Name.Find[Skyshrine Guardian](exists)}
			LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml"]
		elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml"]
		else
			LavishSettings[SaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
		LavishSettings[SaveFile]:AddSet[Profiles]
		LavishSettings[SaveFile].FindSet[Profiles]:AddSet[${_Profile}]
		;Settings
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Settings]
				
		
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsRangedAutoCheckBox,${RI_Obj_CB.GetUISetting[SettingsRangedAutoCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsMeleeAutoCheckBox,${RI_Obj_CB.GetUISetting[SettingsMeleeAutoCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCancelAutoCheckBox,${RI_Obj_CB.GetUISetting[SettingsCancelAutoCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsTimeAutoCheckBox,${RI_Obj_CB.GetUISetting[SettingsTimeAutoCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSkipMobAttackHealthCheckBox,${RI_Obj_CB.GetUISetting[SettingsSkipMobAttackHealthCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAttackHealthTextEntry,${RI_Obj_CB.GetUISetting[SettingsAttackHealthTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsMoveDistanceTextEntry,${RI_Obj_CB.GetUISetting[SettingsMoveDistanceTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAfterMoveDistanceModTextEntry,${RI_Obj_CB.GetUISetting[SettingsAfterMoveDistanceModTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsMoveBehindCheckBox,${RI_Obj_CB.GetUISetting[SettingsMoveBehindCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsMoveInFrontCheckBox,${RI_Obj_CB.GetUISetting[SettingsMoveInFrontCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsMoveInCheckBox,${RI_Obj_CB.GetUISetting[SettingsMoveInCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSkipMobMoveHealthCheckBox,${RI_Obj_CB.GetUISetting[SettingsSkipMobMoveHealthCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsMoveHealthTextEntry,${RI_Obj_CB.GetUISetting[SettingsMoveHealthTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSkipEncounterCheckBox,${RI_Obj_CB.GetUISetting[SettingsSkipEncounterCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsEncounter#TextEntry,${RI_Obj_CB.GetUISetting[SettingsEncounter#TextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsDoNotCastEncounterCheckBox,${RI_Obj_CB.GetUISetting[SettingsDoNotCastEncounterCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSkipAECheckBox,${RI_Obj_CB.GetUISetting[SettingsSkipAECheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAE#TextEntry,${RI_Obj_CB.GetUISetting[SettingsAE#TextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsDoNotCastAECheckBox,${RI_Obj_CB.GetUISetting[SettingsDoNotCastAECheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAutoShareMissionsCheckBox,${RI_Obj_CB.GetUISetting[SettingsAutoShareMissionsCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSummonFamiliarCheckBox,${RI_Obj_CB.GetUISetting[SettingsSummonFamiliarCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsFaceMobCheckBox,${RI_Obj_CB.GetUISetting[SettingsFaceMobCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSendPetsCheckBox,${RI_Obj_CB.GetUISetting[SettingsSendPetsCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsRecallPetsCheckBox,${RI_Obj_CB.GetUISetting[SettingsRecallPetsCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastAbilitiesCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastAbilitiesCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastHostileCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastHostileCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastNamedHostileCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastNamedHostileCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastInCombatTargetCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastInCombatTargetCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastHealCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastHealCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastPowerCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastPowerCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastCureCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastCureCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastResCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastResCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastBuffCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastBuffCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastOutOfCombatBuffCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastOutOfCombatBuffCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCastInvisCheckBox,${RI_Obj_CB.GetUISetting[SettingsCastInvisCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCancelInvisCheckBox,${RI_Obj_CB.GetUISetting[SettingsCancelInvisCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCancelCastingGroupCureCheckBox,${RI_Obj_CB.GetUISetting[SettingsCancelCastingGroupCureCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAlwaysCastNamedHostileCheckBox,${RI_Obj_CB.GetUISetting[SettingsAlwaysCastNamedHostileCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsStartHeroicCheckBox,${RI_Obj_CB.GetUISetting[SettingsStartHeroicCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAssistingCheckBox,${RI_Obj_CB.GetUISetting[SettingsAssistingCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsLootingCheckBox,${RI_Obj_CB.GetUISetting[SettingsLootingCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsLootCorpsesCheckBox,${RI_Obj_CB.GetUISetting[SettingsLootCorpsesCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsLootChestsCheckBox,${RI_Obj_CB.GetUISetting[SettingsLootChestsCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsLockSpottingCheckBox,${RI_Obj_CB.GetUISetting[SettingsLockSpottingCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAutoLoadRIMUICheckBox,${RI_Obj_CB.GetUISetting[SettingsAutoLoadRIMUICheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAutoLoadRIMobHudCheckBox,${RI_Obj_CB.GetUISetting[SettingsAutoLoadRIMobHudCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAcceptRessesCheckBox,${RI_Obj_CB.GetUISetting[SettingsAcceptRessesCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAcceptInvitesCheckBox,${RI_Obj_CB.GetUISetting[SettingsAcceptInvitesCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAcceptTradesCheckBox,${RI_Obj_CB.GetUISetting[SettingsAcceptTradesCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAcceptLootCheckBox,${RI_Obj_CB.GetUISetting[SettingsAcceptLootCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsSkipAbilityCollisionCheckBox,${RI_Obj_CB.GetUISetting[SettingsSkipAbilityCollisionCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAutoTargetMobsCheckBox,${RI_Obj_CB.GetUISetting[SettingsAutoTargetMobsCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsAutoRunKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsAutoRunKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsForwardKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsForwardKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsBackwardKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsBackwardKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsStrafeLeftKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsStrafeLeftKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsStrafeRightKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsStrafeRightKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsJumpKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsJumpKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCrouchKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsCrouchKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsFlyUpKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsFlyUpKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsFlyDownKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsFlyDownKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsFlyDownKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsFlyDownKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsFlyDownKeyTextEntry,${RI_Obj_CB.GetUISetting[SettingsFlyDownKeyTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsCallConfrontFearCheckBox,${RI_Obj_CB.GetUISetting[SettingsCallConfrontFearCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Settings]:AddSetting[SettingsConfrontFearCallTextEntry,${RI_Obj_CB.GetUISetting[SettingsConfrontFearCallTextEntry]}]
		
		;CastStack
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[CastStack]
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items};count:Inc)
		{
			;echo Adding ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} To Set ${count}
			;string _AbilityName, int _ExportPosition, string _Type, string _Target, string _%, string _#, string _SD, string _SE, string _SAE, string _RIE , string _MAX, int _Savagery, int _DissonanceLess,int _DissonanceGreater
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack]:AddSet[${count}]
			;CastStackAbilityDisabled
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityDisabled,FALSE]
			;CastStackAbilityName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityName,"${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}"]
			;CastStackAbilityType
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityType,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}]
			;CastStackAbilityTarget
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityTarget,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|]}]
			;CastStackAbilityRequired%
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityRequired%,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}]
			;CastStackAbilityRequired#
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityRequired#,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}]
			;CastStackAbilitySkipDuration
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilitySkipDuration,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|]}]
			;CastStackAbilitySkipEncounter
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilitySkipEncounter,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[8,|]}]
			;CastStackAbilitySkipAE
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilitySkipAE,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|]}]
			;CastStackAbilityRequiresItemEquipped
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityRequiresItemEquipped,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}]
			;CastStackAbilityRequiresMaxIncrements
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityRequiresMaxIncrements,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[11,|]}]
			;CastStackAbilitySavagery
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilitySavagery,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]}]
			;CastStackAbilityDissonanceLess
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityDissonanceLess,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]}]
			;CastStackAbilityDissonanceGreater
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CastStack].FindSet[${count}]:AddSetting[CastStackAbilityDissonanceGreater,${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]}]
		}
		;Items
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Items]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Items]
		for(count:Set[1];${count}<=${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Items};count:Inc)
		{
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Items]:AddSet[${count}]
			;ItemName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Items].FindSet[${count}]:AddSetting[ItemName,"${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].OrderedItem[${count}].Text}"]
			;ItemEffect
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Items].FindSet[${count}]:AddSetting[ItemEffect,"${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].OrderedItem[${count}].Value}"]
		}
		;Aliases
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Aliases]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Aliases]
		for(count:Set[1];${count}<=${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].Items};count:Inc)
		{	
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Aliases]:AddSet[${count}]
			;AliasDisabled
			if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Aliases].FindSet[${count}]:AddSetting[AliasDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Aliases].FindSet[${count}]:AddSetting[AliasDisabled,FALSE]
			;AliasName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Aliases].FindSet[${count}]:AddSetting[AliasName,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${count}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${count}].Text.Find[" For:"]}-1]}]}]
			;AliasFor
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Aliases].FindSet[${count}]:AddSetting[AliasFor,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${count}].Value}]
			
		}
		;Assist
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Assist]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Assist]
		for(count:Set[1];${count}<=${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Items};count:Inc)
		{
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Assist]:AddSet[${count}]
			if ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Assist].FindSet[${count}]:AddSetting[AssistDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Assist].FindSet[${count}]:AddSetting[AssistDisabled,FALSE]
			;AssistName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Assist].FindSet[${count}]:AddSetting[AssistName,${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${count}].Text}]
			
		}
		;PrePostCast
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[PrePostCast]
		for(count:Set[1];${count}<=${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].Items};count:Inc)
		{
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast]:AddSet[${count}]
			;PrePostCastDisabled
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast].FindSet[${count}]:AddSetting[PrePostCastDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast].FindSet[${count}]:AddSetting[PrePostCastDisabled,FALSE]
			;PrePostCastName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast].FindSet[${count}]:AddSetting[PrePostCastName,${RI_Obj_CB.PrePostCastAbility1[${count}]}]
			;PrePostCastBefore or After
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${count}].Text.Find[|Before|](exists)}
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast].FindSet[${count}]:AddSetting[PrePostCastBefore,${RI_Obj_CB.PrePostCastAbility2[${count}]}]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[PrePostCast].FindSet[${count}]:AddSetting[PrePostCastAfter,${RI_Obj_CB.PrePostCastAbility2[${count}]}]
			
		}
		;InvisAbilities
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[InvisAbilities]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[InvisAbilities]
		for(count:Set[1];${count}<=${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Items};count:Inc)
		{
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[InvisAbilities]:AddSet[${count}]
			;InvisAbilityDisabled
			if ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[InvisAbilities].FindSet[${count}]:AddSetting[InvisAbilityDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[InvisAbilities].FindSet[${count}]:AddSetting[InvisAbilityDisabled,FALSE]
			;InvisAbilityName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[InvisAbilities].FindSet[${count}]:AddSetting[InvisAbilityName,${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${count}].Text}]
			
		}
		;Announce
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Announce]
		for(count:Set[1];${count}<=${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].Items};count:Inc)
		{
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce]:AddSet[${count}]
			;AnnounceDisabled
			if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce].FindSet[${count}]:AddSetting[AnnounceDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce].FindSet[${count}]:AddSetting[AnnounceDisabled,FALSE]
			;AnnounceName
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce].FindSet[${count}]:AddSetting[AnnounceName,${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}]
			;AnnounceTarget
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce].FindSet[${count}]:AddSetting[AnnounceTarget,${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]
			;Announcement
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Announce].FindSet[${count}]:AddSetting[Announcement,"${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}"]
			
		}
		;CharmSwap
		if !${LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CharmSwap](exists)}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[CharmSwap]

			if ${UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI].SelectedItem(exists)}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CharmSwap]:AddSetting[CharmSwapCharm1ComboBox,Item:${UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI].SelectedItem.Text}]
		if ${UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI].SelectedItem(exists)}	
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[CharmSwap]:AddSetting[CharmSwapCharm2ComboBox,Item:${UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI].SelectedItem.Text}]
			
		;OnEvents
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[OnEvents]
		for(count:Set[1];${count}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};count:Inc)
		{
			;AddSet
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents]:AddSet[${count}]
			;OnEventsDisabled
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents].FindSet[${count}]:AddSetting[OnEventsDisabled,TRUE]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents].FindSet[${count}]:AddSetting[OnEventsDisabled,FALSE]
			;OnEventsEvent
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents].FindSet[${count}]:AddSetting[OnEventsEvent,${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}]
			;OnEventsCommand
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|](exists)}
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents].FindSet[${count}]:AddSetting[OnEventsCommand,"\"${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Replace[\",""]}|${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Escape}"]
			else
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[OnEvents].FindSet[${count}]:AddSetting[OnEventsCommand,"${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Escape}"]
		}
		;Huds
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:Clear
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Huds]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsRaidGroupCheckBox,${RI_Obj_CB.GetUISetting[HudsRaidGroupCheckBox]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsRaidGroupOnlyCheckBox,${RI_Obj_CB.GetUISetting[HudsRaidGroupOnlyCheckBox]}]
		if ${RI_Obj_CB.GetUISetting[HudsRaidGroupXTextEntry].NotEqual[""]}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsRaidGroupXTextEntry,${RI_Obj_CB.GetUISetting[HudsRaidGroupXTextEntry]}]
		if ${RI_Obj_CB.GetUISetting[HudsRaidGroupYTextEntry].NotEqual[""]}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsRaidGroupYTextEntry,${RI_Obj_CB.GetUISetting[HudsRaidGroupYTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsNearestPlayerCheckBox,${RI_Obj_CB.GetUISetting[HudsNearestPlayerCheckBox]}]
		if ${RI_Obj_CB.GetUISetting[HudsNearestNPCXTextEntry].NotEqual[""]}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsNearestNPCXTextEntry,${RI_Obj_CB.GetUISetting[HudsNearestNPCXTextEntry]}]
		if ${RI_Obj_CB.GetUISetting[HudsNearestNPCYTextEntry].NotEqual[""]}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsNearestNPCYTextEntry,${RI_Obj_CB.GetUISetting[HudsNearestNPCYTextEntry]}]
		LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsNearestNPCCheckBox,${RI_Obj_CB.GetUISetting[HudsNearestNPCCheckBox]}]
		if ${RI_Obj_CB.GetUISetting[HudsNearestPlayerXTextEntry].NotEqual[""]}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsNearestPlayerXTextEntry,${RI_Obj_CB.GetUISetting[HudsNearestPlayerXTextEntry]}]
		if ${RI_Obj_CB.GetUISetting[HudsNearestPlayerYTextEntry].NotEqual[""]}
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Huds]:AddSetting[HudsNearestPlayerYTextEntry,${RI_Obj_CB.GetUISetting[HudsNearestPlayerYTextEntry]}]
		if ${Me.SubClass.Equal[coercer]} || ${Me.SubClass.Equal[troubador]}
		{
			;Charm
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm]:Clear
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Charm]
			;LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm]:AddSet[CharmControl]
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm]:AddSetting[CharmControl,${UIElement[SubClassCharmControlCheckBox@SubClassFrame@CombatBotUI].Checked}]
			;LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm]:AddSetting[CharmMob23123,FART]
			for(count:Set[1];${count}<=${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items};count:Inc)
			{
				;AddSet
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm]:AddSet[${count}]
				;CharmMob
				LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm].FindSet[${count}]:AddSetting[CharmMob,${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].OrderedItem[${count}].Text}]
				;ItemEffect
				;LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Charm].FindSet[${count}]:AddSetting[ItemEffect,${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].OrderedItem[${count}].Value}]
			}
		}
		if ${Me.SubClass.Equal[inquisitor]}
		{
			;Verdict
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Verdict]:Clear
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}]:AddSet[Verdict]
			LavishSettings[SaveFile].FindSet[Profiles].FindSet[${_Profile}].FindSet[Verdict]:AddSetting[CastVerdict,${UIElement[SubClassInqVerdictCheckBox@SubClassFrame@CombatBotUI].Checked}]
		}
		;echo ${LavishSettings[SaveFile]}
		if ${Me.Name.Find[Skyshrine Guardian](exists)}
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml"]
		elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml"]
		else
			LavishSettings[SaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
		
		if !${UIElement[ProfilesComboBox@BottomFrame@CombatBotUI].ItemByText[${_Profile}](exists)}
			UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:AddItem[${_Profile}]
		if !${UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI].ItemByText[${_Profile}](exists)}
			UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI]:AddItem[${_Profile}]
		UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:SelectItem[${UIElement[ProfilesComboBox@BottomFrame@CombatBotUI].ItemByText[${_Profile}].ID}]
		UIElement[ProfileNameTextEntry@BottomFrame@CombatBotUI]:SetText[""]
		UIElement[CombatBotUI]:SetFocus
	}
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; MAIN FUNCTION ;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function main()
{
	if ${EQ2.ServerName.Equal[Battlegrounds]} && !${Me.Name.Find[.](exists)}
	{
		echo ISXRI: CombatBot: Script is disabled in Battlegrounds Lobby, waiting until out
		while ${EQ2.ServerName.Equal[Battlegrounds]} && !${Me.Name.Find[.](exists)}
			wait 10
	}
	;Turbo 2000
	;disable debugging
	Script:DisableDebugging
	
	while ${Me.IsCamping}
	{
		if ${CombatBotDebug}
			echo CombatBot: Waiting while camping
		wait 10
	}
	while !${Me.InGameWorld}
	{
		if ${CombatBotDebug}
			echo CombatBot: Waiting while not in game world
		wait 10
	}
	while ${Zone.Name.Equal[LoginScene]}
	{
		if ${CombatBotDebug}
			echo CombatBot: Waiting while at LoginScene
		wait 10
	}
	while ${EQ2.Zoning}!=0
	{
		if ${CombatBotDebug}
			echo CombatBot: Waiting while zoning
		wait 10
		;SummonMount:Set[FALSE]
	}
	if ${EQ2.ServerName.Equal[Battlegrounds]} && !${Me.Name.Find[.](exists)}
	{
		echo ISXRI: CombatBot: Script is disabled in Battlegrounds Lobby, waiting until out
		while ${EQ2.ServerName.Equal[Battlegrounds]} && !${Me.Name.Find[.](exists)}
			wait 10
	}
	
	Squelch ChoiceWindow:DoChoice1
	
	if ${Me.Archetype.Equal[fighter]}
		CombatBotAssisting:Set[FALSE]
	;echo ${Script.Filename}
	;Event[EQ2_onMeAfflicted]:AttachAtom[EQ2_onMeAfflicted]
	Event[EQ2_onAnnouncement]:AttachAtom[EQ2_onAnnouncement]
	Event[EQ2_onChoiceWindowAppeared]:AttachAtom[EQ2_onChoiceWindowAppeared]
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	Event[EQ2_FinishedZoning]:AttachAtom[EQ2_FinishedZoning]
	declare FP filepath "${LavishScript.HomeDirectory}/"
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
	}
	;check if CombatBotUI.xml exists, if not create
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		FP:MakeSubdirectory[CombatBot]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot"]
	}
	if !${FP.FileExists[CombatBotUI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting CombatBotUI.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotUI.xml" http://www.isxri.com/CombatBotUI.xml
		wait 50
	}
	if !${FP.FileExists[CombatBotMiniUI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting CombatBotMiniUI.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotMiniUI.xml" http://www.isxri.com/CombatBotMiniUI.xml
		wait 50
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot"]
		FP:MakeSubdirectory[Profiles]	
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
		FP:MakeSubdirectory[AbilityCheck]	
	}
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotMiniUI.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotUI.xml"
	UIElement[RIMovement]:Hide
	UIElement[CombatBotUI]:Hide
	
	
	;UIElement[Start@CombatBotUI]:SetDisabled
	;if !${ISXEQ2.AfflictionEventsOn}
	;	ISXEQ2:EnableAfflictionEvents
	
	
	;while 1 
	;	wait 1
	
	
	echo ISXRI: CombatBot: v${RI_Var_Float_LocalCBVersion.Precision[2]} Loading
	;echo ${Me.Name} - ${Me.SubClass} - ${Me.Level}
	while ${EQ2.Zoning}!=0
	{
		if ${CombatBotDebug}
			echo CombatBot: Waiting while zoning
		wait 10
		;SummonMount:Set[FALSE]
	}
	;&& !${Me.Name.Find[.](exists)}
	if ${strMyName.NotEqual[${Me.Name}]} && ( ( ${EQ2.ServerName.Equal[Battlegrounds]} && ${Me.Name.Find[.](exists)} ) || ${EQ2.ServerName.NotEqual[Battlegrounds]} )
		strMyName:Set[${Me.Name}]
	if ${RI_Var_String_MySubClass.NotEqual[${Me.SubClass.Left[1].Upper}${Me.SubClass.Right[-1]}]}
		RI_Var_String_MySubClass:Set[${Me.SubClass.Left[1].Upper}${Me.SubClass.Right[-1]}]
	if ${intMyLevel}!=${Me.Level}
		intMyLevel:Set[${Me.Level}]
	;echo Name: ${strMyName}
	if ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Thaumaturgist"](exists)}
	{
		UIElement[AscensionButton@CombatBotUI]:SetText[Thaumaturgist]
	}
	if ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Elementalist"](exists)}
	{
		UIElement[AscensionButton@CombatBotUI]:SetText[Elementalist]
	}
	if ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Geomancer"](exists)}
	{
		UIElement[AscensionButton@CombatBotUI]:SetText[Geomancer]
	}
	if ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Etherealist"](exists)}
	{
		UIElement[AscensionButton@CombatBotUI]:SetText[Etherealist]
	}
	if ${RI_Var_String_MySubClass.Equal[warlock]}
	{
		; echo CombatBot: Setting Max Increment Logic for Skull Foci @ 3
		; echo CombatBot: Setting Max Increment Ability to: Toxic Aura @ 180
		; echo CombatBot: Activating Negative Void Code
		strMaxIncrementAbility:Set["Toxic Aura"]
		intMaxIncrements:Set[180]
	}
	if ${RI_Var_String_MySubClass.Equal[wizard]}
	{
		; echo CombatBot: Setting Max Increment Logic for World Ablaze @ 3
		; echo CombatBot: Setting Max Increment Logic for Hellfire and Incineration @ 3 (Not Working Yet)
		; echo CombatBot: Setting Max Increment Ability to: Frozen Solid @ 150
		strMaxIncrementAbility:Set["Frozen Solid"]
		intMaxIncrements:Set[150]
	}
	if ${RI_Var_String_MySubClass.Equal[conjuror]}
	{
		; echo CombatBot: Setting Max Increment Logic for World Ablaze @ 3
		; echo CombatBot: Setting Max Increment Ability to: Planar Wrack @ 5
		strMaxIncrementAbility:Set["Planar Wrack"]
		intMaxIncrements:Set[5]
	}
	if ${RI_Var_String_MySubClass.Equal[necromancer]}
	{
		; echo CombatBot: Setting Max Increment Logic for World Ablaze @ 3
		; echo CombatBot: Setting Max Increment Ability to: Graverot @ 5
		strMaxIncrementAbility:Set["Graverot"]
		intMaxIncrements:Set[5]
	}
	if ${RI_Var_String_MySubClass.Equal[mystic]}
	{
		; echo CombatBot: Setting Max Increment Ability to: Ferocity of Spirits @ 3
		strMaxIncrementAbility:Set["Ferocity of Spirits"]
		intMaxIncrements:Set[3]
	}
	if ${RI_Var_String_MySubClass.Equal[monk]}
	{
		; echo CombatBot: Setting Max Increment Ability to: Waveform @ 5
		strMaxIncrementAbility:Set["Waveform"]
		intMaxIncrements:Set[5]
	}
	if ${RI_Var_String_MySubClass.Equal[guardian]}
	{
		; echo CombatBot: Setting Max Increment Ability to: Champion's Sight @ 50
		strMaxIncrementAbility:Set["Champion's Sight"]
		intMaxIncrements:Set[50]
	}
	if ${RI_Var_String_MySubClass.Equal[brigand]}
	{
		; echo CombatBot: Setting Max Increment Ability to: Thug's Poison @ 5
		strMaxIncrementAbility:Set["Thug's Poison"]
		intMaxIncrements:Set[5]
	}
	if ${RI_Var_String_MySubClass.Equal[inquisitor]}
	{
		UIElement[SubClassText@SubClassFrame@CombatBotUI]:Hide
		UIElement[SubClassInqVerdictCheckBox@SubClassFrame@CombatBotUI]:Show
		;UIElement[SubClassInqVerdictCheckBox@SubClassFrame@CombatBotUI]:SetChecked
	}
	if ${RI_Var_String_MySubClass.Equal[beastlord]}
	{
		UIElement[SubClassText@SubClassFrame@CombatBotUI]:Hide
		UIElement[SubClassBeastlordPrimalDelayCheckBox@SubClassFrame@CombatBotUI]:Show
		UIElement[SubClassBeastlordPrimalDelayCheckBox@SubClassFrame@CombatBotUI]:SetChecked
	}
	if ${RI_Var_String_MySubClass.Equal[coercer]} || ${RI_Var_String_MySubClass.Equal[troubador]} || ${RI_Var_String_MySubClass.Equal[warden]}
	{	
		UIElement[SubClassText@SubClassFrame@CombatBotUI]:Hide
		UIElement[SubClassCharmControlCheckBox@SubClassFrame@CombatBotUI]:Show
		UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI]:Show
		UIElement[SubClassCharmMobsAddButton@SubClassFrame@CombatBotUI]:Show
		UIElement[SubClassCharmMobsTextEntry@SubClassFrame@CombatBotUI]:Show
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
	if !${FP.PathExists}
	{
		;echo CombatBot: Missing RI/CombatBot folder, Adding all folders and attempting to download UI file
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		FP:MakeSubdirectory[CombatBot]
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
		FP:MakeSubdirectory[AbilityCheck]
		FP:MakeSubdirectory[Profiles]
	}
	else
	{	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/"]
		if !${FP.PathExists}
		{
			;echo CombatBot: Missing AbilityCheck folder, Creating
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
			FP:MakeSubdirectory[AbilityCheck]
		}
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/"]
		if !${FP.PathExists}
		{
			;echo CombatBot: Missing Profiles folder, Creating
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
			FP:MakeSubdirectory[Profiles]
		}
	}
	RI_Obj_CB:SetUISetting[SettingsDeitySpendTextEntry,0]
	wait 10
	if ${ImportingOgre}
		wait 50
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/"]
	variable string ProfileFileName
	if ${Me.Name.Find[Skyshrine Guardian](exists)}
	{
		if !${FP.FileExists["skyshrineguardian-AbilityCheck.xml"]}
		{
			
			;echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/${RI_Var_String_MySubClass}-AbilityCheck.xml"
			MessageBox -skin eq2 -YesNo " ISXRI: CombatBot: Missing ${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/skyshrineguardian-AbilityCheck.xml    \n\nWould you like to start AbilityCheck?\n"
			if ${UserInput.Equal[Yes]}
			{
				UIElement[CombatBotMiniUI]:Hide
				RI_AbilityCheck
				while ${Script[Buffer:AbilityCheck](exists)}
					wait 1
				MessageBox -skin eq2 " ISXRI: CombatBot: AbilityCheck Complete"
				UIElement[CombatBotMiniUI]:Show
			}
			else
				Script:End
		}
		
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/"]
		
		ProfileFileName:Set["CBProfile-skyshrineguardian.xml"]
		
		if !${FP.FileExists["${ProfileFileName}"]}
		{
			echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml" copying over our default CombatBot profile!

			http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml" "http://www.isxri.com/CBProfile-Default-skyshrineguardian.xml"
			
			wait 50
			if !${FP.FileExists["CBProfile-skyshrineguardian.xml"]}
			{
				echo ISXRI: CombatBot: Failed to download default profile or download timed out. Please try again or download manually from http://www.isxri.com/ddp.html
				Script:End
			}
			echo Default profile copied, Type CB ImportOgre or CB ImportTHG or import your profile from the respective bot.
		}
	}
	elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
	{
		if !${FP.FileExists["skyshrineinfiltrator-AbilityCheck.xml"]}
		{
			
			;echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/${RI_Var_String_MySubClass}-AbilityCheck.xml"
			MessageBox -skin eq2 -YesNo " ISXRI: CombatBot: Missing ${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/skyshrineinfiltrator-AbilityCheck.xml    \n\nWould you like to start AbilityCheck?\n"
			if ${UserInput.Equal[Yes]}
			{
				UIElement[CombatBotMiniUI]:Hide
				RI_AbilityCheck
				while ${Script[Buffer:AbilityCheck](exists)}
					wait 1
				MessageBox -skin eq2 " ISXRI: CombatBot: AbilityCheck Complete"
				UIElement[CombatBotMiniUI]:Show
			}
			else
				Script:End
		}
		
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/"]
		
		ProfileFileName:Set["CBProfile-skyshrineinfiltrator.xml"]
		
		if !${FP.FileExists["${ProfileFileName}"]}
		{
			echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml" copying over our default CombatBot profile!

			http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineinfiltrator.xml" "http://www.isxri.com/CBProfile-Default-skyshrineguardian.xml"
			
			wait 50
			if !${FP.FileExists["CBProfile-skyshrineinfiltrator.xml"]}
			{
				echo ISXRI: CombatBot: Failed to download default profile or download timed out. Please try again or download manually from http://www.isxri.com/ddp.html
				Script:End
			}
			echo Default profile copied, Type CB ImportOgre or CB ImportTHG or import your profile from the respective bot.
		}
	}
	else
	{
		if !${FP.FileExists["${RI_Var_String_MySubClass}-AbilityCheck.xml"]}
		{
			
			;echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/${RI_Var_String_MySubClass}-AbilityCheck.xml"
			MessageBox -skin eq2 -YesNo " ISXRI: CombatBot: Missing ${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/${RI_Var_String_MySubClass}-AbilityCheck.xml    \n\nWould you like to start AbilityCheck?\n"
			if ${UserInput.Equal[Yes]}
			{
				UIElement[CombatBotMiniUI]:Hide
				RI_AbilityCheck
				while ${Script[Buffer:AbilityCheck](exists)}
					wait 1
				MessageBox -skin eq2 " ISXRI: CombatBot: AbilityCheck Complete"
				UIElement[CombatBotMiniUI]:Show
			}
			else
				Script:End
		}
		
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/"]
		
		ProfileFileName:Set["CBProfile-${EQ2.ServerName}-${strMyName}.xml"]
		
		if !${FP.FileExists["${ProfileFileName}"]}
		{
			if ${EQ2.ServerName.Equal[Battlegrounds]}
			{
				;if ${Me.Name.Find[.](exists)}
				;{
					ProfileFileName:Set["CBProfile-${Me.Name.Replace[_," "].Replace[.,-]}.xml"]
					echo ISXRI: We are in Battlegrounds using profile: ${ProfileFileName}
				;}
				;else
				;{
					;echo ISXRI: CombatBot: Script is disabled in Battlegrounds lobby reload once in a PG Match
					;Script:End
				;}
			}
			
			elseif ${EQ2.ServerName.Equal[Halls of Fate]} && ${FP.FileExists["CBProfile-Everfrost-${strMyName}.xml"]}
				cp "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Everfrost-${strMyName}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Halls of Fate-${strMyName}.xml"
			elseif ${EQ2.ServerName.Equal[Halls of Fate]} && ${FP.FileExists["CBProfile-Guk-${strMyName}.xml"]}
				cp "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Guk-${strMyName}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Halls of Fate-${strMyName}.xml"
			elseif ${EQ2.ServerName.Equal[Halls of Fate]} && ${FP.FileExists["CBProfile-Unrest-${strMyName}.xml"]}
				cp "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Unrest-${strMyName}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Halls of Fate-${strMyName}.xml"
			elseif ${EQ2.ServerName.Equal[Maj'Dul]} && ${FP.FileExists["CBProfile-Crushbone-${strMyName}.xml"]}
				cp "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Crushbone-${strMyName}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Maj'Dul-${strMyName}.xml"
			elseif ${EQ2.ServerName.Equal[Maj'Dul]} && ${FP.FileExists["CBProfile-Butcherblock-${strMyName}.xml"]}
				cp "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Butcherblock-${strMyName}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Maj'Dul-${strMyName}.xml"
			elseif ${EQ2.ServerName.Equal[Maj'Dul]} && ${FP.FileExists["CBProfile-Oasis-${strMyName}.xml"]}
				cp "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Oasis-${strMyName}.xml" "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-Maj'Dul-${strMyName}.xml"
			else
			{
				echo ISXRI: CombatBot: Missing "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml" copying over our default CombatBot profile!

				http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-${EQ2.ServerName}-${strMyName}.xml" "http://www.isxri.com/CBProfile-Default-${RI_Var_String_MySubClass}.xml"
				
				wait 50
				if !${FP.FileExists["CBProfile-${EQ2.ServerName}-${strMyName}.xml"]}
				{
					echo ISXRI: CombatBot: Failed to download default profile or download timed out. Please try again or download manually from http://www.isxri.com/ddp.html
					Script:End
				}
				echo Default profile copied, Type CB ImportOgre or CB ImportTHG or import your profile from the respective bot.
			}
		}
	}
	;import ItemEffectPairs file and Iterate through it placing all pertanint information into the index's
	LavishSettings[IEP]:Clear
	LavishSettings:AddSet[IEP]
	LavishSettings[IEP]:Import["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/ItemInformation/Item_Effect_Pairs.xml"]
	variable settingsetref ItemEffectPairsSet=${LavishSettings.FindSet[IEP].GUID}
	ItemEffectPairsSet:Set[${LavishSettings.FindSet[IEP].GUID}]
	variable int ItemEffectPairsCount=${CountSettings.Count[${ItemEffectPairsSet}]}
	ItemEffectPairsCount:Set[${CountSettings.Count[${ItemEffectPairsSet}]}]
	;while ${CountSettings.Count[${ItemEffectPairsSet}]}<1
	;{
	;	echo ItemEffectPairs Set: ${CountSettings.Count[${ItemEffectPairsSet}]}==0
	;	LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/EQ2OgreBot/ItemInformation/Item_Effect_Pairs.xml"]
	;	ItemEffectPairsSet:Set[${LavishSettings.FindSet[IEP].GUID}]
	;	ItemEffectPairsCount:Set[${CountSettings.Count[${ItemEffectPairsSet}]}]
	;	wait 5
	;}
	;echo ItemEffectPairs Set: ${CountSettings.Count[${ItemEffectPairsSet}]}==0  //  ${ItemEffectPairsCount}
	IterateItemEffectPairs ${ItemEffectPairsSet}
	;call echoItemEffectPairs
	
	;import Export file and Iterate through it placing all pertanint information into the index's
	LavishSettings[AI]:Clear
	LavishSettings:AddSet[AI]
	if ${Me.Name.Find[Skyshrine Guardian](exists)}
		LavishSettings[AI]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/skyshrineguardian-AbilityCheck.xml"]
	elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
		LavishSettings[AI]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/skyshrineinfiltrator-AbilityCheck.xml"]
	else
		LavishSettings[AI]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/${RI_Var_String_MySubClass}-AbilityCheck.xml"]
	variable settingsetref ExportSet=${LavishSettings.FindSet[AI].FindSet[${RI_Var_String_MySubClass}].GUID}
	ExportSet:Set[${LavishSettings.FindSet[AI].FindSet[${RI_Var_String_MySubClass}].GUID}]
	variable int ExportCount=${CountSettings.Count[${ExportSet}]}
	ExportCount:Set[${CountSettings.Count[${ExportSet}]}]
	;while ${CountSettings.Count[${ExportSet}]}<1
	;{
		;echo Export Set: ${CountSettings.Count[${ExportSet}]}==0
	;	LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/AI/${RI_Var_String_MySubClass}_AbilityExport.xml"]
	;	ExportSet:Set[${LavishSettings.FindSet[AI].FindSet[${RI_Var_String_MySubClass}].GUID}]
	;	ExportCount:Set[${CountSettings.Count[${ExportSet}]}]
	;	wait 5
	;}
	;echo Export Set: ${CountSettings.Count[${ExportSet}]}==0  //  ${ExportCount}
	IterateExport ${ExportSet} ${ExportCount}
	;call echoExport
	TimedCommand 10 RI_Obj_CB:LoadExport
	
	;call echo
	;import Set
	LavishSettings[Set]:Clear
	LavishSettings:AddSet[Set]
	LavishSettings[Set]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/${ProfileFileName}"]
	
	Set:Set[${LavishSettings.FindSet[Set].FindSet[Profiles].GUID}]
	;variable string CombatBotDefaultProfile=${Set.FindSetting[CombatBotDefaultProfiles]}
	if !${Set.FindSetting[DefaultProfile](exists)}
	{
		echo ISXRI: CombatBot: Error loading Profile, Please try again or redownload/import
		Script:End
	}
	CombatBotDefaultProfile:Set[${Set.FindSetting[DefaultProfile]}]
	variable int SetCount=${CountSettings.Count[${Set}]}
	SetCount:Set[${CountSettings.Count[${Set}]}]
	;echo ${CountSets.Count[${Set}]}
	LavishSettings[Profiles]:Clear
	LavishSettings:AddSet[Profiles]
	LavishSettings[Profiles]:Import["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/${ProfileFileName}"]
	variable settingsetref Set2=${LavishSettings[Profiles].FindSet[Profiles].GUID}
	Set2:Set[${LavishSettings[Profiles].FindSet[Profiles].GUID}]
	CountSets:IterateProfiles[${Set2}]
	;CountSets:EchoProfiles
	declare CombatBotLoading bool script 1
	CountSets:PopulateProfiles
	UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:SelectItem[${UIElement[ProfilesComboBox@BottomFrame@CombatBotUI].ItemByText[${CombatBotDefaultProfile}].ID}]
	deletevariable CombatBotLoading
	CombatBotLoadCastStackExportAbilitiesListBoxOnce
	LoadProfile
	
	;load rimovement if not running
	execute ${If[${Script[Buffer:RIMovement](exists)},noop,RIMovement]}
	
	;echo CombatBot: Waiting to start
	;while !${CombatBotStarted}
	;	wait 1
	;echo starting
	; Added as Part of the AutoAttack Timing Code
	LastAutoAttack:Set[${Script.RunningTime}/1000]
	;Huds
	;CombatBotLoadDistanceHud
	;CombatBotLoadNNHud
	
	;loadrimui or rimobhud
	if ${UIElement[SettingsAutoLoadRIMUICheckBox@SettingsFrame@CombatBotUI].Checked}
		RIMUIObj:RIMUILoad
	
	if ${UIElement[SettingsAutoLoadRIMobHudCheckBox@SettingsFrame@CombatBotUI].Checked} && !${Script[Buffer:RIMobHud](exists)}
		RIMobHud
		
	;RI_CMD_Hidden_GetCharms
	;RI_CMD_Hidden_GetItems
	
	echo ISXRI: CombatBot: v${RI_Var_Float_LocalCBVersion.Precision[2]} Ready
	
	;start RILooter - This is not part of RI
	;RILooter
	
	;start RI_AutoDeity - This is now part of CB
	;RI_AutoDeity
	;TimedCommand 20 RIAutoDeity_ChangeMode 1
	
	variable int i
	for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
	{
		
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709 && ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[1,|].Equal[Run]}
		{
			;echo Executing on Run: ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}
			;noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}]}
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Left[5].Upper.Equal[RELAY]}
			{
				variable int leftnum
				leftnum:Set[${Math.Calc[6+${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Right[-6].Find[" "]}]}]
				noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Left[${leftnum}]} "${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Right[${Math.Calc[-1*${leftnum}]}]}"]}
			}
			else
				noop ${Execute["${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}"]}
		}
	}
	;add summon mount to abilites list box
	;UIElement[CastStackExportAbilitiesListBox@CastStackFrame@CombatBotUI]:AddItem[Summon Mount]
	
	while ${CombatBotStarted}
	{
		while ${Me.IsCamping}
		{
			if ${CombatBotDebug}
				echo CombatBot: Waiting while camping
			wait 10
		}
		while !${Me.InGameWorld}
		{
			if ${CombatBotDebug}
				echo CombatBot: Waiting while not in game world
			wait 10
		}
		while ${Zone.Name.Equal[LoginScene]}
		{
			if ${CombatBotDebug}
				echo CombatBot: Waiting while at LoginScene
			wait 10
		}
		while ${EQ2.Zoning}!=0
		{
			if ${CombatBotDebug}
				echo CombatBot: Waiting while zoning
			wait 10
			;SummonMount:Set[FALSE]
		}
		while ${EQ2.ServerName.Equal[Battlegrounds]} && !${Me.Name.Find[.](exists)}
		{
			if ${CombatBotDebug}
				echo CombatBot: Waiting while in Battlegrounds lobby
			wait 10
		}
		;execute queued commands
		if ${QueuedCommands}
			ExecuteQueued
		;echo before fum
		if ${Me.FlyingUsingMount}
		{
			if ${CombatBotDebug}
					echo CombatBot: Waiting while flying
			wait 1
			continue
		}
		;echo after fum
		;if istrCurses.Used > 0, iterate through it and check if they still are cursed (if cure curse is up)
		if ${istrCurses.Used}>0 && ${Me.Ability[id,969542071].IsReady}
		{
			for(i:Set[1];${i}<=${istrCurses.Used};i:Inc)
			{
				;echo checking ${istrCurses.Get[${i}]} for Curse
				if ${Me.Raid}>0 
				{
					if ${Me.Raid[${istrCurses.Get[${i}]}].Cursed}==1
					{
						;echo yes they are cursed, Curing
						RI_Obj_CB:CastOn[Cure Curse,${istrCurses.Get[${i}]},TRUE]
						break
					}
					else
					{
						;echo not cursed, Removing from index 
						istrCurses:Remove[${i}]
					}
				}
				else
				{
					if ${Me.Group[${istrCurses.Get[${i}]}].Cursed}==1
					{
						;echo yes they are cursed, Curing
						RI_Obj_CB:CastOn[Cure Curse,${istrCurses.Get[${i}]},TRUE]
						break
					}
					else
					{
						;echo not cursed, Removing from index 
						istrCurses:Remove[${i}]
					}
				}
			}
			istrCurses:Collapse
		}
		
		
		;echo main while
		; if ${GetItems}
		; {
			; call GetItemsFn
			; wait 2
			; GetItems:Set[FALSE]
		; }
		; if ${GetCharms}
		; {
			; call GetCharmsFn
			; wait 2
			; GetCharms:Set[FALSE]
		; }
		;wait 1
		;echo while loop
		;echo ${Script.RunningTime}: while loop
		;echo ${Script.RunningTime}
		;for(mainCount:Set[1];${mainCount}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items};mainCount:Inc)
		;mainCount:Set[1]
		;while ${mainCount:Inc}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
		;{
			;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}]}
		;}
		;echo ${Script.RunningTime}
			while ${Me.IsDead} && !${DoCasting}
			{
				if ${CombatBotDebug}
					echo CombatBot: Waiting while dead
				SawCFTime:Set[0]
				CombatBotIDied:Set[TRUE]
				wait 10 !${Me.IsDead}
			}
			;check if we are the same toon and reloadbot
			if ${Me.InGameWorld} && ${Zone.Name.NotEqual[LoginScene]} && ${EQ2.Zoning}==0 && !${Me.IsDead} && ${strMyName.NotEqual[${Me.Name}]}
			{
				if ( ${EQ2.ServerName.Equal[Battlegrounds]} && ${strMyName.NotEqual[${Me.Name}]} && ${Me.Name.Find[.](exists)} ) || ( ${EQ2.ServerName.NotEqual[Battlegrounds]} && ${strMyName.NotEqual[${Me.Name}]} )
				{
					TimedCommand 10 RI_CB
					Script:End
				}
			}
			;do all these checks every .5 secs
			;echo ${Script.RunningTime}: Before Checks
			
			if ${Script.RunningTime}>${Math.Calc[${intTimeChecks}+500]}
			{
				if ${EQ2.Zoning}==0
				{	
					;echo checks
					intTimeChecks:Set[${Script.RunningTime}]
					; if !${RI_Var_Bool_AutoDeityDisabled} && ${Me.GetGameData["Achievement.AvailableDeityPoints"].Label}>${Int[${UIElement[SettingsDeitySpendTextEntry@SettingsFrame@CombatBotUI].Text}]}
					; {	
						; if ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==0
						; {
							; if ${PotencyCount}<=${CritBonusCount} && ${PotencyCount}<=${StaminaCount}
								; call PotencySpender
							; elseif ${CritBonusCount}<=${PotencyCount} && ${CritBonusCount}<=${StaminaCount}
								; call CritBonusSpender
							; elseif ${StaminaCount}<=${PotencyCount} && ${StaminaCount}<=${CritBonusCount}
								; call StaminaSpender
						; }
						; elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==1
						; {
							; call PotencySpender
						; }
						; elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==2
						; {
							; call CritBonusSpender
						; }
						; elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==3
						; {
							; call StaminaSpender
						; }
						; elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==4
						; {
							; if ${PotencyCount}<=${CritBonusCount}
								; call PotencySpender
							; else
								; call CritBonusSpender
						; }
						; elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==5
						; {
							; if ${PotencyCount}<=${StaminaCount}
								; call PotencySpender
							; else
								; call StaminaSpender
						; }
						; elseif ${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].SelectedItem.Value}==6
						; {
							; if ${CritBonusCount}<=${StaminaCount}
								; call CritBonusSpender
							; else
								; call StaminaSpender
						; }
					; }
					if ${Target(exists)} && !${Target.Name(exists)}
						eq2ex target_none
					;if istrConfrontFear.Used > 0, iterate through it and check if they still are cursed (if cure curse is up)
					if ${istrConfrontFear.Used}>0 && ${Me.Ability[id,3601331586].IsReady}
					{
						;get my dirge number
						variable int mydnum
						mydnum:Set[${DirgeNumObj.MyNum}]
						;echo MYdnum = ${mydnum}
						variable int incrementer
						incrementer:Set[1]
						;echo ${i}
						for(i:Set[1];${i}<=${istrConfrontFear.Size};i:Inc)
						{
							if !${istrConfrontFear.Get[${i}](exists)}
								continue
							if ${i}!=${mydnum} || ${i}!=${Math.Calc[${mydnum}*${incrementer}]}
								continue
							;echo checking ${istrConfrontFear.Get[${i}]} for sickness
							;if ${Me.Raid}>0 
							;{
								;if ${Me.Raid[${istrConfrontFear.Get[${i}]}].Arcane}==-1
								;{
									;echo Curing ${istrConfrontFear.Get[${i}]}
									RI_Obj_CB:CastOn[Confront Fear,${istrConfrontFear.Get[${i}]},TRUE]
									
								;}
								;else
								;{
								;	echo not sick, Removing from index ${istrConfrontFear.Get[${i}]}
									istrConfrontFear:Remove[${i}]
									break
								;}
							;}
							incrementer:Inc
						}
					}
					if ${Me.Ability[id,2068098422].IsReady}
						Me.Ability[id,2068098422]:Use
					
					if ${RI_Obj_CB.GetUISetting[SettingsSummonFamiliarCheckBox]} && !${Me.Name.Find["Skyshrine "](exists)}
					{
						;echo We are set to summon familiar and we assume one is equipped
						;echo ${Script.RunningTime}>${Math.Calc[${intTimeChecksSF}+5000]}
						if ${Script.RunningTime}>${Math.Calc[${intTimeChecksSF}+5000]} || ${CombatBotIDied}
						{
							intTimeChecksSF:Set[${Script.RunningTime}]
							;echo it has been more than 5s since last summon familiar or we died
							if !${RIMUIObj.MaintainedEffectExists[Summon Familiar: ]} && ${UIElement[SettingsCastAbilitiesCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								eq2ex summon_familiar
							}
						}
					}
					if ${EQ2.Zoning}==0 && ${CombatBotIDied}
					{
						RI_Var_Bool_FamiliarEquiped:Set[TRUE]
						;echo check for Rev Sick
						if ${SawCFTime}==0 || ${Script.RunningTime}>${Math.Calc[${SawCFTime}+120000]}
						{
							;echo check 2
							variable int CFCounter=0
							for(CFCounter:Set[1];${CFCounter}<=${Me.CountEffects[detrimental]};CFCounter:Inc)
							{
								if ${Me.Effect[detrimental,${CFCounter}].MainIconID}==279 && ${Me.Effect[detrimental,${CFCounter}].BackDropIconID}==315 && ${IWasResed}
								{
									;echo found rev sick
									; variable string CFDesc="${Me.Effect[detrimental,${CFCounter}].Description}"
									; variable int CFDescCount=0
									; while ${CFDescCount:Inc}<5
									; {
										; while ${EQ2.Zoning}!=0
											; wait 5
										; CFDesc:Set["${Me.Effect[detrimental,${CFCounter}].Description}"]
										; wait 5
									; }
									; if ${CFDesc.Find["revived by an ally"](exists)}
									; {
										; echo ${CFDesc}
										while ${EQ2.Zoning}!=0
										{
											if ${CombatBotDebug}
												echo CombatBot: Waiting while zoning
											wait 10
											;SummonMount:Set[FALSE]
										}
										if ${RI_Var_Bool_CB_CallForConfrontFear} && ${UIElement[SettingsCallConfrontFearCheckBox@SettingsFrame@CombatBotUI].Checked}
										{
											if ${Me.Raid}>0
												TimedCommand 10 execute \${If[\${Me.IsDead},noop,eq2execute r ${RI_Var_String_CB_ConfrontFearText}]}
											else
												TimedCommand 10 execute \${If[\${Me.IsDead},noop,eq2execute g ${RI_Var_String_CB_ConfrontFearText}]}
										}	
									;}
									SawCFTime:Set[${Script.RunningTime}]
									IWasResed:Set[FALSE]
									CombatBotIDied:Set[FALSE]
								}
							}
						}
					}
					;do assist checking and stuff
					;echo ${Script.RunningTime}: Before assist Checks
					CheckAssist
					if ${UIElement[SubClassCharmControlCheckBox@SubClassFrame@CombatBotUI].Checked}
						call Charmer
						
					
					;echo ${Script.RunningTime}: after assist Checks
					
					;echo before melee turn on
					;needs to be changed to melee range
					if ${Target.Type.Equal[NPC]} || ${Target.Type.Equal[NamedNPC]} 
					{	
						KillTargetID:Set[${Target.ID}]
						;echo KillTargetID: ${KillTargetID} Name: ${Actor[id,${KillTargetID}]}
						if !${RI_Var_Bool_MoveCBImmunity}
						{
							;move behind
							if ${UIElement[SettingsMoveBehindCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								;echo setup move behind for ${KillTargetID}
								if ${RI_Var_Bool_RIFollowing}
								{
									RI_Var_Bool_RIFollowing:Set[FALSE]
									WasRIFollowing:Set[TRUE]
								}
								if ${Int[${UIElement[SettingsAfterMoveDistanceModTextEntry@SettingsFrame@CombatBotUI].Text}]}!=0 && ${Int[${UIElement[SettingsAfterMoveDistanceModTextEntry@SettingsFrame@CombatBotUI].Text}]}!=${RI_Var_Int_MoveDistanceMod}
								{
									RI_Var_Int_MoveDistanceMod:Set[${Int[${UIElement[SettingsAfterMoveDistanceModTextEntry@SettingsFrame@CombatBotUI].Text}]}]
								}
								if !${RI_Var_Bool_MovingBehind} || ${RI_Var_Int_MoveBehindMobID}!=${KillTargetID} || ( ${RI_Var_Int_MoveBehindHealth}!=${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} && !${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
								{
									if ${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
										RI_Atom_MoveBehind ${Me.Name} ${KillTargetID} ${Int[${UIElement[SettingsMoveDistanceTextEntry@SettingsFrame@CombatBotUI].Text}]} 100
									else
										RI_Atom_MoveBehind ${Me.Name} ${KillTargetID} ${Int[${UIElement[SettingsMoveDistanceTextEntry@SettingsFrame@CombatBotUI].Text}]} ${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]}
									CB_Bool_MoveBehindOn:Set[1]
								}
							}
							elseif ${CB_Bool_MoveBehindOn}
							{
								CB_Bool_MoveBehindOn:Set[0]
								RI_Atom_MoveBehind OFF
								if ${WasRIFollowing}
								{
									RI_Var_Bool_RIFollowing:Set[TRUE]
									WasRIFollowing:Set[FALSE]
								}
							}
							if ${UIElement[SettingsMoveInFrontCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								;echo setup move behind for ${KillTargetID}
								if ${RI_Var_Bool_RIFollowing}
								{
									RI_Var_Bool_RIFollowing:Set[FALSE]
									WasRIFollowing:Set[TRUE]
								}
								if !${RI_Var_Bool_MovingInFront} || ${RI_Var_Int_MoveInFrontMobID}!=${KillTargetID} || ( ${RI_Var_Int_MoveInFrontHealth}!=${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} && !${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
								{
									if ${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
										RI_Atom_MoveInFront ${Me.Name} ${KillTargetID} 30 100
									else
										RI_Atom_MoveInFront ${Me.Name} ${KillTargetID} 30 ${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]}
								}
							}
							elseif ${RI_Var_Bool_MovingInFront}
							{
								
								RI_Atom_MoveInFront OFF
								if ${WasRIFollowing}
								{
									RI_Var_Bool_RIFollowing:Set[TRUE]
									WasRIFollowing:Set[FALSE]
								}
							}
							;movein
							if ${UIElement[SettingsMoveInCheckBox@SettingsFrame@CombatBotUI].Checked} && ( ${Actor[id,${KillTargetID}].Health}<=${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} || ${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
							{
								;setup move in ${KillTargetID}
								noop
							}
						}
						if ${Actor[id,${KillTargetID}].Health}<=${Int[${UIElement[SettingsAttackHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} || ${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
						{
							;boolValidKillTarget:Set[TRUE]
							if !${Me.IsMoving} && ${UIElement[SettingsFaceMobCheckBox@SettingsFrame@CombatBotUI].Checked} && ${FaceNPCNow} && !${Me.FlyingUsingMount} && ( ${EQ2.ServerName.NotEqual[Battlegrounds]} || ${Me.Name.Find[Skyshrine ](exists)} )
								Actor[id,${KillTargetID}]:DoFace
							LastValidTargetTime:Set[${Script.RunningTime}]
							if ${UIElement[SettingsSendPetsCheckBox@SettingsFrame@CombatBotUI].Checked} && !${Me.FlyingUsingMount} && ${Me.Pet(exists)} && ( !${Me.Pet.InCombatMode} || ${Me.Pet.Target.ID}!=${KillTargetID} ) && ( ${Actor[id,${KillTargetID}].Distance}<15 || !${Actor[id,${KillTargetID}].InCombatMode} || !${Actor[id,${KillTargetID}].Target(exists)} )
								eq2execute pet attack
								;eq2execute merc attack
							if ${Script.RunningTime}>${Math.Calc[${LastValidTargetTime}+5000]} && ${UIElement[SettingsSendPetsCheckBox@SettingsFrame@CombatBotUI].Checked} && ${Me.Pet(exists)} && ( !${Me.Pet.InCombatMode} || ${Me.Pet.Target.ID}!=${KillTargetID} || ${Me.Maintained[${RI_Obj_CB.ConvertAbility[Charm]}](exists)} ) && ( ${Actor[id,${KillTargetID}].Distance}<15 || !${Actor[id,${KillTargetID}].InCombatMode} || !${Actor[id,${KillTargetID}].Target(exists)} )
								eq2ex pet attack
								;eq2execute merc attack
							;if our kill target is in combat and more than 15m away, pull pet back
							if ${Actor[id,${KillTargetID}].Distance}>15 && ${Actor[id,${KillTargetID}].InCombatMode} && ${Actor[id,${KillTargetID}].Target(exists)} && ${Me.Pet.InCombatMode} && ${UIElement[SettingsRecallPetsCheckBox@SettingsFrame@CombatBotUI].Checked}
								eq2ex pet backoff
								;eq2ex merc backoff
							if !${Me.Name.Find["Skyshrine "](exists)} && ( ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[id,${Me.ID}].CollisionRadius} * ${Actor[id,${Me.ID}].CollisionScale}) + 6]} || !${UIElement[SettingsMeleeAutoCheckBox@SettingsFrame@CombatBotUI].Checked} ) && ${UIElement[SettingsRangedAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								;echo Target is ranged: ${Target.Distance}>${Math.Calc[${Actor[${Target.ID}].CollisionRadius} * ${Actor[${Target.ID}].CollisionScale} + 6]}
								if !${Me.RangedAutoAttackOn}
								{
									;echo turning on ranged
									eq2execute setautoattackmode 2
									eq2execute togglerangedattack
								}
								elseif ${Me.RangedAutoAttackOn} && !${Actor[id,${KillTargetID}].Target(exists)} && ${Target.ID}==${KillTargetID} && ${Actor[id,${KillTargetID}].Distance}<35 && !${Actor[id,${KillTargetID}].CheckCollision}
								{
									;echo turning off ranged and back on
									eq2execute autoattack 0
									wait 2
									;echo turning on ranged
									eq2execute setautoattackmode 2
									eq2execute togglerangedattack
								}
							}
							elseif ${UIElement[SettingsMeleeAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								;echo Target is melee: ${Target.Distance}>${Math.Calc[${Actor[${Target.ID}].CollisionRadius} * ${Actor[${Target.ID}].CollisionScale} + 6]}
								if !${Me.AutoAttackOn} || ${Me.RangedAutoAttackOn}
								{
									;echo turning on melee
									eq2execute setautoattackmode 1
									eq2execute toggleautoattack
								}
								elseif ${Me.AutoAttackOn} && !${Me.RangedAutoAttackOn} && !${Actor[id,${KillTargetID}].Target(exists)} && ${Target.ID}==${KillTargetID} && ${Actor[id,${KillTargetID}].Distance}<8 && !${Actor[id,${KillTargetID}].CheckCollision}
								{
									;echo turning off ranged and back on
									eq2execute autoattack 0
									wait 2
									;echo turning on melee
									eq2execute setautoattackmode 1
									eq2execute toggleautoattack
								}
							}
							elseif !${UIElement[SettingsMeleeAutoCheckBox@SettingsFrame@CombatBotUI].Checked} && !${UIElement[SettingsRangedAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
									eq2execute autoattack 0
						}
					}
					elseif ${Target.Type.Equal[PC]}
					{
						if ${Target.Target.Type.Equal[NPC]} || ${Target.Target.Type.Equal[NamedNPC]}
						{
							KillTargetID:Set[${Target.Target.ID}]
							if !${RI_Var_Bool_MoveCBImmunity}
							{
								;move behind
								if ${UIElement[SettingsMoveBehindCheckBox@SettingsFrame@CombatBotUI].Checked}
								{
									;echo setup move behind for ${KillTargetID}
									if ${RI_Var_Bool_RIFollowing}
									{
										RI_Var_Bool_RIFollowing:Set[FALSE]
										WasRIFollowing:Set[TRUE]
									}
									if ${Int[${UIElement[SettingsAfterMoveDistanceModTextEntry@SettingsFrame@CombatBotUI].Text}]}!=0 && ${Int[${UIElement[SettingsAfterMoveDistanceModTextEntry@SettingsFrame@CombatBotUI].Text}]}!=${RI_Var_Int_MoveDistanceMod}
									{
										RI_Var_Int_MoveDistanceMod:Set[${Int[${UIElement[SettingsAfterMoveDistanceModTextEntry@SettingsFrame@CombatBotUI].Text}]}]
									}
									if !${RI_Var_Bool_MovingBehind} || ${RI_Var_Int_MoveBehindMobID}!=${KillTargetID}|| ( ${RI_Var_Int_MoveBehindHealth}!=${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} && !${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
									{
										if ${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
											RI_Atom_MoveBehind ${Me.Name} ${KillTargetID} ${Int[${UIElement[SettingsMoveDistanceTextEntry@SettingsFrame@CombatBotUI].Text}]} 100
										else
											RI_Atom_MoveBehind ${Me.Name} ${KillTargetID} ${Int[${UIElement[SettingsMoveDistanceTextEntry@SettingsFrame@CombatBotUI].Text}]} ${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]}
									}
								}
								elseif ${RI_Var_Bool_MovingBehind}
								{
									;echo turning off movebehind
									RI_Atom_MoveBehind OFF
									if ${WasRIFollowing}
									{
										RI_Var_Bool_RIFollowing:Set[TRUE]
										WasRIFollowing:Set[FALSE]
									}
								}
								if ${UIElement[SettingsMoveInFrontCheckBox@SettingsFrame@CombatBotUI].Checked}
								{
									;echo setup move behind for ${KillTargetID}
									if ${RI_Var_Bool_RIFollowing}
									{
										RI_Var_Bool_RIFollowing:Set[FALSE]
										WasRIFollowing:Set[TRUE]
									}
									if !${RI_Var_Bool_MovingInFront} || ${RI_Var_Int_MoveInFrontMobID}!=${KillTargetID} || ( ${RI_Var_Int_MoveInFrontHealth}!=${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} && !${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
									{
										if ${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
											RI_Atom_MoveInFront ${Me.Name} ${KillTargetID} 30 100
										else
											RI_Atom_MoveInFront ${Me.Name} ${KillTargetID} 30 ${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]}
									}
								}
								elseif ${RI_Var_Bool_MovingInFront}
								{
									
									RI_Atom_MoveInFront OFF
									if ${WasRIFollowing}
									{
										RI_Var_Bool_RIFollowing:Set[TRUE]
										WasRIFollowing:Set[FALSE]
									}
								}
								;movein
								if ${UIElement[SettingsMoveInCheckBox@SettingsFrame@CombatBotUI].Checked} && ( ${Actor[id,${KillTargetID}].Health}<=${Int[${UIElement[SettingsMoveHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} || ${UIElement[SettingsSkipMobMoveHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
								{
									;setup move in ${KillTargetID}
									noop
								}
							}
							if ${Actor[id,${KillTargetID}].Health}<=${Int[${UIElement[SettingsAttackHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} || ${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								;boolValidKillTarget:Set[TRUE]
								if !${Me.IsMoving} && ${UIElement[SettingsFaceMobCheckBox@SettingsFrame@CombatBotUI].Checked} && ${FaceNPCNow} &&  ( ${EQ2.ServerName.NotEqual[Battlegrounds]} || ${Me.Name.Find[Skyshrine ](exists)} )
									Actor[id,${KillTargetID}]:DoFace
								LastValidTargetTime:Set[${Script.RunningTime}]
								if ${UIElement[SettingsSendPetsCheckBox@SettingsFrame@CombatBotUI].Checked} && ${Me.Pet(exists)} && ( !${Me.Pet.InCombatMode} || ${Me.Pet.Target.ID}!=${KillTargetID} ) && ( ${Actor[id,${KillTargetID}].Distance}<15 || !${Actor[id,${KillTargetID}].InCombatMode} || !${Actor[id,${KillTargetID}].Target(exists)} )
									eq2execute pet attack
									;eq2execute merc attack
								if ${Script.RunningTime}>${Math.Calc[${LastValidTargetTime}+5000]} && ${UIElement[SettingsSendPetsCheckBox@SettingsFrame@CombatBotUI].Checked} && ${Me.Pet(exists)} && ( !${Me.Pet.InCombatMode} || ${Me.Pet.Target.ID}!=${KillTargetID} || ${Me.Maintained[${RI_Obj_CB.ConvertAbility[Charm]}](exists)} ) && ( ${Actor[id,${KillTargetID}].Distance}<15 || !${Actor[id,${KillTargetID}].InCombatMode} || !${Actor[id,${KillTargetID}].Target(exists)} )
									eq2ex pet attack
									;eq2execute merc attack
								;if our kill target is in combat and more than 15m away, pull pet back
								if ${Actor[id,${KillTargetID}].Distance}>15 && ${Actor[id,${KillTargetID}].InCombatMode} && ${Actor[id,${KillTargetID}].Target(exists)} && ${Me.Pet.InCombatMode} && ${UIElement[SettingsRecallPetsCheckBox@SettingsFrame@CombatBotUI].Checked}
									eq2ex pet backoff
									;eq2ex merc backoff
								if ( ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[id,${Me.ID}].CollisionRadius} * ${Actor[id,${Me.ID}].CollisionScale}) + 6]} || !${UIElement[SettingsMeleeAutoCheckBox@SettingsFrame@CombatBotUI].Checked} ) && ${UIElement[SettingsRangedAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
								{
									;echo Target is ranged: ${Target.Distance}>${Math.Calc[${Actor[${Target.ID}].CollisionRadius} * ${Actor[${Target.ID}].CollisionScale} + 6]}
									if !${Me.RangedAutoAttackOn}
									{
										;echo turning on ranged
										eq2execute setautoattackmode 2
										eq2execute togglerangedattack
									}
									elseif ${Me.RangedAutoAttackOn} && !${Actor[id,${KillTargetID}].Target(exists)} && ${Target.ID}==${KillTargetID}
									{
										;echo turning off ranged and back on
										eq2execute autoattack 0
										wait 2
										;echo turning on ranged
										eq2execute setautoattackmode 2
										eq2execute togglerangedattack
									}
								}
								elseif ${UIElement[SettingsMeleeAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
								{
									;echo Target is melee: ${Target.Distance}>${Math.Calc[${Actor[${Target.ID}].CollisionRadius} * ${Actor[${Target.ID}].CollisionScale} + 6]}
									if !${Me.AutoAttackOn} || ${Me.RangedAutoAttackOn}
									{
										;echo turning on melee
										eq2execute setautoattackmode 1
										eq2execute toggleautoattack
									}
									elseif ${Me.AutoAttackOn} && !${Me.RangedAutoAttackOn} && !${Actor[id,${KillTargetID}].Target(exists)} && ${Target.ID}==${KillTargetID}
									{
										;echo turning off ranged and back on
										eq2execute autoattack 0
										wait 2
										;echo turning on melee
										eq2execute setautoattackmode 1
										eq2execute toggleautoattack
									}
								}
								elseif !${UIElement[SettingsMeleeAutoCheckBox@SettingsFrame@CombatBotUI].Checked} && !${UIElement[SettingsRangedAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
										eq2execute autoattack 0
							}
						}
						elseif ${Script.RunningTime}>${Math.Calc[${LastValidTargetTime}+500]}
						{
							;echo no valid target
							if ${WasRIFollowing}
							{
								RI_Var_Bool_RIFollowing:Set[TRUE]
								WasRIFollowing:Set[FALSE]
							}
							if !${RI_Var_Bool_MoveCBImmunity}
							{
								if ${RI_Var_Bool_MovingBehind}
									RI_Atom_MoveBehind OFF
								if ${RI_Var_Bool_MovingInFront}
									RI_Atom_MoveInFront OFF
							}
							if ${Me.AutoAttackOn} && ${UIElement[SettingsCancelAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
								eq2execute autoattack 0
							if !${Me.InCombat} && !${Me.IsHated} && ${Me.IsInvis} && ${UIElement[SettingsCancelInvisCheckBox@SettingsFrame@CombatBotUI].Checked}
							{
								if ${EQ2.ServerName.Equal[Battlegrounds]}
								{
									Me.Ability[id,1571882540]:Use
									wait 2
									Me.Ability[id,1571882540]:Use
								}
								else
								{
									eq2execute usea Transmute
									wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
									press esc
								}
							}
							;boolValidKillTarget:Set[FALSE]
							KillTargetID:Set[0]
						}
					}
					elseif ${Script.RunningTime}>${Math.Calc[${LastValidTargetTime}+500]}
					{
						;echo no valid target
						if !${RI_Var_Bool_MoveCBImmunity}
						{
							if ${RI_Var_Bool_MovingBehind}
								RI_Atom_MoveBehind OFF
							if ${RI_Var_Bool_MovingInFront}
								RI_Atom_MoveInFront OFF
						}
						if ${WasRIFollowing}
						{
							RI_Var_Bool_RIFollowing:Set[TRUE]
							WasRIFollowing:Set[FALSE]
						}
						if ${Me.AutoAttackOn} && ${UIElement[SettingsCancelAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
							eq2execute autoattack 0
						if !${Me.InCombat} && !${Me.IsHated} && ${Me.IsInvis} && ${UIElement[SettingsCancelInvisCheckBox@SettingsFrame@CombatBotUI].Checked}
						{
							if ${EQ2.ServerName.Equal[Battlegrounds]}
							{
								Me.Ability[id,1571882540]:Use
								wait 2
								Me.Ability[id,1571882540]:Use
							}
							else
							{
								eq2execute usea Transmute
								wait 10 ${EQ2.ReadyToRefineTransmuteOrSalvage}
								press esc
							}
						}
						KillTargetID:Set[0]
						;boolValidKillTarget:Set[FALSE]
						if ${Target.Type.Equal[Pet]}
						{
							eq2execute target_none
						}
					}
					;if our kill target is in combat and more than 15m away, pull pet back
					if ${Actor[id,${KillTargetID}].Distance}>15 && ${Actor[id,${KillTargetID}].InCombatMode} && ${Actor[id,${KillTargetID}].Target(exists)} && ${Me.Pet.InCombatMode} && ${UIElement[SettingsRecallPetsCheckBox@SettingsFrame@CombatBotUI].Checked}
						eq2ex pet backoff
				}
			}
			;echo after melee turn on
			
			; if ${DoCasting}
			; {
				; echo DOCasting Called, continuing loop from begining
				; mainCount:Set[1]
				; continue
			; }
			; if !${Me.InCombat} || !${Me.IsHated}
			; {	
				; echo i am not in combat leaving for loop
				; wait 1
				; mainCount:Set[${Math.Calc[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}+1]}]
				; continue
			; }
			;echo after moving check
			;if ${istrAbilityType.Get[${mainCount}].Equal[Cure]} || ${istrAbilityType.Get[${mainCount}].Equal[Heal]} || ${istrAbilityType.Get[${mainCount}].Equal[Power]} || ${istrAbilityType.Get[${mainCount}].Equal[InCombatTargeted]} || ${istrAbilityType.Get[${mainCount}].Equal[NamedHostile]} || ${istrAbilityType.Get[${mainCount}].Equal[Buff]} || ${istrAbilityType.Get[${mainCount}].Equal[Res]} || (${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}]}>0 && ${istrAbilityIgnoreDuration.Get[${mainCount}].Equal[FALSE]}) || ${istrAbilityIsItem.Get[${mainCount}].Equal[TRUE]}
			;{
				;echo item needs to be waited on
				;	
				;	
				;	
				;here need to add check if the target of the spell is valid, then wait
				;
				;
				;
				;if ${istrAbilityDisabled.Get[${mainCount}].Equal[FALSE]} && ( ${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}]}].IsReady} && ${istrAbilityIsItem.Get[${mainCount}].Equal[FALSE]} ) || ( ${istrAbilityIsItem.Get[${mainCount}].Equal[TRUE]} && ${ItemEquiped} && ${Me.Equipment["${istrAbilityItemName.Get[${mainCount}]}"].TimeUntilReady}<=0 ) || ( ${istrAbilityIsItem.Get[${mainCount}].Equal[TRUE]} && !${ItemEquiped} && ${Me.Inventory["${istrAbilityItemName.Get[${mainCount}]}"].TimeUntilReady}<=0 )
				;{
				;	echo waiting
				;	eq2execute clearabilityqueue
				;	wait 100 !${Me.CastingSpell} || ${DoCasting}
				;}
				;echo done waiting
			;}
			;echo CheckAbility ${mainCount}
			;echo ${Script.RunningTime} Before CheckAbility
			if !${UIElement[SettingsCastAbilitiesCheckBox@SettingsFrame@CombatBotUI].Checked}
			{
				waitframe
				continue
			}
			;echo before do casting
			if ${DoCasting}
			{
				if ${boolCancelCast}
				{
					;echo cancelling cast
					variable int CancelCastCnt
					while ${Me.CastingSpell} && ${CancelCastCnt:Inc}<=5
					{
						eq2execute cancel_spellcast
						eq2execute clearabilityqueue
						wait 2
					}
				}
				else
					wait 100 !${Me.CastingSpell}
				;echo call CastAb "${strDoCastName}" ${strDoCastID} ${strDoCastTarget}
				if ${DoCastingItem}
					call CastItemFN "${strDoCastName}"
				else
					call CastAb "${strDoCastNameShort}" "${strDoCastName}" ${strDoCastID} ${strDoCastTarget}
				;wait 200
			}
			;echo ${Script.RunningTime} After DoCasting
			
			if ${boolAbilityCast} 
			{
				if ${Me.CastingSpell}
				{
					wait 100 !${Me.CastingSpell} || ${DoCasting}
					;wait 2
				}
				if ${RI_Var_String_MySubClass.Equal[inquisitor]} && ${UIElement[SubClassInqVerdictCheckBox@SubClassFrame@CombatBotUI].Checked}
				{
					;check if verdict is ready
					if ${Me.Ability[id,3138602103].IsReady}
					{
						if ${RI_Var_Bool_Debug}
							echo CombatBot: Verdict is Ready, Checking my KillTarget: ${Actor[id,${KillTargetID}].Name} / Health: ${Actor[id,${KillTargetID}].Health}, Epic: ${Actor[id,${KillTargetID}].IsEpic}, Heroic: ${Actor[id,${KillTargetID}].IsHeroic}
						;check mob's difficulty and health
						if ${Actor[id,${KillTargetID}].IsEpic} && ${Actor[id,${KillTargetID}].Health}<=3
						{
							if ${RI_Var_Bool_Debug}
								echo CombatBot: My KillTarget: ${Actor[id,${KillTargetID}].Name} is Epic: ${Actor[id,${KillTargetID}].IsEpic and is below 4 Health, Casting Verdict
							;cast Verdict
							call CastAb Verdict Verdict 3138602103
						}
						if ${Actor[id,${KillTargetID}].IsHeroic} && ${Actor[id,${KillTargetID}].Health}<=12
						{
							if ${RI_Var_Bool_Debug}
								echo CombatBot: My KillTarget: ${Actor[id,${KillTargetID}].Name} is Heroic: ${Actor[id,${KillTargetID}].IsHeroic and is below 13 Health, Casting Verdict
							
							;cast Verdict
							call CastAb Verdict Verdict 3138602103
						}
					}
				}
				if ${DoCasting}
				{
					waitframe
					continue
				}
				if ${boolPreCast}
				{
					if ${CombatBotDebug}
						echo CombatBot: PreCasting ${strPreCastNameShort}
					call CastAb "${strPreCastNameShort}" "${strPreCastName}" ${strPreCastID} FALSE
					if ${Me.CastingSpell}
					{
						wait 100 !${Me.CastingSpell} || ${DoCasting}
						
					}
				}
				;echo call CastAb "${strCastNameShort}" "${strCastName}" ${strCastID} ${strCastTarget}
				call CastAb "${strCastNameShort}" "${strCastName}" ${strCastID} ${strCastTarget}
				if ${boolPostCast}
				{
					if ${Me.CastingSpell}
					{
						wait 100 !${Me.CastingSpell} || ${DoCasting}
						;wait 2
					}
					if ${CombatBotDebug}
						echo CombatBot: PostCasting ${strPreCastNameShort}
					call CastAb "${strPostCastNameShort}" "${strPostCastName}" ${strPostCastID} FALSE
				}
			}
			;elseif ${Return.Equal[2]}
			elseif ${boolItemCast}
				call CastItemFN "${strCastName}" ${strCastTarget}
			;elseif ${Script.RunningTime}>${Math.Calc[${CheckAbilitiesTime}+250]} || ${CheckAbilitiesTime}==0
			;{
				;variable bool boolAbilityFound
				;boolAbilityFound:Set[FALSE]
				;echo  ${Script.RunningTime} / ${CheckAbilitiesTime} ${CheckAbilitiesObj.CheckAll} 
				; while ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}>${Math.Calc[${mainCount}+10]}
				; {
					; if ${CheckAbilitiesObj.CheckAll[${mainCount},${Math.Calc[${mainCount}+10]}]}
					; {
						; boolAbilityFound:Set[TRUE]
						; CheckAbilitiesTime:Set[${Script.RunningTime}]
						; break
					; }
					;;waitframe
					;;echo InBetween / ${boolAbilityFound} / ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}>=${Math.Calc[${mainCount}+10]}
				; }
				;echo after csting
				;echo ${boolAbilityFound} / ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}>${mainCount}
				;if !${boolAbilityFound} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}>=${mainCount}
				;{
					;echo InBetween - Last
				
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}>0
				{
					;echo mainCount=${mainCount}
					;if !${CheckAbilitiesObj.CheckAll[${mainCount},${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}]}
					noop !${CheckAbilitiesObj.CheckAll[${mainCount},${Math.Calc[${mainCount}+50]}]}
					; {
						; wait 5
						; mainCount:Set[1]
					; }
					if ${mainCount}>${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
					{
						wait 3
						mainCount:Set[1]
					}
					;continue
					; while !${CheckAbilitiesObj.CheckAll[${mainCount},${mainCount}]} && ${mainCount}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
					; {
						; ; if ${CombatBotDebug}
							; ; echo CombatBot: CheckAbilities Counter: ${mainCount}
						; ; if ${SummonMount} && ${Me.GetGameData[Self.ZoneName].Label.NotEqual[The Frillik Tide]} && ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Vaedenmoor, Realm of Despair"]} && ${Me.GetGameData[Self.ZoneName].Label.NotEqual[Ceremony in The Wastes`]}
						; ; {
							; ; wait 5
							; ; if !${Me.OnHorse} && !${Me.OnFlyingMount} && ${Me.GetGameData[Self.ZoneName].Label.NotEqual[The Frillik Tide]}
							; ; {
								; ; eq2ex summon_mount
								; ; wait 5
							; ; }
							; ; SummonMount:Set[FALSE]
						; ; }
						; noop
					; }
					; if ${mainCount}>${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
					; {
						; mainCount:Set[1]
						; wait 1
					; }
					;echo after that ${Script.RunningTime}
					;if ${CheckAbilitiesObj.CheckAll[${mainCount},${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}]}
					;{
					;	;CheckAbilitiesTime:Set[${Script.RunningTime}]
					;	noop
					;}
					;else
					;{
				;		;CheckAbilitiesTime:Set[${Math.Calc[${Script.RunningTime}+250]}]
				;		wait 5
				;		mainCount:Set[1]
					;}
				}
				;elseif !${boolAbilityFound}
				;;	mainCount:Set[1]
				;echo after checkab
				;if ${Script.RunningTime}>${Math.Calc[${LastFaceTime}+250]} || ${LastFaceTime}==0
				;{
				;	if ${Actor[id,${KillTargetID}](exists)} && ${FaceNPC.Equal[TRUE]} && ${FaceNPCNow}
				;	{
				;		Actor[${KillTargetID}]:DoFace
				;		LastFaceTime:Set[${Script.RunningTime}]
				;	}
				;}
			;}
			;echo ${Return}
			;if ${CombatBotDebug}
			;	wait 1
			;waitframe
			;CombatBotDebug:Set[TRUE]
		;}
		;echo before casting check
		if ${Me.CastingSpell}
		{
			wait 100 !${Me.CastingSpell} || ${DoCasting}
			;wait 2
		}
		;echo after casting check
		;elseif ${mainCount}>${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
		;{
			;echo ${mainCount}>${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
		;	wait 5
		;}
		waitframe
		;echo end while loop
	}
}
function PotencySpender()
{
	;if ${ADDebug.Upper.NotEqual[SILENT]}
		echo ISXRI: Spending 1 point into Potency
	eq2ex spend_deity_point 2951281460 1
	;wait 5
	;ChoiceWindow:DoChoice1
	wait 5
	PotencyCount:Inc
}

function CritBonusSpender()
{
	;if ${ADDebug.Upper.NotEqual[SILENT]}
		echo ISXRI: Spending 1 point into Crit Bonus
	eq2ex spend_deity_point 2479066486 1
	;wait 5
	;ChoiceWindow:DoChoice1
	wait 5
	CritBonusCount:Inc
}

function StaminaSpender()
{
	;if ${ADDebug.Upper.NotEqual[SILENT]}
		echo ISXRI: Spending 1 point into Stamina
	eq2ex spend_deity_point 958976882 1
	;wait 5
	;ChoiceWindow:DoChoice1
	wait 5
	StaminaCount:Inc
}
; atom(global) RIAutoDeity_ChangeMode(int _Mode=0)
; {
	; if ${_Mode}>-1
	; {
		; RI_Var_Bool_AutoDeityDisabled:Set[0]
		; UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI]:SelectItem[${UIElement[SettingsDeityComboBox@SettingsFrame@CombatBotUI].ItemByValue[${_Mode}].ID}]
	; }
	; else 
		; RI_Var_Bool_AutoDeityDisabled:Set[1]
	; if ${_Mode}==-1
	; {
		; echo ISXRI: AutoDeity: Disabled
	; }
	; if ${_Mode}==0
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Balance ALL
	; }
	; elseif ${_Mode}==1
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Spend all points in Potency
	; }
	; elseif ${_Mode}==2
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Spend all points in Crit Bonus
	; }
	; elseif ${_Mode}==3
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Spend all points in Stamina
	; }
	; elseif ${_Mode}==4
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Balance Only Potency and Crit Bonus
	; }
	; elseif ${_Mode}==5
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Balance Only Potency and Stamina
	; }
	; elseif ${_Mode}==6
	; {
		; echo ISXRI: AutoDeity: Changing mode to: Balance Only Crit Bonus and Stamina
	; } 
; }
objectdef DirgeNumberObject
{
	member:int MyNum()
	{
		;set me to the first element in istrDirges
		variable index:string istrDirges
		istrDirges:Insert[${Me.Name}]
		variable int count=0
		variable int count2=0
		variable int mynum=0
		declare temp string
		
		;set Dirges in Dirge index
		for(count:Set[1];${count}<=${Me.Raid};count:Inc)
		{
			if ${Me.Raid[${count}].Name.NotEqual[${Me.Name}]}
			{
				;echo ${Time}: Checking ${Me.Raid[${count}]} to see if they are a Dirge / ${Me.Raid[${count}].Class}
				if ${Me.Raid[${count}].Class.Equal[dirge]} 
				{
					;echo ${Time}: Found a Dirge in Raid Position ${count} / ${Me.Raid[${count}]}
					istrDirges:Insert[${Me.Raid[${count}]}]
				}
			}
		}
		
		;sort Dirge index by alpha
		for(count:Set[1];${count}<=${istrDirges.Used};count:Inc)
		{
			for(count2:Set[1];${count2}<=${istrDirges.Used};count2:Inc)
			{
				if ${istrDirges.Get[${count2}].Compare[${istrDirges.Get[${count}]}]}>0
				{
					temp:Set[${istrDirges.Get[${count}]}]
					istrDirges:Set[${count},${istrDirges.Get[${count2}]}]
					istrDirges:Set[${count2},${temp}]
				}
			}
		}
		;temp:Set["echo ${Time}: There are ${istrDirges.Used} Dirge's and the Order is As Follows: "]
		for(count:Set[1];${count}<=${istrDirges.Used};count:Inc)
		{
			;echo checking ${count} : ${istrDirges.Get[${count}]}
			;temp:Concat["${istrDirges.Get[${count}]} / "]
			if ${istrDirges.Get[${count}].Equal[${Me.Name}]}
			{
				;echo me
				mynum:Set[${count}]
				;echo mynum set to ${mynum}
			}
		}
		;execute "${temp}"
		return ${mynum}
	}
}
objectdef CalcAutoAttackTimerObject
{
	member:float Calc()
	{
		if !${AutoAttackReady}
		{
			if ${Me.RangedAutoAttackOn}
				PrimaryDelay:Set[${Me.GetGameData[Stats.Ranged_Delay].Label}]
			else
				PrimaryDelay:Set[${Me.GetGameData[Stats.Primary_Delay].Label}]
				
			RunningTimeInSeconds:Set[${Script.RunningTime}/1000]
			TimeUntilNextAutoAttack:Set[${PrimaryDelay}-(${RunningTimeInSeconds}-${LastAutoAttack})]
		}

		if ${TimeUntilNextAutoAttack} < 0 && !${AutoAttackReady}
		{
			;echo AutoAttackReady: TRUE
			AutoAttackReady:Set[TRUE]
		}
		if ${TimeUntilNextAutoAttack} < 0
			return 0
		else
			return ${TimeUntilNextAutoAttack}
	}
}
function Charmer()
{
	if ${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items}==0
		return
    if ${Me.SubClass.NotEqual[coercer]} && ${Me.SubClass.NotEqual[troubador]} && ${Me.SubClass.NotEqual[warden]}
        return
    
	if !${Me.InCombat}
		return
	
	;echo charmer

	variable bool RangedAuto=${RI_Obj_CB.GetUISetting[SettingsRangedAutoCheckBox]}
	variable bool MeleeAuto=${RI_Obj_CB.GetUISetting[SettingsMeleeAutoCheckBox]}
	variable bool SendPets=${RI_Obj_CB.GetUISetting[SettingsSendPetsCheckBox]}
	variable bool Assisting=${RI_Obj_CB.GetUISetting[SettingsAssistingCheckBox]}
	;variable index:actor ActorIndex
	variable string BuiltQuery
    ;now build our query
    BuiltQuery:Set["( Type=="NPC" || Type=="NamedNPC" ) && CheckCollision=FALSE && IsEpic=FALSE && IsDead=FALSE && Distance<=25 && ( "]

    variable int _count
    for(_count:Set[1];${_count}<=${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items};_count:Inc)
    {
		if ${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].OrderedItem[${_count}].TextColor}!=-10263709
		{
			BuiltQuery:Concat["Name=-\"${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].OrderedItem[${_count}]}\""]
			if ${_count}<${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items}
				BuiltQuery:Concat[" || "]
		}
		elseif ${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].OrderedItem[${_count}].TextColor}==-10263709 && ${_count}==${UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI].Items}
		{
			BuiltQuery:Set[${BuiltQuery.Left[-4]}]
		}
    }
    BuiltQuery:Concat[" )"]
 
	;echo ${BuiltQuery}

	variable string _CharmID
	variable string _CharmName
	
	if ${Me.SubClass.Equal[coercer]}
	{
		_CharmID:Set[${RI_Obj_CB.ConvertAbilityID[Charm]}]
		_CharmName:Set["${RI_Obj_CB.ConvertAbility[Charm]}"]
	}
	elseif ${Me.SubClass.Equal[troubador]}
	{
		_CharmID:Set[${RI_Obj_CB.ConvertAbilityID[Bria's Entrancing Sonnet]}]
		_CharmName:Set["${RI_Obj_CB.ConvertAbility[Bria's Entrancing Sonnet]}"]
	}
	elseif ${Me.SubClass.Equal[warden]}
	{
		_CharmID:Set[${RI_Obj_CB.ConvertAbilityID[Charm Creature]}]
		_CharmName:Set["${RI_Obj_CB.ConvertAbility[Charm Creature]}"]
	}

	if !${Me.Maintained[${_CharmName}](exists)} && ( ${Me.Ability[id,${_CharmID}].IsReady} || ${Me.Maintained[Possess Essence](exists)} )
	{
		variable int _CharmMobID
		;EQ2:QueryActors[ActorIndex,${BuiltQuery}]
		;echo \${Actor[Query,${BuiltQuery}](exists)} // ${Actor[Query,${BuiltQuery}](exists)}
		if ${Actor[Query,${BuiltQuery}](exists)}
			_CharmMobID:Set[${Actor[Query,${BuiltQuery}].ID}]
		;echo ${ActorIndex.Used}
		if ${Actor[Query, ID=${_CharmMobID} && IsDead=FALSE](exists)} && !${Me.Maintained[${_CharmName}](exists)} && ( ${Me.Ability[id,${_CharmID}].IsReady} || ${Me.Maintained[Possess Essence](exists)} )
		{
			;turn off pet, attack and abilities in combatbot and kill our essence
			RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,FALSE]
		   
			if ${RangedAuto}
				RI_Obj_CB:SetUISetting[SettingsRangedAutoCheckBox,FALSE]
			   
			if ${MeleeAuto}
				RI_Obj_CB:SetUISetting[SettingsMeleeAutoCheckBox,FALSE]
			   
			if ${SendPets}
				RI_Obj_CB:SetUISetting[SettingsSendPetsCheckBox,FALSE]
			   
			if ${Assisting}
				RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,FALSE]
			if ${Me.SubClass.Equal[coercer]}
				Me.Maintained[Possess Essence]:Cancel
			;target first mob in index
			;Actor[id,${ActorIndex.Get[1].ID}]:DoTarget
			if ${Target.ID}!=${_CharmMobID}
				Actor[Query, ID=${_CharmMobID} && IsDead=FALSE]:DoTarget
			eq2ex cancel_spellcast
			wait 2
			;cast charm
			while ${Me.Ability[id,${_CharmID}].IsReady} && ${Actor[Query, ID=${_CharmMobID} && IsDead=FALSE](exists)}
			{
				if ${Target.ID}!=${_CharmMobID}
					Actor[Query, ID=${_CharmMobID} && IsDead=FALSE]:DoTarget
				Me.Ability[id,${_CharmID}]:Use
				wait 5 ${Me.CastingSpell}
				wait 50 !${Me.CastingSpell}
			}
		   
			RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,TRUE]
		   
			if ${RangedAuto}
				RI_Obj_CB:SetUISetting[SettingsRangedAutoCheckBox,TRUE]
			   
			if ${MeleeAuto}
				RI_Obj_CB:SetUISetting[SettingsMeleeAutoCheckBox,TRUE]
			   
			if ${SendPets}
				RI_Obj_CB:SetUISetting[SettingsSendPetsCheckBox,TRUE]
		   
			if ${Assisting}
				RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,TRUE]
		}
	}
}
atom LoadProfile(string _Profile=${CombatBotDefaultProfile})
{

	;clear Indexs
	istrAbilities:Clear
	istrAbilityExportPosition:Clear
	istrAbilityType:Clear
	istrAbilityTarget:Clear
	istrAbility%:Clear
	istrAbility#:Clear
	istrAbilityIgnoreDuration:Clear
	istrAbilityIE:Clear
	istrAbilityIAE:Clear
	istrAbilityIsItem:Clear
	istrAbilityItemName:Clear
	istrAbilityRIE:Clear
	istrAbilityDisabled:Clear
	istrAbilityMax:Clear
	istrAbilitySavagery:Clear
	istrAbilityDissonanceLess:Clear
	istrAbilityDissonanceGreater:Clear
	istrAlias:Clear
	istrAliasName:Clear
	istrPreCastDisabled:Clear
	istrPreCastAbility:Clear
	istrPreCastAbilityOn:Clear
	istrPreCastAbilityExportPosition:Clear
	istrPostCastDisabled:Clear
	istrPostCastAbility:Clear
	istrPostCastAbilityAfter:Clear
	istrPostCastAbilityExportPosition:Clear
	istrAnnounceAbility:Clear
	istrAnnounceText:Clear
	istrAnnounceTarget:Clear
	istrAnnounceDisabled:Clear
	istrInvisAbilitiesAbility:Clear
	istrInvisAbilitiesAbilityExportPosition:Clear
	istrInvisAbilitiesDisabled:Clear
	
	echo ISXRI: CombatBot: Loading ${RI_Var_String_MySubClass} Profile: ${_Profile}
;	for ${strMyName} at Level: ${intMyLevel}
;	echo CombatBot: Loading Profile:
	;import CastStackSet
	UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI]:ClearItems
	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	variable settingsetref CastStackSet=${Set.FindSet[${_Profile}].FindSet[CastStack].GUID}
	CastStackSet:Set[${Set.FindSet[${_Profile}].FindSet[CastStack].GUID}]
	variable int CastStackCount=0
	CastStackCount:Set[${CountSets.Count[${CastStackSet}]}]
	;echo ${CountSets.Count[${CastStackSet}]}
	;while ${CountSets.Count[${CastStackSet}]}<1
	;{
	;	echo CastStackSet: ${CountSets.Count[${CastStackSet}]}==0
	;	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	;	CastStackSet:Set[${Set.FindSet[${_Profile}].FindSet[CastStack].GUID}]
	;	CastStackCount:Set[${CountSets.Count[${CastStackSet}]}]
	;	wait 5
	;}
	;echo CastStackSet: ${CastStackSet}
	IterateCastStack ${CastStackSet} ${CastStackCount}
	;echo ${Set.FindSet[${_Profile}].FindSet[CastStack].FindSet[1].FindSetting[__SourceName]}
	;echo ${CastStackSet.FindSet[1].FindSetting[__SourceName]}
	;echo ${CastStackCount}
		
	;import PrePostCastSet
	UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI]:ClearItems
	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	variable settingsetref PrePostCastSet=${Set.FindSet[${_Profile}].FindSet[PrePostCast].GUID}
	PrePostCastSet:Set[${Set.FindSet[${_Profile}].FindSet[PrePostCast].GUID}]
	variable int PrePostCastCount=${CountSets.Count[${PrePostCastSet}]}
	PrePostCastCount:Set[${CountSets.Count[${PrePostCastSet}]}]
	IteratePrePostCast ${PrePostCastSet} ${PrePostCastCount}


	;import AnnounceSet
	UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI]:ClearItems
	variable settingsetref AnnounceSet=${Set.FindSet[${_Profile}].FindSet[Announce].GUID}
	AnnounceSet:Set[${Set.FindSet[${_Profile}].FindSet[Announce].GUID}]
	variable int AnnounceCount=${CountSets.Count[${AnnounceSet}]}
	AnnounceCount:Set[${CountSets.Count[${AnnounceSet}]}]
	IterateAnnounce ${AnnounceSet} ${AnnounceCount}
	;echo ${Set.FindSet[${_Profile}].FindSet[Announce].FindSet[1].FindSetting[__SourceName]}
	;echo ${AnnounceSet.FindSet[1].FindSetting[__SourceName]}
	;echo ${AnnounceCount}
	;call echoAnnounce
	
	;import ItemsSet
	UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI]:ClearItems
	variable settingsetref ItemsSet=${Set.FindSet[${_Profile}].FindSet[Items].GUID}
	ItemsSet:Set[${Set.FindSet[${_Profile}].FindSet[Items].GUID}]
	variable int ItemsCount=${CountSets.Count[${ItemsSet}]}
	ItemsCount:Set[${CountSets.Count[${ItemsSet}]}]
	IterateItems ${ItemsSet} ${ItemsCount}
	;echo ${Set.FindSet[${_Profile}].FindSet[Announce].FindSet[1].FindSetting[__SourceName]}
	;echo ${ItemsSet.FindSet[1].FindSetting[__SourceName]}
	;echo ${ItemsCount}
	
	;import CharmSet
	UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI]:ClearItems
	variable settingsetref CharmSet=${Set.FindSet[${_Profile}].FindSet[Charm].GUID}
	CharmSet:Set[${Set.FindSet[${_Profile}].FindSet[Charm].GUID}]
	variable int CharmCount=${CountSets.Count[${CharmSet}]}
	CharmCount:Set[${CountSets.Count[${CharmSet}]}]
	if ${CharmSet.FindSetting[CharmControl]}
		UIElement[SubClassCharmControlCheckBox@SubClassFrame@CombatBotUI]:SetChecked 
	IterateCharm ${CharmSet} ${CharmCount}
	;echo ${Set.FindSet[${_Profile}].FindSet[Announce].FindSet[1].FindSetting[__SourceName]}
	;echo ${ItemsSet.FindSet[1].FindSetting[__SourceName]}
	;echo ${ItemsCount}
	
	;import VerdictSet
	variable settingsetref VerdictSet=${Set.FindSet[${_Profile}].FindSet[Verdict].GUID}
	VerdictSet:Set[${Set.FindSet[${_Profile}].FindSet[Verdict].GUID}]
	if ${VerdictSet.FindSetting[CastVerdict]}
		UIElement[SubClassInqVerdictCheckBox@SubClassFrame@CombatBotUI]:SetChecked 
	
	;variable settingsetref EquipmentInfoSet=${Set.FindSet[${_Profile}].FindSet[EquipmentInfo].GUID}
	;EquipmentInfoSet:Set[${Set.FindSet[${_Profile}].FindSet[EquipmentInfo].GUID}]
	;variable int EquipmentInfoCount=${CountSets.Count[${EquipmentInfoSet}]}
	;EquipmentInfoCount:Set[${CountSets.Count[${EquipmentInfoSet}]}]
	;echo ${EquipmentInfoCount}
	RI_Var_String_Charm_1:Set[${Set.FindSet[${_Profile}].FindSet[CharmSwap].FindSetting[CharmSwapCharm1ComboBox].String.Right[-5]}]
	RI_Var_String_Charm_2:Set[${Set.FindSet[${_Profile}].FindSet[CharmSwap].FindSetting[CharmSwapCharm2ComboBox].String.Right[-5]}]
	;echo CombatBot: Setting ${RI_Var_String_Charm_1} To: RI_Var_String_Charm_1
	;echo CombatBot: Setting ${RI_Var_String_Charm_2} To: RI_Var_String_Charm_2
	UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI]:SelectItem[${UIElement[CharmSwapCharm1ListBox@CharmSwapFrame@CombatBotUI].ItemByText[${RI_Var_String_Charm_1}].ID}]
	UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI]:SelectItem[${UIElement[CharmSwapCharm2ListBox@CharmSwapFrame@CombatBotUI].ItemByText[${RI_Var_String_Charm_2}].ID}]
	;import InvisAbilitiesSet
	UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI]:ClearItems
	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	variable settingsetref InvisAbilitiesSet=${Set.FindSet[${_Profile}].FindSet[InvisAbilities].GUID}
	InvisAbilitiesSet:Set[${Set.FindSet[${_Profile}].FindSet[InvisAbilities].GUID}]
	variable int InvisAbilitiesCount=${CountSets.Count[${InvisAbilitiesSet}]}
	InvisAbilitiesCount:Set[${CountSets.Count[${InvisAbilitiesSet}]}]
	;echo ${InvisAbilitiesCount}
	IterateInvisAbilities ${InvisAbilitiesSet} ${InvisAbilitiesCount}
	;ConvertInvisAbilitiesAbilities
	;call echoInvisAbilities
	
	;import AliasSet
	UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI]:ClearItems
	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	variable settingsetref AliasSet=${Set.FindSet[${_Profile}].FindSet[Aliases].GUID}
	AliasSet:Set[${Set.FindSet[${_Profile}].FindSet[Aliases].GUID}]
	variable int AliasesCount=${CountSets.Count[${AliasSet}]}
	AliasesCount:Set[${CountSets.Count[${AliasSet}]}]
	;while ${CountSets.Count[${AliasSet}]}<1
	;{
		;echo AliasSet: ${CountSets.Count[${AliasSet}]}==0
	;	LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	;	AliasSet:Set[${Set.FindSet[${_Profile}].FindSet[Aliases].GUID}]
	;	AliasesCount:Set[${CountSets.Count[${AliasSet}]}]
	;	wait 5
	;}
	
	;echo AliasSet: ${CountSets.Count[${AliasSet}]}==0
	IterateAliases ${AliasSet} ${AliasesCount}
	;echo ${AliasesCount}
	;now we done adding aliases to assist add the rest of our raid
	TimedCommand 10 RI_Obj_CB:AssistLoadRaidGroupList
	
	
	;import AssistSet
	UIElement[AssistAddedListBox@AssistFrame@CombatBotUI]:ClearItems
	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	variable settingsetref AssistSet=${Set.FindSet[${_Profile}].FindSet[Assist].GUID}
	AssistSet:Set[${Set.FindSet[${_Profile}].FindSet[Assist].GUID}]
	variable int AssistCount=${CountSets.Count[${AssistSet}]}
	AssistCount:Set[${CountSets.Count[${AssistSet}]}]
	;echo AssistSet: ${CountSets.Count[${AssistSet}]}==0
	IterateAssist ${AssistSet} ${AssistCount}
	;echo ${AssistCount}
	
	;import OnEventsSet
	UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI]:ClearItems
	;LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
	variable settingsetref OnEventsSet=${Set.FindSet[${_Profile}].FindSet[OnEvents].GUID}
	OnEventsSet:Set[${Set.FindSet[${_Profile}].FindSet[OnEvents].GUID}]
	variable int OnEventsCount=${CountSets.Count[${OnEventsSet}]}
	OnEventsCount:Set[${CountSets.Count[${OnEventsSet}]}]
	;echo OnEventsSet: ${CountSets.Count[${OnEventsSet}]}==0
	IterateOnEvents ${OnEventsSet} ${OnEventsCount}
	;echo ${OnEventsCount}
	
	;import SettingsSet
	variable settingsetref SettingsSet=${Set.FindSet[${_Profile}].FindSet[Settings].GUID}
	
	SettingsSet:Set[${Set.FindSet[${_Profile}].FindSet[Settings].GUID}]

	;grab all the settings and set the ui
	RI_Obj_CB:SetUISetting[SettingsRangedAutoCheckBox,${SettingsSet.FindSetting[SettingsRangedAutoCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsMeleeAutoCheckBox,${SettingsSet.FindSetting[SettingsMeleeAutoCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCancelAutoCheckBox,${SettingsSet.FindSetting[SettingsCancelAutoCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsTimeAutoCheckBox,${SettingsSet.FindSetting[SettingsTimeAutoCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsSkipMobAttackHealthCheckBox,${SettingsSet.FindSetting[SettingsSkipMobAttackHealthCheckBox]}]
	if ${SettingsSet.FindSetting[SettingsMoveDistanceTextEntry](exists)}
		RI_Obj_CB:SetUISetting[SettingsMoveDistanceTextEntry,${SettingsSet.FindSetting[SettingsMoveDistanceTextEntry]}]
	else
		RI_Obj_CB:SetUISetting[SettingsMoveDistanceTextEntry,30]
	if ${SettingsSet.FindSetting[SettingsAfterMoveDistanceModTextEntry](exists)}
		RI_Obj_CB:SetUISetting[SettingsAfterMoveDistanceModTextEntry,${SettingsSet.FindSetting[SettingsAfterMoveDistanceModTextEntry]}]
	else
		RI_Obj_CB:SetUISetting[SettingsAfterMoveDistanceModTextEntry,1]
	RI_Obj_CB:SetUISetting[SettingsAttackHealthTextEntry,${SettingsSet.FindSetting[SettingsAttackHealthTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,${SettingsSet.FindSetting[SettingsMoveBehindCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsMoveInFrontCheckBox,${SettingsSet.FindSetting[SettingsMoveInFrontCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsMoveInCheckBox,${SettingsSet.FindSetting[SettingsMoveInCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${SettingsSet.FindSetting[SettingsSkipMobMoveHealthCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${SettingsSet.FindSetting[SettingsMoveHealthTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsSkipEncounterCheckBox,${SettingsSet.FindSetting[SettingsSkipEncounterCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsDoNotCastEncounterCheckBox,${SettingsSet.FindSetting[SettingsDoNotCastEncounterCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsEncounter#TextEntry,${SettingsSet.FindSetting[SettingsEncounter#TextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsSkipAECheckBox,${SettingsSet.FindSetting[SettingsAE#TextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsAE#TextEntry,${SettingsSet.FindSetting[SettingsAE#TextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsDoNotCastAECheckBox,${SettingsSet.FindSetting[SettingsDoNotCastAECheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAutoShareMissionsCheckBox,${SettingsSet.FindSetting[SettingsAutoShareMissionsCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsSummonFamiliarCheckBox,${SettingsSet.FindSetting[SettingsSummonFamiliarCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsFaceMobCheckBox,${SettingsSet.FindSetting[SettingsFaceMobCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsSendPetsCheckBox,${SettingsSet.FindSetting[SettingsSendPetsCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsRecallPetsCheckBox,${SettingsSet.FindSetting[SettingsRecallPetsCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastAbilitiesCheckBox,${SettingsSet.FindSetting[SettingsCastAbilitiesCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastHostileCheckBox,${SettingsSet.FindSetting[SettingsCastHostileCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastNamedHostileCheckBox,${SettingsSet.FindSetting[SettingsCastNamedHostileCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastInCombatTargetCheckBox,${SettingsSet.FindSetting[SettingsCastInCombatTargetCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastHealCheckBox,${SettingsSet.FindSetting[SettingsCastHealCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastPowerCheckBox,${SettingsSet.FindSetting[SettingsCastPowerCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastCureCheckBox,${SettingsSet.FindSetting[SettingsCastCureCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastResCheckBox,${SettingsSet.FindSetting[SettingsCastResCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastBuffCheckBox,${SettingsSet.FindSetting[SettingsCastBuffCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastOutOfCombatBuffCheckBox,${SettingsSet.FindSetting[SettingsCastOutOfCombatBuffCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCastInvisCheckBox,${SettingsSet.FindSetting[SettingsCastInvisCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCancelInvisCheckBox,${SettingsSet.FindSetting[SettingsCancelInvisCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsCancelCastingGroupCureCheckBox,${SettingsSet.FindSetting[SettingsCancelCastingGroupCureCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAlwaysCastNamedHostileCheckBox,${SettingsSet.FindSetting[SettingsAlwaysCastNamedHostileCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsStartHeroicCheckBox,${SettingsSet.FindSetting[SettingsStartHeroicCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAssistingCheckBox,${SettingsSet.FindSetting[SettingsAssistingCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsLootingCheckBox,${SettingsSet.FindSetting[SettingsLootingCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsLootCorpsesCheckBox,${SettingsSet.FindSetting[SettingsLootCorpsesCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsLootChestsCheckBox,${SettingsSet.FindSetting[SettingsLootChestsCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsLockSpottingCheckBox,${SettingsSet.FindSetting[SettingsLockSpottingCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAutoLoadRIMUICheckBox,${SettingsSet.FindSetting[SettingsAutoLoadRIMUICheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAutoLoadRIMobHudCheckBox,${SettingsSet.FindSetting[SettingsAutoLoadRIMobHudCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAcceptRessesCheckBox,${SettingsSet.FindSetting[SettingsAcceptRessesCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAcceptInvitesCheckBox,${SettingsSet.FindSetting[SettingsAcceptInvitesCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAcceptTradesCheckBox,${SettingsSet.FindSetting[SettingsAcceptTradesCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAcceptLootCheckBox,${SettingsSet.FindSetting[SettingsAcceptLootCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsSkipAbilityCollisionCheckBox,${SettingsSet.FindSetting[SettingsSkipAbilityCollisionCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAutoTargetMobsCheckBox,${SettingsSet.FindSetting[SettingsAutoTargetMobsCheckBox]}]
	RI_Obj_CB:SetUISetting[SettingsAutoRunKeyTextEntry,${SettingsSet.FindSetting[SettingsAutoRunKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsCallConfrontFearCheckBox,${SettingsSet.FindSetting[SettingsCallConfrontFearCheckBox]}]
	
	RI_Var_Bool_CB_CallForConfrontFear:Set[${SettingsSet.FindSetting[SettingsCallConfrontFearCheckBox]}]
	if ${SettingsSet.FindSetting[SettingsConfrontFearCallTextEntry](exists)}
		RI_Obj_CB:SetUISetting[SettingsConfrontFearCallTextEntry,${SettingsSet.FindSetting[SettingsConfrontFearCallTextEntry]}]
	
	if ${RI_Obj_CB.GetUISetting[SettingsAutoRunKeyTextEntry].Find[" "](exists)}
		RI_Var_String_AutoRunKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsAutoRunKeyTextEntry]}\"]
	else
		RI_Var_String_AutoRunKey:Set[${RI_Obj_CB.GetUISetting[SettingsAutoRunKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsForwardKeyTextEntry,${SettingsSet.FindSetting[SettingsForwardKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsForwardKeyTextEntry].Find[" "](exists)}
		RI_Var_String_ForwardKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsForwardKeyTextEntry]}\"]
	else
		RI_Var_String_ForwardKey:Set[${RI_Obj_CB.GetUISetting[SettingsForwardKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsBackwardKeyTextEntry,${SettingsSet.FindSetting[SettingsBackwardKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsBackwardKeyTextEntry].Find[" "](exists)}
		RI_Var_String_BackwardKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsBackwardKeyTextEntry]}\"]
	else
		RI_Var_String_BackwardKey:Set[${RI_Obj_CB.GetUISetting[SettingsBackwardKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsStrafeLeftKeyTextEntry,${SettingsSet.FindSetting[SettingsStrafeLeftKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsStrafeLeftKeyTextEntry].Find[" "](exists)}
		RI_Var_String_StrafeLeftKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsStrafeLeftKeyTextEntry]}\"]
	else
		RI_Var_String_StrafeLeftKey:Set[${RI_Obj_CB.GetUISetting[SettingsStrafeLeftKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsStrafeRightKeyTextEntry,${SettingsSet.FindSetting[SettingsStrafeRightKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsStrafeRightKeyTextEntry].Find[" "](exists)}
		RI_Var_String_StrafeRightKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsStrafeRightKeyTextEntry]}\"]
	else
		RI_Var_String_StrafeRightKey:Set[${RI_Obj_CB.GetUISetting[SettingsStrafeRightKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsJumpKeyTextEntry,${SettingsSet.FindSetting[SettingsJumpKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsJumpKeyTextEntry].Find[" "](exists)}
		RI_Var_String_JumpKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsJumpKeyTextEntry]}\"]
	else
		RI_Var_String_JumpKey:Set[${RI_Obj_CB.GetUISetting[SettingsJumpKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsCrouchKeyTextEntry,${SettingsSet.FindSetting[SettingsCrouchKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsCrouchKeyTextEntry].Find[" "](exists)}
		RI_Var_String_CrouchKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsCrouchKeyTextEntry]}\"]
	else
		RI_Var_String_CrouchKey:Set[${RI_Obj_CB.GetUISetting[SettingsCrouchKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsFlyUpKeyTextEntry,${SettingsSet.FindSetting[SettingsFlyUpKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsFlyUpKeyTextEntry].Find[" "](exists)}
		RI_Var_String_FlyUpKeyKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsFlyUpKeyTextEntry]}\"]
	else
		RI_Var_String_FlyUpKeyKey:Set[${RI_Obj_CB.GetUISetting[SettingsFlyUpKeyTextEntry]}]
	RI_Obj_CB:SetUISetting[SettingsFlyDownKeyTextEntry,${SettingsSet.FindSetting[SettingsFlyDownKeyTextEntry]}]
	if ${RI_Obj_CB.GetUISetting[SettingsFlyDownKeyTextEntry].Find[" "](exists)}
		RI_Var_String_FlyDownKey:Set[\"${RI_Obj_CB.GetUISetting[SettingsFlyDownKeyTextEntry]}\"]
	else
		RI_Var_String_FlyDownKey:Set[${RI_Obj_CB.GetUISetting[SettingsFlyDownKeyTextEntry]}]

	;import HudsSet
	variable settingsetref HudsSet=${Set.FindSet[${_Profile}].FindSet[Settings].GUID}
	
	HudsSet:Set[${Set.FindSet[${_Profile}].FindSet[Huds].GUID}]
	
	
	if ${HudsSet.FindSetting[HudsRaidGroupXTextEntry](exists)}
		RI_Obj_CB:SetUISetting[HudsRaidGroupXTextEntry,${HudsSet.FindSetting[HudsRaidGroupXTextEntry]}]
	if ${HudsSet.FindSetting[HudsRaidGroupYTextEntry](exists)}
		RI_Obj_CB:SetUISetting[HudsRaidGroupYTextEntry,${HudsSet.FindSetting[HudsRaidGroupYTextEntry]}]
	RI_Obj_CB:SetUISetting[HudsRaidGroupOnlyCheckBox,${HudsSet.FindSetting[HudsRaidGroupOnlyCheckBox]}]
	RI_Obj_CB:SetUISetting[HudsRaidGroupCheckBox,${HudsSet.FindSetting[HudsRaidGroupCheckBox]}]
	
	if ${HudsSet.FindSetting[HudsNearestNPCXTextEntry](exists)}
		RI_Obj_CB:SetUISetting[HudsNearestNPCXTextEntry,${HudsSet.FindSetting[HudsNearestNPCXTextEntry]}]
	if ${HudsSet.FindSetting[HudsNearestNPCYTextEntry](exists)}
		RI_Obj_CB:SetUISetting[HudsNearestNPCYTextEntry,${HudsSet.FindSetting[HudsNearestNPCYTextEntry]}]
	RI_Obj_CB:SetUISetting[HudsNearestNPCCheckBox,${HudsSet.FindSetting[HudsNearestNPCCheckBox]}]
	
	if ${HudsSet.FindSetting[HudsNearestPlayerXTextEntry](exists)}
		RI_Obj_CB:SetUISetting[HudsNearestPlayerXTextEntry,${HudsSet.FindSetting[HudsNearestPlayerXTextEntry]}]
	if ${HudsSet.FindSetting[HudsNearestPlayerYTextEntry](exists)}
		RI_Obj_CB:SetUISetting[HudsNearestPlayerYTextEntry,${HudsSet.FindSetting[HudsNearestPlayerYTextEntry]}]
	RI_Obj_CB:SetUISetting[HudsNearestPlayerCheckBox,${HudsSet.FindSetting[HudsNearestPlayerCheckBox]}]
;need to fix the coding that checked MeleeAttk, RangedAttk and FaceNPC
	
	;while ${CountSettings.Count[${SettingsSet}]}<1
	;{
		;echo SettingsSet: ${CountSettings.Count[${SettingsSet}]}==0
	;	LavishSettings:Import["${LavishScript.HomeDirectory}/Scripts/ISXTHG/Save/EQ2Save_${EQ2.ServerName}_${strMyName}.xml"]
		;echo ${_Profile}
		;echo SettingsSet:Set[${Set.FindSet[${_Profile}].FindSet[Settings].GUID}]
	;	SettingsSet:Set[${Set.FindSet[${_Profile}].FindSet[Settings].GUID}]
		;AliasesCount:Set[${CountSets.Count[${AliasSet}]}]
	;	MeleeAttk:Set[${SettingsSet.FindSetting[checkbox_settings_meleeattack]}]
	;	RangedAttk:Set[${SettingsSet.FindSetting[checkbox_settings_rangedattack]}]
	;	FaceNPC:Set[${SettingsSet.FindSetting[checkbox_settings_facenpc]}]
	;	wait 5
	;}
	;echo MeleeAttack: ${MeleeAttk}
	;echo RangedAttack: ${RangedAttk}
	;echo FaceNPC: ${FaceNPC}
	
	;RI_Obj_CB:LoadCastStack
}

;atom triggered when an affliction is on me
; atom EQ2_onMeAfflicted(int TraumaCounter, int ArcaneCounter, int NoxiousCounter, int ElementalCounter, int CursedCounter)
; {
 ; echo me afflicted
    ; if ${Me.Effect[detrimental,1].MainIconID}==279 || ${Me.Effect[detrimental,2].MainIconID}==279 || ${Me.Effect[detrimental,3].MainIconID}==279 || ${Me.Effect[detrimental,4].MainIconID}==279 || ${Me.Effect[detrimental,5].MainIconID}==279
	; {
		; if ${Me.Raid}>0
			; TimedCommand 50 r need a confront fear
		; else
			; TimedCommand 50 g need a confront fear
	; }
; }
atom EQ2_FinishedZoning(string TimeInSeconds)
{
	;echo Finished Zoning
	;check for OnEvent
	variable int i
   	for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
	{
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709 && ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[1,|].Equal[Zone]}
		{
			;echo Executing on Zone: ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Left[5].Upper.Equal[RELAY]}
			{
				variable int leftnum
				leftnum:Set[${Math.Calc[6+${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Right[-6].Find[" "]}]}]
				noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Left[${leftnum}]} "${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Right[${Math.Calc[-1*${leftnum}]}]}"]}
			}
			else
				noop ${Execute["${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}"]}
		}
	}
	if ${UIElement[SettingsAutoShareMissionsCheckBox@SettingsFrame@CombatBotUI].Checked}
	{
		RIMUIObj:ShareMissions["${Zone.Name}","${_ZoneTier}",1]
	}
}
;atom triggered when ChoiceWindow is detected
atom(script) EQ2_onChoiceWindowAppeared()
{
	if ${ChoiceWindow.Text.GetProperty[Text].Find[cast]} && ${Me.Health}<1 && ${UIElement[SettingsAcceptRessesCheckBox@SettingsFrame@CombatBotUI].Checked}
	{
		;ChoiceWindow:DoChoice1 - Dont need RI has
		IWasResed:Set[TRUE]
		TimedCommand 1200 CombatBotIDied:Set[FALSE]
	}
}
;atom triggered when Announcement is detected
atom EQ2_onAnnouncement(string Text, string SoundType, float Timer)
{
	;check for OnEvent
	;echo OnInc
	variable int i
   	for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
	{
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709 && ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[1,|].Equal[Announcement]} && ${Text.Find[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}](exists)}
		{
			;echo Executing on Announcement: ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|]}
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Left[5].Upper.Equal[RELAY]}
			{
				variable int leftnum
				leftnum:Set[${Math.Calc[6+${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Right[-6].Find[" "]}]}]
				noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Left[${leftnum}]} "${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Right[${Math.Calc[-1*${leftnum}]}].Replace[\",""]}"]}
			}
			else
				noop ${Execute["${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Replace[\",""]}"]}
		}
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;check we have ToT
	; if ${Text.Find[You must have expansion 12 to use this feature](exists)}
	; {
		; echo ISXRI: You do not have Terrors of Thalumbra Expansion
		; RI_Var_Bool_AutoDeityDisabled:Set[1]
	; }
	;check for OnEvent
	;echo OnInc
	variable int i
	variable int leftnum
   	for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
	{
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709 && ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[1,|].Equal[IncomingText]} && ${Text.Find[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Replace[\",""]}](exists)}
		{
			;echo Executing on IncomingText: ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|]}
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Left[5].Upper.Equal[RELAY]}
			{
				;variable int leftnum
				leftnum:Set[${Math.Calc[6+${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Right[-6].Find[" "]}]}]
				noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Left[${leftnum}]} "${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Right[${Math.Calc[-1*${leftnum}]}].Replace[\",""]}"]}
			}
			else
				noop ${Execute["${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[3,|].Replace[\",""]}"]}
		}
	}
	if ${Text.Find[not enough concentration](exists)}
	{
		RI_Obj_CB:CancelAllMaintained
	}
	if ${Text.Find[No Familiar currently equipped](exists)}
	{
		RI_Obj_CB:SetUISetting[SettingsSummonFamiliarCheckBox,0]
	}
	if ${Text.Find[you have died](exists)} || ${Text.Find[killed you](exists)}
	{
		;check on events
		for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
		{
			
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709 && ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[1,|].Equal[Death]}
			{
				;echo Executing on Death: ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}
				if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Left[5].Upper.Equal[RELAY]}
				{
					;variable int leftnum
					leftnum:Set[${Math.Calc[6+${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Right[-6].Find[" "]}]}]
					noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Left[${leftnum}]} "${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Right[${Math.Calc[-1*${leftnum}]}]}"]}
				}
				else
					noop ${Execute["${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}"]}
			}
		}
		SawCFTime:Set[0]
		IWasResed:Set[FALSE]
		CombatBotIDied:Set[TRUE]
		;echo CombatBotIDied
	}
	;need to add on events here
	if (${Text.Find[YOU hit ]} > 0 || ${Text.Find[YOU critically hit ]} > 0 || ${Text.Find[YOU double attack]} > 0 || ${Text.Find[YOU critically double attack]} > 0)
	{
		;echo ${Text}
		;echo AutoAttackReady: FALSE
		AutoAttackReady:Set[FALSE]
		LastAutoAttack:Set[${Script.RunningTime}/1000]
	}
	variable string CurseName
	variable string CFName
	CurseName:Set[""]
	CFName:Set[""]
	variable string strTemp1
	variable bool CurseSeen=FALSE
	variable bool CFSeen=FALSE
   	if ${Text.Find["need a cure curse"](exists)}
	{
		CurseSeen:Set[TRUE]
		if ${Text.Find["You say"](exists)} || ${Text.Find["You shout"](exists)}
		{
			CurseName:Set[${Me.Name}]
		}
		else
		{
			strTemp1:Set[${Text.Right[-${Text.Find[":"]}]}]
			CurseName:Set[${strTemp1.Left[-${Math.Calc[${strTemp1.Length}-${strTemp1.Find[/a]}+1]}]}]
		}
	}
	if ${Text.Find["${RI_Var_String_CB_ConfrontFearText}"](exists)}
	{
		CFSeen:Set[TRUE]
		if ${Text.Find["You say"](exists)} || ${Text.Find["You shout"](exists)}
		{
			CFName:Set[${Me.Name}]
		}
		else
		{
			strTemp1:Set[${Text.Right[-${Text.Find[":"]}]}]
			CFName:Set[${strTemp1.Left[-${Math.Calc[${strTemp1.Length}-${strTemp1.Find[/a]}+1]}]}]
		}
	}
	if ${CFSeen} && ${RI_Var_String_MySubClass.Equal[dirge]}
	{
		istrConfrontFear:Insert[${CFName}]
	}
	if ${CurseSeen} && ${Me.Archetype.Equal[priest]}
	{
		istrCurses:Insert[${CurseName}]
	}
	if ${Text.Find["has joined the group"](exists)} || ${Text.Find["have joined the group"](exists)} || ${Text.Find["has joined the raid"](exists)} || ${Text.Find["have joined the raid"](exists)} || ${Text.Find["has left the group"](exists)} || ${Text.Find["have left the group"](exists)} || ${Text.Find["has left the raid"](exists)} || ${Text.Find["have left the raid"](exists)}
	{
		TimedCommand 5 RI_Obj_CB:LoadRaidGroupList
	}
}	


; atom(global) CombatBotChangeFaceNPCGlobal(string OnOff)
; {
	; if ${OnOff.Upper.Equal[ON]}
	; {
		; FaceNPC:Set[TRUE]
	; }
	; elseif ${OnOff.Upper.Equal[OFF]}
	; {
		; FaceNPC:Set[FALSE]
	; }
; }

atom CheckAssist()
{
	;add && checkboxvalue
	if ${UIElement[SettingsAssistingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${CombatBotAssisting}
	{
		;echo ${AssistID}
		;check if AssistID>0
		if ${AssistID}>0  && ( ${Actor[ID,${AssistID}].InMyGroup} || ${AssistID}==${Me.ID} ) && ${UIElement[SettingsInstancedAssistingCheckBox@SettingsFrame@CombatBotUI].Checked}
		{
			if ${Target.ID}!=${AssistID} && ${AssistID}!=${Me.ID} 
				Actor[id,${AssistID}]:DoTarget
		}
		elseif ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Items}>0
		{
			variable int _AssistID=0
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].Items};i:Inc)
			{
				if ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709
				{
					;echo Checking #${i}: ${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}]}
					_AssistID:Set[${CheckAbilitiesObj.ConvertAliases[${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}]}]}]
					if ${_AssistID}>0
					{
						if ${Target.ID}!=${_AssistID}
							Actor[id,${_AssistID}]:DoTarget
						return
					}
					elseif ${Actor[PC,${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}]}](exists)} && ${Actor[PC,${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}]}].InMyGroup}
					{
						if ${Target.ID}!=${Actor[PC,${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}]}].ID}
							Actor[PC,${UIElement[AssistAddedListBox@AssistFrame@CombatBotUI].OrderedItem[${i}]}]:DoTarget
						return
					}
				}
			}
		}
		if ${UIElement[SettingsAutoTargetMobsCheckBox@SettingsFrame@CombatBotUI].Checked}
		{
			if ${Target(exists)}
				noop
			elseif ${Zone.Name.Find[Qeynos](exists)} || ${Zone.Name.Find[Freeport](exists)}
				noop
			else
				Mobs:TargetNearestAggroMob
		}
	}
	if ${UIElement[SettingsAutoTargetMobsCheckBox@SettingsFrame@CombatBotUI].Checked}
	{
		if ${Target(exists)}
			noop
		else
			Mobs:TargetNearestAggroMob
	}
}
;atom CheckAssistOld()
;{
	; if ${CombatBotFoundTank} && ${Actor[${TankID}](exists)}
	; {
		; if ${Target.ID}!=${TankID} && ${TankID}!=${Me.ID}
			; Actor[${TankID}]:DoTarget
	; }
	; elseif ${Me.Archetype.NotEqual[fighter]}
	; {
		; if ${Me.Group}>1
		; {
			; variable int checkassistCount=0
			; for(checkassistCount:Set[1];${checkassistCount}<=${Me.Group};checkassistCount:Inc)
			; {
				; if ${Me.Group[${checkassistCount}].Class.Equal[guardian]} || ${Me.Group[${checkassistCount}].Class.Equal[berserker]} || ${Me.Group[${checkassistCount}].Class.Equal[monk]} || ${Me.Group[${checkassistCount}].Class.Equal[bruiser]} || ${Me.Group[${checkassistCount}].Class.Equal[paladin]} || ${Me.Group[${checkassistCount}].Class.Equal[shadowknight]}
				; {
					; CombatBotFoundTank:Set[TRUE]
					; TankID:Set[${Me.Group[${checkassistCount}].ID}]
					; checkassistCount:Set[7]
					; break
				; }
			; }
		; }
	; }
	; elseif ${EQ2.Zoning}==0
	; {
		; if ${Target(exists)}
			; noop
		; else
			; Mobs:TargetNearestAggroMob
	; }
;}

objectdef CheckAbilitiesObject
{
	member:string SetCastTarget(string _target)
	{
		;echo member:string SetCastTarget(string _target=${_target})
		switch ${_target}
		{
			case FALSE
			{
				return FALSE
				break
			}
			case @Me
			{
				return ${Me.ID}
				break
			}
			case @PCTarget
			{
				if ${Target.Type.Equal[PC]}
					return ${Target.ID}
				elseif ${Target.Target.Type.Equal[PC]}
					return ${Target.Target.ID}
				else
					return 0
				break
			}
			case @Group
			{
				return @Group
				break
			}
			case @Raid
			{
				return @Raid
				break
			}
			case @NotSelfGroup
			{
				return @NotSelfGroup
				break
			}
			default
			{
				return ${This.ConvertAliases[${_target}]}
			}
		}
	}
	member:int ConvertAliases(string aliasName)
	{
		variable int caCount=0
		variable int tempid
		for(caCount:Set[1];${caCount}<=${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].Items};caCount:Inc)
		{
			if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Find[" For"]}-1]}].Equal[${aliasName}]} && ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].TextColor}!=-10263709
			{
				if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value.Equal[${Me.Name}]}
					return ${Me.ID}

				tempid:Set[${This.RaidGroupMember[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}]}]
				if ${tempid}!=0
					return ${tempid}
			}
		}
		if ${aliasName.Equal[${Me.Name}]}
			return ${Me.ID}
		tempid:Set[${This.RaidGroupMember[${aliasName}]}]
		if ${tempid}!=0
			return ${tempid}
		return 0
	}
	member:int RaidGroupMember(string _member)
	{
		variable int tempid
		if ${Me.Raid}>0
		{
			tempid:Set[${Me.Raid[${_member}].ID}]
			if ${tempid}>0
				return ${tempid}
		}
		else
		{
			tempid:Set[${Me.Group[${_member}].ID}]
			if ${tempid}>0
				return ${tempid}
		}
		return 0
	}
	member:bool AbilityTypeEnabled(string strType)
	{
		variable string temp
		if ${strType.Equal[InCombatTargeted]}
			temp:Set["InCombatTarget"]
		else
			temp:Set["${strType}"]
			
		if ${UIElement[SettingsCast${temp}CheckBox@SettingsFrame@CombatBotUI].Checked}
			return TRUE
		return FALSE
	}
	
	
	
	member:bool CheckAll(int start, int end)
	{
		variable int first
		variable int second
		first:Set[${Script.RunningTime}]
		variable int count=0		
		boolAbilityCast:Set[FALSE]
		boolItemCast:Set[FALSE]
		strCastName:Set[""]
		strCastNameShort:Set[""]
		strCastID:Set[0]
		strCastTarget:Set[""]
		Heading:Set[${Actor[${KillTargetID}].Heading}]
		HeadingTo:Set[${Actor[${KillTargetID}].HeadingTo}]
		Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
		if ${Angle} < -1 
			Angle:Set[-1]
		if ${Angle} > 1
			Angle:Set[1]
		Angle:Set[${Math.Acos[${Angle}]}]
		AEcount:Set[${Mobs.CountAE}]
		ENCcount:Set[${Mobs.CountEncounter[${KillTargetID}]}]
		RangeCalc:Set[${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})]}]
		MinDist:Set[${Math.Calc[${Actor[id,${KillTargetID}].Distance}+${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})]}]}]
		MaxDist:Set[${Math.Calc[${Actor[id,${KillTargetID}].Distance}-${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})]}]}]
		
		if ${Actor[Query, ID=${KillTargetID} && IsDead=FALSE](exists)}
			KillTargetHealth:Set[${Actor[Query, ID=${KillTargetID} && IsDead=FALSE](exists)}]
		else
			KillTargetHealth:Set[-1]
		
		CastTarget:Set[FALSE]
		for(mainCount:Set[${start}];${mainCount}<=${end};mainCount:Inc)
		{
			if ${mainCount}>${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
				return
			;echo for #${mainCount}
			count:Set[${mainCount}]
			if !${UIElement[SettingsCastAbilitiesCheckBox@SettingsFrame@CombatBotUI].Checked}
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because Abilities are disabled
				continue
			}
			;echo after dis
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is disabled
				continue
			}
			if !${This.AbilityTypeEnabled[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}]}
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}'s are disabled
				continue
			}
			if ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Hostile]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[NamedHostile]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[InCombatTargeted]} ) && ( !${Me.InCombat} && !${Me.IsHated} )
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because we are not in combat
				continue
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].NotEqual[Adrenaline Boost]} && !${RI_Var_Bool_CastWhileMoving} && ${Me.IsMoving} && ${istrExportSpellBookType.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}!=1 && !${Me.Maintained[Cloak of Divinity](exists)}
			{
				if ${Me.SubClass.Equal[channeler]}
				{
					if ${Me.Maintained[Combat Awareness](exists)}
						noop
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are moving
						continue
					}
				}
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are moving
					continue
				}
			}
			if ${Me.FlyingUsingMount} 
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are flying
				continue
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[NamedHostile]}
			{
				;echo is NamedHostile
				if ${Target.Type.Equal[NamedNPC]} || ${Target.Target.Type.Equal[NamedNPC]} || ${Target.Name.Equal["training dummy"]} || ${Target.Target.Name.Equal["training dummy"]} || ${UIElement[SettingsAlwaysCastNamedHostileCheckBox@SettingsFrame@CombatBotUI].Checked}
				{
					noop
				}
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is a NamedHostile and our KillTarget is not a named
					continue
				}
			}
			if ${Me.SubClass.Equal[beastlord]} 
			{
				if ${Me.Maintained[Spiritual Stance](exists)} && ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Silent Talon]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Feral Pounce]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Shadow Leap]} )
				{
					if ${CombatBotDebug}
						echo Ignoring Feral Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are in spiritual
					continue
				}
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
			{
				if ${Me.Equipment["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}<0 || ${Me.Inventory["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}<0
					noop
				else
				{
					if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is not ready
						continue
				}
			}
			elseif ${istrExportReqStealth.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}].Equal[TRUE]}
			{
				if ${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].TimeUntilReady}==0
					noop
				else
				{
					if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is not ready
						continue
				}
			}
			elseif ${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].IsReady} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure]}
				noop
			else
			{
				if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is not ready
					continue
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[FALSE]}
			{
				CastTarget:Set[${This.SetCastTarget[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|]}]}]
				;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|]} ${CastTarget}
				
				switch ${CastTarget}
				{
					case @Group
					{
						;this needs to be modified so i will cast group abilities on my self solo
						if ${Me.Group}>1
							noop
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Group Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are not in a group
							continue
						}
						break
					}
					case @Raid
					{
						if ${Me.Raid}>0
						{
							if ${istrExportAllowRaid.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}
								noop
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Raid Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, does not allow raid
								continue
							}
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Raid Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are not in a raid
							continue
						}
						break
					}
					case @NotSelfGroup
					{
						if ${Me.Raid}>0
							noop
						else
						{
							if ${CombatBotDebug}
								echo Ignoring NotSelfGroup Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, there are no other groups
							continue
						}
						break
					}
					default
					{
						if ${CastTarget}==0
						{
							if ${CombatBotDebug}
								echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we didnt find target ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|]}
							continue
						}
						else
						{	
							;first see if cast target is me
							if ${CastTarget.Equal[${Me.ID}]}
								noop
							;see if we are in raid
							elseif ${Me.Raid}>0
							{
								;now see if the CastTarget exists and is in same zone //OLD WAY - ${Me.Raid[id,${CastTarget}](exists)} //
								if ${Me.Raid[id,${CastTarget}].InZone}
								{
									;now check if they are out of MaxRange
									if ${Me.Raid[id,${CastTarget}].Distance}>${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									{
										if ${CombatBotDebug}
											echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Me.Raid[id,${CastTarget}]} is not within range
										boolAbilityCast:Set[FALSE]
										boolItemCast:Set[FALSE]
										continue
									}
								}
								else
								{
									if ${CombatBotDebug}
										echo Skipping Ability: $${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we didnt find target ${Actor[id,${CastTarget}].Name}
									boolAbilityCast:Set[FALSE]
									boolItemCast:Set[FALSE]
									continue
								}
							}
							else
							{
								;now see if the CastTarget exists and is in same zone
								if ${Me.Group[id,${CastTarget}].InZone}
								{
									;now check if they are out of MaxRange
									if ${Me.Group[id,${CastTarget}].Distance}>${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${_count}].Value.Token[2,|]}]}
									{
										if ${CombatBotDebug}
											echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Me.Group[id,${CastTarget}]} is not within range
										boolAbilityCast:Set[FALSE]
										boolItemCast:Set[FALSE]
										continue
									}
								}
								else
								{
									if ${CombatBotDebug}
										echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we didnt find target ${Actor[${CastTarget}].Name} in our group and the ability does not allow raid
									boolAbilityCast:Set[FALSE]
									boolItemCast:Set[FALSE]
									continue
								}
							}
						}
					}
				}
			}
			else
				CastTarget:Set[FALSE]
			;continue
			;echo ${CastTarget} // ${KillTargetID}
			;echo Duration: ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} -- IsBeneficial: ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} -- IgnoreDuration: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|]}
			;echo before duration check
			;first check if isitem
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
			{
				if ${EQ2.ServerName.Equal[Battlegrounds]}
					continue
				variable int itemMaintainedCount=0
				variable bool boolFoundItemInItemList=FALSE
				boolFoundItemInItemList:Set[FALSE]
				variable bool boolFoundItemInMaintained=FALSE
				boolFoundItemInMaintained:Set[FALSE]
				for(itemMaintainedCount:Set[1];${itemMaintainedCount}<=${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Items};itemMaintainedCount:Inc)
				{
					;echo forloop1
					if ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Text.Equal["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"]}
					{
						;echo found item in our ItemList, ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Text} : ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}, checking EffectName ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}
						variable int cmID1=${KillTargetID}
						variable int iepCMCount
						;for(iepCMCount:Set[1];${iepCMCount}<=${Me.CountMaintained};iepCMCount:Inc)
						;{
						;echo forloop2
							;echo if ${Me.Maintained[${iepCMCount}].Name.Equal["${istrItemEffectPairsEffectName.Get[${itemMaintainedCount}]}"]} 
							if ${Me.Maintained["${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}"](exists)} 
							{
								;echo found spell in maintained, checking if it has a target and if its the correct target
								boolFoundItemInItemList:Set[TRUE]
								if ${Me.Maintained["${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}"].Target(exists)}
								{
									;echo has a target
									if ${Me.Maintained["${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}"].Target.ID}==${cmID1} && (${Me.Maintained["${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}"].Duration}>0 || ${Me.Maintained["${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}"].Duration}==-1)
									{
										if ${CombatBotDebug}
											echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on ${Actor[${KillTargetID}].Name}
										boolItemCast:Set[FALSE]
										boolAbilityCast:Set[FALSE]
										boolFoundItemInMaintained:Set[TRUE]
										break
									}
									if ${Me.Maintained[${iepCMCount}].Target.ID}==${Me.ID} && (${Me.Maintained[${iepCMCount}].Duration}>0 || ${Me.Maintained[${iepCMCount}].Duration}==-1)
									{
										if ${CombatBotDebug}
											echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on Me
										boolItemCast:Set[FALSE]
										boolAbilityCast:Set[FALSE]
										boolFoundItemInMaintained:Set[TRUE]
										break
									}
								}
								else
								{
									;echo doesnt have a target, continueing
									if ${Me.Maintained[${iepCMCount}].Duration}>0 || ${Me.Maintained[${iepCMCount}].Duration}==-1
									{
										if ${CombatBotDebug}
											echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained
										boolItemCast:Set[FALSE]
										boolAbilityCast:Set[FALSE]
										boolFoundItemInMaintained:Set[TRUE]
										break
									}
								}
							}
						;}
					}
					;echo im getting here
					if ${boolFoundItemInMaintained}
						continue
				}
				if ${boolFoundItemInMaintained}
					continue
				;echo im getting here
				if !${boolFoundItemInItemList}
				{
					;echo didnt found item in our ItemEffectPairs, checking ItemName
					variable int cmID2=${KillTargetID}
					variable int iepCMCount2
					;variable bool boolFoundItemInMaintained=FALSE
					;for(iepCMCount2:Set[1];${iepCMCount2}<=${Me.CountMaintained};iepCMCount2:Inc)
					;{
						if ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"](exists)} 
						{
							;echo found spell in maintained, checking if it has a target and if its the correct target
							if ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Target(exists)}
							{
								;echo has a target
								if ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Target.ID}==${cmID2} && (${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Duration}>0 || ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Duration}==-1)
								{
									if ${CombatBotDebug}
										echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on ${Actor[${KillTargetID}].Name}
									boolItemCast:Set[FALSE]
									boolAbilityCast:Set[FALSE]
									boolFoundItemInMaintained:Set[TRUE]
									break
								}
								if ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Target.ID}==${Me.ID} && (${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"}].Duration}>0 || ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Duration}==-1)
								{
									if ${CombatBotDebug}
										echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on Me
									boolItemCast:Set[FALSE]
									boolAbilityCast:Set[FALSE]
									boolFoundItemInMaintained:Set[TRUE]
									break
								}
							}
							else
							{
								;echo doesnt have a target, continueing
								if ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Duration}>0 || ${Me.Maintained["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].Duration}==-1
								{
									if ${CombatBotDebug}
										echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained
									boolItemCast:Set[FALSE]
									boolAbilityCast:Set[FALSE]
									boolFoundItemInMaintained:Set[TRUE]
									break
								}
							}
						}
					;}
					; echo im getting here
					if ${boolFoundItemInMaintained}
						continue
				}
			}
			;then check if MaxDuration is >0 and ignore duration is set to false
			elseif ( ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0 || ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==-1 ) && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|].NotEqual[TRUE]}
			{
				;echo Maintained Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}]}
				;echo checking maintained because duration is either >0 or -1
				;echo ( ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0 || ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==-1 ) && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|]}
				variable int cmID
				if ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${CastTarget.NotEqual[FALSE]}
					cmID:Set[${CastTarget}]
				elseif ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${CastTarget.Equal[FALSE]}
					cmID:Set[${Me.ID}]
				else
					cmID:Set[${KillTargetID}]
					
				if ${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"](exists)}
				{
					if ${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"].Target(exists)}
					{
						if ${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"].Target.ID}==${cmID} && (${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"].Duration}>0 || ${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"].Duration}==-1)
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on ${Actor[${cmID}].Name}
							boolItemCast:Set[FALSE]
							boolAbilityCast:Set[FALSE]
							continue
						}
					}
					else
					{
						if ${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"].Duration}>0 || ${Me.Maintained["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"].Duration}==-1
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained
							boolItemCast:Set[FALSE]
							boolAbilityCast:Set[FALSE]
							continue							
						}
					}
				}
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]}>0 && ${RI_Var_String_MySubClass.Equal[beastlord]}
			{
				;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} is saying savagery
				if ${Me.GetGameData[Self.SavageryLevel].Label}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]}
				{
					if ${Script.RunningTime}<${Math.Calc[${LastSavageryCastTime}+1000]} && !${Me.Maintained[Savagery Freeze](exists)} && ${UIElement[SubClassBeastlordPrimalDelayCheckBox@SubClassFrame@CombatBotUI].Checked}
					{
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we casted a savagery ability less than 1s ago :: ${Script.RunningTime}<${Math.Calc[${LastSavageryCastTime}+1000]}
						continue
					}
					LastSavageryCastTime:Set[${Script.RunningTime}]
					;echo Setting LastSavageryCastTime because we are casting ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}
					noop
				}
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]} and we only have ${Me.GetGameData[Self.SavageryLevel].Label}
					continue
				}
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]}>0 && ${RI_Var_String_MySubClass.Equal[channeler]}
			{
				if ${Me.Dissonance}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]}
					noop
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires greater than ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]} disonance and we have ${Me.Dissonance}
					continue
				}
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]}>0 && ${RI_Var_String_MySubClass.Equal[channeler]}
			{
				if ${Me.Dissonance}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]}
					noop
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires less than ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]} disonance and we only have ${Me.Dissonance}
					continue
				}
			}
			if ${RI_Var_String_MySubClass.Equal[assassin]} || ${RI_Var_String_MySubClass.Equal[ranger]}
			{
				if ${Me.Ability[id,3363812126].IsReady} && ${CombatBotCastExploitWeakness}
				{
					if ${Me.Maintained[Weakness Detected](exists)}
					{
						Cast "Exploit Weakness" "Exploit Weakness" 3363812126
						return TRUE
					}
				}
			}
			switch ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}
			{
				case Res
				{
					;echo is a Res
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						variable bool boolGotFirstDeadTarget=FALSE
						variable int intFirstDeadTarget
						variable int resGroupCount
						variable int isDead=0
						if ${Me.Raid}>0
						{
							for(resGroupCount:Set[1];${resGroupCount}<${Me.Raid};resGroupCount:Inc)
							{
								if ${Me.Raid[${resGroupCount}].IsDead} && ${Me.Raid[${resGroupCount}](exists)} && ${Me.Raid[${resGroupCount}].InZone} && ${Me.Raid[${resGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if !${boolGotFirstDeadTarget}
									{
										intFirstDeadTarget:Set[${Me.Raid[${resGroupCount}].ID}]
										boolGotFirstDeadTarget:Set[TRUE]
									}
									isDead:Inc
								}
							}
						}
						else
						{
							for(resGroupCount:Set[1];${resGroupCount}<${Me.Group};resGroupCount:Inc)
							{
								if ${Me.Group[${resGroupCount}].IsDead} && ${Me.Group[${resGroupCount}](exists)} && ${Me.Group[${resGroupCount}].InZone} && ${Me.Group[${resGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if !${boolGotFirstDeadTarget}
									{
										intFirstDeadTarget:Set[${Me.Group[${resGroupCount}].ID}]
										boolGotFirstDeadTarget:Set[TRUE]
									}
									isDead:Inc
								}
							}
						}
						if ${isDead}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${intFirstDeadTarget}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough to groupres
					}
					;check if the target is NotSelfGroup
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						;echo check NotSelfGroup for dead
						variable int resNotSelfGroupCount=0
						for(resNotSelfGroupCount:Set[7];${resNotSelfGroupCount}<=${Me.Raid};resNotSelfGroupCount:Inc)
						{
							if ${Me.Raid[${resNotSelfGroupCount}](exists)} && ${Me.Raid[${resNotSelfGroupCount}].InZone} && ${Me.Raid[${resNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${resNotSelfGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${resNotSelfGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${resNotSelfGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
					}
					;check if the target is raid
					elseif ${CastTarget.Equal[@Raid]}
					{
						;echo check Raid for dead
						variable int resRaidCount=0
						for(resRaidCount:Set[1];${resRaidCount}<=${Me.Raid};resRaidCount:Inc)
						{
							if ${Me.Raid[${resRaidCount}](exists)} && ${Me.Raid[${resRaidCount}].InZone} && ${Me.Raid[${resRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${resRaidCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${resRaidCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${resRaidCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
					}
					;check if the target is group
					elseif ${CastTarget.Equal[@Group]}
					{
						;echo check group for dead
						variable int resGroupCount2
						for(resGroupCount2:Set[1];${resGroupCount2}<${Me.Group};resGroupCount2:Inc)
						{
							;echo checking ${resGroupCount2}: ${Me.Group[${resGroupCount2}].Name}
							if ${Me.Group[${resGroupCount2}](exists)} && ${Me.Group[${resGroupCount2}].InZone} && ${Me.Group[${resGroupCount2}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${resGroupCount2}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Group[${resGroupCount2}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${resGroupCount2}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
					}
					else
					{
						;check if our target is dead
						if ${Me.Group[id,${CastTarget}].IsDead}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
						continue
					}
					break
				}
				case Cure
				{
					;echo is a Cure
					;first check if the cure has a # of people attached to it (AKA a group cure) then check the entire group for nox,ele,tra,arc, and add them up and cast if that number or higher
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						
						variable int gcure=0
						variable int cureCount=0
						if ${Me.Noxious}>0 || ${Me.Trauma}>0 || ${Me.Arcane}>0 || ${Me.Elemental}>0
							gcure:Inc
						
						for(cureCount:Set[1];${cureCount}<${Me.Group};cureCount:Inc)
						{
							if ${Me.Group[${cureCount}](exists)} && ${Me.Group[${cureCount}].Health}>0 && ${Me.Group[${cureCount}].InZone} && ${Me.Group[${cureCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${cureCount}].Noxious}>0 || ${Me.Group[${cureCount}].Trauma}>0 || ${Me.Group[${cureCount}].Arcane}>0 || ${Me.Group[${cureCount}].Elemental}>0
									gcure:Inc
							}
						}
						if ${gcure}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							return TRUE
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough cures
						}
							
					}
					;check if the cure is cure
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure Magic]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Shed Skin]}
					{
						;echo we made it
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@NotSelfGroup]}
						{
							;check NotSelfGroup for cureable afflictions
							variable int cureNotSelfGroupCount=0
							for(cureNotSelfGroupCount:Set[7];${cureNotSelfGroupCount}<=${Me.Raid};cureNotSelfGroupCount:Inc)
							{
								if ${Me.Raid[${cureNotSelfGroupCount}](exists)} && ${Me.Raid[${cureNotSelfGroupCount}].Health}>0 && ${Me.Raid[${cureNotSelfGroupCount}].InZone} && ${Me.Raid[${cureNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${cureNotSelfGroupCount}].Noxious}>0 || ${Me.Raid[${cureNotSelfGroupCount}].Trauma}>0 || ${Me.Raid[${cureNotSelfGroupCount}].Arcane}>0 || ${Me.Raid[${cureNotSelfGroupCount}].Elemental}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${cureNotSelfGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Raid]}
						{
							;check Raid for cureable afflictions
							variable int cureRaidCount=0
							for(cureRaidCount:Set[1];${cureRaidCount}<=${Me.Raid};cureRaidCount:Inc)
							{
								if ${Me.Raid[${cureRaidCount}](exists)} && ${Me.Raid[${cureRaidCount}].Health}>0 && ${Me.Raid[${cureRaidCount}].InZone} && ${Me.Raid[${cureRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${cureRaidCount}].Noxious}>0 || ${Me.Raid[${cureRaidCount}].Trauma}>0 || ${Me.Raid[${cureRaidCount}].Arcane}>0 || ${Me.Raid[${cureRaidCount}].Elemental}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${cureRaidCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Group]}
						{
							;check group for cureable afflictions
							variable int cureGroupCount
							if ${Me.Noxious}>0 || ${Me.Trauma}>0 || ${Me.Arcane}>0 || ${Me.Elemental}>0
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
							for(cureGroupCount:Set[1];${cureGroupCount}<${Me.Group};cureGroupCount:Inc)
							{
								if ${Me.Group[${cureGroupCount}](exists)} && ${Me.Group[${cureGroupCount}].Health}>0 && ${Me.Group[${cureGroupCount}].InZone} && ${Me.Group[${cureGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Group[${cureGroupCount}].Noxious}>0 || ${Me.Group[${cureGroupCount}].Trauma}>0 || ${Me.Group[${cureGroupCount}].Arcane}>0 || ${Me.Group[${cureGroupCount}].Elemental}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${cureGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						else
						{
							if ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
							{
								if ${Me.Noxious}>0 || ${Me.Trauma}>0 || ${Me.Arcane}>0 || ${Me.Elemental}>0
								{
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
									return TRUE
								}
							}
							;if our target has any affliction cast cure on them
							elseif (${Me.Group[id,${CastTarget}].Noxious}>0 || ${Me.Group[id,${CastTarget}].Trauma}>0 || ${Me.Group[id,${CastTarget}].Arcane}>0 || ${Me.Group[id,${CastTarget}].Elemental}>0 || ${Me.Raid[id,${CastTarget}].Noxious}>0 || ${Me.Raid[id,${CastTarget}].Trauma}>0 || ${Me.Raid[id,${CastTarget}].Arcane}>0 || ${Me.Raid[id,${CastTarget}].Elemental}>0) && (${Me.Group[${cureGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} || ${Me.Raid[${cureGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]})
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure Curse]}
					{
						if ${CastTarget.Equal[@NotSelfGroup]}
						{
							;check NotSelfGroup for curse
							variable int curseNotSelfGroupCount
							for(curseNotSelfGroupCount:Set[7];${curseNotSelfGroupCount}<=${Me.Raid};curseNotSelfGroupCount:Inc)
							{
								if ${Me.Raid[${curseNotSelfGroupCount}](exists)} && ${Me.Raid[${curseNotSelfGroupCount}].Health}>0 && ${Me.Raid[${curseNotSelfGroupCount}].InZone} && ${Me.Raid[${curseNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${curseNotSelfGroupCount}].Cursed}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${curseNotSelfGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${CastTarget.Equal[@Raid]}
						{
							;check Raid for curse
							variable int curseRaidCount
							for(curseRaidCount:Set[1];${curseRaidCount}<=${Me.Raid};curseRaidCount:Inc)
							{
								if ${Me.Raid[${curseRaidCount}](exists)} && ${Me.Raid[${curseRaidCount}].Health}>0 && ${Me.Raid[${curseRaidCount}].InZone} && ${Me.Raid[${curseRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${curseRaidCount}].Cursed}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${curseRaidCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${CastTarget.Equal[@Group]}
						{
							;check group for curse
							variable int curseGroupCount
							if ${Me.Cursed}>0
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
							for(curseGroupCount:Set[1];${curseGroupCount}<${Me.Group};curseGroupCount:Inc)
							{
								if ${Me.Group[${curseGroupCount}](exists)} && ${Me.Group[${curseGroupCount}].Health}>0 && ${Me.Group[${curseGroupCount}].InZone} && ${Me.Group[${curseGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Group[${curseGroupCount}].Cursed}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${curseGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						else
						{
							;if our target has any affliction cast cure on them
							if ( ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]} ) && ${Me.Cursed}>0
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
							elseif (${Me.Group[id,${CastTarget}].Cursed}>0 || ${Me.Raid[id,${CastTarget}].Cursed}>0) && (${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} || ${Me.Raid[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]})
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
					}
					break
				}
				case Heal
				{
					;echo is a heal
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						variable int groupCount1
						variable int lowhealth=0
						if ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							lowhealth:Inc
						for(groupCount1:Set[1];${groupCount1}<${Me.Group};groupCount1:Inc)
						{
							if ${Me.Group[${groupCount1}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && ${Me.Group[${groupCount1}](exists)} && ${Me.Group[${groupCount1}].Health}>0 && ${Me.Group[${groupCount1}].InZone} && !${Me.Group[${groupCount1}].IsDead} && ${Me.Group[${groupCount1}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								lowhealth:Inc
						}
						if ${lowhealth}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough to heal
					}
					;check if the target is NotSelfGroup
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						;echo check NotSelfGroup for health
						variable int NotSelfGroupCount=0
						for(NotSelfGroupCount:Set[7];${NotSelfGroupCount}<=${Me.Raid};NotSelfGroupCount:Inc)
						{
							if ${Me.Raid[${NotSelfGroupCount}](exists)} && ${Me.Raid[${NotSelfGroupCount}].Health}>0 && ${Me.Raid[${NotSelfGroupCount}].InZone} && ${Me.Raid[${NotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${NotSelfGroupCount}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${NotSelfGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${NotSelfGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${NotSelfGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					;check if the target is raid
					elseif ${CastTarget.Equal[@Raid]}
					{
						;echo check Raid for health
						variable int raidCount=0
						for(raidCount:Set[1];${raidCount}<=${Me.Raid};raidCount:Inc)
						{
							if ${Me.Raid[${raidCount}](exists)} && ${Me.Raid[${raidCount}].Health}>0 && ${Me.Raid[${raidCount}].InZone} && ${Me.Raid[${raidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${raidCount}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${raidCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${raidCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${raidCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						;echo check group health
						variable int groupCount
						if ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							return TRUE
						}
						for(groupCount:Set[1];${groupCount}<${Me.Group};groupCount:Inc)
						{
							;echo checking ${groupCount}: ${Me.Group[${groupCount}].Name}
							if ${Me.Group[${groupCount}](exists)} && ${Me.Group[${groupCount}].Health}>0 && ${Me.Group[${groupCount}].InZone} && ${Me.Group[${groupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${groupCount}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[${groupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Group[${groupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${groupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					else
					{
						;if our target is me
						if ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
						{
							;echo Our Heal Target is ${Me}, Checking health ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							if ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							{
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								{
									if ${CastTarget.Equal[FALSE]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
									else
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
								}
								else
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
						}
						;check our target health
						else
						{
							;echo Our Heal Target is ${CastTarget}, Checking health ${Me.Group[id,${CastTarget}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							if ${Me.Raid}>0
							{
								if ${Me.Raid[id,${CastTarget}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[id,${CastTarget}].IsDead} && ${Me.Raid[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
									return TRUE
								}
							}
							elseif ${Me.Group[id,${CastTarget}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[id,${CastTarget}].IsDead} && ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
									call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
								else
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					break
				}
				case Power
				{
					;echo is a Power
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						variable int phGroupCount1
						variable int lowPower=0
						if ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							lowPower:Inc
						for(phGroupCount1:Set[1];${phGroupCount1}<${Me.Group};phGroupCount1:Inc)
						{
							if ${Me.Group[${phGroupCount1}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[${phGroupCount1}].IsDead} && ${Me.Group[${phGroupCount1}](exists)} && ${Me.Group[${phGroupCount1}].Health}>0 && ${Me.Group[${phGroupCount1}].InZone} && ${Me.Group[${phGroupCount1}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								lowPower:Inc
						}
						if ${lowPower}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough to Power
					}
					;check if the target is notselfgroup
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						if ${Me.Raid}==0
							continue
						;echo check NotSelfGroup for Power
						variable int phNotSelfGroupCount=0
						for(phNotSelfGroupCount:Set[7];${phNotSelfGroupCount}<=${Me.Raid};phNotSelfGroupCount:Inc)
						{
							if ${Me.Raid[${phNotSelfGroupCount}](exists)} && ${Me.Raid[${phNotSelfGroupCount}].Health}>0 && ${Me.Raid[${phNotSelfGroupCount}].InZone} && ${Me.Raid[${phNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${phNotSelfGroupCount}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${phNotSelfGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${phNotSelfGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${phNotSelfGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					;check if the target is raid
					elseif ${CastTarget.Equal[@Raid]}
					{
						if ${Me.Raid}==0
							continue
						;echo check Raid for Power
						variable int phRaidCount=0
						for(phRaidCount:Set[1];${phRaidCount}<=${Me.Raid};phRaidCount:Inc)
						{
							if ${Me.Raid[${phRaidCount}](exists)} && ${Me.Raid[${phRaidCount}].Health}>0 && ${Me.Raid[${phRaidCount}].InZone} && ${Me.Raid[${phRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${phRaidCount}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${phRaidCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${phRaidCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${phRaidCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						;echo check group Power
						variable int phGroupCount
						if ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							return TRUE
						}
						for(phGroupCount:Set[1];${phGroupCount}<${Me.Group};phGroupCount:Inc)
						{
							;echo checking ${phGroupCount}: ${Me.Group[${phGroupCount}].Name}
							if ${Me.Group[${phGroupCount}](exists)} && ${Me.Group[${phGroupCount}].Health}>0 && ${Me.Group[${phGroupCount}].InZone} && ${Me.Group[${phGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${phGroupCount}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[${phGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Group[${phGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${phGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					else
					{
						;if our target is me
						if ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
						{
							;echo Our Power Target is ${Me}, Checking Power ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							if ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							{
								;echo ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								{
									if ${CastTarget.Equal[FALSE]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
									else
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
								}
								else
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
							elseif ${CombatBotDebug}
								echo Skipping Power Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} 
						}
						;check our target Power
						elseif ${Me.Raid}>0 && ${Me.Raid[id,${CastTarget}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[id,${CastTarget}].IsDead} && ${Me.Raid[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							return TRUE
						}
						elseif ${Me.Group[id,${CastTarget}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[id,${CastTarget}].IsDead} && ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					break
				}
				case InCombatTargeted
				{	
					;echo is incombattargeted
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["Barrier of the Spirits"]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[11,|].Equal[TRUE]}
					{
						if ${Me.Maintained["Ferocity of Spirits"].CurrentIncrements}<3
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["Ferocity of Spirits"].CurrentIncrements}
							continue
						}
					}
					if ${CastTarget.Equal[@Me]} || ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
						{
							if ${CastTarget.Equal[FALSE]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
							else
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						if ${Me.Raid[7].IsDead}
							continue
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[7].ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[7].Name}
							if ${Actor[id,${Me.Raid[7].ID}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[7].ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Raid]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					else
					{
						if ${Me.Raid[id,${CastTarget}].IsDead} || ${Me.Group[id,${CastTarget}].IsDead}
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Actor[id,${CastTarget}].Name} is dead
							continue
						}
						 
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
						else
						{
							if ${Actor[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							}
						}
						return TRUE
					}
					break
				}
				case NamedHostile
				case Hostile
				{
					;continue
					if ${KillTargetHealth}!=-1 && ( ${KillTargetHealth}<=${Int[${UIElement[SettingsAttackHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} || ${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
						noop
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Hostile/NamedHostile Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we have no valid target or the target's health is too high
						continue
					}
					;continue
					;echo ${MaxDist}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} && ${MinDist}>${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].NotEqual[Item:]}
					{
						if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
						{
							if ${MaxDist}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} && ${MinDist}>${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								noop
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: ${MaxDist}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} && ${MinDist}>${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								continue
							}
						}
						elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
						{
							if ${MaxDist}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								
								noop
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: ${MaxDist}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} && ${MinDist}>${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								continue
							}
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: ${MaxDist}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} && ${MinDist}>${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
					{
						if ${MaxDist}>50
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: 50
							continue
						}
					}
					;continue
					;now
					;check if the ability is an AE, if so check mobs, use 3 for default, -uses ui now
					; echo AE: ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|].NotEqual[TRUE]} && ${Mobs.CountAE}<3
					if ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ( ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} || ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} ) && ( !${UIElement[SettingsSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} || !${UIElement[SettingsInstancedSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} || ${UIElement[SettingsDoNotCastAECheckBox@SettingsFrame@CombatBotUI].Checked} ) && ${UIElement[SettingsAE#TextEntry@SettingsFrame@CombatBotUI].Text.NotEqual[FALSE]}
					{
						
						if ${UIElement[SettingsDoNotCastAECheckBox@SettingsFrame@CombatBotUI].Checked}
						{
							if ${CombatBotDebug}
								echo Ignoring AE Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, set to not cast AE's
							continue
						}
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|].NotEqual[TRUE]} 
						{
							;echo ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|].NotEqual[TRUE]} && ( ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} || ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} ) && ( !${UIElement[SettingsSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} || !${UIElement[SettingsInstancedSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} ) && ${UIElement[SettingsAE#TextEntry@SettingsFrame@CombatBotUI].Text.NotEqual[FALSE]}
							if ${AEcount}<${Int[${UIElement[SettingsAE#TextEntry@SettingsFrame@CombatBotUI].Text}]}
							{
								if ${CombatBotDebug}
									echo Ignoring AE Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough mobs
								continue
							}
						}
					}
					;check if the ability is an Encounter, if so check mobs, use 3 for default, -uses ui now
					;echo Encounter: ${istrExportIsAEncounterHostile.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[8,|].NotEqual[TRUE]} && ${Mobs.CountEncounter[${KillTargetID}]}<3
					if ${istrExportIsAEncounterHostile.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}  && ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} && ( !${UIElement[SettingsSkipEncounterCheckBox@SettingsFrame@CombatBotUI].Checked} || && !${UIElement[SettingsInstancedSkipEncounterCheckBox@SettingsFrame@CombatBotUI].Checked} || ${UIElement[SettingsDoNotCastEncounterCheckBox@SettingsFrame@CombatBotUI].Checked} )
					{
						if ${UIElement[SettingsDoNotCastEncounterCheckBox@SettingsFrame@CombatBotUI].Checked}
						{
							if ${CombatBotDebug}
								echo Ignoring Encounter Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, set to not cast Encounter's
							continue
						}
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[8,|].NotEqual[TRUE]}
						{
							if ${RI_Var_String_MySubClass.Equal[Warlock]} && ${Actor[${KillTargetID}](exists)}
							{
								;echo ${KillTargetID}: ${Actor[${KillTargetID}]}
								;echo ${Mobs.CountEncounter[${KillTargetID}]}==1
								if ${ENCcount}<2
								{
									if ${Me.Maintained["Negative Void"](exists)}
									{
										noop
									}
									elseif ${Me.Ability[id,3398339435].IsReady}
									{
										RI_Obj_CB:Cast["Negative Void",TRUE]
										return TRUE
									}
								}
								else
								{
									;echo Encounter: 
									if ${Me.Maintained["Negative Void"](exists)}
										Me.Maintained["Negative Void"]:Cancel
								}
							}
							if ${ENCcount}<${Int[${UIElement[SettingsEncounter#TextEntry@SettingsFrame@CombatBotUI].Text}]}
							{
								if ${CombatBotDebug}
									echo Ignoring Encounter Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough mobs in encounter
								continue
							}
						}
					}
					;check if ability requires flanking   --- NO LONGER NEEDED AS OF 1-5-17 PATCH BY EQ2 MADE ABILITIES GREY OUT WHEN NOT BEHIND/FLANKING
					if ${CombatBotDoBackFlankCalcs} && !${Me.Maintained[Unfetter](exists)}
					{
						if ${istrExportReqFlanking.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}
						{
							if ${Angle}<120
							{
								;echo We are behind/flanking
								noop
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires behind/flanking
								continue
							}
						}
						elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Gouge]}
						{
							;echo Gouge brigand spell called, checking flanking or infront
							if ${Angle}>60
							{
								;echo We are infront/flanking
								noop
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires in front/flanking
								continue
							}
						}
					}

					;echo is a Hostile
					;echo Casting ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} as ${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} with ID ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
					{
						if ${Actor[id,${KillTargetID}].Distance}>50
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: 50
							continue
						}
						else
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
					}
					else
					{
						;check if max is set and then check for incs
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[11,|].Equal[TRUE]}
						{
							;Setting Max Increment Logic for Skull Foci @ 3
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["Skull Foci"]}
							{
								;still need to code the AE portion but for now will keep the ability up
								if ${Me.Maintained["Skull Foci"].CurrentIncrements}<3
								{
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								}
								else
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["Skull Foci"].CurrentIncrements}
									continue
								}
							}
							;Setting Max Increment Logic for World Ablaze @ 3
							elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["World Ablaze"]}
							{
								;still need to code the AE portion but for now will keep the ability up
								if ${Me.Maintained["World Ablaze"].CurrentIncrements}<3
								{
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								}
								else
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["World Ablaze"].CurrentIncrements}
									continue
								}
							}
							if ${Me.Maintained["${strMaxIncrementAbility}"](exists)}
							{
								if ${Me.Maintained["${strMaxIncrementAbility}"].CurrentIncrements}<${intMaxIncrements}
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Max Increments of ${intMaxIncrements} for "${strMaxIncrementAbility}" has not been reached we are at ${Me.Maintained["${strMaxIncrementAbility}"].CurrentIncrements}
									continue
								}
							}
							else 
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Max Increments Ability: ""${strMaxIncrementAbility}" not found in Maintained
								continue
							}
						}
						Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
					}
					return TRUE
					break
				}
				case Buff
				case OutOfCombatBuff
				{
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[OutOfCombatBuff]}
					{
						if ( ${Me.InCombat} || ${Me.IsHated} )
						{
							if ${CombatBotDebug}
								echo Ignoring OutOfCombatBuff Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are in combat
							continue
						}
					}
					;echo is a Buff
					if ${CastTarget.Equal[@Me]} || ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
						{
							if ${CastTarget.Equal[FALSE]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
							else
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							if ${CastTarget.Equal[FALSE]}
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Raid]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					else
					{
						if ${Me.Raid[id,${CastTarget}].IsDead} || ${Me.Group[id,${CastTarget}].IsDead}
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Actor[id,${CastTarget}].Name} is dead
							continue
						}
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
						elseif ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
						}
						return TRUE
					}
					break
				}
			}
		}
		second:Set[${Script.RunningTime}]
		echo Time Taken: ${Math.Calc[${second}-${first}]}
	}
	member:bool CheckAllOld(int start, int end)
	{
		;echo ${Script.RunningTime}
		;echo Checking from ${start} to ${end}
		variable int count=0		
		boolAbilityCast:Set[FALSE]
		boolItemCast:Set[FALSE]
		strCastName:Set[""]
		strCastNameShort:Set[""]
		strCastID:Set[0]
		strCastTarget:Set[""]
		;echo ability requires flanking
		;check if we are behind or flanking
		;echo ${KillTargetID} : ${Actor[${KillTargetID}].Name}
		Heading:Set[${Actor[${KillTargetID}].Heading}]
		HeadingTo:Set[${Actor[${KillTargetID}].HeadingTo}]
		Angle:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
		if ${Angle} < -1 
			Angle:Set[-1]
		if ${Angle} > 1
			Angle:Set[1]	
		Angle:Set[${Math.Acos[${Angle}]}]
		;AE
		AEcount:Set[${Mobs.CountAE}]
		ENCcount:Set[${Mobs.CountEncounter[${KillTargetID}]}]
		RangeCalc:Set[${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})]}]
		MinDist:Set[${Math.Calc[${Actor[id,${KillTargetID}].Distance}+${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})]}]}]
		MaxDist:Set[${Math.Calc[${Actor[id,${KillTargetID}].Distance}-${Math.Calc[(${Actor[id,${KillTargetID}].CollisionRadius} * ${Actor[id,${KillTargetID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})]}]}]
		if ${RI_Obj_CB.GetUISetting[SettingsStartHeroicCheckBox]} && ${Me.InCombat} && ${EQ2.ServerName.NotEqual[Battlegrounds]}
		{
			switch ${Me.Archetype}
			{
				case fighter
				{
					if ${Me.Ability[id,438025554].IsReady} && !${EQ2.HOWindowActive}
					{
						Cast "Fighting Chance" "Fighting Chance" 438025554
						return TRUE
					}
					break
				}
				case mage
				{
					if ${Me.Ability[id,1605359312].IsReady} && !${EQ2.HOWindowActive}
					{
						Cast "Arcane Augur" "Arcane Augur" 1605359312
						return TRUE
					}
					break
				}
				case priest
				{
					if ${Me.Ability[id,3972280100].IsReady} && !${EQ2.HOWindowActive}
					{
						Cast "Divine Providence" "Divine Providence" 3972280100
						return TRUE
					}
					break
				}
				case scout
				{
					if ${Me.Ability[id,1793121952].IsReady} && !${EQ2.HOWindowActive}
					{
						Cast "Lucky Break" "Lucky Break" 1793121952
						return TRUE
					}
					break
				}
			}
		}
		;${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}
		for(mainCount:Set[${start}];${mainCount}<=${end};mainCount:Inc)
		;mainCount:Set[${start}]
		;while ${mainCount:Inc}<=${end}
		{
			;echo for caloop
			count:Set[${mainCount}]

			if ${CombatBotDebug}
				echo Checking #${count} of ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} with ID ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
			;continue
			; if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Summon Mount]}
			; {
				;;check if we are moving
				; if ${Me.IsMoving}
				; {
					; if ${CombatBotDebug}
						; echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are moving
					; continue
				; }
				;;check if outofcombat or incombatbuff
				; if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[OutOfCombatBuff]} && ${Me.InCombat}
				; {
					; if ${CombatBotDebug}
						; echo Ignoring OutOfCombatBuff Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} Because We are InCombat
					; continue
				; }
				;;check if we are riding a mount if not cast one
				; if !${Me.OnHorse} && !${Me.OnFlyingMount} && ${Me.GetGameData[Self.ZoneName].Label.NotEqual[The Frillik Tide]}
					; SummonMount:Set[TRUE]
				; else
				; {
					; if ${CombatBotDebug}
						; echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because we are already on a mount, or inside a zone that reports we are not
				; }
				; continue
			; }
			
			if !${This.AbilityTypeEnabled[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}]}
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}'s are disabled
				continue
			}
			if !${UIElement[SettingsCastAbilitiesCheckBox@SettingsFrame@CombatBotUI].Checked}
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because Abilities are disabled
				continue
			}
			if ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Hostile]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[NamedHostile]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[InCombatTargeted]} ) && ( !${Me.InCombat} && !${Me.IsHated} )
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, because we are not in combat
				continue
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].NotEqual[Adrenaline Boost]} && !${RI_Var_Bool_CastWhileMoving} && ${Me.IsMoving} && ${istrExportSpellBookType.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}!=1 && !${Me.Maintained[Cloak of Divinity](exists)}
			{
				if ${Me.SubClass.Equal[channeler]}
				{
					if ${Me.Maintained[Combat Awareness](exists)}
						noop
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are moving
						continue
					}
				}
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are moving
					continue
				}
			}
			if ${Me.FlyingUsingMount} 
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are flying
				continue
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
			{
				if ${CombatBotDebug}
					echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is disabled
				continue
			}
			if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[NamedHostile]}
			{
				;echo is NamedHostile
				if ${Target.Type.Equal[NamedNPC]} || ${Target.Target.Type.Equal[NamedNPC]} || ${Target.Name.Equal["training dummy"]} || ${Target.Target.Name.Equal["training dummy"]} || ${UIElement[SettingsAlwaysCastNamedHostileCheckBox@SettingsFrame@CombatBotUI].Checked}
				{
					noop
				}
				else
				{
					if ${CombatBotDebug}
						echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, it is a NamedHostile and our KillTarget is not a named
					continue
				}
			}
			if ${Me.SubClass.Equal[beastlord]} 
			{
				if ${Me.Maintained[Spiritual Stance](exists)} && ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Silent Talon]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Feral Pounce]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Shadow Leap]} )
				{
					if ${CombatBotDebug}
						echo Ignoring Feral Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are in spiritual
					continue
				}
			}
			
			;echo 1
			;if ${CombatBotDebug2}
				;echo if \${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709 && ( ${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].IsReady} && \${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].NotEqual[Item:]} ) || ( \${Me.Equipment["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}<0 || \${Me.Inventory["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}<0 ) || ( \${istrExportReqStealth.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}].Equal[TRUE]} && \${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].TimeUntilReady}==0 )
			if ( ( ${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].IsReady} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure]} )
;			&& ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].NotEqual[Item:]} ) || ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]} && ( ${Me.Equipment["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}<0 || ${Me.Inventory["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}<0 ) ) || ( ${istrExportReqStealth.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}].Equal[TRUE]} && ${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].TimeUntilReady}==0 )
			{
				; continue
				;if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
				;	echo item is ready
				;else
				;	echo ability is ready
				
				if ${istrExportCastingTime.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
					boolInstantCast:Set[TRUE]
				else 
					boolInstantCast:Set[FALSE]
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Buff]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[OutOfCombatBuff]}
					boolBuff:Set[TRUE]
				else 
					boolBuff:Set[FALSE]
				;if my spell has a target, lets check aliases and convert
				;echo before target checks

				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[FALSE]}
				{
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[@Group]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[@Raid]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[@Me]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[@NotSelfGroup]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].NotEqual[@PCTarget]}
					{
						;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} ability has target
						CastTarget:Set[${This.ConvertAliases[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|]}]}]
						if ${CastTarget}==0
						{
							if ${CombatBotDebug}
								echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we didnt find target ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|]}
							continue
						}
						else
						{	
							;first see if cast target is me
							if ${CastTarget.Equal[${Me.ID}]}
								CastTarget:Set[${Me.ID}]
							;see if we are in raid
							elseif ${Me.Raid}>0 && ${istrExportAllowRaid.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}
							{
								;now see if the CastTarget exists and is in same zone //OLD WAY - ${Me.Raid[id,${CastTarget}](exists)} //
								if ${Actor[id,${CastTarget}](exists)} && ${Me.Raid[id,${CastTarget}].InZone}
								{
									;now check if they are out of MaxRange
									if ${Me.Raid[id,${CastTarget}].Distance}>${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									{
										if ${CombatBotDebug}
											echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${CastTarget} is not within range
										boolAbilityCast:Set[FALSE]
										boolItemCast:Set[FALSE]
										continue
									}
								}
								else
								{
									if ${CombatBotDebug}
										echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we didnt find target ${Actor[${CastTarget}].Name}
									boolAbilityCast:Set[FALSE]
									boolItemCast:Set[FALSE]
									continue
								}
							}
							else
							{
								;now see if the CastTarget exists and is in same zone
								if ${Actor[id,${CastTarget}](exists)} && ${Me.Group[id,${CastTarget}].InZone}
								{
									;now check if they are out of MaxRange
									if ${Me.Group[id,${CastTarget}].Distance}>${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									{
										if ${CombatBotDebug}
											echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${CastTarget} is not within range
										boolAbilityCast:Set[FALSE]
										boolItemCast:Set[FALSE]
										continue
									}
								}
								else
								{
									if ${CombatBotDebug}
										echo Skipping Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we didnt find target ${Actor[${CastTarget}].Name} in our group and the ability does not allow raid
									boolAbilityCast:Set[FALSE]
									boolItemCast:Set[FALSE]
									continue
								}
							}
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Me]}
						CastTarget:Set[${Me.ID}]
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@PCTarget]}
					{
						if ${Target.Type.Equal[PC]}
							CastTarget:Set[${Target.ID}]
						elseif ${Target.Target.Type.Equal[PC]}
							CastTarget:Set[${Target.Target.ID}]
						else
						{
							if ${CombatBotDebug}
								echo Ignoring PCTarget Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, neither our target nor implied target are a player character
							continue
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Group]}
					{
						if ${Me.Group}>1
							CastTarget:Set[@Group]
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Group Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are not in a group
							continue
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Raid]}
					{
						if ${Me.Raid}>0
						{
							if ${istrExportAllowRaid.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}
								CastTarget:Set[@Raid]
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Raid Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, does not allow raid
								continue
							}
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Raid Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are not in a raid
							continue
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@NotSelfGroup]}
					{
						if ${Me.Raid}>0
							CastTarget:Set[@NotSelfGroup]
						else
						{
							if ${CombatBotDebug}
								echo Ignoring NotSelfGroup Target Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, there are no other groups
							continue
						}
					}
					else
					{
						if ${CombatBotDebug}
							echo CombatBot error: I did not understand the target for ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}]}
;						- FULLVALUE - ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value}
					}
					if ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Heal]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Power]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[InCombatTargeted]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Cure]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Buff]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[OutOfCombatBuff]} )
					{
						;echo ability is death check cast target ability
						if ${Actor[id,${CastTarget}].IsDead}
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Actor[id,${CastTarget}].Name} is dead
							continue
						}
						;echo target must be alive ${CastTarget} ${Actor[id,${CastTarget}].IsDead}
					}
				}
				else
				{
					CastTarget:Set[FALSE]
					;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} ability has no target
				}
				;echo after target checks for counter: ${count}
				if ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Hostile]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[NamedHostile]} )
					;&& ( ( ${Target(exists)} && ${Target.Type.NotEqual[PC]} && ${Target.ID}!=${KillTargetID} ) || ( ${Target.Type.Equal[PC]} && ${Target.Target(exists)} && ${Target.Target.Type.NotEqual[PC]} && ${Target.Target.ID}!=${KillTargetID} ) )
				{
					; if ${Target(exists)}
					; {
						; if ${Target.Type.Equal[PC]}
						; {
							; if ${Target.Target.Type.Equal[NamedNPC]} || ${Target.Target.Type.Equal[NPC]}
							; {
								; KillTargetID:Set[${Target.Target.ID}]
								; if ${FaceNPC.Equal[TRUE]} && ${FaceNPCNow}
									; Actor[${KillTargetID}]:DoFace
								; if ${Me.Pet(exists)} && ( !${Me.Pet.InCombatMode} || ${Me.Pet.Target.ID}!=${KillTargetID} )
									; eq2execute pet attack
							; }
						; }
						; elseif ${Target.Type.NotEqual[PC]}
						; {
							; if ${Target.Type.Equal[NamedNPC]} || ${Target.Type.Equal[NPC]}
							; {
								; KillTargetID:Set[${Target.ID}]
								; if ${FaceNPC.Equal[TRUE]} && ${FaceNPCNow}
									; Actor[${KillTargetID}]:DoFace
								; if ${Me.Pet(exists)} && ( !${Me.Pet.InCombatMode} || ${Me.Pet.Target.ID}!=${KillTargetID} )
									; eq2execute pet attack
							; }
						; }
						; else
						; {
							; if ${CombatBotDebug}
								; echo Ignoring CA/NamedHostile Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we have no valid target
							; mainCount:Set[1]
							; boolAbilityCast:Set[FALSE]
							; boolItemCast:Set[FALSE]
							; continue
						; }
					; }
					if ${KillTargetID}!=0 && ${Actor[id,${KillTargetID}](exists)} && !${Actor[id,${KillTargetID}].IsDead} && ( ${Actor[id,${KillTargetID}].Health}<=${Int[${UIElement[SettingsAttackHealthTextEntry@SettingsFrame@CombatBotUI].Text}]} || ${UIElement[SettingsSkipMobAttackHealthCheckBox@SettingsFrame@CombatBotUI].Checked} )
						noop
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Hostile/NamedHostile Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we have no valid target or the target's health is too high
						continue
					}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].NotEqual[Item:]}
					{
						if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
						{
							if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								noop
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								continue
							}
						}
						elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
						{
							if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
							{
								
								noop
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								continue
							}
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
						}
					}
					;echo end hostile ${count}
				}
				;echo after hostile ${count}
				;check if the ability is an AE, if so check mobs, use 3 for default, -uses ui now
				; echo AE: ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|].NotEqual[TRUE]} && ${Mobs.CountAE}<3
				if ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ( ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} || ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} ) && ( !${UIElement[SettingsSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} || !${UIElement[SettingsInstancedSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} || ${UIElement[SettingsDoNotCastAECheckBox@SettingsFrame@CombatBotUI].Checked} ) && ${UIElement[SettingsAE#TextEntry@SettingsFrame@CombatBotUI].Text.NotEqual[FALSE]}
				{
					
					if ${UIElement[SettingsDoNotCastAECheckBox@SettingsFrame@CombatBotUI].Checked}
					{
						if ${CombatBotDebug}
							echo Ignoring AE Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, set to not cast AE's
						continue
					}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|].NotEqual[TRUE]} 
					{
						;echo ${istrExportIsAE.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[9,|].NotEqual[TRUE]} && ( ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} || ${istrExportIsSelfAbility.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} ) && ( !${UIElement[SettingsSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} || !${UIElement[SettingsInstancedSkipAECheckBox@SettingsFrame@CombatBotUI].Checked} ) && ${UIElement[SettingsAE#TextEntry@SettingsFrame@CombatBotUI].Text.NotEqual[FALSE]}
						if ${AEcount}<${Int[${UIElement[SettingsAE#TextEntry@SettingsFrame@CombatBotUI].Text}]}
						{
							if ${CombatBotDebug}
								echo Ignoring AE Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough mobs
							continue
						}
					}
				}
				;check if the ability is an Encounter, if so check mobs, use 3 for default, -uses ui now
				;echo Encounter: ${istrExportIsAEncounterHostile.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[8,|].NotEqual[TRUE]} && ${Mobs.CountEncounter[${KillTargetID}]}<3
				if ${istrExportIsAEncounterHostile.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}  && ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].NotEqual[TRUE]} && ( !${UIElement[SettingsSkipEncounterCheckBox@SettingsFrame@CombatBotUI].Checked} || && !${UIElement[SettingsInstancedSkipEncounterCheckBox@SettingsFrame@CombatBotUI].Checked} || ${UIElement[SettingsDoNotCastEncounterCheckBox@SettingsFrame@CombatBotUI].Checked} )
				{
					if ${UIElement[SettingsDoNotCastEncounterCheckBox@SettingsFrame@CombatBotUI].Checked}
					{
						if ${CombatBotDebug}
							echo Ignoring Encounter Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, set to not cast Encounter's
						continue
					}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[8,|].NotEqual[TRUE]}
					{
						if ${RI_Var_String_MySubClass.Equal[Warlock]} && ${Actor[${KillTargetID}](exists)}
						{
							;echo ${KillTargetID}: ${Actor[${KillTargetID}]}
							;echo ${Mobs.CountEncounter[${KillTargetID}]}==1
							if ${ENCcount}<2
							{
								if ${Me.Maintained["Negative Void"](exists)}
								{
									noop
								}
								elseif ${Me.Ability[id,3398339435].IsReady}
								{
									RI_Obj_CB:Cast["Negative Void",TRUE]
									return TRUE
								}
							}
							else
							{
								;echo Encounter: 
								if ${Me.Maintained["Negative Void"](exists)}
									Me.Maintained["Negative Void"]:Cancel
							}
						}
						if ${ENCcount}<${Int[${UIElement[SettingsEncounter#TextEntry@SettingsFrame@CombatBotUI].Text}]}
						{
							if ${CombatBotDebug}
								echo Ignoring Encounter Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough mobs in encounter
							continue
						}
					}
				}
				;echo Duration: ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} -- IsBeneficial: ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} -- IgnoreDuration: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|]}
				;echo before duration check
				;first check if isitem
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
				{
					if ${EQ2.ServerName.Equal[Battlegrounds]}
						continue
					variable int itemMaintainedCount=0
					variable bool boolFoundItemInItemList=FALSE
					boolFoundItemInItemList:Set[FALSE]
					variable bool boolFoundItemInMaintained=FALSE
					boolFoundItemInMaintained:Set[FALSE]
					for(itemMaintainedCount:Set[1];${itemMaintainedCount}<=${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Items};itemMaintainedCount:Inc)
					{
						;echo forloop1
						if ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Text.Equal["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"]}
						{
							;echo found item in our ItemList, ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Text} : ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}, checking EffectName ${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}
							variable int cmID1=${KillTargetID}
							variable int iepCMCount
							for(iepCMCount:Set[1];${iepCMCount}<=${Me.CountMaintained};iepCMCount:Inc)
							{
							;echo forloop2
								;echo if ${Me.Maintained[${iepCMCount}].Name.Equal["${istrItemEffectPairsEffectName.Get[${itemMaintainedCount}]}"]} 
								if ${Me.Maintained[${iepCMCount}].Name.Equal["${UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI].Item[${itemMaintainedCount}].Value}"]} 
								{
									;echo found spell in maintained, checking if it has a target and if its the correct target
									boolFoundItemInItemList:Set[TRUE]
									if ${Me.Maintained[${iepCMCount}].Target(exists)}
									{
										;echo has a target
										if ${Me.Maintained[${iepCMCount}].Target.ID}==${cmID1} && (${Me.Maintained[${iepCMCount}].Duration}>0 || ${Me.Maintained[${iepCMCount}].Duration}==-1)
										{
											if ${CombatBotDebug}
												echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on ${Actor[${KillTargetID}].Name}
											boolItemCast:Set[FALSE]
											boolAbilityCast:Set[FALSE]
											boolFoundItemInMaintained:Set[TRUE]
											break
										}
										if ${Me.Maintained[${iepCMCount}].Target.ID}==${Me.ID} && (${Me.Maintained[${iepCMCount}].Duration}>0 || ${Me.Maintained[${iepCMCount}].Duration}==-1)
										{
											if ${CombatBotDebug}
												echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on Me
											boolItemCast:Set[FALSE]
											boolAbilityCast:Set[FALSE]
											boolFoundItemInMaintained:Set[TRUE]
											break
										}
									}
									else
									{
										;echo doesnt have a target, continueing
										if ${Me.Maintained[${iepCMCount}].Duration}>0 || ${Me.Maintained[${iepCMCount}].Duration}==-1
										{
											if ${CombatBotDebug}
												echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained
											boolItemCast:Set[FALSE]
											boolAbilityCast:Set[FALSE]
											boolFoundItemInMaintained:Set[TRUE]
											break
										}
									}
								}
							}
						}
						;echo im getting here
						if ${boolFoundItemInMaintained}
							continue
					}
					if ${boolFoundItemInMaintained}
						continue
					;echo im getting here
					if !${boolFoundItemInItemList}
					{
						;echo didnt found item in our ItemEffectPairs, checking ItemName
						variable int cmID2=${KillTargetID}
						variable int iepCMCount2
						;variable bool boolFoundItemInMaintained=FALSE
						for(iepCMCount2:Set[1];${iepCMCount2}<=${Me.CountMaintained};iepCMCount2:Inc)
						{
							if ${Me.Maintained[${iepCMCount2}].Name.Equal["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"]} 
							{
								;echo found spell in maintained, checking if it has a target and if its the correct target
								if ${Me.Maintained[${iepCMCount2}].Target(exists)}
								{
									;echo has a target
									if ${Me.Maintained[${iepCMCount2}].Target.ID}==${cmID2} && (${Me.Maintained[${iepCMCount2}].Duration}>0 || ${Me.Maintained[${iepCMCount2}].Duration}==-1)
									{
										if ${CombatBotDebug}
											echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on ${Actor[${KillTargetID}].Name}
										boolItemCast:Set[FALSE]
										boolAbilityCast:Set[FALSE]
										boolFoundItemInMaintained:Set[TRUE]
										break
									}
									if ${Me.Maintained[${iepCMCount2}].Target.ID}==${Me.ID} && (${Me.Maintained[${iepCMCount2}].Duration}>0 || ${Me.Maintained[${iepCMCount2}].Duration}==-1)
									{
										if ${CombatBotDebug}
											echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on Me
										boolItemCast:Set[FALSE]
										boolAbilityCast:Set[FALSE]
										boolFoundItemInMaintained:Set[TRUE]
										break
									}
								}
								else
								{
									;echo doesnt have a target, continueing
									if ${Me.Maintained[${iepCMCount2}].Duration}>0 || ${Me.Maintained[${iepCMCount2}].Duration}==-1
									{
										if ${CombatBotDebug}
											echo Ignoring ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained
										boolItemCast:Set[FALSE]
										boolAbilityCast:Set[FALSE]
										boolFoundItemInMaintained:Set[TRUE]
										break
									}
								}
							}
						}
						; echo im getting here
						if ${boolFoundItemInMaintained}
							continue
					}
				}
				;then check if MaxDuration is >0 and ignore duration is set to false
				elseif ( ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0 || ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==-1 ) && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|].NotEqual[TRUE]}
				{
					;echo Maintained Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}]}
					;echo checking maintained because duration is either >0 or -1
					;echo ( ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0 || ${istrExportMaxDuration.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==-1 ) && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[7,|]}
					variable int cmID
					if ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${CastTarget.NotEqual[FALSE]}
						cmID:Set[${Actor[${CastTarget}].ID}]
					elseif ${istrExportIsBeneficial.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]} && ${CastTarget.Equal[FALSE]}
						cmID:Set[${Me.ID}]
					else
						cmID:Set[${KillTargetID}]
						
					variable int cmCount=1
					variable bool boolFoundAbilityInMaintained=FALSE
					boolFoundAbilityInMaintained:Set[FALSE]
					for(cmCount:Set[1];${cmCount}<=${Me.CountMaintained};cmCount:Inc)
					{
						;echo Checking #${cmCount}: ${Me.Maintained[${cmCount}].Name} against "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"
						if ${Me.Maintained[${cmCount}].Name.Equal["${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}"]} 
						{
							;echo found spell in maintained, checking if it has a target and if its the correct target
							if ${Me.Maintained[${cmCount}].Target(exists)}
							{
								;echo has a target, checking ${Me.Maintained[${cmCount}].Target.Name} : ${Me.Maintained[${cmCount}].Target.ID} against ${Actor[${cmID}].Name} : ${cmID}
								if ${Me.Maintained[${cmCount}].Target.ID}==${cmID} && (${Me.Maintained[${cmCount}].Duration}>0 || ${Me.Maintained[${cmCount}].Duration}==-1)
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained on ${Actor[${cmID}].Name}
									boolItemCast:Set[FALSE]
									boolAbilityCast:Set[FALSE]
									boolFoundAbilityInMaintained:Set[TRUE]
									;break
								}
							}
							else
							{
								;echo doesnt have a target, continueing
								if ${Me.Maintained[${cmCount}].Duration}>0 || ${Me.Maintained[${cmCount}].Duration}==-1
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, already maintained
									boolItemCast:Set[FALSE]
									boolAbilityCast:Set[FALSE]
									boolFoundAbilityInMaintained:Set[TRUE]
									;break
								}
							}
						}
					}
					;echo here1 ${boolFoundAbilityInMaintained}
					if ${boolFoundAbilityInMaintained}
						continue
					;echo here2
				}
				;echo after maintained check
				;echo after maintained checking ${count}
				;check if ability requires flanking   --- NO LONGER NEEDED AS OF 1-5-17 PATCH BY EQ2 MADE ABILITIES GREY OUT WHEN NOT BEHIND/FLANKING
				if ${CombatBotDoBackFlankCalcs} && !${Me.Maintained[Unfetter](exists)}
				{
					if ${istrExportReqFlanking.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}].Equal[TRUE]}
					{
						if ${Angle}<120
						{
							;echo We are behind/flanking
							noop
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires behind/flanking
							continue
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Gouge]}
					{
						;echo Gouge brigand spell called, checking flanking or infront
						if ${Angle}>60
						{
							;echo We are infront/flanking
							noop
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires in front/flanking
							continue
						}
					}
				}

				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]}>0 && ${RI_Var_String_MySubClass.Equal[beastlord]}
				{
					;echo ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} is saying savagery
					if ${Me.GetGameData[Self.SavageryLevel].Label}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]}
					{
						if ${Script.RunningTime}<${Math.Calc[${LastSavageryCastTime}+1000]} && !${Me.Maintained[Savagery Freeze](exists)} && ${UIElement[SubClassBeastlordPrimalDelayCheckBox@SubClassFrame@CombatBotUI].Checked}
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we casted a savagery ability less than 1s ago :: ${Script.RunningTime}<${Math.Calc[${LastSavageryCastTime}+1000]}
							continue
						}
						LastSavageryCastTime:Set[${Script.RunningTime}]
						;echo Setting LastSavageryCastTime because we are casting ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}
						noop
					}
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[12,|]} and we only have ${Me.GetGameData[Self.SavageryLevel].Label}
						continue
					}
				}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]}>0 && ${RI_Var_String_MySubClass.Equal[channeler]}
				{
					if ${Me.Dissonance}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]}
						noop
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires greater than ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[14,|]} disonance and we have ${Me.Dissonance}
						continue
					}
				}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]}>0 && ${RI_Var_String_MySubClass.Equal[channeler]}
				{
					if ${Me.Dissonance}<=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]}
						noop
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, requires less than ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[13,|]} disonance and we only have ${Me.Dissonance}
						continue
					}
				}
				if ${RI_Var_String_MySubClass.Equal[assassin]} || ${RI_Var_String_MySubClass.Equal[ranger]}
				{
					if ${Me.Ability[id,3363812126].IsReady} && ${CombatBotCastExploitWeakness}
					{
						if ${Me.Maintained[Weakness Detected](exists)}
						{
							Cast "Exploit Weakness" "Exploit Weakness" 3363812126
							return TRUE
						}
					}
				}
				;echo Just Before Type Checks ${count}
				;echo Casting ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} as ${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} with id of ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
				if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Cure]}
				{
					;echo is a Cure
					;first check if the cure has a # of people attached to it (AKA a group cure) then check the entire group for nox,ele,tra,arc, and add them up and cast if that number or higher
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						
						variable int gcure=0
						variable int cureCount=0
						if ${Me.Noxious}>0 || ${Me.Trauma}>0 || ${Me.Arcane}>0 || ${Me.Elemental}>0
							gcure:Inc
						
						for(cureCount:Set[1];${cureCount}<${Me.Group};cureCount:Inc)
						{
							if ${Me.Group[${cureCount}](exists)} && ${Me.Group[${cureCount}].Health}>0 && ${Me.Group[${cureCount}].InZone} && ${Me.Group[${cureCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${cureCount}].Noxious}>0 || ${Me.Group[${cureCount}].Trauma}>0 || ${Me.Group[${cureCount}].Arcane}>0 || ${Me.Group[${cureCount}].Elemental}>0
									gcure:Inc
							}
						}
						if ${gcure}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							return TRUE
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough cures
						}
							
					}
					;check if the cure is cure
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure Magic]} || ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Shed Skin]}
					{
						;echo we made it
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@NotSelfGroup]}
						{
							;check NotSelfGroup for cureable afflictions
							variable int cureNotSelfGroupCount=0
							for(cureNotSelfGroupCount:Set[7];${cureNotSelfGroupCount}<=${Me.Raid};cureNotSelfGroupCount:Inc)
							{
								if ${Me.Raid[${cureNotSelfGroupCount}](exists)} && ${Me.Raid[${cureNotSelfGroupCount}].Health}>0 && ${Me.Raid[${cureNotSelfGroupCount}].InZone} && ${Me.Raid[${cureNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${cureNotSelfGroupCount}].Noxious}>0 || ${Me.Raid[${cureNotSelfGroupCount}].Trauma}>0 || ${Me.Raid[${cureNotSelfGroupCount}].Arcane}>0 || ${Me.Raid[${cureNotSelfGroupCount}].Elemental}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${cureNotSelfGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Raid]}
						{
							;check Raid for cureable afflictions
							variable int cureRaidCount=0
							for(cureRaidCount:Set[1];${cureRaidCount}<=${Me.Raid};cureRaidCount:Inc)
							{
								if ${Me.Raid[${cureRaidCount}](exists)} && ${Me.Raid[${cureRaidCount}].Health}>0 && ${Me.Raid[${cureRaidCount}].InZone} && ${Me.Raid[${cureRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${cureRaidCount}].Noxious}>0 || ${Me.Raid[${cureRaidCount}].Trauma}>0 || ${Me.Raid[${cureRaidCount}].Arcane}>0 || ${Me.Raid[${cureRaidCount}].Elemental}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${cureRaidCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[4,|].Equal[@Group]}
						{
							;check group for cureable afflictions
							variable int cureGroupCount
							if ${Me.Noxious}>0 || ${Me.Trauma}>0 || ${Me.Arcane}>0 || ${Me.Elemental}>0
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
							for(cureGroupCount:Set[1];${cureGroupCount}<${Me.Group};cureGroupCount:Inc)
							{
								if ${Me.Group[${cureGroupCount}](exists)} && ${Me.Group[${cureGroupCount}].Health}>0 && ${Me.Group[${cureGroupCount}].InZone} && ${Me.Group[${cureGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Group[${cureGroupCount}].Noxious}>0 || ${Me.Group[${cureGroupCount}].Trauma}>0 || ${Me.Group[${cureGroupCount}].Arcane}>0 || ${Me.Group[${cureGroupCount}].Elemental}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${cureGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						else
						{
							if ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
							{
								if ${Me.Noxious}>0 || ${Me.Trauma}>0 || ${Me.Arcane}>0 || ${Me.Elemental}>0
								{
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
									return TRUE
								}
							}
							;if our target has any affliction cast cure on them
							elseif (${Me.Group[id,${CastTarget}].Noxious}>0 || ${Me.Group[id,${CastTarget}].Trauma}>0 || ${Me.Group[id,${CastTarget}].Arcane}>0 || ${Me.Group[id,${CastTarget}].Elemental}>0 || ${Me.Raid[id,${CastTarget}].Noxious}>0 || ${Me.Raid[id,${CastTarget}].Trauma}>0 || ${Me.Raid[id,${CastTarget}].Arcane}>0 || ${Me.Raid[id,${CastTarget}].Elemental}>0) && (${Me.Group[${cureGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} || ${Me.Raid[${cureGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]})
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
					}
					elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[Cure Curse]}
					{
						if ${CastTarget.Equal[@NotSelfGroup]}
						{
							;check NotSelfGroup for curse
							variable int curseNotSelfGroupCount
							for(curseNotSelfGroupCount:Set[7];${curseNotSelfGroupCount}<=${Me.Raid};curseNotSelfGroupCount:Inc)
							{
								if ${Me.Raid[${curseNotSelfGroupCount}](exists)} && ${Me.Raid[${curseNotSelfGroupCount}].Health}>0 && ${Me.Raid[${curseNotSelfGroupCount}].InZone} && ${Me.Raid[${curseNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${curseNotSelfGroupCount}].Cursed}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${curseNotSelfGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${CastTarget.Equal[@Raid]}
						{
							;check Raid for curse
							variable int curseRaidCount
							for(curseRaidCount:Set[1];${curseRaidCount}<=${Me.Raid};curseRaidCount:Inc)
							{
								if ${Me.Raid[${curseRaidCount}](exists)} && ${Me.Raid[${curseRaidCount}].Health}>0 && ${Me.Raid[${curseRaidCount}].InZone} && ${Me.Raid[${curseRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Raid[${curseRaidCount}].Cursed}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${curseRaidCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						elseif ${CastTarget.Equal[@Group]}
						{
							;check group for curse
							variable int curseGroupCount
							if ${Me.Cursed}>0
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
							for(curseGroupCount:Set[1];${curseGroupCount}<${Me.Group};curseGroupCount:Inc)
							{
								if ${Me.Group[${curseGroupCount}](exists)} && ${Me.Group[${curseGroupCount}].Health}>0 && ${Me.Group[${curseGroupCount}].InZone} && ${Me.Group[${curseGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${Me.Group[${curseGroupCount}].Cursed}>0
									{
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${curseGroupCount}].ID}
										return TRUE
									}
								}
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
						else
						{
							;if our target has any affliction cast cure on them
							if ( ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]} ) && ${Me.Cursed}>0
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
							elseif (${Me.Group[id,${CastTarget}].Cursed}>0 || ${Me.Raid[id,${CastTarget}].Cursed}>0) && (${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} || ${Me.Raid[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]})
							{
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to cure
						}
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Heal]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is a heal
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						variable int groupCount1
						variable int lowhealth=0
						if ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							lowhealth:Inc
						for(groupCount1:Set[1];${groupCount1}<${Me.Group};groupCount1:Inc)
						{
							if ${Me.Group[${groupCount1}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && ${Me.Group[${groupCount1}](exists)} && ${Me.Group[${groupCount1}].Health}>0 && ${Me.Group[${groupCount1}].InZone} && !${Me.Group[${groupCount1}].IsDead} && ${Me.Group[${groupCount1}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								lowhealth:Inc
						}
						if ${lowhealth}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough to heal
					}
					;check if the target is NotSelfGroup
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						;echo check NotSelfGroup for health
						variable int NotSelfGroupCount=0
						for(NotSelfGroupCount:Set[7];${NotSelfGroupCount}<=${Me.Raid};NotSelfGroupCount:Inc)
						{
							if ${Me.Raid[${NotSelfGroupCount}](exists)} && ${Me.Raid[${NotSelfGroupCount}].Health}>0 && ${Me.Raid[${NotSelfGroupCount}].InZone} && ${Me.Raid[${NotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${NotSelfGroupCount}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${NotSelfGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${NotSelfGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${NotSelfGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					;check if the target is raid
					elseif ${CastTarget.Equal[@Raid]}
					{
						;echo check Raid for health
						variable int raidCount=0
						for(raidCount:Set[1];${raidCount}<=${Me.Raid};raidCount:Inc)
						{
							if ${Me.Raid[${raidCount}](exists)} && ${Me.Raid[${raidCount}].Health}>0 && ${Me.Raid[${raidCount}].InZone} && ${Me.Raid[${raidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${raidCount}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${raidCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${raidCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${raidCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						;echo check group health
						variable int groupCount
						if ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							return TRUE
						}
						for(groupCount:Set[1];${groupCount}<${Me.Group};groupCount:Inc)
						{
							;echo checking ${groupCount}: ${Me.Group[${groupCount}].Name}
							if ${Me.Group[${groupCount}](exists)} && ${Me.Group[${groupCount}].Health}>0 && ${Me.Group[${groupCount}].InZone} && ${Me.Group[${groupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${groupCount}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[${groupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Group[${groupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${groupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
					else
					{
						;if our target is me
						if ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
						{
							;echo Our Heal Target is ${Me}, Checking health ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							if ${Me.Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							{
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								{
									if ${CastTarget.Equal[FALSE]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
									else
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
								}
								else
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
						}
						;check our target health
						else
						{
							;echo Our Heal Target is ${CastTarget}, Checking health ${Me.Group[id,${CastTarget}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							if ${Me.Raid}>0
							{
								if ${Me.Raid[id,${CastTarget}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[id,${CastTarget}].IsDead} && ${Me.Raid[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
									return TRUE
								}
							}
							elseif ${Me.Group[id,${CastTarget}].Health}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[id,${CastTarget}].IsDead} && ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
									call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
								else
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								return TRUE
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to heal
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Power]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is a Power
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						variable int phGroupCount1
						variable int lowPower=0
						if ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							lowPower:Inc
						for(phGroupCount1:Set[1];${phGroupCount1}<${Me.Group};phGroupCount1:Inc)
						{
							if ${Me.Group[${phGroupCount1}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[${phGroupCount1}].IsDead} && ${Me.Group[${phGroupCount1}](exists)} && ${Me.Group[${phGroupCount1}].Health}>0 && ${Me.Group[${phGroupCount1}].InZone} && ${Me.Group[${phGroupCount1}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								lowPower:Inc
						}
						if ${lowPower}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough to Power
					}
					;check if the target is notselfgroup
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						if ${Me.Raid}==0
							continue
						;echo check NotSelfGroup for Power
						variable int phNotSelfGroupCount=0
						for(phNotSelfGroupCount:Set[7];${phNotSelfGroupCount}<=${Me.Raid};phNotSelfGroupCount:Inc)
						{
							if ${Me.Raid[${phNotSelfGroupCount}](exists)} && ${Me.Raid[${phNotSelfGroupCount}].Health}>0 && ${Me.Raid[${phNotSelfGroupCount}].InZone} && ${Me.Raid[${phNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${phNotSelfGroupCount}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${phNotSelfGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${phNotSelfGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${phNotSelfGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					;check if the target is raid
					elseif ${CastTarget.Equal[@Raid]}
					{
						if ${Me.Raid}==0
							continue
						;echo check Raid for Power
						variable int phRaidCount=0
						for(phRaidCount:Set[1];${phRaidCount}<=${Me.Raid};phRaidCount:Inc)
						{
							if ${Me.Raid[${phRaidCount}](exists)} && ${Me.Raid[${phRaidCount}].Health}>0 && ${Me.Raid[${phRaidCount}].InZone} && ${Me.Raid[${phRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${phRaidCount}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[${phRaidCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${phRaidCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${phRaidCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						;echo check group Power
						variable int phGroupCount
						if ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							return TRUE
						}
						for(phGroupCount:Set[1];${phGroupCount}<${Me.Group};phGroupCount:Inc)
						{
							;echo checking ${phGroupCount}: ${Me.Group[${phGroupCount}].Name}
							if ${Me.Group[${phGroupCount}](exists)} && ${Me.Group[${phGroupCount}].Health}>0 && ${Me.Group[${phGroupCount}].InZone} && ${Me.Group[${phGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${phGroupCount}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[${phGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Group[${phGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${phGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
					else
					{
						;if our target is me
						if ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
						{
							;echo Our Power Target is ${Me}, Checking Power ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							if ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
							{
								;echo ${Me.Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]}
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								{
									if ${CastTarget.Equal[FALSE]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
									else
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
								}
								else
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
								return TRUE
							}
							elseif ${CombatBotDebug}
								echo Skipping Power Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} 
						}
						;check our target Power
						elseif ${Me.Raid}>0 && ${Me.Raid[id,${CastTarget}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Raid[id,${CastTarget}].IsDead} && ${Me.Raid[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							return TRUE
						}
						elseif ${Me.Group[id,${CastTarget}].Power}<${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[5,|]} && !${Me.Group[id,${CastTarget}].IsDead} && ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to Power
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[InCombatTargeted]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is incombattargeted
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["Barrier of the Spirits"]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[11,|].Equal[TRUE]}
					{
						if ${Me.Maintained["Ferocity of Spirits"].CurrentIncrements}<3
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["Ferocity of Spirits"].CurrentIncrements}
							continue
						}
					}
					if ${CastTarget.Equal[@Me]} || ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
						{
							if ${CastTarget.Equal[FALSE]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
							else
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						if ${Me.Raid[7].IsDead}
							continue
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[7].ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[7].Name}
							if ${Actor[id,${Me.Raid[7].ID}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[7].ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Raid]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					else
					{
						if ${Me.Raid[id,${CastTarget}].IsDead} || ${Me.Group[id,${CastTarget}].IsDead}
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Actor[id,${CastTarget}].Name} is dead
							continue
						}
						 
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
						else
						{
							if ${Actor[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							}
						}
						return TRUE
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[NamedHostile]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is NamedHostile
					if ${Target.Type.Equal[NamedNPC]} || ${Target.Target.Type.Equal[NamedNPC]} || ${Target.Name.Equal["training dummy"]} || ${Target.Target.Name.Equal["training dummy"]} || ${UIElement[SettingsAlwaysCastNamedHostileCheckBox@SettingsFrame@CombatBotUI].Checked}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
						{
							if ${Actor[id,${KillTargetID}].Distance}>50
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: 50
								continue
							}
							else
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
						}
						else
						{
							;check if max is set and then check for incs
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[11,|].Equal[TRUE]}
							{
								;Setting Max Increment Logic for Skull Foci @ 3
								if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["Skull Foci"]}
								{
									;still need to code the AE portion but for now will keep the ability up
									if ${Me.Maintained["Skull Foci"].CurrentIncrements}<3
									{
										if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
										{
											if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
												Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
										}
										elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
										{
											if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
												Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
										}
										else
										{
											if ${CombatBotDebug}
												echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
											continue
										}
									}
									else
									{
										if ${CombatBotDebug}
											echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["Skull Foci"].CurrentIncrements}
										continue
									}
								}
								;Setting Max Increment Logic for World Ablaze @ 3
								elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["World Ablaze"]}
								{
									;still need to code the AE portion but for now will keep the ability up
									if ${Me.Maintained["World Ablaze"].CurrentIncrements}<3
									{
										if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
										{
											if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
												Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
										}
										elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
										{
											if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
												Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
										}
										else
										{
											if ${CombatBotDebug}
												echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
											continue
										}
									}
									else
									{
										if ${CombatBotDebug}
											echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["World Ablaze"].CurrentIncrements}
										continue
									}
								}
								if ${Me.Maintained["${strMaxIncrementAbility}"](exists)}
								{
									if ${Me.Maintained["${strMaxIncrementAbility}"].CurrentIncrements}<${intMaxIncrements}
									{
										if ${CombatBotDebug}
											echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Max Increments of ${intMaxIncrements} for "${strMaxIncrementAbility}" has not been reached we are at ${Me.Maintained["${strMaxIncrementAbility}"].CurrentIncrements}
										continue
									}
								}
								else 
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Max Increments Ability: ""${strMaxIncrementAbility}" not found in Maintained
									continue
								}
							}
							if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
							{
								if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								else
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
									continue
								}
							}
							elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
							{
								if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								{
									;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									;break
								}
								else
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
									continue
								}
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
							}
						}
						return TRUE
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Hostile]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is a Hostile
					;echo Casting ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} as ${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} with ID ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
					{
						if ${Actor[id,${KillTargetID}].Distance}>50
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: 50
							continue
						}
						else
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
					}
					else
					{
						;check if max is set and then check for incs
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[11,|].Equal[TRUE]}
						{
							;Setting Max Increment Logic for Skull Foci @ 3
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["Skull Foci"]}
							{
								;still need to code the AE portion but for now will keep the ability up
								if ${Me.Maintained["Sk\``ull Foci"].CurrentIncrements}<3
								{
									if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
									{
										if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
											Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									}
									elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
									{
										if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
											Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									}
									else
									{
										if ${CombatBotDebug}
											echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
										continue
									}
								}
								else
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["Skull Foci"].CurrentIncrements}
									continue
								}
							}
							;Setting Max Increment Logic for World Ablaze @ 3
							elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal["World Ablaze"]}
							{
								;still need to code the AE portion but for now will keep the ability up
								if ${Me.Maintained["World Ablaze"].CurrentIncrements}<3
								{
									if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
									{
										if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
											Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									}
									elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
									{
										if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
											Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
									}
									else
									{
										if ${CombatBotDebug}
											echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
										continue
									}
								}
								else
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, we are at ${Me.Maintained["World Ablaze"].CurrentIncrements}
									continue
								}
							}
							if ${Me.Maintained["${strMaxIncrementAbility}"](exists)}
							{
								if ${Me.Maintained["${strMaxIncrementAbility}"].CurrentIncrements}<${intMaxIncrements}
								{
									if ${CombatBotDebug}
										echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Max Increments of ${intMaxIncrements} for "${strMaxIncrementAbility}" has not been reached we are at ${Me.Maintained["${strMaxIncrementAbility}"].CurrentIncrements}
									continue
								}
							}
							else 
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Max Increments Ability: ""${strMaxIncrementAbility}" not found in Maintained
								continue
							}
						}
						if ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}>0
						{
							;echo ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
							if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} && ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								continue
							}
								
						}
						elseif ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}==0
						{
							;echo ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
							if ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
							{
								;echo before cast call return: ${Return}
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								;echo After cast call return: ${Return}
							}
							else
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
								continue
							}
						}
						else
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, Range Error: Max: ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[${RangeCalc} + ${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]} Min: ${Actor[id,${KillTargetID}].Distance}>${Math.Calc[${RangeCalc} + ${istrExportMinRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}]}
							continue
						}
					}
					return TRUE
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Buff]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is a Buff
					if ${CastTarget.Equal[@Me]} || ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
						{
							if ${CastTarget.Equal[FALSE]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
							else
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							if ${CastTarget.Equal[FALSE]}
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Raid]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					elseif ${CastTarget.Equal[@Group]}
					{
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
						else
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
						}
						return TRUE
					}
					else
					{
						if ${Me.Raid[id,${CastTarget}].IsDead} || ${Me.Group[id,${CastTarget}].IsDead}
						{
							if ${CombatBotDebug}
								echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Actor[id,${CastTarget}].Name} is dead
							continue
						}
						if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
						elseif ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
						{
							;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
						}
						return TRUE
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[OutOfCombatBuff]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is a OutOfCombatBuff
					if !${Me.InCombat}
					{
						if ${CastTarget.Equal[@Me]} || ${CastTarget.Equal[${Me.ID}]} || ${CastTarget.Equal[FALSE]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
							{
								if ${CastTarget.Equal[FALSE]}
									call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]}
								else
									call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
							}
							else
							{
								;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
								
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							}
							return TRUE
						}
						elseif ${CastTarget.Equal[@Raid]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
							else
							{
								;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
								
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							}
							return TRUE
						}
						elseif ${CastTarget.Equal[@Group]}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.ID}
							else
							{
								;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Name}
								
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.ID}
							}
							return TRUE
						}
						else
						{
							if ${Me.Raid[id,${CastTarget}].IsDead} || ${Me.Group[id,${CastTarget}].IsDead}
							{
								if ${CombatBotDebug}
									echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, ${Actor[id,${CastTarget}].Name} is dead
								continue
							}
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							elseif ${Me.Group[id,${CastTarget}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								;echo Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
								
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							}
							return TRUE
						}
					}
					else
					{
						if ${CombatBotDebug}
							echo Ignoring OutOfCombatBuff Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} Because We are InCombat
						continue
					}
				}
				elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Equal[Res]} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}!=-10263709
				{
					;echo is a Res
					if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}>0
					{
						variable bool boolGotFirstDeadTarget=FALSE
						variable int intFirstDeadTarget
						variable int resGroupCount
						variable int isDead=0
						if ${Me.Raid}>0
						{
							for(resGroupCount:Set[1];${resGroupCount}<${Me.Raid};resGroupCount:Inc)
							{
								if ${Me.Raid[${resGroupCount}].IsDead} && ${Me.Raid[${resGroupCount}](exists)} && ${Me.Raid[${resGroupCount}].InZone} && ${Me.Raid[${resGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if !${boolGotFirstDeadTarget}
									{
										intFirstDeadTarget:Set[${Me.Raid[${resGroupCount}].ID}]
										boolGotFirstDeadTarget:Set[TRUE]
									}
									isDead:Inc
								}
							}
						}
						else
						{
							for(resGroupCount:Set[1];${resGroupCount}<${Me.Group};resGroupCount:Inc)
							{
								if ${Me.Group[${resGroupCount}].IsDead} && ${Me.Group[${resGroupCount}](exists)} && ${Me.Group[${resGroupCount}].InZone} && ${Me.Group[${resGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
								{
									if !${boolGotFirstDeadTarget}
									{
										intFirstDeadTarget:Set[${Me.Group[${resGroupCount}].ID}]
										boolGotFirstDeadTarget:Set[TRUE]
									}
									isDead:Inc
								}
							}
						}
						if ${isDead}>=${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[6,|]}
						{
							Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${intFirstDeadTarget}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, not enough to groupres
					}
					;check if the target is NotSelfGroup
					elseif ${CastTarget.Equal[@NotSelfGroup]}
					{
						;echo check NotSelfGroup for dead
						variable int resNotSelfGroupCount=0
						for(resNotSelfGroupCount:Set[7];${resNotSelfGroupCount}<=${Me.Raid};resNotSelfGroupCount:Inc)
						{
							if ${Me.Raid[${resNotSelfGroupCount}](exists)} && ${Me.Raid[${resNotSelfGroupCount}].InZone} && ${Me.Raid[${resNotSelfGroupCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${resNotSelfGroupCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${resNotSelfGroupCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${resNotSelfGroupCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
					}
					;check if the target is raid
					elseif ${CastTarget.Equal[@Raid]}
					{
						;echo check Raid for dead
						variable int resRaidCount=0
						for(resRaidCount:Set[1];${resRaidCount}<=${Me.Raid};resRaidCount:Inc)
						{
							if ${Me.Raid[${resRaidCount}](exists)} && ${Me.Raid[${resRaidCount}].InZone} && ${Me.Raid[${resRaidCount}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Raid[${resRaidCount}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Raid[${resRaidCount}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Raid[${resRaidCount}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
					}
					;check if the target is group
					elseif ${CastTarget.Equal[@Group]}
					{
						;echo check group for dead
						variable int resGroupCount2
						for(resGroupCount2:Set[1];${resGroupCount2}<${Me.Group};resGroupCount2:Inc)
						{
							;echo checking ${resGroupCount2}: ${Me.Group[${resGroupCount2}].Name}
							if ${Me.Group[${resGroupCount2}](exists)} && ${Me.Group[${resGroupCount2}].InZone} && ${Me.Group[${resGroupCount2}].Distance}<${istrExportMaxRange.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}
							{
								if ${Me.Group[${resGroupCount2}].IsDead}
								{
									if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
										call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${Me.Group[${resGroupCount2}].ID}
									else
										Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${Me.Group[${resGroupCount2}].ID}
									return TRUE
								}
							}
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
					}
					else
					{
						;check if our target is dead
						if ${Me.Group[id,${CastTarget}].IsDead}
						{
							if ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]}
								call CastItem "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}" ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[10,|]} ${CastTarget}
							else
								Cast "${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}" "${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}" ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${CastTarget}
							return TRUE
						}
						if ${CombatBotDebug}
							echo Ignoring Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}, no one to res
						continue
					}
				}
			}
			elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709 && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].NotEqual[Item:]} && ${CombatBotDebug}
				echo Ignoring Disabled Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} 
			elseif ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709 && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]} && ${CombatBotDebug}
				echo Ignoring Disabled Item: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} 
			elseif ( !${Me.Ability[id,${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]}].IsReady} && ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].NotEqual[Item:]} ) && ${CombatBotDebug}
				echo Ignoring NonReady Ability: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} ${istrExport.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${istrExportID.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}]} ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]}
			elseif ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]} && ${ItemEquiped} && ${Me.Equipment["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}>0 ) || ( ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Left[5].Equal[Item:]} && !${ItemEquiped} && ${Me.Inventory["${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Right[-5]}"].TimeUntilReady}>0 )
			{
				if ${CombatBotDebug}
					echo Ignoring NonReady Item: ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]}
			}
		}
		;echo reached end ${mainCount} // ${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].Items}
		return FALSE
	}
}

atom CombatBotLoadCastStackExportAbilitiesListBoxOnce()
{	
	;colors CA=Red FF960000, NamedHostile=FF0000 Combat=Purple FF992588, Mana=Blue FF212494, Heal=Green FF1EE62E, Cure=Brown FFA600, Rez=Orange FF7700 Buff=Yellow FFCBE61E
	variable int count2=0
	variable int counter=0
	variable string temp=""
	variable bool boolInIndex=FALSE
	for(count2:Set[1];${count2}<=${istrExport.Used};count2:Inc)
	{
		if ${istrExport.Get[${count2}].Equal[1]}
			continue
		
		if ${istrExport.Get[${count2}].Right[5].Equal[" VIII"]} || ${istrExport.Get[${count2}].Right[5].Equal[" XIII"]}
		{
			;echo ${istrExport.Get[${count2}]} AS ${istrExport.Get[${count2}].Left[-5]}
			;check to make sure this isnt already in our index
			boolInIndex:Set[FALSE]
			for(counter:Set[1];${counter}<=${istrExportList.Used};counter:Inc)
			{
				if ${istrExportList.Get[${counter}].Equal[${istrExport.Get[${count2}].Left[-5]}]}
					boolInIndex:Set[TRUE]
			}
			if !${boolInIndex}
			{
				istrExportList:Insert[${istrExport.Get[${count2}].Left[-5]}]
				;echo adding ${istrExport.Get[${count2}].Left[-5]} to index
			}
			continue
		}
		if ${istrExport.Get[${count2}].Right[4].Equal[" III"]} || ${istrExport.Get[${count2}].Right[4].Equal[" VII"]} || ${istrExport.Get[${count2}].Right[4].Equal[" XII"]}
		{
			;echo ${istrExport.Get[${count2}]} AS ${istrExport.Get[${count2}].Left[-4]}
			;check to make sure this isnt already in our index
			boolInIndex:Set[FALSE]
			for(counter:Set[1];${counter}<=${istrExportList.Used};counter:Inc)
			{
				if ${istrExportList.Get[${counter}].Equal[${istrExport.Get[${count2}].Left[-4]}]}
					boolInIndex:Set[TRUE]
			}
			if !${boolInIndex}
			{
				istrExportList:Insert[${istrExport.Get[${count2}].Left[-4]}]
				;echo adding ${istrExport.Get[${count2}].Left[-4]} to index
			}
			continue
		}		
		if ${istrExport.Get[${count2}].Right[3].Equal[" II"]} || ${istrExport.Get[${count2}].Right[3].Equal[" IV"]} || ${istrExport.Get[${count2}].Right[3].Equal[" VI"]} || ${istrExport.Get[${count2}].Right[3].Equal[" XI"]} || ${istrExport.Get[${count2}].Right[3].Equal[" IX"]}
		{
			;echo ${istrExport.Get[${count2}]} AS ${istrExport.Get[${count2}].Left[-3]}
			;check to make sure this isnt already in our index
			boolInIndex:Set[FALSE]
			for(counter:Set[1];${counter}<=${istrExportList.Used};counter:Inc)
			{
				if ${istrExportList.Get[${counter}].Equal[${istrExport.Get[${count2}].Left[-3]}]}
					boolInIndex:Set[TRUE]
			}
			if !${boolInIndex}
			{
				istrExportList:Insert[${istrExport.Get[${count2}].Left[-3]}]
				;echo adding ${istrExport.Get[${count2}].Left[-3]} to index
			}
			continue
		}
		if ${istrExport.Get[${count2}].Right[2].Equal[" V"]} || ${istrExport.Get[${count2}].Right[2].Equal[" X"]}
		{
			;echo ${istrExport.Get[${count2}]} AS ${istrExport.Get[${count2}].Left[-2]}
			;check to make sure this isnt already in our index
			boolInIndex:Set[FALSE]
			for(counter:Set[1];${counter}<=${istrExportList.Used};counter:Inc)
			{
				if ${istrExportList.Get[${counter}].Equal[${istrExport.Get[${count2}].Left[-2]}]}
					boolInIndex:Set[TRUE]
			}
			if !${boolInIndex}
			{
				istrExportList:Insert[${istrExport.Get[${count2}].Left[-2]}]
				;echo adding ${istrExport.Get[${count2}].Left[-2]} to index
			}
			continue
		}
		else
		{
			;echo ${istrExport.Get[${count2}]} AS ${istrExport.Get[${count2}]}
			;check to make sure this isnt already in our index
			boolInIndex:Set[FALSE]
			for(counter:Set[1];${counter}<=${istrExportList.Used};counter:Inc)
			{
				if ${istrExportList.Get[${counter}].Equal[${istrExport.Get[${count2}]}]}
					boolInIndex:Set[TRUE]
			}
			if !${boolInIndex}
			{
				istrExportList:Insert[${istrExport.Get[${count2}]}]
				;echo adding ${istrExport.Get[${count2}]} to index
			}
			continue
		}

		;;;;;throw all these into an index, then convert that index to get the abilityexport position of the highest value of these and use that as the value

	}
	variable int intTempAbilityLength
	variable int intTempAbilityExportLength
	variable int intTempExportAbilityLevel
	variable int intMaxExportAbilityLevel=0
	variable int intExportAbilityPosition=0
	variable string strExportAbilityMaxLevelMatchedToAbility
	variable bool boolMatchFound=FALSE
	variable int aCACount
	for(aCACount:Set[1];${aCACount}<=${istrExportList.Used};aCACount:Inc)
	{
		;first set length of istrExportList
		intTempAbilityLength:Set[${istrExportList.Get[${aCACount}].Length}]
		;echo ${istrExportList.Get[${aCACount}]} - ${intTempAbilityLength}
		;search through istrExport for istrExportList and grab one with largest level
		intMaxExportAbilityLevel:Set[0]
		for(count2:Set[1];${count2}<=${istrExport.Used};count2:Inc)
		{
			intTempAbilityExportLength:Set[${istrExport.Get[${count2}].Length}]
			if ${istrExport.Get[${count2}].Left[${intTempAbilityLength}].Equal[${istrExportList.Get[${aCACount}]}]} && ${intTempAbilityExportLength}<${Math.Calc[${intTempAbilityLength}+6]}
			{

				if ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+2]}
				{
					if ${istrExport.Get[${count2}].Right[1].NotEqual[V]} && ${istrExport.Get[${count2}].Right[1].NotEqual[X]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[1]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+3]}
				{
					if ${istrExport.Get[${count2}].Right[2].NotEqual[II]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IV]} && ${istrExport.Get[${count2}].Right[2].NotEqual[VI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[XI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IX]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[2]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+4]}
				{
					if ${istrExport.Get[${count2}].Right[3].NotEqual[III]} && ${istrExport.Get[${count2}].Right[3].NotEqual[VII]} && ${istrExport.Get[${count2}].Right[3].NotEqual[XII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[3]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+5]}
				{
					if ${istrExport.Get[${count2}].Right[4].NotEqual[VIII]} && ${istrExport.Get[${count2}].Right[4].NotEqual[XIII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[4]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				;elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+5]}
				;	echo ${istrExport.Get[${count2}].Right[5]}
				;echo  ${intTempAbilityExportLength}<${Math.Calc[${intTempAbilityLength}+6]}
				; if ${boolAmBrigand} && ${istrExportList.Get[${aCACount}].Equal[Shadow]}
				; {
					; if ${istrExport.Get[${count2}].Equal[Shadow]}
					; {
						; boolMatchFound:Set[TRUE]
						; if ${istrExportLevel.Get[${count2}]}<1
							; istrExportLevel:Set[${count2}],0]
						; echo Found Match - ${istrExportList.Get[${aCACount}]} - ${istrExport.Get[${count2}].Left[${intTempAbilityLength}]} - Level - ${istrExportLevel.Get[${count2}]}
							; intTempExportAbilityLevel:Set[${istrExportLevel.Get[${count2}]}]
						; if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
						; {
							; intMaxExportAbilityLevel:Set[${intTempExportAbilityLevel}]
							; strExportAbilityMaxLevelMatchedToAbility:Set[${istrExport.Get[${count2}]}]
							; intExportAbilityPosition:Set[${count2}]
						; }
					; }
				; }
				; if ${boolAmPriest} && ${istrExportList.Get[${aCACount}].Equal[Cure]}
				; {
					; if ${istrExport.Get[${count2}].Equal[Cure]}
					; {
						; boolMatchFound:Set[TRUE]
						; if ${istrExportLevel.Get[${count2}]}<1
							; istrExportLevel:Set[${count2}],0]
						; echo Found Match - ${istrExportList.Get[${aCACount}]} - ${istrExport.Get[${count2}].Left[${intTempAbilityLength}]} - Level - ${istrExportLevel.Get[${count2}]}
							; intTempExportAbilityLevel:Set[${istrExportLevel.Get[${count2}]}]
						; if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
						; {
							; intMaxExportAbilityLevel:Set[${intTempExportAbilityLevel}]
							; strExportAbilityMaxLevelMatchedToAbility:Set[${istrExport.Get[${count2}]}]
							; intExportAbilityPosition:Set[${count2}]
						; }
					; }
				; }
				;else
				;{
					boolMatchFound:Set[TRUE]
					;if ${istrExportLevel.Get[${count2}]}<1
					;	istrExportLevel:Set[${count2}],0]
					;echo Found Match - ${istrExportList.Get[${aCACount}]} - ${istrExport.Get[${count2}].Left[${intTempAbilityLength}]} - Level - ${istrExportLevel.Get[${count2}]}
						intTempExportAbilityLevel:Set[${istrExportLevel.Get[${count2}]}]
					if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
					{
						intMaxExportAbilityLevel:Set[${intTempExportAbilityLevel}]
						strExportAbilityMaxLevelMatchedToAbility:Set[${istrExport.Get[${count2}]}]
						intExportAbilityPosition:Set[${count2}]
					}
				;}
			}
			;waitframe
		}
		if ${boolMatchFound}
		{
			istrExportListPosition:Insert[${intExportAbilityPosition}]
			;echo CombatBot: Found Highest Level of ${istrExportList.Get[${aCACount}]} as ${strExportAbilityMaxLevelMatchedToAbility} at level ${intMaxExportAbilityLevel} with position of ${intExportAbilityPosition} which in index says ${istrExportListPosition.Get[${aCACount}]}

			boolMatchFound:Set[FALSE]
			
		}

		else
		{
			istrExportListPosition:Insert[0]
			;echo ${istrExportList.Get[${aCACount}]} is an Item, ${istrExportListPosition.Get[${aCACount}]} <-- should be 0
		}
	}
	
		;echo ${ConvertAbilityObj.Convert[${istrExport.Get[${count}]}]}
		;UIElement[CastStackExportAbilitiesListBox@CombatBotUI]:AddItem[${istrExport.Get[${count2}]},${count2}]
}

objectdef ConvertAbilityObject
{
	member:int Convert(string caAbilityName)
	{
		;echo CombatBot: Scanning for ${caAbilityName}
		
		variable int intTempAbilityLength
		variable int intTempAbilityExportLength
		variable int intTempExportAbilityLevel=0
		variable int intMaxExportAbilityLevel=0
		variable int intExportAbilityPosition=0
		variable string strExportAbilityMaxLevelMatchedToAbility
		variable bool boolMatchFound=FALSE
		variable int count2
		
		;first set length of caAbilityName
		intTempAbilityLength:Set[${caAbilityName.Length}]
		;echo ${istrAbilities.Get[${aCACount}]} - ${intTempAbilityLength}
		;search through istrExport for istrAbilities and grab one with largest level
		intMaxExportAbilityLevel:Set[0]
		for(count2:Set[1];${count2}<=${istrExport.Used};count2:Inc)
		{
			intTempAbilityExportLength:Set[${istrExport.Get[${count2}].Length}]
			if ${istrExport.Get[${count2}].Left[${intTempAbilityLength}].Equal[${caAbilityName}]} && ${intTempAbilityExportLength}<${Math.Calc[${intTempAbilityLength}+6]}
			{
				if ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+2]}
				{
					if ${istrExport.Get[${count2}].Right[1].NotEqual[V]} && ${istrExport.Get[${count2}].Right[1].NotEqual[X]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[1]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+3]}
				{
					if ${istrExport.Get[${count2}].Right[2].NotEqual[II]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IV]} && ${istrExport.Get[${count2}].Right[2].NotEqual[VI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[XI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IX]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[2]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+4]}
				{
					if ${istrExport.Get[${count2}].Right[3].NotEqual[III]} && ${istrExport.Get[${count2}].Right[3].NotEqual[VII]} && ${istrExport.Get[${count2}].Right[3].NotEqual[XII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[3]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+5]}
				{
					if ${istrExport.Get[${count2}].Right[4].NotEqual[VIII]} && ${istrExport.Get[${count2}].Right[4].NotEqual[XIII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[4]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				boolMatchFound:Set[TRUE]
				;if ${istrExportLevel.Get[${count2}]}<1
				;	istrExportLevel:Set[${count2}],0]
				;echo Found Match - ${caAbilityName} - ${istrExport.Get[${count2}]} - Level - ${istrExportLevel.Get[${count2}]}
				intTempExportAbilityLevel:Set[${istrExportLevel.Get[${count2}]}]
				;echo if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
				if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
				{
					intMaxExportAbilityLevel:Set[${intTempExportAbilityLevel}]
					strExportAbilityMaxLevelMatchedToAbility:Set[${istrExport.Get[${count2}]}]
					intExportAbilityPosition:Set[${count2}]
				}
			}
			;waitframe
		}
		if ${boolMatchFound}
		{
			;istrAbilityExportPosition:Insert[${intExportAbilityPosition}]
			;strDoCastID:Set[${istrExportID.Get[${intExportAbilityPosition}]}]
			;strDoCastName:Set[${istrExport.Get[${intExportAbilityPosition}]}]
			;echo CombatBot: Found Highest Level of ${caAbilityName} as ${strExportAbilityMaxLevelMatchedToAbility} at level ${intMaxExportAbilityLevel} with position of ${intExportAbilityPosition} which in index says ${istrExport.Get[${intExportAbilityPosition}]}
			;boolTBCMatchFound:Set[TRUE]
			;boolMatchFound:Set[FALSE]
			return ${intExportAbilityPosition}
		}
		else
		{
			return 0
		}
		;echo CombatBot: Done Scanning Ability
	}
	member:string ConvertID(string caAbilityName)
	{
		;echo CombatBot: Scanning for ${caAbilityName}
		
		variable int intTempAbilityLength
		variable int intTempAbilityExportLength
		variable int intTempExportAbilityLevel=0
		variable int intMaxExportAbilityLevel=0
		variable int intExportAbilityPosition=0
		variable string strExportAbilityMaxLevelMatchedToAbility
		variable bool boolMatchFound=FALSE
		variable int count2
		
		;first set length of caAbilityName
		intTempAbilityLength:Set[${caAbilityName.Length}]
		;echo ${istrAbilities.Get[${aCACount}]} - ${intTempAbilityLength}
		;search through istrExport for istrAbilities and grab one with largest level
		intMaxExportAbilityLevel:Set[0]
		for(count2:Set[1];${count2}<=${istrExport.Used};count2:Inc)
		{
			intTempAbilityExportLength:Set[${istrExport.Get[${count2}].Length}]
			if ${istrExport.Get[${count2}].Left[${intTempAbilityLength}].Equal[${caAbilityName}]} && ${intTempAbilityExportLength}<${Math.Calc[${intTempAbilityLength}+6]}
			{
				if ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+2]}
				{
					if ${istrExport.Get[${count2}].Right[1].NotEqual[V]} && ${istrExport.Get[${count2}].Right[1].NotEqual[X]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[1]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+3]}
				{
					if ${istrExport.Get[${count2}].Right[2].NotEqual[II]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IV]} && ${istrExport.Get[${count2}].Right[2].NotEqual[VI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[XI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IX]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[2]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+4]}
				{
					if ${istrExport.Get[${count2}].Right[3].NotEqual[III]} && ${istrExport.Get[${count2}].Right[3].NotEqual[VII]} && ${istrExport.Get[${count2}].Right[3].NotEqual[XII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[3]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+5]}
				{
					if ${istrExport.Get[${count2}].Right[4].NotEqual[VIII]} && ${istrExport.Get[${count2}].Right[4].NotEqual[XIII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[4]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				boolMatchFound:Set[TRUE]
				;if ${istrExportLevel.Get[${count2}]}<1
				;	istrExportLevel:Set[${count2}],0]
				;echo Found Match - ${caAbilityName} - ${istrExport.Get[${count2}]} - Level - ${istrExportLevel.Get[${count2}]}
				intTempExportAbilityLevel:Set[${istrExportLevel.Get[${count2}]}]
				;echo if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
				if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
				{
					intMaxExportAbilityLevel:Set[${intTempExportAbilityLevel}]
					strExportAbilityMaxLevelMatchedToAbility:Set[${istrExport.Get[${count2}]}]
					intExportAbilityPosition:Set[${count2}]
				}
			}
			;waitframe
		}
		if ${boolMatchFound}
		{
			;istrAbilityExportPosition:Insert[${intExportAbilityPosition}]
			;strDoCastID:Set[${istrExportID.Get[${intExportAbilityPosition}]}]
			;strDoCastName:Set[${istrExport.Get[${intExportAbilityPosition}]}]
			;echo CombatBot: Found Highest Level of ${caAbilityName} as ${strExportAbilityMaxLevelMatchedToAbility} at level ${intMaxExportAbilityLevel} with position of ${intExportAbilityPosition} which in index says ${istrExport.Get[${intExportAbilityPosition}]}
			;boolTBCMatchFound:Set[TRUE]
			;boolMatchFound:Set[FALSE]
			;echo \${istrExportID.Get[${intExportAbilityPosition}]} // ${istrExport.Get[${intExportAbilityPosition}]} // ${istrExportID.Get[${intExportAbilityPosition}]}
			return ${istrExportID.Get[${intExportAbilityPosition}]}
		}
		else
		{
			return 0
		}
		;echo CombatBot: Done Scanning Ability
	}
	member:string ConvertName(string caAbilityName)
	{
		;echo CombatBot: Scanning for ${caAbilityName}
		
		variable int intTempAbilityLength
		variable int intTempAbilityExportLength
		variable int intTempExportAbilityLevel=0
		variable int intMaxExportAbilityLevel=0
		variable int intExportAbilityPosition=0
		variable string strExportAbilityMaxLevelMatchedToAbility
		variable bool boolMatchFound=FALSE
		variable int count2
		
		;first set length of caAbilityName
		intTempAbilityLength:Set[${caAbilityName.Length}]
		;echo ${istrAbilities.Get[${aCACount}]} - ${intTempAbilityLength}
		;search through istrExport for istrAbilities and grab one with largest level
		intMaxExportAbilityLevel:Set[0]
		for(count2:Set[1];${count2}<=${istrExport.Used};count2:Inc)
		{
			intTempAbilityExportLength:Set[${istrExport.Get[${count2}].Length}]
			if ${istrExport.Get[${count2}].Left[${intTempAbilityLength}].Equal[${caAbilityName}]} && ${intTempAbilityExportLength}<${Math.Calc[${intTempAbilityLength}+6]}
			{
				if ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+2]}
				{
					if ${istrExport.Get[${count2}].Right[1].NotEqual[V]} && ${istrExport.Get[${count2}].Right[1].NotEqual[X]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[1]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+3]}
				{
					if ${istrExport.Get[${count2}].Right[2].NotEqual[II]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IV]} && ${istrExport.Get[${count2}].Right[2].NotEqual[VI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[XI]} && ${istrExport.Get[${count2}].Right[2].NotEqual[IX]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[2]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+4]}
				{
					if ${istrExport.Get[${count2}].Right[3].NotEqual[III]} && ${istrExport.Get[${count2}].Right[3].NotEqual[VII]} && ${istrExport.Get[${count2}].Right[3].NotEqual[XII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[3]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				elseif ${intTempAbilityExportLength}==${Math.Calc[${intTempAbilityLength}+5]}
				{
					if ${istrExport.Get[${count2}].Right[4].NotEqual[VIII]} && ${istrExport.Get[${count2}].Right[4].NotEqual[XIII]}
					{
						if ${CombatBotDebug}
							echo ${istrExport.Get[${count2}].Right[4]} is Not Correct Spell Ending, Continuing
						continue
					}
				}
				boolMatchFound:Set[TRUE]
				;if ${istrExportLevel.Get[${count2}]}<1
				;	istrExportLevel:Set[${count2}],0]
				;echo Found Match - ${caAbilityName} - ${istrExport.Get[${count2}]} - Level - ${istrExportLevel.Get[${count2}]}
				intTempExportAbilityLevel:Set[${istrExportLevel.Get[${count2}]}]
				;echo if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
				if ${intTempExportAbilityLevel}>=${intMaxExportAbilityLevel} && ${intTempExportAbilityLevel}<=${intMyLevel}
				{
					intMaxExportAbilityLevel:Set[${intTempExportAbilityLevel}]
					strExportAbilityMaxLevelMatchedToAbility:Set[${istrExport.Get[${count2}]}]
					intExportAbilityPosition:Set[${count2}]
				}
			}
			;waitframe
		}
		if ${boolMatchFound}
		{
			;istrAbilityExportPosition:Insert[${intExportAbilityPosition}]
			;strDoCastID:Set[${istrExportID.Get[${intExportAbilityPosition}]}]
			;strDoCastName:Set[${istrExport.Get[${intExportAbilityPosition}]}]
			;echo CombatBot: Found Highest Level of ${caAbilityName} as ${strExportAbilityMaxLevelMatchedToAbility} at level ${intMaxExportAbilityLevel} with position of ${intExportAbilityPosition} which in index says ${istrExport.Get[${intExportAbilityPosition}]}
			;boolTBCMatchFound:Set[TRUE]
			;boolMatchFound:Set[FALSE]
			return ${strExportAbilityMaxLevelMatchedToAbility}
		}
		else
		{
			return 0
		}
		;echo CombatBot: Done Scanning Ability
	}
}

atom Cast(string CastNameShort, string CastName, string CastID, string CastTarget=FALSE)
{
	
	;echo check ${CastNameShort} for both pre and post casts
	variable string PreCheck=${PrePostChecker.PreCast[${CastNameShort}]}
	variable string PostCheck=${PrePostChecker.PostCast[${CastNameShort}]}
	if ${PreCheck.Equal[FALSE]}
	{
		;echo No Pre Cast on ${CastNameShort} / ${PreCheck}
		boolPreCast:Set[FALSE]
	}
	else
	{
		if ${Me.Ability[id,${strPreCastID}].IsReady}
			boolPreCast:Set[TRUE]
		else
			boolPreCast:Set[FALSE]
		;echo ${CastNameShort} has a PreCast of ${PreCheck} == ${strPreCastName} ID: ${strPreCastID} : TF: ${boolPreCast} IsReady: ${Me.Ability[id,${strPreCastID}].IsReady}
	}
	if ${PostCheck.Equal[FALSE]}
	{
		;echo No Post Cast on ${CastNameShort} / ${PostCheck}
		boolPostCast:Set[FALSE]
	}
	else
	{
		if ${Me.Ability[id,${strPostCastID}].IsReady}
			boolPostCast:Set[TRUE]
		else
			boolPostCast:Set[FALSE]
		;echo ${CastNameShort} has a PostCast of ${PostCheck} == ${strPostCastName} ID: ${strPostCastID} : TF: ${boolPostCast} IsReady: ${Me.Ability[id,${strPostCastID}].IsReady}
	}
	;echo cast called for ${CastName} ID: ${CastID} Target: ${CastTarget}
	strCastID:Set[${CastID}]
	strCastName:Set["${CastName}"]
	strCastNameShort:Set["${CastNameShort}"]
	strCastTarget:Set[${CastTarget}]
	boolItemCast:Set[FALSE]
	boolAbilityCast:Set[TRUE]
	;echo in atom cast echo ${strCastID} ${strCastName} ${strCastNameShort}
	;return 1
}

objectdef AnnounceObject
{
	method Announce(string AbilityName, string CastTarget)
	{
		;echo Announce for ${AbilityName}
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].Items};count:Inc)
		{
			;${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} == AbilityName
			;${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|]} == Target
			;${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]} == Announcement
			;echo ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|]} ${AbilityName}
			variable string Announce=""
			variable string AnnounceP1=""
			variable string AnnounceP2=""
			variable string AnnounceTarget=${Actor[id,${CastTarget}].Name}
			variable string AnnounceNew=""
			if ${AnnounceTarget.Equal[NULL]} || ${AnnounceTarget.Equal[""]}
				return
			if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[1,|].Equal[${AbilityName}]}
			{
				if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
					continue
				if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Find[*Target*](exists)}
				{
					AnnounceNew:Set[" "]
					if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Equal[Tell]}
					{
						if ${Me.Group[${Actor[id,${CastTarget}].Name}].InZone} || ${Me.Raid[${Actor[id,${CastTarget}].Name}].InZone}
						{
							Announce:Set["${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}"]
							if ${Announce.Left[${Math.Calc[${Announce.Find[*Target*]}-1]}].Length}>0
							{
								AnnounceP1:Set[${Announce.Left[${Math.Calc[${Announce.Find[*Target*]}-1]}]}]
								AnnounceNew:Concat["${AnnounceP1} "]
							}
							if ${Announce.Right[${Math.Calc[${Announce.Length}-${Announce.Find[*Target*]}-7]}].Length}>0
							{
								AnnounceP2:Set[${Announce.Right[${Math.Calc[${Announce.Length}-${Announce.Find[*Target*]}-7]}]}]
								AnnounceNew:Concat[" ${AnnounceP2}"]
							}
							eq2execute tell ${Actor[id,${CastTarget}].Name} ${AnnounceNew}
						}
						else
							continue
					}
					Announce:Set["${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}"]
					if ${Announce.Left[${Math.Calc[${Announce.Find[*Target*]}-1]}].Length}>0
					{
						AnnounceP1:Set[${Announce.Left[${Math.Calc[${Announce.Find[*Target*]}-1]}]}]
						AnnounceNew:Concat["${AnnounceP1} "]
					}
					AnnounceNew:Concat["${Actor[id,${CastTarget}].Name}"]
					if ${Announce.Right[${Math.Calc[${Announce.Length}-${Announce.Find[*Target*]}-7]}].Length}>0
					{
						AnnounceP2:Set[${Announce.Right[${Math.Calc[${Announce.Length}-${Announce.Find[*Target*]}-7]}]}]
						AnnounceNew:Concat[" ${AnnounceP2}"]
					}

					if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Equal[Raid]}
					{
						;echo Raid
						if ${Me.Raid}>0
							eq2execute r ${AnnounceNew}
						else
							continue
					}
					if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Equal[Group]}
					{
						;echo Group
						if ${Me.Group}>1
							eq2execute g ${AnnounceNew}
						else
							continue
					}
				}
				else
				{
					if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Equal[Raid]}
					{
						if ${Me.Raid}>0
							eq2execute r ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}
						else
							continue
					}
					if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Equal[Group]}
					{
						if ${Me.Group}>1
							eq2execute g ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}
						else
							continue
					}
					if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[2,|].Equal[ExecuteCommand]}
					{
							if ${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Left[5].Upper.Equal[RELAY]}
							{
								variable int leftnum
								leftnum:Set[${Math.Calc[6+${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Right[-6].Find[" "]}]}]
								noop ${Execute[${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Left[${leftnum}]} "${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|].Right[${Math.Calc[-1*${leftnum}]}]}"]}
							}
							else
								noop ${Execute["${UIElement[AnnounceAddedAnnounceListBox@AnnounceFrame@CombatBotUI].OrderedItem[${count}].Value.Token[3,|]}"]}
					}
				}
			}
		}
	}
}
objectdef PrePostCheckerObject
{
	member:string PreCast(string AbilityName)
	{
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].Items};count:Inc)
		{
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				continue
			;echo Checking if ${RI_Obj_CB.PrePostCastAbility2[${count}]} is ${AbilityName}
			if ${RI_Obj_CB.PrePostCastAbility2[${count}].Equal[${AbilityName}]} && ${RI_Obj_CB.PrePostCastBefore[${count}]} && ${Me.Ability[id,${istrExportID.Get[${RI_Obj_CB.PrePostCastAbility1ExportPosition[${count}]}]}].IsReady}
			{
				strPreCastID:Set[${istrExportID.Get[${RI_Obj_CB.PrePostCastAbility1ExportPosition[${count}]}]}]
				strPreCastName:Set["${istrExport.Get[${RI_Obj_CB.PrePostCastAbility1ExportPosition[${count}]}]}"]
				strPreCastNameShort:Set["${RI_Obj_CB.PrePostCastAbility1[${count}]}"]
				return "${RI_Obj_CB.PrePostCastAbility1[${count}]}"
			}
		}
		return FALSE
	}
	member:string PostCast(string AbilityName)
	{
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].Items};count:Inc)
		{
			if ${UIElement[PrePostCastAddedListBox@PrePostCastFrame@CombatBotUI].OrderedItem[${count}].TextColor}==-10263709
				continue
			;echo Checking if ${RI_Obj_CB.PrePostCastAbility2[${count}]} is ${AbilityName}
			if ${RI_Obj_CB.PrePostCastAbility2[${count}].Equal[${AbilityName}]} && !${RI_Obj_CB.PrePostCastBefore[${count}]} && ${Me.Ability[id,${istrExportID.Get[${RI_Obj_CB.PrePostCastAbility1ExportPosition[${count}]}]}].IsReady}
			{
				strPostCastID:Set[${istrExportID.Get[${RI_Obj_CB.PrePostCastAbility1ExportPosition[${count}]}]}]
				strPostCastName:Set["${istrExport.Get[${RI_Obj_CB.PrePostCastAbility1ExportPosition[${count}]}]}"]
				strPostCastNameShort:Set["${RI_Obj_CB.PrePostCastAbility1[${count}]}"]
				return "${RI_Obj_CB.PrePostCastAbility1[${count}]}"
			}
		}
		return FALSE
	}
}

function CastAb(string CastNameShort, string CastName, string CastID, string CastTarget=FALSE)
{
	;return
	;echo string CastNameShort=${CastNameShort}, string CastName=${CastName}, string CastID=${CastID}, string CastTarget=FALSE=${CastTarget} ${Actor[id,${CastTarget}]}
	;echo castab ${mainCount}
	if !${DoCasting} && ${CastNameShort.NotEqual["Exploit Weakness"]}
	{
		if ${Me.AutoAttackOn} && ${Me.InCombat} && ${UIElement[SettingsTimeAutoCheckBox@SettingsFrame@CombatBotUI].Checked}
;		&& ${IMDISABLINGTHIS}
		{
			;echo timing auto
			if !${Me.RangedAutoAttackOn} || ${Me.Archetype.Equal[fighter]} || ${Me.Archetype.Equal[scout]}
			{
				;echo ${CalcAutoAttackTimerObj.Calc}
				if ${CalcAutoAttackTimerObj.Calc}<=0
				;.25
				{
					if ${CombatBotDebug}
						echo ${CalcAutoAttackTimerObj.Calc}<=0 need to wait ${AutoAttackReady}
					;echo AAR1: ${AutoAttackReady}
					wait 100 ${CalcAutoAttackTimerObj.Calc}>=0 || ${AutoAttackReady}
					;echo AAR2: ${AutoAttackReady}
					wait 5 ${CalcAutoAttackTimerObj.Calc}<=0 || ${AutoAttackReady}
					;echo AAR3: ${AutoAttackReady}
					wait 5 !${AutoAttackReady}
					;echo AAR4: ${AutoAttackReady}
				}
				;echo ${CalcAutoAttackTimerObj.Calc}
			}
		}
		variable int GiveUpCnt=0

		;check if the ability requires stealth and if we are invis
		if ${istrExportReqStealth.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}].Equal[TRUE]} && !${Me.Ability[id,${CastID}].IsReady}
		{
			;echo reqstealth
			if !${Me.IsInvis}
			{
				;IPS checks are not needed because the abilities are ready and that will make it script this alltogether
				;echo In Plain Sight: ${Me.Maintained["In Plain Sight"](exists)} / ${Script.RunningTime}<${Math.Calc[${InPlainStealthUPTime}+7000]}
				; if ${RI_Var_String_MySubClass.Equal[assassin]} && ( ${Me.Maintained["In Plain Sight"](exists)} || ${Script.RunningTime}<${Math.Calc[${InPlainStealthUPTime}+7000]} )
				; {
					;; echo Ignoring Stealth Checks because In Plain Sight is UP
					; noop
				; }
				; else
				; {
					;echo check if we have invis casting abilities
					if ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Items}>0 && ${UIElement[SettingsCastInvisCheckBox@SettingsFrame@CombatBotUI].Checked}
					{
						;echo checking InvisAbilities
						variable int sicount=0
						for(sicount:Set[1];${sicount}<=${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].Items};sicount:Inc)
						{
							;echo checking ${sicount} : ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Text} as ${istrExport.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]} with ID: ${istrExportID.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]}
							if ${Me.Ability[id,${istrExportID.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]}].IsReady} && ( ${Actor[id,${KillTargetID}].Distance}<${Math.Calc[(${Actor[${Target.ID}].CollisionRadius} * ${Actor[${Target.ID}].CollisionScale}) + (${Actor[${Me.ID}].CollisionRadius} * ${Actor[${Me.ID}].CollisionScale})+${istrExportMaxRange.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]}]} )
							{
							
								if ${istrExportReqFlanking.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}].Equal[TRUE]}
								{
									;echo ability requires flanking
									;check if we are behind or flanking
									;echo ${KillTargetID} : ${Actor[${KillTargetID}].Name}
									if ${Angle}<120
									{
										;echo We are behind/flanking
										noop
									}
									else
									{
										if ${CombatBotDebug}
											echo Ignoring Ability: ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Text}, requires behind/flanking
										mainCount:Set[${Math.Calc[${mainCount}+1]}]
										boolAbilityCast:Set[FALSE]
										boolItemCast:Set[FALSE]
										strCastName:Set[""]
										strCastNameShort:Set[""]
										strCastID:Set[0]
										strCastTarget:Set[""]
										continue
									}
								}
							
								;echo ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Text} is ready
								while ${Me.Ability[id,${istrExportID.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]}].IsReady} && ${GiveUpCnt:Inc}<=10 && !${DoCasting} && !${Me.IsInvis}
								{
									if ${CombatBotCastingDebug}
										echo Casting Ability ${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Text} as ${istrExport.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]} ID: ${istrExportID.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]} so we can Cast ${CastName}
									if ${Me.IsInvis}
										break
									Me.Ability[id,${istrExportID.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]}]:Use
									eq2execute clearabilityqueue
									wait 5 ${Me.CastingSpell} || ${Me.IsInvis}
									;${boolInstantCast} || 
									if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${istrExport.Get[${UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI].OrderedItem[${sicount}].Value}]}"]}
										break
									if ${Me.IsInvis}
										break
								}
								GiveUpCnt:Set[0]
								wait 50 ${Me.Ability[id,${CastID}].IsReady} || ${Me.Ability[id,${CastID}].TimeUntilReady}>0
								;echo ${Me.Ability[id,${CastID}].IsReady} || ${Me.Ability[id,${CastID}].TimeUntilReady}>0
								break
							}
						}
						if !${Me.IsInvis}
						{
							if ${CombatBotDebug}
								echo Ignoring Stealth Ability: ${istrAbilities.Get[${mainCount}]}, Me.IsInvis: ${Me.IsInvis}, No Stealth Abilities Available
							mainCount:Set[${Math.Calc[${mainCount}+1]}]
							boolAbilityCast:Set[FALSE]
							boolItemCast:Set[FALSE]
							strCastName:Set[""]
							strCastNameShort:Set[""]
							strCastID:Set[0]
							strCastTarget:Set[""]
							return
						}
						;mainCount:Set[${Math.Calc[${mainCount}+1]}]
						;return
					}
					else
					{
						if ${CombatBotDebug}
							echo Ignoring Stealth Ability: ${istrAbilities.Get[${mainCount}]}, Me.IsInvis: ${Me.IsInvis}, InvisAbilitiesAbilities: ${istrInvisAbilities.Used} CastInvis: ${UIElement[SettingsCastInvisCheckBox@SettingsFrame@CombatBotUI].Checked}
						mainCount:Set[${Math.Calc[${mainCount}+1]}]
						boolAbilityCast:Set[FALSE]
						boolItemCast:Set[FALSE]
						strCastName:Set[""]
						strCastNameShort:Set[""]
						strCastID:Set[0]
						strCastTarget:Set[""]
						return
					}
				;}
			}
		}
	}
	if ${CombatBotCastingDebug}
		echo Casting Ability ${CastNameShort} as ${CastName} ID: ${CastID} Target: ${Actor[id,${CastTarget}].Name}
	if ${CastTarget.Equal[FALSE]}
	{	
		;wait until we are not casting
		;echo waiting until we are not casting a spell ${Me.CastingSpell}
		;wait 50 !${Me.CastingSpell} || ${DoCasting}
		;Me.Ability[id,${CastID}]:Use
		;eq2execute useability ${CastName}
		;Me.Ability[id,${CastID}]:Use
		;eq2execute usea ${CastID}
		
		if ${DoCasting}
		{
			DoCasting:Set[FALSE]
			;echo ${Me.GetGameData[Spells.Casting].Label} // ${CastName}
			do
			{
				;echo eq2execute useability ${CastName}
				;echo Me.Ability[id,${CastID}]:Use
				;eq2execute useability ${CastName}
				if !${Me.CastingSpell}
				{
					Me.Ability[id,${CastID}]:Use
					eq2execute clearabilityqueue
				}
				wait 2 ${Me.CastingSpell} || !${Me.Ability[id,${CastID}].IsReady}
				;${boolInstantCast} || 
				if ${boolBuff} || ${CastName.Equal["Negative Void"]}
					wait 5
				if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${CastName}"]}
					break
				waitframe
			}
			while ${Me.Ability[id,${CastID}].IsReady} && !${Me.CastingSpell} && ${GiveUpCnt:Inc}<=5 && ${Me.GetGameData[Spells.Casting].Label.NotEqual[${CastName}]}
			; eq2execute clearabilityqueue
			; wait 2 ${Me.CastingSpell}
			; wait 100 !${Me.CastingSpell}
		}
		else 
		{
			do
			{
				;echo Casting ${CastNameShort} as ${CastName}
				if !${Me.CastingSpell}
				{
					Me.Ability[id,${CastID}]:Use
					eq2execute clearabilityqueue
				}
				wait 2 ${Me.CastingSpell} || !${Me.Ability[id,${CastID}].IsReady} || ( ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal[${CastName}]} )
				;${boolInstantCast} || 
				if ${boolBuff} || 
					wait 5
				if ${CastNameShort.Equal["In Plain Sight"]}
				{
					wait 2
				}
				if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${CastName}"]}
					break
				waitframe
			}
			while ${Me.Ability[id,${CastID}].IsReady} && !${Me.CastingSpell} && ${GiveUpCnt:Inc}<=5 && !${DoCasting} && ${Me.GetGameData[Spells.Casting].Label.NotEqual[${CastName}]}
		}
		if ${EQ2.ServerName.NotEqual[Battlegrounds]} && ( ${Me.GetGameData[Spells.Casting].Label.Equal[${CastName}]} && ${Me.CastingSpell} ) || ${Me.Ability[id,${CastID}].TimeUntilReady}>0
			AnnounceObj:Announce[${CastNameShort}]	
		;{boolInstantCast} ||
		;if ${boolBuff}
		;{
			;echo Instant or Buff
			;eq2execute clearabilityqueue
			;wait 4 ${Me.CastingSpell} || ${DoCasting}
			wait 100 !${Me.CastingSpell} || ${DoCasting}
		;}
		;wait 1
		eq2execute clearabilityqueue
		;wait ${Math.Calc[((1-(.${Me.GetGameData[Stats.Spell_Recovery_Percent].Label.Left[-1]}/2))*.5)*10]}
	}
	else
	{
		;wait until we are not casting
		;wait 50 !${Me.CastingSpell}	|| ${DoCasting}
		; while ${Me.Ability[id,${CastID}].IsReady}
		; {
			; eq2execute useabilityonplayer ${Actor[id,${CastTarget}].Name} "${CastName}"
			; wait 1 ${Me.CastingSpell} || ${DoCasting}
			; if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${CastName}"]}
				; break
		; }
		;check collision
		if ${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+1]},${Me.Z},${Actor[id,${CastTarget}].X},${Math.Calc[${Actor[id,${CastTarget}].Y}+1]},${Actor[id,${CastTarget}].Z}]}
		{
			if ${CombatBotDebug}
				echo Ignoring Ability: ${CastNameShort}, TargetID: ${CastTarget}, TargetName: ${Actor[id,${CastTarget}].Name} CheckCollision: ${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+1]},${Me.Z},${Actor[id,${CastTarget}].X},${Math.Calc[${Actor[id,${CastTarget}].Y}+1]},${Actor[id,${CastTarget}].Z}]}
			mainCount:Set[${Math.Calc[${mainCount}+1]}]
			boolAbilityCast:Set[FALSE]
			boolItemCast:Set[FALSE]
			strCastName:Set[""]
			strCastNameShort:Set[""]
			strCastID:Set[0]
			strCastTarget:Set[""]
			return
		}
		if ${DoCasting}
		{
			DoCasting:Set[FALSE]
			do
			{
				;echo eq2execute useability ${CastName}
				;echo Me.Ability[id,${CastID}]:Use
				;eq2execute useability ${CastName}
				if !${Me.CastingSpell}
				{
					if ${Me.Name.Find["Skyshrine "](exists)}
						eq2execute usea "${CastName}"
					elseif ${EQ2.ServerName.Equal[Battlegrounds]}
						;eq2execute useabilityonplayer ${RI_Obj_CB.ConvertBattleGroundsName[${Actor[id,${CastTarget}].Name}]} "${CastName}"
						eq2execute useabilityonplayer ${RI_Obj_CB.ConvertBattleGroundsName[${Actor[id,${CastTarget}].Name}]} ${CastID}
					else
						;eq2execute useabilityonplayer ${Actor[id,${CastTarget}].Name} "${CastName}"
						eq2execute useabilityonplayer ${Actor[id,${CastTarget}].Name} ${CastID}
					eq2execute clearabilityqueue
				}
				wait 2 ${Me.CastingSpell} || !${Me.Ability[id,${CastID}].IsReady}
				;${boolInstantCast} || 
				if ${boolBuff}
					wait 5
				if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${CastName}"]}
					break
			}
			while ${Me.Ability[id,${CastID}].IsReady} && !${Me.CastingSpell} && ${GiveUpCnt:Inc}<=5 && ${Me.GetGameData[Spells.Casting].Label.NotEqual[${CastName}]}
			; eq2execute clearabilityqueue
			; wait 2 ${Me.CastingSpell}
			; wait 100 !${Me.CastingSpell}
			waitframe
		}
		else 
		{
			do
			{
				; if ${CastName.Equal[Ethereal Conduit]}
				; {
					;;wait until we are not casting
					; wait 50 !${Me.CastingSpell} || ${DoCasting}
					; wait 3
					;;set AssistTargeting FALSE
					; variable bool IWasAssisting=FALSE
					; if ${CombatBotAssisting}
					; {
						; CombatBotAssisting:Set[FALSE]
						; IWasAssisting:Set[TRUE]
					; }
					; variable int tempid=0
					; if ${Target(exists)}
						; tempid:Set[${Target.ID}]
					;;target ${CastTarget}
					; Actor[${CastTarget}]:DoTarget
					; wait 2
					; waitframe
					; do
					; {
						;;echo Casting ${CastNameShort} as ${CastName}
						; if !${Me.CastingSpell}
						; {
							; Me.Ability[id,${CastID}]:Use
							; eq2execute clearabilityqueue
						; }
						; wait 2 ${Me.CastingSpell} || !${Me.Ability[id,${CastID}].IsReady} || ( ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal[${CastName}]} )

						; if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${CastName}"]}
							; break
						; waitframe
					; }
					; while ${Me.Ability[id,${CastID}].IsReady} && !${Me.CastingSpell} && ${GiveUpCnt:Inc}<=5 && !${DoCasting} && ${Me.GetGameData[Spells.Casting].Label.NotEqual[${CastName}]}
										
					; wait 2 ${Me.CastingSpell} || ${DoCasting}
					;;wait 100 !${Me.CastingSpell} || ${DoCasting}
					; if ${boolBuff}
						; wait 5
					; wait 2
					; eq2execute clearabilityqueue
					;;&& ${Actor[id,${tempid}].InZone} 
					; if ${Actor[id,${tempid}](exists)} && ${Actor[id,${tempid}].Health(exists)} && !${Actor[id,${tempid}].IsDead} && ${tempid}!=0
						; Actor[id,${tempid}]:DoTarget
					; else
						; eq2execute target_none
					; wait 1
					; if ${IWasAssisting}
						; CombatBotAssisting:Set[TRUE]
				; }
				if !${Me.CastingSpell}
				{
					if ${Me.Name.Find["Skyshrine "](exists)}
						eq2execute usea "${CastName}"
					elseif ${EQ2.ServerName.Equal[Battlegrounds]}
						;eq2execute useabilityonplayer ${RI_Obj_CB.ConvertBattleGroundsName[${Actor[id,${CastTarget}].Name}]} "${CastName}"
						eq2execute useabilityonplayer ${RI_Obj_CB.ConvertBattleGroundsName[${Actor[id,${CastTarget}].Name}]} ${CastID}
					else
						;eq2execute useabilityonplayer ${Actor[id,${CastTarget}].Name} "${CastName}"
						eq2execute useabilityonplayer ${Actor[id,${CastTarget}].Name} ${CastID}
					eq2execute clearabilityqueue
				}
				wait 2 ${Me.CastingSpell} || !${Me.Ability[id,${CastID}].IsReady} || ${Me.Ability[id,${CastID}].TimeUntilReady}>0 || ( ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal[${CastName}]} )
				;${boolInstantCast} || 
				if ${boolBuff}
					wait 5
				if ${Me.CastingSpell} && ${Me.GetGameData[Spells.Casting].Label.Equal["${CastName}"]}
					break
				waitframe
			}
			while ${Me.Ability[id,${CastID}].IsReady} && ${Me.Ability[id,${CastID}].IsReady} && !${Me.CastingSpell} && ${GiveUpCnt:Inc}<=5 && !${DoCasting} && ${Me.GetGameData[Spells.Casting].Label.NotEqual[${CastName}]}
		}
		if ${EQ2.ServerName.NotEqual[Battlegrounds]} && ( ${Me.GetGameData[Spells.Casting].Label.Equal[${CastName}]} && ${Me.CastingSpell} ) || ${Me.Ability[id,${CastID}].TimeUntilReady}>0
			AnnounceObj:Announce[${CastNameShort},${CastTarget}]
		;if ${boolInstantCast} || ${boolBuff}
		;{
			;echo Instant or Buff
			;eq2execute clearabilityqueue
			;wait 2 ${Me.CastingSpell} || ${DoCasting}
			wait 100 !${Me.CastingSpell} || ${DoCasting}
		;}
		;wait 2 ${Me.CastingSpell} || ${DoCasting}
		;wait 100 !${Me.CastingSpell} || ${DoCasting}
		;wait 1
		;eq2execute clearabilityqueue
	}
	if !${Me.Ability[id,${istrExportID.Get[${istrInvisAbilitiesAbilityExportPosition}]}].IsReady}
		mainCount:Set[1]
	boolAbilityCast:Set[FALSE]
	if ${istrExportReqStealth.Get[${UIElement[CastStackAbiltiesListBox@CastStackFrame@CombatBotUI].OrderedItem[${mainCount}].Value.Token[2,|]}].Equal[TRUE]} 
	{
		wait 5 !${Me.Ability[id,${CastID}].IsReady}
	}
	mainCount:Set[1]
}
function CastItem(string ItemName, bool RIE, string fiCastTarget=FALSE)
{
	;echo RIE: ${RIE}
	;echo Found Item in Cast Stack checking for RIE and if so if we are wearing it
	if ${Me.Equipment["${ItemName}"](exists)}
		ItemEquiped:Set[TRUE]
	elseif !${Me.Equipment["${ItemName}"](exists)} && ${RIE}
	{
		if ${CombatBotDebug}
			echo Ignoring ${ItemName}, item is not equipped
		mainCount:Set[${Math.Calc[${mainCount}+1]}]
		return
	}
	elseif !${Me.Equipment["${ItemName}"](exists)} && !${RIE} && !${Me.Inventory["${ItemName}"](exists)}
	{
		if ${CombatBotDebug}
			echo Ignoring ${ItemName}, was not found in inventory
		mainCount:Set[${Math.Calc[${mainCount}+1]}]
		return
	}
	elseif !${Me.Equipment["${ItemName}"](exists)} && !${RIE} && ${Me.Inventory["${ItemName}"](exists)}
	{
		ItemEquiped:Set[FALSE]
	}
	;echo castitem called for ${ItemName} Target: ${fiCastTarget}
	strCastName:Set["${ItemName}"]
	strCastTarget:Set["${fiCastTarget}"]
	;echo ${strCastTarget}
	strCastID:Set[0]
	boolItemCast:Set[TRUE]
	boolAbilityCast:Set[FALSE]

	;return 2
}
function CastItemFN(string ItemName, string iCastTarget=FALSE)
{
	;echo ${iCastTarget}
	if ${CombatBotCastingDebug} && ${iCastTarget.NotEqual[FALSE]}
		echo Casting Item ${ItemName} Target: ${Actor[id,${iCastTarget}].Name} Equiped: ${ItemEquiped}
	elseif ${CombatBotCastingDebug} && ${iCastTarget.Equal[FALSE]}
		echo Casting Item ${ItemName} Equiped: ${ItemEquiped}
	if ${iCastTarget.Equal[FALSE]}
	{	
		;wait until we are not casting
		wait 50 !${Me.CastingSpell} || ${DoCasting}
		wait 3
		;echo end wait
		variable int GiveUpCnt=0
		if ${ItemEquiped}
		{
			;echo Me.Equipment[${ItemName}]:Use
			Me.Equipment[${ItemName}]:Use
			if ${DoCastingItem}
			{
				
				DoCasting:Set[FALSE]
				DoCastingItem:Set[FALSE]
				ItemEquiped:Set[FALSE]
				while ${Me.Equipment[${ItemName}].TimeUntilReady}<0 && ${GiveUpCnt:Inc}<250
				{
				echo 3
					Me.Equipment[${ItemName}]:Use
					waitframe
				}
			}
		}
		else
		{
			;echo Me.Inventory[${ItemName}]:Use
			Me.Inventory[${ItemName}]:Use
			if ${DoCastingItem}
			{
				DoCasting:Set[FALSE]
				DoCastingItem:Set[FALSE]
				ItemEquiped:Set[FALSE]
				while ${Me.Inventory[${ItemName}].TimeUntilReady}<0 && ${GiveUpCnt:Inc}<250
				{
					echo 5
					Me.Inventory[${ItemName}]:Use
					waitframe
				}
			}
		}
		wait 5 ${Me.CastingSpell} || ${DoCasting}
		wait 100 !${Me.CastingSpell} || ${DoCasting}
		if ${boolBuff}
			wait 5
		wait 3
		eq2execute clearabilityqueue
	}
	else
	{
		;wait until we are not casting
		wait 50 !${Me.CastingSpell} || ${DoCasting}
		wait 3
		;set AssistTargeting FALSE
		variable bool IWasAssisting=FALSE
		if ${CombatBotAssisting}
		{
			CombatBotAssisting:Set[FALSE]
			IWasAssisting:Set[TRUE]
		}
		variable int tempid=0
		if ${Target(exists)}
			tempid:Set[${Target.ID}]
		;target ${CastTarget}
		Actor[${iCastTarget}]:DoTarget
		wait 2
		waitframe
		if ${ItemEquiped}
		{
			;echo Me.Equipment["${ItemName}"]:Use
			Me.Equipment["${ItemName}"]:Use
		}
		else
		{
			;echo Me.Inventory["${ItemName}"]:Use
			Me.Inventory["${ItemName}"]:Use
		}
		wait 5 ${Me.CastingSpell} || ${DoCasting}
		wait 100 !${Me.CastingSpell} || ${DoCasting}
		if ${boolBuff}
			wait 5
		wait 2
		eq2execute clearabilityqueue
		;&& ${Actor[id,${tempid}].InZone} 
		if ${Actor[id,${tempid}](exists)} && ${Actor[id,${tempid}].Health(exists)} && !${Actor[id,${tempid}].IsDead} && ${tempid}!=0
			Actor[id,${tempid}]:DoTarget
		else
			eq2execute target_none
		wait 1
		if ${IWasAssisting}
			CombatBotAssisting:Set[TRUE]
	}
	if ${ItemEquiped}
	{
		;echo announce ${ItemName} ${Me.Equipment["${ItemName}"].TimeUntilReady}>0
		if ${EQ2.ServerName.NotEqual[Battlegrounds]} && ${Me.Equipment["${ItemName}"].TimeUntilReady}>0
			AnnounceObj:Announce["Item:${ItemName}",${iCastTarget}]
	}
	else
	{
		;echo announce
		if ${EQ2.ServerName.NotEqual[Battlegrounds]} && ${Me.Inventory["${ItemName}"].TimeUntilReady}>0
			AnnounceObj:Announce["Item:${ItemName}",${iCastTarget}]
	}
	boolItemCast:Set[FALSE]
}
function DumpSubsets(settingsetref Set)
{
  variable iterator Iterator
  Set:GetSetIterator[Iterator]


  echo ${Set.Name}

  if !${Iterator:First(exists)}
     return

  do
  {
     call DumpSubsets ${Iterator.Value.GUID}
  }
  while ${Iterator:Next(exists)}
}
atom IterateCastStack(settingsetref Set, int CastStackCount)
{
	variable string temp
	variable settingsetref Set4
	variable int icCount=0
	for(icCount:Set[1];${icCount}<=${CastStackCount};icCount:Inc)
	{
		;echo checking ${icCount}
		Set4:Set[${Set.FindSet[${icCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		variable string _AbilityDisabled
		variable bool _gotAbilityDisabled
		variable string _AbilityName
		variable bool _gotAbilityName
		variable string _ExportPosition
		variable bool _gotExportPosition
		variable string _Type
		variable bool _gotType
		variable string _Target
		variable bool _gotTarget
		variable string _%
		variable bool _got%
		variable string _#
		variable bool _got#
		variable string _SD
		variable bool _gotSD
		variable string _SE
		variable bool _gotSE
		variable string _SAE
		variable bool _gotSAE
		variable string _RIE
		variable bool _gotRIE
		variable string _MAX
		variable bool _gotMax
		variable string _Savagery
		variable bool _gotSavagery
		variable string _DissonanceLess
		variable bool _gotDissonanceLess
		variable string _DissonanceGreater
		variable bool _gotDissonanceGreater
		
		_AbilityDisabled:Set[""]
		_gotAbilityDisabled:Set[FALSE]
		_AbilityName:Set[""]
		_gotAbilityName:Set[FALSE]
		_ExportPosition:Set["0"]
		_gotExportPosition:Set[FALSE]
		_Type:Set[""]
		_gotType:Set[FALSE]
		_Target:Set[""]
		_gotTarget:Set[FALSE]
		_%:Set[""]
		_got%:Set[FALSE]
		_#:Set[""]
		_got#:Set[FALSE]
		_SD:Set[""]
		_gotSD:Set[FALSE]
		_SE:Set[""]
		_gotSE:Set[FALSE]
		_SAE:Set[""]
		_gotSAE:Set[FALSE]
		_RIE:Set[""]
		_gotRIE:Set[FALSE]
		_MAX:Set[""]
		_gotMax:Set[FALSE]
		_Savagery:Set[""]
		_gotSavagery:Set[FALSE]
		_DissonanceLess:Set[""]
		_gotDissonanceLess:Set[FALSE]
		_DissonanceGreater:Set[""]
		_gotDissonanceGreater:Set[FALSE]
		
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[CastStackAbilityDisabled]}
			{
				_gotAbilityDisabled:Set[TRUE]
				_AbilityDisabled:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityRequiresItemEquipped]}
			{
				_gotRIE:Set[TRUE]
				_RIE:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilitySkipAE]}
			{
				_gotSAE:Set[TRUE]
				_SAE:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilitySkipEncounter]}
			{
				_gotSE:Set[TRUE]
				_SE:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilitySkipDuration]}
			{
				_gotSD:Set[TRUE]
				_SD:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityRequired#]}
			{
				_got#:Set[TRUE]
				_#:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityRequired%]}
			{
				_got%:Set[TRUE]
				_%:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityName]}
			{
				_gotAbilityName:Set[TRUE]
				_AbilityName:Set["${SettingIterator.Value}"]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityType]}
			{
				_gotType:Set[TRUE]
				_Type:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityTarget]}
			{
				_gotTarget:Set[TRUE]
				_Target:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityRequiresMaxIncrements]}
			{
				_gotMax:Set[TRUE]
				_MAX:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilitySavagery]}
			{
				_gotSavagery:Set[TRUE]
				_Savagery:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityDissonanceLess]}
			{
				_gotDissonanceLess:Set[TRUE]
				_DissonanceLess:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[CastStackAbilityDissonanceGreater]}
			{
				_gotDissonanceGreater:Set[TRUE]
				_DissonanceGreater:Set[${SettingIterator.Value}]
			}
			if ${_gotAbilityDisabled} && ${_gotAbilityName} && ${_gotType} && ${_gotTarget} && ${_got%} && ${_got#} && ${_gotSD} && ${_gotSE} && ${_gotSAE} && ${_gotRIE} && ${_gotMax} && ${_gotSavagery} && ${_gotDissonanceLess} && ${_gotDissonanceGreater}
			{
				;token : -- AbilityName:ExportPosition:Type:Target:%:#:SD:SE:SAE:RIE:MAX:SAV:DLess:DGreater
				if ${_AbilityName.Left[5].Equal[Item:]}
					_ExportPosition:Set[0]
				else
					_ExportPosition:Set[${ConvertAbilityObj.Convert["${_AbilityName}"]}]
				RI_Obj_CB:AddCastStackAbilitiesListBoxItem[${_AbilityDisabled},"${_AbilityName}",${_ExportPosition},${_Type},${_Target},${_%},${_#},${_SD},${_SE},${_SAE},${_RIE},${_MAX},${_Savagery},${_DissonanceLess},${_DissonanceGreater}]
			}
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}

atom IteratePrePostCast(settingsetref Set, int PrePostCastCount)
{
;method AddPrePostCast(string FirstAbility=FALSE, string SecondAbility=FALSE, bool Before)

	variable string temp
	variable settingsetref Set4
	variable int icCount=0
	for(icCount:Set[1];${icCount}<=${PrePostCastCount};icCount:Inc)
	{
		;echo checking ${icCount}
		Set4:Set[${Set.FindSet[${icCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		variable string tempName
		variable string tempName2
		variable bool tempDisabled
		variable bool tempBefore
		variable bool gotName
		variable bool gotBefore
		tempName:Set[""]
		tempName2:Set[""]
		tempDisabled:Set[FALSE]
		tempBefore:Set[FALSE]
		gotName:Set[FALSE]
		gotBefore:Set[FALSE]
		
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[PrePostCastDisabled]}
			{
				tempDisabled:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[PrePostCastName]}
			{
				tempName:Set[${SettingIterator.Value}]
				gotName:Set[TRUE]
			}
			if ${SettingIterator.Key.Equal[PrePostCastBefore]} || ${SettingIterator.Key.Equal[PrePostCastAfter]}
			{
				if ${SettingIterator.Key.Equal[PrePostCastBefore]}
				{
					tempBefore:Set[TRUE]
				}
				else
				{
					tempBefore:Set[FALSE]
				}
				tempName2:Set[${SettingIterator.Value}]
				gotBefore:Set[TRUE]
			}
			if ${gotName} && ${gotBefore}
			{
				;echo RI_Obj_CB:AddPrePostCast["${tempName}","${tempName2}",${tempBefore},${tempDisabled}]
				RI_Obj_CB:AddPrePostCast["${tempName}","${tempName2}",${tempBefore},${tempDisabled}]
				tempDisabled:Set[FALSE]
				tempName:Set[FALSE]
				tempName2:Set[FALSE]
				gotName:Set[FALSE]
				tempBefore:Set[FALSE]
				gotBefore:Set[FALSE]
			}
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateItems(settingsetref Set, int PreCastCount)
{
	variable string temp
	variable settingsetref Set4
	variable int icCount=0
	UIElement[ItemsAddedItemListBox@ItemsFrame@CombatBotUI]:ClearItems
	for(icCount:Set[1];${icCount}<=${PreCastCount};icCount:Inc)
	{
		;echo checking ${icCount}
		variable string tempName
		tempName:Set[""]
		variable string tempEffect
		tempEffect:Set[""]
		variable bool gotName
		gotName:Set[FALSE]
		variable bool gotEffect
		gotEffect:Set[FALSE]
		Set4:Set[${Set.FindSet[${icCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[ItemName]}
			{
				tempName:Set["${SettingIterator.Value}"]
				gotName:Set[TRUE]
			}
			if ${SettingIterator.Key.Equal[ItemEffect]}
			{
				tempEffect:Set["${SettingIterator.Value}"]
				gotEffect:Set[TRUE]
			}
			if ${gotName} && ${gotEffect}
			{
				;echo Adding: ${tempName},${tempEffect}
				RI_Obj_CB:AddItem["${tempName}","${tempEffect}"]
				tempName:Set[""]
				tempEffect:Set[""]
				gotName:Set[FALSE]
				gotEffect:Set[FALSE]
			}
			
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateCharm(settingsetref Set, int _CharmCount)
{
	;echo IterateCharm(settingsetref Set=${Set}, int _CharmCount=${_CharmCount})
	variable string temp
	variable settingsetref Set4
	variable int _count=0
	UIElement[SubClassCharmMobsListBox@SubClassFrame@CombatBotUI]:ClearItems
	for(_count:Set[1];${_count}<=${_CharmCount};_count:Inc)
	{
		;echo checking ${_count}
		variable string tempName
		tempName:Set[""]
		; variable string tempEffect
		; tempEffect:Set[""]
		variable bool gotName
		gotName:Set[FALSE]
		; variable bool gotEffect
		; gotEffect:Set[FALSE]
		Set4:Set[${Set.FindSet[${_count}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[CharmMob]}
			{
				tempName:Set[${SettingIterator.Value}]
				gotName:Set[TRUE]
			}
			; if ${SettingIterator.Key.Equal[ItemEffect]}
			; {
				; tempEffect:Set[${SettingIterator.Value}]
				; gotEffect:Set[TRUE]
			; }
			if ${gotName}
			; && ${gotEffect}
			{
				;echo Adding: ${tempName}
				;,${tempEffect}
				RI_Obj_CB:AddCharmMob[${tempName}]
				tempName:Set[""]
				;tempEffect:Set[""]
				gotName:Set[FALSE]
				;gotEffect:Set[FALSE]
			}
			
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateAnnounce(settingsetref Set, int PreCastCount)
{
	variable string temp
	variable settingsetref Set4
	variable int icCount=0
	for(icCount:Set[1];${icCount}<=${PreCastCount};icCount:Inc)
	{
		;echo checking ${icCount}
		istrAnnounceDisabled:Insert[FALSE]
		Set4:Set[${Set.FindSet[${icCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		variable bool AnnounceDisabled
		AnnounceDisabled:Set[FALSE]
		variable string AnnounceName
		AnnounceName:Set[""]
		variable bool GotAnnounceName
		GotAnnounceName:Set[FALSE]
		variable string AnnounceTarget
		AnnounceTarget:Set[""]
		variable bool GotAnnounceTarget
		GotAnnounceTarget:Set[FALSE]
		variable string Announcement
		Announcement:Set[""]
		variable bool GotAnnouncement
		GotAnnouncement:Set[FALSE]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[AnnounceDisabled]}
			{
				AnnounceDisabled:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[AnnounceName]}
			{
				GotAnnounceName:Set[TRUE]
				AnnounceName:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[AnnounceTarget]}
			{
				GotAnnounceTarget:Set[TRUE]
				AnnounceTarget:Set[${SettingIterator.Value}]
			}
			if ${SettingIterator.Key.Equal[Announcement]}
			{
				GotAnnouncement:Set[TRUE]
				Announcement:Set["${SettingIterator.Value}"]
			}
			if ${GotAnnounceTarget} && ${GotAnnounceName} && ${GotAnnouncement}
			{
				RI_Obj_CB:AddAnnounce[${AnnounceName},${AnnounceTarget},"${Announcement}",${AnnounceDisabled}]
				GotAnnounceName:Set[FALSE]
				GotAnnounceTarget:Set[FALSE]
				GotAnnouncement:Set[FALSE]
				AnnounceDisabled:Set[FALSE]
				AnnounceName:Set[""]
				AnnounceTarget:Set[""]
				Announcement:Set[""]
			}
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IteratePostCast(settingsetref Set, int PostCastCount)
{
	variable string temp
	variable settingsetref Set4
	variable int icCount=0
	for(icCount:Set[1];${icCount}<=${PostCastCount};icCount:Inc)
	{
		;echo checking ${icCount}
		istrPostCastDisabled:Insert[FALSE]
		Set4:Set[${Set.FindSet[${icCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[__Disabled]}
				istrPostCastDisabled:Set[${icCount},${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[__SourceName]}
				istrPostCastAbility:Insert[${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[After]}
				istrPostCastAbilityAfter:Insert[${SettingIterator.Value}]
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateAliases(settingsetref Set, int AliasCount)
{
	UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI]:ClearItems
	variable settingsetref Set4
	variable int iaCount=0
	variable string tempName
	tempName:Set[""]
	variable string tempFor
	tempFor:Set[""]
	variable bool gotName
	gotName:Set[FALSE]
	variable bool gotFor
	gotFor:Set[FALSE]
	variable bool _Disabled
	_Disabled:Set[FALSE]
	for(iaCount:Set[1];${iaCount}<=${AliasCount};iaCount:Inc)
	{
		Set4:Set[${Set.FindSet[${iaCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[AliasDisabled]}
				_Disabled:Set[${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[AliasName]}
			{
				tempName:Set[${SettingIterator.Value}]
				gotName:Set[TRUE]
			}
			if ${SettingIterator.Key.Equal[AliasFor]}
			{
				tempFor:Set[${SettingIterator.Value}]
				gotFor:Set[TRUE]
			}
			if ${gotFor} && ${gotName}
			{
				;echo adding ${tempName} for ${tempFor}
				RI_Obj_CB:AddAlias[${tempName},${tempFor},${_Disabled}]
				gotName:Set[FALSE]
				gotFor:Set[FALSE]
				tempName:Set[""]
				tempFor:Set[""]
				_Disabled:Set[FALSE]
			}
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
	RI_Obj_CB:LoadAliases
}
atom IterateAliasesIndex(settingsetref Set, int AliasCount)
{
	variable settingsetref Set4
	variable int iaCount=0
	for(iaCount:Set[1];${iaCount}<=${AliasCount};iaCount:Inc)
	{
		Set4:Set[${Set.FindSet[${iaCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[AliasName]}
				istrAlias:Insert[${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[AliasFor]}
				istrAliasName:Insert[${SettingIterator.Value}]
			;waitframe
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
	RI_Obj_CB:LoadAliases
}
atom IterateAssist(settingsetref Set, int AliasCount)
{
	variable string temp
	variable settingsetref Set4
	variable int iaCount=0
	UIElement[AssistAddedListBox@AssistFrame@CombatBotUI]:ClearItems
	for(iaCount:Set[1];${iaCount}<=${AliasCount};iaCount:Inc)
	{
		Set4:Set[${Set.FindSet[${iaCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		variable bool _Disabled
		_Disabled:Set[FALSE]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[AssistDisabled]}
				_Disabled:Set[${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[AssistName]}
			{
				RI_Obj_CB:AddAssist[${SettingIterator.Value},${_Disabled}]
				_Disabled:Set[FALSE]
			}
			;waitframe
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateOnEvents(settingsetref Set, int SetCount)
{
	variable string temp
	variable settingsetref Set4
	variable int iaCount=0
	UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI]:ClearItems
	for(iaCount:Set[1];${iaCount}<=${SetCount};iaCount:Inc)
	{
		Set4:Set[${Set.FindSet[${iaCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		variable bool _OnEventsDisabled
		_OnEventsDisabled:Set[FALSE]
		variable string _Event
		_Event:Set[""]
		;variable bool _gotEvent
		;_gotEvent:Set[FALSE]
		variable string _Command
		_Command:Set[""]
		;variable bool _gotCommand
		;_gotCommand:Set[FALSE]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value.String.Escape}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[OnEventsDisabled]}
				_OnEventsDisabled:Set[${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[OnEventsEvent]}
			{
				_Event:Set[${SettingIterator.Value}]
				;_gotEvent:Set[TRUE]
			}
			if ${SettingIterator.Key.Equal[OnEventsCommand]}
			{
				_Command:Set["${SettingIterator.Value.String.Replace[\",""].Escape}"]
				RI_Obj_CB:AddOnEvents[${_Event},"${_Command.Escape}",${_OnEventsDisabled}]
				;_gotCommand:Set[TRUE]
				_OnEventsDisabled:Set[FALSE]
				_Event:Set[""]
			}
			; if ${_gotCommand} && ${_gotEvent}
			; {
				; echo RI_Obj_CB:AddOnEvents[${_Event},${_Command.Escape},${_OnEventsDisabled}]
				; _OnEventsDisabled:Set[FALSE]
				; _Event:Set[""]
				; _gotEvent:Set[FALSE]
				; _Command:Set[""]
				; _gotCommand:Set[FALSE]
			; }
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateInvisAbilities(settingsetref Set, int InvisAbilitiesCount)
{
	variable string temp
	variable settingsetref Set4
	variable int iaCount=0
	UIElement[InvisAbilitiesAddedAbilitiesList@InvisAbilitiesFrame@CombatBotUI]:ClearItems
	for(iaCount:Set[1];${iaCount}<=${InvisAbilitiesCount};iaCount:Inc)
	{
		Set4:Set[${Set.FindSet[${iaCount}].GUID}]
		variable iterator SettingIterator
		Set4:GetSettingIterator[SettingIterator]
		variable bool _Disabled
		_Disabled:Set[FALSE]
		if ${SettingIterator:First(exists)}
		{
		  do
		  {
			;echo "${SettingIterator.Key}=${SettingIterator.Value}"
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
			if ${SettingIterator.Key.Equal[InvisAbilityDisabled]}
				_Disabled:Set[${SettingIterator.Value}]
			if ${SettingIterator.Key.Equal[InvisAbilityName]}
			{	
				RI_Obj_CB:AddInvisAbility[${SettingIterator.Value},${_Disabled}]
				_Disabled:Set[FALSE]
			}
			;waitframe
		  }
		  while ${SettingIterator:Next(exists)}
		}
	}
}
atom IterateItemEffectPairs(settingsetref Set)
{
	;echo Iterating Export
	variable iterator Iterator
	Set:GetSettingIterator[Iterator]

	if !${Iterator:First(exists)}
		return
	do
	{
		istrItemEffectPairsItemName:Insert[${Iterator.Key}]
		istrItemEffectPairsEffectName:Insert[${Iterator.Value}]
		
		
		;echo "${Iterator.Key}=${Iterator.Value}"
		;waitframe
	}
	while ${Iterator:Next(exists)}
	;echo Done Iterating Export
}

atom IterateExport(settingsetref Set, int ExportCount)
{
	;echo Iterating Export
	variable iterator Iterator
	Set:GetSettingIterator[Iterator]
	variable string strTmpIsAE=FALSE
	variable int exportCount=0
	exportCount:Set[0]
	if !${Iterator:First(exists)}
		return
	do
	{
		exportCount:Inc
		;first insert FALSES
		istrExportIsRes:Insert[FALSE]
		istrExportIsASingleTargetBeneficial:Insert[FALSE]
		istrExportIsASingleTargetHostile:Insert[FALSE]
		istrExportIsSingleTargetAbility:Insert[FALSE]
		istrExportIsGroupAbility:Insert[FALSE]
		istrExportIsPetAbility:Insert[FALSE]
		istrExportIsSelfAbility:Insert[FALSE]
		istrExportIsOtherGroupAbility:Insert[FALSE]
		istrExportIsRaidAbility:Insert[FALSE]
		
		istrExport:Insert[${Iterator.Value}]
		istrExportID:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[AbilityID]}]
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[Level]}
			istrExportLevel:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[Level]}]
		else
			istrExportLevel:Insert[0]
		istrExportDissonanceCost:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[DissonanceCost]}]
		istrExportDoesNotExpire:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[DoesNotExpire]}]
		istrExportIsAE:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsAoE]}]
		strTmpIsAE:Set[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsAoE]}]
		istrExportIsAEncounterHostile:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsEncounter]}]
		istrExportAllowRaid:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[AllowRaid]}]
		if ${strTmpIsAE.String.Equal[TRUE]} && ${Set.FindSetting[${Iterator.Value}].FindAttribute[EffectRadius]}>0
		{
			istrExportMaxRange:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[EffectRadius]}]
			;echo This Export: ${Iterator.Value} is an AE: ${strTmpIsAE.String.Equal[TRUE]} Setting MaxRange to EffectRadius: ${Set.FindSetting[${Iterator.Value}].FindAttribute[EffectRadius]}
		}
		else
		{
			istrExportMaxRange:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[MaxRange]}]
		}
		;if ${Set.FindSetting[${Iterator.Value}].FindAttribute[MaxRange]}<=0
			;echo This Export: ${Iterator.Value} MaxRange is 0
		istrExportMinRange:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[MinRange]}]
		istrExportSavageryCost:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[SavageryCost]}]
		istrExportMaxDuration:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[MaxDuration]}]
		istrExportIsBeneficial:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsBeneficial]}]
		istrExportReqFlanking:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsFlankingRequired]}]
		istrExportReqStealth:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsStealthRequired]}]
		istrExportCastingTime:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[CastingTime]}]
		istrExportSpellBookType:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[SpellBookType]}]
		istrExportISPCCure:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsCure]}]
		istrExportIsABuff:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[DoesNotExpire]}]
		istrExportIsPCCureCurse:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[IsCureCurse]}]
		istrExportMaxAOETargets:Insert[${Set.FindSetting[${Iterator.Value}].FindAttribute[MaxAOETargets]}]
		
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute["DamageType"].String.NotEqual[FALSE]} && ( ${Set.FindSetting[${Iterator.Value}].FindAttribute["IsCure"]} || ${Set.FindSetting[${Iterator.Value}].FindAttribute["IsCureCurse"]} )
		{
			if ${Set.FindSetting[${Iterator.Value}].FindAttribute["DoesDmg"]} && ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.NotEqual[2]} && ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.NotEqual[8]} && ${Iterator.Value.String.NotEqual["Cure"]}
			{
				
				istrExportISPCCure:Set[${exportCount},FALSE]
				istrExportIsBeneficial:Set[${exportCount},FALSE]
				istrExportIsPCCureCurse:Set[${exportCount},FALSE]
			}
			else
			{
				istrExportIsASingleTargetBeneficial:Set[${exportCount},TRUE]
			}
		}
		
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[1]}
		{
			if ${Set.FindSetting[${Iterator.Value}].FindAttribute["IsBeneficial"]} || ${Set.FindSetting[${Iterator.Value}].FindAttribute["GroupRestricted"]} || ${Set.FindSetting[${Iterator.Value}].FindAttribute["AllowRaid"]}
			{
				istrExportIsASingleTargetBeneficial:Set[${exportCount},TRUE]
			}
			else
			{
				if ${setSpell.FindSetting[${CurrentSpellName}].FindAttribute["IsAoE"]}
				{
					;setSpell.FindSetting[${CurrentSpellName}]:AddAttribute[IsTargetAE,TRUE]
				}
				elseif ${setSpell.FindSetting[${CurrentSpellName}].FindAttribute["EffectRadius"]}
				{
					istrExportIsAEncounterHostile:Set[${exportCount},TRUE]
				}
				else
				{
					istrExportIsASingleTargetHostile:Set[${exportCount},TRUE]
				}
			}
		}

		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[5]}
			istrExportIsRes:Set[${exportCount},TRUE]
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[1]}
			istrExportIsSingleTargetAbility:Set[${exportCount},TRUE]
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[2]}
			istrExportIsGroupAbility:Set[${exportCount},TRUE]
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[3]}
			istrExportIsPetAbility:Set[${exportCount},TRUE]
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[0]}
			istrExportIsSelfAbility:Set[${exportCount},TRUE]		
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[8]}
			istrExportIsRaidAbility:Set[${exportCount},TRUE]
		if ${Set.FindSetting[${Iterator.Value}].FindAttribute[TargetType].String.Equal[9]}	
			istrExportIsOtherGroupAbility:Set[${exportCount},TRUE]


		;echo ${Set.FindSetting[${Iterator.Value}].FindAttribute[MaxDuration]}  -- ${Set.FindSetting[${Iterator.Value}].FindAttribute[IsBeneficial]}
		;echo ${Iterator.Value} - ${Set.FindSetting[${Iterator.Value}].FindAttribute[AbilityLineID]} - Level: ${Set.FindSetting[${Iterator.Value}].FindAttribute[Level]} - DissonanceCost: ${Set.FindSetting[${Iterator.Value}].FindAttribute[DissonanceCost]} - DoesNotExpire: ${Set.FindSetting[${Iterator.Value}].FindAttribute[DoesNotExpire]} - IsAE: ${Set.FindSetting[${Iterator.Value}].FindAttribute[IsAE]} - IsAEncounterHostile: ${Set.FindSetting[${Iterator.Value}].FindAttribute[IsAEncounterHostile]} - AllowRaid: ${Set.FindSetting[${Iterator.Value}].FindAttribute[AllowRaid]} - MinRange: ${Set.FindSetting[${Iterator.Value}].FindAttribute[MinRange]} - MaxRange: ${Set.FindSetting[${Iterator.Value}].FindAttribute[MaxRange]} - SavageryCost: ${Set.FindSetting[${Iterator.Value}].FindAttribute[SavageryCost]}
		;echo "${Iterator.Key}=${Iterator.Value}"
		;waitframe
	}
	while ${Iterator:Next(exists)}
	;echo Done Iterating Export
}
;object CountSetsObject
objectdef CountSetsObject
{
	;countsettings in set
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
		}
		while ${Iterator:Next(exists)}
		 
		return ${csoCount}
	}
	method IterateProfiles(settingsetref ipSet)
	{
		variable iterator Iterator
		ipSet:GetSetIterator[Iterator]
		if !${Iterator:First(exists)}
			return

		do
		{	
			istrProfiles:Insert[${Iterator.Key}]
			;echo ${Iterator.Key}
		}
		while ${Iterator:Next(exists)}
	}
	method PopulateProfiles()
	{
		variable int ecCount=0
		for(ecCount:Set[1];${ecCount}<=${istrProfiles.Used};ecCount:Inc)
		{
			UIElement[ProfilesComboBox@BottomFrame@CombatBotUI]:AddItem[${istrProfiles.Get[${ecCount}]}]
			UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI]:AddItem[${istrProfiles.Get[${ecCount}]}]
		}
		UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI]:SelectItem[${UIElement[DefaultProfileComboBox@BottomFrame@CombatBotUI].ItemByText[${CombatBotDefaultProfile}].ID}]
	}
	method EchoProfiles()
	{
		variable int ecCount=0
		for(ecCount:Set[1];${ecCount}<=${istrProfiles.Used};ecCount:Inc)
		{
			echo CombatBot: Available Profile: ${istrProfiles.Get[${ecCount}]}
		}
	}
}
;object CountSettingsObject
objectdef CountSettingsObject
{
	;countsettings in set
	member:int Count(settingsetref Set)
	{
		variable iterator Iterator
		Set:GetSettingIterator[Iterator]
		variable int cs2oCount
		

		;echo ${Set.Name}

		if !${Iterator:First(exists)}
			return

		do
		{
			cs2oCount:Inc
			;waitframe
		}
		while ${Iterator:Next(exists)}
		 
		return ${cs2oCount}
	}
}
;object MobsObject
objectdef MobsObject
{
	;find and target nearest mob aggro to me or my group/raid
	method TargetNearestAggroMob()
	{
		;echo TNAM
		;variable int intQuery=0
		variable index:actor ActorIndex
		
		;EQ2:GetActors[ActorIndex,range,100]
		if ${Zone.Name.Find[Qeynos](exists)} || ${Zone.Name.Find[Freeport](exists)}
			EQ2:QueryActors[ActorIndex, ( Type =="NPC" || Type =="NamedNPC" ) && Distance <= 100 && InCombatMode = TRUE && Health > 0 && Target.InMyGroup = TRUE]
		else
			EQ2:QueryActors[ActorIndex, ( Type =="NPC" || Type =="NamedNPC" ) && Distance <= 100 && InCombatMode = TRUE && Health > 0 && Target.InMyGroup = TRUE]
		
		if ${CombatBotDebugTargeting}
			echo ActorIndex: ${ActorIndex.Used}
			
		;if we got no actors return
		if ${ActorIndex.Used} <= 0
			return

			
		;remove everything except NPC and NamedNPC
		; intQuery:Set[${LavishScript.CreateQuery[Type = "NPC" || Type = "NamedNPC"]}]
		; ActorIndex:RemoveByQuery[${intQuery},FALSE]
		; LavishScript:FreeQuery[${intQuery}]
		; ActorIndex:Collapse
		
		;if nothing is left return
		; if ${ActorIndex.Used} <= 0
			; return
		
		;echo ActorIndex After Query1: ${ActorIndex.Used}
			
		;remove mobs that are not incombat, dead or health is <0
		; if ${CombatBotDebugTargeting}
			; echo ActorIndex Prior to Query2: ${ActorIndex.Used}
		;remove mobs that are not incombat or dead or health is <0
		; intQuery:Set[${LavishScript.CreateQuery[]}]
		; ActorIndex:RemoveByQuery[${intQuery},FALSE]
		; LavishScript:FreeQuery[${intQuery}]
		; ActorIndex:Collapse
			
		;if nothing is left return
		; if ${ActorIndex.Used} <= 0
			; return
		; if ${CombatBotDebugTargeting}
			; echo ActorIndex After Query2: ${ActorIndex.Used}
		if ${CombatBotDebugTargeting}
			echo I have no Target and Found one Targeting me or my raid: Targeting: ${ActorIndex[1].Name}
		ActorIndex[1]:DoTarget
	}
	;Mobs for AE
	member:int CountAE()
	{
		variable index:actor ActorIndex
		variable iterator ActorIterator
		variable int cmoActorCount=0
		
		;OLD WAY;variable int cmoCount=0
		;EQ2:GetActors[ActorIndex,range,20]
		;for(cmoCount:Set[1];${cmoCount}<=${ActorIndex.Used};cmoCount:Inc)
		;{
			;echo Checking ${ActorIndex[${cmoCount}].Name}
			;if the actor is incombatmode and not dead
		;	if ${ActorIndex[${cmoCount}].InCombatMode} && !${ActorIndex[${cmoCount}].IsDead} && ${ActorIndex[${cmoCount}].Health}>0 && ( ${ActorIndex[${cmoCount}].Type.Equal[NPC]} || ${ActorIndex[${cmoCount}].Type.Equal[NamedNPC]} )
		;		cmoActorCount:Inc
		;END OLD WAY;}
		
		EQ2:QueryActors[ActorIndex, ( Type =="NPC" || Type =="NamedNPC" ) && Distance <= 20 && InCombatMode = TRUE && IsDead = FALSE && Health > 0 && Target.InMyGroup = TRUE]
		ActorIndex:GetIterator[ActorIterator]
		
		if ${ActorIterator:First(exists)}
		{
			do
			{
				;echo "${ActorIterator.Value.Name}"
				cmoActorCount:Inc
			}
			while ${ActorIterator:Next(exists)}
		}
				
		return ${cmoActorCount}
	}
	;Mobs for Encounter
	member:int CountEncounter(int MobID)
	{
		variable index:actor ActorIndex
		variable int cmoEncounterActorCount=0
		variable int cmoEncounterCount=0

		EQ2:GetActors[ActorIndex,range,20]
		for(cmoEncounterCount:Set[1];${cmoEncounterCount}<=${ActorIndex.Used};cmoEncounterCount:Inc)
		{
			;echo Checking ${ActorIndex[${cmoEncounterCount}].Name}
			;if the actor is incombatmode and not dead
			if ${ActorIndex[${cmoEncounterCount}].InCombatMode} && !${ActorIndex[${cmoEncounterCount}].IsDead} && ${ActorIndex[${cmoEncounterCount}].Health}>0 && ( ${ActorIndex[${cmoEncounterCount}].Type.Equal[NPC]} || ${ActorIndex[${cmoEncounterCount}].Type.Equal[NamedNPC]} ) && ${ActorIndex[${cmoEncounterCount}].IsInSameEncounter[${MobID}]}
				cmoEncounterActorCount:Inc
		}
		return ${cmoEncounterActorCount}
	}
	member:bool EffectMainIconIDExists(int _ActorID, int _MainIconID)
	{
		if (${Actor[id,${_ActorID}](exists)})
		{
			variable int Counter=1
			variable int NumActorEffects
			NumActorEffects:Set[${Actor[id,${_ActorID}].NumEffects}]
			
			if (${NumActorEffects} > 0)
			{
				do
				{
					if ${Actor[id,${_ActorID}].Effect[${Counter}].MainIconID}==${_MainIconID}
					{
						echo return TRUE
						return
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				echo return FALSE
			}
			else
				echo return FALSE
		}
		else
			echo return FALSE
	}
}
function echoExport()
{
	variable int eeCount=0
	for(eeCount:Set[1];${eeCount}<=${istrExport.Used};eeCount:Inc)
	{
		echo Export ${eeCount}: ${istrExport.Get[${eeCount}]} ID: ${istrExportID.Get[${eeCount}]} Level: ${istrExportLevel.Get[${eeCount}]} AlwRaid: ${istrExportAllowRaid.Get[${eeCount}]} DisCost: ${istrExportDissonanceCost.Get[${eeCount}]} DNE: ${istrExportDoesNotExpire.Get[${eeCount}]} IsAE: ${istrExportIsAE.Get[${eeCount}]} IsAEnc: ${istrExportIsAEncounterHostile.Get[${eeCount}]} IsBene: ${istrExportIsBeneficial.Get[${eeCount}]} MnRng: ${istrExportMinRange.Get[${eeCount}]} MxRng: ${istrExportMaxRange.Get[${eeCount}]} MxDur: ${istrExportMaxDuration.Get[${eeCount}]} SavCost: ${istrExportSavageryCost.Get[${eeCount}]} RegFlnk: ${istrExportReqFlanking.Get[${eeCount}]} ReqStlth: ${istrExportReqStealth.Get[${eeCount}]} SBT: ${istrExportSpellBookType.Get[${eeCount}]}
	}
}
function atexit()
{	
	variable int i
	for(i:Set[1];${i}<=${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].Items};i:Inc)
	{
		
		if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].TextColor}!=-10263709 && ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[1,|].Equal[End]}
		{
			;echo Executing on End: ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}
			;RI_CMD_ExecuteCommand ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}
			if ${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Left[5].Upper.Equal[RELAY]}
			{
				variable int leftnum
				leftnum:Set[${Math.Calc[6+${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Right[-6].Find[" "]}]}]
				noop ${Execute[${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Left[${leftnum}]} "${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|].Right[${Math.Calc[-1*${leftnum}]}]}"]}
			}
			else
				noop ${Execute["${UIElement[OnEventsAddedOnEventsListBox@OnEventsFrame@CombatBotUI].OrderedItem[${i}].Value.Token[2,|]}"]}
		}
	}
	;UIElement[CombatBotUI]:SetHeight[65]
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotUI.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotMiniUI.xml"
	UIElement[RIMovement]:Show
	echo ISXRI: CombatBot: Ending v${RI_Var_Float_LocalCBVersion.Precision[2]}
	RIMUIObj:UnLoadNearestPlayerHud[${Me.Name}]
	RIMUIObj:UnLoadNearestNPCHud[${Me.Name}]
	RIMUIObj:UnLoadRaidGroupHud[${Me.Name}]
}