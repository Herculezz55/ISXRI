

#include "${LavishScript.HomeDirectory}/Scripts/RI/auto_quest/property_editors/property_editors.iss"
#include "${LavishScript.HomeDirectory}/Scripts/RI/auto_quest/actions/actions.iss"

objectdef QuestWriterController
{
    variable string CurrentStepType
    variable weakref CurrentStepProperties

    variable jsonvalue QuestSteps = []
    
    member:jsonvalueref FormatPropertiesForDisplay(jsonvalue step)
    {
        echo "Formatting properties for ${step.Get["type"]}"

        variable jsonvalue stepItem
        variable weakref stepProperties
        stepProperties:SetReference[${PropertyEditors.GetPropertyEditor[${step.Get["type"]}]}]
        

        stepItem:SetValue["${stepProperties.GetDisplayForProperties[step]}"]
        
        return stepItem
    }

    member:string GetQuestStepsForDisplay()
    {
        variable jsoniterator stepIterator
        This.QuestSteps:GetIterator[stepIterator]

        if ${stepIterator:First(exists)}
        {
            variable jsonvalue listItems = "[]"
            variable jsonvalue stepItem
            variable jsonvalue listItem

            do
            {
                stepItem:SetValue["${This.FormatPropertiesForDisplay["${stepIterator.Value.AsJSON~}"].AsJSON~}"]
                stepItem:Set["_dock", "\"left\""]
                stepItem:Set["widthFactor", "0.8"]


                listItem:SetValue[$$>"{
                    "type": "dockpanel",
                    "widthFactor": .18,
                    "children": [
                        ${stepItem.AsJSON~},
                        {
                            "type": "button",
                            "content": "Test",
                            "_dock": "right",
                            "verticalAlignment": "center",

                            "_step": ${stepIterator.Value.AsJSON~}
                            "eventHandlers": {
                                "onRelease": {
                                    "type": "method",
                                    "object": "RIQuestWriterController",
                                    "method": "OnTestStepButtonClick",
                                }
                            }
                        }
                    ]
                }"<$$]

                listItems:Add["${listItem.AsJSON~}"]

            }
            while ${stepIterator:Next(exists)}
        }
        return ${listItems.AsJSON~}
    }
    

    method Initialize()
    {
        LGUI2:LoadPackageFile["writer.json"]
    }

    method Shutdown()
    {
        LGUI2:UnloadPackageFile["writer.json"]
    }

    method OnClose()
    {
        Script:End
    }

    method OnConfigureNewStep()
    {
        LGUI2.Element["RI.quest_writer.properties_panel"]:ClearChildren
        CurrentStepProperties:SetReference[${PropertyEditors.GetPropertyEditor[${Context.Source.Metadata.Get["stepType"]}]}]
        LGUI2.Element["RI.quest_writer.properties_panel"]:AddChild[CurrentStepProperties.GetUI]
    }

    method OnTestStepButtonClick()
    {
        variable jsonvalue step
        step:SetValue["${Context.Source.Metadata.Get["step"].AsJSON~}"]

        echo "Testing step ${step.Get["params"].AsJSON~}"
        QueueCommand call RunAction ${step.Get["type"]} "${step.Get["params"].AsJSON~}"
        
    }

    method OnAddStepButtonClick()
    {
        This.QuestSteps:Add["${This.CurrentStepProperties.GetDialogOptions.AsJSON~}"]
        LGUI2.Element[RIQuestWriterController.events]:FireEventHandler[onNewStepAdded]
        LGUI2.Element["RI.quest_writer.properties_panel"]:ClearChildren
    }

}

variable(global) QuestWriterController RIQuestWriterController

function main()
{
    while 1
    {
        ExecuteQueued
        wait 1
    }
}