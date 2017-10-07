
;coming soon
;moving MY Boss Code to Extension to make the CustomNamed smaller, so people can make their custom code. - FORGET THAT, They use my code or suck a dick -- DONE
;ld checks, and stuck checks



;
;NEED TO REMOVE ALL SERVER CALLS, WHARFIE DONE.
;
;
;script to completely RunInstances
;Best to set your group loot options to Round Robin for all items and set your personal loot method to greed or accept.
;
;ver 1b Changes: 9-1-14
;changed movement code to use num lock aka auto run key in some instances to allow for a more fluid movement especially when flying
;changed run quests to default as off
;cleaned a few bugs
;
;ver 1c Changes 9-8-14
;fixed a bug with pause that was not pausing script on all clients
;added a check for combat after each wait
;
;ver 1d changes 9-21-14
;fixed a bug where toons where still on ofollow when trying to move to clickactor, hailactor or chest locations
;fixed a bug that was preventing quest sharing (could still cause an issue if you share a quest at the exact moment your reward window appears (very unlikely))
;added wait on group member dead, wait on LD, and wait while not in zone for group members
;polished a few zone files:
;	Nexus: Changed Maligned and Amalgam locations, fixed a few quest and no quest paths, added evac and zone out after kill prime, changed primes first lockspot
;	Hive: Changed to not stop for combat until in hallway of first named, added a few waits on roc ring event and changed movement on flammicum, Added evac and zone out after Queen
;	Stratum: added evac and zone out after Shazzak
;	Chamber: added evac and zone out after Warden
;	Highkeep: changed path to help avoid stuck added evac after Last named and zone out
;   Pickclaw: added evac after port to jail, added evac after Last named and zone out
;
;
; ver 1e changes 10-1-14
;added Fabled Den
;
;ver 1f changes 10-7-14
; Added Movebehind coding to replace ogre triggered
; added death and distance checks for group members. 
; changed alot of movement to use RIMovement and added ogreplaynice to pause when ogre is paused
; Polished:
;	Dom: Added coding for Dagrin, Changed campspots for getiar, fixed campspot for ahrmatal
;
;ver 1g changes 11-25
; added Bilgewater falls, both Zavith'loa and CastleHighkeep zones
;
;ver 2a changes 12-5-14
;added ossuary rom and tweaked bilge and zav zones and highkeep
;
;ver 2b changes 12-7-14
;added as a buffer script to ISXRI dll
;
;ver 2c changes 12-10-14
; added Shiny looting (pre alpha) and a global variable to turn on and off.
; changed back to press -hold forward key for movement in all situations except flying.
;
;ver 2d changes 12-14-14
; changed Shiny looting to skip if named within a 50 radius
;
;ver 2e changes 12-16-14
; added a script:end if the extension is not running
;
;ver 2f changes 12-23-14
; added Brokenskull: Hoist and Bosun, and Ossuary Sanguine and Zav EH
;
;ver 2g changes 1-24-15
; added variable to turn off auto loot and just wait when a chest is in range.
; added isaggro check to adds in named fights to make sure we are not targeting non aggro or hidden mobs
; added Ssraeshza Temple [Heroic]
; added Ssraeshza Temple: Inner Sanctum [Heroic]
; added Ssraeshza Temple: Taskmaster's Echo [Event Heroic]
; added Castle Highhold: Insider Treachery [Event Heroic]
;
;ver 2h changes 1-25-15
; removed npc checks as it was causing issues.
; 
;ver 2I changes 1-25-15
; fixed a lockspot bug
; fixed a bug that would target a ? and not fight while in combat
;
;ver 2J changes 1-27-15
; fixed a small bug that was clearing ALL targets when running function
; checkcombat instead of just ? // added ${Target.Name.Equal[?]}
; added DeTarget.ISS to Update File.
;
;ver 2K changes 2-16-15
;	changed waitmob logic to set and check ID
;	changed Target logic to set and check ID
;
;ver 2L changes 2-19-15
;	added relay ${RI_Var_String_RelayGroup} -noredirect to the loot Shiny function
;	
;ver 2M changes 2-19-15
;	fixed ogre pause during Shiny
;
;ver 2N changes 2-19-15
;	fixed Shiny to relay ${RI_Var_String_RelayGroup} -noredirect AllLootShiny Function in CustomNameAOM
;
;ver 2O changes 2-19-15
;	changed Shiny to run shiny.iss from runinstances folder
;
;ver 2P changes 2-20-15
;	added looting of corpses
;
;ver 2P changes 2-20-15
;	changed waitmob and target radius' to 25
;
;ver 2S changes 2-20-15
;	added combat check prior to looting Shinys
;
;ver 2T changes 2-27-15
;	removed corpse looting from RI main script and added a seperate 
;	Buffer:RILotter script to loot corpses and chests within 10m
;
;ver 2U changes 3-23-15
;	added Ossuary Contested to zone list with file OssCon
;
;ver 2V changes 3-31-15
;	fixed a bug that would not reset our seek position when a file did not 
;	have a blank line at the end.
;
;ver 2w changes 3-31-15
;	put npc check into named function so we dont get false positives 
;	from non npc actors
;
;ver 2x changes 4-1-15
;	changed waitmob logic to 10m and added npc and namednpc checks
;	changed CustomActor to Actor in all Instances
;
;ver 2y changes 4--10-15
;	Added,${RI_Var_Bool_Loot} check to RILooter as well as slowed 
;	loop to .5 secs, also coded to close RILooter on RI exit.
;	disabled ogre looting for now until kannkor gets his head out his ass.
;	removed the usage of Shiny.iss and changed to relay ${RI_Var_String_RelayGroup} -noredirect instead
;	changed Auto Loot in xml to relay ${RI_Var_String_RelayGroup} -noredirect
;	moved non custom functions to RunInstances instead of CustomNamedAoM:
;		RunCustomScript
;		EndCustomScript
;		SeverHate
;		Target
;		ToggleWalkRun
;		EndScript
;
;ver 2Z changes 4-14-15
;	Removed npc and namednpc checks from all Actor TLO's
;	Removed radius check to Target function.
;	Fixed a bug in WaitMob function
;	Added an bool ALL Flag to ToggleWalkRun function
;	to relay it to all
;	Added a EndScript bool Flag to End Script in the Evac Function
;	and moved the function to RI
;	Fixed a bug in RIMovement (Refer to RIMovement.iss for more info)
;
;ver 2Za changes 4-18-15
;	Changed chest looting routine a bit and added summoning of chests.
;
;ver 2Zb changes 4-19-15
;	fixed Severhate script to continue to try severing hate until the shtarget is targeting
;	changed the relay ${RI_Var_String_RelayGroup} -noredirect endscript Buffer:RunInstances to CloseRI (removing console error)
; implemented relay groups. 
;   (put ${Me.Group[x]} all in an array, sort alphabetically 
;	then spew to a single string var named RI_Var_String_RelayGroup
;	then join that relaygroup and all relay ${RI_Var_String_RelayGroup} -noredirect's changed to
;	relay ${RI_Var_String_RelayGroup} -noredirect and all relay "all other"'s changed to 
;	relay "other ${RI_Var_String_RelayGroup}" -noredirect // uplink relaygroup -join ${RI_Var_String_RelayGroup})
;
;ver 2Zc 5-7-15 changes
;	changed relaygroup to a script to be invoked by relay ${RI_Var_String_RelayGroup} -noredirect upon first invocation of this script, 
;	effectively allowing everyone to set their relay group so this toon can relay to they rest of the 
;	relaygroup only to start ri
;
;	added New Zones (Rum Cellar)
;
;ver 2Zd 5-12-15 changes
;	Moved all Scripts in RunInstances Folder to the Extension and added code to delete the old files.
;	all that should be left in runinstances folder are the 2 XML files.
;	added -noredirect to all relay's
;
;ver 2Ze 5-14-15 changes
;	Added ApplyVerb function, takes 2 paramaters, the ID and the Verb
;	Added the following Named Coding:
;		Bull
;		Yipnik
;		Grogmogo
;		Corsair
;		Charanda
;	Added IsSwimming check to lootchest to ifgnore when were swimming since the new zones you cant summon when swimming
;	Added Lift function proprietary for FSD Heroic.
;
;ver 2Zf 5-14-15 changes
;	Added LootOptions function to change loot options:
;		arguments:  FreeForAll
;					LeaderOnly
;					RoundRobin
;					Lotto
;					NeedBeforeGreed
;	Added RI_Var_Bool_CorpseLoot Variable to turn off corpse looting.
;ver 2Zg 5-16-15 changes
;	Fixed stopping movement when Shiny has a collision to it.
;	tweaked Corsair function
;
;ver 2Zh 5-17-15 changes
;	tweaked Corsair function again (to release page down)
;
;ver 2Zi 5-18-15 changes
;	fixed a bug in LootOptions function
;
;ver 2Zj 5-20-15 changes
;	tweaked yipnik and charanda functions
;
;ver 2Zk 5-22-15 changes
;	fixed a bug in yipnik that made the bard not click out the toon, added so the bard and the chanter do it everytime
;		just in case the bard is in vat
;	tweaked Grogmogo to continue attempting to click rum bottles until they are no longer clickable
; 	tweaked Bull to continue to click brazier and the rum containers until they are no longer
;		clickable.
;	tweaked charanda to wait 11s after a curse spawns or until it despawns then wait 2 secs while running back
;		this fixed a bug where sometimes a few toons would stay out there an extra 10s
;	Added grogmaga function so toons click bed when its clickable.
;	tweaked corsair for when she says FIRE!, the bard runs immediately back to campspot
;		(if he is not there) regardless of what he is doing and waits 7s, then continues
;
;ver 2Zk 5-22-15 changes
;	Added a CancelMovement Global var to be set after finishing clickactor to
;		help prevent pingponging on toons who didnt make it due to stuck or other
;		issues.
;
;ver 2Zm 5-25-15 changes
;	Added disable RI_Var_Bool_Debuging to all scripts
;	Tweaked Wharfie
;	fixed a bug in CancelMovement
;
;ver 2Zn 5-26-15 changes
;	Fixed a bug in ToggelWalkRun that would not all relay ${RI_Var_String_RelayGroup} -noredirect
;	Tweaked Corsair to try to help cannon placement
;	Tweaked Wharfie to use Actor[${Me.ID}]:DoTarget instead of press f1
;
;ver 2Zo 5-27-15 changes
;	Fixed a bug in MoveBehind in RIMovement
;	Tweaked V'Raudin function
;
;ver 2Zp 5-28-15 changes
;	Tweaked Corsair
;
;ver 2Zq 6-2-15 changes
;	Tweaked Wharfie, changed 1st priest and 2nd and third scout lockspots to further prevent getting knocked below
;	tweaked Senshali, removed move behind, to help prevent some movement bugs specific to this fight
;
;ver 2Zr 6-4-15 changes
;	fixed a bug in shiny that used clear_target instead of target_none
;
;ver 2Zs 6-10-15
;	tweaked wharfie to move to barrels on opposite side 
;	tweaked MoveC function to use Actor[${Me.ID}]:DoTarget instead of press f1
;	tweaked bitterman function for better movement
;	added wait 1 in k'deru while loop
;	added Bilgewater function to make sure the group 
;		only moves behind him and not the adds
;	added Cruikshank function to jump when more than 5m from lockspot
;	added wait 1 in bosunring while loop, removed ending script
;		added to cast vial 2 times every 10s, fixed movebehind
;	added Krasnok function which handles moving the cannons and using them
;		to kill the cannoneers, tank targets crewmembers then captain.
;	changed Strafe keys and autorun keys to use global variables for access
;		from ui
;	fixed shiny spelling, fixed checking for combat while trying to get shiny
;	added stop movement to lootchest routine so it can summon
;	added a couple waits in the named function to keep others from moving behind too early
;	added turning on and off of food drink and potion when script ends and starts.
;
;ver 2Zt 6-13-15
;	added RI_CoT command and script, set to run when RI runs
;	added RI_AggroControl Command and script, set to run when RI runs
;	added the following RaidScripts and Commands:
;		Teraradus
;		Kerridicus
;		Icon
;		Jessip
;		Captain
;		Grevog
;		Torso
;		Grethah
;		Farozth
;		Ferun
;		Zadune
;		Sacrificer
;		Virtuoso
;		Protector
;	tweaked Bipsie
;	tweaked BosunRing
;	tweaked Togglecog
;	Removed all RI_Var_String_RelayGroup code and made relaygroup script set it as
;		a globalkeep variable
;	fixed a bug in Zaxfalump that caused the Tank to bounce back and forth
;	fixed a bug in wharfie that caused everyone to target crate instead of just chanter
;
;ver 2Zu 6-20-15 changes
;	Fixed a bug in HuntRingEvent that was causing you 
; 		to target the corpse instead of the alive dino
;	Tweaked Clotl'thoa to joust at 8
;	Tweaked named function to end RI_CoT and rerun after named is dead
;	Tweaked Corsair to Improve cannon placement
;
;ver 2Zv changes 6-21-15
;	Fixed a Bug in all Raid Code.
;	Fixed a bug in Kerridicus that was crashing
;	fixed a bug in captain that was crashing 
;
;ver 2Zw changes 6-22-15
;	Added Devel TLO and changed relay ${RI_Var_String_RelayGroup} -noredirect Shiny to devel only
;	Added ${RI(exists)} checks to all Buffered Scripts so they end when ext is unloaded
;
;ver 2Zx changes 6-22-15
;	fixed a bug that was not ending RI_CoT and RI_AggroControl upon ending RI
;
;ver 2zy changes 6-23-15
;	removed ogreplaynice, tweaked rimovment
;
;ver 2Zz changes 6-25-15
;	Fixed a bug in virtuoso

;ver 2ZzA changes 6-26-15
; 	updated various raid code to 100m 
;	Added The Fabled Acadechism [Heroic]
;	Added The Crypt of Valdoon [Heroic]
;	Added The Fabled Court of Innovation [Heroic]
;
;Ver Alpha3Build5 6-30-15 changes
;	Added all dat files to the extension in TLOs
;	rewrote all RI code to read from those TLOs
;	Fixed a few bugs in raid code
;	changed all Commands to RI_ (except a select few)
;	added code to remove old files
;	added code to download ri.xml if it doesnt exist
;	added RI_Depot to deposit all to closest depot
;	added RZ to Developer Access

;ver Alpha3Build6 7-1-15 changes
; fixed a bug in Both stoaways that was not picking up the first rum bottle
; fixed camp spot in hunt EH for small toons.
;	fixed a bug in rz that was not zoning out
;
;ver Alpha3Build7 7-1-15 changes
;	added RZ to Heroic allowing one set to run
;	
;ver Alpha3Build12 7-1-15 changes
;	fixed a bug in Teraradus
;	fixed a bug in Icon
;	fixed a bug in Court
;	
;ver Alpha3Build13 7-1-15 changes
;	fixed hunt
;
;ver Alpha3Build14 7-2-15 changes
;	added turning on of cast stack items when exiting ri	
;	fixed a bug in Protocol that was making it not use the gear
;	fixed a bug in treachery

;ver 3.01,3.02 changes 7-5-15
;	rebuilt auto updater and polished some authentication functions
;

;ver 3.03 changes 7-7-15
;	added a healer check to check if someone is dead and more than 50m away they will cast gather remains
;	added longer waits on valdoon for the guardians
;	removed innersanctum charm from SSRA zone
;	Tweaked War function
;	tweaked SSRA Zone
;	tweaked petrotrainer campspot
;	added RI_Var_Bool_WaitForShinys which will still goto the shiny but then wait there for the user to decide what to do
;
;
;ver 3.04 changes 7-9-15
;	fixed a bug in Hidden Caldera
;
;ver 3.1 changes 7-12-15
;	wrote ValdoonRing function to click on valdoon and to kill all the crypt guardians
;	fixed a bug in War function
;	rewrote authentication routine in Extension to remove while loop and stop process locking
;	hopefully fixed issue with not looting shinys
;	polished Court zone specifically the way it handles the last named ring event
;	Added prefaced L in the allowed Exclusions list:
;		L1,L2,L3,L12,L13,L23 - Will simply tell RZ that said zone/s are locked and will 
;		not run them and after running the unlocked zones will sit in last zone 
;		attempting to unlock the L zone/s until they are successfully unlocked
;
;ver 3.2 changes 7-13-15
;	changed campspot for BosunRing
;
;ver 3.3 changes 7-14-15
;	fixed updater, renamed extension to RI.dll
;
;ver 3.4 changes 7-14-15
;	fixed updater, renamed extension to RI.dll
;
;ver 3.5 changes 7-14-15
;	fixed bug in court for purple shiny
;
;ver 3.61 changes 7-16-15
;	changed download function to use URLDownloadtoFile instead of FTPGetFile
;	fixed UI width 
;
;ver 3.62 changes 7-16-15
;	removed checkpause call from checkcombatfunction
;	added Bool var to make it only turn on food/drink/potion 1 time 
;	Tweaked CheckGatherRemains function
;	Tweaked Court to avoid jumping off ledge to get purple shiny
;	Tweaked Valdoon to attempt to avoid getting stuck near the ledge.
;
;ver 3.63 changes 7-17-15
;	Added CheckShiny in Evac function to check before ending script
;	Tweaked King ring event in Court
;	Fixed a bug in CheckGatherRemains function
;
;ver 3.64 changes 7-19-15
;	Fixed a bug in CoT that was not stopping movement
;	Removed RI_Var_Bool_Debug code from CourtPowerCells Function
;	Fixed another bug in CheckGatherRemains function
;	Fixed a bug in CHH Event Heroic
;	Fixed updater to only update on 1 session. This will always be the session in the foreground, if none are in the foreground, it will try is1, if is1 does not exist it can be random which session updates.
;
;ver 3.65 changes 7-22-15
;	Added ui for RZ
;	Changed movement code for all raid scripts
;	added ui for raidcode
;	temporarily disabled SSRA: Inner Sanctum zone.
;	temporarily disabled Bull raid code
;	temporarily disabled imbiber raid code
;
;ver 3.66 changes 7-23-15
;	fixed a bug in download ri and rz.xml files
;
;ver 3.67 changes 7-24-15
;	fixed a bug in CoT that was causing movement to stop
;
;ver 3.68 changes 7-24-15
;	fixed another bug in download ri and rz.xml files

;ver 3.69 changes 7-24-15
;	fixed a crash bug
;
;ver 3.70 changes 7-26-15
;	fixed a typo in evac function
;
;ver 3.71 changes 7-26-15
;	fixed another bug in evac function
;
;ver 3.72 changes 7-27-15
;	Removed an object that was allowing detection by other "things"
;
;ver 3.73 changes 7-27-15
;	Removed another object that was allowing detection by other "things"
;
;ver 3.74 changes 7-27-15
;	Removed 3 zone restriction from RZ, 
;	People claim this is how RI works, well now it does!!
;
;ver 3.75 changes 7-27-15
;	fixed a bug in Sacrificer 
;
;ver 3.76 changes 7-27-15
;	fixed a bug in Grevog
;	fixed a bug in evac function
;	Removed AutoLoot event from RI since its redundant
;
;ver 3.77 changes 7-29-15
;	Improved Evac function
;
;ver 3.78 changes 8-4-15
;	Improved SH function
;	Removed LoggedIn Function in Ext, to be redone and added later
;	Added a few redundant special clicks for MCP in court
;
;ver 3.79 changes 8-9-15
;	Improved Corsair function
;	
;ver 3.80 changes 8-18-15
;	Added RIMovementUI and RIMUI Commands that will bring up the new RIMovement UI
;
;ver 3.81 changes 8-18-15
;	Fixed a BUG in RZ
;
;ver 3.82 changes 8-18-15
;	Fixed a BUG in RI that was closing RIMovement
;
;ver 3.83 changes 8-18-15
;	Added pausing of Other to:
;		Grevog
;		AggroControl
;
;ver 3.84 changes 8-26-15
;	Tweaked King Function
;	Added CastleHighold to RZ
;	Added Y check to CheckShiny for Named
;	Added the Following to script atexit function:
;		stopped pressing forward key on all in relaygroup
;		stopped RILockspot on all in relaygroup
;		stopped RIFollow on all in relaygroup
;	Added CHH to RZ
;	Fixed looting sometimes not looting.
;	Changed Extension back to ISXRI.dll
;	updated Auth function to use WinAPI CreateThread to prevent Freezing and to only open L/P form on 1 client
;	updated Updater function to use WinAPI CreateThread to prevent Freezing
;	updated LoggedIn function to use WinAPI CreateThread to prevent Freezing
;	Removed AggroControl from RI for now due to errors in some zones
;	Updated all RaidCode to Stop RILockSpot and RIFollow, Added RRG RaidRelayGroup for Closing of scripts
;
;ver 3.85 changes 8-27-15
;	Fixed a bug in the update function that was not updating when Extension filename was renamed.
;
;ver 3.86 changes 8-29-15
;	Fixed a bug in Grethah
;
;ver 3.87 changes 8-29-15
;	Fixed another bug in Grethah
;
;ver 3.88 changes 9-1-15
;	Updated all Heroic code to be THGBot Compatible
;
;ver 3.89 changes 9-1-15
;	Finished Updating all Heroic code to be THGBot Compatible
;
;ver 3.90 changes 9-4-15
;	Added:
;		RI_Ritual
;		RI_ZoneReset
;		RI_Login (takes 1 argument, ToonName/ImportOgre(imports ogre eq2chars.xml into RICharList.xml))
;		RI_Repair
;		RI_Flag (takes 1 Argument, Get/Take(Default))
;	fixed bug in RZ for CHH zones.
;
;ver 3.91 changes 9-4-15
;	Fixed a bug in Ritual
;
;ver 3.92 changes 9-4-15
;	Fixed another bug in Ritual
;
;ver 3.93 changes 9-4-15
;	Updated Ritual for THGBot
;
;ver 3.94 changes 9-4-15
;	Updated Ferun for THGBot
;	Updated Zadune for THGBot
;	Updated Virtuoso for THGBot
;
;ver 3.95 changes 9-4-15
;	Fixed a bug in RaidRelayGroup and RI
;
;ver 3.96 changes 9-5-15
;	Added RIMobHud
;
;ver 3.97 changes 9-5-15
;	Fixed a bug in ZoneReset
;
;ver 3.98 changes 9-5-15
;	Fixed a bug in RIMobHud
;	Made RILooter work without RI
;
;ver 3.99 changes 9-6-15
;	Updated RIMovement
;	Added RI_CMD_FullRebuff to RIMUI Commands
;	Updated RI
;
;ver 4.00 changes 9-6-15
;	Fixed a bug in RIMovement
;	Added 
;		RI_CMD_FullRebuff
;		RI_CMD_AbilityEnableDisable
;		RI_CMD_Assisting
;		RI_CMD_PauseCombatBots
;		RI_CMD_ReloadBots
;		RI_CMD_AbilityTypeEnableDisable
;		RI_CMD_FoodDrinkConsume
;	Fixed a bug in RI_Repair that was not unpausing the bots
;	Fixed a bug in RI_Flag that was not unpausing the bots
;	Updated ALL RaidCode to use New Commands above
;	Updated ALL Heroic Code to use New Commands above
;	Updated CoT to use new Commands above
;	Added Bull Raid Code Back in
;
;ver 4.01 changes 9-6-15
;	Fixed a bug in RILogin for AB toons
;
;ver 4.02 changes 9-6-15
;	Fixed a bug in RILogin
;
;ver 4.03 changes 9-6-15
;	Added RI_Var_Bool_Debug option to RILogin
;
;ver 4.04 changes 9-7-15
;	fixed a few bugs in grevog
;	updated RI_CMD_Assisting
;
;ver 4.05 changes 9-8-15
;	Fixed a bug in RIMovementUI
;
;ver 4.06 changes 9-9-15
;	Fixed a bug in RIMovement
;	Added the following commands
;		RI_CMD_Cast
;		RI_CMD_CastOn
;
;ver 4.07 changes 9-9-15
;	Updated RI_CMD_PauseCombatBots
;	Added RI_CMD_PauseRIMovement
;	Added RI_CMD_PotionConsume
;	Fixed a bug in RIMovement
;	Updated RIMUI (Lots of changes, more options to come)
;
;ver 4.08 changes 9-10-15
;	Fixed a bug in the updater that was not always updating XML's
;
;ver 4.09 changes 9-10-15
;	Fixed a bug in RIMovementUI
;	Updated RILogin
;
;ver 4.10 changes 9-13-15
;	Fixed a bug in RIMovement that wasnt downloading the XML
;	Added ISXEQ2.IsReady Wait to RILogin
;	Updated RIMobHud
;	Fixed cure curse on Mo'iana
;	Fixed Get/Take Flag Bug in RIMUI

;ver 4.11 changes 9-14-15
;	Really fixed cure curse on Mo'iana, also repositioned lockspots to help with LoS and sometimes tank rubber banding
;	Added a spot in between the original lockspot and augurs lockspot on Kaimanu to help prevent getting stuck on rocks
;	Fixed a bug in Grogmaga that was pausing and not unpausing the bots
;	Fixed a bug in MoveBehind and MoveInFront Code where it was not working on any fights.
;	Tweaked LockSpots on Wharfie
;
;ver 4.12 changes 9-16-15
;	Fixed a bug in RIMovement movebehind/infront that was not stopping on Lockspot
;	Added MultipleCommands to RIMUIObj allowing chaining of commands	
;	Fixed a bug in RZ that would attempt to lock a zone that you are in before zoning out if it is resetable
;	Fixed a bug in CHH on Senshali that was causing some toons to run off the platform
;	Fixed a bug in CHH on Blackhand that was not interrupting his heal
;	Moved LockSpot position for ShoGrah
;	Added turning off of FaceNPC when moving with RIMovement
;
;ver 4.13 changes 9-21-15
;	Added To RIMUIObj
;		method Depot(string ForWho)
;		method RunScript(string ForWho, string ScriptName)
;		method EndScript(string ForWho, string ScriptName)
;		method ExecuteCommand(string ForWho, string CommandName)
;
;	Documenting RIMUIObj methods not Mentioned Earlier:
;		method FDR(string ForWho)
;		method Repair(string ForWho)
;		method Special(string ForWho)
;		method Revive(string ForWho)
;		method FoodDrinkConsume(string ForWho, int OnOff)
;		method Door(string ForWho, int Door)
;		method EquipCharm(string ForWho, string Charm)
;		method PotionConsume(string ForWho, int OnOff)
;		method CallGH(string ForWho)
;		method Zone(string ForWho)
;		method POTR(string ForWho)
;		method Flag(string ForWho, string GetTake=Take)
;		method Evac(string ForWho)
;		method FullRebuff(string ForWho)
;		method LSPop()
;		method RIFolPop()
;		method AssistPop()
;		method DoorPop()
;		method PreHeal(string ForWho, string OnWho)
;		method RIFolChg(string ForWho, int Inc)
;		method MultipleCommands(... argv)
;		method MC(... argv)
;		method StopMove(string ForWho)
;		method ComeOn(string ForWho)
;		method ChoiceWindow(string ForWho, int Choice)
;		method SetRIFollow(string ForWho, string OnWho, int Min, int Max)
;		method SetLockSpot(string ForWho, string X, float Y, float Z, int Min, int Max)
;		method Pause(int OnOff, string ForWho)
;		method Cast(string ForWho, string SpellName, int CancelCast)
;		method CastOn(string ForWho, string SpellName, string CastName, int CancelCast)
;		method Assist(string ForWho, int OnOff, string OnWho)
;	Fixed a bug in CoI for Power Cell C
;	Improved Target Function, added 3 arg for Distance to check for target
;
;ver 4.14 changes 9-22-15
;	Changed LS on ritual
;	Fixed a Bug in Kerridicus
;	Really fixed a targeting bug in Valdoon's
;
;ver 4.15 changes 9-25-15
;	Added To RIMUIObj
;		method ApplyVerb(string ForWho, string Actor, string Verb)
;		method AcceptReward(string ForWho)
;		method AutoRun(string ForWho)
;		method CampDesktop(string ForWho)
;		method CampLogin(string ForWho)
;		method CampCharacterSelect(string ForWho)
;		method Jump(string ForWho)
;		method EndBots(string ForWho)
;		method Crouch(string ForWho)
;		method Hail(string ForWho, string HailWho)
;		method Mentor(string ForWho, string MentorWho)
;		method UnMentor(string ForWho)
;		method Target(string ForWho, string TargetWho)
;		method UseItem(string ForWho, string ItemName)
;		method UnloadISXRI(string ForWho)
;		method HailOption(string ForWho, int Option)
;		method CloseTopWindow(string ForWho)
;		method PetAttack(string ForWho)
;		method PetBackOff(string ForWho)
;		method ToggleWalkRun(string ForWho)
;	Modified RIMUI - First Column is Frame Change buttons, this changes to up to 10 different frames of buttons allowing up to 510 total Customizable Buttons (depending on UI Size), The 2nd column is static buttons these do not change, column 3-7 change with frame selection.
;	Fixed a bug in RedCorsair that was not turning off FaceNPC and causing toons to fall off the Elevator
;	Tweaked RedCorsair CampSpot to help hide better from her FIRE
;	Modified RIMUIEdit - When you right click a button in RIMUI it opens this new UI window that allows you to change any button on RIMUI
;	Added RI and !RI commands, they take special arguments and can run most all commands and scripts in RI
;		type RI AvailableCommands or RI AC to list all the commands available (many more to come)
;		if no argument is given both commands will invoke RunInstances Script
;		if an unknown argument is given RILogin will search for a toon matching the argument and log them in
;	  Arguments:
;		Zadune
;		Looter
;		Farozth
;		Evac
;		RIMovement
;		RIM
;		FDR
;		FoodDrinkReplenish
;		RIMovementUI
;		RIMUI
;		Ferun
;		Grethah
;		Grevog
;		Icon
;		RRG
;		RaidRelayGroup
;		RG
;		RelayGroup
;		Jessip
;		Kerridicus
;		RZ
;		RunZones
;		AggroControl
;		Protector
;		AntiAFK
;		Sacrificer
;		Captain
;		Teraradus
;		Charanda
;		Torso
;		Ritual
;		Repair
;		Flag
;		ZR
;		ZoneReset
;		Login
;		RIMH
;		RIMob
;		RIMobHud
;		CAM
;		CancelAllMaintained
;
;ver 4.16 changes 9-25-15
;	Fixed a bug in RIMUI
;
;ver 4.17 changes 9-25-15
;	Fixed another bug in RIMUI
;
;ver 4.18 changes 9-25-15
;	Updated update function
;	Fixed a Folder issue
;
;ver 4.19 changes 9-25-15
;	Added the following to RIMUIObj and AvailableCommands in RIMUIEdit
;		Invite
;	Added auto accepting of invites/rezes/teleports.
;
;ver 4.20 changes 9-25-15
;	Added auto accept trade (to turn off RI_Var_Bool_AcceptTrades:Set[FALSE])
;
;ver 4.21 changes 9-27-15
;	Fixed a display bug in RIMobHud
;	Fixed a Bug in Grethah
;	Fixed a crash but with PotionReplenish (method still not implemented, just fixed the crash)
;	Fixed a bug in Door Method
;
;ver 4.22 changes 9-28-15
;	Changed CancelAllMaintained to only cancel Abilities
;
;ver 4.23 changes 9-28-15
;	Fixed a bug in Run/Endscript
;
;ver 4.24 changes 9-29-15
;	Added the Following to RIMUIObj
;		method UnLoadNearestNPCHud(string ForWho)
;		method LoadNearestNPCHud(string ForWho)
;		method UnLoadRaidGroupHud(string ForWho)
;		method LoadRaidGroupHud(string ForWho)
;	(The huds have existed for a while but are now toggleable by the user)
;	Changed the Added Arguments List of RIMUIEdit to User Sortable allowing you to move arguments to where you want them in the list
;	Fixed a Bug with Farozth	
;
;ver 4.25 changes 10-2-15
;	Added RI_AutoTarget
;
;ver 4.26 changes 10-12-15
;	Fixed a bug in RI that would sometimes run after shinys that were near a named when Your Y was more than 10 distance from the nameds (calc was supposed to check the shinys Y)
;	Tweaked Icon, Added jousting out of pool with named when someone is in pool, and added death prevent logic for announce
;	Tweaked Shiny routine to ignore shinys that are lower or higher than 10m from your position to prevent jumping down to grab shinys and getting stuck on the wall trying to return to your original loc.
;	Fixed a bug that was causing CoT to pause RIMovement, and The Bots, when ported after a ClickActor Event
;	Changed RIFollow so that when the follow target Starts to fly you will ingame follow them, when they land you will return to rifollowing them and land if you are still flying
;	Fixed a bug in SetRIFollow function that was crashing when off was passed into the args
;	Updated RIMovement to Accept CombatBot Settings
;	Updated RI to Accept CombatBot Settings
;	Added to Devel
;		CombatBot (CB || RI_CB || RI_CombatBot)
;		AbilityCheck (RI_AbilityCheck)
;
;ver 4.27 changes 10-15-15
;	Made some internal changes to keymappings to be more compatible with CombatBot
;

;when CombatBot goes Beta we will start doing all Update notes here in RI.iss so they can include all Updates from RunInstances and all updates from CombatBot

; noop ${If[${Math.Distance[${Me.Loc},-90,-110,50]}<5,RIMUIObj:SetLockSpot[${Me.Name},-110,-110,50],RIMUIObj:SetLockSpot[${Me.Name},-90,-110,50]]}
; ${Math.Distance[${Me.Loc},-90,-110,50]}<5
; ${RIMUIObj:SetLockSpot[${Me.Name},-110,-110,50]}
; ${RIMUIObj:SetLockSpot[${Me.Name},-90,-110,50]}

; ${If[${Math.Distance[${Me.Loc},-90,-110,50]}<5,execute RI_Atom_SetLockSpot ${Me.Name} -110 -110 50,execute RI_Atom_SetLockSpot ${Me.Name} -90 -110 50]}

;v4.29 Changes 10-16-15
;	RI:
;		Added RI_CMD_ExecuteCommand
;
;	RIMUI:
;		Changed MC/MultipleCommands/ExecuteCommand/RunScript and EndScript to utilize the new RI_CMD_ExecuteCommand

;
;v4.29 Changes 10-16-15
;	RunInstances:
;		Added CombatBot Compatibility
;
;	RI
;		Added RI_CMD_PoisonReplenish
;		Added RI_CMD_PoisonConsume
;		Activated RI_CMD_PotionReplenish
;		Fixed a few dexcription typo's
;		Added Global Variables for PotionName,FoodName,DrinkName,Poison1Name,Poison2Name,and Poison3Name in preperation for CombatBot 
;			Currently all these variables are defaulted to:
;				FoodName: Stormborn Souffle
;				DrinkName: Monsoon
;				PotionName: Gnostic's Elixir of XX (Piety, Deftness, Fortitude or Intellect)
;				Poison1Name: Exemplar's Hemotoxin
;				Poison2Name: Infused Savant's Essence of Turgur
;				Poison3Name: Infused Savant's Warding Ebb
;					These all will have options in CombatBot that you can change which of them you want to use and save to your profiles.
;		Fixed a bug in AutoTarget that was ignoring the Enabled CheckBox
;
;		Modified all Food/Drink/Poision and Potion Consume and Replenish routines to use these new Variables.
;
;	RIMUI
;		Added PoisonReplenish
;		Added PoisonConsume
;		Activated PotionReplenish
;
;v4.30 Changes 10-21-15
;	Updated Auth Server
;
;v4.31 Changes 10-21-15
;	Fixed a bug in the Auth Server
;
;v4.32 Changes 11-1-15
;	CombatBot:
;		Released to ALL access levels for Public Beta Testing
;		Fixed a bug that was marking all abilities to AllowRaid=FALSE
;		Completed Saving
;		Coded OnEvents: Run/End/IncomingText/Announcement/Death 
;		Added auto copy of Profiles from Old Servers to New Merged Servers.
;		Fixed a small RI_Var_Bool_Debug Bug
;		Added RI_Obj_CB method ModifyCastStackAbilityType(string AbilityType, string EnableDisable)
;			Accepts the following AbilityTypes: 
;				CA/Hostile NamedCA/NamedHostile Combat/InCombatTarget 
;				Heal Power Buff OutOfCombatBuff/NonCombatBuff Res
;			Accepts the following EnableDisable:
;				1/TRUE For Enabled , 0/FALSE for Disable
;		Added Curse Cure Logic for need a cure curse(will be customizable in the near future), so it will attempt to cure until no one that called is left cursed
;		Added Confront Fear Logic for need a confront fear(will be customizable in the near future), so it TRIES not to step on any other dirge and tries to get everyone's confront fear.
;		Modified ImportOgre method to check for previous servernames for the Merged servers.
;		Fixed a bug when downloading default profile and failing
;
;v4.33 Changes 11-2-15
;	CombatBot:
;		Temporarily disabled confront fear logic as it was sometimes causing dirge's to get stuck in a loop.
;		
;v4.34 Changes 11-3-15
;	CombatBot:
;		RI_Obj_CB:Cast will now accept Item's as its first argument but they must be in the form Item:Item Name
;			ex. relay all RI_Obj_CB:Cast[Item:Hempen Halter,1]
;				P.S. (Hint) This can be used under announce for 1 toon as ExecuteCommand to make all the
;					 rest of your toons Cast Hempen Halter when the one announcing the command does :O
;		
;v4.35 Changes 11-3-15
;	CombatBot:
;		Fixed a bug that would fail to start combatbot or download cb req files when RI folder does not exist
;		Fixed a bug in method Cast that would cause CB to get stuck in a death loop
;		Added Default Profile for: Berserker
;
;v4.36 Changes 11-4-15
;	CombatBot:
;		Added X,Y Text Entry boxes for All 3 Hud Types as well as + - buttons to inc or dec the values
;			Added Saving to profile of above
;		Added HudsRaidGroupOnlyCheckBox to RaidGroupHud to allow only your group to be shown when in raid
;
;	RI:
;		Added methods:
;			method LoadNearestPlayerHud(string ForWho)
;			method UnLoadNearestPlayerHud(string ForWho)
;
;v4.37 Changes 11-4-15
;	RunInstances:
;		Fixed a bug that was not looting shinys in most cases.
;	CombatBot:
;		Added Methods to RI_Obj_CB:
;			method RI_Var_Bool_Debug(string EnableDisable)
;			method CastingRI_Var_Bool_Debug(string EnableDisable)
;				EnableDisable will accept 1/TRUE for Enable and 0/FALSE for Disable
;		Added CastingRI_Var_Bool_Debug/RI_Var_Bool_Debug Checkboxes in Misc Frame
;		Fixed a bug that was not allowing [] or , to be entered in OnEvents and Announce Commands
;
;v4.38 Changes 11-5-15
;	RI:
;		Added secondary authentication server
;		Moved RI_Update command to PRE Auth, so if its failing auth you can still at least update
;
;v4.39 Changes 11-5-15
;	RI:
;		Fixed a bug in Hail that was not hailing multi word actors
;	CombatBot:
;		Fixed a bug in OnEvents that was not allowing entry of ${} and escaping them.
;
;v4.40 Changes 11-29-15
;	RIMUI:
;		Added auto adding of Quotes for arguments that need them if they are not put in.
;	RunInstances:
;		Added checking if RZ is running before redisabling LockSpotting on Exit.
;		Added Stygian Threshhold(Heroic)
;			Added Coding for Nocturn
;			Added Coding for Heracyne
;			Added Coding for Mawz
;
;v4.41 Changes 12-9-15
;	RI:
;		Fixed a bug in RI_Atom_SetRIFollow
;	RunInstances:
;		Added Bar Brawl (Event Heroic)
;			Added Coding for Bailey	
;
;v4.42 Changes 12-10-15
;	RunInstances:
;		Added First Named in Bar Brawl to Zone File
;		Tweaked Coding for Bailey	
;
;v4.43 Changes 12-10-15
;	RunInstances:
;		Added NoKill NPC check in Named Function
;		Tweaked Bar Brawl
;
;v4.44 Changes 12-14-15
;	RunInstances:
;		Added Maldura: District of Ash [Heroic]
;			Added Coding for Gavitzle
;			Added Coding for Cudgava
;
;v4.45 Changes 12-14-15
;	RunInstances:
;		Fixed a Bug in Maldura: District of Ash [Heroic] that would evac on last named
;		Fixed a Bug in Maldura: District of Ash [Heroic] that was skipping Gavitzle's script
;
;v4.46 Changes 12-15-15
;	RunInstances:
;		Added Maldura: Palace Foray [Event Heroic]
;			Added Coding for Dreadtusk (fight and spawn)
;			Added Coding for Dreadmaw (fight and spawn)
;
;v4.47 Changes 12-15-15
;	RunInstances:
;		Tweaked Gavitzle
;		Added a cpl PreHeal spots in Bar Brawl
;		Added Stygian Threshold: The Howling Gateway [Event Heroic]
;			Added Coding for Hagrash
;			Added Coding for Gagrash
;			Added Coding for Bagagrash
;
;v4.48 Changes 12-16-15
;	CombatBot:
;		Fixed a HUGE bug that would Cause the cast stack to not go beyond 
;			an ability that part of the name was in an item either in inventory or
;			equipped, long story short, Alot of Classes were not casting correctly and
;			their cast stack's would get stuck rendering them ineffective. THIS IS FIXED
;
;v4.49 Changes 12-17-15
;	RunInstances:
;		Fixed a bug in Bar Brawl that was not targeting the fungus after the Circus Brothers.
;	RZ:
;		Added Maldura Zones
;
;v4.50 Changes 12-17-15
;	RunInstances:
;		Really Fixed a bug in Bar Brawl that was not targeting the fungus after the Circus Brothers.
;		Fixed a bug in Palace that would sometimes not target the aggressive if they add.
;	RZ:
;		Really Added Maldura Zones
;
;v4.51 Changes 12-18-15
;	RunInstances:
;		Added Kralet Penumbra: Rise to Power [Heroic]
;			Added Coding for Xacx-Kahd
;		Added Kralet Penumbra: Temple of the Ill-Seen [Heroic]
;	RIMovement:
;		Fixed a bug that would rarely not release back or forward keys when moving behind and getting aggro
;
;v4.52 Changes 12-18-15
;	RunInstances:
;		Tweaked Rise To Power
;		Tweaked Palace
;
;v4.53 Changes 12-18-15
;	RunInstances:
;		fixed a bug in Rise To Power that was sending the group to the wrong rooms
;
;v4.54 Changes 12-24-15		
;	RunInstances:
;		fixed a bug in Palace that was not moving dirge behind group and not moving back to doorway
;		tweaked Howling Gateway
;	CombatBot:
;		fixed Confront Fear Logic
;	RIMovement:
;		Added out of group flying follow
;
;v4.55 Changes 12-28-15
;	RunInstances:
;		Added StygianForest Routine to Stygian Heroic
;		Rewrote alot of the pathing in Stygian Heroic
;	CombatBot:
;		Fixed a bug in ConfrontFear Routine
;	RI: 
;		Modified Zone fn
;	RZ:
;		Added KP Zones and Stygian Zones
;
;v4.56 Changes 12-28-15
;	RunInstances:
;		Tweaked Zaraxia
;		Tweaked Mraz
;		Tweaked Bagarash
;
;v4.57 Changes 1-4-15
;	HAPPY NEW YEAR
;	
;	RI:
;		Added Command:
;			RI_AutoDeity(int Mode=0, string RI_Var_Bool_Debug=Verbose)
;				Accepts the following Mode:
;					0 - Balance ALL (Default)
;					1 - Spend all points in Potency
;				    2 - Spend all points in Crit Bonus
;				 	3 - Spend all points in Stamina
;					4 - Balance Only Potency and Crit Bonus
;					5 - Balance Only Potency and Stamina
;					6 - Balance Only Crit Bonus and Stamina
;				Accepts the following RI_Var_Bool_Debug:
;					Silent
;					Verbose (Default)
;				Script includes a Global Atom to change the mode on the Fly:
;					RIAutoDeity_ChangeMode(int Mode=0)
;						Refer to above Modes
;				Usage Example: RI_AutoDeity 2 Silent
;	RunInstances:
;		Tweaked Z'Koz
;
;	CombatBot:
;		Added auto loading of RIAutoDeity with the default options to CB
;			Saveable profile options coming later
;			To End simply type endscript Buffer:RIAutoDeity

;v4.58 Changes 1-6-15
;	RunInstances:
;		Tweaked Dreadtusk
;		Tweaked Dreadmaw
;		Tweaked Z'Koz
;		To attempt to reduce stucks, Reduced Shiny Scan Distance to 10 for:
;			KP: Rise to Power
;			KP: Temple of the Ill Seen
;
;v4.59 Changes 1-21-15
;	RIMovement:
;		Removed auto swim up when swimming
;	CombatBot:
;		Added MoveBehind Code

;v4.62 Changes 7-6-16
;	RunInstances:
;		Fixed a bug in KP: Rise to Power and Stygian Threshold that was getting the group stuck.
;	RI:
;		Added RI_WriteLocs
;			- script to create ZoneFiles for RunInstances.
;
;v4.63 Changes 7-6-16
;	RunInstances:
;		Fixed another bug in KP: Rise to Power that was getting the group stuck.

;v4.64 Changes 7-10-16
;	RI:
;		Opened up Full access to everything to Beta login, Added an Identical login, Public with password Free, this login also has full access.
;	RILogin:
;		Fixed syntax replacing AddToTextBox with SetProperty
;	RunInstances:
;		Fixed a bug in Stygian Custom Function StygianForest that was not correctly ignoring NON LOS Shinys

;v4.65 Changes 7-14-16
;	RI:
;		Fixed all ChoiceWindow Text Finds to appropriate new syntax
;	CombatBot
;		Fixed all ChoiceWindow Text Finds to appropriate new syntax

;v4.66 Changes 11-12-16
;	ALL:
;		Removed ALL Deprecated ToActor Calls.

;v4.67 Changes 11-16-16
;	CombatBot:
;		Fixed a small bug related to detecting in combat for casting Hostile, NamedHostile or InCombatTargeted Spells.
;		Fixed a bug with Character(exists) that surfaced after removing all calls to ToActor (previously exists would fail if toon in another zone) 
;			Fixed by adding an additional check everywhere for .InZone and Health>0

;v4.68 Changes 11-27-16
;	RI:
;		Added Face Target to Hail Command.
;		Added RI_Harvest - just harvest any node you come within 7m of
;	CombatBot:
;		Fixed a bug that attempted to cast while flying
;

;v4.69 Changes 12-4-16
;	CombatBot:
;		Fixed a bug that prevented CB from Killing AutoDiety when detect text "You must have expansion 12 to use this feature"
;			- also moved this functionality to the AutoDiety Script itself
;	RIMovement
;		Fixed a bug that when pausing RIMovement would sometimes not release held movement keys.
;

;v4.70 Changes 12-10-16
;	RIMovement
;		Removed a couple leftover calls to stayafloat system.
;		Fixed a bug that when pausing RIMovement it would not stop autorun
;		Added SwimFollow to RIMovement

;v4.71 Changes 12-11-16
;	RI
;		Fixed a crashing bug in RI_AutoTarget

;v4.72 Changes 12-12-16
;	RI
;		Added Kaesora: Xalgozian Stronghold [Heroic] to RI
;	AutoDeity
;		Removed the prompt asking are you sure

;v4.73 Changes 12-16-16
;	RI
;		Refined Kaesora: Xalgozian Stronghold [Heroic]
;			Added Custom Coding for:
;				Eghonz (target self and back off pets while bulwark is up)
;				Janosz (target self and back off pets while bulwark is up, target adds when up)
;			Cleaned up some of the pathing
;	CombatBot
;		Added Atom:
;			RI_Atom_CB_SetUISetting(string _SettingName, string Value)
;				changes setting on the SettingsTab of CB to the Value given
;		Added some coding for Allowing certain Ascension abilities at Hostile that were previously coming up as beneficial

;v4.74 Changes 12-19-16
;	RI
;		Removed inmygroup check from RIMobHud
;	CombatBot
;		Added Verdict Casting for Inquisitors
;		Added Looting Corpses and Chests
;	RunInstances
;		Refined Kaesora: Xalgozian Stronghold [Heroic]
;			changed LockSpots for Xigoh
;			changed targeting on Vhankmin
;		Changed the way the UI handles auto loot

;v4.75 Changes 12-23-16
;	RunInstances
;		Added Arcanna'se Spire: Forgotten Sanctum [Heroic]
;			Pathing across entire zone
;			Special Coding for Following Nameds:
;				Queshaun
;					Target self and backoff pets while Endemic Redoubt is up
;				Caelan'Gael
;					AutoTargeting of the vile prisons and the adds
;				Lachina
;					Target self and backoff pets while Endemic Redoubt is up
;		Added Arcanna'se Spire: Repository of Secrets [Heroic]
;			Pathing across entire zone
;			Special Coding for Following Nameds:
;				Tabor'Zaai
;					Target remnants while Endemic glyphs are up
;		Added Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]
;			Pathing across entire zone
;			Special Coding for Following Nameds:
;				Sorceress
;					Mages will Absorb Magic as needed (!!!!!!!!!!!!!!!!!!!!!NOT DONE YET!!!!!!!!!!!!!!!!!!!!!!)
;	RI
;		Added ability to call specific custom coded named encouters independent of RI
;			type RI Pull Named in console to invoke functions, available encounters:
;				Vhankmin, Eghonz, Janosz, Queshaun, Caelan'Gael, Lachina, Tabor'Zaai, Sorceress
;			more to come, Type RI Pull NAMEDLIST anytime for a full list of available encounters
;		Added 3 New Scripts
;			RI_DeleteMissions(bool Prompt=TRUE)  -- Deletes all your mission quests in your quest journal 
;			RI_ShareMissions(bool Prompt=TRUE)  -- Shares all your mission quests in your quest journal 
;			RI_Balance  -- balances mobs within a certain health threshold.
;		Updated WriteLocs
;	
;v4.76 Changes 12-26-16
;	CombatBot
;		Fixed a bug that was incorrectly reading and tagging Beneficial AE's
;		Fixed a bug that would incorrectly set the UIelements on CastStackClick of certain abilities
;		Fixed a bug that was not treating Beneficial AE's as AE's
;		Added RI_Var_Bool_CastWhileMoving global boolean to Allow Casting While Moving
;	ShareMissions
;		Increased wait to 1.5s to allow time for toons to accept.

