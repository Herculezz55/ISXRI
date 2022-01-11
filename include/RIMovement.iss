;MovementScript for RunInstances by Herculezz v13
;
;v2 added move infront, removed if already pressing check as it seemed unreliable
;
;v3 changes 12-14-14
;	changed move behind and move in front distance to 3
;
;v4 changes 3-31-15
;	gave LockSpotting Priority over all else. 
;   so if you lockspot it doesn't fight with move behind or infront or follow
;
;v5 changes 4-14-15 
;	fixed a bug that was not checking my agro when moving behind
;	causing a spinning action
;
;v6 changes 5-12-15
;	removed include of PositionUtils and brought the entire Object here.
;
;
;v7 changes 5-15-15
;	added RI_Var_Bool_MoveBehindIgnoreAggroCheck for certain situations
;
;v8 changes 5-16-15
;	Added CheckSwimming function to stayafloat when swimming
;
;v9 changes 5-27-15
;	fixed a bug in move behind
;
;v10 changes 6-3-15
;	changed movebehind to angle 1 insterad of 0, to help getting stuck on mob
;
;v11 fixed a few bugs 9-9-15
;v12 fixed a bug in movebehind 9-13-15
;v13 fixed a bug in movebehind/infront that was not stopping on Lockspot
;	added turning off of FaceNPC when moving

;v14 Added CombatBot Settings

 ; #ifndef _PositionUtils_
	 ; #define _IncludePositionUtils_
	 ; #include "${LavishScript.HomeDirectory}/Scripts/RunInstances/PositionUtils.iss"
 ; #endif
variable(global) bool RI_Var_Bool_RIMPaused=FALSE
variable(global) bool RI_Var_Bool_StayAfloat=FALSE

variable(global) bool RI_Var_Bool_MovingBehind
variable(global) int RI_Var_Int_MoveBehindDistance
variable(global) int RI_Var_Int_MoveBehindMaxMeleeRangeMod=0
variable(global) int RI_Var_Int_MoveBehindHealth
variable(global) int RI_Var_Int_MoveBehindMobID
variable(global) string RI_Var_String_MoveBehindFallBackPCName
variable(global) bool RI_Var_Bool_MoveBehindIgnoreAggroCheck=FALSE
variable(global) bool RI_Var_Bool_MoveDebug=FALSE
variable(global) bool RI_Var_Bool_MovingInFront
variable(global) int RI_Var_Int_MoveInFrontDistance
variable(global) int RI_Var_Int_MoveInFrontMaxMeleeRangeMod=0
variable(global) int RI_Var_Int_MoveInFrontHealth
variable(global) int RI_Var_Int_MoveInFrontMobID
variable(global) string RI_Var_String_MoveInFrontFallBackPCName
variable(global) bool RI_Var_Bool_MoveInFrontIgnoreAggroCheck=FALSE
variable(global) bool RI_Var_Bool_MoveCBImmunity=FALSE
variable(global) int RI_Var_Int_MoveDistanceMod=1
variable(global) bool RI_Var_Bool_LockSpotting
variable(global) float RI_Var_Float_LockSpotX=0
variable(global) float RI_Var_Float_LockSpotY=0
variable(global) float RI_Var_Float_LockSpotZ=0
variable(global) int RI_Var_Int_LockSpotMax=100
variable(global) int RI_Var_Int_LockSpotPrecision=1
variable(global) string RI_Var_String_LockSpotZoneName

variable(global) bool RI_Var_Bool_RIFollowing=FALSE
variable(global) int RI_Var_Int_RIFollowTargetID=1
variable(global) int RI_Var_Int_RIFollowMinDistance=1
variable(global) int RI_Var_Int_RIFollowMaxDistance=100
variable bool SpacePressed=FALSE
variable(global) EQ2Position Position
variable int CheckedSwimmingTime=0
variable(global) bool RI_Var_Bool_AutoRunning=FALSE
variable(global) GroupCheck GrpChk

