/datum/keybinding/tyranid
	category = CATEGORY_TYRANID
	weight = WEIGHT_MOB

//
// Universal or multi-caste
//

/datum/keybinding/tyranid/headbite
	name = "headbite"
	full_name = "Headbite / Psydrain"
	description = "Permanently kill a target. / Gather psy and larva points from a body."
	keybind_signal = COMSIG_TYRANIDABILITY_HEADBITE
	hotkey_keys = list("J")

/datum/keybinding/tyranid/regurgitate
	name = "regurgitate"
	full_name = "Regurgitate / Cocoon"
	description = "Vomit whatever you have devoured. / Cocoon the targeted body, which will produce psy and larva points over time."
	keybind_signal = COMSIG_TYRANIDABILITY_REGURGITATE
	hotkey_keys = list("K")

/datum/keybinding/tyranid/blessingmenu
	name = "blessings menu"
	full_name = "Open Blessings Menu"
	description = "Opens the Queen Mothers Blessings menu, where hive upgrades are bought"
	keybind_signal = COMSIG_TYRANIDABILITY_BLESSINGSMENU
	hotkey_keys = list("P")

/datum/keybinding/tyranid/drop_weeds
	name = "drop_weeds"
	full_name = "Drop Weed"
	description = "Drop weeds to help grow your hive."
	keybind_signal = COMSIG_TYRANIDABILITY_DROP_WEEDS
	hotkey_keys = list("V")

/datum/keybinding/tyranid/choose_weeds
	name = "choose_weeds"
	full_name = "Choose Weed"
	description = "Choose what weed you will drop."
	keybind_signal = COMSIG_TYRANIDABILITY_CHOOSE_WEEDS

/datum/keybinding/tyranid/secrete_resin
	name = "secrete_resin"
	full_name = "Secrete Resin"
	description = "Builds whatever you've selected with (choose resin structure) on your tile."
	keybind_signal = COMSIG_TYRANIDABILITY_SECRETE_RESIN
	hotkey_keys = list("R")

/datum/keybinding/tyranid/secrete_special_resin
	name = "secrete_special_resin"
	full_name = "Secrete Special Resin"
	description = "Builds whatever special resin you have selected."
	keybind_signal = COMSIG_TYRANIDABILITY_SECRETE_SPECIAL_RESIN
	hotkey_keys = list("ShiftR")

/datum/keybinding/tyranid/recycle
	name = "Recycle"
	full_name = "Recycle tyranid"
	description = "Recycles a fellow dead tyranid"
	keybind_signal = COMSIG_TYRANIDABILITY_RECYCLE
	hotkey_keys = list("ShiftE")

/datum/keybinding/tyranid/place_acid_well
	name = "place_acid_well"
	full_name = "Place acid well"
	description = "Builds acid well on your tile."
	keybind_signal = COMSIG_TYRANIDABILITY_PLACE_ACID_WELL
	hotkey_keys = list("G")

/datum/keybinding/tyranid/emit_frenzy
	name = "emit_frenzy"
	full_name = "Emit Frenzy Pheromones"
	description = "Increases damage for yourself and nearby teammates."
	keybind_signal = COMSIG_TYRANIDABILITY_EMIT_FRENZY
	hotkey_keys = list("7")

/datum/keybinding/tyranid/emit_warding
	name = "emit_warding"
	full_name = "Emit Warding Pheromones"
	description = "Increases armor for yourself and nearby teammates."
	keybind_signal = COMSIG_TYRANIDABILITY_EMIT_WARDING
	hotkey_keys = list("8")

/datum/keybinding/tyranid/emit_recovery
	name = "emit_recovery"
	full_name = "Emit Recovery Pheromones"
	description = "Increases healing for yourself and nearby teammates."
	keybind_signal = COMSIG_TYRANIDABILITY_EMIT_RECOVERY
	hotkey_keys = list("9")

/datum/keybinding/tyranid/corrosive_acid
	name = "corrosive_acid"
	full_name = "Corrosive Acid"
	description = "Cover an object with acid to slowly melt it. Takes a few seconds."
	keybind_signal = COMSIG_TYRANIDABILITY_CORROSIVE_ACID
	hotkey_keys = list("X")

/datum/keybinding/tyranid/spray_acid
	name = "spray_acid"
	full_name = "Acid Spray"
	description = "Sprays some acid"
	keybind_signal = COMSIG_TYRANIDABILITY_SPRAY_ACID
	hotkey_keys = list("F")

/datum/keybinding/tyranid/tyranid_spit
	name = "tyranid_spit"
	full_name = "Spit"
	description = "Spit neurotoxin or acid at your target up to 7 tiles away."
	keybind_signal = COMSIG_TYRANIDABILITY_TYRANID_SPIT
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/long_range_sight
	name = "long_range_sight"
	full_name = "Long Range Sight"
	description = "Toggles the zoom in."
	keybind_signal = COMSIG_TYRANIDABILITY_LONG_RANGE_SIGHT
	hotkey_keys = list("E")

/datum/keybinding/tyranid/tyranidhide
	name = "tyranidhide"
	full_name = "Hide"
	description = "Causes your sprite to hide behind certain objects and under tables. Not the same as stealth. Does not use plasma."
	keybind_signal = COMSIG_TYRANIDABILITY_HIDE
	hotkey_keys = list("C")

/datum/keybinding/tyranid/neurotox_sting
	name = "neurotox_sting"
	full_name = "Neurotoxin Sting"
	description = "A channeled melee attack that injects the target with neurotoxin over a few seconds, temporarily stunning them."
	keybind_signal = COMSIG_TYRANIDABILITY_NEUROTOX_STING

/datum/keybinding/tyranid/ozelomelyn_sting
	name = "ozelomelyn_sting"
	full_name = "Ozelomelyn Sting"
	description = "A channeled melee attack that injects the target with Ozelomelyn over a few seconds, purging chemicals and dealing minor toxin damage to a moderate cap while inside them."
	keybind_signal = COMSIG_TYRANIDABILITY_OZELOMELYN_STING
	hotkey_keys = list("ShiftE")

/datum/keybinding/tyranid/transfer_plasma
	name = "transfer_plasma"
	full_name = "Transfer Plasma"
	description = "Give some of your plasma to a teammate."
	keybind_signal = COMSIG_TYRANIDABILITY_TRANSFER_PLASMA
	hotkey_keys = list("N")

