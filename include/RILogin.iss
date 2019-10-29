variable int numSets=0
variable int countds=0
variable string strLogin
variable string strPassword
variable string strServer
variable(global) bool RI_Var_Bool_RILoginDebug=FALSE
function main(string ToonName=!Blank!, bool LoadCB=FALSE)
{
	;disable debugging
	Script:DisableDebugging
	
	;wait until isxeq2 is ready
	wait 300 ${ISXEQ2.IsReady}
	
	if ${ISXEQ2.IsReady}
		noop
	else
	{
		echo ISXRI: Failed to login toon ${ToonName}, ISXEQ2 appears not ready after 30s
		Script:End
	}
	
	if ${ToonName.Find[Debug](exists)}
	{
		RI_Var_Bool_RILoginDebug:Set[TRUE]
		ToonName:Set[${ToonName.Left[-6]}]
		;echo ${ToonName}
		;return
	}
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	
	;echo ${ToonName.Upper}
	if ${ToonName.Upper.Equal[IMPORTOGRE]}
	{
		;echo import
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private/"]
		if !${FP.PathExists}
		{	
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
			FP:MakeSubdirectory[Private]	
			FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private/"]
		}
		if ${FP.FileExists[RICharList.xml]}
		{
			echo ISXRI: Deleting "${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"
			rm "${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"
		}
		wait 5
		FP:Set["${LavishScript.HomeDirectory}/Scripts/EQ2OgreCommon/DoNotShareWithOthers/"]
		if ${FP.FileExists[EQ2Chars.xml]}
		{
			echo ISXRI: Copying "${LavishScript.HomeDirectory}/Scripts/EQ2OgreCommon/DoNotShareWithOthers/EQ2Chars.xml" to: "${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"
			cp "${LavishScript.HomeDirectory}/Scripts/EQ2OgreCommon/DoNotShareWithOthers/EQ2Chars.xml" "${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"
		}
		else
		{
			ISXRI: Can not find EQ2Chars.xml, copy manually
		}
		Script:End
		;echo end import
	}
	if ${ToonName.Equal[!Blank!]}
	{
		echo ISXRI: Usage RILogin ToonName, or RILogin ImportOgre to import ogre's EQ2Chars.xml
		Script:End
	}
	if ${ToonName.Equal[${Me.Name}]}
	{
		echo ISXRI: Already logged in to ${ToonName}
		wait 5
		if ${LoadCB}
			timedcommand 5 RI_CB
		Script:End
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/Private/"]
	if !${FP.FileExists["RICharList.xml"]}
	{
		echo ISXRI: Error loading RICharList.xml
		Script:End
	}
	
	variable CountSetsObject CountSets
	LavishSettings[Login]:Clear
	LavishSettings:AddSet[Login]
	LavishSettings[Login]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
	variable settingsetref Set2
	Set2:Set[${LavishSettings[Login].GUID}]
	;echo Set: ${CountSets.Count[${Set2}]}==0
	numSets:Set[${CountSets.Count[${Set2}]}]
	;variable int FailCounter=0
	; while ${CountSets.Count[${Set2}]}<1 && ${FailCounter:Inc}<10
	; {
		; if ${RI_Var_Bool_RILoginDebug}
			; echo ${Script.RunningTime} ISXRI: Set: ${CountSets.Count[${Set2}]}==0
		; LavishSettings[Login]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		; Set2:Set[${LavishSettings[Login].GUID}]
		; numSets:Set[${CountSets.Count[${Set2}]}]
		; wait 5
	; }
	; if ${FailCounter}>=10
	; {
		; echo ISXRI: Error loading RICharList.xml settings file, could be a corrupt file
		; Script:End
	; }
	;echo numSets:${numSets}
	declare strSets[${numSets}] string script
	if ${CountSets.Count[${Set2}]}==0
		echo ISXRI: Error loading RICharList.xml
	;echo ${strSets.Size}
	;call echoSets
	
	;now search through each set for ${ToonName} 
	if ${CountSets.FindLoginInfo[${Set2},${ToonName}]}==1
	{
		echo ISXRI: Logging in ${ToonName} on "${strServer}"
		if ${Zone.Name.NotEqual[LoginScene]}
		{
			echo ISXRI: Not at LoginScene, camping
			eq2ex camp login
			wait 300
			if ${Zone.Name.NotEqual[LoginScene]}
			{
				echo ISXRI: Failed to camp to LoginScene
				Script:End
			}
		}
		call LogToonIn ${ToonName} ${strLogin} ${strPassword} "${strServer}"
	}
	else
	{
		echo ISXRI: ${ToonName} not found in RICharList.xml
		Script:End
	}
	Set2:Clear
	LavishSettings[Login]:Clear
	wait 600 ${Me.InGameWorld}
	wait 600 ${Me.Name(exists)}
	;echo LoadCB: ${LoadCB} / ToonName: ${ToonName} == ${Me.Name} / InGameWorld: ${Me.InGameWorld}
	if ${Me.Name.Equal[${ToonName}]} && ${Me.InGameWorld} && ${LoadCB}
	{
		RI_CB
		eq2ex allaccess claim
	}
	if !${Me.Name.Equal[${ToonName}]} && ${Me.InGameWorld}
		echo ISXRI: Failed to login ${ToonName}, or login timedout
}
function LogToonIn(string ltiToonname, string ltiLogin, string ltiPassword, string ltiServer)
{
	variable int count=0
	for(count:Set[1];${count}<=5;count:Inc)
	{
		MouseClick -hold right
		wait 1
		MouseClick -release right 	
		wait 1
	}
	EQ2UIPage[LoginScene,LSUsernamePassword].Child[Textbox,WindowPage.AutoPlayChar]:SetProperty[Text,"${ltiToonname}"]
	EQ2UIPage[LoginScene,LSUsernamePassword].Child[Textbox,WindowPage.Password]:SetProperty[Text,"${ltiPassword}"]
	EQ2UIPage[LoginScene,LSUsernamePassword].Child[Textbox,WindowPage.Username]:SetProperty[Text,"${ltiLogin}"]
	EQ2UIPage[LoginScene,LSUsernamePassword].Child[Textbox,WindowPage.AutoPlayWorld]:SetProperty[Text,"${ltiServer}"]
	
	wait 10
	EQ2UIPage[LoginScene,LSUsernamePassword].Child[Button,LSUsernamePassword.WindowPage.ConnectButton]:LeftClick
	
	wait 1800 ${Me.InGameWorld} && ${Me.Name.Equal[${ltiToonname}]}
	if ${Me.InGameWorld} && ${Me.Name.Equal[${ltiToonname}]}
	{
		wait 10
		if ${EQ2.Zoning}==0
			eq2ex allaccess claim
	}
	else
	{
		echo ISXRI: Unable to login ${ltiToonname}
	}
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
	member:int FindLoginInfo(settingsetref Set4, string ToonName)
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
				;echo ${Iterator.Key}
				if ${Iterator.Key.Equal[${ToonName}]}
				{
					if ${RI_Var_Bool_RILoginDebug}
					{
						echo ${Script.RunningTime} ISXRI: Toon: ${ToonName}
						echo ${Script.RunningTime} ISXRI: Login: ${Set3.Name}
						echo ${Script.RunningTime} ISXRI: Password: ${Set3.FindSetting[Password]}
						echo ${Script.RunningTime} ISXRI: Server: ${Set3.FindSet[${ToonName}].FindSetting[Server]}
					}	
					strLogin:Set[${Set3.Name}]
					strPassword:Set[${Set3.FindSetting[Password]}]
					strServer:Set["${Set3.FindSet[${ToonName}].FindSetting[Server]}"]
					return 1
				}
			}
			while ${Iterator:Next(exists)}
		}
		return 0
	}
}
function atexit()
{
	Set2:Clear
	LavishSettings[Login]:Clear
	;TimedCommand 600 eq2ex allaccess claim
	;TimedCommand 610 EQ2UIPage[MainHUD,Welcome]:Close
}