function main()
{
	;disable RI_Var_Bool_Debugging
	Script:DisableDebugging
	
	if ${RI_Var_Bool_Debug}
		echo Starting RIMovement v11
		
	
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if RIMovement.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RIMovement.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMovement.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMovement.xml" http://www.isxri.com/RIMovement.xml
		wait 50
	}
		
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMovement.xml"
	if ${Script[Buffer:CombatBot](exists)}
		UIElement[RIMovement]:Hide
	;if our main script is not running echo and end
	; if !${Script[Buffer:RunInstances](exists)}
	; {
		; echo Please type RI in the Console, RIMovement cannot be run by itself
		; return
	; }
	
	;main loop
	do
	{
		;check if we are swimming and if we should be staying afloat
		call CheckSwimming
		;if all checks are true, call RILockSpot
		if ${EQ2.ServerName.Equal[Battlegrounds]} && !${Me.Name.Find["Skyshrine "](exists)}
		{
			wait 10
		}
		else
		{
			;echo 	${RI_Var_Bool_LockSpotting} && !${RI_Var_Bool_Paused} && ${RI_Var_Float_LockSpotX} != 0 && ${Me.GetGameData[Self.ZoneName].Label.Equal["${RI_Var_String_LockSpotZoneName}"]} && !${Me.FlyingUsingMount} && ( !${Script[Buffer:CombatBot](exists)} || ( ${UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} ) ) 
			if ${RI_Var_Bool_LockSpotting} && !${RI_Var_Bool_Paused} && ${RI_Var_Float_LockSpotX} !=0 && ${Me.GetGameData[Self.ZoneName].Label.Equal["${RI_Var_String_LockSpotZoneName}"]} && ( ( !${Me.FlyingUsingMount} && !${Me.WaterDepth}>1 ) ||  ${RI_Var_Float_LockSpotY}!=0 ) && ( !${Script[Buffer:CombatBot](exists)} || ( ${UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} ) ) 
			{
				;echo calling RILockSpot
				call RILockSpot
			}
			;if all checks are true call RIFollow
			if ${RI_Var_Bool_RIFollowing} && !${RI_Var_Bool_LockSpotting} && !${EQ2.Zoning} && !${RI_Var_Bool_Paused} && ${RI_Var_Int_RIFollowTargetID} > 0 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}](exists)} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance}
			{
				if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${RI_Var_Int_RIFollowMinDistance}
					call RIFollow
				if !${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount} && ${Me.FlyingUsingMount} && ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]} <= ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]}
				{
					wait 2
					press -hold ${RI_Var_String_FlyDownKey}
				}
				else
				{
					press -release ${RI_Var_String_FlyDownKey}
					wait 2
				}
			}
			;if we are to movebehind all checks are true call RIMoveBehind
			if ${RI_Var_Bool_MovingBehind} && !${RI_Var_Bool_LockSpotting} && !${EQ2.Zoning} && !${RI_Var_Bool_Paused} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health(exists)}
			{
				;echo calling move
				call RIMoveBehind
			}
			;if we are to moveInFront all checks are true call RIMoveInFront
			if ${RI_Var_Bool_MovingInFront} && !${RI_Var_Bool_LockSpotting} && !${EQ2.Zoning} && !${RI_Var_Bool_Paused} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Health(exists)}
				call RIMoveInFront
			wait 1
		}
	}
	while 1
}
;RI_Atom_SetLockSpot ${Me.Name} ${Me.X} ${Me.Y} ${Me.Z} 1 100
;need to turn aX into a string and typecast it to float if it isnt OFF
atom(global) RI_Atom_SetLockSpot(string aWho, string aX=${Me.X}, float aY=${Me.Y}, float aZ=${Me.Z}, int aPrecision=1, int aMax=1000)
{
	if ${RI_Var_Bool_Debug}
		echo ${aWho}  - ${aX} ${aY} ${aZ} - ${aPrecision}  -  ${aMax}
	if ${aWho.Upper.Equal[OFF]} || ( ${aX.Upper.Equal[OFF]} && ${RIMUIObj.ForWhoCheck["${aWho}"]} )
	{
		if ${Script[Buffer:CombatBot](exists)}
			UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI]:UnsetChecked
		RI_Var_Bool_LockSpotting:Set[FALSE]
	}
	; elseif ${aWho.Equal[""]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif ${aWho.Upper.Equal[ALL]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
		; call SetLockSpot ${aPrecision} ${aMax} ${aX} ${aY} ${aZ}
	elseif ${RIMUIObj.ForWhoCheck["${aWho}"]}
	{
		if ${RI_Var_Bool_Debug}
			echo RI_Var_String_LockSpotZoneName:Set[${Me.GetGameData[Self.ZoneName].Label}]
		
		RI_Var_String_LockSpotZoneName:Set["${Me.GetGameData[Self.ZoneName].Label}"]
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Setting LockSpot for ${Me.Name} at ${aX} ${aY} ${aZ} with Precision - ${aPrecision} and Max - ${aMax} in - ${RI_Var_String_LockSpotZoneName}
		RI_Var_Float_LockSpotX:Set[${Float[${aX}]}]
		RI_Var_Float_LockSpotY:Set[${aY}]
		RI_Var_Float_LockSpotZ:Set[${aZ}]
		RI_Var_Int_LockSpotMax:Set[${aMax}]
		RI_Var_Int_LockSpotPrecision:Set[${aPrecision}]
		RI_Var_Bool_LockSpotting:Set[TRUE]
		if ${Script[Buffer:CombatBot](exists)}
			UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI]:SetChecked
	}
}
atom(global) RI_Atom_MoveBehind(string aWho, string aRI_Var_Int_MoveBehindMobID, int aDistance, int aHealth, string aFallBackPCName)
{

	if ${aWho.Upper.Equal[OFF]}
		RI_Var_Bool_MovingBehind:Set[FALSE]
	; elseif ${aWho.Equal[""]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif ${aWho.Upper.Equal[ALL]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
		; call SetMoveBehind ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	elseif ${RIMUIObj.ForWhoCheck["${aWho}"]}
	{
		if ${aRI_Var_Int_MoveBehindMobID.Upper.Equal[OFF]}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Turning off Movebehind
			RI_Var_Bool_MovingBehind:Set[FALSE]
			return
		}
		if ${aRI_Var_Int_MoveBehindMobID.Equal[0]}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Actor does not exist
			return
		}
		if ${Actor[id,${aRI_Var_Int_MoveBehindMobID}](exists)}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Turning on Movebehind for ${Actor[id,${aRI_Var_Int_MoveBehindMobID}].Name}
			RI_Atom_MoveInFront ALL OFF
			RI_Var_Bool_MovingBehind:Set[TRUE]	
			RI_Var_Int_MoveBehindMobID:Set[${aRI_Var_Int_MoveBehindMobID}]
			RI_Var_Int_MoveBehindDistance:Set[${aDistance}]
			RI_Var_Int_MoveBehindHealth:Set[${aHealth}]
			if ${Int[${aFallBackPCName}]}>0
				RI_Var_String_MoveBehindFallBackPCName:Set[${Int[${aFallBackPCName}]}]
			elseif ${Int[${aFallBackPCName}]}==0 && ${Int[${Actor[${aFallBackPCName}].ID}]}>0
				RI_Var_String_MoveBehindFallBackPCName:Set[${Int[${Actor[${aFallBackPCName}].ID}]}]
		}
		else
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Actor does not exist
		}
	}
}

