
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	;create lavishsetting and import from isxri.xml
	LavishSettings[ISXRIAuth]:Clear
	LavishSettings:AddSet[ISXRIAuth]
	LavishSettings[ISXRIAuth]:AddSet[Authentication]
	LavishSettings[ISXRIAuth]:Import["${LavishScript.HomeDirectory}/Extensions/ISXRI.xml"]
	setter:Set[${LavishSettings[ISXRIAuth].FindSet[Authentication]]
	
	;if login setting does not exists create it
	if !${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login](exists)}
	{
		;echo adding Login
		LavishSettings[ISXRIAuth].FindSet[Authentication]:AddSetting[Login,""]
	}
	
	;if password setting does not exist create it
	if !${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Password](exists)}
	{
		;echo adding Password
		LavishSettings[ISXRIAuth].FindSet[Authentication]:AddSetting[Password,""]
	}
	
	;echo ${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login]}
	;echo ${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Password]}
	
	;get login
	InputBox "Enter ISXRI Login"	"${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login]}" 
	variable string Login
	Login:Set[${UserInput}]
	while ${Login.Equal[NULL]}
	{
		InputBox "Enter ISXRI Login"	"${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login]}" 
		Login:Set[${UserInput}]
		wait 1
	}
	;save login

	;clear out the set if it exists
	if ${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login](exists)}
	{
		;echo removing login
		LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login]:Remove
	}
	
	;add Login
	LavishSettings[ISXRIAuth].FindSet[Authentication]:AddSetting[Login,${UserInput}]
	
	;get password
	InputBox "Enter ISXRI Password" "${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Password]}"
	variable string Password
	Password:Set[${UserInput}]
	while ${Password.Equal[NULL]}
	{
		InputBox "Enter ISXRI Password" "${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Password]}"
		Password:Set[${UserInput}]
		wait 1
	}
	;save password
	;clear out the set if it exists
	if ${LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Login](exists)}
	{
		;echo removing password
		LavishSettings[ISXRIAuth].FindSet[Authentication].FindSetting[Password]:Remove
	}
	
	;add Password
	LavishSettings[ISXRIAuth].FindSet[Authentication]:AddSetting[Password,${UserInput}]
	
	MessageBox "Saved"
	
	;echo ${UserInput}
	
	LavishSettings[ISXRIAuth]:Export["${LavishScript.HomeDirectory}/Extensions/ISXRI.xml"]
	LavishSettings[ISXRIAuth]:Clear
	;echo Saved file: "${LavishScript.HomeDirectory}/Extensions/ISXRI.xml"
	echo ISXRI: Authentication information updated, reload ISXRI on all intended sessions
	relay all -noredirect execute \${If[\${Extension[ISXRI.dll](exists)},ext -unload ISXRI]}
}