GLOBAL_LIST_EMPTY(clients)							//all clients
GLOBAL_LIST_EMPTY(admins)							//all clients whom are admins
GLOBAL_PROTECT(admins)
GLOBAL_LIST_EMPTY(deadmins)							//all ckeys who have used the de-admin verb.

GLOBAL_LIST_EMPTY(directory)							//all ckeys with associated client
GLOBAL_LIST_EMPTY(stealthminID)						//reference list with IDs that store ckeys, for stealthmins

//Since it didn't really belong in any other category, I'm putting this here
//This is for procs to replace all the goddamn 'in world's that are chilling around the code

GLOBAL_LIST_EMPTY(player_list)				//all mobs **with clients attached**.
GLOBAL_LIST_EMPTY(mob_list)					//all mobs, including clientless
GLOBAL_LIST_EMPTY(new_player_list)			//all /mob/new_player
GLOBAL_LIST_EMPTY(ready_players)			//all /mob/new_player that are (ready == TRUE)
GLOBAL_LIST_EMPTY(observer_list)			//all /mob/dead/observer
GLOBAL_LIST_EMPTY(tyranid_mob_list)			//all /mob/living/carbon/tyranid
GLOBAL_LIST_EMPTY(alive_tyranid_list)			//as above except stat != DEAD
GLOBAL_LIST_EMPTY(alive_tyranid_list_hive)		//living tyranids by hive
GLOBAL_LIST_EMPTY(dead_tyranid_list)
GLOBAL_LIST_EMPTY(human_mob_list)			//all /mob/living/carbon/human including synths and species
GLOBAL_LIST_EMPTY(alive_human_list)			//as above except stat != DEAD
GLOBAL_LIST_EMPTY(alive_human_list_faction) //as above but categorized by faction
GLOBAL_LIST_EMPTY(dead_human_list)
GLOBAL_LIST_EMPTY(cryoed_mob_list)			//Used for logging people entering cryosleep
GLOBAL_LIST_EMPTY(dead_mob_list)			//all dead mobs, including clientless. Excludes /mob/new_player
GLOBAL_LIST_EMPTY(joined_player_list)		//all clients that have joined the game at round-start or as a latejoin.
GLOBAL_LIST_EMPTY(mob_living_list)				//all instances of /mob/living and subtypes
GLOBAL_LIST_EMPTY(alive_living_list)		//all alive /mob/living, including clientless.
GLOBAL_LIST_EMPTY(offered_mob_list)				//all /mobs offered by admins
GLOBAL_LIST_EMPTY(ai_list)
GLOBAL_LIST_EMPTY(silicon_mobs) //all silicon mobs
GLOBAL_LIST_INIT(simple_animals, list(list(),list(),list(),list())) // One for each AI_* status define
GLOBAL_LIST_EMPTY(living_cameras)
GLOBAL_LIST_EMPTY(aiEyes)
GLOBAL_LIST_EMPTY_TYPED(humans_by_zlevel, /list/mob/living/carbon/human)			//z level /list/list of alive humans

GLOBAL_LIST_EMPTY(mob_config_movespeed_type_lookup)

GLOBAL_LIST_EMPTY(real_names_joined)

GLOBAL_LIST_EMPTY(language_datum_instances)
GLOBAL_LIST_EMPTY(all_languages)

GLOBAL_LIST_EMPTY(all_species)
GLOBAL_LIST_EMPTY(roundstart_species)

GLOBAL_LIST_INIT_TYPED(tyranid_caste_datums, /list/datum/tyranid_caste, init_tyranid_caste_list())

/proc/init_tyranid_caste_list()
	. = list()
	var/list/typelist = subtypesof(/datum/tyranid_caste)
	for(var/datum/tyranid_caste/typepath AS in typelist)
		if(initial(typepath.upgrade) == TYRANID_UPGRADE_BASETYPE)
			.[typepath] = list()
			.[typepath][TYRANID_UPGRADE_BASETYPE] = new typepath
			typelist -= typepath

	for(var/typepath in typelist)
		var/datum/tyranid_caste/caste = new typepath
		.[caste.get_base_caste_type()][caste.upgrade] = caste

