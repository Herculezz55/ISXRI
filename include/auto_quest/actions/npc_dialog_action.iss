#includeoptional "${LavishScript.HomeDirectory}/Scripts/RI/utilities/NpcHelpers.iss"

function npc_dialog_action(jsonvalueref params)
{
    variable NpcHelpers npcHelpers

    call npcHelpers.GetQuestFromNpc "${params.Get["npc_name"]}" "${params.Get["dialog_options"]}"
}