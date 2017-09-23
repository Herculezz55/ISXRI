;quest test

function main(bool Prompt=TRUE)
{
	;disable debugging
	Script:DisableDebugging
	
	echo ISXRI: Starting DeleteMissions
	if ${Prompt}
	{
		MessageBox -skin eq2 -YesNo "Are you sure you want to DELETE All your Mission Quests?"
		if ${UserInput.Equal[No]}
			Script:End
	}
	
	variable index:quest Quests
    variable iterator QuestsIterator
    
    QuestJournalWindow:GetActiveQuests[Quests]
    Quests:GetIterator[QuestsIterator]
  
    if ${QuestsIterator:First(exists)}
    {
        do
        {
			if ${QuestsIterator.Value.Category.Equal[Mission]} || ${QuestsIterator.Value.Category.Equal[Mission: Weekly]}
			{
				echo ISXRI: Deleting: "${QuestsIterator.Value.Name}"
				QuestsIterator.Value:Delete
				wait 5
			}
        }
        while ${QuestsIterator:Next(exists)}
    }
	
}
function atexit()
{
	echo ISXRI: Ending DeleteMissions
}