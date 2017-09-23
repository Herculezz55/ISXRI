function main(string _TrainerOverwriter=NONE)
{
	; 723.207458 249.531342 1315.920898
	; 723.207458 276.172272 1315.920898
	; 627.347534 275.756134 1296.443359
	; 660.474426 275.756134 1217.970215
	; 660.474426 266.345551 1217.970215
	; 705.801025 266.345551 1147.749146
	; 736.516052 264.519012 1010.482727
	; 737.225525 249.478668 1006.810791
	; 714.246948 249.478668 926.069092
	; 696.598389 249.478668 861.858032
	; 679.308655 249.543732 799.341797
	; 647.821655 288.258209 770.006592
	; 611.370178 338.075348 736.046509
	; 554.139221 358.411713 679.010742
	; 532.799988 368.106659 652.348572
	; 506.487213 378.533844 613.441284
	; 474.683685 385.477966 566.395203
	; 437.246979 385.477966 510.989502
	; 408.031250 385.477966 467.751740
	; 378.095001 385.477966 423.447388
	; 351.401276 385.477966 383.942017
	; 320.144043 385.477966 337.683105
	; 271.901794 385.477966 285.415161
	; 220.002502 385.477966 236.995346
	; 134.183197 356.733826 161.023987
	; 61.875549 324.218597 94.663033
	; 17.193449 304.304016 53.601723
	; -36.389305 280.398651 4.986562
	; -100.036148 236.592514 -53.842533
	; -155.601700 193.073990 -105.476471
	; -157.053619 159.377838 -168.929901
	; -157.145203 146.075027 -192.129227
	
	
	;disable debugging
	Script:DisableDebugging
	
	
	
	if ${Me.Inventory[Guided Ascension].Quantity}==50
	{
		MessageBox -skin eq2 "Your Guided Ascension scrolls are maxed out at 50"
		Script:End
	}
	
	RI_Var_Bool_Start:Set[TRUE]
	if ( ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Thaumaturgist"](exists)} && ${_TrainerOverwriter.Equal[NONE]} ) || ${_TrainerOverwriter.Find[Tha](exists)}
	{
		echo ISXRI: Starting Ascension - Thaumaturgist
		if ${QuestJournalWindow.CompletedQuest["Kunark Ascending: A Nightmare Realized"](exists)}
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},669.340027,253.436829,1418.979980]}>25
			{
				if ${Math.Distance[${Me.Loc},606.603455,248.838074,1263.760010]}>25
				{
					call RIMObj.CallToGuildHall
					call RIMObj.TravelMap "Obulus Frontier" 0 2
				}
				call RIMObj.Move 610.880493 248.615494 1271.212646 1 0 1 1 1 1 1 1
				call RIMObj.Move 653.489502 269.430923 1317.475464 1 0 1 1 1 1 1 1
				call RIMObj.Move 684.128662 274.746368 1350.181152 1 0 1 1 1 1 1 1
				call RIMObj.Move 675.452332 274.155167 1382.561279 1 0 1 1 1 1 1 1
				call RIMObj.Move 662.837708 275.751022 1400.255737 1 0 1 1 1 1 1 1
				call RIMObj.Move 665.952026 275.436829 1407.700195 1 0 1 1 1 0 1 1
				call RIMObj.FlyDown
				call RIMObj.Move 669.340027 253.436829 1418.979980 3 0 1 1 1 1 1 1
				call RIMObj.Move ${Math.Calc[669.340027+${Math.Calc[${Math.Rand[11]}-5]}]} 253.436829 ${Math.Calc[1418.979980+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
		}
		else
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},669.340027,253.436829,1418.979980]}>25
			{
				if ${Math.Distance[${Me.Loc},726.150330,249.717072,1327.047241]}>25
				{
					call RIMObj.CallToGuildHall
					Actor["Cae'Dal Star"]:DoubleClick
					wait 10
					RIMUIObj:Door[${Me.Name},0]
					wait 600 ${EQ2.Zoning}==1
					wait 600 ${EQ2.Zoning}==0
					wait 10
				}
				call RIMObj.Move 726.150330 249.717072 1327.047241 1 0 1 1 1 1 1 1
				call RIMObj.Move 713.649109 249.514236 1308.779297 1 0 1 1 1 1 1 1
				call RIMObj.Move 706.371887 274.483276 1308.911987 1 0 1 1 1 1 1 1
				call RIMObj.Move 667.682556 274.483276 1313.588867 1 0 1 1 1 1 1 1
				call RIMObj.Move 667.682556 280.267944 1313.588867 1 0 1 1 1 1 1 1
				call RIMObj.Move 667.444275 280.267944 1389.494263 1 0 1 1 1 1 1 1
				call RIMObj.Move 660.214478 280.267944 1401.159058 1 0 1 1 1 0 1 1
				call RIMObj.FlyDown
				call RIMObj.Move 671.597473 253.436829 1419.633911 1 0 1 1 1 1 1 1
				call RIMObj.Move 669.340027 253.436829 1418.979980 3 0 1 1 1 1 1 1
				call RIMObj.Move ${Math.Calc[669.340027+${Math.Calc[${Math.Rand[11]}-5]}]} 253.436829 ${Math.Calc[1418.979980+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
		}
		if ${Math.Distance[${Me.Loc},669.340027,253.436829,1418.979980]}>10
			call RIMObj.Move ${Math.Calc[669.340027+${Math.Calc[${Math.Rand[11]}-5]}]} 253.436829 ${Math.Calc[1418.979980+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
		wait 20
		RI_CMD_PauseCombatBots 1
		wait 10
		Actor[Chosooth]:DoTarget
		wait 5
		Actor[Chosooth]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		Actor[Chosooth]:DoTarget
		wait 5
		Actor[Chosooth]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	}
	if ( ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Etherealist"](exists)}  && ${_TrainerOverwriter.Equal[NONE]} ) || ${_TrainerOverwriter.Find[Eth](exists)}
	{
		echo ISXRI: Starting Ascension - Etherealist
		if ${QuestJournalWindow.CompletedQuest["Kunark Ascending: A Nightmare Realized"](exists)}
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},-380.649994,18.743742,-558.380005]}>25
			{
				if ${Math.Distance[${Me.Loc},-209.187790,90.546265,-172.006088]}>25
				{
					call RIMObj.CallToGuildHall
					Actor["Cae'Dal Star"]:DoubleClick
					wait 10
					RIMUIObj:Door[${Me.Name},0]
					wait 600 ${EQ2.Zoning}==1
					wait 600 ${EQ2.Zoning}==0
					wait 10
				}
				call RIMObj.Move -214.968552 90.548225 -173.623108 1 0 1 1 1 1 1 1
				call RIMObj.Move -240.947098 122.346169 -202.567551 1 0 1 1 1 1 1 1
				call RIMObj.Move -258.668457 123.866096 -249.658005 1 0 1 1 1 1 1 1
				call RIMObj.Move -275.864960 112.471184 -295.283203 1 0 1 1 1 1 1 1
				call RIMObj.Move -292.971344 98.963272 -340.553558 1 0 1 1 1 1 1 1
				call RIMObj.Move -310.070709 85.460747 -385.805725 1 0 1 1 1 1 1 1
				call RIMObj.Move -327.143188 71.979561 -430.986389 1 0 1 1 1 1 1 1
				call RIMObj.Move -344.168365 58.535786 -476.041901 1 0 1 1 1 1 1 1
				call RIMObj.Move -361.882965 41.126999 -519.667114 1 0 1 1 1 1 1 1
				call RIMObj.Move -377.864014 20.027666 -552.149475 1 0 1 1 1 0 1 1
				call RIMObj.FlyDown
				call RIMObj.Move ${Math.Calc[-380.649994+${Math.Calc[${Math.Rand[11]}-5]}]} 18.743742 ${Math.Calc[-558.380005+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
		}
		else
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},-380.649994,18.743742,-558.380005]}>25
			{
				if ${Math.Distance[${Me.Loc},726.150330,249.717072,1327.047241]}>25
				{
					call RIMObj.CallToGuildHall
					Actor["Cae'Dal Star"]:DoubleClick
					wait 10
					RIMUIObj:Door[${Me.Name},0]
					wait 600 ${EQ2.Zoning}==1
					wait 600 ${EQ2.Zoning}==0
					wait 10
				}
				call RIMObj.Move 723.207458 249.531342 1315.920898 1 0 1 1 1 1 1 1
				call RIMObj.Move 723.207458 276.172272 1315.920898 1 0 1 1 1 1 1 1
				call RIMObj.Move 627.347534 275.756134 1296.443359 1 0 1 1 1 1 1 1
				call RIMObj.Move 660.474426 275.756134 1217.970215 1 0 1 1 1 1 1 1
				call RIMObj.Move 660.474426 260.345551 1217.970215 1 0 1 1 1 1 1 1
				call RIMObj.Move 705.801025 255.345551 1147.749146 1 0 1 1 1 1 1 1
				call RIMObj.Move 736.516052 255.519012 1010.482727 1 0 1 1 1 1 1 1
				call RIMObj.Move 737.225525 249.478668 1006.810791 1 0 1 1 1 1 1 1
				call RIMObj.Move 714.246948 249.478668 926.069092 1 0 1 1 1 1 1 1
				call RIMObj.Move 696.598389 249.478668 861.858032 1 0 1 1 1 1 1 1
				call RIMObj.Move 679.308655 249.543732 799.341797 1 0 1 1 1 1 1 1
				call RIMObj.Move 647.821655 288.258209 770.006592 1 0 1 1 1 1 1 1
				call RIMObj.Move 611.370178 338.075348 736.046509 1 0 1 1 1 1 1 1
				call RIMObj.Move 554.139221 358.411713 679.010742 1 0 1 1 1 1 1 1
				call RIMObj.Move 532.799988 368.106659 652.348572 1 0 1 1 1 1 1 1
				call RIMObj.Move 506.487213 378.533844 613.441284 1 0 1 1 1 1 1 1
				call RIMObj.Move 474.683685 385.477966 566.395203 1 0 1 1 1 1 1 1
				call RIMObj.Move 437.246979 385.477966 510.989502 1 0 1 1 1 1 1 1
				call RIMObj.Move 408.031250 385.477966 467.751740 1 0 1 1 1 1 1 1
				call RIMObj.Move 378.095001 385.477966 423.447388 1 0 1 1 1 1 1 1
				call RIMObj.Move 351.401276 385.477966 383.942017 1 0 1 1 1 1 1 1
				call RIMObj.Move 320.144043 385.477966 337.683105 1 0 1 1 1 1 1 1
				call RIMObj.Move 271.901794 385.477966 285.415161 1 0 1 1 1 1 1 1
				call RIMObj.Move 220.002502 385.477966 236.995346 1 0 1 1 1 1 1 1
				call RIMObj.Move 134.183197 356.733826 161.023987 1 0 1 1 1 1 1 1
				call RIMObj.Move 61.875549 324.218597 94.663033 1 0 1 1 1 1 1 1
				call RIMObj.Move 17.193449 304.304016 53.601723 1 0 1 1 1 1 1 1
				call RIMObj.Move -36.389305 280.398651 4.986562 1 0 1 1 1 1 1 1
				call RIMObj.Move -100.036148 236.592514 -53.842533 1 0 1 1 1 1 1 1
				call RIMObj.Move -155.601700 193.073990 -105.476471 1 0 1 1 1 1 1 1
				call RIMObj.Move -157.053619 159.377838 -168.929901 1 0 1 1 1 1 1 1
				call RIMObj.Move -157.145203 146.075027 -192.129227 1 0 1 1 1 1 1 1
				call RIMObj.Move -175.103699 150.770004 -254.324402 1 0 1 1 1 1 1 1
				call RIMObj.Move -218.452316 152.164841 -304.159668 1 0 1 1 1 1 1 1
				call RIMObj.Move -259.542999 152.164841 -371.258575 1 0 1 1 1 1 1 1
				call RIMObj.Move -300.156006 152.164841 -437.579102 1 0 1 1 1 1 1 1
				call RIMObj.Move -334.922272 137.379227 -488.767639 1 0 1 1 1 1 1 1
				call RIMObj.Move -371.790649 137.379227 -539.551758 1 0 1 1 1 1 1 1
				call RIMObj.Move -378.434662 137.379227 -555.190979 1 0 1 1 1 0 1 1
				call RIMObj.FlyDown
				call RIMObj.Move ${Math.Calc[-229.055847+${Math.Calc[${Math.Rand[11]}-5]}]} 91.389877 ${Math.Calc[-232.600342+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
		}
		if ${Math.Distance[${Me.Loc},-380.649994,18.743742,-558.380005]}>10
			call RIMObj.Move ${Math.Calc[-380.649994+${Math.Calc[${Math.Rand[11]}-5]}]} 18.743742 ${Math.Calc[-558.380005+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
		wait 20
		RI_CMD_PauseCombatBots 1
		wait 5
		Actor[Miragul]:DoTarget
		wait 5
		Actor[Miragul]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		Actor[Miragul]:DoTarget
		wait 5
		Actor[Miragul]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	}
	if ( ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Geomancer"](exists)} && ${_TrainerOverwriter.Equal[NONE]} ) || ${_TrainerOverwriter.Find[Geo](exists)}
	{
		echo ISXRI: Starting Ascension - Geomancer
		if ${QuestJournalWindow.CompletedQuest["Kunark Ascending: A Nightmare Realized"](exists)}
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},-227.330002,91.369026,-233.990005]}>25
			{
				if ${Math.Distance[${Me.Loc},-209.187790,90.546265,-172.006088]}>25
				{
					call RIMObj.CallToGuildHall
					Actor["Cae'Dal Star"]:DoubleClick
					wait 10
					RIMUIObj:Door[${Me.Name},0]
					wait 600 ${EQ2.Zoning}==1
					wait 600 ${EQ2.Zoning}==0
					wait 10
				}
				call RIMObj.Move -209.187790 90.546265 -172.006088 1 0 1 1 1 1 1 1
				call RIMObj.Move -216.081696 90.550606 -179.592010 1 0 1 1 1 1 1 1
				call RIMObj.Move -222.656921 90.558823 -187.174484 1 0 1 1 1 1 1 1
				call RIMObj.Move -229.002930 90.585625 -195.222092 1 0 1 1 1 1 1 1
				call RIMObj.Move -235.205399 90.673553 -203.236618 1 0 1 1 1 1 1 1
				call RIMObj.Move -241.387787 90.682251 -211.225098 1 0 1 1 1 1 1 1
				call RIMObj.Move -247.419373 90.682251 -219.018768 1 0 1 1 1 1 1 1
				call RIMObj.Move -239.058990 91.041344 -224.664444 1 0 1 1 1 1 1 1
				call RIMObj.Move -231.164246 91.416313 -230.973251 1 0 1 1 1 1 1 1
				call RIMObj.Move ${Math.Calc[-228.063629+${Math.Calc[${Math.Rand[3]}-1]}]} 91.389877 ${Math.Calc[-233.546982+${Math.Calc[${Math.Rand[3]}-1]}]} 1 0 1 1 1 0 1 1
			}
		}
		else
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},-227.330002,91.369026,-233.990005]}>25
			{
				if ${Math.Distance[${Me.Loc},726.150330,249.717072,1327.047241]}>25
				{
					call RIMObj.CallToGuildHall
					Actor["Cae'Dal Star"]:DoubleClick
					wait 10
					RIMUIObj:Door[${Me.Name},0]
					wait 600 ${EQ2.Zoning}==1
					wait 600 ${EQ2.Zoning}==0
					wait 10
				}
				call RIMObj.Move 723.207458 249.531342 1315.920898
				call RIMObj.Move 723.207458 276.172272 1315.920898
				call RIMObj.Move 627.347534 275.756134 1296.443359
				call RIMObj.Move 660.474426 275.756134 1217.970215
				call RIMObj.Move 660.474426 260.345551 1217.970215
				call RIMObj.Move 705.801025 255.345551 1147.749146
				call RIMObj.Move 736.516052 255.519012 1010.482727
				call RIMObj.Move 737.225525 249.478668 1006.810791
				call RIMObj.Move 714.246948 249.478668 926.069092
				call RIMObj.Move 696.598389 249.478668 861.858032
				call RIMObj.Move 679.308655 249.543732 799.341797
				call RIMObj.Move 647.821655 288.258209 770.006592
				call RIMObj.Move 611.370178 338.075348 736.046509
				call RIMObj.Move 554.139221 358.411713 679.010742
				call RIMObj.Move 532.799988 368.106659 652.348572
				call RIMObj.Move 506.487213 378.533844 613.441284
				call RIMObj.Move 474.683685 385.477966 566.395203
				call RIMObj.Move 437.246979 385.477966 510.989502
				call RIMObj.Move 408.031250 385.477966 467.751740
				call RIMObj.Move 378.095001 385.477966 423.447388
				call RIMObj.Move 351.401276 385.477966 383.942017
				call RIMObj.Move 320.144043 385.477966 337.683105
				call RIMObj.Move 271.901794 385.477966 285.415161
				call RIMObj.Move 220.002502 385.477966 236.995346
				call RIMObj.Move 134.183197 356.733826 161.023987
				call RIMObj.Move 61.875549 324.218597 94.663033
				call RIMObj.Move 17.193449 304.304016 53.601723
				call RIMObj.Move -36.389305 280.398651 4.986562
				call RIMObj.Move -100.036148 236.592514 -53.842533
				call RIMObj.Move -155.601700 193.073990 -105.476471
				call RIMObj.Move -157.053619 159.377838 -168.929901
				call RIMObj.Move -157.145203 146.075027 -192.129227
				MessageBox -show "You must move the rest of the way from here"
				Script:End
			}
		}
		if ${Math.Distance[${Me.Loc},-227.330002,91.369026,-233.990005]}>10
			call RIMObj.Move ${Math.Calc[-228.063629+${Math.Calc[${Math.Rand[3]}-1]}]} 91.389877 ${Math.Calc[-233.546982+${Math.Calc[${Math.Rand[3]}-1]}]} 1 0 1 1 1 0 1 1

		press -release ${RI_Var_String_ForwardKey}
		
		wait 20
		RI_CMD_PauseCombatBots 1
		wait 5
		Actor[Aranolh]:DoTarget
		wait 5
		Actor[Aranolh]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		Actor[Aranolh]:DoTarget
		wait 5
		Actor[Aranolh]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	}
	if ( ${Me.GetGameData[Self.AscensionLevelClass].Label.Find["Elementalist"](exists)} && ${_TrainerOverwriter.Equal[NONE]} ) || ${_TrainerOverwriter.Find[Ele](exists)}
	{
		echo ISXRI: Starting Ascension - Elementalist
		if ${QuestJournalWindow.CompletedQuest["Kunark Ascending: A Nightmare Realized"](exists)}
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},785.380005,229.669998,1000.010010]}>25
			{
				if ${Math.Distance[${Me.Loc},621.594543,248.486938,1267.528931]}>25
				{
					call RIMObj.CallToGuildHall
					call RIMObj.TravelMap "Obulus Frontier" 0 2
				}
				call RIMObj.Move 621.594543 248.486938 1267.528931 1 0 1 1 1 1 1 1
				call RIMObj.Move 629.982483 275.773895 1257.558350 1 0 1 1 1 1 1 1
				call RIMObj.Move 658.389709 269.293701 1216.877441 1 0 1 1 1 1 1 1
				call RIMObj.Move 686.846497 263.997864 1175.851929 1 0 1 1 1 1 1 1
				call RIMObj.Move 705.703125 259.899841 1129.691895 1 0 1 1 1 1 1 1
				call RIMObj.Move 720.405029 256.744995 1081.945679 1 0 1 1 1 1 1 1
				call RIMObj.Move 734.003235 256.740082 1033.816406 1 0 1 1 1 1 1 1
				call RIMObj.Move 770.189331 238.928802 1004.038635 1 0 1 1 1 1 1 1
				call RIMObj.Move 773.015015 237.014008 1002.500305 1 0 1 1 1 0 1 1
				call RIMObj.FlyDown
				call RIMObj.Move ${Math.Calc[783.344177+${Math.Calc[${Math.Rand[11]}-5]}]} 229.409286 ${Math.Calc[1000.269531+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
		}
		else
		{
			;call to guild hall if not there, and not within so far of trainer
			if ${Math.Distance[${Me.Loc},785.380005,229.669998,1000.010010]}>25
			{
				if ${Math.Distance[${Me.Loc},726.150330,249.717072,1327.047241]}>25
				{
					call RIMObj.CallToGuildHall
					Actor["Cae'Dal Star"]:DoubleClick
					wait 10
					RIMUIObj:Door[${Me.Name},0]
					wait 600 ${EQ2.Zoning}==1
					wait 600 ${EQ2.Zoning}==0
					wait 10
				}
				call RIMObj.Move 723.207458 249.531342 1315.920898 1 0 1 1 1 1 1 1
				call RIMObj.Move 723.207458 276.172272 1315.920898 1 0 1 1 1 1 1 1
				call RIMObj.Move 627.347534 275.756134 1296.443359 1 0 1 1 1 1 1 1
				call RIMObj.Move 660.474426 275.756134 1217.970215 1 0 1 1 1 1 1 1
				call RIMObj.Move 660.474426 260.345551 1217.970215 1 0 1 1 1 1 1 1
				call RIMObj.Move 705.801025 255.345551 1147.749146 1 0 1 1 1 1 1 1
				call RIMObj.Move 736.516052 255.519012 1010.482727 1 0 1 1 1 1 1 1
				call RIMObj.Move 771.057373 250.712433 994.480713 1 0 1 1 1 0 1 1
				call RIMObj.FlyDown
				call RIMObj.Move ${Math.Calc[783.344177+${Math.Calc[${Math.Rand[11]}-5]}]} 229.409286 ${Math.Calc[1000.269531+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
			}
		}
		if ${Math.Distance[${Me.Loc},785.380005,229.669998,1000.010010]}>10
			call RIMObj.Move ${Math.Calc[783.344177+${Math.Calc[${Math.Rand[11]}-5]}]} 229.409286 ${Math.Calc[1000.269531+${Math.Calc[${Math.Rand[11]}-5]}]} 1 0 1 1 1 0 1 1
		wait 20
		RI_CMD_PauseCombatBots 1
		wait 5
		Actor[Najena]:DoTarget
		wait 5
		Actor[Najena]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		Actor[Aranolh]:DoTarget
		wait 5
		Actor[Aranolh]:DoFace
		wait 5
		eq2ex hail
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
		wait 5
		EQ2UIPage[ProxyActor,Conversation].Child[composite,replies].Child[button,1]:LeftClick
	}
	RI_Var_Bool_Start:Set[FALSE]
	RI_CMD_PauseCombatBots 0
}
function atexit()
{
	echo ISXRI: Ending Ascension
}