atom(global) RI_Atom_MoveInFront(string aWho, string aRI_Var_Int_MoveInFrontMobID=0, int aDistance, int aHealth, string aFallBackPCName)
{
	if ${aWho.Upper.Equal[OFF]}
		RI_Var_Bool_MovingInFront:Set[FALSE]
	; elseif ${aWho.Equal[""]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif ${aWho.Upper.Equal[ALL]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
		; call SetMoveInFront ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
		; call SetMoveInFront ${aRI_Var_Int_MoveBehindMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
		; call SetMoveInFront ${aRI_Var_Int_MoveInFrontMobID} ${aDistance} ${aHealth} ${aFallBackPCName}
	elseif ${RIMUIObj.ForWhoCheck["${aWho}"]}
	{
		if ${aRI_Var_Int_MoveInFrontMobID.Upper.Equal[OFF]}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Turning off MoveInFront
			RI_Var_Bool_MovingInFront:Set[FALSE]
			return
		}
		if ${aRI_Var_Int_MoveInFrontMobID}==0
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Actor does not exist
			return
		}
		if ${Actor[id,${aRI_Var_Int_MoveBehindMobID}](exists)}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Turning on MoveInFront for ${Actor[id,${aRI_Var_Int_MoveInFrontMobID}].Name}
			RI_Atom_MoveBehind ALL OFF
			RI_Var_Bool_MovingInFront:Set[TRUE]	
			RI_Var_Int_MoveInFrontMobID:Set[${aRI_Var_Int_MoveInFrontMobID}]
			RI_Var_Int_MoveInFrontDistance:Set[${aDistance}]
			RI_Var_Int_MoveInFrontHealth:Set[${aHealth}]
			RI_Var_String_MoveInFrontFallBackPCName:Set[${aFallBackPCName}]
		}
		else
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Actor does not exist
		}
	}
}
; function SetMoveInFront(string fRI_Var_Int_MoveInFrontMobID, int fDistance, int fHealth, int fFallBackPCName)
; {
	; if ${fRI_Var_Int_MoveInFrontMobID.Upper.Equal[OFF]}
	; {
		; if ${RI_Var_Bool_Debug}
			; echo ${Time}: Turning off MoveInFront
		; RI_Var_Bool_MovingInFront:Set[FALSE]
		; return
	; }
	; if ${fRI_Var_Int_MoveInFrontMobID}==0
	; {
		; if ${RI_Var_Bool_Debug}
			; echo ${Time}: Actor does not exist
		; return
	; }
	; if ${Actor[id,${fRI_Var_Int_MoveBehindMobID}](exists)}
	; {
		; if ${RI_Var_Bool_Debug}
			; echo ${Time}: Turning on MoveInFront for ${Actor[id,${fRI_Var_Int_MoveInFrontMobID}].Name}
		; RI_Atom_MoveBehind ALL OFF
		; RI_Var_Bool_MovingInFront:Set[TRUE]	
		; RI_Var_Int_MoveInFrontMobID:Set[${fRI_Var_Int_MoveInFrontMobID}]
		; RI_Var_Int_MoveInFrontDistance:Set[${fDistance}]
		; RI_Var_Int_MoveInFrontHealth:Set[${fHealth}]
		; RI_Var_String_MoveInFrontFallBackPCName:Set[${fFallBackPCName}]
	; }
	; else
	; {
		; if ${RI_Var_Bool_Debug}
			; echo ${Time}: Actor does not exist
	; }
; }
;need to add whos to this atom
atom(global) RI_Atom_ChangeLockSpot(string aWho, float aX, float aY, float aZ)
{
	; variable bool GoodToGo=FALSE
	; if ${aWho.Upper.Equal[ALL]}
		; GoodToGo:Set[TRUE]
	; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
		; GoodToGo:Set[TRUE]
	; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
		; GoodToGo:Set[TRUE]
	if ${RI_Var_Bool_LockSpotting} && ${RIMUIObj.ForWhoCheck["${aWho}"]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Changing LockSpot to: ${aX} ${aY} ${aZ}
		if ${aX} != 0
			RI_Var_Float_LockSpotX:Set[${aX}]
		if ${aZ} != 0
			RI_Var_Float_LockSpotY:Set[${aY}]
		if ${aZ} != 0
			RI_Var_Float_LockSpotZ:Set[${aZ}]
	}
}
;neeed to add whoos
atom(global) RI_Atom_ChangeLockSpotByChg(string aWho, int aXChg, intaYChg, int aZChg)
{
	; variable bool GoodToGo=FALSE
	; if ${aWho.Upper.Equal[ALL]}
		; GoodToGo:Set[TRUE]
	; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
		; GoodToGo:Set[TRUE]
	; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
		; GoodToGo:Set[TRUE]
	; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
		; GoodToGo:Set[TRUE]
	if ${RI_Var_Bool_LockSpotting} && ${RIMUIObj.ForWhoCheck["${aWho}"]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Changing LockSpot by: ${aXChg} ${aYChg} ${aZChg}
		if ${aXChg} != 0
			RI_Var_Float_LockSpotX:Set[${Math.Calc[${RI_Var_Float_LockSpotX}+${aXChg}]}]
		if ${aYChg} != 0
			RI_Var_Float_LockSpotY:Set[${Math.Calc[${RI_Var_Float_LockSpotY}+${aYChg}]}]
		if ${aZChg} != 0
			RI_Var_Float_LockSpotZ:Set[${Math.Calc[${RI_Var_Float_LockSpotZ}+${aZChg}]}]
	}
}
atom(global) RI_Atom_SetRIFollow(string aWho, string aWhoFollowID=0, int aMin=1, int aMax=100)
{
	if ${aWho.Upper.Equal[OFF]}
		RI_Var_Bool_RIFollowing:Set[FALSE]
	elseif ( ${aWhoFollowID.Upper.Equal[OFF]} || ${aWhoFollowID.Equal[0]} ) && ${RIMUIObj.ForWhoCheck["${aWho}"]}
		RI_Var_Bool_RIFollowing:Set[FALSE]
	; {
		; if ${aWho.Upper.Equal[ALL]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
			; RI_Var_Bool_RIFollowing:Set[FALSE]
		; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
			; RI_Var_Bool_RIFollowing:Set[FALSE]
	; }
	elseif ${aWhoFollowID.Equal[${Me.ID}]}
		RI_Var_Bool_RIFollowing:Set[FALSE]
	; elseif ${aWho.Upper.Equal[ALL]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif ${aWho.Upper.Equal[${Me.Name.Upper}]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[FIGHTER]} || ${aWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[NONFIGHTER]} || ${aWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[SCOUT]} || ${aWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[MAGE]} ||${aWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[PRIEST]} || ${aWho.Upper.Equal[PRIESTS]} || ${aWho.Upper.Equal[HEALER]} || ${aWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[BARD]} || ${aWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[ENCHANTER]} || ${aWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif ${aWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[G1]} || ${aWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[G2]} || ${aWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[G3]} || ${aWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	; elseif (${aWho.Upper.Equal[G4]} || ${aWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
		; call SetRIFollow ${aWhoFollowID} ${aMin} ${aMax}
	elseif ${RIMUIObj.ForWhoCheck[${aWho}]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Setting RIFollow for ${Me.Name} to ${Actor[id,${aWhoFollowID}].Name} at a Min Distance: ${aMin} and Max Distance: ${aMax}
		RI_Var_Int_RIFollowTargetID:Set[${aWhoFollowID}]
		RI_Var_Int_RIFollowMinDistance:Set[${aMin}]
		RI_Var_Int_RIFollowMaxDistance:Set[${aMax}]
		RI_Var_Bool_RIFollowing:Set[TRUE]
	}
}
function CheckSwimming()
{
	if ${Script.RunningTime}>${Math.Calc[${CheckedSwimmingTime}+1000]}
	{
		;if i am swimming && RI_Var_Bool_StayAfloat 
		if ${Me.IsSwimming} && ${RI_Var_Bool_StayAfloat} && !${SpacePressed}
		{
			press -hold space
			SpacePressed:Set[TRUE]
		}
		elseif !${Me.IsSwimming} && ${SpacePressed}
		{
			press -release space
			SpacePressed:Set[FALSE]
		}
		CheckedSwimmingTime:Set[${Script.RunningTime}]
	}
}
; function SetLockSpot(int fPrecision, int fMax, string fX, float fY, float fZ)
; {
	; if ${RI_Var_Bool_Debug}
		; echo RI_Var_String_LockSpotZoneName:Set[${Me.GetGameData[Self.ZoneName].Label}]
	
	; if ${fX.Upper.Equal[OFF]}
	; {
		; if ${Script[Buffer:CombatBot](exists)}
			; UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI]:UnsetChecked
		; RI_Var_Bool_LockSpotting:Set[FALSE]
		; return
	; }
	; RI_Var_String_LockSpotZoneName:Set["${Me.GetGameData[Self.ZoneName].Label}"]
	; if ${RI_Var_Bool_Debug}
		; echo ${Time}: Setting LockSpot for ${Me.Name} at ${fX} ${fY} ${fZ} with Precision - ${fPrecision} and Max - ${fMax} in - ${RI_Var_String_LockSpotZoneName}
	; RI_Var_Float_LockSpotX:Set[${fX}]
	; RI_Var_Float_LockSpotY:Set[${fY}]
	; RI_Var_Float_LockSpotZ:Set[${fZ}]
	; RI_Var_Int_LockSpotMax:Set[${fMax}]
	; RI_Var_Int_LockSpotPrecision:Set[${fPrecision}]
	; RI_Var_Bool_LockSpotting:Set[TRUE]
	; if ${Script[Buffer:CombatBot](exists)}
		; UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI]:SetChecked
; }
; function SetRIFollow(string fWhoFollowID, int fMin, int fMax)
; {
	; if ${fWhoFollowID.Upper.Equal[OFF]}
	; {
		; RI_Var_Bool_RIFollowing:Set[FALSE]
		; return
	; }
	; if ${fWhoFollowID}==${Me.ID}
		; return
	; if ${RI_Var_Bool_Debug}
			; echo ${Time}: Setting RIFollow for ${Me.Name} to ${Actor[id,${fWhoFollowID}].Name} at a Min Distance: ${fMin} and Max Distance: ${fMax}
	; RI_Var_Int_RIFollowTargetID:Set[${fWhoFollowID}]
	; RI_Var_Int_RIFollowMinDistance:Set[${fMin}]
	; RI_Var_Int_RIFollowMaxDistance:Set[${fMax}]
	; RI_Var_Bool_RIFollowing:Set[TRUE]
; }
function RILockSpot()
{
	if ( ${Me.FlyingUsingMount} || ${Me.WaterDepth}>1 ) && ${RI_Var_Float_LockSpotY}>0 && ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}>3
	{
		;for Lockspotting while flying
		;check our height vs our lockspots y height
		;now check if we are above or below desired height
		;below move down
		if ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}>5 && ${Me.Y}>${RI_Var_Float_LockSpotY}
		{
			;echo ${Time}: flydown
			press -release ${RI_Var_String_FlyUpKey}
			press -hold ${RI_Var_String_FlyDownKey}
			;wait 1
		}
		;above move up
		elseif ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}>5 && ${Me.Y}<${RI_Var_Float_LockSpotY}
		{
			;echo ${Time}: flyup
			press -release ${RI_Var_String_FlyDownKey}
			press -hold ${RI_Var_String_FlyUpKey}
			;wait 1
		}
		;stop moveup or down
		elseif ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}<=5
		{
			;echo ${Time}: we are there lets stop flying up or down
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			;wait 1
		}
	}
	if ${RI_Var_Bool_LockSpotting} && !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Float_LockSpotX} != 0 && ${Math.Distance[${Me.X},${Me.Z},${RI_Var_Float_LockSpotX},${RI_Var_Float_LockSpotZ}]} < ${RI_Var_Int_LockSpotMax} && ${Math.Distance[${Me.X},${Me.Z},${RI_Var_Float_LockSpotX},${RI_Var_Float_LockSpotZ}]} > ${RI_Var_Int_LockSpotPrecision} && ( !${Script[Buffer:CombatBot](exists)} || ( ${UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} ) ) 
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: RILockSpot Function
		;if we are following in game, stop following
		if ${Me.WhoFollowingID} != -1 && !${StopFollow}
			eq2ex stopfollow
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		
		;while we are not zoning and we are in the correct zone and we are less than max away and more than min away, move to LockSpot
		while ${RI_Var_Bool_LockSpotting} && !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Float_LockSpotX} != 0 && ${Math.Distance[${Me.X},${Me.Z},${RI_Var_Float_LockSpotX},${RI_Var_Float_LockSpotZ}]} < ${RI_Var_Int_LockSpotMax} && ${Math.Distance[${Me.X},${Me.Z},${RI_Var_Float_LockSpotX},${RI_Var_Float_LockSpotZ}]} > ${RI_Var_Int_LockSpotPrecision} && ( !${Script[Buffer:CombatBot](exists)} || ( ${UIElement[SettingsInstancedLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLockSpottingCheckBox@SettingsFrame@CombatBotUI].Checked} ) ) 
		{
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			
			;for Lockspotting while flying
			if ( ${Me.FlyingUsingMount} || ${Me.WaterDepth}>1 ) && ${RI_Var_Float_LockSpotY}!=0
			{
				;check our height vs our lockspots y height
				;now check if we are above or below desired height
				;below move down
				if ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}>3 && ${Me.Y}>${RI_Var_Float_LockSpotY}
				{
					;echo ${Time}: flydown
					press -release ${RI_Var_String_FlyUpKey}
					press -hold ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;above move up
				elseif ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}>3 && ${Me.Y}<${RI_Var_Float_LockSpotY}
				{
					;echo ${Time}: flyup
					press -release ${RI_Var_String_FlyDownKey}
					press -hold ${RI_Var_String_FlyUpKey}
					;wait 1
				}
				;stop moveup or down
				elseif ${Math.Distance[${Me.Y},${RI_Var_Float_LockSpotY}]}<=3
				{
					;echo ${Time}: we are there lets stop flying up or down
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					;wait 1
				}
			}
			
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are more than ${RI_Var_Int_LockSpotPrecision} away from ${RI_Var_Float_LockSpotX} ${RI_Var_Float_LockSpotZ}, Moving Closer
			;if we are following in game, cancel
			if ${Me.WhoFollowing(exists)}
				eq2ex stopfollow
			;face location
			Face ${RI_Var_Float_LockSpotX} ${RI_Var_Float_LockSpotZ}
			if ( ${Me.FlyingUsingMount} || ${Me.WaterDepth}>1 )
			{
				if !${Me.IsMoving}
				{
					press ${RI_Var_String_AutoRunKey}
					wait 2
				}
			}
			else
			{
				;if we are not already, hold ${RI_Var_String_ForwardKey}
				if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
					press -hold ${RI_Var_String_ForwardKey}
				;press -release ${RI_Var_String_BackwardKey}
			}
			wait 1
		}

		;release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_FlyUpKey}
		press -release ${RI_Var_String_FlyDownKey}
		press -release ${RI_Var_String_ForwardKey}
		wait 1
		if ${Me.IsMoving}
		{
			press ${RI_Var_String_BackwardKey}
			press ${RI_Var_String_BackwardKey}
			press ${RI_Var_String_BackwardKey}
		}
		;press -release ${RI_Var_String_BackwardKey}
		
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
	}
}
function RIFollow()
{
	;turn off FaceNPC
	RI_CMD_ChangeFaceNPC 0
		
	;while we are following, our following target exists and we are within the min and max range
	;Temp workaround for IsSwimming not working
	;while !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Bool_RIFollowing} && ${RI_Var_Int_RIFollowTargetID} > 0 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${RI_Var_Int_RIFollowMinDistance} && !${RI_Var_Bool_LockSpotting} && !${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount} && !${Actor[id,${RI_Var_Int_RIFollowTargetID}].IsSwimming} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}](exists)}
	while !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Bool_RIFollowing} && ${RI_Var_Int_RIFollowTargetID} > 0 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${RI_Var_Int_RIFollowMinDistance} && !${RI_Var_Bool_LockSpotting} && !${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount} && ${Me.WaterDepth}<=1 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}](exists)}
	{
		if !${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount} && ${Me.FlyingUsingMount} && ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]} <= ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+7]}
			press -hold ${RI_Var_String_FlyDownKey}
		else
			press -release ${RI_Var_String_FlyDownKey}
		;check if we are swimming and if we should be staying afloat
		;call CheckSwimming
		;if we are following in game, cancel
		;if ${Me.WhoFollowing(exists)}
		;	eq2ex stopfollow
		;face ${RI_Var_Int_RIFollowTargetID}
		Actor[id,${RI_Var_Int_RIFollowTargetID}]:DoFace
		;if we are not already, hold ${RI_Var_String_ForwardKey}
		if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed} && !${Me.FlyingUsingMount}
			press -hold ${RI_Var_String_ForwardKey}
		wait 1
	}
	;release ${RI_Var_String_ForwardKey}
	press -release ${RI_Var_String_ForwardKey}
	press -release ${RI_Var_String_FlyDownKey}

	if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount} && ${Me.WhoFollowingID}!=${RI_Var_Int_RIFollowTargetID} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}](exists)}
	{
		if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance}<69 && ${GrpChk.InMyActualGroup[${RI_Var_Int_RIFollowTargetID}]}
		{
			eq2ex follow ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Name}
			wait 5
		}
		else
		{
			if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]}
				call RIFlyFollow
			wait 5
		}
	}
	;if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].IsSwimming} && ${Me.WhoFollowingID}!=${RI_Var_Int_RIFollowTargetID} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}](exists)}
	if ${Me.WaterDepth}>1 && ${Me.WhoFollowingID}!=${RI_Var_Int_RIFollowTargetID} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}](exists)}
	{
		if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance}<69 && ${GrpChk.InMyActualGroup[${RI_Var_Int_RIFollowTargetID}]}
		{
			eq2ex follow ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Name}
			wait 5
		}
		else
		{
			if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]}
				call RISwimFollow
			wait 5
		}
		
	}
	;turn on FaceNPC
	RI_CMD_ChangeFaceNPC 1
}
objectdef GroupCheck
{
	member:bool InMyActualGroup(int _ID)
	{
		if ${Actor[id,${_ID}].InMyGroup} && ( ( ${Me.Raid}>0 && ${Me.RaidGroupNum}==${Me.Raid[id,${_ID}].RaidGroupNum} ) || ${Me.Raid}==0 )
			return TRUE
		else
			return FALSE
	}
}

