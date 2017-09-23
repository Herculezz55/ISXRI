function main()
{
	;disable debugging
	Script:DisableDebugging
	
	if ${Me.Class.Equal[enchanter]}
	{
		OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Possess Essence" FALSE
		Me.Maintained["Possess Essence"]:Cancel
	}
	do
	{
		if ${Me.Class.Equal[enchanter]} && ${Me.Ability["Charm IX"].IsReady}
			Me.Ability["Charm IX"]:Use
		
		if ${Me.Archetype.Equal[fighter]} && ${Target(exists)} && !${Target.IsAggro}
			eq2ex target_none
			
		wait 1
	}
	while ${RI(exists)}
}
function atexit()
{
	if ${Me.Class.Equal[enchanter]}
	{
		Me.Maintained["Charm IX"]:Cancel
		OgreBotAtom aExecuteAtom ${Me.Name} a_QueueCommand ChangeCastStackListBoxItem "Possess Essence" TRUE
	}
}