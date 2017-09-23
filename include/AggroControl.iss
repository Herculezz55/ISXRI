;AggroControl v1 by Herculezz

;variables
variable bool TrashTargeting=TRUE
variable index:actor ActorIndex
variable int count
variable int ID
variable int MobToTarget

function main(bool NamedOnly=TRUE)
{
	echo ${Time}: Starting AggroControl v1, NamedOnly: ${NamedOnly}
	
	;disable debugging
	Script:DisableDebugging
	
	;if we are not a fighter exit
	if ${Me.Archetype.NotEqual[fighter]}
		Script:End
		
	;main loop
	while 1
	{
		;if my target's target ID is not my ID, call snap function
		if ${Me.InCombat} && ${EQ2.Zoning}==0
		{
			if ${TrashTargeting} && ${FARTARONI}
			{
				;populate actors to our ActorIndex that are NPC and within distance 10
				EQ2:GetActors[ActorIndex,NPC,range,10]
				
				;echo ${Time}: ActorIndexSize: ${ActorIndex.Used}
				
				;for loop to iterate through all actors in our index
				for(count:Set[1];${count}<=${ActorIndex.Used};count:Inc)
				{
					;echo Checking ${ActorIndex[${count}].Name} Target ${ActorIndex[${count}].Target}
					;if the actor is incombatmode and not dead
					if ${ActorIndex[${count}].InCombatMode} && !${ActorIndex[${count}].IsDead}
					{
						
						;if the actor's target is not me then
						;set them to MobToTarget
						if ${ActorIndex[${count}].Target.ID}!=${Me.ID}
							MobToTarget:Set[${ActorIndex[${count}].ID}]
					}
					waitframe
					;echo checking ${count}
				}
				
				wait 2
				
				;if i am not targeting MobToTarget and it is not 0 and exists
				;target MobToTarget
				if ${Target.ID}!=${MobToTarget} && ${MobToTarget}!=0 && ${Actor[${MobToTarget}](exists)} && !${Actor[${MobToTarget}].IsDead} && ${Actor[${MobToTarget}].Target.ID}!=${Me.ID}
				{
					;echo ${Time}: Targeting ${MobToTarget} / ${Actor[${MobToTarget}]} Target: ${Actor[${MobToTarget}].Target}
					Actor[${MobToTarget}]:DoTarget
				}
			}
			if ${NamedOnly} 
			{
				if ${Target.Target(exists)} && ${Target.IsNamed} && ${Target.Target.ID}!=${Me.ID} && ${Target.Health}<100 && ${Target.Target.Class.NotEqual[guardian]} && ${Target.Target.Class.NotEqual[berserker]} && ${Target.Target.Class.NotEqual[monk]} && ${Target.Target.Class.NotEqual[bruiser]} && ${Target.Target.Class.NotEqual[paladin]} && ${Target.Target.Class.NotEqual[shadowknight]}
				{
					;echo ${Time}: I Lost Aggro, Snapping
					if !${Me.IsFD} && !${Me.IsDead}
						call Snap ${Me.SubClass}
				}
			}
			else
			{
				if ${Target.Target(exists)} && ${Target.Target.ID}!=${Me.ID} && ${Target.Health}<100 && ${Target.Target.Class.NotEqual[guardian]} && ${Target.Target.Class.NotEqual[berserker]} && ${Target.Target.Class.NotEqual[monk]} && ${Target.Target.Class.NotEqual[bruiser]} && ${Target.Target.Class.NotEqual[paladin]} && ${Target.Target.Class.NotEqual[shadowknight]}
				{
					;echo ${Time}: I Lost Aggro, Snapping, if im not FD or dead
					if !${Me.IsFD} && !${Me.IsDead}
						call Snap ${Me.SubClass}
				}
			}
		}
		wait 1
	}
}

