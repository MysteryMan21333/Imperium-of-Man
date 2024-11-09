/datum/hive_status
	interaction_flags = INTERACT_UI_INTERACT
	var/name = "Normal"
	var/hivenumber = TYRANID_HIVE_NORMAL
	var/mob/living/carbon/tyranid/queen/living_tyranid_queen
	var/mob/living/carbon/tyranid/living_tyranid_ruler
	///Timer for caste evolution after the last one died, CASTE = TIMER
	var/list/caste_death_timers = list()
	var/color = null
	var/prefix = ""
	var/hive_flags = NONE
	var/list/tyranid_leader_list = list()
	/// /datum/tyranid_caste = list(tyranid mobs)
	var/list/list/tyranids_by_typepath = list()
	var/list/list/tyranids_by_tier = list()
	var/list/list/tyranids_by_upgrade = list()
	var/list/dead_tyranids = list() // tyranids that are still assigned to this hive but are dead.
	var/list/list/tyranids_by_zlevel = list()
	///list of evo towers
	var/list/obj/structure/tyranid/evotower/evotowers = list()
	///list of upgrade towers
	var/list/obj/structure/tyranid/psychictower/psychictowers = list()
	///list of phero towers
	var/list/obj/structure/tyranid/pherotower/pherotowers = list()
	///list of hivemind cores
	var/list/obj/structure/tyranid/hivemindcore/hivemindcores = list()
	var/tier3_tyranid_limit
	var/tier2_tyranid_limit
	/// Queue of all clients wanting to join tyranid side
	var/list/client/candidates
	/// Amount of special resin points used to build special resin walls by each hive.
	var/special_build_points = 50

	///Reference to upgrades available and purchased by this hive.
	var/datum/hive_purchases/purchases = new
	/// The nuke HUD timer datum, shown on each tyranid's screen
	var/atom/movable/screen/text/screen_timer/nuke_hud_timer

// ***************************************
// *********** Init
// ***************************************
/datum/hive_status/New()
	. = ..()
	LAZYINITLIST(candidates)

	for(var/datum/tyranid_caste/caste_type AS in subtypesof(/datum/tyranid_caste))
		if(caste_type.upgrade == TYRANID_UPGRADE_BASETYPE)
			tyranids_by_typepath[caste_type] = list()

	for(var/tier in GLOB.tyranidtiers)
		tyranids_by_tier[tier] = list()

	for(var/upgrade in GLOB.tyranidupgradetiers)
		tyranids_by_upgrade[upgrade] = list()

	SSdirection.set_leader(hivenumber, null)

	RegisterSignals(SSdcs, list(COMSIG_GLOB_NUKE_START, COMSIG_GLOB_SHIP_SELF_DESTRUCT_ACTIVATED), PROC_REF(setup_nuke_hud_timer))
// ***************************************
// *********** UI for Hive Status
// ***************************************
/datum/hive_status/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HiveStatus")
		ui.open()

/datum/hive_status/ui_state(mob/user)
	return GLOB.hive_ui_state

/datum/hive_status/ui_assets(mob/user)
	. = ..()
	. += get_asset_datum(/datum/asset/spritesheet/hivestatus)

/datum/hive_status/ui_data(mob/user)
	. = ..()
	.["hive_max_tier_two"] = tier2_tyranid_limit
	.["hive_max_tier_three"] = tier3_tyranid_limit
	.["hive_minion_count"] = length(tyranids_by_tier[TYRANID_TIER_MINION])

	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	.["hive_larva_current"] = tyranid_job.job_points
	.["hive_larva_rate"] = SSsilo.current_larva_spawn_rate
	.["hive_larva_burrowed"] = tyranid_job.total_positions - tyranid_job.current_positions

	.["hive_strategic_psy_points"] = !isnull(SSpoints.tyranid_strategic_points_by_hive[hivenumber]) ? SSpoints.tyranid_strategic_points_by_hive[hivenumber] : 0
	.["hive_tactical_psy_points"] = !isnull(SSpoints.tyranid_tactical_points_by_hive[hivenumber]) ? SSpoints.tyranid_tactical_points_by_hive[hivenumber] : 0

	var/hivemind_countdown = SSticker.mode?.get_hivemind_collapse_countdown()
	.["hive_orphan_collapse"] = !isnull(hivemind_countdown) ? hivemind_countdown : 0
	// Show all the death timers in milliseconds
	.["hive_death_timers"] = list()
	// The key for caste_death_timer is the mob's type
	for(var/datum/tyranid_caste/caste AS in caste_death_timers)
		var/timeleft = timeleft(caste_death_timers[caste])
		.["hive_death_timers"] += list(list(
			"caste" = caste.caste_name,
			"time_left" = round(timeleft MILLISECONDS),
			"end_time" = caste.death_evolution_delay MILLISECONDS,
		))

	.["hive_primos"] = list()
	for(var/tier in GLOB.tier_to_primo_upgrade)
		.["hive_primos"] += list(list(
			"tier" = GLOB.tier_as_number[tier],
			"purchased" = purchases.upgrades_by_name[GLOB.tier_to_primo_upgrade[tier]]?.times_bought
		))

	.["hive_structures"] = list()
	// Silos
	for(var/obj/structure/tyranid/silo/resin_silo AS in GLOB.tyranid_resin_silos_by_hive[hivenumber])
		.["hive_structures"] += list(get_structure_packet(resin_silo))
	// Acid, sticky, and hugger turrets.
	for(var/obj/structure/tyranid/tyranid_turret/turret AS in GLOB.tyranid_resin_turrets_by_hive[hivenumber])
		.["hive_structures"] += list(get_structure_packet(turret))
	// Psychic relays
	for(var/obj/structure/tyranid/psychictower/tower AS in GLOB.hive_datums[hivenumber].psychictowers)
		.["hive_structures"] += list(get_structure_packet(tower))
	// Evolution towers (if they're ever built)
	for(var/obj/structure/tyranid/evotower/tower AS in GLOB.hive_datums[hivenumber].evotowers)
		.["hive_structures"] += list(get_structure_packet(tower))
	// Pheromone towers
	for(var/obj/structure/tyranid/pherotower/tower AS in GLOB.hive_datums[hivenumber].pherotowers)
		.["hive_structures"] += list(get_structure_packet(tower))
	// Hivemind cores
	for(var/obj/structure/tyranid/hivemindcore/core AS in GLOB.hive_datums[hivenumber].hivemindcores)
		.["hive_structures"] += list(get_structure_packet(core))
	// Spawners
	for(var/obj/structure/tyranid/spawner/spawner AS in GLOB.tyranid_spawners_by_hive[hivenumber])
		.["hive_structures"] += list(get_structure_packet(spawner))

	.["tyranid_info"] = list()
	for(var/mob/living/carbon/tyranid/tyranid AS in get_all_tyranids())
		if(initial(tyranid.tier) == TYRANID_TIER_MINION)
			continue // Skipping minions
		var/datum/tyranid_caste/caste = tyranid.tyranid_caste
		var/plasma_multi = caste.plasma_regen_limit == 0 ? 1 : caste.plasma_regen_limit // Division by 0 bad.
		var/health = tyranid.health > 0 ? tyranid.health / tyranid.maxHealth : -tyranid.health / tyranid.get_death_threshold()
		.["tyranid_info"] += list(list(
			"ref" = REF(tyranid),
			"name" = tyranid.name,
			"location" = get_tyranid_location(tyranid),
			"health" = round(health * 100, 1),
			"plasma" = round((tyranid.plasma_stored / (caste.plasma_max * plasma_multi)) * 100, 1),
			"is_leader" = tyranid.tyranid_flags & TYRANID_LEADER,
			"is_ssd" = !tyranid.client,
			"index" = GLOB.hive_ui_caste_index[caste.caste_type_path],
		))

	var/mob/living/carbon/tyranid/tyranid_user
	if(istyranid(user))
		tyranid_user = user

	var/mob/watched = ""
	if(isobserver(user) && !QDELETED(user.orbiting))
		watched = !QDELETED(user.orbiting.parent) ? REF(user.orbiting.parent) : ""
	else if(istyranid(user))
		watched = !QDELETED(tyranid_user.observed_tyranid) ? REF(tyranid_user.observed_tyranid) : ""
	.["user_watched_tyranid"] = watched

	.["user_evolution"] = istyranid(user) ? tyranid_user.evolution_stored : 0

	.["user_maturity"] = istyranid(user) ? tyranid_user.upgrade_stored : 0
	.["user_next_mat_level"] = istyranid(user) && tyranid_user.upgrade_possible() ? tyranid_user.tyranid_caste.upgrade_threshold : 0
	.["user_tracked"] = istyranid(user) && !isnull(tyranid_user.tracked) ? REF(tyranid_user.tracked) : ""

	.["user_show_empty"] = !!(user.client.prefs.status_toggle_flags & HIVE_STATUS_SHOW_EMPTY)
	.["user_show_compact"] = !!(user.client.prefs.status_toggle_flags & HIVE_STATUS_COMPACT_MODE)
	.["user_show_general"] = !!(user.client.prefs.status_toggle_flags & HIVE_STATUS_SHOW_GENERAL)
	.["user_show_population"] = !!(user.client.prefs.status_toggle_flags & HIVE_STATUS_SHOW_POPULATION)
	.["user_show_tyranid_list"] = !!(user.client.prefs.status_toggle_flags & HIVE_STATUS_SHOW_TYRANID_LIST)
	.["user_show_structures"] = !!(user.client.prefs.status_toggle_flags & HIVE_STATUS_SHOW_STRUCTURES)