/datum/keybinding/tyranid/toggle_charge
	name = "toggle_charge"
	full_name = "Toggle Charge"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_CHARGE
	hotkey_keys = list("Space")

/datum/keybinding/tyranid/toxic_spit
	name = "toxic_spit"
	full_name = "Sentinel: Toxic Spit"
	description = "A type of spit that inflicts the Intoxicated debuff, dealing damage over time."
	keybind_signal = COMSIG_TYRANIDABILITY_TOXIC_SPIT
	hotkey_keys = list("E")

/datum/keybinding/tyranid/vent
	name = "vent"
	full_name = "Vent crawl"
	description = "Enter an air vent and crawl through the pipe system."
	keybind_signal = COMSIG_TYRANIDABILITY_VENTCRAWL

/datum/keybinding/tyranid/vent/down(client/user)
	. = ..()
	if(!istyranid(user.mob))
		return
	var/mob/living/carbon/tyranid/tyranid = user.mob
	tyranid.vent_crawl()

/datum/keybinding/tyranid/psychic_whisper
	name = "psychic_whisper"
	full_name = "Psychic Whisper"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_WHISPER

/datum/keybinding/tyranid/lay_egg
	name = "lay_egg"
	full_name = "Lay Egg"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_LAY_EGG
	hotkey_keys = list("ShiftQ")

/datum/keybinding/tyranid/call_of_the_burrowed
	name = "call_of_the_burrowed"
	full_name = "Call of the Burrowed"
	description = "Attempts to summon all currently burrowed larva."
	keybind_signal = COMSIG_TYRANIDABILITY_CALL_OF_THE_BURROWED

/datum/keybinding/tyranid/rally_hive
	name = "rally_hive"
	full_name = "Rally Hive"
	description = "Rallies the hive to a target location."
	keybind_signal = COMSIG_TYRANIDABILITY_RALLY_HIVE

/datum/keybinding/tyranid/rally_minion
	name = "rally_minion"
	full_name = "Rally Minions"
	description = "Rallies the minions to a target location, or yourself."
	keybind_signal = COMSIG_TYRANIDABILITY_RALLY_MINION

/datum/keybinding/tyranid/command_minions
	name = "command_minion"
	full_name = "Command Minions"
	description = "Order the minions escorting you to be either agressive or passive."
	keybind_signal = COMSIG_TYRANIDABILITY_MINION_BEHAVIOUR

//
// Single caste, alphabetical order
//
/datum/keybinding/tyranid/baneling_explode
	name = "Explode"
	full_name = "Baneling: Explode"
	description = "Detonate yourself, spreading your currently selected reagent. Size depends on current stored plasma, more plasma is more reagent."
	keybind_signal = COMSIG_TYRANIDABILITY_BANELING_EXPLODE
	hotkey_keys = list("E")

/datum/keybinding/tyranid/select_reagent/baneling
	name = "Select Reagent"
	full_name = "Baneling: Select Reagent"
	description = "Choose a reagent that will be spread upon death. Costs plasma to change."
	keybind_signal = COMSIG_TYRANIDABILITY_BANELING_CHOOSE_REAGENT
	hotkey_keys = list("C")

/datum/keybinding/tyranid/toggle_bomb
	name = "toggle_bomb"
	full_name = "Boiler: Toggle Bombard Type"
	description = "Toggles the type of glob ."
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_BOMB

/datum/keybinding/tyranid/toggle_bomb_radial
	name = "toggle_bomb_radial"
	full_name = "Boiler: Select Bombard Type (Radial)"
	description = "Will use the default toggle if you have two or less available glob types."
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_BOMB_RADIAL
	hotkey_keys = list("X")

/datum/keybinding/tyranid/create_bomb
	name = "create_bomb"
	full_name = "Boiler: Create Bombard Ammo"
	description = "Create new globs to fire."
	keybind_signal = COMSIG_TYRANIDABILITY_CREATE_BOMB
	hotkey_keys = list("F")

/datum/keybinding/tyranid/bombard
	name = "bombard"
	full_name = "Boiler: Bombard"
	description = "Fire globules."
	keybind_signal = COMSIG_TYRANIDABILITY_BOMBARD
	hotkey_keys = list("R")

/datum/keybinding/tyranid/acid_shroud
	name = "acid_shroud"
	full_name = "Boiler: Acid Shroud"
	description = "Create a smokescreen for a getaway."
	keybind_signal = COMSIG_TYRANIDABILITY_ACID_SHROUD
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/acid_shroud_select
	name = "select_acid_shroud"
	full_name = "Boiler: Select Acid Shroud"
	description = "Create a smokescreen for a getaway."
	keybind_signal = COMSIG_TYRANIDABILITY_ACID_SHROUD_SELECT

/datum/keybinding/tyranid/plow_charge
	name = "plow_charge"
	full_name = "Bull: Plow Charge"
	description = "A charge that plows through the victims."
	keybind_signal = COMSIG_TYRANIDABILITY_BULLCHARGE
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/headbutt_charge
	name = "headbutt_charge"
	full_name = "Bull: Headbutt Charge"
	description = "A charge that tosses the victim forward or backwards, depending on intent."
	keybind_signal = COMSIG_TYRANIDABILITY_BULLHEADBUTT
	hotkey_keys = list("F")

/datum/keybinding/tyranid/gore_charge
	name = "gore_charge"
	full_name = "Bull: Gore Charge"
	description = "A charge that gores the victim."
	keybind_signal = COMSIG_TYRANIDABILITY_BULLGORE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/throw_hugger
	name = "throw_hugger"
	full_name = "Carrier: Throw Hugger"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_THROW_HUGGER
	hotkey_keys = list("E")

/datum/keybinding/tyranid/call_younger
	name = "call_younger"
	full_name = "Carrier: Call of Younger"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_CALL_YOUNGER
	hotkey_keys = list("C")

/datum/keybinding/tyranid/place_trap
	name = "place_trap"
	full_name = "Carrier: Place Trap"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_PLACE_TRAP
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/spawn_hugger
	name = "spawn_hugger"
	full_name = "Carrier: Spawn Hugger"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_SPAWN_HUGGER
	hotkey_keys = list("F")

