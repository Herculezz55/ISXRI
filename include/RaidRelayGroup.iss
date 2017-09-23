;script to set and join our relaygroup by Herculezz v1
variable(globalkeep) string RI_Var_String_RelayGroup
;variable(global) string RG_Var_Bool_RelayGroupSet=FALSE

;main function
function main()
{
	;disable debugging
	Script:DisableDebugging
	
	if ${Debug}
		echo Starting RaidRelayGroup.iss
	RI_Var_String_RelayGroup:Set["RIRaidRelayGroup"]
	uplink relaygroup -join ${RI_Var_String_RelayGroup}
}
function atexit()
{
	if ${Debug}
		echo Ending RaidRelayGroup.iss
}