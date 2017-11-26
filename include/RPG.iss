;RPG.iss by Herculezz v1

variable bool Hush=0
variable int _count=1
variable int _count2=1
variable int _count3=1
variable int _zcount=1
variable int _displaycount=1
variable int _tooncount=1
variable(global) index:string toons
variable(global) index:bool unlocked
variable(global) index:int locktime
variable CheckZoneObject CheckZone
variable bool Ready=TRUE
variable bool BadInstance=FALSE
variable int SecondsUntilExpiration=0
variable int UnlockableTime=0
variable int InPGTimer=0
variable bool ZonedInToPG=FALSE
variable string FullCallingStatement
variable int sessions=0
variable(global) bool RPG_Var_Bool_CanInitiateSession=TRUE
variable int LastCheckedSessionTime=0
variable(global) string RPG_Var_String_CharacterSetName
variable(global) string RPG_Var_String_RPGScriptName=${Script.Filename}
variable(global) RPGObject RPGObj
variable filepath FP
variable settingsetref RPGSet
variable CountSetsObject2 CountSets
variable int BadInstanceCount=0
;unlock time 5400=1.5 hours, 10800=3hours 16200=4.5 hours 21600=6 hours
variable int vUnlockTime=10800
variable int eUnlockTime=10800

function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	;set the unlock time 5400=1.5 hours, 10800=3hours 16200=4.5 hours 21600=6 hours
	if ${Devel.Equal[TRUE]}
	{	
		;how many seconds to reset from locktime, 1 hour 15 mins
		variable int vUnlockTime=4500
		;how many seconds to take away from expiration time , 4 hours 45 mins
		variable int eUnlockTime=17100
	}
	
	if ${args[1].Upper.Equal["EXIT"]} || ${args[1].Upper.Equal["END"]}
		Script:End
		
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[CombatBot]	
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot"]
		FP:MakeSubdirectory[AbilityCheck]	
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot"]
		FP:MakeSubdirectory[Profiles]	
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[Private]	
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private"]
	if !${FP.FileExists[RICharList.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RICharList.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml" http://www.isxri.com/RICharList.xml
		wait 50
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles"]
	if !${FP.FileExists[CBProfile-skyshrineguardian.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting CBProfile-skyshrineguardian.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/Profiles/CBProfile-skyshrineguardian.xml" http://www.isxri.com/CBProfile-Default-skyshrineguardian.xml
		wait 50
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck"]
	if !${FP.FileExists[skyshrineguardian-AbilityCheck.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting skyshrineguardian-AbilityCheck.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/AbilityCheck/skyshrineguardian-AbilityCheck.xml" http://www.isxri.com/skyshrineguardian-AbilityCheck.xml
		wait 50
	}
	
	if ${args.Used}<1
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		if !${FP.PathExists}
		{
			FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
			FP:MakeSubdirectory[RI]	
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		}
		
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RPG"]
		if !${FP.PathExists}
		{
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
			FP:MakeSubdirectory[RPG]	
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RPG"]
		}
		
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		if !${FP.FileExists[RPG.xml]}
		{
			if ${Debug}
				echo ${Time}: Getting RPG.XML
			http -file "${LavishScript.HomeDirectory}/Scripts/RI/RPG.xml" http://www.isxri.com/RPG.xml
			wait 50
		}
		;load ui
		ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RPG.xml"
		wait 1
		if ${ISBoxerCharacterSet(exists)}
			UIElement[ISBCharSetTextEntry@RPG]:SetText[${ISBoxerCharacterSet}]
		UIElement[SessionNameTextEntry@RPG]:SetText[${Session}]
		RPGObj:LoadSaves
		call LoadToonList
		RPGObj:LoadCharSet
		if ${UIElement[SaveListbox@RPG].OrderedItem[1](exists)}
		{
			UIElement[SaveListbox@RPG]:SelectItem[1]
			UIElement[SaveTextEntry@RPG]:SetText[${UIElement[SaveListbox@RPG].SelectedItem.Text}]
			RPGObj:LoadList
		}
		while 1
			wait 1
	}

	;echo 1: ${args[1]} // ${args[1].Upper.Find[-CHARSET](exists)}  // ${args[1].Upper.Equal[-CHARSET]}
	;echo 2: ${args[2]}
	if ${args[1].Upper.Find[-CHARSET](exists)}
	{
		RPG_Var_String_CharacterSetName:Set[${args[2]}]
		_count:Set[3]
		_count2:Set[3]
	}
	if ${args[${_count}].Upper.Equal[-SESSION]}
	{
		;first store the entire calling statement to send to crashed clients when they return
		for(_count:Set[${_count}];${_count}<=${args.Used};_count:Inc)
		{
			;echo ${_count}: ${args[${_count}]}
			FullCallingStatement:Concat["${args[${_count}]} "]
		}
		;echo FullCallingStatement: ${FullCallingStatement}
		for(_count2:Set[${_count2}];${_count2}<=${args.Used};_count2:Inc)
		{
			_count2:Inc
			sessions:Inc
			if ${args[${_count2}].Token[1,|].Equal[${Session}]}
			{
				for(_count3:Set[2];${_count3}<=${Math.Calc[${args[${_count2}].Count[|]}+1]};_count3:Inc)
				{
					;echo Inserting ${args[${_count2}].Token[${_count3},|]}
					toons:Insert[${args[${_count2}].Token[${_count3},|]}]
					unlocked:Insert[1]
					locktime:Insert[0]
				}
			}
		}
		;echo Sessions:${sessions}
		;echo Toons: ${toons.Used}
		if ${toons.Used}==0
		{
			;echo ISXRI: I am not listed in the calling statement ending RPG
			Hush:Set[1]
			return
		}
	}
	else
	{
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			;echo Inserting ${args[${_count}]}
			toons:Insert[${args[${_count}]}]
			unlocked:Insert[1]
			locktime:Insert[0]
		}
	}
	
	echo ISXRI: Starting RPG
	
	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
	
	;buildrelaygroup
	RG
	
	;load RI_AntiAFK
	RI_AntiAFK
	
	while 1
	{
		call LoadRPG
		
		call CheckAndLoadSessions
		
		;check if any of the args list toons are unlocked or unlockable
		Ready:Set[0]
		while !${Ready}
		{
			for(_count:Set[1];${_count}<=${toons.Used};_count:Inc)
			{
				if !${Ready}
				{
					if ${locktime[${_count}]}==0 || ${unlocked[${_count}]} || ${CheckZone.Unlocked[${locktime[${_count}]}]}
					{
						;if ${locktime[${_count}]}!=0 && !${unlocked[${_count}]} && ${CheckZone.Unlocked[${locktime[${_count}]}]}
						;echo ISXRI: ${toons[${_count}]} is Unlocked
						_tooncount:Set[${_count}]
						Ready:Set[1]
						continue
					}
				}
			}
			wait 50
			if !${Ready}
			{
				echo ISXRI: ${Time}: Waiting for a toon to be unlocked
				if ${Me.InGameWorld} && !${Me.IsCamping}
					eq2ex camp login
			}
		}
		press esc
		while !${Me.Name.Find[${toons[${_tooncount}]}](exists)}
		{
			rilogin ${toons[${_tooncount}]}
			wait 1200 ${EQ2.Zoning}!=0
			wait 1800 ${EQ2.Zoning}==0
			if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
				exit
			if ${Me.GetGameData[Self.ZoneName].Label.Equal["The Underdepths [Proving Ground]"]}
			{
				Actor[Proving Grounds Portal]:DoubleClick
				wait 2
				Actor[Proving Grounds Portal]:DoubleClick
				wait 2
				Actor[Proving Grounds Portal]:DoubleClick
				ZonedInToPG:Set[FALSE]
				;waiting to zone
				wait 600 ${EQ2.Zoning}!=0
				wait 600 ${EQ2.Zoning}==0
				if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
					exit
				continue
			}
			wait 5
		}

		wait 600 ${EQ2.Zoning}==0
		if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
			exit
			
		call CheckZone.Unlock
		wait 10
		call CheckZone.Unlock
		wait 10
		call CheckZone.Unlock
		if ${Me.GetGameData[Self.ZoneName].Label.Left[15].Equal["Proving Grounds"]}
		{
			;move to portal and click
			while !${Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002](exists)}
			{
				echo ISXRI: Can not find portal please report this to Herculezz on Discord or IRC
				wait 50
			}
			if ${Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002](exists)} && ${Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002].Distance}>20
			{
				call RIMObj.Move 24.468470 0.250399 -33.332939 1 0 1 1 1 0 1 1
				call RIMObj.Move ${Math.Calc[30.294470+${Math.Calc[${Math.Rand[5]}-2]}]} 1.748314 ${Math.Calc[-41.858967+${Math.Calc[${Math.Rand[5]}-2]}]} 1 0 1 1 1 0 1 1
				call RIMObj.Move ${Math.Calc[21.264095+${Math.Calc[${Math.Rand[11]}-5]}]} 1.742121 ${Math.Calc[-60.507301+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
			wait 20
			
			if ${Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002].Distance}<20
			{
				ZonedInToPG:Set[TRUE]
				Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002]:DoubleClick
				wait 2
				Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002]:DoubleClick
				wait 2
				Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002]:DoubleClick
				wait 50 
				RIMUIObj:Door[ALL,2]
				wait 10
				if ${EQ2.Zoning}==0
					RIMUIObj:Door[ALL,2]
				;waiting to zone
				wait 600 ${EQ2.Zoning}!=0
				wait 1500 ${EQ2.Zoning}==0
				if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
					exit
			}
			else
			{
				MessageBox -skin eq2 "We were unable to get within 20m of the zone object please move us"
				while ${Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002].Distance}>20
					wait 1
				ZonedInToPG:Set[TRUE]
				Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002]:DoubleClick
				wait 2
				Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002]:DoubleClick
				wait 2
				Actor[Query, TintFlags=15477 && X=22.309999 && Y=1.740000 && Z=-68.440002]:DoubleClick
				wait 50 
				RIMUIObj:Door[ALL,2]
				wait 10
				if ${EQ2.Zoning}==0
					RIMUIObj:Door[ALL,2]
				;waiting to zone
				wait 600 ${EQ2.Zoning}!=0
				wait 1500 ${EQ2.Zoning}==0
				if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
					exit
			}
			if ${Me.GetGameData[Self.ZoneName].Label.Equal["The Underdepths [Proving Ground]"]}
			{
				wait 50
				if ${BadInstance}
				{
					BadInstance:Set[FALSE]
					Actor[Proving Grounds Portal]:DoubleClick
					wait 2
					Actor[Proving Grounds Portal]:DoubleClick
					wait 2
					Actor[Proving Grounds Portal]:DoubleClick
					;waiting to zone
					wait 600 ${EQ2.Zoning}!=0
					wait 600 ${EQ2.Zoning}==0
					if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
						exit
					continue
				}
				wait 20
				;run runinstances started and cb
				;cb
				ri
				wait 20
				RI_Var_Bool_Start:Set[TRUE]
				UIElement[Start@RI]:SetText[Pause]
				InPGTimer:Set[0]
				;wait 50
				while ${Me.GetGameData[Self.ZoneName].Label.Equal["The Underdepths [Proving Ground]"]} && ${InPGTimer:Inc}<1800
				{
					if ${Script.RunningTime}>${Math.Calc[${LastCheckedSessionTime}+30000]}
					{
						LastCheckedSessionTime:Set[${Script.RunningTime}]
						call LoadRPG
						call CheckAndLoadSessions
					}
					wait 10
				}
				if ${InPGTimer}>=1800 && ${EQ2.Zoning}==0
				{
					Script[${RI_Var_String_RunInstancesScriptName}]:End
					CB end
					wait 2
					while ${RIMUIObj.MainIconIDExists[${Me.ID},815]}
					{
						Me.Effect[Ancient Possession]:Cancel
						wait 5
					}
					eq2ex target_none
					wait 2
					eq2ex target_none
					call RIMObj.Move -0.558985 -9.788222 0.040509
					call RIMObj.Move 6.764014 -9.725281 0.068064
					wait 20
					eq2ex target_none
					wait 2
					eq2ex target_none
					Actor[Proving Grounds Portal]:DoubleClick
					wait 2
					Actor[Proving Grounds Portal]:DoubleClick
					wait 2
					Actor[Proving Grounds Portal]:DoubleClick
					ZonedInToPG:Set[FALSE]
					;waiting to zone
					wait 600 ${EQ2.Zoning}!=0
					if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
						exit
				}
				wait 600 ${EQ2.Zoning}==0
				
				wait 20
				ZonedInToPG:Set[FALSE]
				;set this indexposition timer for 90mins, then increase index
			}
		}
		wait 600 ${EQ2.Zoning}==0
		if ${EQ2.Zoning}!=0 || ( ${Zone.ID}==0 && ${Zone.Name.Equal[Unknown]} && !${Me.InGameWorld} && !${Me.AtLoginScene} )
			exit
		wait 5
		cb end
		press esc
	}
}

