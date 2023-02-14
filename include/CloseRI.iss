function main()
{
	;disable debugging
	Script:DisableDebugging
	
	;if the scripts are running, End them
	if ${Script[Buffer:RIMovement](exists)}
		Script[Buffer:RIMovement]:End
	if ${Script[Buffer:RIOverseer](exists)}
		Script[Buffer:RIOverseer]:End
	if ${Script[Buffer:RIMovementUI](exists)}
		Script[Buffer:RIMovementUI]:End
	if ${Script[Buffer:RunInstances](exists)}
		Script[Buffer:RunInstances]:End
	if ${Script[Buffer:RILooter](exists)}
		Script[Buffer:RILooter]:End
	if ${Script[Buffer:RZ](exists)}
		Script[Buffer:RZ]:End
	if ${Script[Buffer:AntiAFK](exists)}
		Script[Buffer:AntiAFK]:End
	if ${Script[Buffer:CoT](exists)}
		Script[Buffer:CoT]:End
	if ${Script[Buffer:Depot](exists)}
		Script[Buffer:Depot]:End
	if ${Script[Buffer:Updater](exists)}
		Script[Buffer:Updater]:End
	if ${Script[Buffer:Vexven](exists)}
		Script[Buffer:Vexven]:End
	if ${Script[Buffer:RelayGroup](exists)}
		Script[Buffer:RelayGroup]:End
	if ${Script[Buffer:DeTarget](exists)}
		Script[Buffer:DeTarget]:End
	if ${Script[Buffer:OgrePlayNice](exists)}
		Script[Buffer:OgrePlayNice]:End
	if ${Script[Buffer:AggroControl](exists)}
		Script[Buffer:AggroControl]:End
	if ${Script[Buffer:Auth](exists)}
		Script[Buffer:Auth]:End
	if ${Script[Buffer:Bull](exists)}
		Script[Buffer:Bull]:End
	if ${Script[Buffer:Captain](exists)}
		Script[Buffer:Captain]:End
	if ${Script[Buffer:Charanda](exists)}
		Script[Buffer:Charanda]:End
	if ${Script[Buffer:Farozth](exists)}
		Script[Buffer:Farozth]:End
	if ${Script[Buffer:Ferun](exists)}
		Script[Buffer:Ferun]:End
	if ${Script[Buffer:Grethah](exists)}
		Script[Buffer:Grethah]:End
	if ${Script[Buffer:Grevog](exists)}
		Script[Buffer:Grevog]:End
	if ${Script[Buffer:Icon](exists)}
		Script[Buffer:Icon]:End
	if ${Script[Buffer:Imbiber](exists)}
		Script[Buffer:Imbiber]:End
	if ${Script[Buffer:Jessip](exists)}
		Script[Buffer:Jessip]:End
	if ${Script[Buffer:Kerridicus](exists)}
		Script[Buffer:Kerridicus]:End
	if ${Script[Buffer:Protector](exists)}
		Script[Buffer:Protector]:End
	if ${Script[Buffer:Sacrificer](exists)}
		Script[Buffer:Sacrificer]:End
	if ${Script[Buffer:Teraradus](exists)}
		Script[Buffer:Teraradus]:End
	if ${Script[Buffer:Torso](exists)}
		Script[Buffer:Torso]:End
	if ${Script[Buffer:Virtuoso](exists)}
		Script[Buffer:Virtuoso]:End
	if ${Script[Buffer:Zadune](exists)}
		Script[Buffer:Zadune]:End
	if ${Script[Buffer:RIMovementUI](exists)}
		Script[Buffer:RIMovementUI]:End
	if ${Script[Buffer:ZoneReset](exists)}
		Script[Buffer:ZoneReset]:End
	if ${Script[Buffer:RIMobHud](exists)}
		Script[Buffer:RIMobHud]:End
	if ${Script[Buffer:RI](exists)}
		Script[Buffer:RI]:End
	if ${Script[Buffer:RILogin](exists)}
		Script[Buffer:RILogin]:End
	if ${Script[Buffer:RIAutoTarget](exists)}
		Script[Buffer:RIAutoTarget]:End
	if ${Script[Buffer:CombatBot](exists)}
		Script[Buffer:CombatBot]:End
	if ${Script[Buffer:RIAutoDeity](exists)}
		Script[Buffer:RIAutoDeity]:End
	if ${Script[Buffer:RIHarvest](exists)}
		Script[Buffer:RIHarvest]:End	
	if ${Script[Buffer:RIWriteLocs](exists)}
		Script[Buffer:RIWriteLocs]:End
	if ${Script[Buffer:RA](exists)}
		Script[Buffer:RA]:End
	if ${Script[Buffer:RPG](exists)}
		Script[Buffer:RPG]:End
	if ${Script[Buffer:RICharList](exists)}
		Script[Buffer:RICharList]:End
	if ${Script[Buffer:RIBalance](exists)}
		Script[Buffer:RIBalance]:End
	if ${Script[Buffer:RoRDisguiseFlute](exists)}
		Script[Buffer:RoRDisguiseFlute]:End
}