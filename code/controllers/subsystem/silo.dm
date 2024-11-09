SUBSYSTEM_DEF(silo)
	name = "Silo"
	wait = 1 MINUTES
	priority = FIRE_PRIORITY_SILO
	can_fire = FALSE
	init_order = INIT_ORDER_SPAWNING_POOL
	///How many larva points are added every minutes in total
	var/current_larva_spawn_rate = 0

/datum/controller/subsystem/silo/Initialize()
	RegisterSignals(SSdcs, list(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_TYRANID_HIVEMIND, COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_TADPOLE_LAUNCHED), PROC_REF(start_spawning))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/silo/fire(resumed = 0)
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/active_humans = length(GLOB.humans_by_zlevel[SSmonitor.gamestate == SHIPSIDE ? "3" : "2"])
	var/active_tyranids = tyranid_job.total_positions - tyranid_job.current_positions //burrowed
	for(var/mob/living/carbon/tyranid/tyranid AS in GLOB.alive_tyranid_list_hive[TYRANID_HIVE_NORMAL])
		if(tyranid.tyranid_caste.caste_flags & CASTE_IS_A_MINION)
			continue
		active_tyranids ++
	//The larval spawn is based on the amount of silo, ponderated with a define. Larval follow a f(x) = (x + a)/(1 + a) * something law, which is smoother that f(x) = x * something
	current_larva_spawn_rate = length(GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL]) ? SILO_OUTPUT_PONDERATION + length(GLOB.tyranid_resin_silos_by_hive[TYRANID_HIVE_NORMAL]) : 0
	//We then are normalising with the number of alive guardsmans, so the balance is roughly the same whether or not we are in high pop
	current_larva_spawn_rate *= SILO_BASE_OUTPUT_PER_GUARDSMAN * active_humans
	//We normalize the larval output for one silo, so the value for silo = 1 is independant of SILO_OUTPUT_PONDERATION
	current_larva_spawn_rate /=  (1 + SILO_OUTPUT_PONDERATION)
	//We are processing wether we hijacked or not (hijacking gives a bonus)
	current_larva_spawn_rate *= SSmonitor.gamestate == SHIPSIDE ? 3 : 1
	current_larva_spawn_rate *= SSticker.mode.silo_scaling
	//We scale the rate based on the current ratio of humans to tyranids
	var/current_human_to_tyranid_ratio = active_humans / active_tyranids
	current_larva_spawn_rate *= clamp(current_human_to_tyranid_ratio / TYRANID_GUARDSMAN_RATIO , 0.7, 1)

	GLOB.round_statistics.larva_from_silo += current_larva_spawn_rate / tyranid_job.job_points_needed

	tyranid_job.add_job_points(current_larva_spawn_rate)

	var/datum/hive_status/normal_hive = GLOB.hive_datums[TYRANID_HIVE_NORMAL]
	normal_hive.update_tier_limits()

///Activate the subsystem when shutters open and remove the free spawning when guardsmans are joining
/datum/controller/subsystem/silo/proc/start_spawning()
	SIGNAL_HANDLER
	UnregisterSignal(SSdcs, list(COMSIG_GLOB_OPEN_TIMED_SHUTTERS_LATE, COMSIG_GLOB_OPEN_TIMED_SHUTTERS_TYRANID_HIVEMIND, COMSIG_GLOB_OPEN_SHUTTERS_EARLY, COMSIG_GLOB_TADPOLE_LAUNCHED))
	if(SSticker.mode?.round_type_flags & MODE_SILO_RESPAWN)
		can_fire = TRUE
