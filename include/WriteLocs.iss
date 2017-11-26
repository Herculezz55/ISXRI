;#include Moveinc.iss

;WriteLocs Script - WriteLocs.iss Ver 1A
;Written by Herculezz Ver 1A 7-21-14
;script to write X,Y,Z Locs to File
;
;
;
;
;
;;;;;;;;;;;;IMPORTANT, the logic to find the closest way point is to read first line in file
;;;;;;;;;;;;;;;;;;;;;;; then compare it to current position and store the distance and loc in 2 temp vars
;;;;;;;;;;;;;;;;;;;;;; then read the second line and compare to current position and then compare that
;;;;;;;;;;;;;;;;;;;;;;; distance to the tempvar distance if its less then store its distance and loc in the 2 temp vars and so on till the end of the file
;;;;;;;;;;;;;;;;;;;; but also maybe should check LOS to the location very first because if we dont have los no sense in comparing or storing the vars
;;;;;;;;;;;;;;;;;;;; also need to store the position prior to reading the line so we can know where to seek to!!!
;
;
;
;
variable file Filename
variable filepath FP
variable string LastXYZ=0,0,0
variable string LastXYZC=0,0,0
variable int TEDistance=10
variable bool Auto=FALSE
variable bool Debug=TRUE
variable string NamedName
variable bool SFC=TRUE
variable(global) string RIWriteLocsScriptName=${Script.Filename}
variable bool TestRun=FALSE
variable bool _quest=FALSE
variable bool MoveToLoc=0
variable string MoveToLocLoc
;main function
function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if WriteLocs.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[WriteLocs.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting WriteLocs.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/WriteLocs.xml" http://www.isxri.com/WriteLocs.xml
		wait 50
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[ZoneFiles]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"]
	}
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/WriteLocs.xml"
	
	; UIElement[WriteLocs].FindChild[WriteLOC]:Hide
	; UIElement[WriteLocs].FindChild[ClickActor]:Hide
	; UIElement[WriteLocs].FindChild[HailActor]:Hide
	; UIElement[WriteLocs].FindChild[Named]:Hide
	; UIElement[WriteLocs].FindChild[Auto]:Hide
	; UIElement[WriteLocs].FindChild[Wait]:Hide
	; UIElement[WriteLocs].FindChild[Custom]:Hide
	; UIElement[WriteLocs].FindChild[StopForCombat]:Hide
	; UIElement[WriteLocs].FindChild[TEDistance]:SetText[${TEDistance}]
	; UIElement[WriteLocs].FindChild[StopForCombat].Font:SetColor[FF32CD32]
	
	echo ISXRI: Starting WriteLocs
	
	variable int _count
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		switch ${args[${_count}]}
		{
			case -quest
			{
				;echo ${args.Used}
				;echo ${args[2]}
				_quest:Set[TRUE]
				UIElement[TEFilename@WriteLocs]:SetText["${args[${Math.Calc[${_count}+1]}].Replace[".",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}.dat"]
				call Write 0 0 0 0 0 -quest "${args[${Math.Calc[${_count}+1]}]}"
				break
			}
			default
				noop
		}
	}
	
	UIElement[TEDistance@WriteLocs]:SetText[10]
	if !${_quest}
		UIElement[TEFilename@WriteLocs]:SetText[${Me.GetGameData[Self.ZoneName].Label.Replace[" ",""].Replace["'",""].Replace[":",""].Replace["[",,""].Replace["]",""].Replace[",",""]}.dat]
	
	;echo ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
	if ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: Loading "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
		
		WLImportZoneFile "${UIElement[TEFilename@WriteLocs].Text}"
		UIElement[Save@WriteLocs]:SetText[Save]
	}
	
	do 
	{
		call ExecuteQueued
		wait 1
		if ${Auto}
			call Auto ${TEDistance}
		if ${TestRun}
			call TestRun
		if ${MoveToLoc}
			call MoveToLocFN
	}
	while 1
}
function ExecuteQueued()
{
	;execute queued commands
	if ${QueuedCommands}
		ExecuteQueued
}
atom(global) WriteLocsTEDistance()
{
	TEDistance:Set[${Int[${UIElement[TEDistance@WriteLocs].Text}]}]
	;echo Settings Distance to ${TEDistance}
}
atom WLImportZoneFile(string ZoneFileName)
{
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"
	;check if ZineFileName exists, if not end
	if !${FP.FileExists[${ZoneFileName}]}
	{
		echo ISXRI: Missing ZoneFile: "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"
		return
	}
	
	variable file Filename
	variable int Count
	
	variable string TempString
	istrMain:Clear
	Count:Set[1]
	;set file to read in to Filename variable
	Filename:SetFilename["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"]

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
		UIElement[LocsList@WriteLocs]:AddItem["${TempString.Left[-1]}"]
		;echo Adding ${istrMain.Get[${Count}]} to istrMain Variable in Element ${Count}
		Count:Inc
		;waitframe
	}
	
	;close file
	Filename:Close
}
atom(global) MoveToLoc(string _Loc)
{
	MoveToLocLoc:Set["${_Loc}"]
	MoveToLoc:Set[1]
	UIElement[LocsList@WriteLocs]:ClearSelection
}
function MoveToLocFN()
{
	MoveToLoc:Set[0]
	RI_Var_Bool_Start:Set[TRUE]
	call RIMObj.Move ${MoveToLocLoc.Replace[","," "]} 1 0 FALSE FALSE TRUE FALSE
	RI_Var_Bool_Start:Set[FALSE]
}
function Save()
{
	if ${UIElement[TEFilename@WriteLocs].Text.NotEqual[""]}
	{
		if !${UIElement[TEFilename@WriteLocs].Text.Upper.Find[".DAT"](exists)}
		{
			MessageBox -skin eq2 "please include the .dat extension in your filename"
			return
		}
		if ${UIElement[Save@WriteLocs].Text.Equal[Load]}
		{
			;echo "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
			;echo ${FP}
			;echo ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			;check if the file (${UIElement[TEFilename@WriteLocs].Text}) exists, if so import into listbox, else create
			if ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			{
				
				if ${RI_Var_Bool_Debug}
					echo ISXRI: Loading "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
				UIElement[LocsList@WriteLocs]:ClearItems
				WLImportZoneFile "${UIElement[TEFilename@WriteLocs].Text}"
				UIElement[Save@WriteLocs]:SetText[Save]
			}
			else
			{
				UIElement[Save@WriteLocs]:SetText[Save]
			}
		}
		else
		{
			;echo "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
			;echo ${FP}
			;echo ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			;check if the file (${UIElement[TEFilename@WriteLocs].Text}) exists, if so import into listbox, else create
			if ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			{
				MessageBox -skin eq2 -yesno "ZoneFile: ${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text} Exists, Are you sure you want to overwrite?"
				if ${UserInput.Equal[No]}
				{
					MessageBox -skin eq2 "File Not Saved"
					return
				}
			}
			Filename:SetFilename["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"]
			;echo ${Filename}
			Filename:Open
			Filename:Truncate
			
			; UIElement[WriteLocs].FindChild[Save]:Hide
			; UIElement[WriteLocs].FindChild[Filename]:Hide
			; UIElement[WriteLocs].FindChild[TEFilename]:Hide
			; UIElement[WriteLocs].FindChild[Distance]:Hide
			; UIElement[WriteLocs].FindChild[TEDistance]:Hide
			; UIElement[WriteLocs].FindChild[WriteLOC]:Show
			; UIElement[WriteLocs].FindChild[WriteLOC]:SetFocus
			; UIElement[WriteLocs].FindChild[ClickActor]:Show
			; UIElement[WriteLocs].FindChild[HailActor]:Show
			; UIElement[WriteLocs].FindChild[Named]:Show
			; UIElement[WriteLocs].FindChild[Wait]:Show
			; UIElement[WriteLocs].FindChild[Custom]:Show
			; UIElement[WriteLocs].FindChild[Auto]:Show
			; UIElement[WriteLocs].FindChild[StopForCombat]:Show
			;forloop to reset zones in AddedZoneList
			variable int count
			for (count:Set[1];${count}<=${UIElement[LocsList@WriteLocs].Items};count:Inc)
			{
				echo Writing "${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}" to file
				Filename:Write["${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}\n"]
			}
			
			Filename:Flush
			Filename:Close
			MessageBox -skin eq2 "Saved File Name as ${Filename}"
		}
	}
	else
	{
		MessageBox "You must enter a valid File Name"
	}
}
;atom(global) TestRun()
;{
;	if ${TestRun}
;		TestRun:Set[FALSE]
;	else
;		TestRun:Set[TRUE]
;}
function RPB()
{
	relay all RIMUIObj:SetRIFollow[ALL,${Me.ID},1,200]
	variable int count
	for (count:Set[${UIElement[LocsList@WriteLocs].Items}];${count}>=1;count:Dec)
	{
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Custom]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[ClickActor]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[HailActor]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Dec
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Wait]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Dec
			wait ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Named]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Dec
			count:Dec
			count:Dec
			count:Dec
			count:Dec
			continue
		}
		echo Running TO "${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}"
		;Filename:Write["${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}\n"]
		call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]} 1 0 FALSE FALSE TRUE TRUE
		wait 1
	}
	call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[1]} 1 0 FALSE FALSE TRUE FALSE
	call FlyDownIfYHI ${UIElement[LocsList@WriteLocs].OrderedItem[1]}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	press -release ${RI_Var_String_ForwardKey}
	;TestRun:Set[FALSE]
	
}
function FlyDownIfYHI(float _X, float _Y, float _Z)
{
	if ${Math.Distance[${Me.Y,${_Y}}]}>5
		call RIMObj.FlyDown
}
function RP()
{
	relay all RIMUIObj:SetRIFollow[ALL,${Me.ID},1,200]
	variable int count
	for (count:Set[1];${count}<${UIElement[LocsList@WriteLocs].Items};count:Inc)
	{
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Custom]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[ClickActor]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[HailActor]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Inc
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Wait]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Inc
			wait ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Named]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Inc
			count:Inc
			count:Inc
			count:Inc
			count:Inc
			continue
		}
		echo Running TO "${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}"
		;Filename:Write["${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}\n"]
		call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]} 1 0 FALSE FALSE TRUE TRUE
		; if !${TestRun}
		; {
			; press -release ${RI_Var_String_FlyUpKey}
			; press -release ${RI_Var_String_FlyDownKey}
			; press -release ${RI_Var_String_ForwardKey}
			; return
		; }
		wait 1
	}
	call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[${UIElement[LocsList@WriteLocs].Items}]} 1 0 FALSE FALSE TRUE FALSE
	call FlyDownIfYHI ${UIElement[LocsList@WriteLocs].OrderedItem[${UIElement[LocsList@WriteLocs].Items}]}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	press -release ${RI_Var_String_ForwardKey}
	TestRun:Set[FALSE]
}
function Write(... _args)
{
;bool Custom, bool ClickActor, bool HailActor, bool Named, bool Wait,
	LastXYZ:Set["${Me.X} ${Me.Y} ${Me.Z}"]
	LastXYZC:Set["${Me.X},${Me.Y},${Me.Z}"]

	variable int _count
	for(_count:Set[1];${_count}<=${_args.Used};_count:Inc)
	{
		switch ${_args[${_count}]}
		{
			case -quest
			{
				UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+1]}]}"]
				break
			}
			case -wait
			{
				if ${_args.Used}>1
				{
					UIElement[LocsList@WriteLocs]:AddItem["Wait"]
					UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+1]}]}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				else
				{
					InputBox -skin eq2 "Enter Wait Time"
					while ${UserInput.Equal[""]} 
					{
						MessageBox -skin eq2 "You must enter a wait time"
						InputBox -skin eq2 "Enter Wait Time"
						wait 1
					}
					if ${String[${UserInput}].Equal[NULL]}
						return
					if ${RI_Var_Bool_Debug}
						echo Adding Wait for ${UserInput} at LOC: ${LastXYZ} 
					;Filename:Write["Wait\n"]
					;Filename:Write[${UserInput}\n]
					;Filename:Write[${LastXYZ}\n]
					UIElement[LocsList@WriteLocs]:AddItem["Wait"]
					UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				break
			}
			case -flydown
			{
				UIElement[LocsList@WriteLocs]:AddItem["Custom"]
				UIElement[LocsList@WriteLocs]:AddItem["FlyDown"]
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -hailactor
			{
				if ${Target(exists)}
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor NumberOfResponses=1 ResponseNumber=1 Hail=TRUE Follow=TRUE ExactName=FALSE" "\"${Target}\" "
				else
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor NumberOfResponses=1 ResponseNumber=1 Hail=TRUE Follow=TRUE ExactName=FALSE"
				while ${UserInput.Equal[""]}
				{
					MessageBox -skin eq2 "You must enter arguments"
					InputBox -skin eq2 "Enter arguments seperated by a space in this order (Actor NumberOfResponses=1 ResponseNumber=1 Hail=TRUE Follow=TRUE ExactName=FALSE)"
					wait 1
				}
				if ${String[${UserInput}].Equal[NULL]}
					return
				if ${RI_Var_Bool_Debug}
					echo Writing HailActor ${UserInput} LOC: ${LastXYZ}
				UIElement[LocsList@WriteLocs]:AddItem["Custom"]
				UIElement[LocsList@WriteLocs]:AddItem["HailActor ${UserInput}"]
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -clickactor
			{
				if ${Target(exists)}
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor LoopUntilNoHighlightOnMouseHover=FALSE LoopUntilDNE=FALSE GiveUpCNT=50" "\"${Target}\" "
				else
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor LoopUntilNoHighlightOnMouseHover=FALSE LoopUntilDNE=FALSE GiveUpCNT=50"
				while ${UserInput.Equal[""]}
				{
					MessageBox -skin eq2 "You must enter arguments"
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor LoopUntilNoHighlightOnMouseHover=FALSE LoopUntilDNE=FALSE GiveUpCNT=50"
					wait 1
				}
				if ${String[${UserInput}].Equal[NULL]}
					return
				if ${RI_Var_Bool_Debug}
					echo Writing ClickActor ${UserInput} LOC: ${LastXYZ}
				UIElement[LocsList@WriteLocs]:AddItem["Custom"]
				UIElement[LocsList@WriteLocs]:AddItem["ClickActor ${UserInput}"]
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -named
			{
				InputBox -skin eq2 "Enter Name"
				while ${UserInput.Equal[""]} 
				{
					MessageBox -skin eq2 "You must enter a name"
					InputBox -skin eq2 "Enter Name"
					wait 1
				}
				if ${String[${UserInput}].Equal[NULL]}
					return
				NamedName:Set[${UserInput}]
				if ${RI_Var_Bool_Debug}
					echo Writing Named ${UserInput} LOC: ${LastXYZ}
				UIElement[LocsList@WriteLocs]:AddItem["Named"]
				UIElement[LocsList@WriteLocs]:AddItem["${NamedName}"]
				MessageBox -skin eq2 -yesno "Standard Named?"
				if ${UserInput.Equal[No]}
					UIElement[LocsList@WriteLocs]:AddItem["CustomNamed"]
				else
				{
					UIElement[LocsList@WriteLocs]:AddItem["StandardNamed"]
					MessageBox -skin eq2 -yesno "Same LockSpot For Entire Group?"
					if ${UserInput.Equal[Yes]}
						UIElement[LocsList@WriteLocs]:AddItem["SameLock"]
					else
					{
						UIElement[LocsList@WriteLocs]:AddItem["DiffLock"]
						MessageBox  -skin eq2 "Move to 2nd lock position and click OK"
						UIElement[LocsList@WriteLocs]:AddItem["${Me.X} ${Me.Y} ${Me.Z}"]
						MessageBox  -skin eq2 "Move back to 1st lock position and click OK"
					}
					MessageBox -skin eq2 -yesno "Kill Add?"
					if ${UserInput.Equal[Yes]}
					{
						
						InputBox -skin eq2 "Enter Add Name"
						while ${UserInput.Equal[""]} 
						{
							MessageBox -skin eq2 "You must enter a add name"
							InputBox -skin eq2 "Enter Add Name"
							wait 1
						}
						if ${String[${UserInput}].NotEqual[NULL]}
						{
							UIElement[LocsList@WriteLocs]:AddItem["KillAdd"]
							UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
						}
						else
							UIElement[LocsList@WriteLocs]:AddItem["DontKillAdd"]
					}
					else
						UIElement[LocsList@WriteLocs]:AddItem["DontKillAdd"]
					MessageBox -skin eq2 -yesno "Move group behind named?"
					if ${UserInput.Equal[Yes]}
						UIElement[LocsList@WriteLocs]:AddItem["MoveBehind"]
					else
						UIElement[LocsList@WriteLocs]:AddItem["DontMoveBehind"]
				}
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
			}
			case -custom
			{
				if ${_args.Used}==1
				{
					InputBox -skin eq2 "What would you like to do here?"
					while ${UserInput.Equal[""]} 
					{
						MessageBox -skin eq2 "You must enter a custom function"
						InputBox -skin eq2 "What would you like to do here?"
						wait 1
					}
					if ${String[${UserInput}].Equal[NULL]}
						return
					if ${RI_Var_Bool_Debug}
						echo Adding Custom: ${UserInput} LOC: ${LastXYZ}
					UIElement[LocsList@WriteLocs]:AddItem["Custom"]
					UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				else
				{
					InputBox -skin eq2 "${_args[${Math.Calc[${_count}+1]}]}"
					while ${UserInput.Equal[""]} 
					{
						MessageBox -skin eq2 "You must enter your input"
						InputBox -skin eq2 "${_args[${Math.Calc[${_count}+1]}]}"
						wait 1
					}
					if ${String[${UserInput}].Equal[NULL]}
						return
					if ${RI_Var_Bool_Debug}
						echo Adding Custom: ${UserInput} LOC: ${LastXYZ}
					UIElement[LocsList@WriteLocs]:AddItem["Custom"]
					if ${_args.Used}==2
						UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
					else
						UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+2]}]} \"${UserInput}\""]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				break
			}
			default
				noop
		}
	}

	if ${_args.Used}==0
	{
		if ${UIElement[LocsList@WriteLocs].SelectedItem(exists)} && ${UIElement[TEEdit@WriteLocs].Text.NotEqual[""]}
		{
			UIElement[LocsList@WriteLocs].SelectedItem:SetText["${LastXYZ}"]
			return
		}
		if ${RI_Var_Bool_Debug}
			echo Writing ${LastXYZ}
		UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
	}
	elseif ${Custom}
	{
		
	}
	elseif ${ClickActor}
	{
		
	}
	elseif ${Named}
	{
		
	}
	UIElement[LocsList@WriteLocs].FindUsableChild[Vertical,Scrollbar]:SetValue[0]
	;Filename:Flush
}
function Auto(int Distance)
{
	while ${Auto}
	{
		if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LastXYZC}]}>${Distance}
		{
			if ${RI_Var_Bool_Debug}
				echo we are more than ${Distance} from ${LastXYZC} Adding new point, ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LastXYZC}]}
			;write a new point to file
			call Write FALSE FALSE FALSE FALSE FALSE
		}
		else
			call ExecuteQueued
	}
}