;v4.77 Changes 12-28-16
;	RI
;		Fixed a bug in RIFollow
;	RunInstances
;		Fixed a bug that would cause "all other" to try to end the script twice resulting in an error message
;		Autoloot now temporarily disables looting in CB as well
;	CombatBot
;		Updated Inventory functions to use new QueryInventory system

;v4.78 Changes 12-29-16
;	RunInstances
;		Added Arcanna'se Spire: Revealed
;			Pathing across entire zone and clickies
;	CombatBot
;		Added a few more Flying Checks
;		Fixed a maintained bug that was not correctly checking maintained target on Hostile Abilities
;		Fixed Logic for imported Target Type @PCTarget, to check implied target as well and to ignore ability if neither exists or is not a player character

;v4.79 Changes 12-29-16
;	RunInstances
;		Changed some backend code on how RunInstances reads Files from the extension and from disk
;		Arcanna'se Spire: Forgotten Sanctum [Heroic]
;			Fixed a bug in Lachina and Queshaun that could rarely cause the script to do the opposite
;		Arcanna'se Spire: Vessel of the Sorceress [Heroic]
;			Updated Sorceress code to use new Actor Effect Query System
;			Refined timing
;		Added the Rest of the Kunark Ascending Heroic, Event Heroic, Solo and Advanced Solo zones
;			they do not have files built into the extension yet but can be ran with custom made files from RI_WriteLocs
;				simply type ImportZoneFile filename after loading RI
;	RI
;		Fixed camp desktop
;		Added a few KA zones for Zone button
;	CombatBot
;		Globally Disabled Attempt to TimeAutoAttacks
;		Fixed a bug in Importing Charms