;checkzone object
objectdef CheckZoneObject
{
	
	;check current seconds since midnight against locktimer return true or false
	member:bool Unlocked(int SecondsSinceMidnightTheZoneWasSetAt)
	{
		;echo ${Time}: Checking ${SecondsSinceMidnightTheZoneWasSetAt}
		if ${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${vUnlockTime}]}<86400
		{
			;echo ${Time} Reset timer is not past midnight
			
			if ${Time.SecondsSinceMidnight}>${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${vUnlockTime}]}
				return TRUE
			else
				return FALSE
			;return ${Time.SecondsSinceMidnight}>${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${vUnlockTime}]}

		}
		else
		{
			;echo ${Time} Reset timer is past midnight

			if ${Time.SecondsSinceMidnight}>${vUnlockTime}
				return FALSE
			else
			{
				if ${Time.SecondsSinceMidnight}>${Math.Calc[${vUnlockTime}-(86400-${SecondsSinceMidnightTheZoneWasSetAt})]}
					return TRUE
				else
					return FALSE
			}
		}
	}
	;check current seconds since midnight against locktimer return true or false
	member:int TimeUntilUnlocked(int SecondsSinceMidnightTheZoneWasSetAt)
	{
		;echo ${Time}: Checking ${SecondsSinceMidnightTheZoneWasSetAt}
		if ${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${vUnlockTime}]}<86400
		{
			;echo ${Time} Reset timer is not past midnight
			return ${Math.Calc[(${SecondsSinceMidnightTheZoneWasSetAt}+${vUnlockTime})-${Time.SecondsSinceMidnight}]}
		}
		else
		{
			;echo ${Time} Reset timer is past midnight
			
			return ${Math.Calc[(86400-${Time.SecondsSinceMidnight})+${SecondsSinceMidnightTheZoneWasSetAt}]}
		}
	}
	;check current seconds since midnight against locktimer return true or false, this function is not working need to add debug and zone in and out a few times seeing what is going on
	member:int UnlockTime(string _InstanceMessage)
	{
		if ${_InstanceMessage.Find[This instance will expire in ](exists)}
		{
			if ${_InstanceMessage.Find[hour](exists)}
				SecondsUntilExpiration:Set[${Math.Calc[${Int[${_InstanceMessage.Right[${Math.Calc[-1*(${_InstanceMessage.Find[hour]}-3)]}].Left[1]}]}*3600]}]
			else
				SecondsUntilExpiration:Set[0]
			SecondsUntilExpiration:Set[${Math.Calc[${SecondsUntilExpiration}+${Math.Calc[${Int[${_InstanceMessage.Right[${Math.Calc[-1*(${_InstanceMessage.Find[minutes]}-4)]}].Left[2].Replace[" ",""]}]}*60]}]}]
						
			return ${Int[${Math.Calc[${SecondsUntilExpiration}-(${eUnlockTime})]}]}
		}
	}
	;open then close the zone timers window then, unlock zone ZoneName, 
	;wait 5 seconds or until confirmation is seen
	function Unlock()
	{	
		;echo ${Time}: Unlocking The Underdepths [Proving Ground] for ${toons[${_tooncount}]}
		eq2ex togglezonereuse
		wait 5
		eq2ex togglezonereuse
		wait 5
		Me:ResetZoneTimer["Proving Grounds: The Underdepths"]
		wait 2
		;wait 20 ${ResetConfirmation}
		;ResetConfirmation:Set[FALSE]
	}
}
function LoadRPG()
{
	;send out the calling statement in case any toons had reloaded
	relay all rpg -CHARSET "${RPG_Var_String_CharacterSetName}" ${FullCallingStatement}
}
function CheckAndLoadSessions()
{
	;echo ( ( ${Sessions}<${Int[${Math.Calc[${sessions}-1]}]} && ${sessions}<=${ISBoxerSlots} ) || ( ${Sessions}<${Int[${Math.Calc[${ISBoxerSlots}-1]}]} && ${sessions}>${ISBoxerSlots} ) ) && ${RPG_Var_Bool_CanInitiateSession}
	if ( ( ${Sessions}<${Int[${Math.Calc[${sessions}-1]}]} && ${sessions}<=${ISBoxerSlots} ) || ( ${Sessions}<${Int[${Math.Calc[${ISBoxerSlots}-1]}]} && ${sessions}>${ISBoxerSlots} ) ) && ${RPG_Var_Bool_CanInitiateSession}
	{
		relay all RPG_Var_Bool_CanInitiateSession:Set[0]
		TimedCommand 3000 relay all RPG_Var_Bool_CanInitiateSession:Set[1]
		;call to reload the entire character set, then tell everyone not to do this for 5 minutes
		squelch osexecute "${LavishScript.HomeDirectory}/InnerSpace.exe" run isboxer -launch "${RPG_Var_String_CharacterSetName}"
		TimedCommand 50 relay all rg
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;check Text for BadInstance
	if ${ZonedInToPG}
	{
		if ${Text.Find["This instance will expire in "](exists)} && !${Text.Find["125 days 6 hours"](exists)} && !${Text.Find["6 hours"](exists)}
		{
			UnlockableTime:Set[${CheckZone.UnlockTime[${Text}]}]
			;UnlockableTime:Set[${CheckZone.UnlockTime[${Text.Left[29]}${Text.Right[-37]}]}]
			;echo UnlockableTime: ${UnlockableTime}
			if ${UnlockableTime}<1 || ${BadInstanceCount}<1
			{
				echo ISXRI: It Seems we did not unlock, zoning out and trying again
				BadInstanceCount:Inc
				BadInstance:Set[TRUE]
			}
			else
			{
				;echo ${Math.Calc[${Time.SecondsSinceMidnight}+${UnlockableTime}]}>86400
				if ${Math.Calc[${Time.SecondsSinceMidnight}-(${vUnlockTime}-${UnlockableTime})]}>0
					locktime[${_tooncount}]:Set[${Math.Calc[${Time.SecondsSinceMidnight}-(${vUnlockTime}-${UnlockableTime})]}]
				else
					locktime[${_tooncount}]:Set[${Math.Calc[86400-${Time.SecondsSinceMidnight}-(${vUnlockTime}-${UnlockableTime})]}]
				unlocked[${_tooncount}]:Set[0]
				echo ISXRI: ${toons[${_tooncount}]} is Locked, Setting their locktimer to ${locktime[${_tooncount}]} seconds since midnight and zoning out, resetable in ${Math.Calc[${CheckZone.TimeUntilUnlocked[${locktime[${_tooncount}}]}]}/60]} minutes
				;${locktime[${_tooncount}]}  //  ${Math.Calc[(${locktime[${_tooncount}]}-${Time.SecondsSinceMidnight})/60]}
				BadInstance:Set[TRUE]
				BadInstanceCount:Set[0]
			}
		}
		elseif ${Text.Find["This instance will expire in 6 hours"](exists)}
		{
			BadInstanceCount:Set[0]
		}
	}
	;check Text for Zone timer confirmation message
   	if ${Text.Find["Your zone reuse timer for The Underdepths [Proving Ground] has been set"](exists)}
	{
		echo ${Time}: Setting ${toons[${_tooncount}]}'s zone reuse timer for The Underdepths [Proving Ground] to: ${Time.SecondsSinceMidnight} Seconds since midnight
		locktime[${_tooncount}]:Set[${Time.SecondsSinceMidnight}]
		unlocked[${_tooncount}]:Set[0]
	}
	;check Text for Zone reset timer confirmation message
   	if ${Text.Find["You reset your entrance timer for The Underdepths [Proving Ground]"](exists)}
	{
		ResetConfirmation:Set[TRUE]
		echo ${Time}: Succesfully Reset The Underdepths [Proving Ground] for ${toons[${_tooncount}]}
		locktime[${_tooncount}]:Set[0]
		unlocked[${_tooncount}]:Set[TRUE]

	}
}
atom EQ2_onRewardWindowAppeared()
{
	TimedCommand 20 RewardWindow:Receive
}
atom(global) RPG(string what)
{
	if ${what.Upper.Equal[EXIT]} || ${what.Upper.Equal[END]}
		Hush:Set[1];Script:End
	if ${what.Upper.Equal[DISPLAYTOONS]}
	{
		echo ISXRI: Total Toons: ${toons.Used}
		for(_displaycount:Set[1];${_displaycount}<=${toons.Used};_displaycount:Inc)
		{
			echo ISXRI: Toon ${_displaycount}: ${toons[${_displaycount}]} | Locked: ${unlocked[${_displaycount}]} | Locktime: ${locktime[${_displaycount}]} seconds since midnight, which is in ${Math.Calc[${CheckZone.TimeUntilUnlocked[${locktime[${_displaycount}]}]}/60]} minutes
		}
		echo ISXRI: Current toon #${_tooncount}: ${toons[${_tooncount}]}
	}
}
function LoadToonList()
{
	variable CountSetsObject CountSets2
	variable int numSets
	LavishSettings[RPG]:Clear
	LavishSettings:AddSet[RPG]
	LavishSettings[RPG]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
	variable settingsetref Set2
	Set2:Set[${LavishSettings[RPG].GUID}]
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
	CountSets2:PopulateToons[${Set2}]
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
			if ${RI_Var_Bool_RILoginDebug}
			{
				echo strSets[${csoCount}]:Set[${Iterator.Key}]
			}
		}
		while ${Iterator:Next(exists)}
		return ${csoCount}
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
				UIElement[ToonsAvailListbox@RPG]:AddItem[${Iterator.Key}]
			}
			while ${Iterator:Next(exists)}
		}
	}
}
objectdef RPGObject
{
	method AddedSessionsListboxDoubleLeftClick()
	{
		if ${UIElement[AddedSessionsListbox@RPG].SelectedItem(exists)}
		{
			if ${UIElement[AddedSessionsListbox@RPG].SelectedItem.TextColor}==-10263709
				UIElement[AddedSessionsListbox@RPG].SelectedItem:SetTextColor[FFF9F099]
			else
				UIElement[AddedSessionsListbox@RPG].SelectedItem:SetTextColor[FF636363]
			UIElement[AddedSessionsListbox@RPG]:ClearSelection
		}
	}
	method AddedSessionsListboxLeftClick()
	{
		if ${UIElement[AddedSessionsListbox@RPG].SelectedItem.ID(exists)}
		{
			UIElement[SessionNameTextEntry@RPG]:SetText[${UIElement[AddedSessionsListbox@RPG].SelectedItem.Text.Token[1,|]}]
			UIElement[AddedToonsListbox@RPG]:ClearItems
			UIElement[ToonsAvailListbox@RPG]:ClearSelection
			variable int i=0
			for(i:Set[2];${i}<=${Math.Calc[${UIElement[AddedSessionsListbox@RPG].SelectedItem.Text.Count[|]}+1]};i:Inc)
			{
				UIElement[AddedToonsListbox@RPG]:AddItem[${UIElement[AddedSessionsListbox@RPG].SelectedItem.Text.Token[${i},|]}]
			}
		}
		else
		{
			UIElement[SessionNameTextEntry@RPG]:SetText[${Session}]
			UIElement[AddedToonsListbox@RPG]:ClearItems
			UIElement[ToonsAvailListbox@RPG]:ClearSelection
		}
	}
	method Start()
	{
		if ${UIElement[AddedSessionsListbox@RPG].Items}>0 && ${UIElement[ISBCharSetTextEntry@RPG].Text.NotEqual[NULL]}
		{
			variable int i=0
			variable string CallingStatement="-session "
			for(i:Set[1];${i}<=${UIElement[AddedSessionsListbox@RPG].Items};i:Inc)
			{
				if ${UIElement[AddedSessionsListbox@RPG].OrderedItem[${i}].TextColor}!=-10263709
				{
					if ${i}<${UIElement[AddedSessionsListbox@RPG].Items}
						CallingStatement:Concat["${UIElement[AddedSessionsListbox@RPG].Item[${i}].Text} -session "]
					else
						CallingStatement:Concat[${UIElement[AddedSessionsListbox@RPG].Item[${i}].Text}]
				}
			}
			TimedCommand 2 rpg -CHARSET \"${UIElement[ISBCharSetTextEntry@RPG].Text}\" ${CallingStatement}
			Script:End
		}
	}
	method AddToon(string _ToonName)
	{
		;echo ${_ToonName}
		if ${_ToonName.NotEqual[NULL]} && ${_ToonName.NotEqual[""]}
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedToonsListbox@RPG].Items};i:Inc)
			{
				if ${UIElement[AddedToonsListbox@RPG].Item[${i}].Text.Equal[${_ToonName}]}
					UIElement[AddedToonsListbox@RPG]:RemoveItem[${UIElement[AddedToonsListbox@RPG].Item[${i}].ID}]
			}
			UIElement[AddedToonsListbox@RPG]:AddItem[${_ToonName}]
			UIElement[ToonsAvailListbox@RPG]:ClearSelection
		}
	}
	method AddSession(string _SessionName)
	{
		;echo ${_ToonName}
		if ${_SessionName.NotEqual[NULL]} && ${_SessionName.NotEqual[""]} && ${UIElement[AddedToonsListbox@RPG].Items}>0
		{
			variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedSessionsListbox@RPG].Items};i:Inc)
			{
				if ${UIElement[AddedSessionsListbox@RPG].Item[${i}].Text.Token[1,|].Equal[${_SessionName}]}
					UIElement[AddedSessionsListbox@RPG]:RemoveItem[${UIElement[AddedSessionsListbox@RPG].Item[${i}].ID}]
			}
			
			variable string SessionString="${_SessionName}|"
			for(i:Set[1];${i}<=${UIElement[AddedToonsListbox@RPG].Items};i:Inc)
			{
				if ${i}<${UIElement[AddedToonsListbox@RPG].Items}
					SessionString:Concat[${UIElement[AddedToonsListbox@RPG].OrderedItem[${i}].Text}|]
				else
					SessionString:Concat[${UIElement[AddedToonsListbox@RPG].OrderedItem[${i}].Text}]
			}
			
			UIElement[AddedSessionsListbox@RPG]:AddItem[${SessionString}]
			UIElement[AddedToonsListbox@RPG]:ClearItems
			UIElement[SessionNameTextEntry@RPG]:SetText[is${Int[${Math.Calc[${UIElement[AddedSessionsListbox@RPG].Items}+1]}]}]
		}
	}
	
	method LoadSaves()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RPG/"]
		if ${FP.FileExists[RPGSave.xml]}
		{
			LavishSettings[RPG]:Clear
			LavishSettings:AddSet[RPG]
			LavishSettings[RPG]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RPG/RPGSave.xml"]
			RPGSet:Set[${LavishSettings[RPG].GUID}]
			CountSets:IterateSets[${RPGSet}]
		}
	}
	method LoadCharSet()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RPG/"]
		if ${FP.FileExists[RPGSave.xml]}
		{
			LavishSettings[RPG]:Clear
			LavishSettings:AddSet[RPG]
			LavishSettings[RPG]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RPG/RPGSave.xml"]
			RPGSet:Set[${LavishSettings[RPG].GUID}]
			;CountSets:IterateSets[${RPGSet}]
			;echo ${RPGSet.FindSetting[ISBCharSetTextEntry]}
			UIElement[ISBCharSetTextEntry@RPG]:SetText[${RPGSet.FindSetting[ISBCharSetTextEntry]}]
		}
	}
	method SaveClick()
	{
		if ${UIElement[SaveListbox@RPG].SelectedItem(exists)}
			UIElement[SaveTextEntry@RPG]:SetText[${UIElement[SaveListbox@RPG].SelectedItem.Text}]
	}
	method LoadList()
	{
		if ${UIElement[SaveTextEntry@RPG].Text.NotEqual[""]}
		{
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RPG/"]
			if ${FP.FileExists[RPGSave.xml]}
			{
				LavishSettings[RPG]:Clear
				LavishSettings:AddSet[RPG]
				LavishSettings[RPG]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RPG/RPGSave.xml"]
				RPGSet:Set[${LavishSettings[RPG].GUID}]

				;CountSets:IterateSets[${RPGSet}]
				;CountSets:EchoSets
				;CountSets:PopulateSets
				;import AnnounceSet
				variable settingsetref LoadListSet=${RPGSet.FindSet[${UIElement[SaveTextEntry@RPG].Text}].GUID}
				LoadListSet:Set[${RPGSet.FindSet[${UIElement[SaveTextEntry@RPG].Text}].GUID}]
				variable int LoadListCount=${CountSets.Count[${LoadListSet}]}
				LoadListCount:Set[${CountSets.Count[${LoadListSet}]}]
				
				if ${LoadListCount}>0
				{
					UIElement[SaveTextEntry@RPG]:SetText[""]
					UIElement[SaveListbox@RPG]:ClearSelection
					CountSets:IterateSettings[${LoadListSet},${LoadListCount}]
				}
			}
		}
	}
	method SaveList(bool _Delete=FALSE)
	{
		;echo ${UIElement[SaveTextEntry@RPG].Text.NotEqual[""]} && ( ${UIElement[AddedSessionsListbox@RPG].Items}>0 || ${_Delete} )
		if ${UIElement[SaveTextEntry@RPG].Text.NotEqual[""]} && ( ${UIElement[AddedSessionsListbox@RPG].Items}>0 || ${_Delete} )
		{
			;echo ISXRI Saving RPGList: RPGSave.xml
			variable string SetName
			SetName:Set[${UIElement[SaveTextEntry@RPG].Text}]
			LavishSettings[RPGSaveFile]:Clear
			LavishSettings:AddSet[RPGSaveFile]
			LavishSettings[RPGSaveFile]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RPG/RPGSave.xml"]
			LavishSettings[RPGSaveFile]:AddSetting[ISBCharSetTextEntry,${UIElement[ISBCharSetTextEntry@RPG].Text}]
			LavishSettings[RPGSaveFile]:AddSet[${SetName}]
			LavishSettings[RPGSaveFile].FindSet[${SetName}]:Clear
			variable int count=0
			
			for(count:Set[1];${count}<=${UIElement[AddedSessionsListbox@RPG].Items};count:Inc)
			{
				LavishSettings[RPGSaveFile].FindSet[${SetName}]:AddSet[${count}]
				LavishSettings[RPGSaveFile].FindSet[${SetName}].FindSet[${count}]:AddSetting[Session,${UIElement[AddedSessionsListbox@RPG].OrderedItem[${count}].Text}]
			}
			LavishSettings[RPGSaveFile]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RPG/RPGSave.xml"]
			if !${_Delete}
				UIElement[SaveListbox@RPG]:AddItem[${UIElement[SaveTextEntry@RPG].Text}]
			UIElement[SaveTextEntry@RPG]:SetText[""]
			;echo here
		}
	}
	method DeleteList()
	{
		if ${UIElement[SaveListbox@RPG].SelectedItem(exists)}
		{
			UIElement[AddedSessionsListbox@RPG]:ClearItems
			This:SaveList[TRUE]
			UIElement[SaveListbox@RPG]:RemoveItem[${UIElement[SaveListbox@RPG].SelectedItem.ID}]
			UIElement[SaveTextEntry@RPG]:SetText[""]
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
		UIElement[AddedSessionsListbox@RPG]:ClearItems
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
					UIElement[AddedSessionsListbox@RPG]:AddItem[${SettingIterator.Value}]
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
			UIElement[SaveListbox@RPG]:AddItem[${Iterator.Key}]
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
				UIElement[ToonsAvailListbox@RPG]:AddItem[${Iterator.Key}]
			}
			while ${Iterator:Next(exists)}
		}
	}
}
atom(global) RPG(string what)
{
	if ${what.Upper.Equal[EXIT]} || ${what.Upper.Equal[END]}
		Hush:Set[0];Script:End
	if ${what.Upper.Equal[DISPLAYTOONS]}
	{
		echo ISXRI: Total Toons: ${toons.Used}
		for(_displaycount:Set[1];${_displaycount}<=${toons.Used};_displaycount:Inc)
		{
			echo ISXRI: Toon ${_displaycount}: ${toons[${_displaycount}]} | Locked: ${unlocked[${_displaycount}]} | Locktime: ${locktime[${_displaycount}]} seconds since midnight, which is unlockable at ${Math.Calc[${locktime[${_displaycount}]}+5400]} seconds since midnight which is in ${Math.Calc[(${CheckZone.TimeUntilUnlocked[${locktime[${_displaycount}]}]})/60]} minutes
		}
		echo ISXRI: Current toon #${_tooncount}: ${toons[${_tooncount}]}
	}
}
function atexit()
{
	if !${Hush}
		echo ISXRI: Ending RPG
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RPG.xml"
}
