;quest test

function main()
{
	;disable debugging
	Script:DisableDebugging
	
	echo ISXRI: Hiding Effects
	eq2ex hidden_effects clear
	wait 5
	;;Read all the effects that we should hide (Duration -1, TargetType = Group,Raid,Self Only,Pet Only) and put in the index
	
    variable string Duration
    variable string EffectTarget
    variable int CountMaintained
    variable int Counter = 1
	variable int HideCounter = 1
	variable index:string MaintainedEffects
	variable iterator MaintainedEffectsIterator
	variable int Timer = 0
    variable index:effect Effects
    variable iterator EffectsIterator
    CountMaintained:Set[${Me.CountMaintained}]
    
    if (${CountMaintained} > 0)
     {
         do
         {
		 ; Personae Reflection
			; Aery Hunter
			; Fiery Magician
			; Grim Sorcerer
			; Create Construct
			; Earthen Avatar
			; Nightshade
			; Undead Knight
            if ( !${Me.Maintained[${Counter}].Name.Find[Aery Hunter](exists)} && !${Me.Maintained[${Counter}].Name.Find[Fiery Magician](exists)} && !${Me.Maintained[${Counter}].Name.Find[Grim Sorcerer](exists)} && !${Me.Maintained[${Counter}].Name.Find[Create Construct](exists)} && !${Me.Maintained[${Counter}].Name.Find[Earthen Avatar](exists)} && !${Me.Maintained[${Counter}].Name.Find[Nightshade](exists)} && !${Me.Maintained[${Counter}].Name.Find[Undead Knight](exists)} && !${Me.Maintained[${Counter}].Name.Find[Personae Reflection](exists)} && !${Me.Maintained[${Counter}].Name.Find[Grim Aura](exists)} && !${Me.Maintained[${Counter}].Name.Find[Summon](exists)} && ${Me.Maintained[${Counter}].Name.NotEqual[Possess Essence]} && ${Me.Maintained[${Counter}].Duration.Equal[-1]}) && ( ${Me.Maintained[${Counter}].TargetType.Equal[Raid]} || ${Me.Maintained[${Counter}].TargetType.Equal["Self Only"]} || ${Me.Maintained[${Counter}].TargetType.Equal["Pet Only"]} )
            ; || ${Me.Maintained[${Counter}].TargetType.Equal["Group"]})
				MaintainedEffects:Insert["${Me.Maintained[${Counter}].Name}"]
			echo "- ${Counter}. ${Me.Maintained[${Counter}].Name} (Duration: ${Me.Maintained[${Counter}].Duration}, TargetType: ${Me.Maintained[${Counter}].TargetType}) :: Should Be Hidden"
         
         }
         while (${Counter:Inc} <= ${CountMaintained})
     }
    else
	{
        echo ISXRI: We were not able to read your maintained effects or you are not maintaining any, ending
		Script:End
	}
	echo ISXRI: Found ${MaintainedEffects.Used} Effects to Hide
	
    Counter:Set[1]
    
	;;Now go through all your effects and match the name with ones from the index, if found Hide
	Me:RequestEffectsInfo
	Me:QueryEffects[Effects, Type == "Beneficial"]
    Effects:GetIterator[EffectsIterator]
	MaintainedEffects:GetIterator[MaintainedEffectsIterator]
    echo ${Effects.Used}
    wait 50
    if ${EffectsIterator:First(exists)}
    {
        do
        {
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; This routine is echoing the effect's "Name", so we must ensure that the effectinfo 
            ;; datatype is available.
            if (!${EffectsIterator.Value.IsEffectInfoAvailable})
            {
                ;; When you check to see if "IsEffectInfoAvailable", ISXEQ2 checks to see if it's already
                ;; cached (and immediately returns true if so).  Otherwise, it spawns a new thread 
                ;; to request the details from the server.   
                do
                {
                    wait 2
                    ;; It is OK to use waitframe here because the "IsEffectInfoAvailable" will simple return
                    ;; FALSE while the details acquisition thread is still running.   In other words, it 
                    ;; will not spam the server, or anything like that.
					;echo waiting
                }
                while ( !${EffectsIterator.Value.IsEffectInfoAvailable} && ${Timer:Inc} < 50 )
            }
            ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; At this point, the "ToEffectInfo" MEMBER of this object will be immediately available.  It should
            ;; remain available until the cache is cleared/reset (which is not very often.)
 
            ;echo "- ${Counter}. ${EffectsIterator.Value.ToEffectInfo.Name} (ID: ${EffectsIterator.Value.ID}, MainIconID: ${EffectsIterator.Value.MainIconID}, BackDropIconID: ${EffectsIterator.Value.BackDropIconID})"
			if ${MaintainedEffectsIterator:First(exists)}
			{
				do
				{
					if ${EffectsIterator.Value.ToEffectInfo.Name.Equal[${MaintainedEffectsIterator.Value}]}
					{
						echo EffectsIterator.Value:Hide
						HideCounter:Inc
						echo ISXRI: Hiding #${HideCounter} of ${MaintainedEffects.Used}: ${MaintainedEffectsIterator.Value}
						if ${HideCounter}>=${MaintainedEffects.Used}
							Script:End
					}
						
				}
				while ${MaintainedEffectsIterator:Next(exists)}
			}
            Counter:Inc
			Timer:Set[0]
        }
        while ${EffectsIterator:Next(exists)}
    }
    else
        echo ISXRI: We were not able to read your effects, ending
    ;echo "---------------------"
    Counter:Set[1]
}
function atexit()
{
	echo ISXRI: Done Hiding Effects
}