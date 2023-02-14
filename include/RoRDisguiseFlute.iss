function main()
{
	while 1
    {
        wait 2
        if ${Me.InCombatMode} || ${Me.FlyingUsingMount}
        {
            RI_Var_Bool_PauseMovement:Set[0]
            continue
        }
        if !${Me.Maintained[Play Ismail's Flute](exists)} && ${Me.Inventory[Query, Name=-"Ismail's Flute" && Location=="Inventory"](exists)}
        {
            RI_Var_Bool_PauseMovement:Set[1]
            while ${Me.IsMoving}
                wait 1
        
            Me.Inventory[Query, Name=-"Ismail's Flute" && Location=="Inventory"]:Use
            wait 5 ${Me.CastingSpell}
            wait 50 !${Me.CastingSpell}
            wait 5
        }
        elseif !${Me.Maintained[Raj'Dur Ruffian Disguise](exists)} && ${Me.Inventory[Query, Name=-"Raj'Dur Ruffian Disguise" && Location=="Inventory"](exists)}
        {
            RI_Var_Bool_PauseMovement:Set[1]
            while ${Me.IsMoving}
                wait 1

            Me.Inventory[Query, Name=-"Raj'Dur Ruffian Disguise" && Location=="Inventory"]:Use
            wait 5 ${Me.CastingSpell}
            wait 50 !${Me.CastingSpell}
            wait 5
        }
        elseif ${RI_Var_Bool_PauseMovement}
            RI_Var_Bool_PauseMovement:Set[0]
    }
}