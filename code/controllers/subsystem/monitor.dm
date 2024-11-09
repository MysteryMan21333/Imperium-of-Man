SUBSYSTEM_DEF(monitor)
	name = "Monitor"
	init_order = INIT_ORDER_MONITOR
	runlevels = RUNLEVEL_GAME
	wait = 3 MINUTES
	can_fire = TRUE
	///The current state
	var/current_state = STATE_BALANCED
	///The last state
	var/last_state = STATE_BALANCED
	///The current state points. Negative means tyranids are winning, positive points correspond to guardsman winning
	var/current_points = 0
	///The number of humans on ground
	var/human_on_ground = 0
	///The number of humans being in either lz1 or lz2
	var/human_in_FOB = 0
	///The number of humans on the ship
	var/human_on_ship = 0
	///The number of time most of humans are in FOB consecutively
	var/humans_all_in_FOB_counter = 0
	///TRUE if we detect a state of FOB hugging
	var/FOB_hugging = FALSE
	///List of all int stats
	var/datum/monitor_statistics/stats = new
	///If the game is currently before shutters drop, after, or shipside
	var/gamestate = SHUTTERS_CLOSED
	///If the automatic balance system is online
	var/is_automatic_balance_on = TRUE
	///Maximum record of how many players were concurrently playing this round
	var/maximum_connected_players_count = 0

/datum/monitor_statistics
	var/primo_T4 = 0
	var/normal_T4 = 0
	var/primo_T3 = 0
	var/normal_T3 = 0
	var/primo_T2 = 0
	var/normal_T2 = 0
	var/list/miniguns_in_use = list()
	var/list/sadar_in_use = list()
	var/list/b18_in_use = list()
	var/list/b17_in_use = list()

/datum/controller/subsystem/monitor/Initialize()
	RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE, COMSIG_GLOB_OPEN_SHUTTERS_EARLY), PROC_REF(set_groundside_calculation))
	RegisterSignal(SSdcs, COMSIG_GLOB_DROPSHIP_HIJACKED, PROC_REF(set_shipside_calculation))
	is_automatic_balance_on = CONFIG_GET(flag/is_automatic_balance_on)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/monitor/fire(resumed = 0)
	var/total_living_players = length(GLOB.alive_human_list_faction[FACTION_IMPERIUM]) + length(GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL])
	current_points = calculate_state_points() / max(total_living_players, 10)//having less than 10 players gives bad results
	maximum_connected_players_count = max(get_active_player_count(), maximum_connected_players_count)
	if(gamestate == GROUNDSIDE)
		process_human_positions()
		FOB_hugging_check()
	set_state(current_points)

	//Automatic buff system for the tyranid, if they have too much burrowed yet are still losing
	var/proposed_balance_buff = GLOB.tyranid_stat_multiplicator_buff
	if(is_automatic_balance_on)
		proposed_balance_buff = balance_tyranid_team()
	if(abs(proposed_balance_buff - GLOB.tyranid_stat_multiplicator_buff) >= 0.05 || (proposed_balance_buff == 1 && GLOB.tyranid_stat_multiplicator_buff != 1))
		GLOB.tyranid_stat_multiplicator_buff = proposed_balance_buff
		apply_balance_changes()

	if(SSticker.mode?.round_type_flags & MODE_SILOS_SPAWN_MINIONS)
		//Balance spawners output
		for(var/silo in GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL])
			SSspawning.spawnerdata[silo].required_increment = 2 * max(45 SECONDS, 3 MINUTES - SSmonitor.maximum_connected_players_count * SPAWN_RATE_PER_PLAYER) / SSspawning.wait
			SSspawning.spawnerdata[silo].max_allowed_mobs = max(1, MAX_SPAWNABLE_MOB_PER_PLAYER * SSmonitor.maximum_connected_players_count * 0.5)
		for(var/spawner in GLOB.tyranid_spawners_by_hive[TYRANID_HIVE_NORMAL])
			SSspawning.spawnerdata[spawner].required_increment = max(45 SECONDS, 3 MINUTES - SSmonitor.maximum_connected_players_count * SPAWN_RATE_PER_PLAYER) / SSspawning.wait
			SSspawning.spawnerdata[spawner].max_allowed_mobs = max(2, MAX_SPAWNABLE_MOB_PER_PLAYER * SSmonitor.maximum_connected_players_count)

/datum/controller/subsystem/monitor/proc/set_groundside_calculation()
	SIGNAL_HANDLER
	gamestate = GROUNDSIDE

/datum/controller/subsystem/monitor/proc/set_shipside_calculation()
	SIGNAL_HANDLER
	gamestate = SHIPSIDE

