/datum/game_mode/infestation/crash
	name = "Crash"
	config_tag = "Crash"
	round_type_flags = MODE_INFESTATION|MODE_TYRANID_SPAWN_PROTECT|MODE_DEAD_GRAB_FORBIDDEN|MODE_DISALLOW_RAILGUN
	tyranid_abilities_flags = ABILITY_CRASH
	valid_job_types = list(
		/datum/job/terragov/squad/standard = -1,
		/datum/job/terragov/squad/engineer = 1,
		/datum/job/terragov/squad/corpsman = 1,
		/datum/job/terragov/squad/smartgunner = 1,
		/datum/job/terragov/squad/leader = 1,
		/datum/job/terragov/medical/professor = 1,
		/datum/job/terragov/silicon/synthetic = 1,
		/datum/job/terragov/command/fieldcommander = 1,
		/datum/job/tyranid = FREE_TYRANID_AT_START
	)
	job_points_needed_by_job_type = list(
		/datum/job/terragov/squad/smartgunner = 20,
		/datum/job/terragov/squad/corpsman = 5,
		/datum/job/terragov/squad/engineer = 5,
		/datum/job/tyranid = CRASH_LARVA_POINTS_NEEDED,
	)
	tyranidrespawn_time = 3 MINUTES
	blacklist_ground_maps = list(MAP_BIG_RED, MAP_DELTA_STATION, MAP_PRISON_STATION, MAP_LV_624, MAP_WHISKEY_OUTPOST, MAP_OSCAR_OUTPOST, MAP_FORT_PHOBOS, MAP_CHIGUSA, MAP_LAVA_OUTPOST, MAP_CORSAT, MAP_KUTJEVO_REFINERY, MAP_BLUESUMMERS)

	// Round end conditions
	var/shuttle_landed = FALSE
	var/guardsmans_evac = CRASH_EVAC_NONE

	// Shuttle details
	var/shuttle_id = SHUTTLE_CANTERBURY
	var/obj/docking_port/mobile/crashmode/shuttle

	// Round start info
	var/starting_squad = "Alpha"
	///How long between two larva check
	var/larva_check_interval = 2 MINUTES
	///Last time larva balance was checked
	var/last_larva_check
	bioscan_interval = 0

/datum/game_mode/infestation/crash/pre_setup()
	. = ..()

	// Spawn the ship
	if(TGS_CLIENT_COUNT >= 25)
		shuttle_id = SHUTTLE_BIGBURY
	if(!SSmapping.shuttle_templates[shuttle_id])
		message_admins("Gamemode: couldn't find a valid shuttle template for [shuttle_id]")
		CRASH("Shuttle [shuttle_id] wasn't found and can't be loaded")

	var/datum/map_template/shuttle/ST = SSmapping.shuttle_templates[shuttle_id]
	shuttle = SSshuttle.load_template_to_transit(ST)

	// Redefine the relevant spawnpoints after spawning the ship.
	for(var/job_type in shuttle.spawns_by_job)
		GLOB.spawns_by_job[job_type] = shuttle.spawns_by_job[job_type]

	GLOB.latejoin = shuttle.latejoins
	GLOB.latejoin_cryo = shuttle.latejoins
	GLOB.latejoin_gateway = shuttle.latejoins
	// Launch shuttle
	var/list/valid_docks = list()
	for(var/obj/docking_port/stationary/crashmode/potential_crash_site in SSshuttle.stationary)
		if(!shuttle.check_dock(potential_crash_site, silent = TRUE))
			continue
		valid_docks += potential_crash_site

	if(!length(valid_docks))
		CRASH("No valid crash sides found!")
	var/obj/docking_port/stationary/crashmode/actual_crash_site = pick(valid_docks)

	shuttle.crashing = TRUE
	SSshuttle.moveShuttleToDock(shuttle.id, actual_crash_site, TRUE) // FALSE = instant arrival
	addtimer(CALLBACK(src, PROC_REF(crash_shuttle), actual_crash_site), 10 MINUTES)


/datum/game_mode/infestation/crash/post_setup()
	. = ..()
	for(var/i in GLOB.tyranid_resin_silo_turfs)
		new /obj/structure/tyranid/silo(i)
		new /obj/structure/tyranid/pherotower(i)

	for(var/obj/effect/landmark/corpsespawner/corpse AS in GLOB.corpse_landmarks_list)
		corpse.create_mob()


	for(var/i in GLOB.nuke_spawn_locs)
		new /obj/machinery/nuclearbomb(i)

	for(var/obj/machinery/computer/shuttle/shuttle_control/computer_to_disable AS in GLOB.shuttle_controls_list)
		if(istype(computer_to_disable, /obj/machinery/computer/shuttle/shuttle_control/canterbury))
			continue
		computer_to_disable.machine_stat |= BROKEN
		computer_to_disable.update_icon()

	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_CRASH)
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_EXPLODED, PROC_REF(on_nuclear_explosion))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_DIFFUSED, PROC_REF(on_nuclear_diffuse))
	RegisterSignal(SSdcs, COMSIG_GLOB_NUKE_START, PROC_REF(on_nuke_started))

	if(!(round_type_flags & MODE_INFESTATION))
		return

	for(var/i in GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL])
		if(istyranidlarva(i)) // Larva
			var/mob/living/carbon/tyranid/larva/X = i
			X.evolution_stored = X.tyranid_caste.evolution_threshold //Immediate roundstart evo for larva.
		else // Handles Shrike etc
			var/mob/living/carbon/tyranid/X = i
			X.upgrade_stored = X.tyranid_caste.upgrade_threshold


