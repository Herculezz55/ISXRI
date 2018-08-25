;RunZones v6 by Herculezz

;v2 changes
;	changed relay all to relay ${RI_Var_String_RelayGroup}
;	added anti afk code to while loop when waiting for zone.
;	added check for This instance will expire in 0.0 seconds
;		also added back up check for 
;			You may not enter an instance created prior to when your previous instance's minimum lockout timer expired
; 	changed zoning time out to 10 minutes
;	added exclusions
;	added BSB Zones
;	added FSD Zones
;
;v3 changes
;	added SSRA Zones
;
;v4 changes
;	added Ossuary Zones
;
;v5 changes
;	added UI
;
;v6 changes
;	Removed 3 zone restrictions
;

variable(global) bool RZ_Var_Bool_Start=FALSE
variable(global) bool RZ_Var_Bool_Paused=FALSE
variable(global) string RZ_Var_String_ZoneSet=""
variable string Zone1
variable string Zone1Exit
variable int Zone1PopupSelection
variable bool Zone1MoveToExit
variable float Zone1MoveToExitLocX
variable float Zone1MoveToExitLocZ
variable string Zone2
variable string Zone2Exit
variable int Zone2PopupSelection
variable bool Zone2MoveToExit
variable float Zone2MoveToExitLocX
variable float Zone2MoveToExitLocZ
variable string Zone3
variable string Zone3Exit
variable int Zone3PopupSelection
variable bool Zone3MoveToExit
variable float Zone3MoveToExitLocX
variable float Zone3MoveToExitLocZ
variable string Zone4
variable string Zone4Exit
variable int Zone4PopupSelection
variable bool Zone4MoveToExit
variable float Zone4MoveToExitLocX
variable float Zone4MoveToExitLocZ
variable string ZoneEntrance
variable string ZoneEntrance2=NONE
variable bool ZoneEntranceMoveToZone
variable float ZoneEntranceMoveToZoneLocX
variable float ZoneEntranceMoveToZoneLocZ
variable bool MalduraZone=FALSE