///Calculate the points supposedly representating of the situation
/datum/controller/subsystem/monitor/proc/calculate_state_points()
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	switch(gamestate)
		if(GROUNDSIDE)
			. += stats.primo_T2 * PRIMO_T2_WEIGHT
			. += stats.primo_T3 * PRIMO_T3_WEIGHT
			. += stats.normal_T2 * NORMAL_T2_WEIGHT
			. += stats.normal_T3 * NORMAL_T3_WEIGHT
			. += stats.primo_T4 * PRIMO_T4_WEIGHT
			. += stats.normal_T4 * NORMAL_T4_WEIGHT
			. += human_on_ground * HUMAN_LIFE_ON_GROUND_WEIGHT
			. += (length(GLOB.alive_human_list_faction[FACTION_IMPERIUM]) - human_on_ground) * HUMAN_LIFE_ON_SHIP_WEIGHT
			. += length(GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL]) * TYRANIDS_LIFE_WEIGHT
			. += (tyranid_job.total_positions - tyranid_job.current_positions) * BURROWED_LARVA_WEIGHT
			. += length(stats.miniguns_in_use) * MINIGUN_PRICE * REQ_POINTS_WEIGHT
			. += length(stats.sadar_in_use) * SADAR_PRICE * REQ_POINTS_WEIGHT
			. += length(stats.b17_in_use) * B17_PRICE * REQ_POINTS_WEIGHT
			. += length(stats.b18_in_use) * B18_PRICE * REQ_POINTS_WEIGHT
			. += length(GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL]) * SPAWNING_POOL_WEIGHT
			. += SSpoints.supply_points[FACTION_IMPERIUM] * REQ_POINTS_WEIGHT
		if(SHUTTERS_CLOSED)
			. += length(GLOB.alive_human_list_faction[FACTION_IMPERIUM]) * HUMAN_LIFE_WEIGHT_PREGAME
			. += length(GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL]) * TYRANIDS_LIFE_WEIGHT_PREGAME
		if(SHIPSIDE)
			. += length(GLOB.alive_human_list_faction[FACTION_IMPERIUM]) * HUMAN_LIFE_WEIGHT_SHIPSIDE
			. += length(GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL]) * TYRANIDS_LIFE_WEIGHT_SHIPSIDE

///Keep the monitor informed about the position of humans
/datum/controller/subsystem/monitor/proc/process_human_positions()
	human_on_ground = 0
	human_in_FOB = 0
	human_on_ship = 0
	for(var/human in GLOB.alive_human_list_faction[FACTION_IMPERIUM])
		var/turf/TU = get_turf(human)
		var/area/myarea = TU.loc
		if(is_ground_level(TU.z))
			human_on_ground++
			if(myarea.area_flags & NEAR_FOB)
				human_in_FOB++
		else if(is_mainship_level(TU.z))
			human_on_ship++

///Check if we are in a FOB camping situation
/datum/controller/subsystem/monitor/proc/FOB_hugging_check()
	if (human_on_ground && human_in_FOB/(human_on_ground) >= PROPORTION_GUARDSMAN_FOB_HUGGING_THRESHOLD)
		humans_all_in_FOB_counter++
		if (humans_all_in_FOB_counter == 3)
			FOB_hugging = TRUE
			return
		return
	humans_all_in_FOB_counter = 0
	FOB_hugging = FALSE

///Etablish the new monitor state of the game, and update the GLOB values
/datum/controller/subsystem/monitor/proc/set_state(actualPoints)
	//We set the actual state
	if (actualPoints > TYRANIDS_DELAYING_THRESHOLD)
		current_state = TYRANIDS_DELAYING
	else if (actualPoints > TYRANIDS_LOSING_THRESHOLD)
		current_state = TYRANIDS_LOSING
	else if (actualPoints > GUARDSMANS_LOSING_THRESHOLD)
		current_state = STATE_BALANCED
	else if (actualPoints > GUARDSMANS_DELAYING_THRESHOLD)
		current_state = GUARDSMANS_LOSING
	else
		current_state = GUARDSMANS_DELAYING

/**
 * Return the proposed tyranid buff calculated with the number of burrowed, and the state of the game
 */
/datum/controller/subsystem/monitor/proc/balance_tyranid_team()
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	if(current_state >= STATE_BALANCED || ((tyranid_job.total_positions - tyranid_job.current_positions) <= (length(GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL]) * TOO_MUCH_BURROWED_PROPORTION)) || length(GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL]) == 0)
		return 1
	var/datum/hive_status/normal/HN = GLOB.hive_datums[TYRANID_HIVE_NORMAL]
	var/tyranid_alive_plus_burrowed = HN.total_tyranids_for_evolving()
	var/buff_needed_estimation = min( MAXIMUM_TYRANID_BUFF_POSSIBLE , 1 + (tyranid_job.total_positions-tyranid_job.current_positions) / (tyranid_alive_plus_burrowed ? tyranid_alive_plus_burrowed : 1))
	// No need to ask admins every time
	if(GLOB.tyranid_stat_multiplicator_buff != 1)
		return buff_needed_estimation
	var/admin_response = admin_approval("<span color='prefix'>AUTO BALANCE SYSTEM:</span> An excessive amount of burrowed was detected, while the balance system consider that guardsmans are winning. [span_boldnotice("Considering the amount of burrowed larvas, a stat buff of [buff_needed_estimation * 100]% will be applied to health, health recovery, and melee damages.")]",
		options = list("approve" = "approve", "deny" = "deny", "shutdown balance system" = "shutdown balance system"),
		admin_sound = sound('sound/effects/sos-morse-code.ogg', channel = CHANNEL_ADMIN))
	if(admin_response != "approve")
		if(admin_response == "shutdown balance system")
			is_automatic_balance_on = FALSE
		return 1
	return buff_needed_estimation


/**
 * Will multiply every base health, regen and melee damage stat on all tyranid by GLOB.tyranid_stat_multiplicator_buff
 */
/datum/controller/subsystem/monitor/proc/apply_balance_changes()
	for(var/mob/living/carbon/tyranid/tyranid AS in GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL])
		tyranid.apply_health_stat_buff()
	for(var/tyranid_caste_typepath in GLOB.tyranid_caste_datums)
		for(var/upgrade in GLOB.tyranid_caste_datums[tyranid_caste_typepath])
			var/datum/tyranid_caste/caste = GLOB.tyranid_caste_datums[tyranid_caste_typepath][upgrade]
			caste.melee_damage = initial(caste.melee_damage) * GLOB.tyranid_stat_multiplicator_buff
