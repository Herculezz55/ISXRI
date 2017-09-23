;Evac script by Herculezz v1
;
;1647605107 - Escape (Scouts)
;340378711 - Verdurous Journey (Warden)
;1338767926 - Depart (Wizard)
;1107779827 - Shadowy Elusion (Shadowknight)

function main()
{
	if ${Me.Archetype.Equal[scout]}
		call Evac 1647605107
	elseif ${Me.SubClass.Equal[warden]}
		call Evac 340378711
	elseif ${Me.SubClass.Equal[shadowknight]}
		call Evac 1107779827
	elseif ${Me.SubClass.Equal[wizard]}
		call Evac 1338767926
	else
		call Evac 0
}

;Evac function
function Evac(int AbilityID)
{
	if ${AbilityID}==0
	{
		wait 30
		Me.Inventory[Totem of Escape]:Use
		wait 2
		Me.Inventory[Totem of Escape]:Use
		wait 2
		Me.Inventory[Totem of Escape]:Use
	}
	else
	{
		declare GiveUpTime int ${Math.Calc[${Script.RunningTime}+10000]}
		while ${Me.Ability[id,${AbilityID}].IsReady}
		{
			if ${Script.RunningTime}>${GiveUpTime}
			{
				;echo We failed to cast evac and tried for 10s
				return
			}
			Me.Ability[id,${AbilityID}]:Use
			wait 2
			wait 2 ${Me.CastingSpell}
			wait 30 !${Me.CastingSpell}
			wait 2
		}
	}
}