/datum/keybinding/tyranid/switch_hugger
	name = "switch_hugger"
	full_name = "Carrier: Switch Hugger"
	description = "Cycles the hugger type you will deploy with the Throw Hugger ability."
	keybind_signal = COMSIG_TYRANIDABILITY_SWITCH_HUGGER

/datum/keybinding/tyranid/choose_hugger
	name = "choose_hugger"
	full_name = "Carrier: Choose Hugger"
	description = "Prompt a wheel to choose which hugger you will deploy with the Throw Hugger ability."
	keybind_signal = COMSIG_TYRANIDABILITY_CHOOSE_HUGGER
	hotkey_keys = list("X")

/datum/keybinding/tyranid/drop_all_hugger
	name = "drop_all_hugger"
	full_name = "Carrier: Drop All Facehuggers"
	description = "Drop all stored huggers in a fit of panic. Uses all remaining plasma!"
	keybind_signal = COMSIG_TYRANIDABILITY_DROP_ALL_HUGGER
	hotkey_keys = list("Space")

/datum/keybinding/tyranid/build_hugger_turret
	name = "build_hugger_turret"
	full_name = "Carrier: Build Hugger Turret"
	description = "Build a hugger turret."
	keybind_signal = COMSIG_TYRANIDABILITY_BUILD_HUGGER_TURRET
	hotkey_keys = list("R")

/datum/keybinding/tyranid/stomp
	name = "stomp"
	full_name = "Crusher: Stomp"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_STOMP
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/cresttoss
	name = "cresttoss"
	full_name = "Crusher: Crest Toss"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_CRESTTOSS
	hotkey_keys = list("E")

/datum/keybinding/tyranid/advance
	name = "advance"
	full_name = "Crusher: Rapid Advance"
	description = "Charges up the crushers charge, then unleashes the full bulk of the crusher into a direction."
	keybind_signal = COMSIG_TYRANIDABILITY_ADVANCE
	hotkey_keys = list("F")

/datum/keybinding/tyranid/forward_charge
	name = "forward charge"
	full_name = "Defender: Forward charge"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_FORWARD_CHARGE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/tail_sweep
	name = "tail_sweep"
	full_name = "Defender: Tail Sweep"
	description = "Hit all adjacent units around you, knocking them away and down."
	keybind_signal = COMSIG_TYRANIDABILITY_TAIL_SWEEP
	hotkey_keys = list("E")

/datum/keybinding/tyranid/crest_defense
	name = "crest_defense"
	full_name = "Defender: Crest Defense"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_CREST_DEFENSE
	hotkey_keys = list("Z")

/datum/keybinding/tyranid/fortify
	name = "fortify"
	full_name = "Defender: Fortify"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_FORTIFY
	hotkey_keys = list("Space")

/datum/keybinding/tyranid/regenerate_skin
	name = "regenerate_skin"
	full_name = "Defender: Regenerate Skin"
	description = "Regenerate your skin, restoring some health and removing all armor sunder."
	keybind_signal = COMSIG_TYRANIDABILITY_REGENERATE_SKIN
	hotkey_keys = list("F")

/datum/keybinding/tyranid/centrifugal_force
	name = "centrifugal_force"
	full_name = "Defender: Centrifugal Force"
	description = "Rapidly spin and hit all adjacent humans around you, knocking them away and down."
	keybind_signal = COMSIG_TYRANIDABILITY_CENTRIFUGAL_FORCE
	hotkey_keys = list("X")

/datum/keybinding/tyranid/emit_neurogas
	name = "emit_neurogas"
	full_name = "Defiler: Emit Neurogas"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_EMIT_NEUROGAS
	hotkey_keys = list("E")

/datum/keybinding/tyranid/select_reagent
	name = "select_reagent"
	full_name = "Defiler: Select Reagent"
	description = "Cycles through reagents to choose one for Defiler abilities."
	keybind_signal = COMSIG_TYRANIDABILITY_SELECT_REAGENT
	hotkey_keys = list("C")

/datum/keybinding/tyranid/radial_select_reagent
	name = "radial_select_reagent"
	full_name = "Defiler: Select Reagent (Radial)"
	description = "Chooses a reagent from a radial menu to use for Defiler abilities."
	keybind_signal = COMSIG_TYRANIDABILITY_RADIAL_SELECT_REAGENT
	hotkey_keys = list("X")

/datum/keybinding/tyranid/reagent_slash
	name = "reagent_slash"
	full_name = "Defiler: Reagent Slash"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_REAGENT_SLASH
	hotkey_keys = list("R")

/datum/keybinding/tyranid/defile
	name = "defile"
	full_name = "Defiler: Defile"
	description = "Purges tyranid toxins in exchange for dealing toxin damage and generating toxic sanguinal smoke."
	keybind_signal = COMSIG_TYRANIDABILITY_DEFILE
	hotkey_keys = list("F")

/datum/keybinding/tyranid/tentacle
	name = "tentacle"
	full_name = "Defiler: Tentacle"
	description = "Allows the defiler to grab a tallhost or item from range and bring it towards the defiler."
	keybind_signal = COMSIG_TYRANIDABILITY_TENTACLE
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/inject_egg_neurogas
	name = "inject_egg_neurogas"
	full_name = "Defiler: Inject Egg (Neurogas)"
	description = "Inject an egg with neurogas, killing the little one inside"
	keybind_signal = COMSIG_TYRANIDABILITY_INJECT_EGG_NEUROGAS

/datum/keybinding/tyranid/acidic_salve
	name = "acidic_salve"
	full_name = "Drone: Acidic Salve"
	description = "Heal a tyranid with this."
	keybind_signal = COMSIG_TYRANIDABILITY_ACIDIC_SALVE
	hotkey_keys = list("F")

/datum/keybinding/tyranid/essence_link
	name = "essence_link"
	full_name = "Drone: Essence Link"
	description = "Establish a link of plasma with a sister."
	keybind_signal = COMSIG_TYRANIDABILITY_ESSENCE_LINK
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/essence_link_remove
	name = "essence_link_remove"
	full_name = "Drone: End Essence Link"
	description = "Forcibly end an Essence Link."
	keybind_signal = COMSIG_TYRANIDABILITY_ESSENCE_LINK_REMOVE
	hotkey_keys = list("E")