;function to snap current target based on my class
function Snap(string MyClass)
{
	;echo ${Time}: Snapping
	;switch based on which class I am, then check which ability is ready and cast it
	switch ${MyClass}
	{
		;if I am a guardian
		case guardian
		{
			;echo ${Time}: Guardian, Aggro, Casting Something
			if ${Me.Ability[Rescue].IsReady} && ${Target.Distance}<10
				call Cast Rescue TRUE
			elseif ${Me.Ability["Sneering Assault"].IsReady}
				call Cast "Sneering Assault" TRUE
			elseif ${Me.Ability["Cry of the Warrior"].IsReady}
				call Cast "Cry of the Warrior" TRUE
			elseif ${Me.Ability["Plant VI"].IsReady}
			{
				if ${ISXOgre(exists)}
					call Cast "Plant" TRUE
				else
					call Cast "Plant VI" TRUE
			}
			elseif ${Me.Ability[Reinforcement].IsReady}
				call Cast Reinforcement TRUE
			wait 5
			break
		}
		;if I am a Monk
		case monk
		{
			;echo ${Time}: Monk, Aggro, Casting Something
			if ${Me.Ability[Rescue].IsReady} && ${Target.Distance}<10
				call Cast Rescue TRUE
			elseif ${Me.Ability["Hidden Openings"].IsReady} && ${Target.Distance}<5
				call Cast "Hidden Openings" TRUE
			elseif ${Me.Ability["Peel III"].IsReady} && ${Target.Distance}<50
			{
				if ${ISXOgre(exists)}
					call Cast "Peel" TRUE
				else
					call Cast "Peel III" TRUE
			}
			elseif ${Me.Ability["Sneering Assault"].IsReady} && ${Target.Distance}<5
				call Cast "Sneering Assault" TRUE
			elseif ${Me.Ability["Mantis Leap"].IsReady} && ${Target.Distance}<10
				call Cast "Mantis Leap" TRUE
			wait 5
			break
		}
		;if I am a Shadowknight
		case Shadowknight
		{
			;echo ${Time}: Shadowknight, Aggro, Casting Something
			if ${Me.Ability[Rescue].IsReady} && ${Target.Distance}<10
				call Cast Rescue TRUE
			elseif ${Me.Ability["Chaos Cloud"].IsReady} && ${Target.Distance}<10
				call Cast "Chaos Cloud" TRUE
			elseif ${Me.Ability["Grave Sacrament VII"].IsReady} && ${Target.Distance}<10
			{
				if ${ISXOgre(exists)}
					call Cast "Grave Sacrament" TRUE
				else
					call Cast "Grave Sacrament VII" TRUE
			}
			elseif ${Me.Ability["Sneering Assault"].IsReady} && ${Target.Distance}<5
				call Cast "Sneering Assault" TRUE
			elseif ${Me.Ability["Touch of Death"].IsReady} && ${Target.Distance}<50
				call Cast "Touch of Death" TRUE
			wait 5
			break
		}
		;if I am a Shadowknight
		case Paladin
		{
			;echo ${Time}: Shadowknight, Aggro, Casting Something
			if ${Me.Ability[Rescue].IsReady} && ${Target.Distance}<10
				call Cast Rescue TRUE
			elseif ${Me.Ability["Sneering Assault"].IsReady} && ${Target.Distance}<5
				call Cast "Sneering Assault" TRUE
			elseif ${Me.Ability["Holy Ground"].IsReady} && ${Target.Distance}<10
				call Cast "Holy Ground" TRUE
			wait 5
			break
		}
	}
}

function Cast(string AbilityName, bool CancelCast)
{
	;echo ${Time}: Casting ${AbilityName}
	;if Ogre exists
	if ${ISXOgre(exists)}
	{
		;if we want to cancel cast, send OgreBotAtom to CancelCast
		if ${CancelCast}
			OgreBotAtom a_CastFromUplink ${Me.Name} "${AbilityName}" TRUE
		;if we don't want to cancel cast, Send OgreBotAtom to queue cast
		else
			OgreBotAtom a_CastFromUplink ${Me.Name} "${AbilityName}"
			
		wait 5 !${Me.Ability["${AbilityName}"].IsReady}
	}
	;if ogre doesn't exists
	else
	{
		;pause Troll
		if ${Script[Buffer:Troll](exists)}
			Script[Buffer:Troll]:Pause
		;if we want to cancel cast, send in game commands to cancel our cast 
		;and clear the queue until we are no longer casting, then cast AbilityName
		if ${CancelCast}
		{
			while ${Me.CastingSpell}
			{
				eq2ex cancel_spellcast
				eq2ex clearabilityqueue 
				waitframe
			}
			while ${Me.Ability["${AbilityName}"].IsReady}
				Me.Ability[${AbilityName}]:Use
		}
		;if we dont want to cancel cast, wait until we are done casting and
		;cast AbilityName
		else
		{
			while ${Me.CastingSpell}
				waitframe
			while ${Me.Ability["${AbilityName}"].IsReady}
				Me.Ability[${AbilityName}]:Use
		}
		;resume Troll
		if ${Script[Buffer:Troll](exists)}
			Script[Buffer:Troll]:Resume
	}
}

;function called upon script ending
function atexit()
{
	echo ${Time}: Ending AggroControl v1
}