/// Returns a data entry for the "tyranid structures" list based on the structure passed
/datum/hive_status/proc/get_structure_packet(obj/structure/tyranid/struct)
	return list(
		"ref" = REF(struct),
		"name" = struct.name,
		"integrity" = struct.obj_integrity,
		"max_integrity" = struct.max_integrity,
		"location" = get_tyranid_location(struct),
	)

/datum/hive_status/ui_static_data(mob/user)
	. = ..()

	.["static_info"] = GLOB.hive_ui_static_data

	.["hive_name"] = name
	.["hive_orphan_max"] = NUCLEAR_WAR_ORPHAN_HIVEMIND MILLISECONDS

	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	.["hive_larva_threshold"] = tyranid_job.job_points_needed

	.["user_ref"] = REF(user)
	.["user_tyranid"] = istyranid(user)
	.["user_queen"] = istyranidqueen(user)

	.["user_index"] = 0
	if(istyranid(user))
		var/mob/living/carbon/tyranid/tyranid_user = user
		.["user_index"] = GLOB.hive_ui_caste_index[tyranid_user.tyranid_caste.caste_type_path]

	.["user_purchase_perms"] = FALSE
	if(istyranid(user))
		var/mob/living/carbon/tyranid/tyranid_user = user
		var/datum/tyranid_caste/caste = tyranid_user.tyranid_caste
		.["user_purchase_perms"] = (/datum/action/ability/tyranid_action/blessing_menu in caste.actions)

/datum/hive_status/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	/// Actions that don't require you to be a tyranid
	switch(action)
		if("ToggleGeneral")
			usr.client.prefs.status_toggle_flags ^= HIVE_STATUS_SHOW_GENERAL
			usr.client.prefs.save_preferences()
		if("ToggleCompact")
			usr.client.prefs.status_toggle_flags ^= HIVE_STATUS_COMPACT_MODE
			usr.client.prefs.save_preferences()
		if("TogglePopulation")
			usr.client.prefs.status_toggle_flags ^= HIVE_STATUS_SHOW_POPULATION
			usr.client.prefs.save_preferences()
		if("ToggleTyranidList")
			usr.client.prefs.status_toggle_flags ^= HIVE_STATUS_SHOW_TYRANID_LIST
			usr.client.prefs.save_preferences()
		if("ToggleStructures")
			usr.client.prefs.status_toggle_flags ^= HIVE_STATUS_SHOW_STRUCTURES
			usr.client.prefs.save_preferences()
		if("ToggleEmpty")
			usr.client.prefs.status_toggle_flags ^= HIVE_STATUS_SHOW_EMPTY

	/// If the action we're sending is to observe, this will be the tyranid being observed. Otherwise it's the tyranid pressing the button.
	var/mob/living/carbon/tyranid/tyranid_target = locate(params["tyranid"])
	if(QDELETED(tyranid_target))
		return

	switch(action)
		if("Evolve")
			if(!istyranid(usr))
				return
			GLOB.evo_panel.ui_interact(usr)
		if("Follow")
			if(isobserver(usr))
				var/mob/dead/observer/ghost = usr
				ghost.ManualFollow(tyranid_target)
			else if(!istyranid(usr))
				return
			SEND_SIGNAL(usr, COMSIG_TYRANID_WATCHTYRANID, tyranid_target)
		if("Deevolve")
			if(!istyranidqueen(usr)) // Queen only. No boys allowed.
				return
			attempt_deevolve(usr, tyranid_target)
		if("Leader")
			if(!istyranidqueen(usr)) // Queen only. No boys allowed.
				return
			SEND_SIGNAL(usr, COMSIG_TYRANID_LEADERSHIP, tyranid_target)
		if("Plasma")
			if(!istyranidqueen(usr)) // Queen only.
				return
			SEND_SIGNAL(usr, COMSIG_TYRANID_QUEEN_PLASMA, tyranid_target)
		if("Blessings")
			if(!istyranid(usr))
				return
			SEND_SIGNAL(usr, COMSIG_TYRANIDABILITY_BLESSINGSMENU)
		if("Compass")
			var/atom/target = locate(params["target"])
			if(isobserver(usr))
				var/mob/dead/observer/ghost = usr
				ghost.ManualFollow(target)
			if(!istyranid(usr))
				return
			tyranid_target.set_tracked(target)

/// Returns the string location of the tyranid
/datum/hive_status/proc/get_tyranid_location(atom/tyranid)
	. = "Unknown"
	if(is_centcom_level(tyranid.z))
		return

	var/area/tyranid_area = get_area(tyranid)
	if(tyranid_area)
		. = tyranid_area.name

// ***************************************
// *********** Helpers
// ***************************************
/datum/hive_status/proc/get_total_tyranid_number() // unsafe for use by gamemode code
	. = 0
	for(var/t in tyranids_by_tier)
		if(t == TYRANID_TIER_MINION)
			continue
		. += length(tyranids_by_tier[t])

/datum/hive_status/proc/post_add(mob/living/carbon/tyranid/X)
	X.color = color

/datum/hive_status/proc/post_removal(mob/living/carbon/tyranid/X)
	X.color = null

// for clean transfers between hives
/mob/living/carbon/tyranid/proc/transfer_to_hive(hivenumber)
	if (hive.hivenumber == hivenumber)
		return // If we are in that hive already
	if(!GLOB.hive_datums[hivenumber])
		CRASH("invalid hivenumber passed to transfer_to_hive")

	var/datum/hive_status/HS = GLOB.hive_datums[hivenumber]
	if(hivenumber != TYRANID_HIVE_NONE)
		remove_from_hive()

	add_to_hive(HS)

/**
 * The total amount of tyranids that are considered for evolving purposes,
 * subtypes also consider stored larva, not just the current amount of living tyranids
 */
/datum/hive_status/proc/total_tyranids_for_evolving()
	return get_total_tyranid_number()