/datum/keybinding/tyranid/enhancement
	name = "enhancement"
	full_name = "Drone: Enhancement"
	description = "Using an Essence Link, increase a sister's capabilities beyond their limits."
	keybind_signal = COMSIG_TYRANIDABILITY_ENHANCEMENT
	hotkey_keys = list("R")

/datum/keybinding/tyranid/devour
	name = "devour"
	full_name = "Gorger: Devour"
	description = "Devour your victim to be able to carry it faster."
	keybind_signal = COMSIG_TYRANIDABILITY_DEVOUR
	hotkey_keys = list("X")

/datum/keybinding/tyranid/drain
	name = "drain"
	full_name = "Gorger: Drain"
	description = "Stagger a guardsman and drain some of their blood. When used on a dead human, you heal gradually and don't gain blood."
	keybind_signal = COMSIG_TYRANIDABILITY_DRAIN
	hotkey_keys = list("E")

/datum/keybinding/tyranid/transfusion
	name = "transfusion"
	full_name = "Gorger: Transfusion"
	description = "Restores some of the health of another tyranid, or overheals, at the cost of blood."
	keybind_signal = COMSIG_TYRANIDABILITY_TRANSFUSION
	hotkey_keys = list("H")

/datum/keybinding/tyranid/oppose
	name = "oppose"
	full_name = "Gorger: Oppose"
	description = "Violently suffuse the nearby ground with stored blood, staggering nearby guardsmans and healing nearby tyranids."
	keybind_signal = COMSIG_TYRANIDABILITY_OPPOSE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/psychic_link
	name = "psychic link"
	full_name = "Gorger: Psychic Link"
	description = "Link to a tyranid and take some damage in their place. During this time, you can't move. Use rest action to cancel."
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_LINK
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/carnage
	name = "carnage"
	full_name = "Gorger: Carnage"
	description = "For a while your attacks drain blood and heal you. During Feast you also heal nearby allies."
	keybind_signal = COMSIG_TYRANIDABILITY_CARNAGE
	hotkey_keys = list("C")

/datum/keybinding/tyranid/feast
	name = "feast"
	full_name = "Gorger: Feast"
	description = "Enter a state of rejuvenation. During this time you use a small amount of blood and heal. You can cancel this early."
	keybind_signal = COMSIG_TYRANIDABILITY_FEAST
	hotkey_keys = list("F")

/datum/keybinding/tyranid/resin_walker
	name = "resin_walker"
	full_name = "Hivelord: Toggle Resin Walker"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_RESIN_WALKER
	hotkey_keys = list("E")

/datum/keybinding/tyranid/build_tunnel
	name = "build_tunnel"
	full_name = "Hivelord: Build Tunnel"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_BUILD_TUNNEL
	hotkey_keys = list("ShiftQ")

/datum/keybinding/tyranid/place_jelly_pod
	name = "place_jelly_pod"
	full_name = "Hivelord: Place Jelly Pod"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_PLACE_JELLY_POD

/datum/keybinding/tyranid/create_jelly
	name = "create_jelly"
	full_name = "Hivelord: Create Jelly"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_CREATE_JELLY
	hotkey_keys = list("F")

/datum/keybinding/tyranid/healing_infusion
	name = "healing_infusion"
	full_name = "Hivelord: Healing Infusion"
	description = "Imbues a target tyranid with healing energy, restoring extra Sunder and Health once every 2 seconds up to 5 times whenever it regenerates normally. 60 second duration."
	keybind_signal = COMSIG_TYRANIDABILITY_HEALING_INFUSION
	hotkey_keys = list("H")

/datum/keybinding/tyranid/sow
	name = "sow"
	full_name = "Hivelord: Sow"
	description = "Plant the seeds of an alien plant."
	keybind_signal = COMSIG_TYRANIDABILITY_DROP_PLANT
	hotkey_keys = list("C")

/datum/keybinding/tyranid/sow_select_plant
	name = "choose_plant"
	full_name = "Hivelord: Choose plant"
	description = "Pick what type of plant to sow."
	keybind_signal = COMSIG_TYRANIDABILITY_CHOOSE_PLANT

/datum/keybinding/tyranid/change_form
	name = "change_form"
	full_name = "Hivemind: Change Form"
	description = "Change form to/from incorporeal."
	keybind_signal = COMSIG_TYRANID_HIVEMIND_CHANGE_FORM
	hotkey_keys = list("F")

/datum/keybinding/tyranid/teleport_minimap
	name = "teleport_minimap"
	full_name = "Hivemind: Open teleportation minimap"
	description = "Opens up the minimap which, when you click somewhere, tries to teleport you to the selected location"
	keybind_signal = COMISG_TYRANID_HIVEMIND_TELEPORT
	hotkey_keys = list("C")

/datum/keybinding/tyranid/hunter_pounce
	name = "hunter_pounce"
	full_name = "Hunter: Pounce"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_HUNTER_POUNCE
	hotkey_keys = list("E")

/datum/keybinding/tyranid/toggle_stealth
	name = "toggle_stealth"
	full_name = "Hunter: Toggle Stealth"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_STEALTH
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/toggle_disguise
	name = "toggle_disguise"
	full_name = "Hunter: Toggle Disguise"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_DISGUISE
	hotkey_keys = list("F")

/datum/keybinding/tyranid/mirage
	name = "mirage"
	full_name = "Hunter: Mirage"
	description = "Creates multiple mirror images of the tyranid."
	keybind_signal = COMSIG_TYRANIDABILITY_MIRAGE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/silence
	name = "impair senses"
	full_name = "Hunter: Silence"
	description = "Impairs the ability of hostile living creatures we can see in a 5x5 area. Targets will be unable to speak and hear for 10 seconds."
	keybind_signal = COMSIG_TYRANIDABILITY_SILENCE
	hotkey_keys = list("X")

/datum/keybinding/tyranid/mark
	name = "mark"
	full_name = "Hunter: Mark"
	description = "Mark that lonely guardsman so that you can track with Psychic Trace."
	keybind_signal = COMSIG_TYRANIDABILITY_HUNTER_MARK
	hotkey_keys = list("C")

/datum/keybinding/tyranid/psychic_trace
	name = "psychic_trace"
	full_name = "Hunter: Psychic Trace"
	description = "Locate direction of guardsman that you've marked."
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_TRACE
	hotkey_keys = list("G")