function ClearList()
{
	MessageBox -skin eq2 -yesno "Are you sure you want to clear the list of waypoints?"
	if ${UserInput.Equal[No]}
		return
	UIElement[LocsList@WriteLocs]:ClearItems
}
;executed when Edit Selection is pressed
function EditSelection()
{
	if ${UIElement[LocsList@WriteLocs].SelectedItem(exists)} && ${UIElement[TEEdit@WriteLocs].Text.NotEqual[""]}
	{
		UIElement[LocsList@WriteLocs].SelectedItem:SetText[${UIElement[TEEdit@WriteLocs].Text}]
	}
	else
	{
		if !${UIElement[LocsList@WriteLocs].SelectedItem(exists)}
		{
			MessageBox -skin eq2 "You must have an item selected to edit its value"
			return
		}
		if ${UIElement[TEEdit@WriteLocs].Text.Equal[""]}
		{
			MessageBox -skin eq2 "You must enter the text to the right that you want to replace the selected item with"
			return
		}
	}
}
;executed when Auto button is pressed
function AutoBTN()
{
	if ${Auto} == FALSE
	{
		Auto:Set[TRUE]
		UIElement[WriteLocs].FindChild[Auto]:SetText[Stop Auto]
		UIElement[WriteLocs].FindChild[Auto].Font:SetColor[FF32CD32]
	}
	else
	{
		Auto:Set[FALSE]
		UIElement[WriteLocs].FindChild[Auto]:SetText[Start Auto]
		UIElement[WriteLocs].FindChild[Auto].Font:SetColor[FFFF0000]
	}
}

;code to execute when close is pressed on ui
function atexit()
{
	echo ISXRI: Ending WriteLocs
	press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
	Filename:Close
	ui -unload "${LavishScript.HomeDirectory}/Scripts/WriteLocs.xml"
}