GLOBAL_LIST_INIT(all_tyranid_types, list(
	/mob/living/carbon/tyranid/runner,
	/mob/living/carbon/tyranid/runner/primordial,
	/mob/living/carbon/tyranid/drone,
	/mob/living/carbon/tyranid/drone/primordial,
	/mob/living/carbon/tyranid/sentinel,
	/mob/living/carbon/tyranid/sentinel/primordial,
	/mob/living/carbon/tyranid/defender,
	/mob/living/carbon/tyranid/defender/primordial,
	/mob/living/carbon/tyranid/gorger,
	/mob/living/carbon/tyranid/gorger/primordial,
	/mob/living/carbon/tyranid/hunter,
	/mob/living/carbon/tyranid/hunter/primordial,
	/mob/living/carbon/tyranid/warrior,
	/mob/living/carbon/tyranid/warrior/primordial,
	/mob/living/carbon/tyranid/spitter,
	/mob/living/carbon/tyranid/spitter/primordial,
	/mob/living/carbon/tyranid/hivelord,
	/mob/living/carbon/tyranid/hivelord/primordial,
	/mob/living/carbon/tyranid/carrier,
	/mob/living/carbon/tyranid/carrier/primordial,
	/mob/living/carbon/tyranid/bull,
	/mob/living/carbon/tyranid/bull/primordial,
	/mob/living/carbon/tyranid/queen,
	/mob/living/carbon/tyranid/queen/primordial,
	/mob/living/carbon/tyranid/king,
	/mob/living/carbon/tyranid/king/primordial,
	/mob/living/carbon/tyranid/wraith,
	/mob/living/carbon/tyranid/wraith/primordial,
	/mob/living/carbon/tyranid/ravager,
	/mob/living/carbon/tyranid/ravager/primordial,
	/mob/living/carbon/tyranid/praetorian,
	/mob/living/carbon/tyranid/praetorian/primordial,
	/mob/living/carbon/tyranid/praetorian/dancer,
	/mob/living/carbon/tyranid/praetorian/dancer/primordial,
	/mob/living/carbon/tyranid/boiler,
	/mob/living/carbon/tyranid/boiler/primordial,
	/mob/living/carbon/tyranid/defiler,
	/mob/living/carbon/tyranid/defiler/primordial,
	/mob/living/carbon/tyranid/crusher,
	/mob/living/carbon/tyranid/crusher/primordial,
	/mob/living/carbon/tyranid/widow,
	/mob/living/carbon/tyranid/widow/primordial,
	/mob/living/carbon/tyranid/shrike,
	/mob/living/carbon/tyranid/shrike/primordial,
	/mob/living/carbon/tyranid/warlock,
	/mob/living/carbon/tyranid/warlock/primordial,
	/mob/living/carbon/tyranid/puppeteer,
	/mob/living/carbon/tyranid/puppeteer/primordial,
	/mob/living/carbon/tyranid/behemoth,
	/mob/living/carbon/tyranid/behemoth/primordial,
	/mob/living/carbon/tyranid/beetle,
	/mob/living/carbon/tyranid/mantis,
	/mob/living/carbon/tyranid/scorpion,
	/mob/living/carbon/tyranid/spiderling,
	/mob/living/carbon/tyranid/pyrogen,
	/mob/living/carbon/tyranid/pyrogen/primordial,
	/mob/living/carbon/tyranid/baneling,
	))

