#include "${LavishScript.HomeDirectory}/scripts/RI/common/file_helpers.iss"

objectdef RunPathPropertiesController
{
    variable jsonvalue PropertyEditorUi ="{}"
    variable jsonvalue ListViewUi ="{}"

    variable jsonvalue PathToRun = "[]"

    variable string StepType = "run_path"
    variable string PropertyPath

 

    member:jsonvalueref GetUI()
    {
        return PropertyEditorUi
    }

    member:float GetDistanceFromLastPoint()
    {
        if ${PathToRun.Used} == 0
        {
            return 0
        }
        variable jsonvalueref lastPoint = PathToRun.Get[${PathToRun.Used}]
        return ${Math.Distance["${Me.Loc.X}", "${Me.Loc.Y}", "${Me.Loc.Z}", "${lastPoint.Get["x"]}", "${lastPoint.Get["y"]}", "${lastPoint.Get["z"]}"]}
    }

    member:jsonvalueref GetDialogOptions()
    {
        variable jsonvalue dialogOptions

        dialogOptions:SetValue[$$>"{
            "type": "${This.StepType}",
            "params": {
                "path": ${This.PathToRun.AsJSON~}
            }
        }"<$$]

        return dialogOptions
    }

    member:jsonvalueref GetDisplayForProperties(jsonvalueref step)
    {
        variable jsonvalue theUi
        variable jsoniterator pathIterator
        variable string currentPoint

        theUi:SetValue["${This.ListViewUi.AsJSON~}"]
        step.Get["params", "path"]:GetIterator[pathIterator]

        if ${pathIterator:First(exists)}
        {
            do
            {
                currentPoint:Set["x: ${pathIterator.Value.Get["x"]} y: ${pathIterator.Value.Get["y"]} z: ${pathIterator.Value.Get["z"]}"]
                theUi.Get["children", 2, "items"]:Add["${currentPoint.AsJSON~}"]
            }
            while ${pathIterator:Next(exists)}
        }


        return theUi
    }

    method Initialize()
    {
        This.PropertyPath:Set["${FileHelpers.GetDirectoryFromFilePath["_FILE_"]}"] 
        PropertyEditorUi:ParseFile["${This.PropertyPath}/editor_ui.json"]
        ListViewUi:ParseFile["${This.PropertyPath}/list_ui.json"]
    }

    method OnAddPointClick()
    {
        PathToRun:Add[$$>"{
            x: ${Me.Loc.X},
            y: ${Me.Loc.Y},
            z: ${Me.Loc.Z}
        }"<$$]
    }
}