variable(global) bool RZ_Var_Bool_Zone1Unlocked=TRUE
variable(global) bool RZ_Var_Bool_Zone2Unlocked=TRUE
variable(global) bool RZ_Var_Bool_Zone3Unlocked=TRUE
variable bool ResetConfirmation=FALSE
variable(global) int RZ_Var_Int_Zone1SetTime=0
variable(global) int RZ_Var_Int_Zone2SetTime=0
variable(global) int RZ_Var_Int_Zone3SetTime=0
variable CheckZoneObject CheckZone
variable bool RecentlyAntiAFK=FALSE
variable bool UnableToZone=FALSE
variable bool InstanceExpired=FALSE
variable(global) bool RZ_Var_Bool_ExcludeZone1=FALSE
variable(global) bool RZ_Var_Bool_ExcludeZone2=FALSE
variable(global) bool RZ_Var_Bool_ExcludeZone3=FALSE
variable bool DontEchoExit=FALSE
variable bool Developer=FALSE
variable bool 6HourZones=FALSE
variable int MainArrayCounter
variable index:string istrMain
variable bool Others=FALSE
variable bool StartRZ=TRUE
variable bool Experts=FALSE
variable string ExpertsSummonOption=0
function PreGo(string _EXTVar)
{
	echo ISXRI: ${Time} Importing ZoneFile from Extension
	istrMain:Clear
	for(MainArrayCounter:Set[0];${MainArrayCounter}<${${_EXTVar}[#]};MainArrayCounter:Inc)
		istrMain:Insert[${${_EXTVar}[${MainArrayCounter}]}]
	echo ISXRI: ${Time} Done Importing ZoneFile from Extension, to Load from File type ImportZoneFile filename.dat (omitting filename.dat, will attempt to load WriteLocs default file for the zone)
}
atom ImportZoneFile(string _Zone)
{
	istrMain:Clear
	switch ${_Zone.Upper}
	{
		case KAESORA
		{
			istrMain:Insert[182.646912 -118.825867 -160.124619]
			istrMain:Insert[179.241959 -69.218857 -166.021149]
			istrMain:Insert[153.935852 -32.875347 -189.627106]
			istrMain:Insert[128.791473 -3.191060 -221.428726]
			istrMain:Insert[100.991234 9.898625 -260.874969]
			istrMain:Insert[77.417007 38.798981 -294.364716]
			istrMain:Insert[57.918842 72.666298 -325.754364]
			istrMain:Insert[33.129749 85.940758 -367.369965]
			istrMain:Insert[8.482460 84.029160 -410.859833]
			istrMain:Insert[-16.213810 82.113777 -454.436249]
			istrMain:Insert[-40.988400 80.192314 -498.150726]
			istrMain:Insert[-65.792084 79.986656 -541.922791]
			istrMain:Insert[-90.601685 79.981827 -585.705811]
			istrMain:Insert[-115.372040 79.976974 -629.420044]
			istrMain:Insert[-140.171539 79.972107 -673.186035]
			istrMain:Insert[-153.889053 79.971298 -721.278931]
			istrMain:Insert[-160.984756 79.971298 -770.932922]
			istrMain:Insert[-165.737854 79.971298 -820.895264]
			istrMain:Insert[-163.740234 79.971298 -870.865356]
			istrMain:Insert[-147.752213 79.971298 -918.431152]
			istrMain:Insert[-111.120026 79.971298 -952.905151]
			istrMain:Insert[-71.941132 79.971298 -984.434265]
			istrMain:Insert[-32.652782 79.971298 -1015.369690]
			istrMain:Insert[6.776206 79.971298 -1046.416016]
			istrMain:Insert[46.205173 79.971298 -1077.461792]
			istrMain:Insert[85.649773 79.971298 -1108.519775]
			istrMain:Insert[125.063194 79.971298 -1139.554688]
			istrMain:Insert[164.538986 79.971298 -1170.640015]
			istrMain:Insert[203.999161 79.971298 -1201.712646]
			istrMain:Insert[244.139832 79.971298 -1231.965698]
			istrMain:Insert[293.355682 71.552437 -1235.383301]
			istrMain:Insert[304.826630 67.772789 -1236.646606]
			istrMain:Insert[333.782623 58.869308 -1271.929810]
			istrMain:Insert[348.353668 39.361343 -1291.254028]
			istrMain:Insert[346.567902 29.337437 -1293.531494]
			istrMain:Insert[346.108856 27.366489 -1296.947632]
			istrMain:Insert[344.858917 20.766964 -1306.249268]
			break
		}
		case TORSIS
		{
			istrMain:Insert[-150.956680 1.861307 -83.695122]
			istrMain:Insert[-150.956680 51.874031 -83.695122]
			istrMain:Insert[-163.266052 88.654266 -115.475006]
			istrMain:Insert[-199.693329 118.839531 -132.713516]
			istrMain:Insert[-243.483093 140.658600 -143.670242]
			istrMain:Insert[-291.082855 152.911957 -153.506317]
			istrMain:Insert[-339.985962 152.329498 -164.174484]
			istrMain:Insert[-389.480255 149.825272 -171.241867]
			istrMain:Insert[-439.466370 145.484055 -174.356110]
			istrMain:Insert[-489.433289 141.144394 -177.469299]
			istrMain:Insert[-539.226257 136.819962 -180.571548]
			istrMain:Insert[-588.951599 130.803757 -181.668411]
			istrMain:Insert[-639.019592 126.609009 -182.495941]
			istrMain:Insert[-682.004028 121.373619 -207.632996]
			istrMain:Insert[-651.817444 143.486694 -241.087753]
			istrMain:Insert[-620.946716 149.481186 -280.182465]
			istrMain:Insert[-589.991638 155.491989 -319.383636]
			istrMain:Insert[-560.419922 165.292313 -358.874908]
			istrMain:Insert[-531.559143 176.890060 -398.267517]
			istrMain:Insert[-500.165710 200.711472 -429.188904]
			istrMain:Insert[-457.458344 204.695633 -454.975281]
			istrMain:Insert[-426.471802 206.903778 -494.389435]
			istrMain:Insert[-399.208008 209.399506 -536.656372]
			istrMain:Insert[-376.765961 210.956985 -581.721436]
			istrMain:Insert[-354.618652 218.560425 -626.193359]
			istrMain:Insert[-332.236938 220.113708 -671.135681]
			istrMain:Insert[-309.942322 221.660995 -715.904541]
			istrMain:Insert[-292.068970 226.514740 -762.486084]
			istrMain:Insert[-278.808014 217.939651 -810.153992]
			istrMain:Insert[-270.115906 206.891266 -858.195923]
			istrMain:Insert[-261.378937 196.103088 -906.486572]
			istrMain:Insert[-252.452805 195.569687 -955.822449]
			istrMain:Insert[-249.393219 189.447571 -1005.751709]
			istrMain:Insert[-252.950043 188.635956 -1055.675415]
			istrMain:Insert[-254.702957 188.634933 -1105.838379]
			istrMain:Insert[-257.967285 163.436356 -1149.255005]
			istrMain:Insert[-257.893005 152.357834 -1169.341431]
			break
		}
		case SPIRE
		{
			break
		}
		case DALNIR
		{
			istrMain:Insert[-208.259216 90.546265 -171.838242]
			istrMain:Insert[-192.281799 117.245171 -178.418533]
			istrMain:Insert[-145.389725 117.245171 -195.804733]
			istrMain:Insert[-98.344231 117.245171 -213.247787]
			istrMain:Insert[-51.386753 117.245171 -230.658188]
			istrMain:Insert[-4.130384 117.245171 -248.179428]
			istrMain:Insert[42.879860 117.245171 -265.609009]
			istrMain:Insert[89.960487 117.245171 -283.064880]
			istrMain:Insert[135.972824 117.245171 -302.680634]
			istrMain:Insert[181.804108 117.245171 -323.377563]
			istrMain:Insert[227.566986 117.245171 -344.042694]
			istrMain:Insert[273.398132 117.245171 -364.739166]
			istrMain:Insert[319.109344 117.245171 -385.381165]
			istrMain:Insert[364.939758 117.245171 -406.077881]
			istrMain:Insert[410.695251 117.245171 -426.740875]
			istrMain:Insert[456.320190 117.245171 -447.345032]
			istrMain:Insert[500.079712 108.536240 -469.953583]
			istrMain:Insert[537.549561 85.659111 -494.129913]
			istrMain:Insert[575.102966 62.730656 -518.360474]
			istrMain:Insert[612.586243 39.844955 -542.545593]
			istrMain:Insert[649.985535 17.010588 -566.676514]
			istrMain:Insert[681.166870 -18.416731 -583.256104]
			istrMain:Insert[705.750671 -60.858173 -593.075928]
			istrMain:Insert[731.091370 -103.702263 -597.811401]
			istrMain:Insert[759.797729 -129.857666 -594.005249]
			istrMain:Insert[774.813354 -129.350403 -588.724670]
			istrMain:Insert[792.112061 -129.383835 -583.020386]
			break
		}
	}
}
function StartR(string _r)
{
	relay all -noredirect RG
	wait 20
	relay "other ${RI_Var_String_RelayGroup}" rzo -${_r} -others
}
function RunK()
{
	if !${Others}
		call StartR rk

	; if ${KaesoraEntrance[1](exists)}
		; call PreGo "KaesoraEntrance"
	; else
		; ImportZoneFile "KaesoraEntrance.dat"
	ImportZoneFile KAESORA
	
	call CheckNearStart "Fens of Nathsar"
	
	if ${Others}
		Script:End
		
	variable bool _AllHere
	_AllHere:Set[FALSE]
	
	variable int _count
	while !${_AllHere}
	{
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		wait 2
	}
	wait 10

	call follow

	wait 20

	;echo ${istrMain.Used}
	for(_count:Set[1];${_count}<=${istrMain.Used};_count:Inc)
	{
		;echo ${_count}: call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		
		waitframe
	}
	call Move ${istrMain.Get[${istrMain.Used}]} 2 0 1 1 1 0

	wait 20 

	call FlyDown

	Script:End
}
function RunL()
{
	if !${Others}
		call StartR rl

	; if ${KaesoraEntrance[1](exists)}
		; call PreGo "TorsisEntrance"
	; else
		; ImportZoneFile "TorsisEntrance.dat"
		
	ImportZoneFile TORSIS
	
	call CheckNearStart "Kunzar Jungle" 0 3
	
	if ${Others}
		Script:End
	
	variable bool _AllHere
	_AllHere:Set[FALSE]
	
	variable int _count
	while !${_AllHere}
	{
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		wait 2
	}
	wait 10

	call follow

	wait 20

	;echo ${istrMain.Used}
	for(_count:Set[1];${_count}<=${istrMain.Used};_count:Inc)
	{
		;echo ${_count}: call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		
		waitframe
	}
	call Move ${istrMain.Get[${istrMain.Used}]} 2 0 1 1 1 0

	wait 20 

	call FlyDown

	Script:End
}
function RunC()
{
	if !${Others}
		call StartR rc

	; if ${DalnirEntrance[1](exists)}
		; call PreGo "DalnirEntrance"
	; else
		; ImportZoneFile "DalnirEntrance.dat"
	
	ImportZoneFile DALNIR
	
	call CheckNearStart "Obulus Frontier" 0 4
	
	if ${Others}
		Script:End
		
	variable bool _AllHere
	_AllHere:Set[FALSE]
	
	variable int _count
	while !${_AllHere}
	{
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		wait 2
	}
	wait 10

	call follow

	wait 20

	;echo ${istrMain.Used}
	for(_count:Set[1];${_count}<=${istrMain.Used};_count:Inc)
	{
		;echo ${_count}: call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		call Move ${istrMain.Get[${_count}]} 2 0 1 1 1 1
		
		waitframe
	}
	call Move ${istrMain.Get[${istrMain.Used}]} 2 0 1 1 1 0

	wait 20 

	call FlyDown

	Script:End
}
function RunA()
{
	if !${Others}
		call StartR ra

	; if ${DalnirEntrance[1](exists)}
		; call PreGo "DalnirEntrance"
	; else
		; ImportZoneFile "DalnirEntrance.dat"
	
	call CheckNearStart "Obulus Frontier" 0 4
	
	variable bool _AllHere
	_AllHere:Set[FALSE]
	
	variable int _count
	while !${_AllHere}
	{
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		wait 2
	}
	wait 50
	Actor["Teleportation to Thalumbra"]:DoubleClick
	wait 2
	Actor["Teleportation to Thalumbra"]:DoubleClick
	wait 2
	Actor["Teleportation to Thalumbra"]:DoubleClick
	
	if ${Others}
		Script:End
	
	wait 600 ${EQ2.Zoning}!=0
	wait 600 ${EQ2.Zoning}==0
	wait 50
	
	_AllHere:Set[FALSE]
	
	while !${_AllHere}
	{
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		wait 2
	}
	wait 10

	call follow

	wait 20

	call Move -64.222878 14.077106 165.971741 2 0 1 1 1 0

	Script:End
}
function CheckNearStart(string _ZoneToZoneName, int _ZoneOption=0, int _BellWizardDruid=1)
{
	if ${Math.Distance[${Me.Loc},${istrMain.Get[1].Replace[" ",","]}]}>50 
;|| ${EQ2.CheckCollision[${Me.Loc},${istrMain.Get[1].Replace[" ",","]}]}
	{
		call RIMObj.CallToGuildHall 0
		if !${Actor[Query, Name=="Ole Salt's Mariner Bell" && Distance<=13](exists)} && !${Actor[Query, Name=="Navigator's Globe of Norrath" && Distance<=13](exists)} && !${Actor[Query, Name=="Pirate Captain's Helmsman" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
		{
			MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Travel Bell within 13"
			Script:End
		}
		if ${_BellWizardDruid}==4
		{
			Actor["Cae'Dal Star"]:DoubleClick
			wait 2
			Actor["Cae'Dal Star"]:DoubleClick
			wait 2
			Actor["Cae'Dal Star"]:DoubleClick
			wait 50
			RIMUIObj:Door[ALL,0]
			wait 600 ${EQ2.Zoning}!=0
			wait 600 ${EQ2.Zoning}==0
			wait 50
		}
		else
			call RIMObj.TravelMap "${_ZoneToZoneName}" ${_ZoneOption} ${_BellWizardDruid}

		;move to QuestGiver, check which dock we are on first
		if !${Zone.Name.Find[${_ZoneToZoneName}](exists)}
		{
			MessageBox -skin eq2 "We were unable to succesfully zone to ${_ZoneToZoneName}, please try again or zone there manually"
			Script:End
		}
	}
}

atom(global) displayindex()
{
	variable int counter
	for(counter:Set[1];${counter}<=${istrMain.Used};counter:Inc)
	{
		echo ${counter}: ${istrMain.Get[${counter}]}
	}
}
function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	;if ${Devel.Equal[TRUE]}
	Developer:Set[TRUE]
	
	variable int ArgCount=1
	variable bool RunK=FALSE
	variable bool RunC=FALSE
	variable bool RunL=FALSE
	variable bool RunA=FALSE
	while ${ArgCount} <= ${args.Used}
	{
		switch ${args[${ArgCount}]}
		{
			case -rk
				RunK:Set[TRUE]
				break
			case -rc
				RunC:Set[TRUE]
				break
			case -rl
				RunL:Set[TRUE]
				break
			case -ra
				RunA:Set[TRUE]
				break
			case -others
				Others:Set[TRUE]
				break
			default
				break
		}
		ArgCount:Inc
	}
	if ${RunK}
		call RunK
	if ${RunC}
		call RunC
	if ${RunL}
		call RunL		
	if ${RunA}
		call RunA
	;echo ${Zones} // ${Exclusions} // ${JustZone} // ${ZoneExitActorName} // ${ZoneName}
	if ${JustZone}
	{
		echo Zoning Out of "${ZoneName}" using "${ZoneExitActorName}"
		call ZoneOut "${ZoneExitActorName}" "${ZoneName}"
		DontEchoExit:Set[TRUE]
		Script:End
		;echo done zoning out
	}

	echo ${Time}: Starting RZ v4
	
	;load ui
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RZo.xml"
	
	;set zones checked
	UIElement[RunZ1@RZo]:SetChecked
	UIElement[RunZ2@RZo]:SetChecked
	UIElement[RunZ3@RZo]:SetChecked
	UIElement[RZo]:SetHeight[160]
	
	;start RIMovement if it is not running
	relay all -noredirect ${If[!${Script[Buffer:RIMovement](exists)},RIMovement,noop]}
	
	;wait until start is pushed
	while !${RZ_Var_Bool_Start}
	{
		;execute queued commands
		if ${QueuedCommands}
		{
			ExecuteQueued
		}
		wait 5
	}
	
		
	
	echo ${Time}: RZ_Var_Bool_Zone1Unlocked: ${RZ_Var_Bool_Zone1Unlocked}
	echo ${Time}: RZ_Var_Bool_Zone2Unlocked: ${RZ_Var_Bool_Zone2Unlocked}
	echo ${Time}: RZ_Var_Bool_Zone3Unlocked: ${RZ_Var_Bool_Zone3Unlocked}
	echo ${Time}: RZ_Var_Bool_ExcludeZone1: ${RZ_Var_Bool_ExcludeZone1}
	echo ${Time}: RZ_Var_Bool_ExcludeZone2: ${RZ_Var_Bool_ExcludeZone2}
	echo ${Time}: RZ_Var_Bool_ExcludeZone3: ${RZ_Var_Bool_ExcludeZone3}
	
	
	
	;zone set
	switch ${UIElement[ZoneSets@RZo].SelectedItem.Value}
	{
		case 10
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Tranquil Sea"]} || ${Math.Distance[${Me.Loc},295.27,5.67,-921.18]}>20
			{
				echo ${Time}: You must be in Zone Tranquil Sea and within 20 distance of 295.27,5.67,-921.18 to run this script for Brokenskull Bay Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[BSB]
			Zone1:Set["Brokenskull Bay: Bilgewater Falls [Heroic]"]
			Zone1Exit:Set["Exit Pirate Cove"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Brokenskull Bay: Hoist the Yellow Jack [Heroic]"]
			Zone2Exit:Set["loc,131.052139,-219.438873"]
			Zone2PopupSelection:Set[6]
			Zone2MoveToExit:Set[TRUE]
			Zone2MoveToExitLocX:Set[130.01]
			Zone2MoveToExitLocZ:Set[-217.27]
			Zone3:Set["Brokenskull Bay: Bosun's Private Stock [Event Heroic]"]
			Zone3Exit:Set[use]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-146.34]
			Zone3MoveToExitLocZ:Set[-454.92]
			ZoneEntrance:Set["Enter Brokenskull Bay"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[295.27]
			ZoneEntranceMoveToZoneLocZ:Set[-921.18]
			6HourZones:Set[FALSE]
			break
		}
		case 9
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Tranquil Sea"]} || ${Math.Distance[${Me.Loc},-1262.61,79.84,-724.97]}>10
			{
				echo ${Time}: You must be in Zone Tranquil Sea and within 10 distance of -1262.61,79.84,-724.97 to run this script for Zavith'loa Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[ZAV]
			Zone1:Set["Zavith'loa: The Lost Caverns [Heroic]"]
			Zone1Exit:Set[zavithloa_01_exit_to_southseas]
			Zone1PopupSelection:Set[6]
			Zone1MoveToExit:Set[TRUE]
			Zone1MoveToExitLocX:Set[-2925.14]
			Zone1MoveToExitLocZ:Set[-174.67]
			Zone2:Set["Zavith'loa: The Hidden Caldera [Heroic]"]
			Zone2Exit:Set["loc,-3680.734131,26.664436"]
			Zone2PopupSelection:Set[2]
			Zone2MoveToExit:Set[TRUE]
			Zone2MoveToExitLocX:Set[-3681.76]
			Zone2MoveToExitLocZ:Set[32.02]
			Zone3:Set["Zavith'loa: The Hunt [Event Heroic]"]
			Zone3Exit:Set[zavithloa_03_exit_to_southseas]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Enter Zavith'loa"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			6HourZones:Set[FALSE]
			break
		}
		case 6
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Phantom Sea"]} || ${Math.Distance[${Me.Loc},801.63,10.88,-339.85]}>10
			{
				echo ${Time}: You must be in Zone Phantom Sea and within 10 distance of 801.63,10.88,-339.85 to run this script for Far Seas Distillery Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[FSD]
			Zone1:Set["F.S. Distillery: Distill or Be Killed [Heroic]"]
			Zone1Exit:Set["Exit the F.S. Distillery"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["F.S. Distillery: Stowaways [Event Heroic]"]
			Zone2Exit:Set["Exit the F.S. Distillery"]
			Zone2PopupSelection:Set[5]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["F.S. Distillery: Stowaways [Challenge]"]
			Zone3Exit:Set["Exit the F.S. Distillery"]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Enter the F.S. Distillery"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			6HourZones:Set[FALSE]
			break
		}
		case 5
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Phantom Sea"]} || ${Math.Distance[${Me.Loc},-1077.29,51.55,-1061.54]}>10
			{
				echo ${Time}: You must be in Zone Phantom Sea and within 10 distance of -1077.29,51.55,-1061.54 to run this script for Far Seas Distillery Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[ST]
			Zone1:Set["Ssraeshza Temple [Heroic]"]
			Zone1Exit:Set["Zone Exit"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[TRUE]
			Zone1MoveToExitLocX:Set[-10.97]
			Zone1MoveToExitLocZ:Set[22.52]
			Zone2:Set["Ssraeshza Temple: Taskmaster's Echo [Event Heroic]"]
			Zone2Exit:Set["To Phantom Sea"]
			Zone2PopupSelection:Set[6]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Ssraeshza Temple: Inner Sanctum [Heroic]"]
			Zone3Exit:Set["Zone Exit"]
			Zone3PopupSelection:Set[5]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[476.27]
			Zone3MoveToExitLocZ:Set[69.23]
			ZoneEntrance:Set["To Ssraeshza Temple"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			6HourZones:Set[FALSE]
			break
		}
		case 11
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Phantom Sea"]} || ${Math.Distance[${Me.Loc},696.27,52.44,771.12]}>10
			{
				echo ${Time}: You must be in Zone Phantom Sea and within 10 distance of 696.27,52.44,771.12 to run this script for Ossuary Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[OSS]
			Zone1:Set["Ossuary: Resonance of Malice [Heroic]"]
			Zone1Exit:Set["loc,-28.223486,-23.598997"]
			Zone1PopupSelection:Set[5]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Ossuary: Sanguine Fountains [Heroic]"]
			Zone2Exit:Set["zone_to_phantom_seas"]
			Zone2PopupSelection:Set[7]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set[]
			Zone3Exit:Set[]
			Zone3PopupSelection:Set[]
			Zone3MoveToExit:Set[]
			Zone3MoveToExitLocX:Set[]
			Zone3MoveToExitLocZ:Set[]
			ZoneEntrance:Set["Enter Ossuary"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			RZ_Var_Bool_ExcludeZone3:Set[TRUE]
			6HourZones:Set[FALSE]
			break
		}
		case 7
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Butcherblock Mountains"]} || ${Math.Distance[${Me.Loc},723.89,24.01,580.57]}>10
			{
				echo ${Time}: You must be in Zone Butcherblock Mountains and within 10 distance of 723.89,24.01,580.57 to run this script for Far Seas Distillery Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[EOF]
			Zone1:Set["The Fabled Acadechism [Heroic]"]
			Zone1Exit:Set["zone_exit"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["The Fabled Crypt of Valdoon [Heroic]"]
			Zone2Exit:Set["zone_exit"]
			Zone2PopupSelection:Set[6]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["The Fabled Court of Innovation [Heroic]"]
			Zone3Exit:Set["zone_exit"]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Zone to Fabled Dungeons"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			6HourZones:Set[FALSE]
			break
		}
		case 8
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Phantom Sea"]} || ${Math.Distance[${Me.Loc},320.58,164.12,-138.07]}>10
			{
				echo ${Time}: You must be in Zone Phantom Sea and within 10 distance of 320.58,164.12,-138.07 (Inside sludge drain, near grate) to run this script for Castle Highhold Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[CHH]
			Zone1:Set["Castle Highhold [Heroic]"]
			Zone1Exit:Set["Zone"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Castle Highhold: Thresinet's Den [Heroic]"]
			Zone2Exit:Set["Zone"]
			Zone2PopupSelection:Set[6]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Castle Highhold: Insider Treachery [Event Heroic]"]
			Zone3Exit:Set["Zone"]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Castle Highhold Sludge Drain Latch"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[321.71]
			ZoneEntranceMoveToZoneLocZ:Set[-137.08]
			6HourZones:Set[FALSE]
			break
		}
		case 2
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Maldura"]} || ( ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}>10 && ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}>10 && ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}>10 && ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}>10 )
			{
				echo ${Time}: You must be in Zone Maldura and within 10 distance of -107.588409,1.464843,-45.882183 or -107.899620,1.360249,45.699463 or 202.524216,66.070686,-1.015480 or -68.632019,9.525129,118.591179 to run this script for Maldura Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[Maldura]
			Zone1:Set["Maldura: Bar Brawl [Event Heroic]"]
			Zone1Exit:Set["Exit"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			MalduraZone:Set[TRUE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Maldura: District of Ash [Heroic]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[2]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Maldura: Palace Foray [Event Heroic]"]
			Zone3Exit:Set["Exit"]
			Zone3PopupSelection:Set[0]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			Zone4:Set["Maldura: Alogrithm for Destrucution [Heroic]"]
			Zone4Exit:Set["Exit"]
			Zone4PopupSelection:Set[2]
			Zone4MoveToExit:Set[FALSE]
			Zone4MoveToExitLocX:Set[0]
			Zone4MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Door to Maldura:"]
			ZoneEntrance2:Set["Palace Mechno-Gate Controls"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			6HourZones:Set[FALSE]
			break
		}
		case 3
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Thalumbra, the Ever Deep"]} || ${Math.Distance[${Me.Loc},-748.658142,171.747192,168.508789]}>10
			{
				echo ${Time}: You must be in Zone Thalumbra, the Ever Deep and within 10 distance of -748.658142,171.747192,168.508789 to run this script for Stygian Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[Stygian]
			Zone1:Set["Stygian Threshold [Heroic]"]
			Zone1Exit:Set["Exit"]
			Zone1PopupSelection:Set[1]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Stygian Threshold: The Howling Gateway [Event Heroic]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[4]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set[]
			Zone3Exit:Set[]
			Zone3PopupSelection:Set[]
			Zone3MoveToExit:Set[]
			Zone3MoveToExitLocX:Set[]
			Zone3MoveToExitLocZ:Set[]
			ZoneEntrance:Set["Stygian Threshold Entrance"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			RZ_Var_Bool_ExcludeZone3:Set[TRUE]
			;6HourZones:Set[FALSE]
			break
		}
		case 4
		{
			if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["Thalumbra, the Ever Deep"]} || ${Math.Distance[${Me.Loc},457.162964,5.955282,-760.078125]}>10
			{
				echo ${Time}: You must be in Zone Thalumbra, the Ever Deep and within 10 distance of 457.162964,5.955282,-760.078125 to run this script for Kralet Penumbra Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[KP]
			Zone1:Set["Kralet Penumbra: Rise to Power [Heroic]"]
			Zone1Exit:Set["Exit"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Kralet Penumbra: Temple of the Ill-Seen [Heroic]"]
			Zone2Exit:Set["Return to Thalumbra"]
			Zone2PopupSelection:Set[4]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set[]
			Zone3Exit:Set[]
			Zone3PopupSelection:Set[]
			Zone3MoveToExit:Set[]
			Zone3MoveToExitLocX:Set[]
			Zone3MoveToExitLocZ:Set[]
			ZoneEntrance:Set["Kralet Penumbra Zone Entrance 02 - Penumbra Heroic - Penumbra Heroic 01 - Penumbra Advanced Solo - Penumbra 01 Advanced Solo"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			RZ_Var_Bool_ExcludeZone3:Set[TRUE]
			;6HourZones:Set[FALSE]
			break
		}
		case 12
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Obulus Frontier"](exists)} || ${Math.Distance[${Me.Loc},520.677246,250.506332,1353.012451]}>35
			{
				echo ${Time}: You must be in Zone Obulus Frontier and within 35 distance of 520.677246,250.506332,1353.012451 to run this script for Kaesora Expert Zone.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[K]
			Zone1:Set["Kaesora: Xalgozian Stronghold [Expert]"]
			Zone1Exit:Set["kaesora_door"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Kaesora: Tomb of the Venerated [Expert Event]"]
			Zone2Exit:Set[Exit]
			Zone2PopupSelection:Set[1]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["The Ruins of Cabilis [Expert]"]
			Zone3Exit:Set[Exit]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Teleporter to Expert Kaesora"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[520]
			ZoneEntranceMoveToZoneLocZ:Set[1352]
			;RZ_Var_Bool_ExcludeZone2:Set[TRUE]
			;RZ_Var_Bool_ExcludeZone3:Set[TRUE]
			Experts:Set[TRUE]
			ExpertsSummonOption:Set["Kaesora [Expert]"]
			;6HourZones:Set[TRUE]
			break
		}
		case 13
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Obulus Frontier"](exists)} || ${Math.Distance[${Me.Loc},520.677246,250.506332,1353.012451]}>35
			{
				echo ${Time}: You must be in Zone Obulus Frontier and within 35 distance of 520.677246,250.506332,1353.012451 to run this script for Kaesora Expert Zone.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[AS]
			Zone1:Set["Arcanna'se Spire: Forgotten Sanctum [Expert]"]
			Zone1Exit:Set["invis_wal"]
			Zone1PopupSelection:Set[1]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Arcanna'se Spire: Repository of Secrets [Expert]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[3]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Arcanna'se Spire: Vessel of the Sorceress [Expert Event]"]
			Zone3Exit:Set["Exit Door Left"]
			Zone3PopupSelection:Set[4]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-470]
			Zone3MoveToExitLocZ:Set[-107]
			ZoneEntrance:Set["Teleporter to Expert A"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[520]
			ZoneEntranceMoveToZoneLocZ:Set[1352]
			Experts:Set[TRUE]
			ExpertsSummonOption:Set["Arcanna'se Spire [Expert]"]
			;6HourZones:Set[TRUE]
			break
		}
		case 15
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Kunzar Jungle"](exists)} || ${Math.Distance[${Me.Loc},-258.121796,151.009216,-1162.882324]}>35
			{
				echo ${Time}: You must be in Zone Kunzar Jungle and within 35 distance of -258.121796,151.009216,-1162.882324 to run this script for Torsis Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[LC]
			Zone1:Set["Lost City of Torsis: Reaver's Remnants [Heroic]"]
			Zone1Exit:Set["door 5"]
			Zone1PopupSelection:Set[3]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Lost City of Torsis: The Spectral Market [Heroic]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[7]
			Zone2MoveToExit:Set[TRUE]
			Zone2MoveToExitLocX:Set[1]
			Zone2MoveToExitLocZ:Set[148]
			Zone3:Set["Lost City of Torsis: The Shrouded Temple [Event Heroic]"]
			Zone3Exit:Set["Exit"]
			Zone3PopupSelection:Set[6]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-130]
			Zone3MoveToExitLocZ:Set[-221]
			ZoneEntrance:Set["City of Mist Entrance Door"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[-258]
			ZoneEntranceMoveToZoneLocZ:Set[-1157]
			Experts:Set[FALSE]
			ExpertsSummonOption:Set[""]
			;6HourZones:Set[TRUE]
			break
		}
		case 16
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Kunzar Jungle"](exists)} || ${Math.Distance[${Me.Loc},-258.121796,151.009216,-1162.882324]}>35
			{
				echo ${Time}: You must be in Zone Kunzar Jungle and within 35 distance of -258.121796,151.009216,-1162.882324 to run this script for Torsis Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[LC]
			Zone1:Set["Lost City of Torsis: Reaver's Remnants [Solo]"]
			Zone1Exit:Set["door 5"]
			Zone1PopupSelection:Set[3]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Lost City of Torsis: The Spectral Market [Solo]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[7]
			Zone2MoveToExit:Set[TRUE]
			Zone2MoveToExitLocX:Set[1]
			Zone2MoveToExitLocZ:Set[148]
			Zone3:Set["Lost City of Torsis: The Shrouded Temple [Advanced Solo]"]
			Zone3Exit:Set["Exit"]
			Zone3PopupSelection:Set[6]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-130]
			Zone3MoveToExitLocZ:Set[-221]
			ZoneEntrance:Set["City of Mist Entrance Door"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[-258]
			ZoneEntranceMoveToZoneLocZ:Set[-1157]
			Experts:Set[FALSE]
			ExpertsSummonOption:Set[""]
			;6HourZones:Set[TRUE]
			break
		}
		case 17
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Obulus Frontier"](exists)} || ${Math.Distance[${Me.Loc},520.677246,250.506332,1353.012451]}>35
			{
				echo ${Time}: You must be in Zone Obulus Frontier and within 35 distance of 520.677246,250.506332,1353.012451 to run this script for Kaesora Expert Zone.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[LC]
			Zone1:Set["Lost City of Torsis: Reaver's Remnants [Expert]"]
			Zone1Exit:Set["door 5"]
			Zone1PopupSelection:Set[3]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Lost City of Torsis: The Spectral Market [Expert]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[7]
			Zone2MoveToExit:Set[TRUE]
			Zone2MoveToExitLocX:Set[1]
			Zone2MoveToExitLocZ:Set[148]
			Zone3:Set["Lost City of Torsis: The Shrouded Temple [Expert Event]"]
			Zone3Exit:Set["Exit"]
			Zone3PopupSelection:Set[6]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-130]
			Zone3MoveToExitLocZ:Set[-221]
			ZoneEntrance:Set["Teleporter to Expert City of Mist"]
			ZoneEntranceMoveToZone:Set[TRUE]
			ZoneEntranceMoveToZoneLocX:Set[520]
			ZoneEntranceMoveToZoneLocZ:Set[1352]
			Experts:Set[TRUE]
			ExpertsSummonOption:Set["Lost City of Torsis [Expert]"]
			;6HourZones:Set[TRUE]
			break
		}
		case 21
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Obulus Frontier"](exists)} || ${Math.Distance[${Me.Loc},790.735962,-129.386322,-583.942261]}>35
			{
				echo ${Time}: You must be in Zone Obulus Frontier and within 35 distance of 790.735962,-129.386322,-583.942261 to run this script for Torsis Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[CD]
			Zone1:Set["Crypt of Dalnir: Baron's Workshop [Heroic]"]
			Zone1Exit:Set["Exit Ladder"]
			Zone1PopupSelection:Set[1]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Crypt of Dalnir: Ritual Chamber [Heroic]"]
			Zone2Exit:Set["Exit Ladder"]
			Zone2PopupSelection:Set[3]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Crypt of Dalnir: Wizard's Den [Event Heroic]"]
			Zone3Exit:Set["Exit Ladder"]
			Zone3PopupSelection:Set[7]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Entrance to Dalnir"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			Experts:Set[FALSE]
			ExpertsSummonOption:Set[""]
			;6HourZones:Set[TRUE]
			break
		}
		case 20
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Obulus Frontier"](exists)} || ${Math.Distance[${Me.Loc},790.735962,-129.386322,-583.942261]}>35
			{
				echo ${Time}: You must be in Zone Obulus Frontier and within 35 distance of 790.735962,-129.386322,-583.942261 to run this script for Torsis Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[CD]
			Zone1:Set["Crypt of Dalnir: Baron's Workshop [Solo]"]
			Zone1Exit:Set["Exit Ladder"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Crypt of Dalnir: Ritual Chamber [Solo]"]
			Zone2Exit:Set["Exit Ladder"]
			Zone2PopupSelection:Set[4]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Crypt of Dalnir: Wizard's Den [Advanced Solo]"]
			Zone3Exit:Set["Exit Ladder"]
			Zone3PopupSelection:Set[6]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Entrance to Dalnir"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			Experts:Set[FALSE]
			ExpertsSummonOption:Set[""]
			;6HourZones:Set[TRUE]
			break
		}
		case 22
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Obulus Frontier"](exists)} || ${Math.Distance[${Me.Loc},520.677246,250.506332,1353.012451]}>35
			{
				echo ${Time}: You must be in Zone Obulus Frontier and within 35 distance of 520.677246,250.506332,1353.012451 to run this script for Kaesora Expert Zone.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[CD]
			Zone1:Set["Crypt of Dalnir: Baron's Workshop [Expert]"]
			Zone1Exit:Set["Exit Ladder"]
			Zone1PopupSelection:Set[1]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Crypt of Dalnir: Ritual Chamber [Expert]"]
			Zone2Exit:Set["Exit Ladder"]
			Zone2PopupSelection:Set[3]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Crypt of Dalnir: Wizard's Den [Expert Event]"]
			Zone3Exit:Set["Exit Ladder"]
			Zone3PopupSelection:Set[7]
			Zone3MoveToExit:Set[FALSE]
			Zone3MoveToExitLocX:Set[0]
			Zone3MoveToExitLocZ:Set[0]
			ZoneEntrance:Set["Teleporter to Expert Dalnir"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			Experts:Set[TRUE]
			ExpertsSummonOption:Set["Crypt of Dalnir [Expert]"]
			;6HourZones:Set[TRUE]
			break
		}
		case 1
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Thalumbra, the Ever Deep"](exists)} || ${Math.Distance[${Me.Loc},-61.980949,15.927130,160.867096]}>35
			{
				echo ${Time}: You must be in Zone Thalumbra, the Ever Deep and within 35 distance of -61.980949,15.927130,160.867096 to run this script for Arcanna'se Spire Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[AS]
			Zone1:Set["Arcanna'se Spire: Forgotten Sanctum [Heroic]"]
			Zone1Exit:Set["invis_wal"]
			Zone1PopupSelection:Set[1]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Arcanna'se Spire: Repository of Secrets [Heroic]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[4]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]"]
			Zone3Exit:Set["Exit Door Left"]
			Zone3PopupSelection:Set[8]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-470]
			Zone3MoveToExitLocZ:Set[-107]
			ZoneEntrance:Set["Arcanna'se Spire Portal"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			;6HourZones:Set[TRUE]
			break
		}
		case 14
		{
			if !${Me.GetGameData[Self.ZoneName].Label.Find["Thalumbra, the Ever Deep"](exists)} || ${Math.Distance[${Me.Loc},-61.980949,15.927130,160.867096]}>35
			{
				echo ${Time}: You must be in Zone Thalumbra, the Ever Deep and within 35 distance of -61.980949,15.927130,160.867096 to run this script for Arcanna'se Spire Zones.
				Script:End
			}
			RZ_Var_String_ZoneSet:Set[AS]
			Zone1:Set["Arcanna'se Spire: Forgotten Sanctum [Solo]"]
			Zone1Exit:Set["invis_wal"]
			Zone1PopupSelection:Set[2]
			Zone1MoveToExit:Set[FALSE]
			Zone1MoveToExitLocX:Set[0]
			Zone1MoveToExitLocZ:Set[0]
			Zone2:Set["Arcanna'se Spire: Repository of Secrets [Solo]"]
			Zone2Exit:Set["Exit"]
			Zone2PopupSelection:Set[5]
			Zone2MoveToExit:Set[FALSE]
			Zone2MoveToExitLocX:Set[0]
			Zone2MoveToExitLocZ:Set[0]
			Zone3:Set["Arcanna'se Spire: Vessel of the Sorceress [Advanced Solo]"]
			Zone3Exit:Set["Exit Door Left"]
			Zone3PopupSelection:Set[7]
			Zone3MoveToExit:Set[TRUE]
			Zone3MoveToExitLocX:Set[-470]
			Zone3MoveToExitLocZ:Set[-107]
			ZoneEntrance:Set["Arcanna'se Spire Portal"]
			ZoneEntranceMoveToZone:Set[FALSE]
			ZoneEntranceMoveToZoneLocX:Set[0]
			ZoneEntranceMoveToZoneLocZ:Set[0]
			;6HourZones:Set[TRUE]
			break
		}
	}
	

	;events
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	
	;buildrelaygroup
	RG
	
	;load RI_AntiAFK
	relay all -noredirect RI_AntiAFK
	
	;main loop
	while 1
	{
		;echo EX1: ${RZ_Var_Bool_ExcludeZone1} / EX2: ${RZ_Var_Bool_ExcludeZone2} / EX3: ${RZ_Var_Bool_ExcludeZone3}
		;if we are not zoning
		if ${EQ2.Zoning}==0
		{
			;if Zone1 is unlocked run it
			if ${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_ExcludeZone1}
				call Zone1
			
			;if Zone2 is unlocked run it
			if ${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_ExcludeZone2}
				call Zone2
				
			;if Zone3 is unlocked run it
			if ${RZ_Var_Bool_Zone3Unlocked} && !${RZ_Var_Bool_ExcludeZone3}
				call Zone3
			
			; if !${Developer} && ${Zone1FirstRunDone} && ${Zone2FirstRunDone} && ${Zone3FirstRunDone}
			; {
				; echo ${Time}: Full set complete please rerun rz
				; Script:End
			; }
			
			;call CheckZones function
			call CheckZones
			wait 50
		}
	}
}

;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	;check Text for Zone timer confirmation message
   	if ${Text.Find["Your zone reuse timer for "](exists)}
	{
		if ${Text.Find["${Zone1}"]}
		{
			echo ${Time}: Setting ${Zone1} zone reuse timer to: ${Time.SecondsSinceMidnight} Seconds since midnight
			RZ_Var_Int_Zone1SetTime:Set[${Time.SecondsSinceMidnight}]
			RZ_Var_Bool_Zone1Unlocked:Set[FALSE]
		}
		if ${Text.Find["${Zone2}"]}
		{
			echo ${Time}: Setting ${Zone2} zone reuse timer to: ${Time.SecondsSinceMidnight} Seconds since midnight
			RZ_Var_Int_Zone2SetTime:Set[${Time.SecondsSinceMidnight}]
			RZ_Var_Bool_Zone2Unlocked:Set[FALSE]
		}
		if ${Text.Find["${Zone3}"]}
		{
			echo ${Time}: Setting ${Zone3} zone reuse timer to: ${Time.SecondsSinceMidnight} Seconds since midnight
			RZ_Var_Int_Zone3SetTime:Set[${Time.SecondsSinceMidnight}]
			RZ_Var_Bool_Zone3Unlocked:Set[FALSE]
		}
	}
	;check Text for Zone reset timer confirmation message
   	if ${Text.Find["You reset your entrance timer for "](exists)}
	{
		ResetConfirmation:Set[TRUE]
		if ${Text.Find["${Zone1}"]}
		{
			echo ${Time}: Succesfully Reset ${Zone1}
			RZ_Var_Int_Zone1SetTime:Set[0]
			RZ_Var_Bool_Zone1Unlocked:Set[TRUE]
		}
		if ${Text.Find["${Zone2}"]}
		{
			echo ${Time}: Succesfully Reset ${Zone2}
			RZ_Var_Int_Zone2SetTime:Set[0]
			RZ_Var_Bool_Zone2Unlocked:Set[TRUE]
		}
		if ${Text.Find["${Zone3}"]}
		{
			echo ${Time}: Succesfully Reset ${Zone3}
			RZ_Var_Int_Zone3SetTime:Set[0]
			RZ_Var_Bool_Zone3Unlocked:Set[TRUE]
		}
	}
	;check Text for unable to zone message
   	if ${Text.Find["The following group members are already saved to this instance"](exists)}
	{
		UnableToZone:Set[TRUE]
	}
	;check Text for unable to zone message
   	if ${Text.Find["is already saved to this instance"](exists)}
	{
		UnableToZone:Set[TRUE]
	}
	;check Text for instance expired message
   	if ${Text.Find["This instance will expire in 0.0 seconds"](exists)} || ${Text.Find["You may not enter an instance created prior to when your previous instance's minimum lockout timer expired"](exists)}
	{
		InstanceExpired:Set[TRUE]
	}
}

;CheckZones function
function CheckZones()
{
	;if ${Zone1} is not unlocked, check its lock timer and reset if its time.
	if !${RZ_Var_Bool_Zone1Unlocked} && ${RZ_Var_Int_Zone1SetTime}!=0 && !${RZ_Var_Bool_ExcludeZone1}
	{
		echo ${Time}: Zone1 Unlocked: ${CheckZone.Unlocked[${RZ_Var_Int_Zone1SetTime}]}
		if ${CheckZone.Unlocked[${RZ_Var_Int_Zone1SetTime}]}
			call CheckZone.Unlock "${Zone1}"
	}
	
	;if ${Zone2} is not unlocked, check its lock timer and reset if its time.
	if !${RZ_Var_Bool_Zone2Unlocked} && ${RZ_Var_Int_Zone2SetTime}!=0 && !${RZ_Var_Bool_ExcludeZone2}
	{
		echo ${Time}: Zone2 Unlocked: ${CheckZone.Unlocked[${RZ_Var_Int_Zone1SetTime}]}
		if ${CheckZone.Unlocked[${RZ_Var_Int_Zone2SetTime}]}
			call CheckZone.Unlock "${Zone2}"
	}
	
	;if ${Zone3} is not unlocked, check its lock timer and reset if its time.
	if !${RZ_Var_Bool_Zone3Unlocked} && ${RZ_Var_Int_Zone3SetTime}!=0 && !${RZ_Var_Bool_ExcludeZone3}
	{
		echo ${Time}: Zone3 Unlocked: ${CheckZone.Unlocked[${RZ_Var_Int_Zone1SetTime}]}
		if ${CheckZone.Unlocked[${RZ_Var_Int_Zone3SetTime}]}
			call CheckZone.Unlock "${Zone3}"
	}
}
function HailActor(string _Actor, int _NumberOfResponses=1, string _ResponseNumber=1, bool _Hail=TRUE, bool _Follow=TRUE)
{
	variable bool _Words=TRUE
	if ${Int[${_ResponseNumber}]}>0
		_Words:Set[FALSE]
	;echo HailActor(string _Actor=${_Actor}, int _NumberOfResponses=1=${_NumberOfResponses}, int _ResponseNumber=1=${_ResponseNumber}, bool _Hail=TRUE=${_Hail})
	if ${_Hail}
	{
		wait 20
	}
	;make sure _Actor exists so we do not go through the motions for nothign
	;echo \${Actor[${_Actor}](exists)}  //  ${Actor[${_Actor}](exists)}
	if ${Actor[${_Actor}](exists)}
	{
		variable int _ID=${Actor[${_Actor}].ID}
		;wait until we are out of combat
		if !${DontStopForCombat}
			call RIMObj.CheckCombat
		
		if ${_Hail}
		{
			wait 10
			;pause bots
			
			RI_CMD_PauseCombatBots 1
			;wait 5
			;change camera
			Press -hold "Page Down"
			wait 15
			;change camera
			Press -release "Page Down"
			Press -hold "Page Up"
			wait 3
			Press -release "Page Up"
			
			Actor[${_ID}]:DoFace
			Actor[${_ID}]:DoFace
			wait 5
			;scroll the mouse wheel
			MouseWheel -10000
			Actor[${_ID}]:DoTarget
			Actor[${_ID}]:DoTarget
			wait 5
			eq2execute hail
			wait 5
		}
		echo ${_Words}
		if ${_Words}
		{
			wait 20 ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText].Equal["${_ResponseNumber}"]}
			if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)} && ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1].GetProperty[LocalText].Equal["${_ResponseNumber}"]}
				EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
			elseif ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2](exists)} && ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2].GetProperty[LocalText].Equal["${_ResponseNumber}"]}
				EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,2]:LeftClick
			elseif ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,3](exists)} && ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,3].GetProperty[LocalText].Equal["${_ResponseNumber}"]}
				EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,3]:LeftClick
			elseif ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,4](exists)} && ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,4].GetProperty[LocalText].Equal["${_ResponseNumber}"]}
				EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,4]:LeftClick
		}
		else
		{
			variable int count
			variable string _tempbtntxt
			for(count:Set[1];${count}<=${_NumberOfResponses};count:Inc)
			{
				_tempbtntxt:Set["${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText]}"]
				if ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1](exists)}
					EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}]:LeftClick
				wait 5
				wait 20 ( ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${_ResponseNumber}].GetProperty[LocalText].NotEqual["${_tempbtntxt}"]} || !${EQ2UIPage[ProxyActor,Conversation].IsVisible} )
			}
		}
		;unpause bots
		RI_CMD_PauseCombatBots 0
	}
}
;Zone1 function
function Zone1()
{
	;if we have ZoneEntranceMoveToZone TRUE, Do it
	if ${ZoneEntranceMoveToZone}
		call MoveC ${ZoneEntranceMoveToZoneLocX} ${ZoneEntranceMoveToZoneLocZ} 0
	elseif ${MalduraZone}
		call MalduraFinder "${Zone1}"
		
	wait 20

	echo ${Time}: Zoning into ${Zone1}
	
	if ${Experts}
	{
		call HailActor "Prissaia" 2 "${ExpertsSummonOption}"
		wait 20
	}
	
	;click Zone1 Zone in
	Actor["${ZoneEntrance}"]:DoubleClick
	wait 10
	
	CheckZone:GetZoneLists
	wait 20
	variable int _ZCNT=0
	while ${CheckZone.RowByName["${Zone1}"]}==0 && ${_ZCNT:Inc}<10
	{
		CheckZone:GetZoneLists
		wait 5
	}
	if ${CheckZone.RowByName["${Zone1}"]}==0
	{
		echo ISXRI: Can't find that zone in the Destination list
		Script:End
	}
	wait 10
	EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${CheckZone.RowByName["${Zone1}"]}]
	wait 10
	
	;confirm selection and zone
	EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	
	;wait until we start zoning, or are unable to zone
	wait 6000 ${EQ2.Zoning} || ${UnableToZone} || ${InstanceExpired}
	
	;if we are unable to zone because someone is still locked, unlock again and return
	if ${UnableToZone}
	{
		;try again to unlock
		call CheckZone.Unlock "${Zone1}"
		
		;set UnableToZone False
		UnableToZone:Set[FALSE]
		
		;exit function
		return
	}
	elseif ${InstanceExpired}
	{
		;wait 5s
		wait 50
		
		;wait until we are done zoning
		wait 6000 !${EQ2.Zoning}
		
		;set InstanceExpired false
		InstanceExpired:Set[FALSE]
		
		;exit function
		return
	}
	
	;wait until we are not zoning
	wait 6000 !${EQ2.Zoning}
	
	;wait until all the group is in the zone
	call CheckZone.CheckAllHere
	
	
	;wait 5s
	wait 50
	
	;if we are not in the correct zone, exit function
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${Zone1}"]}
		return
		
	;run runinstances started
	ri
	wait 50
	RI_Var_Bool_Start:Set[TRUE]
	UIElement[Start@RI]:SetText[Pause]
	wait 50
	
	;while runinstances is running wait
	while ${Script[Buffer:RunInstances](exists)}
		wait 20
	wait 10
	
	;if we are not a developer and all zones first runs are done, exit script
	if !${Developer} && ${Zone1FirstRunDone} && ${Zone2FirstRunDone} && ${Zone3FirstRunDone}
	{
		echo ${Time}: Full set complete please rerun rz
		Script:End
	}
	
	;wait until we have a zone open so we stay hidden.
	if !${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_Zone3Unlocked}
		echo ${Time}: No Zones are Unlocked, Waiting to Zone Out
	while !${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_Zone3Unlocked}
	{
		echo ${Time}: Waiting until a zone is unlocked
		;first check if zone1 is unlockable
		;if ${Zone1} is not unlocked, check its lock timer and reset if its time.
		if !${RZ_Var_Bool_Zone1Unlocked} && ${RZ_Var_Int_Zone1SetTime}!=0 && !${RZ_Var_Bool_ExcludeZone1}
		{
			echo ${Time}: Zone1 Unlocked: ${CheckZone.Unlocked[${RZ_Var_Int_Zone1SetTime}]}
			if ${CheckZone.Unlocked[${RZ_Var_Int_Zone1SetTime}]}
				break
		}
		;call CheckZones function
		call CheckZones

		wait 50
	}
	
	;if we are supposed to move to exit
	if ${Zone1MoveToExit}
		call MoveC ${Zone1MoveToExitLocX} ${Zone1MoveToExitLocZ}
	
	wait 20
	
	;zoneout
	;relay "other ${RI_Var_String_RelayGroup}" -noredirect RZ 0 0 TRUE "${Zone1Exit}" "${Zone1}"
	call ZoneOut "${Zone1Exit}" "${Zone1}"
}

