#ifndef _RI_api_
#define _RI_api_
objectdef RIApi
{
    variable string test = "test RIAPI";
    member:bool IsForMe(string forWhoTarget)
    {
        variable string target = ${forWhoTarget}
        variable string prefix = ${forWhoTarget.Token[1, ":"]}
        variable bool negate = FALSE

        echo "IsForMe ${forWhoTarget} ${prefix} ${target}"
        
		
        if ${target.Count[":"]} > 0
        {
            negate:Set[${prefix.Equal["not"]}]
            target:Set[${forWhoTarget.Token[2, ":"]}];
        }

        if ${prefix.Equal["igw"]}
        {
            return ${Me.Group["${target}"](exists)}
        }
        
        if ${prefix.Equal["igwbn"]}
        {

            return !${Me.Name.Equal["${target}"]) && ${Me.Group["${target}"](exists)}
        }

        if ${prefix.Equal["irw"]}
        {
            return ${Me.Raid["${target}"](exists)}
        }
        
        if ${prefix.Equal["irwbn"]}
        {
            return !${Me.Name.Equal["${target}"]) && ${Me.Raid["${target}"](exists)}
        }

        if ${target.Equal["${Me.Name}"]} || ${target.Equal["all"]}
        {
            echo "Name match ${negate.Not}"
            return ${negate.Not};
        }

        if ${target.Equal["${Me.Class}"]} || ${target.Equal["${Me.SubClass}"]} || ${target.Equal["${Me.Archetype}"]}
        {
            return ${negate.Not};
        }

        if ${target.Equal["melee"]} && (${Me.Archetype.Equal["fighter"]} || ${Me.Archetype.Equal["scout"]})
        {
            echo "melee match"
            return ${negate.Not};
        }

        if ${target.Equal["caster"]} && (${Me.Archetype.Equal["mage"]} || ${Me.Archetype.Equal["priest"]})
        {
            return ${negate.Not};
        }
        

        return ${negate}
    }

    function MoveTo(string forWho, point3f location, float minDistance = 0)
    {
        echo "Moving to ${location}"
        if ${This.IsForMe["${forWho}"]}
        {
            RINav:MoveTo["${location}"]
        }
        else
        {
            echo "${forWho} NotForMe"
        }
    }

    function WaitForMoveTo(string forWho, point3f location, float minDistance = 0)
    {
        echo "Waiting for move to ${location}"
         while ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${location.X},${location.Y},${location.Z}]} > ${minDistance}
            {
                echo "waiting for path to complete ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${location.X},${location.Y},${location.Z}]}"
                wait 5
            }

function ActivateSpecial(string ActorName, float X, float Y, float Z)
{
	call TestArrivalCoord  ${X} ${Y} ${Z}
	if (!${Return})
		call MoveTo "${ActorName}" ${X} ${Y} ${Z}
	RI:Special["${Me.Name}"]
	wait 50
}

function ActivateVerbOn(string ActorName, string verb, bool UseID)
{
	echo do ${verb} on ${ActorName} (${UseID})
	if ${UseID}
		eq2execute apply_verb ${Actor[Query,Name=="${ActorName}"].ID} "${verb}"
	else
		RI:ApplyVerbForWho["${Me.Name}","${ActorName}","${verb}"]
	wait 50
}

;===================================================================================
;long list below
;

function DescribeActor(int ActorID)
{
	echo ID:				${ActorID}
	echo Name:				${Actor[${ActorID}].Name}
	echo LastName:			${Actor[${ActorID}].LastName}
	echo Health:			${Actor[${ActorID}].Health}
	echo Power:				${Actor[${ActorID}].Power}
	echo Level:				${Actor[${ActorID}].Level}
	echo EffectiveLevel:	${Actor[${ActorID}].EffectiveLevel}
	echo TintFlags:			${Actor[${ActorID}].TintFlags}
	echo VisualVariant:		${Actor[${ActorID}].VisualVariant}
	echo Mood:				${Actor[${ActorID}].Mood}
	echo CurrentAnimation:	${Actor[${ActorID}].CurrentAnimation}
	echo Overlay:			${Actor[${ActorID}].Overlay}
	echo Aura:				${Actor[${ActorID}].Aura}
	echo Gender:			${Actor[${ActorID}].Gender}
	echo Race:				${Actor[${ActorID}].Race}
	echo Class:				${Actor[${ActorID}].Class}
	echo Guild:				${Actor[${ActorID}].Guild}
	echo Type:				${Actor[${ActorID}].Type}
	echo SuffixTitle:		${Actor[${ActorID}].SuffixTitle}
	echo ConColor:			${Actor[${ActorID}].ConColor}
	echo Distance: 			${Actor[${ActorID}].Distance}
	echo X					${Actor[${ActorID}].Loc.X}
	echo Y					${Actor[${ActorID}].Loc.Y}
	echo Z					${Actor[${ActorID}].Loc.Z}
}
	}
		}
;===================================================================================
;long list below
;

function get_Archetype(string ToonClass)
{
	switch ${ToonClass}
	{
		case warrior
		{
			return fighter
			break
		}
		case berserker
		{
			return fighter
			break
		}
		case guardian
		{
			return fighter
			break
		}
		case paladin
		{
			return fighter
			break
		}
		case shadowknight
		{
			return fighter
			break
		}
		case monk
		{
			return fighter
			break
		}
		case bruiser
		{
			return fighter
			break
		}
		case warden
		{
			return priest
			break
		}
		case mystic
		{
			return priest
			break
		}
		case defiler
		{
			return priest
			break
		}
		case fury
		{
			return priest
			break
		}
		case templar
		{
			return priest
			break
		}
		case inquisitor
		{
			return priest
			break
		}
		case conjuror
		{
			return mage
			break
		}
		case necromancer
		{
			return mage
			break
		}
		case warlock
		{
			return mage
			break
		}
		case wizard
		{
			return mage
			break
		}
		case illusionist
		{
			return mage
			break
		}
		case coercer
		{
			return mage
			break
		}
		Default
		{
			return scout
			break
		}	
	}
}

;===================================================================================

    }
}

#endif
