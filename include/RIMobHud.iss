variable collection:int MobIDCollection 
variable index:actor ActorIndex
variable(global) string RI_Var_String_RIMobHudScriptName=${Script.Filename}
variable Spaces SpaceObj
variable(global) RIMobHudGlobalObject RIMobHudGlobObj
variable RIMobHudObject RIMobHudObj
variable int cmoActorCount=0
variable int cmoCount=0
variable int intQuery=0
variable index:string DisplayText
variable index:string DisplayKey
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if RIMobHud.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RIMobHud.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RIMobHud.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMobHud.xml" http://www.isxri.com/RIMobHud.xml
		wait 50
	}
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMobHud.xml"
	
	;main loop
	while 1
	{
		;populate our ActorIndex
		RIMobHudObj:GetMobs
		
		call Update
		
		RIMobHudObj:UpdateUI
		
		;if !${Me.InCombat} && !${Me.IsHated}
			wait 5
		;else
			;wait 1
	}
}
objectdef Spaces
{
	member:string AddSpacing(int SpacesNeeded)
	{
		;// echo started
		variable int iCounter
		variable string TempHolder=""
		for ( iCounter:Set[1] ; ${iCounter} <= ${SpacesNeeded} ; iCounter:Inc )
		{
			;echo space added
			TempHolder:Concat[" "]
		}
		return "${TempHolder}"
	}
}
objectdef RIMobHudObject
{
	method GetMobs()
	{	
		EQ2:GetActors[ActorIndex,range,100]
		EQ2:QueryActors[ActorIndex,( Type =="NPC" || Type =="NamedNPC" ) && InCombatMode = TRUE && Health >0 && IsDead = FALSE && Distance <= 100 && Target.ID!=0]
		;if we got no actors return
		if ${ActorIndex.Used} <= 0
			return
		;else
		;	echo ActorIndex Prior to Query1: ${ActorIndex.Used}
			
		;remove everything except NPC and NamedNPC
		; intQuery:Set[${LavishScript.CreateQuery[Type = "NPC" || Type = "NamedNPC"]}]
		; ActorIndex:RemoveByQuery[${intQuery},FALSE]
		; LavishScript:FreeQuery[${intQuery}]
		; ActorIndex:Collapse
		
		;if nothing is left return
		; if ${ActorIndex.Used} <= 0
			; return
		;else
			;echo ActorIndex After Query1: ${ActorIndex.Used}
			
		;remove mobs that are not incombat, dead or health is <0
		;echo ActorIndex Prior to Query2: ${ActorIndex.Used}
		;remove mobs that are not incombat or dead or health is <0
		;removed  && Target.InMyGroup = TRUE for mobs that like to target other mobs but are in our fight
		; intQuery:Set[${LavishScript.CreateQuery[InCombatMode = TRUE && Health > 0 && Target.ID!=0]}]
		; ActorIndex:RemoveByQuery[${intQuery},FALSE]
		; LavishScript:FreeQuery[${intQuery}]
		; ActorIndex:Collapse
			
		;if nothing is left return
		;if ${ActorIndex.Used} <= 0
		;	return
		;echo ActorIndex After Query2: ${ActorIndex.Used}
	}
	method UpdateUI()
	{
		;echo update
		if ${DisplayText.Used}>0
		{
			UIElement[Mobs@RIMobHud]:ClearItems
			variable int count=0
			for(count:Set[1];${count}<=${DisplayText.Used};count:Inc)
				UIElement[Mobs@RIMobHud]:AddItem["${DisplayText.Get[${count}]}",${DisplayKey.Get[${count}]}]
		}
		else
		{
			UIElement[Mobs@RIMobHud]:ClearItems
			;echo empty
		}
	}
}
function Update()
	{
		DisplayKey:Clear
		DisplayText:Clear
		;populate our MobIDCollection
		variable int collCount
		MobIDCollection:Clear
		for(collCount:Set[1];${collCount}<=${ActorIndex.Used};collCount:Inc)
		{
			MobIDCollection:Set[${collCount},${ActorIndex[${collCount}].ID}]
		}
		;make sure there are mobs
		if ${MobIDCollection.FirstKey(exists)}
		{
			;UIElement[Mobs@RIMobHud]:ClearItems
			do
			{
				;// echo ${MobIDCollection.CurrentKey} - ${MobIDCollection.CurrentValue} Actor: ${Actor[id,${MobIDCollection.CurrentKey}].Name}
				;// UIElement[${LstBoxOgreOSAListID}]:AddItem[${Actor[id,${MobIDCollection.CurrentValue}].Name.Left[20]} @ ${Actor[id,${MobIDCollection.CurrentValue}].Health} on ${Actor[id,${MobIDCollection.CurrentValue}].Target.Name.Left[12]} (S+F${MobIDCollection.CurrentKey})]
				;// Need to build with correct spacing and shit
				variable string BuildDisplay
				variable string sTemp
				variable int SpacesNeeded
				variable int iCounter
				BuildDisplay:Set[""]
				SpacesNeeded:Set[0]
				;BuildDisplay:Concat["H:"]
				BuildDisplay:Set["${Actor[id,${MobIDCollection.CurrentValue}].Health} "]
				SpacesNeeded:Set[${Math.Calc[3-${String[${Actor[id,${MobIDCollection.CurrentValue}].Health}].Length}]}]
				BuildDisplay:Concat["${SpaceObj.AddSpacing[${SpacesNeeded}]}"]
				BuildDisplay:Concat["${Actor[id,${MobIDCollection.CurrentValue}].Name.Left[22]} "]
				SpacesNeeded:Set[${Math.Calc[22-${Actor[id,${MobIDCollection.CurrentValue}].Name.Left[22].Length}]}]
				; echo SpacesNeeded: ${SpacesNeeded} for ${Actor[id,${MobIDCollection.CurrentValue}].Name.Left[25]} (  )
				BuildDisplay:Concat["${SpaceObj.AddSpacing[${SpacesNeeded}]}"]
				BuildDisplay:Concat["   "]
				BuildDisplay:Concat["${Actor[id,${MobIDCollection.CurrentValue}].Target.Name.Left[7]} "]
				SpacesNeeded:Set[${Math.Calc[7-${Actor[id,${MobIDCollection.CurrentValue}].Target.Name.Left[7].Length}]}]
				BuildDisplay:Concat["${SpaceObj.AddSpacing[${SpacesNeeded}]}"]
				BuildDisplay:Concat[" "]
				BuildDisplay:Concat["${Actor[id,${MobIDCollection.CurrentValue}].Distance.Round}"]
				SpacesNeeded:Set[${Math.Calc[3-${String[${Actor[id,${MobIDCollection.CurrentValue}].Distance.Round}].Length}]}]
				;echo SpacesNeeded: ${SpacesNeeded} for ${String[${Actor[id,${MobIDCollection.CurrentValue}].Distance.Round}].Length} (  )
				BuildDisplay:Concat["${SpaceObj.AddSpacing[${SpacesNeeded}]}"]
				BuildDisplay:Concat["  "]
				sTemp:Set[${If[${Actor[id,${MobIDCollection.CurrentValue}].ThreatToMe}==100, ${Actor[id,${MobIDCollection.CurrentValue}].ThreatToNext}, ${Actor[id,${MobIDCollection.CurrentValue}].ThreatToMe}]}]
				BuildDisplay:Concat["${sTemp} "]
				SpacesNeeded:Set[${Math.Calc[3-${sTemp.Length}]}]
				
				DisplayText:Insert["${BuildDisplay}"]
				DisplayKey:Insert[${MobIDCollection.CurrentKey}]
				
				;// echo UIElement[${LstBoxOgreOSAListID}]:AddItem["${BuildDisplay}",${MobIDCollection.CurrentKey}]
				;// UIElement[${LstBoxOgreOSAListID}]:AddItem[${Actor[id,${MobIDCollection.CurrentValue}].Name.Left[20]} @ ${Actor[id,${MobIDCollection.CurrentValue}].Health} on ${Actor[id,${MobIDCollection.CurrentValue}].Target.Name.Left[12]} H: ${If[${Actor[id,${MobIDCollection.CurrentValue}].ThreatToMe}==100, ${Actor[id,${MobIDCollection.CurrentValue}].ThreatToNext}, ${Actor[id,${MobIDCollection.CurrentValue}].ThreatToMe}]} D:${Actor[id,${MobIDCollection.CurrentValue}].Distance.Round}]
				;waitframe
			}
			while ${MobIDCollection.NextKey(exists)}
		}
		elseif ${UIElement[Mobs@RIMobHud].Items} >0
		{
			DisplayKey:Clear
			DisplayText:Clear
		}
	}
objectdef RIMobHudGlobalObject
{
	method DoTarget(int FunctionKey)
	{
		;echo F key pressed: ${FunctionKey} - ${MobIDCollection.Element[${FunctionKey}]}
		if ${MobIDCollection.Element[${FunctionKey}]} > 0 && ${Actor[id,${MobIDCollection.Element[${FunctionKey}]}].Health} > 0
		{
			Actor[${MobIDCollection.Element[${FunctionKey}]}]:DoTarget
			UIElement[Mobs@RIMobHud]:ClearSelection
		}
	}
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMobHud.xml"
}