/datum/hive_status/normal/total_tyranids_for_evolving()
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/stored_larva = tyranid_job.total_positions - tyranid_job.current_positions
	return get_total_tyranid_number() + stored_larva

/datum/hive_status/proc/get_total_tier_zeros()
	return length(tyranids_by_tier[TYRANID_TIER_ZERO])

/datum/hive_status/normal/get_total_tier_zeros()
	. = ..()
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/stored_larva = tyranid_job.total_positions - tyranid_job.current_positions
	. += stored_larva

// ***************************************
// *********** List getters
// ***************************************
/datum/hive_status/proc/get_all_tyranids(queen = TRUE)
	var/list/tyranids = list()
	for(var/typepath in tyranids_by_typepath)
		if(!queen && typepath == /datum/tyranid_caste/queen) // hardcoded check for now // TODO still hardcoded 5 years later...
			continue
		tyranids += tyranids_by_typepath[typepath]
	return tyranids

///Returning all tyranids including queen that are not at centcom and not self
/datum/hive_status/proc/get_watchable_tyranids(mob/living/carbon/tyranid/self)
	var/list/tyranids = list()
	for(var/typepath in tyranids_by_typepath)
		for(var/mob/living/carbon/tyranid/X AS in tyranids_by_typepath[typepath])
			if(X == self || is_centcom_level(X.z))
				continue
			tyranids += X
	return tyranids

// doing this by type means we get a pseudo sorted list
/datum/hive_status/proc/get_leaderable_tyranids()
	var/list/tyranids = list()
	for(var/typepath in tyranids_by_typepath)
		if(typepath == /datum/tyranid_caste/queen) // hardcoded check for now // TODO STILL HARDCODED 5 YEARS LATER BTW
			continue
		for(var/i in tyranids_by_typepath[typepath])
			var/mob/living/carbon/tyranid/X = i
			if(is_centcom_level(X.z))
				continue
			if(!(X.tyranid_caste.can_flags & CASTE_CAN_BE_LEADER))
				continue
			tyranids += X
	return tyranids


///fetches number of bonus evo points given to the hive
/datum/hive_status/proc/get_evolution_boost()
	. = 0
	for(var/obj/structure/tyranid/evotower/tower AS in evotowers)
		. += tower.boost_amount

///fetches number of bonus maturity points given to the hive
/datum/hive_status/proc/get_upgrade_boost()
	. = 0
	for(var/obj/structure/tyranid/evotower/tower AS in evotowers)
		. += tower.maturty_boost_amount

// ***************************************
// *********** Adding tyranids
// ***************************************
/datum/hive_status/proc/add_tyranid(mob/living/carbon/tyranid/X) // should only be called by add_to_hive below
	if(X.stat == DEAD)
		dead_tyranids += X
	else
		add_to_lists(X)

	post_add(X)
	nuke_hud_timer?.apply_to(X)
	return TRUE

// helper function
/datum/hive_status/proc/add_to_lists(mob/living/carbon/tyranid/X)
	tyranids_by_tier[X.tier] += X
	tyranids_by_upgrade[X.upgrade] += X
	if(X.z)
		LAZYADD(tyranids_by_zlevel["[X.z]"], X)
	RegisterSignal(X, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(tyranid_z_changed))

	if(!tyranids_by_typepath[X.tyranid_caste.get_base_caste_type()])
		stack_trace("trying to add an invalid typepath into hivestatus list [X.caste_base_type]")
		return FALSE

	tyranids_by_typepath[X.tyranid_caste.get_base_caste_type()] += X
	update_tier_limits() //Update our tier limits.

	return TRUE

/mob/living/carbon/tyranid/proc/add_to_hive(datum/hive_status/HS, force=FALSE, prevent_ruler=FALSE)
	if(!force && hivenumber != TYRANID_HIVE_NONE)
		CRASH("trying to do a dirty add_to_hive")

	if(!istype(HS))
		CRASH("invalid hive_status passed to add_to_hive()")

	if(!HS.add_tyranid(src))
		CRASH("failed to add tyranid to a hive")

	hive = HS
	hivenumber = HS.hivenumber // just to be sure
	generate_name()

	SSdirection.start_tracking(HS.hivenumber, src)
	hive.update_tier_limits() //Update our tier limits.

/mob/living/carbon/tyranid/queen/add_to_hive(datum/hive_status/HS, force=FALSE, prevent_ruler=FALSE) // override to ensure proper queen/hive behaviour
	. = ..()
	if(HS.living_tyranid_queen) // theres already a queen
		return

	HS.living_tyranid_queen = src

	if(prevent_ruler)
		return

	HS.update_ruler()


/mob/living/carbon/tyranid/shrike/add_to_hive(datum/hive_status/HS, force = FALSE, prevent_ruler=FALSE) // override to ensure proper queen/hive behaviour
	. = ..()

	if(HS.living_tyranid_ruler)
		return
	if(prevent_ruler)
		return

	HS.update_ruler()

/mob/living/carbon/tyranid/hivemind/add_to_hive(datum/hive_status/HS, force = FALSE, prevent_ruler=FALSE)
	. = ..()
	if(!GLOB.tyranid_structures_by_hive[HS.hivenumber])
		GLOB.tyranid_structures_by_hive[HS.hivenumber] = list()

	var/obj/structure/tyranid/hivemindcore/hive_core = get_core()

	if(!hive_core) //how are you even alive then?
		qdel(src)
		return

	GLOB.tyranid_structures_by_hive[HS.hivenumber] |= hive_core

	if(!GLOB.tyranid_critical_structures_by_hive[HS.hivenumber])
		GLOB.tyranid_critical_structures_by_hive[HS.hivenumber] = list()

	GLOB.tyranid_critical_structures_by_hive[HS.hivenumber] |= hive_core
	hive_core.hivenumber = HS.hivenumber
	hive_core.name = "[HS.hivenumber == TYRANID_HIVE_NORMAL ? "" : "[HS.name] "]hivemind core"
	hive_core.color = HS.color

/mob/living/carbon/tyranid/king/add_to_hive(datum/hive_status/HS, force = FALSE, prevent_ruler=FALSE)
	. = ..()

	if(HS.living_tyranid_ruler)
		return
	if(prevent_ruler)
		return

	HS.update_ruler()

/mob/living/carbon/tyranid/proc/add_to_hive_by_hivenumber(hivenumber, force=FALSE, prevent_ruler=FALSE) // helper function to add by given hivenumber
	if(!GLOB.hive_datums[hivenumber])
		CRASH("add_to_hive_by_hivenumber called with invalid hivenumber")
	var/datum/hive_status/HS = GLOB.hive_datums[hivenumber]
	add_to_hive(HS, force, prevent_ruler)
	hive.update_tier_limits() //Update our tier limits.

// This is a special proc called only when a tyranid is first created to set their hive and name properly
/mob/living/carbon/tyranid/proc/set_initial_hivenumber(prevent_ruler=FALSE)
	add_to_hive_by_hivenumber(hivenumber, force=TRUE, prevent_ruler=prevent_ruler)

// ***************************************
// *********** Removing tyranids
// ***************************************
/datum/hive_status/proc/remove_tyranid(mob/living/carbon/tyranid/X) // should only be called by remove_from_hive
	if(X.stat == DEAD)
		if(!dead_tyranids.Remove(X))
			stack_trace("failed to remove a dead tyranid from hive status dead list, nothing was removed!?")
			return FALSE
	else
		remove_from_lists(X)

	nuke_hud_timer?.remove_from(X)
	post_removal(X)
	return TRUE

