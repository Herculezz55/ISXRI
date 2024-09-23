#ifndef _RI_property_editors_
#define _RI_property_editors_

#includeoptional "${LavishScript.HomeDirectory}/Scripts/RI/auto_quest/property_editors/npc_dialog_properties/editor.iss"
#includeoptional "${LavishScript.HomeDirectory}/Scripts/RI/auto_quest/property_editors/run_path_properties/editor.iss"


variable(global) NPCDialogPropertiesController RINPCDialogPropertiesController
variable(global) RunPathPropertiesController RIRunPathPropertiesController

objectdef PropertyEditors
{
    static member GetPropertyEditor( string stepType )
    {
        echo "PropertyEditors::GetPropertyEditor[${stepType}]"
        if ${stepType.Equal["${RINPCDialogPropertiesController.StepType}"]}
        {
            return RINPCDialogPropertiesController;
        }
        if ${stepType.Equal["${RIRunPathPropertiesController.StepType}"]}
        {
            return RIRunPathPropertiesController;
        }

        return null;
    }
}

#endif