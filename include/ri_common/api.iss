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

	/* ================================================
		Movement
	*/ ================================================

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




function DetectCircles(float Distance, string Color)
{ 
	variable index:actor Actors
    variable iterator ActorIterator
	variable int Counter
	;echo in DetectCircles
    if (${Distance}<1)
		Distance:Set[10]
    EQ2:QueryActors[Actors, Distance <= ${Distance}]
    Actors:GetIterator[ActorIterator]
	if ${ActorIterator:First(exists)}
    {       
		do
		{
			if (${Actor[${ActorIterator.Value.ID}].Aura.Equal[${Color}]})
			;if (${ActorIterator.Value.Name.Equal[""]} && ${ActorIterator.Value.Distance}<${Distance})
			{
				;echo ${Actor[${ActorIterator.Value.ID}].Aura.Equal[${Color}]} (${ActorIterator.Value.ID}) spotted
				Counter:Inc
			}
		}
        while (${ActorIterator:Next(exists)})
	}
	return ${Counter}
	;echo out DetectCircles
}






function FindLoS(string ActorName, string KeytoPress, float Distance, int PressTime)
{
	if (${PressTime}<5)
		PressTime:Set[5]
	if (${Distance}<1)
		Distance:Set[20]
	do
	{
		face ${Actor["${ActorName}"].X} ${Actor["${ActorName}"].Z}
		if (!${Actor["${ActorName}"].CheckCollision})
		{
			echo found LoS against ${ActorName}
		}
		else
		{
			call PKey "${KeytoPress}" ${PressTime}
		}
		wait 5
	}
	while (${Actor["${ActorName}"].CheckCollision} && ${Actor["${ActorName}"].Distance} < ${Distance})
}

function Follow2D(string ActorName,float X, float Y, float Z, float RespectDistance, bool Walk)
{
	variable index:actor Actors
	variable iterator ActorIterator
	variable bool Vanished
	
	EQ2:QueryActors[Actors, Name  =- "${ActorName}" && Distance <= 50]
	Actors:GetIterator[ActorIterator]
	if ${ActorIterator:First(exists)}
	{
		do
		{
			if  (${ActorIterator.Value.Distance}> ${RespectDistance})
				call 2DNav ${ActorIterator.Value.X} ${ActorIterator.Value.Z} ${Walk}
			wait 5
			call IsPresent "${ActorName}" 50
			Vanished:Set[!${Return}]
			call TestArrivalCoord ${X} ${Y} ${Z}
		}	
		while (!${Return} && !${Vanished} )
	}
}






	/* ================================================
		specials
	*/ ================================================

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


function CheckPlayerAtCoordinates(float X, float Y, float Z, float Distance)
{
	variable index:actor Actors
	variable iterator ActorIterator
	
	echo calling CheckPlayerAtCoordinates ${X} ${Y} ${Z} ${Distance}
	if (${Distance}<1)
		Distance:Set[30]
	
	EQ2:QueryActors[Actors, Type  = "PC" && Guild != "${Me.Guild}"]
	if ${ActorIterator:First(exists)}
	{
		do
		{
			echo Found ${ActorIterator.Value.Name} (${ActorIterator.Value.X} ${ActorIterator.Value.Y} ${ActorIterator.Value.Z})
			if (${Math.Distance[${ActorIterator.Value.X},${ActorIterator.Value.Y},${ActorIterator.Value.Z},${X},${Y},${Z}]}<${Distance})
				return TRUE
		}
		while (${ActorIterator:Next(exists)})
	}
	return FALSE
}


function CheckWalking()
{

if (${Math.Calc64[${Me.Velocity.X} * ${Me.Velocity.X} + ${Me.Velocity.Y} * ${Me.Velocity.Y} + ${Me.Velocity.Z} * ${Me.Velocity.Z} ]}>100)
return FALSE
else
return TRUE
}


function ClickOn(string ActorName)
{
	variable index:actor Actors
	variable iterator ActorIterator
	
	EQ2:QueryActors[Actors, Name  =- "${ActorName}" && Distance <= 10]
	Actors:GetIterator[ActorIterator]
	if ${ActorIterator:First(exists)}
	{
		echo click on ${ActorIterator.Value.Name}
		Actor[name,"${ActorIterator.Value.Name}"]:DoubleClick
	}
}