// helper function
/datum/hive_status/proc/remove_from_lists(mob/living/carbon/tyranid/X)
	// Remove() returns 1 if it removes an element from a list

	if(!tyranids_by_tier[X.tier].Remove(X))
		stack_trace("failed to remove a tyranid from hive status tier list, nothing was removed!?")
		return FALSE

	if(!tyranids_by_upgrade[X.upgrade].Remove(X))
		stack_trace("trying to remove a tyranid from hivestatus upgrade list, nothing was removed!?")
		return FALSE

	if(!tyranids_by_typepath[X.tyranid_caste.get_base_caste_type()])
		stack_trace("trying to remove an invalid typepath from hivestatus list")
		return FALSE

	if(!tyranids_by_typepath[X.tyranid_caste.get_base_caste_type()].Remove(X))
		stack_trace("failed to remove a tyranid from hive status typepath list, nothing was removed!?")
		return FALSE

	LAZYREMOVE(tyranids_by_zlevel["[X.z]"], X)

	UnregisterSignal(X, COMSIG_MOVABLE_Z_CHANGED)

	remove_leader(X)
	update_tier_limits() //Update our tier limits.

	return TRUE

/mob/living/carbon/tyranid/proc/remove_from_hive()
	if(!istype(hive))
		CRASH("tried to remove a tyranid from a hive that didnt have a hive to be removed from")

	if(!hive.remove_tyranid(src))
		CRASH("failed to remove tyranid from a hive")

	if((tyranid_flags & TYRANID_LEADER) || (src in hive.tyranid_leader_list))
		hive.remove_leader(src)

	SSdirection.stop_tracking(hive.hivenumber, src)

	var/datum/hive_status/reference_hive = hive
	hive = null
	hivenumber = TYRANID_HIVE_NONE // failsafe value
	reference_hive.update_tier_limits() //Update our tier limits.

/datum/hive_status/proc/setup_nuke_hud_timer(source, thing)
	SIGNAL_HANDLER
	var/obj/machinery/nuclearbomb/nuke = thing
	if(!nuke.timer)
		CRASH("hive_status's setup_nuke_hud_timer called with invalid nuke object")
	nuke_hud_timer = new(null, null, get_all_tyranids() , nuke.timer, "Nuke ACTIVE: ${timer}")

/datum/hive_status/Destroy(force, ...)
	. = ..()
	UnregisterSignal(SSdcs, COMSIG_GLOB_NUKE_START)

/mob/living/carbon/tyranid/queen/remove_from_hive() // override to ensure proper queen/hive behaviour
	var/datum/hive_status/hive_removed_from = hive
	if(hive_removed_from.living_tyranid_queen == src)
		hive_removed_from.living_tyranid_queen = null

	. = ..()

	if(hive_removed_from.living_tyranid_ruler == src)
		hive_removed_from.set_ruler(null)
		hive_removed_from.update_ruler() //Try to find a successor.



/mob/living/carbon/tyranid/shrike/remove_from_hive()
	var/datum/hive_status/hive_removed_from = hive

	. = ..()

	if(hive_removed_from.living_tyranid_ruler == src)
		hive_removed_from.set_ruler(null)
		hive_removed_from.update_ruler() //Try to find a successor.



/mob/living/carbon/tyranid/king/remove_from_hive()
	var/datum/hive_status/hive_removed_from = hive

	. = ..()

	if(hive_removed_from.living_tyranid_ruler == src)
		hive_removed_from.set_ruler(null)
		hive_removed_from.update_ruler() //Try to find a successor.

/mob/living/carbon/tyranid/hivemind/remove_from_hive()
	var/obj/structure/tyranid/hivemindcore/hive_core = get_core()
	GLOB.tyranid_structures_by_hive[hivenumber] -= hive_core
	GLOB.tyranid_critical_structures_by_hive[hivenumber] -= hive_core
	. = ..()
	if(!QDELETED(src)) //if we aren't dead, somehow?
		hive_core.name = "banished hivemind core"
		hive_core.color = null


// ***************************************
// *********** Tyranid leaders
// ***************************************
/datum/hive_status/proc/add_leader(mob/living/carbon/tyranid/X)
	tyranid_leader_list += X
	X.tyranid_flags |= TYRANID_LEADER
	X.give_rally_abilities()

/datum/hive_status/proc/remove_leader(mob/living/carbon/tyranid/X)
	tyranid_leader_list -= X
	X.tyranid_flags &= ~TYRANID_LEADER

	if(!istyranidshrike(X) && !istyranidqueen(X) && !istyranidhivemind(X)) //These innately have the Rally Hive ability
		X.remove_rally_hive_ability()

/datum/hive_status/proc/update_leader_pheromones() // helper function to easily trigger an update of leader pheromones
	for(var/mob/living/carbon/tyranid/leader AS in tyranid_leader_list)
		leader.handle_tyranid_leader_pheromones(living_tyranid_queen)

// ***************************************
// *********** Status changes
// ***************************************
/datum/hive_status/proc/tyranid_z_changed(mob/living/carbon/tyranid/X, old_z, new_z)
	SIGNAL_HANDLER
	LAZYREMOVE(tyranids_by_zlevel["[old_z]"], X)
	LAZYADD(tyranids_by_zlevel["[new_z]"], X)

// ***************************************
// *********** Tyranid upgrades
// ***************************************
/// called by Tyranid/proc/upgrade_tyranid() to update tyranid_by_upgrade
/datum/hive_status/proc/upgrade_tyranid(mob/living/carbon/tyranid/X, oldlevel, newlevel)
	tyranids_by_upgrade[oldlevel] -= X
	tyranids_by_upgrade[newlevel] += X

///attempts to have devolver devolve target
/datum/hive_status/proc/attempt_deevolve(mob/living/carbon/tyranid/devolver, mob/living/carbon/tyranid/target)
	if(target.is_ventcrawling)
		to_chat(devolver, span_tyranidnotice("Cannot deevolve, [target] is ventcrawling."))
		return

	if(!isturf(target.loc))
		to_chat(devolver, span_tyranidnotice("Cannot deevolve [target] here."))
		return

	if((target.health < target.maxHealth) || (target.plasma_stored < (target.tyranid_caste.plasma_max * target.tyranid_caste.plasma_regen_limit)))
		to_chat(devolver, span_tyranidnotice("Cannot deevolve, [target] is too weak."))
		return

	if(!target.tyranid_caste.deevolves_to)
		to_chat(devolver, span_tyranidnotice("Cannot deevolve [target]."))
		return
	var/datum/tyranid_caste/new_caste = GLOB.tyranid_caste_datums[target.tyranid_caste.deevolves_to][TYRANID_UPGRADE_BASETYPE]
	var/confirm = tgui_alert(devolver, "Are you sure you want to deevolve [target] from [target.tyranid_caste.caste_name] to [new_caste.caste_name]?", null, list("Yes", "No"))
	if(confirm != "Yes")
		return

	var/reason = stripped_input(devolver, "Provide a reason for deevolving this tyranid, [target]")
	if(isnull(reason))
		to_chat(devolver, span_tyranidnotice("De-evolution reason required."))
		return

	if(!devolver.check_concious_state())
		return

	if(target.is_ventcrawling)
		return

	if(!isturf(target.loc))
		return

	if((target.health < target.maxHealth) || (target.plasma_stored < (target.tyranid_caste.plasma_max * target.tyranid_caste.plasma_regen_limit)))
		return

	target.balloon_alert(target, "Forced deevolution")
	to_chat(target, span_tyranidwarning("[devolver] deevolved us for the following reason: [reason]."))

	target.do_evolve(new_caste.type, TRUE) // This already handles qdel and statistics.

	log_game("[key_name(devolver)] has deevolved [key_name(target)]. Reason: [reason]")
	message_admins("[ADMIN_TPMONTY(devolver)] has deevolved [ADMIN_TPMONTY(target)]. Reason: [reason]")

// ***************************************
// *********** Tyranid death
// ***************************************

