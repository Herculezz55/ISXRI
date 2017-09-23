;quest test

function main(bool Prompt=TRUE)
{
	;disable debugging
	Script:DisableDebugging
	
	echo ISXRI: Starting ShareMissions
	if ${Prompt}
	{
		MessageBox -skin eq2 -YesNo "Are you sure you want to SHARE All your Mission Quests?"
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
				echo ISXRI: Sharing: "${QuestsIterator.Value.Name}"
				QuestsIterator.Value:Share
				wait 15
			}
        }
        while ${QuestsIterator:Next(exists)}
    }
	else
		echo none
}
function atexit()
{
	echo ISXRI: Ending ShareMissions
}