;===================================================================================
; Descriptions


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
function DescribeActorbyName(string ActorName, bool Exact)
{
	variable index:actor Actors
	variable iterator ActorIterator
	if (${Exact})
		EQ2:QueryActors[Actors, Name  = "${ActorName}"]
	else
		EQ2:QueryActors[Actors, Name  =- "${ActorName}"]
	Actors:GetIterator[ActorIterator]
	if ${ActorIterator:First(exists)}
	{
		call DescribeActor ${ActorIterator.Value.ID}
		return TRUE
	}
	else
		return FALSE
}
function DescribeItemInventory(string ItemName)
{
	call DescribeItem "${ItemName}" "Inventory"
}
function DescribeItem(string ItemName, string ItemLocation)
{
    variable index:item Items
    variable iterator ItemIterator
    variable int Counter = 1
    
    Me:QueryInventory[Items, Location =- "${ItemLocation}" && Name =- "${ItemName}"]
    Items:GetIterator[ItemIterator]
 
 
    if ${ItemIterator:First(exists)}
    {
        do
        {
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; This routine is echoing the item "Description", so we must ensure that the iteminfo 
            ;; datatype is available.
            if (!${ItemIterator.Value.IsItemInfoAvailable})
            {
                ;; When you check to see if "IsItemInfoAvailable", ISXEQ2 checks to see if it's already
                ;; cached (and immediately returns true if so).  Otherwise, it spawns a new thread 
                ;; to request the details from the server.   
                do
                {
                    waitframe
                    ;; It is OK to use waitframe here because the "IsItemInfoAvailable" will simply return
                    ;; FALSE while the details acquisition thread is still running.   In other words, it 
                    ;; will not spam the server, or anything like that.
                }
                while (!${ItemIterator.Value.IsItemInfoAvailable})
            }
            ;;
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            ;; At this point, the "ToItemInfo" MEMBER of this object will be immediately available.  It should
            ;; remain available until the cache is cleared/reset (which is not very often.)
            echo "${Counter}. ${ItemIterator.Value.Name} : Index : '${ItemIterator.Value.Index}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : ID : '${ItemIterator.Value.ID}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : SerialNumber : '${ItemIterator.Value.SerialNumber}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : Name : '${ItemIterator.Value.Name}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : Location : '${ItemIterator.Value.Location}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : ToLink : '${ItemIterator.Value.ToLink}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : LinkID : '${ItemIterator.Value.LinkID}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IconID : '${ItemIterator.Value.IconID}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : Quantity : '${ItemIterator.Value.Quantity}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : EffectiveLevel : '${ItemIterator.Value.EffectiveLevel}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : Slot : '${ItemIterator.Value.Slot}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsReady : '${ItemIterator.Value.IsReady}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : TimeUntilReady : '${ItemIterator.Value.TimeUntilReady}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : InInventorySlot : '${ItemIterator.Value.InInventorySlot}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsInventoryContainer : '${ItemIterator.Value.IsInventoryContainer}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsBankConatainer : '${ItemIterator.Value.IsBankContainer}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsSharedBankContainer : '${ItemIterator.Value.IsSharedBankContainer}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsAutoConsumeable : '${ItemIterator.Value.IsAutoConsumeable}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : AutoConsumeOn : '${ItemIterator.Value.AutoConsumeOn}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : CanBeRedeemed : '${ItemIterator.Value.CanBeRedeemed}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsFoodOrDrink : '${ItemIterator.Value.IsFoodOrDrink}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsScribeable : '${ItemIterator.Value.IsScribeable}'"
            echo "${Counter}. ${ItemIterator.Value.Name} : IsUsable : '${ItemIterator.Value.IsUsable}'"
			echo "${Counter}. ${ItemIterator.Value.Name} : IsAgent : '${ItemIterator.Value.IsAgent}'"
			echo "${Counter}. ${ItemIterator.Value.Name} : Tier : '${ItemIterator.Value.ToItemInfo.Tier}'"
			echo "${Counter}. ${ItemIterator.Value.Name} : Description : '${ItemIterator.Value.ToItemInfo.Description}'"
			echo "${Counter}. ${ItemIterator.Value.Name} : Type : '${ItemIterator.Value.ToItemInfo.Type}'"
			call IsOverseerQuest "${ItemIterator.Value.Name}"
			echo "${Counter}. ${ItemIterator.Value.Name} : IsOverseerQuest : '${Return}'"
            Counter:Inc
        }
        while ${ItemIterator:Next(exists)}
    }
    else
	echo no item "${ItemName}" in Inventory
}


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
;long Archetype
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