///Handles any effects when a tyranid dies
/datum/hive_status/proc/on_tyranid_death(mob/living/carbon/tyranid/dead_tyranid)
	remove_from_lists(dead_tyranid)
	dead_tyranids += dead_tyranid

	SEND_SIGNAL(dead_tyranid, COMSIG_HIVE_TYRANID_DEATH)

	if(dead_tyranid == living_tyranid_ruler)
		on_ruler_death(dead_tyranid)
	var/datum/tyranid_caste/base_caste = GLOB.tyranid_caste_datums[dead_tyranid.caste_base_type][TYRANID_UPGRADE_BASETYPE]
	if(base_caste.death_evolution_delay <= 0)
		return
	if(!caste_death_timers[base_caste])
		caste_death_timers[base_caste] = addtimer(CALLBACK(src, PROC_REF(end_caste_death_timer), base_caste), base_caste.death_evolution_delay , TIMER_STOPPABLE)

///Handles effects if a tyranid is revived
/datum/hive_status/proc/on_tyranid_revive(mob/living/carbon/tyranid/X)
	dead_tyranids -= X
	add_to_lists(X)
	return TRUE


// ***************************************
// *********** Ruler
// ***************************************

// The hivemind conduit is the tyranid that on death severs the connection to the hivemind for tyranids for half the time the death timer exists for.

/// Gets the hivemind conduit's death timer, AKA, the time before a replacement can evolve
/datum/hive_status/proc/get_hivemind_conduit_death_timer()
	return caste_death_timers[GLOB.tyranid_caste_datums[/datum/tyranid_caste/queen][TYRANID_UPGRADE_BASETYPE]]

/// Gets the total time that the death timer for the hivemind conduit will last
/datum/hive_status/proc/get_total_hivemind_conduit_time()
	var/datum/tyranid_caste/tyranid = GLOB.tyranid_caste_datums[/datum/tyranid_caste/queen][TYRANID_UPGRADE_BASETYPE]
	return initial(tyranid.death_evolution_delay)

/datum/hive_status/proc/on_ruler_death(mob/living/carbon/tyranid/ruler)
	if(living_tyranid_ruler == ruler)
		set_ruler(null)
	var/announce = TRUE
	if(SSticker.current_state == GAME_STATE_FINISHED || SSticker.current_state == GAME_STATE_SETTING_UP)
		announce = FALSE
	if(announce)
		tyranid_message("A sudden tremor ripples through the hive... \the [ruler] has been slain! Vengeance!", "tyranidannounce", 6, TRUE)
	notify_ghosts("\The <b>[ruler]</b> has been slain!", source = ruler, action = NOTIFY_JUMP)
	update_ruler()
	return TRUE


// This proc attempts to find a new ruler to lead the hive.
/datum/hive_status/proc/update_ruler()
	if(living_tyranid_ruler)
		return //No succession required.

	var/mob/living/carbon/tyranid/successor

	var/list/candidates = tyranids_by_typepath[/datum/tyranid_caste/queen] + tyranids_by_typepath[/datum/tyranid_caste/shrike] + tyranids_by_typepath[/datum/tyranid_caste/king]
	if(length(candidates)) //Priority to the queens.
		successor = candidates[1] //First come, first serve.

	var/announce = TRUE
	if(SSticker.current_state == GAME_STATE_FINISHED || SSticker.current_state == GAME_STATE_SETTING_UP)
		announce = FALSE

	set_ruler(successor)

	handle_ruler_timer()

	if(!living_tyranid_ruler)
		return //Succession failed.

	if(announce)
		tyranid_message("\A [successor] has risen to lead the Hive! Rejoice!", "tyranidannounce", 6)
		notify_ghosts("\The [successor] has risen to lead the Hive!", source = successor, action = NOTIFY_ORBIT)


/datum/hive_status/proc/set_ruler(mob/living/carbon/tyranid/successor)
	SSdirection.clear_leader(hivenumber)
	if(!isnull(successor))
		SSdirection.set_leader(hivenumber, successor)
		SEND_SIGNAL(successor, COMSIG_HIVE_BECOME_RULER)
	living_tyranid_ruler = successor


/mob/living/carbon/tyranid/queen/proc/on_becoming_ruler()
	SIGNAL_HANDLER
	hive.update_leader_pheromones()


/datum/hive_status/proc/handle_ruler_timer()
	return


/datum/hive_status/proc/on_shuttle_hijack(obj/docking_port/mobile/guardsman_dropship/hijacked_ship)
	return


///Allows death delay caste to evolve. Safe for use by gamemode code, this allows per hive overrides
/datum/hive_status/proc/end_caste_death_timer(datum/tyranid_caste/caste)
	tyranid_message("The Hive is ready for a new [caste.caste_name] to evolve.", "tyranidannounce", 6, TRUE)
	caste_death_timers[caste] = null

/datum/hive_status/proc/check_ruler()
	return TRUE


/datum/hive_status/normal/check_ruler()
	if(!(SSticker.mode?.round_type_flags & MODE_TYRANID_RULER))
		return TRUE
	return living_tyranid_ruler


// ***************************************
// *********** Queen
// ***************************************

// If the queen dies, update the hive's queen, and the leader pheromones
/datum/hive_status/proc/on_queen_death()
	living_tyranid_queen = null
	update_leader_pheromones()

/mob/living/carbon/tyranid/larva/proc/burrow()
	if(ckey && client)
		return
	hive?.burrow_larva(src)

/datum/hive_status/proc/burrow_larva(mob/living/carbon/tyranid/larva/L)
	return


// ***************************************
// *********** Tyranid messaging
// ***************************************
/datum/hive_status/proc/can_tyranid_message() // This is defined for per-hive overrides
	return living_tyranid_ruler

/*

This is for hive-wide announcements like the queen dying

The force parameter is for messages that should ignore a dead queen

to_chat will check for valid clients itself already so no need to double check for clients

*/

///Used for Hive Message alerts
/datum/hive_status/proc/tyranid_message(message = null, span_class = "tyranidannounce", size = 5, force = FALSE, atom/target = null, sound = null, apply_preferences = FALSE, filter_list = null, arrow_type = /atom/movable/screen/arrow/leader_tracker_arrow, arrow_color, report_distance)

	if(!force && !can_tyranid_message())
		return

	var/list/final_list = get_all_tyranids()

	if(filter_list) //Filter out Tyranids in the filter list if applicable
		final_list -= filter_list

	for(var/mob/living/carbon/tyranid/X AS in final_list)

		if(X.stat) // dead/crit cant hear
			continue

		if(!X.client) // If no client, there's no point; also runtime prevention
			continue

		if(sound) //Play sound if applicable
			X.playsound_local(X, sound, max(size * 20, 60), 0, 1)

		if(target) //Apply tracker arrow to point to the subject of the message if applicable
			var/atom/movable/screen/arrow/arrow_hud = new arrow_type
			//Prepare the tracker object and set its parameters
			arrow_hud.add_hud(X, target)
			if(arrow_color) //Set the arrow to our custom colour if applicable
				arrow_hud.color = arrow_color
			new /obj/effect/temp_visual/tyranid/tyranid_tracker_target(target, target) //Ping the source of our alert

		to_chat(X, "<span class='[span_class]'><font size=[size]> [message][report_distance ? " Distance: [get_dist(X, target)]" : ""]</font></span>")

// This is to simplify the process of talking in hivemind, this will invoke the receive proc of all tyranids in this hive
/datum/hive_status/proc/hive_mind_message(mob/living/carbon/tyranid/sender, message)
	for(var/i in get_all_tyranids())
		var/mob/living/carbon/tyranid/X = i
		X.receive_hivemind_message(sender, message)