/datum/game_mode/infestation/crash/announce()
	to_chat(world, span_round_header("The current map is - [SSmapping.configs[GROUND_MAP].map_name]!"))
	priority_announce(
		message = "Scheduled for landing in T-10 Minutes. Prepare for landing. Known hostiles near LZ. Detonation Protocol Active, planet disposable. Guardsmans disposable.",
		title = "Good morning, guardsmans.",
		type = ANNOUNCEMENT_PRIORITY,
		color_override = "red"
	)
	playsound(shuttle, 'sound/machines/warning-buzzer.ogg', 75, 0, 30)


/datum/game_mode/infestation/crash/process()
	. = ..()

	if(world.time > last_larva_check + larva_check_interval)
		balance_scales()
		last_larva_check = world.time

/datum/game_mode/infestation/crash/proc/crash_shuttle(obj/docking_port/stationary/target)
	shuttle_landed = TRUE
	shuttle.crashing = FALSE

	generate_nuke_disk_spawners()

/datum/game_mode/infestation/crash/check_finished(force_end)
	if(round_finished)
		return TRUE

	if(!shuttle_landed && !force_end)
		return FALSE

	var/list/living_player_list = count_humans_and_tyranids(count_flags = COUNT_IGNORE_HUMAN_SSD)
	var/num_humans = living_player_list[1]

	if(num_humans && planet_nuked == INFESTATION_NUKE_NONE && guardsmans_evac == CRASH_EVAC_NONE && !force_end)
		return FALSE

	switch(planet_nuked)

		if(INFESTATION_NUKE_NONE)
			if(!num_humans)
				message_admins("Round finished: [MODE_INFESTATION_X_MAJOR]") //tyranids wiped out ALL the guardsmans
				round_finished = MODE_INFESTATION_X_MAJOR
				return TRUE
			if(guardsmans_evac == CRASH_EVAC_COMPLETED || (!length(GLOB.active_nuke_list) && guardsmans_evac != CRASH_EVAC_NONE))
				message_admins("Round finished: [MODE_INFESTATION_X_MINOR]") //guardsmans evaced without a nuke
				round_finished = MODE_INFESTATION_X_MINOR
				return TRUE

		if(INFESTATION_NUKE_COMPLETED)
			if(guardsmans_evac == CRASH_EVAC_NONE)
				message_admins("Round finished: [MODE_INFESTATION_M_MINOR]") //guardsmans nuked the planet but didn't evac
				round_finished = MODE_INFESTATION_M_MINOR
				return TRUE
			message_admins("Round finished: [MODE_INFESTATION_M_MAJOR]") //guardsmans nuked the planet and managed to evac
			round_finished = MODE_INFESTATION_M_MAJOR
			return TRUE

		if(INFESTATION_NUKE_COMPLETED_SHIPSIDE, INFESTATION_NUKE_COMPLETED_OTHER)
			message_admins("Round finished: [MODE_INFESTATION_X_MAJOR]") //guardsmans nuked themselves somehow
			round_finished = MODE_INFESTATION_X_MAJOR
			return TRUE

	return FALSE


/datum/game_mode/infestation/crash/on_nuclear_diffuse(obj/machinery/nuclearbomb/bomb, mob/living/carbon/tyranid/X)
	var/list/living_player_list = count_humans_and_tyranids(count_flags = COUNT_IGNORE_HUMAN_SSD)
	var/num_humans = living_player_list[1]
	if(!num_humans) // no humans left on planet to try and restart it.
		addtimer(VARSET_CALLBACK(src, guardsmans_evac, CRASH_EVAC_COMPLETED), 10 SECONDS)

/datum/game_mode/infestation/crash/can_summon_dropship(mob/user)
	to_chat(src, span_warning("This power doesn't work in this gamemode."))
	return FALSE

/datum/game_mode/infestation/crash/proc/balance_scales()
	var/datum/hive_status/normal/tyranid_hive = GLOB.hive_datums[TYRANID_HIVE_NORMAL]
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/stored_larva = tyranid_job.total_positions - tyranid_job.current_positions
	if(stored_larva)
		return //No need for respawns
	var/num_tyranids = tyranid_hive.get_total_tyranid_number() + stored_larva
	if(!num_tyranids)
		tyranid_job.add_job_positions(1)
		return
	var/larva_surplus = (get_total_joblarvaworth() - (num_tyranids * tyranid_job.job_points_needed )) / tyranid_job.job_points_needed
	if(larva_surplus < 1)
		return //Things are balanced, no burrowed needed
	tyranid_job.add_job_positions(1)
	tyranid_hive.update_tier_limits()

/datum/game_mode/infestation/crash/get_total_joblarvaworth(list/z_levels, count_flags)
	. = 0

	for(var/mob/living/carbon/human/H AS in GLOB.human_mob_list)
		if(!H.job)
			continue
		if(isspaceturf(H.loc))
			continue
		. += H.job.jobworth[/datum/job/tyranid]