GLOBAL_LIST_INIT(tyranid_types_tier_one, list(/datum/tyranid_caste/runner, /datum/tyranid_caste/drone, /datum/tyranid_caste/sentinel, /datum/tyranid_caste/defender))
GLOBAL_LIST_INIT(tyranid_types_tier_two, list(/datum/tyranid_caste/hunter, /datum/tyranid_caste/warrior, /datum/tyranid_caste/spitter, /datum/tyranid_caste/hivelord, /datum/tyranid_caste/carrier, /datum/tyranid_caste/bull, /datum/tyranid_caste/wraith, /datum/tyranid_caste/puppeteer, /datum/tyranid_caste/pyrogen))
GLOBAL_LIST_INIT(tyranid_types_tier_three, list(/datum/tyranid_caste/gorger, /datum/tyranid_caste/widow, /datum/tyranid_caste/ravager, /datum/tyranid_caste/praetorian, /datum/tyranid_caste/boiler, /datum/tyranid_caste/defiler, /datum/tyranid_caste/crusher, /datum/tyranid_caste/shrike, /datum/tyranid_caste/behemoth, /datum/tyranid_caste/warlock))
GLOBAL_LIST_INIT(tyranid_types_tier_four, list(/datum/tyranid_caste/shrike, /datum/tyranid_caste/queen, /datum/tyranid_caste/king))


GLOBAL_LIST_INIT_TYPED(hive_datums, /datum/hive_status, init_hive_datum_list()) // init by make_datum_references_lists()

/proc/init_hive_datum_list()
	. = list()
	for(var/H in subtypesof(/datum/hive_status))
		var/datum/hive_status/HS = new H
		.[HS.hivenumber] = HS

///Returns the index of the corresponding static caste data given caste typepath.
GLOBAL_LIST_EMPTY(hive_ui_caste_index)

///Contains static data passed to all hive status UI.
GLOBAL_LIST_INIT(hive_ui_static_data, init_hive_status_lists()) // init by make_datum_references_lists()

/proc/init_hive_status_lists()
	. = list()
	// Initializes static ui data used by all hive status UI
	var/list/per_tier_counter = list()
	for(var/caste_type_path AS in GLOB.tyranid_caste_datums)
		var/datum/tyranid_caste/caste = GLOB.tyranid_caste_datums[caste_type_path][TYRANID_UPGRADE_BASETYPE]
		if(caste.caste_flags & CASTE_HIDE_IN_STATUS)
			continue
		var/type_path = initial(caste.caste_type_path)

		GLOB.hive_ui_caste_index[type_path] = length(.) //Starts from 0.

		var/icon/tyranid_minimap = icon('icons/UI_icons/map_blips.dmi', initial(caste.minimap_icon))
		var/tier = initial(caste.tier)
		if(tier == TYRANID_TIER_MINION)
			continue
		if(isnull(per_tier_counter[tier]))
			per_tier_counter[tier] = 0

		. += list(list(
			"name" = initial(caste.caste_name),
			"is_queen" = type_path == /mob/living/carbon/tyranid/queen,
			"minimap" = icon2base64(tyranid_minimap),
			"sort_mod" = per_tier_counter[tier]++,
			"tier" = GLOB.tier_as_number[tier],
			"is_unique" = caste.maximum_active_caste == 1,
			"can_transfer_plasma" = CHECK_BITFIELD(initial(caste.can_flags), CASTE_CAN_BE_GIVEN_PLASMA),
			"evolution_max" = initial(caste.evolution_threshold)
		))



/proc/update_config_movespeed_type_lookup(update_mobs = TRUE)
	var/list/mob_types = list()
	var/list/entry_value = CONFIG_GET(keyed_list/multiplicative_movespeed)
	for(var/path in entry_value)
		var/value = entry_value[path]
		if(!value)
			continue
		for(var/subpath in typesof(path))
			mob_types[subpath] = value
	GLOB.mob_config_movespeed_type_lookup = mob_types
	if(update_mobs)
		update_mob_config_movespeeds()

/proc/update_mob_config_movespeeds()
	for(var/i in GLOB.mob_list)
		var/mob/M = i
		M.update_config_movespeed()

///The actions given to all humans on init
GLOBAL_LIST_INIT(human_init_actions, list(
	/datum/action/skill/toggle_orders,
	/datum/action/skill/issue_order/move,
	/datum/action/skill/issue_order/hold,
	/datum/action/skill/issue_order/focus,
	/datum/action/innate/order/attack_order/personal,
	/datum/action/innate/order/defend_order/personal,
	/datum/action/innate/order/retreat_order/personal,
	/datum/action/innate/order/rally_order/personal,
	/datum/action/innate/message_squad,
))