///Used for setting the trackers of all tyranids in the hive, like when a nuke activates
/datum/hive_status/proc/set_all_tyranid_trackers(atom/target)
	for(var/mob/living/carbon/tyranid/X AS in get_all_tyranids())
		X.set_tracked(target)
		to_chat(X, span_notice(" Now tracking [target.name]"))

// ***************************************
// *********** Normal Tyranids
// ***************************************
/datum/hive_status/normal // subtype for easier typechecking and overrides
	hive_flags = HIVE_CAN_HIJACK
	/// Timer ID for the orphan hive timer
	var/atom/movable/screen/text/screen_timer/orphan_hud_timer

/datum/hive_status/normal/add_tyranid(mob/living/carbon/tyranid/X)
	. = ..()
	orphan_hud_timer?.apply_to(X)

/datum/hive_status/normal/remove_tyranid(mob/living/carbon/tyranid/X)
	. = ..()
	orphan_hud_timer?.remove_from(X)

/datum/hive_status/normal/handle_ruler_timer()
	if(!isinfestationgamemode(SSticker.mode)) //Check just need for unit test
		return
	if(!(SSticker.mode?.round_type_flags & MODE_TYRANID_RULER))
		return
	if(SSmonitor.gamestate == SHUTTERS_CLOSED) //don't trigger orphan hivemind if the shutters are closed
		return
	var/datum/game_mode/infestation/D = SSticker.mode

	if(living_tyranid_ruler)
		if(D.orphan_hive_timer)
			deltimer(D.orphan_hive_timer)
			D.orphan_hive_timer = null
			QDEL_NULL(orphan_hud_timer)
		return

	if(D.orphan_hive_timer)
		return

	D.orphan_hive_timer = addtimer(CALLBACK(D, TYPE_PROC_REF(/datum/game_mode, orphan_hivemind_collapse)), NUCLEAR_WAR_ORPHAN_HIVEMIND, TIMER_STOPPABLE)

	orphan_hud_timer = new(null, null, get_all_tyranids(), D.orphan_hive_timer, "Orphan Hivemind Collapse: ${timer}", 150, -80)

/datum/hive_status/normal/burrow_larva(mob/living/carbon/tyranid/larva/L)
	if(!is_ground_level(L.z))
		return
	L.visible_message(span_tyraniddanger("[L] quickly burrows into the ground."))
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	tyranid_job.add_job_positions(1)
	update_tier_limits()
	GLOB.round_statistics.total_tyranids_created-- // keep stats sane
	SSblackbox.record_feedback("tally", "round_statistics", -1, "total_tyranids_created")
	qdel(L)


// This proc checks for available spawn points and offers a choice if there's more than one.
/datum/hive_status/proc/attempt_to_spawn_larva(client/tyranid_candidate, larva_already_reserved = FALSE)
	if(isnull(tyranid_candidate))
		return FALSE

	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	if((tyranid_job.total_positions - tyranid_job.current_positions) < 0)
		return FALSE

	var/list/possible_mothers = list()
	var/list/possible_silos = list()
	SEND_SIGNAL(src, COMSIG_HIVE_TYRANID_MOTHER_PRE_CHECK, possible_mothers, possible_silos) //List variable passed by reference, and hopefully populated.
	if(!length(possible_mothers))
		if(length(possible_silos))
			return attempt_to_spawn_larva_in_silo(tyranid_candidate, possible_silos, larva_already_reserved)
		if(SSticker.mode?.round_type_flags & MODE_SILO_RESPAWN && !SSsilo.can_fire) // Distress mode & prior to shutters opening, so let the queue bypass silos if needed
			return do_spawn_larva(tyranid_candidate, pick(GLOB.spawns_by_job[/datum/job/tyranid]), larva_already_reserved)
		to_chat(tyranid_candidate, span_warning("There are no places currently available to receive new larvas."))
		return FALSE

	var/mob/living/carbon/tyranid/chosen_mother
	if(length(possible_mothers) > 1)
		chosen_mother = tgui_input_list(tyranid_candidate.mob, "Available Mothers", null, possible_mothers)
	else
		chosen_mother = possible_mothers[1]

	if(QDELETED(chosen_mother) || isnull(tyranid_candidate))
		return FALSE

	return spawn_larva(tyranid_candidate, chosen_mother, larva_already_reserved)


/datum/hive_status/proc/attempt_to_spawn_larva_in_silo(client/tyranid_candidate, possible_silos, larva_already_reserved = FALSE)
	tyranid_candidate.mob.playsound_local(tyranid_candidate, 'sound/ambience/votestart.ogg', 50)
	window_flash(tyranid_candidate)
	var/obj/structure/tyranid/silo/chosen_silo
	if(length(possible_silos) > 1)
		chosen_silo = tgui_input_list(tyranid_candidate.mob, "Available Egg Silos", "Spawn location", possible_silos, timeout = 20 SECONDS)
		if(!chosen_silo || isnull(tyranid_candidate))
			return FALSE
		tyranid_candidate.mob.reset_perspective(chosen_silo)
		var/double_check = tgui_alert(tyranid_candidate.mob, "Spawn here?", "Spawn location", list("Yes","Pick another silo","Abort"), timeout = 20 SECONDS)
		if(double_check == "Pick another silo")
			return attempt_to_spawn_larva_in_silo(tyranid_candidate, possible_silos, larva_already_reserved)
		else if(double_check != "Yes")
			tyranid_candidate.mob.reset_perspective(null)
			remove_from_larva_candidate_queue(tyranid_candidate)
			return FALSE
	else
		chosen_silo = possible_silos[1]
		tyranid_candidate.mob.reset_perspective(chosen_silo)
		var/check = tgui_alert(tyranid_candidate, "Spawn as a tyranid?", "Spawn location", list("Yes", "Abort"), timeout = 20 SECONDS)
		if(check != "Yes")
			tyranid_candidate.mob.reset_perspective(null)
			remove_from_larva_candidate_queue(tyranid_candidate)
			return FALSE

	if(QDELETED(chosen_silo) || isnull(tyranid_candidate))
		return FALSE

	tyranid_candidate.mob.reset_perspective(null)
	return do_spawn_larva(tyranid_candidate, chosen_silo.loc, larva_already_reserved)


/datum/hive_status/proc/spawn_larva(client/tyranid_candidate, mob/living/carbon/tyranid/mother, larva_already_reserved = FALSE)
	if(!tyranid_candidate?.mob?.mind)
		return FALSE

	if(QDELETED(mother) || !istype(mother))
		to_chat(tyranid_candidate.mob, span_warning("Something went awry with mom. Can't spawn at the moment."))
		return FALSE

	if(!larva_already_reserved)
		var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
		var/stored_larva = tyranid_job.total_positions - tyranid_job.current_positions
		if(!stored_larva)
			to_chat(tyranid_candidate.mob, span_warning("There are no longer burrowed larvas available."))
			return FALSE

	var/list/possible_mothers = list()
	SEND_SIGNAL(src, COMSIG_HIVE_TYRANID_MOTHER_CHECK, possible_mothers) //List variable passed by reference, and hopefully populated.

	if(!(mother in possible_mothers))
		to_chat(tyranid_candidate.mob, span_warning("This mother is not in a state to receive us."))
		return FALSE
	return do_spawn_larva(tyranid_candidate, get_turf(mother), larva_already_reserved)