function RIFlyFollow()
{
	while !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Bool_RIFollowing} && ${RI_Var_Int_RIFollowTargetID} > 0 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && !${RI_Var_Bool_LockSpotting} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount}
	{
		if ${GrpChk.InMyActualGroup[${RI_Var_Int_RIFollowTargetID}]} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance}<69
			break
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Our Main Fly Loop
		;face ${RI_Var_Int_RIFollowTargetID}
		Actor[id,${RI_Var_Int_RIFollowTargetID}]:DoFace
		;make sure we are flying if not fly
		if ${Actor[id,${RI_Var_Int_RIFollowTargetID}].FlyingUsingMount} && !${Me.FlyingUsingMount}
		{
			press -hold ${RI_Var_String_JumpKey}
			wait 2
			press -release ${RI_Var_String_JumpKey}
		}
		;press our autorunkey
		if !${Me.IsMoving} && ${Me.FlyingUsingMount} && ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]}>${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && !${RI_Var_Bool_AutoRunning}
		{
			;echo ${Time}: we are ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]} away from our target 2d so hitting autorunkey
			press ${RI_Var_String_AutoRunKey}
			RI_Var_Bool_AutoRunning:Set[TRUE]
			;wait 2
		}
		elseif ${Me.IsMoving} && ${Me.FlyingUsingMount} && ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]}<=${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && ${RI_Var_Bool_AutoRunning}
		{
			;echo ${Time}: we are ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]} away from our target 2d so stopping autorunkey
			press -hold ${RI_Var_String_ForwardKey}
			wait 1
			press -release ${RI_Var_String_ForwardKey}
			;press -hold ${RI_Var_String_BackwardKey}
			;wait 1
			;press -release ${RI_Var_String_BackwardKey}
			RI_Var_Bool_AutoRunning:Set[FALSE]
		}
		;check our height vs our follows height
		;now check if we are above or below desired height
		;below move down
		if  ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y}]}>3 && ${Me.Y}>${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y} && ${Me.FlyingUsingMount}
		{
			;echo ${Time}: flydown
			press -release ${RI_Var_String_FlyUpKey}
			press -hold ${RI_Var_String_FlyDownKey}
			;wait 1
		}
		;above move up
		elseif ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y}]}>3 && ${Me.Y}<${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y} && ${Me.FlyingUsingMount}
		{
			;echo ${Time}: flyup
			press -release ${RI_Var_String_FlyDownKey}
			press -hold ${RI_Var_String_FlyUpKey}
			;wait 1
		}
		;stop moveup or down
		elseif ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y}]}<=3 && ${Me.FlyingUsingMount}
		{
			;echo ${Time}: we are there lets stop flying up or down
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			;wait 1
		}
		wait 1
	}
	;echo ${Time}: Out of Fly Loop

	press -release ${RI_Var_String_ForwardKey}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	if ${Me.IsMoving}
		call StopAutoRun
		
}