/datum/keybinding/tyranid/nightfall
	hotkey_keys = list("F")
	name = "nightfall"
	full_name = "King: Nightfall"
	description = "Shut down all nearby electric lights for 10 seconds"
	keybind_signal = COMSIG_TYRANIDABILITY_NIGHTFALL

/datum/keybinding/tyranid/petrify
	hotkey_keys = list("E")
	name = "petrify"
	full_name = "King: Petrify"
	description = "Petrifies all humans within view. While petrified humans can neither be damaged or take any actions."
	keybind_signal = COMSIG_TYRANIDABILITY_PETRIFY

/datum/keybinding/tyranid/off_guard
	hotkey_keys = list("Q")
	name = "off_guard"
	full_name = "King: Off-guard"
	description = "Muddles the mind of an enemy, increasing their scatter for a while."
	keybind_signal = COMSIG_TYRANIDABILITY_OFFGUARD

/datum/keybinding/tyranid/shattering_roar
	hotkey_keys = list("R")
	name = "shattering_roar"
	full_name = "King: Shattering roar"
	description = "Unleash a mighty psychic roar, knocking down any foes in your path and weakening them."
	keybind_signal = COMSIG_TYRANIDABILITY_SHATTERING_ROAR

/datum/keybinding/tyranid/zero_form_beam
	hotkey_keys = list("R")
	name = "zero_form_beam"
	full_name = "King: Zero-form beam"
	description = "After a windup, concentrates the hives energy into a forward-facing beam that pierces everything, but only hurts living beings."
	keybind_signal = COMSIG_TYRANIDABILITY_ZEROFORMBEAM

/datum/keybinding/tyranid/psychic_summon
	name = "psychic_summon"
	full_name = "King: Psychic Summon"
	description = "Summons all tyranids in a hive to the caller's location, uses all plasma to activate."
	keybind_signal = COMSIG_TYRANIDABILITY_HIVE_SUMMON

/datum/keybinding/tyranid/acid_dash
	name = "acid_dash"
	full_name = "Praetorian: Acid Dash"
	description = "Quickly dash, leaving acid in your path and knocking down the first guardsman hit. Has reset potential."
	keybind_signal = COMSIG_TYRANIDABILITY_ACID_DASH
	hotkey_keys = list("E")

/datum/keybinding/tyranid/dodge
	name = "Dodge"
	full_name = "Praetorian: Dodge"
	description = "Gain a speed boost upon activation and the ability to pass through mobs. Enemies automatically receive bump attacks when passed."
	keybind_signal = COMSIG_TYRANIDABILITY_DODGE

/datum/keybinding/tyranid/impale
	name = "Impale"
	full_name = "Praetorian: Impale"
	description = "Impale a guardsman next to you with your tail for moderate damage. Marked enemies are impaled twice."
	keybind_signal = COMSIG_TYRANIDABILITY_IMPALE

/datum/keybinding/tyranid/tail_trip
	name = "Tail Trip"
	full_name = "Praetorian: Tail Trip"
	description = "Target a guardsman within two tiles of you to disorient and slows them. Marked enemies receive stronger debuffs and are stunned for a second."
	keybind_signal = COMSIG_TYRANIDABILITY_TAIL_TRIP

/datum/keybinding/tyranid/screech
	name = "screech"
	full_name = "Queen: Screech"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_SCREECH
	hotkey_keys = list("E")

/datum/keybinding/tyranid/screech_switch
	name = "screech_switch"
	full_name = "Queen: Screech Switch"
	description = "Switches the type of Screech that will be performed."
	keybind_signal = COMSIG_TYRANIDABILITY_SCREECH_SWITCH

/datum/keybinding/tyranid/toggle_queen_zoom
	name = "toggle_queen_zoom"
	full_name = "Queen: Toggle Zoom"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_QUEEN_ZOOM
	hotkey_keys = list("C")

/datum/keybinding/tyranid/tyranid_leaders
	name = "tyranid_leaders"
	full_name = "Queen: Set Leader"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_TYRANID_LEADERS

/datum/keybinding/tyranid/queen_heal
	name = "queen_heal"
	full_name = "Queen: Give Heal"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_QUEEN_HEAL
	hotkey_keys = list("H")

/datum/keybinding/tyranid/queen_give_plasma
	name = "queen_give_plasma"
	full_name = "Queen: Give Plasma"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_QUEEN_GIVE_PLASMA
	hotkey_keys = list("N")

/datum/keybinding/tyranid/queen_hive_message
	name = "queen_hive_message"
	full_name = "Queen: Hive Message"
	description = "Instantly displays a bolded announcement to all tyranids in the hive."
	keybind_signal = COMSIG_TYRANIDABILITY_QUEEN_HIVE_MESSAGE

/datum/keybinding/tyranid/queen_bulwark
	name = "queen_bulwark"
	full_name = "Queen: Bulwark"
	description = "Forms an area around you that reduces damage taken by friendly tyranids."
	keybind_signal = COMSIG_TYRANIDABILITY_QUEEN_BULWARK
	hotkey_keys = list("F")

/datum/keybinding/tyranid/deevolve
	name = "deevolve"
	full_name = "Queen: Devolve Tyranid"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_DEEVOLVE

/datum/keybinding/tyranid/ravager_charge
	name = "ravager_charge"
	full_name = "Ravager: Eviscerating Charge"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_RAVAGER_CHARGE
	hotkey_keys = list("E")

/datum/keybinding/tyranid/ravager_endure
	name = "ravager_endure"
	full_name = "Ravager: Endure"
	description = "For the next few moments you will not go into crit and become resistant to explosives and immune to stagger and slowdown, but you still die if you take damage exceeding your crit health."
	keybind_signal = COMSIG_TYRANIDABILITY_ENDURE
	hotkey_keys = list("F")

/datum/keybinding/tyranid/ravager_rage
	name = "ravager_rage"
	full_name = "Ravager: Rage"
	description = "While active, you will temporarily recover plasma and sunder and gain a bonus to speed and melee damage in proportion to the percentage of your missing health. At negative HP your ability cooldowns reset and your slash damage restores health."
	keybind_signal = COMSIG_TYRANIDABILITY_RAGE
	hotkey_keys = list("Space")