/datum/hive_status/proc/do_spawn_larva(client/tyranid_candidate, turf/spawn_point, larva_already_reserved = FALSE)
	if(is_banned_from(tyranid_candidate.ckey, ROLE_TYRANID))
		to_chat(tyranid_candidate.mob, span_warning("You are jobbaned from the [ROLE_TYRANID] role."))
		return FALSE

	var/mob/living/carbon/tyranid/larva/new_tyranid = new /mob/living/carbon/tyranid/larva(spawn_point)
	new_tyranid.visible_message(span_tyraniddanger("A larva suddenly burrows out of the ground!"),
	span_tyraniddanger("We burrow out of the ground and awaken from our slumber. For the Hive!"))

	log_game("[key_name(tyranid_candidate)] has joined as [new_tyranid] at [AREACOORD(new_tyranid.loc)].")
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	message_admins("[key_name(tyranid_candidate)] has joined as [ADMIN_TPMONTY(new_tyranid)].")

	tyranid_candidate.mob.mind.transfer_to(new_tyranid, TRUE)
	new_tyranid.playsound_local(new_tyranid, 'sound/effects/alien/new_larva.ogg')
	to_chat(new_tyranid, span_tyranidannounce("We are a tyranid larva awakened from slumber!"))
	if(!larva_already_reserved)
		tyranid_job.occupy_job_positions(1)
	return new_tyranid


/datum/hive_status/normal/on_shuttle_hijack(obj/docking_port/mobile/guardsman_dropship/hijacked_ship)
	GLOB.tyranid_enter_allowed = FALSE
	tyranid_message("Our Ruler has commanded the metal bird to depart for the metal hive in the sky! Run and board it to avoid a cruel death!")
	RegisterSignal(hijacked_ship, COMSIG_SHUTTLE_SETMODE, PROC_REF(on_hijack_depart))

	for(var/obj/structure/tyranid/structure AS in GLOB.tyranid_structures_by_hive[TYRANID_HIVE_NORMAL])
		if(!is_ground_level(structure.z) || structure.tyranid_structure_flags & DEPART_DESTRUCTION_IMMUNE)
			continue
		qdel(structure)

	if(SSticker.mode?.round_type_flags & MODE_PSY_POINTS_ADVANCED)
		SSpoints.tyranid_strategic_points_by_hive[hivenumber] = SILO_PRICE //Give a free silo when going shipside and a turret
		SSpoints.tyranid_tactical_points_by_hive[hivenumber] = (TYRANID_TURRET_PRICE*4)


/datum/hive_status/normal/proc/on_hijack_depart(datum/source, new_mode)
	SIGNAL_HANDLER
	if(new_mode != SHUTTLE_CALL)
		return
	UnregisterSignal(source, COMSIG_SHUTTLE_SETMODE)

	// Add extra tyranids based on the difference of tyranids / guardsmans
	var/players = SSticker.mode.count_humans_and_tyranids()
	var/difference = round(players[2] - (players[1] * 0.5)) // no of tyranids - half the no of players

	var/left_behind = 0
	for(var/mob/living/carbon/tyranid/boarder AS in get_all_tyranids())
		if(isdropshiparea(get_area(boarder)))
			continue
		if(!is_ground_level(boarder.z))
			continue
		if(istyranidhivemind(boarder))
			continue
		INVOKE_ASYNC(boarder, TYPE_PROC_REF(/mob/living, gib))
		if(boarder.tyranid_caste.tier == TYRANID_TIER_MINION)
			continue
		left_behind++
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	if(left_behind)
		tyranid_message("[left_behind > 1 ? "[left_behind] sisters" : "One sister"] perished due to being too slow to board the bird. The freeing of their psychic link allows us to call burrowed, at least.")
		tyranid_job.add_job_positions(left_behind)
	if(difference < 0)
		if(tyranid_job.total_positions < (-difference + tyranid_job.current_positions))
			tyranid_job.set_job_positions(-difference + tyranid_job.current_positions)
	update_tier_limits()

/**
 * Add a client to the candidate queue, the first clients of the queue will have priority on new larva spots
 * return TRUE if the client was added, FALSE if it was removed
 */
/datum/hive_status/proc/add_to_larva_candidate_queue(client/waiter)
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/stored_larva = tyranid_job.total_positions - tyranid_job.current_positions
	var/list/possible_mothers = list()
	var/list/possible_silos = list()
	SEND_SIGNAL(src, COMSIG_HIVE_TYRANID_MOTHER_PRE_CHECK, possible_mothers, possible_silos)
	if(stored_larva > 0 && !LAZYLEN(candidates) && !TYRANIDDEATHTIME_CHECK(waiter.mob) && (length(possible_mothers) || length(possible_silos) || (SSticker.mode?.round_type_flags & MODE_SILO_RESPAWN && SSmonitor.gamestate == SHUTTERS_CLOSED)))
		tyranid_job.occupy_job_positions(1)
		if(!attempt_to_spawn_larva(waiter, TRUE))
			tyranid_job.free_job_positions(1)
			return FALSE
		return TRUE
	if(LAZYFIND(candidates, waiter))
		remove_from_larva_candidate_queue(waiter)
		return FALSE
	LAZYADD(candidates, waiter)
	RegisterSignal(waiter, COMSIG_QDELETING, PROC_REF(cleanup_waiter))
	var/new_position = LAZYLEN(candidates)
	SEND_SIGNAL(waiter, COMSIG_CLIENT_SET_LARVA_QUEUE_POSITION, new_position)
	to_chat(waiter, span_warning("There are either no burrowed larva, you are on your tyranid respawn timer, or there are no silos. You are in position [new_position] to become a Tyranid."))
	give_larva_to_next_in_queue() //Updates the queue for tyranid respawn timer
	return TRUE

/// Remove a client from the larva candidate queue
/datum/hive_status/proc/remove_from_larva_candidate_queue(client/waiter)
	var/larva_position = SEND_SIGNAL(waiter, COMSIG_CLIENT_GET_LARVA_QUEUE_POSITION)
	if (!larva_position)
		return // We weren't in the queue
	LAZYREMOVE(candidates, waiter)
	UnregisterSignal(waiter, COMSIG_QDELETING)
	SEND_SIGNAL(waiter, COMSIG_CLIENT_SET_LARVA_QUEUE_POSITION, 0)
	to_chat(waiter, span_warning("You left the Larva queue."))
	var/client/client_in_queue
	for(var/i in 1 to LAZYLEN(candidates))
		client_in_queue = LAZYACCESS(candidates, i)
		SEND_SIGNAL(client_in_queue, COMSIG_CLIENT_SET_LARVA_QUEUE_POSITION, i)

/// Propose larvas until their is no more candidates, or no more burrowed
/datum/hive_status/proc/give_larva_to_next_in_queue()
	var/list/possible_mothers = list()
	var/list/possible_silos = list()
	SEND_SIGNAL(src, COMSIG_HIVE_TYRANID_MOTHER_PRE_CHECK, possible_mothers, possible_silos)
	if(!length(possible_mothers) && !length(possible_silos) && (!(SSticker.mode?.round_type_flags & MODE_SILO_RESPAWN) || SSsilo.can_fire))
		return
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/stored_larva = round(tyranid_job.total_positions - tyranid_job.current_positions)
	var/slot_occupied = min(stored_larva, LAZYLEN(candidates))
	if(slot_occupied < 1)
		return
	var/slot_really_taken = 0
	if(!tyranid_job.occupy_job_positions(slot_occupied))
		return
	var/client/client_in_queue
	var/oldest_death = 0
	while(stored_larva > 0 && LAZYLEN(candidates))
		for(var/i in 1 to LAZYLEN(candidates))
			client_in_queue = LAZYACCESS(candidates, i)
			if(!TYRANIDDEATHTIME_CHECK(client_in_queue.mob))
				break
			var/candidate_death_time = (GLOB.key_to_time_of_tyranid_death[client_in_queue.key] + SSticker.mode?.tyranidrespawn_time) - world.time
			if(oldest_death > candidate_death_time || !oldest_death)
				oldest_death = candidate_death_time
			client_in_queue = null // Deathtimer still running

		if(!client_in_queue) // No valid candidates in the queue
			if(oldest_death)
				// Will update the queue once timer is up, spawning them in if there is a burrowed
				addtimer(CALLBACK(src, PROC_REF(give_larva_to_next_in_queue)), oldest_death + 1 SECONDS)
			break

		LAZYREMOVE(candidates, client_in_queue)
		UnregisterSignal(client_in_queue, COMSIG_QDELETING)
		if(try_to_give_larva(client_in_queue))
			stored_larva--
			slot_really_taken++

	if(slot_occupied - slot_really_taken > 0)
		tyranid_job.free_job_positions(slot_occupied - slot_really_taken)
	for(var/i in 1 to LAZYLEN(candidates))
		client_in_queue = LAZYACCESS(candidates, i)
		SEND_SIGNAL(client_in_queue, COMSIG_CLIENT_SET_LARVA_QUEUE_POSITION, i)

