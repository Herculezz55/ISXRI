#include "${LavishScript.HomeDirectory}/scripts/RI/common/file_helpers.iss"

objectdef NPCDialogPropertiesController
{
    variable string CurrentDialogOptions
    variable string CurrentNPCName
    variable jsonvalue propertyEditorUi ="{}"
    variable jsonvalue listViewUi ="{}"

    variable string StepType = "npc_dialog"
    variable string PropertyPath

    member:jsonvalueref GetUI()
    {
        return propertyEditorUi
    }

    member:jsonvalueref GetDialogOptions()
    {
        variable jsonvalue dialogOptions

        dialogOptions:SetValue[$$>"{
            "type": "${This.StepType}",
            "params": {
                "npc_name": ${This.CurrentNPCName.AsJSON~},
                "dialog_options": ${This.CurrentDialogOptions.AsJSON~}
            }
        }"<$$]

        return dialogOptions
    }

    member:jsonvalueref GetDisplayForProperties(jsonvalueref step)
    {
        variable string options = "N/A"
        variable string npcName = "N/A"
        variable jsonvalue theUi

        theUi:SetValue["${This.listViewUi.AsJSON~}"]
        npcName:Set["${step.Get["params","npc_name"]}"]
        options:Set["${step.Get["params","dialog_options"]}"]

        theUi.Get["children", 2, "children", 2]:SetString["text", "${npcName}"]
        theUi.Get["children", 3, "children", 2]:SetString["text", "${options}"]

        return theUi
    }

    method Initialize()
    {
        This.PropertyPath:Set["${FileHelpers.GetDirectoryFromFilePath["_FILE_"]}"] 
        propertyEditorUi:ParseFile["${This.PropertyPath}/editor_ui.json"]
        listViewUi:ParseFile["${This.PropertyPath}/list_ui.json"]
    }

    method OnSetNPCNameButtonClick()
    {
        This.CurrentNPCName:Set["${Me.Target.Name}"]
    }
}