;v4.80 Changes 12-30-16
;	RunInstances
;		Fixed a bug in reading ZoneFiles
;	WriteLocs
;		Added loading of existing dat files from the ZoneFiles folder
;			auto loads if default file exists
;		Added Edit Selection feature to edit anything already in the Waypoints ListBox
;		Modified WriteLoc to change the currently selected item to a loc if selected

;v4.81 Changes 12-31-16
;	RI
;		Fixed Timing on INQ Preheal
;		Added new Script
;			RA (RunAgnostics)
; 				Very similiar to RZ in that it will loop an Agnostic zone over and over
;					Zone either has to be coded in the extension or you must have a 
;					dat file in WriteLocs default name in the ZoneFiles folder
;				simply type RA ZoneName into the console and it will begin 
;				(make sure your grouped up and at your appropriate agnostic portal(evil or good))
;					zone name can be anything from just a few letters to the full zone name it 
;					will search from top down the destination list until it finds 
;					a zone matching what you entered for ZoneName, remember if you have spaces in your 
;					ZoneName please surround the entire ZoneName with ""
;	RunInstances
;		Added all the Agnostic Zones
;			most do not have files built into the extension yet but can be ran with custom made files from RI_WriteLocs
;				simply type ImportZoneFile filename after loading RI
;		Added Crypt of Dalnir: Wizard's Den [Event Heroic]
;			pathing entire zone (NOT PATCHED YET)
;			Custom Named Coding:
;				Gooblin
;					Uses item on each toon when appropriate based on Alphabetical
;		Modified ImportZoneFile to allow calling with no argument and to default to WriteLocs 
;		default zone file name when called with no argument
;	AbilityCheck
;		Updated to use new ToAbilityInfo

;v4.82 Changes 1-3-17
;	RunInstances:
;		Added balancing of trash to within 2 health
;		Modified movement routine to work better with flying and swimming
;		Crypt of Dalnir: Wizard's Den [Event Heroic]
;			Added pathing of entire zone
;		Maldura: Palace Foray [Event Heroic]
;			Modified Dreadmaw and Dreadtusk:
;				Instead of bard handling script now it sends the first person alphabetically unless they are tank then 2nd person
;		Added The Crypt of Agony [Agnostic]
;			Pathing for entire zone including zone out to be compatible with RA
;	CombatBot:
;		Modified TargetNearestAggroMob && CountAE object to use new QueryActor system
;		Moved GetCharms and GetItems functions outside of main script so it does not hold up everything while iterating 
;			through peoples sometimes very large and full inventory bags
;	RA
;		Added 15s wait when zoning to Qeynos/Freeport before zoning back to specified zone
;		Added 2ms wait after calling GetZoneList Object to ensure its populated before Checking arg for correct Highlight row option

;v4.83 Changes 1-3-17
;	RunInstances
;		Added balancing to Adds in Named Fights
;		Fixed Crypt of Agony [Agnostic] zone file