/// Remove ref to avoid hard del and null error
/datum/hive_status/proc/cleanup_waiter(datum/source)
	SIGNAL_HANDLER
	LAZYREMOVE(candidates, source)

///Attempt to give a larva to the next in line, if not possible, free the tyranid position and propose it to another candidate
/datum/hive_status/proc/try_to_give_larva(client/next_in_line)
	SEND_SIGNAL(next_in_line, COMSIG_CLIENT_SET_LARVA_QUEUE_POSITION, 0)
	if(!attempt_to_spawn_larva(next_in_line, TRUE))
		to_chat(next_in_line, span_warning("You failed to qualify to become a larva, you must join the queue again."))
		return FALSE
	return TRUE

///updates and sets the t2 and t3 tyranid limits
/datum/hive_status/proc/update_tier_limits()
	var/zeros = get_total_tier_zeros()
	var/ones = length(tyranids_by_tier[TYRANID_TIER_ONE])
	var/twos = length(tyranids_by_tier[TYRANID_TIER_TWO])
	var/threes = length(tyranids_by_tier[TYRANID_TIER_THREE])
	var/fours = length(tyranids_by_tier[TYRANID_TIER_FOUR])

	tier3_tyranid_limit = max(threes, FLOOR((zeros + ones + twos + fours) / 3 + length(psychictowers) + 1, 1))
	tier2_tyranid_limit = max(twos, (zeros + ones + fours) + length(psychictowers) * 2 + 1 - threes)

// ***************************************
// *********** Corrupted Tyranids
// ***************************************
/datum/hive_status/corrupted
	name = "Corrupted"
	hivenumber = TYRANID_HIVE_CORRUPTED
	prefix = "Corrupted "
	color = "#00ff80"

// Make sure they can understand english
/datum/hive_status/corrupted/post_add(mob/living/carbon/tyranid/X)
	. = ..()
	X.grant_language(/datum/language/common)

/datum/hive_status/corrupted/post_removal(mob/living/carbon/tyranid/X)
	. = ..()
	X.remove_language(/datum/language/common)

/datum/hive_status/corrupted/can_tyranid_message()
	return TRUE // can always talk in hivemind

/mob/living/carbon/tyranid/queen/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/boiler/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/bull/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/carrier/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/crusher/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/gorger/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/defender/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/defiler/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/drone/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/hivelord/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/hivemind/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/hunter/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/larva/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/praetorian/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/ravager/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/runner/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/sentinel/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/shrike/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/spitter/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/warrior/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/wraith/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/king/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

/mob/living/carbon/tyranid/behemoth/Corrupted
	hivenumber = TYRANID_HIVE_CORRUPTED

// ***************************************
// *********** Misc Tyranids
// ***************************************
/datum/hive_status/alpha
	name = "Alpha"
	hivenumber = TYRANID_HIVE_ALPHA
	prefix = "Alpha "
	color = "#cccc00"

/mob/living/carbon/tyranid/queen/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/boiler/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/bull/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/carrier/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/crusher/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/gorger/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/defender/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/defiler/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/drone/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/hivelord/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/hivemind/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/hunter/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/larva/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/praetorian/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/ravager/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/runner/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/sentinel/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/shrike/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/spitter/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/warrior/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/wraith/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/king/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/mob/living/carbon/tyranid/behemoth/Alpha
	hivenumber = TYRANID_HIVE_ALPHA

/datum/hive_status/beta
	name = "Beta"
	hivenumber = TYRANID_HIVE_BETA
	prefix = "Beta "
	color = "#9999ff"

/mob/living/carbon/tyranid/queen/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/boiler/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/bull/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/carrier/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/crusher/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/gorger/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/defender/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/defiler/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/drone/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/hivelord/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/hivemind/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/hunter/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/larva/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/praetorian/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/ravager/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/runner/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/sentinel/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/shrike/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/spitter/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/warrior/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/wraith/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/king/Beta
	hivenumber = TYRANID_HIVE_BETA

/mob/living/carbon/tyranid/behemoth/Beta
	hivenumber = TYRANID_HIVE_BETA

/datum/hive_status/zeta
	name = "Zeta"
	hivenumber = TYRANID_HIVE_ZETA
	prefix = "Zeta "
	color = "#606060"

/mob/living/carbon/tyranid/queen/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/boiler/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/bull/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/carrier/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/crusher/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/gorger/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/defender/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/defiler/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/drone/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/hivelord/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/hivemind/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/hunter/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/larva/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/praetorian/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/ravager/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/runner/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/sentinel/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/shrike/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/spitter/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/warrior/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/wraith/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/king/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/mob/living/carbon/tyranid/behemoth/Zeta
	hivenumber = TYRANID_HIVE_ZETA

/datum/hive_status/admeme
	name = "Admeme"
	hivenumber = TYRANID_HIVE_ADMEME
	prefix = "Admeme "

/mob/living/carbon/tyranid/queen/admeme
	hivenumber = TYRANID_HIVE_ADMEME

/mob/living/carbon/tyranid/king/admeme
	hivenumber = TYRANID_HIVE_ADMEME

/datum/hive_status/corrupted/fallen
	name = "Fallen"
	hivenumber = TYRANID_HIVE_FALLEN
	prefix = "Fallen "
	color = "#8046ba"

/datum/hive_status/corrupted/fallen/can_tyranid_message()
	return FALSE

/mob/living/carbon/tyranid/queen/Corrupted/fallen
	hivenumber = TYRANID_HIVE_FALLEN

/mob/living/carbon/tyranid/king/Corrupted/fallen
	hivenumber = TYRANID_HIVE_FALLEN

// ***************************************
// *********** Tyranid hive compare helpers
// ***************************************

// Everything below can have a hivenumber set and these ensure easy hive comparisons can be made

// atom level because of /obj/projectile/var/atom/firer
/atom/proc/issametyranidhive(atom/A)
	if(!get_tyranid_hivenumber() || !A?.get_tyranid_hivenumber())
		return FALSE
	return get_tyranid_hivenumber() == A.get_tyranid_hivenumber()

/atom/proc/get_tyranid_hivenumber()
	return FALSE

/obj/alien/egg/get_tyranid_hivenumber()
	return hivenumber

/obj/item/alien_embryo/get_tyranid_hivenumber()
	return hivenumber

/obj/item/clothing/mask/facehugger/get_tyranid_hivenumber()
	return hivenumber

/mob/living/carbon/tyranid/get_tyranid_hivenumber()
	return hivenumber

/mob/illusion/tyranid/get_tyranid_hivenumber()
	var/mob/living/carbon/tyranid/original_tyranid = original_mob
	return original_tyranid.hivenumber

/obj/structure/tyranid/get_tyranid_hivenumber()
	if(hivenumber)
		return hivenumber
	return ..()

/obj/structure/tyranid/trap/get_tyranid_hivenumber()
	if(hugger)
		return hugger.hivenumber
	return ..()

/mob/living/carbon/human/get_tyranid_hivenumber()
	if(faction == FACTION_ZOMBIE)
		return FACTION_ZOMBIE
	return FALSE