function RISwimFollow()
{
	;while !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Bool_RIFollowing} && ${RI_Var_Int_RIFollowTargetID} > 0 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && !${RI_Var_Bool_LockSpotting} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].IsSwimming}
	while !${RI_Var_Bool_Paused} && !${EQ2.Zoning} && ${RI_Var_Bool_RIFollowing} && ${RI_Var_Int_RIFollowTargetID} > 0 && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} < ${RI_Var_Int_RIFollowMaxDistance} && ${Actor[id,${RI_Var_Int_RIFollowTargetID}].Distance} > ${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && !${RI_Var_Bool_LockSpotting} && ${Me.WaterDepth}>1
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Our Main Swim Loop
		;face ${RI_Var_Int_RIFollowTargetID}
		Actor[id,${RI_Var_Int_RIFollowTargetID}]:DoFace
		
		;press our autorunkey
		if !${Me.IsMoving} && ${Me.WaterDepth}>1 && ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]}>${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && !${RI_Var_Bool_AutoRunning}
		{
			;echo ${Time}: we are ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]} away from our target 2d so hitting autorunkey
			press ${RI_Var_String_AutoRunKey}
			RI_Var_Bool_AutoRunning:Set[TRUE]
			;wait 2
		}
		elseif ${Me.IsMoving} && ${Me.WaterDepth}>1 && ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]}<=${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+6]} && ${RI_Var_Bool_AutoRunning}
		{
			;echo ${Time}: we are ${Math.Distance[${Me.X},${Me.Z},${Actor[id,${RI_Var_Int_RIFollowTargetID}].X},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Z}]} away from our target 2d so stopping autorunkey
			press -hold ${RI_Var_String_ForwardKey}
			wait 1
			press -release ${RI_Var_String_ForwardKey}
			;press -hold ${RI_Var_String_BackwardKey}
			;wait 1
			;press -release ${RI_Var_String_BackwardKey}
			RI_Var_Bool_AutoRunning:Set[FALSE]
		}
		;check our height vs our follows height
		;now check if we are above or below desired height
		;below move down
		if  ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y}]}>3 && ${Me.Y}>${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y} && ${Me.WaterDepth}>1
		{
			;echo ${Time}: SwimDown
			press -release ${RI_Var_String_FlyUpKey}
			press -hold ${RI_Var_String_FlyDownKey}
			;wait 1
		}
		;above move up
		elseif ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y}]}>3 && ${Me.Y}<${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y} && ${Me.WaterDepth}>1
		{
			;echo ${Time}: SwimUp
			press -release ${RI_Var_String_FlyDownKey}
			press -hold ${RI_Var_String_FlyUpKey}
			;wait 1
		}
		;stop moveup or down
		elseif ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_RIFollowTargetID}].Y}]}<=3 && ${Me.WaterDepth}>1
		{
			;echo ${Time}: we are there lets stop Swimming up or down
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			;wait 1
		}
		wait 1
	}
	;echo ${Time}: Out of Swim Loop

	press -release ${RI_Var_String_ForwardKey}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	if ${Me.IsMoving}
		call StopAutoRun
}
function StopAutoRun()
{
	;do
	;{
		;echo stopping autorun
		press -release ${RI_Var_String_FlyUpKey}
		press -release ${RI_Var_String_FlyDownKey}
		press -hold ${RI_Var_String_ForwardKey}
		wait 1
		press -release ${RI_Var_String_ForwardKey}
		;press -hold ${RI_Var_String_BackwardKey}
		;wait 1
		;press -release ${RI_Var_String_BackwardKey}
		;press ${RI_Var_String_AutoRunKey}
		;wait 1
	;}
	;while ${Me.IsMoving}
	RI_Var_Bool_AutoRunning:Set[FALSE]
}
function RIMoveBehindOLD()
{
	if ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && !${RI_Var_Bool_LockSpotting}
	{
		;declaration
		variable point3f PointBehindMob
		;set point behind the mob
		PointBehindMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveBehindMobID},1]}]
		;if we are already in melee range and behind continue
		if (${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${Math.Calc[${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]}-1]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30)
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: we are in range and behind (${Actor[${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30)
			;checking if we are too close 
			if ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${Math.Distance[${Me.X},${Me.Y},${Me.Z},${PointBehindMob}]}
				return
		}
		;if there is collision detected, do not move
		if ${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${PointBehindMob.X},${Math.Calc[${PointBehindMob.Y}+2]},${PointBehindMob.Z}]} 
		{		
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Collision check is true, not moving behind
			return
		}
		;if we have aggro, and not ${RI_Var_Bool_MoveBehindIgnoreAggroCheck}, do not move
		if ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}==${Me.ID} && !${RI_Var_Bool_MoveBehindIgnoreAggroCheck}
		{		
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are hated, not moving behind
			return
		}
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		;loop until we are in melee range and behind the mob
		
		while ${RI_Var_Bool_MovingBehind} && (${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]} || ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}>0) && ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveBehindMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		{
			if ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}==${Me.ID} && !${RI_Var_Bool_MoveBehindIgnoreAggroCheck}
				return
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Moving into position behind ${Actor[id,${RI_Var_Int_MoveBehindMobID}]}: ${Actor[${RI_Var_Int_MoveBehindMobID}].Distance2D} > ${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]} / ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;set point behind the mob
			PointBehindMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveBehindMobID},1]}]
			if ${RI_Var_Bool_Debug}
				echo ${Time}: PointBehindMob: ${PointBehindMob}
			;face point
			Face ${PointBehindMob.X} ${PointBehindMob.Z}
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
				press -release ${RI_Var_String_BackwardKey}
			wait 1
		}
		;while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Math.Distance[${Me.X},${Me.Y},${Me.Z},${PointBehindMob}]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30 && ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveBehindMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Math.Calc[${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]}-1]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30 && ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveBehindMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		{
			if ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}==${Me.ID} && !${RI_Var_Bool_MoveBehindIgnoreAggroCheck}
			{
				press -release ${RI_Var_String_ForwardKey}
				press -release ${RI_Var_String_BackwardKey}
				return
			}
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are too close from behind ${Actor[id,${RI_Var_Int_MoveBehindMobID}]}: ${Target.Target.Distance2D} > ${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]} / ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;set point behind the mob
			PointBehindMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveBehindMobID},1]}]
			;face mob
			Actor[id,${RI_Var_Int_MoveBehindMobID}:DoFace
			;hold backward, if it isnt already
			;if !${Input.Button[${RI_Var_String_BackwardKey}].Pressed}
			press -release ${RI_Var_String_ForwardKey}
				press -hold ${RI_Var_String_BackwardKey}
			wait 1
		}
		;we are behind, release forward and backward
		press -release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_BackwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
		wait 1
	}
	;else if we are too far move to our fallback PC character if it exists
	elseif ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting}
	{
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are too far away to move behind, moving to our fallback PC character: ${RI_Var_String_MoveBehindFallBackPCName}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;face Actor
			Actor[${RI_Var_String_MoveBehindFallBackPCName}]:DoFace
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
			wait 1
		}
		press -release ${RI_Var_String_ForwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
	}
}
function RIMoveBehind()
{
	if !${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health(exists)}
		return
	if ${RI_Var_Bool_MoveDebug}
		echo rimovebehind ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && !${RI_Var_Bool_LockSpotting}
	if ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && !${RI_Var_Bool_LockSpotting} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health(exists)}
	{
		if ${RI_Var_Bool_MoveDebug}
			echo Valid Rimovebehind: {RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && !${RI_Var_Bool_LockSpotting}`
		;declaration
		variable point3f PointBehindMob
		variable float MoveDistance
		;set Distance
		MoveDistance:Set[${Math.Calc[(${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]}-1)-${RI_Var_Int_MoveDistanceMod}]}]
		if ${MoveDistance}<1
			MoveDistance:Set[1]
		;set point Behind the mob
		PointBehindMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveBehindMobID},1,${MoveDistance}]}]
		;if we are already in melee range and Behind continue
		if (${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Math.Calc[${MoveDistance}+1]} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${Math.Calc[${MoveDistance}-1]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30)
		{
			if ${RI_Var_Bool_MoveDebug}
				echo ${Time}: We are in range and Behind (${Target.Target.Distance2D}<${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30)
			;checking if we are too close 
			if ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${Math.Distance[${Me.X},${Me.Y},${Me.Z},${PointBehindMob}]}
				return
		}
		;if there collision detected or if we have aggro, do not move
		if ${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${PointBehindMob.X},${Math.Calc[${PointBehindMob.Y}+2]},${PointBehindMob.Z}]}
		{	
			if ${RI_Var_Bool_MoveDebug}
				echo ${Time}: MoveBehind: our collision check is true
			return
		}
		; if ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}==${Me.ID} && !${RI_Var_Bool_MoveBehindIgnoreAggroCheck}
		; {	
			; if ${RI_Var_Bool_Debug}
				; echo ${Time}: MoveBehind: we our hated
			; return
		; }
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		;loop until we are in melee range and Behind the mob
		while ${RI_Var_Bool_MovingBehind} && (${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>=${Math.Calc[${MoveDistance}+1]} || ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}>30) && ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveBehindMobID}].IsDead} && !${RI_Var_Bool_LockSpotting} && ( ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}!=${Me.ID} || ${RI_Var_Bool_MoveBehindIgnoreAggroCheck} )
		{
			if ${RI_Var_Bool_RIFollowing}
				RI_Var_Bool_RIFollowing:Set[0]
			if ${RI_Var_Bool_MoveDebug}
				echo ${Time}: Moving into position Behind ${Actor[id,${RI_Var_Int_MoveBehindMobID}]}: ${Target.Target.Distance2D} > ${MoveDistance} / ${Position.Angle[${RI_Var_Int_MoveBehindMobID},1]}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;set point Behind the mob
			PointBehindMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveBehindMobID},1,${MoveDistance}]}]
			;face point
			Face ${PointBehindMob.X} ${PointBehindMob.Z}
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
				press -release ${RI_Var_String_BackwardKey}
			wait 1
		}
		;while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Math.Distance[${Me.X},${Me.Y},${Me.Z},${PointBehindMob}]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}>30 && ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveBehindMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}<${Math.Calc[${MoveDistance}-1]} && ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}<30 && ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveBehindMobID}].IsDead} && !${RI_Var_Bool_LockSpotting} && ( ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}!=${Me.ID} || ${RI_Var_Bool_MoveBehindIgnoreAggroCheck} )
		{
			if ${RI_Var_Bool_RIFollowing}
				RI_Var_Bool_RIFollowing:Set[0]
			if ${RI_Var_Bool_MoveDebug}
				echo ${Time}: We are too close from Behind ${Actor[id,${RI_Var_Int_MoveBehindMobID}]}: ${Target.Target.Distance2D} > ${MoveDistance} / ${Position.Angle[${RI_Var_Int_MoveBehindMobID}]}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;set point Behind the mob
			;PointBehindMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveBehindMobID},1]}]
			;face mob
			Actor[id,${RI_Var_Int_MoveBehindMobID}]:DoFace
			;hold backward, if it isnt already
			;if !${Input.Button[${RI_Var_String_BackwardKey}].Pressed}
			press -release ${RI_Var_String_ForwardKey}
				press -hold ${RI_Var_String_BackwardKey}
			wait 1
		}
		;we are Behind, release forward and backward
		press -release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_BackwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
		wait 1
	}
	;else if we are too far move to our fallback PC character if it exists
	elseif ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting} && ( ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}!=${Me.ID} || ${RI_Var_Bool_MoveBehindIgnoreAggroCheck} )
	{
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting}
		{
			if ${RI_Var_Bool_MoveDebug}
				echo ${Time}: We are too far away to move Behind, moving to our fallback PC character: ${RI_Var_String_MoveBehindFallBackPCName}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;face Actor
			Actor[${RI_Var_String_MoveBehindFallBackPCName}]:DoFace
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
			wait 1
		}
		press -release ${RI_Var_String_ForwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
	}
	elseif ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Target.ID}==${Me.ID} && !${RI_Var_Bool_MoveBehindIgnoreAggroCheck}
	{
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		while ${RI_Var_Bool_MovingBehind} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Distance2D}>${RI_Var_Int_MoveBehindDistance} && ${Actor[id,${RI_Var_Int_MoveBehindMobID}].Health}<=${RI_Var_Int_MoveBehindHealth} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveBehindFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting}
		{
			if ${RI_Var_Bool_MoveDebug}
				echo ${Time}: We have aggro, moving to our fallback PC character: ${RI_Var_String_MoveBehindFallBackPCName}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;face Actor
			Actor[${RI_Var_String_MoveBehindFallBackPCName}]:DoFace
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
			wait 1
		}
		press -release ${RI_Var_String_ForwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
	}
}
function RIMoveInFront()
{
	if !${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Health(exists)}
		return
	if ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}<${RI_Var_Int_MoveInFrontDistance} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Health}<=${RI_Var_Int_MoveInFrontHealth} && !${RI_Var_Bool_LockSpotting}
	{
		;declaration
		variable point3f PointInFrontMob
		variable float MoveDistance
		;set Distance
		MoveDistance:Set[${Math.Calc[(${Position.GetMeleeMaxRange[${RI_Var_Int_MoveBehindMobID}]}-1)-${RI_Var_Int_MoveDistanceMod}]}]
		if ${MoveDistance}<1
			MoveDistance:Set[1]
		;set point InFront the mob
		PointInFrontMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveInFrontMobID},180,${MoveDistance}]}]
		;if we are already in melee range and InFront continue
		if (${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}<${Math.Calc[${MoveDistance}+1]} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}>${Math.Calc[${MoveDistance}-1]} && ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}>150)
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are in range and InFront (${Target.Target.Distance2D}<${Position.GetMeleeMaxRange[${RI_Var_Int_MoveInFrontMobID}]} && ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}>150)
			;checking if we are too close 
			if ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}>${Math.Distance[${Me.X},${Me.Y},${Me.Z},${PointInFrontMob}]}
				return
		}
		;if there collision detected or if we have aggro, do not move
		if ${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${PointInFrontMob.X},${Math.Calc[${PointInFrontMob.Y}+2]},${PointInFrontMob.Z}]}
		{	
			if ${RI_Var_Bool_Debug}
			echo ${Time}: MoveInFront: Our collision check is true
			return
		}
		if ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Target.ID}==${Me.ID} && !${RI_Var_Bool_MoveInFrontIgnoreAggroCheck}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: MoveInFront: We are hated
			return
		}
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		;loop until we are in melee range and InFront the mob
		while ${RI_Var_Bool_MovingInFront} && (${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}>=${Math.Calc[${MoveDistance}+1]} || ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}<150) && ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveInFrontMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		{
			if ${RI_Var_Bool_RIFollowing}
				RI_Var_Bool_RIFollowing:Set[0]
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Moving into position InFront ${Actor[id,${RI_Var_Int_MoveInFrontMobID}]}: ${Target.Target.Distance2D} > ${Position.GetMeleeMaxRange[${RI_Var_Int_MoveInFrontMobID}]} / ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;set point InFront the mob
			PointInFrontMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveInFrontMobID},180,${MoveDistance}]}]
			;face point
			Face ${PointInFrontMob.X} ${PointInFrontMob.Z}
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
				press -release ${RI_Var_String_BackwardKey}
			wait 1
		}
		;while ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}<${Math.Distance[${Me.X},${Me.Y},${Me.Z},${PointInFrontMob}]} && ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}>150 && ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveInFrontMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		while ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}<${Math.Calc[${MoveDistance}-1]} && ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}>150 && ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}](exists)} && !${Actor[id,${RI_Var_Int_MoveInFrontMobID}].IsDead} && !${RI_Var_Bool_LockSpotting}
		{
			if ${RI_Var_Bool_RIFollowing}
				RI_Var_Bool_RIFollowing:Set[0]
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are too close from InFront ${Actor[id,${RI_Var_Int_MoveInFrontMobID}]}: ${Target.Target.Distance2D} > ${Position.GetMeleeMaxRange[${RI_Var_Int_MoveInFrontMobID}]} / ${Position.Angle[${RI_Var_Int_MoveInFrontMobID}]}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;set point InFront the mob
			PointInFrontMob:Set[${Position.PointAtAngle[${RI_Var_Int_MoveInFrontMobID},180]}]
			;face mob
			Actor[id,${RI_Var_Int_MoveInFrontMobID}]:DoFace
			;hold backward, if it isnt already
			;if !${Input.Button[${RI_Var_String_BackwardKey}].Pressed}
			press -release ${RI_Var_String_ForwardKey}
				press -hold ${RI_Var_String_BackwardKey}
			wait 1
		}
		;we are InFront, release forward and backward
		press -release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_BackwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
		wait 1
	}
	;else if we are too far move to our fallback PC character if it exists
	elseif ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}>${RI_Var_Int_MoveInFrontDistance} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Health}<=${RI_Var_Int_MoveInFrontHealth} && ${Actor[${RI_Var_String_MoveInFrontFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveInFrontFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting}
	{
		;turn off FaceNPC
		RI_CMD_ChangeFaceNPC 0
		while ${RI_Var_Bool_MovingInFront} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Distance2D}>${RI_Var_Int_MoveInFrontDistance} && ${Actor[id,${RI_Var_Int_MoveInFrontMobID}].Health}<=${RI_Var_Int_MoveInFrontHealth} && ${Actor[${RI_Var_String_MoveInFrontFallBackPCName}](exists)} && ${Actor[${RI_Var_String_MoveInFrontFallBackPCName}].Distance2D}>5 && !${RI_Var_Bool_LockSpotting}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: We are too far away to move InFront, moving to our fallback PC character: ${RI_Var_String_MoveInFrontFallBackPCName}
			;check if we are swimming and if we should be staying afloat
			;call CheckSwimming
			;face Actor
			Actor[${RI_Var_String_MoveInFrontFallBackPCName}]:DoFace
			;hold forward, if it isnt already
			;if !${Input.Button[${RI_Var_String_ForwardKey}].Pressed}
				press -hold ${RI_Var_String_ForwardKey}
			wait 1
		}
		press -release ${RI_Var_String_ForwardKey}
		;turn on FaceNPC
		RI_CMD_ChangeFaceNPC 1
	}
}

;;;;; PositionUtils

objectdef EQ2Position
{
	; Returns angle 0-180 degrees:
	; 0 == Behind
	; 180 == In front
	; 90 == Directly beside (either side)

	member:float Angle(uint ActorID)
	{
		variable float Retval
		variable float Heading=${Actor[${ActorID}].Heading}
		variable float HeadingTo=${Actor[${ActorID}].HeadingTo}
		Retval:Set[${Math.Calc[${Math.Cos[${Heading}]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}]} * ${Math.Sin[${HeadingTo}]}]}]
		if ${Retval} < -1 
			Retval:Set[-1]
		if ${Retval} > 1
			Retval:Set[1]	
		Retval:Set[${Math.Acos[${Retval}]}]
		return ${Retval}
	}

	; Returns which side of the Actor I am on, Left or Right.
	member:string Side(uint ActorID)
	{
		variable float Side
		variable float Heading=${Actor[${ActorID}].Heading}
		variable float HeadingTo=${Actor[${ActorID}].HeadingTo}
		Side:Set[${Math.Calc[${Math.Cos[${Heading}+90]} * ${Math.Cos[${HeadingTo}]} + ${Math.Sin[${Heading}+90]} * ${Math.Sin[${HeadingTo}]}]}]
		if ${Side}>0
			return Left
		else
			return Right
	}

	; This member will return a point in 3d space at any angle of attack from the
	; Actor passed to it. The returned point will be on the same side as the player's
	; current position, or directly behind/in front of the Actor. Angle should be
	; 0 to 180 (or -0 to -180 if you wish to get a point on the opposite side.)
	member:point3f PointAtAngle(uint ActorID, float Angle, float Distance = 3)
	{
		variable float Heading=${Actor[${ActorID}].Heading}
		Returning.Y:Set[${Actor[${ActorID}].Y}]

		if ${This.Side[${ActorID}].Equal[Right]}
		{
			Angle:Set[-(${Angle})]
		}
		Returning.X:Set[-${Distance} * ${Math.Sin[-(${Heading}+(${Angle}))]} + ${Actor[${ActorID}].X}]
		Returning.Z:Set[${Distance} * ${Math.Cos[-(${Heading}+(${Angle}))]} + ${Actor[${ActorID}].Z}]
		return
	}

	; and this member will return a point in 3d space at any angle of attack from the
	; Actor passed to it, predicting that Actor's position based on their current speed
	; and direction, and the time argument passed to this function.
	member:point3f PredictPointAtAngle(uint ActorID, float Angle, float Seconds=1, float Distance=3)
	{
		variable point3f Velocity

		Velocity:Set[${Actor[${ActorID}].Velocity}]

		Returning:Set[${This.PointAtAngle[${ActorID},${Angle},${Distance}]}]

		Returning.X:Inc[${Velocity.X}*${Seconds}]
		Returning.Y:Inc[${Velocity.Y}*${Seconds}]
		Returning.Z:Inc[${Velocity.Z}*${Seconds}]
		return
	}

	; This one will predict an intercept point based on your speed and the actor's speed.
	; and direction.
	; Defaults to the actor's location (with prediction) if:
	;   1) Either you, or the actor, is stationary.
	;   2) You are both moving, but the actor is not facing you.
	member:point3f PredictInterceptPoint(uint ActorID)
	{
		variable point3f MyVelocity
		variable point3f ActorVelocity
		variable float TimeToImpact
		variable float TotalSpeed
		MyVelocity:Set[${Me.Velocity}]
		ActorVelocity:Set[${Actor[${ActorID}].Velocity}]
		
		if ${MyVelocity.Distance[0,0,0]}==0 || ${ActorVelocity.Distance[0,0,0]}==0
		{   /* If neither of us are moving, move directly for the actor. */
			Returning:Set[${Actor[${ActorID}].Loc}]
		}
		elseif ${This.Angle[${ActorID}]}>155 /* Within 50 degrees of front of actor */
		{                                    /* and we're both moving */
			TotalSpeed:Set[${MyVelocity.Distance[0,0,0]} + ${ActorVelocity.Distance[0,0,0]}
			TimeToImpact:Set[${Actor[${ActorID}].Distance} / ${TotalSpeed}]
			Returning:Set[${This.PredictPointAtAngle[${ActorID},180,${TimeToImpact},1]}]
		}
		else /* We are both moving, BUT the actor isn't approaching. */
		{    /* Predict point from my speed to actor's predicted location. */
			TotalSpeed:Set[${MyVelocity.Distance[0,0,0]}]
			TimeToImpact:Set[${Actor[${ActorID}].Distance} / ${TotalSpeed}]
			Returning:Set[${This.PredictPointAtAngle[${ActorID},180,${TimeToImpact},3]}]
		}
		return
 
	}
		
	member:float GetBaseMaxRange(uint ActorID)
	{
		return ${Math.Calc[${Actor[${ActorID}].CollisionRadius} * ${Actor[${ActorID}].CollisionScale}]}
	}

	member:float GetMeleeMaxRange(uint ActorID, float PercentMod = 0, float MeleeRange = 6)
	{
		PercentMod:Set[${Math.Calc[(100+${PercentMod})/100]}]
		MeleeRange:Set[${Math.Calc[${MeleeRange}*${PercentMod}]}]
		return ${Math.Calc[${Actor[${ActorID}].CollisionRadius} * ${Actor[${ActorID}].CollisionScale} + ${MeleeRange}]}
	}

	member:float GetSpellMaxRange(uint ActorID, float PercentMod = 0, float SpellRange = 30)
	{
		PercentMod:Set[${Math.Calc[(100+${PercentMod})/100]}]
		SpellRange:Set[${Math.Calc[${SpellRange}*${PercentMod}]}]
		if ${SpellRange}<5
			SpellRange:Set[5]
		return ${Math.Calc[${Actor[${ActorID}].CollisionRadius} * ${Actor[${ActorID}].CollisionScale} + ${SpellRange}]}
	}

	member:float GetCAMaxRange(uint ActorID, float PercentMod = 0, float CARange = 6)
	{
		PercentMod:Set[${Math.Calc[(100+${PercentMod})/100]}]
		CARange:Set[${Math.Calc[${CARange}*${PercentMod}]}]
		if ${CARange}<5
			CARange:Set[5]
		return ${Math.Calc[${Actor[${ActorID}].CollisionRadius} * ${Actor[${ActorID}].CollisionScale} + ${CARange}]}
	}

	member:point3f FindDestPoint(uint ActorID, float minrange, float maxrange, float destangle)
	{
		variable float myspeed
		variable point3f destminpoint
		variable point3f destmaxpoint
		;
		; ok which point is closer our min range or max range, will vary depending on our vector to mob
		;
		myspeed:Set[${Math.Calc[${Actor[${ActorID}].Distance2D}/10+${Me.Speed}]}]
		destminpoint:Set[${This.PredictPointAtAngle[${ActorID},${destangle},${myspeed},${minrange}]}]
		destmaxpoint:Set[${This.PredictPointAtAngle[${ActorID},${destangle},${myspeed},${maxrange}]}]

		Returning.Y:Set[${Actor[${ActorID}].Y}]
				
		if ${Math.Distance[${Me.Loc},${destminpoint}]}<${Math.Distance[${Me.Loc},${destmaxpoint}]}
		{
			Returning.X:Set[${destminpoint.X}]
			Returning.Z:Set[${destminpoint.Z}]
		}
		else
		{
			Returning.X:Set[${destmaxpoint.X}]
			Returning.Z:Set[${destmaxpoint.Z}]
		}
		
		return
	}
}

;;;;;;;;;;;; End of PositionUtils

function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMovement.xml"
	press -release ${RI_Var_String_ForwardKey}
	press -release ${RI_Var_String_BackwardKey}
	press -release ${RI_Var_String_SwimUpKey}
	press -release ${RI_Var_String_JumpKey}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
}