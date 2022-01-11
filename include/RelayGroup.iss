;script to set and join our relaygroup by Herculezz v1

;main function
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	if ${RI_Var_Bool_Debug}
		echo Starting RelayGroup.iss
	
	wait 600 ${EQ2.Zoning}==0
	
	if ${Me.Name.Find[Skyshrine Guardian](exists)}
	{
		RI_Var_Int_RelayGroupSize:Set[1]
		RI_Var_String_RelayGroup:Set[SG-${Session}]
	}
	elseif ${Me.Name.Find[Skyshrine Infiltrator](exists)}
	{
		RI_Var_Int_RelayGroupSize:Set[1]
		RI_Var_String_RelayGroup:Set[SI-${Session}]
	}
	else
	{
		declare GroupArray[${Me.Group}] string
		declare Group string
		RI_Var_Int_RelayGroupSize:Set[${Me.Group}]
		variable int count=0
		for(count:Set[1];${count}<=${Me.Group};count:Inc)
			GroupArray[${count}]:Set[${Me.Group[${Math.Calc[${count}-1]}].Name.Replace["'",""].Replace[" ",""]}]
		variable int count2=0
		declare temp string
		for(count:Set[1];${count}<=${GroupArray.Size};count:Inc)
		{
			for(count2:Set[1];${count2}<=${GroupArray.Size};count2:Inc)
			{
				if ${GroupArray[${count2}].Compare[${GroupArray[${count}]}]}>0
				{
					temp:Set[${GroupArray[${count}]}]
					GroupArray[${count}]:Set[${GroupArray[${count2}]}]
					GroupArray[${count2}]:Set[${temp}]
				}
			}
		}
		variable string temp1
		temp1:Set[${GroupArray[1]}]
		for(count:Set[2];${count}<=${GroupArray.Size};count:Inc)
		{
			temp1:Concat[${GroupArray[${count}]}]
		}

		RI_Var_String_RelayGroup:Set[${temp1}]
	}
	uplink relaygroup -join ${RI_Var_String_RelayGroup}
	wait 5
	if ${RI_Var_Bool_Debug}
		echo ${Time}: Set and joined our relaygroup ${RI_Var_String_RelayGroup}, Waiting for RI to close us.
	;RG_Var_Bool_RelayGroupSet:Set[TRUE]
	;while 1
		;wait 100
}
function atexit()
{
	if ${RI_Var_Bool_Debug}
		echo Ending RelayGroup.iss
}