; Now that everything is working good, I would like to add:
;   Add a counter for NonChargedQuests and dont run charged until that hits 0 -- DONE
;   Add input boxes for minimum trait matches to run - DONE
;   still need to code the run charged and run charged daily to uncheck others/ check each other
;   Add waits for zoning and add checks if the window is still open if not reopen window 


;will have a RIO or RI_Overseer GUI with the following options (options will save as Toon-OverseerSave under Overseer folder)
;   - on load if not save for toon bring up ui for importing from another save
;     OPTIONS:
;       run tiers
;       run mishap
;       run charged
;       run charged only after daily done
;       run charged only (for alts)
;       button for replenishing charged

;Quest types to run (checkboxes)
;Lowest Bonus chance to run quests
;Highest Mishap Chance
;Tokens: Questname|Duration|Bonus Chance|Mishap Chance|# Agents Needed|Positive Traits|Negative Traits|Tier
variable index:string GOChargedCnt
variable index:string GOQuest
variable index:string AgentsTraits
variable index:string AgentsNoTraits
variable index:string Quest
variable index:string Agent
variable index:string Quests
variable index:string AgentsTraitsReady
variable index:string AgentsNoTraitsReady
variable index:string QuestsReady
variable index:string QuestsReadySorted
variable index:string QuestsReadySortedMatched
variable(global) OverseerObj RIOverseerObj
variable(global) bool RI_Var_Bool_Overseer_RunNow=FALSE
variable(global) bool RI_Var_Bool_OverseerDebug=FALSE
variable int cnt=0
variable int i=2
variable int f=1
variable int traitcnt=0
variable int seconds=0
variable int secondscalc=0
variable string traitbuilder=""
variable string _agent=""
variable string _quest=""
variable int _minagents
variable int _maxagents
variable bool _GO=FALSE
variable int NonChargedCount=0
variable int scriptRunningTime
variable bool CompletingQuests=FALSE
variable bool AlreadyWaitedOnce=FALSE
variable int RI_Var_Overseer_Int_DailyCount=0
variable string MyName