;v4.84 Changes 1-3-17
;	RunInstances
;		Arcanna'se Spire: Forgotten Sanctum [Heroic]
;			Fixed a bug near last named that pulled her entire hall and room of trash at once
;		Fixed a bug in Balancing adds in Named Fights
;	RZ
;		Added Arcanna'Se Spire Zones
;	RI
;		Added new Script RI_HideEffects
;			Hides all your effects that are -1 duration and self,group,pet or raid

;v4.85 Changes 1-4-17
;	RIMovement
;		Fixed a bug that would not land from flying if we were within correct distance of our FollowTarget
;	RI
;		Added stopfollowing to StopMove code
;	CombatBot
;		Removed behind/flanking checks since its now done in game (thanks dbg) - REVERTED as so did DBG
;		Fixed a bug that was reporting a few abilities as incorrect types

;v4.86 Changes 1-6-17
;	RI
;		Fixed an issue with the updater, added RI_Update command back in 

;v4.87 Changes 1-7-17
;	CombatBot
;		Added cb importogre as an alias for cb ogreimport
;	RI
;		Added RI_Var_Bool_SkipCheckToons global bool to skip full group checks with RunInstances
;	RunInstances 
;		Removed SkipCheckToons global bool and moved to RI so stays static with extension
;		Fixed a bug in Arcanna'Se Spire: Repository of Secrets that would pull the last nameds entire wing of trash at once

;v4.88 Changes 1-8-17
;	RA
;		removed auto loading of RI's ImportZoneFile function to import default WL zone file
;		Fixed a small bug related to loading
;	RunInstances
;		added auto loading of RI's ImportZoneFile function to import default WL zone file 
;			IF there is no zone file in the extension
;	CombatBot
;		Added Summon Mount to Export List for every toon so the 
;		ability can be added to the cast stack as a buff or noncombat buff
;	RI
;		Added SummonMount command for RIMUI and RIMUIObj

;v4.89 Changes 1-8-17
;	CombatBot
;		fixed a bug that would sometimes (rarely) get stuck in a loop of recasting summon mount

;v4.90 Changes 1-22-17
;	RunInstances
;		removed auto turn on/off of consuming drinks/potions
;		changed some backend code used in determining who is the main and who are not
;		added global boolean RI_Var_Bool_PauseMovement to pause all movement in RunInstances
;		Added The Frillik Tide (Early Alpha Release, please post bugs to Forums or Forge)
;			full zone completion in ~5mins
;		Added Xalgozian Stronghold [Solo]
;			includes killing the writ of war if you are on that quest
;		Tweaked Xalgozian Stronghold [Heroic]
;			Vihgoh 
;				Turned off All AE's and Encounters and Turned on Singular Focus/ Subtle Strikes
;			Tweaked pathing
;		Tweaked Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]
;			Timing
;			The Armor of Sul
;				Will move out of center when increments are gone
;		Tweaked Arcanna'se Spire: Repository of Secrets [Heroic]
;			Tabor'Zaai
;				Each toon does their own targeting
;		Tweaked Arcanna'se Spire: Forgotten Sanctum [Heroic]
;			Caelan'Gael
;				added crouch and walk for duration of fight
;		Tweaked The Crypt of Agony [Agnostic]
;			Pathing and timing
;	RZ
;		Fixed new zones for 6 hour timers
;	ShareMissions
;		Converted to new QuestJournalWindow System
;	DeleteMissions
;		Converted to new QuestJournalWindow System
;	Added RI_Transmute
;		Transmutes as per settings in ui
;	Added RI_Salvage
;		Salvages as per settings in ui
;	WriteLocs
;		Fixed a bug in Default ZoneFile Name when theres a ","
;	RIMovement 
;		Fixed a bug with Landing in RIFlyFollow
;	RIMobHud
;		updated to new actor query system
;	CombatBot
;		Fixed a bug that caused,when flying would not save profile
;		Added new methods to RI_Obj_CB
;			method DoNotCastAE(bool Enabled) - Will prevent the bot from casting AE's
;			method DoNotCastEncounter(bool Enabled) - Will prevent the bot from casting Encounter Spells's
;		Temporarily disabled summon mount in cast stack (you can still use the RimUI button)
;		Fixed Auto Attack Timing Object
;	RI_AbilityCheck
;		fixed a bug that was not tagging Unda Arcanus Spiritus and Dagger Storm as ae's
;	RA
;		Fixed a bug with loading zonefiles
;	RimUI
;		Added Buttons and Methods:
;			method UplinkConnect(string PCName)  - connects PCName to the uplink (make sure the firewall is allowing and in innerspace config the pcnames are set correctly and ports are correct)
; 			method UplinkList  - lists in the console all PC's connected to the uplink

;v4.91 Changes 1-24-17
;	RunInstances
;		Tweaked Arcanna'se Spire: Vessel of the Sorceress [Event Heroic]
;			Tweaked timing on Armor pull
;		Tweaked Arcanna'se Spire: Forgotten Sanctum [Heroic]
;			Fixed targeting bug with Lachina and Protectors
;		Added ZoneFile for The Frillik Tide
;	AbilityCheck
;		Added Summon: from Abilities Tab for Diety Pets

;v4.92 Changes 1-30-17
;	RimUI
;		Added Method and Button
;			method GuildBuffs(string ForWho=ALL) - Will click ToT and KA preorder clickie buffs with a 10s gap
;	RunInstances
;		Added Lost City of Torsis: The Shrouded Temple [Event Heroic]
;			pathing
;			CustomNameds:
;				Haze
;					will go kill your mirages (when they actually spawn)
;				Reaver
;					will go kill add for curse
;					will go get correct damage buff
;	WriteLocs
;		Added testrun command
;			will run the waypoints in the file, but ignore all other commands except wait
;				be careful this is not RI it doesnt do anything but run the zonefile
;				best to be done in an empty zone

;v4.93 Changes 1-31-17
;	RI_AggroControl
;		fixed a bug that was not accepting arguments
;	RunInstances
;		Lost City of Torsis: The Shrouded Temple [Event Heroic]
;			fixed zone file

;v4.94 Changes 1-31-17
;	RI
;		Added channeler to PreHeal command
;	RunInstances
;		Lost City of Torsis: The Shrouded Temple [Event Heroic]
;			fixed a bug that was prematurely ending the Haze fight when his Actor no longer Existed
;	CombatBot
;		fixed a bug that would sometimes cause abilities to double cast
;		fixed a bug with Beastlord that would sometimes cast a primal right after another when not at the correct savagery
;	RA
;		Fixed a bug that would sometimes cause the main not to run RI correctly or at the correct time

;v4.95 Changes 2-3-17
;	RI
;		GuildBuffs
;			fixed command to actually execute instead of echo, added a few more items and reduced the wait to 5s each
;		Reenabled Command
;			RI_Collection, usage RI_Collection Bag or RI_Collection Depot, will collect all collections in a depot or your bags that are not already collected
;		CoT
;			fixed a bug that would sometimes not engage the script
;		Potion/Food/Drink/Poision Replenish/AutoConsumer
;			updated to KA

;v4.96 Changes 2-3-17
;	RI
;		Fixed a bug in Potion/Food/Drink/Poision Replenish/AutoConsumer

;v4.97 Changes 2-4-17
;	RI_Transmute and RI_Salvage
;		Tweaked timing
;	CombatBot
;		Fixed a bug that was not Starting Heroic opp's when clicked

;v4.98 Changes 2-20-17
;	RI
;		Added the Following RI Commands:
;			RI UNLOAD	- Completely unloads extensions and all scripts 
;			RI UNLOADEXTENSION	- Completely unloads extensions and all scripts 
;			RI END (RIMUI,RIMOVEMENT,CB,RI,RIMOBHUD)	- Ends the pertaining script
;		Added (Now are persistent for entire time extension is loaded)
;			RI_Var_Bool_GrabShinys
;			RI_Var_Bool_WaitForShinys
;	WriteLocs
;		Fixed a bug that was not scrolling all the way down when adding an item to the listbox
;		Fixed an unneeded include bug
;	RunInstances
;		Added ability to run in any zone with your own ZoneFiles via ImportZoneFile command
;		Added RI_Var_Bool_BalanceTrash global BOOL - turns on/off RunInstances balancing of trash mob health
;		Arcanna'se Spire: Forgotten Sanctum [Heroic]
;			Fixed a bug on Caelan'Gael that would target charmed Protectors
;		Removed (Moved to RI)
;			RI_Var_Bool_GrabShinys
;			RI_Var_Bool_WaitForShinys
;	Combatbot:
;		RI_Obj_CB:
;			Added method CastWhileMoving(bool Enabled) - turns on and off casting while moving
;	RimUI
;		Added RIMUIObj Method's, Member's and *Button's
;			*method BalanceTrash(bool On)  - turns on/off RunInstances balancing of trash mob health 
;			*method InitializeFactions(string ForWho=ALL)  - Retrieves faction data from server
;			*method DisplayAllFactions(string ForWho=ALL)  - Displays all faction data, will retrieve data from server if doesn't exist
;			*method TravelMap(string ForWho=ALL, string ZoneName, int ZoneOption=0) - Clicks ZoneName on TravelMap and Zones there (case insesitive and partial zone names are fine)
;			*method TravelMapPop(string ForWho=ALL) - Opens a UserInput widow and Clicks Name entered on TravelMap and Zones there (case insesitive and partial zone names are fine)
;			*method ScribeBook(string ForWho=ALL, string BookName) - Scribes the recipe book if it exists in your inventory (case insesitive and partial book names are fine)
;			*method GuidedAscension(string ForWho=ALL) - Applies Guided Ascension if it exists in your inventory and is useable
;			member(bool) FactionsInitialized()  - TRUE if faction data exists, FALSE if not, if not will start initializing
;			member(string) FactionName(int _IndexPosition)  - Returns exact name and case of Faction as shown in game, -1 means no data exists and will start initializing
;			member(int) FactionAmount(string _FactionName)  - Returns amount of faction for given faction name (must be exact spelling, case does not matter), -1 means no data exists and will start initializing
;			member(string) FactionKOS(string _FactionName)  - Returns KOS of faction for given faction name (must be exact spelling, case does not matter), -1 means no data exists and will start initializing
;				!!!!!! If anyone would like an example script showing how these work, ask on irc or on the forums. !!!!!
;		Added Bell's to Zone Button

