#ifndef _RI_auto_quest_actions_
#define _RI_auto_quest_actions_

#include "${LavishScript.HomeDirectory}/Scripts/RI/auto_quest/actions/npc_dialog_action.iss"
#include "${LavishScript.HomeDirectory}/Scripts/RI/auto_quest/actions/run_path_action.iss"

function RunAction(string actionType, jsonvalue params)
{
    if ${actionType.Equal["npc_dialog"]}
    {
        call npc_dialog_action params
    }
    if ${actionType.Equal["run_path"]}
    {
        call run_path_action params
    }
}

#endif