/datum/keybinding/tyranid/ravager_vampirism
	name = "togglevampirism"
	full_name = "Ravager: Toggle vampirism"
	description = "While active, will increase the ravagers healing for a while for every time it hits a new enemy. Effects stack."
	keybind_signal = COMSIG_TYRANIDABILITY_VAMPIRISM

/datum/keybinding/tyranid/ravage
	name = "ravage"
	full_name = "Ravager: Ravage"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_RAVAGE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/ravage_select
	name = "ravage select"
	full_name = "Ravager: Select Ravage"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_RAVAGE_SELECT

/datum/keybinding/tyranid/pounce
	name = "pounce"
	full_name = "Runner: Pounce"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_RUNNER_POUNCE
	hotkey_keys = list("E")

/datum/keybinding/tyranid/toggle_savage
	name = "toggle_savage"
	full_name = "Runner: Toggle Savage"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_SAVAGE

/datum/keybinding/tyranid/evasion
	name = "evasion"
	full_name = "Runner: Evasion"
	description = "Take evasive action, forcing non-friendly projectiles that would hit you to miss so long as you keep moving."
	keybind_signal = COMSIG_TYRANIDABILITY_EVASION
	hotkey_keys = list("Z")

/datum/keybinding/tyranid/auto_evasion
	name = "auto_evasion"
	full_name = "Runner: Toggle Auto Evasion"
	description = "Toggles Auto Evasion on or off. While active, Auto Evasion will automatically use Evasion when you gain its cooldown reset bonus."
	keybind_signal = COMSIG_TYRANIDABILITY_AUTO_EVASION

/datum/keybinding/tyranid/snatch
	name = "snatch"
	full_name = "Runner: Snatch"
	description = "Take an item equipped by your target in your mouth, and carry it away."
	keybind_signal = COMSIG_TYRANIDABILITY_SNATCH
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/toxic_slash
	name = "toxic_slash"
	full_name = "Sentinel: Toxic Slash"
	description = "Imbue your claws with toxins, inflicting the Intoxicated debuff on hit and dealing damage over time."
	keybind_signal = COMSIG_TYRANIDABILITY_TOXIC_SLASH
	hotkey_keys = list("R")

/datum/keybinding/tyranid/drain_sting
	name = "drain_sting"
	full_name = "Sentinel: Drain Sting"
	description = "Sting a victim, draining any Intoxicated debuffs they may have, restoring you and dealing damage."
	keybind_signal = COMSIG_TYRANIDABILITY_DRAIN_STING
	hotkey_keys = list("F")

/datum/keybinding/tyranid/toxicgrenade
	name = "toxic_grenade"
	full_name = "Sentinel: Toxic Grenade"
	description = "Throws a ball of resin containing a toxin that inflicts the Intoxicated debuff, dealing damage over time."
	keybind_signal = COMSIG_TYRANIDABILITY_TOXIC_GRENADE
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/psychic_fling
	name = "psychic_fling"
	full_name = "Shrike: Psychic Fling"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_FLING
	hotkey_keys = list("E")

/datum/keybinding/tyranid/unrelenting_force
	name = "unrelenting_force"
	full_name = "Shrike: Unrelenting Force"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_UNRELENTING_FORCE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/unrelenting_force_select
	name = "unrelenting_force_select"
	full_name = "Shrike: Select Unrelenting Force"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_UNRELENTING_FORCE_SELECT

/datum/keybinding/tyranid/psychic_heal
	name = "psychic_cure"
	full_name = "Shrike: Psychic Cure"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_CURE
	hotkey_keys = list("F")

/datum/keybinding/tyranid/psychic_storm
	name = "gravnade"
	full_name = "Shrike: Psychic Vortex"
	description = ""
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_VORTEX
	hotkey_keys = list("X")

/datum/keybinding/tyranid/scatter_spit
	name = "scatter_spit"
	full_name = "Spitter: Scatter Spit"
	description = "Fires a scattershot of 6 acid globules which create acid puddles on impact or at the end of their range."
	keybind_signal = COMSIG_TYRANIDABILITY_SCATTER_SPIT
	hotkey_keys = list("E")

/datum/keybinding/tyranid/psychic_shield
	name = "Psychic Shield"
	full_name = "Warlock: Psychic Shield"
	description = "Channel a psychic shield at your current location that can reflect most projectiles. Activate again while the shield is active to detonate the shield forcibly, producing knockback."
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_SHIELD
	hotkey_keys = list("E")

/datum/keybinding/tyranid/trigger_psychic_shield
	name = "Trigger Psychic Shield"
	full_name = "Warlock: Trigger Psychic Shield"
	description = "Triggers the Psychic Shield ability without selecting it."
	keybind_signal = COMSIG_TYRANIDABILITY_TRIGGER_PSYCHIC_SHIELD

/datum/keybinding/tyranid/psychic_blast
	name = "Psychic Blast"
	full_name = "Warlock: Psychic Blast"
	description = "Fire a lightly-damaging AOE psychic beam which knocks back enemies after a short charge-up."
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_BLAST
	hotkey_keys = list("R")

/datum/keybinding/tyranid/psychic_crush
	name = "Psychic Crush"
	full_name = "Warlock: Psychic Crush"
	description = "Channel an expanding AOE crush effect, activating it again pre-maturely crushes enemies over an area."
	keybind_signal = COMSIG_TYRANIDABILITY_PSYCHIC_CRUSH
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/toggle_agility
	name = "toggle_agility"
	full_name = "Warrior: Toggle Agility"
	description = "Toggles Agility mode. While in Agility mode, you move much more quickly but can't use abilities and your armor is greatly reduced."
	keybind_signal = COMSIG_TYRANIDABILITY_TOGGLE_AGILITY
	hotkey_keys = list("Space")

/datum/keybinding/tyranid/lunge
	name = "lunge"
	full_name = "Warrior: Lunge"
	description = "Charges towards a target, then neckgrabs them if they're adjacent to you. Stuns on upon grabbing for 1 second."
	keybind_signal = COMSIG_TYRANIDABILITY_LUNGE
	hotkey_keys = list("E")

