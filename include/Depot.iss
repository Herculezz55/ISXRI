;Depot v1 by Herculezz

;another option to deposit all, eq2ex container deposit_all ${Actor["Scroll Depot"].ID} 0
;stopped using 

function main()
{
	;disable debugging
	Script:DisableDebugging
	
	echo Starting Depot v1 - Depositing all to the closest depot
	eq2ex container deposit_all ${Actor["Depot"].ID} 0
	;Actor[Depot]:DoubleClick
	;wait 10
	;EQ2UIPage[Inventory,Container].Child[button,Container.TabPages.Items.CommandDepositAll]:LeftClick
	;wait 10
	;eq2ex close_top_window
}
function atexit()
{
	echo Depot v1 Done
}