function ZoneOut(string ZoneExit, string ZoneName)
{
	;while we are not zoning and in ${Zone} keep clicking the exit
	relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
	wait 5
	;select row 1
	relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[1]
	wait 5
	;confirm selection and zone
	relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	wait 20
	while !${EQ2.Zoning} && ${Me.GetGameData[Self.ZoneName].Label.Equal["${ZoneName}"]}
	{
		relay ${RI_Var_String_RelayGroup} Actor[${Actor[${ZoneExit}].ID}]:DoubleClick
		wait 5
		;select row 1
		; relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[1]
		; wait 5
		;; confirm selection and zone
		; relay ${RI_Var_String_RelayGroup} EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
		relay ${RI_Var_String_RelayGroup} RIMUIObj:Door[ALL,0]
		wait 20
	}
	;wait until we start zoning
	wait 6000 ${EQ2.Zoning}
	;wait until we are not zoning
	wait 6000 !${EQ2.Zoning}
	;wait until all the group is in the zone
	call CheckZone.CheckAllHere
}

;Zone2 function
function Zone2()
{
	;if we have ZoneEntranceMoveToZone TRUE, Do it
	if ${ZoneEntranceMoveToZone}
		call MoveC ${ZoneEntranceMoveToZoneLocX} ${ZoneEntranceMoveToZoneLocZ} 0
	elseif ${MalduraZone}
		call MalduraFinder "${Zone2}"
		
	wait 20
	
	echo ${Time}: Zoning into ${Zone2}
	
	if ${Experts}
	{
		call HailActor "Prissaia" 2 "${ExpertsSummonOption}"
		wait 20
	}
	
	;click Zone2 Zone in
	Actor["${ZoneEntrance}"]:DoubleClick
	wait 10
	
	CheckZone:GetZoneLists
	wait 20
	variable int _ZCNT=0
	while ${CheckZone.RowByName["${Zone2}"]}==0 && ${_ZCNT:Inc}<10
	{
		CheckZone:GetZoneLists
		wait 5
	}
	if ${CheckZone.RowByName["${Zone2}"]}==0
	{
		echo ISXRI: Can't find that zone in the Destination list
		Script:End
	}
	wait 10
	EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${CheckZone.RowByName["${Zone2}"]}]
	wait 10
	
	;confirm selection and zone
	EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	
	;wait until we start zoning
	wait 6000 ${EQ2.Zoning} || ${UnableToZone} || ${InstanceExpired}
	
	;if we are unable to zone because someone is still locked, unlock again and return
	if ${UnableToZone}
	{
		;try again to unlock
		call CheckZone.Unlock "${Zone1}"
		
		;set UnableToZone False
		UnableToZone:Set[FALSE]
		
		;exit function
		return
	}
	elseif ${InstanceExpired}
	{
		;wait 5s
		wait 50
		
		;wait until we are done zoning
		wait 6000 !${EQ2.Zoning}
		
		;set InstanceExpired false
		InstanceExpired:Set[FALSE]
		
		;exit function
		return
	}
	
	;wait until we are not zoning
	wait 6000 !${EQ2.Zoning}
	
	;wait until all the group is in the zone
	call CheckZone.CheckAllHere
	
	;wait 5s
	wait 50
	
	;if we are not in the correct zone, exit function
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${Zone2}"]}
		return
	
	;run runinstances started
	ri
	wait 50
	RI_Var_Bool_Start:Set[TRUE]
	UIElement[Start@RI]:SetText[Pause]
	wait 50
	
	;while runinstances is running wait
	while ${Script[Buffer:RunInstances](exists)}
		wait 20
	wait 10
	
	;if we are not a developer and all zones first runs are done, exit script
	if !${Developer} && ${Zone1FirstRunDone} && ${Zone2FirstRunDone} && ${Zone3FirstRunDone}
	{
		echo ${Time}: Full set complete please rerun rz
		Script:End
	}
	
	;wait until we have a zone open so we stay hidden.
	if !${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_Zone3Unlocked}
		echo ${Time}: No Zones are Unlocked, Waiting to Zone Out
	while !${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_Zone3Unlocked}
	{
		;first check if zone2 is unlockable
		;if ${Zone2} is not unlocked, check its lock timer and reset if its time.
		if !${RZ_Var_Bool_Zone2Unlocked} && ${RZ_Var_Int_Zone2SetTime}!=0 && !${RZ_Var_Bool_ExcludeZone2}
		{
			echo ${Time}: Zone2 Unlocked: ${CheckZone.Unlocked[${RZ_Var_Int_Zone2SetTime}]}
			if ${CheckZone.Unlocked[${RZ_Var_Int_Zone2SetTime}]}
				break
		}
		;call CheckZones function
		call CheckZones

		wait 50
	}
	
	;if we are supposed to move to exit
	if ${Zone2MoveToExit}
		call MoveC ${Zone2MoveToExitLocX} ${Zone2MoveToExitLocZ}
	
	wait 20
	
	;zoneout
	;relay "other ${RI_Var_String_RelayGroup}" RZ 0 0 TRUE "${Zone2Exit}" "${Zone2}"
	call ZoneOut "${Zone2Exit}" "${Zone2}"
}