;v4.99 Changes 3-1-17
;	RI:
;		Added Large Ulteran Spire and Guild Portal Druid to Zone Button
;		Modified Zone button to only click the closest Actor in the list and not ALL
;		Fixed a bug in LootOptions
;	RunInstances:
;		Arcanna'Se Spire: Vessel of the Sorceress [Event Heroic]
;			Tweaked lockspot for Armor
;		Lost City of Torsis: Shrouded Temple [Event Heroic]
;			Turned off RI Balance Mobs 
;			The Meld of Haze:
;				Tweaked LockSpot and Pathing
;				Added - Toon with closest mirage will wait to kill till all the other mirages are dead and the furthest away group member is closer than my mirage.
;		Added Crypt of Dalnir: Baron's Workshop [Heroic] (Pathing not Available yet just Named Scripts)
;			Added Tootooz (RI Pull Tootooz)
;				will point
;			Added Googantuan (RI Pull Googantuan)  (Starts near first valve at -423 1 -195)
;				will move to all valves and close them, then campspot and fight
;			Added Enchanted Sword and Shield (RI Pull Enchanted) (Spawn Named's first or script will autoend)
;				will joust Sword's Curse and cure shields and swords immunities 
;			Added Haggle Baron Dalnir (RI Pull Baron) (Set group options to FreeForAll or LeaderOnly and Assign to Bard, and Engage fight then invoke pull command)
;				Lockspot for group, bard will get resources, craft and close the Forges
;	CombatBot:
;		Added the following RI_Obj_CB Member's:
;			member:int ConvertAbilityID(string _AbilityName) - returns the ID of the highest level of ability _AbilityName thats your level or lower
;			member:string ConvertAbility(string _AbilityName) - returns the Name of the highest level of ability _AbilityName thats your level or lower
;	RIMUI:
;		Added RIMUIObj Method's, Member's and *Button's
;			*method DisplayStats(... _Stats) - Displays stats passed in console (Stat must be Exact spelling, not Case sensitive)
;			member(string) DisplayStat(string _Stat) - Returns value of stat passed
;				available Stats:
;					Resolve,Fervor,AAXPModCap,TradeskillXPModCap,CombatXPModCap,AAXPMod,TradeskillXPMod,CombatXPMod,Lethality
;					LethalityPercent,PVPSpellDoubleAttack,Weapon_Damage_Bonus,SpellDoubleAttack,AbilityDoubleAttack
;					PvP_Critical_Mitigation,Defense_ToughnessPercent,Defense_Toughness,DPS,Run_Speed,Haste,Hate_Mod,Defense_Mitigation
;					Defense_MitigationPercent,Defense_Avoidance,Defense_AvoidanceBase,Defense_AvoidanceBlock,Defense_AvoidanceParry
;					CurrentStatus,LifetimeStatus,PowerRange,HealthRange,ConcentrationRange,Defense,Strength,Agility,Stamina,Intelligence
;					Wisdom,Physical,Elemental,Arcane,Noxious,Damage_Reduction_Physical,Damage_Reduction_Arcane,Damage_Reduction_Elemental
;					Damage_Reduction_Noxious,Damage_Reduction_Percentage_Physical,Damage_Reduction_Percentage_Arcane
;					Damage_Reduction_Percentage_Elemental,Damage_Reduction_Percentage_Noxious,Crit_Chance,Crit_Bonus,Ability_Mod,Potency
;					HP_Regen,Power_Regen,Double_Atk_Percent,Ranged_Double_Atk_Percent,AE_AutoAtk_Percent,Spell_Reuse_Spell_Only
;					Spell_Reuse_Percent,Spell_Cast_Percent,Spell_Recovery_Percent,Accuracy,Flurry,Critical_Mitigation,Shield_Effectiveness
;					Deflection_Chance,Primary_Damage_Range,Secondary_Damage_Range,Ranged_Damage_Range,Primary_Delay,Secondary_Delay
;					Ranged_Delay,Strikethrough,Houses,Dungeons

;4.991 Changes 3-7-17
;	RunInstances:
;		Added Expert Zones for Coded RI Zones
;	CombatBot
;		Fixed a bug that would not allow Ascension buffs to Cast
;		Fixed a bug that was incorrectly displaying some ability types
;		Fixed a range bug with Item Casting
;	AbilityCheck
;		Added Pathfinding Ability from AbilitiesTab
;	RI_Salvage
;		Fixed a bug that was not salvaging bag 4
;	RI_Transmute
;		Fixed a bug that was not transmuting bag 4
;	RunInstances & RI
;		Made some backend changes to allow for more robust code sharing

;4.992 Changes 3-8-17
;	RunInstances
;		Fixed a missing function bug

;v5.00 Changes 3-16-17
;	RI
;		Moved Debug Variable from RunInstances to RI to be global
;		Renamed Debug variable to RI_Var_Bool_Debug to help with conflicts with other scripts
;		Fixed a bug in TravelMap
;	RunInstances
;		Crypt of Dalnir: Baron's Workshop
;			Haggle Baron Dalnir
;				Changed order
;	RZ:
;		Reduced the Lockout Timers for Spire zones to 90minutes
;	CombatBot
;		Fixed RIE on Items
;	Added:
;		RI_Ascension - Moves to and hails your ascension trainer to level or get scrolls (needs Cae'Dal Star Star and Wizard Portal in Guild Hall within 5 and 15 meters respectively of the Door) (for now only works if completed sig line)
;		RQ - runs quests or entire timelines that have been coded. (needs Cae'Dal Star Star, Travel Bell, Druid Summoner and Wizard Portal in Guild Hall within 5 and 15 meters respectively of the Door)
;			Added:
;				Sokokar Crafting Timeline
;				The Captain's Lament
;				Terrors of Thalumbra Crafting Timeline
;				Kunark Ascending Crafting Timeline
;				Greenmist Timeline
;				Mending of a Broken Land 
;					A Message with Spirit
;					Into the Arena
;				The Never Ending Mending of a Broken Land (Repeatable)
;					More Message with Spirit (Repeatable)
;					Into the Arena (Repeatable)

;v5.01 Changes 3-24-17
;	RQ
;		Fixed a missing ZoneFile for Terrors of Thalumbra Crafting Timeline
;		Fixed a numerous amount of small bugs here and there, too many to list
;	AutoDeity
;		Will now spend points while in combat

;v5.02 Changes 3-25-17
;	RI
;		Changed the way RIMObj.Move handles stoping
;	RI_Ascension
;		Now handles movement for toons who have not completed the Sig Line.

;v5.03 Changes 3-30-17
;	RI
;		Fixed a bug with movement when in group with a merc
;	RI_Ascension
;		Fixed a bug that would cause geomancers to tweak out at the end of their line of movement
;	CombatBot
;		Fixed a bug in Announce that would announce casting even if you did not start casting ability
;		Added additional code to allow Etheral Conduit to be cast on a group member
;		Added Saving of Cast Verdict option for Inquisitors
;		Added Charm Control for Coercers and Troubadors on subclass tab
;		Fixed a bug that was resaving the Default Profiles every time CB was loaded
;	RunInstances
;		Lost City of Torsis: The Shrouded Temple [Event Heroic]
;			tweaked Meld of Haze
;			tweaked ZoneFile

;v5.04 Changes 4-23-17
;	RunInstances
;		Added Raid Mobs:
;			Slime (RI Pull Slime)
;				Jousts between 41.181149,-6.196420,-651.539246 and 48.976913,-6.196415,-647.433899 including tanks (releases tanks)
;			Black Reaver (RI Pull Blackreaver)
;				Jousts toon who has the detriment to the top of stairs and stays until gone	
;			Runelord Strathbone (RI Pull Runelord)
;				Targets self on curse
;			Chomp (RI Pull Chomp)		
;				Jousts between -323.196747,11.774687,317.118469 and -273.333435,11.774687,317.906952 including tanks (releases tanks)
;			Sentinel Primatious (RI Pull Primatious)
;				Jousts between -523.602600,11.180099,-56.043617 and -555.931274,11.180054,-25.864149 including tanks (releases tanks)
;				Targets self on correct curse
;		Added Lost City of Torsis: The Spectral Market [Heroic, Expert and Solo]
;			The Algae Fiend
;				Turning on Absorb Magic in Mage Profiles (make sure its actually in the profile)
;			Torsis Champion
;				Jousting
;			Ongnissim
;				Jousting
;			Pathing for entire zone
;		Added Lost City of Torsis: Reaver's Remnants [Heroic, Challenge Heroic, Expert, Expert Challenge and Solo]
;			Pathing for entire zone (no named coding exists yet)
;			Added handling of all quest elements for Kunark Ascending: Seeking Reassurance
;		Crypt of Dalnir: Baron's Workshop [Heroic, Expert, Solo]
;			Added Pathing for entire zone (grabbing the key must be done manually exept in Solo)
;			Added handling of all quest elements for Kunark Ascending: A Chosen Weapon
;		Crypt of Dalnir: Wizard's Den [Heroic, Expert, Solo]
;			Tweaked Nazkra
;				Solo zone will move closer to be able to pull her without a pet
;				Added turning off AE's and Turning on Singlar Focus
;			Added handling of all quest elements for Ghosts and Gooblins
;		Added Vaedenmoor Realm of Despair
;			Pathing for entire zone
;			Added handling of all quest elements for Kunark Ascending: A Nightmare Realized
;		Added Charasis: Maidens Chamber [Agnostic]
;			Pathing for entire zone
;			Added handling of all quest elements for Kunark Ascending: Resurrection Machination
;		Kaesora: Xalgozian Stronghold
;			Added handling of all quest elements for Kunark Ascending: Reading Assignment
;		Removed CoT from Main
;		Fixed a bug that was not pausing CoT when pausing RunInstances
;	CombatBot
;		Fixed some bugs in the Charmer function and added warden's ability
;		Fixed a bug that would rarely get some announce abilities in a death loop
;		Added Auto sharing of missions - Option on settings tab
;	RIMUI
;		Added Geomancer, Thaumaturgist, Etherealist, and Elementalist to ForWhoChecks
;		Added RIMUIObj Method's, Member's and *Button's
;			member ConvertAlias(string _AliasName)
;				Returns converted _AliasName to whats set in CombatBot (for usage in scripts and methods, etc)
;			*method SetMoveBehind(... args)
;				Sets MoveBehind options for CombatBot
;				Accepts an unlimited amount of args in sets of 4
;					string _ForWho, string _OnOffToggle, int _MoveHealth, bool _SkipMoveHealthCheck
;			*method SetMoveIn(... args)
;				Sets MoveIn options for CombatBot
;				Accepts an unlimited amount of args in sets of 4
;					string _ForWho, string _OnOffToggle, int _MoveHealth, bool _SkipMoveHealthCheck
;			*method SetMoveInFront(... args)
;				Sets MoveInFront options for CombatBot
;				Accepts an unlimited amount of args in sets of 4
;					string _ForWho, string _OnOffToggle, int _MoveHealth, bool _SkipMoveHealthCheck
;			*method RIPull(string _Named)
;				Engages RI scripting for Named specified
;			*method UplinkDisconnect(... args)  
;				Diconnects PC's from the uplink
;				Accepts an unlimited amount of args in sets of 1
;					string _PCName
;		Modified RIMUIObj Method's, Member's and *Button's
;			*method UplinkConnect(... args)  
;				now accepts an unlimited amount of args in sets of 1
;					string _PCName
;			*method Cast(... args)
;				now accepts an unlimited amount of args in sets of 3 
;					string _ForWho, string _CastSpellName, int _CancelCast
;			*method CastOn(... args)
;				now accepts an unlimited amount of args in sets of 4 
;					string _ForWho, string _CastOnSpellName, string _CastOnCastName, int _CancelCast
;			*method SetLockSpot(... args)
;				now accepts an unlimited amount of args in sets of 6
;					string ForWho, string X, float Y, float Z, int Min, int Max
;	RQ
;		Fixed a bug in Bathezids Watch Faction Crafting that was not creating the correct items.
;		Added the Kunark Ascending Adventure Timeline and all quests and instances required

;v5.05 Changes 5-14-17
;	CombatBot
;		Fixed a bug that was causing the bot to attempt to cast hostile's when no killtarget exists
;		Fixed a bug that would not share missions in expert zones
;		Disabled Auto Target Aggro Mobs in Qeynos and Freeport (will add rest later)
;		Fixed a bug that would not cast on players in Battlegrounds
;		Added loading of regular profile file in Battlegrounds
;		Modified CancelInvis after combat for Battlegrounds
;		Disabled FaceMob in Combat in Battlegrounds since AutoAttack is disabled
;		Disabled Item casting in Battlegrounds
;		Disabled Heroic Opps in Battlegrounds
;		Disabled all Scripted movement in Battlegrounds (Use in game follow)
;	RunInstances
;		Added Raid Mobs:
;			Shanaira the Prestigous (RI Pull Shanaira)
;				Jousts between 0.355797,4.718675,-7.988738 and 9.978826,5.179579,22.060690 when you have
;					either the ring of blaze or venom on mages
;				Targets your illusion
;				Targets swarm and then shanaira
;		Added RIMUIObj Method's, Member's and *Button's
;			*method SetUISetting(... args) (Currently only works for Checkboxes on the Settings tab (More soonish tm))
;				Sets UISettings for CombatBot
;				Accepts an unlimited amount of args in sets of 3
;					string _ForWho, string _SettingName, string _OnOffToggle
;			*method SetInGameFollow(... args)
;				Sets In Game Follow
;				Accepts an unlimited amount of args in sets of 2
;					string _ForWho, string _WhoToFollow
;	RIMovement
;		Fixed a bug that would not engage RIFlyFollow when out of range of In Game Follow
;		Disabled all Scripted movement in Battlegrounds (Use in game follow)

;v5.07 Changes 6-4-17
;	RIMUIObj Methods and Members
;		Fixed a bug in method Zone that was making it not function
;		Added
;			member:bool MaintainedEffectExists(string _MaintainedEffect)
;				will return TRUE if the _MaintainedEffect exists and is not hidden (accepts partial matches)
;		Modified
;			member:string DisplayStat
;			Method DisplayStat
;				Added alot more available stats:
;					
;	RunInstances
;		Crypt of Dalnir: Baron's Workshop
;			Added custom named:
;				The Frenzied Feeder (RI Pull Frenzied)
;					will kill Corpse Devourer's and Ravenous Gnasher's
;		Arcanna'se Spire: Forgotten Sanctum
;			Tweaked pathing and named pulling waypoints
;		Ssraeshza Temple: Inner Sanctum [Heroic]
;			Fixed all Pathing and Named Coding
;	CombatBot
;		Added pull pet back when mob is engaged and more than 15m away
;		Modified pet attack behavior when charm and possess essence are both active
;		Disabled annouces in battlegrounds
;		Added casting of summon_familiar upon death or if not maintained
;			if you do not have one equipped it will uncheck the setting on the settings tab
;		Fixed a bug that was not allowing the download of the default profiles when no profile exists
;		Disabled Face Mob in Combat while moving (if anyone has any qualms about this let me know)
;		Fixed a bug with beastlords and primals
;		Added toggle for beastlords to enable/disable Primal delay
;		Fixed a bug that would only use your regular server profiles inr PG's on Halls of Fate server, now should work on all
;	RI
;		Fixed a bug in CheckCombat that would sometimes cause a toon to fly up forever

;v5.08 Changes 6-6-17
;	RunInstances
;		Fixed a bug with looting

;v5.09 Changes 6-16-17
;	CombatBot
;		Added default profile for Skyshrine Guardian and abilities (Do abilitycheck after clearing when you have all the abilities)
;			you can also just download the Abiltycheck here http://www.isxri.com/skyshrineguardian-AbilityCheck.xml

;v5.10 Changes 6-16-17
;	CombatBot
;		Added Shed Skin as a Cure ability
;	RI
;		Disabled group invite auto accept in battlegrounds
;		Enabled RIMovement for Underfoot Depths PG

;v5.12 Changes 7-1-17
;	CombatBot
;		Changed disable of CB in Battlegrounds lobby to wait
;		Moved AutoDeity script to a function of CB
;		Added UI Settings options for AutoSpend Deity options
;		Modified Accept Loot routine to only trigger at best every 5s
;		Added Combat Awareness for Channelers to allow casting while moving
;		Reenabled Face Mob in Combat for Skyshrine Guardian and Infiltrator
;		Added default profile for Skyshrine Infiltrator and abilities (Do abilitycheck after clearing when you have all the abilities)
;			you can also just download the Abiltycheck here http://www.isxri.com/skyshrineinfiltrator-AbilityCheck.xml
;	RunInstances
;		Added The Underfoot Depths Proving Grounds
;			Complete pathing for Skyshrine Guardian
;		Modified Brokenskull Bay: Bilgewater Falls
;			Added solo and advanced solo
;			Added Sig Quest Elements
;		Modified Zavith'Loa: The Hidden Caldera
;			Added solo and advanced solo
;			Added Sig Quest Elements
;		Modified Accept Loot routine to only trigger at best every 5s
;		Modified Lost City of Torsis: Spectral Market
;			Tweaked Merchant Caniz
;		Modified Arcanna'se Spire: Forgotten Sanctum
;			Removed plundering of the chandeleir
;	RI
;		Moved RILooter to a function of RI
;		Fixed a bug that would save over the RIMUICustom.xml file everytime RIMUI was loaded
;		Added Command RPG
;			usage: RPG (Brings up the ui)
;				Loops Solo PG while cycling toons with login/out (toons must be in Proving Grounds lobby)
;					also recovers from zone lockups and client crashes

;v5.13 Changes 7-1-17
;	RI
;		Fixed a version bug

;v5.14 Changes 7-11-17
;	RI
;		Fixed a bug in Revive	
;		Tweaked Move function
;		Added Commands:
;			RI_GroupLogin or RGL
;				Auto logs in groups of toons based on settings in ui or args sent via command line 
;				(will also ensure you have enough sessions open if you are loaded via a ISBoxer Character Set)
;				usage: RGL (Brings up UI)
;				usage: RGL GroupAliasName (loads in group with corresponding group alias)
;				usage: RGL Toon1|Toon2|Toon3|Toon4|Toon5|Toon6 (auto loads in group in given order)
;	RQ
;		Added Shattered Seas Timeline
;	CombatBot
;		Fixed a bug that was not using the saved value for AutoDeity

;v5.16 Changes 8-22-17
;	RPG
;		Will now recover from drop to Character Select
;		Modified the lockout timer to 3 hours
;	RQ
;		Added:
;			City of Qeynos Timeline (Including Scout, Priest and Fighter Archetype Quests)
;			Heritage Quests:
;				A Source of Malediction
;				The White Dragonscale Cloak
;			Jarsath Wastes Timeline
;			Ning Yung Retreat Timeline
;			Order of Rime Faction Timeline
;			Othmir Cobalt Scar Timeline
;			Othmir EW Faction Timeline
;			Tears of Veeshan Timeline
;			Tower of the Four Winds Timeline
;	RI
;		Added Command:
;			RICharList
;				Script to edit and save your RICharList.xml file
;		Modified Command:
;			UseItem
;				only uses items in your inventory now
;			Invite
;				with no toon name arguments or just the ForWho argument passed it will invite all open 
;				logged in relayable toons to your group (works best with only 6 sessions logged in)
;	RunInstances
;		Lost City of Torsis: The Shrouded Temple
;			Modified pathing to help with getting stuck in a few spots
;		Arcanna'se Sprire: The Vessel of the Sorceress
;			Modified Sorceress
;				Added 4 lockspots and after 5s at each spot if a whirlwind is too close it will move
;	CombatBot
;		Added code to toggle ranged and melee auto attack when the game bugs and does not attack

;v5.17 Changes 8-23-17
;	RPG
;		Now correctly chooses Underdepths in Zone list.

;v5.18 Changes 8-23-17
;	RPG
;		Now will handle where the zone is reporting an expiration of 125 days 6 hours (to some extent, may not work for setting timers).

;v5.19 Changes 8-24-17
;	RPG
;		Now will handle where the zone is reporting an expiration of 125 days 6 hours (even for setting timers).

;v5.20 Changes 8-25-17
;	CombatBot
;		Fixed a bug that was ignoring disabled OnEvents status

;v5.21 Changes 8-29-17
;	RQ
;		Removed move to and loot chest (will still attempt to summon them)
;	RPG
;		Fixed zone expiration to coincide with DBG's fix for 125 days 6 hours bug.
;		Fixed portal location and added a check before moving to if portal exists in this location
;	RI
;		Added RIMUIObj Methods and Members
;			CheckEpic2PreReqs(string ForWho=ALL)
;				Lists epic 2 pre reqs for each archetype and whether they have been completed or not (excluding faction amount)

;v5.22 Changes 8-29-17
;	RI
;		Fixed RIMUIObj Methods and Members
;			CheckEpic2PreReqs(string ForWho=ALL)
;				fixed a bug

;v5.23 Changes 9-9-17
;	RI
;		Added command RI E2
;			will display your prereqs for epic 2.0
;	RPG
;		Fixed the location of the portal, Again

;v5.24 Changes 10-5-17
;	RI
;		Crypt of Dalnir: The Wizard's Den
;			Modified Nazkra
;				changed maintoon lockspot and added targeting for aggro
;		Lost City of Torsis: The Spectral Market
;			Ongnissim
;				Fixed a bug that was only reading fighters and not Main toons
;		Added the Following Instances:
;			Crypt of Dalnir Ritual Chamber
;				Pathing and Named Coding (Up until the 3 Linked Named)
;			Kaesora Tomb of the Venerated
;				Pathing and Named Coding
;			The Ruins of Cabilis
;				Pathing and Named Coding
;			Mistmyr Manor
;				Pathing
;			Ravenscale Repository
;				Pathing
;		RIMUIObj Members and Methods
;			Changed TravelMap
;				fixed a bug that was not reading the last zone in the list
;	RPG
;		Fixed a bug
;	RQ
;		Added the Following Quests/Timelines:
;				Dark Mail Guantlets HQ Timeline
;				An Eye for Power
;				A Strange Black Rock
;				Gogas Afadin
;				The Bone Bladed Claymore
;				The Symbol in the Flesh
;				Kurns Tower Access Timeline
;				The Mysteries of TikTok
;				Othmir Great Divide Timeline
;				Ry'Gorr Keep Timeline
;				Shades of Drinal Timeline
;				Koada'dal Magi's Craft

;v5.25 Changes 10-6-17
;	RI
;		RIMUIObj Members and Methods
;			Changed TravelMap
;				fixed a bug that was not opening portals
;	RQ
;		Added
;			The Circle of the Unseen Hand Timeline
;	RZ
;		Stopped group follow on MoveToZoneIn function

;	RZ
;		Completely rewrote RZ now can queue up any number of Zones and RZ will run them and move between them as needed and as queued. (Only KA for now)
;		RZO will handle pre-KA zones


variable(global) float RI_Var_Float_Version=5.25


;ri Script, Holds, all the things that need to happen all the time, this Starts with ISXRI and ends with it.
;10-15-15

variable(global) RIMUIObject RIMUIObj
variable(global) RIMovementObject RIMObj
variable string MySubClass=${Me.SubClass}
variable(global) string RI_Var_String_FlyUpKey=Home
variable(global) string RI_Var_String_FlyDownKey=End
variable(global) string RI_Var_String_StrafeLeftKey=q
variable(global) string RI_Var_String_StrafeRightKey=e
variable(global) string RI_Var_String_AutoRunKey=\"Num Lock\"
variable(global) string RI_Var_String_ForwardKey=w
variable(global) string RI_Var_String_BackwardKey=s
variable(global) string RI_Var_String_SwimUpKey=Home
variable(global) string RI_Var_String_SwimDownKey=End
variable(global) string RI_Var_String_JumpKey=space
variable(global) string RI_Var_String_CrouchKey=z
variable(global) string RI_Var_String_PotionName="Thaumic Elixir of "
variable(global) string RI_Var_String_Poison1Name="Exemplar's Hemotoxin"
variable(global) string RI_Var_String_Poison2Name="Expert Acidic Blast"
variable(global) string RI_Var_String_Poison3Name="Expert Ignorant Bliss"
variable(global) string RI_Var_String_Poison4Name="Expert Marked Target"
variable(global) string RI_Var_String_Poison5Name="Expert Warding Ebb"
variable(global) string RI_Var_String_FoodName="Stormborn Souffle"
variable(global) string RI_Var_String_DrinkName="Monsoon"
variable(global) bool RI_Var_Bool_Debug=FALSE
variable(global) bool RI_Var_Bool_AcceptTrades=TRUE
variable(global) bool RI_Var_Bool_SkipCheckToons=FALSE
variable(global) bool RI_Var_Bool_SkipLoot=FALSE
variable(global) bool RI_Var_Bool_BalanceTrash=TRUE
variable(global) bool RI_Var_Bool_GrabShinys=TRUE
variable(global) bool RI_Var_Bool_WaitForShinys=FALSE
variable(global) index:string RI_Index_String_AvailableRIMUICommands
variable(global) index:string RI_Index_String_AvailableRIMUICommandsDescription
variable(global) bool RI_Var_Bool_CancelMovement=FALSE
variable(global) bool RI_Var_Bool_PauseMovement=FALSE
variable(global) bool RI_Var_Bool_GlobalOthers=FALSE
variable(global) bool RI_Var_Bool_Start=FALSE
variable(global) bool RI_Var_Bool_Paused=FALSE
variable(global) string RI_Var_String_RelayGroup=NONE
variable(global) string RI_Var_Int_RelayGroupSize=0

variable string RI_Var_String_ButtonToChange
variable string RI_Var_String_ButtonChangeOriginalCommand
variable bool TradePending=FALSE
variable bool TradeAccepted=FALSE
variable bool IStartedTrade=FALSE
;RIMovementUI by Herculezz v1
;
;for GuildStrategist use 10m distance2d
;
variable bool LoadRIMUI=FALSE
variable bool RIMUILoaded=FALSE
variable bool CommandQ=FALSE
variable bool RIFP=FALSE
variable bool RILSP=FALSE
variable bool ASSP=FALSE
variable bool DOORP=FALSE
variable bool TMP=FALSE
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
variable bool NearesetNPCHudLoaded=FALSE
variable bool NearesetPlayerHudLoaded=FALSE
variable bool RaidGroupHudLoaded=FALSE
variable string Size=Small
variable settingsetref Set
variable bool boolNameOnlyButton=FALSE
variable bool FactionsInit=FALSE
variable string FactionsPass=NONE
variable string CurrentZoneName="${Zone.Name}"
variable index:string GroupNames
;end variables for RIMUI

function main()
{
	;disable RI_Var_Bool_Debugging
	Script:DisableDebugging
	
	RI_Index_String_AvailableRIMUICommands:Insert[AcceptReward]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Accept Reward - Accepts pending reward (for rewards with options it simply closes the window until you zone again)\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[AssistPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[AssistPop - Pops up the Assist UI]
	RI_Index_String_AvailableRIMUICommands:Insert[ApplyVerb]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ApplyVerb - execute's eq2's Apply Verb command\n\nArgument 1: For Who\nArgument 2: Actor Name or ID\nArgument 3: Verb]
	RI_Index_String_AvailableRIMUICommands:Insert[Assist]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Assist - Turns on/off assisting dynamically and sets assist name\n\nArgument 1: For Who\nArgument 2: 1=On 0=Off\nArgument 3: Assist Name (Optional)]
	RI_Index_String_AvailableRIMUICommands:Insert[AutoRun]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Auto Run - Presses auto run key\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[BalanceTrash]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[BalanceTrash - Turns on/off Balancing of trash mobs with RunInstances (must be done on Main session aka Tank)]
	RI_Index_String_AvailableRIMUICommands:Insert[CancelAllMaintained]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[CancelAllMaintained - Cancels all Maintained Abilities\n\nArgument 1: For Who]
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
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[DoorPop - Pops up the DoorOption UI]
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
	RI_Index_String_AvailableRIMUICommands:Insert[Flag]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Flag - Takes/Gets a Flag from the closest Guild Strategist\n\nArgument 1: ForWho\nArgument 2: Get/Take]
	RI_Index_String_AvailableRIMUICommands:Insert[FoodDrinkConsume]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[FoodDrinkConsume - Toggles the consumption of your equiped food and drink\n\nArgument 1: For Who\nArgument 2: 1=On or 0=Off]
	RI_Index_String_AvailableRIMUICommands:Insert[FoodDrinkReplenish]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[FoodDrinkReplenish - Replenishes raid food and drink from the nearest FoodDrink depot\n\nArgument 1: For Who]
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
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LockSpotPop - Pops up the SetLockSpot UI]
	RI_Index_String_AvailableRIMUICommands:Insert[LootOptions]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[LootOptions - Change groups loot options\n\nArgument 1: For Who\nArgument 2: Option\nLEADERONLY / LO\nFREEFORALL / FFA\nLOTTO / L\nNEEDBEFOREGREED / NBG\nROUNDROBIN/ RR]
	RI_Index_String_AvailableRIMUICommands:Insert[Mentor]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Mentor - Mentors player\n\nArgument 1: For Who\nArgument 2: Player Name (\\$ {Target} works)]
	RI_Index_String_AvailableRIMUICommands:Insert[MoveTo]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[MoveTo - Moves to a Loc\nAccepts Unlimited Arguments in Sets of 5\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: X\nArgument 3: Y\nArgument 4: Z\nArgument 5: Precision]
	RI_Index_String_AvailableRIMUICommands:Insert[MultipleCommands]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[MultipleCommands - Executes multiple commands all in the same frame\n\nArgument 1: ForWho\nArguments 2+: Unlimited number of commands (eq2ex commands, isxeq2 commands or even any of the commands from RIMUI or ISXRI)]
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
	RI_Index_String_AvailableRIMUICommands:Insert[ResumeBot]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResumeBot - Resumes whatever compatible bot you are running\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[ResumeRI]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResumeRI - Resumes RI\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[ResumeRIM]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ResumeRIM - Resumes RIMovement\n\nArgument 1: For Who\n]
	RI_Index_String_AvailableRIMUICommands:Insert[Revive]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[Revive - Revives at junction 0\n\nArgument 1: For Who]
	RI_Index_String_AvailableRIMUICommands:Insert[RIFollowChange]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RIFollowChange - Changes min of RIFollow\n\nArgument 1: For Who (Default: ALL)\nArgument 2: Change(#)]
	RI_Index_String_AvailableRIMUICommands:Insert[RIFollowPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RIFollowPop - Pops up the RIFollow UI]
	RI_Index_String_AvailableRIMUICommands:Insert[RunScript]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[RunScript - Runs a script\n\nArgument 1: For Who\nArgument 2: Script Name]
	RI_Index_String_AvailableRIMUICommands:Insert[ScribeBook]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[ScribeBook - Scribes the recipe book if it exists in your inventory (case insesitive and partial book names are fine\n\nArgument 1: For Who\n\nArgument 2: Book Name]
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
	RI_Index_String_AvailableRIMUICommands:Insert[SetInGameFollow]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[SetInGameFollow - Turns on In Game Follow\n\nAccepts Unlimited Arguments in Sets of 2\nALL ARGUMENTS REQUIRED:\nArgument 1: For Who\nArgument 2: Who to follow]
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
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[TravelMap - Clicks Argument2 on TravelMap and Zones there\n\nArgument 1: For Who\n\nArgument 2: Zone Name (case insesitive and partial zone names are fine)\n\nArgument 3: Door Option (0 chooses Bottom option)\n\nArgument 4: Open Portal / Bell=1 Wizard=2 Druid=3]
	RI_Index_String_AvailableRIMUICommands:Insert[TravelMapPop]
	RI_Index_String_AvailableRIMUICommandsDescription:Insert[TravelMapPop - Pops up the TravelMap UI]
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
	
	Event[EQ2_onChoiceWindowAppeared]:AttachAtom[EQ2_onChoiceWindowAppeared]
	Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
	Event[EQ2_onQuestOffered]:AttachAtom[EQ2_onQuestOffered]
	
	while 1
	{
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
			
			;if a chest exists within 8m radius and looting is on
			if ${RI_Var_Bool_Loot} || ( ${UIElement[SettingsLootingCheckBox@SettingsFrame@CombatBotUI].Checked} && ${UIElement[SettingsLootChestsCheckBox@SettingsFrame@CombatBotUI].Checked} )
			{
				if ${Script[Buffer:RunInstances](exists)} && !${RI_Var_Bool_Loot}
				{
					noop
				}
				else
				{
					if ${Actor[chest,radius,8](exists)}
					{
						if ${RI_Var_Bool_Debug}
							echo ISXRI: ${Time}: Looting ${Actor[chest,radius,7]} because Loot: ${RI_Var_Bool_Loot}
						
						;doubleclick chest wait 2 then loot all
						Actor[chest,radius,7]:DoubleClick
						wait 2
						LootWindow:LootAll
					}
				}
			}
		}
		;wait 1 ${MT} || ${JU} || ${QueuedCommands} || ${FactionsInit} || ${CommandQ} || ${TradePending} || ${RaidGroupHudLoaded} || ${NearesetNPCHudLoaded} || ${NearesetPlayerHudLoaded} || ${CurrentZoneName.NotEqual["${Zone.Name}"]}
		if ${RIFP}
			call RIFollowPop
		if ${RILSP}
			call RILockSpotPop
		if ${ASSP}
			call AssistPop
		if ${DOORP}
			call DoorPop
		if ${TMP}
			call TravelMapPop
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
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
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
	if ${ChoiceWindow.Text.GetProperty[Text].Find[cast]} && ${Me.Health}<1 && ( !${Script[Buffer:CombatBot](exists)} || ${UIElement[SettingsAcceptRessesCheckBox@SettingsFrame@CombatBotUI].Checked} )
	{
		ChoiceWindow:DoChoice1
	}
	;put code in here to search through richarlist.xml
	if ${EQ2.ServerName.NotEqual[Battlegrounds]} && ${ChoiceWindow.Text.GetProperty[Text].Find["has invited you to join a"]} && ( !${Script[Buffer:CombatBot](exists)} || ${UIElement[SettingsAcceptInvitesCheckBox@SettingsFrame@CombatBotUI].Checked} )
	{
		ChoiceWindow:DoChoice1
	}
	if ${ChoiceWindow.Text.GetProperty[Text].Find["would you like to teleport to"]}
	{
		ChoiceWindow:DoChoice1
	}
	if ${ChoiceWindow.Text.GetProperty[Text].Find["would you like to loot"]} && ( !${Script[Buffer:CombatBot](exists)} || ${UIElement[SettingsAcceptLootCheckBox@SettingsFrame@CombatBotUI].Checked} )
	{
		ChoiceWindow:DoChoice1
	}
}
atom EQ2_onQuestOffered(string Name, string Description, int Level, int StatusReward)
{
	if ${Script[${RI_Var_String_CombatBotScriptName}](exists)} || ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
	{
		TimedCommand 3 RewardWindow:Receive
		;TimedCommand 3 RewardWindow:Accept
		TimedCommand 5 EQ2:AcceptPendingQuest
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
			wait 2
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
	function CheckCombat(bool FollowAfter=FALSE)
	{
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting CheckCombat
		variable bool _IWasFlying=FALSE
		if (${Me.InCombat} || ${Me.IsHated}) && ${RI_Var_Bool_Start} && !${RI_Var_Bool_GlobalOthers}
		{
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
				relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[ALL,${Me.X},${Me.Y},${Me.Z},${Precision},100]
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
		if ${IGFollow} && !${RI_Var_Bool_GlobalOthers}
			relay "other ${RI_Var_String_RelayGroup}" -noredirect eq2execute follow ${Me.Name}
		elseif ${SFollow} && !${RI_Var_Bool_GlobalOthers}
		{
			; if ${ISXOgre(exists)}
				; relay ${RI_Var_String_RelayGroup} -noredirect OgreBotAtom a_QueueCommand DoNotMove
			relay "${RI_Var_String_RelayGroup}" RIMUIObj:SetLockSpot[OFF]
			;relay ${RI_Var_String_RelayGroup} -noredirect RI_Atom_SetLockSpot OFF
			relay "other ${RI_Var_String_RelayGroup}" -noredirect RIMUIObj:SetRIFollow[ALL,${Me.Name},${Distance},100]
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
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Checking For Chests within 100 Radius
		;if we find a chest and can run to it, do so and loot
		if ${Actor["Treasure Chest",radius,100].Name.EqualCS["Treasure Chest"]} && ${Math.Distance[${Actor["Treasure Chest",radius,100].Loc},${Me.Loc}]}>5
			return
		if ${Actor[Chest,radius,100](exists)} && !${Me.IsSwimming} && !${Me.FlyingUsingMount}
		;&& !${Me.CheckCollision[${Actor[Chest].X},${Actor[Chest].Z}]}
		{
			;stop moving
			press -release ${RI_Var_String_ForwardKey}

			;chest's id
			variable int ChestID=${Actor[Chest,radius,100].ID}
			
			;if ChestID is 0 leave function
			if ${ChestID}==0
				return
				
			if ${RI_Var_Bool_Loot}
			{
				;first try to summon chest, if we are not flying, and chest is more than 7m away
				if !${Me.FlyingUsingMount} && ${Math.Distance[${Me.Loc},${Actor[${ChestID}].Loc}]}>7
				{
					eq2ex apply_verb ${ChestID} Summon
					wait 10
				}
				
				;if the chest is not within 7m, move to it
				if ${Actor[${ChestID}](exists)} && ${Math.Distance[${Me.Loc},${Actor[${ChestID}].Loc}]}>7 && !${RI_Var_Bool_QuestMode}
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
			}
			else
			{
				while ${Actor[Chest,radius,100](exists)}
					wait 1
			}
		}
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Ending LootChest
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
		
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Starting CheckShiny
		ShinyID:Set[${Actor[Query, Name=-"?" && Distance<=${ShinyScanDistance}].ID}]
		
		if !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${Actor[${ShinyID}].X},${Math.Calc[${Actor[${ShinyID}].Y}+2]},${Actor[${ShinyID}].Z}]}
		{
			if ${RI_Var_Bool_Debug}
				echo ${Time}: Shiny is close enough being ${Actor[${ShinyID}].Distance}
			press -release ${RI_Var_String_ForwardKey}
			Actor[id,${ShinyID}]:DoTarget
			wait 1
			if ${Me.TargetLOS}
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Shiny is in LOS
				wait 2
				TempX:Set[${Me.X}]
				TempY:Set[${Me.Y}]
				TempZ:Set[${Me.Z}]
				wait 5
				call This.Move ${Actor[${ShinyID}].X} ${Math.Calc[${Actor[${ShinyID}].Y}+0.01]} ${Actor[${ShinyID}].Z} ${Precision} 10 FALSE TRUE TRUE FALSE TRUE
				declare count int 0
				for (count:Set[1];${count}<50;count:Inc)
				{
					call This.CheckCombat
					wait 1
				}
				;target shiney click it and lootall
				if ${RI_Var_Bool_WaitForShinys}
				{
					while ${Actor[id,${ShinyID}](exists)}
						wait 50
				}
				else
				;if ${Developer}
				{
					relay ${RI_Var_String_RelayGroup} -noredirect Actor[id,${ShinyID}]:DoTarget
					waitframe
					relay ${RI_Var_String_RelayGroup} -noredirect Actor[id,${ShinyID}]:DoubleClick
				}
				; else
				; {
					; Actor[id,${ShinyID}]:DoTarget
					; waitframe
					; Actor[id,${ShinyID}]:DoubleClick
				; }
				wait 10
				LootWindow:LootAll
				;wait 20
				wait 50
				;
				;;;;;
				call This.Move ${TempX} ${TempY} ${TempZ} ${Precision} 10 TRUE TRUE TRUE FALSE TRUE
			}
			else
			{
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Shiny not in LOS
				eq2ex target_none
			}
		}
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
		if ( ${Me.Group[1].Distance}>60 && ${Me.Group[1].Type.Equal[PC]} ) || ( ${Me.Group[2].Distance}>60 && ${Me.Group[2].Type.Equal[PC]} ) || ( ${Me.Group[3].Distance}>60 && ${Me.Group[3].Type.Equal[PC]} ) || ( ${Me.Group[4].Distance}>60 && ${Me.Group[4].Type.Equal[PC]} ) || ( ${Me.Group[5].Distance}>60 && ${Me.Group[5].Type.Equal[PC]} )
		{
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
		while ( ${Me.Group[1].Distance}>60 && ${Me.Group[1].Type.Equal[PC]} ) || ( ${Me.Group[2].Distance}>60 && ${Me.Group[2].Type.Equal[PC]} ) || ( ${Me.Group[3].Distance}>60 && ${Me.Group[3].Type.Equal[PC]} ) || ( ${Me.Group[4].Distance}>60 && ${Me.Group[4].Type.Equal[PC]} ) || ( ${Me.Group[5].Distance}>60 && ${Me.Group[5].Type.Equal[PC]} )
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
	member(bool) AllGroupWithinRange(_Distance)
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
	function Move(float X1, float Y1, float Z1, int MPrecision=2, int PauseLength=0, bool ClearTarget=FALSE, bool StopForCombat=FALSE, bool SkipCheck=TRUE, bool KeepMoving=FALSE, bool UseRI_Var_String_ForwardKey=TRUE, bool SkipCollisionCheck=FALSE)
	{
		variable string _Zone=${Zone.Name}
		variable int _Precision=${MPrecision}
		variable int _LastFaceTime=0
		RIMUIObj:SetLockSpot[OFF]
		if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
			MPrecision:Set[${Math.Calc[${_Precision}+2]}]
		else
			MPrecision:Set[${_Precision}]
		if ${RI_Var_Bool_Debug}
			echo ISXRI: ${Time}: Moving : Move(float X1=${X1}, float Y1=${Y1}, float Z1=${Z1}, int MPrecision=${MPrecision}, int PauseLength=${PauseLength}, bool ClearTarget=${ClearTarget}, bool StopForCombat=${StopForCombat}, bool SkipCheck=${SkipCheck}, bool KeepMoving=${KeepMoving}, bool UseRI_Var_String_ForwardKey=${UseRI_Var_String_ForwardKey}=TRUE, bool SkipCollisionCheck=${SkipCollisionCheck}=FALSE)	
		;check for a Shiny if set
		if ${RI_Var_Bool_GrabShinys} && !${RI_Var_Bool_QuestMode} && ${StopForCombat} && !${SkipCheck} && !${RI_Var_Bool_GlobalOthers} && ${Actor[?,radius,${ShinyScanDistance}](exists)}
		{
			if ( !${Actor[NamedNPC,radius,50](exists)} || ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}>10 ) && ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Me.Y}]}<3
			{
				ShinyID:Set[${Actor[?,radius,${ShinyScanDistance}].ID}]
				if ${RI_Var_Bool_Debug}
					echo ${Time}: Closest Shiny ID: ${ShinyID} @ ${Actor[${ShinyID}].X} ${Actor[${ShinyID}].Y} ${Actor[${ShinyID}].Z} Which is ${Actor[${ShinyID}].Distance} Away
				;press -release ${RI_Var_String_ForwardKey}
				call This.CheckShiny
			}
		}
		if ${X1}==0 && ${Y1}==0 && ${Z1}==0
		{
			;echo ${Time}: Our movement position is 0,0,0, skipping, please check to make sure this is intended.
			return
		}
		if ${RI_Var_Bool_Debug}
			echo \${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}=${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<200 && ( Collision=${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}!${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${X1},${Math.Calc[${Y1}+2]},${Z1}]} || ${SkipCollisionCheck} || ${RI_Var_Bool_QuestMode} )
		if ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<200 && ( !${EQ2.CheckCollision[${Me.X},${Math.Calc[${Me.Y}+2]},${Me.Z},${X1},${Math.Calc[${Y1}+2]},${Z1}]} || ${SkipCollisionCheck} || ${RI_Var_Bool_QuestMode} )
		{
			_LastFaceTime:Set[0]
			if ${RI_Var_Bool_Debug}
				echo In If Statement
			;pause a bit before each move
			wait ${PauseLength}
			if ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
			{
				;echo we are there lets stop flying up or down
				press -release ${RI_Var_String_FlyUpKey}
				press -release ${RI_Var_String_FlyDownKey}
				;wait 1
			}
			if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
				MPrecision:Set[${Math.Calc[${_Precision}+1]}]
			else
				MPrecision:Set[${_Precision}]
			;check distance from my current x,z position vs the predetermined x,z positions
			;if larger than the precision move
			
			if ${RI_Var_Bool_Debug}
				echo ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>${MPrecision} && ${RI_Var_Bool_Start} && !${RI_Var_Bool_CancelMovement} && "${_Zone}" "${Zone.Name}" // ${_Zone.Equal["${Zone.Name}"]}
			while ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]}<200 && ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}>${MPrecision} && ( ${RI_Var_Bool_Start} || !${Script[${RI_Var_String_RunInstancesScriptName}](exists)} ) && !${RI_Var_Bool_CancelMovement} && ${_Zone.Equal["${Zone.Name}"]}
			{
				if ${EQ2.Zoning}!=0
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					press -release ${RI_Var_String_ForwardKey}
					wait 5
					continue
				}
				if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
					MPrecision:Set[${Math.Calc[${_Precision}+1]}]
				else
					MPrecision:Set[${_Precision}]
				;echo ${Time}: move while
				if ${Zone.Name.Equal[The Frillik Tide]}
					call This.FrillikCheck
				;check toons
				if !${SkipCheck}
					call This.checktoons
				;check if we are paused
				call This.CheckPause
				if ${RI_Var_Bool_Debug}
					echo ${Time}: We are at ${Me.X} ${Me.Y} ${Me.Z} which is ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} away from ${X1},${Y1},${Z1} and the precision is set to ${MPrecision}
				;check if in combat
				if ${StopForCombat}
					call This.CheckCombat
				;clear target while moving
				if ${Target(exists)} && ${ClearTarget} && !${RI_Var_Bool_GlobalOthers}
					eq2execute target_none
				;Follow
				if ${RI_Var_Bool_Follow} && !${RI_Var_Bool_GlobalOthers} && !(${Me.InCombat} || ${Me.IsHated})
					call This.follow
				;check for a Shiny if set
				if ${RI_Var_Bool_GrabShinys} && !${RI_Var_Bool_QuestMode} && ${StopForCombat} && !${SkipCheck} && !${RI_Var_Bool_GlobalOthers} && ${Actor[?,radius,${ShinyScanDistance}](exists)}
				{
					if ( !${Actor[NamedNPC,radius,50](exists)} || ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Actor[NamedNPC,radius,50].Y}]}>10 ) && ${Math.Distance[${Actor[?,radius,${ShinyScanDistance}].Y},${Me.Y}]}<3
					{
						ShinyID:Set[${Actor[?,radius,${ShinyScanDistance}].ID}]
						if ${RI_Var_Bool_Debug}
							echo ${Time}: Closest Shiny ID: ${ShinyID} @ ${Actor[${ShinyID}].X} ${Actor[${ShinyID}].Y} ${Actor[${ShinyID}].Z} Which is ${Actor[${ShinyID}].Distance} Away
						;press -release ${RI_Var_String_ForwardKey}
						call This.CheckShiny
					}
				}
				if !${SkipCheck} && !${RI_Var_Bool_GlobalOthers} && !${RI_Var_Bool_SkipLoot}
					call This.LootChest
				;first check our height if farther than ${Precision} away press and hold space as long as we are flying
				;we need to get to the correct height for current position we are ${Math.Distance[${Me.Y},${YHeight}]} away
				;check if we are even flying at all, if not start flight
				;echo if !${Me.FlyingUsingMount} && ${Math.Distance[${Me.Y},${Y1}]}>20 && !${Me.InCombat} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				if !${Me.FlyingUsingMount} && ${Me.Y}<${Y1} && ${Math.Distance[${Me.Y},${Y1}]}>20 && !${Me.InCombat} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				{
					press -hold ${RI_Var_String_FlyUpKey}
					wait 1
					press -release ${RI_Var_String_FlyUpKey}
				}
				;now check if we are above or below desired height
				if ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}>${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -hold ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;above move up
				elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}<${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyDownKey}
					press -hold ${RI_Var_String_FlyUpKey}
					;wait 1
				}
				;below move down
				elseif ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;face x,y,z position and press autorun key if my heading is more than 1degree off of what its supposed to be  ${Math.Calc[${Me.Heading}-1]}<${Me.HeadingTo[${X1},${Me.Y},${Z1}]}<${Math.Calc[${Me.Heading}+1]}
				; if !${Input.Button[${PauseMovementKey}].Pressed} && ${Script.RunningTime}>${Math.Calc[${_LastFaceTime}+500]}
				; {
					; _LastFaceTime:Set[${Script.RunningTime}]
					; Face ${X1} ${Z1}
				; }
				;if !${Input.Button[${PauseMovementKey}].Pressed} && ${Math.Distance[${Me.Heading},${Me.HeadingTo[${X1},${Me.Y},${Z1}]}]}>1
				;{
					;echo ${Time.SecondsSinceMidnight}: my heading is off facing
					Face ${X1} ${Z1}
				;}
				;{
				;	_LastFaceTime:Set[${Script.RunningTime}]
				;	Face ${X1} ${Z1}
				;}
				if !${Me.IsMoving} && !${Input.Button[${PauseMovementKey}].Pressed} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
				{
					;echo pressing autorun
					press ${RI_Var_String_AutoRunKey}
					wait 2
				}
				if ${Me.IsMoving} && ${Input.Button[${PauseMovementKey}].Pressed} && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
					call This.StopAutoRun
				if ${UseRI_Var_String_ForwardKey} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement} && !${Me.FlyingUsingMount} && !${Me.IsSwimming}
					press -hold ${RI_Var_String_ForwardKey}
				if ${UseRI_Var_String_ForwardKey} && ( ${Input.Button[${PauseMovementKey}].Pressed} || ${RI_Var_Bool_PauseMovement} ) && !${Me.FlyingUsingMount} && !${Me.IsSwimming}
					press -release ${RI_Var_String_ForwardKey}
				if ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
					press -release ${RI_Var_String_ForwardKey}
				;execute queued commands
				call This.ExecuteQueued
				wait 5 ( ${Math.Distance[${Me.Heading},${Me.HeadingTo[${X1},${Me.Y},${Z1}]}]}>1 || ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}<=${MPrecision} )
				; if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
					; wait 2
				; else
					; waitframe
			}
			if ${Math.Distance[${Me.Y},${Y1}]}>5 && ( !${UseRI_Var_String_ForwardKey} || ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) )
			{
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
			}
			if ${Math.Distance[${Me.Y},${Y1}]}>5 && !${UseRI_Var_String_ForwardKey} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
			{
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
				press ${RI_Var_String_BackwardKey}
			}
			elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${UseRI_Var_String_ForwardKey} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
				press -release ${RI_Var_String_ForwardKey}
			
			if ${RI_Var_Bool_Debug}
				echo ${Math.Distance[${Me.Y},${Y1}]}>5 && ( ${Me.FlyingUsingMount} || ( ${Me.IsSwimming} && ${Me.Y}>${Y1} ) || ( ${Me.IsSwimming} && ${Me.Y}<${Y1} && ${Me.WaterDepth}<1 ) ) && ${RI_Var_Bool_Start} && ${_Zone.Equal["${Zone.Name}"]}
				
			if !${Me.FlyingUsingMount} && ${Me.Y}<${Y1} && ${Math.Distance[${Me.Y},${Y1}]}>25 && !${Me.InCombat} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
			{
				press -hold ${RI_Var_String_FlyUpKey}
				wait 1
				press -release ${RI_Var_String_FlyUpKey}
			}	
				
			while ${Math.Distance[${Me.Y},${Y1}]}>5 && ( ${Me.FlyingUsingMount} || ( ${Me.IsSwimming} && ${Me.Y}>${Y1} ) || ( ${Me.IsSwimming} && ${Me.Y}<${Y1} && ${Me.WaterDepth}<1 ) ) && ${RI_Var_Bool_Start} && ${_Zone.Equal["${Zone.Name}"]}
			{
				if ${EQ2.Zoning}!=0
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					press -release ${RI_Var_String_ForwardKey}
					wait 5
					continue
				}
				;echo flyup or down only while
				;check if we are paused
				call This.CheckPause
				;check if in combat
				if ${StopForCombat}
					call This.CheckCombat
				;first check our height if farther than ${Precision} away press and hold space as long as we are flying
				;we need to get to the correct height for current position we are ${Math.Distance[${Me.Y},${YHeight}]} away
				;check if we are even flying at all, if not start flight
				if !${Me.FlyingUsingMount} && ${Me.Y}<${Y1} && ${Math.Distance[${Me.Y},${Y1}]}>25 && !${Me.InCombat} && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				{
					press -hold ${RI_Var_String_FlyUpKey}
					wait 1
					press -release ${RI_Var_String_FlyUpKey}
				}
				;now check if we are above or below desired height
				if  ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}>${Y1} && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyUpKey}
					press -hold ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				;above move up
				elseif ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Me.Y}<${Y1} && ( ${Me.FlyingUsingMount} || ( ${Me.IsSwimming} && ${Me.WaterDepth}<1 ) ) && !${Input.Button[${PauseMovementKey}].Pressed} && !${RI_Var_Bool_PauseMovement}
				{
					press -release ${RI_Var_String_FlyDownKey}
					press -hold ${RI_Var_String_FlyUpKey}
					;wait 1
				}
				;below move down
				elseif ${Math.Distance[${Me.Y},${Y1}]}<5 && ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && !${KeepMoving}
				{
					;echo we are there lets stop flying up or down
					press -release ${RI_Var_String_FlyUpKey}
					press -release ${RI_Var_String_FlyDownKey}
					;wait 1
				}
				wait 5 ${Math.Distance[${Me.Y},${Y1}]}<=5
				; if ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} )
					; wait 2
				; else
					; waitframe
			}
			;stop flying up or down
			if !${KeepMoving}
			{
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
			;press autorun key (stop move)
			; if ${UseRI_Var_String_ForwardKey} && !${Me.FlyingUsingMount} && !${Me.IsSwimming}
			; {
				; if !${KeepMoving}
					; press -release ${RI_Var_String_ForwardKey}
				; elseif ( ${Me.FlyingUsingMount} || ${Me.IsSwimming} ) && ( ${Math.Distance[${Me.Y},${Y1}]}>5 && ${Math.Distance[${Me.X},${Me.Z},${X1},${Z1}]}<${MPrecision} )
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
			if ${RI_Var_Bool_Debug} 
				echo ${Time}: We are ${Math.Distance[${Me.X},${Me.Y},${Me.Z},${X1},${Y1},${Z1}]} away from ${X1} ${Y1} ${Z1} and our Collision Check is ${Me.CheckCollision[${Me.X},${Me.Y},${Me.Z},${X1},${Y1}${Z1}]}
			; if ${Me.IsMoving} && !${UseRI_Var_String_ForwardKey}
				; call This.StopAutoRun
			; elseif ${UseRI_Var_String_ForwardKey} || ( !${Me.FlyingUsingMount} && !${Me.IsSwimming} )
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
		RIMUIObj:TravelMap[${Me.Name},${_ZoneToZoneName},${_ZoneOption}]
		if ${_ZoneOption}==-1
		{
			wait 600 ${Me.IsMoving}
			wait 600 !${Me.IsMoving}
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
objectdef RIMUIObject
{
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
	method CheckEpic2PreReqs(string _ForWho=ALL)
	{
		if !${This.ForWhoCheck[${_ForWho}]}
			return
		variable bool CTD=0
		variable bool SS=0
		switch ${Me.Archetype}
		{	
			case mage
			{
				echo ISXRI: ${Me.Name}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Kaedrin's Fate](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Your Eternal Reward](exists)}]}
					CTD:Set[1]
				if ${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Dethknell Citadel](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Qeynos Castle](exists)}]}
					SS:Set[1]
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
				echo ISXRI: Shattered Seas Timeline Complete: ${SS}
				echo ISXRI: Othmir Cobalt Scar Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[High Tide](exists)}]}
				echo ISXRI: Othmir Great Divide Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The End of an Era](exists)}]}
				echo ISXRI: Koada'dal Magi's Craft Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Koada'dal Magi's Craft](exists)}]}
				echo ISXRI: A Strange Black Rock Complete: ${Bool[${QuestJournalWindow.CompletedQuest[A Strange Black Rock](exists)}]}
				echo ISXRI: An Eye for Power Complete: ${Bool[${QuestJournalWindow.CompletedQuest[An Eye for Power](exists)}]}
				echo ISXRI: Vesspyr Isles Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Family Ties](exists)}]}
				break
			}
			case priest
			{
				echo ISXRI: ${Me.Name}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Kaedrin's Fate](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Your Eternal Reward](exists)}]}
					CTD:Set[1]
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
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
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				if ${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Dethknell Citadel](exists)}]}||${Bool[${QuestJournalWindow.CompletedQuest[Shattered Seas: Epilogue in Qeynos Castle](exists)}]}
					SS:Set[1]
				echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
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
				echo ISXRI: Artisan Level: ${Me.TSLevel}
				echo ISXRI: Kunark Ascending Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Kunark Ascending: A Nightmare Realized](exists)}]}
				echo ISXRI: City Timeline Completed Qeynos/Freeport: ${CTD}
				echo ISXRI: Tik-Tok Language Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Mysteries of Tik-Tok](exists)}]}
				echo ISXRI: Pygmy Language Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Handle With Care](exists)}]}
				echo ISXRI: The Symbol in the Flesh Heritage Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Symbol in the Flesh](exists)}]}
				echo ISXRI: The Bone Bladed Claymore Heritage Quest Complete: ${Bool[${QuestJournalWindow.CompletedQuest[The Bone Bladed Claymore](exists)}]}
				echo ISXRI: ToT Sigline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Underdepths Saga: Chaos and Malice](exists)}]}
				echo ISXRI: ToT Crafting Sig Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Containing the Stone](exists)}]}
				echo ISXRI: Jarsath Wastes Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[I'd Hammer in the Morning](exists)}]}
				echo ISXRI: ToV and Ragefire Timeline Complete: ${RF}
				echo ISXRI: Ry'Gorr Keep Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest["Rise of Thrael'Gorr"](exists)}]}
				echo ISXRI: Shades of Drinal Timeline Complete: ${Bool[${QuestJournalWindow.CompletedQuest[Shades of Drinal: Fate's Crusade](exists)}]}
				break
			}
		}
	}
	method ShareMissions(string _ZoneName, string _Tier)
	{
		if ${_ZoneName.Equal[NULL]} || ${_Tier.Equal[NULL]}
			return
		;echo ShareMissions(string _ZoneName=${_ZoneName}, string _Tier=${_Tier})
		if ${QueueCommands}
			FlushQueued
		Script[${Script.Filename}]:QueueCommand["call RIMUIObj.ShareMissionsFN \"${_ZoneName}\" \"${_Tier}\""]
	}
	function ShareMissionsFN(string _ZoneName, string _Tier, bool _WaitTillGroupAllInZone=FALSE)
	{
		if ${_WaitTillGroupAllInZone}
		{
			wait 600 ${RIMObj.AllGroupInZone}
		}
		;echo ShareMissionsFN(string _ZoneName=${_ZoneName}, string _Tier=${_Tier})
		
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
					if ${QuestsIterator.Value.CurrentZone.Equal[${_ZoneName}]} && ${QuestsIterator.Value.Name.Find[${_Tier}](exists)}
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
	member:bool MainIconIDExists(int _ActorID, int _MainIconID, bool _Det=TRUE)
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
							return TRUE
						}
					}
					else
					{
						if ${Me.Effect[${Counter}].MainIconID}==${_MainIconID}
						{
							return TRUE
						}
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				return FALSE
			}
			else
				return FALSE
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
						return TRUE
					}
				}
				while (${Counter:Inc} <= ${NumActorEffects})
				return FALSE
			}
			else
				return FALSE
		}
		else
			return FALSE
	}
	method RQCat(string _CatName=!NONE!)
	{
		if ${_CatName.Equal[!NONE!]}
			return
		else
		{
			if ${_CatName.Equal[Sokokar Crafting]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[Sokokar Crafting Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Sokokar Crafting Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Fangs Away!]
				UIElement[QuestsListBox@RI]:AddItem[An Eye in the Sky]
				UIElement[QuestsListBox@RI]:AddItem[Sticking My Ore In]
				UIElement[QuestsListBox@RI]:AddItem[Preparations for the Rescue]
				UIElement[QuestsListBox@RI]:AddItem[Is It Good News?]
			}
			if ${_CatName.Equal[Greenmist Heritage]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[Greenmist Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Greenmist Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[The Name of Fear]
				UIElement[QuestsListBox@RI]:AddItem[The Word of Fear]
				UIElement[QuestsListBox@RI]:AddItem[The Call of Fear]
				UIElement[QuestsListBox@RI]:AddItem[The Path of Fear]
				UIElement[QuestsListBox@RI]:AddItem[The Triumph of Fear]
			}
			if ${_CatName.Equal[Artisan Epic]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[Artisan Epic Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Artisan Epic Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[New Lands New Profits]
				UIElement[QuestsListBox@RI]:AddItem[Bathzid Watch Faction Crafting]
				UIElement[QuestsListBox@RI]:AddItem[Sarnak Supply Stocking]
				UIElement[QuestsListBox@RI]:AddItem[Bixie Distraction]
				UIElement[QuestsListBox@RI]:AddItem[Anything For Jumjum]
				UIElement[QuestsListBox@RI]:AddItem[${Me.TSClass.Left[1].Upper}${Me.TSClass.Right[-1]} Errands]
			}
			elseif ${_CatName.Equal[Terrors of Thalumbra Crafting]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[The Captain's Lament]
				UIElement[QuestsListBox@RI]:AddItem[Terrors of Thalumbra Crafting Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Terrors of Thalumbra Crafting Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[What Lies Beneath]
				UIElement[QuestsListBox@RI]:AddItem[Assay of Origin]
				UIElement[QuestsListBox@RI]:AddItem[Ore of Yore]
				UIElement[QuestsListBox@RI]:AddItem[More Ore of Yore]
				UIElement[QuestsListBox@RI]:AddItem[Underfoot Defender]
				UIElement[QuestsListBox@RI]:AddItem[Subtunarian Subterfuge]
				UIElement[QuestsListBox@RI]:AddItem[Into the Unknown]
				UIElement[QuestsListBox@RI]:AddItem[Stanger in Distress]
				UIElement[QuestsListBox@RI]:AddItem[Menace in the Mine]
				UIElement[QuestsListBox@RI]:AddItem[Scanning the Seals]
				UIElement[QuestsListBox@RI]:AddItem[Monitoring the Situation]
				UIElement[QuestsListBox@RI]:AddItem[Attuning the Portal]
				UIElement[QuestsListBox@RI]:AddItem[Monitor Malfunction]
				UIElement[QuestsListBox@RI]:AddItem[Researching a Solution]
				UIElement[QuestsListBox@RI]:AddItem[Containing the Stone]
			}
			elseif ${_CatName.Equal[Kunark Ascending Crafting]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending Crafting Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Kunark Ascending Crafting Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[An Urgent Call]
				UIElement[QuestsListBox@RI]:AddItem[Forging Onwards]
				UIElement[QuestsListBox@RI]:AddItem[Into The Spire]
				UIElement[QuestsListBox@RI]:AddItem[Not Dead Yet]
				UIElement[QuestsListBox@RI]:AddItem[Getting Hooked]
				UIElement[QuestsListBox@RI]:AddItem[Feeling Crabby]
				UIElement[QuestsListBox@RI]:AddItem[Hung Out to Dry]
				UIElement[QuestsListBox@RI]:AddItem[Live Bait]
				UIElement[QuestsListBox@RI]:AddItem[Gathering Shinies]
				UIElement[QuestsListBox@RI]:AddItem[Losers, Weepers]
				UIElement[QuestsListBox@RI]:AddItem[Requesting Blessing]
				UIElement[QuestsListBox@RI]:AddItem[A Finding Charm]
				UIElement[QuestsListBox@RI]:AddItem[A Mission of Mercy]
				UIElement[QuestsListBox@RI]:AddItem[Bone Collecting]
				UIElement[QuestsListBox@RI]:AddItem[Scrying Eyes]
				UIElement[QuestsListBox@RI]:AddItem[Deeper Disguise]
				UIElement[QuestsListBox@RI]:AddItem[Gone Astray]
				UIElement[QuestsListBox@RI]:AddItem[Figurine Profits]
				UIElement[QuestsListBox@RI]:AddItem[Search and Rescue]
				UIElement[QuestsListBox@RI]:AddItem[Borrowing From The Dead]
				UIElement[QuestsListBox@RI]:AddItem[Drop Your Weapon]
				UIElement[QuestsListBox@RI]:AddItem[Smoothy-Stones for Stabby-Sticks]
				UIElement[QuestsListBox@RI]:AddItem[Googlow Juice]
				UIElement[QuestsListBox@RI]:AddItem[Keep the Home Fires Burning]
				UIElement[QuestsListBox@RI]:AddItem[Squirmy-Wormies for Grumbly-Bellies]
				UIElement[QuestsListBox@RI]:AddItem[Stacky-Racks for Stabby-Sticks]
				UIElement[QuestsListBox@RI]:AddItem[If The Bones Fit]
				UIElement[QuestsListBox@RI]:AddItem[Sickly-Brews for Stabby Sticks]
				UIElement[QuestsListBox@RI]:AddItem[Temple Visitor]
				UIElement[QuestsListBox@RI]:AddItem[Guardian of Growf]
				UIElement[QuestsListBox@RI]:AddItem[Blessing of Growf]
				UIElement[QuestsListBox@RI]:AddItem[Protector of Growf]
				UIElement[QuestsListBox@RI]:AddItem[Seeds of Growf]
				UIElement[QuestsListBox@RI]:AddItem[The Gardens Are In Bloom]
				UIElement[QuestsListBox@RI]:AddItem[Stranger Friends]
				UIElement[QuestsListBox@RI]:AddItem[Dying of Bore-dom]
				UIElement[QuestsListBox@RI]:AddItem[Soil and Trouble]
				UIElement[QuestsListBox@RI]:AddItem[Process of Elimination]
				UIElement[QuestsListBox@RI]:AddItem[Choose the Slug Life]
			}
			elseif ${_CatName.Equal[Sokokar Crafting]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[Sokokar Crafting Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Sokokar Crafting Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Fangs Away!]
				UIElement[QuestsListBox@RI]:AddItem[An Eye in the Sky]
				UIElement[QuestsListBox@RI]:AddItem[Sticking My Ore In]
				UIElement[QuestsListBox@RI]:AddItem[Preperations for the Rescue]
				UIElement[QuestsListBox@RI]:AddItem[Is It Good News?]
			}
			elseif ${_CatName.Equal[Kunark Ascending Adventure]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending Adventure Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Kunark Ascending Adventure Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Beyond the Veil]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Opportunity 'Noks]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Ghost Whisperer]
				UIElement[QuestsListBox@RI]:AddItem[Drake Disposal Duty]
				UIElement[QuestsListBox@RI]:AddItem[Idol Destruction]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Forgotten Lands]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: History in Stone]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: A Chosen Weapon]
				UIElement[QuestsListBox@RI]:AddItem[Giant Impressment Effort]
				UIElement[QuestsListBox@RI]:AddItem[Giant Spiritual Awakening]
				UIElement[QuestsListBox@RI]:AddItem[Suit Up]
				UIElement[QuestsListBox@RI]:AddItem[Flame Licked]
				UIElement[QuestsListBox@RI]:AddItem[Littered Along the Pass]
				UIElement[QuestsListBox@RI]:AddItem[Trader Amongst Us]
				UIElement[QuestsListBox@RI]:AddItem[Remains to be Seen]
				UIElement[QuestsListBox@RI]:AddItem[Wings in Danger]
				UIElement[QuestsListBox@RI]:AddItem[Artifacts of Life]
				UIElement[QuestsListBox@RI]:AddItem[Feast for a Gift]
				UIElement[QuestsListBox@RI]:AddItem[Delivered from Madness]
				UIElement[QuestsListBox@RI]:AddItem[Shattered Lives]
				UIElement[QuestsListBox@RI]:AddItem[A Vicious Tongue]
				UIElement[QuestsListBox@RI]:AddItem[Bridge To Success]
				UIElement[QuestsListBox@RI]:AddItem[Get A 'Shroom]
				UIElement[QuestsListBox@RI]:AddItem[Sluggin' It Out]
				UIElement[QuestsListBox@RI]:AddItem[Hide and Wreek]
				UIElement[QuestsListBox@RI]:AddItem[Dying to Have You]
				UIElement[QuestsListBox@RI]:AddItem[Ghosts and Gooblins]
				UIElement[QuestsListBox@RI]:AddItem[Growth in an Arid Land]
				UIElement[QuestsListBox@RI]:AddItem[Lightning Bug Hunt]
				UIElement[QuestsListBox@RI]:AddItem[Parchment Preservation]
				UIElement[QuestsListBox@RI]:AddItem[Case of the Missing Headpiece]
				UIElement[QuestsListBox@RI]:AddItem[Damage the Trust]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Seeking Reassurance]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Reading Assignment]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: Resurrection Machination]
				UIElement[QuestsListBox@RI]:AddItem[Kunark Ascending: A Nightmare Realized]
			}
			; elseif ${_CatName.Equal[Shattered Seas]}
			; {
				; UIElement[QuestsListBox@RI]:ClearItems
				; UIElement[QuestsListBox@RI]:AddItem[Shattered Seas Timeline]
				; UIElement[QuestsListBox@RI].ItemByText[Shattered Seas Timeline]:SetTextColor[FFE8E200]
				; UIElement[QuestsListBox@RI]:AddItem[]
		
			; }
			elseif ${_CatName.Equal[Epic 2.0 Pre Reqs]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				
				UIElement[QuestsListBox@RI]:AddItem[Jarsath Wastes Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Jarsath Wastes Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Koada'dal Magi's Craft]
				UIElement[QuestsListBox@RI]:AddItem[Kurns Tower Access Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Kurns Tower Access Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Ning Yung Retreat Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Ning Yung Retreat Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Order of Rime Faction Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Order of Rime Faction Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Othmir Cobalt Scar Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Othmir Cobalt Scar Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Othmir Great Divide Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Othmir Great Divide Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Othmir EW Faction Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Othmir EW Faction Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Ry'Gorr Keep Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Ry'Gorr Keep Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Shades of Drinal Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Shades of Drinal Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Shattered Seas Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Shattered Seas Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[Tears of Veeshan Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Tears of Veeshan Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[The Circle of the Unseen Hand Timeline]
				UIElement[QuestsListBox@RI].ItemByText[The Circle of the Unseen Hand Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[The City of Qeynos Timeline]
				UIElement[QuestsListBox@RI].ItemByText[The City of Qeynos Timeline]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[The Mysteries of TikTok]
				UIElement[QuestsListBox@RI]:AddItem[Tower of the Four Winds Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Tower of the Four Winds Timeline]:SetTextColor[FFE8E200]
			
			}
			elseif ${_CatName.Equal[Heritage Quests]}
			{
				UIElement[QuestsListBox@RI]:ClearItems
				UIElement[QuestsListBox@RI]:AddItem["A Source of Malediction"]
				UIElement[QuestsListBox@RI]:AddItem[The White Dragonscale Cloak]
				UIElement[QuestsListBox@RI]:AddItem[Dark Mail Guantlets HQ Timeline]
				UIElement[QuestsListBox@RI].ItemByText[Dark Mail Guantlets HQ Timelin]:SetTextColor[FFE8E200]
				UIElement[QuestsListBox@RI]:AddItem[An Eye for Power]
				UIElement[QuestsListBox@RI]:AddItem[A Strange Black Rock]
				UIElement[QuestsListBox@RI]:AddItem[Gogas Afadin]
				UIElement[QuestsListBox@RI]:AddItem[The Bone Bladed Claymore]
				UIElement[QuestsListBox@RI]:AddItem[The Symbol in the Flesh]
			}
		}
	}
	method RQ(string _QuestName=!NONE!)
	{
		if ${Script[${RI_Var_String_RunInstancesScriptName}](exists)}
			return
		if ${_QuestName.Equal[!NONE!]}
		{
			;load RI ui and change 
			ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
			ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
		
			UIElement[Start@RI]:Hide
			UIElement[AutoLoot@RI]:Hide
			UIElement[RI]:SetHeight[378]
			UIElement[RI]:SetWidth[302]
			UIElement[QuestsListBox@RI]:Show
			UIElement[RunButton@RI]:Show
			UIElement[CategoryText@RI]:Show
			UIElement[CategoryComboBox@RI]:Show
			UIElement[CategoryComboBox@RI]:AddItem[Sokokar Crafting]
			UIElement[CategoryComboBox@RI]:AddItem[Artisan Epic]
			UIElement[CategoryComboBox@RI]:AddItem[Terrors of Thalumbra Crafting]
			UIElement[CategoryComboBox@RI]:AddItem[Kunark Ascending Crafting]
			UIElement[CategoryComboBox@RI]:AddItem[Kunark Ascending Adventure]
			UIElement[CategoryComboBox@RI]:AddItem[Greenmist Heritage]
			UIElement[CategoryComboBox@RI]:AddItem[Epic 2.0 Pre Reqs]
			UIElement[CategoryComboBox@RI]:AddItem[Heritage Quests]
			UIElement[CategoryComboBox@RI]:SelectItem[${UIElement[CategoryComboBox@RI].ItemByText[Epic 2.0 Pre Reqs].ID}]
			UIElement[RI]:SetTitle[RQv${RI_Var_Float_Version.Precision[2]}]
			
			;UIElement[QuestsListBox@RI].OrderedItem[]:SetTextColor[FF5DA5CF]
			;UIElement[QuestsListBox@RI].OrderedItem[]:SetTextColor[FFE8E200]
		}
		elseif ${_QuestName.Equal[QUIT]}
		{
			;changeui back to standard ri then close it
			;ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
			;ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
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
	method TravelMap(string ForWho=ALL, string ZoneName=~NONE~, int ZoneOption=-1, int _BellWizardDruid=0)
	{
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
	method TravelMapPop(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Atom_TravelMapPop
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
				RI_Atom_SetLockSpot ALL ${If[${args[${Math.Calc[${_count}+1]}](exists)},${args[${Math.Calc[${_count}+1]}]},${Me.X}]} ${If[${args[${Math.Calc[${_count}+2]}](exists)},${args[${Math.Calc[${_count}+2]}]},${Me.Y}]} ${If[${args[${Math.Calc[${_count}+3]}](exists)},${args[${Math.Calc[${_count}+3]}]},${Me.Z}]} ${If[${args[${Math.Calc[${_count}+4]}](exists)},${args[${Math.Calc[${_count}+4]}]},1]} ${If[${args[${Math.Calc[${_count}+5]}](exists)},${args[${Math.Calc[${_count}+5]}]},100]}
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
			RewardWindow:Receive
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
	method UseItem(string ForWho, string ItemName)
	{
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Inventory[Query,Location=="Inventory" && Name=-"${ItemName}"](exists)}
			Me.Inventory[Query,Location=="Inventory" && Name=-"${ItemName}"]:Use
		if ${This.ForWhoCheck[${ForWho}]} && ${Me.Equipment["${ItemName}"](exists)}
			Me.Equipment["${ItemName}"]:Use
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
	method Revive(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
		{
			variable int Rand
			Rand:Set[${Math.Rand[4]}]
			Rand:Set[${Math.Calc[${Rand}+1]}]
			TimedCommand ${Rand} eq2ex "select_junction 0"
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
		if ${ForWho.Upper.Find[~Not~](exists)}
		{
			if ${ForWho.Upper.Find[${Me.Name}](exists)}
				GoodToGo:Set[FALSE]
			else
				GoodToGo:Set[TRUE]
		}
		elseif ${ForWho.Upper.Find[~AllBut~](exists)}
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
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
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
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
		if ${_Save}>0
			RI_Atom_SaveSize Large
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
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
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
		tempvar:Set["${comvariable.Right[-19].Escape}"]
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
		ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
		
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
					tempvar:Set["relay all RIMUIObj:${UIElement[AvailableCommandsCB@RIMUIEdit].SelectedItem}["]
				elseif ${RI_Var_String_ButtonChangeOriginalCommand.NotEqual[""]} 
					tempvar:Set["relay all RIMUIObj:${RI_Var_String_ButtonChangeOriginalCommand}["]
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
			;CODING THE SAVE BUTTON,,, Opposite of above. build the string from relay all RIMUIObj:COMMAND[arg,arg,arg] etc
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
	method LockSpotPop(string ForWho)
	{
		;load RIMovement
		This:LoadRIMovement
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Atom_RILockSpotPop
	}
	method RIFollowPop(string ForWho)
	{
		;load RIMovement
		This:LoadRIMovement
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Atom_RIFollowPop
	}
	method AssistPop(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Atom_AssistPop
	}
	method DoorPop(string ForWho)
	{
		if ${This.ForWhoCheck[${ForWho}]}
			RI_Atom_DoorPop
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
					strRIHUD1:Set[":${Me.Name} => ${Me.Target}"]
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
function LoadRIMUI()
{
	RIMUILoaded:Set[TRUE]
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	;check if RIMUI.xml exists, if not create
	;FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if ${FP.FileExists[RIMUI.xml]}
	{
		noop
	}
	else
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMUI.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml" http://www.isxri.com/RIMUI.xml
		wait 50
	}
	if ${FP.FileExists[RIMUICustom.xml]}
	{
		noop
	}
	else
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMUICustom.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMUICustom.xml" http://www.isxri.com/RIMUICustom.xml
		wait 50
	}
	if ${FP.FileExists[RIMUIEdit.xml]}
	{
		noop
	}
	else
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIMUIEdit.xml
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml" http://www.isxri.com/RIMUIEdit.xml
		wait 50
	}
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
	wait 5
	
	LoadUI
}
;RIFollowPop function
function RIFollowPop()
{
	InputBox "RI Follow For Who? Standard: ALL, Options: All, Class, Name, Off"
	variable string RIFW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			RIFW:Set[ALL]
			;echo Blank
		}
		else
		{
			RIFW:Set[${UserInput}]
			;echo we got ${RIFW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		RIFW:Set[ALL]
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
	relay all RI_Atom_SetRIFollow ${RIFW} ${Actor[PC,${RIFOW}].ID} ${RIFMin} ${RIFMax}
	CommandQ:Set[FALSE]
	RIFP:Set[FALSE]
}
;RILockSpotPop function
function RILockSpotPop()
{
	InputBox "RI Lockspot For Who? Standard: ALL, Options: All, Class, Name, Off"
	variable string RILSW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			RILSW:Set[ALL]
			;echo Blank
		}
		else
		{
			RILSW:Set[${UserInput}]
			;echo we got ${RILSW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		RILSW:Set[ALL]
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
	relay all RI_Atom_SetLockSpot ${RILSW} ${RILSXYZMM}
	CommandQ:Set[FALSE]
	RILSP:Set[FALSE]
}

;AssistPop function
function AssistPop()
{
	InputBox "Assist For Who? Standard: ALL, Options: All, Class, Name, Off"
	variable string ASSW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			ASSW:Set[ALL]
			;echo Blank
		}
		else
		{
			ASSW:Set[${UserInput}]
			;echo we got ${ASSW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		ASSW:Set[ALL]
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
	echo relay all RIMUIObj:Assist[${ASSW},1,${ASSOW}]
	relay all RIMUIObj:Assist[${ASSW},1,${ASSOW}]
	CommandQ:Set[FALSE]
	ASSP:Set[FALSE]
}
;DoorPop Function
function DoorPop()
{
	InputBox "Door For Who? Standard: ALL, Options: All, Class, Name, Off"
	variable string DOORW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			DOORW:Set[ALL]
			;echo Blank
		}
		else
		{
			DOORW:Set[${UserInput}]
			;echo we got ${ASSW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		DOORW:Set[ALL]
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
	
	relay all RIMUIObj:Door[${DOORW},${DOOROP}]
	CommandQ:Set[FALSE]
	DOORP:Set[FALSE]
}
;TravelMapPop Function
function TravelMapPop()
{
	InputBox "TravelMap For Who? Standard: ALL, Options: All, Class, Name"
	variable string TMW=${UserInput}
	if ${UserInput.NotEqual[NULL]}
	{
		if ${UserInput.Equal[""]}
		{
			TMW:Set[ALL]
			;echo Blank
		}
		else
		{
			TMW:Set[${UserInput}]
			;echo we got ${ASSW}
		}
		
	}
	else 
	{
		;echo we got null or blank
		TMW:Set[ALL]
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
	
	relay all RIMUIObj:TravelMap[${TMW},"${TMZN}"]
	CommandQ:Set[FALSE]
	TMP:Set[FALSE]
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
	ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
	
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
}

atom IterateSet(settingsetref Set)
{
	;set variables
	variable string commandT
	variable string commandC
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
function atexit()
{
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUI.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIMUIEdit.xml"
	ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RI.xml"
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
	if ${args.Size}==0
		RI_RunInstances
	else
	{
		switch ${args[1]}
		{
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
			case AD
			case AutoDeity
			{
				if !${Script[Buffer:RIAutoDeity](exists)}
				{
					if ${args.Size}==2
						RI_AutoDeity ${args[2]}
					elseif ${args.Size}==3
						RI_AutoDeity ${args[2]} ${args[3]}
					else
						RI_AutoDeity
				}
				break
			}
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
				echo AutoDeity
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
atom(global) !ri(... args)
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