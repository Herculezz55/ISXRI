;AbilityCheck v1 by Herculezz

function main(... args)
{	
	;disable debugging
	Script:DisableDebugging

	echo ISXRI: Starting AbilityCheck v1
	
	variable index:string AbilityName
	variable index:string AbilityID
	variable index:int Level
	variable int LevelGreaterThan=0
	variable int LevelLessThan=125
	variable index:string Tier
	variable string MSC
	variable int _failcnt=0
	variable int _acnt=0
	variable bool RestartCB=FALSE
	for(_acnt:Set[1];${_acnt}<=${args.Used};_acnt:Inc)
	{
		;echo args ${_acnt} : ${args[${_acnt}]}
		switch ${args[${_acnt}]}
		{
			case -RestartCB
			{
				RestartCB:Set[1]
				break
			}
			case -AbilityName
			{
				AbilityName:Insert["${args[${Math.Calc[${_acnt}+1]}]}"]
				_failcnt:Set[0]
				while ${Me.Ability["${args[${Math.Calc[${_acnt}+1]}]}"].ID}<1 && ${_failcnt:Inc}<10
				{
					wait 1
				}
				AbilityID:Insert[${Me.Ability["${args[${Math.Calc[${_acnt}+1]}]}"].ID}]
				break
			}
			case -AbilityID
			{
				AbilityID:Insert["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -Level
			{
				Level:Insert["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -LevelGreaterThan
			{
				LevelGT:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -LevelLessThan
			{
				LevelLT:Set["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
			case -Tier
			{
				Tier:Insert["${args[${Math.Calc[${_acnt}+1]}]}"]
				break
			}
		}
	}
	
	
	variable int NumAbil=${Me.NumAbilities}
	variable string CurrentAbilityID
	variable string CurrentAbilityName
	variable settingsetref AbilitySet

	declare FP filepath "${LavishScript.HomeDirectory}/"
	declare ImportFile string ""
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/"]
	
	if ${Me.Name.Find[Skyshrine Guardian](exists)}
		MSC:Set[skyshrineguardian]
	if ${Me.Name.Find[Skyshrine Infiltrator](exists)}
		MSC:Set[skyshrineinfiltrator]
	else
		MSC:Set[${Me.SubClass}]
	
	;IF our abilitycheckfile exists, load it else create new
	if ${FP.FileExists["${MSC}-AbilityCheck.xml"]}
	{
		LavishSettings[AbilityCheck]:Clear
		LavishSettings:AddSet[AbilityCheck]
		LavishSettings[AbilityCheck]:Import["${LavishScript.HomeDirectory}/scripts/RI/CombatBot/AbilityCheck/${MSC}-AbilityCheck.xml"]
	}
	else
	{
		;clear and addset for lavishsettings
		LavishSettings[AbilityCheck]:Clear
		LavishSettings:AddSet[AbilityCheck]
		LavishSettings[AbilityCheck]:AddSet[${Me.SubClass}]
	}
	AbilitySet:Set[${LavishSettings[AbilityCheck].FindSet[${Me.SubClass}]}]
	
	
	;cancel Negative Void
	if ${Me.SubClass.Equal[warlock]} && ${Me.Maintained[Negative Void](exists)}
	{
		Me.Maintained[Negative Void]:Cancel
		wait 10
	}
	echo ISXRI: ${Time}: AbilityCheck Checking ${NumAbil} Abilities
	
	
	variable index:ability Abilities
    variable iterator AbilitiesIterator
    variable int AbilityCounter = 0
    variable int Timer = 0
    
    ;;;;;;;;;;;;;;
    ;;;;
    ;;;; The following routine illustrates how to iterate through abilities.  To return a single
    ;;;; ability, you can do so by using the "Query" argument along with a lavishsoft Query String.  For example
    ;;;; to check if the character has an ability with a ID of 234, simply use:
    ;;;; "if ${Me.Ability[Query, ID =- "546331599"](Exists)}"
    ;;;;;;;;
    
    ;echo "Abilities (Total ${Me.NumAbilities}):"
    Me:QueryAbilities[Abilities]
    Abilities:GetIterator[AbilitiesIterator]
	variable bool _FoundAbility
	variable int _cnt
    if ${AbilitiesIterator:First(exists)}
    {
        do
        {
			AbilityCounter:Inc
			if ${AbilityID.Used}>0
			{
				;echo test
				_FoundAbility:Set[FALSE]
				for(_cnt:Set[0];${_cnt}<=${AbilityID.Used};_cnt:Inc)
				{
					if ${AbilitiesIterator.Value.ID}==${AbilityID.Get[${_cnt}]}
						_FoundAbility:Set[1]
				}
				if !${_FoundAbility}
				{
					;echo ISXRI: ${Time}: Skipping Not Passed In Ability ${AbilityCounter} of ${Me.NumAbilities}: w/ ID #: ${AbilitiesIterator.Value.ID}
					continue
				}
			}
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; This routine is echoing the ability's "Name", so we must ensure that the abilityinfo 
            ;; datatype is available.
            if (!${AbilitiesIterator.Value.IsAbilityInfoAvailable})
            {
                ;; When you check to see if "IsAbilityInfoAvailable", ISXEQ2 checks to see if it's already
                ;; cached (and immediately returns true if so).  Otherwise, it spawns a new thread 
                ;; to request the details from the server.   
                do
                {
                    wait 2
					;echo waiting - ${AbilitiesIterator.Value.IsAbilityInfoAvailable}  //  ${AbilitiesIterator.Value.ToAbilityInfo.Name}
                    ;; It is OK to use waitframe here because the "IsAbilityInfoAvailable" will simple return
                    ;; FALSE while the details acquisition thread is still running.   In other words, it 
                    ;; will not spam the server, or anything like that.
                }
                while (!${AbilitiesIterator.Value.IsAbilityInfoAvailable} && ${Timer:Inc} < 1500)
            }
            ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; At this point, the "ToAbilityInfo" MEMBER of this object will be immediately available.  It should
            ;; remain available until the cache is cleared/reset (which is not very often.)
 
            ;echo "- ${Counter}. ${AbilitiesIterator.Value.ToAbilityInfo.Name} (ID: ${AbilitiesIterator.Value.ID}, IsReady: ${AbilitiesIterator.Value.IsReady})"
            
			CurrentAbilityID:Set[${AbilitiesIterator.Value.ID}]
			CurrentAbilityName:Set[${AbilitiesIterator.Value.ToAbilityInfo.Name}]
			
			if ${AbilityName.Used}>0
			{
				;echo test
				_FoundAbility:Set[FALSE]
				for(_cnt:Set[0];${_cnt}<=${AbilityName.Used};_cnt:Inc)
				{
					if ${CurrentAbilityName.Find["${AbilityName.Get[${_cnt}]}"]}
						_FoundAbility:Set[1]
				}
				if !${_FoundAbility}
				{
					echo ISXRI: ${Time}: Skipping Not Passed In Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID} Tier: ${AbilitiesIterator.Value.ToAbilityInfo.Tier}
					continue
				}
			}
			if ${Tier.Used}>0
			{
				;echo test
				_FoundAbility:Set[FALSE]
				for(_cnt:Set[0];${_cnt}<=${Tier.Used};_cnt:Inc)
				{
					if ${AbilitiesIterator.Value.ToAbilityInfo.Tier.Find["${Tier.Get[${_cnt}]}"]}
						_FoundAbility:Set[1]
				}
				if !${_FoundAbility}
				{
					echo ISXRI: ${Time}: Skipping Incorrect Tier Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID} Tier: ${AbilitiesIterator.Value.ToAbilityInfo.Tier}
					continue
				}
			}
			if ${Level.Used}>0
			{
				;echo test
				_FoundAbility:Set[FALSE]
				for(_cnt:Set[0];${_cnt}<=${Level.Used};_cnt:Inc)
				{
					if ${Int[${AbilitiesIterator.Value.ToAbilityInfo.Class[${Me.SubClass}].Level}]}==${Level.Get[${_cnt}]}
						_FoundAbility:Set[1]
				}
				if !${_FoundAbility}
				{
					echo ISXRI: ${Time}: Skipping Incorrect Level Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID} Tier: ${AbilitiesIterator.Value.ToAbilityInfo.Tier}
					continue
				}
			}
			if ${Int[${AbilitiesIterator.Value.ToAbilityInfo.Class[${Me.SubClass}].Level}]}<${LevelGreaterThan}
			{
				echo ISXRI: ${Time}: Skipping Incorrect Level Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID} Tier: ${AbilitiesIterator.Value.ToAbilityInfo.Tier}
				continue
			}
			if ${Int[${AbilitiesIterator.Value.ToAbilityInfo.Class[${Me.SubClass}].Level}]}>${LevelLessThan}
			{
				echo ISXRI: ${Time}: Skipping Incorrect Level Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID} Tier: ${AbilitiesIterator.Value.ToAbilityInfo.Tier}
				continue
			}
			;SpellBookType 0=Spells,1=CombatArts,2=AbilitiesTab,3=Tradeskills,4=Passive,6=Ascension
			;skip AbilitiesTab abilities, except Summon:*
			if ${AbilitiesIterator.Value.ToAbilityInfo.SpellBookType}==2 && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Balanced Synergy](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Summon](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Illusion](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Pathfinding](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Singular Focus](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Ascension Form:](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Impenetrable Will](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Loyal Zelniak Companion](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Devoted Shadeweaver](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Feathered Stalker](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Familiar Infusion](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Mount Infusion](exists)} && !${AbilitiesIterator.Value.ToAbilityInfo.Name.Find[Mercenary Infusion](exists)}
			{
				echo ISXRI: ${Time}: Skipping AbilitiesTab Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID}
				continue
			}
			;skip Tradeskill abilities
			if ${AbilitiesIterator.Value.ToAbilityInfo.SpellBookType}==3
			{
				echo ISXRI: ${Time}: Skipping Tradeskill Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID}
				continue
			}
			;skip Passive abilities
			if ${AbilitiesIterator.Value.ToAbilityInfo.SpellBookType}==4
			{
				echo ISXRI: ${Time}: Skipping Passive Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID}
				continue
			}
			
			echo ISXRI: ${Time}: Adding Ability ${AbilityCounter} of ${Me.NumAbilities}: ${CurrentAbilityName} ID #: ${CurrentAbilityID} Tier: ${AbilitiesIterator.Value.ToAbilityInfo.Tier}
			;${CurrentAbilityName}=${AbilitiesIterator.Value.ToAbilityInfo.Name} ID #: ${CurrentAbilityID} = ${AbilitiesIterator.Value.ID}  === ${Me.Ability[id,${AbilitiesIterator.Value.ID}].ToAbilityInfo.Name}  ===  ${Me.Ability[${CurrentAbilityName}]}
			
			
			;820381576 - Warden - DawnstrikeAA. Has exact same name as the ability. Thx to Kannkor
			if ${CurrentAbilityID}==820381576 && ${Me.SubClass.Equal[Warden]}
				CurrentAbilityName:Set[${CurrentAbilityName}AA]

			;clear out the set if it exists
			if ${AbilitySet.FindSetting["${CurrentAbilityName}"](exists)}
				AbilitySet.FindSetting["${CurrentAbilityName}"]:Remove
			AbilitySet:AddSetting[${CurrentAbilityName},${CurrentAbilityName}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[AbilityID,"${CurrentAbilityID}"]
			
			;echo ${AbilitiesIterator.Value.ToAbilityInfo.Class[${Me.SubClass}].Level}
			if ${AbilitiesIterator.Value.ToAbilityInfo.Class[${Me.SubClass}](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Level,${AbilitiesIterator.Value.ToAbilityInfo.Class[${Me.SubClass}].Level}]
			else
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Level,0]
			
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsBeneficial,${AbilitiesIterator.Value.ToAbilityInfo.IsBeneficial}]
			
			;;check Effects of the rest
			variable bool IsAoE=FALSE
			variable bool IsEncounter=FALSE
			variable bool IsCureCurse=FALSE
			variable bool IsCure=FALSE
			variable bool IsDispel=FALSE
			variable bool IsStun=FALSE
			variable bool IsStealthRequired=FALSE
			variable bool IsFlankingRequired=FALSE
			variable bool IsRangedWeaponRequired=FALSE
			variable bool IsShieldRequired=FALSE
			variable bool IsEpicImmune=FALSE
			variable bool IsDebuff=FALSE
			variable bool IsThreatIncrease=FALSE
			variable bool IsThreatDecrease=FALSE
			variable bool IsStealthAbility=FALSE
			variable string DamageType=FALSE
			variable string Effect
			variable int count=0
			IsAoE:Set[FALSE]
			IsEncounter:Set[FALSE]
			IsCureCurse:Set[FALSE]
			IsCure:Set[FALSE]
			IsDispel:Set[FALSE]
			IsStun:Set[FALSE]
			IsStealthRequired:Set[FALSE]
			IsFlankingRequired:Set[FALSE]
			IsRangedWeaponRequired:Set[FALSE]
			IsShieldRequired:Set[FALSE]
			IsEpicImmune:Set[FALSE]
			IsDebuff:Set[FALSE]
			IsThreatIncrease:Set[FALSE]
			IsThreatDecrease:Set[FALSE]
			IsStealthAbility:Set[FALSE]
			DamageType:Set[FALSE]
			count:Set[0]
			for(count:Set[1];${count}<=${AbilitiesIterator.Value.ToAbilityInfo.NumEffects};count:Inc)
			{
				;echo Effect:Set["${AbilitiesIterator.Value.ToAbilityInfo.Effect[${count}].Desc}"]
				Effect:Set["${AbilitiesIterator.Value.ToAbilityInfo.Effect[${count}].Desc}"]
				if ${Effect.Find["targets in area of effect"](exists)} && !${Effect.Find["heals targets in area of effect"](exists)}
					IsAoE:Set[TRUE]
				if ${Effect.Find["target encounter"](exists)}
					IsEncounter:Set[TRUE]
				if ${Effect.Find["Decreases"](exists)} && ${Effect.Find["of"](exists)}  && ${Effect.Find["by"](exists)} 
					IsDebuff:Set[TRUE]
				if ${Effect.Find["Increases Threat to"](exists)}
					IsThreatIncrease:Set[TRUE]
				if ${Effect.Find["Decreases Threat to"](exists)}
					IsThreatDecrease:Set[TRUE]
				if ${Effect.Find["Grants stealth to caster"](exists)}
					IsStealthAbility:Set[TRUE]
				if ${Effect.Find["Dispels"](exists)} && ${Effect.Find["beneficial effects on target"](exists)}
					ISDispel:Set[TRUE]
				if ${Effect.Find["Dispels"](exists)} && ( ${Effect.Find["hostile effects on"](exists)} || ${Effect.Find["hostile fear"](exists)} )
				{
					if ${CurrentAbilityName.Left[4].NotEqual["Mend"]}
						IsCure:Set[TRUE]
				}
				if ${Effect.Find["Dispels"](exists)} && ${Effect.Find["curse effects on"](exists)}	
					IsCureCurse:Set[TRUE]
				if ${Effect.Find["Epic targets gain an immunity to stun"](exists)} || ${Effect.Find["Stuns target"](exists)}
					IsStun:Set[TRUE]
				if ${Effect.Find[Flanking or behind](exists)}
					IsFlankingRequired:Set[TRUE]
				if ${Effect.Find[you must be sneaking](exists)} || ${Effect.Find[you must be in stealth](exists)} || ${Effect.Find[you must be stealthed to use this](exists)} || ${Effect.Find[I need to be stealthed](exists)}
					IsStealthRequired:Set[TRUE]
				if ${Effect.Find[does not affect epic](exists)}
					IsEpicImmune:Set[TRUE]
				if ${Effect.Find[if weapon equipped in ranged](exists)}
					IsRangedWeaponRequired:Set[TRUE]
				if ${Effect.Find[if shield equipped in secondary](exists)}
					IsShieldRequired:Set[TRUE]
				if ${Effect.Find[poison damage on](exists)}
					DamageType:Set[Poison]
				if ${Effect.Find[arcane damage on](exists)}
					DamageType:Set[Arcane]
				if ${Effect.Find[melee damage on](exists)}
					DamageType:Set[Melee]
				if ${Effect.Find[ranged damage on](exists)}
					DamageType:Set[Ranged]
				if ${Effect.Find[mental damage on](exists)}
					DamageType:Set[Mental]
				if ${Effect.Find[magic damage on](exists)}
					DamageType:Set[Magic]
				if ${Effect.Find[heat damage on](exists)}
					DamageType:Set[Heat]
				if ${Effect.Find[cold damage on](exists)}
					DamageType:Set[Cold]
				if ${Effect.Find[piecing damage on](exists)}
					DamageType:Set[Piercing]
				if ${Effect.Find[disease damage on](exists)}
					DamageType:Set[Disease]
				if ${Effect.Find[slashing damage on](exists)}
					DamageType:Set[Slashing]
				if ${Effect.Find[crushing damage on](exists)}
					DamageType:Set[Crushing]
				if ${Effect.Find[divine damage on](exists)}
					DamageType:Set[Divine]
			}
			;;IsAoE For DaggerStorm
			if ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["total hits to enemies they are currently engaging in combat"](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsAoE,TRUE]
			elseif ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Inflicts damage to the mage's enemies who are within the blast radius"](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsAoE,TRUE]
			else
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsAoE,${IsAoE}]
			if ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Feral"](exists)}
			{
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Feral,TRUE]
				if ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Primal"](exists)}
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Primal,TRUE]
				if ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Advantage"](exists)}
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Advantage,TRUE]
			}
			elseif ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Spiritual"](exists)}
			{
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Spiritual,TRUE]
				if ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Primal"](exists)}
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Primal,TRUE]
				if ${AbilitiesIterator.Value.ToAbilityInfo.Description.Find["Advantage"](exists)}
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Advantage,TRUE]
			}
				
			; else
			; {
				; AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Feral,FALSE]
				; AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[Spiritual,FALSE]
			; }
			;echo ${IsAoE}
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsEncounter,${IsEncounter}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsCureCurse,${IsCureCurse}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsCure,${IsCure}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsDispel,${IsDispel}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsStun,${IsStun}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsStealthRequired,${IsStealthRequired}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsFlankingRequired,${IsFlankingRequired}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsRangedWeaponRequired,${IsRangedWeaponRequired}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsShieldRequired,${IsShieldRequired}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsEpicImmune,${IsEpicImmune}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsDebuff,${IsDebuff}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsThreatIncrease,${IsThreatIncrease}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsThreatDecrease,${IsThreatDecrease}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[IsStealthAbility,${IsStealthAbility}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[DamageType,${DamageType}]
		
			;;TargetType 0=Self,1=SingleTarget,2=Group,3=Pet,5=Res,8=Raid,9=OtherGroup
			switch ${CurrentAbilityID}
			{
				;;;1988236065 AncestralChanneling is Group=2
				;;;3317919629 Warden - Winds of Growth is Group=2
				;;;2770270544 Defiler - Phantasmal Barrier is Group=2
				;;;1112122823 Warden - Howling with the Pack is Group=2
				;;;1116482863 Enchanter - Manasoul is Group=2
				;;;3547634278 Guardian - Champion's Interception is Group=2
				case 1988236065
				case 3317919629
				case 2770270544
				case 1112122823
				case 1116482863
				case 3547634278
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[TargetType,2]
					break
				}
				;;;154548221 Templar - Deific Reformation is SingleTarget=1
				case 154548221
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[TargetType,1]
					break
				}
				;;;827011312 Crusader's faith
				case 827011312
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[TargetType,0]
					break
				}
				default
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[TargetType,${AbilitiesIterator.Value.ToAbilityInfo.TargetType}]
				}
			}
			

			
			;;;CAs (1) can be cast while moving, Spells (0) cannot
			;;;2441664395 = Cleansing of the Soul (Inq myth)
			;;;3903537279 = Arcane Bewilderment (Mage AA)
			;;;1624083660 = Umbral Barrier (Mystic AA)
			;;;if - Change FROM spell to CA
			switch ${CurrentAbilityID}
			{
				case 1624083660
				case 3903537279
				case 2441664395
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[SpellBookType,1]
					break
				}
				default
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[SpellBookType,${AbilitiesIterator.Value.ToAbilityInfo.SpellBookType}]
				}
			}
			
			if ${CurrentAbilityName.Find["Rejuvenation"](exists)} || ${CurrentAbilityName.Find["Ritual Healing"](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[AllowRaid,TRUE]
			else
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[AllowRaid,${AbilitiesIterator.Value.ToAbilityInfo.AllowRaid}]
				
			;;;GroupRestricted
			if ${CurrentAbilityName.Find["Ancestral Avenger"](exists)} || ${CurrentAbilityName.Find["Redemption"](exists)} || ${CurrentAbilityName.Find["ancestral savior"](exists)} || ${CurrentAbilityName.Find["Oberon"](exists)} || ${CurrentAbilityName.Find["Holy Shield"](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[GroupRestricted,TRUE]
			else
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[GroupRestricted,${AbilitiesIterator.Value.ToAbilityInfo.GroupRestricted}]
			
			;;;Some ablities have unlimited AOETargets
			;;;Ball Lightning
			;;;Ring of Fire
			;;;Acid Storm
			if ${CurrentAbilityName.Find["Ball Lightning"](exists)} || ${CurrentAbilityName.Find["Ring of Fire"](exists)} || ${CurrentAbilityName.Find["Acid Storm"](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxAOETargets,100]
			switch ${CurrentAbilityID}
			{
				;;;Circle of the Anicents: Mystic AA
				case 673915569 
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxAOETargets,100]
					break
				}
				;;;Unda Arcanus Spiritus: Enchanter Prestige
				case 3050559149
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxAOETargets,8]
					break
				}
				default
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxAOETargets,${AbilitiesIterator.Value.ToAbilityInfo.MaxAOETargets}]
				}
			}
			
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MinRange,${AbilitiesIterator.Value.ToAbilityInfo.MinRange}]
			
			;;;Change Max Range on (so we dont port around):
			;;;2479136206 Shadow Step: Assassin AA
			;;;235516501 Interrogation: Inquisitor AA
			;;;3900779518 Dragonwrath: Brigand AA
			switch ${CurrentAbilityID}
			{
				case 2479136206
				case 235516501
				case 3900779518
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxRange,5]
					break
				}
				default
				{
					AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxRange,${AbilitiesIterator.Value.ToAbilityInfo.MaxRange}]
				}
			}
			
			if ${CurrentAbilityName.Find["Cannibalize Thoughts"](exists)} || ${CurrentAbilityName.Find["Soul Shackle"](exists)}
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[EffectRadius,0]
			elseif ${CurrentAbilityID}==1248178167 || ${CurrentAbilityID}==2021499963
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[EffectRadius,15]
			else
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[EffectRadius,${AbilitiesIterator.Value.ToAbilityInfo.EffectRadius}]
				
			;;;Time Warp: Illusionist AA
			if ${CurrentAbilityID}==3020295062
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxDuration,5]
			else
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MaxDuration,${AbilitiesIterator.Value.ToAbilityInfo.MaxDuration}]
				

			
			if ${Me.SubClass.Equal[beastlord]}
			{
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[SavageryCost,${AbilitiesIterator.Value.ToAbilityInfo.SavageryCost}]
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[SavageryCostPerTick,${AbilitiesIterator.Value.ToAbilityInfo.SavageryCostPerTick}]
			}
			if ${Me.SubClass.Equal[channeler]}
			{
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[DissonanceCost,${AbilitiesIterator.Value.ToAbilityInfo.DissonanceCost}]
				AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[DissonanceCostPerTick,${AbilitiesIterator.Value.ToAbilityInfo.DissonanceCostPerTick}]
			}
			
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[HealthCost,${AbilitiesIterator.Value.ToAbilityInfo.HealthCost}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[PowerCost,${AbilitiesIterator.Value.ToAbilityInfo.PowerCost}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[ConcentrationCost,${AbilitiesIterator.Value.ToAbilityInfo.ConcentrationCost}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[MainIconID,${AbilitiesIterator.Value.ToAbilityInfo.MainIconID}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[HOIconID,${AbilitiesIterator.Value.ToAbilityInfo.HOIconID}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[CastingTime,${AbilitiesIterator.Value.ToAbilityInfo.CastingTime}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[RecoveryTime,${AbilitiesIterator.Value.ToAbilityInfo.RecoveryTime}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[RecastTime,${AbilitiesIterator.Value.ToAbilityInfo.RecastTime}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[HealthCostPerTick,${AbilitiesIterator.Value.ToAbilityInfo.HealthCostPerTick}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[PowerCostPerTick,${AbilitiesIterator.Value.ToAbilityInfo.PowerCostPerTick}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[DoesNotExpire,${AbilitiesIterator.Value.ToAbilityInfo.DoesNotExpire}]
			AbilitySet.FindSetting[${CurrentAbilityName}]:AddAttribute[BackDropIconID,${AbilitiesIterator.Value.ToAbilityInfo.BackDropIconID}]
				
			
            Timer:Set[0]
			;wait 2
        }
        while ${AbilitiesIterator:Next(exists)}
    }
	
	LavishSettings[AbilityCheck]:Export["${LavishScript.HomeDirectory}/scripts/RI/CombatBot/AbilityCheck/${MSC}-AbilityCheck.xml"]
	LavishSettings[AbilityCheck]:Clear
	echo ISXRI: ${Time}: Saved file: "${LavishScript.HomeDirectory}/scripts/RI/CombatBot/AbilityCheck/${MSC}-AbilityCheck.xml"
	echo ISXRI: ${Time}: Done Scanning
	if ${RestartCB}
	{
		CB End
		wait 10
		CB
	}
}
function atexit()
{
	echo ISXRI: ${Time}: Ending AbilityCheck
}