;Zone3 function
function Zone3()
{
	;if we have ZoneEntranceMoveToZone TRUE, Do it
	if ${ZoneEntranceMoveToZone}
		call MoveC ${ZoneEntranceMoveToZoneLocX} ${ZoneEntranceMoveToZoneLocZ} 0
	elseif ${MalduraZone}
		call MalduraFinder "${Zone3}"
		
	wait 20
	
	echo ${Time}: Zoning into ${Zone3}
	
	if ${Experts}
	{
		call HailActor "Prissaia" 2 "${ExpertsSummonOption}"
		wait 20
	}
	
	;click Zone3 Zone in
	if ${ZoneEntrance2.NotEqual[NONE]}
		Actor["${ZoneEntrance2}"]:DoubleClick
	else
		Actor["${ZoneEntrance}"]:DoubleClick
	wait 10
	CheckZone:GetZoneLists
	wait 20
	variable int _ZCNT=0
	while ${CheckZone.RowByName["${Zone3}"]}==0 && ${_ZCNT:Inc}<10
	{
		CheckZone:GetZoneLists
		wait 5
	}
	if ${CheckZone.RowByName["${Zone3}"]}==0
	{
		echo ISXRI: Can't find that zone in the Destination list
		Script:End
	}
	wait 10
	EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${CheckZone.RowByName["${Zone3}"]}]
	wait 10
	
	;confirm selection and zone
	EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
	;wait until we start zoning
	wait 6000 ${EQ2.Zoning} || ${UnableToZone} || ${InstanceExpired}
	
	;if we are unable to zone because someone is still locked, unlock again and return
	if ${UnableToZone}
	{
		;try again to unlock
		call CheckZone.Unlock "${Zone1}"
		
		;set UnableToZone False
		UnableToZone:Set[FALSE]
		
		;exit function
		return
	}
	elseif ${InstanceExpired}
	{
		;wait 5s
		wait 50
		
		;wait until we are done zoning
		wait 6000 !${EQ2.Zoning}
		
		;set InstanceExpired false
		InstanceExpired:Set[FALSE]
		
		;exit function
		return
	}
	
	;wait until we are not zoning
	wait 6000 !${EQ2.Zoning}
	
	;wait until all the group is in the zone
	call CheckZone.CheckAllHere
	
	;wait 5s
	wait 50
	
	;if we are not in the correct zone, exit function
	if ${Me.GetGameData[Self.ZoneName].Label.NotEqual["${Zone3}"]}
		return
	
	;run runinstances started
	ri
	wait 50
	RI_Var_Bool_Start:Set[TRUE]
	UIElement[Start@RI]:SetText[Pause]
	wait 50
	while ${Script[Buffer:RunInstances](exists)}
		wait 20
	wait 10
	
	;if we are not a developer and all zones first runs are done, exit script
	if !${Developer} && ${Zone1FirstRunDone} && ${Zone2FirstRunDone} && ${Zone3FirstRunDone}
	{
		echo ${Time}: Full set complete please rerun rz
		Script:End
	}
	
	;wait until we have a zone open so we stay hidden.
	if !${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_Zone3Unlocked}
		echo ${Time}: No Zones are Unlocked, Waiting to Zone Out
	while !${RZ_Var_Bool_Zone1Unlocked} && !${RZ_Var_Bool_Zone2Unlocked} && !${RZ_Var_Bool_Zone3Unlocked}
	{
		;first check if zone3 is unlockable
		;if ${Zone3} is not unlocked, check its lock timer and reset if its time.
		if !${RZ_Var_Bool_Zone3Unlocked} && ${RZ_Var_Int_Zone3SetTime}!=0 && !${RZ_Var_Bool_ExcludeZone3}
		{
			echo ${Time}: Zone3 Unlocked: ${CheckZone.Unlocked[${RZ_Var_Int_Zone3SetTime}]}
			if ${CheckZone.Unlocked[${RZ_Var_Int_Zone3SetTime}]}
				break
		}
		;call CheckZones function
		call CheckZones

		wait 50
	}
	
	;if we are supposed to move to exit
	if ${Zone3MoveToExit}
		call MoveC ${Zone3MoveToExitLocX} ${Zone3MoveToExitLocZ}
	
	wait 20
	
	;zoneout
	;relay "other ${RI_Var_String_RelayGroup}" RZ 0 0 TRUE "${Zone3Exit}" "${Zone3}"
	call ZoneOut "${Zone3Exit}" "${Zone3}"
}