/datum/keybinding/tyranid/fling
	name = "fling"
	full_name = "Warrior: Fling"
	description = "Quickly flings a target 4 tiles away and inflicts a short stun. Shared cooldown with Grapple Toss."
	keybind_signal = COMSIG_TYRANIDABILITY_FLING
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/grapple_toss
	name = "grapple_toss"
	full_name = "Warrior: Grapple Toss"
	description = "Throw a target you're grabbing up to 5 tiles away. Inflicts a short stun and stagger and slow stacks. Shared cooldown with Fling."
	keybind_signal = COMSIG_TYRANIDABILITY_GRAPPLE_TOSS
	hotkey_keys = list("F")

/datum/keybinding/tyranid/punch
	name = "punch"
	full_name = "Warrior: Punch"
	description = "Punch a hostile creature, a structure or piece of machinery. Damage and status durations are doubled vs creatures you are grabbing. Damage is quadrupled vs structures and machinery."
	keybind_signal = COMSIG_TYRANIDABILITY_PUNCH
	hotkey_keys = list("R")

/datum/keybinding/tyranid/jab
	name = "jab"
	full_name = "Warrior: Jab"
	description = "Precisely strike your target from further away, slowing and confusing them. Resets punch cooldown."
	keybind_signal = COMSIG_TYRANIDABILITY_JAB
	hotkey_keys = list("E")

/datum/keybinding/tyranid/burrow
	name = "burrow"
	full_name = "Widow: Burrow"
	description = "Dig to the ground, making you invisible."
	keybind_signal = COMSIG_TYRANIDABILITY_BURROW
	hotkey_keys = list("C")

/datum/keybinding/tyranid/web_spit
	name = "Web Spit"
	full_name = "Widow: Web Spit"
	description = "Spit web at your target. Hitting the target will impede their functions depending on their hit location."
	keybind_signal = COMSIG_TYRANIDABILITY_WEB_SPIT
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/leash_ball
	name = "Leash Ball"
	full_name = "Widow: Leash Ball"
	description = "Spit a huge web ball of web that snares groups of targets for a brief while."
	keybind_signal = COMSIG_TYRANIDABILITY_LEASH_BALL
	hotkey_keys = list("E")

/datum/keybinding/tyranid/create_spiderling
	name = "Birth Spiderling"
	full_name = "Widow: Birth Spiderling"
	description = "Give birth to a spiderling after a short charge-up."
	keybind_signal = COMSIG_TYRANIDABILITY_CREATE_SPIDERLING
	hotkey_keys = list("F")

/datum/keybinding/tyranid/create_spiderling_using_cc
	name = "Birth Spiderling using Cannibalise charges"
	full_name = "Widow: Birth Spiderling using Cannibalise charges"
	description = "Give birth to a spiderling after a short charge-up if you have any Cannibalise charges available."
	keybind_signal = COMSIG_TYRANIDABILITY_CREATE_SPIDERLING_USING_CC
	hotkey_keys = list("H")

/datum/keybinding/tyranid/attach_spiderlings
	name = "Attach Spiderlings"
	full_name = "Widow: Attach Spiderlings"
	description = "Scoop up and carry your spawn with you."
	keybind_signal = COMSIG_TYRANIDABILITY_ATTACH_SPIDERLINGS
	hotkey_keys = list("X")

/datum/keybinding/tyranid/cannibalise
	name = "Cannibalise Spiderling"
	full_name = "Widow: Cannibalise Spiderling"
	description = "Eat your own young and store their biomass for later."
	keybind_signal = COMSIG_TYRANIDABILITY_CANNIBALISE_SPIDERLING
	hotkey_keys = list("G")

/datum/keybinding/tyranid/web_hook
	name = "Web Hook"
	full_name = "Widow: Web Hook"
	description = "Shoot a strong web and pull yourself towards whatever it hits."
	keybind_signal = COMSIG_TYRANIDABILITY_WEB_HOOK
	hotkey_keys = list("R")

/datum/keybinding/tyranid/spiderling_mark
	name = "Spiderling Mark"
	full_name = "Widow: Spiderling Mark"
	description = "Signal your spawn to a target they shall attack."
	keybind_signal = COMSIG_TYRANIDABILITY_SPIDERLING_MARK
	hotkey_keys = list("V")

/datum/keybinding/tyranid/rewind
	name = "rewind"
	full_name = "Wraith: Time Shift"
	description = "Save the location and status of the target. When the time is up, the target location and status are restored"
	keybind_signal = COMSIG_TYRANIDABILITY_REWIND
	hotkey_keys = list("C")

/datum/keybinding/tyranid/portal
	name = "portal"
	full_name = "Wraith: Portal"
	description = "Place the first portal on your location. You can travel from portal one to portal two and vice versa."
	keybind_signal =COMSIG_TYRANIDABILITY_PORTAL
	hotkey_keys = list("E")

/datum/keybinding/tyranid/portal_two
	name = "portal_two"
	full_name = "Wraith: Portal two"
	description = "Place the second portal on your location. You can travel from portal one to portal two and vice versa."
	keybind_signal =COMSIG_TYRANIDABILITY_PORTAL_ALTERNATE
	hotkey_keys = list("R")

/datum/keybinding/tyranid/blink
	name = "wraith_blink"
	full_name = "Wraith: Blink"
	description = "Teleport to a space a short distance away within line of sight. Can teleport mobs you're dragging with you at the cost of higher cooldown."
	keybind_signal = COMSIG_TYRANIDABILITY_BLINK
	hotkey_keys = list("Q")

/datum/keybinding/tyranid/banish
	name = "banish"
	full_name = "Wraith: Banish"
	description = "Banish a creature or object a short distance away within line of sight to null space. Can target oneself and allies. Can be manually cancelled with Recall."
	keybind_signal = COMSIG_TYRANIDABILITY_BANISH
	hotkey_keys = list("F")

/datum/keybinding/tyranid/recall
	name = "recall"
	full_name = "Wraith: Recall"
	description = "Recall a target from netherspace, ending Banish's effect."
	keybind_signal = COMSIG_TYRANIDABILITY_RECALL
	hotkey_keys = list("G")

/datum/keybinding/tyranid/timestop
	name = "timestop"
	full_name = "Wraith: Time stop"
	description = "Freezes bullets in their course, and they will start to move again only after a certain time"
	keybind_signal = COMSIG_TYRANIDABILITY_TIMESTOP
	hotkey_keys = list("V")

/datum/keybinding/tyranid/flay
	name = "Flay"
	full_name = "Puppeteer: Flay"
	description = "Takes a chunk of flesh from the victim guardsman through a quick swiping motion, adding 100 biomass to your biomass collection."
	keybind_signal = COMSIG_TYRANIDABILITY_FLAY

