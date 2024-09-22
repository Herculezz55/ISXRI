;ri Script, Holds, all the things that need to happen all the time, this Starts with ISXRI and ends with it.

variable(global) float RI_Var_Float_Version=6.86

variable(global) string RI_Var_String_SkinFileName="${LavishScript.HomeDirectory}/Interface/skins/eq2-green/eq2-green.xml"
variable(global) string RI_Var_String_SkinName="eq2-green"
variable(global) RIMUIObject RIMUIObj
variable(global) RIConsoleObject RIConsole
variable(global) RIMovementObject RIMObj
variable string MySubClass=${Me.SubClass}
variable(global) string RI_Var_Int_RIConsoleID
variable(global) string RI_Var_String_LookDownKey="\"Page Down\""
variable(global) string RI_Var_String_LookUpKey="\"Page Up\""
variable(global) string RI_Var_String_FlyUpKey=Home
variable(global) string RI_Var_String_FlyDownKey=End
variable(global) string RI_Var_String_StrafeLeftKey=q
variable(global) string RI_Var_String_StrafeRightKey=e
variable(global) string RI_Var_String_AutoRunKey="\"Num Lock\""
variable(global) string RI_Var_String_ForwardKey=w
variable(global) string RI_Var_String_BackwardKey=s
variable(global) string RI_Var_String_SwimUpKey=Home
variable(global) string RI_Var_String_SwimDownKey=End
variable(global) string RI_Var_String_JumpKey=space
variable(global) string RI_Var_String_CrouchKey=z
variable(global) string RI_Var_String_PotionName="Elixir of "
variable(global) string RI_Var_String_Poison1Name="Hemotoxin"
variable(global) string RI_Var_String_Poison2Name="Acidic Blast"
variable(global) string RI_Var_String_Poison3Name="Ignorant Bliss"
variable(global) string RI_Var_String_Poison4Name="Marked Target"
variable(global) string RI_Var_String_Poison5Name="Warding Ebb"
variable(global) string RI_Var_String_FoodName="Stormborn Souffle"
variable(global) string RI_Var_String_DrinkName="Monsoon"
variable(global) bool RI_Var_Bool_CraftDebug=FALSE
variable(global) bool RI_Var_Bool_RIMUICommandsEchoToConsole=TRUE
variable(global) bool RI_Var_Bool_WaitForHealth=TRUE
variable(global) bool RI_Var_Bool_Debug=FALSE
variable(global) bool RI_Var_Bool_ShinyDebug=FALSE
variable(global) bool RI_Var_Bool_LootDebug=FALSE
variable(global) bool RI_Var_Bool_AcceptTrades=TRUE
variable(global) bool RI_Var_Bool_SkipCheckToons=FALSE
variable(global) bool RI_Var_Bool_SkipLoot=FALSE
variable(global) bool RI_Var_Bool_BalanceTrash=TRUE
variable(global) bool RI_Var_Bool_GrabShinys=FALSE
variable(global) bool RI_Var_Bool_WaitForShinys=FALSE
variable(global) bool RI_Var_Bool_BackOffMerc=TRUE
variable(global) bool RI_Var_Bool_Moving=FALSE
variable(global) index:string RI_Index_String_AvailableRIMUICommands
variable(global) index:string RI_Index_String_AvailableRIMUICommandsDescription
variable(global) bool RI_Var_Bool_CancelMovement=FALSE
variable(global) bool RI_Var_Bool_PauseMovement=FALSE
variable(global) bool RI_Var_Bool_GlobalOthers=FALSE
variable(global) bool RI_Var_Bool_Start=FALSE
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) int RI_Var_Int_BadChestCnt=0
variable(global) string RI_Var_String_RelayGroup=ALL
variable(global) string RI_Var_Int_RelayGroupSize=0
variable(global) bool _RI_LootImmunity_=FALSE
variable string RI_Var_String_ButtonToChange
variable string RI_Var_String_ButtonChangeOriginalCommand
variable bool TradePending=FALSE
variable bool TradeAccepted=FALSE
variable bool IStartedTrade=FALSE
variable(global) RILootObject RILootObj
variable int Precision=2
variable(global) int RI_Var_Int_BSReadyCount=0
variable(global) int RI_Var_Int_ShinyMoveDistance=3
variable(global) bool RI_Var_Bool_IgnoreShinyY=FALSE
;RIMovementUI by Herculezz v1
;
;for GuildStrategist use 10m distance2d
;
variable(global) bool RI_Var_Bool_WaitForLastNamedChest=0
variable(global) bool RI_Var_Bool_TordenShort=0
variable(global) bool RI_Var_Bool_BadChestTrigger=0
variable(global) int RI_Var_Int_MoveMaxDistance=500

variable(global) index:int RI_Var_IndexInt_InvalidChest
variable(global) index:int RI_Var_IndexInt_InvalidShiny
variable(global) index:string RI_Var_IndexString_ShinyNames
variable(global) string RI_Var_String_Query="Name=-\"?\""
variable(global) int RI_Var_Int_ShinyClosestPointScanPoints=100
variable bool LoadRIMUI=FALSE
variable bool RIMUILoaded=FALSE
variable bool CommandQ=FALSE
variable bool RIFP=FALSE
variable bool RILSP=FALSE
variable bool ASSP=FALSE
variable bool DOORP=FALSE
variable bool TMP=FALSE
variable bool FaTrP=FALSE
variable string PopForWho=~NONE~
variable float JUX
variable float JUY
variable float JUZ
variable float JUYT
variable float JUFD
variable float JUGUC
variable bool JU=FALSE
variable float MTX
variable float MTY
variable float MTZ
variable int MTP
variable bool MT=FALSE
variable CountSetsObject CountSets
variable(global) string RIMovementUIScriptName=${Script.Filename}
variable(global) string RI_String_RIMUI_BTNR1C1Txt=""
variable(global) string RI_String_RIMUI_BTNR2C1Txt=""
variable(global) string RI_String_RIMUI_BTNR3C1Txt=""
variable(global) string RI_String_RIMUI_BTNR4C1Txt=""
variable(global) string RI_String_RIMUI_BTNR5C1Txt=""
variable(global) string RI_String_RIMUI_BTNR6C1Txt=""
variable(global) string RI_String_RIMUI_BTNR7C1Txt=""
variable(global) string RI_String_RIMUI_BTNR8C1Txt=""
variable(global) string RI_String_RIMUI_BTNR9C1Txt=""
variable(global) string RI_String_RIMUI_BTNR10C1Txt=""
variable(global) string RI_String_RIMUI_BTNR1C2Txt=""
variable(global) string RI_String_RIMUI_BTNR2C2Txt=""
variable(global) string RI_String_RIMUI_BTNR3C2Txt=""
variable(global) string RI_String_RIMUI_BTNR4C2Txt=""
variable(global) string RI_String_RIMUI_BTNR5C2Txt=""
variable(global) string RI_String_RIMUI_BTNR6C2Txt=""
variable(global) string RI_String_RIMUI_BTNR7C2Txt=""
variable(global) string RI_String_RIMUI_BTNR8C2Txt=""
variable(global) string RI_String_RIMUI_BTNR9C2Txt=""
variable(global) string RI_String_RIMUI_BTNR10C2Txt=""
variable(global) string RI_String_RIMUI_BTNR1C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F1Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F1Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F1Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F1Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F1Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F2Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F2Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F2Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F2Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F2Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F3Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F3Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F3Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F3Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F3Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F3Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F4Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F4Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F4Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F4Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F4Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F4Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F5Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F5Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F5Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F5Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F5Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F5Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F6Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F6Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F6Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F6Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F6Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F6Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F7Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F7Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F7Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F7Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F7Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F7Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F8Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F8Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F8Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F8Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F8Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F8Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F9Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F9Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F9Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F9Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F9Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F9Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR2C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR3C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR4C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR5C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR6C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR7C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR8C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR9C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR10C3F10Txt=""
variable(global) string RI_String_RIMUI_BTNR1C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR2C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR3C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR4C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR5C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR6C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR7C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR8C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR9C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR10C4F10Txt=""
variable(global) string RI_String_RIMUI_BTNR1C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR2C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR3C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR4C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR5C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR6C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR7C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR8C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR9C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR10C5F10Txt=""
variable(global) string RI_String_RIMUI_BTNR1C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR2C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR3C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR4C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR5C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR6C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR7C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR8C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR9C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR10C6F10Txt=""
variable(global) string RI_String_RIMUI_BTNR1C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR2C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR3C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR4C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR5C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR6C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR7C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR8C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR9C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR10C7F10Txt=""
variable(global) string RI_String_RIMUI_BTNR1C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C1Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C2Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C3F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C4F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C5F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C6F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR1C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR2C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR3C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR4C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR5C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR6C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR7C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR8C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR9C7F10Com="noop"
variable(global) string RI_String_RIMUI_BTNR10C7F10Com="noop"
variable(global) string RI_String_RIMUI_RelayTarget="ALL"
variable bool RelayGroupChecked=FALSE
variable bool NearesetNPCHudLoaded=FALSE
variable bool NearesetPlayerHudLoaded=FALSE
variable bool RaidGroupHudLoaded=FALSE
variable string Size=Small
variable string RIConsoleSize=Small
variable settingsetref Set
variable bool boolNameOnlyButton=FALSE
variable bool FactionsInit=FALSE
variable string FactionsPass=NONE
variable string CurrentZoneName="${Zone.Name}"
variable index:string GroupNames
;end variables for RIMUI
variable(global) bool RI_Var_Bool_CheckLoot=FALSE
variable filepath FP
variable bool GrabingShinys=FALSE
variable filepath ScanDirectory=""
variable(global) collection:string RI_CollectionString_RQQuests

function main()
{
	;disable RI_Var_Bool_Debugging
	Script:DisableDebugging
	
	;if RelayGroup is check on rimui chage RI_String_RIMUI_RelayTarget to \${RI_Var_String_RelayGroup}
	if ${UIElement[RelayGroup@Titlebar@RIMovementUI].Checked}
		RI_String_RIMUI_RelayTarget:Set["\${RI_Var_String_RelayGroup}"]
	else
		RI_String_RIMUI_RelayTarget:Set["ALL"]
	
	;check if RIMUI.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml" http://www.isxri.com/RI.xml
		wait 50
	}
	if !${FP.FileExists[RIAutoTarget.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIAutoTarget.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIAutoTarget.xml" http://www.isxri.com/RIAutoTarget.xml
		wait 50
	}
	if !${FP.FileExists[RIBalance.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIBalance.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIBalance.xml" http://www.isxri.com/RIBalance.xml
		wait 50
	}
	if !${FP.FileExists[RICharListUI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RICharListUI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RICharListUI.xml" http://www.isxri.com/RICharListUI.xml
		wait 50
	}
	if !${FP.FileExists[RIGroupLogin.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIGroupLogin.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIGroupLogin.xml" http://www.isxri.com/RIGroupLogin.xml
		wait 50
	}
	if !${FP.FileExists[RIInventory.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIInventory.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIInventory.xml" http://www.isxri.com/RIInventory.xml
		wait 50
	}
	if !${FP.FileExists[RIMobHud.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMobHud.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMobHud.xml" http://www.isxri.com/RIMobHud.xml
		wait 50
	}
	if !${FP.FileExists[RIMovement.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMovement.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMovement.xml" http://www.isxri.com/RIMovement.xml
		wait 50
	}
	if !${FP.FileExists[RISalvage.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RISalvage.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RISalvage.xml" http://www.isxri.com/RISalvage.xml
		wait 50
	}
	if !${FP.FileExists[RITransmute.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RITransmute.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RITransmute.xml" http://www.isxri.com/RITransmute.xml
		wait 50
	}
	if !${FP.FileExists[RPG.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RPG.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RPG.xml" http://www.isxri.com/RPG.xml
		wait 50
	}
	if !${FP.FileExists[RZ.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RZ.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RZ.xml" http://www.isxri.com/RZ.xml
		wait 50
	}
	if !${FP.FileExists[RZm.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RZm.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RZm.xml" http://www.isxri.com/RZm.xml
		wait 50
	}
	if !${FP.FileExists[RZo.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RZo.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RZo.xml" http://www.isxri.com/RZo.xml
		wait 50
	}
	if !${FP.FileExists[ZoneReset.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting ZoneReset.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/ZoneReset.xml" http://www.isxri.com/ZoneReset.xml
		wait 50
	}
	if !${FP.FileExists[WriteLocs.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting WriteLocs.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/WriteLocs.xml" http://www.isxri.com/WriteLocs.xml
		wait 50
	}
	if !${FP.FileExists[RIMUI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMUI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml" http://www.isxri.com/RIMUI.xml
		wait 50
	}
	if !${FP.FileExists[RIMUICustom.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMUICustom.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMUICustom.xml" http://www.isxri.com/RIMUICustom.xml
		wait 50
	}
	if !${FP.FileExists[RIMUIEdit.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMUIEdit.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml" http://www.isxri.com/RIMUIEdit.xml
		wait 50
	}
	if !${FP.FileExists[RIConsole.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIConsole.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIConsole.xml" http://www.isxri.com/RIConsole.xml
		wait 50
	}
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		FP:MakeSubdirectory[CombatBot]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/"]
	}
	if !${FP.FileExists[CombatBotMiniUI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting CombatBotMiniUI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/CombatBot/CombatBotMiniUI.xml" http://www.isxri.com/CombatBotMiniUI.xml
		wait 50
	}
	if !${FP.FileExists[CombatBotUI.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting CombatBotUI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI//CombatBot/CombatBotUI.xml" http://www.isxri.com/CombatBotUI.xml
		wait 50
	}
	
	RI_Index_String_AvailableRIMUICommands:Insert[AcceptReward]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Accept Reward - Accepts pending reward (for rewards with options it simply closes the window until you zone again)\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[AssistPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[AssistPop - Pops up the Assist UI\n\nArgument 1: ForWho To Show UI\n\nArgument 2(Optional): For Who To Execute After UI]
	RI_Index_String_AvailableRIMUICommands:Insert[ApplyVerb]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ApplyVerb - execute's eq2's Apply Verb command\n\nArgument 1: For Who\nArgument 2: Actor Name or ID\nArgument 3: Verb]
	RI_Index_String_AvailableRIMUICommands:Insert[Assist]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Assist - Turns on/off assisting dynamically and sets assist name\n\nArgument 1: For Who\nArgument 2: 1=On 0=Off\nArgument 3: Assist Name (Optional)]
	RI_Index_String_AvailableRIMUICommands:Insert[AutoLoot]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LootOptions - Change auto loot options\n\nArgument 1: For Who\nArgument 2: Option\n0=None\n1=Greed or Accept\n2=Decline]
	RI_Index_String_AvailableRIMUICommands:Insert[AutoRun]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Auto Run - Presses auto run key\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[BalanceTrash]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[BalanceTrash - Turns on/off Balancing of trash mobs with RunInstances (must be done on Main session aka Tank)]
	RI_Index_String_AvailableRIMUICommands:Insert[CancelAllMaintained]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CancelAllMaintained - Cancels all Maintained Abilities\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[CancelMaintained]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CancelMaintained - Cancels Maintained Abilities\nRequires CombatBot to use Base Ability Names\nAccepts Unlimited Arguments in sets of 2\n\nArgument 1: For Who\nArgument 2:Maintained Ability to Cancel]
	RI_Index_String_AvailableRIMUICommands:Insert[CallGH]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CallGH - Calls to the Guild Hall\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[CampCharacterSelect]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CampCharacterSelect - Camps to the character selection screen\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[CampDesktop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CampDesktop - Camps to the desktop (closing the client)\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[CampLogin]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CampLogin - Camps to the login screen\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[Cast]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Cast - Casts abilities\n\nAccepts Unlimited Arguments in sets of 3\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: Ability Name\nArgument 3: CancelCast 1=Yes 0=No]
	RI_Index_String_AvailableRIMUICommands:Insert[CastOn]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CastOn - Casts abilities on specified targets\n\nAccepts Unlimited Arguments in sets of 4\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: Ability Name\nArgument 3: On Who\nArgument 4: CancelCast 1=Yes 0=No]
	RI_Index_String_AvailableRIMUICommands:Insert[ChoiceWindow]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ChoiceWindow - Chooses option from a pop up choice window action\n\nArgument 1: For Who\nArgument 2: Choice(1 or 2)]
	RI_Index_String_AvailableRIMUICommands:Insert[ClearButton]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ClearButton - Clears this buttons name and command\n\nNo Arguments]
	RI_Index_String_AvailableRIMUICommands:Insert[CloseTopWindow]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CloseTopWindow - Closes topmost eq2 window\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[ComeOn]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ComeOn - Clears LockSpot and returns to previous RIMovement action\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[Crouch]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Crouch - Presses crouch key\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[DisplayAllFactions]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[DisplayAllFactions - Displays all faction data, will retrieve data from server if doesn't exist\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[DisplayStats]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[DisplayStats - Displays stats passed in console\n\nArguments: Stats (unlimited)]
	RI_Index_String_AvailableRIMUICommands:Insert[Depot]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Depot - Deposits all into the nearest Depot\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[Door]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Door - Clicks door option\n\nArgument 1: For Who\nArgument 2: Door Option(#)]
	RI_Index_String_AvailableRIMUICommands:Insert[DoorPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[DoorPop - Pops up the DoorOption UI\n\nArgument 1: ForWho To Show UI\n\nArgument 2(Optional): For Who To Execute After UI]
	RI_Index_String_AvailableRIMUICommands:Insert[EndBots]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[EndBots - Ends compatible running bot\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[EndScript]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[EndScript - Ends a script\n\nArgument 1: For Who\nArgument 2: Script Name]
	RI_Index_String_AvailableRIMUICommands:Insert[EquipCharm]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[EquipCharm - Equips the charm specified\n\nArgument 1: For Who\nArgument 2: Charm Name]
	RI_Index_String_AvailableRIMUICommands:Insert[ExecuteCommand]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ExecuteCommand - Executes a command\n\nArgument 1: For Who\nArgument 2: Command Name]
	RI_Index_String_AvailableRIMUICommands:Insert[Evac]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Evac - Casts evac ability\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[FastTravel]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[FastTravel - Opens fast travel Clicks Argument2 on TravelMap and Zones there\n\nArgument 1: For Who\n\nArgument 2: Zone Name (case insesitive and partial zone names are fine)]
	RI_Index_String_AvailableRIMUICommands:Insert[FastTravelPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[FastTravelPop - Pops up the FastTravel UI\n\nArgument 1: ForWho To Show UI\n\nArgument 2(Optional): For Who To Execute After UI]
	RI_Index_String_AvailableRIMUICommands:Insert[Flag]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Flag - Takes/Gets a Flag from the closest Guild Strategist\n\nArgument 1: ForWho\nArgument 2: Get/Take]
	RI_Index_String_AvailableRIMUICommands:Insert[FoodDrinkConsume]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[FoodDrinkConsume - Toggles the consumption of your equiped food and drink\n\nArgument 1: For Who\nArgument 2: 1=On or 0=Off]
	RI_Index_String_AvailableRIMUICommands:Insert[FoodDrinkReplenish]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[FoodDrinkReplenish - Replenishes raid food and drink from the nearest FoodDrink depot\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[GrabShinys]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[GrabShinys - Turns RI's GrabShiny function on or off\n\nArgument 1: On/Off (1/0) or (TRUE/FALSE)]
	RI_Index_String_AvailableRIMUICommands:Insert[GuidedAscension]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[GuidedAscension - Applies Guided Ascension if it exists in your inventory and is useable\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[GuildBuffs]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[GuildBuffs - Clicks preorder clicky buff's with 10s delay\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[Hail]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Hail - Hails specified actor\n\nArgument 1: For Who\nArgument 2: Actor to Hail ($ {Target} works)]
	RI_Index_String_AvailableRIMUICommands:Insert[HailOption]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[HailOption - Chooses the specified option in a conversation\n\nArgument 1: For Who\nArgument 2: Option(#)]
	RI_Index_String_AvailableRIMUICommands:Insert[InitializeFactions]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[InitializeFactions - Retrieves faction data from server\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[Invite]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Invite - Invites up to 5 toons to your group or 23 to your raid\n\nArgument 1: For Who\nArguments 2-24: Toon Names]
	RI_Index_String_AvailableRIMUICommands:Insert[Jump]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Jump - Jumps :P\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[LoadNearestNPCHud]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LoadNearestNPCHud - Loads in game HUD with Nearest Named/NPC, their target and their distance\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[LoadNearestPlayerHud]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LoadNearestPlayerHud - Loads in game HUD with Nearest PC, their target and their distance\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[LoadRaidGroupHud]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LoadRaidGroupHud - Loads in game HUD with your raid/group, their target and their distance\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[LockSpotPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LockSpotPop - Pops up the SetLockSpot UI\n\nArgument 1: ForWho To Show UI\n\nArgument 2(Optional): For Who To Execute After UI]
	RI_Index_String_AvailableRIMUICommands:Insert[LootOptions]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LootOptions - Change groups loot options\n\nArgument 1: For Who\nArgument 2: Option\nLEADERONLY / LO\nFREEFORALL / FFA\nLOTTO / L\nNEEDBEFOREGREED / NBG\nROUNDROBIN/ RR]
	RI_Index_String_AvailableRIMUICommands:Insert[Mentor]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Mentor - Mentors player\n\nArgument 1: For Who\nArgument 2: Player Name (\\$ {Target} works)]
	RI_Index_String_AvailableRIMUICommands:Insert[MoveTo]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[MoveTo - Moves to a Loc\nAccepts Unlimited Arguments in Sets of 5\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: X\nArgument 3: Y\nArgument 4: Z\nArgument 5: Precision]
	RI_Index_String_AvailableRIMUICommands:Insert[MultipleCommands]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[MultipleCommands - Executes multiple commands all in the same frame\n\nArgument 1: ForWho\nArguments 2+: Unlimited number of commands (eq2ex commands, isxeq2 commands or even any of the commands from RIMUI or ISXRI)]
	RI_Index_String_AvailableRIMUICommands:Insert[OverseerRunNow]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[OverseerRunNow - Runs overseer check NOW\n\nArgument 1: ForWho]
	RI_Index_String_AvailableRIMUICommands:Insert[OverseerGO]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[OverseerGO - Go's and gets charged quests according to ui settings\n\nArgument 1: ForWho]
	RI_Index_String_AvailableRIMUICommands:Insert[PauseBot]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PauseBot - Pauses whatever compatible bot you are running\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[PauseRI]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PauseRI - Pauses RI\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[PauseRIM]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PauseRIM - Pauses RIMovement\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[PetAttack]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PetAttack - Sends your pet in to attack (if you have one)\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[PetBackOff]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PetBackOff - Tells your pet to back off (if you have one)\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[PotionConsume]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PotionConsume - Toggles the consumption of your Elixir of XX\n\nArgument 1: For Who\nArgument 2:  1=On or 0=Off]
	RI_Index_String_AvailableRIMUICommands:Insert[PotionReplenish]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PotionReplenish - Replenishes potion from the nearest potion depot\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[PoisonConsume]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PoisonConsume - Toggles the consumption of your poison's\n\nArgument 1: For Who\nArgument 2:  1=On or 0=Off]
	RI_Index_String_AvailableRIMUICommands:Insert[PoisonReplenish]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PoisonReplenish - Replenishes poison's from the nearest poison depot\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[PreHeal]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[PreHeal - Casts your main single target and group heal abilities\n\nArgument 1: For Who\nArgument 2: On Who (For Single Target)]
	RI_Index_String_AvailableRIMUICommands:Insert[Repair]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Repair - Repairs your gear at the nearest repair actor\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[ReplyDialog]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ReplyDialog - Chooses option's from a reply dialog window\n\nArgument 1: For Who\nArgument 2-Unlimited: Option as # or String]
	RI_Index_String_AvailableRIMUICommands:Insert[ResetZone]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResetZone - Resets zone's\n\nArgument 1: For Who\n\nArgument 2+: Zone or Zone's to Reset\n]
	RI_Index_String_AvailableRIMUICommands:Insert[ResetAllZones]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResetAllZones - Resets all zone's\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[ResumeBot]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResumeBot - Resumes whatever compatible bot you are running\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[ResumeRI]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResumeRI - Resumes RI\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[ResumeRIM]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResumeRIM - Resumes RIMovement\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[Revive]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Revive - Revives at junction\n\nArgument 1: For Who\n\nArgument 2: Junction (Default: 0)]
	RI_Index_String_AvailableRIMUICommands:Insert[RIFollowChange]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RIFollowChange - Changes min of RIFollow\n\nArgument 1: For Who (Default: ALL)\nArgument 2: Change(#)]
	RI_Index_String_AvailableRIMUICommands:Insert[RIFollowPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RIFollowPop - Pops up the RIFollow UI\n\nArgument 1: ForWho To Show UI\n\nArgument 2(Optional): For Who To Execute After UI]
	RI_Index_String_AvailableRIMUICommands:Insert[RunQuest]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RunQuest - Runs a quest with RQ\n\nArgument 1: For Who\nArgument 2: Quest Name]
	RI_Index_String_AvailableRIMUICommands:Insert[RunScript]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RunScript - Runs a script\n\nArgument 1: For Who\nArgument 2: Script Name]
	RI_Index_String_AvailableRIMUICommands:Insert[ScribeBook]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ScribeBook - Scribes the recipe book if it exists in your inventory (case insesitive and partial book names are fine\n\nArgument 1: For Who\n\nArgument 2: Book Name]
	RI_Index_String_AvailableRIMUICommands:Insert[SetInGameFollow]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetInGameFollow - Turns on In Game Follow\n\nAccepts Unlimited Arguments in Sets of 2\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: Who to follow]
	RI_Index_String_AvailableRIMUICommands:Insert[SetLockSpot]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetLockSpot - Turns on LockSpot\nAccepts Unlimited Arguments in Sets of 6\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: X or OFF\nArgument 3: Y\nArgument 4: Z\nArgument 5: Min\nArgument 6: Max]
	RI_Index_String_AvailableRIMUICommands:Insert[SetMoveBehind]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetMoveBehind - Turns on/off/toggles MoveBehind in CombatBot\nAccepts Unlimited Arguments in Sets of 4\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: On/Off/Toggle (1/0/-1)\nArgument 3: Move Health\nArgument 4: Skip Move Health Check (TRUE/FALSE)]
	RI_Index_String_AvailableRIMUICommands:Insert[SetMoveIn]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetMoveIn - Turns on/off/toggles MoveIn in CombatBot\nAccepts Unlimited Arguments in Sets of 4\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: On/Off/Toggle (1/0/-1)\nArgument 3: Move Health\nArgument 4: Skip Move Health Check (TRUE/FALSE)]
	RI_Index_String_AvailableRIMUICommands:Insert[SetMoveInFront]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetMoveInFront - Turns on/off/toggles MoveInFront in CombatBot\nAccepts Unlimited Arguments in Sets of 4\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: On/Off/Toggle (1/0/-1)\nArgument 3: Move Health\nArgument 4: Skip Move Health Check (TRUE/FALSE)]
	RI_Index_String_AvailableRIMUICommands:Insert[SetRIFollow]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetRIFollow - Turns on RIFollow\n\nArgument 1: For Who (Default: ALL)\nArgument 2: On Who (Default: OFF)\nArgument 3: Min (Default: 1)\nArgument 4: Max (Default: 100)]
	RI_Index_String_AvailableRIMUICommands:Insert[SetShinyScanDistance]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetShinyScanDistance - Sets the distance to scan for shinies\n\nArgument 1: Distance]
	RI_Index_String_AvailableRIMUICommands:Insert[SetUISetting]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetUISetting - Turns on/off/toggles UISettings in CombatBot\nAccepts Unlimited Arguments in Sets of 3\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: Setting Name\nArgument 3: On/Off/Toggle (1/0/-1)]
	RI_Index_String_AvailableRIMUICommands:Insert[Special]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Special - Clicks the closest Special type actor\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[StopMove]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[StopMove - Stops all movement\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[SummonMount]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SummonMount - Summons your mount if you are not on one\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[Target]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Target - Target's specified actor\n\nArgument 1: For Who\nArgument 2: Actor Name ($ {Target} works)]
	RI_Index_String_AvailableRIMUICommands:Insert[ToggleWalkRun]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ToggleWalkRun - Toggles between walking and running\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[TravelMap]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[TravelMap - Clicks Argument2 on TravelMap and Zones there\nArgument 1: For Who\nArgument 2: Zone Name (case insesitive and partial zone names are fine)\nArgument 3: Door Option (0 chooses Bottom option)\nArgument 4: Open Portal / Bell=1 Wizard=2 Druid=3]
	RI_Index_String_AvailableRIMUICommands:Insert[TravelMapPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[TravelMapPop - Pops up the TravelMap UI\n\nArgument 1: ForWho To Show UI\n\nArgument 2(Optional): For Who To Execute After UI]
	RI_Index_String_AvailableRIMUICommands:Insert[UnloadISXRI]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UnloadISXRI - Unloads the ISXRI extension\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[UnLoadNearestNPCHud]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UnLoadNearestNPCHud - UnLoads in game HUD with Nearest Named/NPC, their target and their distance\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[UnLoadNearestPlayerHud]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UnLoadNearestPlayerHud - UnLoads in game HUD with Nearest PC, their target and their distance\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[UnLoadRaidGroupHud]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UnLoadRaidGroupHud - UnLoads in game HUD with your raid/group, their target and their distance\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[UnMentor]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UnMentor - Unmentors\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[UplinkConnect]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UplinkConnect - Connects PC's to the uplink\n\nAccepts Unlimited Arguments in Sets of 1\n\nArguments: PCName's]
	RI_Index_String_AvailableRIMUICommands:Insert[UplinkDisconnect]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UplinkDisconnect - Disconnects PC's to the uplink\n\nAccepts Unlimited Arguments in Sets of 1\n\nArguments: PCName's]
	RI_Index_String_AvailableRIMUICommands:Insert[UplinkList]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UplinkList - Lists all PC's on the uplink]
	RI_Index_String_AvailableRIMUICommands:Insert[UseItem]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[UseItem - Uses an item from your Inventory or Equipment\n\nArgument 1: For Who\nArgument 2: Item Name]
	RI_Index_String_AvailableRIMUICommands:Insert[Zone]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Zone - Clicks closest KNOWN zone door\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[ZoneVersion]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ZoneVersion - Accepts zone version window\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[JumpUp]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[JumpUp - Jumps toons on top of things\n\nArgument 1: For Who\n\nArgument 2: X\nArgument 3: Y\nArgument 4: Z\n(Args 2,3,4 Defaults to your LOC)\nArgument 5: Y_Target (Default: Your Y+2)\nArgument 6: Heading (Default: Your Heading)\nArgument 7: Fail Timer(s) (Default: 5s) ]
	;(string _ForWho=ALL, float _X=${Me.X}, float _Y=${Me.Y}, float _Z=${Me.Z}, float _YTarget=${Math.Calc[${Me.Y}+2]}, int _FaceDegree=${Me.Heading}, int _GiveUpCNT=10)
	;need to do something about when someone changes toons - DONE
	switch ${Me.Archetype}
	{
		case fighter
		{
			RI_Var_String_PotionName:Concat["Fortitude"]
			break
		}
		case priest
		{
			RI_Var_String_PotionName:Concat["Piety"]
			break
		}
		case mage
		{
			RI_Var_String_PotionName:Concat["Intellect"]
			break
		}
		case scout
		{
			RI_Var_String_PotionName:Concat["Deftness"]
			break
		}
	}
	
	;events
	Event[EQ2_onChoiceWindowAppeared]:AttachAtom[EQ2_onChoiceWindowAppeared]
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	Event[EQ2_onQuestOffered]:AttachAtom[EQ2_onQuestOffered]
	Event[EQ2_FinishedZoning]:AttachAtom[EQ2_FinishedZoning]
	Event[EQ2_onLootWindowAppeared]:AttachAtom[EQ2_onLootWindowAppeared]
	call LoadRIMUI 0
	RIConsole:LoadUI
	RIConsole:Hide
	wait 1
	if ${RIConsoleSize.Equal[Small]}
	{
		RIConsole:UISmall[0]
	}
	if ${RIConsoleSize.Equal[Medium]}
	{
		RIConsole:UIMedium[0]
	}
	if ${RIConsoleSize.Equal[Large]}
	{
		RIConsole:UILarge[0]
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI"]
		FP:MakeSubdirectory[RILoot]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot"]
	}
	
	if !${FP.FileExists[RILootSave.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RILootSave.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml" http://www.isxri.com/RILootSave.xml
		wait 50
	}
	
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	;check if xml exists, if not create
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RILoot.xml]}
	{
		if ${Debug}
			echo ${Time}: Getting RILoot.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RILoot.xml" http://www.isxri.com/RILoot.xml
		wait 50
	}
	
	;start ri overseer
	RI_Overseer

	;load ui
	ui -reload "${RI_Var_String_SkinFileName}"
	
	RILootObj:LoadRILootOn
	RILootObj:LoadItems
	RILootObj:LoadAddedItems
	RILootObj:Group[1]
	UIElement[LootedTextEntry@RILoot]:SetText[0]
	variable int ChildrenCounter = 1
	variable int AILCounter = 1
	UIElement[RILoot]:Hide
	
	if ${Input.Button[PGUP](exists)}
	{
		RI_Var_String_LookDownKey:Set[PGDOWN]
		RI_Var_String_LookUpKey:Set[PGUP]
	}
	while 1
	{
		; if ${_BALREZUSCRIPTRUNNING}
		; {
			; if ${Actor[corpse,radius,8](exists)} && ${Actor[Query, Name=-"Balrezu"](exists)}
			; {
				; if ${RI_Var_Bool_Debug}
					; echo ISXRI: ${Time}: Looting ${Actor[corpse,radius,10]}
				
				;;loot corpse via apply verb
				; eq2ex apply_verb ${Actor[corpse,radius,10].ID} Loot
			; }
			; if ${Me.Inventory[Query, Location=="Inventory" && Name=="Obsidian Sun Disc"](exists)}
				; Me.Inventory[Query, Location=="Inventory" && Name=="Obsidian Sun Disc"]:Destroy
		; }
		if ${RI_Var_Bool_Podts}
		{
			if ${RI_Var_Bool_Podtstombhorrow}
			{
				Me.Inventory[Query, Name=-"Embalming Kit" && Location=="Inventory"]:Use
			}
			if ${Actor[Query, Name=-"minigame flesh cube blocker" && Distance<10](exists)}
				Actor[Query, Name=-"minigame flesh cube blocker" && Distance<10]:DoubleClick
			waitframe
		}
		
		if ${QueuedCommands}
			call RIMObj.ExecuteQueued
		if ${MySubClass.NotEqual[${Me.SubClass}]}
		{
			MySubClass:Set[${Me.SubClass}]
			RI_Var_String_PotionName:Set["Thaumic Elixir of "]
			switch ${Me.Archetype}
			{
				case fighter
				{
					RI_Var_String_PotionName:Concat["Fortitude"]
					break
				}
				case priest
				{
					RI_Var_String_PotionName:Concat["Piety"]
					break
				}
				case mage
				{
					RI_Var_String_PotionName:Concat["Intellect"]
					break
				}
				case scout
				{
					RI_Var_String_PotionName:Concat["Deftness"]
					break
				}
			}
		}
		if ${CurrentZoneName.NotEqual["${Zone.Name}"]} && ${EQ2.Zoning}==0
		{
			CurrentZoneName:Set["${Zone.Name}"]
			RIMUIObj.NumFactions:Set[0]
		}
		if !${RI_Var_Bool_SkipLoot} && !${Me.Name.Find["Skyshrine "](exists)}
		{
			;if a corpse exists within 8m radius and corpse looting is on
			if ${RI_Var_Bool_CorpseLoot} || ( ${UIElement[SettingsLootingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLootCorpsesCheckBox@SettingsFrame@CombatBotUI].Checked} )
			{
				if ${Actor[corpse,radius,8](exists)}
				{
					if ${RI_Var_Bool_Debug}
						echo ISXRI: ${Time}: Looting ${Actor[corpse,radius,10]}
					
					;loot corpse via apply verb
					eq2ex apply_verb ${Actor[corpse,radius,10].ID} Loot
				}
			}
			if ${UIElement[AddedItemsListbox@RILoot].Items}>0 && ${UIElement[RILootOnCheckbox@RILoot].Checked} && ${Me.Group}>1 && ( ${Me.Group[2].Type.NotEqual[Mercenary]} || ${Me.Group}>2 ) && ( ${Actor[Exquisite Chest,radius,7](exists)} || ${Actor[Gaukr Sandstorm's Treasure,radius,7](exists)} || ${Actor[Hreidar Lynhillig's Treasure,radius,7](exists)} )
			{
				if ${Me.IsGroupLeader} && ( ${RI_Var_Bool_Loot} || ( ${UIElement[SettingsLootingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLootChestsCheckBox@SettingsFrame@CombatBotUI].Checked} ) ) && !${GrabingShinys}
				{
					if ( ${Actor[Exquisite Chest,radius,7](exists)} || ${Actor[Gaukr Sandstorm's Treasure,radius,7](exists)} || ${Actor[Hreidar Lynhillig's Treasure,radius,7](exists)} )
					{
						if ${RI_Var_Bool_LootDebug}
							echo ISXRI: ${Time}: Checking Smart Loot : ( ${Actor[Exquisite Chest,radius,7](exists)} || ${Actor[Gaukr Sandstorm's Treasure,radius,7](exists)} || ${Actor[Hreidar Lynhillig's Treasure,radius,7](exists)} ) : ${RI_Var_Bool_Loot}
						if ${LootWindow(exists)}
							noop
						else
						{
							LootWindow:Close
							eq2ex close_top_window
							RIMUIObj:LootOptions[ALL,LO]
							wait 20
							if ${RI_Var_Bool_LootDebug}
								echo ISXRI: Clicking Chest to distribute via RILoot, main fuction in Buffer:RI
							;doubleclick chest wait 5 then check if we need to give any items to anyone
							Actor[Exquisite Chest,radius,7]:DoubleClick
							Actor[Gaukr Sandstorm's Treasure,radius,7]:DoubleClick
							Actor[Hreidar Lynhillig's Treasure,radius,7]:DoubleClick
							wait 5 ${LootWindow(exists)}
							Actor[Exquisite Chest,radius,7]:DoubleClick
							Actor[Gaukr Sandstorm's Treasure,radius,7]:DoubleClick
							Actor[Hreidar Lynhillig's Treasure,radius,7]:DoubleClick
							wait 5 ${LootWindow(exists)}
							wait 2
							
							;check if any items in chest are in our AddedItemsListbox and the Toon is in our group/raid
						}
						if ${LootWindow(exists)}
						{
							do
							{
								ChildrenCounter:Set[1]
								FoundVar:Set[0]
								do
								{
									;; We are only interested in the members of Type Text and this will be what we need to click
									if (${LootWindow.ItemsPage.Child[${ChildrenCounter}].Type.Find[Text]})
									{
										;; We ignore the static member table entry as it is never an item
										if ${LootWindow.ItemsPage.Child[${ChildrenCounter}].GetProperty[LocalText].Equals[table entry]}
											continue
										if ${RI_Var_Bool_LootDebug}	
											echo Checking #${ChildrenCounter} of ${LootWindow.ItemsPage.NumChildren}: ${LootWindow.ItemsPage.Child[${ChildrenCounter}].GetProperty[LocalText]}
										
										for(AILCounter:Set[1];${AILCounter}<=${UIElement[AddedItemsListbox@RILoot].Items};AILCounter:Inc)
										{
											;if we find the Item of ChildCounter in our AddedItemsListbox
											if ${RI_Var_Bool_LootDebug}
												echo Checking #${AILCounter} of ${UIElement[AddedItemsListbox@RILoot].Items}: Checking ${LootWindow.ItemsPage.Child[${ChildrenCounter}].GetProperty[LocalText]} //${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[1,|]} // ${LootWindow.ItemsPage.Child[${ChildrenCounter}].GetProperty[LocalText].Find["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[1,|]}"](exists)}
											
											if ${LootWindow.ItemsPage.Child[${ChildrenCounter}].GetProperty[LocalText].Find["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[1,|]}"](exists)}
											{
												if ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|].Equals["*WAIT*"]}
												{
													;sound Alarm and throw a messagebox on ALL Sessions
													relay ALL MessageBox -skin eq2 "${Me.Name} Found ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]} WAITING"
													while ${Actor[Exquisite Chest,radius,7](exists)}
														wait 1
												}
												else
												{
													;now check if the toon associated is in our group and if the QTY is either ~ or < LootedTextEntry@RILoot
													if ${RI_Var_Bool_LootDebug}
														echo Checking #${AILCounter} of ${UIElement[AddedItemsListbox@RILoot].Items}: ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text} // ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[1,|]} : ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]} : ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[3,|]} : ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[4,|]} ${Me.Group["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]}"](exists)} && ( ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[3,|].Equals[~]} || ${Int[${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[3,|]}]} > ${Int[${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[4,|]}]} )
													if ${Me.Group["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]}"](exists)} && ( ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[3,|].Equals[~]} || ${Int[${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[3,|]}]} > ${Int[${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[4,|]}]} )
													{
														;increment our Foundvar
														FoundVar:Inc
														;set the group member box to this toon and send over the item as well as increment the Looted
														noop ${RILootObj.SetGroupMember["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]}"]}
														wait 5
														if ${RI_Var_Bool_LootDebug}
															echo Setting GroupMember ${RILootObj.SetGroupMember["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]}"]}
														if ${RILootObj.SetGroupMember["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]}"]}
														{
															if ${RI_Var_Bool_LootDebug}
																echo Setting Looted +1 for ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text}
																
															;set looted +1
															UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}]:SetText["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[1,|]}|${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[2,|]}|${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[3,|]}|${Math.Calc[${Int[${UIElement[AddedItemsListbox@RILoot].OrderedItem[${AILCounter}].Text.Token[4,|]}]}+1].Precision[0]}"]
															;save and reload to All
															RILootObj:SaveList
															relay "all other" RILootObj:LoadAddedItems
															wait 5
															
															;Assign the loot
															LootWindow.ItemsPage.Child[${ChildrenCounter}]:LeftClick
															LootWindow.LeaderAssign:LeftClick
															wait 5
															relay "other ${RI_Var_String_RelayGroup}" LootWindow:RequestAll
															relay "other ${RI_Var_String_RelayGroup}" LootWindow:LootAll
															wait 5
															;relay "other ${RI_Var_String_RelayGroup}" LootWindow:Receive
															;set our counter over the break to end the for loop
															AILCounter:Set[${Math.Calc[${UIElement[AddedItemsListbox@RILoot].Items}+1]}]
														}
														else
														{
															AILCounter:Dec
															continue
														}
													}
												}
											}
										}
									}
								}
								while (${ChildrenCounter:Inc} < ${LootWindow.ItemsPage.NumChildren})
							}
							while ${FoundVar}>0
							
							;we did not see anything return and try again on next loop iteration
							if ${ChildrenCounter}==1 || ${FoundVar}>0
							{
								if ${RI_Var_Loot_Debug}
									echo Somethings not right: ChildrenCounter: ${ChildrenCounter}  FoundVar: ${FoundVar}
								
								noop
							}
							else
							{
								if ${RI_Var_Bool_LootDebug}
									echo ISXRI: Receiving from LootWindow, because we either had nothing to distribute via RILoot or already Distributed everything, main fuction in Buffer:RI
										
								;just loot the rest
								LootWindow:RequestAll
								LootWindow:LootAll
								;LootWindow:Receive
							}
							wait 5
						}
					}
				}
			}
			else
			{
				;if a chest exists within 8m radius and looting is on
				if ${RI_Var_Bool_Loot} || ( ${UIElement[SettingsLootingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLootChestsCheckBox@SettingsFrame@CombatBotUI].Checked} )
				{
					if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)} && !${RI_Var_Bool_Loot}
					{
						noop
					}
					else
					{
						if ${Actor[chest,radius,7](exists)}
						{
							if ${RI_Var_Bool_Debug}
								echo ISXRI: ${Time}: Looting ${Actor[chest,radius,7]} because Loot: ${RI_Var_Bool_Loot}
							
							if ${RI_Var_Bool_LootDebug}
								echo ISXRI: Clicking Chest and Receiving from LootWindow, main fuction in Buffer:RI
							
							;doubleclick chest wait 2 then loot all
							Actor[chest,radius,7]:DoubleClick
							wait 2
							LootWindow:LootAll
						}
					}
				}
			}
		}
		if ${LootWindow(exists)} && !${_RI_LootImmunity_} && !${RI_Var_Bool_SkipLoot} 
		{
			if ${UIElement[SettingsAcceptLootCheckBox@SettingsFrame@CombatBotUI].Checked} || ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
			{
				if ${UIElement[AddedItemsListbox@RILoot].Items}>0 && ${UIElement[RILootOnCheckbox@RILoot].Checked} && ${Me.Group}>1 && ( ${Me.Group[2].Type.NotEqual[Mercenary]} || ${Me.Group}>2 ) && ${Actor[Exquisite Chest,radius,7](exists)}
				{
					noop
				}
				elseif ${Script[${RI_Var_String_RunInstancesScriptName}](exists)} && !${RI_Var_Bool_AcceptLoot}
				{
					noop
				}
				else
				{
					if ${RI_Var_Bool_LootDebug}
						echo ISXRI: Receiving from LootWindow, main fuction in Buffer:RI
					LootWindow:RequestAll
					_RI_LootImmunity_:Set[TRUE]
					TimedCommand 5 _RI_LootImmunity_:Set[FALSE]
				}
			}
		}
		;wait 1 ${MT} || ${JU} || ${QueuedCommands} || ${FactionsInit} || ${CommandQ} || ${TradePending} || ${RaidGroupHudLoaded} || ${NearesetNPCHudLoaded} || ${NearesetPlayerHudLoaded} || ${CurrentZoneName.NotEqual["${Zone.Name}"]}
		if ${RIFP}
			call RIFollowPop ${PopForWho}
		if ${RILSP}
			call RILockSpotPop ${PopForWho}
		if ${ASSP}
			call AssistPop ${PopForWho}
		if ${DOORP}
			call DoorPop ${PopForWho}
		if ${TMP}
			call TravelMapPop ${PopForWho}
		if ${FaTrP}
			call FastTravelPop ${PopForWho}
		if ${JU}
		{
			RIMUIObj:StopMove[ALL]
			call RIMObj.JumpUp ${JUX} ${JUY} ${JUZ} ${JUYT} ${JUFD} ${JUGUC}
			JU:Set[FALSE]
		}
		if ${MT}
		{
			call RIMObj.Move ${MTX} ${MTY} ${MTZ} ${MTP}
			MT:Set[FALSE]
		}
		if ${FactionsInit}
		{
			call RIMUIObj.InitializeFactions "${FactionsPass}"
			FactionsInit:Set[FALSE]
			FactionsPass:Set[NONE]
		}
		if ${LoadRIMUI}
		{
			call LoadRIMUI
			LoadRIMUI:Set[FALSE]
			CommandQ:Set[FALSE]
		}
		if ${TradePending}
		{
			if ${RI_Var_Bool_AcceptTrades}
			{
				if ${TradeAccepted}
					EQ2UIPage[Inventory,Trade].Child[button,buttonAccept]:LeftClick
			}
			elseif !${IStartedTrade}
				EQ2UIPage[Inventory,Trade].Child[button,buttonReject]:LeftClick
				
		}
		if ${RaidGroupHudLoaded}
			UpdateDistanceHud
		if ${NearesetNPCHudLoaded}
			UpdateNNHud
		if ${NearesetPlayerHudLoaded}
			UpdateNPHud
		wait 2
	}
}
atom EQ2_FinishedZoning(string TimeInSeconds)
{
	RI_Var_IndexInt_InvalidChest:Clear
	RI_Var_IndexInt_InvalidShiny:Clear
}
;atom triggered when a loot window is detected
atom EQ2_onLootWindowAppeared(string LootWindowID)
{
	if ( ${UIElement[SettingsAcceptLootCheckBox@SettingsFrame@CombatBotUI].Checked} || ${Script[${RI_Var_String_RunInstancesScriptName}](exists)} ) && !${_RI_LootImmunity_} && !${RI_Var_Bool_SkipLoot}
	;&& ${CurrentLootWindowID.NotEqual[${LootWindowID}]}
	{
		if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)} && ( !${RI_Var_Bool_AcceptLoot} || ( ${UIElement[AddedItemsListbox@RILoot].Items}>0 && ${Me.IsGroupLeader} && ( ${Actor[Exquisite Chest,radius,7](exists)} || ${Actor[Gaukr Sandstorm's Treasure,radius,7](exists)} || ${Actor[Hreidar Lynhillig's Treasure,radius,7](exists)} ) && ${UIElement[RILootOnCheckbox@RILoot].Checked} && ${Me.Group}>1 && ( ${Me.Group[2].Type.NotEqual[Mercenary]} || ${Me.Group}>2 ) ) )
		{
			noop
		}
		else
		{
			if ${RI_Var_Bool_LootDebug}
				echo ISXRI: Receiving from LootWindow, atom EQ2_onLootWindowAppeared(string LootWindowID)
			_RI_LootImmunity_:Set[TRUE]
			TimedCommand 5 _RI_LootImmunity_:Set[FALSE]
			;CurrentLootWindowID:Set[${LootWindowID}]
			;LootWindow[${LootWindowID}]:LootAll
			LootWindow[${LootWindowID}]:RequestAll
		}
	}
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["Not a valid chest to summon!"](exists)} || ${Text.Find["There are no chests in range for you to summon"](exists)} || ${Text.Find["This treasure chest is locked and you do not have a key"](exists)}
	{
		RI_Var_Bool_BadChestTrigger:Set[1]
	}
	if ${Text.Find["You already have"](exists)} && ${Text.Find["Spirit of the Cat"](exists)} && ${Zone.Name.Find["Fordel Midst: Bizarre Bazaar [Solo]"]}
	{
		RI_Var_Bool_BadChestTrigger:Set[1]
	}
	if ( !${Script[Buffer:CombatBot](exists)} || ${UIElement[SettingsAcceptTradesCheckBox@SettingsFrame@CombatBotUI].Checked} )
	{
		if ${Text.Find["You start a trade with"](exists)} 
		{
			TradePending:Set[TRUE]
			IStartedTrade:Set[TRUE]
		}
		if ${Text.Find["has started a trade with you"](exists)}
			TradePending:Set[TRUE]
		if ${Text.Find["has accepted the trade"](exists)} && ${TradePending}
			TradeAccepted:Set[TRUE]
		if ${Text.Find["has canceled the trade"](exists)}
		{
			TradePending:Set[FALSE]
			TradeAccepted:Set[FALSE]
			IStartedTrade:Set[FALSE]
		}
		if ${Text.Find["You cancel the trade"](exists)}
		{
			TradePending:Set[FALSE]
			TradeAccepted:Set[FALSE]
			IStartedTrade:Set[FALSE]
		}
		if ${Text.Find["You have accepted the trade"](exists)}
		{
			TradePending:Set[FALSE]
			TradeAccepted:Set[FALSE]
			IStartedTrade:Set[FALSE]
		}
		if ${Text.Upper.Find["TELLS YOU"](exists)} && ${Text.Upper.Find["INVITE"](exists)} && ${TANKSUCKS}
		{
			if !${Me.IsGroupLeader}
				return
			;echo ${Text.Find[invite]}
			;echo ${Math.Calc[-1*(${Text.Find[invite]})]}
			;echo ${Text}
			echo ISXRI: Inviting: ${Text.Right[${Math.Calc[-1*(${Text.Find[invite]}+6)]}].Replace[\",""]}
			eq2ex /invite ${Text.Right[${Math.Calc[-1*(${Text.Find[invite]}+6)]}].Replace[\",""]}
		}
		if ${Text.Upper.Find["TELLS YOU"](exists)} && ${Text.Upper.Find["RAIDINVITE"](exists)} && ${TANKSUCKS}
		{
			if !${Me.IsGroupLeader}
				return
			;echo ${Text.Find[raidinvite]}
			;echo ${Math.Calc[-1*(${Text.Find[raidinvite]})]}
			;echo ${Text}
			echo ISXRI: Raid Inviting: ${Text.Right[${Math.Calc[-1*(${Text.Find[raidinvite]}+10)]}].Replace[\",""]}
			eq2ex /raidinvite ${Text.Right[${Math.Calc[-1*(${Text.Find[raidinvite]}+10)]}].Replace[\",""]}
		}
	}
}
;atom triggered when ChoiceWindow is detected
atom(script) EQ2_onChoiceWindowAppeared()
{
	if ${ChoiceWindow.Text.GetProperty[Text].Find[cast]} && ${Me.Health}<1 && ${UIElement[SettingsAcceptRessesCheckBox@SettingsFrame@CombatBotUI].Checked}
	;( !${Script[Buffer:CombatBot](exists)} ||  )
	{
		ChoiceWindow:DoChoice1
	}
	;put code in here to search through richarlist.xml
	if ${EQ2.ServerName.NotEqual[Battlegrounds]} && ${ChoiceWindow.Text.GetProperty[Text].Find["has invited you to join a"]} && ${UIElement[SettingsAcceptInvitesCheckBox@SettingsFrame@CombatBotUI].Checked}
	;( !${Script[Buffer:CombatBot](exists)} || ${UIElement[SettingsAcceptInvitesCheckBox@SettingsFrame@CombatBotUI].Checked} )
	{
		ChoiceWindow:DoChoice1
	}
	if ${ChoiceWindow.Text.GetProperty[Text].Find["would you like to teleport to"]}
	{
		ChoiceWindow:DoChoice1
	}
	if ${ChoiceWindow.Text.GetProperty[Text].Find["would you like to loot"]} && ( !${Script[Buffer:CombatBot](exists)} || ${UIElement[SettingsAcceptLootCheckBox@SettingsFrame@CombatBotUI].Checked} || ( ${Script[${RI_Var_String_RunInstancesScriptName}](exists)} && ${RI_Var_Bool_Loot} ) )
	{
		ChoiceWindow:DoChoice1
	}
}
atom EQ2_onQuestOffered(string Name, string Description, int Level, int StatusReward)
{
	if ${Script[${RI_Var_String_CombatBotScriptName}](exists)} || ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
	{
		if ${RI_Var_Bool_AcceptRewards}
			TimedCommand 3 RewardWindow:AcceptReward
		;TimedCommand 3 RewardWindow:Accept
		TimedCommand 5 EQ2:AcceptPendingQuest
	}
}
;RILoot Object
objectdef RILootObject
{
	method LoadRILootOn()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[RILootSet]:Clear
			LavishSettings:AddSet[RILootSet]
			LavishSettings[RILootSet]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[RILootSet].GUID}]
			if ${RILootSet.FindSetting[RILootOn]}
				UIElement[RILootOnCheckbox@RILoot]:SetChecked
			else
				UIElement[RILootOnCheckbox@RILoot]:UnsetChecked
		}
	}
	method SaveRILootOn()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[RILootSet]:Clear
			LavishSettings:AddSet[RILootSet]
			LavishSettings[RILootSet]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[RILootSet].GUID}]
			LavishSettings[RILootSet]:AddSetting[RILootOn,${UIElement[RILootOnCheckbox@RILoot].Checked}]
			LavishSettings[RILootSet]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
		}
		if ${UIElement[RILootOnCheckbox@RILoot].Checked}
			relay "all other" UIElement[RILootOnCheckbox@RILoot]:SetChecked
		else
			relay "all other" UIElement[RILootOnCheckbox@RILoot]:UnsetChecked
	}
	method AssignLoot()
	{
		LootWindow.LeaderAssign:LeftClick
	}
	method SelectItem(string _ItemName)
	{
		noop ${This.SelectItem["${_ItemName}"]}
	}
	member:bool SelectItem(string _ItemName)
	{
		variable int _cnt
		for(_cnt:Set[1];${_cnt}<${LootWindow.ItemsPage.NumChildren};_cnt:Inc)
		{
			;; We are only interested in the members of Type Text and this will be what we need to click
			if (${LootWindow.ItemsPage.Child[${_cnt}].Type.Find[Text]})
			{
				;; We ignore the static member table entry as it is never an item
				if ${LootWindow.ItemsPage.Child[${_cnt}].GetProperty[LocalText].Equals[table entry]}
					continue
				
				if ${RI_Var_Bool_LootDebug}				
					echo Checking #${_cnt} of ${LootWindow.ItemsPage.NumChildren}: ${LootWindow.ItemsPage.Child[${_cnt}].GetProperty[LocalText]} == ${_ItemName}
					
				;if we find the Item of ChildCounter in our AddedItemsListbox
				if ${LootWindow.ItemsPage.Child[${_cnt}].GetProperty[LocalText].Find["${_ItemName}"](exists)}
				{
					LootWindow.ItemsPage.Child[${_cnt}]:LeftClick
					return TRUE
				}
			}
		}
		return FALSE
	}
	method SetGroupMember(string _Name)
	{
		noop ${This.SetGroupMember["${_Name}"]}
	}
	member:bool SetGroupMember(string _Name)
	{
		variable index:collection:string GroupMembers
		variable iterator GroupMembersIterator
		variable int GroupMembersCounter = 0
		
		LootWindow.GroupMembers:GetOptions[GroupMembers]
		GroupMembers:GetIterator[GroupMembersIterator]
		
		if (${GroupMembersIterator:First(exists)})
		{
			do
			{
				if (${GroupMembersIterator.Value.FirstKey(exists)})
				{
					do
					{
						;echo ${GroupMembersIterator.Value.CurrentKey.Equal[text]} && ${GroupMembersIterator.Value.CurrentValue.Equal[${_Name}]}
						if ${GroupMembersIterator.Value.CurrentKey.Equal[text]} && ${GroupMembersIterator.Value.CurrentValue.Equal[${_Name}]}
						{
							LootWindow.GroupMembers:Set[${GroupMembersCounter}]
							return TRUE
						}
					}
					while ${GroupMembersIterator.Value.NextKey(exists)}
				}
				GroupMembersCounter:Inc
			}
			while ${GroupMembersIterator:Next(exists)}
		}
		return FALSE
	}
	variable settingsetref RILootSet
	method Hide()
	{
		if ${UIElement[RILoot](exists)}
			UIElement[RILoot]:Hide
	}
	method Show()
	{
		if ${UIElement[RILoot](exists)}
			UIElement[RILoot]:Show
	}
	method LoadToonList()
	{
		LavishSettings[RILoot]:Clear
		LavishSettings:AddSet[RILoot]
		LavishSettings[RILoot]:Import["${LavishScript.HomeDirectory}/Scripts/RI/Private/RICharList.xml"]
		variable settingsetref Set2
		Set2:Set[${LavishSettings[RILoot].GUID}]

		variable settingsetref Set3
		
		variable iterator Iterator
		variable iterator Iterator2
		Set2:GetSetIterator[Iterator]
		
		if ${Iterator:First(exists)}
		{
			do
			{
				Set3:Set[${Set2.FindSet[${Iterator.Key}].GUID}]
				Set3:GetSetIterator[Iterator2]

				if ${Iterator2:First(exists)}
				{
					do
					{
						;;echo ${Iterator2.Key} // ${Iterator2.Value}
						UIElement[ToonsListbox@RILoot]:AddItem["${Iterator2.Key}"]
					}
					while ${Iterator2:Next(exists)}
				}
			}
			while ${Iterator:Next(exists)}
		}
	}
	method LoadItems()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			LavishSettings[ItemsList]:Clear
			LavishSettings:AddSet[ItemsList]
			LavishSettings[ItemsList]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[ItemsList].GUID}]

			variable settingsetref LoadListSet=${RILootSet.FindSet[ItemsList].GUID}
			LoadListSet:Set[${RILootSet.FindSet[ItemsList].GUID}]
			
			variable iterator SettingIterator
			LoadListSet:GetSettingIterator[SettingIterator]
			if ${SettingIterator:First(exists)}
			{
				do
				{
					;;echo "${SettingIterator.Key}=${SettingIterator.Value}"
					UIElement[ItemsListbox@RILoot]:AddItem["${SettingIterator.Key}"]
				}
				while ${SettingIterator:Next(exists)}
			}
		}
	}
	method LoadAddedItems()
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/"]
		if ${FP.FileExists[RILootSave.xml]}
		{
			UIElement[AddedItemsListbox@RILoot]:ClearItems
			LavishSettings[AddedItemsList]:Clear
			LavishSettings:AddSet[AddedItemsList]
			LavishSettings[AddedItemsList]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
			RILootSet:Set[${LavishSettings[AddedItemsList].GUID}]

			variable settingsetref LoadListSet=${RILootSet.FindSet[AddedItemsList].GUID}
			LoadListSet:Set[${RILootSet.FindSet[AddedItemsList].GUID}]
			
			variable iterator SettingIterator
			LoadListSet:GetSettingIterator[SettingIterator]
			if ${SettingIterator:First(exists)}
			{
				do
				{
					;echo "${SettingIterator.Key}=${SettingIterator.Value}"
					UIElement[AddedItemsListbox@RILoot]:AddItem["${SettingIterator.Key}"]
				}
				while ${SettingIterator:Next(exists)}
			}
		}
	}
	method ItemsListboxLeftClick()
	{
		if ${UIElement[ItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[ItemTextEntry@RILoot]:SetText["${UIElement[ItemsListbox@RILoot].SelectedItem}"]
		}
	}
	method ItemsListboxRightClick()
	{
		if ${UIElement[ItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[ItemsListbox@RILoot]:RemoveItem[${UIElement[ItemsListbox@RILoot].SelectedItem.ID}]
			This:SaveItems
			This:Clear
			relay "all other" RILootObj:LoadItems
		}
	}
	method ToonsListboxLeftClick()
	{
		if ${UIElement[ToonsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[GroupTextEntry@RILoot]:SetText[${UIElement[ToonsListbox@RILoot].SelectedItem}]
		}
	}
	method AddedItemsListboxLeftClick()
	{
		if ${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[AddButton@RILoot]:SetText[Edit]
			UIElement[ItemTextEntry@RILoot]:SetText[${UIElement["AddedItemsListbox@RILoot].SelectedItem.Text.Token[1,|]}"]
			UIElement[GroupTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[2,|]}]
			UIElement[QuantityTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[3,|]}]
			UIElement[LootedTextEntry@RILoot]:SetText[${UIElement[AddedItemsListbox@RILoot].SelectedItem.Text.Token[4,|]}]
		}
		else
		{
			This:Clear
		}
	}
	method AddedItemsListboxRightClick()
	{
		if ${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID(exists)}
		{
			UIElement[AddedItemsListbox@RILoot]:RemoveItem[${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID}]
			This:SaveList
			This:Clear
			relay "all other" RILootObj:LoadAddedItems
		}
	}
	method Group(int _GroupOnly)
	{
		if ${_GroupOnly}==1
		{
			UIElement[AllToonsCheckBox@RILoot]:UnsetChecked
			UIElement[GroupOnlyCheckBox@RILoot]:SetChecked
			UIElement[ToonsListbox@RILoot]:ClearItems
			variable int i=0
			if ${Me.Name(exists)}
				UIElement[ToonsListbox@RILoot]:AddItem[${Me.Name}]
			for(i:Set[1];${i}<${Me.Group};i:Inc)
				UIElement[ToonsListbox@RILoot]:AddItem[${Me.Group[${i}].Name}]
		}
		else
		{	
			UIElement[GroupOnlyCheckBox@RILoot]:UnsetChecked
			UIElement[AllToonsCheckBox@RILoot]:SetChecked
			UIElement[ToonsListbox@RILoot]:ClearItems
			This:LoadToonList
		}
	}
	;need to add code that IF the Item does not exist in our ItemsListBox to Add it and save to file.
	method Add()
	{
		if ${UIElement[ItemTextEntry@RILoot].Text.NotEqual[NULL]} && ${UIElement[ItemTextEntry@RILoot].Text.NotEqual[""]} && ${UIElement[GroupTextEntry@RILoot].Text.NotEqual[NULL]} && ${UIElement[GroupTextEntry@RILoot].Text.NotEqual[""]}
		{
			if ${UIElement[QuantityTextEntry@RILoot].Text.Equal[NULL]} || ${UIElement[QuantityTextEntry@RILoot].Text.Equal[""]} || ${Int[${UIElement[QuantityTextEntry@RILoot].Text}]}==0
			{
				UIElement[QuantityTextEntry@RILoot]:SetText[~]
			}
			else
			{
				UIElement[QuantityTextEntry@RILoot]:SetText[${Int[${UIElement[QuantityTextEntry@RILoot].Text}]}]
			}
			if ${UIElement[LootedTextEntry@RILoot].Text.Equal[NULL]} || ${UIElement[LootedTextEntry@RILoot].Text.Equal[""]}
			{
				UIElement[LootedTextEntry@RILoot]:SetText[0]
			}
			else
			{
				UIElement[LootedTextEntry@RILoot]:SetText[${Int[${UIElement[LootedTextEntry@RILoot].Text}]}]
			}
			if ${UIElement[AddedItemsListbox@RILoot].SelectedItem.ID(exists)}
				UIElement[AddedItemsListbox@RILoot].SelectedItem:SetText["${UIElement[ItemTextEntry@RILoot].Text}|${UIElement[GroupTextEntry@RILoot].Text}|${UIElement[QuantityTextEntry@RILoot].Text}|${UIElement[LootedTextEntry@RILoot].Text}"]
			else
			{
				variable int cnt=0
				variable bool DNE=TRUE
				variable bool IE=FALSE
				for(cnt:Set[0];${cnt}<=${UIElement[ItemsListbox@RILoot].Items};cnt:Inc)
				{
					if ${UIElement[ItemsListbox@RILoot].OrderedItem[${cnt}].Text.Equal["${UIElement[ItemTextEntry@RILoot].Text}"]}
					{
						IE:Set[TRUE]
					}
				}
				for(cnt:Set[0];${cnt}<=${UIElement[AddedItemsListbox@RILoot].Items};cnt:Inc)
				{
					if ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${cnt}].Text.Token[1,|].Equal["${UIElement[ItemTextEntry@RILoot].Text}"]} && ${UIElement[AddedItemsListbox@RILoot].OrderedItem[${cnt}].Text.Token[2,|].Equal["${UIElement[GroupTextEntry@RILoot].Text}"]}
					{
						UIElement[AddedItemsListbox@RILoot].OrderedItem[${cnt}]:SetText["${UIElement[ItemTextEntry@RILoot].Text}|${UIElement[GroupTextEntry@RILoot].Text}|${UIElement[QuantityTextEntry@RILoot].Text}|${UIElement[LootedTextEntry@RILoot].Text}"]
						DNE:Set[FALSE]
					}
				}
				if !${IE}
				{
					UIElement[ItemsListbox@RILoot]:AddItem["${UIElement[ItemTextEntry@RILoot].Text}"]
					This:SaveItems
					relay "all other" RILootObj:LoadItems
				}
				if ${DNE}
					UIElement[AddedItemsListbox@RILoot]:AddItem["${UIElement[ItemTextEntry@RILoot].Text}|${UIElement[GroupTextEntry@RILoot].Text}|${UIElement[QuantityTextEntry@RILoot].Text}|${UIElement[LootedTextEntry@RILoot].Text}"]
			}
			;UIElement[ItemTextEntry@RILoot]:SetText[""]
			UIElement[GroupTextEntry@RILoot]:SetText[""]
			;UIElement[QuantityTextEntry@RILoot]:SetText[""]
			UIElement[LootedTextEntry@RILoot]:SetText[0]
			UIElement[ItemsListbox@RILoot]:ClearSelection
			UIElement[ToonsListbox@RILoot]:ClearSelection
			UIElement[AddedItemsListbox@RILoot]:ClearSelection
			UIElement[AddButton@RILoot]:SetText[Add]
			UIElement[AddButton@RILoot]:SetFocus
			This:SaveList
			relay "all other" RILootObj:LoadAddedItems
		}
	}
	method Clear()
	{
		UIElement[ItemTextEntry@RILoot]:SetText[""]
		UIElement[GroupTextEntry@RILoot]:SetText[""]
		UIElement[QuantityTextEntry@RILoot]:SetText[""]
		UIElement[LootedTextEntry@RILoot]:SetText[0]
		UIElement[ItemsListbox@RILoot]:ClearSelection
		UIElement[ToonsListbox@RILoot]:ClearSelection
		UIElement[AddedItemsListbox@RILoot]:ClearSelection
		UIElement[AddButton@RILoot]:SetText[Add]
		UIElement[AddButton@RILoot]:SetFocus
	}
	method SaveList()
	{
		variable string SetName
		SetName:Set[AddedItemsList]
		LavishSettings[RILoot]:Clear
		LavishSettings:AddSet[RILoot]
		LavishSettings[RILoot]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
		LavishSettings[RILoot]:AddSet[${SetName}]
		LavishSettings[RILoot].FindSet[${SetName}]:Clear
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[AddedItemsListbox@RILoot].Items};count:Inc)
		{
			LavishSettings[RILoot].FindSet[${SetName}]:AddSetting["${UIElement[AddedItemsListbox@RILoot].OrderedItem[${count}].Text}",""]
		}
		LavishSettings[RILoot]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
	}
	method SaveItems()
	{
		variable string SetName
		SetName:Set[ItemsList]
		LavishSettings[RILoot]:Clear
		LavishSettings:AddSet[RILoot]
		LavishSettings[RILoot]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
		LavishSettings[RILoot]:AddSet[${SetName}]
		LavishSettings[RILoot].FindSet[${SetName}]:Clear
		variable int count=0
		for(count:Set[1];${count}<=${UIElement[ItemsListbox@RILoot].Items};count:Inc)
		{
			LavishSettings[RILoot].FindSet[${SetName}]:AddSetting["${UIElement[ItemsListbox@RILoot].OrderedItem[${count}].Text}",""]
		}
		LavishSettings[RILoot]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RILoot/RILootSave.xml"]
	}
}
objectdef RIMovementObject
{
	variable int TempX
	variable int TempY
	variable int TempZ
	variable bool IGFollow=FALSE
	variable bool SFollow=TRUE
	variable bool WaitForLootCorpses=TRUE
	
	function JumpUp(float _X, float _Y, float _Z, float _YTarget, int _FaceDegree, int _GiveUpCNT=10)
	{	
		variable int _Cnt=0
		while ${Me.Y}<${_YTarget} && ${_Cnt:Inc}<=${_GiveUpCNT}
		{
			RI_Var_Bool_Follow:Set[0]
			if ${Math.Distance[${Me.Loc},${_X},${_Y},${_Z}]}>3
				call This.Move ${_X} ${_Y} ${_Z} 1 0 1 1 1 0 1 1
			press -hold ${RI_Var_String_BackwardKey}
			waitframe
			waitframe
			press -release ${RI_Var_String_BackwardKey}
			Face ${_FaceDegree}
			wait 2
			;jump part
			press ${RI_Var_String_JumpKey}
			wait 5 ${Me.Y}>${_YTarget}
			press -hold ${RI_Var_String_ForwardKey}
			wait 3
			press -release ${RI_Var_String_ForwardKey}
			RI_Var_Bool_Follow:Set[1]
			;wait 10
		}
	}
	function JumpOver(float _X, float _Y, float _Z, int _FaceDegree)
	{	
		;variable int _Cnt=0
		;while ${Me.Y}<${_YTarget} && ${_Cnt:Inc}<=${_GiveUpCNT}
		;{
			if ${Math.Distance[${Me.Loc},${_X},${_Y},${_Z}]}>3
				call This.Move ${_X} ${_Y} ${_Z} 1 0 1 1 1 0 1 1
			press -hold ${RI_Var_String_BackwardKey}
			waitframe
			waitframe
			press -release ${RI_Var_String_BackwardKey}
			Face ${_FaceDegree}
			wait 2
			;jump part
			press ${RI_Var_String_JumpKey}
			wait 1
			;${Me.Y}>${_YTarget}
			press -hold ${RI_Var_String_ForwardKey}
			wait 3
			press -release ${RI_Var_String_ForwardKey}
			;wait 10
		;}
	}
	function FlyDown(bool _AllToons=TRUE)
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting FlyDown
		if ${_AllToons}
		{
			if !${RI_Var_Bool_GlobalOthers}
			{
				relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RIScriptName}]:QueueCommand["call RIMObj.FlyDown 0"]
				wait 5
			}
		}
		;while we and the rest of our group are flying, relay press x
		press -release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_FlyUpKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_FlyUpKey}
		press -hold ${RI_Var_String_FlyDownKey}
		press -release ${RI_Var_String_FlyUpKey}
		while (${Me.FlyingUsingMount})
		{
			press -hold ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_FlyUpKey}
			;check if we are paused
			call This.CheckPause
			wait 2
		}
		wait 10
		press -release ${RI_Var_String_FlyDownKey}
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending FlyDown
	}
	function CheckCombat(bool FollowAfter=TRUE)
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting CheckCombat
		variable bool _IWasFlying=FALSE
		if (${Me.InCombat} || ${Me.IsHated}) && ${RI_Var_Bool_Start} && !${RI_Var_Bool_GlobalOthers}
		{
			RI_Var_Bool_Moving:Set[0]
			;check if we are paused
			;call CheckPause
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Waiting while we fight!
			;turn on auto attack
			if !${Me.AutoAttackOn}
				eq2execute autoattack 1
			;stop moving
			if ${Me.FlyingUsingMount}
				call This.StopAutoRun
			else
				press -release ${RI_Var_String_ForwardKey}
			press -release x
			press -release space
			;fly down
			if ${Me.FlyingUsingMount}
			{
				press -release ${RI_Var_String_FlyUpKey}
				_IWasFlying:Set[TRUE]
				call This.FlyDown
			}
			;stop follow
			call This.stopfollow
			;if set to lockforcombat, set it
			if (${Me.InCombat} || ${Me.IsHated})
				relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z},${Precision},1000]
				;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot ALL ${Me.X} ${Me.Y} ${Me.Z} ${Precision} 100
			;clear target incase we are targeting a ?
			if ${Target.Name.Equal[?]}
				eq2ex target_none
			while ( ${Me.InCombat} || ${Me.IsHated} ) && ${RI_Var_Bool_Start}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Waiting while we fight!
				;check if we are paused
				;call CheckPause
				;execute queued commands
				
				;balance mobs
				RIObj:BalanceMobs[ALL]
				
				call This.ExecuteQueued
				
				if ${Zone.Name.Find[Ward of Chaos Elements](exists)}
				{
					if ${Me.Inventory["Icecrete Shield"].TimeUntilReady}==-1
					{
						RI_CMD_PauseCombatBots 1
						eq2ex cancel_spellcast
						wait 2
						Me.Inventory["Icecrete Shield"]:Use
						wait 10
						RI_CMD_PauseCombatBots 0
					}
				}
				if ${Zone.Name.Find["Castle Vacrul: Rosy Reverie"]}
				{
					if ${Actor[Query, Name=="bloodrose bouquet" && Distance<=12 && IsDead=FALSE](exists)} && ${RIMUIObj.MainIconIDExists[${Me.ID},476]}>0
					{
						Actor[Query, Name=="bloodrose bouquet" && Distance<=12 && IsDead=FALSE]:DoTarget
						return
					}
				}
				wait 1
			}
			;end lockspot
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot OFF
			if ${WaitForLootCorpses}
				wait 2
			;follow
			if ${FollowAfter}
				call This.follow
			if ${_IWasFlying}
			{
				press -hold ${RI_Var_String_FlyUpKey}
				wait 1
				press -release ${RI_Var_String_FlyUpKey}
				_IWasFlying:Set[FALSE]
			}
		}
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending CheckCombat
	}
	
	function follow()
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Starting Follow!
		;if ${IGFollow} && !${RI_Var_Bool_GlobalOthers}
		;	relay "other ${RI_Var_String_RelayGroup}" -noredirect eq2execute follow ${Me.Name}
		;else ${SFollow} && 
		if !${RI_Var_Bool_GlobalOthers}
		{
			; if ${ISXOgre(exists)}
				; relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom a_QueueCommand DoNotMove
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot OFF
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},2,100]
			;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetRIFollow ALL ${Me.ID} ${Distance} 100
		}
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending Follow!
	}
	function stopfollow()
	{	
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Starting StopFollow
		wait 2
		relay "other ${RI_Var_String_RelayGroup}" -noredirect eq2execute stopfollow
		relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[OFF]
		;relay "other ${RI_Var_String_RelayGroup}" -noredirect RI_Atom_SetRIFollow OFF
		
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending StopFollow
	}
	function LootChest()
	{
		;IncomingText:Clear
		;IncomingText:Insert[Not a valid chest to summon!]
		;IncomingText:Insert[There are no chests in range for you to summon]
		variable int LONLCnt=0
		
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Checking For Chests within 100 Radius
		;if we find a chest and can run to it, do so and loot
		
		if ${Actor["Auliffe Chaoswind's Treasure",radius,100].Name.EqualCS["Auliffe Chaoswind's Treasure"]} && ${Math.Distance[${Actor["Auliffe Chaoswind's Treasure",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor["Gaukr Sandstorm's Treasure",radius,100].Name.EqualCS["Gaukr Sandstorm's Treasure"]} && ${Math.Distance[${Actor["Gaukr Sandstorm's Treasure",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor["Hreidar Lynhillig's Treasure",radius,100].Name.EqualCS["Hreidar Lynhillig's Treasure"]} && ${Math.Distance[${Actor["Hreidar Lynhillig's Treasure",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor["Yveti Stormbrood's Treasure",radius,100].Name.EqualCS["Yveti Stormbrood's Treasure"]} && ${Math.Distance[${Actor["Yveti Stormbrood's Treasure",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor["Treasure Chest",radius,100].Name.EqualCS["Treasure Chest"]} && ${Math.Distance[${Actor["Treasure Chest",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor["Gooey Hoard",radius,100].Name.EqualCS["Gooey Hoard"]} && ${Math.Distance[${Actor["Gooey Hoard Chest",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor[Chest,radius,100](exists)} && ( ${Me.WaterDepth}==0 || !${Me.IsSwimming} ) && !${Me.FlyingUsingMount}
		;&& !${Me.CheckCollision[${Actor[Chest].X},${Actor[Chest].Z}]}
		{
			;chest's id
			variable int ChestID=${Actor[Chest,radius,100].ID}
			variable int cnt=0
			
			if ${RI_Var_Loot_Debug}
				echo ISXRI: Found Chest ${ChestID}:${Actor[Chest,radius,100].Name} at ${Actor[Chest,radius,100].Distance}
			
			;if ChestID is 0 leave function
			if ${ChestID}==0 || ${RIMUIObj.InvalidChestCheck[${ChestID}]}
			{
				if ${RI_Var_Loot_Debug}
					echo ISXRI: Chest ${ChestID}:${Actor[Chest,radius,100].Name} at ${Actor[Chest,radius,100].Distance} is BAD leaving function
				return
			}
			RI_Var_Bool_Moving:Set[0]
			;stop moving
			press -release ${RI_Var_String_ForwardKey}

			
			if ${RI_Var_Bool_Loot}
			{
				;first try to summon chest, if we are not flying, and chest is more than 7m away
				if !${Me.FlyingUsingMount} && ${Math.Distance[${Me.Loc},${Actor[${ChestID}].Loc}]}>7
				{
					eq2ex apply_verb ${ChestID} Summon
					eq2ex summon ${ChestID}
					;for some odd reason in some instances there will be a chest up but the game will not let us summon it, 
					;this makes this wait cause a stutter in our movement, until i can find out why im removing the wait
					;but we need this or it will not summon as we are moving
					wait 10
					if ${RI_Var_Bool_BadChestTrigger} && ${RI_Var_Int_BadChestCnt:Inc}>5
					{
						if ${RI_Var_Loot_Debug}
							echo ISXRI: Chest ${ChestID}:${Actor[Chest,radius,100].Name} at ${Actor[Chest,radius,100].Distance} is BAD Adding it to our InvalidChest Index which has ${RI_Var_IndexInt_InvalidChest.Used} chests in it.
						RI_Var_IndexInt_InvalidChest:Insert[${ChestID}]
						RI_Var_Bool_BadChestTrigger:Set[0]
						RI_Var_Int_BadChestCnt:Set[0]
						relay ${RI_Var_String_RelayGroup} RI_Var_Bool_SkipLoot:Set[0]
						return
					}
					else
					{
						RI_Var_Bool_BadChestTrigger:Set[0]
					}
					wait 10
				}
				if ${Actor["Auliffe Chaoswind's Treasure",radius,100].Name.EqualCS["Auliffe Chaoswind's Treasure"]} && ${Math.Distance[${Actor["Auliffe Chaoswind's Treasure",radius,100].Loc},${Me.Loc}]}>5
					return
				if ${Actor["Gaukr Sandstorm's Treasure",radius,100].Name.EqualCS["Gaukr Sandstorm's Treasure"]} && ${Math.Distance[${Actor["Gaukr Sandstorm's Treasure",radius,100].Loc},${Me.Loc}]}>5
					return
				if ${Actor["Hreidar Lynhillig's Treasure",radius,100].Name.EqualCS["Hreidar Lynhillig's Treasure"]} && ${Math.Distance[${Actor["Hreidar Lynhillig's Treasure",radius,100].Loc},${Me.Loc}]}>5
					return
				if ${Actor["Yveti Stormbrood's Treasure",radius,100].Name.EqualCS["Yveti Stormbrood's Treasure"]} && ${Math.Distance[${Actor["Yveti Stormbrood's Treasure",radius,100].Loc},${Me.Loc}]}>5
					return
				if ${Actor["Treasure Chest",radius,100].Name.EqualCS["Treasure Chest"]} && ${Math.Distance[${Actor["Treasure Chest",radius,100].Loc},${Me.Loc}]}>5
					return
				if ${Actor["Gooey Hoard",radius,100].Name.EqualCS["Gooey Hoard"]} && ${Math.Distance[${Actor["Gooey Hoard Chest",radius,100].Loc},${Me.Loc}]}>5
					return
				;if the chest is not within 7m, move to it
				if ${Actor[${ChestID}](exists)} && ${Actor[${ChestID}].Name.Find[Chest](exists)} && ${Math.Distance[${Me.Loc},${Actor[${ChestID}].Loc}]}>7 && !${RI_Var_Bool_QuestMode}
				{
					;set original loc
					TempX:Set[${Me.X}]
					TempY:Set[${Me.Y}]
					TempZ:Set[${Me.Z}]
					wait 5
					;if Ogre Exists clear Campspot
					; if ${ISXOgre(exists)}
						; relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom a_LetsGo all
					;dont move entire group to chest
					;relay "other ${RI_Var_String_RelayGroup}" -noredirect Script[${RI_Var_String_RunInstancesScriptName}]:QueueCommand["call Move ${Actor[Chest].X} ${Actor[Chest].Y} ${Actor[Chest].Z} 2 0 FALSE FALSE TRUE"]
					call This.Move ${Actor[Chest].X} ${Actor[Chest].Y} ${Actor[Chest].Z} ${Precision} 10 TRUE TRUE TRUE FALSE TRUE
					wait 10
					;fly down
					if ${Me.FlyingUsingMount}
						call This.FlyDown
					
					wait 10
					;move back to original loc
					call This.Move ${TempX} ${TempY} ${TempZ} ${Precision} 10 TRUE TRUE FALSE FALSE TRUE
				}
				;wait while lootwindow exists
				if ( ${LootWindow(exists)} || ${Actor[${ChestID}].Name.Find[Chest](exists)} ) && ${ChestID}!=0 && ${cnt:Inc}<600 && !${RI_Var_Bool_QuestMode} && ${UIElement[AddedItemsListbox@RILoot].Items}>0 && ${UIElement[RILootOnCheckbox@RILoot].Checked} && ( ${Actor[Exquisite Chest,radius,7](exists)} || ${Actor[Gaukr Sandstorm's Treasure,radius,7](exists)} || ${Actor[Hreidar Lynhillig's Treasure,radius,7](exists)} )
				{
					while ( ${LootWindow(exists)} || ${Actor[${ChestID}].Name.Find[Chest](exists)} ) && ${ChestID}!=0 && ${cnt:Inc}<600 && !${RI_Var_Bool_QuestMode} && ${UIElement[AddedItemsListbox@RILoot].Items}>0 && ${UIElement[RILootOnCheckbox@RILoot].Checked} && ( ${Actor[Exquisite Chest,radius,7](exists)} || ${Actor[Gaukr Sandstorm's Treasure,radius,7](exists)} || ${Actor[Hreidar Lynhillig's Treasure,radius,7](exists)} )
					{
						if ${RI_Var_Bool_LootDebug}
							echo ISXRI: ${cnt}: Waiting while ${Actor[${ChestID}].Name} with ID: ${ChestID} has Chest in the name (aka still exists): ${Actor[${ChestID}].Name.Find[Chest](exists)} or LootWindow is open: ${LootWindow(exists)} and our QuestMode is: ${RI_Var_Bool_QuestMode}
						wait 1
					}
				}
				else
				{
					wait 50 ( !${Actor[${ChestID}].Name.Find[Chest](exists)} && !${LootWindow(exists)} ) || ${ChestID}!=0
				}
			}
			else
			{
				while ${Actor[Chest,radius,100](exists)}
					wait 1
			}
		}
		;if ${RI_Var_Bool_CheckLoot}
		;	relay ${RI_Var_String_RelayGroup} RI_Var_Bool_SkipLoot:Set[0]
		;wait 10
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending LootChest
	}
	member:bool LootItemsToNotAutoLootExists(index:string _LONL)
	{
		variable int _cnt
		variable int _cnt2
		variable bool _exists=FALSE
		for(_cnt:Set[1];${_cnt}<=${_LONL.Used};_cnt:Inc)
		{
			for(_cnt2:Set[1];${_cnt2}<=${LootWindow.NumItems};_cnt2:Inc)
			{
				if ${LootWindow.Item[${_cnt2}].Equal["${_LONL.Get[${_cnt}]}"]}
					_exists:Set[TRUE]
			}
		}
		return ${_exists}
	}
	function ExecuteQueued()
	{
		;execute queued commands
		if ${QueuedCommands}
		{
			ExecuteQueued
		}
	}
	function CheckPause()
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting CheckPause
		if ${RI_Var_Bool_Paused}
		{
			RI_Var_Bool_Moving:Set[0]
			if ${Me.FlyingUsingMount}
				call This.StopAutoRun
			else
				press -release ${RI_Var_String_ForwardKey}
			press -release ${RI_Var_String_StrafeLeftKey}
			press -release ${RI_Var_String_StrafeRightKey}
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
		}
		while ${RI_Var_Bool_Paused}
		{
			call This.ExecuteQueued
			wait 1
		}
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending CheckPause
	}
	function CheckShiny()
	{
		variable int _ClosestPoint
		variable int _failcntshiny=0
		variable int _combatshinycount
		;; need to do a couple things here in this order, 1 - if Shiny's X is more than 1.5 > than Me.X then face shiny and do jump up function, -- DONE
		;; 2 - record the amount of times this function is called (after the closest point return) on the same Shiny ID (use globalvar), if>5 then 
		;; add to ignore index (which we will reset everytime you zone like the chest index) -- DONE
		;;
		;; 3 - Add a stuck function independent of MoveFunction but in Collab with, so if we get stuck it will first try to jump and move forward,
		;; then strafe left, then strafe right if unsuccesful will add shiny to ignore (move will set a Global Shinystuck flag) that shiny function 
		;; will ignore on return to and then proceed back to original spot
		
		;; ALSO NOTE FOR STUCK FUNCTION IN RI, If we are stuck and cant recover we need to first set a global stuck var, then try the next 3-5 waypoints 
		;; see if we can recover via those if not then pause and popup RICOnsole w/ Message and Sound RICOnsole ALARM
		
		;echo ${RIObj.ClosestPoint[${MainArrayCounter},"${Actor[?,radius,${ShinyScanDistance}].Loc}"]}!=${MainArrayCounter}
		;if ChestID is 0 leave function
		
		if ${RI_Var_Bool_ShinyDebug}
			echo ISXRI: ${Time}: Starting CheckShiny

		
		if ${RI_Var_Bool_ShinyDebug}
			echo Query: ${RI_Var_String_Query}

		while ${Actor[Query, ${RI_Var_String_Query} && Distance <= ${ShinyScanDistance}](exists)} && ${_failcntshiny:Inc}<5
		{	
			if ${Math.Distance[${Actor[Query, ${RI_Var_String_Query} && Distance <= ${ShinyScanDistance}].Y},${Me.Y}]}>9
				return
			;this is where we put ignore shinys that are retardedly placed gonna make it an index but this works for now
			if ( ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].X}==-123.940010 && ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].Y}==180.789993 && ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].Z}==-211.589996 ) || ( ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].X}==-131.169998 && ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].Y}==62.639999 && ${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].Z}==-397.750000 )
				RI_Var_Int_ShinyID:Set[0]
			else
				RI_Var_Int_ShinyID:Set[${Actor[Query, ${RI_Var_String_Query} && Distance<=${ShinyScanDistance}].ID}]

			_ClosestPoint:Set[${RIObj.ClosestPoint[${MainArrayCounter},"${Actor[id,${RI_Var_Int_ShinyID}].Loc}",${RI_Var_Int_ShinyClosestPointScanPoints}]}]

			if ${RI_Var_Bool_ShinyDebug}
				echo Shiny Found: ${Actor[id, ${RI_Var_Int_ShinyID}]}: ${Actor[id, ${RI_Var_Int_ShinyID}].ID} // ${RI_Var_Int_ShinyID} // ${Actor[id,${RI_Var_Int_ShinyID}].Loc} // ${_ClosestPoint}!=${MainArrayCounter} 

			if ${RI_Var_Int_ShinyID}==0 || ${RIMUIObj.InvalidShinyCheck[${RI_Var_Int_ShinyID}]}
			{
				if ${RI_Var_Bool_ShinyDebug}
					echo ISXRI: Shiny ${RI_Var_Int_ShinyID}:${Actor[id,${RI_Var_Int_ShinyID}].Name} at ${Actor[id,${RI_Var_Int_ShinyID}].Distance} is BAD leaving function
				return
			}
			if !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+1]},${Me.Z},${Actor[${RI_Var_Int_ShinyID}].X},${Math.Calc[${Actor[${RI_Var_Int_ShinyID}].Y}+1]},${Actor[${RI_Var_Int_ShinyID}].Z}]}
			{
				if ${_ClosestPoint}!=${MainArrayCounter}
				{
					if ${RI_Var_Bool_ShinyDebug}
						echo closest point doesnt match // ${_ClosestPoint}!=${MainArrayCounter}
					return
				}

				if ${RI_Var_Int_ShinyID}==${RI_Var_Int_LastShinyID}
				{
					RI_Var_Int_SameShinyCount:Inc
					if ${RI_Var_Int_SameShinyCount}>4
					{
						RI_Var_IndexInt_InvalidShiny:Insert[${RI_Var_Int_ShinyID}]
						return
					}
				}
				else
					RI_Var_Int_SameShinyCount:Set[0]
				RI_Var_Int_LastShinyID:Set[${RI_Var_Int_ShinyID}]
				GrabingShinys:Set[1]
				if ${Devel.Equal[TRUE]} && ${Actor[id,${RI_Var_Int_ShinyID}].Name.Equal["?"]} 
					RIMUIObj:LootOptions[ALL,RR]
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Shiny is close enough being ${Actor[${RI_Var_Int_ShinyID}].Distance}
				press -release ${RI_Var_String_ForwardKey}
				Actor[id,${RI_Var_Int_ShinyID}]:DoTarget
				wait 1
				if ${Me.TargetLOS} || ${Actor[id,${RI_Var_Int_ShinyID}].Name.NotEqual["?"]}
				{
					relay ${RI_Var_String_RelayGroup} RI_Var_Bool_SkipLoot:Set[1]
					LootWindow:Close
					wait 2
					LootWindow:Close
					if ${RI_Var_Bool_Debug}
						echo ${Time}: Shiny is in LOS
					wait 2
					TempX:Set[${Me.X}]
					TempY:Set[${Me.Y}]
					TempZ:Set[${Me.Z}]
					wait 5
					call This.follow
					call This.Move ${Actor[${RI_Var_Int_ShinyID}].X} ${Math.Calc[${Actor[${RI_Var_Int_ShinyID}].Y}+0.01]} ${Actor[${RI_Var_Int_ShinyID}].Z} ${RI_Var_Int_ShinyMoveDistance} 10 FALSE TRUE TRUE FALSE TRUE
					_combatshinycount:Set[0]
					for (_combatshinycount:Set[1];${_combatshinycount}<50;_combatshinycount:Inc)
					{
						if ${RI_Var_Bool_ShinyDebug}
							ISXRI ${Time}: Waiting for combat before shiny collection // _combatshinycount: ${_combatshinycount}
						call This.CheckCombat
						wait 1
					}
					;check our shinys Y position vs ours  /// need to edit to only enact if it detects cant see target
					if !${RI_Var_Bool_IgnoreShinyY}
					{
						if ${Actor[id,${RI_Var_Int_ShinyID}].Name.Equal["?"]} && ${Math.Distance[${Me.Y},${Actor[id,${RI_Var_Int_ShinyID}].Y}]}>1 && ${Actor[id,${RI_Var_Int_ShinyID}].Y}>${Me.Y}
						{
							Actor[id,${RI_Var_Int_ShinyID}]:DoFace
							wait 1
							relay ${RI_Var_String_RelayGroup} RIMUIObj:JumpUp[ALL,${Me.X},${Me.Y},${Me.Z},${Math.Calc[${Me.Y}+.2]},${Me.Heading},5]
							wait 100 ${RIMObj.AllGroupWithinRange[1.2]}
							for (_combatshinycount:Set[1];${_combatshinycount}<50;_combatshinycount:Inc)
							{
								if ${RI_Var_Bool_ShinyDebug}
									ISXRI ${Time}: Waiting for combat before shiny collection // _combatshinycount: ${_combatshinycount}
								call This.CheckCombat
								wait 1
							}
						}
					}
					;target shiney click it and lootall
					if ${RI_Var_Bool_WaitForShinys}
					{
						while ${Actor[id,${RI_Var_Int_ShinyID}](exists)}
							wait 50
					}
					else
					;if ${Developer}
					;{
						relay ${RI_Var_String_RelayGroup} -noredirect Actor[id,${RI_Var_Int_ShinyID}]:DoTarget
						waitframe
						relay ${RI_Var_String_RelayGroup} -noredirect Actor[id,${RI_Var_Int_ShinyID}]:DoubleClick
					;}
					;else
					;{
					;	Actor[id,${RI_Var_Int_ShinyID}]:DoTarget
					;	waitframe
					;	Actor[id,${RI_Var_Int_ShinyID}]:DoubleClick
					;}
					wait 10
					LootWindow:LootAll
					;wait 20
					wait 50
					;
					;;;;;
					if ${EQ2UIPage[Journals,JournalsQuest].IsVisible} && ${EQ2UIPage[Journals,JournalsQuest].Child[Page,TabPages].Child[2].IsEnabled}
					{	
						wait 5
						EQ2UIPage[Journals,JournalsQuest].Child[Page,TabPages].Child[2].Child[6].Child[2].Child[1].Child[1]:LeftClick
						wait 5
						EQ2UIPage[Journals,JournalsQuest].Child[Page,TabPages].Child[2].Child[6].Child[2].Child[1].Child[1]:LeftClick
						wait 5
						EQ2UIPage[Journals,JournalsQuest]:Close
					}
					relay ${RI_Var_String_RelayGroup} RI_Var_Bool_SkipLoot:Set[0]
					call This.Move ${TempX} ${TempY} ${TempZ} ${Precision} 10 TRUE TRUE TRUE FALSE TRUE
				}
				else
				{
					if ${RI_Var_Bool_Debug}
						echo ${Time}: Shiny not in LOS
					eq2ex target_none
				}
			}
		}
		GrabingShinys:Set[0]
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending CheckShiny
	}
	;checktoons function
	function checktoons()
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting CheckToons
	;
	;need to modify these to use for loops to do checks against ${Me.Group}  which is number in group so its not checking all 6 if u dont have 6
	;
	;
		variable bool IWasMB=FALSE
		variable bool IWasLS=FALSE
		variable bool _IStopped=FALSE
		if ${Me.Group}==1 || ${Me.GetGameData[Self.ZoneName].Label.Find["Solo]"](exists)}
			return
		if !${RI_Var_Bool_SkipCheckToons}
		{
			variable bool _AllHere
			_AllHere:Set[FALSE]
			
			variable int _count
			while !${_AllHere}
			{
				_AllHere:Set[TRUE]
				for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
				{
					if !${Me.Group[${_count}].Health(exists)} && ${Me.Group[${_count}].Type.NotEqual[Mercenary]} 
						_AllHere:Set[FALSE]
				}
				if !${_AllHere}
				{
					if ${RI_Var_Bool_MovingBehind}
					{
						IWasMB:Set[TRUE]
						RI_Var_Bool_MovingBehind:Set[FALSE]
					}
					if ${RI_Var_Bool_LockSpotting}
					{
						IWasLS:Set[TRUE]
						RI_Var_Bool_LockSpotting:Set[FALSE]
					}
					if !${_IStopped}
					{
						RI_Var_Bool_Moving:Set[0]
						if ${Me.FlyingUsingMount}
							call RIMObj.StopAutoRun
						else
							press -release ${RI_Var_String_ForwardKey}
						press -release ${RI_Var_String_StrafeLeftKey}
						press -release ${RI_Var_String_StrafeRightKey}
						press -release ${RI_Var_String_FlyUpKey}
						press -release ${RI_Var_String_FlyDownKey}
						_IStopped:Set[TRUE]
					}
					wait 10
				}
			}
		}
		if (${Me.Group[1].IsDead} || ${Me.Group[2].IsDead} || ${Me.Group[3].IsDead} || ${Me.Group[4].IsDead} || ${Me.Group[5].IsDead})
		{
			RI_Var_Bool_Moving:Set[0]
			if ${RI_Var_Bool_MovingBehind}
			{
				IWasMB:Set[TRUE]
				RI_Var_Bool_MovingBehind:Set[FALSE]
			}
			if ${RI_Var_Bool_LockSpotting}
			{
				IWasLS:Set[TRUE]
				RI_Var_Bool_LockSpotting:Set[FALSE]
			}
			if ${Me.FlyingUsingMount}
				call This.StopAutoRun
			else
				press -release ${RI_Var_String_ForwardKey}
			press -release ${RI_Var_String_StrafeLeftKey}
			press -release ${RI_Var_String_StrafeRightKey}
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
		}
		while (${Me.Group[1].IsDead} || ${Me.Group[2].IsDead} || ${Me.Group[3].IsDead} || ${Me.Group[4].IsDead} || ${Me.Group[5].IsDead})
			wait 10
		if ( ${Me.Group[1].Distance}>60 && ${Me.Group[1].Type.Equal[PC]} ) || ( ${Me.Group[2].Distance}>60 && ${Me.Group[2].Type.Equal[PC]} ) || ( ${Me.Group[3].Distance}>60 && ${Me.Group[3].Type.Equal[PC]} ) || ( ${Me.Group[4].Distance}>60 && ${Me.Group[4].Type.Equal[PC]} ) || ( ${Me.Group[5].Distance}>60 && ${Me.Group[5].Type.Equal[PC]} ) || ( ${Me.Group[1].IsRooted} && ${Me.Group[1].Type.Equal[PC]} ) || ( ${Me.Group[2].IsRooted} && ${Me.Group[2].Type.Equal[PC]} ) || ( ${Me.Group[3].IsRooted} && ${Me.Group[3].Type.Equal[PC]} ) || ( ${Me.Group[4].IsRooted} && ${Me.Group[4].Type.Equal[PC]} ) || ( ${Me.Group[5].IsRooted} && ${Me.Group[5].Type.Equal[PC]} )
		{
			RI_Var_Bool_Moving:Set[0]
			if ${Me.FlyingUsingMount}
			{
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
			}
			else
				press -release ${RI_Var_String_ForwardKey}
			press -release ${RI_Var_String_StrafeLeftKey}
			press -release ${RI_Var_String_StrafeRightKey}
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
		}
		while ( ${Me.Group[1].Distance}>60 && ${Me.Group[1].Type.Equal[PC]} ) || ( ${Me.Group[2].Distance}>60 && ${Me.Group[2].Type.Equal[PC]} ) || ( ${Me.Group[3].Distance}>60 && ${Me.Group[3].Type.Equal[PC]} ) || ( ${Me.Group[4].Distance}>60 && ${Me.Group[4].Type.Equal[PC]} ) || ( ${Me.Group[5].Distance}>60 && ${Me.Group[5].Type.Equal[PC]} ) || ( ${Me.Group[1].IsRooted} && ${Me.Group[1].Type.Equal[PC]} ) || ( ${Me.Group[2].IsRooted} && ${Me.Group[2].Type.Equal[PC]} ) || ( ${Me.Group[3].IsRooted} && ${Me.Group[3].Type.Equal[PC]} ) || ( ${Me.Group[4].IsRooted} && ${Me.Group[4].Type.Equal[PC]} ) || ( ${Me.Group[5].IsRooted} && ${Me.Group[5].Type.Equal[PC]} )
		{
			call This.follow
			wait 50
		}
		if ${IWasMB}
			RI_Var_Bool_MovingBehind:Set[TRUE]
		if ${IWasLS}
			RI_Var_Bool_LockSpotting:Set[TRUE]
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending CheckToons
	}
	function FrillikCheck()
	{
		if ${NotPastFirstSlaver}
		{
			if ${Actor[${GoodSlaver}].Distance}<6
			{
				RI_Var_Bool_PauseMovement:Set[TRUE]
			}
			else
			{	
				RI_Var_Bool_PauseMovement:Set[FALSE]
			}
		}
	}
	member(bool) AllGroupAlive(bool _UseRelayGroupSize=FALSE)
	{
		variable int _count
		variable bool _AllHere=TRUE
		if ${_UseRelayGroupSize}
		{
			for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
			{
				if ${Me.Group[${_count}].IsDead}
					_AllHere:Set[FALSE]
			}
		}
		else
		{
			for(_count:Set[1];${_count}<${Me.Group};_count:Inc)
			{
				if !${Me.Group[${_count}].IsDead(exists)}
					_AllHere:Set[FALSE]
			}
		}
		return ${_AllHere}
	}
	member(bool) AllGroupInZone(bool _UseRelayGroupSize=FALSE)
	{
		variable int _count
		variable bool _AllHere=TRUE
		if ${_UseRelayGroupSize}
		{
			for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
			{
				if !${Me.Group[${_count}].Health(exists)}
				;&& ${Me.Group[${_count}].Type.Equal[PC]}
					_AllHere:Set[FALSE]
			}
		}
		else
		{
			for(_count:Set[1];${_count}<${Me.Group};_count:Inc)
			{
				if !${Me.Group[${_count}].Health(exists)}
				;&& ${Me.Group[${_count}].Type.Equal[PC]}
					_AllHere:Set[FALSE]
			}
		}
		return ${_AllHere}
	}
	method BuildShinyQuery()
	{
		;here we need to build our query if there are any names added
		if ${RI_Var_IndexString_ShinyNames.Used}>0
		{
			RI_Var_String_Query:Set["( Name=-\"?\" "]
			for(declarevariable i int 1;${i}<=${RI_Var_IndexString_ShinyNames.Used};i:Inc)
			{
				RI_Var_String_Query:Concat[" ||  Name=-\"${RI_Var_IndexString_ShinyNames.Get[${i}]}\" "]
			}
			RI_Var_String_Query:Concat[")"]
		}
		else
			RI_Var_String_Query:Set["Name=-\"?\""]
	}
	member(bool) AllGroupWithinRange(float _Distance)
	{
		if ${EQ2.Zoning}
			return FALSE
		variable int _count
		variable bool _AllHere=TRUE
		for(_count:Set[1];${_count}<${RI_Var_Int_RelayGroupSize};_count:Inc)
		{
			if ( ${Me.Group[${_count}].Distance}>${_Distance} && ${Me.Group[${_count}].Type.Equal[PC]} ) || !${Me.Group[${_count}].Health(exists)}
				_AllHere:Set[FALSE]
		}
		return ${_AllHere}
	}
	function Move(float X1, float Y1, float Z1, int MPrecision=2, int PauseLength=0, bool ClearTarget=FALSE, bool StopForCombat=FALSE, bool SkipCheck=TRUE, bool KeepMoving=FALSE, bool UseRI_Var_String_ForwardKey=TRUE, bool SkipCollisionCheck=TRUE)
	{
		if ${X1}==0.000000 && ${Y1}==1.000000 && ${Z1}==0.000000
			return
		if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}>${RI_Var_Int_MoveMaxDistance}
		{
			if ${RI_Var_Bool_Debug}
				echo ISXRI: ${Time}: Moving : Unable to Move Our Distance to ${X1},${Y1},${Z1} is ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} which is greater than our max move distance: ${RI_Var_Int_MoveMaxDistance}
			if !${KeepMoving}
			{
				if ${RI_Var_Bool_Debug}
					echo ISXRI: Stoping Move since KeepMoving: ${KeepMoving}
				press -release ${RI_Var_String_FlyUpKey}
				press -release ${RI_Var_String_FlyDownKey}
				press -release ${RI_Var_String_ForwardKey}
				wait 1
				if ${Me.IsMoving}
				{
					press ${RI_Var_String_BackwardKey}
					press ${RI_Var_String_BackwardKey}
					press ${RI_Var_String_BackwardKey}
				}
			}
			wait 1
			return
		}
		variable string _Zone=${Zone.Name}
		variable int _Precision=${MPrecision}
		variable int _LastFaceTime=0
		variable int _LastChecksTime=0
		RIMUIObj:SetLockSpot[OFF]
		if ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) )
			MPrecision:Set[${Math.Calc[${_Precision}+2]}]
		else
			MPrecision:Set[${_Precision}]
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Moving : Move(float X1=${X1}, float Y1=${Y1}, float Z1=${Z1}, int MPrecision=${MPrecision}, int PauseLength=${PauseLength}, bool ClearTarget=${ClearTarget}, bool StopForCombat=${StopForCombat}, bool SkipCheck=${SkipCheck}, bool KeepMoving=${KeepMoving}, bool UseRI_Var_String_ForwardKey=${UseRI_Var_String_ForwardKey}=TRUE, bool SkipCollisionCheck=${SkipCollisionCheck}=FALSE)	
		if ${X1}==0 && ${Y1}==0 && ${Z1}==0
		{
			;echo ${Time}: Our movement position is 0,0,0, skipping, please check to make sure this is intended.
			return
		}
		if ${RI_Var_Bool_Debug}
			echo \${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}=${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<${RI_Var_Int_MoveMaxDistance} && ( Collision=${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}!${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${X1},${Math.Calc[${Y1}+2]},${Z1}]} || ${SkipCollisionCheck} || ${RI_Var_Bool_QuestMode} )
		if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<${RI_Var_Int_MoveMaxDistance} && ( !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${X1},${Math.Calc[${Y1}+2]},${Z1}]} || ${SkipCollisionCheck} || ${RI_Var_Bool_QuestMode} )
		{
			if ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>${MPrecision}
				Face ${X1} ${Z1}
			_LastFaceTime:Set[0]
			_LastChecksTime:Set[0]
			if !${SkipCheck} && !${RI_Var_Bool_GlobalOthers} && !${RI_Var_Bool_SkipLoot}
				call This.LootChest
			if ${RI_Var_Bool_Debug}
				echo In If Statement
			;pause a bit before each move
			wait ${PauseLength}
			if ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) )
			{
				;echo we are there lets stop flying up or down
				press -release ${RI_Var_String_FlyUpKey}
				press -release ${RI_Var_String_FlyDownKey}
				;wait 1
			}
			if ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) )
				MPrecision:Set[${Math.Calc[${_Precision}+1]}]
			else
				MPrecision:Set[${_Precision}]
			;check distance from my current x,z position vs the predetermined x,z positions
			;if larger than the precision move
			
			if ${RI_Var_Bool_Debug}
				echo ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>${MPrecision} && ${RI_Var_Bool_Start} && !${RI_Var_Bool_CancelMovement} && "${_Zone}" "${Zone.Name}" // ${_Zone.Equal["${Zone.Name}"]}
			while ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<${RI_Var_Int_MoveMaxDistance} && ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>${MPrecision} && ( ${RI_Var_Bool_Start} || !${Script[${RI_Var_String_RunInstancesScriptName}](exists)} ) && !${RI_Var_Bool_CancelMovement} && ${_Zone.Equal["${Zone.Name}"]}
			{
				RI_Var_Bool_Moving:Set[1]
				if ${RI_Var_Bool_Debug}
					echo ${Time}: We are at ${Me.X} ${Me.Y} ${Me.Z} which is ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} away from ${X1},${Y1},${Z1} and the precision is set to ${MPrecision}
				if ${EQ2.Zoning}!=0
				{
					RI_Var_Bool_Moving:Set[0]
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					press -release ${RI_Var_String_ForwardKey}
					wait 5
					continue
				}
				if ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) )
					MPrecision:Set[${Math.Calc[${_Precision}+1]}]
				else
					MPrecision:Set[${_Precision}]
				if ${Script.RunningTime}>${_LastChecksTime}
				{
					_LastChecksTime:Set[${Math.Calc[${Script.RunningTime}+500]}]
					;echo ${Time}: move checks
					if ${Zone.Name.Equal[The Frillik Tide]}
						call This.FrillikCheck
					;check toons
					if !${SkipCheck}
						call This.checktoons
					RI_Var_Bool_Moving:Set[1]
					;check if we are paused
					call This.CheckPause
					RI_Var_Bool_Moving:Set[1]
					;check if in combat
					if ${StopForCombat}
						call This.CheckCombat
					RI_Var_Bool_Moving:Set[1]
					;clear target while moving
					if ${Target(exists)} && ${ClearTarget} && !${RI_Var_Bool_GlobalOthers}
						eq2execute target_none
					;Follow
					if ${RI_Var_Bool_Follow} && !${RI_Var_Bool_GlobalOthers} && !(${Me.InCombat} || ${Me.IsHated})
						call This.follow
					if !${SkipCheck} && !${RI_Var_Bool_GlobalOthers} && !${RI_Var_Bool_SkipLoot}
						call This.LootChest
					RI_Var_Bool_Moving:Set[1]
				}
				;echo after checks
				;first check our height if farther than ${Precision} away press and hold space as long as we are flying
				;we need to get to the correct height for current position we are ${Math.Distance[${Me.Y},${YHeight}]} away
				;check if we are even flying at all, if not start flight
				;echo if !${Me.FlyingUsingMount} && ${Math.Distance[${Me.Y},${Y1}]}>20 && !${Me.InCombat} && !${RI_Var_Bool_PauseMovement}
				if !${Me.FlyingUsingMount} && ${Me.Y}<${Y1} && ${Math.Distance[${Me.Y},${Y1}]}>20 && !${Me.InCombat} && !${RI_Var_Bool_PauseMovement}
				{
					press -hold ${RI_Var_String_FlyUpKey}
					wait 1
					press -release ${RI_Var_String_FlyUpKey}
				}
				;echo now check if we are above or below desired height
				if ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}>${Y1} && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) ) && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -hold ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;echo above move up
				elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}<${Y1} && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) ) && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyDownKey}
					press -hold ${RI_Var_String_FlyUpKey}
					;wait 1
				}
				;echo below move down
				elseif ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) )
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;echo face x,y,z position and press autorun key if my heading is more than 1degree off of what its supposed to be  ${Math.Calc[${Me.Heading}-1]}<${Me.HeadingTo[${X1},${Me.Y},${Z1}]}<${Math.Calc[${Me.Heading}+1]}
				if ( ${Script.RunningTime}>${_LastFaceTime} || ${Math.Distance[${Me.Heading},${Me.HeadingTo[${X1},${Me.Y},${Z1}]}]}>25 )
				{
					_LastFaceTime:Set[${Math.Calc[${Script.RunningTime}+250]}]
					Face ${X1} ${Z1}
				}
				;if !${Input.Button[${PauseMovementKey}].Pressed} && ${Math.Distance[${Me.Heading},${Me.HeadingTo[${X1},${Me.Y},${Z1}]}]}>1
				;{
					;echo ${Time.SecondsSinceMidnight}: my heading is off facing
					;Face ${X1} ${Z1}
				;}
				;{
				;	_LastFaceTime:Set[${Script.RunningTime}]
				;	Face ${X1} ${Z1}
				;}
				
				if !${Me.IsMoving} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) ) )
				{
					;echo pressing autorun
					press ${RI_Var_String_AutoRunKey}
					wait 2
				}
				; if ${Me.IsMoving} && ${Input.Button[${PauseMovementKey}].Pressed} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) ) )
					; call This.StopAutoRun
				if ${UseRI_Var_String_ForwardKey} && !${RI_Var_Bool_PauseMovement} && !${Me.FlyingUsingMount} && ( ${Me.WaterDepth}==0 || !${Me.IsSwimming} )
					press -hold ${RI_Var_String_ForwardKey}
				if ${UseRI_Var_String_ForwardKey} && ${RI_Var_Bool_PauseMovement} && !${Me.FlyingUsingMount} && ( ${Me.WaterDepth}==0 || !${Me.IsSwimming} )
					press -release ${RI_Var_String_ForwardKey}
				if ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) ) )
					press -release ${RI_Var_String_ForwardKey}
				;wait 5 ( ${Math.Distance[${Me.Heading},${Me.HeadingTo[${X1},${Me.Y},${Z1}]}]}>1 || ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}<=${MPrecision} )
				;echo execute queued commands
				call This.ExecuteQueued
				;echo after execute queued
				if ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.IsSwimming} ) )
					wait 2
				else
					waitframe
				;echo end while
			}
			if ${Math.Distance[${Me.Y},${Y1}]}>5 && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) ) )
			{
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
			}
			if ${Math.Distance[${Me.Y},${Y1}]}>5 && !${UseRI_Var_String_ForwardKey} && ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) )
			{
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
			}
			elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${UseRI_Var_String_ForwardKey} && ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) )
				press -release ${RI_Var_String_ForwardKey}
			
			if ${RI_Var_Bool_Debug}
				echo ${Math.Distance[${Me.Y},${Y1}]}>5 && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.Y}>${Y1} ) || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.Y}<${Y1} && ${Me.WaterDepth}<1 ) ) && ${RI_Var_Bool_Start} && ${_Zone.Equal["${Zone.Name}"]}
				
			if !${Me.FlyingUsingMount} && ${Me.Y}<${Y1} && ${Math.Distance[${Me.Y},${Y1}]}>25 && !${Me.InCombat} && !${RI_Var_Bool_PauseMovement}
			{
				press -hold ${RI_Var_String_FlyUpKey}
				wait 1
				press -release ${RI_Var_String_FlyUpKey}
			}	
			if ${RI_Var_Bool_Debug}
			{
				echo ${Math.Distance[${Me.Y},${Y1}]}>5 && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.Y}>${Y1} ) || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.Y}<${Y1} && ${Me.WaterDepth}<1 ) ) && ( ${RI_Var_Bool_Start} || !${Script[${RI_Var_String_RunInstancesScriptName}](exists)} ) && ${_Zone.Equal["${Zone.Name}"]}
			}
			while ${Math.Distance[${Me.Y},${Y1}]}>5 && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.Y}>${Y1} ) || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.Y}<${Y1} && ${Me.WaterDepth}<1 ) ) && ( ${RI_Var_Bool_Start} || !${Script[${RI_Var_String_RunInstancesScriptName}](exists)} ) && ${_Zone.Equal["${Zone.Name}"]}
			{
				if ${EQ2.Zoning}!=0
				{
					RI_Var_Bool_Moving:Set[0]
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					press -release ${RI_Var_String_ForwardKey}
					wait 5
					continue
				}
				;echo flyup or down only while
				;check if we are paused
				call This.CheckPause
				RI_Var_Bool_Moving:Set[1]
				;check if in combat
				if ${StopForCombat}
					call This.CheckCombat
				RI_Var_Bool_Moving:Set[1]
				;first check our height if farther than ${Precision} away press and hold space as long as we are flying
				;we need to get to the correct height for current position we are ${Math.Distance[${Me.Y},${YHeight}]} away
				;check if we are even flying at all, if not start flight
				if !${Me.FlyingUsingMount} && ${Me.Y}<${Y1} && ${Math.Distance[${Me.Y},${Y1}]}>25 && !${Me.InCombat} && !${RI_Var_Bool_PauseMovement}
				{
					press -hold ${RI_Var_String_FlyUpKey}
					wait 1
					press -release ${RI_Var_String_FlyUpKey}
				}
				;now check if we are above or below desired height
				if  ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}>${Y1} && ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) ) && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -hold ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;above move up
				elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}<${Y1} && ( ${Me.FlyingUsingMount} || ( ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) && ${Me.WaterDepth}<1 ) ) && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyDownKey}
					press -hold ${RI_Var_String_FlyUpKey}
					;wait 1
				}
				;below move down
				elseif ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) ) && !${KeepMoving}
				{
					;echo we are there lets stop flying up or down
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;wait 5 ${Math.Distance[${Me.Y},${Y1}]}<=5
				if ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) )
					wait 2
				else
					waitframe
			}
			;stop flying up or down
			if !${KeepMoving}
			{
				RI_Var_Bool_Moving:Set[0]
				if ${RI_Var_Bool_Debug}
					echo ISXRI: Stoping Move since KeepMoving: ${KeepMoving}
				press -release ${RI_Var_String_FlyUpKey}
				press -release ${RI_Var_String_FlyDownKey}
				press -release ${RI_Var_String_ForwardKey}
				wait 1
				if ${Me.IsMoving}
				{
					press ${RI_Var_String_BackwardKey}
					press ${RI_Var_String_BackwardKey}
					press ${RI_Var_String_BackwardKey}
				}
			}
			;check for a Shiny if set
			if ${RI_Var_Bool_GrabShinys} && !${RI_Var_Bool_QuestMode} && ${StopForCombat} && !${SkipCheck} && !${RI_Var_Bool_GlobalOthers} && ${Actor[Query, ${RI_Var_String_Query} && Distance <= ${ShinyScanDistance}](exists)} 
			{
				if ${RI_Var_Bool_ShinyDebug}
					echo ISXRI: ${Time}: Checking for Shiny: NamedNPC Exists: ${Actor[NamedNPC,radius,50](exists)} IgnoreNamed: ${RI_Var_Bool_IgnoreNamedForShiny} Shiny Y and Named Y Distance: ${Math.Distance[${Actor[Query, ${RI_Var_String_Query} && Distance <= ${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}
				if ${Actor[NamedNPC,radius,50](exists)} && !${RI_Var_Bool_IgnoreNamedForShiny} && ${Math.Distance[${Actor[Query, ${RI_Var_String_Query} && Distance <= ${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}<11
					return
				
				call This.CheckShiny
			}
			;press autorun key (stop move)
			; if ${UseRI_Var_String_ForwardKey} && !${Me.FlyingUsingMount} && 
			; {
				; if !${KeepMoving}
					; press -release ${RI_Var_String_ForwardKey}
				; elseif ( ${Me.FlyingUsingMount} || ( ${Me.WaterDepth}>0 && ${Me.IsSwimming} ) ) && ( ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}<${MPrecision} )
					; press -release ${RI_Var_String_ForwardKey}
				; wait 1
				; if ${Me.IsMoving} && !${KeepMoving}
				; {	
					; press ${RI_Var_String_BackwardKey}
					; press ${RI_Var_String_BackwardKey}
					; press ${RI_Var_String_BackwardKey}
				; }
			; }
			; else
			; {
				;echo not using forward key
				; if ${Me.IsMoving} && !${KeepMoving}
					; call This.StopAutoRun
				; wait 1
				; if ${Me.IsMoving} && !${KeepMoving}
				; {	
					; press ${RI_Var_String_BackwardKey}
					; press ${RI_Var_String_BackwardKey}
					; press ${RI_Var_String_BackwardKey}
				; }
			; }
		}
		else
		{
			RI_Var_Bool_Moving:Set[0]
			if ${RI_Var_Bool_Debug} 
				echo ${Time}: We are ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} away from ${X1} ${Y1} ${Z1} and our Collision Check is ${Me.CheckCollision[${Me.X},${Me.Y},${Me.Z},${X1},${Y1}${Z1}]}
			; if ${Me.IsMoving} && !${UseRI_Var_String_ForwardKey}
				; call This.StopAutoRun
			; elseif ${UseRI_Var_String_ForwardKey} || ( !${Me.FlyingUsingMount} &&  )
				; press -release ${RI_Var_String_ForwardKey}
			press -release ${RI_Var_String_FlyUpKey}
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_ForwardKey}
			wait 1
			if ${Me.IsMoving}
			{
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
			}
		}
		if ${RI_Var_Bool_CancelMovement}
			RI_Var_Bool_CancelMovement:Set[FALSE]
		
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Ending Move
		
	}
	function StopAutoRun()
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Starting Stop autorun
		
		; press ${RI_Var_String_ForwardKey}
		; press ${RI_Var_String_BackwardKey}
		; press ${RI_Var_String_ForwardKey}
		; press ${RI_Var_String_BackwardKey}
		press -release ${RI_Var_String_ForwardKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
		press ${RI_Var_String_BackwardKey}
		press -release ${RI_Var_String_FlyDownKey}
		press -release ${RI_Var_String_FlyUpKey}
		wait 1
		while ${Me.IsMoving}
		{
			press -release ${RI_Var_String_FlyDownKey}
			press -release ${RI_Var_String_FlyUpKey}
			press ${RI_Var_String_AutoRunKey}
			
			waitframe
			wait 2 !${Me.IsMoving}
		}
		wait 2
		if ${Me.IsMoving}
		{
			press ${RI_Var_String_BackwardKey}
			press ${RI_Var_String_BackwardKey}
			press ${RI_Var_String_BackwardKey}
		}
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time} Ending Stop autorun
	}
	
	function TravelMap(string _ZoneToZoneName, int _ZoneOption=0, int _BellWizardDruid=0)
	{
		;echo TravelMap(string _ZoneToZoneName=${_ZoneToZoneName}, int _ZoneOption=${_ZoneOption}, int _BellWizardDruid=${_BellWizardDruid})
		
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting TravelMap(string _ZoneToZoneName=${_ZoneToZoneName}, int _ZoneOption=${_ZoneOption}, int _BellWizardDruid=${_BellWizardDruid})
			
		if ${_BellWizardDruid}==1
		{
			if !${Actor[Query, Name=="Explorer's Globe of Norrath" && Distance<=13](exists)} && !${Actor[Query, Name=="Ole Salt's Mariner Bell" && Distance<=13](exists)} && !${Actor[Query, Name=="Navigator's Globe of Norrath" && Distance<=13](exists)} && !${Actor[Query, Name=="Pirate Captain's Helmsman" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
			{
				if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
				{
					MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Travel Bell within 13, please move closer and resume RQ"
					RI_Var_Bool_Paused:Set[TRUE]
					UIElement[Start@RI]:SetText[Resume]
					while ${RI_Var_Bool_Paused}
					{
						wait 1
					}
					wait 5
				}
				else
				{
					MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Travel Bell within 13"
					return
				}
			}
			Actor[mariners_bell]:DoubleClick
			Actor[mariner_bell_city_travel_qeynos]:DoubleClick
			Actor[zone_to_guildhall_tier3]:DoubleClick
			Actor[Zone to Friend]:DoubleClick
			Actor[flight_cloud_large_1_to_medium_1]:DoubleClick
			Actor[mariner_bell_city_travel_freeport]:DoubleClick
			Actor["Ole Salt's Mariner Bell"]:DoubleClick
			Actor["Navigator's Globe of Norrath"]:DoubleClick
			Actor["Pirate Captain's Helmsman"]:DoubleClick
			Actor["Explorer's Globe of Norrath"]:DoubleClick
			wait 10
		}
		elseif ${_BellWizardDruid}==2
		{
			if !${Actor[Query, Name=-"Ulteran Spire" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
			{
				if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
				{
					MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Spire within 13, please move closer and resume RQ"
					RI_Var_Bool_Paused:Set[TRUE]
					UIElement[Start@RI]:SetText[Resume]
					while ${RI_Var_Bool_Paused}
					{
						wait 1
					}
					wait 5
				}
				else
				{
					MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Spire within 13"
					return
				}
			}
			Actor["Ulteran Spire"]:DoubleClick
			wait 10
		}
		elseif ${_BellWizardDruid}==3
		{
			if !${Actor[Query, Guild=="Guild Portal Druid" && Distance<=13](exists)} && ${Zone.ShortName.Find[guildhall](exists)}
			{
				if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
				{
					MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Guild Portal Druid within 13, please move closer and resume RQ"
					RI_Var_Bool_Paused:Set[TRUE]
					UIElement[Start@RI]:SetText[Resume]
					while ${RI_Var_Bool_Paused}
					{
						wait 1
					}
					wait 5
				}
				else
				{
					MessageBox -skin eq2 "We are at the guild hall to attempt to zone to ${_ZoneToZoneName} but can not find a Guild Portal Druid within 13"
					return
				}
			}
			Actor[guild,"Guild Portal Druid"]:DoFace
			Actor[guild,"Guild Portal Druid"]:DoTarget
			wait 5
			eq2ex hail
			wait 5
			EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
			wait 20
			Actor[tcg_druid_portal]:DoubleClick
			wait 20
		}
		;echo RIMUIObj:TravelMap[${Me.Name},${_ZoneToZoneName},${_ZoneOption}]
		variable int _fcnt=0
		while !${EQ2.Zoning} && ${_fcnt:Inc}<10
		{
			RIMUIObj:TravelMap[${Me.Name},${_ZoneToZoneName},${_ZoneOption}]
			wait 5
		}
		if ${_ZoneOption}==-1
		{
			wait 50 ${Me.IsMoving}
			wait 6000 !${Me.IsMoving}
		}
		else
		{
			wait 600 ${EQ2.Zoning}==1
			wait 600 ${EQ2.Zoning}==0
		}
		;wait 600 ${Zone.Name.Find[${_ZoneToZoneName}](exists)}
		wait 10
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending TravelMap
	}
	function CallToGuildHall(bool _WaitTillReady=TRUE)
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Start CallToGuildHall
		;while !${Zone.ShortName.Find[guildhall](exists)}
		;{
			;wait until calltoguildhall is up
			if ${_WaitTillReady}
			{
				while !${Me.Ability[id,3266969222].IsReady} && !${Zone.ShortName.Find[guildhall](exists)}
					wait 10
			}
			
			while ${Me.Ability[id,3266969222].IsReady} && !${Zone.ShortName.Find[guildhall](exists)}
			{
				Me.Ability[id,3266969222]:Use
				wait 5
			}
			;if ${Me.GetGameData[Spells.Casting].Label.Equal[Call to Guild Hall]}
			;{
				wait 600 ${EQ2.Zoning}==1 || ${Zone.ShortName.Find[guildhall](exists)}
				wait 600 ${EQ2.Zoning}==0
				wait 600 ${Zone.ShortName.Find[guildhall](exists)}
			;}
			wait 10 ${Zone.ShortName.Find[guildhall](exists)}
		;}
		wait 50
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending CallToGuildHall
	}
}
objectdef RIConsoleObject
{	
	method UISmall(int _Save=1)
	{
		UIElement[RIConsole]:SetHeight[165]
		UIElement[RIConsole]:SetWidth[335]
		if ${_Save}>0
		{
			if ${Set.FindSet[RIConsolSize](exists)}
				Set.FindSet[RIConsolSize]:Remove
			Set:AddSet[RIConsolSize]
			Set.FindSet[RIConsolSize]:AddSetting[Size,Small]
			LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
		}
	}
	method UIMedium(int _Save=1)
	{
		UIElement[RIConsole]:SetHeight[185]
		UIElement[RIConsole]:SetWidth[400]
		if ${_Save}>0
		{
			if ${Set.FindSet[RIConsolSize](exists)}
				Set.FindSet[RIConsolSize]:Remove
			Set:AddSet[RIConsolSize]
			Set.FindSet[RIConsolSize]:AddSetting[Size,Medium]
			LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
		}
	}
	method UILarge(int _Save=1)
	{
		UIElement[RIConsole]:SetHeight[225]
		UIElement[RIConsole]:SetWidth[465]
		;UIElement[RIConsole@RIConsole]:SetHeight[190]
		if ${_Save}>0
		{
			if ${Set.FindSet[RIConsolSize](exists)}
				Set.FindSet[RIConsolSize]:Remove
			Set:AddSet[RIConsolSize]
			Set.FindSet[RIConsolSize]:AddSetting[Size,Large]
			LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
		}
	}
	method LoadUI()
	{
		ui -reload "${RI_Var_String_SkinFileName}"
		ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RIConsole.xml"
	}
	method Hide()
	{
		if ${UIElement[RIConsole](exists)}
			UIElement[RIConsole]:Hide
	}
	method Show()
	{
		if ${UIElement[RIConsole](exists)}
			UIElement[RIConsole]:Show
	}
	method EchoVanilla(string _Message)
	{
		if ${UIElement[RIConsole](exists)}
			UIElement[RIConsole@RIConsole]:Echo["${_Message}"]
	}
	method Echo(string _Message, bool _ShowConsole=FALSE, int _FlashConsoleTimeInSeconds=0, bool _PlayAlarm=FALSE)
	{
		if ${_ShowConsole}
			This:Show
		if ${_PlayAlarm}
		{
			playsound "${LavishScript.HomeDirectory}/Scripts/RI/RIConsoleAlarm.wav"
		}
		if ${_FlashConsoleTimeInSeconds}>0
		{
			variable int _cnt
			variable bool _HidLast=1
			for(_cnt:Set[0];${_cnt}<=${Math.Calc[${_FlashConsoleTimeInSeconds}*10]};_cnt:Set[${Math.Calc[${_cnt}+5]}])
			{
				if ${_HidLast}
				{
					TimedCommand ${_cnt} RIConsole:Show
					_HidLast:Set[0]
				}
				else
				{
					TimedCommand ${_cnt} RIConsole:Hide
					_HidLast:Set[1]
				}
			}
		}
		if ${UIElement[RIConsole](exists)}
			UIElement[RIConsole@RIConsole]:Echo["${_Message}"]
	}
	method Execute(string _Command)
	{
		UIElement[RIConsole@RIConsole]:Echo["${_Command}"]
		noop ${Execute["${_Command.EscapeQuotes}"]}
	}
	method Clear()
	{
		UIElement[RIConsole@RIConsole]:Clear
	}
}
objectdef RIMUIObject
{
	method RunQuest(string _ForWho=ALL, string _QuestName)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RI_RunInstances "QUEST-${_QuestName}"
			TimedCommand 5 RIObj:Start
		}
	}
	method OverseerRunNow(string _ForWho=ALL)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RIOverseerObj:RunNow
		}
	}
	method OverseerGO(string _ForWho=ALL)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RIOverseerObj:GO
		}
	}
	member(bool) QuestStepExists(string _QuestStep, bool _isChecked=FALSE)
	{
		variable index:collection:string Details    
		variable iterator DetailsIterator
		variable int DetailsCounter = 0
		variable bool _FoundIt = FALSE
		variable bool _Checked = FALSE
	;    echo "Journal Current Quest:"
	;    echo "- Name: ${QuestJournalWindow.CurrentQuest.Name.GetProperty["LocalText"]}"
	;    echo "- Level: ${QuestJournalWindow.CurrentQuest.Level.GetProperty["LocalText"]}"
	;    echo "- Category: ${QuestJournalWindow.CurrentQuest.Category.GetProperty["LocalText"]}"
	;    echo "- CurrentZone: ${QuestJournalWindow.CurrentQuest.CurrentZone.GetProperty["LocalText"]}"
	;    echo "- TimeStamp: ${QuestJournalWindow.CurrentQuest.TimeStamp.GetProperty["LocalText"]}"
	;    echo "- MissionGroup: ${QuestJournalWindow.CurrentQuest.MissionGroup.GetProperty["LocalText"]}"
	;    echo "- Status: ${QuestJournalWindow.CurrentQuest.Status.GetProperty["LocalText"]}"
	;    echo "- ExpirationTime: ${QuestJournalWindow.CurrentQuest.ExpirationTime.GetProperty["LocalText"]}"
	;    echo "- Body: ${QuestJournalWindow.CurrentQuest.Body.GetProperty["LocalText"]}"
		
		QuestJournalWindow.CurrentQuest:GetDetails[Details]
		Details:GetIterator[DetailsIterator]
	;    echo "- Details:"
		if (${DetailsIterator:First(exists)})
		{
			do
			{
				if (${DetailsIterator.Value.FirstKey(exists)})
				{
					do
					{
						;echo "-- ${DetailsCounter}::  '${DetailsIterator.Value.CurrentKey}' => '${DetailsIterator.Value.CurrentValue}'"
						;echo ${DetailsIterator.Value.CurrentValue.Find[${_QuestStep}](exists)} // ${DetailsIterator.Value.CurrentValue}
						if ${DetailsIterator.Value.CurrentKey.Equal[Check]} && ${DetailsIterator.Value.CurrentValue.Find[true](exists)}
							_Checked:Set[TRUE]
						if ${DetailsIterator.Value.CurrentKey.Equal[Check]} && ${DetailsIterator.Value.CurrentValue.Find[false](exists)}
							_Checked:Set[FALSE]
						if ${DetailsIterator.Value.CurrentKey.Equal[Text]} && ${DetailsIterator.Value.CurrentValue.Find[${_QuestStep}](exists)}
							_FoundIt:Set[TRUE]
					}
					while ${DetailsIterator.Value.NextKey(exists)}
					 ;echo "------"
				}
				DetailsCounter:Inc
			}
			while ${DetailsIterator:Next(exists)} && !${_FoundIt}
		}
		;echo FoundIt: ${_FoundIt} isChecked: ${_isChecked} Checked: ${_Checked}
		if ( ${_FoundIt} && !${_isChecked} && !${_Checked} ) || ( ${_FoundIt} && ${_isChecked} && ${_Checked} )
			return TRUE
		else
			return FALSE
	}
	member:int GroupDetrimentCount(string _Type)
	{
		variable int detcnt
		variable int i
		detcnt:Set[0]
		if ${_Type.Equals[Trauma]}
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
			{
				if ${Me.Group[${i}].Trauma}>0
				{
					detcnt:Inc
				}
			}
		}
		elseif ${_Type.Equals[Noxious]}
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
			{
				if ${Me.Group[${i}].Noxious}>0
				{
					detcnt:Inc
				}
			}
		}
		elseif ${_Type.Equals[Arcane]}
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
			{
				if ${Me.Group[${i}].Arcane}>0
				{
					detcnt:Inc
				}
			}
		}
		elseif ${_Type.Equals[Elemental]}
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
			{
				if ${Me.Group[${i}].Elemental}>0
				{
					detcnt:Inc
				}
			}
		}
		elseif ${_Type.Equals[Cursed]} || ${_Type.Equals[Curse]}
		{
			for(i:Set[0];${i}<${Me.Group};i:Inc)
			{
				if ${Me.Group[${i}].Cursed}>0
				{
					detcnt:Inc
				}
			}
		}
		return ${detcnt}
	}
	member:string 3rdPointLine(float x1, float y1, float x2, float y2, float distance)
	{
		distance:Set[${Math.Calc[${Math.Distance[${x1},${y1},${x2},${y2}]}+${distance}]}]
		variable float dx
		variable float dx2
		variable float dy
		variable float dy2
		variable float k
		variable float distance2
		variable float dx2y2
		variable float distance2dx2y2
		variable float x3
		variable float y3
		distance2:Set[${Math.Calc[${distance}*${distance}]}]
		dx:Set[${Math.Calc[${x2}-${x1}]}]
		dy:Set[${Math.Calc[${y2}-${y1}]}]
		dx2:Set[${Math.Calc[${dx}*${dx}]}]
		dy2:Set[${Math.Calc[${dy}*${dy}]}]
		dx2y2:Set[${Math.Calc[${dx2}+${dy2}]}]
		distance2dx2y2:Set[${Math.Calc[${distance2}/${dx2y2}]}]
		k:Set[${Math.Sqrt[${distance2dx2y2}]}]
		x3:Set[${Math.Calc[${x1}+${dx}*${k}]}]
		y3:Set[${Math.Calc[${y1}+${dy}*${k}]}]
		return "${x3},${y3}"
	}
	method ButtonExecute(string _Button)
	{
		;echo ${_Button}
		;echo RIConsole:Echo["${RI_String_RIMUI_${_Button}Com}"]
		if ${RI_Var_Bool_RIMUICommandsEchoToConsole}
			RIConsole:EchoVanilla["${RI_String_RIMUI_${_Button}Com}"]
		;echo execute relay ${RI_String_RIMUI_RelayTarget} ${RI_String_RIMUI_${_Button}Com}
		execute relay ${RI_String_RIMUI_RelayTarget} ${RI_String_RIMUI_${_Button}Com}
	}
	member:string Archetype(string _Actor)
	{
		variable int _ID
		if ${Int[${_Actor}]}>5
		{
			_ID:Set[${Int[${_Actor}]}]
		}
		elseif ${Int[${_Actor}]}>0
		{
			_ID:Set[${Me.Group[${Int[${_Actor}]}].ID}]
		}
		else
		{
			_ID:Set[${Actor[Query, Name=-"${_Actor}"].ID}]
		}
		switch ${Actor[Query, ID=${_ID}].Class}
		{
			case defiler
			case mystic
			case warden
			case fury
			case templar
			case inquisitor
			case channeler
			{
				return priest
				break
			}
			case dirge
			case troubador
			case assassin
			case ranger
			case brigand
			case swashbuckler
			case beastlord
			{
				return scout
				break
			}
			case monk
			case bruiser
			case guardian
			case berserker
			case shadowknight
			case paladin
			{
				return fighter
				break
			}
			case coercer
			case illusionist
			case wizard
			case warlock
			case necromancer
			case conjuror
			{
				return mage
				break
			}
		}
	}
	member:int InventoryQuantity(string _Item)
	{
		variable index:item _Items
		variable int _ItemCount=0
		variable int _count2
		_Items:Clear
		Me:QueryInventory[_Items, ( Location=="Inventory" || Location=="Unknown" || Location=="Harvest Bag") && Name=-"${_Item}"]
		;echo ${_Items.Used}
		for(_count2:Set[1];${_count2}<=${_Items.Used};_count2:Inc)
		{
			_ItemCount:Set[${Math.Calc[${_ItemCount}+${_Items.Get[${_count2}].Quantity}]}]
		}
		return ${_ItemCount}
	}
	method DisablePets(string _ForWho)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Possess Essence,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Spirit Companion,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Personae Reflection,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Aery Hunter,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Fiery Magician,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Grim Sorcerer,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Create Construct,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Earthen Avatar,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Nightshade,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Undead Knight,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Avian,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Bear,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Boar,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Bovid,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Canine,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Dire,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Drake,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Enchanted,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Feline,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Mystical,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Rodent,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Warboar,0]
			Me.Maintained[Possess Essence]:Cancel
			Me.Maintained[Summon Spirit Companion]:Cancel
			Me.Maintained[Personae Reflection]:Cancel
			Me.Maintained[Aery Hunter]:Cancel
			Me.Maintained[Fiery Magician]:Cancel
			Me.Maintained[Grim Sorcerer]:Cancel
			Me.Maintained[Create Construct]:Cancel
			Me.Maintained[Earthen Avatar]:Cancel
			Me.Maintained[Nightshade]:Cancel
			Me.Maintained[Undead Knight]:Cancel
			Me.Maintained[Summon Warder: Avian]:Cancel
			Me.Maintained[Summon Warder: Bear]:Cancel
			Me.Maintained[Summon Warder: Boar]:Cancel
			Me.Maintained[Summon Warder: Bovid]:Cancel
			Me.Maintained[Summon Warder: Canine]:Cancel
			Me.Maintained[Summon Warder: Dire]:Cancel
			Me.Maintained[Summon Warder: Drake]:Cancel
			Me.Maintained[Summon Warder: Enchanted]:Cancel
			Me.Maintained[Summon Warder: Feline]:Cancel
			Me.Maintained[Summon Warder: Mystical]:Cancel
			Me.Maintained[Summon Warder: Rodent]:Cancel
			Me.Maintained[Summon Warder: Warboar]:Cancel
		}
	}
	method EnablePets(string _ForWho)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Possess Essence,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Spirit Companion,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Personae Reflection,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Aery Hunter,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Fiery Magician,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Grim Sorcerer,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Create Construct,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Earthen Avatar,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Nightshade,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Undead Knight,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Avian,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Bear,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Boar,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Bovid,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Canine,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Dire,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Drake,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Enchanted,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Feline,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Mystical,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Rodent,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Summon Warder: Warboar,1]
		}
	}
	
	method DisableTempPets(string _ForWho)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Granite Protector,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Elemental Amalgamation,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Bloatfly,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Shadow,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Awaken Grave,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Ancestral Sentry,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Ball of Lightning,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Band of Thugs,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Blighted Horde,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Doppelganger,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Holy Avenger,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Puppetmaster,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Ring of Fire,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Undead Horde,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Unswerving Hammer,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Dark Infestation,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Furnace of Ro,0]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Protoflame,0]
		}
	}
	method EnableTempPets(string _ForWho)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Granite Protector,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Elemental Amalgamation,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Bloatfly,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Shadow,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Awaken Grave,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Ancestral Sentry,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Ball of Lightning,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Band of Thugs,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Blighted Horde,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Doppelganger,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Holy Avenger,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Puppetmaster,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Ring of Fire,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Undead Horde,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Unswerving Hammer,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Dark Infestation,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Furnace of Ro,1]
			RI_Obj_CB:ModifyCastStackAbiltiesListBoxItem[Protoflame,1]
		}
	}
	method StarFormation(int _Distance=10)
	{
		relay is2 RIMUIObj:SetLockSpot[ALL,${Math.Calc[${Me.X}+${_Distance}]},${Me.Y},${Me.Z}]
		relay is3 RIMUIObj:SetLockSpot[ALL,${Math.Calc[${Me.X}+(${_Distance}*.37)]},${Me.Y},${Math.Calc[${Me.Z}+(${_Distance}*.92)]}]
		relay is4 RIMUIObj:SetLockSpot[ALL,${Math.Calc[${Me.X}+(${_Distance}*.37)]},${Me.Y},${Math.Calc[${Me.Z}-(${_Distance}*.92)]}]
		relay is5 RIMUIObj:SetLockSpot[ALL,${Math.Calc[${Me.X}-(${_Distance}*.80)]},${Me.Y},${Math.Calc[${Me.Z}+(${_Distance}*.61)]}]
		relay is6 RIMUIObj:SetLockSpot[ALL,${Math.Calc[${Me.X}-(${_Distance}*.80)]},${Me.Y},${Math.Calc[${Me.Z}-(${_Distance}*.61)]}]
	}
	method RIWaitForHealth(bool _OnOff)
	{
		RI_Var_Bool_WaitForHealth:Set[${_OnOff}]
	}
	method GrabShinys(bool _OnOff)
	{
		RI_Var_Bool_GrabShinys:Set[${_OnOff}]
	}
	method SetShinyScanDistance(int _Distance=100)
	{
		RIObj:SetShinyScanDistance[${_Distance}]
	}
	member InvalidChestCheck(int _ID)
	{
		variable int _cnt=1
		for(_cnt:Set[1];${_cnt}<=${RI_Var_IndexInt_InvalidChest.Used};_cnt:Inc)
		{
			if ${RI_Var_IndexInt_InvalidChest.Get[${_cnt}]}==${_ID}
				return TRUE
		}
		return FALSE
	}
	member InvalidShinyCheck(int _ID)
	{
		variable int _cnt=1
		for(_cnt:Set[1];${_cnt}<=${RI_Var_IndexInt_InvalidShiny.Used};_cnt:Inc)
		{
			if ${RI_Var_IndexInt_InvalidShiny.Get[${_cnt}]}==${_ID}
				return TRUE
		}
		return FALSE
	}
	method SetInGameFollow(... args)
	{
		;string _ForWho, string _WhoToFollow
		variable int _count
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${This.ForWhoCheck[${args[${_count}]}]}
			{
				eq2ex follow ${args[${Math.Calc[${_count}+1]}]}
			}	
			count:Inc
		}	
	}
	method MoveTo(... args)
	{
		;string _ForWho, float _x, float _y, float _z, int precision
		variable int _count
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${This.ForWhoCheck[${args[${_count}]}]}
			{
				MTX:Set[${args[${Math.Calc[${_count}+1]}]}]
				MTY:Set[${args[${Math.Calc[${_count}+2]}]}]
				MTZ:Set[${args[${Math.Calc[${_count}+3]}]}]
				MTP:Set[${args[${Math.Calc[${_count}+4]}]}]
				MT:Set[1]
			}
			count:inc;count:inc;count:inc;count:inc
		}	
	}
	method ResetZone(string _ForWho, ... args)
	{
		variable int _count
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
			{
				Me:ResetZoneTimer["${args[${_count}]}"]
			}
		}
	}
	method ResetAllZones(string _ForWho)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			eq2ex /reset_all_zone_timers
			ChoiceWindow:DoChoice1
			TimedCommand 5 ChoiceWindow:DoChoice1
			TimedCommand 10 ChoiceWindow:DoChoice1
		}
	}
	method CheckEpic2PreReqs(string _ForWho=ALL)
	{
		if !${This.ForWhoCheck[${_ForWho}]}
			return
		variable bool CTD=0
		variable bool SS=0
		variable bool E1C=0
		switch ${Me.Archetype}
		{	
			case mage
			{
				echo ISXRI: ${Me.Name}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Kaedrin's Fate](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Your Eternal Reward](exists)}]}
					CTD:Set[1]
				if ${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Dethknell Citadel](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Qeynos Castle](exists)}]}
					SS:Set[1]
				;illusionist,coercer,wizard,warlock,necromancer,conjurer
				if ${QuestJournalWindow.CompletedQuest[The Maiden of Masks](exists)} || ${QuestJournalWindow.CompletedQuest[Leandre's Shard: Drusella's Extraction](exists)} || ${QuestJournalWindow.CompletedQuest[Of Fire and Ice: Suitable Components](exists)} || ${QuestJournalWindow.CompletedQuest[The Will of Kyrtoxxulous](exists)} || ${QuestJournalWindow.CompletedQuest[The Bones of Insanity](exists)} || ${QuestJournalWindow.CompletedQuest[The Domination of Phrotis](exists)}
					E1C:Set[1]
				
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				;echo ISXRI: Epic 1.0 Complete: ${E1C}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				;echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
				echo ISXRI: Shattered Seas Timeline Complete: ${SS}
				echo ISXRI: Othmir Cobalt Scar Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[High Tide](exists)}]}
				echo ISXRI: Othmir Great Divide Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The End of an Era](exists)}]}
				echo ISXRI: Koada'dal Magi's Craft Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Koada'dal Magi's Craft](exists)}]}
				echo ISXRI: A Strange Black Rock Complete: ${Bool[${QuestJournalWindow.CompletedQuest[A Strange Black Rock](exists)}]}
				echo ISXRI: An Eye for Power Complete: ${Bool[${QuestJournalWindow.CompletedQuest[An Eye for Power](exists)}]}
				echo ISXRI: Vesspyr Isles Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Family Ties](exists)}]}
				echo ISXRI: Words of Air (Uruvanian Language) Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Words of Air](exists)}]}
				echo ISXRI: Voices from Beyond (Words of Shade Language) Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Voices from Beyond](exists)}]}
				break
			}
			case priest
			{
				echo ISXRI: ${Me.Name}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Kaedrin's Fate](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Your Eternal Reward](exists)}]}
					CTD:Set[1]
				;fury,warden,defiler,mystic,templar,inquisitor,channeler
				if ${QuestJournalWindow.CompletedQuest[Restored To Glory](exists)} || ${QuestJournalWindow.CompletedQuest[Broken Barrier: Lessons of the Fallen](exists)} || ${QuestJournalWindow.CompletedQuest[The Dream Scorcher](exists)} || ${QuestJournalWindow.CompletedQuest[A Sleeping Stone: The Cudgel of Obviation](exists)} || ${QuestJournalWindow.CompletedQuest[Bringing the Hammer Down on Venril](exists)} || ${QuestJournalWindow.CompletedQuest[The Saga of Yasva V'Alear](exists)} || ${QuestJournalWindow.CompletedQuest[The Red Shadow's Long Fingers](exists)}
					E1C:Set[1]
					
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				;echo ISXRI: Epic 1.0 Complete: ${E1C}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				;echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
				echo ISXRI: Thulian Language Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Fearful Words](exists)}]}
				echo ISXRI: Ning Yung Retreat Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Shaping a Clearer Mind](exists)}]}
				echo ISXRI: Othmir Cobalt Scar Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[High Tide](exists)}]}
				echo ISXRI: Othmir Great Divide Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The End of an Era](exists)}]}
				echo ISXRI: The White Dragonscale Cloak Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The White Dragonscale Cloak](exists)}]}
				echo ISXRI: A Source of Malediction Complete: ${Bool[${QuestJournalWindow.CompletedQuest[A Source of Malediction](exists)}]}
				echo ISXRI: Fallen Dynasty Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[A Vision of the Future](exists)}]}
				echo ISXRI: Vesspyr Isles Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Tears of Veeshan: Falling Tears](exists)}]}
				break
			}
			case scout
			{
				echo ISXRI: ${Me.Name}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Kaedrin's Fate](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Your Eternal Reward](exists)}]}
					CTD:Set[1]
				;dirge,troubador,assassin,ranger,swashbuckler,brigand,beastlord
				if ${QuestJournalWindow.CompletedQuest[Sing a Song of Sorrow](exists)} || ${QuestJournalWindow.CompletedQuest[An Ayonic Journey](exists)} || ${QuestJournalWindow.CompletedQuest[A Mysterious Trinket](exists)} || ${QuestJournalWindow.CompletedQuest[Removing the Darkness From Within...](exists)} || ${QuestJournalWindow.CompletedQuest[High Seas Adventure](exists)} || ${QuestJournalWindow.CompletedQuest[The Heart of Treachery](exists)} || ${QuestJournalWindow.CompletedQuest[A Chance For Redemption](exists)}
					E1C:Set[1]
					
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				;echo ISXRI: Epic 1.0 Complete: ${E1C}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Dethknell Citadel](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Qeynos Castle](exists)}]}
					SS:Set[1]
				;echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				echo ISXRI: Shattered Seas Timeline Complete: ${SS}
				echo ISXRI: Othmir Cobalt Scar Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[High Tide](exists)}]}
				echo ISXRI: Dark Mail Gauntlets Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Means to an End...](exists)}]}
				;echo ISXRI: The Order of Rime Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[More Fish for the Stew](exists)}]}
				echo ISXRI: Kurns Tower Access Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Dragonbone Weapon Parts](exists)}]}
				echo ISXRI: High Keep: The Bloodless Incursion Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[On the Heel of Nightmares](exists)}]}
				echo ISXRI: Fallen Dynasty Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Rift](exists)}]}
				echo ISXRI: Tears of Veeshan Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Reaching Fraka](exists)}]}
				break
			}
			case fighter
			{
				echo ISXRI: ${Me.Name}
				variable bool CTD2=0
				variable bool RF=0
				if ${Bool[${QuestJournalWindow.CompletedQuest[Kaedrin's Fate](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Your Eternal Reward](exists)}]}
					CTD:Set[1]
				if ${Bool[${QuestJournalWindow.CompletedQuest[Putting the Rage in Ragefire](exists)}]}||${Bool[${QuestJournalWindow.ActiveQuest[Putting the Rage in Ragefire](exists)}]}
					RF:Set[1]
				;guardian,berserker,paladin,shadowknight,monk,bruiser
				if ${QuestJournalWindow.CompletedQuest[The Search for Vel'Arek](exists)} || ${QuestJournalWindow.CompletedQuest[The Responsibilities of a Berserker's Rage](exists)} || ${QuestJournalWindow.CompletedQuest[The Consequences of a Berserker's Rage](exists)} || ${QuestJournalWindow.CompletedQuest[A Paladin's Crusade](exists)} || ${QuestJournalWindow.CompletedQuest[A Bloodmoon Rising!](exists)} || ${QuestJournalWindow.CompletedQuest[The Broken Hand](exists)} || ${QuestJournalWindow.CompletedQuest[The Broken Fist](exists)}
					E1C:Set[1]
					
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				;echo ISXRI: Epic 1.0 Complete: ${E1C}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				;echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
				echo ISXRI: Tik-Tok Language Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Mysteries of Tik-Tok](exists)}]}
				echo ISXRI: Pygmy Language Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Handle With Care](exists)}]}
				echo ISXRI: Krombral Language Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Words of a Giant](exists)}]}
				echo ISXRI: The Symbol in the Flesh Heritage Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Symbol in the Flesh](exists)}]}
				echo ISXRI: The Bone Bladed Claymore Heritage Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Bone Bladed Claymore](exists)}]}
				echo ISXRI: ToT Crafting Sig Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Containing the Stone](exists)}]}
				echo ISXRI: ToT Sigline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Underdepths Saga: Chaos and Malice](exists)}]}
				echo ISXRI: Jarsath Wastes Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[I'd Hammer in the Morning](exists)}]}
				echo ISXRI: ToV and Ragefire Timeline Complete: ${RF}
				echo ISXRI: Ry'Gorr Keep Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest["Rise of Thrael'Gorr"](exists)}]}
				echo ISXRI: Shades of Drinal Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Shades of Drinal: Fate's Crusade](exists)}]}
				break
			}
		}
	}
	method ShareMissions(string _ZoneName, bool _WaitTillGroupAllInZone=TRUE)
	{
		if ${_ZoneName.Equal[NULL]}
			return
		;echo ShareMissions(string _ZoneName=${_ZoneName}, bool _WaitTillGroupAllInZone=${_WaitTillGroupAllInZone})
		if ${QueueCommands}
			FlushQueued
		Script[${Script.Filename}]:QueueCommand["call RIMUIObj.ShareMissionsFN \"${_ZoneName}\" ${_WaitTillGroupAllInZone}"]
	}
	function ShareMissionsFN(string _ZoneName, bool _WaitTillGroupAllInZone=TRUE)
	{
		if ${_WaitTillGroupAllInZone}
		{
			wait 600 ${RIMObj.AllGroupInZone}
		}
		;echo ShareMissionsFN(string _ZoneName=${_ZoneName}, bool _WaitTillGroupAllInZone=${_WaitTillGroupAllInZone})
		
		;format zonename
		variable string _FormattedZoneName
		variable string _ZoneTier
		if ${Zone.Name.Find["Shard of Hate: Utter Contempt [Heroic]"](exists)} || ${Zone.Name.Find["Shard of Hate: Udder Contempt [Herd Mode]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name}"]
			_ZoneTier:Set["[Heroic]"]
		}
		elseif ${Zone.Name.Find["[Heroic]"](exists)} || ${Zone.Name.Find["[Expert]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-9]}"]
			_ZoneTier:Set["[Heroic]"]
		}
		elseif ${Zone.Name.Find["[Event Heroic]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-15]}"]
			_ZoneTier:Set["[Event Heroic]"]
		}
		elseif ${Zone.Name.Find["[Solo]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-7]}"]
			_ZoneTier:Set["[Solo]"]
		}
		elseif ${Zone.Name.Find["[Advanced Solo]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-16]}"]
			_ZoneTier:Set["[Advanced Solo]"]
		}
		elseif ${Zone.Name.Find["[Challenge Heroic]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-19]}"]
			_ZoneTier:Set["[Challenge Heroic]"]
		}
		elseif ${Zone.Name.Find["[Expert]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-9]}"]
			_ZoneTier:Set["[Heroic]"]
		}
		elseif ${Zone.Name.Find["[Expert Event]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-15]}"]
			_ZoneTier:Set["[Event Heroic]"]
		}
		elseif ${Zone.Name.Find["[Expert Challenge]"](exists)}
		{
			_FormattedZoneName:Set["${Zone.Name.Left[-19]}"]
			_ZoneTier:Set["[Challenge Heroic]"]
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
					;;;;;;;;;;;; Added .Right[-14] to CurrentZone to parse out DBG's New Addition of Current zone: to the beggining on 7-2-18
					;echo _FormattedZoneName: ${_FormattedZoneName} // QuestsIterator.Value.CurrentZone: ${QuestsIterator.Value.CurrentZone} // ${QuestsIterator.Value.CurrentZone.Equal["${_FormattedZoneName}"]} // ${QuestsIterator.Value.Name} // _ZoneTier: ${_ZoneTier} // ${QuestsIterator.Value.Name.Find[${_ZoneTier}](exists)}
					if ( ${QuestsIterator.Value.CurrentZone.Right[-14].Equal[${_FormattedZoneName}]} && ${QuestsIterator.Value.Name.Find[${_ZoneTier}](exists)} ) || ${QuestsIterator.Value.CurrentZone.Right[-14].Equal["${_FormattedZoneName}"]} || ${QuestsIterator.Value.CurrentZone.Equal["Multiple LocationsDISABLED"]} || ${QuestsIterator.Value.CurrentZone.Equal["${_FormattedZoneName}"]}
					{
						echo ISXRI: Sharing: "${QuestsIterator.Value.Name}"
						QuestsIterator.Value:Share
						wait 15
					}
				}
			}
			while ${QuestsIterator:Next(exists)}
		}
	}
	member:string ConvertAlias(string aliasName)
	{
		variable int caCount=0
		;FoundTarget:Set[FALSE]
		;echo checking ${aliasName}
		if ${aliasName.Equal[""]}
			return 0
		for(caCount:Set[1];${caCount}<=${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].Items};caCount:Inc)
		{
			if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Find[" For"]}-1]}].Equal[${aliasName}]} && ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].TextColor}!=-10263709
			{
				;echo checking ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Find[" For"]}-1]}]} if it matches ${aliasName}
				;echo found an alias ${aliasName}, searching for its alias
				; if ${Me.Raid}>0 && ${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].InMyGroup}
				; {
					; CastTarget:Set[${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].ID}]
					; echo found Alias ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Find[" For"]}-1]}]} as ${Me.Raid[id,${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].ID}].Name}
					; return TRUE
				; }
				if ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value.Equal[${Me.Name}]}
					return ${Me.Name}
				if ${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].InMyGroup}
				{
					;CastTarget:Set[${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].ID}]
					;echo found Alias ${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Left[${Math.Calc[${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Text.Find[" For"]}-1]}]} as ${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].Name}
					return ${Actor[PC,${UIElement[AliasesAliasListBox@AliasesFrame@CombatBotUI].OrderedItem[${caCount}].Value}].Name}
				}
			}
		}
		; if ${Me.Raid}>0
		; {
			; ;do raid checks
			; variable int caRaidCount2
			; for(caRaidCount2:Set[1];${caRaidCount2}<=${Me.Raid};caRaidCount2:Inc)
			; {
				; if ${Me.Raid[${caRaidCount2}].Name.Equal[${aliasName}]}
				; {
					; CastTarget:Set[${Me.Raid[${caRaidCount2}].ID}]
					; return TRUE
				; }
			; }
		; }
		; else
		if ${aliasName.Equal[${Me.Name}]}
			return ${Me.Name}
		if ${Actor[PC,${aliasName}].InMyGroup}
		{
			;CastTarget:Set[${Actor[PC,${aliasName}].ID}]
			return ${Actor[PC,${aliasName}].Name}
		}
		return 0
	}
	method RIPull(string _PullNamed)
	{
		if ${This.ForWhoCheck[${Me.Name}]}
			RI Pull ${_PullNamed}
	}
	method JumpUp(string _ForWho=ALL, float _X=${Me.X}, float _Y=${Me.Y}, float _Z=${Me.Z}, float _YTarget=${Math.Calc[${Me.Y}+2]}, int _FaceDegree=${Me.Heading}, int _GiveUpCNT=10)
	{
		;(float _X, float _Y, float _Z, float _YTarget, int _FaceDegree, int _GiveUpCNT=10)
		if ${This.ForWhoCheck[${_ForWho}]}
		{
			JUX:Set[${_X}]
			JUY:Set[${_Y}]
			JUZ:Set[${_Z}]
			JUYT:Set[${_YTarget}]
			JUFD:Set[${_FaceDegree}]
			JUGUC:Set[${_GiveUpCNT}]
			JU:Set[TRUE]
		}
	}
	method SetUISetting(... args)
	{
		variable int _count
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${This.ForWhoCheck[${args[${_count}]}]}
			{
				if ${args[${Math.Calc[${_count}+2]}].Equal[-1]} || ${args[${Math.Calc[${_count}+2]}].Upper.Equal[TOGGLE]}
				{
					if ${RI_Obj_CB.GetUISetting[${args[${Math.Calc[${_count}+1]}]}]}
						RI_Obj_CB:SetUISetting[${args[${Math.Calc[${_count}+1]}]},0]
					else
						RI_Obj_CB:SetUISetting[${args[${Math.Calc[${_count}+1]}]},1]
				}
				elseif ${args[${Math.Calc[${_count}+2]}].Equal[0]} || ${args[${Math.Calc[${_count}+2]}].Upper.Equal[OFF]}
				{
					RI_Obj_CB:SetUISetting[${args[${Math.Calc[${_count}+1]}]},0]
				}
				elseif ${args[${Math.Calc[${_count}+2]}].Equal[1]} || ${args[${Math.Calc[${_count}+2]}].Upper.Equal[ON]}
				{
					RI_Obj_CB:SetUISetting[${args[${Math.Calc[${_count}+1]}]},1]
				}
			}
			_count:Inc;_count:Inc
			
		}
	}
	method SetMoveBehind(... args)
	{
		variable bool _SkipMoveHealthCheck
		;string _ForWho=ALL, string _OnOffToggle=-1, int _MoveHealth=${RI_Obj_CB.GetUISetting[SettingsMoveHealthTextEntry]}, bool _SkipMoveHealthCheck=${RI_Obj_CB.GetUISetting[SettingsSkipMobMoveHealthCheckBox]}
		if ${Script[${RI_Var_String_CombatBotScriptName}](exists)}
		{
			variable int _count
			for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
			{
				_SkipMoveHealthCheck:Set[${args[${Math.Calc[${_count}+3]}]}]
				if ${This.ForWhoCheck[${args[${_count}]}]}
				{
					if ${args[${Math.Calc[${_count}+1]}].Equal[-1]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[TOGGLE]}
					{
						if ${RI_Obj_CB.GetUISetting[SettingsMoveBehindCheckBox]}
							RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,0]
						else
							RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,1]
						
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
					elseif ( ${args[${Math.Calc[${_count}+1]}].Equal[0]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[OFF]} )
					{
						RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,0]
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
					elseif ( ${args[${Math.Calc[${_count}+1]}].Equal[1]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[ON]} )
					{
						RI_Obj_CB:SetUISetting[SettingsMoveBehindCheckBox,1]
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
				}
				_count:Inc;_count:Inc;_count:Inc
			}
		}
	}
	method SetMoveInFront(... args)
	{
		variable bool _SkipMoveHealthCheck
		;string _ForWho=ALL, string _OnOffToggle=-1, int _MoveHealth=${RI_Obj_CB.GetUISetting[SettingsMoveHealthTextEntry]}, bool _SkipMoveHealthCheck=${RI_Obj_CB.GetUISetting[SettingsSkipMobMoveHealthCheckBox]}
		if ${Script[${RI_Var_String_CombatBotScriptName}](exists)}
		{
			variable int _count
			for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
			{
				_SkipMoveHealthCheck:Set[${args[${Math.Calc[${_count}+3]}]}]
				if ${This.ForWhoCheck[${args[${_count}]}]}
				{
					if ${args[${Math.Calc[${_count}+1]}].Equal[-1]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[TOGGLE]}
					{
						if ${RI_Obj_CB.GetUISetting[SettingsMoveInFrontCheckBox]}
							RI_Obj_CB:SetUISetting[SettingsMoveInFrontCheckBox,0]
						else
							RI_Obj_CB:SetUISetting[SettingsMoveInFrontCheckBox,1]
						
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
					elseif ( ${args[${Math.Calc[${_count}+1]}].Equal[0]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[OFF]} )
					{
						RI_Obj_CB:SetUISetting[SettingsMoveInFrontCheckBox,0]
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
					elseif ( ${args[${Math.Calc[${_count}+1]}].Equal[1]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[ON]} )
					{
						RI_Obj_CB:SetUISetting[SettingsMoveInFrontCheckBox,1]
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
				}
				_count:Inc;_count:Inc;_count:Inc
			}
		}
	}
	method SetMoveIn(... args)
	{
		variable bool _SkipMoveHealthCheck
		;string _ForWho=ALL, string _OnOffToggle=-1, int _MoveHealth=${RI_Obj_CB.GetUISetting[SettingsMoveHealthTextEntry]}, bool _SkipMoveHealthCheck=${RI_Obj_CB.GetUISetting[SettingsSkipMobMoveHealthCheckBox]}
		if ${Script[${RI_Var_String_CombatBotScriptName}](exists)}
		{
			variable int _count
			for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
			{
				_SkipMoveHealthCheck:Set[${args[${Math.Calc[${_count}+3]}]}]
				if ${This.ForWhoCheck[${args[${_count}]}]}
				{
					if ${args[${Math.Calc[${_count}+1]}].Equal[-1]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[TOGGLE]}
					{
						if ${RI_Obj_CB.GetUISetting[SettingsMoveInCheckBox]}
							RI_Obj_CB:SetUISetting[SettingsMoveInCheckBox,0]
						else
							RI_Obj_CB:SetUISetting[SettingsMoveInCheckBox,1]
						
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
					elseif ( ${args[${Math.Calc[${_count}+1]}].Equal[0]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[OFF]} )
					{
						RI_Obj_CB:SetUISetting[SettingsMoveInCheckBox,0]
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
					elseif ( ${args[${Math.Calc[${_count}+1]}].Equal[1]} || ${args[${Math.Calc[${_count}+1]}].Upper.Equal[ON]} )
					{
						RI_Obj_CB:SetUISetting[SettingsMoveInCheckBox,1]
						if ${Int[${args[${Math.Calc[${_count}+2]}]}]}>1 && ${Int[${args[${Math.Calc[${_count}+2]}]}]}<101
							RI_Obj_CB:SetUISetting[SettingsMoveHealthTextEntry,${Int[${args[${Math.Calc[${_count}+2]}]}]}]
						RI_Obj_CB:SetUISetting[SettingsSkipMobMoveHealthCheckBox,${_SkipMoveHealthCheck}]
					}
				}
				_count:Inc;_count:Inc;_count:Inc
			}
		}
	}
	member:bool MaintainedEffectExists(string _MaintainedEffect)
	{
		variable int Counter=1
		variable int NumMaintainedEffects

		NumMaintainedEffects:Set[${Me.CountMaintained}]
		;echo ${NumMaintainedEffects}
		if (${NumMaintainedEffects} > 0)
		{
			do
			{
				;echo checking ${Counter} of ${NumMaintainedEffects}: ${Me.Maintained[${Counter}].Name}
				if ${Me.Maintained[${Counter}].Name.Find[${_MaintainedEffect}](exists)}
				{
					return TRUE
				}
			}
			while (${Counter:Inc} <= ${NumMaintainedEffects})
			return FALSE
		}
		else
			return FALSE
	}
	member:int MainIconIDExists(int _ActorID, int _MainIconID, bool _Det=TRUE)
	{
		variable int Counter=1
		variable int NumActorEffects
		if ${_ActorID}==${Me.ID}
		{
			if ${_Det}
				NumActorEffects:Set[${Me.CountEffects[detrimental]}]
			else
				NumActorEffects:Set[${Me.CountEffects}]
				
			if (${NumActorEffects} > 0)
			{
				do
				{
					if ${_Det}
					{
						if ${Me.Effect[detrimental,${Counter}].MainIconID}==${_MainIconID}
						{
							return ${Counter}
						}
					}
					else
					{
						if ${Me.Effect[${Counter}].MainIconID}==${_MainIconID}
						{
							return ${Counter}
						}
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				return 0
			}
			else
				return 0
		}
		elseif (${Actor[id,${_ActorID}](exists)})
		{
			NumActorEffects:Set[${Actor[id,${_ActorID}].NumEffects}]
			
			if (${NumActorEffects} > 0)
			{
				do
				{
					if ${Actor[id,${_ActorID}].Effect[${Counter}].MainIconID}==${_MainIconID}
					{
						return ${Counter}
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				return 0
			}
			else
				return 0
		}
		else
			return 0
	}
	method RQEngage(string _Item)
	{
		;echo RQEngage(string _Item="${_Item}")
		if ${_Item.Find[|Repeatable](exists)}
			This:RQ["${_Item}"]
		else
			This:RQ["${_Item.Token[1,|]}"]
	}
	member:string RQCategory(string path)
	{
		variable int i=${Math.Calc[-1*(${path.Find["Quest/"]}+5)]}
		variable string editedPath=${path.Right[${i}]}
		variable int j=${Math.Calc[${editedPath.Find["/"]}-1]}
		return ${editedPath.Left[${j}]}
	}
	method RQCat(string _CatName=!NONE!)
	{
		if ${_CatName.Equal[!NONE!]}
			return
		else
		{
			UIElement[QuestsListBox@RI]:ClearItems
			;echo ${_CatName}
			if "${RI_CollectionString_RQQuests.FirstValue(exists)}"
			{
				do
				{
					if ${This.RQCategory[${RI_CollectionString_RQQuests.CurrentValue}].Equal[${_CatName}]} && ${RI_CollectionString_RQQuests.CurrentKey.NotEqual[""]}
					{
						if ${RI_CollectionString_RQQuests.CurrentKey.Find["Timeline"]}
							UIElement[QuestsListBox@RI]:AddItem["${RI_CollectionString_RQQuests.CurrentKey}","${RI_CollectionString_RQQuests.CurrentValue}",FFE8E200]
						elseif ${_TempString.Find["Mission"]}
							UIElement[QuestsListBox@RI]:AddItem["${RI_CollectionString_RQQuests.CurrentKey}","${RI_CollectionString_RQQuests.CurrentValue}",FF00b33c]
						else
							UIElement[QuestsListBox@RI]:AddItem["${RI_CollectionString_RQQuests.CurrentKey}","${RI_CollectionString_RQQuests.CurrentValue}"]
					}
				}
				while "${RI_CollectionString_RQQuests.NextKey(exists)}"
			}
		}
	}
	method RQ(... args)
	{
		if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
			return

		variable string _QuestName=""
		variable int i=0
		for(i:Set[1];${i}<=${args.Used};i:Inc)
		{
			_QuestName:Concat[${args[${i}]}]
			if ${i}!=${args.Used}
			_QuestName:Concat[" "];
		}

		if ${_QuestName.Equal[""]}
		{
			RI_CMD_Hidden_ScanQuests
			;RI_CollectionString_RQQuests:Clear
			;load RI ui and change 
			ui -reload "${RI_Var_String_SkinFileName}"
			ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
		
			UIElement[Start@RI]:Hide
			UIElement[AutoLoot@RI]:Hide
			UIElement[RI]:SetHeight[378]
			UIElement[RI]:SetWidth[302]
			UIElement[QuestsListBox@RI]:Show
			UIElement[RunButton@RI]:Show
			UIElement[CategoryText@RI]:Show
			UIElement[CategoryComboBox@RI]:Show

			UIElement[RI]:SetTitle[RQv${RI_Var_Float_Version.Precision[2]}]

			declare _cnt int 0
   			declare _DirList filelist
    		ScanDirectory:Set["${LavishScript.HomeDirectory}//Scripts//RI//Quest//"]
    		_DirList:GetDirectories[${ScanDirectory}\\*]

			while (${_cnt:Inc}<=${_DirList.Files})
			{
				UIElement[CategoryComboBox@RI]:AddItem[${_DirList.File[${_cnt}].Filename}]
				;UIElement[CategoryComboBox@RI]:SelectItem[${UIElement[CategoryComboBox@RI].ItemByText[${_DirList.File[${_cnt}].Filename}].ID}]
				;This:RQCat["${_DirList.File[${_cnt}].Filename}"]
			}
			UIElement[CategoryComboBox@RI]:SelectItem[${UIElement[CategoryComboBox@RI].ItemByText[${_DirList.File[1].Filename}].ID}]
			;UIElement[QuestsListBox@RI].OrderedItem[]:SetTextColor[FF5DA5CF]
			;UIElement[QuestsListBox@RI].OrderedItem[]:SetTextColor[FFE8E200]
		}
		elseif ${_QuestName.Equal[QUIT]}
		{
			;changeui back to standard ri then close it
			;ui -reload "${RI_Var_String_SkinFileName}"
			;ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
			UIElement[Start@RI]:Show
			UIElement[Start@RI]:SetText[Start]
			UIElement[AutoLoot@RI]:Show
			UIElement[RI]:SetHeight[60]
			UIElement[RI]:SetWidth[102]
			UIElement[QuestsListBox@RI]:Hide
			UIElement[RunButton@RI]:Hide
			ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
		}
		else
		{
			echo ISXRI: Starting quest ${_QuestName} with RI
			RI_RunInstances "QUEST-${_QuestName}"
			;change ui back to standard UI
			UIElement[Start@RI]:Show
			UIElement[AutoLoot@RI]:Show
			UIElement[RI]:SetHeight[60]
			UIElement[RI]:SetWidth[102]
			UIElement[QuestsListBox@RI]:Hide
			UIElement[RunButton@RI]:Hide
			TimedCommand 5 UIElement[Start@RI]:SetText[Pause]
			TimedCommand 5 RI_Var_Bool_Start:Set[TRUE]
		}
	}
	method DisplayStats(... _Stats)
	{
		if ${EQ2.Zoning}==0
		{
			variable int _count
			variable string temp
			for(_count:Set[1];${_count}<=${_Stats.Used};_count:Inc)
			{
				if ${Me.GetGameData[Stats.${_Stats[${_count}]}].Label(exists)} && ${Me.GetGameData[Stats.${_Stats[${_count}]}].Label.NotEqual[""]}
					relay all echo ISXRI: ${_Stats[${_count}]}: \${Me.Name}: \${Me.GetGameData[Stats.${_Stats[${_count}]}].Label}
				elseif ${Me.GetGameData[Stats.${_Stats[${_count}]}].Percent(exists)}
					relay all echo ISXRI: ${_Stats[${_count}]}: \${Me.Name}: \${Me.GetGameData[Stats.${_Stats[${_count}]}].Percent}
				elseif ${Me.GetGameData[Self.${_Stats[${_count}]}].Label(exists)} && ${Me.GetGameData[Self.${_Stats[${_count}]}].Label.NotEqual[""]}
					relay all echo ISXRI: ${_Stats[${_count}]}: \${Me.Name}: \${Me.GetGameData[Self.${_Stats[${_count}]}].Label}
				elseif ${Me.GetGameData[Self.${_Stats[${_count}]}].Percent(exists)}
					relay all echo ISXRI: ${_Stats[${_count}]}: \${Me.Name}: \${Me.GetGameData[Self.${_Stats[${_count}]}].Percent}
			}
		}
	}
	member(string) DisplayStat(string _Stat)
	{
		if ${Me.GetGameData[Stats.${_Stat}].Label(exists)} && ${Me.GetGameData[Stats.${_Stat}].Label.NotEqual[""]}
			return ${Me.GetGameData[Stats.${_Stat}].Label}
		elseif ${Me.GetGameData[Stats.${_Stat}].Percent(exists)}
			return ${Me.GetGameData[Stats.${_Stat}].Percent}
		elseif ${Me.GetGameData[Self.${_Stat}].Label(exists)} && ${Me.GetGameData[Self.${_Stat}].Label.NotEqual[""]}
			return ${Me.GetGameData[Self.${_Stat}].Label}
		elseif ${Me.GetGameData[Self.${_Stat}].Percent(exists)}
			return ${Me.GetGameData[Self.${_Stat}].Percent}
	}
	method GuidedAscension(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${Me.Inventory[Query, Location=="Inventory" && Name=="Guided Ascension"](exists)} && ${Me.Inventory[Query, Location=="Inventory" && Name=="Guided Ascension"].IsReady}
				Me.Inventory[Query, Location=="Inventory" && Name=="Guided Ascension"]:Use
		}
	}
	method ScribeBook(string ForWho=ALL, string BookName)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${Me.Inventory[Query, Location=="Inventory" && Name=-"${BookName}"](exists)}
				Me.Inventory[Query, Location=="Inventory" && Name=-"${BookName}"]:Scribe
		}
	}
	method FastTravel(string ForWho=ALL, string ZoneName=~NONE~, string _DoorOption=0)
	{
		;echo FastTravel(string ForWho=${ForWho}, string ZoneName=${ZoneName}, string _DoorOption=${_DoorOption})
		EQ2:OpenFastTravelWindow
		TimedCommand 10 TravelMapWindow.Buttons.Child[${ZoneName}]:LeftClick
		TimedCommand 20 EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[1]:LeftClick
		if ${Int[${_DoorOption}]}>0 || ${_DoorOption.NotEqual[0]}
		{
			TimedCommand 30 RIMUIObj:Door[ALL,${_DoorOption}]
		}
		TimedCommand 40 ChoiceWindow:DoChoice1
	}
	;OLD Method
	;method FastTravel(string ForWho=ALL, string ZoneName=~NONE~, string _DoorOption=0)
	;{
	;	;echo FastTravel(string ForWho=${ForWho}, string ZoneName=${ZoneName}, string _DoorOption=${_DoorOption})
	;	if !${EQ2UIPage[Popup,TravelMap].IsVisible}
	;	{
	;		eq2ex /smp pon pon_teleport
	;		TimedCommand 5 RIMUIObj:FastTravel[${Me.Name},${ZoneName},${_DoorOption}]
	;	 	return
			; Actor[mariners_bell]:DoubleClick
			; Actor[mariner_bell_city_travel_qeynos]:DoubleClick
			; Actor[zone_to_guildhall_tier3]:DoubleClick
			; Actor[Zone to Friend]:DoubleClick
			; Actor[flight_cloud_large_1_to_medium_1]:DoubleClick
			; Actor[mariner_bell_city_travel_freeport]:DoubleClick
			; Actor["Ole Salt's Mariner Bell"]:DoubleClick
			; Actor["Navigator's Globe of Norrath"]:DoubleClick
			; Actor["Pirate Captain's Helmsman"]:DoubleClick
			; TimedCommand 10 RIMUIObj:TravelMap[${ForWho},${ZoneName},${ZoneOption}]
			; return
	;	}
	;	else
	;	{
	;		variable int TMCount
	;		for(TMCount:Set[1];${TMCount}<=${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].NumChildren};TMCount:Inc)
	;		{
				;echo Checking #${TMCount} <= ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].NumChildren} ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}].GetProperty[Name]} against ${ZoneName} // ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}].GetProperty[Name].Find[${ZoneName}](exists)}
	;			if ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}].GetProperty[Name].Find[${ZoneName}](exists)}
	;			{
	;				EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}]:LeftClick
	;				TimedCommand 5 EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[1]:LeftClick
	;				if ${Int[${_DoorOption}]}>0 || ${_DoorOption.NotEqual[0]}
	;				{
	;					TimedCommand 10 RIMUIObj:Door[ALL,${_DoorOption}]
	;				}
	;				TimedCommand 20 ChoiceWindow:DoChoice1
					;click zone option if it exists
					;if ${ZoneOption}>-1
					;	TimedCommand 30 RIMUIObj:Door[${Me.Name},${ZoneOption}]
	;				return
	;			}
	;		}
	;	}
	;	TimedCommand 10 EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[2]:LeftClick
	;}
	method TravelMap(string ForWho=ALL, string ZoneName=~NONE~, int ZoneOption=-1, int _BellWizardDruid=0)
	{
		;echo TravelMap(string ForWho=${ForWho}=ALL, string ZoneName=${ZoneName}=~NONE~, int ZoneOption=${ZoneOption}=-1, int _BellWizardDruid=${_BellWizardDruid}=0)
		if ${ZoneName.Equal[~NONE~]}
			return
		if ${_BellWizardDruid}>0
		{
			if ${_BellWizardDruid}==1
			{
				Actor[mariners_bell]:DoubleClick
				Actor[mariner_bell_city_travel_qeynos]:DoubleClick
				Actor[zone_to_guildhall_tier3]:DoubleClick
				Actor[Zone to Friend]:DoubleClick
				Actor[flight_cloud_large_1_to_medium_1]:DoubleClick
				Actor[mariner_bell_city_travel_freeport]:DoubleClick
				Actor["Ole Salt's Mariner Bell"]:DoubleClick
				Actor["Navigator's Globe of Norrath"]:DoubleClick
				Actor["Pirate Captain's Helmsman"]:DoubleClick
				Actor["Explorer's Globe of Norrath"]:DoubleClick
				TimedCommand 10 RIMUIObj:TravelMap[${ForWho},${ZoneName},${ZoneOption}]
			}
			elseif ${_BellWizardDruid}==2
			{
				Actor["Ulteran Spire"]:DoubleClick
				TimedCommand 10 RIMUIObj:TravelMap[${ForWho},${ZoneName},${ZoneOption}]
			}
			elseif ${_BellWizardDruid}==3
			{
				Actor[guild,"Guild Portal Druid"]:DoFace
				Actor[guild,"Guild Portal Druid"]:DoTarget
				TimedCommand 5 eq2ex hail
				TimedCommand 10 EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
				TimedCommand 20 Actor[tcg_druid_portal]:DoubleClick
				TimedCommand 30 RIMUIObj:TravelMap[${ForWho},${ZoneName},${ZoneOption}]
			}
			return
		}
		if !${EQ2UIPage[Popup,TravelMap].IsVisible}
		 	return
			; Actor[mariners_bell]:DoubleClick
			; Actor[mariner_bell_city_travel_qeynos]:DoubleClick
			; Actor[zone_to_guildhall_tier3]:DoubleClick
			; Actor[Zone to Friend]:DoubleClick
			; Actor[flight_cloud_large_1_to_medium_1]:DoubleClick
			; Actor[mariner_bell_city_travel_freeport]:DoubleClick
			; Actor["Ole Salt's Mariner Bell"]:DoubleClick
			; Actor["Navigator's Globe of Norrath"]:DoubleClick
			; Actor["Pirate Captain's Helmsman"]:DoubleClick
			; TimedCommand 10 RIMUIObj:TravelMap[${ForWho},${ZoneName},${ZoneOption}]
			; return
		; }
		; else
		; {
			variable int TMCount
			for(TMCount:Set[1];${TMCount}<=${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].NumChildren};TMCount:Inc)
			{
				;echo Checking #${TMCount} <= ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].NumChildren} ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}].GetProperty[Name]} against ${ZoneName} // ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}].GetProperty[Name].Find[${ZoneName}](exists)}
				if ${EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}].GetProperty[Name].Find[${ZoneName}](exists)}
				{
					EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[3].Child[1].Child[3].Child[${TMCount}]:LeftClick
					TimedCommand 5 EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[1]:LeftClick
					;click zone option if it exists
					if ${ZoneOption}>-1
						TimedCommand 30 RIMUIObj:Door[${Me.Name},${ZoneOption}]
					return
				}
			}
		;}
		TimedCommand 10 EQ2UIPage[Popup,TravelMap].Child[Page,TravelMap].Child[2]:LeftClick
	}
	variable int NumFactions=0
	variable int TrueFactionCount=1
	variable int FactionCount
	variable bool FactionsInitializing=FALSE
	function InitializeFactions(string Pass=NONE)
	{
		FactionsInitializing:Set[TRUE]
		;this opens every faction dropdown
		eq2ex TOGGLEPERSONA
		wait 5
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,6]:SetProperty[visible,TRUE]
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,2]:SetProperty[visible,FALSE]
		wait 5
		variable index:collection:string test
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,6].Child[Page,2]:GetOptions[test]
		
		variable int count
		for(count:Set[0];${count}<${test.Used};count:Inc)
		{
			EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,6].Child[Page,2]:Set[${count}]
			wait 5
		}
		wait 5
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,6]:SetProperty[visible,FALSE]
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,2]:SetProperty[visible,TRUE]
		wait 5
		eq2ex TOGGLEPERSONA
		NumFactions:Set[${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].NumChildren}]
		;if ${Pass.Equal[IF]}
		;	echo ISXRI: Done Initializing Factions
		if ${Pass.Equal[DAF]}
			This:DisplayAllFactions
		FactionsInitializing:Set[FALSE]
	}
	
	
	;;;;; need to finish this
	function InitializeCurrency(string Pass=NONE)
	{
		CurrencyInitializing:Set[TRUE]
		;this opens every faction dropdown
		eq2ex TOGGLEPERSONA
		wait 5
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,13]:SetProperty[visible,TRUE]
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,2]:SetProperty[visible,FALSE]
		wait 5
		variable index:collection:string test
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,13].Child[Page,2]:GetOptions[test]
		
		variable int count
		for(count:Set[0];${count}<${test.Used};count:Inc)
		{
			EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,13].Child[Page,2]:Set[${count}]
			wait 5
		}
		wait 5
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,13]:SetProperty[visible,FALSE]
		EQ2UIPage[MainHUD,Persona].Child[Page,MainPage].Child[Page,2]:SetProperty[visible,TRUE]
		wait 5
		eq2ex TOGGLEPERSONA
		NumCurrency:Set[${EQ2UIPage[Mainhud,Persona].Child[page,Persona.MainPage.CurrencyPage.currencylist.scrollpage].NumChildren}]
		;if ${Pass.Equal[IF]}
		;	echo ISXRI: Done Initializing Factions
		if ${Pass.Equal[DAC]}
			This:DisplayAllCurrency
		CurrencyInitializing:Set[FALSE]
	}
	method TravelMapPop(string TForWho, string ForWho=~NONE~)
	{
		if ${This.ForWhoCheck[${TForWho}]}
		{
			PopForWho:Set[${ForWho}]
			RI_Atom_TravelMapPop
		}
	}
	method FastTravelPop(string TForWho, string ForWho=~NONE~)
	{
		;echo method FastTravelPop(string TForWho=${TForWho}, string ForWho=${ForWho}=~NONE~)
		if ${This.ForWhoCheck[${TForWho}]}
		{
			PopForWho:Set[${ForWho}]
			RI_Atom_FastTravelPop
		}
	}
	method InitializeFactions(string ForWho=ALL)
	{
	;, bool Verbose=FALSE
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if !${FactionsInitializing}
			{
				; if ${Verbose}
				; {
					; echo ISXRI: Initializing Factions, this can take a minute or two please be patient
					; FactionsPass:Set[IF]
				; }
				; else
					FactionsPass:Set[NONE]
				FactionsInit:Set[TRUE]
			}
		}
	}
	method DisplayAllFactions(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${NumFactions}==0
			{
				FactionsInit:Set[TRUE]
				FactionsPass:Set[DAF]
				return
			}
			echo ISXRI: Factions:
			variable int FactionCount
			for(FactionCount:Set[1];${FactionCount}<=${NumFactions};FactionCount:Inc)
			{
				if ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,1].GetProperty[Text].NotEqual[NULL]}
				{
					TrueFactionCount:Inc
					echo Faction: ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,1].GetProperty[Text]} Value: ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,2].GetProperty[Text].Replace[",",""]} KOS: ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,3].GetProperty[Text]}
				}
			}
			if ${TrueFactionCount} < ${FactionCount} 
				echo ISXRI: ${Math.Calc[${FactionCount}-${TrueFactionCount}].Precision[0]} Factions are unreadable without scrolling, if your faction is not listed go into persona window and factions and goto each dropdown and scroll all the way down
			TrueFactionCount:Set[1]
		}
	}
	member(bool) FactionsInitialized()
	{
		if ${NumFactions}==0
		{
			if !${FactionsInitializing}
			{
				FactionsInit:Set[TRUE]
				FactionsPass:Set[NONE]
			}
			return FALSE
		}
		else
			return TRUE
	}
	member(string) FactionName(int _IndexPosition)
	{
		if ${NumFactions}==0
		{
			FactionsInit:Set[TRUE]
			return -1
		}
		
		return ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${_IndexPosition}].Child[Text,1].GetProperty[Text]}
	}
	member(int) FactionAmount(string _FactionName)
	{
		if ${NumFactions}==0
		{
			FactionsInit:Set[TRUE]
			return -1
		}
		for(FactionCount:Set[1];${FactionCount}<=${NumFactions};FactionCount:Inc)
		{
			if ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,1].GetProperty[Text].NotEqual[NULL]}
			{
				if ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,1].GetProperty[Text].Upper.Equal[${_FactionName.Upper}]}
					return ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,2].GetProperty[Text].Replace[",",""]}
			}
		}
		return 0
	}
	member(string) FactionKOS(string _FactionName)
	{
		if ${NumFactions}==0
		{
			FactionsInit:Set[TRUE]
			return -1
		}
		for(FactionCount:Set[1];${FactionCount}<=${NumFactions};FactionCount:Inc)
		{
			if ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,1].GetProperty[Text].NotEqual[NULL]}
			{
				if ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,1].GetProperty[Text].Upper.Equal[${_FactionName.Upper}]}
					return ${EQ2UIPage[MainHUD,Persona].Child[Page,MainPage.Factions].Child[Page,3].Child[Composite,1].Child[Page,1].Child[Composite,1].Child[Page,${FactionCount}].Child[Text,3].GetProperty[Text]}
			}
		}
		return 0
	}
	;method to connect pc's to the uplink
	method UplinkConnect(... args)
	{
		if ${This.ForWhoCheck[${Me.Name}]}
		{
			variable int _count
			for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
			{
				TimedCommand 0 echo ISXRI: connecting ${args[${_count}]} to the uplink
				uplink remote -connect ${args[${_count}]}
			}
		}
	}
	;method to connect pc's to the uplink
	method UplinkDisconnect(... args)
	{
		if ${This.ForWhoCheck[${Me.Name}]}
		{
			variable int _count
			for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
			{
				TimedCommand 0 echo ISXRI: disconnecting ${args[${_count}]} from the uplink
				uplink remote -disconnect ${args[${_count}]}
			}
		}
	}
	;method to connect pc's to the uplink
	method BalanceTrash(bool On)
	{
		;echo ISXRI: connecting ${PCName} to the uplink
		if ${On}
			TimedCommand 1 echo ISXRI: Turning on RunInstances balance trash health
		else
			TimedCommand 1 echo ISXRI: Turning off RunInstances balance trash health
		RI_Var_Bool_BalanceTrash:Set[${On}]
	}
	;method to list connected pc's on the uplink
	method UplinkList()
	{
		TimedCommand 0 echo ISXRI: List of PC's on the Uplink:
		uplink remote -list
	}
	method GuildBuffs(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			TimedCommand 1 echo ISXRI: Starting GuildBuffs
			variable int Waiter
			Waiter:Set[5]
			if ${Actor[Query, Name=="Altar of the Ancients" && Distance<=5](exists)}
			{
				TimedCommand ${Waiter} echo ISXRI: Clicking Altar of the Ancients
				TimedCommand ${Waiter} Actor[Query, Name=="Altar of the Ancients" && Distance<=5]:DoubleClick
				Waiter:Set[${Math.Calc[${Waiter}+45]}]
			}
			if ${Actor[Query, Name=="Arcanna'se Effigy of Rebirth" && Distance<=5](exists)}
			{
				TimedCommand ${Waiter} echo ISXRI: Clicking Arcanna'se Effigy of Rebirth
				TimedCommand ${Waiter} Actor[Query, Name=="Arcanna'se Effigy of Rebirth" && Distance<=5]:DoubleClick
				Waiter:Set[${Math.Calc[${Waiter}+50]}]
			}
			if ${Actor[Query, Name=="Heartstone" && Distance<=5](exists)}
			{
				TimedCommand ${Waiter} echo ISXRI: Clicking Heartstone
				TimedCommand ${Waiter} eq2ex apply_verb ${Actor[Heartstone].ID} Rekindle
				Waiter:Set[${Math.Calc[${Waiter}+50]}]
			}
			if ${Actor[Query, Guild=="Stable Hand" && Distance<=9](exists)}
			{
				TimedCommand ${Waiter} echo ISXRI: Hailing Stable Hand
				TimedCommand ${Waiter} eq2ex apply_verb ${Actor[Query, Guild=="Stable Hand" && Distance<=9].ID} hail
				Waiter:Set[${Math.Calc[${Waiter}+50]}]
			}
			; if ${Actor["Altar of the Ancients"].Distance} <= 5
				; {
					; eq2execute apply_verb ${Actor["Altar of the Ancients"].ID} Pray at the altar
					; wait 40
				; }
			if ${Actor[Query, Name=="Blessed Sapling" && Distance <=5](exists)}
			{
				TimedCommand ${Waiter} echo ISXRI: Clicking Blessed Sapling
				TimedCommand ${Waiter} Actor[Query, Name=="Blessed Sapling" && Distance <=5]:DoubleClick
				Waiter:Set[${Math.Calc[${Waiter}+50]}]
			}
			if ${Actor[Query, Name=="Mug of Fulfillment" && Distance<=5](exists)}
			{
				TimedCommand ${Waiter} echo ISXRI: Clicking Mug of Fulfillment
				TimedCommand ${Waiter} eq2ex apply_verb ${Actor[Query, Name=="Mug of Fulfillment" && Distance<=5].ID} use
				Waiter:Set[${Math.Calc[${Waiter}+50]}]
			}
			TimedCommand 1 echo ISXRI: Should take ${Int[${Math.Calc[${Waiter}/10]}]}s please do not move until done
			TimedCommand ${Waiter} echo ISXRI: Done With GuildBuffs
		}
	}
	method AutoLoot(string ForWho=_ALL, int _Options=0)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.IsGroupLeader}
		{
			;open group options window
			eq2ex groupoptions
			TimedCommand 10 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.PersonalPage.AutoLootCombo]:Set[${_Options}]
			TimedCommand 15 EQ2UIPage[popup,groupoptions].Child[Button,GroupOptions.ApplyButton]:LeftClick
		}
	}
	;script to change loot options
	method LootOptions(string ForWho=ALL, string Options)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.IsGroupLeader}
		{
			;open group options window
			eq2ex groupoptions
			
			;switch which options was requested
			switch ${Options.Upper}
			{
				case LO
				case LEADERONLY
				{
					TimedCommand 10 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[0]
					break
				}
				case FFA
				case FREEFORALL
				{
					TimedCommand 10 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[1]
					break
				}
				case L
				case LOTTO
				{
					TimedCommand 10 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[2]
					break
				}
				case NBG
				case NEEDBEFOREGREED
				{
					TimedCommand 10 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[3]
					break
				}
				case RR
				case ROUNDROBIN
				{
					TimedCommand 10 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.LootMethodCombo]:Set[4]
					break
				}
			}
			;set to all items
			TimedCommand 11 EQ2UIPage[popup,groupoptions].Child[DropDownBox,GroupOptions.LootPage.ItemTierCombo]:Set[0]
			
			;press Apply
			TimedCommand 16 EQ2UIPage[popup,groupoptions].Child[Button,GroupOptions.ApplyButton]:LeftClick
		}
	}
	method AddArgumentBTN()
	{
		if ( ${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Find[" "](exists)} || ${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Find["["](exists)} || ${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Find["]"](exists)} || ${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Find[","](exists)})	
		{
			;echo space,[,]or , exists
			if ( ${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Left[1].Equal["\""]} && ${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Right[1].Equal["\""]} )
			{
				;echo already has \"\"
				UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem[${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Escape}]
			}
			else
			{
				UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem[\"${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Escape}\"]
				;echo doesnt have \"\"
			}
		}
		else
			UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem[${UIElement[AddArgumentTXTEntry@RIMUIEdit].Text.Escape}]
		
		UIElement[AddArgumentTXTEntry@RIMUIEdit]:SetText[]
	}
	method LoadRIMovement()
	{
		execute ${If[${Script[Buffer:RIMovement](exists)},noop,RIMovement]}
	}
	method MC(... argv)
	{
		variable int count=0
		for(count:Set[1];${count}<=${argv.Used};count:Inc)
		{	
			if ${argv[${count}].Left[5].Upper.Equal[RELAY]}
			{
				variable int leftnum
				leftnum:Set[${Math.Calc[6+${argv[${count}].Right[-6].Find[" "]}]}]
				noop ${Execute[${argv[${count}].Left[${leftnum}]} "${argv[${count}].Right[${Math.Calc[-1*${leftnum}]}]}"]}
			}
			else
				noop ${Execute["${argv[${count}]}"]}
		
			;noop ${Execute["${argv[${count}]}"]}
		}
	}
	method RelayCharacterName(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Name(exists)}
		{
			relay ALL RIMUIObj:RelayCharacterNameResponse[${Me.Name}]
		}
	}
	method RelayCharacterNameResponse(string _Name)
	{
		variable int _count=0
		variable bool _AlreadyExists=FALSE
		for(_count:Set[1];${_count}<=${GroupNames.Used};_count:Inc)
		{
			if ${_Name.Equal[${GroupNames.Get[${_count}]}]}
				_AlreadyExists:Set[1]
		}
		if !${_AlreadyExists}
			GroupNames:Insert[${_Name}]
	}
	method RelayBalancedSynergy(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Name(exists)}
		{
			;echo RBS
			RI_Var_Int_BSReadyCount:Set[0]
			relay ALL RIMUIObj:BalancedSynergy[~IGW~${Me.Name}]
		}
	}
	method BalancedSynergy(string ForWho)
	{
		;echo BS
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Name(exists)}
		{
			relay ALL RIMUIObj:BalancedSynergyResponse[~IGW~${Me.Name},${Me.Ability[id,1643224411].IsReady}]
		}
	}
	method BalancedSynergyResponse(string ForWho, bool _ISR=FALSE)
	{
		;echo BSR: ${ForWho} , ${_ISR}
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Name(exists)}
		{
			if ${_ISR}
				RI_Var_Int_BSReadyCount:Inc
		}
	}
	method Invite(... argv)
	{
		if ${This.ForWhoCheck[${argv[1]}]}
		{
			variable int _count=0
			variable int _waiter=0
			if ${argv.Used}<2 || ${argv[2].Equal[*INVITE*]}
			{
				if ${argv.Used}<2
				{
					GroupNames:Clear
					relay ALL RIMUIObj:RelayCharacterName[ALL]
					TimedCommand 4 RIMUIObj:Invite[${argv[1]},*INVITE*]
					return
				}
				_waiter:Set[0]
				for(_count:Set[1];${_count}<=${GroupNames.Used};_count:Inc)
				{	
					_waiter:Inc
					if ${_count}==7 || ${_count}==13 || ${_count}==19
					{
						_waiter:Inc[5]
						TimedCommand ${_waiter} eq2ex raidinvite ${GroupNames.Get[${_count}]}
					}
					else
						TimedCommand ${_waiter} eq2ex invite ${GroupNames.Get[${_count}]}
				}
			}
			else
			{
				_waiter:Set[0]
				for(_count:Set[2];${_count}<=${argv.Used};_count:Inc)
				{	
					_waiter:Inc
					if ${_count}==7 || ${_count}==13 || ${_count}==19
					{
						_waiter:Inc[5]
						TimedCommand ${_waiter} eq2ex raidinvite ${argv[${_count}]}
					}
					else
						TimedCommand ${_waiter} eq2ex invite ${argv[${_count}]}
				}
			}
		}
	}
	method MultipleCommands(... argv)
	{
		if ${This.ForWhoCheck[${argv[1]}]}
		{
			;echo MultipleCommands
			variable int count=0
			for(count:Set[2];${count}<=${argv.Used};count:Inc)
			{
				;echo execute ${argv[${count}]}
				if ${argv[${count}].Left[5].Upper.Equal[RELAY]}
				{
					variable int leftnum
					leftnum:Set[${Math.Calc[6+${argv[${count}].Right[-6].Find[" "]}]}]
					noop ${Execute[${argv[${count}].Left[${leftnum}]} "${argv[${count}].Right[${Math.Calc[-1*${leftnum}]}]}"]}
				}
				else
					noop ${Execute["${argv[${count}]}"]}
				;noop ${Execute["${argv[${count}]}"]}
			}
		}
	}
	
	method StopMove(string ForWho=ALL)
	{
		;load RIMovement
		This:LoadRIMovement
		
		;StopMove
		if ${ForWho.Upper.Find[~Not~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}
		if ${ForWho.Upper.Find[~AllBut~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}
		
		RI_Atom_SetLockSpot ${ForWho} OFF
		RI_Atom_SetRIFollow ${ForWho} OFF
		press -release ${RI_Var_String_ForwardKey}
		press -release ${RI_Var_String_FlyUpKey}
		press -release ${RI_Var_String_FlyDownKey}
		;if we are following in game, stop following
		if ${Me.WhoFollowingID} != -1 && !${StopFollow}
			eq2ex stopfollow
	}
	method ComeOn(string ForWho=ALL)
	{
		;load RIMovement
		This:LoadRIMovement
		
		;ComeOn
		if ${ForWho.Upper.Find[~Not~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}
		if ${ForWho.Upper.Find[~AllBut~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]	
		}
		
		RI_Atom_SetLockSpot ${ForWho} OFF
	}
	method SetRIFollow(string ForWho=ALL, string OnWho=OFF, int Min=1, int Max=100)
	{
		;load RIMovement
		This:LoadRIMovement
		
		;SetRIFollow
		if ${ForWho.Upper.Find[~Not~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}
		if ${ForWho.Upper.Find[~AllBut~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}
		
		RI_Atom_SetRIFollow ${ForWho} ${Actor[PC,${OnWho}].ID} ${Min} ${Max}
	}
	method SetLockSpot(... args)
	{
		;string ForWho=ALL, string X=${Me.X}, float Y=${Me.Y}, float Z=${Me.Z}, int Min=1, int Max=100
		;load RIMovement
		This:LoadRIMovement
		
		variable int _count
		for(_count:Set[1];${_count}<=${args.Used};_count:Inc)
		{
			if ${args[${_count}].Upper.Equal[OFF]}
				RI_Atom_SetLockSpot OFF
			elseif ${This.ForWhoCheck[${args[${_count}]}]}
;			&& ${args[${_count}].Upper.Equal[ALL]}
				RI_Atom_SetLockSpot ALL ${If[${args[${Math.Calc[${_count}+1]}](exists)},${args[${Math.Calc[${_count}+1]}]},${Me.X}]} ${If[${args[${Math.Calc[${_count}+2]}](exists)},${args[${Math.Calc[${_count}+2]}]},${Me.Y}]} ${If[${args[${Math.Calc[${_count}+3]}](exists)},${args[${Math.Calc[${_count}+3]}]},${Me.Z}]} ${If[${args[${Math.Calc[${_count}+4]}](exists)},${args[${Math.Calc[${_count}+4]}]},1]} ${If[${args[${Math.Calc[${_count}+5]}](exists)},${args[${Math.Calc[${_count}+5]}]},1000]}
;			elseif ${This.ForWhoCheck[${args[${_count}]}]}
;				RI_Atom_SetLockSpot ${Me.Name} ${If[${args[${Math.Calc[${_count}+1]}](exists)},${args[${Math.Calc[${_count}+1]}]},${Me.X}]} ${If[${args[${Math.Calc[${_count}+2]}](exists)},${args[${Math.Calc[${_count}+2]}]},${Me.Y}]} ${If[${args[${Math.Calc[${_count}+3]}](exists)},${args[${Math.Calc[${_count}+3]}]},${Me.Z}]} ${If[${args[${Math.Calc[${_count}+4]}](exists)},${args[${Math.Calc[${_count}+4]}]},1]} ${If[${args[${Math.Calc[${_count}+5]}](exists)},${args[${Math.Calc[${_count}+5]}]},100]}			
			_count:Inc;_count:Inc;_count:Inc;_count:Inc;_count:Inc
		}
	}
	method SetLockSpotOLD(string ForWho=ALL, string X=${Me.X}, float Y=${Me.Y}, float Z=${Me.Z}, int Min=1, int Max=100)
	{
		;load RIMovement
		This:LoadRIMovement
		
		;SetLS
		if ${ForWho.Upper.Find[~Not~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}
		if ${ForWho.Upper.Find[~AllBut~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				return
			else
				ForWho:Set[ALL]
		}

		RI_Atom_SetLockSpot ${ForWho} ${X} ${Y} ${Z} ${Min} ${Max}
	}
	method PauseBot(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			RI_CMD_PauseCombatBots 1
			;RI_CMD_PauseRI ${pOnOff}
			;RI_CMD_PauseRIMovement 1
		}
	}
	method ResumeBot(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			RI_CMD_PauseCombatBots 0
			;RI_CMD_PauseRI ${pOnOff}
			;RI_CMD_PauseRIMovement 0
		}
	}
	method PauseRIM(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			;RI_CMD_PauseCombatBots 1
			;RI_CMD_PauseRI ${pOnOff}
			RI_CMD_PauseRIMovement 1
		}
	}
	method ResumeRIM(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			;RI_CMD_PauseCombatBots 0
			;RI_CMD_PauseRI ${pOnOff}
			RI_CMD_PauseRIMovement 0
		}
	}
	method PauseRI(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			;RI_CMD_PauseCombatBots 1
			RI_CMD_PauseRI 1
			;RI_CMD_PauseRIMovement 1
		}
	}
	method ResumeRI(string ForWho=ALL)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			;RI_CMD_PauseCombatBots 0
			RI_CMD_PauseRI 0
			;RI_CMD_PauseRIMovement 0
		}
	}
	method Cast(... args)
	{
		;string ForWho, string cSpellName, int cCancelCast
		;${args[${_count}]}
		;${args[${Math.Calc[${_count}+1]}]}   
		;${args[${Math.Calc[${_count}+2]}]}
		variable int _count=0
		for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
		{
			if ${This.ForWhoCheck[${args[${_count}]}]}
				RI_CMD_Cast "${args[${Math.Calc[${_count}+1]}]}" ${args[${Math.Calc[${_count}+2]}]}
			_count:Inc
			_count:Inc
		}
	}
	method CastOn(... args)
	{
		;string ForWho, string coSpellName, string coCastName, int coCancelCast
		;${args[${_count}]}
		;${args[${Math.Calc[${_count}+1]}]}   
		;${args[${Math.Calc[${_count}+2]}]}
		;${args[${Math.Calc[${_count}+3]}]}
		variable int _count=0
		for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
		{
			if ${This.ForWhoCheck[${args[${_count}]}]}
				RI_CMD_CastOn "${args[${Math.Calc[${_count}+1]}]}" ${args[${Math.Calc[${_count}+2]}]} ${args[${Math.Calc[${_count}+3]}]}
			_count:Inc
			_count:Inc
			_count:Inc
		}
		;if ${This.ForWhoCheck[${ForWho}]}
		;	RI_CMD_CastOn "${coSpellName}" ${coCastName} ${coCancelCast}
	}
	method Assist(string ForWho, int OnOff, string OnWho)
	{
		;echo Assist: ${OnOff} For: ${ForWho} On ${OnWho}
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${OnOff}==1
			{
				RI_CMD_Assist 1 ${OnWho}
			}
			if ${OnOff}==0
				RI_CMD_Assist 0
		}
	}
	method Depot(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Depot
	}
	method ApplyVerb(string _ForWho, string _Actor, string _Verb)
	{
		if ${This.ForWhoCheck[${_ForWho}]}
			eq2ex apply_verb ${Actor[${_Actor}].ID} "${_Verb}"
	}
	method AcceptReward(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RewardWindow:AcceptReward
	}
	method AutoRun(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			press ${RI_Var_String_AutoRunKey}
	}
	method CampDesktop(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			eq2ex camp desktop
	}
	method CampLogin(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			eq2ex camp login
	}
	method CampCharacterSelect(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			eq2ex camp
	}
	method Jump(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			press ${RI_Var_String_JumpKey}
	}
	method EndBots(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_CMD_EndBots
	}
	method Crouch(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			press ${RI_Var_String_CrouchKey}
	}
	method Hail(string ForWho, string _HailWho)
	{
		variable string HailWho
		HailWho:Set[${_HailWho.Replace[\",""]}]
		;echo ${HailWho}
		if ${This.ForWhoCheck[${ForWho}]} && ${Actor["${HailWho}"](exists)}
		{
			RI_CMD_Assisting 0
			
			if ${Target.ID}!=${Actor["${HailWho}"].ID}
			{
				TimedCommand 1 Actor["${HailWho}"]:DoTarget
				TimedCommand 1 Actor["${HailWho}"]:DoFace
			}
			
			TimedCommand 3 eq2ex hail
			
			TimedCommand 5 RI_CMD_Assisting 1
		}
	}
	method Mentor(string ForWho, string MentorWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Actor[${MentorWho}](exists)}
		{
			RI_CMD_Assisting 0
			
			if ${Target.ID}!=${Actor[${MentorWho}].ID}
				TimedCommand 1 Actor[${MentorWho}]:DoTarget
			
			TimedCommand 3 eq2ex mentor
			
			TimedCommand 5 RI_CMD_Assisting 1
		}
	}
	method UnMentor(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			eq2ex un
	}
	method Target(string ForWho, string TargetWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Actor[${TargetWho}](exists)}
		{
			RI_CMD_Assisting 0
			
			if ${Target.ID}!=${Actor[${TargetWho}].ID}
				TimedCommand 1 Actor[${TargetWho}]:DoTarget
		}
	}
	method UseItem(... args)
	{
		
		variable int _count=0
		for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
		{
			;echo UseItem: ${args[${_count}]} // ${args[${Math.Calc[${_count}+1]}]} // \${Me.Inventory[Query,Location=="Inventory" && Name=-"${args[${Math.Calc[${_count}+1]}]}"](exists)} // ${Me.Inventory[Query,Location=="Inventory" && Name=-"${args[${Math.Calc[${_count}+1]}]}"](exists)}
			if ${This.ForWhoCheck[${args[${_count}]}]} && ${Me.Inventory[Query,Location=="Inventory" && Name=-"${args[${Math.Calc[${_count}+1]}]}"](exists)}
				Me.Inventory[Query,Location=="Inventory" && Name=-"${args[${Math.Calc[${_count}+1]}]}"]:Use
			if ${This.ForWhoCheck[${args[${_count}]}]} && ${Me.Equipment["${args[${Math.Calc[${_count}+1]}]}"](exists)}
				Me.Equipment["${args[${Math.Calc[${_count}+1]}]}"]:Use
			_count:Inc
		}
	}
	method CancelMaintained(... args)
	{
		variable int _count=0
		for(_count:Set[1];${_count}<=${args.Size};_count:Inc)
		{
			if ${This.ForWhoCheck[${args[${_count}]}]}
				Me.Maintained[${RI_Obj_CB.ConvertAbility["${args[${Math.Calc[${_count}+1]}]}"]}]:Cancel
			_count:Inc
		}
	}
	method UnloadISXRI(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Extension[ISXRI.dll](exists)}
			ext -unload isxri	
	}
	method HailOption(string ForWho, int Option)
	{
		if !${Me.InGameWorld}
			return
		if ${This.ForWhoCheck[${ForWho}]} && ${EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${Option}](exists)}
			EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,${Option}]:LeftClick
	}
	method CloseTopWindow(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			eq2ex close_top_window
	}
	method PetAttack(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Pet(exists)}
			eq2ex pet attack
	}
	method PetBackOff(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Pet(exists)}
			eq2ex pet backoff
	}
	method ToggleWalkRun(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			press shift+r
	}
	method RunScript(string ForWho, string ScriptName)
	{
		if ${This.ForWhoCheck[${ForWho}]} && !${Script[${ScriptName}](exists)}
			noop ${Execute["runscript ${ScriptName}"]}
	}
	method EndScript(string ForWho, string ScriptName)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Script[${ScriptName}](exists)}
			noop ${Execute["endscript ${ScriptName}"]}
	}
	method ExecuteCommand(string ForWho, string CommandName)
	{
		;echo ExecuteCommand(string ${ForWho}, string ${CommandName})
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${CommandName.Left[5].Upper.Equal[RELAY]}
			{
				variable int leftnum
				leftnum:Set[${Math.Calc[6+${CommandName.Right[-6].Find[" "]}]}]
				noop ${Execute[${CommandName.Left[${leftnum}]} "${CommandName.Right[${Math.Calc[-1*${leftnum}]}]}"]}
			}
			else
				noop ${Execute["${CommandName}"]}
			;noop ${Execute["${CommandName}"]}
		}
	}
	method FoodDrinkReplenish(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_FDR
	}
	method Repair(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Repair
	}
	method Special(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			Actor[special]:DoubleClick
	}
	method Revive(string ForWho, int _Junction=0)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			variable int Rand
			Rand:Set[${Math.Rand[4]}]
			Rand:Set[${Math.Calc[${Rand}+6]}]
			TimedCommand ${Rand} eq2ex "select_junction ${_Junction}"
		}
	}
	method FoodDrinkConsume(string ForWho, int OnOff)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${OnOff}==1
				RI_CMD_FoodDrinkConsume 1
			if ${OnOff}==0
				RI_CMD_FoodDrinkConsume 0
		}
	}
	method Door(string ForWho, int Door)
	{
		if ${EQ2.Zoning}!=0
			return
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${EQ2.Zoning}!=0 || !${Me.InGameWorld} || ${Zone.Name.Equal[LoginScene]} || ${Zone.Name.Equal[Unknown]}
				return
			;echo Door: ${Door}
			if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
			{
				if ${Door}==0 && ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
				{
					variable index:collection:string _Zones
					EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:GetOptions[_Zones]
					Door:Set[${_Zones.Used}]
					;DeleteVariable _Zones
				}
				if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
					EQ2UIPage[popup,ZoneTeleporter].Child[list,Destinations.DestinationList]:HighlightRow[${Door}]
				if ${EQ2UIPage[popup,ZoneTeleporter].IsVisible}
					TimedCommand 5 EQ2UIPage[popup,ZoneTeleporter].Child[button,ZoneButton]:LeftClick
			}
		}
	}
	method EquipCharm(string ForWho, string Charm)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			Me.Inventory["${Charm}"]:Equip
	}
	method ChoiceWindow(string ForWho, int Choice)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			Squelch ChoiceWindow:DoChoice${Choice}
	}
	method ReplyDialog(string ForWho, ... args)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if (!${ReplyDialog.Replies(exists)}	|| ${args.Used}<1)
					return
				
				variable index:collection:string Options
				variable iterator OptionsIterator
				variable int OptionCounter = 0
				variable int _CNT
				for(_CNT:Set[1];${_CNT}<=${args.Used};_CNT:Inc)
				{
					if ${Int[${args[${_CNT}]}]}>0
						relay ${RI_Var_String_RelayGroup} ReplyDialog:Choose[${Int[${args[${_CNT}]}]}]
					else
					{
						ReplyDialog.Replies:GetOptions[Options]
						Options:GetIterator[OptionsIterator]
						
						;echo "The current reply dialog window has ${Options.Used} reply options available"
						
						if (${OptionsIterator:First(exists)})
						{
							do
							{
								if (${OptionsIterator.Value.FirstKey(exists)})
								{
									do
									{
										if ${OptionsIterator.Value.CurrentValue.Find["${args[${_CNT}]}"]}
										{
											relay ${RI_Var_String_RelayGroup} ReplyDialog:Choose[${Math.Calc[${OptionCounter}+1]}]
										}
										;echo "Option #${OptionCounter}::  '${OptionsIterator.Value.CurrentKey}' => '${OptionsIterator.Value.CurrentValue}' // ${args[${_CNT}]} // ${OptionsIterator.Value.CurrentValue.Find["${args[${_CNT}]}"]}"
									}
									while ${OptionsIterator.Value.NextKey(exists)}
									;echo "------"
								}
								OptionCounter:Inc
							}
							while ${OptionsIterator:Next(exists)}
						}
					}
				}		
		TimedCommand 5 Squelch ReplyDialog:Choose[${_Option}]
		}
	}
	method PotionConsume(string ForWho, int OnOff)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${OnOff}==1
				RI_CMD_PotionConsume 1
			if ${OnOff}==0
				RI_CMD_PotionConsume 0
		}
	}
	method PoisonConsume(string ForWho, int OnOff)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${OnOff}==1
				RI_CMD_PoisonConsume 1
			if ${OnOff}==0
				RI_CMD_PoisonConsume 0
		}
	}
	method CallGH(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			;eventually put checks in here for if in GH
			if !${Zone.ShortName.Find[guildhall](exists)}
				eq2ex usea "Call to Guild Hall"
		}
	}
	method ZoneVersion(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			EQ2UIPage[popup,Select].Child[button,Select.Footer.OK]:LeftClick
		}
	}
	method Zone(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			variable index:string _Actors
			_Actors:Insert["loc,0.000000,0.000000"]
			_Actors:Insert["Exit Pirate Cove"]
			_Actors:Insert["loc,131.052139,-219.438873"]
			_Actors:Insert["use"]
			_Actors:Insert["zavithloa_01_exit_to_southseas"]
			_Actors:Insert["loc,-3680.734131,26.664436"]
			_Actors:Insert["Exit the F.S. Distillery"]
			_Actors:Insert["Zone Exit"]
			_Actors:Insert["zavithloa_03_exit_to_southseas"]
			_Actors:Insert["To Phantom Sea"]
			_Actors:Insert["loc,-28.223486,-23.598997"]
			_Actors:Insert["zone_to_phantom_seas"]
			_Actors:Insert["zone_exit"]
			_Actors:Insert["Zone"]
			_Actors:Insert["Exit"]
			_Actors:Insert["Entrance"]
			_Actors:Insert["Door"]
			_Actors:Insert["Return"]
			_Actors:Insert["Tinkered Portal-Gate"]
			_Actors:Insert["Door to Thalumbra"]
			_Actors:Insert["Teleportation"]
			_Actors:Insert["Portal"]
			_Actors:Insert["invis_wall"]
			_Actors:Insert["Magic Door to the Guild Hall"]
			_Actors:Insert["Cae'Dal Star"]
			_Actors:Insert["kaesora_door"]
			_Actors:Insert["id,${Actor[Query, Name=-\"door\"].ID}"]
			_Actors:Insert["mariners_bell"]
			_Actors:Insert["mariner_bell_city_travel_qeynos"]
			_Actors:Insert["zone_to_guildhall_tier3"]
			_Actors:Insert["Zone to Friend"]
			_Actors:Insert["flight_cloud_large_1_to_medium_1"]
			_Actors:Insert["mariner_bell_city_travel_freeport"]
			_Actors:Insert["Ole Salt's Mariner Bell"]
			_Actors:Insert["Navigator's Globe of Norrath"]
			_Actors:Insert["Pirate Captain's Helmsman"]
			_Actors:Insert["Large Ulteran Spire"]
			_Actors:Insert["Village of Shin"]
			_Actors:Insert["a movable rock"]
			;_Actors:Insert[""]

			variable int _ClosestActorID
			variable float _ClosestActorDistance
			variable int _count
			_ClosestActorID:Set[0]
			_ClosestActorDistance:Set[100000]
			for(_count:Set[1];${_count}<=${_Actors.Used};_count:Inc)
			{	
				if ${Actor["${_Actors.Get[${_count}]}"](exists)}
				{
					;echo ${Actor["${_Actors.Get[${_count}]}"].Distance}<${_ClosestActorDistance}
					if ${Actor["${_Actors.Get[${_count}]}"].Distance}<${_ClosestActorDistance}
					{
						_ClosestActorDistance:Set[${Actor["${_Actors.Get[${_count}]}"].Distance}]
						_ClosestActorID:Set[${Actor["${_Actors.Get[${_count}]}"].ID}]
					}
				}
			}
			Actor[id,${_ClosestActorID}]:DoubleClick
			if ${Actor[id,${_ClosestActorID}].Guild.Equal["Guild Portal Druid"]}
			{
				TimedCommand 10 EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
				TimedCommand 20 Actor[tcg_druid_portal]:DoubleClick
			}
		}
	}
	method SummonMount(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && !${Me.OnHorse} && !${Me.OnFlyingMount}
			eq2ex summon_mount
	}
	method PotionReplenish(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_POTR
	}
	method PoisonReplenish(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_PoisonReplenish
	}
	method Flag(string ForWho, string GetTake=Take)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			if ${GetTake.Equal[GET]}
				RI_Flag GET
			elseif ${GetTake.Equal[TAKE]}
				RI_Flag TAKE
		}
	}
	method Evac(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Evac
	}
	method CancelAllMaintained(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			This:PauseBot[ALL]
			RI_CMD_CancelAllMaintained
			TimedCommand 2 RI_CMD_CancelAllMaintained
			TimedCommand 4 RI_CMD_CancelAllMaintained
			TimedCommand 6 RI_CMD_CancelAllMaintained
			TimedCommand 8 RI_CMD_CancelAllMaintained
			TimedCommand 10 RI_CMD_CancelAllMaintained
			TimedCommand 11 RIMUIObj:ResumeBot[ALL]
		}
	}
	member:bool ForWhoCheck(string ForWho)
	{
		;if ${This.ConvertAlias[${ForWho}].NotEqual[0]}
		;	ForWho:Set[${This.ConvertAlias[${ForWho}]}]
			
		;echo ${ForWho}
		variable bool GoodToGo=FALSE
		if ${ForWho.Upper.Find[~IGW~](exists)}
		{
			if ${Me.Group[${ForWho.Right[-5]}](exists)} || ${Me.Name.Equal[${ForWho.Right[-5]}]}
				GoodToGo:Set[TRUE]
			else
				GoodToGo:Set[FALSE]
		}
		elseif ${ForWho.Upper.Find[~NIGW~](exists)}
		{
			if ${Me.Group[${ForWho.Right[-6]}](exists)} || ${Me.Name.Equal[${ForWho.Right[-5]}]}
				GoodToGo:Set[FALSE]
			else
				GoodToGo:Set[TRUE]
		}
		elseif ${ForWho.Upper.Find[~IRW~](exists)}
		{
			if ${Me.Raid[${ForWho.Right[-5]}](exists)} || ${Me.Name.Equal[${ForWho.Right[-5]}]}
				GoodToGo:Set[TRUE]
			else
				GoodToGo:Set[FALSE]
		}
		elseif ${ForWho.Upper.Find[~NIRW~](exists)}
		{
			if ${Me.Raid[${ForWho.Right[-6]}](exists)} || ${Me.Name.Equal[${ForWho.Right[-5]}]}
				GoodToGo:Set[FALSE]
			else
				GoodToGo:Set[TRUE]
		}
		elseif ${ForWho.Upper.Find[~NOT~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				GoodToGo:Set[FALSE]
			else
				GoodToGo:Set[TRUE]
		}
		elseif ${ForWho.Upper.Find[~ALLBUT~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				GoodToGo:Set[FALSE]
			else
				GoodToGo:Set[TRUE]
		}
		elseif ${ForWho.Upper.Equal[${Me.Class.Upper}]}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[${Me.SubClass.Upper}]}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[ALL]}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Find[Skyshrine Guardian](exists)}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[${Me.Name.Upper}]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[FIGHTER]} || ${ForWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[NONFIGHTER]} || ${ForWho.Upper.Equal[NONFIGHTERS]}) && ${Me.Archetype.NotEqual[fighter]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[SCOUT]} || ${ForWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[MAGE]} ||${ForWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[PRIEST]} || ${ForWho.Upper.Equal[PRIESTS]} || ${ForWho.Upper.Equal[HEALER]} || ${ForWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[BARD]} || ${ForWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[ENCHANTER]} || ${ForWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[G1]} || ${ForWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[G2]} || ${ForWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[G3]} || ${ForWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
			GoodToGo:Set[TRUE]
		elseif (${ForWho.Upper.Equal[G4]} || ${ForWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[GEOMANCER]} && ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Geomancer"](exists)}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[THAUMATURGIST]} && ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Thaumaturgist"](exists)}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[ELEMENTALIST]} && ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Elementalist"](exists)}
			GoodToGo:Set[TRUE]
		elseif ${ForWho.Upper.Equal[ETHEREALIST]} && ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Etherealist"](exists)}
			GoodToGo:Set[TRUE]
		if ${GoodToGo}
		{
			;echo return TRUE
			return TRUE
		}
		else
		{
			;echo return FALSE
			return FALSE
		}
	}
	method UISmall(int _Save=1)
	{
		variable int icount1=0
		variable int jcount1=0
		variable int kcount1=0
		variable string stemp
		for(icount1:Set[1];${icount1}<=2;icount1:Inc)
		{
			if ${icount1}>5
			{
				for(jcount1:Set[1];${jcount1}<=10;jcount1:Inc)
				{
					stemp:Set["UIElement[BTNR"]
					stemp:Concat["${jcount1}"]
					stemp:Concat["C"]
					stemp:Concat["${icount1}"]
					stemp:Concat["@RIMovementUI]:Hide"]
					execute ${stemp}
				}
			}
			else
			{
				for(jcount1:Set[8];${jcount1}<=10;jcount1:Inc)
				{
					stemp:Set["UIElement[BTNR"]
					stemp:Concat["${jcount1}"]
					stemp:Concat["C"]
					stemp:Concat["${icount1}"]
					stemp:Concat["@RIMovementUI]:Hide"]
					execute ${stemp}
				}
			}
		}
		for(icount1:Set[3];${icount1}<=7;icount1:Inc)
		{
			if ${icount1}>5
			{
				for(jcount1:Set[1];${jcount1}<=10;jcount1:Inc)
				{
					for(kcount1:Set[1];${kcount1}<=10;kcount1:Inc)
					{
						stemp:Set["UIElement[BTNR"]
						stemp:Concat["${jcount1}"]
						stemp:Concat["C"]
						stemp:Concat["${icount1}"]
						stemp:Concat["F"]
						stemp:Concat["${kcount1}"]
						stemp:Concat["@Frame"]
						stemp:Concat["${kcount1}"]
						stemp:Concat["@RIMovementUI]:Hide"]
						execute ${stemp}
					}
				}
			}
			else
			{
				for(jcount1:Set[8];${jcount1}<=10;jcount1:Inc)
				{
					for(kcount1:Set[1];${kcount1}<=10;kcount1:Inc)
					{
						stemp:Set["UIElement[BTNR"]
						stemp:Concat["${jcount1}"]
						stemp:Concat["C"]
						stemp:Concat["${icount1}"]
						stemp:Concat["F"]
						stemp:Concat["${kcount1}"]
						stemp:Concat["@Frame"]
						stemp:Concat["${kcount1}"]
						stemp:Concat["@RIMovementUI]:Hide"]
						execute ${stemp}
					}
				}
			}
		}
		UIElement[Seperator@RIMovementUI]:SetHeight[148]
		UIElement[RIMovementUI]:SetHeight[165]
		UIElement[RIMovementUI]:SetWidth[335]
		if ${_Save}>0
			RI_Atom_SaveSize Small
	}
	method UIMedium(int _Save=1)
	{
		ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
		if ${RelayGroupChecked}	
			UIElement[RelayGroup@Titlebar@RIMovementUI]:SetChecked
		else
			UIElement[RelayGroup@Titlebar@RIMovementUI]:UnsetChecked
		This:RelayGroup[0]
		variable int micount1=0
		variable int mjcount1=0
		variable int mkcount1=0
		variable string mtemp
		for(micount1:Set[1];${micount1}<=7;micount1:Inc)
		{
			if ${micount1}>6
			{
				for(mjcount1:Set[1];${mjcount1}<=10;mjcount1:Inc)
				{
					mtemp:Set["UIElement[BTNR"]
					mtemp:Concat["${mjcount1}"]
					mtemp:Concat["C"]
					mtemp:Concat["${micount1}"]
					mtemp:Concat["@RIMovementUI]:Hide"]
					execute ${mtemp}
				}
			}
			else
			{
				for(mjcount1:Set[9];${mjcount1}<=10;mjcount1:Inc)
				{
					mtemp:Set["UIElement[BTNR"]
					mtemp:Concat["${mjcount1}"]
					mtemp:Concat["C"]
					mtemp:Concat["${micount1}"]
					mtemp:Concat["@RIMovementUI]:Hide"]
					execute ${mtemp}
				}
			}
		}
		for(micount1:Set[1];${micount1}<=7;micount1:Inc)
		{
			if ${micount1}>6
			{
				for(mjcount1:Set[1];${mjcount1}<=10;mjcount1:Inc)
				{
					for(mkcount1:Set[1];${mkcount1}<=10;mkcount1:Inc)
					{
						mtemp:Set["UIElement[BTNR"]
						mtemp:Concat["${mjcount1}"]
						mtemp:Concat["C"]
						mtemp:Concat["${micount1}"]
						mtemp:Concat["F"]
						mtemp:Concat["${mkcount1}"]
						mtemp:Concat["@Frame"]
						mtemp:Concat["${mkcount1}"]
						mtemp:Concat["@RIMovementUI]:Hide"]
						execute ${mtemp}
					}
				}
			}
			else
			{
				for(mjcount1:Set[9];${mjcount1}<=10;mjcount1:Inc)
				{
					for(mkcount1:Set[1];${mkcount1}<=10;mkcount1:Inc)
					{
						mtemp:Set["UIElement[BTNR"]
						mtemp:Concat["${mjcount1}"]
						mtemp:Concat["C"]
						mtemp:Concat["${micount1}"]
						mtemp:Concat["F"]
						mtemp:Concat["${mkcount1}"]
						mtemp:Concat["@Frame"]
						mtemp:Concat["${mkcount1}"]
						mtemp:Concat["@RIMovementUI]:Hide"]
						execute ${mtemp}
					}
				}
			}
		}
		UIElement[Seperator@RIMovementUI]:SetHeight[168]
		UIElement[RIMovementUI]:SetHeight[185]
		UIElement[RIMovementUI]:SetWidth[400]
		if ${_Save}>0
			RI_Atom_SaveSize Medium
	}
	method UILarge(int _Save=1)
	{
		UIElement[RIMovementUI]:SetHeight[225]
		UIElement[RIMovementUI]:SetWidth[465]
		ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
		if ${RelayGroupChecked}	
			UIElement[RelayGroup@Titlebar@RIMovementUI]:SetChecked
		else
			UIElement[RelayGroup@Titlebar@RIMovementUI]:UnsetChecked
		This:RelayGroup[0]
		if ${_Save}>0
			RI_Atom_SaveSize Large
	}
	method RelayGroup(int _Save=1)
	{
		if ${UIElement[RelayGroup@Titlebar@RIMovementUI].Checked}
		{
			RI_String_RIMUI_RelayTarget:Set["\${RI_Var_String_RelayGroup}"]
			RelayGroupChecked:Set[TRUE]
		}
		else
		{
			RI_String_RIMUI_RelayTarget:Set["ALL"]
			RelayGroupChecked:Set[FALSE]
		}
		if ${_Save}>0
			RI_Atom_SaveRG ${UIElement[RelayGroup@Titlebar@RIMovementUI].Checked}
	}
	method UIEdit()
	{
		;echo ${RI_Index_String_AvailableRIMUICommands.Used}
		variable int count=0
		for(count:Set[1];${count}<=${RI_Index_String_AvailableRIMUICommands.Used};count:Inc)
		{
			;echo Adding ${RI_Index_String_AvailableRIMUICommands.Get[${count}]}
			UIElement[AvailableCommandsCB@RIMUIEdit]:AddItem[${RI_Index_String_AvailableRIMUICommands.Get[${count}]}]
		}
	}
	method ButtonChg(string BTNName)
	{
		;echo ${BTNName.Upper}
		RI_Var_String_ButtonToChange:Set[${BTNName.Upper}]
		ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
		UIElement[RIMUIEdit]:SetTitle[RIMUI Edit Button: ${BTNName.Upper}]
		UIElement[RIMUIEdit]:SetWidth[495]
		UIElement[RIMUIEdit]:SetHeight[275]
		variable string txtvariable
		variable string comvariable
		variable string tempvar
		variable string tempvar2
		txtvariable:Set[${RI_String_RIMUI_${BTNName.Upper}Txt}]
		comvariable:Set["${RI_String_RIMUI_${BTNName.Upper}Com.Escape}"]
		;echo ${comvariable.Escape}
		UIElement[ButtonNameTXTEntry@RIMUIEdit]:SetText[${txtvariable}]
		;relay all RIMUIObj:Depot[ALL]
		;if ${comvariable.Find[RIMUIObj:MultipleCommands](exists)}
		;	noop
		;elseif ${comvariable.Find[RIMUIObj:MC](exists)}
		;	noop
		;elseif ${comvariable.Find[RIMUIObj:ExecuteCommand](exists)}
		;	noop
		;elseif ${comvariable.Find[RIMUIObj:Depot](exists)}
		;{	;UIElement[Description2TXT@RIMUIEdit]:SetText[${RI_Index_String_AvailableRIMUICommandsDescription.Get[${UIElement[AvailableCommandsCB@RIMUIEdit].ItemByText[Depot].ID}]}]
			;UIElement[AvailableCommandsCB@RIMUIEdit]:SetSelection[${UIElement[AvailableCommandsCB@RIMUIEdit].ItemByText[Depot].ID}]
			;tempvar:Set["${comvariable.Right[-25].Escape}"]
			;tempvar:Set["${tempvar.Left[-1].Escape}"]
			;UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem[${tempvar.Escape}]
		;}
		;else
		;{
		tempvar:Set["${comvariable.Right[-9].Escape}"]
		;echo ${tempvar.Escape}
		;echo Command: "${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Escape}"
		if ${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Escape.Length}==0
			RI_Var_String_ButtonChangeOriginalCommand:Set[ClearButton]
		else
			RI_Var_String_ButtonChangeOriginalCommand:Set["${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Escape}"]
		;echo space
		if "${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Escape.Equal[""]}"
		{
			UIElement[Description2TXT@RIMUIEdit]:SetText[${RI_Index_String_AvailableRIMUICommandsDescription.Get[14]}]
			UIElement[AvailableCommandsCB@RIMUIEdit]:SetSelection[14]
		}
		else
		{
			UIElement[Description2TXT@RIMUIEdit]:SetText[${RI_Index_String_AvailableRIMUICommandsDescription.Get[${UIElement[AvailableCommandsCB@RIMUIEdit].ItemByText["${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Escape}"].ID}]}]
			UIElement[AvailableCommandsCB@RIMUIEdit]:SetSelection[${UIElement[AvailableCommandsCB@RIMUIEdit].ItemByText["${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Escape}"].ID}]
			tempvar:Set["${tempvar.Right[${Math.Calc[-1*${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Length}-1]}].Escape}"]
			;echo ${tempvar.Escape}
			;echo spce
			while ${tempvar.Find[","](exists)}
			{
				;echo ${tempvar.Find[","]}
				;echo Arg: "${tempvar.Left[${Math.Calc[${tempvar.Find[","]}-1]}].Escape}"
				UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem["${tempvar.Left[${Math.Calc[${tempvar.Find[","]}-1]}].Escape}"]
				tempvar:Set["${tempvar.Right[${Math.Calc[-1*${tempvar.Left[${Math.Calc[${tempvar.Find[","]}-1]}].Length}-1]}].Escape}"]
				;echo ${tempvar}
			}
			;echo Arg: "${tempvar.Left[-1].Escape}"
			UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem["${tempvar.Left[-1].Escape}"]
			;echo ${tempvar.Right[${Math.Calc[-1*${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Length}-1]}]}
			;echo ${Math.Calc[${tempvar.Right[${Math.Calc[-1*${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Length}-1]}].Find[","]}-1]}
			;echo ${tempvar.Right[${Math.Calc[-1*${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Length}-1]}].Left[${Math.Calc[${tempvar.Right[${Math.Calc[-1*${tempvar.Left[${Math.Calc[-1*(${tempvar.Length}-${tempvar.Find["["]})-1]}].Length}-1]}].Find[","]}-1]}]}
			;echo ${}
			
		}
		;
		;
		;
		;CODING THE SAVE BUTTON,,, Opposite of above. build the string from relay all RIMUIObj:COMMAND[arg,arg,arg] etc
		;
		;remember any argument with spaces or [] need "" around it
		;
		;
		
	}
	method NameOnlyButtonChg(string BTNName)
	{
		;echo ${BTNName.Upper}
		RI_Var_String_ButtonToChange:Set[${BTNName.Upper}]
		ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
		
		;;;;;disable all but save/cancel and the button name field
		
		UIElement[AvailableCommandsTXT@RIMUIEdit]:Hide
		UIElement[AvailableCommandsCB@RIMUIEdit]:Hide
		UIElement[DescriptionTXT@RIMUIEdit]:Hide
		UIElement[Description2TXT@RIMUIEdit]:Hide
		UIElement[AddArgumentBTN@RIMUIEdit]:Hide
		UIElement[ButtonNameTXT@RIMUIEdit]:SetY[5]
		UIElement[ButtonNameTXTEntry@RIMUIEdit]:SetY[25]
		UIElement[SaveBTN@RIMUIEdit]:SetY[45]
		UIElement[CancelBTN@RIMUIEdit]:SetY[45]
		UIElement[AddArgumentTXTEntry@RIMUIEdit]:Hide
		UIElement[AddedArgumentsLST@RIMUIEdit]:Hide
		UIElement[RIMUIEdit]:SetWidth[215]
		UIElement[RIMUIEdit]:SetHeight[85]
		UIElement[RIMUIEdit]:SetTitle[RIMUI Edit Button: ${BTNName.Upper}]
		variable string txtvariable
		txtvariable:Set[${RI_String_RIMUI_${BTNName.Upper}Txt}]
		;echo ${comvariable.Escape}
		UIElement[ButtonNameTXTEntry@RIMUIEdit]:SetText[${txtvariable}]
		boolNameOnlyButton:Set[TRUE]
		;relay all RIMUIObj:Depot[ALL]
		;if ${comvariable.Find[RIMUIObj:MultipleCommands](exists)}
		;	noop
		;elseif ${comvariable.Find[RIMUIObj:MC](exists)}
		;	noop
		;elseif ${comvariable.Find[RIMUIObj:ExecuteCommand](exists)}
		;	noop
		;elseif ${comvariable.Find[RIMUIObj:Depot](exists)}
		;{	;UIElement[Description2TXT@RIMUIEdit]:SetText[${RI_Index_String_AvailableRIMUICommandsDescription.Get[${UIElement[AvailableCommandsCB@RIMUIEdit].ItemByText[Depot].ID}]}]
			;UIElement[AvailableCommandsCB@RIMUIEdit]:SetSelection[${UIElement[AvailableCommandsCB@RIMUIEdit].ItemByText[Depot].ID}]
			;tempvar:Set["${comvariable.Right[-25].Escape}"]
			;tempvar:Set["${tempvar.Left[-1].Escape}"]
			;UIElement[AddedArgumentsLST@RIMUIEdit]:AddItem[${tempvar.Escape}]
		;}
		;else
		;{
	}
	method SaveButtonChg()
	{
		variable string txtvariable
		variable string txtvariable2
		if ${boolNameOnlyButton}
		{	
			txtvariable:Set["RI_String_RIMUI_${RI_Var_String_ButtonToChange}Txt"]
			txtvariable2:Set["${txtvariable.Escape}"]
			txtvariable2:Concat[":Set[${UIElement[ButtonNameTXTEntry@RIMUIEdit].Text.Escape}]"]
			noop ${txtvariable2}
			
			noop ${${txtvariable2}}
		
			;echo ISXRI: Changing Button ${RI_Var_String_ButtonToChange} Values:
			noop ${${txtvariable}}
			RI_Atom_SaveNameOnlyButton ${RI_Var_String_ButtonToChange}
			ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
			boolNameOnlyButton:Set[FALSE]
		}
		else
		{
			variable string comvariable
			variable string comvariable2
			variable string tempvar
			variable string tempvar2
			variable bool boolClear=FALSE
			;echo ${RI_Var_String_ButtonToChange}
			txtvariable:Set["RI_String_RIMUI_${RI_Var_String_ButtonToChange}Txt"]
			comvariable:Set["RI_String_RIMUI_${RI_Var_String_ButtonToChange}Com"]
			;echo ${comvariable}
			;echo ${txtvariable}
			;echo ${UIElement[AvailableCommandsCB@RIMUIEdit].SelectedItem.Text.Equal[ClearButton]} || ${RI_Var_String_ButtonChangeOriginalCommand.Equal[ClearButton]}
			if ${UIElement[AvailableCommandsCB@RIMUIEdit].SelectedItem.Text.Equal[ClearButton]} || ( !${UIElement[AvailableCommandsCB@RIMUIEdit].SelectedItem(exists)} && ${RI_Var_String_ButtonChangeOriginalCommand.Equal[ClearButton]} )
			{
				txtvariable2:Set["${txtvariable.Escape}"]
				txtvariable2:Concat[":Set[]"]
				tempvar:Set[noop]
				boolClear:Set[TRUE]
			}
			elseif ${UIElement[AddedArgumentsLST@RIMUIEdit].OrderedItem[1](exists)}
			{
				if ${UIElement[AvailableCommandsCB@RIMUIEdit].SelectedItem(exists)}
					tempvar:Set["RIMUIObj:${UIElement[AvailableCommandsCB@RIMUIEdit].SelectedItem}["]
				elseif ${RI_Var_String_ButtonChangeOriginalCommand.NotEqual[""]} 
					tempvar:Set["RIMUIObj:${RI_Var_String_ButtonChangeOriginalCommand}["]
				else
					echo end here
			
				tempvar:Concat[${UIElement[AddedArgumentsLST@RIMUIEdit].OrderedItem[1].Text.Escape.Escape}]
				variable int count=1
				while ${UIElement[AddedArgumentsLST@RIMUIEdit].OrderedItem[${count:Inc}](exists)}
				{
					tempvar:Concat[","]
					tempvar:Concat["${UIElement[AddedArgumentsLST@RIMUIEdit].OrderedItem[${count}].Text.Escape.Escape}"]
					;echo "${UIElement[AddedArgumentsLST@RIMUIEdit].OrderedItem[${count}].Text.Escape}"
				}
				tempvar:Concat["]"]
				;echo ${UIElement[ButtonNameTXTEntry@RIMUIEdit].Text}
				;echo ${tempvar}
				txtvariable2:Set["${txtvariable.Escape}"]
				txtvariable2:Concat[":Set[${UIElement[ButtonNameTXTEntry@RIMUIEdit].Text.Escape}]"]
			}
			
			comvariable2:Set["${comvariable.Escape}"]
			comvariable2:Concat[":Set[\"${tempvar.Escape}\"]"]
			
			noop ${txtvariable2}
			noop ${comvariable2}
				
			noop ${${txtvariable2}}
			noop ${${comvariable2}}
			
			;echo ISXRI: Changing Button ${RI_Var_String_ButtonToChange} Values:
			noop ${${txtvariable}}
			noop "${${comvariable.Escape}}"
			;
			;
			;
			;CODING THE SAVE BUTTON,,, Opposite of above. build the string from RIMUIObj:COMMAND[arg,arg,arg] etc
			;
			;Also add a Spread, and Circle RIMUICommands , have 2nd arg be Seed #, or # to rand off for spread and who far from middle man (for man in the middle) for circle or from first man for reg circle
			;
			if ${boolClear}
				RI_Atom_ClearButton ${RI_Var_String_ButtonToChange}
			else
				RI_Atom_SaveButton ${RI_Var_String_ButtonToChange}
			RI_Var_String_ButtonChangeOriginalCommand:Set[""]
			ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
		}
	}
	method LockSpotPop(string TForWho, string ForWho=~NONE~)
	{
		if ${This.ForWhoCheck[${TForWho}]}
		{
			;load RIMovement
			This:LoadRIMovement
			PopForWho:Set[${ForWho}]
			RI_Atom_RILockSpotPop
		}
	}
	method RIFollowPop(string TForWho, string ForWho=~NONE~)
	{
		if ${This.ForWhoCheck[${TForWho}]}
		{
			;load RIMovement
			This:LoadRIMovement
			PopForWho:Set[${ForWho}]
			RI_Atom_RIFollowPop
		}
	}
	method AssistPop(string TForWho, string ForWho=~NONE~)
	{
		if ${This.ForWhoCheck[${TForWho}]}
		{
			PopForWho:Set[${ForWho}]
			RI_Atom_AssistPop
		}
	}
	method DoorPop(string TForWho, string ForWho=~NONE~)
	{
		if ${This.ForWhoCheck[${TForWho}]}
		{
			PopForWho:Set[${ForWho}]
			RI_Atom_DoorPop
		}
	}
	method PreHeal(string phForWho=ALL, string phOnWho)
	{
		variable bool phGoodToGo=FALSE
		if ${phForWho.Upper.Equal[ALL]}
			phGoodToGo:Set[TRUE]
		elseif ${phForWho.Upper.Equal[NOTME]}
			phGoodToGo:Set[FALSE]
		elseif ${phForWho.Upper.Equal[${Me.Name.Upper}]}
			phGoodToGo:Set[TRUE]
		; elseif (${phForWho.Upper.Equal[FIGHTER]} || ${phForWho.Upper.Equal[FIGHTERS]}) && ${Me.Archetype.Equal[fighter]}
			; phGoodToGo:Set[TRUE]
		; elseif (${phForWho.Upper.Equal[SCOUT]} || ${phForWho.Upper.Equal[SCOUTS]}) && ${Me.Archetype.Equal[scout]}
			; phGoodToGo:Set[TRUE]
		; elseif (${phForWho.Upper.Equal[MAGE]} ||${phForWho.Upper.Equal[MAGES]}) && ${Me.Archetype.Equal[mage]}
			; phGoodToGo:Set[TRUE]
		elseif (${phForWho.Upper.Equal[PRIEST]} || ${phForWho.Upper.Equal[PRIESTS]} || ${phForWho.Upper.Equal[HEALER]} || ${phForWho.Upper.Equal[HEALERS]}) && ${Me.Archetype.Equal[priest]}
			phGoodToGo:Set[TRUE]
		; elseif (${phForWho.Upper.Equal[BARD]} || ${phForWho.Upper.Equal[BARDS]}) && ${Me.Class.Equal[bard]}
			; phGoodToGo:Set[TRUE]
		; elseif (${phForWho.Upper.Equal[ENCHANTER]} || ${phForWho.Upper.Equal[ENCHANTERS]}) && ${Me.Class.Equal[enchanter]}
			; phGoodToGo:Set[TRUE]
		; elseif ${phForWho.Upper.Equal[DPS]} && ((${Me.Archetype.Equal[mage]} && !${Me.Class.Equal[enchanter]}) || (${Me.Archetype.Equal[scout]} && !${Me.Class.Equal[bard]}))
			; phGoodToGo:Set[TRUE]
		elseif (${phForWho.Upper.Equal[G1]} || ${phForWho.Upper.Equal[GROUP1]}) && ${Me.RaidGroupNum}==1
			phGoodToGo:Set[TRUE]
		elseif (${phForWho.Upper.Equal[G2]} || ${phForWho.Upper.Equal[GROUP2]}) && ${Me.RaidGroupNum}==2
			phGoodToGo:Set[TRUE]
		elseif (${phForWho.Upper.Equal[G3]} || ${phForWho.Upper.Equal[GROUP3]}) && ${Me.RaidGroupNum}==3
			phGoodToGo:Set[TRUE]
		elseif (${phForWho.Upper.Equal[G4]} || ${phForWho.Upper.Equal[GROUP4]}) && ${Me.RaidGroupNum}==4
			phGoodToGo:Set[TRUE]
		if ${phGoodToGo}
		{
			if ${Me.SubClass.Equal[mystic]}
			{
				RI_CMD_CastOn "Ancestral Ward" ${phOnWho} 1
				TimedCommand 15 RI_CMD_Cast \"Umbral Warding" 0
			}
			if ${Me.SubClass.Equal[defiler]}
			{
				RI_CMD_CastOn "Ancient Shroud" ${phOnWho} 1
				TimedCommand 15 RI_CMD_Cast \"Carrion Warding" 0
			}
			if ${Me.SubClass.Equal[templar]}
			{
				RI_CMD_CastOn "Vital Intercession" ${phOnWho} 1
				TimedCommand 15 RI_CMD_Cast \"Holy Intercession" 0
			}
			if ${Me.SubClass.Equal[inquisitor]}
			{
				RI_CMD_CastOn "Fanatic's Protection" ${phOnWho} 1
				TimedCommand 18 RI_CMD_CastOn \"Penance" ${phOnWho} 1
				TimedCommand 33 RI_CMD_Cast \"Malevolent Diatribe" 0
			}
			if ${Me.SubClass.Equal[warden]}
			{
				RI_CMD_CastOn "Photosynthesis" ${phOnWho} 1
				TimedCommand 15 RI_CMD_Cast \"Healstorm" 0
			}
			if ${Me.SubClass.Equal[fury]}
			{
				RI_CMD_CastOn "Regrowth" ${phOnWho} 1
				TimedCommand 15 RI_CMD_Cast \"Autumn's Kiss" 0
			}
			if ${Me.SubClass.Equal[channeler]}
			{
				RI_CMD_CastOn "Siphoned Protection" ${phOnWho} 1
				TimedCommand 50 RI_CMD_CastOn \"Truespirit Rift" ${phOnWho} 0
			}
		}
	}
	method RIFollowChange(string ForWho, int rifpInc)
	{
		;load RIMovement
		This:LoadRIMovement
		
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Var_Int_RIFollowMinDistance:Set[${Math.Calc[${RI_Var_Int_RIFollowMinDistance}+${rifpInc}]}]
	}
	method RIMUIClose()
	{
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
		ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
		RIMUILoaded:Set[FALSE]
	}
	method RIMUILoad()
	{
		if !${RIMUILoaded}
			aLoadRIMUI
	}
	method LoadRaidGroupHud(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && !${RaidGroupHudLoaded}
		{
			LoadDistanceHud
			RaidGroupHudLoaded:Set[TRUE]
		}
	}
	method UnLoadRaidGroupHud(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${RaidGroupHudLoaded}
		{
			squelch hud -remove LD1P1
			squelch hud -remove LD1P2
			squelch hud -remove LD2P1
			squelch hud -remove LD2P2
			squelch hud -remove LD3P1
			squelch hud -remove LD3P2
			squelch hud -remove LD4P1
			squelch hud -remove LD4P2
			squelch hud -remove LD5P1
			squelch hud -remove LD5P2
			squelch hud -remove LD6P1
			squelch hud -remove LD6P2
			squelch hud -remove LD7P1
			squelch hud -remove LD7P2
			squelch hud -remove LD8P1
			squelch hud -remove LD8P2
			squelch hud -remove LD9P1
			squelch hud -remove LD9P2
			squelch hud -remove LD10P1
			squelch hud -remove LD10P2
			squelch hud -remove LD11P1
			squelch hud -remove LD11P2
			squelch hud -remove LD12P1
			squelch hud -remove LD12P2
			squelch hud -remove LD13P1
			squelch hud -remove LD13P2
			squelch hud -remove LD14P1
			squelch hud -remove LD14P2
			squelch hud -remove LD15P1
			squelch hud -remove LD15P2
			squelch hud -remove LD16P1
			squelch hud -remove LD16P2
			squelch hud -remove LD17P1
			squelch hud -remove LD17P2
			squelch hud -remove LD18P1
			squelch hud -remove LD18P2
			squelch hud -remove LD19P1
			squelch hud -remove LD19P2
			squelch hud -remove LD20P1
			squelch hud -remove LD20P2
			squelch hud -remove LD21P1
			squelch hud -remove LD21P2
			squelch hud -remove LD22P1
			squelch hud -remove LD22P2
			squelch hud -remove LD23P1
			squelch hud -remove LD23P2
			squelch hud -remove LD24P1
			squelch hud -remove LD24P2
			RaidGroupHudLoaded:Set[FALSE]
		}
	}
	method LoadNearestNPCHud(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && !${NearesetNPCHudLoaded}
		{
			LoadNNHud
			NearesetNPCHudLoaded:Set[TRUE]
		}
	}
	method UnLoadNearestNPCHud(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${NearesetNPCHudLoaded}
		{
			squelch Hud -remove NN1P1
			squelch Hud -remove NN1P2
			NearesetNPCHudLoaded:Set[FALSE]
		}
	}
	method LoadNearestPlayerHud(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && !${NearesetPlayerHudLoaded}
		{
			LoadNPHud
			NearesetPlayerHudLoaded:Set[TRUE]
		}
	}
	method UnLoadNearestPlayerHud(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${NearesetPlayerHudLoaded}
		{
			squelch Hud -remove NP1P1
			squelch Hud -remove NP1P2
			NearesetPlayerHudLoaded:Set[FALSE]
		}
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;HUDS
variable(global) string strRIHUD1
variable(global) string strRIHUD1F
variable(global) float floatRIHUD1
variable(global) string strRIHUD2
variable(global) string strRIHUD2F
variable(global) float floatRIHUD2
variable(global) string strRIHUD3
variable(global) string strRIHUD3F
variable(global) float floatRIHUD3
variable(global) string strRIHUD4
variable(global) string strRIHUD4F
variable(global) float floatRIHUD4
variable(global) string strRIHUD5
variable(global) string strRIHUD5F
variable(global) float floatRIHUD5
variable(global) string strRIHUD6
variable(global) string strRIHUD6F
variable(global) float floatRIHUD6
variable(global) string strRIHUD7
variable(global) string strRIHUD7F
variable(global) float floatRIHUD7
variable(global) string strRIHUD8
variable(global) string strRIHUD8F
variable(global) float floatRIHUD8
variable(global) string strRIHUD9
variable(global) string strRIHUD9F
variable(global) float floatRIHUD9
variable(global) string strRIHUD10
variable(global) string strRIHUD10F
variable(global) float floatRIHUD10
variable(global) string strRIHUD11
variable(global) string strRIHUD11F
variable(global) float floatRIHUD11
variable(global) string strRIHUD12
variable(global) string strRIHUD12F
variable(global) float floatRIHUD12
variable(global) string strRIHUD13
variable(global) string strRIHUD13F
variable(global) float floatRIHUD13
variable(global) string strRIHUD14
variable(global) string strRIHUD14F
variable(global) float floatRIHUD14
variable(global) string strRIHUD15
variable(global) string strRIHUD15F
variable(global) float floatRIHUD15
variable(global) string strRIHUD16
variable(global) string strRIHUD16F
variable(global) float floatRIHUD16
variable(global) string strRIHUD17
variable(global) string strRIHUD17F
variable(global) float floatRIHUD17
variable(global) string strRIHUD18
variable(global) string strRIHUD18F
variable(global) float floatRIHUD18
variable(global) string strRIHUD19
variable(global) string strRIHUD19F
variable(global) float floatRIHUD19
variable(global) string strRIHUD20
variable(global) string strRIHUD20F
variable(global) float floatRIHUD20
variable(global) string strRIHUD21
variable(global) string strRIHUD21F
variable(global) float floatRIHUD21
variable(global) string strRIHUD22
variable(global) string strRIHUD22F
variable(global) float floatRIHUD22
variable(global) string strRIHUD23
variable(global) string strRIHUD23F
variable(global) float floatRIHUD23
variable(global) string strRIHUD24
variable(global) string strRIHUD24F
variable(global) float floatRIHUD24
variable(global) string strRIHUDNN
variable(global) string strRIHUDNNF
variable(global) float floatRIHUDNN
variable(global) string strRIHUDNP
variable(global) string strRIHUDNPF
variable(global) float floatRIHUDNP
atom LoadNPHud()
{
	;first load hud
	variable int _X
	variable int _Y
	_X:Set[300]
	_Y:Set[175]
	if ${UIElement[HudsNearestPlayerXTextEntry@HudsFrame@CombatBotUI].Text.NotEqual[""]}
		_X:Set[${UIElement[HudsNearestPlayerXTextEntry@HudsFrame@CombatBotUI].Text}]
	if ${UIElement[HudsNearestPlayerYTextEntry@HudsFrame@CombatBotUI].Text.NotEqual[""]}
		_Y:Set[${UIElement[HudsNearestPlayerYTextEntry@HudsFrame@CombatBotUI].Text}]
	squelch Hud -add NP1P1 ${_X},${_Y} ${strRIHUDNPF}
	squelch Hud -add NP1P2 ${Math.Calc[${_X}+55].Precision[0]},${_Y} ${strRIHUDNP}
	;now update it
	UpdateNPHud
}
atom LoadNNHud()
{
	;first load hud
	variable int _X
	variable int _Y
	_X:Set[300]
	_Y:Set[205]
	if ${UIElement[HudsNearestNPCXTextEntry@HudsFrame@CombatBotUI].Text.NotEqual[""]}
		_X:Set[${UIElement[HudsNearestNPCXTextEntry@HudsFrame@CombatBotUI].Text}]
	if ${UIElement[HudsNearestNPCYTextEntry@HudsFrame@CombatBotUI].Text.NotEqual[""]}
		_Y:Set[${UIElement[HudsNearestNPCYTextEntry@HudsFrame@CombatBotUI].Text}]
	;echo X: ${_X} Y: ${_Y}
	squelch Hud -add NN1P1 ${_X},${_Y} ${strRIHUDNNF}
	squelch Hud -add NN1P2 ${Math.Calc[${_X}+55].Precision[0]},${_Y} ${strRIHUDNN}
	;now update it
	UpdateNNHud
}
atom LoadDistanceHud()
{
	variable int _X
	variable int _Y
	_X:Set[300]
	_Y:Set[235]
	if ${UIElement[HudsRaidGroupXTextEntry@HudsFrame@CombatBotUI].Text.NotEqual[""]}
		_X:Set[${UIElement[HudsRaidGroupXTextEntry@HudsFrame@CombatBotUI].Text}]
	if ${UIElement[HudsRaidGroupYTextEntry@HudsFrame@CombatBotUI].Text.NotEqual[""]}
		_Y:Set[${UIElement[HudsRaidGroupYTextEntry@HudsFrame@CombatBotUI].Text}]
	;echo X: ${_X} Y: ${_Y}
	;first load huds
	squelch Hud -add LD1P1 ${_X},${_Y} ${strRIHUD1F}
	squelch Hud -add LD1P2 ${Math.Calc[${_X}+55].Precision[0]},${_Y} ${strRIHUD1}
	squelch Hud -add LD2P1 ${_X},${Math.Calc[${_Y}+15].Precision[0]} ${strRIHUD2F}
	squelch Hud -add LD2P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+15].Precision[0]} ${strRIHUD2}
	squelch Hud -add LD3P1 ${_X},${Math.Calc[${_Y}+30].Precision[0]} ${strRIHUD3F}
	squelch Hud -add LD3P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+30].Precision[0]} ${strRIHUD3}
	squelch Hud -add LD4P1 ${_X},${Math.Calc[${_Y}+45].Precision[0]} ${strRIHUD4F}
	squelch Hud -add LD4P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+45].Precision[0]} ${strRIHUD4}
	squelch Hud -add LD5P1 ${_X},${Math.Calc[${_Y}+60].Precision[0]} ${strRIHUD5F}
	squelch Hud -add LD5P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+60].Precision[0]} ${strRIHUD5}
	squelch Hud -add LD6P1 ${_X},${Math.Calc[${_Y}+75].Precision[0]} ${strRIHUD6F}
	squelch Hud -add LD6P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+75].Precision[0]} ${strRIHUD6}
	squelch Hud -add LD7P1 ${_X},${Math.Calc[${_Y}+90].Precision[0]} ${strRIHUD7F}
	squelch Hud -add LD7P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+90].Precision[0]} ${strRIHUD7}
	squelch Hud -add LD8P1 ${_X},${Math.Calc[${_Y}+105].Precision[0]} ${strRIHUD8F}
	squelch Hud -add LD8P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+105].Precision[0]} ${strRIHUD8}
	squelch Hud -add LD9P1 ${_X},${Math.Calc[${_Y}+120].Precision[0]} ${strRIHUD9F}
	squelch Hud -add LD9P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+120].Precision[0]} ${strRIHUD9}
	squelch Hud -add LD10P1 ${_X},${Math.Calc[${_Y}+135].Precision[0]} ${strRIHUD10F}
	squelch Hud -add LD10P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+135].Precision[0]} ${strRIHUD10}
	squelch Hud -add LD11P1 ${_X},${Math.Calc[${_Y}+150].Precision[0]} ${strRIHUD11F}
	squelch Hud -add LD11P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+150].Precision[0]} ${strRIHUD11}
	squelch Hud -add LD12P1 ${_X},${Math.Calc[${_Y}+165].Precision[0]} ${strRIHUD12F}
	squelch Hud -add LD12P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+165].Precision[0]} ${strRIHUD12}
	squelch Hud -add LD13P1 ${_X},${Math.Calc[${_Y}+180].Precision[0]} ${strRIHUD13F}
	squelch Hud -add LD13P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+180].Precision[0]} ${strRIHUD13}
	squelch Hud -add LD14P1 ${_X},${Math.Calc[${_Y}+195].Precision[0]} ${strRIHUD14F}
	squelch Hud -add LD14P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+195].Precision[0]} ${strRIHUD14}
	squelch Hud -add LD15P1 ${_X},${Math.Calc[${_Y}+210].Precision[0]} ${strRIHUD15F}
	squelch Hud -add LD15P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+210].Precision[0]} ${strRIHUD15}
	squelch Hud -add LD16P1 ${_X},${Math.Calc[${_Y}+225].Precision[0]} ${strRIHUD16F}
	squelch Hud -add LD16P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+225].Precision[0]} ${strRIHUD16}
	squelch Hud -add LD17P1 ${_X},${Math.Calc[${_Y}+240].Precision[0]} ${strRIHUD17F}
	squelch Hud -add LD17P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+240].Precision[0]} ${strRIHUD17}
	squelch Hud -add LD18P1 ${_X},${Math.Calc[${_Y}+255].Precision[0]} ${strRIHUD18F}
	squelch Hud -add LD18P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+255].Precision[0]} ${strRIHUD18}
	squelch Hud -add LD19P1 ${_X},${Math.Calc[${_Y}+270].Precision[0]} ${strRIHUD19F}
	squelch Hud -add LD19P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+270].Precision[0]} ${strRIHUD19}
	squelch Hud -add LD20P1 ${_X},${Math.Calc[${_Y}+285].Precision[0]} ${strRIHUD20F}
	squelch Hud -add LD20P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+285].Precision[0]} ${strRIHUD20}
	squelch Hud -add LD21P1 ${_X},${Math.Calc[${_Y}+300].Precision[0]} ${strRIHUD21F}
	squelch Hud -add LD21P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+300].Precision[0]} ${strRIHUD21}
	squelch Hud -add LD22P1 ${_X},${Math.Calc[${_Y}+315].Precision[0]} ${strRIHUD22F}
	squelch Hud -add LD22P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+315].Precision[0]} ${strRIHUD22}
	squelch Hud -add LD23P1 ${_X},${Math.Calc[${_Y}+330].Precision[0]} ${strRIHUD23F}
	squelch Hud -add LD23P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+330].Precision[0]} ${strRIHUD23}
	squelch Hud -add LD24P1 ${_X},${Math.Calc[${_Y}+345].Precision[0]} ${strRIHUD24F}
	squelch Hud -add LD24P2 ${Math.Calc[${_X}+55].Precision[0]},${Math.Calc[${_Y}+345].Precision[0]} ${strRIHUD24}
	;now update them
	UpdateDistanceHud
}
atom UpdateNPHud()
{
	if ${EQ2.Zoning}==0
	{
		if ${Actor[PC](exists)}
		{
			floatRIHUDNP:Set["${Actor[PC].Distance}"]
			strRIHUDNPF:Set[${floatRIHUDNP.Precision[2]}]
			if ${Actor[PC].Target(exists)}
				strRIHUDNP:Set[":${Actor[PC].Name} => ${Actor[PC].Target}"]
			else 
				strRIHUDNP:Set[":${Actor[PC].Name}"]
			if ${floatRIHUDNP}==0
				HUDSet NP1P1 -c FF888888
			elseif ${floatRIHUDNP}>0 && ${floatRIHUDNP}<20
				HUDSet NP1P1 -c FFFFFFFF
			elseif ${floatRIHUDNP}>=20 && ${floatRIHUDNP}<30
				HUDSet NP1P1 -c FFFFFF00
			elseif ${floatRIHUDNP}>=30 && ${floatRIHUDNP}<50
				HUDSet NP1P1 -c FFFF8800
			elseif ${floatRIHUDNP}>50
				HUDSet NP1P1 -c FFFF0000
		}
		else
		{
			floatRIHUDNP<:Set[0.00]
			strRIHUDNPF:Set[""]
			strRIHUDNP:Set[""]
		}
	}
}
atom UpdateNNHud()
{
	if ${EQ2.Zoning}==0
	{
		if ${Actor[NamedNPC](exists)}
		{
			floatRIHUDNN:Set["${Actor[NamedNPC].Distance}"]
			strRIHUDNNF:Set[${floatRIHUDNN.Precision[2]}]
			if ${Actor[NamedNPC].Target(exists)}
				strRIHUDNN:Set[":${Actor[NamedNPC].Name} => ${Actor[NamedNPC].Target}"]
			else 
				strRIHUDNN:Set[":${Actor[NamedNPC].Name}"]
			if ${floatRIHUDNN}==0
				HUDSet NN1P1 -c FF888888
			elseif ${floatRIHUDNN}>0 && ${floatRIHUDNN}<20
				HUDSet NN1P1 -c FFFFFFFF
			elseif ${floatRIHUDNN}>=20 && ${floatRIHUDNN}<30
				HUDSet NN1P1 -c FFFFFF00
			elseif ${floatRIHUDNN}>=30 && ${floatRIHUDNN}<50
				HUDSet NN1P1 -c FFFF8800
			elseif ${floatRIHUDNN}>50
				HUDSet NN1P1 -c FFFF0000
		}
		elseif ${Actor[NPC](exists)}
		{
			floatRIHUDNN:Set["${Actor[NPC].Distance}"]
			strRIHUDNNF:Set[${floatRIHUDNN.Precision[2]}]
			if ${Actor[NPC].Target(exists)}
				strRIHUDNN:Set[":${Actor[NPC].Name} => ${Actor[NPC].Target}"]
			else 
				strRIHUDNN:Set[":${Actor[NPC].Name}"]
			if ${floatRIHUDNN}==0
				HUDSet NN1P1 -c FF888888
			elseif ${floatRIHUDNN}>0 && ${floatRIHUDNN}<20
				HUDSet NN1P1 -c FFFFFFFF
			elseif ${floatRIHUDNN}>=20 && ${floatRIHUDNN}<30
				HUDSet NN1P1 -c FFFFFF00
			elseif ${floatRIHUDNN}>=30 && ${floatRIHUDNN}<50
				HUDSet NN1P1 -c FFFF8800
			elseif ${floatRIHUDNN}>50
				HUDSet NN1P1 -c FFFF0000
		}
		else
		{
			floatRIHUDNN<:Set[0.00]
			strRIHUDNNF:Set[""]
			strRIHUDNN:Set[""]
		}
	}
}
atom UpdateDistanceHud()
{
	if ${EQ2.Zoning}==0
	{
		if ${Me.Raid}>0 && !${UIElement[HudsRaidGroupOnlyCheckBox@HudsFrame@CombatBotUI].Checked}
		{
			if ${Me.Raid[1].Name(exists)}
			{
				floatRIHUD1:Set[0]
				strRIHUD1F:Set[0.00]
				strRIHUD1:Set[":${Me.Raid[1].Name}"]
				if ${Me.Raid[1](exists)}
				{
					floatRIHUD1:Set["${Me.Raid[1].Distance}"]
					strRIHUD1F:Set[${floatRIHUD1.Precision[2]}]
					if ${Me.Raid[1].Target(exists)}
						strRIHUD1:Set[":${Me.Raid[1].Name} => ${Me.Raid[1].Target}"]
					else 
						strRIHUD1:Set[":${Me.Raid[1].Name}"]
				}
				if ${floatRIHUD1}==0
					HUDSet LD1P1 -c FF888888
				elseif ${floatRIHUD1}>0 && ${floatRIHUD1}<20
					HUDSet LD1P1 -c FFFFFFFF
				elseif ${floatRIHUD1}>=20 && ${floatRIHUD1}<30
					HUDSet LD1P1 -c FFFFFF00
				elseif ${floatRIHUD1}>=30 && ${floatRIHUD1}<50
					HUDSet LD1P1 -c FFFF8800
				elseif ${floatRIHUD1}>50
					HUDSet LD1P1 -c FFFF0000
			}
			else
			{
				floatRIHUD1:Set[0.00]
				strRIHUD1F:Set[""]
				strRIHUD1:Set[""]
			}
			if ${Me.Raid[2].Name(exists)}
			{
				floatRIHUD2:Set[0.00]
				strRIHUD2F:Set[0.00]
				strRIHUD2:Set[":${Me.Raid[2].Name}"]
				if ${Me.Raid[2](exists)}
				{
					floatRIHUD2:Set["${Me.Raid[2].Distance}"]
					strRIHUD2F:Set[${floatRIHUD2.Precision[2]}]
					if ${Me.Raid[2].Target(exists)}
						strRIHUD2:Set[":${Me.Raid[2].Name} => ${Me.Raid[2].Target}"]
					else 
						strRIHUD2:Set[":${Me.Raid[2].Name}"]
				}
				if ${floatRIHUD2}==0
					HUDSet LD2P1 -c FF888888
				elseif ${floatRIHUD2}>0 && ${floatRIHUD2}<20
					HUDSet LD2P1 -c FFFFFFFF
				elseif ${floatRIHUD2}>=20 && ${floatRIHUD2}<30
					HUDSet LD2P1 -c FFFFFF00
				elseif ${floatRIHUD2}>=30 && ${floatRIHUD2}<50
					HUDSet LD2P1 -c FFFF8800
				elseif ${floatRIHUD2}>50
					HUDSet LD2P1 -c FFFF0000
			}
			else
			{
				floatRIHUD2:Set[0.00]
				strRIHUD2F:Set[""]
				strRIHUD2:Set[""]
			}
			if ${Me.Raid[3].Name(exists)}
			{
				floatRIHUD3:Set[0.00]
				strRIHUD3F:Set[0.00]
				strRIHUD3:Set[":${Me.Raid[3].Name}"]
				if ${Me.Raid[3](exists)}
				{
					floatRIHUD3:Set["${Me.Raid[3].Distance}"]
					strRIHUD3F:Set[${floatRIHUD3.Precision[2]}]
					if ${Me.Raid[3].Target(exists)}
						strRIHUD3:Set[":${Me.Raid[3].Name} => ${Me.Raid[3].Target}"]
					else 
						strRIHUD3:Set[":${Me.Raid[3].Name}"]
				}
				if ${floatRIHUD3}==0
					HUDSet LD3P1 -c FF888888
				elseif ${floatRIHUD3}>0 && ${floatRIHUD3}<20
					HUDSet LD3P1 -c FFFFFFFF
				elseif ${floatRIHUD3}>=20 && ${floatRIHUD3}<30
					HUDSet LD3P1 -c FFFFFF00
				elseif ${floatRIHUD3}>=30 && ${floatRIHUD3}<50
					HUDSet LD3P1 -c FFFF8800
				elseif ${floatRIHUD3}>50
					HUDSet LD3P1 -c FFFF0000
			}
			else
			{
				floatRIHUD3:Set[0.00]
				strRIHUD3F:Set[""]
				strRIHUD3:Set[""]
			}
			if ${Me.Raid[4].Name(exists)}
			{
				floatRIHUD4:Set[0.00]
				strRIHUD4F:Set[0.00]
				strRIHUD4:Set[":${Me.Raid[4].Name}"]
				if ${Me.Raid[4](exists)}
				{
					floatRIHUD4:Set["${Me.Raid[4].Distance}"]
					strRIHUD4F:Set[${floatRIHUD4.Precision[2]}]
					if ${Me.Raid[4].Target(exists)}
						strRIHUD4:Set[":${Me.Raid[4].Name} => ${Me.Raid[4].Target}"]
					else 
						strRIHUD4:Set[":${Me.Raid[4].Name}"]
				}
				if ${floatRIHUD4}==0
					HUDSet LD4P1 -c FF888888
				elseif ${floatRIHUD4}>0 && ${floatRIHUD4}<20
					HUDSet LD4P1 -c FFFFFFFF
				elseif ${floatRIHUD4}>=20 && ${floatRIHUD4}<30
					HUDSet LD4P1 -c FFFFFF00
				elseif ${floatRIHUD4}>=30 && ${floatRIHUD4}<50
					HUDSet LD4P1 -c FFFF8800
				elseif ${floatRIHUD4}>50
					HUDSet LD4P1 -c FFFF0000
			}
			else
			{
				floatRIHUD4:Set[0.00]
				strRIHUD4F:Set[""]
				strRIHUD4:Set[""]
			}
			if ${Me.Raid[5].Name(exists)}
			{
				floatRIHUD5:Set[0.00]
				strRIHUD5F:Set[0.00]
				strRIHUD5:Set[":${Me.Raid[5].Name}"]
				if ${Me.Raid[5](exists)}
				{
					floatRIHUD5:Set["${Me.Raid[5].Distance}"]
					strRIHUD5F:Set[${floatRIHUD5.Precision[2]}]
					if ${Me.Raid[5].Target(exists)}
						strRIHUD5:Set[":${Me.Raid[5].Name} => ${Me.Raid[5].Target}"]
					else 
						strRIHUD5:Set[":${Me.Raid[5].Name}"]
				}
				if ${floatRIHUD5}==0
					HUDSet LD5P1 -c FF888888
				elseif ${floatRIHUD5}>0 && ${floatRIHUD5}<20
					HUDSet LD5P1 -c FFFFFFFF
				elseif ${floatRIHUD5}>=20 && ${floatRIHUD5}<30
					HUDSet LD5P1 -c FFFFFF00
				elseif ${floatRIHUD5}>=30 && ${floatRIHUD5}<50
					HUDSet LD5P1 -c FFFF8800
				elseif ${floatRIHUD5}>50
					HUDSet LD5P1 -c FFFF0000
			}
			else
			{
				floatRIHUD5:Set[0.00]
				strRIHUD5F:Set[""]
				strRIHUD5:Set[""]
			}
			if ${Me.Raid[6].Name(exists)}
			{
				floatRIHUD6:Set[0.00]
				strRIHUD6F:Set[0.00]
				strRIHUD6:Set[":${Me.Raid[6].Name}"]
				if ${Me.Raid[6](exists)}
				{
					floatRIHUD6:Set["${Me.Raid[6].Distance}"]
					strRIHUD6F:Set[${floatRIHUD6.Precision[2]}]
					if ${Me.Raid[6].Target(exists)}
						strRIHUD6:Set[":${Me.Raid[6].Name} => ${Me.Raid[6].Target}"]
					else 
						strRIHUD6:Set[":${Me.Raid[6].Name}"]
				}
				if ${floatRIHUD6}==0
					HUDSet LD6P1 -c FF888888
				elseif ${floatRIHUD6}>0 && ${floatRIHUD6}<20
					HUDSet LD6P1 -c FFFFFFFF
				elseif ${floatRIHUD6}>=20 && ${floatRIHUD6}<30
					HUDSet LD6P1 -c FFFFFF00
				elseif ${floatRIHUD6}>=30 && ${floatRIHUD6}<50
					HUDSet LD6P1 -c FFFF8800
				elseif ${floatRIHUD6}>50
					HUDSet LD6P1 -c FFFF0000
			}
			else
			{
				floatRIHUD6:Set[0.00]
				strRIHUD6F:Set[""]
				strRIHUD6:Set[""]
			}
			if ${Me.Raid[7].Name(exists)}
			{
				floatRIHUD7:Set[0.00]
				strRIHUD7F:Set[0.00]
				strRIHUD7:Set[":${Me.Raid[7].Name}"]
				if ${Me.Raid[7](exists)}
				{
					floatRIHUD7:Set["${Me.Raid[7].Distance}"]
					strRIHUD7F:Set[${floatRIHUD7.Precision[2]}]
					if ${Me.Raid[7].Target(exists)}
						strRIHUD7:Set[":${Me.Raid[7].Name} => ${Me.Raid[7].Target}"]
					else 
						strRIHUD7:Set[":${Me.Raid[7].Name}"]
				}
				if ${floatRIHUD7}==0
					HUDSet LD7P1 -c FF888888
				elseif ${floatRIHUD7}>0 && ${floatRIHUD7}<20
					HUDSet LD7P1 -c FFFFFFFF
				elseif ${floatRIHUD7}>=20 && ${floatRIHUD7}<30
					HUDSet LD7P1 -c FFFFFF00
				elseif ${floatRIHUD7}>=30 && ${floatRIHUD7}<50
					HUDSet LD7P1 -c FFFF8800
				elseif ${floatRIHUD7}>50
					HUDSet LD7P1 -c FFFF0000
			}
			else
			{
				floatRIHUD7:Set[0.00]
				strRIHUD7F:Set[""]
				strRIHUD7:Set[""]
			}
			if ${Me.Raid[8].Name(exists)}
			{
				floatRIHUD8:Set[0.00]
				strRIHUD8F:Set[0.00]
				strRIHUD8:Set[":${Me.Raid[8].Name}"]
				if ${Me.Raid[8](exists)}
				{
					floatRIHUD8:Set["${Me.Raid[8].Distance}"]
					strRIHUD8F:Set[${floatRIHUD8.Precision[2]}]
					if ${Me.Raid[8].Target(exists)}
						strRIHUD8:Set[":${Me.Raid[8].Name} => ${Me.Raid[8].Target}"]
					else 
						strRIHUD8:Set[":${Me.Raid[8].Name}"]
				}
				if ${floatRIHUD8}==0
					HUDSet LD8P1 -c FF888888
				elseif ${floatRIHUD8}>0 && ${floatRIHUD8}<20
					HUDSet LD8P1 -c FFFFFFFF
				elseif ${floatRIHUD8}>=20 && ${floatRIHUD8}<30
					HUDSet LD8P1 -c FFFFFF00
				elseif ${floatRIHUD8}>=30 && ${floatRIHUD8}<50
					HUDSet LD8P1 -c FFFF8800
				elseif ${floatRIHUD8}>50
					HUDSet LD8P1 -c FFFF0000
			}
			else
			{
				floatRIHUD8:Set[0.00]
				strRIHUD8F:Set[""]
				strRIHUD8:Set[""]
			}
			if ${Me.Raid[9].Name(exists)}
			{
				floatRIHUD9:Set[0.00]
				strRIHUD9F:Set[0.00]
				strRIHUD9:Set[":${Me.Raid[9].Name}"]
				if ${Me.Raid[9](exists)}
				{
					floatRIHUD9:Set["${Me.Raid[9].Distance}"]
					strRIHUD9F:Set[${floatRIHUD9.Precision[2]}]
					if ${Me.Raid[9].Target(exists)}
						strRIHUD9:Set[":${Me.Raid[9].Name} => ${Me.Raid[9].Target}"]
					else 
						strRIHUD9:Set[":${Me.Raid[9].Name}"]
				}
				if ${floatRIHUD9}==0
					HUDSet LD9P1 -c FF888888
				elseif ${floatRIHUD9}>0 && ${floatRIHUD9}<20
					HUDSet LD9P1 -c FFFFFFFF
				elseif ${floatRIHUD9}>=20 && ${floatRIHUD9}<30
					HUDSet LD9P1 -c FFFFFF00
				elseif ${floatRIHUD9}>=30 && ${floatRIHUD9}<50
					HUDSet LD9P1 -c FFFF8800
				elseif ${floatRIHUD9}>50
					HUDSet LD9P1 -c FFFF0000
			}
			else
			{
				floatRIHUD9:Set[0.00]
				strRIHUD9F:Set[""]
				strRIHUD9:Set[""]
			}
			if ${Me.Raid[10].Name(exists)}
			{
				floatRIHUD10:Set[0.00]
				strRIHUD10F:Set[0.00]
				strRIHUD10:Set[":${Me.Raid[10].Name}"]
				if ${Me.Raid[10](exists)}
				{
					floatRIHUD10:Set["${Me.Raid[10].Distance}"]
					strRIHUD10F:Set[${floatRIHUD10.Precision[2]}]
					if ${Me.Raid[10].Target(exists)}
						strRIHUD10:Set[":${Me.Raid[10].Name} => ${Me.Raid[10].Target}"]
					else 
						strRIHUD10:Set[":${Me.Raid[10].Name}"]
				}
				if ${floatRIHUD10}==0
					HUDSet LD10P1 -c FF888888
				elseif ${floatRIHUD10}>0 && ${floatRIHUD10}<20
					HUDSet LD10P1 -c FFFFFFFF
				elseif ${floatRIHUD10}>=20 && ${floatRIHUD10}<30
					HUDSet LD10P1 -c FFFFFF00
				elseif ${floatRIHUD10}>=30 && ${floatRIHUD10}<50
					HUDSet LD10P1 -c FFFF8800
				elseif ${floatRIHUD10}>50
					HUDSet LD10P1 -c FFFF0000
			}
			else
			{
				floatRIHUD10:Set[0.00]
				strRIHUD10F:Set[""]
				strRIHUD10:Set[""]
			}
			if ${Me.Raid[11].Name(exists)}
			{
				floatRIHUD11:Set[0.00]
				strRIHUD11F:Set[0.00]
				strRIHUD11:Set[":${Me.Raid[11].Name}"]
				if ${Me.Raid[11](exists)}
				{
					floatRIHUD11:Set["${Me.Raid[11].Distance}"]
					strRIHUD11F:Set[${floatRIHUD11.Precision[2]}]
					if ${Me.Raid[11].Target(exists)}
						strRIHUD11:Set[":${Me.Raid[11].Name} => ${Me.Raid[11].Target}"]
					else 
						strRIHUD11:Set[":${Me.Raid[11].Name}"]
				}
				if ${floatRIHUD11}==0
					HUDSet LD11P1 -c FF888888
				elseif ${floatRIHUD11}>0 && ${floatRIHUD11}<20
					HUDSet LD11P1 -c FFFFFFFF
				elseif ${floatRIHUD11}>=20 && ${floatRIHUD11}<30
					HUDSet LD11P1 -c FFFFFF00
				elseif ${floatRIHUD11}>=30 && ${floatRIHUD11}<50
					HUDSet LD11P1 -c FFFF8800
				elseif ${floatRIHUD11}>50
					HUDSet LD11P1 -c FFFF0000
			}
			else
			{
				floatRIHUD11:Set[0.00]
				strRIHUD11F:Set[""]
				strRIHUD11:Set[""]
			}
			if ${Me.Raid[12].Name(exists)}
			{
				floatRIHUD12:Set[0.00]
				strRIHUD12F:Set[0.00]
				strRIHUD12:Set[":${Me.Raid[12].Name}"]
				if ${Me.Raid[12](exists)}
				{
					floatRIHUD12:Set["${Me.Raid[12].Distance}"]
					strRIHUD12F:Set[${floatRIHUD12.Precision[2]}]
					if ${Me.Raid[12].Target(exists)}
						strRIHUD12:Set[":${Me.Raid[12].Name} => ${Me.Raid[12].Target}"]
					else 
						strRIHUD12:Set[":${Me.Raid[12].Name}"]
				}
				if ${floatRIHUD12}==0
					HUDSet LD12P1 -c FF888888
				elseif ${floatRIHUD12}>0 && ${floatRIHUD12}<20
					HUDSet LD12P1 -c FFFFFFFF
				elseif ${floatRIHUD12}>=20 && ${floatRIHUD12}<30
					HUDSet LD12P1 -c FFFFFF00
				elseif ${floatRIHUD12}>=30 && ${floatRIHUD12}<50
					HUDSet LD12P1 -c FFFF8800
				elseif ${floatRIHUD12}>50
					HUDSet LD12P1 -c FFFF0000
			}
			else
			{
				floatRIHUD12:Set[0.00]
				strRIHUD12F:Set[""]
				strRIHUD12:Set[""]
			}
			if ${Me.Raid[13].Name(exists)}
			{
				floatRIHUD13:Set[0.00]
				strRIHUD13F:Set[0.00]
				strRIHUD13:Set[":${Me.Raid[13].Name}"]
				if ${Me.Raid[13](exists)}
				{
					floatRIHUD13:Set["${Me.Raid[13].Distance}"]
					strRIHUD13F:Set[${floatRIHUD13.Precision[2]}]
					if ${Me.Raid[13].Target(exists)}
						strRIHUD13:Set[":${Me.Raid[13].Name} => ${Me.Raid[13].Target}"]
					else 
						strRIHUD13:Set[":${Me.Raid[13].Name}"]
				}
				if ${floatRIHUD13}==0
					HUDSet LD13P1 -c FF888888
				elseif ${floatRIHUD13}>0 && ${floatRIHUD13}<20
					HUDSet LD13P1 -c FFFFFFFF
				elseif ${floatRIHUD13}>=20 && ${floatRIHUD13}<30
					HUDSet LD13P1 -c FFFFFF00
				elseif ${floatRIHUD13}>=30 && ${floatRIHUD13}<50
					HUDSet LD13P1 -c FFFF8800
				elseif ${floatRIHUD13}>50
					HUDSet LD13P1 -c FFFF0000
			}
			else
			{
				floatRIHUD13:Set[0.00]
				strRIHUD13F:Set[""]
				strRIHUD13:Set[""]
			}
			if ${Me.Raid[14].Name(exists)}
			{
				floatRIHUD14:Set[0.00]
				strRIHUD14F:Set[0.00]
				strRIHUD14:Set[":${Me.Raid[14].Name}"]
				if ${Me.Raid[14](exists)}
				{
					floatRIHUD14:Set["${Me.Raid[14].Distance}"]
					strRIHUD14F:Set[${floatRIHUD14.Precision[2]}]
					if ${Me.Raid[14].Target(exists)}
						strRIHUD14:Set[":${Me.Raid[14].Name} => ${Me.Raid[14].Target}"]
					else 
						strRIHUD14:Set[":${Me.Raid[14].Name}"]
				}
				if ${floatRIHUD14}==0
					HUDSet LD14P1 -c FF888888
				elseif ${floatRIHUD14}>0 && ${floatRIHUD14}<20
					HUDSet LD14P1 -c FFFFFFFF
				elseif ${floatRIHUD14}>=20 && ${floatRIHUD14}<30
					HUDSet LD14P1 -c FFFFFF00
				elseif ${floatRIHUD14}>=30 && ${floatRIHUD14}<50
					HUDSet LD14P1 -c FFFF8800
				elseif ${floatRIHUD14}>50
					HUDSet LD14P1 -c FFFF0000
			}
			else
			{
				floatRIHUD14:Set[0.00]
				strRIHUD14F:Set[""]
				strRIHUD14:Set[""]
			}
			if ${Me.Raid[15].Name(exists)}
			{
				floatRIHUD15:Set[0.00]
				strRIHUD15F:Set[0.00]
				strRIHUD15:Set[":${Me.Raid[15].Name}"]
				if ${Me.Raid[15](exists)}
				{
					floatRIHUD15:Set["${Me.Raid[15].Distance}"]
					strRIHUD15F:Set[${floatRIHUD15.Precision[2]}]
					if ${Me.Raid[15].Target(exists)}
						strRIHUD15:Set[":${Me.Raid[15].Name} => ${Me.Raid[15].Target}"]
					else 
						strRIHUD15:Set[":${Me.Raid[15].Name}"]
				}
				if ${floatRIHUD15}==0
					HUDSet LD15P1 -c FF888888
				elseif ${floatRIHUD15}>0 && ${floatRIHUD15}<20
					HUDSet LD15P1 -c FFFFFFFF
				elseif ${floatRIHUD15}>=20 && ${floatRIHUD15}<30
					HUDSet LD15P1 -c FFFFFF00
				elseif ${floatRIHUD15}>=30 && ${floatRIHUD15}<50
					HUDSet LD15P1 -c FFFF8800
				elseif ${floatRIHUD15}>50
					HUDSet LD15P1 -c FFFF0000
			}
			else
			{
				floatRIHUD15:Set[0.00]
				strRIHUD15F:Set[""]
				strRIHUD15:Set[""]
			}
			if ${Me.Raid[16].Name(exists)}
			{
				floatRIHUD16:Set[0.00]
				strRIHUD16F:Set[0.00]
				strRIHUD16:Set[":${Me.Raid[16].Name}"]
				if ${Me.Raid[16](exists)}
				{
					floatRIHUD16:Set["${Me.Raid[16].Distance}"]
					strRIHUD16F:Set[${floatRIHUD16.Precision[2]}]
					if ${Me.Raid[16].Target(exists)}
						strRIHUD16:Set[":${Me.Raid[16].Name} => ${Me.Raid[16].Target}"]
					else 
						strRIHUD16:Set[":${Me.Raid[16].Name}"]
				}
				if ${floatRIHUD16}==0
					HUDSet LD16P1 -c FF888888
				elseif ${floatRIHUD16}>0 && ${floatRIHUD16}<20
					HUDSet LD16P1 -c FFFFFFFF
				elseif ${floatRIHUD16}>=20 && ${floatRIHUD16}<30
					HUDSet LD16P1 -c FFFFFF00
				elseif ${floatRIHUD16}>=30 && ${floatRIHUD16}<50
					HUDSet LD16P1 -c FFFF8800
				elseif ${floatRIHUD16}>50
					HUDSet LD16P1 -c FFFF0000
			}
			else
			{
				floatRIHUD16:Set[0.00]
				strRIHUD16F:Set[""]
				strRIHUD16:Set[""]
			}
			if ${Me.Raid[17].Name(exists)}
			{
				floatRIHUD17:Set[0.00]
				strRIHUD17F:Set[0.00]
				strRIHUD17:Set[":${Me.Raid[17].Name}"]
				if ${Me.Raid[17](exists)}
				{
					floatRIHUD17:Set["${Me.Raid[17].Distance}"]
					strRIHUD17F:Set[${floatRIHUD17.Precision[2]}]
					if ${Me.Raid[17].Target(exists)}
						strRIHUD17:Set[":${Me.Raid[17].Name} => ${Me.Raid[17].Target}"]
					else 
						strRIHUD17:Set[":${Me.Raid[17].Name}"]
				}
				if ${floatRIHUD17}==0
					HUDSet LD17P1 -c FF888888
				elseif ${floatRIHUD17}>0 && ${floatRIHUD17}<20
					HUDSet LD17P1 -c FFFFFFFF
				elseif ${floatRIHUD17}>=20 && ${floatRIHUD17}<30
					HUDSet LD17P1 -c FFFFFF00
				elseif ${floatRIHUD17}>=30 && ${floatRIHUD17}<50
					HUDSet LD17P1 -c FFFF8800
				elseif ${floatRIHUD17}>50
					HUDSet LD17P1 -c FFFF0000
			}
			else
			{
				floatRIHUD17:Set[0.00]
				strRIHUD17F:Set[""]
				strRIHUD17:Set[""]
			}
			if ${Me.Raid[18].Name(exists)}
			{
				floatRIHUD18:Set[0.00]
				strRIHUD18F:Set[0.00]
				strRIHUD18:Set[":${Me.Raid[18].Name}"]
				if ${Me.Raid[18](exists)}
				{
					floatRIHUD18:Set["${Me.Raid[18].Distance}"]
					strRIHUD18F:Set[${floatRIHUD18.Precision[2]}]
					if ${Me.Raid[18].Target(exists)}
						strRIHUD18:Set[":${Me.Raid[18].Name} => ${Me.Raid[18].Target}"]
					else 
						strRIHUD18:Set[":${Me.Raid[18].Name}"]
				}
				if ${floatRIHUD18}==0
					HUDSet LD18P1 -c FF888888
				elseif ${floatRIHUD18}>0 && ${floatRIHUD18}<20
					HUDSet LD18P1 -c FFFFFFFF
				elseif ${floatRIHUD18}>=20 && ${floatRIHUD18}<30
					HUDSet LD18P1 -c FFFFFF00
				elseif ${floatRIHUD18}>=30 && ${floatRIHUD18}<50
					HUDSet LD18P1 -c FFFF8800
				elseif ${floatRIHUD18}>50
					HUDSet LD18P1 -c FFFF0000
			}
			else
			{
				floatRIHUD18:Set[0.00]
				strRIHUD18F:Set[""]
				strRIHUD18:Set[""]
			}
			if ${Me.Raid[19].Name(exists)}
			{
				floatRIHUD19:Set[0.00]
				strRIHUD19F:Set[0.00]
				strRIHUD19:Set[":${Me.Raid[19].Name}"]
				if ${Me.Raid[19](exists)}
				{
					floatRIHUD19:Set["${Me.Raid[19].Distance}"]
					strRIHUD19F:Set[${floatRIHUD19.Precision[2]}]
					if ${Me.Raid[19].Target(exists)}
						strRIHUD19:Set[":${Me.Raid[19].Name} => ${Me.Raid[19].Target}"]
					else 
						strRIHUD19:Set[":${Me.Raid[19].Name}"]
				}
				if ${floatRIHUD19}==0
					HUDSet LD19P1 -c FF888888
				elseif ${floatRIHUD19}>0 && ${floatRIHUD19}<20
					HUDSet LD19P1 -c FFFFFFFF
				elseif ${floatRIHUD19}>=20 && ${floatRIHUD19}<30
					HUDSet LD19P1 -c FFFFFF00
				elseif ${floatRIHUD19}>=30 && ${floatRIHUD19}<50
					HUDSet LD19P1 -c FFFF8800
				elseif ${floatRIHUD19}>50
					HUDSet LD19P1 -c FFFF0000
			}
			else
			{
				floatRIHUD19:Set[0.00]
				strRIHUD19F:Set[""]
				strRIHUD19:Set[""]
			}
			if ${Me.Raid[20].Name(exists)}
			{
				floatRIHUD20:Set[0.00]
				strRIHUD20F:Set[0.00]
				strRIHUD20:Set[":${Me.Raid[20].Name}"]
				if ${Me.Raid[20](exists)}
				{
					floatRIHUD20:Set["${Me.Raid[20].Distance}"]
					strRIHUD20F:Set[${floatRIHUD20.Precision[2]}]
					if ${Me.Raid[20].Target(exists)}
						strRIHUD20:Set[":${Me.Raid[20].Name} => ${Me.Raid[20].Target}"]
					else 
						strRIHUD20:Set[":${Me.Raid[20].Name}"]
				}
				if ${floatRIHUD20}==0
					HUDSet LD20P1 -c FF888888
				elseif ${floatRIHUD20}>0 && ${floatRIHUD20}<20
					HUDSet LD20P1 -c FFFFFFFF
				elseif ${floatRIHUD20}>=20 && ${floatRIHUD20}<30
					HUDSet LD20P1 -c FFFFFF00
				elseif ${floatRIHUD20}>=30 && ${floatRIHUD20}<50
					HUDSet LD20P1 -c FFFF8800
				elseif ${floatRIHUD20}>50
					HUDSet LD20P1 -c FFFF0000
			}
			else
			{
				floatRIHUD20:Set[0.00]
				strRIHUD20F:Set[""]
				strRIHUD20:Set[""]
			}
			if ${Me.Raid[21].Name(exists)}
			{
				floatRIHUD21:Set[0.00]
				strRIHUD21F:Set[0.00]
				strRIHUD21:Set[":${Me.Raid[21].Name}"]
				if ${Me.Raid[21](exists)}
				{
					floatRIHUD21:Set["${Me.Raid[21].Distance}"]
					strRIHUD21F:Set[${floatRIHUD21.Precision[2]}]
					if ${Me.Raid[21].Target(exists)}
						strRIHUD21:Set[":${Me.Raid[21].Name} => ${Me.Raid[21].Target}"]
					else 
						strRIHUD21:Set[":${Me.Raid[21].Name}"]
				}
				if ${floatRIHUD21}==0
					squelch HUDSet LD21P1 -c FF888888
				elseif ${floatRIHUD21}>0 && ${floatRIHUD21}<20
					squelch HUDSet LD21P1 -c FFFFFFFF
				elseif ${floatRIHUD21}>=20 && ${floatRIHUD21}<30
					squelch HUDSet LD21P1 -c FFFFFF00
				elseif ${floatRIHUD21}>=30 && ${floatRIHUD21}<50
					squelch HUDSet LD21P1 -c FFFF8800
				elseif ${floatRIHUD21}>50
					squelch HUDSet LD21P1 -c FFFF0000
			}
			else
			{
				floatRIHUD21:Set[0.00]
				strRIHUD21F:Set[""]
				strRIHUD21:Set[""]
			}
			if ${Me.Raid[22].Name(exists)}
			{
				floatRIHUD22:Set[0.00]
				strRIHUD22F:Set[0.00]
				strRIHUD22:Set[":${Me.Raid[22].Name}"]
				if ${Me.Raid[22](exists)}
				{
					floatRIHUD22:Set["${Me.Raid[22].Distance}"]
					strRIHUD22F:Set[${floatRIHUD22.Precision[2]}]
					if ${Me.Raid[22].Target(exists)}
						strRIHUD22:Set[":${Me.Raid[22].Name} => ${Me.Raid[22].Target}"]
					else 
						strRIHUD22:Set[":${Me.Raid[22].Name}"]
				}
				if ${floatRIHUD22}==0
					HUDSet LD22P1 -c FF888888
				elseif ${floatRIHUD22}>0 && ${floatRIHUD22}<20
					HUDSet LD22P1 -c FFFFFFFF
				elseif ${floatRIHUD22}>=20 && ${floatRIHUD22}<30
					HUDSet LD22P1 -c FFFFFF00
				elseif ${floatRIHUD22}>=30 && ${floatRIHUD22}<50
					HUDSet LD22P1 -c FFFF8800
				elseif ${floatRIHUD22}>50
					HUDSet LD22P1 -c FFFF0000
			}
			else
			{
				floatRIHUD22:Set[0.00]
				strRIHUD22F:Set[""]
				strRIHUD22:Set[""]
			}
			if ${Me.Raid[23].Name(exists)}
			{
				floatRIHUD23:Set[0.00]
				strRIHUD23F:Set[0.00]
				strRIHUD23:Set[":${Me.Raid[23].Name}"]
				if ${Me.Raid[23](exists)}
				{
					floatRIHUD23:Set["${Me.Raid[23].Distance}"]
					strRIHUD23F:Set[${floatRIHUD23.Precision[2]}]
					if ${Me.Raid[23].Target(exists)}
						strRIHUD23:Set[":${Me.Raid[23].Name} => ${Me.Raid[23].Target}"]
					else 
						strRIHUD23:Set[":${Me.Raid[23].Name}"]
				}
				if ${floatRIHUD23}==0
					HUDSet LD23P1 -c FF888888
				elseif ${floatRIHUD23}>0 && ${floatRIHUD23}<20
					HUDSet LD23P1 -c FFFFFFFF
				elseif ${floatRIHUD23}>=20 && ${floatRIHUD23}<30
					HUDSet LD23P1 -c FFFFFF00
				elseif ${floatRIHUD23}>=30 && ${floatRIHUD23}<50
					HUDSet LD23P1 -c FFFF8800
				elseif ${floatRIHUD23}>50
					HUDSet LD23P1 -c FFFF0000
			}
			else
			{
				floatRIHUD23:Set[0.00]
				strRIHUD23F:Set[""]
				strRIHUD23:Set[""]
			}
			if ${Me.Raid[24].Name(exists)}
			{
				floatRIHUD24:Set[0.00]
				strRIHUD24F:Set[0.00]
				strRIHUD24:Set[":${Me.Raid[24].Name}"]
				if ${Me.Raid[24](exists)}
				{
					floatRIHUD24:Set["${Me.Raid[24].Distance}"]
					strRIHUD24F:Set[${floatRIHUD24.Precision[2]}]
					if ${Me.Raid[24].Target(exists)}
						strRIHUD24:Set[":${Me.Raid[24].Name} => ${Me.Raid[24].Target}"]
					else 
						strRIHUD24:Set[":${Me.Raid[24].Name}"]
				}
				if ${floatRIHUD24}==0
					HUDSet LD24P1 -c FF888888
				elseif ${floatRIHUD24}>0 && ${floatRIHUD24}<20
					HUDSet LD24P1 -c FFFFFFFF
				elseif ${floatRIHUD24}>=20 && ${floatRIHUD24}<30
					HUDSet LD24P1 -c FFFFFF00
				elseif ${floatRIHUD24}>=30 && ${floatRIHUD24}<50
					HUDSet LD24P1 -c FFFF8800
				elseif ${floatRIHUD24}>50
					HUDSet LD24P1 -c FFFF0000
			}
		}
		else
		{
			floatRIHUD7:Set[0.00]
			strRIHUD7F:Set[""]
			strRIHUD7:Set[""]
			floatRIHUD8:Set[0.00]
			strRIHUD8F:Set[""]
			strRIHUD8:Set[""]
			floatRIHUD9:Set[0.00]
			strRIHUD9F:Set[""]
			strRIHUD9:Set[""]
			floatRIHUD10:Set[0.00]
			strRIHUD10F:Set[""]
			strRIHUD10:Set[""]
			floatRIHUD11:Set[0.00]
			strRIHUD11F:Set[""]
			strRIHUD11:Set[""]
			floatRIHUD12:Set[0.00]
			strRIHUD12F:Set[""]
			strRIHUD12:Set[""]
			floatRIHUD13:Set[0.00]
			strRIHUD13F:Set[""]
			strRIHUD13:Set[""]
			floatRIHUD14:Set[0.00]
			strRIHUD14F:Set[""]
			strRIHUD14:Set[""]
			floatRIHUD15:Set[0.00]
			strRIHUD15F:Set[""]
			strRIHUD15:Set[""]
			floatRIHUD16:Set[0.00]
			strRIHUD16F:Set[""]
			strRIHUD16:Set[""]
			floatRIHUD17:Set[0.00]
			strRIHUD17F:Set[""]
			strRIHUD17:Set[""]
			floatRIHUD18:Set[0.00]
			strRIHUD18F:Set[""]
			strRIHUD18:Set[""]
			floatRIHUD19:Set[0.00]
			strRIHUD19F:Set[""]
			strRIHUD19:Set[""]
			floatRIHUD20:Set[0.00]
			strRIHUD20F:Set[""]
			strRIHUD20:Set[""]
			floatRIHUD21:Set[0.00]
			strRIHUD21F:Set[""]
			strRIHUD21:Set[""]
			floatRIHUD22:Set[0.00]
			strRIHUD22F:Set[""]
			strRIHUD22:Set[""]
			floatRIHUD23:Set[0.00]
			strRIHUD23F:Set[""]
			strRIHUD23:Set[""]
			floatRIHUD24:Set[0.00]
			strRIHUD24F:Set[""]
			strRIHUD24:Set[""]
			if ${Me.Group}>=1
			{
				floatRIHUD1:Set[0.00]
				strRIHUD1F:Set[0.00]
				if ${Me.Target(exists)}
					strRIHUD1:Set[":${Me.Name} => ${Me.Target} => ${Me.Distance2D[${Me.Target.X},${Me.Target.Z}].Precision[2]}"]
				else 
					strRIHUD1:Set[":${Me.Name}"]
				HUDSet LD1P1 -c FF888888
			}
			if ${Me.Group}>=2
			{
				if ${Me.Group[1](exists)}
				{
					floatRIHUD2:Set["${Me.Group[1].Distance}"]
					strRIHUD2F:Set[${floatRIHUD2.Precision[2]}]
					if ${Me.Group[1].Target(exists)}
						strRIHUD2:Set[":${Me.Group[1].Name} => ${Me.Group[1].Target}"]
					else 
						strRIHUD2:Set[":${Me.Group[1].Name}"]
				}
				elseif ${Me.Group[1].Name(exists)}
				{
					floatRIHUD2:Set[0.00]
					strRIHUD2F:Set[0.00]
					strRIHUD2:Set[":${Me.Group[1].Name}"]
				}
				if ${floatRIHUD2}==0
					HUDSet LD2P1 -c FF888888
				elseif ${floatRIHUD2}>0 && ${floatRIHUD2}<20
					HUDSet LD2P1 -c FFFFFFFF
				elseif ${floatRIHUD2}>=20 && ${floatRIHUD2}<30
					HUDSet LD2P1 -c FFFFFF00
				elseif ${floatRIHUD2}>=30 && ${floatRIHUD2}<50
					HUDSet LD2P1 -c FFFF8800
				elseif ${floatRIHUD2}>50
					HUDSet LD2P1 -c FFFF0000
			}
			else
			{
				floatRIHUD2:Set[0.00]
				strRIHUD2F:Set[""]
				strRIHUD2:Set[""]
			}
			if ${Me.Group}>=3
			{
				if ${Me.Group[2](exists)}
				{
					floatRIHUD3:Set["${Me.Group[2].Distance}"]
					strRIHUD3F:Set[${floatRIHUD3.Precision[2]}]
					if ${Me.Group[2].Target(exists)}
						strRIHUD3:Set[":${Me.Group[2].Name} => ${Me.Group[2].Target}"]
					else 
						strRIHUD3:Set[":${Me.Group[2].Name}"]
				}
				elseif ${Me.Group[2].Name(exists)}
				{
					floatRIHUD3:Set[0.00]
					strRIHUD3F:Set[0.00]
					strRIHUD3:Set[":${Me.Group[3].Name}"]
				}
				if ${floatRIHUD3}==0
					HUDSet LD3P1 -c FF888888
				elseif ${floatRIHUD3}>0 && ${floatRIHUD3}<20
					HUDSet LD3P1 -c FFFFFFFF
				elseif ${floatRIHUD3}>=20 && ${floatRIHUD3}<30
					HUDSet LD3P1 -c FFFFFF00
				elseif ${floatRIHUD3}>=30 && ${floatRIHUD3}<50
					HUDSet LD3P1 -c FFFF8800
				elseif ${floatRIHUD3}>50
					HUDSet LD3P1 -c FFFF0000
			}
			else
			{
				floatRIHUD3:Set[0.00]
				strRIHUD3F:Set[""]
				strRIHUD3:Set[""]
			}
			if ${Me.Group}>=4
			{
				if ${Me.Group[3](exists)}
				{
					floatRIHUD4:Set["${Me.Group[3].Distance}"]
					strRIHUD4F:Set[${floatRIHUD4.Precision[2]}]
					if ${Me.Group[3].Target(exists)}
						strRIHUD4:Set[":${Me.Group[3].Name} => ${Me.Group[3].Target}"]
					else 
						strRIHUD4:Set[":${Me.Group[3].Name}"]
				}
				elseif ${Me.Group[3].Name(exists)}
				{
					floatRIHUD4:Set[0.00]
					strRIHUD4F:Set[0.00]
					strRIHUD4:Set[":${Me.Group[3].Name}"]
				}
				if ${floatRIHUD4}==0
					HUDSet LD4P1 -c FF888888
				elseif ${floatRIHUD4}>0 && ${floatRIHUD4}<20
					HUDSet LD4P1 -c FFFFFFFF
				elseif ${floatRIHUD4}>=20 && ${floatRIHUD4}<30
					HUDSet LD4P1 -c FFFFFF00
				elseif ${floatRIHUD4}>=30 && ${floatRIHUD4}<50
					HUDSet LD4P1 -c FFFF8800
				elseif ${floatRIHUD4}>50
					HUDSet LD4P1 -c FFFF0000
			}
			else
			{
				floatRIHUD4:Set[0.00]
				strRIHUD4F:Set[""]
				strRIHUD4:Set[""]
			}
			if ${Me.Group}>=5
			{
				if ${Me.Group[4](exists)}
				{
					floatRIHUD5:Set["${Me.Group[4].Distance}"]
					strRIHUD5F:Set[${floatRIHUD5.Precision[2]}]
					if ${Me.Group[4].Target(exists)}
						strRIHUD5:Set[":${Me.Group[4].Name} => ${Me.Group[4].Target}"]
					else 
						strRIHUD5:Set[":${Me.Group[4].Name}"]
				}
				elseif ${Me.Group[4].Name(exists)}
				{
					floatRIHUD5:Set[0.00]
					strRIHUD5F:Set[0.00]
					strRIHUD5:Set[":${Me.Group[4].Name}"]
				}
				if ${floatRIHUD5}==0
					HUDSet LD5P1 -c FF888888
				elseif ${floatRIHUD5}>0 && ${floatRIHUD5}<20
					HUDSet LD5P1 -c FFFFFFFF
				elseif ${floatRIHUD5}>=20 && ${floatRIHUD5}<30
					HUDSet LD5P1 -c FFFFFF00
				elseif ${floatRIHUD5}>=30 && ${floatRIHUD5}<50
					HUDSet LD5P1 -c FFFF8800
				elseif ${floatRIHUD5}>50
					HUDSet LD5P1 -c FFFF0000
			}
			else
			{
				floatRIHUD5:Set[0.00]
				strRIHUD5F:Set[""]
				strRIHUD5:Set[""]
			}
			if ${Me.Group}>=6
			{
				if ${Me.Group[5](exists)}
				{
					floatRIHUD6:Set["${Me.Group[5].Distance}"]
					strRIHUD6F:Set[${floatRIHUD6.Precision[2]}]
					if ${Me.Group[5].Target(exists)}
						strRIHUD6:Set[":${Me.Group[5].Name} => ${Me.Group[5].Target}"]
					else 
						strRIHUD6:Set[":${Me.Group[5].Name}"]
				}
				elseif ${Me.Group[5].Name(exists)}
				{
					floatRIHUD6:Set[0.00]
					strRIHUD6F:Set[0.00]
					strRIHUD6:Set[":${Me.Group[5].Name}"]
				}
				if ${floatRIHUD6}==0
					HUDSet LD6P1 -c FF888888
				elseif ${floatRIHUD6}>0 && ${floatRIHUD6}<20
					HUDSet LD6P1 -c FFFFFFFF
				elseif ${floatRIHUD6}>=20 && ${floatRIHUD6}<30
					HUDSet LD6P1 -c FFFFFF00
				elseif ${floatRIHUD6}>=30 && ${floatRIHUD6}<50
					HUDSet LD6P1 -c FFFF8800
				elseif ${floatRIHUD6}>50
					HUDSet LD6P1 -c FFFF0000
			}
			else
			{
				floatRIHUD6:Set[0.00]
				strRIHUD6F:Set[""]
				strRIHUD6:Set[""]
			}
		}
	}
}
;;;;;;;;;;;;;;;;;;;;;;;;;HUDS END

atom RI_Atom_SaveButton(string ButtonName)
{
	variable string txtvariable
	variable string comvariable
	txtvariable:Set["${RI_String_RIMUI_${ButtonName}Txt.Escape}"]
	comvariable:Set["${RI_String_RIMUI_${ButtonName}Com.Escape}"]
	;echo ${txtvariable}
	;echo ${comvariable}
	;clear out the set if it exists
	if ${Set.FindSet["${ButtonName}"](exists)}
		Set.FindSet["${ButtonName}"]:Remove
	Set:AddSet[${ButtonName}]
	Set.FindSet[${ButtonName}]:AddSetting[Txt,"${txtvariable.Escape}"]
	Set.FindSet[${ButtonName}]:AddSetting[Com,"${comvariable.Escape}"]
	LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
}
atom RI_Atom_SaveNameOnlyButton(string ButtonName)
{
	variable string txtvariable
	;variable string comvariable
	txtvariable:Set["${RI_String_RIMUI_${ButtonName}Txt}"]
	;comvariable:Set["${RI_String_RIMUI_${ButtonName}Com}"]
	;echo ${txtvariable}
	;echo ${comvariable}
	;clear out the set if it exists
	if ${Set.FindSet["${ButtonName}"](exists)}
		Set.FindSet["${ButtonName}"]:Remove
	Set:AddSet[${ButtonName}]
	Set.FindSet[${ButtonName}]:AddSetting[Txt,"${txtvariable}"]
	;Set.FindSet[${ButtonName}]:AddSetting[Com,"${comvariable}"]
	LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
}
atom RI_Atom_SaveSize(string Size)
{
	if ${Set.FindSet[Size](exists)}
		Set.FindSet[Size]:Remove
	Set:AddSet[Size]
	Set.FindSet[Size]:AddSetting[Size,"${Size}"]
	LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
}
atom RI_Atom_SaveRG(bool Checked)
{
	if ${Set.FindSet[RelayGroup](exists)}
		Set.FindSet[RelayGroup]:Remove
	Set:AddSet[RelayGroup]
	Set.FindSet[RelayGroup]:AddSetting[RelayGroup,"${Checked}"]
	LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
}
atom RI_Atom_ClearButton(string ButtonName)
{
	if ${Set.FindSet["${ButtonName}"](exists)}
		Set.FindSet["${ButtonName}"]:Remove
	LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
}
atom aLoadRIMUI()
{
	CommandQ:Set[TRUE]
	LoadRIMUI:Set[TRUE]
}
;LoadRIMUI function
function LoadRIMUI(bool _LoadUI=TRUE)
{
	if ${_LoadUI}
		RIMUILoaded:Set[TRUE]
	;IterateSet
	;return
	;load xmlfile
	LavishSettings[RIMUI]:Clear
	LavishSettings:AddSet[RIMUI]
	LavishSettings[RIMUI]:Import["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
	
	;import Set
	Set:Set[${LavishSettings[RIMUI].FindSet[RIMUI].GUID}]
	variable int SetCount=${CountSets.Count[${Set}]}
	variable int FailCounter=0
	while ${CountSets.Count[${Set}]}<1 && ${FailCounter:Inc}<10
	{
		;echo Set: ${CountSets.Count[${Set}]}==0
		LavishSettings[RIMUI]:Import["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
		Set:Set[${LavishSettings[RIMUI].FindSet[RIMUI].GUID}]
		wait 5
	}
	if ${FailCounter}>=10
	{
		echo ISXRI: Error loading RIMUICustom.xml settings file, could be a corrupt file
		RIMUILoaded:Set[FALSE]
		return
	}
	
	IterateSet ${Set}
	wait 5
	
	;relay all -noredirect execute \${If[\${Script[Buffer:RIMovement](exists)},noop,RIMovement]}
	;wait 5
	if ${_LoadUI}
		LoadUI
}
;RIFollowPop function
function RIFollowPop()
{
	if ${PopForWho.Equal[~NONE~]}
	{
		InputBox "RI Follow For Who? Standard: ALL, Options: All, Class, Name, Off"
		;variable string RIFW=${UserInput}
		if ${UserInput.NotEqual[NULL]}
		{
			if ${UserInput.Equal[""]}
			{
				PopForWho:Set[ALL]
				;echo Blank
			}
			else
			{
				PopForWho:Set[${UserInput}]
				;echo we got ${RIFW}
			}
			
		}
		else 
		{
			;echo we got null or blank
			PopForWho:Set[ALL]
		}
	}
	InputBox "RI Follow On Who? Standard: ${Me.Name}, Options: Me, Name, Off"
	variable string RIFOW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			RIFOW:Set[${Me.Name}]
			;echo Blank
		}
		else
		{
			RIFOW:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		RIFOW:Set[${Me.Name}]
	}
	
	InputBox "Min Distance? Standard: 1"
	variable int RIFMin=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			RIFMin:Set[1]
			;echo Blank
		}
		else
		{
			RIFMin:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		RIFMin:Set[1]
	}
	InputBox "Max Distance? Standard: 100"
	variable int RIFMax=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			RIFMax:Set[100]
			;echo Blank
		}
		else
		{
			RIFMax:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		RIFMax:Set[100]
	}
	;echo ${RIFOW}
	;echo relay all ${RIFW} ${Actor[${RIFOW}].ID} ${RIFMin} ${RIFMax}
	relay all RI_Atom_SetRIFollow ${PopForWho} ${Actor[PC,${RIFOW}].ID} ${RIFMin} ${RIFMax}
	CommandQ:Set[FALSE]
	RIFP:Set[FALSE]
	PopForWho:Set[~NONE~]
}
;RILockSpotPop function
function RILockSpotPop()
{
	if ${PopForWho.Equal[~NONE~]}
	{
		InputBox "RI Lockspot For Who? Standard: ALL, Options: All, Class, Name, Off"
		;variable string RILSW=${UserInput}
		if ${UserInput.NotEqual[NULL]}
		{
			if ${UserInput.Equal[""]}
			{
				PopForWho:Set[ALL]
				;echo Blank
			}
			else
			{
				PopForWho:Set[${UserInput}]
				;echo we got ${RILSW}
			}
			
		}
		else 
		{
			;echo we got null or blank
			PopForWho:Set[ALL]
		}
	}
	InputBox "RI LockSpot Input(with Spaces): Standards X=${Me.X} Y=${Me.Y} Z=${Me.Z} Min=1 Max=100"
	variable string RILSXYZMM=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			RILSXYZMM:Set["${Me.X} ${Me.Y} ${Me.Z} 1 100"]
			;echo Blank
		}
		else
		{
			RILSXYZMM:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		RILSXYZMM:Set["${Me.X} ${Me.Y} ${Me.Z} 1 100"]
	}
	
	;echo relay all RI_Atom_SetLockSpot ${RILSW} ${RILSXYZMM}
	relay all RI_Atom_SetLockSpot ${PopForWho} ${RILSXYZMM}
	CommandQ:Set[FALSE]
	RILSP:Set[FALSE]
	PopForWho:Set[~NONE~]
}

;AssistPop function
function AssistPop()
{
	if ${PopForWho.Equal[~NONE~]}
	{
		InputBox "Assist For Who? Standard: ALL, Options: All, Class, Name, Off"
		;variable string ASSW=${UserInput}
		if ${UserInput.NotEqual[NULL]}
		{
			if ${UserInput.Equal[""]}
			{
				PopForWho:Set[ALL]
				;echo Blank
			}
			else
			{
				PopForWho:Set[${UserInput}]
				;echo we got ${ASSW}
			}
			
		}
		else 
		{
			;echo we got null or blank
			PopForWho:Set[ALL]
		}
	}
	InputBox "Assist on Who? Options: NAME, Off"
	variable string ASSOW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			ASSOW:Set["OFF"]
			;echo Blank
		}
		else
		{
			ASSOW:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		ASSOW:Set["OFF"]
	}
	echo relay all RIMUIObj:Assist[${PopForWho},1,${ASSOW}]
	relay all RIMUIObj:Assist[${PopForWho},1,${ASSOW}]
	CommandQ:Set[FALSE]
	ASSP:Set[FALSE]
	PopForWho:Set[~NONE~]
}
;DoorPop Function
function DoorPop()
{
	if ${PopForWho.Equal[~NONE~]}
	{
		InputBox "Door For Who? Standard: ALL, Options: All, Class, Name, Off"
		;variable string DOORW=${UserInput}
		if ${UserInput.NotEqual[NULL]}
		{
			if ${UserInput.Equal[""]}
			{
				PopForWho:Set[ALL]
				;echo Blank
			}
			else
			{
				PopForWho:Set[${UserInput}]
				;echo we got ${ASSW}
			}
			
		}
		else 
		{
			;echo we got null or blank
			PopForWho:Set[ALL]
		}
	}
	InputBox "Door Option?"
	variable string DOOROP=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			DOOROP:Set["OFF"]
			;echo Blank
		}
		else
		{
			DOOROP:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		DOOROP:Set["OFF"]
	}
	
	relay all RIMUIObj:Door[${PopForWho},${DOOROP}]
	CommandQ:Set[FALSE]
	DOORP:Set[FALSE]
	PopForWho:Set[~NONE~]
}
;TravelMapPop Function
function TravelMapPop()
{
	if ${PopForWho.Equal[~NONE~]}
	{
		InputBox "TravelMap For Who? Standard: ALL, Options: All, Class, Name"
		;variable string TMW=${UserInput}
		if ${UserInput.NotEqual[NULL]}
		{
			if ${UserInput.Equal[""]}
			{
				PopForWho:Set[ALL]
				;echo Blank
			}
			else
			{
				PopForWho:Set[${UserInput}]
				;echo we got ${ASSW}
			}
			
		}
		else 
		{
			;echo we got null or blank
			PopForWho:Set[ALL]
		}
	}
	InputBox "ZoneName?"
	variable string TMZN=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			TMZN:Set["~NONE~"]
			;echo Blank
		}
		else
		{
			TMZN:Set[${UserInput}]
			;echo we got ${TMZN}
		}
		
	}
	else 
	{
		;echo we got null or blank
		TMZN:Set["~NONE~"]
	}
	
	relay all RIMUIObj:TravelMap[${PopForWho},"${TMZN}"]
	CommandQ:Set[FALSE]
	TMP:Set[FALSE]
	PopForWho:Set[~NONE~]
}
;FastTravelPop Function
function FastTravelPop()
{
	;echo function FastTravelPop()  PopForWho=${PopForWho}
	if ${PopForWho.Equal[~NONE~]}
	{
		InputBox "FastTravel For Who? Standard: ALL, Options: All, Class, Name"
		;variable string FaTrW=${UserInput}
		if ${UserInput.NotEqual[NULL]}
		{
			if ${UserInput.Equal[""]}
			{
				PopForWho:Set[ALL]
				;echo Blank
			}
			else
			{
				PopForWho:Set[${UserInput}]
				;echo we got ${ASSW}
			}
			
		}
		else 
		{
			;echo we got null or blank
			PopForWho:Set[ALL]
		}
	}
	InputBox "ZoneName?"
	variable string FaTrZN=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			FaTrZN:Set["~NONE~"]
			;echo Blank
		}
		else
		{
			FaTrZN:Set[${UserInput}]
			;echo we got ${TMZN}
		}
		
	}
	else 
	{
		;echo we got null or blank
		FaTrZN:Set["~NONE~"]
	}
	
	relay all RIMUIObj:FastTravel[${PopForWho},"${FaTrZN}"]
	CommandQ:Set[FALSE]
	FaTrP:Set[FALSE]
	PopForWho:Set[~NONE~]
}
;object CountSetsObject
objectdef CountSetsObject
{
	;countsettings in set
	member:int Count(settingsetref Set)
	{
		variable iterator Iterator
		Set:GetSetIterator[Iterator]
		variable int csoCount
		;echo ${Set.Name}

		if !${Iterator:First(exists)}
			return

		do
		{
			csoCount:Inc
			;waitframe
		}
		while ${Iterator:Next(exists)}
		 
		return ${csoCount}
	}
}
atom LoadUI()
{
	ui -reload "${RI_Var_String_SkinFileName}"
	ui -reload -skin ${RI_Var_String_SkinName} "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
	
	if ${Size.Equal[Small]}
	{
		RIMUIObj:UISmall[0]
	}
	if ${Size.Equal[Medium]}
	{
		RIMUIObj:UIMedium[0]
	}
	if ${Size.Equal[Large]}
	{
		RIMUIObj:UILarge[0]
	}
	if ${RelayGroupChecked}	
		UIElement[RelayGroup@Titlebar@RIMovementUI]:SetChecked
	else
		UIElement[RelayGroup@Titlebar@RIMovementUI]:UnsetChecked
	This:RelayGroup[0]
}

atom IterateSet(settingsetref Set)
{
	;set variables
	variable bool export=FALSE
	variable string commandT
	variable string commandC
	variable string Value
	variable settingsetref Set4
	variable int icCount=0
	variable int jcCount=0
	variable int kcCount=0
	Set4:Set[${Set.FindSet[Size].GUID}]
	variable iterator SettingIterators
	Set4:GetSettingIterator[SettingIterators]
	
	if ${SettingIterators:First(exists)}
	{
		do
		{
			;echo "${SettingIterators.Key}=${SettingIterators.Value}"
			Size:Set[${SettingIterators.Value}]
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
		}
		while ${SettingIterators:Next(exists)}
	}
	Set4:Set[${Set.FindSet[RIConsoleSize].GUID}]
	Set4:GetSettingIterator[SettingIterators]
	
	if ${SettingIterators:First(exists)}
	{
		do
		{
			;echo "${SettingIterators.Key}=${SettingIterators.Value}"
			RIConsoleSize:Set[${SettingIterators.Value}]
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
		}
		while ${SettingIterators:Next(exists)}
	}
	Set4:Set[${Set.FindSet[RelayGroup].GUID}]
	Set4:GetSettingIterator[SettingIterators]
	
	if ${SettingIterators:First(exists)}
	{
		do
		{
			;echo "${SettingIterators.Key}=${SettingIterators.Value}"
			Value:Set[${SettingIterators.Value}]
			if ${Value.Equal[TRUE]}
				RelayGroupChecked:Set[TRUE]
			else
				RelayGroupChecked:Set[FALSE]
			;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
		}
		while ${SettingIterators:Next(exists)}
	}
	for(icCount:Set[1];${icCount}<=2;icCount:Inc)
	{
		for(jcCount:Set[1];${jcCount}<=10;jcCount:Inc)
		{
			if ${Set.FindSet["BTNR${jcCount}C${icCount}"](exists)}
			{
				Set4:Set[${Set.FindSet["BTNR${jcCount}C${icCount}"].GUID}]
				variable iterator SettingIterator
				Set4:GetSettingIterator[SettingIterator]
				if ${SettingIterator:First(exists)}
				{
					do
					{
						if ${SettingIterator.Key.Equal[Com]}
						{
							if ${SettingIterator.Value.String.Left[9].Equal["relay all"]}
							{
								SettingIterator.Value:Set["${SettingIterator.Value.String.Escape.Right[-10]}"]
								export:Set[1]
							}
							commandC:Set["RI_String_RIMUI_BTNR${jcCount}C${icCount}Com:Set[\"\${SettingIterator.Value.String.Escape}\"]"]
							;this ${${}} parses it as a data sequence 
							noop ${${commandC}}
							;echo ${${commandC}}
							;echo Variable value: "${RI_String_RIMUI_BTNR${jcCount}C${icCount}Com}"
						}
						elseif ${SettingIterator.Key.Equal[Txt]}
						{
							commandT:Set["RI_String_RIMUI_BTNR${jcCount}C${icCount}Txt:Set[\"${SettingIterator.Value.String.Escape}\"]"]
							;this ${${}} parses it as a data sequence 
							noop ${${commandT}}
							;echo Variable value: "${RI_String_RIMUI_BTNR${jcCount}C${icCount}Txt}"
						}
						
						;echo "${SettingIterator.Key}=${SettingIterator.Value}"
						;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
					}
					while ${SettingIterator:Next(exists)}
				}
			}
	
		}
	}
	for(icCount:Set[3];${icCount}<=7;icCount:Inc)
	{
		for(jcCount:Set[1];${jcCount}<=10;jcCount:Inc)
		{
			for(kcCount:Set[1];${kcCount}<=10;kcCount:Inc)
			{
				if ${Set.FindSet["BTNR${jcCount}C${icCount}F${kcCount}"](exists)}
				{
					Set4:Set[${Set.FindSet["BTNR${jcCount}C${icCount}F${kcCount}"].GUID}]
					variable iterator SettingIterator2
					Set4:GetSettingIterator[SettingIterator2]
					if ${SettingIterator2:First(exists)}
					{
						do
						{
							if ${SettingIterator2.Key.Equal[Com]}
							{
								if ${SettingIterator2.Value.String.Left[9].Equal["relay all"]}
								{
									SettingIterator2.Value:Set["${SettingIterator2.Value.String.Escape.Right[-10]}"]
									export:Set[1]
								}
								commandC:Set["RI_String_RIMUI_BTNR${jcCount}C${icCount}F${kcCount}Com:Set[\"\${SettingIterator2.Value.String.Escape}\"]"]
								;this ${${}} parses it as a data sequence 
								noop ${${commandC}}
								;echo ${${commandC}}
								;echo Variable value: "${RI_String_RIMUI_BTNR${jcCount}C${icCount}F${kcCount}Com}"
							}
							elseif ${SettingIterator2.Key.Equal[Txt]}
							{
								commandT:Set["RI_String_RIMUI_BTNR${jcCount}C${icCount}F${kcCount}Txt:Set[\"${SettingIterator2.Value.String.Escape}\"]"]
								;this ${${}} parses it as a data sequence 
								noop ${${commandT}}
								;echo Variable value: "${RI_String_RIMUI_BTNR${jcCount}C${icCount}F${kcCount}Txt}"
							}
							
							;echo "${SettingIterator2.Key}=${SettingIterator2.Value}"
							;/* iterator.Key is the name of the setting, and iterator.Value is the setting object, which reduces to the value of the setting */
						}
						while ${SettingIterator2:Next(exists)}
					}
				}
			}
		}
	}
	if ${export}
		LavishSettings[RIMUI]:Export["${LavishScript.HomeDirectory}/scripts/RI/RIMUICustom.xml"]
}
atom RI_Atom_RIFollowPop()
{
	CommandQ:Set[TRUE]
	RIFP:Set[TRUE]
}
atom RI_Atom_RILockSpotPop()
{
	CommandQ:Set[TRUE]
	RILSP:Set[TRUE]
}
atom RI_Atom_AssistPop()
{
	CommandQ:Set[TRUE]
	ASSP:Set[TRUE]
}
atom RI_Atom_DoorPop()
{
	CommandQ:Set[TRUE]
	DOORP:Set[TRUE]
}
atom RI_Atom_TravelMapPop()
{
	CommandQ:Set[TRUE]
	TMP:Set[TRUE]
}
atom RI_Atom_FastTravelPop()
{
	CommandQ:Set[TRUE]
	FaTrP:Set[TRUE]
}
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIConsole.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RILoot.xml"
	squelch Hud -remove NN1P1
	squelch Hud -remove NN1P2
	squelch Hud -remove NP1P1
	squelch Hud -remove NP1P2
	squelch hud -remove LD1P1
	squelch hud -remove LD1P2
	squelch hud -remove LD2P1
	squelch hud -remove LD2P2
	squelch hud -remove LD3P1
	squelch hud -remove LD3P2
	squelch hud -remove LD4P1
	squelch hud -remove LD4P2
	squelch hud -remove LD5P1
	squelch hud -remove LD5P2
	squelch hud -remove LD6P1
	squelch hud -remove LD6P2
	squelch hud -remove LD7P1
	squelch hud -remove LD7P2
	squelch hud -remove LD8P1
	squelch hud -remove LD8P2
	squelch hud -remove LD9P1
	squelch hud -remove LD9P2
	squelch hud -remove LD10P1
	squelch hud -remove LD10P2
	squelch hud -remove LD11P1
	squelch hud -remove LD11P2
	squelch hud -remove LD12P1
	squelch hud -remove LD12P2
	squelch hud -remove LD13P1
	squelch hud -remove LD13P2
	squelch hud -remove LD14P1
	squelch hud -remove LD14P2
	squelch hud -remove LD15P1
	squelch hud -remove LD15P2
	squelch hud -remove LD16P1
	squelch hud -remove LD16P2
	squelch hud -remove LD17P1
	squelch hud -remove LD17P2
	squelch hud -remove LD18P1
	squelch hud -remove LD18P2
	squelch hud -remove LD19P1
	squelch hud -remove LD19P2
	squelch hud -remove LD20P1
	squelch hud -remove LD20P2
	squelch hud -remove LD21P1
	squelch hud -remove LD21P2
	squelch hud -remove LD22P1
	squelch hud -remove LD22P2
	squelch hud -remove LD23P1
	squelch hud -remove LD23P2
	squelch hud -remove LD24P1
	squelch hud -remove LD24P2
}
atom(global) ri(... args)
{
	if ${PaidMem.Equal[TRUE]}
	{
		if ${args.Size}==0 
			RI_RunInstances
		else
		{
			switch ${args[1]}
			{
				case CONSOLE
				{
					RIConsole
				}
				case LOOT
				{
					RILoot
				}
				case BULWARK
				{
					if ${args.Size}==2
					{
						if ${args[2].Equal[ON]} || ${Int[${args[2]}]}==1
							RI_Var_Bool_Bulwark:Set[1];echo ISXRI: Turning ON Bulwark
						elseif ${args[2].Equal[OFF]} || ${Int[${args[2]}]}==0
							RI_Var_Bool_Bulwark:Set[0];echo ISXRI: Turning OFF Bulwark
					}
					else
					{
						if ${RI_Var_Bool_Bulwark}
							RI_Var_Bool_Bulwark:Set[0];echo ISXRI: Turning OFF Bulwark
						else
							RI_Var_Bool_Bulwark:Set[1];echo ISXRI: Turning ON Bulwark
					}
					break
				}
				case SKIPLOOT
				case SL
				{
					if ${args.Size}==2
					{
						if ${args[2].Equal[ON]} || ${Int[${args[2]}]}==1
							RI_Var_Bool_SkipLoot:Set[1];echo ISXRI: Turning ON SkipLoot
						elseif ${args[2].Equal[OFF]} || ${Int[${args[2]}]}==0
							RI_Var_Bool_SkipLoot:Set[0];echo ISXRI: Turning OFF SkipLoot
					}
					else
					{
						if ${RI_Var_Bool_SkipLoot}
							RI_Var_Bool_SkipLoot:Set[0];echo ISXRI: Turning OFF SkipLoot
						else
							RI_Var_Bool_SkipLoot:Set[1];echo ISXRI: Turning ON SkipLoot
					}
					break
				}
				case WAITFORLASTNAMEDCHEST
				case WFLNC
				{
					if ${args.Size}==2
					{
						if ${args[2].Equal[ON]} || ${Int[${args[2]}]}==1
							RI_Var_Bool_WaitForLastNamedChest:Set[1];echo ISXRI: Turning ON WaitForLastNamedChest
						elseif ${args[2].Equal[OFF]} || ${Int[${args[2]}]}==0
							RI_Var_Bool_WaitForLastNamedChest:Set[0];echo ISXRI: Turning OFF WaitForLastNamedChest;relay all RI_Var_Bool_SkipLoot:Set[0]
					}
					else
					{
						if ${RI_Var_Bool_WaitForLastNamedChest}
							RI_Var_Bool_WaitForLastNamedChest:Set[0];echo ISXRI: Turning OFF WaitForLastNamedChest;relay all RI_Var_Bool_SkipLoot:Set[0]
						else
							RI_Var_Bool_WaitForLastNamedChest:Set[1];echo ISXRI: Turning ON WaitForLastNamedChest
					}
					break
				}
				case TORDENSHORT
				case TS
				{
					if ${args.Size}==2
					{
						if ${args[2].Equal[ON]} || ${Int[${args[2]}]}==1
							RI_Var_Bool_TordenShort:Set[1];echo ISXRI: Turning ON TordenShort
						elseif ${args[2].Equal[OFF]} || ${Int[${args[2]}]}==0
							RI_Var_Bool_TordenShort:Set[0];echo ISXRI: Turning OFF TordenShort
					}
					else
					{
						if ${RI_Var_Bool_TordenShort}
							RI_Var_Bool_TordenShort:Set[0];echo ISXRI: Turning OFF TordenShort
						else
							RI_Var_Bool_TordenShort:Set[1];echo ISXRI: Turning ON TordenShort
					}
					break
				}
				case GRABSHINYS
				case GS
				{
					if ${args.Size}==2
					{
						if ${args[2].Equal[ON]} || ${Int[${args[2]}]}==1
							RI_Var_Bool_GrabShinys:Set[1];echo ISXRI: Turning ON GrabShinys
						elseif ${args[2].Equal[OFF]} || ${Int[${args[2]}]}==0
							RI_Var_Bool_GrabShinys:Set[0];echo ISXRI: Turning OFF GrabShinys
					}
					else
					{
						if ${RI_Var_Bool_GrabShinys}
							RI_Var_Bool_GrabShinys:Set[0];echo ISXRI: Turning OFF GrabShinys
						else
							RI_Var_Bool_GrabShinys:Set[1];echo ISXRI: Turning ON GrabShinys
					}
					break
				}
				case GI
				case GC
				{
					break
				}
				case UNLOAD	
				case UNLOADEXTENSION
				{
					ext -unload isxri
					break
				}
				case END
				{
					if ${args.Size}==2
					{
						switch ${args[2]}
						{
							case RIMUI
							{
								RIMUIObj:RIMUIClose
								break
							}
							case RIMOVEMENT
							{
								if ${Script[Buffer:RIMovement](exists)}
									Script[Buffer:RIMovement]:End
								break
							}
							case CB
							{
								RI_Obj_CB:EndBot
								break
							}
							case RUNINSTANCES
							case RI
							{
								RIObj:EndScript
								break
							}
							case RIMOBHUD
							{
								if ${Script[${RI_Var_String_RIMobHudScriptName}](exists)}
									Script[${RI_Var_String_RIMobHudScriptName}]:End
								break
							}
						}
					}
					break
				}
				case Pull
				{
					if ${args.Size}==2
					{
						;start ri
						RI_RunInstances MAIN-${args[2]}
					}
					else
					{
						echo ISXRI: You must say the name of the Named you want to pull.
					}
					break
				}
				case Quest
				{
					if ${args.Size}==2
					{
						;start ri
						RI_RunInstances "QUEST-${args[2]}"
					}
					else
					{
						echo ISXRI: You must specify a quest name or timeline name, USAGE: RI Quest "Quest or Timeline Name", Example RI Quest \"Sokokar Timeline Crafting\" 
					}
					break
				}
				case Zadune
				{
					if !${Script[Buffer:Zadune](exists)}
						RI_Zadune
					break
				}
				
				case Looter
				{
					if !${Script[Buffer:RILooter](exists)}
						RI_Looter
					break
				}
				case Farozth
				{
					if !${Script[Buffer:Farozth](exists)}
						RI_Farozth
					break
				}
				case Evac
				{
					if !${Script[Buffer:Evac](exists)}
						RI_Evac
					break
				}
				case RIMovement
				case RIM
				{
					if !${Script[Buffer:RIMovement](exists)}
						RIMovement
					break
				}
				case FDR
				case FoodDrinkReplenish
				{
					if !${Script[Buffer:FDR](exists)}
						RI_FDR
					break
				}
				case POTR
				case PotionReplenish
				{
					if !${Script[Buffer:POTR](exists)}
						RI_POTR
					break
				}
				case RIMovementUI
				case RIMUI
				{
					RIMUIObj:RIMUILoad
					break
				}
				case Ferun
				{
					if !${Script[Buffer:Ferun](exists)}
						RI_Ferun
					break
				}
				case Grethah
				{
					if !${Script[Buffer:Grethah](exists)}
						RI_Grethah
					break
				}
				case Grevog
				{
					if !${Script[Buffer:Grevog](exists)}
						RI_Grevog
					break
				}
				case Icon
				{
					if !${Script[Buffer:Icon](exists)}
						RI_Icon
					break
				}
				case RRG
				case RaidRelayGroup
				{
					if !${Script[Buffer:RaidRelayGroup](exists)}
						 RRG
					break
				}
				case RG
				case RelayGroup
				{
					if !${Script[Buffer:RelayGroup](exists)}
						RG
					break
				}
				case Jessip
				{
					if !${Script[Buffer:Jessip](exists)}
						RI_Jessip
					break
				}
				case Kerridicus
				{
					if !${Script[Buffer:Kerridicus](exists)}
						RI_Kerridicus
					break
				}
				case RZ
				case RunZones
				{
					if !${Script[Buffer:RZ](exists)}
						RZ
					break
				}
				case AggroControl
				{
					if !${Script[Buffer:AggroControl](exists)}
						RI_AggroControl
					break
				}
				case Protector
				{
					if !${Script[Buffer:Protector](exists)}
						RI_Protector
					break
				}
				case AntiAFK
				{
					if !${Script[Buffer:AntiAFK](exists)}
						RI_AntiAFK
					break
				}
				case Sacrificer
				{
					if !${Script[Buffer:Sacrificer](exists)}
						RI_Sacrificer
					break
				}
				case Captain
				{
					if !${Script[Buffer:Captain](exists)}
						RI_Captain
					break
				}
				case Teraradus
				{
					if !${Script[Buffer:Teraradus](exists)}
						RI_Teraradus
					break
				}
				case Charanda
				{
					if !${Script[Buffer:Charanda](exists)}
						RI_Charanda
					break
				}
				case Torso
				{
					if !${Script[Buffer:Torso](exists)}
						RI_Torso
					break
				}
				case Ritual
				{
					if !${Script[Buffer:Ritual](exists)}
						RI_Ritual
					break
				}
				case Tserrina
				{
					if !${Script[Buffer:Tserrina](exists)}
						RI_Tserrina
					break
				}
				case Repair
				{
					if !${Script[Buffer:Repair](exists)}
						RI_Repair
					break
				}
				case Flag
				{
					if !${Script[Buffer:Flag](exists)}
						RI_Flag
					break
				}
				case ZR
				case ZoneReset
				{
					if !${Script[Buffer:ZoneReset](exists)}
						RI_ZoneReset
					break
				}
				case Login
				{
					if !${Script[Buffer:RILogin](exists)}
						RILogin ${args[2]}
					break
				}
				case RIMobHud
				{
					if !${Script[Buffer:RIMobHud](exists)}
						RIMobHud
					break
				}
				case CAM
				case CancelAllMaintained
				{
					RI_CMD_CancelAllMaintained
					break
				}
				case AT
				case AutoTarget
				{
					if !${Script[Buffer:RIAutoTarget](exists)}
						RI_AutoTarget
					else
						UIElement[RIAutoTarget]:Show
					break
				}
				case WL
				case WriteLocs
				{
					if !${Script[Buffer:RIWriteLocs](exists)}
						RI_WriteLocs
					break
				}
				case Harvest
				{
					if !${Script[Buffer:RIHarvest](exists)}
						RI_Harvest
					break
				}
				case DM
				case DeleteMissions
				{
					if !${Script[Buffer:DeleteMissions](exists)}
						RI_DeleteMissions
					break
				}
				case SM
				case ShareMissions
				{
					if !${Script[Buffer:ShareMissions](exists)}
						RI_ShareMissions
					break
				}
				case Balance
				{
					if !${Script[Buffer:RIBalance](exists)}
						RI_Balance
					break
				}
				case Collections
				{
					if !${Script[Buffer:Collections](exists)}
						RI_Collections
					break
				}
				case HideEffects
				{
					if !${Script[Buffer:HideEffects](exists)}
						RI_HideEffects
					break
				}
				case Transmute
				{
					if !${Script[Buffer:RITransmute](exists)}
						RI_Transmute
					break
				}
				case Salvage
				{
					if !${Script[Buffer:RISalvage](exists)}
						RI_Salvage
					break
				}
				case CB
				case CombatBot
				{
					if !${Script[Buffer:CombatBot](exists)}
						RI_CombatBot
					else
						UIElement[CombatBotMiniUI]:Show
					break
				}
				case AbilityCheck
				{
					if !${Script[Buffer:AbilityCheck](exists)}
						RI_AbilityCheck
					break
				}
				; case AD
				; case AutoDeity
				; {
					; if !${Script[Buffer:RIAutoDeity](exists)}
					; {
						; if ${args.Size}==2
							; RI_AutoDeity ${args[2]}
						; elseif ${args.Size}==3
							; RI_AutoDeity ${args[2]} ${args[3]}
						; else
							; RI_AutoDeity
					; }
					; break
				; }
				case E2
				case Epic2
				case Epic2PreReqs
				{
					RIMUIObj:CheckEpic2PreReqs[ALL]
					break
				}
				case AC
				case AvailableCommands
				{
					echo ISXRI: Available RI and !RI commands:
					echo RICONSOLE
					echo RILOOT
					echo UNLOAD	
					echo UNLOADEXTENSION
					echo END (RIMUI,RIMOVEMENT,CB,RI,RIMOBHUD)
					echo Zadune
					echo Looter
					echo Farozth
					echo Evac
					echo RIMovement
					echo RIM
					echo FDR
					echo FoodDrinkReplenish
					echo RIMovementUI
					echo RIMUI
					echo Ferun
					echo Grethah
					echo Grevog
					echo Icon
					echo RRG
					echo RaidRelayGroup
					echo RG
					echo RelayGroup
					echo Jessip
					echo Kerridicus
					echo RZ
					echo RunZones
					echo AggroControl
					echo Protector
					echo AntiAFK
					echo Sacrificer
					echo Captain
					echo Teraradus
					echo Charanda
					echo Torso
					echo Ritual
					echo Repair
					echo Flag
					echo ZR
					echo ZoneReset
					echo Login
					echo RIMH
					echo RIMob
					echo RIMobHud
					echo CAM
					echo CancelAllMaintained
					echo AutoTarget
					echo CombatBot
					echo CB
					echo CombatBot
					echo AbilityCheck
					;echo AutoDeity
					echo DeleteMissions
					echo ShareMissions
					echo Harvest
					echo Balance
					echo WriteLocs
					echo Harvest
					echo DeleteMissions
					echo ShareMissions
					echo Balance
					echo HideEffects
					echo Collections
					echo Transmute
					echo Salvage
					echo E2
					break
				}
				; case AbilityEnableDisable
				; {
					; RI_CMD_AbilityEnableDisable 
					; break
				; }

				; RI_CMD_AbilityEnableDisable
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

					; RI_CMD_Assisting
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_PauseCombatBots
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_ReloadBots
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_AbilityTypeEnableDisable
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_FoodDrinkConsume
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_Cast
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_CastOn
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_PauseRIMovement
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_PotionConsume
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

	 ; RI_CMD_ChangeFaceNPC 
				; case
				; {
					; if !${Script[Buffer:](exists)}
						; RI_
					; break
				; }

				default
				{
					RILogin ${args[1]}
				}
			}
		}
	}
}
atom(global) !ri(... args)
{
	if ${PaidMem.Equal[TRUE]}
	{
		variable int count=0
		variable string executecomm
		executecomm:Set["ri"]
		for(count:Set[1];${count}<=${args.Size};count:Inc)
		{
			executecomm:Concat[" ${args[${count}]}"]
		}
		execute "${executecomm.Escape}"
	}
}
atom(global) rilogin(... args)
{
	if ${Script[Buffer:RILogin](exists)}
		endscript Buffer:RILogin
	if ${args.Size}==0
		Return
	elseif ${args.Size}==1
		RILC ${args[1]}
	elseif ${args.Size}>1
		RILC ${args[1]} ${args[2]}
}
atom(global) cb(... args)
{
	if ${args.Size}==0
		RI_CB
	else
	{
		if ${args[1].Upper.Equal[ENDBOT]} || ${args[1].Upper.Equal[END]}
		{
			if ${Script[Buffer:CombatBot](exists)}
				RI_Obj_CB:EndBot
		}
		elseif ${args[1].Upper.Equal[ABILITYCHECK]}
		{
			if !${Script[Buffer:AbilityCheck](exists)}
				RI_AbilityCheck
		}
		elseif ${args[1].Upper.Equal[IMPORTOGRE]} || ${args[1].Upper.Equal[OGREIMPORT]}
		{
			if !${Script[Buffer:CombatBot](exists)}
				RI_CombatBot
			TimedCommand 5 RI_Obj_CB:ImportOgre
		}
		elseif ${args[1].Upper.Equal[IMPORTTHG]}
		{
			if !${Script[Buffer:CombatBot](exists)}
				RI_CombatBot
			TimedCommand 5 RI_Obj_CB:ImportTHG
		}
		elseif ${args[1].Upper.Equal[AC]} || ${args[1].Upper.Equal[AVAILABLECOMMANDS]}
		{
			echo END
			echo ENDBOT
			echo ABILITYCHECK
			echo IMPORTOGRE
			echo IMPORTTHG
		}
		else
		;if !${Script[Buffer:RILogin](exists)}
		{
			if ${Script[Buffer:RILogin](exists)}
				endscript Buffer:RILogin
			if ${Script[Buffer:CombatBot](exists)}
				RI_Obj_CB:EndBot
			RILogin ${args[1]} TRUE
		}
	}
}
atom(global) combatbot(... args)
{
	if ${args.Size}==0
		RI_CB
	else
	{
		if ${args[1].Upper.Equal[ENDBOT]} || ${args[1].Upper.Equal[END]}
		{
			if ${Script[Buffer:CombatBot](exists)}
				RI_Obj_CB:EndBot
		}
		elseif ${args[1].Upper.Equal[ABILITYCHECK]}
		{
			if !${Script[Buffer:AbilityCheck](exists)}
				RI_AbilityCheck
		}
		elseif ${args[1].Upper.Equal[IMPORTOGRE]}
		{
			if !${Script[Buffer:CombatBot](exists)}
				RI_CombatBot
			TimedCommand 5 RI_Obj_CB:ImportOgre
		}
		elseif ${args[1].Upper.Equal[IMPORTTHG]}
		{
			if !${Script[Buffer:CombatBot](exists)}
				RI_CombatBot
			TimedCommand 5 RI_Obj_CB:ImportTHG
		}
		elseif ${args[1].Upper.Equal[AC]} || ${args[1].Upper.Equal[AVAILABLECOMMANDS]}
		{
			echo END
			echo ENDBOT
			echo ABILITYCHECK
			echo IMPORTOGRE
			echo IMPORTTHG
		}
		else
		;if !${Script[Buffer:RILogin](exists)}
		{
			if ${Script[Buffer:RILogin](exists)}
				endscript Buffer:RILogin
			if ${Script[Buffer:CombatBot](exists)}
				RI_Obj_CB:EndBot
			RILogin ${args[1]} TRUE
		}
	}
}
atom(global) riconsole(string _what)
{
	if ${_what.Upper.EqualCS[HIDE]}
		RIConsole:Hide
	else
		RIConsole:Show
}
atom(global) riloot(string _what)
{
	if ${_what.Upper.EqualCS[HIDE]}
		RILootObj:Hide
	else
		RILootObj:Show
}			