;checkzone object
objectdef CheckZoneObject
{
	variable index:string ZoneList
	method GetZoneLists()
	{
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
	;check current seconds since midnight against locktimer return true or false
	member:bool Unlocked(int SecondsSinceMidnightTheZoneWasSetAt)
	{
		;set the unlock time 5400=1.5 hours, 21600=6 hours
		variable int UnlockTime
		if ${6HourZones}
			UnlockTime:Set[21600]
		else
			UnlockTime:Set[5400]
		;echo ${Time}: Checking ${SecondsSinceMidnightTheZoneWasSetAt}
		if ${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${UnlockTime}]}<86400
		{
			;echo ${Time} Reset timer is not past midnight
			
			if ${Time.SecondsSinceMidnight}>${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${UnlockTime}]}
				return TRUE
			else
				return FALSE
			;return ${Time.SecondsSinceMidnight}>${Math.Calc[${SecondsSinceMidnightTheZoneWasSetAt}+${UnlockTime}]}

		}
		else
		{
			;echo ${Time} Reset timer is past midnight
			
			if ${Time.SecondsSinceMidnight}>${UnlockTime}
				return FALSE
			else
			{
				if ${Time.SecondsSinceMidnight}>${Math.Calc[${UnlockTime}-(86400-${SecondsSinceMidnightTheZoneWasSetAt})]}
					return TRUE
				else
					return FALSE
			}
		}
	}

	;open then close the zone timers window then, unlock zone ZoneName, 
	;wait 5 seconds or until confirmation is seen
	function Unlock(string ZoneName)
	{	
		echo ${Time}: Unlocking ${ZoneName}
		relay ${RI_Var_String_RelayGroup} eq2ex togglezonereuse
		wait 5
		relay ${RI_Var_String_RelayGroup} eq2ex togglezonereuse
		wait 5
		relay ${RI_Var_String_RelayGroup} Me:ResetZoneTimer["${ZoneName}"]
		wait 50 ${ResetConfirmation}
		ResetConfirmation:Set[FALSE]
	}
	member:bool _CheckAllHere()
	{
		variable bool _AllHere
		
		variable int _count
		_AllHere:Set[TRUE]
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		return ${_AllHere}
	}
	function CheckAllHere()
	{
		while !${This._CheckAllHere}
		{
			wait 10
		}
	}
}
function Move(float X1, float Y1, float Z1, int MPrecision, int PauseLength, bool ClearTarget, bool StopForCombat, bool SkipCheck, bool KeepMoving, bool UseRI_Var_String_ForwardKey=TRUE, bool SkipCollisionCheck=FALSE)
{
	;echo Moving : Move(float ${X1}, float ${Y1}, float ${Z1}, int ${MPrecision}, int ${PauseLength}, bool ${ClearTarget}, bool ${StopForCombat}, bool ${SkipCheck}, bool ${KeepMoving}, bool ${UseRI_Var_String_ForwardKey}=TRUE, bool ${SkipCollisionCheck}=FALSE)
	if ${X1}==0 && ${Y1}==0 && ${Z1}==0
	{
		;echo ${Time}: Our movement position is 0,0,0, skipping, please check to make sure this is intended.
		return
	}
	if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<200 && ( !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${X1},${Math.Calc[${Y1}+2]},${Z1}]} || ${SkipCollisionCheck} )
	{
		;pause a bit before each move
		wait ${PauseLength}
		if ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
		{
			;echo we are there lets stop flying up or down
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			;wait 1
		}
		;check distance from my current x,z position vs the predetermined x,z positions
		;if larger than the precision move
		while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>${MPrecision} && ${StartRZ} && !${RI_Var_Bool_CancelMovement}
		{
			;check if we are paused
			call CheckPause
			if ${Debug}
				echo ${Time}: We are at ${Me.X} ${Me.Y} ${Me.Z} which is ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} away from ${X1},${Y1},${Z1} and the precision is set to ${MPrecision}
			;check if in combat
			if ${StopForCombat}
				call CheckCombat
			;clear target while moving
			if ${Target(exists)} && ${ClearTarget} && !${GlobalOthers}
				eq2execute target_none
			;Follow
			if ${Follow} && !${GlobalOthers} && !(${Me.InCombat} || ${Me.IsHated})
				call follow
			;check for a Shiny if set
			if ${RI_Var_Bool_GrabShinys} && !${QuestMode} && ${StopForCombat} && !${SkipCheck} && !${GlobalOthers} && ${Actor[?,radius,${ShinyScanDistance}](exists)}
			{
				if ( !${Actor[NamedNPC,radius,50](exists)} || ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}>10 ) && ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Me.Y}]}<3
				{
					ShinyID:Set[${Actor[?,radius,${ShinyScanDistance}].ID}]
					if ${Debug}
						echo ${Time}: Closest Shiny ID: ${ShinyID} @ ${Actor[${ShinyID}].X} ${Actor[${ShinyID}].Y} ${Actor[${ShinyID}].Z} Which is ${Actor[${ShinyID}].Distance} Away
					;press -release ${RI_Var_String_ForwardKey}
					call CheckShiny
				}
			}
			;first check our height if farther than ${Precision} away press and hold space as long as we are flying
			;we need to get to the correct height for current position we are ${Math.Distance[${Me.Y},${YHeight}]} away
			;check if we are even flying at all, if not start flight
			if !${Me.FlyingUsingMount} && ${Math.Distance[${Me.Y},${Y1}]}>25 && !${Me.InCombat} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -hold ${RI_Var_String_FlyUpKey}
				wait 1
				press -release ${RI_Var_String_FlyUpKey}
			}
			;now check if we are above or below desired height
			if  ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}>${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -release ${RI_Var_String_FlyUpKey}
				press -hold ${RI_Var_String_FlyDownKey}
				;wait 1
			}
			;above move up
			elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}<${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -release ${RI_Var_String_FlyDownKey}
				press -hold ${RI_Var_String_FlyUpKey}
				;wait 1
			}
			;below move down
			elseif ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
			{
				press -release ${RI_Var_String_FlyUpKey}
				press -release ${RI_Var_String_FlyDownKey}
				;wait 1
			}
			;face x,y,z position and press autorun key
			if !${Input.Button[${PauseMovementKey}].Pressed}
				Face ${X1} ${Z1}
			if !${Me.IsMoving} && !${Input.Button[${PauseMovementKey}].Pressed} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
			{
				;echo pressing autorun
				press ${RI_Var_String_AutoRunKey}
				wait 2
			}
			if ${Me.IsMoving} && ${Input.Button[${PauseMovementKey}].Pressed} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
				call StopAutoRun
			if ${UseRI_Var_String_ForwardKey} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement} && !${Me.FlyingUsingMount} && !${Me.IsSwimming}
				press -hold ${RI_Var_String_ForwardKey}
			if ${UseRI_Var_String_ForwardKey} && ( ${Input.Button[${PauseMovementKey}].Pressed} || ${RI_Var_Bool_PauseMovement} ) && !${Me.FlyingUsingMount} && !${Me.IsSwimming}
				press -release ${RI_Var_String_ForwardKey}
			if ${Input.Button[${RI_Var_String_ForwardKey}].Pressed} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
				press -release ${RI_Var_String_ForwardKey}
			;execute queued commands
			;call ExecuteQueued
			wait 1
		}
		if ${Math.Distance[${Me.Y},${Y1}]}>5 && !${UseRI_Var_String_ForwardKey} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
		{
			press ${RI_Var_String_BackwardKey}
			press ${RI_Var_String_BackwardKey}
			press ${RI_Var_String_BackwardKey}
		}
		elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${UseRI_Var_String_ForwardKey} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
			press -release ${RI_Var_String_ForwardKey}
		while ${Math.Distance[${Me.Y},${Y1}]}>5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && ${StartRZ} 
		{
			;check if we are paused
			call CheckPause
			;check if in combat
			if ${StopForCombat}
				call CheckCombat
			;first check our height if farther than ${Precision} away press and hold space as long as we are flying
			;we need to get to the correct height for current position we are ${Math.Distance[${Me.Y},${YHeight}]} away
			;check if we are even flying at all, if not start flight
			if !${Me.FlyingUsingMount} && ${Math.Distance[${Me.Y},${Y1}]}>25 && !${Me.InCombat} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -hold ${RI_Var_String_FlyUpKey}
				wait 1
				press -release ${RI_Var_String_FlyUpKey}
			}
			;now check if we are above or below desired height
			if  ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}>${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -release ${RI_Var_String_FlyUpKey}
				press -hold ${RI_Var_String_FlyDownKey}
				;wait 1
			}
			;above move up
			elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}<${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -release ${RI_Var_String_FlyDownKey}
				press -hold ${RI_Var_String_FlyUpKey}
				;wait 1
			}
			;below move down
			elseif ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${KeepMoving}
			{
				;echo we are there lets stop flying up or down
				press -release ${RI_Var_String_FlyUpKey}
				press -release ${RI_Var_String_FlyDownKey}
				;wait 1
			}
			wait 1
		}
		;stop flying up or down
		if !${KeepMoving}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
		}
		;press autorun key (stop move)
		if ${UseRI_Var_String_ForwardKey} && !${Me.FlyingUsingMount} && !${Me.IsSwimming}
		{
			if !${KeepMoving}
				press -release ${RI_Var_String_ForwardKey}
			elseif ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && ( ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}<${MPrecision} )
				press -release ${RI_Var_String_ForwardKey}
		}
		else
		{
			;echo not using forward key
			if ${Me.IsMoving} && !${KeepMoving}
				call StopAutoRun
		}
	}
	else
	{
		if ${Debug} 
			echo ${Time}: We are ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} away from ${X1} ${Y1} ${Z1} and our Collision Check is ${Me.CheckCollision[${Me.X},${Me.Y},${Me.Z},${X1},${Y1}${Z1}]}
		if ${Me.IsMoving} && !${UseRI_Var_String_ForwardKey}
			call StopAutoRun
		elseif ${UseRI_Var_String_ForwardKey} || ( !${Me.FlyingUsingMount} && !${Me.IsSwimming} )
			press -release ${RI_Var_String_ForwardKey}
	}
	if ${RI_Var_Bool_CancelMovement}
		RI_Var_Bool_CancelMovement:Set[FALSE]
}
function CheckCombat(bool FollowAfter=FALSE)
{

	
	; if ${Target.Name.Find[Luminox]}
	; {
		; if ${Target.Name.Find[Prime]}
			; call Prime
		; else
			; call Luminox
	; }	
	if (${Me.InCombat} || ${Me.IsHated}) && ${StartRZ} && !${GlobalOthers}
;	&& !${Target.Name.Find[Luminox]}
	{
		;check if we are paused
		;call CheckPause
		if ${Debug}
			echo ${Time}: Waiting while we fight!
		;turn on auto attack
		if !${Me.AutoAttackOn}
			eq2execute autoattack 1
		;stop moving
		if ${Me.FlyingUsingMount}
			call StopAutoRun
		else
			press -release ${RI_Var_String_ForwardKey}
		press -release x
		press -release space
		;fly down
		if ${Me.FlyingUsingMount}
			call FlyDown
		;stop follow
		call stopfollow
		;if set to lockforcombat, set it
		if ${LockForCombat} && (${Me.InCombat} || ${Me.IsHated})
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z},${Precision},100]
			;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z} ${Precision} 100
		;clear target incase we are targeting a ?
		if ${Target.Name.Equal[?]}
			eq2ex target_none
		while ( ${Me.InCombat} || ${Me.IsHated} ) && ${StartRZ}
		{
			if ${Debug}
				echo ${Time}: Waiting while we fight!
			;check if we are paused
			;call CheckPause
			;execute queued commands

			wait 1
		}
		;end lockspot
		relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
		;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot OFF
		if ${WaitForLootCorpses}
			wait 2
		;follow
		if ${FollowAfter}
			call follow
	}
}
function follow()
{
	if ${Debug}
		echo ${Time}: Starting Follow!
		; if ${ISXOgre(exists)}
			; relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom a_QueueCommand DoNotMove
		relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
		;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot OFF
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
		;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} ${Distance} 100
}
function stopfollow()
{	
	if ${Debug}
		echo ${Time}: Stopping Follow!
	wait 2
	relay "other ${RI_Var_String_RelayGroup}" -noredirect eq2execute stopfollow
	relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[OFF]
	;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetRIFollow OFF
}
function CheckPause()
{
	if ${RI_Var_Bool_Paused}
	{
		if ${Me.FlyingUsingMount}
			call StopAutoRun
		else
			press -release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_StrafeLeftKey}
		press -release ${RI_Var_String_StrafeRightKey}
		press -release ${RI_Var_String_FlyUpKey}
		press -release ${RI_Var_String_FlyDownKey}
	}
	while ${RI_Var_Bool_Paused}
	{
		;call ExecuteQueued
		wait 1
	}
}
function StopAutoRun()
{
	if ${Debug}
		echo ISXRI: ${Time} Stopping autorun
	press -release ${RI_Var_String_ForwardKey}
	do
	{
		press ${RI_Var_String_AutoRunKey}
		wait 2 !${Me.IsMoving}
	}
	while ${Me.IsMoving}
}
function FlyDown()
{
	;while we and the rest of our group are flying, relay press x
	relay ${RI_Var_String_RelayGroup} -noredirect press -hold ${RI_Var_String_FlyDownKey}
	while (${Me.FlyingUsingMount} || ${Me.Group[1].FlyingUsingMount} || ${Me.Group[2].FlyingUsingMount} || ${Me.Group[3].FlyingUsingMount} || ${Me.Group[4].FlyingUsingMount} || ${Me.Group[5].FlyingUsingMount})
	{
		;check if we are paused
		call CheckPause
		wait 2
	}
	wait 10
	relay ${RI_Var_String_RelayGroup} -noredirect press -release ${RI_Var_String_FlyDownKey}
}
function MoveC(float X1, float Z1, _Follow=TRUE)
{
	wait 20
	;start group following
	if ${_Follow}
	{
		call RIFollow
		wait 5
	}
	echo ${Time}: Moving to ${X1} ${Z1}
	
	;set lock spot to X1 Z1
	RI_Atom_SetLockSpot ${Me.Name} ${X1} 0 ${Z1}
	while ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>3
	{
		waitframe
	}
}
function MoveNF3(float X1, float Y1, float Z1)
{
	;wait 20

	;start group following
	;call RIFollow
	;wait 5
	;echo ${Time}: Moving to ${X1} ${Y1} ${Z1}
	
	;set lock spot to X1 Y1 Z1
	RI_Atom_SetLockSpot ${Me.Name} ${X1} ${Y1} ${Z1}
	while ${Math.Distance[${Me.Loc},${X1},${Y1},${Z1}]}>2
	{
		wait 1
	}
}
function MalduraFinder(string ZoneTo)
{
	echo ISXRI: Going To: ${ZoneTo}
	if ${ZoneTo.Find[Bar](exists)}
	{
		;i am at District
		if ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}<15
		{
			echo ISXRI: Moving From: Maldura: District of Ash [Heroic]
			call MoveFromDistrictToBB
		}
		;i am at Alg
		if ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}<15
		{
			echo ISXRI: Moving From: Maldura: Algorithm for Destruction [Heroic]
			call MoveFromAlgToBB
		}
		;i am at Palace
		if ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}<15
		{
			echo ISXRI: Moving From: Maldura: Palace Foray [Event Heroic]
			call MoveFromPalaceToBB
		}
	}
	elseif ${ZoneTo.Find[Algorithm](exists)}
	{
		;i am at District
		if ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}<15
		{
			echo ISXRI: Moving From: Maldura: District of Ash [Heroic]
			call MoveFromDistrictToAlg
		}
		;i am at BB
		if ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}<15
		{
			echo ISXRI: Moving From: Maldura: Bar Brawl [Event Heroic]
			call MoveFromBBToAlg
		}
		;i am at Palace
		if ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}<15
		{
			echo ISXRI: Moving From: Maldura: Palace Foray [Event Heroic]
			call MoveFromPalaceToAlg
		}
	}
	elseif ${ZoneTo.Find[District](exists)}
	{
		;i am at BB
		if ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}<15
		{
			echo ISXRI: Moving From: Maldura: Bar Brawl [Event Heroic]
			call MoveFromBBToDistrict
		}
		;i am at Alg
		if ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}<15
		{
			echo ISXRI: Moving From: Maldura: Algorithm for Destruction [Heroic]
			call MoveFromAlgToDistrict
		}
		;i am at Palace
		if ${Math.Distance[${Me.Loc},202.524216,66.070686,-1.015480]}<15
		{
			echo ISXRI: Moving From: Maldura: Palace Foray [Event Heroic]
			call MoveFromPalaceToDistrict
		}
	}
	elseif ${ZoneTo.Find[Palace](exists)}
	{
		;i am at District
		if ${Math.Distance[${Me.Loc},-107.588409,1.464843,-45.882183]}<15
		{
			echo ISXRI: Moving From: Maldura: District of Ash [Heroic]
			call MoveFromDistrictToPalace
		}
		;i am at Alg
		if ${Math.Distance[${Me.Loc},-107.899620,1.360249,45.699463]}<15
		{
			echo ISXRI: Moving From: Maldura: Algorithm for Destruction [Heroic]
			call MoveFromAlgToPalace
		}
		;i am at BB
		if ${Math.Distance[${Me.Loc},-68.632019,9.525129,118.591179]}<15
		{
			echo ISXRI: Moving From: Maldura: Bar Brawl [Event Heroic]
			call MoveFromBBToPalace
		}
	}
}
function MoveFromBBToAlg()
{
	call MoveFromBBToCenterEast
	call MoveFromCenterEastToAlgorithm
}
function MoveFromBBToDistrict()
{
	call MoveFromBBToCenterEast
	call MoveFromCenterEastToDistrict
}
function MoveFromBBToPalace()
{
	call MoveFromBBToCenterEast
	call MoveFromCenterEastToCenterWest
	call MoveFromCenterWestToPalace
}
function MoveFromAlgToBB()
{
	call MoveFromAlgorithmToCenterEast
	call MoveFromCenterEastToBB
}
function MoveFromAlgToDistrict()
{
	call MoveFromAlgorithmToCenterEast
	call MoveFromCenterEastToDistrict
}
function MoveFromAlgToPalace()
{
	call MoveFromAlgorithmToCenterWest
	call MoveFromCenterWestToPalace
}
function MoveFromDistrictToBB()
{
	call MoveFromDistrictToCenterEast
	call MoveFromCenterEastToBB
}
function MoveFromDistrictToAlg()
{
	call MoveFromDistrictToCenterWest
	call MoveFromCenterWestToAlgorithm
}
function MoveFromDistrictToPalace()
{
	call MoveFromDistrictToCenterWest
	call MoveFromCenterWestToPalace
}
function MoveFromPalaceToAlg()
{
	call MoveFromPalaceToCenterWest
	call MoveFromCenterWestToAlgorithm
}
function MoveFromPalaceToDistrict()
{
	call MoveFromPalaceToCenterWest
	call MoveFromCenterWestToDistrict
}
function MoveFromPalaceToBB()
{
	call MoveFromPalaceToCenterWest
	call MoveFromCenterWestToCenterEast
	call MoveFromCenterEastToBB
}
function MoveFromCenterWestToCenterEast()
{
	call MoveNF3 -96.561684 1.333169 2.435470
	call MoveNF3 -101.754234 1.333471 11.028763
	call MoveNF3 -111.592079 1.333889 13.133477
	call MoveNF3 -118.659782 1.333385 5.781046
	call MoveNF3 -119.749695 1.333358 0.398619
}
function MoveFromBBToCenterEast()
{
	call MoveNF3 -74.987793 8.953678 121.594414
	call MoveNF3 -84.854172 8.741453 119.465195
	call MoveNF3 -94.254158 7.550994 115.606918
	call MoveNF3 -102.937462 5.106602 111.125481
	call MoveNF3 -111.784805 2.941614 106.436958
	call MoveNF3 -119.963387 0.421129 101.066185
	call MoveNF3 -127.897781 -2.980700 95.388550
	call MoveNF3 -135.921967 -4.219001 89.157715
	call MoveNF3 -142.551773 -7.624911 82.107994
	call MoveNF3 -147.927673 -8.031591 73.413498
	call MoveNF3 -153.103882 -7.718341 64.181427
	call MoveNF3 -157.727295 -7.699974 54.570038
	call MoveNF3 -161.447632 -7.545240 45.128490
	call MoveNF3 -165.033966 -7.571215 35.616474
	call MoveNF3 -167.568115 -7.745778 25.339172
	call MoveNF3 -168.498322 -7.555120 15.165951
	call MoveNF3 -165.485611 -6.921866 5.490453
	call MoveNF3 -157.057266 -6.081460 -0.326506
	call MoveNF3 -147.792191 -1.905953 -1.152804
	call MoveNF3 -137.853607 -1.811615 0.231563
	call MoveNF3 -128.031769 0.868079 0.545507
	call MoveNF3 -119.745110 1.333356 0.574359

}
function MoveFromDistrictToCenterEast()
{
	call MoveNF3 -107.588409 1.464843 -45.882183
	call MoveNF3 -107.518822 1.544127 -35.855019
	call MoveNF3 -107.688492 1.544120 -25.837738
	call MoveNF3 -109.189613 1.483117 -15.816957
	call MoveNF3 -115.078377 1.332909 -7.555491
	call MoveNF3 -119.443909 1.333226 1.046711
}
function MoveFromDistrictToCenterWest()
{
	call MoveNF3 -108.110458 1.527551 -46.323360
	call MoveNF3 -106.414383 1.544125 -36.299629
	call MoveNF3 -106.109436 1.544121 -26.292387
	call MoveNF3 -105.414413 1.494619 -16.239443
	call MoveNF3 -100.335434 1.333001 -7.507511
	call MoveNF3 -96.269058 1.333248 1.470333
}
function MoveFromAlgorithmToCenterEast()
{
	call MoveNF3 -107.899620 1.360249 45.699463
	call MoveNF3 -108.552261 1.541995 35.522964
	call MoveNF3 -109.209106 1.519127 25.540161
	call MoveNF3 -110.352814 1.498703 15.539167
	call MoveNF3 -115.465210 1.332481 6.891775
	call MoveNF3 -118.796013 1.332946 0.674744
}
function MoveFromAlgorithmToCenterWest()
{
	call MoveNF3 -107.932632 1.547165 48.023392
	call MoveNF3 -107.219864 1.541990 38.003262
	call MoveNF3 -107.019325 1.541988 27.986483
	call MoveNF3 -105.920990 1.511162 17.820841
	call MoveNF3 -101.354004 1.332714 8.708767
}
function MoveFromPalaceToCenterWest()
{
	call MoveNF3 192.761948 63.795761 -1.046231
	call MoveNF3 182.744354 63.796738 -1.104314
	call MoveNF3 172.533356 63.807709 -1.117245
	call MoveNF3 162.307053 63.759064 -1.130196
	call MoveNF3 152.353470 61.701675 -1.142801
	call MoveNF3 142.112000 62.258053 -1.155771
	call MoveNF3 131.933136 62.177505 -1.069386
	call MoveNF3 121.778931 61.686459 -0.333621
	call MoveNF3 111.776169 61.630856 0.395978
	call MoveNF3 101.758301 61.337959 1.126680
	call MoveNF3 91.891518 59.751373 1.846360
	call MoveNF3 82.033752 57.700142 1.369395
	call MoveNF3 72.557419 54.833401 -0.610031
	call MoveNF3 62.993145 51.995277 -2.612994
	call MoveNF3 53.409676 49.945824 -5.118948
	call MoveNF3 42.956539 49.320534 -6.211683
	call MoveNF3 33.878460 45.383678 -3.559703
	call MoveNF3 25.548120 41.218243 0.104685
	call MoveNF3 15.825115 38.574142 -0.653403
	call MoveNF3 6.605190 34.685101 -0.850443
	call MoveNF3 -2.450275 30.065004 -0.597008
	call MoveNF3 -11.413877 25.637964 -0.291770
	call MoveNF3 -21.304764 22.576492 -0.124891
	call MoveNF3 -30.864052 19.224083 -0.041291
	call MoveNF3 -40.241554 14.907271 0.040719
	call MoveNF3 -49.194870 10.069301 0.119020
	call MoveNF3 -58.890507 6.697672 0.203812
	call MoveNF3 -68.843689 4.274456 0.290857
	call MoveNF3 -79.054451 4.087050 0.373791
	call MoveNF3 -89.248512 3.231163 0.289442
	call MoveNF3 -96.261322 1.333251 0.441733
}
function MoveFromCenterEastToDistrict()
{
	call MoveNF3 -118.796013 1.332946 0.674744
	call MoveNF3 -114.393547 1.332971 -8.334318
	call MoveNF3 -109.788170 1.527551 -17.528275
	call MoveNF3 -107.456436 1.544124 -27.415716
	call MoveNF3 -107.164772 1.544123 -37.508636
	call MoveNF3 -107.588409 1.464843 -45.882183
}
function MoveFromCenterEastToAlgorithm()
{
	call MoveNF3 -118.328964 1.333039 4.647811
	call MoveNF3 -111.849747 1.333648 12.492848
	call MoveNF3 -106.485893 1.360261 21.116299
	call MoveNF3 -105.274956 1.541993 31.181787
	call MoveNF3 -107.614853 1.527540 40.921227
	call MoveNF3 -107.899620 1.360249 45.699463
}
function MoveFromCenterEastToBB()
{
	call MoveNF3 -122.441010 1.498703 0.474294
	call MoveNF3 -132.529449 -0.415226 0.004875
	call MoveNF3 -142.639618 -1.857636 0.256313
	call MoveNF3 -152.627243 -4.049346 0.725432
	call MoveNF3 -162.461166 -6.586624 1.333190
	call MoveNF3 -168.980423 -6.933326 9.138783
	call MoveNF3 -168.672958 -7.888989 19.327946
	call MoveNF3 -165.479126 -7.616230 29.035858
	call MoveNF3 -162.259827 -7.072036 38.660103
	call MoveNF3 -159.025543 -7.545322 48.329437
	call MoveNF3 -154.942352 -7.718052 57.696407
	call MoveNF3 -150.388641 -7.718277 66.852715
	call MoveNF3 -145.427628 -7.842994 75.837799
	call MoveNF3 -139.628647 -6.933485 84.238777
	call MoveNF3 -132.694412 -3.029800 90.384697
	call MoveNF3 -124.822319 -2.584181 96.839294
	call MoveNF3 -117.498993 1.587271 102.223701
	call MoveNF3 -108.872444 4.243935 106.902153
	call MoveNF3 -100.000893 5.106598 111.580147
	call MoveNF3 -91.437553 8.659725 116.095612
	call MoveNF3 -82.293884 8.574335 120.176414
	call MoveNF3 -72.427734 9.132478 121.798759
	call MoveNF3 -68.632019 9.525129 118.591179
}
function MoveFromCenterWestToDistrict()
{
	call MoveNF3 -96.655060 1.333081 0.716211
	call MoveNF3 -101.269440 1.333009 -8.378657
	call MoveNF3 -106.372986 1.527551 -17.175358
	call MoveNF3 -108.776642 1.544123 -27.055979
	call MoveNF3 -108.344147 1.544124 -37.177406
	call MoveNF3 -107.588409 1.464843 -45.882183
}
function MoveFromCenterWestToAlgorithm()
{
	call MoveNF3 -96.966721 1.333022 2.642747
	call MoveNF3 -102.270111 1.333547 11.541652
	call MoveNF3 -106.911255 1.360490 20.586712
	call MoveNF3 -108.066223 1.541993 30.541306
	call MoveNF3 -107.957497 1.528404 40.872646
	call MoveNF3 -107.899620 1.360249 45.699463
}
function MoveFromCenterWestToPalace()
{
	call MoveNF3 -96.564697 1.333120 0.045436
	call MoveNF3 -86.925285 4.021127 0.132103
	call MoveNF3 -76.545097 4.087046 0.194072
	call MoveNF3 -66.379692 4.826190 0.145704
	call MoveNF3 -56.623211 7.378497 0.099282
	call MoveNF3 -47.063675 11.035548 0.053797
	call MoveNF3 -37.988934 16.053326 0.010618
	call MoveNF3 -28.535440 20.128014 -0.034362
	call MoveNF3 -18.703203 23.377699 -0.081145
	call MoveNF3 -9.098212 26.810278 -0.126846
	call MoveNF3 0.097734 31.404289 -0.170601
	call MoveNF3 9.263380 35.987278 -0.214212
	call MoveNF3 18.747171 39.928371 -0.259337
	call MoveNF3 28.539454 42.695728 -1.256736
	call MoveNF3 37.373001 46.593834 -4.018705
	call MoveNF3 46.676357 49.742569 -6.095671
	call MoveNF3 56.641201 50.857754 -5.265169
	call MoveNF3 66.335556 52.678940 -3.540220
	call MoveNF3 75.752686 56.332909 -1.728288
	call MoveNF3 85.668022 58.539101 -0.444260
	call MoveNF3 95.690346 60.553802 0.539063
	call MoveNF3 105.837959 61.560116 0.406833
	call MoveNF3 115.968864 61.630840 0.105912
	call MoveNF3 126.283028 61.686424 -0.135682
	call MoveNF3 136.568420 62.258053 -0.305492
	call MoveNF3 146.581207 62.197403 -0.470801
	call MoveNF3 156.684799 61.701645 -0.637610
	call MoveNF3 166.576431 63.878624 -0.800918
	call MoveNF3 176.770905 63.808289 -0.972683
	call MoveNF3 186.842346 63.796539 -1.155712
	call MoveNF3 197.021561 63.791595 -0.978441
	call MoveNF3 202.524216 66.070686 -1.015480
}
function MoveFromCenterEastToCenterWest()
{
	call MoveNF3 -119.443909 1.333226 1.046711
	call MoveNF3 -114.377823 1.333057 9.698290
	call MoveNF3 -104.747360 1.333647 12.699495
	call MoveNF3 -98.039307 1.332917 5.236200
	call MoveNF3 -96.564697 1.333120 0.045436
}
function RIFollow()
{
	echo ${Time}: Setting RIFollow
	if ${ISXOgre(exists)}
		relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom a_LetsGo all
	
	relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} 1 100
}
function atexit()
{
	if !${DontEchoExit}
	{
		echo ${Time}: Ending RZ
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RZo.xml"
	}
}