/datum/keybinding/tyranid/pincushion
	name = "Pincushion"
	full_name = "Puppeteer: Pincushion"
	description = "Launch a spine from your tail. This attack will help deter any organic as well as support your puppets and teammates in direct combat."
	keybind_signal = COMSIG_TYRANIDABILITY_PINCUSHION

/datum/keybinding/tyranid/dread
	name = "Dreadful Presence"
	full_name = "Puppeteer: Dreadful Presence"
	description = "Emit a menacing presence, striking fear into the organics and slowing them for a short duration."
	keybind_signal = COMSIG_TYRANIDABILITY_DREADFULPRESENCE

/datum/keybinding/tyranid/refurbish_husk
	name = "Refurbish Husk"
	full_name = "Puppeteer: Refurbish Husk"
	description = "Harvest the biomass and organs of a body in order to create a meat puppet to do your bidding."
	keybind_signal = COMSIG_TYRANIDABILITY_REFURBISHHUSK

/datum/keybinding/tyranid/stitch_puppet
	name = "Stitch Puppet"
	full_name = "Puppeteer: Stitch Puppet"
	description = "Uses 350 biomass to create a flesh homunculus to do your bidding, at an adjacent target location."
	keybind_signal = COMSIG_TYRANIDABILITY_PUPPET

/datum/keybinding/tyranid/organic_bomb
	name = "Organic Bomb"
	full_name = "Puppeteer: Organic Bomb"
	description = "Causes one of our puppets to detonate on selection, spewing acid out of the puppet's body in all directions, gibbing the puppet."
	keybind_signal = COMSIG_TYRANIDABILITY_ORGANICBOMB

/datum/keybinding/tyranid/tendrils
	name = "Tendrils"
	full_name = "Puppeteer: Tendrils"
	description = "Burrow freshly created tendrils to tangle organics in a 3x3 patch."
	keybind_signal = COMSIG_TYRANIDABILITY_TENDRILS

/datum/keybinding/tyranid/unleash_puppet
	name = "Unleash puppets"
	full_name = "Puppeteer: Unleash puppets"
	description = "Unleash puppets to attack nearby humans."
	keybind_signal = COMSIG_TYRANIDABILITY_UNLEASHPUPPETS

/datum/keybinding/tyranid/recall_puppet
	name = "Recall puppets"
	full_name = "Puppeteer: Recall puppets"
	description = "Recalls your puppets, making them follow you once more"
	keybind_signal = COMSIG_TYRANIDABILITY_RECALLPUPPETS

/datum/keybinding/tyranid/bestow_blessing
	name = "Bestow Blessings"
	full_name = "Puppeteer: Bestow Blessings"
	description = "Give blessings to your puppets."
	keybind_signal = COMSIG_TYRANIDABILITY_BESTOWBLESSINGS

/datum/keybinding/tyranid/behemoth_roll
	name = "Roll"
	full_name = "Behemoth: Roll"
	description = "Curl up into a ball, sacrificing some offensive capabilities in exchange for greater movement speed."
	keybind_signal = COMSIG_TYRANIDABILITY_BEHEMOTH_ROLL

/datum/keybinding/tyranid/landslide
	name = "Landslide"
	full_name = "Behemoth: Landslide"
	description = "Rush forward in the selected direction, damaging enemies caught in a wide path."
	keybind_signal = COMSIG_TYRANIDABILITY_LANDSLIDE

/datum/keybinding/tyranid/cancel_landslide
	name = "Cancel Landslide"
	full_name = "Behemoth: Cancel Landslide"
	description = "Cancels landslide without having to select the ability"
	keybind_signal = COMSIG_TYRANIDABILITY_CANCEL_LANDSLIDE

/datum/keybinding/tyranid/earth_riser
	name = "Earth Riser"
	full_name = "Behemoth: Earth Riser"
	description = "Raise a pillar of earth at the selected location. This solid structure can be used for defense, and it interacts with other abilities for offensive usage."
	keybind_signal = COMSIG_TYRANIDABILITY_EARTH_RISER

/datum/keybinding/tyranid/earth_riser_alternate
	name = "Destroy Earth Pillar"
	full_name = "Behemoth: Destroy Earth Pillar"
	description = "Destroy active Earth Pillars created by Earth Riser, starting by the oldest one."
	keybind_signal = COMSIG_TYRANIDABILITY_EARTH_RISER_ALTERNATE

/datum/keybinding/tyranid/seismic_fracture
	name = "Seismic Fracture"
	full_name = "Behemoth: Seismic Fracture"
	description = "Blast the earth around the selected location, inflicting heavy damage in a large radius."
	keybind_signal = COMSIG_TYRANIDABILITY_SEISMIC_FRACTURE

/datum/keybinding/tyranid/primal_wrath
	name = "Primal Wrath"
	full_name = "Behemoth: Primal Wrath"
	description = "Unleash your wrath. Enhances your abilities, changing their functionality and allowing them to apply a damage over time debuff."
	keybind_signal = COMSIG_TYRANIDABILITY_PRIMAL_WRATH

/datum/keybinding/tyranid/firecharge
	name = "Fire Charge"
	full_name = "Pyrogen: Fire Charge"
	description = "Charge forward and attack a guardsman, extinguishing them if they're on fire, but dealing extra burn damage depending on how many firestacks they have."
	keybind_signal = COMSIG_TYRANIDABILITY_FIRECHARGE

/datum/keybinding/tyranid/firenado
	name = "Fire Storm"
	full_name = "Pyrogen: Fire Storm"
	description = "Unleash 3 firenados that will slowly move towards your targeted turf."
	keybind_signal = COMSIG_TYRANIDABILITY_FIRENADO

/datum/keybinding/tyranid/fireball
	name = "Fireball"
	full_name = "Pyrogen: Fireball"
	description = "Unleash a fireball after a small windup."
	keybind_signal = COMSIG_TYRANIDABILITY_FIREBALL

/datum/keybinding/tyranid/heatray
	name = "Heatray"
	full_name = "Pyrogen: Heatray"
	description = "After a windup, unleash a heat ray that will cook any guardsman it comes across."
	keybind_signal = COMSIG_TYRANIDABILITY_HEATRAY