function main()
{
    
    Script:DisableDebugging

    GOQuest:Insert["Eliminate Venekor|Fabled|1"]
    GOQuest:Insert["Retrieval for the Crown|Fabled|1"]
    GOQuest:Insert["The Kra'thuk's Magical Properties|Fabled|1"]
    GOQuest:Insert["The Word of Thule|Fabled|1"]
    GOQuest:Insert["Save the Vision of Vox|Fabled|1"]
    GOQuest:Insert["Convince the Guardians|Legendary|1"]
    GOQuest:Insert["Eliminate Warlord Ix Acon|Legendary|1"]
    GOQuest:Insert["Exact Revenge on the Drakota|Legendary|1"]
    GOQuest:Insert["Find the Goblin Banker's Loot|Legendary|1"]
    GOQuest:Insert["Find the Golden Idol of the Drafling|Legendary|1"]
    GOQuest:Insert["Liberate Lady Laravale|Legendary|1"]
    GOQuest:Insert["Reacquire the Idol of Solusek Ro|Legendary|1"]
    GOQuest:Insert["Recover the Stolen Scrolls|Legendary|1"]
    GOQuest:Insert["Save Orxilia Calogn|Legendary|1"]
    GOQuest:Insert["Save the Valkyrie Princess|Legendary|1"]
    GOQuest:Insert["The Throne of Emperor Fyst|Legendary|1"]
    GOQuest:Insert["A Dark Ceremony|Treasured|1"]
    GOQuest:Insert["Captured in Bramble Woods|Treasured|1"]
    GOQuest:Insert["Eliminate Klirkan X'Davai|Treasured|1"]
    GOQuest:Insert["Eliminate the Gang Lord|Treasured|1"]
    GOQuest:Insert["Keeper for the Keep|Treasured|1"]
    GOQuest:Insert["Lord Sellwin's Locket|Treasured|1"]
    GOQuest:Insert["Rescue Captain Wilcox|Treasured|1"]
    GOQuest:Insert["Rob the Fool's Gold Tavern|Treasured|1"]
    GOQuest:Insert["Save Lira Singebellows|Treasured|1"]
    GOQuest:Insert["Slay the Evol Ew Chieftan|Treasured|1"]
    GOQuest:Insert["The Thexian Wizard's Wand|Treasured|1"]
    GOQuest:Insert["Thexian Treasure|Treasured|1"]
    GOQuest:Insert["Treasure in Shortwine Burrow|Treasured|1"]
    GOQuest:Insert["Valuable Runes in a Dirty Place|Treasured|1"]

    Quest:Insert["A Dark Ceremony|1:00:00|5%|5%|1|Agile:Persuasive|Devoted|Treasured"]
    Quest:Insert["Captured in Bramble Woods|1:30:00|10%|5%|1|Noble:Tough|Lucky|Treasured"]
    Quest:Insert["Eliminate Klirkan X'Davai|2:00:00|15%|10%|1|Cautious|Devoted|Treasured"]
    Quest:Insert["Eliminate the Gang Lord|1:00:00|5%|5%|1|Lucky:Tough|Noble|Treasured"]
    Quest:Insert["Keeper for the Keep|1:00:00|5%|5%|1|Strong:Honest|Sly|Treasured"]
    Quest:Insert["Lord Sellwin's Locket|1:00:00|5%|5%|1|Sly:Agile|Honest|Treasured"]
    Quest:Insert["Rescue Captain Wilcox|1:00:00|5%|5%|1|Sly:Wise|Vigilant|Treasured"]
    Quest:Insert["Rob the Fool's Gold Tavern|1:30:00|10%|5%|1|Lucky:Cautious|Vigilant|Treasured"]
    Quest:Insert["Save Lira Singebellows|2:00:00|15%|10%|1|Focused|Persuasive|Treasured"]
    Quest:Insert["Slay the Evol Ew Chieftain|1:30:00|10%|5%|1|Agile:Focused|Strong|Treasured"]
    Quest:Insert["The Thexian Wizard's Wand|2:00:00|15%|10%|1|Cunning|Righteous|Treasured"]
    Quest:Insert["Thexian Treasure|1:30:00|10%|5%|1|Strong:Cunning|Wise|Treasured"]
    Quest:Insert["Treasure in Shortwine Burrow|2:00:00|15%|10%|1|Cunning|Vigilant|Treasured"]
    Quest:Insert["Valuable Runes in a Dirty Place|1:30:00|10%|5%|1|Sly:Lucky|Charming|Treasured"]
    Quest:Insert["Convince the Guardians|5:00:00|20%|20%|1-2|Vigilant:Diplomatic|Tough:Agile|Legendary"]
    Quest:Insert["Eliminate Warlord Ix Acon|3:30:00|15%|10%|1-2|Agile:Vigilant:Dexterous|Diplomatic:Devoted|Legendary"]
    Quest:Insert["Exact Revenge on the Drakota|5:00:00|20%|20%|1-2|Devoted:Righteous|Diplomatic:Cautious|Legendary"]
    Quest:Insert["Find the Goblin Banker's Loot|2:30:00|10%|5%|1-2|Agile:Lucky:Tough:Persuasive|Intelligent|Legendary"]
    Quest:Insert["Find the Golden Idol of the Drafling|3:30:00|15%|10%|1-2|Lucky:Cunning:Intelligent|Charming:Compassionate|Legendary"]
    Quest:Insert["Liberate Lady Laravale|2:30:00|10%|5%|1-2|Wise:Noble:Strong:Honest|Cautious:Cunning|Legendary"]
    Quest:Insert["Reacquire the Idol of Solusek Ro|5:00:00|20%|20%|1-2|Focused:Intelligent|Compassionate:Vigilant|Legendary"]
    Quest:Insert["Recover the Stolen Scrolls|5:00:00|20%|20%|1-2|Diplomatic:Vigilant|Lucky:Agile|Legendary"]
    Quest:Insert["Save Orxilia Calogn|3:30:00|0%|0%|1-2|Noble:Persuasive:Compassionate|Wise:Cautious|Legendary"]
    Quest:Insert["Save the Valkyrie Princess|5:00:00|20%|20%|1-2|Honest:Charming|Dexterous|Legendary"]
    Quest:Insert["The Throne of Emperor Fyst|2:30:00|10%|5%|1-2|Sly:Tough:Devoted|Noble:Honest|Legendary"]
    Quest:Insert["Eliminate Venekor|10:00:00|20%|30%|1-2|Sly:Tough:Lucky:Cautious:Charming|Strong:Focused|Fabled"]
    Quest:Insert["Retrieval for the Crown|10:00:00|20%|30%|1-3|Agile:Noble:Wise:Devoted:Diplomatic|Cunning:Persuasive|Fabled"]
    Quest:Insert["The Kra'thuk's Magical Properties|10:00:00|20%|30%|1-3|Noble:Wise:Strong:Honest:Intelligent|Focused:Dexterous|Fabled"]
    Quest:Insert["The Word of Thule|10:00:00|20%|30%|1-3|Sly:Tough:Wise:Focused:Dexterous|Honest:Righteous|Fabled"]
    Quest:Insert["Save the Vision of Vox|10:00:00|20%|30%|1-3|Wise:Noble:Strong:Vigilant:Compassionate|Cunning:Persuasive:Cautious|Fabled"]

    ;Season 2


    GOQuest:Insert["Ancient Spices|Treasured|2"]
    GOQuest:Insert["Eliminate Harbinger Siyuth|Treasured|2"]
    GOQuest:Insert["Eliminate Herald Zydul|Treasured|2"]
    GOQuest:Insert["Eliminate Lady Samiel|Treasured|2"]
    GOQuest:Insert["Pilfer Tan'ke Rei's Golden Cap|Treasured|2"]
    GOQuest:Insert["Raja the Sunspeaker's Staff|Treasured|2"]
    GOQuest:Insert["Rescue Dolloran Arkur from Azhahkar the Gatecaller|Treasured|2"]
    GOQuest:Insert["Rescue Lady Mirolyn from Gorakhul the Annihilator|Treasured|2"]
    GOQuest:Insert["Save Lord Pardun from Queen Marrowjaw|Treasured|2"]
    GOQuest:Insert["Steal Yinderis the Snake Charmer's Jeweled Pipe|Treasured|2"]
    GOQuest:Insert["The Golden Trowel|Treasured|2"]
    GOQuest:Insert["The Jeweled Fez|Treasured|2"]
    GOQuest:Insert["Eliminate Blademaster Thul|Legendary|2"]
    GOQuest:Insert["Eliminate Meathooks|Legendary|2"]
    GOQuest:Insert["Pirate Strongbox|Legendary|2"]
    GOQuest:Insert["Rescue Gumbolt Triggerhand|Legendary|2"]
    GOQuest:Insert["Save Joana Larr|Legendary|2"]
    GOQuest:Insert["Save Milo Brownfoot|Legendary|2"]
    GOQuest:Insert["Shield of Cazel the Mad|Legendary|2"]
    GOQuest:Insert["The Blackened Scepter|Legendary|2"]
    GOQuest:Insert["The Broken Lord's Crown|Legendary|2"]
    GOQuest:Insert["The Golden Tablet|Legendary|2"]
    GOQuest:Insert["The Priceless Time Monocle|Legendary|2"]
    GOQuest:Insert["Eliminate Ahk'Mun Rhoen|Fabled|2"]
    GOQuest:Insert["The Scepter of Life|Fabled|2"]
    GOQuest:Insert["Retrieve the Golden Scale|Fabled|2"]
    GOQuest:Insert["Save Xideus Yoatiak|Fabled|2"]
    GOQuest:Insert["The Platinum Eye|Fabled|2"]
    GOQuest:Insert["Eliminate the Djinn Master|Celestial|2"]
    GOQuest:Insert["Ewer of Sul'Dae|Celestial|2"]

    Quest:Insert["Ancient Spices|1:30:00|10%|5%|1|Vigilant:Noble|Shrewd|Treasured"]
    Quest:Insert["Eliminate Harbinger Siyuth|1:00:00|5%|5%|1|Strong:Unpredictable|Sly|Treasured"]
    Quest:Insert["Eliminate Herald Zydul|1:30:00|10%|5%|1|Persuasive:Shrewd|Noble|Treasured"]
    Quest:Insert["Eliminate Lady Samiel|2:00:00|15%|10%|1|Corrupt|Honest|Treasured"]
    Quest:Insert["Pilfer Tan'ke Rei's Golden Cap|2:00:00|15%|10%|1|Persuasive|Cautious|Treasured"]
    Quest:Insert["Raja the Sunspeaker's Staff|1:00:00|5%|5%|1|Agile:Wise|Lucky|Treasured"]
    Quest:Insert["Rescue Dolloran Arkur from Azhahkar the Gatecaller|2:00:00|15%|10%|1|Cunning|Devoted|Treasured"]
    Quest:Insert["Rescue Lady Mirolyn from Gorakhul the Annihilator|1:30:00|10%|5%|1|Cautious:Lucky|Strong|Treasured"]
    Quest:Insert["Save Lord Pardun from Queen Marrowjaw|1:00:00|5%|5%|1|Unpredictable:Shrewd|Noble|Treasured"]
    Quest:Insert["Steal Yinderis the Snake Charmer's Jeweled Pipe|1:30:00|10%|5%|1|Devoted:Tough|Wise|Treasured"]
    Quest:Insert["The Golden Trowel|1:30:00|10%|5%|1|Lucky:Cautious|Unpredictable|Treasured"]
    Quest:Insert["The Jeweled Fez|2:00:00|15%|10%|1|Cunning|Impatient|Treasured"]
    Quest:Insert["Eliminate Blademaster Thul|3:30:00|15%|10%|2|Impatient:Sly:Manipulative|Wise:Honest|Legendary"]
    Quest:Insert["Eliminate Meathooks|5:00:00|20%|20%|2|Dexterous:Focused|Strong:Persuasive|Legendary"]
    Quest:Insert["Pirate Strongbox|2:30:00|10%|5%|2|Tough:Lucky:Persuasive:Strong|Shrewd:Wise|Legendary"]
    Quest:Insert["Rescue Gumbolt Triggerhand|5:00:00|20%|20%|2|Charming:Vigilant|Impatient:Cautious|Legendary"]
    Quest:Insert["Save Joana Larr|3:30:00|15%|10%|2|Honest:Wise:Righteous|Sly:Cunning|Legendary"]
    Quest:Insert["Save Milo Brownfoot|2:30:00|10%|5%|2|Tough:Noble:Honest:Strong|Agile:Lucky|Legendary"]
    Quest:Insert["Shield of Cazel the Mad|2:30:00|15%|5%|2|Tough:Noble:Vigilant:Agile|Lucky:Sly|Legendary"]
    Quest:Insert["The Blackened Scepter|5:00:00|20%|20%|2|Righteous:Cautious|Focused:Corrupt|Legendary"]
    Quest:Insert["The Broken Lord's Crown|5:00:00|20%|20%|2|Compassionate:Devoted|Strong:Unpredictable|Legendary"]
    Quest:Insert["The Golden Tablet|5:00:00|20%|20%|2|Manipulative:Focused|Unpredictable:Cautious|Legendary"]
    Quest:Insert["The Priceless Time Monocle|3:30:00|15%|10%|2|Devoted:Strong:Dexterous|Noble:Vigilant|Legendary"]
    Quest:Insert["Eliminate Ahk'Mun Rhoen|10:00:00|20%|30%|3|Strong:Noble:Diplomatic:Devoted:Wise|Tough:Agile|Fabled"]
    Quest:Insert["The Scepter of Life|10:00:00|20%|30%|3|Sly:Shrewd:Manipulative:Corrupt:Lucky|Compassionate:Intelligent|Fabled"]
    Quest:Insert["Retrieve the Golden Scale|10:00:00|20%|30%|3|Agile:Sly:Compasionate:Cunning:Noble|Tough:Intelligent|Fabled"]
    Quest:Insert["Save Xideus Yoatiak|10:00:00|20%|30%|3|Agile:Sly:Dexterous:Honest:Lucky|Righteous:Charming|Fabled"]
    Quest:Insert["The Platinum Eye|10:00:00|20%|30%|3|Noble:Wise:Diplomatic:Focused:Tough|Agile:Manipulative|Fabled"]
    Quest:Insert["Eliminate the Djinn Master|15:00:00|25%|30%|3|Lucky:Wise:Intelligent:Charming:Impatient|Persuasive:Manipulative:Shrewd|Celestial"]
    Quest:Insert["Ewer of Sul'Dae|15:00:00|25%|30%|3|Tough:Agile:Intelligent:Manipulative:Vigilant|Shrewd:Corrupt:Diplomatic|Celestial"]

    Quest:Insert["Heritage Hunt [Daily]|24:00:00|0%|0%|2|||Heritage"]

    ;;;; mishaps need more data -- DONE

    Quest:Insert["Bitten By Alligators|6:00:00|5%|5%|1-2|Strong:Unpredictable|Tough|Mishap"]
    Quest:Insert["Captured By Dervish|4:00:00|5%|10%|1-2|Agile:Sly|Wise|Mishap"]
    Quest:Insert["Captured by Pit Fighters|6:00:00|5%|5%|1-2|Noble:Wise|Unpredictable|Mishap"]
    Quest:Insert["Captured by Sandfury Brutes|6:00:00|5%|5%|1-2|Wise:Lucky|Sly|Mishap"]
    Quest:Insert["Captured by Sandcrawler Goblins|6:00:00|5%|5%|1-2|Strong:Unpredictable|Agile|Mishap"]
    Quest:Insert["Captured By Windsister Harpies|6:00:00|5%|5%|1-2|Tough:Shrewd|Noble|Mishap"]
    Quest:Insert["Caught in a Sand Storm|6:00:00|5%|5%|1-2|Shrewd:Tough|Lucky|Mishap"]
    Quest:Insert["Poisoned by Cobras|6:00:00|5%|5%|1-2|Lucky:Noble|Shrewd|Mishap"]
    Quest:Insert["Scimitar to the Head|4:00:00|5%|10%|1-2|Agile:Sly|Unpredictable|Mishap"]
    Quest:Insert["Wounded by Harpies|6:00:00|5%|5%|1-2|Wise:Agile|Shrewd|Mishap"]

    ;Season 3
    ;Treasured
    GOQuest:Insert["Eliminate Konarr the Despoiler|Treasured|3"]
    GOQuest:Insert["Eliminate the Vornerus Tyrant |Treasured|3"]
    GOQuest:Insert["Eliminate Queen Bazzt Bzzt the 200th|Treasured|3"]
    GOQuest:Insert["Pilfer the Beguiler's Gemmed Robe|Treasured|3"]
    GOQuest:Insert["Rescue Constance Cloudpuff from Skymarshal Stormfeather|Treasured|3"]
    GOQuest:Insert["Rescue Gimdimble Fizzwoddle from the Ravaging Maw|Treasured|3"]
    GOQuest:Insert["Save Jabber Longwind from The Brood Matron|Treasured|3"]
    GOQuest:Insert["Steal the Reformation Trinket|Treasured|3"]
    GOQuest:Insert["Steal the Balefire Blade|Treasured|3"]
    GOQuest:Insert["The Drained Soul Husk|Treasured|3"]
    GOQuest:Insert["The Emblem of the Lost Gods|Treasured|3"]
    GOQuest:Insert["The Gloompall Gewgaw|Treasured|3"]
    ;Legendary
    GOQuest:Insert["Eliminate Oracle Tuunza|Legendary|3"]
    GOQuest:Insert["Eliminate the Enmity of Naar'Yora|Legendary|3"]
    GOQuest:Insert["Rescue Raluvh|Legendary|3"]
    GOQuest:Insert["Save Gribbly the Gallant|Legendary|3"]
    GOQuest:Insert["Save Turadramin|Legendary|3"]
    GOQuest:Insert["The Crown of X'haviz|Legendary|3"]
    GOQuest:Insert["The Queen's Trove|Legendary|3"]
    GOQuest:Insert["The Splitscar Bow|Legendary|3"]
    GOQuest:Insert["The Vaults of El'Arad|Legendary|3"]
    GOQuest:Insert["The Wand of Oblivion|Legendary|3"]
    GOQuest:Insert["Treasure in the Halls|Legendary|3"]
    ;Fabled
    GOQuest:Insert["Eliminate Pantrilla|Fabled|3"]
    GOQuest:Insert["Gaudralek, Sword of the Sky|Fabled|3"]
    GOQuest:Insert["Retrieve the Silver Sword of Rage|Fabled|3"]
    GOQuest:Insert["Save Karnos Van Kellin|Fabled|3"]
    GOQuest:Insert["Shield of the White Dragon|Fabled|3"]
    ;Celestial
    GOQuest:Insert["The Blood Ember Breastplate|Celestial|3"]
    GOQuest:Insert["The Boots of Terror|Celestial|3"]
    GOQuest:Insert["Eliminate Vilucidae the Priest of Thule|Celestial|3"]
    GOQuest:Insert["Save Fitzpitzle|Celestial|3"]
    GOQuest:Insert["Tarinax's Head|Celestial|3"]

    ;Season 3
    ;Treasured
    Quest:Insert["Eliminate Konarr the Despoiler|1:30:00|10%|5%|1|Daring:Stalwart|Impatient|Treasured"]
    Quest:Insert["Eliminate the Vornerus Tyrant |2:00:00|15%|10%|1|Corrupt|Adventurous|Treasured"]
    Quest:Insert["Eliminate Queen Bazzt Bzzt the 200th|1:00:00|5%|5%|1|Daring:Inquisitive|Adventurous|Treasured"]
    Quest:Insert["Pilfer the Beguiler's Gemmed Robe|1:30:00|10%|5%|1|Impatient:Inquisitive|Daring|Treasured"]
    Quest:Insert["Rescue Constance Cloudpuff from Skymarshal Stormfeather|1:30:00|10%|5%|1|Adventurous:Impatient|Stalwart|Treasured"]
    Quest:Insert["Rescue Gimdimble Fizzwoddle from the Ravaging Maw|2:00:00|15%|10%|1|Impatient|Corrupt|Treasured"]
    Quest:Insert["Save Jabber Longwind from The Brood Matron|1:00:00|5%|5%|1|Noble:Tough|Adventurous|Treasured"]
    Quest:Insert["Steal the Reformation Trinket|1:00:00|5%|5%|1|Daring:Shrewd|Unpredictable|Treasured"]
    Quest:Insert["Steal the Balefire Blade|2:00:00|15%|10%|1|Stalwart|Inquisitive|Treasured"]
    Quest:Insert["The Drained Soul Husk|2:00:00|15%|10%|1|Stalwart|Impatient|Treasured"]
    Quest:Insert["The Emblem of the Lost Gods|1:30:00|10%|5%|1|Cunning:Inquisitive|Honest|Treasured"]
    Quest:Insert["The Gloompall Gewgaw|1:30:00|10%|5%|1|Stalwart:Unpredictable|Corrupt|Treasured"]
    ;Legendary
    Quest:Insert["Eliminate Oracle Tuunza|3:30:00|15%|10%|2|Adventurous:Cautious:Courageous|Devoted:Unpredictable|Legendary"]
    Quest:Insert["Eliminate the Enmity of Naar'Yora|5:00:00|20%|20%|2|Courageous:Persuasive|Agile:Shrewd|Legendary"]
    Quest:Insert["Rescue Raluvh|5:00:00|20%|20%|2|Corrupt:Unflappable|Stalwart:Courageous|Legendary"]
    Quest:Insert["Save Gribbly the Gallant|2:30:00|10%|5%|2|Adventurous:Corrupt:Shrewd:Unpredictable|Tough:Wise|Legendary"]
    Quest:Insert["Save Turadramin|3:30:00|15%|10%|2|Courageous:Stalwart:Noble|Daring:Adventurous|Legendary"]
    Quest:Insert["The Crown of X'haviz|2:30:00|10%|5%|2|Daring:Inquisitive:Sly:Stalwart|Impatient:Corrupt|Legendary"]
    Quest:Insert["The Queen's Trove|2:30:00|10%|5%|2|Agile:Daring:Focused:Sly|Adventurous:Noble|Legendary"]
    Quest:Insert["The Splitscar Bow|5:00:00|20%|20%|2|Charming:Honest|Corrupt:Daring|Legendary"]
    Quest:Insert["The Vaults of El'Arad|3:30:00|15%|10%|2|Courageous:Impatient:Unpredictable|Cunning:Strong|Legendary"]
    Quest:Insert["The Wand of Oblivion|5:00:00|20%|20%|2|Impatient:Manipulative|Inquisitive:Stalwart|Legendary"]
    Quest:Insert["Treasure in the Halls|5:00:00|20%|20%|2|Stalwart:Righteous|Devoted:Lucky|Legendary"]
    ;Fabled
    Quest:Insert["Eliminate Pantrilla|10:00:00|20%|30%|3|Cunning:Daring:Shrewd:Unpredictable:Dexterous|Tough:Sly|Fabled"]
    Quest:Insert["Gaudralek, Sword of the Sky|10:00:00|20%|30%|3|Persuasive:Unpredictable:Inquisitive:Adventurous:Compassionate|Shrewd:Tough|Fabled"]
    Quest:Insert["Retrieve the Silver Sword of Rage|10:00:00|20%|30%|3|Adventurous:Diplomatic:Honest:Inquisitive:Lucky|Daring:Unpredictable|Fabled"]
    Quest:Insert["Save Karnos Van Kellin|10:00:00|20%|30%|3|Adventurous:Corrupt:Daring:Manipulative:Shrewd|Noble:Wise|Fabled"]
    Quest:Insert["Shield of the White Dragon|10:00:00|20%|30%|3|Adventurous:Courageous:Inquisitive:Stalwart:Strong|Noble:Wise|Fabled"]
    ;Celestial
    Quest:Insert["The Blood Ember Breastplate|30:00:00|30%|30%|4|Compassionate:Dexterous:Righteous:Devoted:Inquisitive|Agile:Persuasive:Intelligent|Celestial"]
    Quest:Insert["The Boots of Terror|15:00:00|25%|30%|3|Charming:Dexterous:Focused:Noble:Wise|Daring:Stalwart|Celestial"]
    Quest:Insert["Eliminate Vilucidae the Priest of Thule|15:00:00|25%|30%|3|Courageous:Diplomatic:Impatient:Sly:Tough|Honest:Inquisitive|Celestial"]
    Quest:Insert["Save Fitzpitzle|30:00:00|30%|30%|4|Diplomatic:Intelligent:Manipulative:Corrupt:Shrewd|Unflappable:Devoted|Celestial"]
    Quest:Insert["Tarinax's Head|30:00:00|30%|30%|4|Compassionate:Courageous:Daring:Unflappable:Vigilant|Impatient:Manipulative:Shrewd|Celestial"]
    ;Mishap
    Quest:Insert["Bitten by Dryland Hyena|6:00:00|5%|5%|1|Adventurous:Unpredictable|Inquisitive|Mishap"]
    Quest:Insert["Captured by Blacktalons|6:00:00|5%|5%|1|Sly:Strong|Daring|Mishap"]
    Quest:Insert["Captured by Droags|4:00:00|5%|10%|1|Adventurous:Lucky|Daring|Mishap"]
    Quest:Insert["Captured by Doomwings|6:00:00|5%|10%|1|Inquisitive:Unpredictable|Adventurous|Mishap"]
    Quest:Insert["Captured by Ravasects|6:00:00|5%|5%|1|Agile:Daring|Adventurous|Mishap"]
    Quest:Insert["Captured by Strifewings|6:00:00|5%|5%|1|Adventurous:Shrewd|Inquisitive|Mishap"]
    Quest:Insert["Fallen From Great Heights|6:00:00|5%|5%|1|Noble:Wise|Unpredictable|Mishap"]
    Quest:Insert["Wounded by Drakes|6:00:00|5%|5%|1|Daring:Lucky|Inquisitive|Mishap"]
    Quest:Insert["Attacked by Fetid Horrors|6:00:00|5%|5%|1|Daring:Inquisitive|Tough|Mishap"]
    Quest:Insert["Talons to the Face|6:00:00|5%|5%|1|Tough:Wise|Daring|Mishap"]
    
    ;Season 4
    ;Treasured
    Quest:Insert["A Miner Setback|1:00:00|5%|5%|1|Strong:Agile|Daring|Treasured"]
    Quest:Insert["Cloak of the Magi|1:00:00|5%|5%|1|Shrewd:Wise|Adventurous|Treasured"]
    Quest:Insert["Oversee the Overseer|1:00:00|5%|5%|1|Inquisitive:Daring|Adventurous|Treasured"]
    Quest:Insert["Runic Bow of Calling|1:30:00|10%|5%|1|Noble:Heroic|Explorative|Treasured"]
    Quest:Insert["Ice-forged Satchel|1:30:00|10%|5%|1|Daring:Secretive|Forager|Treasured"]
    Quest:Insert["Barking and Biting Back|1:30:00|10%|5%|1|Forager:Inquisitive|Cunning|Treasured"]
    Quest:Insert["Dance Haywire, Dance|1:30:00|10%|5%|1|Unpredictable:Forager|Secretive|Treasured"]
    Quest:Insert["Kill Zappodill|1:30:00|10%|5%|1|Inquisitive:Corrupt|Forager|Treasured"]
    Quest:Insert["Save Hedwocket Cobbleblork|2:00:00|15%|10%|1|Explorative|Shrewd|Treasured"]
    Quest:Insert["Eliminate Crumb Shinspitter|2:00:00|15%|10%|1|Forager|Adventurous|Treasured"]

    ;Legendary
    Quest:Insert["Tools of Success|2:30:00|10%|5%|2|Noble:Devoted:Lucky:Wise|Unpredictable:Daring|Legendary"]
    Quest:Insert["Blight and Light|2:30:00|10%|5%|2|Tough:Agile:Shrewd|Inquisitive:Daring|Legendary"]
    Quest:Insert["The Spellborn Relic|2:30:00|10%|5%|2|Adventurous:Unpredictable:Secretive:Inquisitive|Sly:Shrewd|Legendary"]
    Quest:Insert["Unrest in Butcherblock|3:30:00|15%|10%|2|Intelligent:Persuasive:Strong|Honest|Legendary"]
    Quest:Insert["Anon in Klak'Anon|3:30:00|15%|10%|2|Unpredictable:Explorative:Intelligent|Heroic|Legendary"]
    Quest:Insert["Do Not Count On the Count|3:30:00|15%|10%|2|Unflappable:Explorative:Sly|Lucky:Cunning|Legendary"]
    Quest:Insert["Some Sage Advice|5:00:00|20%|20%|2|Unflappable:Heroic|Inquisitive:Secretive|Legendary"]
    Quest:Insert["The Royal Band|5:00:00|20%|20%|2|Manipulative:Corrupt|Cunning:Noble|Legendary"]
    Quest:Insert["The Davissi Code|5:00:00|20%|20%|2|Charming:Secretive|Tough:Focused|Legendary"]
    Quest:Insert["Born to Somborn|5:00:00|20%|20%|2|Impatient:Dexterous|Stalwart:Adventurous|Legendary"]
    Quest:Insert["Throwing Down the Gauntlet|5:00:00|20%|20%|2|Explorative:Compassionate|Inquisitive:Secretive|Legendary"]

    ;Fabled
    Quest:Insert["Blood-Crusted Band|10:00:00|20%|30%|3|Cavalier:Explorative:Inquisitive:Unpredictable:Shrewd|Noble:Tough|Fabled"]
    Quest:Insert["Save Jamus Cornerlly|10:00:00|20%|30%|3|Dexterous:Secretive:Unpredictable:Daring:Adventurous|Lucky:Inquisitive|Fabled"]
    Quest:Insert["Retrieve the Amulet of Forsaken Rites|10:00:00|20%|30%|3|Unflappable:Heroic:Lucky:Strong:Shrewd|Agile:Wise|Fabled"]
    Quest:Insert["Eliminate Zylphax the Shredder|10:00:00|20%|30%|3|Inquisitive:Adventurous:Shrewd|Daring:Sly|Fabled"]
    Quest:Insert["The Ring of Blooding|10:00:00|20%|30%|3|Agile:Inquisitive:Noble:Forager:Diplomatic|Lucky:Impatient|Fabled"]
    ;Celestial
    Quest:Insert["Cuirass of Perpetuity|15:00:00|25%|30%|3|Adventurous:Daring:Heroic:Compassionate:Charming|Secretive:Shrewd|Celestial"]
    Quest:Insert["Eliminate Gardener Thirgen|15:00:00|25%|30%|3|Cavalier:Charming:Secretive:Unpredictable:Adventurous|Lucky:Heroic|Celestial"]
    Quest:Insert["Band of the Chosen|1:06:00:00|30%|30%|4|Explorative:Adventurous:Manipulative:Cavalier:Unflappable|Courageous:Heroic:Sly|Celestial"]
    Quest:Insert["Growth Requires Seeds|1:06:00:00|30%|30%|4|Daring:Impatient:Unflappable:Cavalier:Manipulative|Agile:Explorative:Intelligent|Celestial"]
    Quest:Insert["Rescue Simone Chelmonte|1:06:00:00|30%|30%|4|Righteous:Courageous:Diplomatic:Explorative:Agile|Sly:Secretive:Cavalier|Celestial"]

    ;Mishap
    Quest:Insert["Clawed From Behind|6:00:00|5%|5%|1|Adventurous:Unpredictable|Inquisitive|Mishap"]
    Quest:Insert["A Poisoned Arrow|4:00:00|5%|10%|1|Tough:Wise|Daring|Mishap"]
    Quest:Insert["Stabbed in the Leg|6:00:00|5%|5%|1|Daring:Inquisitive|Tough|Mishap"]
    Quest:Insert["Bitten by Werewolves|6:00:00|5%|5%|1|Wise:Noble|Unpredictable|Mishap"]
    Quest:Insert["Captured by the Bummer Gang|6:00:00|5%|5%|1|Inquisitive:Unpredictable|Adventurous|Mishap"]
    Quest:Insert["Captured by the Smokehorn Minotaur|6:00:00|5%|5%|1|Strong:Sly|Daring|Mishap"]
    Quest:Insert["Captured by the Tidesylphs|6:00:00|5%|5%|1|Daring:Agile|Adventurous|Mishap"]
    Quest:Insert["Captured by the Krukiel|4:00:00|5%|10%|1|Adventurous:Lucky|Daring|Mishap"]
    Quest:Insert["Captured by the Grikbar Kobolds|6:00:00|5%|5%|1|Shrewd:Adventurous|Inquisitive|Mishap"]
    Quest:Insert["Gored by the Bloodhorn|6:00:00|5%|5%|1|Daring:Lucky|Inquisitive|Mishap"]

    ;Season 4
    ;Treasured
    Agent:Insert["Mekland Frostbreak|"]
    Agent:Insert["Liddo Bowbeck|"]
    Agent:Insert["Powella Rimeblast|"]
    Agent:Insert["Larisca Farleaf|"]
    Agent:Insert["Joralda Strummer|"]
    Agent:Insert["Janizia Kharn|"]
    Agent:Insert["Frolabert Cringeward|"]
    Agent:Insert["Guthrie Arlond|"]
    Agent:Insert["Stella Vel'Raza|"]
    Agent:Insert["Stelgar Mortertoe|"]
    Agent:Insert["Maazz Blockhammer|"]
    Agent:Insert["Karla Tallspear|"]
    Agent:Insert["Aurther Gradenko|"]
    Agent:Insert["Jalira Waterfrost|"]
    Agent:Insert["Maazz Blockhammer|"]
    ;Legendary
    Agent:Insert["Urohg Shattershield|Daring"]
    Agent:Insert["Sandrine Tzofiya|Shrewd"]
    Agent:Insert["Donigal Sharpnote|Tough"]
    Agent:Insert["Isa Frondbow|Adventurous"]
    Agent:Insert["Welstar Nightfire|Wise"]
    Agent:Insert["Kyrcel D'Lan|Inquisitive"]
    Agent:Insert["Emia Cloudsong|Unpredictable"]
    Agent:Insert["Kleggo Flakbindle|Strong"]
    ;Fabled
    Agent:Insert["Meklor Brindlecog|Cautious:Inquisitive"]
    Agent:Insert["Andra Figglebloom|Agile:Explorative"]
    Agent:Insert["Crimson Theleh|Heroic:Sly"]
    Agent:Insert["Ceyonne the Blade|Daring:Secretive"]
    Agent:Insert["Vongrut Battlebreaker|Impatient:Lucky"]
    Agent:Insert["Achadina|Forager:Wise"]
    ;Celestial
    Agent:Insert["Doxah Eucalia, Champion of the Worthy|Compassionate:Devoted"]

    ;Season 1
    ;Treasured
    Agent:Insert["Bladimir Black|"]
    Agent:Insert["Cleric Sararah|"]
    Agent:Insert["Doric Silverhew|"]
    Agent:Insert["Galen Stormwolf|"]
    Agent:Insert["Garith Oldfoe|"]
    Agent:Insert["Grumpy Little Stelve|"]
    Agent:Insert["Inquisitor L'Morr|"]
    Agent:Insert["Milo Burningsun|"]
    Agent:Insert["Selmo Koriat|"]
    Agent:Insert["Sergeant Marcus Carpenter|"]
    Agent:Insert["Wizard Flurggledim|"]
    Agent:Insert["Young Michem|"]
    ;Legendary
    Agent:Insert["Druid Ellanha|Wise"]
    Agent:Insert["Garick the Mad|Tough"]
    Agent:Insert["Kror McKroffan|Strong"]
    Agent:Insert["Magnus Frostheart|Tough"]
    Agent:Insert["Mina Szekle|Agile"]
    Agent:Insert["Morac the Builder|Strong"]
    Agent:Insert["Rittan D'Sal|Agile"]
    Agent:Insert["Rosamond|Lucky"]
    ;Fabled
    Agent:Insert["Councilor Wrathburn|Persuasive:Sly"]
    Agent:Insert["Gretacia Windsong|Devoted:Noble"]
    Agent:Insert["King Grorlif|Cunning:Lucky"]
    Agent:Insert["Lucielyn L'Kirin|Focused:Sly"]
    Agent:Insert["Mingla Gelfshir|Vigilant:Wise"]
    Agent:Insert["Morlin Val'Sara|Honest:Noble"]
    ;Celestial
    Agent:Insert["Alexandrina X'Aphon|Charming:Cunning"]
    Agent:Insert["Klirgain the Mangler|Dexterous:Focused"]
    Agent:Insert["Velun Punox|Devoted:Diplomatic"]
    Agent:Insert["Xiang Jie|Cautious:Intelligent"]

    ;Season 2
    ;Treasured
    Agent:Insert["Simrin of the Hood|"]
    Agent:Insert["Coledo of the Shield|"]
    Agent:Insert["Ekkarim Trueshot|"]
    Agent:Insert["Emarin Clearmind|"]
    Agent:Insert["Glamden Dura|"]
    Agent:Insert["Captain Jackaron Blackflag|"]
    Agent:Insert["Janarra Spellglory|"]
    Agent:Insert["Malrissa Stormcloud|"]
    Agent:Insert["Ratakil Traploc|"]
    Agent:Insert["Ricorin Blazedeth|"]
    Agent:Insert["Shrehz Vashz|"]
    Agent:Insert["Vikeesh Flamestaff|"]
    ;Legendary
    Agent:Insert["Chlara Soulmender|Wise"]
    Agent:Insert["Donah Salvesetter|Noble"]
    Agent:Insert["Helacent Mindrender|Shrewd"]
    Agent:Insert["Janella Nadine, Tower Guard|Strong"]
    Agent:Insert["Kelita Soulshiv|Unpredictable"]
    Agent:Insert["Lord Pellun, Master of Coin|Shrewd"]
    Agent:Insert["Mikkler Draven|Lucky"]
    Agent:Insert["Tigrat Rushingpaw|Tough"]
    ;Fabled
    Agent:Insert["Aava Brightborn|Agile:Honest"]
    Agent:Insert["Akil Oporeh|Corrupt:Tough"]
    Agent:Insert["Dellon Verseturner|Lucky:Vigilant"]
    Agent:Insert["Elvidil Z'Vyath|Cunning:Sly"]
    Agent:Insert["Master Wort|Vigilant:Wise"]
    Agent:Insert["Thosa Kern|Cautious:Noble"]
    ;Celestial
    Agent:Insert["Belliza Morninglight, Warrior of Tunare|Compassionate:Devoted"]
    Agent:Insert["Thomasina Fe'Qar |Focused:Manipulative"]
    Agent:Insert["Ugar Malshadow, Guardian of the Blades|Dexterous:Persuasive"]
    Agent:Insert["Yalno Accelerato, the Dark Star|Impatient:Righteous"]

    ;Season 3
    ;Celestial
    Agent:Insert["Commander Aurabelle Shay, the Eidolon of Marr|Noble:Unflappable"]
    Agent:Insert["Doxah Eucalia, Champion of the Worthy|Compassionate:Devoted"]
    Agent:Insert["Lokud Sal'Vara|Impatient:Righteous"]
    Agent:Insert["Skyking Molad|Courageous:Stalwart"]
    ;Fabled
    Agent:Insert["Carnelia Cloudmoon|Adventurous:Persuasive"]
    Agent:Insert["Edris Thibadou|Cunning:Inquisitive"]
    Agent:Insert["Emilia Tailor|Adventurous:Cautious"]
    Agent:Insert["Ilbryen Iarxisys|Inquisitive:Stalwart"]
    Agent:Insert["Skylord Stormtalon|Honest:Unpredictable"]
    Agent:Insert["Zophaa Gaza|Daring:Focused"]
    ;Legendary
    Agent:Insert["Captain Tim Blair|Daring"]
    Agent:Insert["Eimi Brightbulb|Inquisitive"]
    Agent:Insert["Ganor Uryis|Adventurous"]
    Agent:Insert["Grim Stormshield |Tough"]
    Agent:Insert["Lark Goldfeather|Strong"]
    Agent:Insert["Mephis Umbrage|Shrewd"]
    Agent:Insert["Sal Harid|Unpredictable"]
    Agent:Insert["Walaric Bunce|Shrewd"]
    ;Treasured
    Agent:Insert["Akozag Gaank|"]
    Agent:Insert["Childebert Bottomhill|"]
    Agent:Insert["Dalarn Darkmana|"]
    Agent:Insert["Dirron Emberblood|"]
    Agent:Insert["Elmo Elmstaff|"]
    Agent:Insert["Gosunbert Fritzbang|"]
    Agent:Insert["Glark Bloodtalon|"]
    Agent:Insert["Guthrie Arlond|"]
    Agent:Insert["Master Bristles|"]
    Agent:Insert["Master Jennifer Brightsteel|"]
    Agent:Insert["Mirah Strong|"]
    Agent:Insert["Qourn Broadgrog|"]
    Agent:Insert["Stella Vel'Raza|"]
    Agent:Insert["Thuskis of Alivan|"]

    

    declare count int
	declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
		FP:MakeSubdirectory[RIOverseer]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/"]
	}
    if !${FP.FileExists[RIOSaveDefault.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIOSaveDefault.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIOSaveDefault.xml" http://www.isxri.com/RIOSaveDefault.xml
		wait 50
	}
	;check if RI.xml exists, if not create
	FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	if !${FP.PathExists}
	{
		FP:Set["${LavishScript.HomeDirectory}/Scripts/"]
		FP:MakeSubdirectory[RI]	
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/"]
	}
	if !${FP.FileExists[RIO.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIO.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIO.xml" http://www.isxri.com/RIO.xml
		wait 50
	}
    if !${FP.FileExists[RIOg.xml]}
	{
		if ${RI_Var_Bool_Debug}
			echo ${Time}: Getting RIOg.XML
		http -file "${LavishScript.HomeDirectory}/Scripts/RI/RIOg.xml" http://www.isxri.com/RIOg.xml
		wait 50
	}
    ui -reload "${LavishScript.HomeDirectory}/Interface/skins/eq2/eq2.xml"
	ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIO.xml"
    ui -reload -skin eq2 "${LavishScript.HomeDirectory}/Scripts/RI/RIOg.xml"

    UIElement[RIOverseer]:Hide
    UIElement[RIOverseerGQ]:Hide

    call RunChecks

    RIOverseerObj:PopulateGQ[3]
    RIOverseerObj:LoadSave

    Event[EQ2_onRewardWindowAppeared]:AttachAtom[EQ2_onRewardWindowAppeared]
    
    declarevariable i int 2
    declarevariable f int 1
    declarevariable traitcnt int 0
    declarevariable seconds int 0
    declarevariable secondscalc int 0
    declarevariable traitbuilder string ""
    declarevariable _completecnt int 0
    variable string MAg
    variable int _notraitcnt=1

    MyName:Set["${Me.Name}"]

    while 1
    {
       call RunChecks

        if ${MyName.NotEqual["${Me.Name}"]}
        {
            MyName:Set[${Me.Name}]
            RIOverseerObj:LoadSave
        }

        if !${UIElement[LoopOverseerCheckBox@RIOverseer].Checked} && !${RI_Var_Bool_Overseer_RunNow}
        {   
            if ${_GO}
            {
                call GO
                _GO:Set[0]
            }
            wait 10 ${RI_Var_Bool_Overseer_RunNow}
            continue
        }
        if !${UIElement[RunImmediatelyCheckBox@RIOverseer].Checked} && !${AlreadyWaitedOnce}
        {
            RI_Var_Bool_Overseer_RunNow:Set[0]
            scriptRunningTime:Set[${Script.RunningTime}]
            while ${Script.RunningTime}<=${Math.Calc[${scriptRunningTime}+${Math.Calc[${Int[${UIElement[MinsTextEntry@RIOverseer].Text}]}*60000]}]} && !${RI_Var_Bool_Overseer_RunNow}
            {
                if ${RI_Var_Bool_OverseerDebug}
                    echo ISXRI Overseer: 1st Waiting ${Math.Calc[(${Math.Calc[${scriptRunningTime}+${Math.Calc[${Int[${UIElement[MinsTextEntry@RIOverseer].Text}]}*60000]}]}-${Script.RunningTime})/1000].Precision[0]} seconds
                if ${_GO}
                {
                    call GO
                    _GO:Set[0]
                }
                wait 10 ${RI_Var_Bool_Overseer_RunNow}
            }
            AlreadyWaitedOnce:Set[1]
        }
        elseif ${UIElement[RunImmediatelyCheckBox@RIOverseer].Checked} && !${AlreadyWaitedOnce}
        {
            wait 150 ${RI_Var_Bool_Overseer_RunNow}
            AlreadyWaitedOnce:Set[1]
        }
        echo ${Time}: ISXRI Overseer: Running Checks
        ;this opens overseer window and gets data
        do
        {
            if !${EQ2UIPage[MainHUD,Minions].IsVisible}
                eq2ex TOGGLEOVERSEER
            else
            {
                eq2ex TOGGLEOVERSEER
                wait 2
                eq2ex TOGGLEOVERSEER
            }
            wait 5
        }
        while !${EQ2UIPage[MainHUD,Minions].IsVisible}
        ;wait 10
        ;first complete all quests so agents and quests are fresh data
        call RefreshAgents
        wait 5
        call RefreshQuests
        wait 5
        CompletingQuests:Set[1]
        for(i:Set[2];${i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].NumChildren};i:Inc)
        {
            if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Equal[":f:Complete!"]} && ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[textcolor].NotEqual[#DA3C3A]}
            {
                _completecnt:Inc
                EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}]:LeftClick
                wait 2
                while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Equal[":f:Complete!"]} && ${cnt:Inc}<300 && !${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14].GetProperty["Text"].Find["Owner"](exists)}
                {
                    
                    ;echo ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text]}
                    EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14]:LeftClick
                    wait 2
                    EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}]:LeftClick
                }
                if ${cnt}>=50
                {
                    echo ISXRI: Unable to complete overseer mission: ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[1].GetProperty[text]}
                    continue
                }
            }
        }
        if ${_completecnt}>0
        {
            call RefreshAgents
            wait 5
            call RefreshQuests
            wait 5
        }
        CompletingQuests:Set[0]
        ; ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[2].Child[4]}  -- minioncooldownpage

        
        ;echo before quests for loop
        variable string _tempQuestName
        variable bool _FoundQuestToRun=FALSE
        ;Here we need a loop, First Match all ready quests agents, then sort those, then find the first one in that list to run based off settings, 
        ;then we start over from scratch, after removing that quest from all our ready indexes and the agents from the agents ready lists
        ;loop this until we are done with our LOGIC
        QuestsReadySortedMatched:Insert[STARTER]
        ;wait 10000
        ;echo start while loop ( ${UIElement[RunChargedCheckBox@RIOverseer].Checked} || ${RI_Var_Overseer_Int_DailyCount}>0 ) && ${QuestsReady.Used}>0 && ${AgentsTraitsReady.Used}>0 && ${QuestsReadySortedMatched.Used}>0
        while ( ${UIElement[RunChargedCheckBox@RIOverseer].Checked} || ${RI_Var_Overseer_Int_DailyCount}>0 ) && ${QuestsReady.Used}>0 && ${AgentsTraitsReady.Used}>0 && ${QuestsReadySortedMatched.Used}>0
        {
            ;echo in loop
            call RunChecks
            call OverseerWindow
            ;echo start while loop ${Int[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventureCountReminder].Child[1].GetProperty[Text]}]}>0 && ${QuestsReady.Used}>0 && ${AgentsTraitsReady.Used}>0 && ${QuestsReadySortedMatched.Used}>0
            ;now go through each quest and match agents, add to new index to be sorted by match count and duration
            QuestsReadySortedMatched:Clear
            NonChargedCount:Set[0]
            ;echo //1:${Script.RunningTime}
            for(i:Set[1];${i}<=${QuestsReady.Used};i:Inc)
            {
                ;waitframe
                ;echo ${QuestsReady.Get[${i}]}
                if ${UIElement[RunChargedCheckBox@RIOverseer].Checked} && ${RI_Var_Overseer_Int_DailyCount}==0 && !${QuestsReady.Get[${i}].Token[1,|].Find["[Charged]"]}
                    continue
                if ${UIElement[RunChargedOnlyCheckBox@RIOverseer].Checked} && !${QuestsReady.Get[${i}].Token[1,|].Find["[Charged]"]}
                    continue
                ;first find our matching agents with traits
                ;${QuestsReady.Get[${i}].Token[1,|].ReplaceSubstring[" [Charged]",""]}-- QuestName
                _tempQuestName:Set["${QuestsReady.Get[${i}].Token[1,|].ReplaceSubstring[" [Charged]",""]}"]

                MAg:Set[${RIOverseerObj.MatchingAgents["${QuestsReady.Get[${i}].Token[6,|]}","${QuestsReady.Get[${i}].Token[7,|]}","${QuestsReady.Get[${i}].Token[9,|]}"]}]
                ;echo ISXRI: MAg: ${MAg} Quest: ${_tempQuestName} has ${Int[${MAg.Right[1]}]} Matching Agents, which are ${MAg.Left[-2]}, Quests Min: ${RIOverseerObj.QuestMinAgents["${_tempQuestName}"]} Max: ${RIOverseerObj.QuestMaxAgents["${_tempQuestName}"]}
                if ${Int[${MAg.Right[1]}]}>0 && ${Int[${MAg.Right[1]}]}>=${RIOverseerObj.MinTraitMatches["${QuestsReady.Get[${i}].Token[5,|]}"]}
                {
                    if !${QuestsReady.Get[${i}].Token[1,|].Find["[Charged]"]}
                        NonChargedCount:Inc
                    QuestsReadySortedMatched:Insert["${QuestsReady.Get[${i}]}|${MAg}"]
                }
            }
            ;echo ///////  First Sort //////
            ;wait 50
            ;echo ${QuestsReadySortedMatched.Used}
            ;for(i:Set[1];${i}<=${QuestsReadySortedMatched.Used};i:Inc)
            ;{
            ;    echo ${i}: ${QuestsReadySortedMatched.Get[${i}]}  //   ${QuestsReadySortedMatched.Get[${i}].Token[3,|].Token[2,:]}
            ;}
            ;now sort our matched ready quests by duration and number of traits matched
            variable string temp=""
            for(i:Set[1];${i}<=${QuestsReadySortedMatched.Used};i:Inc)
            {
                for(f:Set[1];${f}<=${QuestsReadySortedMatched.Used};f:Inc)
                {
                    if ${Int[${QuestsReadySortedMatched.Get[${f}].Token[3,|].Token[2,:]}]}==${Int[${QuestsReadySortedMatched.Get[${i}].Token[3,|].Token[2,:]}]} && ${Int[${QuestsReadySortedMatched.Get[${f}].Token[11,|]}]}<=${Int[${QuestsReadySortedMatched.Get[${i}].Token[11,|]}]}
                    {
                        ;echo ${QuestsReadySortedMatched.Get[${f}].Token[1,|]} is higher than ${QuestsReadySortedMatched.Get[${f}].Token[1,|]}
                        temp:Set["${QuestsReadySortedMatched.Get[${i}]}"]
                        QuestsReadySortedMatched:Set[${i},"${QuestsReadySortedMatched.Get[${f}]}"]
                        QuestsReadySortedMatched:Set[${f},"${temp}"]
                    }
                }
            }
            ;echo ///////  Second Sort //////
            ;echo ${QuestsReadySortedMatched.Used}
            ;echo QuestName|IndexNum|TimeSinceScriptInvoke:Duration|TextColor|QuestTier|QuestGoodTraits|QuestBadTraits|QuestMinAgents|QuestMaxAgents|MatchingAgents|MACount
            ;for(i:Set[1];${i}<=${QuestsReadySortedMatched.Used};i:Inc)
            ;{
            ;    echo ${i}: ${QuestsReadySortedMatched.Get[${i}]}  //   ${QuestsReadySortedMatched.Get[${i}].Token[3,|].Token[2,:]}
            ;}
            
            _FoundQuestToRun:Set[FALSE]
            ;wait 11111
            for(i:Set[1];${i}<=${QuestsReadySortedMatched.Used};i:Inc)
            {
                ;waitframe
                if ${_FoundQuestToRun} || ( ${QuestsReadySortedMatched.Get[${i}].Token[1,|].Find["[Charged]"]} && ${NonChargedCount}>0 )
                    continue
                ;echo checking ${QuestsReadySortedMatched.Get[${i}]}
                if ${RIOverseerObj.Checks["${QuestsReadySortedMatched.Get[${i}].Token[1,|]}"]}
                {
                    _FoundQuestToRun:Set[1]
                    _tempQuestName:Set["${QuestsReadySortedMatched.Get[${i}].Token[1,|].ReplaceSubstring[" [Charged]",""]}"]
                    MAg:Set["${QuestsReadySortedMatched.Get[${i}].Token[10,|]}"]
                    ;echo ${Math.Calc[${MAg.Count[:]}+1]}>=${RIOverseerObj.QuestMinAgents["${_tempQuestName}"]}

                    if ${Math.Calc[${MAg.Count[:]}+1]}>=${Int[${QuestsReadySortedMatched.Get[${i}].Token[8,|]}]}
                        call RunQuest ${QuestsReadySortedMatched.Get[${i}].Token[2,|]} "${QuestsReadySortedMatched.Get[${i}].Token[1,|]}" "${MAg}"
                    else
                    {
                        ;need to add notrait agents to get to minimum
                        ;if ${AgentsNoTraitsReady.Used}<${Math.Calc[${RIOverseerObj.QuestMinAgents["${Quests.Get[${i}].Token[1,|]}"]}-${Math.Calc[${MAg.Count[:]}+1]}]}
                         ;   continue
                        ;echo FAILCHECK: "${MAg}"
                        ;echo ANTR: ${AgentsNoTraitsReady.Used}
                        _notraitcnt:Set[1]
                        for(f:Set[${Math.Calc[${MAg.Count[:]}+1]}];${f}<${Int[${QuestsReadySortedMatched.Get[${i}].Token[8,|]}]};f:Inc)
                        {
                            MAg:Concat[":${AgentsNoTraitsReady.Get[${_notraitcnt}].Token[3,|]}"]
                            _notraitcnt:Inc
                        }
                        ;echo FAILCHECK: "${MAg}"
                        call RunQuest ${QuestsReadySortedMatched.Get[${i}].Token[2,|]} "${QuestsReadySortedMatched.Get[${i}].Token[1,|]}" "${MAg}"
                    }
                }
                else
                {
                    RIOverseerObj:RemoveReadyQuest["${QuestsReadySortedMatched.Get[${i}].Token[1,|]}"]
                }
            }
            waitframe
        }
        
        ;echo //2:${Script.RunningTime}
        ;echo ${QuestsReadySortedMatched.Used}
        ;for(i:Set[1];${i}<=${QuestsReadySortedMatched.Used};i:Inc)
        ;{
        ;    echo ${i}: ${QuestsReadySortedMatched.Get[${i}]}
        ;}
        ;if ${EQ2UIPage[MainHUD,Minions].IsVisible}
        ;   eq2ex TOGGLEOVERSEER
        cnt:Set[0]
        while ${EQ2UIPage[MainHUD,Minions].IsVisible} && ${cnt:Inc}<10
        {
            EQ2UIPage[MainHUD,Minions]:Close
            wait 3
        }
       
        ;for(i:Set[1];${i}<=${AgentsNoTraits.Used};i:Inc)
        ;{
        ;    echo ${i}: ${AgentsNoTraits.Get[${i}]}
        ;}
        ;in progress - #22FF22  //  on cooldown - #DA3C3A  // ready #FFFFFF
        ;echo Quests: QuestName|Index|Duration|Cooldown|Progress  < depends on the color
        ;for(i:Set[1];${i}<=${Quests.Used};i:Inc)
        ;{
        ;    
        ;    echo ${i}: ${Quests.Get[${i}]}
        ;}
        ;call RunQuest 3 "Retrieval for the Crown [Charged]" "58|11|1"
        ;echo done and waiting
        RI_Var_Bool_Overseer_RunNow:Set[0]
        scriptRunningTime:Set[${Script.RunningTime}]
        if ${RI_Var_Bool_OverseerDebug}
            echo ISXRI Overseer: Waiting ${Math.Calc[(${Math.Calc[${scriptRunningTime}+${Math.Calc[${Int[${UIElement[MinsTextEntry@RIOverseer].Text}]}*60000]}]}-${Script.RunningTime})/1000].Precision[0]} seconds
        while ${Script.RunningTime}<=${Math.Calc[${scriptRunningTime}+${Math.Calc[${Int[${UIElement[MinsTextEntry@RIOverseer].Text}]}*60000]}]} && !${RI_Var_Bool_Overseer_RunNow}
        {
            if ${_GO}
            {
                call GO
                _GO:Set[0]
            }
            wait 10 ${RI_Var_Bool_Overseer_RunNow}
        }
        if ${RI_Var_Bool_OverseerDebug}
            echo ISXRI Overseer: Done Waiting
        wait 10 ${RI_Var_Bool_Overseer_RunNow}
    }
}
function RunChecks()
{
    variable bool _CheckPos=FALSE
    if ${RI_Var_Bool_OverseerDebug} && ${RIOverseerObj.ZoneChecks}
    {
        echo ISXRI Overseer: Waiting while ineligible
        _CheckPos:Set[1]
    }
    while ${RIOverseerObj.ZoneChecks}
    {
        
        ;if ${EQ2UIPage[MainHUD,Minions].IsVisible} --- CRASHES CLIENT when at loginscene - plus i dont think its necessary there duh
         ;   EQ2UIPage[MainHUD,Minions]:Close
        wait 10
    }
    if ${RI_Var_Bool_OverseerDebug} && ${_CheckPos}
        echo ISXRI Overseer: Done Waiting while ineligible
}
function OverseerWindow()
{
    if !${EQ2UIPage[MainHUD,Minions].IsVisible}
    {
        do
        {
            if !${EQ2UIPage[MainHUD,Minions].IsVisible}
                eq2ex TOGGLEOVERSEER
            wait 5
        }
        while !${EQ2UIPage[MainHUD,Minions].IsVisible}

        RI_Var_Overseer_Int_DailyCount:Set[${Int[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventureCountReminder].Child[1].GetProperty[Text]}]}]

        if ${RI_Var_Bool_OverseerDebug}
            echo ISXRI Overseer: Setting RI_Var_Overseer_Int_DailyCount to ${Int[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventureCountReminder].Child[1].GetProperty[Text]}]} : ${RI_Var_Overseer_Int_DailyCount}
        
        call RefreshAgents
        wait 5
        call RefreshQuests
        wait 5
    }
}
function RunQuest(int _IndexNum, string _QuestName, string _AgentsToAdd)
{
    if ${RI_Var_Bool_OverseerDebug}
        echo ISXRI Overseer: RunQuest(int _IndexNum=${_IndexNum}, string _QuestName=${_QuestName}, string _AgentsToAdd=${_AgentsToAdd})
    variable string _tmp
    variable int _failcnt=0
    variable int _cnt=0
    ;Click Quest
    ;echo \${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text].NotEqual["${_QuestName}"]}
    ;echo ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text]}
    if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_IndexNum}].Child[1].Child[1].GetProperty[text].NotEqual["${_QuestName}"]}
    {
        for(i:Set[2];${i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].NumChildren};i:Inc)
        {
            ;waitframe
            if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[1].GetProperty[text].Equal["${_QuestName}"]}
            {
                _failcnt:Set[0]
                do
                {
                    if ${RIOverseerObj.ZoneChecks}
                        return
                    EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}]:LeftClick
                    if ${RI_Var_Bool_OverseerDebug}
                        echo ISXRI Overseer: Clicking Quest: ${_QuestName}: ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text].NotEqual["${_QuestName}"]}: ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text]}
                    wait 2
                }
                while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text].NotEqual["${_QuestName}"]} && ${_failcnt:Inc}<150
            }
        }
    }
    else
    {
        _failcnt:Set[0]
        do
        {
            if ${RIOverseerObj.ZoneChecks}
                return
            EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_IndexNum}]:LeftClick
            if ${RI_Var_Bool_OverseerDebug}
                echo ISXRI Overseer: Clicking Quest: ${_QuestName}: ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text].NotEqual["${_QuestName}"]}: ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text]}
            wait 1
        }
        while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text].NotEqual["${_QuestName}"]} && ${_failcnt:Inc}<150
    }
    if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage.AdventureDetailPage.AdventureNamePage].Child[1].GetProperty[text].NotEqual["${_QuestName}"]}
        return
    if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14].GetProperty[text].NotEqual[:f:Start Quest]}
    {
        _failcnt:Set[0]
        do
        {
            RIOverseerObj:RemoveReadyQuest["${_QuestName}"]
            wait 2
        }
        while ${RIOverseerObj.ReadyQuestExists["${_QuestName}"]} && ${_failcnt:Inc}<150
        return
    }
    ;first add mishap agent if thats what we are doing
    ;echo ${RIOverseerObj.QuestTier["${_QuestName}"]} // ${RIOverseerObj.QuestTier["${_QuestName}"].Find[Mishap]} 
    if ${RIOverseerObj.QuestTier["${_QuestName}"].Find[Mishap]}
    {
        call RIOverseerObj.AddMishapAgent
    }
    ;Add Agents
    if ${_AgentsToAdd.Find[:]}
    {   
        for(_cnt:Set[1];${_cnt}<=${Math.Calc[${_AgentsToAdd.Count[:]}+1]};_cnt:Inc)
        {
            if ${RIOverseerObj.ZoneChecks}
                return
            if ${RI_Var_Bool_OverseerDebug}
                echo ISXRI Overseer: Adding: ${_AgentsToAdd.Token[${_cnt},:]}: ${RIOverseerObj.AgentName[${_AgentsToAdd.Token[${_cnt},:]}]}
            _tmp:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[6].Child[2].Child[1].Child[${_cnt}].IconID}]
            _failcnt:Set[0]
            while ${_tmp.NotEqual[${_AgentsToAdd.Token[${_cnt},:]}]} && ${_failcnt:Inc}<60
            {
                if ${RIOverseerObj.ZoneChecks}
                    return
                ;echo // ${_tmp} == ${_AgentsToAdd.Token[${_cnt},:]}
                if ${_tmp.NotEqual[${_AgentsToAdd.Token[${_cnt},:]}]} && ${_tmp.NotEqual[-1]}
                    EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[6].Child[2].Child[1].Child[${_cnt}]:DoubleLeftClick
                wait 2
                EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${RIOverseerObj.AgentIndex[${_AgentsToAdd.Token[${_cnt},:]}]}]:DoubleLeftClick
                wait 3
                _tmp:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[6].Child[2].Child[1].Child[${_cnt}].IconID}]
            }
            ;${_AgentsToAdd.Token[${_cnt},:]}
            ;${RIOverseerObj.AgentIndex["${_AgentsToAdd.Token[${_cnt},:]}"]}
        }
    }
    else
    {
        if ${RI_Var_Bool_OverseerDebug}
            echo ISXRI Overseer: Adding: ${_AgentsToAdd}: ${RIOverseerObj.AgentName[${_AgentsToAdd}]}
        _tmp:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[6].Child[2].Child[1].Child[1].IconID}]
        _failcnt:Set[0]
        while ${_tmp.NotEqual[${_AgentsToAdd}]} && ${_failcnt:Inc}<60
        {
            if ${RIOverseerObj.ZoneChecks}
                return
            if ${_tmp.NotEqual[${_AgentsToAdd}]} && ${_tmp.NotEqual[-1]}
                EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[6].Child[2].Child[1].Child[1]:DoubleLeftClick
            wait 2
            EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${RIOverseerObj.AgentIndex[${_AgentsToAdd}]}]:DoubleLeftClick
            wait 3
            _tmp:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[6].Child[2].Child[1].Child[1].IconID}]
        }
    }
    ;sometime i would like to see if i can read this to create a loop
    if ${_QuestName.Equal["Heritage Hunt [Daily]"]}
        noop
    else
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[11].Child[2]:LeftClick
        wait 5
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[1].Child[1]:LeftClick
        wait 2
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[12].Child[2]:LeftClick
        wait 5
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[1].Child[1]:LeftClick
    }
    ;click Start Quest
    if ${RI_Var_Bool_OverseerDebug}
        echo ISXRI Overseer: Starting Quest: ${_QuestName}

    _failcnt:Set[0]
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14].GetProperty[text].Equal[:f:Start Quest]} && ${_failcnt:Inc}<60
    ; && ${poop}
    {
        if ${RIOverseerObj.ZoneChecks}
            return
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14]:LeftClick
        wait 5 ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14].GetProperty[text].NotEqual[:f:Start Quest]}
    }
    ;remove the quest from our ready lists
    ;RIOverseerObj:RemoveReadyQuest["${_QuestName}"]
    ;remove the agents from our ready lists - not necessary as we are refreshing agents
    ;if ${_AgentsToAdd.Find[:]}
    ;{   
    ;    for(_cnt:Set[1];${_cnt}<=${Math.Calc[${_AgentsToAdd.Count[:]}+1]};_cnt:Inc)
    ;    {
    ;        RIOverseerObj:RemoveReadyAgent["${_AgentsToAdd.Token[${_cnt},:]}"]    
    ;    }
    ;}
    ;else
    ;{
    ;    RIOverseerObj:RemoveReadyAgent["${_AgentsToAdd}"]
    ;}
    wait 5
    while ${RIOverseerObj.ZoneChecks}
        wait 10
    call RefreshAgents
    wait 5
    call RefreshQuests
    wait 5
    ;_failcnt:Set[0]
    ;do
    ;{
    ;    RIOverseerObj:RemoveReadyQuest["${_QuestName}"]
    ;    wait 2
    ;}
    ;while ${RIOverseerObj.ReadyQuestExists["${_QuestName}"]} && ${_failcnt:Inc}<150
}
function BuyFromVendor(string _VendorName, string _Item, int _Qty)
{
	if ${_Qty}<1
		return
	RI_CMD_PauseCombatBots 1
	wait 5
	variable int _failcnt=0
	while ${Target.ID}!=${Actor["${_VendorName}"].ID} && ${_failcnt:Inc}<150
	{
		Actor[Query, Name=="${_VendorName}"]:DoTarget
		Actor[Query, Name=-"${_VendorName}"]:DoTarget
		wait 2
	}
	_failcnt:Set[0]
	while !${MerchantWindow.IsVisible} && ${_failcnt:Inc}<150
	{
		Actor[Query, Name=="${_VendorName}"]:DoubleClick
		Actor[Query, Name=-"${_VendorName}"]:DoubleClick
		wait 5
	}
	wait 5
    variable int _cnt=0
    while ${_cnt:Inc}<=${_Qty}
    {
	    MerchantWindow.MerchantInventory["${_Item}"]:Buy[1]
        wait 2
    }
	wait 5
	RI_CMD_PauseCombatBots 0
}
function GO()
{
    echo ISXRI: Overseer, Running Get Charged Quests
    if ${UIElement[AddedQuestsListbox@RIOverseerGQ].Items}<1
    {
        RIConsole:Echo["You must select quests before we go and get them. Gont forget after adding quests to the Added Quests list to Save either as Toon or Default on the main RI Overseer UI Window"]
        MessageBox -skin eq2 "You must select quests before we go and get them. Gont forget after adding quests to the Added Quests list to Save either as Toon or Default on the main RI Overseer UI Window"
        return
    }
    if ${Zone.Name.Find["Qeynos Province District"]} && ${Me.Distance[972.459473,-25.561602,90.370720]}<20
    {
        call RIMObj.Move 972.459473 -25.561602 90.370720
    }
    elseif ${Zone.Name.Find["The City of Freeport"]} && ${Me.Distance[-245.846313,-56.063496,58.866585]}<20
    {
        call RIMObj.Move -245.846313 -56.063496 58.866585
    }
    else
    {
        RIMUIObj:FastTravel[ALL,Freeport]
        wait 50 ${EQ2.Zoning}==1
        if ${EQ2.Zoning}==0
        {
            RIMUIObj:FastTravel[ALL,Qeynos,1]
            wait 50 ${EQ2.Zoning}==1
        }
        wait 6000 ${EQ2.Zoning}==0
        if ${Zone.Name.Find["Qeynos Province District"]}
        {
            call RIMObj.Move 982.915527 -25.561602 77.915695 2 0 0 0 1 1 1 1
            call RIMObj.Move 972.459473 -25.561602 90.370720
        }
        elseif ${Zone.Name.Find["The City of Freeport"]}
        {
            call RIMObj.Move -230.351913 -56.064968 169.945190 2 0 0 0 1 1 1 1
            call RIMObj.Move -187.458328 -57.188896 168.242981 2 0 0 0 1 1 1 1
            call RIMObj.Move -185.843460 -57.002762 80.057274 2 0 0 0 1 1 1 1
            call RIMObj.Move -245.846313 -56.063496 58.866585
        }
    }
    variable int _i
    if !${EQ2UIPage[MainHUD,Minions].IsVisible}
        eq2ex TOGGLEOVERSEER
    else
    {
        eq2ex TOGGLEOVERSEER
        wait 2
        eq2ex TOGGLEOVERSEER
    }
    wait 1
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2].CanScrollUp}
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2]:ScrollUp
        waitframe
    }
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2].CanScrollDown}
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2]:ScrollDown
        waitframe
    }
    RIOverseerObj:GetCharges
    variable int _failcnt=0
	while ${Target.ID}!=${Actor["Stanley Parnem"].ID} && ${_failcnt:Inc}<150
	{
		Actor[Query, Name=="Stanley Parnem"]:DoTarget
		;Actor[Query, Name=-"Stanley Parnem"]:DoTarget
		wait 2
	}
	_failcnt:Set[0]
	while !${MerchantWindow.IsVisible} && ${_failcnt:Inc}<150
	{
		Actor[Query, Name=="Stanley Parnem"]:DoubleClick
		;Actor[Query, Name=-"Stanley Parnem"]:DoubleClick
		wait 5
	}
	wait 5
    variable int _ChargedCount
    variable int _ChargedQuestCount
    variable int _ChargedQuestCounter=0
    _ChargedQuestCount:Set[${Math.Calc[10-${GOChargedCnt.Used}]}]
    ;for(_i:Set[1];${_i}<=${GOQuest.Used};_i:Inc)
    ;{
    ;    if ${GOQuest.Get[${_i}].Token[2,|].Equal[Treasured]} && !${UIElement[GetTreasuredCheckBox@RIOverseer].Checked}
    ;        continue
    ;    if ${GOQuest.Get[${_i}].Token[2,|].Equal[Legendary]} && !${UIElement[GetLegendaryCheckBox@RIOverseer].Checked}
    ;        continue
    ;    if ${GOQuest.Get[${_i}].Token[2,|].Equal[Fabled]} && !${UIElement[GetFabledCheckBox@RIOverseer].Checked}
    ;        continue
    ;    _ChargedCount:Set[${RIOverseerObj.ChargedBuyCount["${GOQuest.Get[${_i}].Token[1,|]}"]}]
    ;    if ${_ChargedQuestCounter}>=${_ChargedQuestCount} && !${RIOverseerObj.ChargedQuestExists["${GOQuest.Get[${_i}].Token[1,|]}"]}
    ;    {
    ;        echo ISXRI: Skipping Buying "${GOQuest.Get[${_i}].Token[1,|]}" because we are at 10 charged quests !${RIOverseerObj.ChargedQuestExists["${GOQuest.Get[${_i}].Token[1,|]}"]}
    ;        continue
    ;    }
    ;    if ${MerchantWindow.MerchantInventory["${GOQuest.Get[${_i}].Token[1,|]}"](exists)} && ${_ChargedCount}>0
    ;    {
    ;        echo ISXRI: Buying and Consuming ${_ChargedCount} "${GOQuest.Get[${_i}].Token[1,|]}"
    ;        call BuyAndConsume "${GOQuest.Get[${_i}].Token[1,|]}" ${RIOverseerObj.ChargedBuyCount["${GOQuest.Get[${_i}].Token[1,|]}"]}
    ;        if !${RIOverseerObj.ChargedQuestExists["${GOQuest.Get[${_i}].Token[1,|]}"]}
    ;            _ChargedQuestCounter:Inc
    ;    }
    ;}
    ;${UIElement[AddedQuestsListbox@RIOverseerGQ]
    for(_i:Set[1];${_i}<=${UIElement[AddedQuestsListbox@RIOverseerGQ].Items};_i:Inc)
    {
        ;echo ${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}
        _ChargedCount:Set[${RIOverseerObj.ChargedBuyCount["${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}"]}]
        if ${_ChargedQuestCounter}>=${_ChargedQuestCount} && !${RIOverseerObj.ChargedQuestExists["${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}"]}
        {
            echo ISXRI: Skipping Buying "${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}" because we are at 10 charged quests !${RIOverseerObj.ChargedQuestExists["${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}"]}
            continue
        }
        if ${MerchantWindow.MerchantInventory["${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text} [Charged]"](exists)} && ${_ChargedCount}>0
        {
            echo ISXRI: Buying and Consuming ${_ChargedCount} "${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text} [Charged]"
            call BuyAndConsume "${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text} [Charged]" ${RIOverseerObj.ChargedBuyCount["${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}"]}
            if !${RIOverseerObj.ChargedQuestExists["${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}"]}
                _ChargedQuestCounter:Inc
        }
    }
    MerchantWindow:Close
    eq2ex target_none
    call RIMObj.CallToGuildHall
}
;atom triggered when incommingtext is detected
atom EQ2_onIncomingText(string Text)
{
	if ${Text.Find["The overseer quest failed to be added because adding charges would put you over the maximum amount of charges allowed for a charged quest"](exists)}
	{
		RI_Var_OverseerBACT:Set[1]
	}
}
function BuyAndConsume(string _QuestName, int _Qty)
{
    declarevariable RI_Var_OverseerBACT bool global FALSE
    Event[EQ2_onIncomingText]:AttachAtom[EQ2_onIncomingText]
    ;The overseer quest failed to be added because adding charges would put you over the maximum amount of charges allowed for a charged quest
    variable int _failcnt=0
    while ${RIMUIObj.InventoryQuantity["${_QuestName}"]}<${_Qty} && ${_failcnt:Inc}<60
    {
        call BuyFromVendor "Stanley Parnem" "${_QuestName}" ${Math.Calc[${_Qty}-${RIMUIObj.InventoryQuantity["${_QuestName}"]}]}
        wait 5
    }
    _failcnt:Set[0]
    RI_Var_OverseerBACT:Set[FALSE]
    while ${RIMUIObj.InventoryQuantity["${_QuestName}"]}>0 && ${_failcnt:Inc}<600 && !${RI_Var_OverseerBACT}
    {
        Me.Inventory[Query, Name=="${_QuestName}" && Location=="Inventory"]:Use
        wait 1
    }
    deletevariable RI_Var_OverseerBACT
    Event[EQ2_onIncomingText]:DetachAtom[EQ2_onIncomingText]
}
function RefreshQuests()
{
     ;QUESTS - you have to click on each individual quest to get the info inside
        ;${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[2]:LeftClick}
        ;${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].NumChildren}
        ;QUESTNAME - ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[1].GetProperty[text]}
        ;QuestDuration/Cooldown (need to check text color) - ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text]}

        ;${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[###].GetProperty[Name]}
        ;1: MercFamiliarSelectorWidget
        ;2: AdventureNamePage
        ;3: AdventureDescription
        ;4: AdvMinMinionsText
        ;5: AdventureTraits
        ;6: MinionAssignment
        ;7: BonusChancePercent    --- ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[7].GetProperty[text].Replace["%",""]}
        ;8: MishapChancePercent   --- ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[8].GetProperty[text].Replace["%",""]}
        ;9: MishapChanceLabel
        ;10: BonusChanceLabel
        ;11: MercAddWidget
        ;12: FamiliarAddWidget
        ;13: ChanceBackdrop
        ;14: AdventureActionButton EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[14]:LeftClick
        ;15: AdventureCancelButton
        ;16: RescuePage

    ;${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[5].Child[###].GetProperty[Name]}
    ;  ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[5].NumChildren} // this wont work always comes up 9 even if less traits not sure how to handle
    ;       OK i am stuck here because of the clients ui holding onto trait information from the last quest -- may have to toggle window for each quest -- dreading that
    ;       -- thats not feasible, may need to hardcode EVERY quest with its trait data into script, i know its alot of work but when done will be much faster and more reliable 
    ;           but will have to be digilient for all new added quests, I dont like this but i cant figure that shit out, althought it does save us from clicking every single quest in the book
    ;           only have to click the quest when you are needing to complete or want to run it
    ;           Actually it wont be so bad as here is a list i can copy and paste: https://eq2.fandom.com/wiki/All_Overseer_Quests
    ;1: PositiveTraitTemplate
    ;2: NegativeTraitTemplate
    ;3: AdventureTrait - Devoted
    ;4: AdventureTrait - Tough
    ;5: AdventureTrait - Sly
    ;6: AdventureTrait - Strong
    ;7: PosNegSeparator
    ;8: AdventureTrait - Noble
    ;9: AdventureTrait - Honest
    variable int _scrollcount
    _scrollcount:Set[0]
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2].CanScrollUp}
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2]:ScrollUp
        _scrollcount:Inc
        if ${_scrollcount}==3
        {
            _scrollcount:Set[0]
            waitframe
        }
    }
    _scrollcount:Set[0]
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2].CanScrollDown}
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[2]:ScrollDown
        _scrollcount:Inc
        if ${_scrollcount}==3
        {
            _scrollcount:Set[0]
            waitframe
        }
    }
    
    RI_Var_Overseer_Int_DailyCount:Set[${Int[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventureCountReminder].Child[1].GetProperty[Text]}]}]

    if ${RI_Var_Bool_OverseerDebug}
        echo ISXRI Overseer: Setting RI_Var_Overseer_Int_DailyCount to ${Int[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventureCountReminder].Child[1].GetProperty[Text]}]} : ${RI_Var_Overseer_Int_DailyCount}
    Quests:Clear
    variable string _QuestName
    for(i:Set[2];${i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].NumChildren};i:Inc)
    {
        ;waitframe
        _quest:Set["${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[1].GetProperty[text]}"]
        _QuestName:Set["${_quest.ReplaceSubstring[" [Charged]",""]}"]
        if !${RIOverseerObj.QuestExists["${_QuestName}"]}
        {
            echo ISXRI: Quest: "${_QuestName}" does not appear to be in our DB, please report to Herculezz or THG immediately
            continue
        }
        _quest:Concat["|${i}"]
        ;QuestsAgentsRequired:Insert["${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[4].GetProperty[text].ReplaceSubstring["Agents Required: ",""]}"]
        seconds:Set[0]
        secondscalc:Set[0]
        cnt:Set[0]

        if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Equal[":f:Complete!"]}
            continue

        if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Count[:]}>1
        {
            secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Token[1,:]}*3600]}]
            seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
            secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Token[2,:]}*60]}]
            seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
            seconds:Set[${Math.Calc[${seconds}+${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Token[3,:]}]}]
        }
        elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Count[:]}==1
        {
            secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Token[1,:]}*60]}]
            seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
            seconds:Set[${Math.Calc[${seconds}+${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text].Token[2,:]}]}]
        }
        else
            seconds:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[text]}]

        ;in progress - #22FF22  //  on cooldown - #DA3C3A
        _quest:Concat["|${Math.Calc[${Script.RunningTime}/1000].Precision[0]}:${seconds}|${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${i}].Child[1].Child[3].GetProperty[textcolor]}"]    
        _quest:Concat["|${RIOverseerObj.QuestTier["${_QuestName}"]}"]
        _quest:Concat["|${RIOverseerObj.QuestGoodTraits["${_QuestName}"]}"]
        _quest:Concat["|${RIOverseerObj.QuestBadTraits["${_QuestName}"]}"]
        _quest:Concat["|${RIOverseerObj.QuestMinAgents["${_QuestName}"]}"]
        _quest:Concat["|${RIOverseerObj.QuestMaxAgents["${_QuestName}"]}"]
        ;"${RIOverseerObj.QuestGoodTraits["${_tempQuestName}"]}","${RIOverseerObj.QuestBadTraits["${_tempQuestName}"]}","${RIOverseerObj.QuestMaxAgents["${_tempQuestName}"]}
        ;${RIOverseerObj.QuestTier["${_QuestName}"]}
        waitframe
        Quests:Insert["${_quest}"]
    }
    ;now check the quests, and add Ready Quests to our index and sort by token also run Heritage Daily first if ready
    QuestsReady:Clear
    for(i:Set[1];${i}<=${Quests.Used};i:Inc)
    {
        ;waitframe
        ;echo \${Quests.Get[${i}].Token[4,|].Equal[#FFFFFF]}
        ;echo ${Quests.Get[${i}].Token[4,|]}
        ;echo ${Quests.Get[${i}].Token[4,|].Equal[#FFFFFF]}
        if ${Quests.Get[${i}].Token[4,|].Equal[#FFFFFF]}
        {
            ;run our Heritage Hunt
            if ${Quests.Get[${i}].Token[1,|].Equal["Heritage Hunt [Daily]"]}
            {
                ;take the first 2 AgentsNoTraits and run quest
                if ${Math.Calc[${AgentsTraitsReady.Used}+${AgentsNoTraitsReady.Used}]}<2
                    continue
                elseif ${AgentsNoTraitsReady.Used}>1
                    call RunQuest ${Quests.Get[${i}].Token[2,|]} "${Quests.Get[${i}].Token[1,|]}" "${AgentsNoTraitsReady.Get[1].Token[3,|]}:${AgentsNoTraitsReady.Get[2].Token[3,|]}"
                elseif ${AgentsNoTraitsReady.Used}==1
                    call RunQuest ${Quests.Get[${i}].Token[2,|]} "${Quests.Get[${i}].Token[1,|]}" "${AgentsNoTraitsReady.Get[1].Token[3,|]}:${AgentsTraitsReady.Get[2].Token[3,|]}"
                elseif ${AgentsNoTraitsReady.Used}==0
                    call RunQuest ${Quests.Get[${i}].Token[2,|]} "${Quests.Get[${i}].Token[1,|]}" "${AgentsTraitsReady.Get[1].Token[3,|]}:${AgentsTraitsReady.Get[2].Token[3,|]}"

            }
            ;run our Mishap if it exists
            ;echo "${Quests.Get[${i}].Token[1,|]}": ${RIOverseerObj.IsMishap["${Quests.Get[${i}].Token[1,|]}"]} && ${UIElement[RunMishapCheckBox@RIOverseer].Checked}
            variable string MAg
            if ${Quests.Get[${i}].Token[5,|].Equal["Mishap"]} && ${UIElement[RunMishapCheckBox@RIOverseer].Checked} && ${RI_Var_Overseer_Int_DailyCount}>0
            {
                ;first find our matching agents with traits
                ;echo MisHap - ${Quests.Get[${i}].Token[1,|]} -- QuestName
                ;${RIOverseerObj.QuestGoodTraits["${Quests.Get[${i}].Token[1,|]}"]} --QuestGoodTraits
                ;${RIOverseerObj.QuestBadTraits["${Quests.Get[${i}].Token[1,|]}"]} --QuestBadTraits
                ;${RIOverseerObj.QuestMaxAgents["${Quests.Get[${i}].Token[1,|]}"]}  --QuestMaxAgents
                ;${RIOverseerObj.MatchingAgents["${RIOverseerObj.QuestGoodTraits["${Quests.Get[${i}].Token[1,|]}"]}","${RIOverseerObj.QuestBadTraits["${Quests.Get[${i}].Token[1,|]}"]}","${RIOverseerObj.QuestMaxAgents["${Quests.Get[${i}].Token[1,|]}"]}"]}
                MAg:Set["${RIOverseerObj.MatchingAgents["${Quests.Get[${i}].Token[6,|]}","${Quests.Get[${i}].Token[7,|]}","${Quests.Get[${i}].Token[9,|]}"]}"]
                if ${MAg.Token[2,|]}<${Int[${UIElement[RunMishapTextEntry@RIOverseer].Text}]}
                    continue
                ;echo ${MAg} // ${MAg.Token[2,|]}>=${RIOverseerObj.QuestMinAgents["${Quests.Get[${i}].Token[1,|]}"]}
                if ${MAg.Token[1,|].Equal[-1]}
                    MAg:Set["|0"]
                ;echo ///${MAg}
                if ${MAg.Token[2,|]}>=${Int[${Quests.Get[${i}].Token[8,|]}]}
                    call RunQuest ${Quests.Get[${i}].Token[2,|]} "${Quests.Get[${i}].Token[1,|]}" "${MAg.Left[-2]}"
                else
                {
                    if ${AgentsNoTraitsReady.Used}<${Math.Calc[${Int[${Quests.Get[${i}].Token[9,|]}]}-${Math.Calc[${MAg.Count[:]}+1]}]}
                        continue
                    ;echo MAg: ${MAg}
                    MAg:Set["${MAg.Left[-2]}"]
                    ;echo MAg: ${MAg}
                    ;need to add notrait agents to get to minimum
                    variable int _matchedagentsmishap=0
                    _matchedagentsmishap:Set[${MAg.Token[2,|]}]
                    ;echo ${AgentsNoTraitsReady.Used}
                    for(f:Set[1];${f}<=${Math.Calc[${Int[${Quests.Get[${i}].Token[8,|]}]}-${_matchedagentsmishap}]};f:Inc)
                    {
                        ;echo ${f} // ${f} // ${AgentsNoTraitsReady.Get[${f}]}
                        if ${f}==${Math.Calc[${Int[${Quests.Get[${i}].Token[8,|]}]}-${_matchedagentsmishap}]}
                            MAg:Concat["${AgentsNoTraitsReady.Get[${f}].Token[3,|]}"]
                        else
                            MAg:Concat["${AgentsNoTraitsReady.Get[${f}].Token[3,|]}:"]
                    }
                    call RunQuest ${Quests.Get[${i}].Token[2,|]} "${Quests.Get[${i}].Token[1,|]}" "${MAg}"
                }
            }
            else
            {
                ;echo ${RIOverseerObj.QuestTier["${Quests.Get[${i}].Token[1,|]}"]}  //  ${Quests.Get[${i}].Token[5,|]}
                switch ${Quests.Get[${i}].Token[5,|]}
                {
                    case Treasured
                    {
                        if ${Quests.Get[${i}].Token[1,|].Find["[Charged]"]}
                        {
                            if ${UIElement[RunTreasuredCheckBox@RIOverseer].Checked} && ${UIElement[RunChargedCheckBox@RIOverseer].Checked}
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        else
                        {
                            if ${UIElement[RunTreasuredCheckBox@RIOverseer].Checked}  
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        break
                    }
                    case Legendary
                    {
                        if ${Quests.Get[${i}].Token[1,|].Find["[Charged]"]}
                        {
                            if ${UIElement[RunLegendaryCheckBox@RIOverseer].Checked} && ${UIElement[RunChargedCheckBox@RIOverseer].Checked}
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        else
                        {
                            if ${UIElement[RunLegendaryCheckBox@RIOverseer].Checked}  
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        break
                    }
                    case Fabled
                    {
                        ;echo ${Quests.Get[${i}].Token[1,|].Find["[Charged]"]}
                        if ${Quests.Get[${i}].Token[1,|].Find["[Charged]"]}
                        {
                            ;echo 1 ${UIElement[RunTreasuredCheckBox@RIOverseer].Checked} && ${UIElement[RunChargedCheckBox@RIOverseer].Checked}
                            if ${UIElement[RunFabledCheckBox@RIOverseer].Checked} && ${UIElement[RunChargedCheckBox@RIOverseer].Checked}
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        else
                        {
                            if ${UIElement[RunFabledCheckBox@RIOverseer].Checked}  
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        break
                    }
                    case Celestial
                    {
                        if ${Quests.Get[${i}].Token[1,|].Find["[Charged]"]}
                        {
                            if ${UIElement[RunCelestialCheckBox@RIOverseer].Checked} && ${UIElement[RunChargedCheckBox@RIOverseer].Checked}
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        else
                        {
                            if ${UIElement[RunCelestialCheckBox@RIOverseer].Checked}  
                                QuestsReady:Insert["${Quests.Get[${i}]}"]
                        }
                        break
                    }
                }
            }
        }
    }
    ;echo after quests for loopecho before quests for loop
    ;echo BEFORE SORT: ${QuestsReady.Used}
    ;now sort our ReadyQuests by duration
    variable string temp
    for(i:Set[1];${i}<=${QuestsReady.Used};i:Inc)
    {
        for(f:Set[1];${f}<=${QuestsReady.Used};f:Inc)
        {
            if ${QuestsReady.Get[${f}].Token[3,|].Token[2,:]}<${QuestsReady.Get[${i}].Token[3,|].Token[2,:]}
            {
                temp:Set["${QuestsReady.Get[${i}]}"]
                QuestsReady:Set[${i},"${QuestsReady.Get[${f}]}"]
                QuestsReady:Set[${f},"${temp}"]
            }
        }
    }
    ;echo SORTED: ${QuestsReady.Used}
    ;for(i:Set[1];${i}<=${QuestsReady.Used};i:Inc)
    ;{
    ;    echo ${QuestsReady.Get[${i}]}
    ;}
    ;echo ${QuestsReady.Used}
}
function RefreshAgents()
{
    ;echo ////////////// REFRESH AGENTS /////////////////
    EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[1]:Set[0]
    wait 1
    variable int _scrollcount
    _scrollcount:Set[0]
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[2].CanScrollUp}
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[2]:ScrollUp
        _scrollcount:Inc
        if ${_scrollcount}==3
        {
            _scrollcount:Set[0]
            waitframe
        }
    }
    _scrollcount:Set[0]
    while ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[2].CanScrollDown}
    {
        EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[2]:ScrollDown
        _scrollcount:Inc
        if ${_scrollcount}==3
        {
            _scrollcount:Set[0]
            waitframe
        }
    }
    AgentsTraits:Clear
    AgentsNoTraits:Clear
    AgentsTraitsReady:Clear
    AgentsNoTraitsReady:Clear
    variable bool _ready=FALSE
    variable string _IconID=-1
    variable string _traits
    for(i:Set[2];${i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].NumChildren};i:Inc)
    {
        ;waitframe
        ;echo ${i}: ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[2].GetProperty[text]}
        _agent:Set["${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[2].GetProperty[text]}"]
        _agent:Concat["|${i}"]
        _IconID:Set["${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[1].IconID}"]
        _agent:Concat["|${_IconID}"]
        _agent:Concat["|${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[1].NodeID}"]
        traitcnt:Set[0]
        traitbuilder:Set[""]
        seconds:Set[0]
        secondscalc:Set[0]
        ;if ${_first}
        ;{
        ;   for (f:Set[1];${f}<=5;f:Inc)
        ;    {
        ;        if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[4].Child[${f}].GetProperty[TraitSearch].NotEqual[""]}
        ;        {
        ;            ;echo Trait ${f}: ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[4].Child[${f}].GetProperty[TraitSearch]}
        ;            traitbuilder:Concat["${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[4].Child[${f}].GetProperty[TraitSearch]}:"]
        ;            traitcnt:Inc
        ;        }

        ;    }
        ;}
        if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].NumChildren}>0
        {
            ;echo ${i}: ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[2].GetProperty[text]}: ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text]}
            _ready:Set[0]
            if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Equal["[Busy]"]}
                _agent:Concat["|BUSY"]
            elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Equal["[Idle]"]}
                _agent:Concat["|IDLE"]
            elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Equal["[Rescue]"]}
                _agent:Concat["|RESCUE"]
            else
            {
                if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Count[:]}>1
                {
                    secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[1,:]}*3600]}]
                    seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
                    secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[2,:]}*60]}]
                    seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
                    seconds:Set[${Math.Calc[${seconds}+${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[3,:]}]}]
                }
                elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Count[:]}==1
                {
                    secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[1,:]}*60]}]
                    seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
                    seconds:Set[${Math.Calc[${seconds}+${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[2,:]}]}]
                }
                else
                    seconds:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text]}]
                _agent:Concat["|${Math.Calc[${Script.RunningTime}/1000].Precision[0]}:${seconds}:${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[textcolor]}"]
            }
        }
        else
        {
            _ready:Set[1]
            _agent:Concat["|READY"]
        }
        ;echo Ready: ${_ready}: Agent: ${_agent}: IconID: ${_IconID} Traits: ${RIOverseerObj.AgentTraits["${_agent.Token[1,|]}"]}
        _traits:Set["${RIOverseerObj.AgentTraits["${_agent.Token[1,|]}"]}"]
        _agent:Concat["|${_traits}"]
        if ${_traits.Equal["-1"]}
        {
            AgentsNoTraits:Insert["${_agent}"]
            if ${_ready}
                AgentsNoTraitsReady:Insert["${_agent}"]
        }
        else
        {
            AgentsTraits:Insert["${_agent}"]
            if ${_ready}
                AgentsTraitsReady:Insert["${_agent}"]
        }
    }
    ;echo AgentsTraits: AgentName|Index|IconID|NodeID|Cooldown|Traits < mishap depends on the color
    ;for(i:Set[1];${i}<=${AgentsTraits.Used};i:Inc)
    ;{
    ;    echo ${i}: ${AgentsTraits.Get[${i}]}
    ;}
    ;echo AgentsNoTraits: AgentName|Index|IconID|NodeID|Cooldown|Traits(will be blank) < mishap depends on the color
    ;for(i:Set[1];${i}<=${AgentsNoTraits.Used};i:Inc)
    ;{
    ;    echo ${i}: ${AgentsNoTraits.Get[${i}]}
    ;}
    ;echo /////////// READY AGENTS ////////////
    ;RIOverseerObj:DisplayReadyAgents
    ;echo /////////// AGENT UI DATA ////////////
    ;RIOverseerObj:DisplayAgentUIData
    ;echo AgentsTraitsReady: ${AgentsTraitsReady.Used} AgentsNoTraitsReady: ${AgentsNoTraitsReady.Used}
    ;echo ////////////// REFRESH AGENTS END /////////////////
}
atom EQ2_onRewardWindowAppeared()
{
    if !${Script[${RI_Var_String_RunInstancesScriptName}](exists)} && !${Script[${RI_Var_String_RIInventoryScriptName}](exists)} && ${CompletingQuests}
	{
        RewardWindow:AcceptReward
    }
}
objectdef OverseerObj
{
    member:int MinTraitMatches(string _Tier)
    {
        switch ${_Tier}
        {
            case Treasured
            {
                return ${Int[${UIElement[RunTreasuredTextEntry@RIOverseer].Text}]}
                break
            }
            case Legendary
            {
                return ${Int[${UIElement[RunLegendaryTextEntry@RIOverseer].Text}]}
                break 
            }
            case Fabled
            {
                return ${Int[${UIElement[RunFabledTextEntry@RIOverseer].Text}]}
                break
            }
            case Celestial
            {
                return ${Int[${UIElement[RunCelestialTextEntry@RIOverseer].Text}]}
                break
            }
        }
    }
    method AddedQuestsListboxRightClick()
    {
        if ${UIElement[AddedQuestsListbox@RIOverseerGQ].SelectedItem(exists)}
		{
            UIElement[AddedQuestsListbox@RIOverseerGQ]:RemoveItem[${UIElement[AddedQuestsListbox@RIOverseerGQ].SelectedItem.ID}]
        }
    }
    method QuestsListboxClick()
    {
        ;echo ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text} // ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value}
        if ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem(exists)}
		{
            variable int i=0
			for(i:Set[1];${i}<=${UIElement[AddedQuestsListbox@RIOverseerGQ].Items};i:Inc)
			{
                ;echo ${UIElement[AddedQuestsListbox@RIOverseerGQ].Item[${i}].Text} // ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text} // ${UIElement[AddedQuestsListbox@RIOverseerGQ].Item[${i}].Text.Equal["${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text}"]}
				if ${UIElement[AddedQuestsListbox@RIOverseerGQ].Item[${i}].Text.Equal["${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text}"]}
					UIElement[AddedQuestsListbox@RIOverseerGQ]:RemoveItem[${UIElement[AddedQuestsListbox@RIOverseerGQ].Item[${i}].ID}]
			}
            if ${UIElement[AddedQuestsListbox@RIOverseerGQ].Items}>=10
            {
                RIConsole:Echo["You can only currently have 10 charged quests. Please right click to remove a quest in order to add a new one"]
                MessageBox -skin eq2 "You can only currently have 10 charged quests. Please right click to remove a quest in order to add a new one"
                return
            }
            if ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value.Equal[Celestial]}
			    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text}","${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value}",FF19BB19]
            elseif ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value.Equal[Fabled]}
			    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text}","${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value}",FFFF0BF6]
            elseif ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value.Equal[Legendary]}
			    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text}","${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value}",FFFFFF00]
            elseif ${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value.Equal[Treasured]}
			    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Text}","${UIElement[QuestsListbox@RIOverseerGQ].SelectedItem.Value}",FF0080FF]
        }
    }
    method GO()
    {
        echo ISXRI: Overseer, Queuing Get Charged Quests, this will run after Checks, if checks are running
        if ${UIElement[AddedQuestsListbox@RIOverseerGQ].Items}<1
        {
            RIConsole:Echo["You must select quests before we go and get them. Dont forget after adding quests to the Added Quests list to Save either as Toon or Default on the main RI Overseer UI"]
            MessageBox -skin eq2 "You must select quests before we go and get them. Dont forget after adding quests to the Added Quests list to Save either as Toon or Default on the main RI Overseer UI"
            return
        }
        _GO:Set[1]
        This:HideUI
        This:HideGQUI
    }
    method GQ()
    {
        UIElement[RIOverseerGQ]:Show
    }
    method PopulateGQ(int _Season)
    {
        variable int _i
        UIElement[QuestsListbox@RIOverseerGQ]:ClearItems
        for(_i:Set[1];${_i}<=${GOQuest.Used};_i:Inc)
        {
            if ${GOQuest.Get[${_i}].Token[3,|].Equal[${_Season}]}
            {
                if ${GOQuest.Get[${_i}].Token[2,|].Equal[Celestial]}
                    UIElement[QuestsListbox@RIOverseerGQ]:AddItem["${GOQuest.Get[${_i}].Token[1,|]}","${GOQuest.Get[${_i}].Token[2,|]}",FF19BB19]
                elseif ${GOQuest.Get[${_i}].Token[2,|].Equal[Fabled]}
                    UIElement[QuestsListbox@RIOverseerGQ]:AddItem["${GOQuest.Get[${_i}].Token[1,|]}","${GOQuest.Get[${_i}].Token[2,|]}",FFFF0BF6]
                elseif ${GOQuest.Get[${_i}].Token[2,|].Equal[Legendary]}
                    UIElement[QuestsListbox@RIOverseerGQ]:AddItem["${GOQuest.Get[${_i}].Token[1,|]}","${GOQuest.Get[${_i}].Token[2,|]}",FFFFFF00]
                elseif ${GOQuest.Get[${_i}].Token[2,|].Equal[Treasured]}
                    UIElement[QuestsListbox@RIOverseerGQ]:AddItem["${GOQuest.Get[${_i}].Token[1,|]}","${GOQuest.Get[${_i}].Token[2,|]}",FF0080FF]
            }
        }
    }

    member:bool ChargedQuestExists(string _QuestName)
    {
        variable int _i
        for(_i:Set[1];${_i}<=${GOChargedCnt.Used};_i:Inc)
        {
            ;echo ${GOChargedCnt.Get[${_i}].Token[1,|].ReplaceSubstring[" [Charged]",""]} == ${_QuestName}
            if ${GOChargedCnt.Get[${_i}].Token[1,|].ReplaceSubstring[" [Charged]",""].Equal["${_QuestName}"]}
                return TRUE
        }
        return FALSE
    }
    member:bool ReadyQuestExists(string _QuestName)
    {
        variable int _i
        for(_i:Set[1];${_i}<=${QuestsReady.Used};_i:Inc)
        {
            ;echo ${QuestsReady.Get[${_i}].Token[1,|].ReplaceSubstring[" [Charged]",""]} == ${_QuestName}
            if ${QuestsReady.Get[${_i}].Token[1,|].Equal["${_QuestName}"]}
                return TRUE
        }
        return FALSE
    }
    method GetCharges()
    {
        ;; Charges
        ;${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_i}].Child[1].Child[2].GetProperty[text]}
        ;; questname
        ;${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_i}].Child[1].Child[1].GetProperty[text]}
        GOChargedCnt:Clear
        variable int _i
        for(_i:Set[2];${_i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].NumChildren};_i:Inc)
        {
            if ${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_i}].Child[1].Child[1].GetProperty[text].Find["[Charged]"](exists)}
                GOChargedCnt:Insert["${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_i}].Child[1].Child[1].GetProperty[text]}|${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[3].Child[1].Child[${_i}].Child[1].Child[2].GetProperty[text]}"]
        }
        eq2ex TOGGLEOVERSEER
    }
    member:int ChargedBuyCount(string _QuestName)
    {
        variable int _i
        for(_i:Set[1];${_i}<=${GOChargedCnt.Used};_i:Inc)
		{
            if ${GOChargedCnt.Get[${_i}].Token[1,|].Find["${_QuestName}"](exists)}
                return ${Math.Calc[10-${GOChargedCnt.Get[${_i}].Token[2,|]}]}
        }
        return 10
    }
    method Save(bool _Toon)
	{
		LavishSettings[RIO]:Clear
		LavishSettings:AddSet[RIO]
        LavishSettings[RIO]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/RIOSave${Me.Name}.xml"]
        LavishSettings[RIO]:AddSetting[RunTreasured,"${UIElement[RunTreasuredCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunLegendary,"${UIElement[RunLegendaryCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunFabled,"${UIElement[RunFabledCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunCelestial,"${UIElement[RunCelestialCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunMishap,"${UIElement[RunMishapCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunCharged,"${UIElement[RunChargedCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunChargedAfterDaily,"${UIElement[RunChargedAfterDailyCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunChargedOnly,"${UIElement[RunChargedOnlyCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[LoopOverseer,"${UIElement[LoopOverseerCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[RunImmediately,"${UIElement[RunImmediatelyCheckBox@RIOverseer].Checked}"]
        LavishSettings[RIO]:AddSetting[LoopOverseerMins,"${Int[${UIElement[MinsTextEntry@RIOverseer].Text}]}"]
        LavishSettings[RIO]:AddSetting[TreasuredMinTraits,"${Int[${UIElement[RunTreasuredTextEntry@RIOverseer].Text}]}"]
        LavishSettings[RIO]:AddSetting[LegendaryMinTraits,"${Int[${UIElement[RunLegendaryTextEntry@RIOverseer].Text}]}"]
        LavishSettings[RIO]:AddSetting[FabledMinTraits,"${Int[${UIElement[RunFabledTextEntry@RIOverseer].Text}]}"]
        LavishSettings[RIO]:AddSetting[CelestialMinTraits,"${Int[${UIElement[RunCelestialTextEntry@RIOverseer].Text}]}"]
        LavishSettings[RIO]:AddSetting[MishapMinTraits,"${Int[${UIElement[RunMishapTextEntry@RIOverseer].Text}]}"]

        variable int _i
        for(_i:Set[1];${_i}<=${UIElement[AddedQuestsListbox@RIOverseerGQ].Items};_i:Inc)
		{
			;echo Adding ${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text} To Set ${_i}
            LavishSettings[RIO]:AddSetting[GQ${_i},"${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Text}|${UIElement[AddedQuestsListbox@RIOverseerGQ].OrderedItem[${_i}].Value}"]
		}

        if ${_Toon}
        {
            LavishSettings[RIO]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/RIOSave${Me.Name}.xml"]
        }
        else
        {
            LavishSettings[RIO]:Export["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/RIOSaveDefault.xml"]
            TimedCommand 5 relay all RIOverseerObj:LoadSave
        }
	}
	method LoadSave()
	{
        declare FP filepath "${LavishScript.HomeDirectory}/Scripts/RI/"
		FP:Set["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/"]
        if ${FP.FileExists[RIOSave${Me.Name}.xml]}
		{
			LavishSettings[RIO]:Clear
			LavishSettings:AddSet[RIO]
			LavishSettings[RIO]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/RIOSave${Me.Name}.xml"]
		}
		elseif ${FP.FileExists[RIOSaveDefault.xml]}
		{
			LavishSettings[RIO]:Clear
			LavishSettings:AddSet[RIO]
			LavishSettings[RIO]:Import["${LavishScript.HomeDirectory}/Scripts/RI/RIOverseer/RIOSaveDefault.xml"]
		}
        if ${LavishSettings[RIO].FindSetting[LoopOverseer]}
            UIElement[LoopOverseerCheckBox@RIOverseer]:SetChecked
        else
            UIElement[LoopOverseerCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunImmediately]}
            UIElement[RunImmediatelyCheckBox@RIOverseer]:SetChecked
        else
            UIElement[RunImmediatelyCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[LoopOverseerMins](exists)}
            UIElement[MinsTextEntry@RIOverseer]:SetText[${Int[${LavishSettings[RIO].FindSetting[LoopOverseerMins]}]}]
        else
            UIElement[MinsTextEntry@RIOverseer]:SetText[30]
        if ${LavishSettings[RIO].FindSetting[TreasuredMinTraits](exists)}
        {
            UIElement[RunTreasuredTextEntry@RIOverseer]:SetText[${Int[${LavishSettings[RIO].FindSetting[TreasuredMinTraits]}]}]
        }
        else
            UIElement[RunTreasuredTextEntry@RIOverseer]:SetText[1]
        if ${LavishSettings[RIO].FindSetting[LegendaryMinTraits](exists)}
        {
            UIElement[RunLegendaryTextEntry@RIOverseer]:SetText[${Int[${LavishSettings[RIO].FindSetting[LegendaryMinTraits]}]}]
        }
        else
            UIElement[RunLegendaryTextEntry@RIOverseer]:SetText[1]
        if ${LavishSettings[RIO].FindSetting[FabledMinTraits](exists)}
        {
            UIElement[RunFabledTextEntry@RIOverseer]:SetText[${Int[${LavishSettings[RIO].FindSetting[FabledMinTraits]}]}]
        }
        else
            UIElement[RunFabledTextEntry@RIOverseer]:SetText[2]
        if ${LavishSettings[RIO].FindSetting[CelestialMinTraits](exists)}
        {
            UIElement[RunCelestialTextEntry@RIOverseer]:SetText[${Int[${LavishSettings[RIO].FindSetting[CelestialMinTraits]}]}]
        }
        else
            UIElement[RunCelestialTextEntry@RIOverseer]:SetText[2]
        if ${LavishSettings[RIO].FindSetting[MishapMinTraits](exists)}
        {
            UIElement[RunMishapTextEntry@RIOverseer]:SetText[${Int[${LavishSettings[RIO].FindSetting[MishapMinTraits]}]}]
        }
        else
            UIElement[RunMishapTextEntry@RIOverseer]:SetText[0]
        if ${LavishSettings[RIO].FindSetting[RunTreasured]}
        {
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunTreasuredCheckBox@RIOverseer]:SetChecked
        }
        else
            UIElement[RunTreasuredCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunLegendary]}
        {
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunLegendaryCheckBox@RIOverseer]:SetChecked
        }
        else
            UIElement[RunLegendaryCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunFabled]}
        {
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunFabledCheckBox@RIOverseer]:SetChecked
        }
        else
            UIElement[RunFabledCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunCelestial]}
        {
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunCelestialCheckBox@RIOverseer]:SetChecked
        }
        else
            UIElement[RunCelestialCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunMishap]}
        {
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunMishapCheckBox@RIOverseer]:SetChecked
        }
        else
            UIElement[RunMishapCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunCharged]}
            UIElement[RunChargedCheckBox@RIOverseer]:SetChecked
        else
            UIElement[RunChargedCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunChargedAfterDaily]}
            UIElement[RunChargedAfterDailyCheckBox@RIOverseer]:SetChecked
        else
            UIElement[RunChargedAfterDailyCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[RunChargedOnly]}
        {
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:SetChecked
            UIElement[RunChargedCheckBox@RIOverseer]:SetChecked
            UIElement[RunTreasuredCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunLegendaryCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunFabledCheckBox@RIOverseer]:UnsetChecked
            UIElement[RunCelestialCheckBox@RIOverseer]:UnsetChecked
        }
        else
            UIElement[RunChargedOnlyCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[GetTreasured]}
            UIElement[GetTreasuredCheckBox@RIOverseer]:SetChecked
        else
            UIElement[GetTreasuredCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[GetLegendary]}
            UIElement[GetLegendaryCheckBox@RIOverseer]:SetChecked
        else
            UIElement[GetLegendaryCheckBox@RIOverseer]:UnsetChecked
        if ${LavishSettings[RIO].FindSetting[GetFabled]}
            UIElement[GetFabledCheckBox@RIOverseer]:SetChecked
        else
            UIElement[GetFabledCheckBox@RIOverseer]:UnsetChecked
        variable int _i
        variable int _endi=999999999999999999999
        variable string _settingText
        UIElement[AddedQuestsListbox@RIOverseerGQ]:ClearItems
        for(_i:Set[1];${_i}<${_endi};_i:Inc)
		{
            _settingText:Set["${LavishSettings[RIO].FindSetting[GQ${_i}]}"]
            ;echo checking \${LavishSettings[RIO].FindSetting[GQ${_i}]}: ${LavishSettings[RIO].FindSetting[GQ${_i}]}: ${_settingText}
            if ${LavishSettings[RIO].FindSetting[GQ${_i}](exists)}
            {
                if ${_settingText.Token[2,|].Equal[Celestial]}
                    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${_settingText.Token[1,|]}",${_settingText.Token[2,|]},FF19BB19]
                elseif ${_settingText.Token[2,|].Equal[Fabled]}
                    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${_settingText.Token[1,|]}",${_settingText.Token[2,|]},FFFF0BF6]
                elseif ${_settingText.Token[2,|].Equal[Legendary]}
                    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${_settingText.Token[1,|]}",${_settingText.Token[2,|]},FFFFFF00]
                elseif ${_settingText.Token[2,|].Equal[Treasured]}
                    UIElement[AddedQuestsListbox@RIOverseerGQ]:AddItem["${_settingText.Token[1,|]}",${_settingText.Token[2,|]},FF0080FF]
            }
            else
                _endi:Set[${_i}]
		}
	}
    member:bool ZoneChecks()
    {
        if ${EQ2.Zoning}!=0 || ${Me.IsCamping} || !${Me.InGameWorld} || ${Zone.Name.Equal[LoginScene]} || !${Me.Name(exists)} || !${Me.Health(exists)}
            return TRUE
        else
            return FALSE
    }
    method RunNow()
    {
        RI_Var_Bool_Overseer_RunNow:Set[1]
        This:HideUI
    }
    method ShowUI()
    {
        UIElement[RIOverseer]:Show
    }
    method HideUI()
    {
        UIElement[RIOverseer]:Hide
    }
    method HideGQUI()
    {
        UIElement[RIOverseerGQ]:Hide
    }
    function AddMishapAgent()
    {
        ;echo ADDDDDD
        variable string _tmp
        variable int _failcnt
        for(i:Set[2];${i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].NumChildren};i:Inc)
        {
            if ${This.ZoneChecks}
                return
            ;echo ${i}
            if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[textcolor].Equal[#DA3C3A]}
            {
                _tmp:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[16].Child[2].IconID}]
                _failcnt:Set[0]
                while ${_tmp.NotEqual[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[1].IconID}]} && ${_failcnt:Inc}<60
                {
                    if ${This.ZoneChecks}
                        return
                    ;echo ${_temp} == ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[1].IconID}
                    EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}]:DoubleLeftClick
                    wait 5
                    _tmp:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,AdventuresTabPage].Child[2].Child[16].Child[2].IconID}]
                }
                return
            }
        }
    }
    method DisplayAgentUIData()
    {
        echo //////////////////// Agent UI Data ///////////////////
        for(i:Set[2];${i}<=${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].NumChildren};i:Inc)
        {
            variable string _agent
            _agent:Set["${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[2].GetProperty[text]}"]
            _agent:Concat["|${i}"]
            _agent:Concat["|${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[1].IconID}"]
            _agent:Concat["|${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[1].NodeID}"]
            traitcnt:Set[0]
            traitbuilder:Set[""]
            seconds:Set[0]
            secondscalc:Set[0]
            for (f:Set[1];${f}<=5;f:Inc)
            {
                if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[4].Child[${f}].GetProperty[TraitSearch].NotEqual[""]}
                {
                    ;echo Trait ${f}: ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[4].Child[${f}].GetProperty[TraitSearch]}
                    traitbuilder:Concat["${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[4].Child[${f}].GetProperty[TraitSearch]}:"]
                    traitcnt:Inc
                }
            }
            _agent:Concat["|${traitbuilder.Left[-1]}"]
            if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].NumChildren}>0
            {
                if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Equal["[Busy]"]}
                    _agent:Concat["|BUSY"]
                elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Equal["[Idle]"]}
                    _agent:Concat["|IDLE"]
                elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Equal["[Rescue]"]}
                    _agent:Concat["|RESCUE"]
                else
                {
                    if ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Count[:]}>1
                    {
                        secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[1,:]}*3600]}]
                        seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
                        secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[2,:]}*60]}]
                        seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
                        seconds:Set[${Math.Calc[${seconds}+${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[3,:]}]}]
                    }
                    elseif ${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Count[:]}==1
                    {
                        secondscalc:Set[${Math.Calc[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[1,:]}*60]}]
                        seconds:Set[${Math.Calc[${seconds}+${secondscalc}]}]
                        seconds:Set[${Math.Calc[${seconds}+${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text].Token[2,:]}]}]
                    }
                    else
                        seconds:Set[${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[text]}]
                    _agent:Concat["|${Math.Calc[${Script.RunningTime}/1000].Precision[0]}:${seconds}:${EQ2UIPage[MainHUD,Minions].Child[Page,MinionList].Child[3].Child[1].Child[${i}].Child[3].Child[2].GetProperty[textcolor]}"]
                }
            }
            else
            {
                _agent:Concat["|READY"]
            }
            echo ${_agent}
        }
    }
    member:bool Checks(string _QuestName)
    {
        ;echo Checks(string _QuestName=${_QuestName}, int _Stage=${_Stage})
        if ${_QuestName.Find["[Charged]"]}
        {
            ;echo 1
            if ${UIElement[RunChargedAfterDailyCheckBox@RIOverseer].Checked}
            {
                if ${RI_Var_Overseer_Int_DailyCount}==0
                    return TRUE
                else
                    return FALSE
            }
            else
                return TRUE
        }
        else
        {
            ;echo 2
            return TRUE
        }
    }
    member:bool QuestExists(string _QuestName)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
            if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]}
                return TRUE
        }
        return FALSE
    }
    member:string QuestGoodTraits(string _QuestName)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
            if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]}
                return ${Quest.Get[${_cnt}].Token[6,|]}
        }
    }
    member:string QuestTier(string _QuestName)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
            if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]}
                return ${Quest.Get[${_cnt}].Token[8,|]}
        }
    }
    member:string QuestBadTraits(string _QuestName)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
            if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]}
                return ${Quest.Get[${_cnt}].Token[7,|]}
        }
    }
    member:string QuestMinAgents(string _QuestName)
    {
        ;echo ${Quest.Get[${_cnt}].Token[5,|].Count[-]}
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
           if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]}
            {
                if ${Quest.Get[${_cnt}].Token[5,|].Count[-]}>0
                    return ${Quest.Get[${_cnt}].Token[5,|].Token[1,-]}
                else
                    return ${Quest.Get[${_cnt}].Token[5,|]}
            }
        }
    }
    method RemoveReadyQuest(string _QuestName)
    {
        ;echo ${QuestsReady.Used}
        variable int i
        for(i:Set[1];${i}<=${QuestsReady.Used};i:Inc)
		{
            if ${QuestsReady.Get[${i}].Token[1,|].Equal["${_QuestName}"]}
                QuestsReady:Remove[${i}]
            ;echo ${QuestsReady.Get[${i}]}
        }
        QuestsReady:Collapse
    }
    method RemoveReadyAgent(string _IconID)
    {
        variable int _cnt
        ;echo ${AgentsTraitsReady.Used} // ${AgentsNoTraitsReady.Used}
        for(_cnt:Set[1];${_cnt}<=${AgentsTraitsReady.Used};_cnt:Inc)
        {
            if ${AgentsTraitsReady.Get[${_cnt}].Token[3,|].Equal["${_IconID}"]}
                AgentsTraitsReady:Remove[${_cnt}]
        }
        for(_cnt:Set[1];${_cnt}<=${AgentsNoTraitsReady.Used};_cnt:Inc)
        {
            if ${AgentsNoTraitsReady.Get[${_cnt}].Token[3,|].Equal["${_IconID}"]}
                AgentsNoTraitsReady:Remove[${_cnt}]
        }
        AgentsTraitsReady:Collapse
        AgentsNoTraitsReady:Collapse
        ;echo ${AgentsTraitsReady.Used} // ${AgentsNoTraitsReady.Used}
    }
    method DisplayReadyQuests()
    {
        ;echo ${QuestsReady.Used}
        variable int i
        echo //////////////////// Ready Quests ///////////////////
        for(i:Set[1];${i}<=${QuestsReady.Used};i:Inc)
		{
           echo ${QuestsReady.Get[${i}]}
        }
    }
    method DisplayReadyAgents()
    {
        ;echo ${QuestsReady.Used}
        variable int i
        echo //////////////////// Agents w/ Traits ///////////////////
        for(i:Set[1];${i}<=${AgentsTraitsReady.Used};i:Inc)
		{
           echo ${AgentsTraitsReady.Get[${i}]}
        }
        echo //////////////////// Agents w/o Traits ///////////////////
        for(i:Set[1];${i}<=${AgentsNoTraitsReady.Used};i:Inc)
		{
           echo ${AgentsNoTraitsReady.Get[${i}]}
        }
    }
    member:string QuestMaxAgents(string _QuestName)
    {
        ;echo ${Quest.Get[${_cnt}].Token[5,|].Count[-]}
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
            if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]}
            {
                if ${Quest.Get[${_cnt}].Token[5,|].Count[-]}>0
                    return ${Quest.Get[${_cnt}].Token[5,|].Token[2,-]}
                else
                    return ${Quest.Get[${_cnt}].Token[5,|]}
            }
        }
    }
    member:int AgentIndex(string _IconID)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${AgentsTraits.Used};_cnt:Inc)
        {
            ;echo ${AgentsTraits.Get[${_cnt}].Token[3,|]} == ${_IconID}
            if ${AgentsTraits.Get[${_cnt}].Token[3,|].Equal["${_IconID}"]}
                return ${AgentsTraits.Get[${_cnt}].Token[2,|]}
        }
        for(_cnt:Set[1];${_cnt}<=${AgentsNoTraits.Used};_cnt:Inc)
        {
            if ${AgentsNoTraits.Get[${_cnt}].Token[3,|].Equal["${_IconID}"]}
                return ${AgentsNoTraits.Get[${_cnt}].Token[2,|]}
        }
    }
    member:string AgentTraits(string _IconID)
    {
        ;now accepts Agent Name or IconID
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Agent.Used};_cnt:Inc)
        {
            if ${Agent.Get[${_cnt}].Token[1,|].Equal["${This.AgentName["${_IconID}"]}"]} || ${Agent.Get[${_cnt}].Token[1,|].Equal["${_IconID}"]}
            {
                if ${Agent.Get[${_cnt}].Token[2,|].Equal[""]}
                    return -1
                else
                    return ${Agent.Get[${_cnt}].Token[2,|]}
            }
        }
        return -1
    }
    member:string AgentName(string _IconID)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${AgentsTraits.Used};_cnt:Inc)
        {
            if ${AgentsTraits.Get[${_cnt}].Token[3,|].Equal["${_IconID}"]}
                return ${AgentsTraits.Get[${_cnt}].Token[1,|]}
        }
        for(_cnt:Set[1];${_cnt}<=${AgentsNoTraits.Used};_cnt:Inc)
        {
            if ${AgentsNoTraits.Get[${_cnt}].Token[3,|].Equal["${_IconID}"]}
                return ${AgentsNoTraits.Get[${_cnt}].Token[1,|]}
        }
    }
    member:bool IsMishap(string _QuestName)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${Quest.Used};_cnt:Inc)
        {
            if ${Quest.Get[${_cnt}].Token[1,|].Equal["${_QuestName}"]} && ${Quest.Get[${_cnt}].Token[8,|].Equal["Mishap"]}
                return TRUE
        }
        return FALSE
    }
    method DisplayReadyTraitAgents()
    {
        variable int _cnt
        echo //////////////////// Ready Agents w/ Traits ///////////////////
        for(_cnt:Set[1];${_cnt}<=${AgentsTraitsReady.Used};_cnt:Inc)
        {
            echo ${AgentsTraitsReady.Get[${_cnt}]}
        }
    }
    member:int CountAgentsTraits(string _IconID)
    {
        variable int _cnt
        for(_cnt:Set[1];${_cnt}<=${AgentsTraits.Used};_cnt:Inc)
        {
            
            ;echo ${_IconID}:${AgentsTraits.Get[${_cnt}].Token[2,|]}:${Math.Calc[${AgentsTraits.Get[${_cnt}].Token[5,|].Count[:]}+1]}
            if ${AgentsTraits.Get[${_cnt}].Token[3,|].Equal[${_IconID}]}
            {
                if ${RIOverseerObj.AgentTraits["${_IconID}"].Count[:]}==-1
                    return 0
                else
                    return ${Math.Calc[${RIOverseerObj.AgentTraits["${_IconID}"].Count[:]}+1]}
            }
        }
    }
    member:string MatchingAgents(string _Traits, string _BadTraits, string _Max=0)
    {
        ;if ${RI_Var_Bool_OverseerDebug}
        ;    echo MatchingAgents(string _Traits=${_Traits}, string _BadTraits=${_BadTraits}, string _Max=${_Max})
        variable index:string Traits
        variable index:string MatchingAgents
        variable index:string UsedAgents
        variable int _cnt
        variable int _cnt2
        variable int _cnt3
        variable string _tempstring=""
        variable int _traitmatchcnt=0
        ;first add all our traits to our trait index
        for(_cnt:Set[1];${_cnt}<=${Math.Calc[${_Traits.Count[:]}+1]};_cnt:Inc)
        {
            Traits:Insert["${_Traits.Token[${_cnt},:]}"]
        }
        ;echo Traits: ${Traits.Used}
        ;;then go through each trait and find all matching agents
        for(_cnt:Set[1];${_cnt}<=${Traits.Used};_cnt:Inc)
        {
            _tempstring:Set["${RIOverseerObj.AgentsWithTrait["${Traits.Get[${_cnt}]}"]}"]
            ;echo ${_tempstring}//${Traits.Get[${_cnt}]}
            if ${_tempstring.Equal[""]}
                continue
            for(_cnt2:Set[1];${_cnt2}<=${Math.Calc[${_tempstring.Count[|]}+1]};_cnt2:Inc)
            {
                MatchingAgents:Insert["${_tempstring.Token[${_cnt2},|]}|${Traits.Get[${_cnt}]}"]
            }
        }
        ;echo MatchingAgents: ${MatchingAgents.Used}
        ;for(_cnt:Set[1];${_cnt}<=${MatchingAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${MatchingAgents.Get[${_cnt}]}
        ;}
        ;echo UsedAgents:${UsedAgents.Used}

        ;then count any that match twice, use them and remove those traits from the list
        variable index:string _agentmatchingtraits
        variable int macnt
        variable string removeTemp
        variable string matchedtrait
        macnt:Set[${MatchingAgents.Used}]
        for(_cnt:Set[1];${_cnt}<=${macnt};_cnt:Inc)
        {
            if ${UsedAgents.Used}==${_Max} || !${MatchingAgents.Get[${_cnt}](exists)}
                continue
            _agentmatchingtraits:Clear
            for(_cnt2:Set[1];${_cnt2}<=${macnt};_cnt2:Inc)
            {
                if ${MatchingAgents.Get[${_cnt}].Token[1,|].Equal["${MatchingAgents.Get[${_cnt2}].Token[1,|]}"]}
                    _agentmatchingtraits:Insert["${MatchingAgents.Get[${_cnt2}].Token[2,|]}"]
            }
            if ${_agentmatchingtraits.Used}>1
            {
                ;add agent to usedagents
                UsedAgents:Insert["${MatchingAgents.Get[${_cnt}].Token[1,|]}"]
                _traitmatchcnt:Inc
                _traitmatchcnt:Inc
                removeTemp:Set["${MatchingAgents.Get[${_cnt}].Token[1,|]}"]
                ;remove them from MatchingAgents so we dont check them again
                MatchingAgents:Remove[${_cnt}]
                for(_cnt3:Set[1];${_cnt3}<=${macnt};_cnt3:Inc)
                {
                    ;echo ${MatchingAgents.Get[${_cnt3}].Token[1,|]}==${removeTemp}
                    if ${MatchingAgents.Get[${_cnt3}].Token[1,|].Equal[${removeTemp}]}
                    {
                        MatchingAgents:Remove[${_cnt3}]
                    }
                }
                ;remove all agents with the 2 traits,except doubles
                for(_cnt2:Set[1];${_cnt2}<=${_agentmatchingtraits.Used};_cnt2:Inc)
                {
                    for(_cnt3:Set[1];${_cnt3}<=${macnt};_cnt3:Inc)
                    {
                        if ${MatchingAgents.Get[${_cnt3}].Token[2,|].Equal[${_agentmatchingtraits.Get[${_cnt2}]}]}
                        {
                            if ${RIOverseerObj.CountAgentsTraits[${MatchingAgents.Get[${_cnt3}].Token[1,|]}]}==1
                                MatchingAgents:Remove[${_cnt3}]
                        }
                    }
                }
            }
        }
        MatchingAgents:Collapse
        ;echo MatchingAgents: ${MatchingAgents.Used}  //  After 2 Matching
        ;for(_cnt:Set[1];${_cnt}<=${MatchingAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${MatchingAgents.Get[${_cnt}]}
        ;}
        ;echo UsedAgents:${UsedAgents.Used}
        ;for(_cnt:Set[1];${_cnt}<=${UsedAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${UsedAgents.Get[${_cnt}]}
        ;}
        ;now pick remaining traits agents, first grab ones with only 1 trait
        if ${UsedAgents.Used}!=${_Max}
        {
            macnt:Set[${MatchingAgents.Used}]
            for(_cnt:Set[1];${_cnt}<=${macnt};_cnt:Inc)
            {
                if ${UsedAgents.Used}==${_Max} || !${MatchingAgents.Get[${_cnt}](exists)}
                    continue
                if ${This.CountAgentsTraits["${MatchingAgents.Get[${_cnt}].Token[1,|]}"]}==1
                {
                    UsedAgents:Insert["${MatchingAgents.Get[${_cnt}].Token[1,|]}"]
                    _traitmatchcnt:Inc
                    matchedtrait:Set["${MatchingAgents.Get[${_cnt}].Token[2,|]}"]
                    for(_cnt2:Set[1];${_cnt2}<=${macnt};_cnt2:Inc)
                    {
                        ;echo ${MatchingAgents.Get[${_cnt2}].Token[2,|]} == ${matchedtrait}
                        if ${MatchingAgents.Get[${_cnt2}].Token[2,|].Equal["${matchedtrait}"]}
                        {
                            ;echo Removing ${_cnt2}
                            MatchingAgents:Remove[${_cnt2}]
                        }
                    }
                    ;echo Removing ${_cnt}
                    ;MatchingAgents:Remove[${_cnt}]  --  Above for loop will remove
                }
            }
        }
        MatchingAgents:Collapse
        ;echo MatchingAgents: ${MatchingAgents.Used}  // After 1 trait agent matches
        ;for(_cnt:Set[1];${_cnt}<=${MatchingAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${MatchingAgents.Get[${_cnt}]}
        ;}
        ;echo UsedAgents:${UsedAgents.Used}
        ;for(_cnt:Set[1];${_cnt}<=${UsedAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${UsedAgents.Get[${_cnt}]}
        ;}
        ;now pick remaining traits agents, now grab ones with 2 traits // need to code to check against negative traits
        variable bool _FoundBadTrait=FALSE
        if ${UsedAgents.Used}!=${_Max}
        {
            macnt:Set[${MatchingAgents.Used}]
            for(_cnt:Set[1];${_cnt}<=${macnt};_cnt:Inc)
            {
                _FoundBadTrait:Set[0]
                for(_cnt2:Set[0];${_cnt2}<=${Math.Calc[${RIOverseerObj.AgentTraits["${MatchingAgents.Get[${_cnt}].Token[1,|]}"].Count[:]}+1]};_cnt2:Inc)
                {
                    ;echo ${_cnt2}<=${Math.Calc[${RIOverseerObj.AgentTraits["${MatchingAgents.Get[${_cnt}].Token[1,|]}"].Count[:]}+1]}
                    if ${_BadTraits.Find["${RIOverseerObj.AgentTraits["${MatchingAgents.Get[${_cnt}].Token[1,|]}"].Token[${_cnt2},:]}"](exists)}
                    {
                        ;echo \${RIOverseerObj.AgentTraits["${MatchingAgents.Get[${_cnt}].Token[1,|]}"].Token[${_cnt2},:]}
                        ;echo Found Bad Trait: ${RIOverseerObj.AgentTraits["${MatchingAgents.Get[${_cnt}].Token[1,|]}"].Token[${_cnt2},:]} in ${_BadTraits}
                        _FoundBadTrait:Set[1]
                    }
                }
                ;echo // ${_cnt}: "${MatchingAgents.Get[${_cnt}].Token[2,|]}"
                if ${UsedAgents.Used}==${_Max} || !${MatchingAgents.Get[${_cnt}](exists)} || ${_FoundBadTrait}
                {
                   ; echo max
                    continue
                }
                ;echo ${MatchingAgents.Get[${_cnt}](exists)} // ${MatchingAgents.Get[${_cnt}]} // ${MatchingAgents.Get[${_cnt}].Token[1,|]}
                
                
                UsedAgents:Insert["${MatchingAgents.Get[${_cnt}].Token[1,|]}"]
                _traitmatchcnt:Inc
                matchedtrait:Set["${MatchingAgents.Get[${_cnt}].Token[2,|]}"]
                for(_cnt2:Set[1];${_cnt2}<=${macnt};_cnt2:Inc)
                {
                    ;echo ${MatchingAgents.Get[${_cnt2}].Token[2,|]} == ${MatchingAgents.Get[${_cnt}].Token[2,|]}
                    if ${MatchingAgents.Get[${_cnt2}].Token[2,|].Equal["${matchedtrait}"]}
                    {
                        ;echo Removing ${_cnt2}
                        MatchingAgents:Remove[${_cnt2}]
                    }
                }
                ;echo Removing ${_cnt}
                MatchingAgents:Remove[${_cnt}]
            }
        }
        MatchingAgents:Collapse
        ;echo MatchingAgents: ${MatchingAgents.Used} // After 2 Trait agents with 1 trait matching
        ;for(_cnt:Set[1];${_cnt}<=${MatchingAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${MatchingAgents.Get[${_cnt}]}
        ;}
        ;echo UsedAgents:${UsedAgents.Used}
        ;for(_cnt:Set[1];${_cnt}<=${UsedAgents.Used};_cnt:Inc)
        ;{
        ;    echo ${_cnt}: ${UsedAgents.Get[${_cnt}]}
        ;}
        
        variable string _tempString=""
        if ${UsedAgents.Used}>0
        {
            for(_cnt:Set[1];${_cnt}<=${UsedAgents.Used};_cnt:Inc)
            {
                if ${_cnt}==${UsedAgents.Used}
                    _tempString:Concat["${UsedAgents.Get[${_cnt}]}"]
                else
                    _tempString:Concat["${UsedAgents.Get[${_cnt}]}:"]
            }
        }
        else
            _tempString:Set[-1]
        _tempString:Concat["|${_traitmatchcnt}"]
        ;echo ${_tempString}
        return ${_tempString}
    }
    member:string AgentsWithTrait(string _Trait)
    {
        variable int _cnt
        variable int _cnt2
        variable string _temp=""
        variable string _traits
        for(_cnt:Set[1];${_cnt}<=${AgentsTraitsReady.Used};_cnt:Inc)
        {
            ;if ${RI_Var_Bool_OverseerDebug}
             ;   echo ${RIOverseerObj.AgentTraits["${AgentsTraitsReady.Get[${_cnt}].Token[3,|]}"]} == ${_Trait}
            _traits:Set["${AgentsTraitsReady.Get[${_cnt}].Token[6,|]}"]
            if ${_traits.Count[:]}>0
            {
                ;2 trait agents
                for(_cnt2:Set[1];${_cnt2}<=${Math.Calc[${_traits.Count[:]}+1]};_cnt2:Inc)
                {
                    if ${_traits.Token[${_cnt2},:].Equal[${_Trait}]}
                        _temp:Concat["${AgentsTraitsReady.Get[${_cnt}].Token[3,|]}|"]
                }
            }
            else
            {
                ;1 trait agents
                if ${_traits.Equal[${_Trait}]}
                    _temp:Concat["${AgentsTraitsReady.Get[${_cnt}].Token[3,|]}|"]
            }
            
        }
        ;echo AgentsWithTrait: ${_Trait}: ${_temp.Left[-1]}
        return ${_temp.Left[-1]}
    }
}
atom(global) rio()
{
    if !${UIElement[RIOverseer].Visible}
        RIOverseerObj:ShowUI
}
function atexit()
{
    ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIO.xml"
    ui -unload "${LavishScript.HomeDirectory}/Scripts/RI/RIOg.xml"
}
