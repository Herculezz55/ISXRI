;#include Moveinc.iss

;WriteLocs Script - WriteLocs.iss Ver 1A
;Written by Herculezz Ver 1A 7-21-14
;script to write X,Y,Z Locs to File
;
;
;
;
;
;;;;;;;;;;;;IMPORTANT, the logic to find the closest way point is to read first line in file
;;;;;;;;;;;;;;;;;;;;;;; then compare it to current position and store the distance and loc in 2 temp vars
;;;;;;;;;;;;;;;;;;;;;; then read the second line and compare to current position and then compare that
;;;;;;;;;;;;;;;;;;;;;;; distance to the tempvar distance if its less then store its distance and loc in the 2 temp vars and so on till the end of the file
;;;;;;;;;;;;;;;;;;;; but also maybe should check LOS to the location very first because if we dont have los no sense in comparing or storing the vars
;;;;;;;;;;;;;;;;;;;; also need to store the position prior to reading the line so we can know where to seek to!!!
;
;
;
;
variable file Filename
variable filepath FP
variable string LastXYZ=0,0,0
variable string LastXYZC=0,0,0
variable int TEDistance=10
variable bool Auto=FALSE
variable bool Debug=TRUE
variable string NamedName
variable bool SFC=TRUE
variable(global) string RIWriteLocsScriptName=${Script.Filename}
variable bool TestRun=FALSE
variable bool _quest=FALSE
variable bool MoveToLoc=0
variable string MoveToLocLoc
variable(global) index:string RI_Index_String_AvailableRIWFunctions
variable(global) index:string RI_Index_String_AvailableRIWFunctionsDescription
variable(global) RIWObject RIWObj
;main function
objectdef RIWObject
{
	method RIWCustom()
	{
		ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIWCustom.xml"
	}
	method AddCustom()
	{
		LastXYZ:Set["${Me.X.Precision[2]} ${Me.Y.Precision[2]} ${Me.Z.Precision[2]}"]
		LastXYZC:Set["${Me.X.Precision[2]},${Me.Y.Precision[2]},${Me.Z.Precision[2]}"]
		UIElement[LocsList@WriteLocs]:AddItem["Custom"]
		variable int count=0
		variable string tempcustom=""
		for(count:Set[1];${count}<=${UIElement[AddedArgumentsLST@RIWCustom].Items};count:Inc)
		{
			tempcustom:Concat[" ${UIElement[AddedArgumentsLST@RIWCustom].OrderedItem[${count}]}"]
		}
		UIElement[LocsList@WriteLocs]:AddItem["${UIElement[FunctionNameTXTEntry@RIWCustom].Text}${tempcustom}"]
		UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIWCustom.xml"
		UIElement[LocsList@WriteLocs].FindUsableChild[Vertical,Scrollbar]:SetValue[0]
	}
	method AddArguments()
	{ 	
		if ${UIElement[AddArgumentTXTEntry@RIWCustom].Text.Find[" "](exists)} && !${UIElement[AddArgumentTXTEntry@RIWCustom].Text.Find[\"](exists)}
			UIElement[AddedArgumentsLST@RIWCustom]:AddItem[""${UIElement[AddArgumentTXTEntry@RIWCustom].Text.Escape}""]
		else
			UIElement[AddedArgumentsLST@RIWCustom]:AddItem[${UIElement[AddArgumentTXTEntry@RIWCustom].Text.Escape}]
		UIElement[AddArgumentTXTEntry@RIWCustom]:SetText[]
	}
	method UIEdit()
	{
		;echo ${RI_Index_String_AvailableRIWFunctions.Used}
		variable int count=0
		for(count:Set[1];${count}<=${RI_Index_String_AvailableRIWFunctions.Used};count:Inc)
		{
			;echo Adding ${RI_Index_String_AvailableRIWFunctions.Get[${count}]}
			UIElement[AvailableFunctionsCB@RIWCustom]:AddItem[${RI_Index_String_AvailableRIWFunctions.Get[${count}]}]
		}
		TimedCommand 1 UIElement[AvailableFunctionsCB@RIWCustom]:SetSelection[1]
		TimedCommand 1 UIElement[FunctionNameTXTEntry@RIWCustom]:SetText[${RI_Index_String_AvailableRIWFunctions.Get[1]}]
		TimedCommand 1 UIElement[Description2TXT@RIWCustom]:SetText[${RI_Index_String_AvailableRIWFunctionsDescription.Get[1]}]
	}
}
function main(... args)
{
	;disable debugging
	Script:DisableDebugging
	
	RI_Index_String_AvailableRIWFunctions:Insert[ApplyVerb]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ApplyVerb - Executes ISXCommand ApplyVerb to Actor\n\nArgument 1: Actor\nArgument 2: Verb]
	RI_Index_String_AvailableRIWFunctions:Insert[BalanceTrash]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[BalanceTrash - Modifies RI's Balancing of Trash\n\nArgument 1: 1=On/0=Off]
	RI_Index_String_AvailableRIWFunctions:Insert[BuyFromVendor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[BuyFromVendor - Buys from a vendor\n\nArgument 1: Vendor Name\nArgument 2: Item Name\nArgument 3: Quantity]
	RI_Index_String_AvailableRIWFunctions:Insert[CallToGuildHall]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CallToGuildHall - Casts call to guild hall\n\nArgument 1: Wait for the spell to be ready: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[CancelInvis]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CancelInvis - Cancels your invisibility]
	RI_Index_String_AvailableRIWFunctions:Insert[CastAbility]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CastAbility - Casts an ability \n\nArgument 1: Ability name or ID]
	RI_Index_String_AvailableRIWFunctions:Insert[CastInvis]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CastInvis - Casts your invisibility]
	RI_Index_String_AvailableRIWFunctions:Insert[Collection]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Collection - Collects an item \n\nAccepts an unlimited number of arguments of Item Name]
	RI_Index_String_AvailableRIWFunctions:Insert[CheckActiveQuest]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CheckActiveQuest - Checks if a quest is active in your Quest Journal and moves to a new line in the Zone File \n\nArgument 1: Quest name\nArgument 2: Line # to move to\nArgument 3: Pause - TRUE/FALSE\nArgument 4: Message to display in MessageBox(optional)]
	RI_Index_String_AvailableRIWFunctions:Insert[CheckAndSet]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CheckAndSet - Checks for many things and sets position in the Zone File to the highest passing argument\n\nAccepts an unlimited number of arguments in the form of any of the following\n-NamedNPC "NPC Name" (Exists)\n-Expert (Zone Tier)\n\n-CompletedQuest "Quest Name"\n-ActiveQuest "Quest Name"\n-NotActiveQuest "Quest Name"\n-NearLocation "X Y Z"\n-NotNearLocation "X Y Z"]
	RI_Index_String_AvailableRIWFunctions:Insert[CheckCompletedQuest]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CheckCompletedQuest - Checks if a quest is completed in your Quest Journal and moves to a new line in the Zone File \n\nArgument 1: Quest name\nArgument 2: Line # to move to\nArgument 3: Pause - TRUE/FALSE\nArgument 4: Message to display in MessageBox(optional)]
	RI_Index_String_AvailableRIWFunctions:Insert[CheckPreReqs]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CheckPreReqs - Checks for Active Quest/Completed Quest/ItemQty and pauses if it doesnt pass any and will recheck upon resume\n\nAccepts an unlimited number of arguments in the form of any of the following\n-ACTIVE "Quest Name"\n-COMPLETED "Quest Name"\n-ITEMQTY #]
	RI_Index_String_AvailableRIWFunctions:Insert[CheckQuest]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CheckQuest - Checs the arguments and sets position in the Zone File to the highest passing argument\n\nAccepts an unlimited number of arguments in the form of any of the following\n-NotActive "Quest Name"\n-Active "Quest Name"\n-Completed "Quest Name"]
	RI_Index_String_AvailableRIWFunctions:Insert[CheckQuestStep]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CheckQuestStep - Checks for the quest step and sets position in the Zone File\n\nArgument 1: Quest Step\nArgument 2: Line # to move to\nArgument 3: Exists: TRUE/FALSE\nArgument 4: Is Not Checked: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[ClickActor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ClickActor - Clicks Actor\n\nAccepts unlimited number of arguments in sets of 4 as follows:\nArgument 1: Actor Name\nArgument 2: Loop until HighlightOnMouseHover is False: TRUE/FALSE\nArgument 3: Loop until Actor does not exist: TRUE/FALSE\nArgument 4: Give Up Counter: #]
	RI_Index_String_AvailableRIWFunctions:Insert[ClickAllActors]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ClickAllActors - Clicks All Actors\n\nArgument 1: Actor Query\nArgument 2: Distance #]
	RI_Index_String_AvailableRIWFunctions:Insert[ClickNoNameActor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ClickNoNameActor - Clicks All No Name Actors\n\nArgument 1: Distance #]
	RI_Index_String_AvailableRIWFunctions:Insert[ClimbLadder]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ClimbLadder - Climbs Ladder\n\nArgument 1: Degree to Face Toon #\nArgument 2: Y Position to Jump To #\nArgument 3: Give Up Counter #]
	RI_Index_String_AvailableRIWFunctions:Insert[CraftIt]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[CraftIt - Crafts (requires eq2craft to be running)\n\nArgument 1: Recipe Name\nArgument 2: Quantity #]
	RI_Index_String_AvailableRIWFunctions:Insert[Door]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Door - Clicks All Doors\n\nArgument 1: Distance #]
	RI_Index_String_AvailableRIWFunctions:Insert[DoorOption]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[DoorOption - Clicks the option for the Zone Popup Window\n\nArgument 1: Zone Name or Line Number #]
	RI_Index_String_AvailableRIWFunctions:Insert[EndCustomScript]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[EndCustomScript - Ends a script\n\nArgument 1: ScriptName]
	RI_Index_String_AvailableRIWFunctions:Insert[EndScript]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[EndScript - Ends RunInstances]
	RI_Index_String_AvailableRIWFunctions:Insert[EquipItem]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[EquipItem - Equips Item\n\nArgument 1: Item Name\nArgument 2: Slot #\nArgument 3: Store item name being replaced: TRUE/FALSE/1/0]
	RI_Index_String_AvailableRIWFunctions:Insert[Evac]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Evac - Evacs\n\nArgument 1(Optional): End RunInstances: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[ExamineItem]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ExamineItem - Examine's an Item\n\nArgument 1: Item Name\nArgument 2-Unlimited(Optional): ReplyDialog Choices]
	RI_Index_String_AvailableRIWFunctions:Insert[ExecuteCommand]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ExecuteCommand - Executes Command in the console\n\nArgument 1: Command]
	RI_Index_String_AvailableRIWFunctions:Insert[ExecuteRIMUIObjMethod]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ExecuteRIMUIObjMethod - Executes a Method from the RIMUIObj\n\nArgument 1: Method Name\nArgument 2-Unlimited: Arguments to be passed into the method]
	RI_Index_String_AvailableRIWFunctions:Insert[FaceAndMoveForward]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[FaceAndMoveForward - Face a direction and move forward until you reach a loc\n\nArgument 1: Direction to face #\nArgument 2: X\nArgument 3: Y\nArgument 4: Z\nArgument 5: Give Up Counter #]
	RI_Index_String_AvailableRIWFunctions:Insert[FastTravel]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[FastTravel - Fast Travels\n\nArgument 1: Zone Name\nArgument 2: Relay to group: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[FlyDown]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[FlyDown - Flys down until no longer flying\n\nArgument 1: Relay to group: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[FlyUp]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[FlyUp - Flys up for a specified amount of time\n\nArgument 1: How Long #\nArgument 2: Argument 1 is a Y Loc: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[HailActor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[HailActor - Hails actor\n\nArgument 1: Actor Name\nArgument 2: Number of responses: #\nArgument 3: Response number: #\nArgument 4: Hail first: TRUE/FALSE\nArgument 5: Stop ANY Following: TRUE/FALSE\nArgument 6: name must match exactly: TRUE/FALSE\nArgument 7: How long to hold camera on readjust (15 by default): #]
	RI_Index_String_AvailableRIWFunctions:Insert[HailActorFast]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[HailActorFast - Hails actor fast\n\nArgument 1: Actor Name\nArgument 2: Number of responses: #\nArgument 3: Response number: #\nArgument 3: Hail first: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[HailActorGetQuest]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[HailActorGetQuest - Hails actor until quest appears in quest journal\n\nAccepts arguments in any order as follows:\n-Actor "Actor Name"\n-NumberOfResponses #\n-ResponseNumber #\n-NoHail\n-QuestName "Name of Quest"\n-NoCheckQuestExists]
	RI_Index_String_AvailableRIWFunctions:Insert[HailActorMultiOption]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[HailActorMultiOption - Hails actor and replies with options supplied in arguments\n\nArgument 1: Actor Name\nArgument 2-Unlimited: Number of response: #]
	RI_Index_String_AvailableRIWFunctions:Insert[HailCollector]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[HailCollector - Hails guild hall collector]
	RI_Index_String_AvailableRIWFunctions:Insert[Harvest]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Harvest - Harvests a node\n\nArgument 1: Node name\nArgument 2: Name of item from node\nArgument 3: Quantity: #]
	RI_Index_String_AvailableRIWFunctions:Insert[HarvestNode]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[HarvestNode - Harvests a node\n\nArgument 1: Node name\nArgument 2: Name of item from node\nArgument 3: Quantity: #]
	RI_Index_String_AvailableRIWFunctions:Insert[Instance]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Instance - Runs an instance\n\nArgument 1: Instance name(Optional omit to use zone you are in)]
	RI_Index_String_AvailableRIWFunctions:Insert[JumpUp]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[JumpUp - Jumps up\n\nArgument 1: X: #\nArgument 2: Y: #\nArgument 3: Z: #\nArgument 4: Y Target: #\nArgument 5: Give up counter: #\nArgument 6: Relay to group: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[JumpOver]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[JumpOver - Jumps over\n\nArgument 1: X: #\nArgument 2: Y: #\nArgument 3: Z: #\nArgument 4: Give up counter: #\nArgument 5: Relay to group: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[KillAll]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[KillAll - Kills all actors with specified name in specified distance\n\nArgument 1: Actor name\nArgument 2: Distance: #]
	RI_Index_String_AvailableRIWFunctions:Insert[LockAndWait]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[LockAndWait - Lockspots and wait's specified time\n\nAccepts the following arguments in any order\n-LOC "X,Y,Z"\n-Precision #\n-RelayToGroup\n-Max #\n-WaitAfter #\n-Wait #]
	RI_Index_String_AvailableRIWFunctions:Insert[LongJumpOver]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[LongJumpOver - Jumps over\n\nArgument 1: X: #\nArgument 2: Y: #\nArgument 3: Z: #\nArgument 4: Face degree: #]
	RI_Index_String_AvailableRIWFunctions:Insert[LootOptions]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[LootOptions - Changes loot options\n\nArgument 1: Loot option]
	RI_Index_String_AvailableRIWFunctions:Insert[MessageBox]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[MessageBox - Pops up a messagebox\n\nArgument 1: Message\nArgument 2: Pause: 1/0]
	RI_Index_String_AvailableRIWFunctions:Insert[MoveToActor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[MoveToActor - Moves to specified actor\n\nArgument 1: Actor name\nArgument 2: Precision: #\nArgument 3: Skip collision check: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[MoveToActorHail]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[MoveToActorHail - Moves to specified actor then hails them\n\nArgument 1: Actor name\nArgument 2: Precision: #\nArgument 3: Skip collision check: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[MoveToNoNameActor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[MoveToNoNameActor - Moves to closest actor with no name\n\nArgument 1: Precision: #\nArgument 2: Skip collision check: TRUE/FALSE]
	;RI_Index_String_AvailableRIWFunctions:Insert[OpenDoor(string _DoorName, float _ClosedHeading, bool _WaitTilClosed=FALSE, int _WaitTimeOut=15)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[OpenDoor(string _DoorName, float _ClosedHeading, bool _WaitTilClosed=FALSE, int _WaitTimeOut=15)
	RI_Index_String_AvailableRIWFunctions:Insert[Path]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Path - Runs a path of the next X lines in the Zone file and does actions\nArguments:\n-PathLines #\n-Precision # (Default 2)\n-RelayToGroup(Default FALSE)\n-Loop(Default FALSE)\n-Reverse/-ReverseLoopOnly(Default FALSE)\n-GroupWait #(Default 0)\n-DontStopForCombat\n-JumpAfterEachLoc\n-TargetSelf\n-QueryActor (this is where you input what actions to take on what  -use quotes for entire argument)\n(will take an unlimited amount of arguments of the following each seperated by a |)\n     -Interactable\n     -ActorName|Actor name\n     -QueryDistance|#(Default 50)\n     -MoveToDistance|#(Default 5)\n     -Trigger|Trigger:Text\n        AnnounceText/IncomingText/\n        QuestStepExists/QuestStepDNE/\n        QuestStepChecked\n     -Events|DoubleClick/Kill/Hail/Harvest]
	;RI_Index_String_AvailableRIWFunctions:Insert[PathApplyVerb(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathApplyVerb(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathFlyHarvest(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, bool _HighlightOnMouseHover=FALSE, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathFlyHarvest(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, bool _HighlightOnMouseHover=FALSE, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathHail(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathHail(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathHailCast(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathHailCast(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathHailDistance(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathHailDistance(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathHailExists(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathHailExists(int _PathLines, int _Distance, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathHarvest(int _PathLines, string _DistanceIN, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, bool _HighlightOnMouseHover=FALSE, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathHarvest(int _PathLines, string _DistanceIN, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, bool _HighlightOnMouseHover=FALSE, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathItem(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)	
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathItem(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)	
	;RI_Index_String_AvailableRIWFunctions:Insert[PathItemHail(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathItemHail(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathItemKill(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathItemKill(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathItemKillApplyVerb(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathItemKillApplyVerb(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathItemKillClick(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathItemKillClick(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathKill(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathKill(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctions:Insert[PathKillClick(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	;RI_Index_String_AvailableRIWFunctionsDescription:Insert[PathKillClick(int _PathLines, int _Distance, int _Precision, bool _Loop, bool _GoReverseAfterAllQuantitiesMet, bool _GoReverseAtLoopOrEnd, ... args)
	RI_Index_String_AvailableRIWFunctions:Insert[PauseCombatBot]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[PauseCombatBot - Pauses or resumes combatbot\n\nArgument 1: Pause: 1/0]
	RI_Index_String_AvailableRIWFunctions:Insert[PlaceHouseItem]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[PlaceHouseItem - Places house item in front of your toon\n\nArgument 1: Face degree: #]
	RI_Index_String_AvailableRIWFunctions:Insert[Portal]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Portal - Moves to and ports at a portal\n\nArgument 1: Portal name]
	RI_Index_String_AvailableRIWFunctions:Insert[PreHeal]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[PreHeal - Healers will cast heals]
	RI_Index_String_AvailableRIWFunctions:Insert[Quest]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Quest - Runs a quest\n\nArgument 1: Quest Name]
	RI_Index_String_AvailableRIWFunctions:Insert[PressKey]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[PressKey - Presses key\n\nArgument 1: Key name\nArgument 2: Hold time: #]
	RI_Index_String_AvailableRIWFunctions:Insert[RemoveFromDepot]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[RemoveFromDepot - Removes items from any depot\n\nArgument 1: Depot name\nAccepts unlimited arguments in sets of 2 as follows:\nItem name\nQuantity: #]
	RI_Index_String_AvailableRIWFunctions:Insert[ReplyDialog]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ReplyDialog - Responds to a reply dialog pop up\n\nAccepts unlimited number of arguments of either the option # or name]
	RI_Index_String_AvailableRIWFunctions:Insert[ResetZone]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ResetZone - Resets zone of name specified\n\nArgument 1: Zone name]
	RI_Index_String_AvailableRIWFunctions:Insert[Revive]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Revive - Revives]
	RI_Index_String_AvailableRIWFunctions:Insert[RIMUIObj]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[RIMUIObj - Executes a RIMUIObj Method specified with the arguments specified\n\nArgument 1: Method name\nArgument 2-Unlimited: Arguments]
	RI_Index_String_AvailableRIWFunctions:Insert[RingEvent]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[RingEvent - Stands and kills a ring event\n\nArgument 1:Distance: #\nArgument 2-Unlimited: Actor name]
	RI_Index_String_AvailableRIWFunctions:Insert[RunCustomScript]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[RunCustomScript - Runs a custom script\n\nArgument 1: Script name\nArgument 2-Unlimited: arguments to pass to script]
	RI_Index_String_AvailableRIWFunctions:Insert[ScribeBook]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ScribeBook - Scribes a book\n\nArgument 1: Book name]
	RI_Index_String_AvailableRIWFunctions:Insert[SetShinyScanDistance]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SetShinyScanDistance - Sets RI's Shiny scan distance for this session only\nArgument 1: Distance: #]
	RI_Index_String_AvailableRIWFunctions:Insert[SetShinyMoveDistance]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SetShinyMoveDistance - Sets RI's Shiny move distance for this session only\nArgument 1: Distance: #]
	RI_Index_String_AvailableRIWFunctions:Insert[SetIgnoreShinyY]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SetIgnoreShinyY - Sets RI's Ignore Y value for shinies (effectively turning off RI's ability to jump up to get shinies)\nArgument 1: 1/0]
	RI_Index_String_AvailableRIWFunctions:Insert[SetMainArrayCounter]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SetMainArrayCounter - Sets RI's Main Zone file array position\n\nArgument 1: Position: #]
	RI_Index_String_AvailableRIWFunctions:Insert[SeverHate]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SeverHate - Casts sever hate on specified target\n\nArgument 1:Actor name]
	RI_Index_String_AvailableRIWFunctions:Insert[SkipLoot]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SkipLoot - Turns on RI's SkipLoot option\n\nArgument 1: 1/0]
	RI_Index_String_AvailableRIWFunctions:Insert[StayAfloat]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[StayAfloat - Turns on RI's StayAFloat Feature\n\nArgument 1: 1/0]
	RI_Index_String_AvailableRIWFunctions:Insert[StopFollow]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[StopFollow - Stops follow]
	RI_Index_String_AvailableRIWFunctions:Insert[SummonMount]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SummonMount - Summon's your mount]
	RI_Index_String_AvailableRIWFunctions:Insert[SwimUp]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SwimUp - Swim's up until you reach intended Y Location\n\nArgument 1: Y Loc: #]
	RI_Index_String_AvailableRIWFunctions:Insert[SwimDown]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[SwimDown - Swim's down for a specified amount of time\n\nArgument 1: Time: #]
	RI_Index_String_AvailableRIWFunctions:Insert[Target]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Target - Targets a specified actor\n\nArgument 1: Actor name\nArgument 2: Stay targeted: TRUE/FALSE\nArgument 3: Distance: #\nArgument 4: No kill npc: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[TargetUntilAnnounce]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[TargetUntilAnnounce - Targets a specified actor until an Announce is detected\n\nArgument 1: Actor name\nArgument 2: Distance: #\nArgument 3: Announce text]
	RI_Index_String_AvailableRIWFunctions:Insert[TargetUntilQuestStepExists]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[TargetUntilQuestStepExists - Targets a specified actor until a Quest step is detected\n\nArgument 1: Actor name\nArgument 2: Distance: #\nArgument 3: Quest step text]
	RI_Index_String_AvailableRIWFunctions:Insert[Teleporter]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Teleporter - Steps onto a teleporter and moves back and forth until you port\n\nArgument 1: X: #\nArgument 2: Y: #\nArgument 3: Z: #\nArgument 1: Precision: #\nArgument 1: Max distance: #]
	RI_Index_String_AvailableRIWFunctions:Insert[TimeStampEcho]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[TimeStampEcho -Echoes a time stamped message to console\n\nArgument 1: Message]
	RI_Index_String_AvailableRIWFunctions:Insert[ToggleWalkRun]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ToggleWalkRun - Toggles between walk and run\nArgument 1: Relay to group: TRUE/FALSE]
	RI_Index_String_AvailableRIWFunctions:Insert[TravelMap]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[TravelMap - Clicks a zone on the TravelMap\\nArgument 1: Zone name\nArgument 2(optional): Zone pop up option: #\nArgument 3(optional): Click Bell/Wizard/Druid Actors and Portals: 0=No/1=Bell/2=Wizard/3=Druid]
	RI_Index_String_AvailableRIWFunctions:Insert[UseItem]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[UseItem - Uses an Item from your inventory\n\nArgument 1: Item Name]
	RI_Index_String_AvailableRIWFunctions:Insert[Wait]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Wait - Waits specified amount of time\n\nArgument 1: Time: #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitDeath]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitDeath - Waits while dead]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForAnnounceText]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForAnnounceText - Waits for an announce text\n\nAccepts an unlimited number of arguments of the announce text or -LockSpot to lockspot]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForIncomingText]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForIncomingText - Waits for an incoming text\n\nAccepts an unlimited number of arguments of the incoming text or -LockSpot to lockspot]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForMob]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForMob - Wait while a mob exists\n\nArgument 1: Actor name\nArgument 2: Distance: #\nArgument 3: Wait for aggro: TRUE/FALSE\nArgument 4: Check if mob exists: TRUE/FALSE\nArgument 5(optional): Max time to wait: #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForMobAway]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForMobAway - Wait for a mob to not exist(go away)\n\nArgument 1: Actor name\nArgument 2: Distance: #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForMobQuery]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForMobQuery - Wait while a mob exists(this function accepts a LS Query)\n\nArgument 1: Actor name\nArgument 2: Distance: #\nArgument 3: Wait for aggro: TRUE/FALSE\nArgument 4: Check if mob exists: TRUE/FALSE\nArgument 5(optional): Max time to wait: #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForScript]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForScript - Waits while a script is running\n\nArgument 1: Script name]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitForZoning]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitForZoning - Waits while you are zoning\n\nArgument 1: Wait time(default 600): #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitMob]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitMob(OLD New Function is WaitForMob) - Waits while a mob exists\n\nArgument 1: Actor name\nArgument 2: Distance: #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitUntilAllGroupWithinRange]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitUntilAllGroupWithinRange - Waits until your entire group is within a specified range\nAccepts arguments in any order as follows:\n-Range #\n-WaitTime #]
	RI_Index_String_AvailableRIWFunctions:Insert[WaitWhileMoving]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[WaitWhileMoving - Wait while you are moving]
	RI_Index_String_AvailableRIWFunctions:Insert[Zone]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[Zone - Faces a location and moves forward for a specified time: used for zoning\n\nArgument 1: X: #\nArgument 2: Z: #\nArgument 3: Wait time: #]
	RI_Index_String_AvailableRIWFunctions:Insert[ZoneDoor]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ZoneDoor - Clicks a zone Actor (you may omit arguments to use their defaults)\n\nArgument 1: Actor name\nArgument 2: Door option: # or Name(Default -1)\nArgument 3: Keep clicking until the actor is no longer HighlightOnMouseHover: TRUE/FALSE(Default FALSE)\nArgument 4: Give up counter: #(Default 50)\nArgument 5: Use exact name: TRUE/FALSE(Default TRUE)]
	RI_Index_String_AvailableRIWFunctions:Insert[ZoneFly]
	RI_Index_String_AvailableRIWFunctionsDescription:Insert[ZoneFly - Faces a location and moves forward for a specified time(while flying): used for zoning\n\nArgument 1: X: #\nArgument 2: Z: #\nArgument 3: Wait time: #]
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if WriteLocs.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[WriteLocs.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting WriteLocs.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/WriteLocs.xml" http://www.isxri.com/WriteLocs.xml
		wait 50
	}
	if !${FP.FileExists[RIWCustom.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIWCustom.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIWCustom.xml" http://www.isxri.com/RIWCustom.xml
		wait 50
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[ZoneFiles]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"]
	}
	
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/WriteLocs.xml"
	
	; UIElement[WriteLocs].FindChild[WriteLOC]:Hide
	; UIElement[WriteLocs].FindChild[ClickActor]:Hide
	; UIElement[WriteLocs].FindChild[HailActor]:Hide
	; UIElement[WriteLocs].FindChild[Named]:Hide
	; UIElement[WriteLocs].FindChild[Auto]:Hide
	; UIElement[WriteLocs].FindChild[Wait]:Hide
	; UIElement[WriteLocs].FindChild[Custom]:Hide
	; UIElement[WriteLocs].FindChild[StopForCombat]:Hide
	; UIElement[WriteLocs].FindChild[TEDistance]:SetText[${TEDistance}]
	; UIElement[WriteLocs].FindChild[StopForCombat].Font:SetColor[FF32CD32]
	
	echo ISXRI: Starting WriteLocs
	
	variable int _count
	for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
	{
		switch ${args[${_count}]}
		{
			case -quest
			case -q
			{
				;echo ${args.Used}
				;echo ${args[2]}
				_quest:Set[TRUE]
				UIElement[TEFilename@WriteLocs]:SetText["${args[${Math.Calc[${_count}+1]}].Replace[".",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}.dat"]
				call Write -quest "${args[${Math.Calc[${_count}+1]}]}"
				break
			}
			case -currentquest
			case -cq
			{
				_quest:Set[TRUE]
				UIElement[TEFilename@WriteLocs]:SetText["${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText].Replace[".",""].Replace["!",""].Replace["'",""].Replace["-",""].Replace[" ",""].Replace["?",""].Replace[\",""].Replace[",",""].Replace[":",""]}.dat"]
				call Write -quest "${QuestJournalWindow.CurrentQuest.Name.GetProperty[LocalText]}"
				break
			}
			case -filename
			case -fn
			case -f
			{
				_quest:Set[TRUE]
				UIElement[Save@WriteLocs]:SetText[Save]
				UIElement[TEFilename@WriteLocs]:SetText["${args[${Math.Calc[${_count}+1]}]}"]
				break
			}
			default
				noop
		}
	}
	
	UIElement[TEDistance@WriteLocs]:SetText[10]
	if !${_quest}
		UIElement[TEFilename@WriteLocs]:SetText[${Me.GetGameData[Self.ZoneName].Label.Replace[" ",""].Replace["'",""].Replace[":",""].Replace["[",,""].Replace["]",""].Replace[",",""]}.dat]
	
	;echo ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
	if ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: Loading "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
		
		WLImportZoneFile "${UIElement[TEFilename@WriteLocs].Text}"
		UIElement[Save@WriteLocs]:SetText[Save]
	}
	
	do 
	{
		call ExecuteQueued
		wait 1
		if ${Auto}
			call Auto ${TEDistance}
		if ${TestRun}
			call TestRun
		if ${MoveToLoc}
			call MoveToLocFN
	}
	while 1
}
function ExecuteQueued()
{
	;execute queued commands
	if ${QueuedCommands}
		ExecuteQueued
}
atom(global) WriteLocsTEDistance()
{
	TEDistance:Set[${Int[${UIElement[TEDistance@WriteLocs].Text}]}]
	;echo Settings Distance to ${TEDistance}
}
atom WLImportZoneFile(string ZoneFileName)
{
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/"
	;check if ZineFileName exists, if not end
	if !${FP.FileExists[${ZoneFileName}]}
	{
		echo ISXRI: Missing ZoneFile: "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"
		return
	}
	
	variable file Filename
	variable int Count
	
	variable string TempString
	istrMain:Clear
	Count:Set[1]
	;set file to read in to Filename variable
	Filename:SetFilename["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${ZoneFileName}"]

	;open the file
	Filename:Open
	
	;seek to the beginning of file
	Filename:Seek[0]
	
	;while we are not at the end of file
	while !${Filename.EOF}
	{
		;store each line of the file in var
		TempString:Set[${Filename.Read}]
		if ${TempString.Equal[NULL]}
			continue
		UIElement[LocsList@WriteLocs]:AddItem["${TempString.Left[-1]}"]
		;echo Adding ${istrMain.Get[${Count}]} to istrMain Variable in Element ${Count}
		Count:Inc
		;waitframe
	}
	
	;close file
	Filename:Close
}
atom(global) MoveToLoc(string _Loc)
{
	MoveToLocLoc:Set["${_Loc}"]
	MoveToLoc:Set[1]
	UIElement[LocsList@WriteLocs]:ClearSelection
}
function MoveToLocFN()
{
	MoveToLoc:Set[0]
	RI_Var_Bool_Start:Set[TRUE]
	call RIMObj.Move ${MoveToLocLoc.Replace[","," "]} 1 0 FALSE FALSE TRUE FALSE
	RI_Var_Bool_Start:Set[FALSE]
}
function Save()
{
	if ${UIElement[TEFilename@WriteLocs].Text.NotEqual[""]}
	{
		if !${UIElement[TEFilename@WriteLocs].Text.Upper.Find[".DAT"](exists)}
		{
			MessageBox -skin eq2 "please include the .dat extension in your filename"
			return
		}
		if ${UIElement[Save@WriteLocs].Text.Equal[Load]}
		{
			;echo "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
			;echo ${FP}
			;echo ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			;check if the file (${UIElement[TEFilename@WriteLocs].Text}) exists, if so import into listbox, else create
			if ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			{
				
				if ${RI_Var_Bool_Debug}
					echo ISXRI: Loading "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
				UIElement[LocsList@WriteLocs]:ClearItems
				WLImportZoneFile "${UIElement[TEFilename@WriteLocs].Text}"
				UIElement[Save@WriteLocs]:SetText[Save]
			}
			else
			{
				UIElement[Save@WriteLocs]:SetText[Save]
			}
		}
		else
		{
			;echo "${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"
			;echo ${FP}
			;echo ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			;check if the file (${UIElement[TEFilename@WriteLocs].Text}) exists, if so import into listbox, else create
			if ${FP.FileExists["${UIElement[TEFilename@WriteLocs].Text}"]}
			{
				MessageBox -skin eq2 -yesno "ZoneFile: ${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text} Exists, Are you sure you want to overwrite?"
				if ${UserInput.Equal[No]}
				{
					MessageBox -skin eq2 "File Not Saved"
					return
				}
			}
			Filename:SetFilename["${LavishScript.HomeDirectory}/Scripts/RI/ZoneFiles/${UIElement[TEFilename@WriteLocs].Text}"]
			;echo ${Filename}
			Filename:Open
			Filename:Truncate
			
			; UIElement[WriteLocs].FindChild[Save]:Hide
			; UIElement[WriteLocs].FindChild[Filename]:Hide
			; UIElement[WriteLocs].FindChild[TEFilename]:Hide
			; UIElement[WriteLocs].FindChild[Distance]:Hide
			; UIElement[WriteLocs].FindChild[TEDistance]:Hide
			; UIElement[WriteLocs].FindChild[WriteLOC]:Show
			; UIElement[WriteLocs].FindChild[WriteLOC]:SetFocus
			; UIElement[WriteLocs].FindChild[ClickActor]:Show
			; UIElement[WriteLocs].FindChild[HailActor]:Show
			; UIElement[WriteLocs].FindChild[Named]:Show
			; UIElement[WriteLocs].FindChild[Wait]:Show
			; UIElement[WriteLocs].FindChild[Custom]:Show
			; UIElement[WriteLocs].FindChild[Auto]:Show
			; UIElement[WriteLocs].FindChild[StopForCombat]:Show
			;forloop to reset zones in AddedZoneList
			variable int count
			for (count:Set[1];${count}<=${UIElement[LocsList@WriteLocs].Items};count:Inc)
			{
				echo Writing "${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}" to file
				Filename:Write["${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}\n"]
			}
			
			Filename:Flush
			Filename:Close
			MessageBox -skin eq2 "Saved File Name as ${Filename}"
		}
	}
	else
	{
		MessageBox "You must enter a valid File Name"
	}
}
;atom(global) TestRun()
;{
;	if ${TestRun}
;		TestRun:Set[FALSE]
;	else
;		TestRun:Set[TRUE]
;}
function RPB()
{
	relay all RIMUIObj:SetRIFollow[ALL,${Me.ID},1,200]
	variable int count
	for (count:Set[${UIElement[LocsList@WriteLocs].Items}];${count}>=1;count:Dec)
	{
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Custom]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[ClickActor]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[HailActor]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Dec
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Wait]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Dec
			wait ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Named]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Dec
			count:Dec
			count:Dec
			count:Dec
			count:Dec
			continue
		}
		echo Running TO "${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}"
		;Filename:Write["${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}\n"]
		call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]} 1 0 FALSE FALSE TRUE TRUE
		wait 1
	}
	call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[1]} 1 0 FALSE FALSE TRUE FALSE
	call FlyDownIfYHI ${UIElement[LocsList@WriteLocs].OrderedItem[1]}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	press -release ${RI_Var_String_ForwardKey}
	;TestRun:Set[FALSE]
	
}
function FlyDownIfYHI(float _X, float _Y, float _Z)
{
	if ${Math.Distance[${Me.Y,${_Y}}]}>5
		call RIMObj.FlyDown
}
function RP()
{
	relay all RIMUIObj:SetRIFollow[ALL,${Me.ID},1,200]
	variable int count
	for (count:Set[1];${count}<${UIElement[LocsList@WriteLocs].Items};count:Inc)
	{
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Custom]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[ClickActor]} || ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[HailActor]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Inc
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Wait]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Inc
			wait ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}
			continue
		}
		if ${UIElement[LocsList@WriteLocs].OrderedItem[${count}].Text.Equal[Named]}
		{
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			count:Inc
			count:Inc
			count:Inc
			count:Inc
			count:Inc
			continue
		}
		echo Running TO "${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}"
		;Filename:Write["${UIElement[LocsList@WriteLocs].OrderedItem[${count}]}\n"]
		call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[${count}]} 1 0 FALSE FALSE TRUE TRUE
		; if !${TestRun}
		; {
			; press -release ${RI_Var_String_FlyUpKey}
			; press -release ${RI_Var_String_FlyDownKey}
			; press -release ${RI_Var_String_ForwardKey}
			; return
		; }
		wait 1
	}
	call RIMObj.Move ${UIElement[LocsList@WriteLocs].OrderedItem[${UIElement[LocsList@WriteLocs].Items}]} 1 0 FALSE FALSE TRUE FALSE
	call FlyDownIfYHI ${UIElement[LocsList@WriteLocs].OrderedItem[${UIElement[LocsList@WriteLocs].Items}]}
	press -release ${RI_Var_String_FlyUpKey}
	press -release ${RI_Var_String_FlyDownKey}
	press -release ${RI_Var_String_ForwardKey}
	TestRun:Set[FALSE]
}
function Write(... _args)
{
;bool Custom, bool ClickActor, bool HailActor, bool Named, bool Wait,
	LastXYZ:Set["${Me.X.Precision[2]} ${Me.Y.Precision[2]} ${Me.Z.Precision[2]}"]
	LastXYZC:Set["${Me.X.Precision[2]},${Me.Y.Precision[2]},${Me.Z.Precision[2]}"]

	variable int _count
	for(_count:Set[1];${_count}<=${_args.Used};_count:Inc)
	{
		switch ${_args[${_count}]}
		{
			case -quest
			{
				UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+1]}]}"]
				break
			}
			case -wait
			{
				if ${_args.Used}>1
				{
					UIElement[LocsList@WriteLocs]:AddItem["Wait"]
					UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+1]}]}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				else
				{
					InputBox -skin eq2 "Enter Wait Time"
					while ${UserInput.Equal[""]} 
					{
						MessageBox -skin eq2 "You must enter a wait time"
						InputBox -skin eq2 "Enter Wait Time"
						wait 1
					}
					if ${String[${UserInput}].Equal[NULL]}
						return
					if ${RI_Var_Bool_Debug}
						echo Adding Wait for ${UserInput} at LOC: ${LastXYZ} 
					;Filename:Write["Wait\n"]
					;Filename:Write[${UserInput}\n]
					;Filename:Write[${LastXYZ}\n]
					UIElement[LocsList@WriteLocs]:AddItem["Wait"]
					UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				break
			}
			case -flydown
			{
				UIElement[LocsList@WriteLocs]:AddItem["Custom"]
				UIElement[LocsList@WriteLocs]:AddItem["FlyDown"]
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -hailactor
			{
				if ${Target(exists)}
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor NumberOfResponses=1 ResponseNumber=1 Hail=TRUE Follow=TRUE ExactName=FALSE" "\"${Target}\" "
				else
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor NumberOfResponses=1 ResponseNumber=1 Hail=TRUE Follow=TRUE ExactName=FALSE"
				while ${UserInput.Equal[""]}
				{
					MessageBox -skin eq2 "You must enter arguments"
					InputBox -skin eq2 "Enter arguments seperated by a space in this order (Actor NumberOfResponses=1 ResponseNumber=1 Hail=TRUE Follow=TRUE ExactName=FALSE)"
					wait 1
				}
				if ${String[${UserInput}].Equal[NULL]}
					return
				if ${RI_Var_Bool_Debug}
					echo Writing HailActor ${UserInput} LOC: ${LastXYZ}
				UIElement[LocsList@WriteLocs]:AddItem["Custom"]
				UIElement[LocsList@WriteLocs]:AddItem["HailActor ${UserInput}"]
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -clickactor
			{
				if ${Target(exists)}
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor LoopUntilNoHighlightOnMouseHover=FALSE LoopUntilDNE=FALSE GiveUpCNT=50" "\"${Target}\" "
				else
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor LoopUntilNoHighlightOnMouseHover=FALSE LoopUntilDNE=FALSE GiveUpCNT=50"
				while ${UserInput.Equal[""]}
				{
					MessageBox -skin eq2 "You must enter arguments"
					InputBox -skin eq2 "Enter arguments seperated by a space in this order Actor LoopUntilNoHighlightOnMouseHover=FALSE LoopUntilDNE=FALSE GiveUpCNT=50"
					wait 1
				}
				if ${String[${UserInput}].Equal[NULL]}
					return
				if ${RI_Var_Bool_Debug}
					echo Writing ClickActor ${UserInput} LOC: ${LastXYZ}
				UIElement[LocsList@WriteLocs]:AddItem["Custom"]
				UIElement[LocsList@WriteLocs]:AddItem["ClickActor ${UserInput}"]
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -named
			{
				InputBox -skin eq2 "Enter Name"
				while ${UserInput.Equal[""]} 
				{
					MessageBox -skin eq2 "You must enter a name"
					InputBox -skin eq2 "Enter Name"
					wait 1
				}
				if ${String[${UserInput}].Equal[NULL]}
					return
				NamedName:Set[${UserInput}]
				if ${RI_Var_Bool_Debug}
					echo Writing Named ${UserInput} LOC: ${LastXYZ}
				UIElement[LocsList@WriteLocs]:AddItem["Named"]
				UIElement[LocsList@WriteLocs]:AddItem["${NamedName}"]
				MessageBox -skin eq2 -yesno "Standard Named?"
				if ${UserInput.Equal[No]}
					UIElement[LocsList@WriteLocs]:AddItem["CustomNamed"]
				else
				{
					UIElement[LocsList@WriteLocs]:AddItem["StandardNamed"]
					MessageBox -skin eq2 -yesno "Same LockSpot For Entire Group?"
					if ${UserInput.Equal[Yes]}
						UIElement[LocsList@WriteLocs]:AddItem["SameLock"]
					else
					{
						UIElement[LocsList@WriteLocs]:AddItem["DiffLock"]
						MessageBox  -skin eq2 "Move to 2nd lock position and click OK"
						UIElement[LocsList@WriteLocs]:AddItem["${Me.X} ${Me.Y} ${Me.Z}"]
						MessageBox  -skin eq2 "Move back to 1st lock position and click OK"
					}
					MessageBox -skin eq2 -yesno "Kill Add?"
					if ${UserInput.Equal[Yes]}
					{
						
						InputBox -skin eq2 "Enter Add Name"
						while ${UserInput.Equal[""]} 
						{
							MessageBox -skin eq2 "You must enter a add name"
							InputBox -skin eq2 "Enter Add Name"
							wait 1
						}
						if ${String[${UserInput}].NotEqual[NULL]}
						{
							UIElement[LocsList@WriteLocs]:AddItem["KillAdd"]
							UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
						}
						else
							UIElement[LocsList@WriteLocs]:AddItem["DontKillAdd"]
					}
					else
						UIElement[LocsList@WriteLocs]:AddItem["DontKillAdd"]
					MessageBox -skin eq2 -yesno "Move group behind named?"
					if ${UserInput.Equal[Yes]}
						UIElement[LocsList@WriteLocs]:AddItem["MoveBehind"]
					else
						UIElement[LocsList@WriteLocs]:AddItem["DontMoveBehind"]
				}
				UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				break
			}
			case -custom
			{
				if ${_args.Used}==1
				{
					InputBox -skin eq2 "What would you like to do here?"
					while ${UserInput.Equal[""]} 
					{
						MessageBox -skin eq2 "You must enter a custom function"
						InputBox -skin eq2 "What would you like to do here?"
						wait 1
					}
					if ${String[${UserInput}].Equal[NULL]}
						return
					if ${RI_Var_Bool_Debug}
						echo Adding Custom: ${UserInput} LOC: ${LastXYZ}
					UIElement[LocsList@WriteLocs]:AddItem["Custom"]
					UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				elseif ${_args.Used}==2
				{
					UIElement[LocsList@WriteLocs]:AddItem["Custom"]
					UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+1]}]}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				else
				{
					if ${_args.Used}>3
						InputBox -skin eq2 "${_args[${Math.Calc[${_count}+1]}]}" "${_args[${Math.Calc[${_count}+3]}]}"
					else
						InputBox -skin eq2 "${_args[${Math.Calc[${_count}+1]}]}"
					while ${UserInput.Equal[""]} 
					{
						MessageBox -skin eq2 "You must enter your input"
						InputBox -skin eq2 "${_args[${Math.Calc[${_count}+1]}]}"
						wait 1
					}
					if ${String[${UserInput}].Equal[NULL]}
						return
					if ${RI_Var_Bool_Debug}
						echo Adding Custom: ${UserInput} LOC: ${LastXYZ}
					UIElement[LocsList@WriteLocs]:AddItem["Custom"]
					if ${_args.Used}==2
						UIElement[LocsList@WriteLocs]:AddItem["${UserInput}"]
					else
						UIElement[LocsList@WriteLocs]:AddItem["${_args[${Math.Calc[${_count}+2]}]} ${UserInput}"]
					UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
				}
				break
			}
			default
				noop
		}
	}

	if ${_args.Used}==0
	{
		if ${UIElement[LocsList@WriteLocs].SelectedItem(exists)} && ${UIElement[TEEdit@WriteLocs].Text.NotEqual[""]}
		{
			UIElement[LocsList@WriteLocs].SelectedItem:SetText["${LastXYZ}"]
			return
		}
		if ${RI_Var_Bool_Debug}
			echo Writing ${LastXYZ}
		UIElement[LocsList@WriteLocs]:AddItem["${LastXYZ}"]
	}
	elseif ${Custom}
	{
		
	}
	elseif ${ClickActor}
	{
		
	}
	elseif ${Named}
	{
		
	}
	UIElement[LocsList@WriteLocs].FindUsableChild[Vertical,Scrollbar]:SetValue[0]
	;Filename:Flush
}
function Auto(int Distance)
{
	while ${Auto}
	{
		if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LastXYZC}]}>${Distance}
		{
			if ${RI_Var_Bool_Debug}
				echo we are more than ${Distance} from ${LastXYZC} Adding new point, ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${LastXYZC}]}
			;write a new point to file
			call Write
		}
		else
			call ExecuteQueued
	}
}

function ClearList()
{
	MessageBox -skin eq2 -yesno "Are you sure you want to clear the list of waypoints?"
	if ${UserInput.Equal[No]}
		return
	UIElement[LocsList@WriteLocs]:ClearItems
}
;executed when Edit Selection is pressed
function EditSelection()
{
	if ${UIElement[LocsList@WriteLocs].SelectedItem(exists)} && ${UIElement[TEEdit@WriteLocs].Text.NotEqual[""]}
	{
		UIElement[LocsList@WriteLocs].SelectedItem:SetText[${UIElement[TEEdit@WriteLocs].Text}]
	}
	else
	{
		if !${UIElement[LocsList@WriteLocs].SelectedItem(exists)}
		{
			MessageBox -skin eq2 "You must have an item selected to edit its value"
			return
		}
		if ${UIElement[TEEdit@WriteLocs].Text.Equal[""]}
		{
			MessageBox -skin eq2 "You must enter the text to the right that you want to replace the selected item with"
			return
		}
	}
}
;executed when Auto button is pressed
function AutoBTN()
{
	if ${Auto} == FALSE
	{
		Auto:Set[TRUE]
		UIElement[WriteLocs].FindChild[Auto]:SetText[Stop Auto]
		UIElement[WriteLocs].FindChild[Auto].Font:SetColor[FF32CD32]
	}
	else
	{
		Auto:Set[FALSE]
		UIElement[WriteLocs].FindChild[Auto]:SetText[Start Auto]
		UIElement[WriteLocs].FindChild[Auto].Font:SetColor[FFFF0000]
	}
}

;code to execute when close is pressed on ui
function atexit()
{
	echo ISXRI: Ending WriteLocs
	press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
	Filename:Close
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/WriteLocs.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIWCustom.xml"
}