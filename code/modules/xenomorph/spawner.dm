
/obj/structure/tyranid/spawner
	name = "spawner"
	desc = "A slimy, oozy resin bed filled with foul-looking egg-like ...things."
	icon = 'modular_imperium/master_files/icons/tyranid/3x3building.dmi'
	icon_state = "spawner"
	bound_width = 96
	bound_height = 96
	max_integrity = 500
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE
	tyranid_structure_flags = IGNORE_WEED_REMOVAL | CRITICAL_STRUCTURE
	///For minimap icon change if silo takes damage or nearby hostile
	var/warning
	COOLDOWN_DECLARE(spawner_damage_alert_cooldown)
	COOLDOWN_DECLARE(spawner_proxy_alert_cooldown)
	var/linked_minions = list()

/obj/structure/tyranid/spawner/Initialize(mapload, _hivenumber)
	. = ..()
	LAZYADDASSOC(GLOB.tyranid_spawners_by_hive, hivenumber, src)
	SSspawning.registerspawner(src, INFINITY, GLOB.tyranid_ai_spawnable, 0, 0, CALLBACK(src, PROC_REF(on_spawn)))
	SSspawning.spawnerdata[src].required_increment = max(45 SECONDS, 3 MINUTES - SSmonitor.maximum_connected_players_count * SPAWN_RATE_PER_PLAYER)/SSspawning.wait
	SSspawning.spawnerdata[src].max_allowed_mobs = max(2, MAX_SPAWNABLE_MOB_PER_PLAYER * SSmonitor.maximum_connected_players_count)
	for(var/turfs in RANGE_TURFS(TYRANID_SILO_DETECTION_RANGE, src))
		RegisterSignal(turfs, COMSIG_ATOM_ENTERED, PROC_REF(spawner_proxy_alert))
	update_minimap_icon()

/obj/structure/tyranid/spawner/examine(mob/user)
	. = ..()
	var/current_integrity = (obj_integrity / max_integrity) * 100
	switch(current_integrity)
		if(0 to 20)
			. += span_warning("It's barely holding, there's leaking oozes all around, and most eggs are broken. Yet it is not inert.")
		if(20 to 40)
			. += span_warning("It looks severely damaged, its movements slow.")
		if(40 to 60)
			. += span_warning("It's quite beat up, but it seems alive.")
		if(60 to 80)
			. += span_warning("It's slightly damaged, but still seems healthy.")
		if(80 to 100)
			. += span_info("It appears in good shape, pulsating healthily.")


/obj/structure/tyranid/spawner/take_damage(damage_amount, damage_type = BRUTE, armor_type = null, effects = TRUE, attack_dir, armour_penetration = 0, mob/living/blame_mob)
	. = ..()
	spawner_damage_alert()

///Alert if spawner is receiving damage
/obj/structure/tyranid/spawner/proc/spawner_damage_alert()
	if(!COOLDOWN_CHECK(src, spawner_damage_alert_cooldown))
		warning = FALSE
		return
	warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].tyranid_message("Our [name] at [AREACOORD_NO_Z(src)] is under attack! It has [obj_integrity]/[max_integrity] Health remaining.", "tyranidannounce", 5, FALSE, src, 'sound/voice/alien/help1.ogg',FALSE, null, /atom/movable/screen/arrow/silo_damaged_arrow)
	COOLDOWN_START(src, spawner_damage_alert_cooldown, TYRANID_SILO_HEALTH_ALERT_COOLDOWN) //set the cooldown.
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), TYRANID_SILO_DETECTION_COOLDOWN) //clear warning

///Alerts the Hive when hostiles get too close to their spawner
/obj/structure/tyranid/spawner/proc/spawner_proxy_alert(datum/source, atom/movable/hostile, direction)
	SIGNAL_HANDLER

	if(!COOLDOWN_CHECK(src, spawner_proxy_alert_cooldown)) //Proxy alert triggered too recently; abort
		warning = FALSE
		return

	if(!isliving(hostile))
		return

	var/mob/living/living_triggerer = hostile
	if(living_triggerer.stat == DEAD) //We don't care about the dead
		return

	if(istyranid(hostile))
		var/mob/living/carbon/tyranid/X = hostile
		if(X.hivenumber == hivenumber) //Trigger proxy alert only for hostile tyranids
			return

	warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].tyranid_message("Our [name] has detected a nearby hostile [hostile] at [get_area(hostile)] (X: [hostile.x], Y: [hostile.y]).", "tyranidannounce", 5, FALSE, hostile, 'sound/voice/alien/help1.ogg', FALSE, null, /atom/movable/screen/arrow/leader_tracker_arrow)
	COOLDOWN_START(src, spawner_proxy_alert_cooldown, TYRANID_SILO_DETECTION_COOLDOWN) //set the cooldown.
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), TYRANID_SILO_DETECTION_COOLDOWN) //clear warning

///Clears the warning for minimap if its warning for hostiles
/obj/structure/tyranid/spawner/proc/clear_warning()
	warning = FALSE
	update_minimap_icon()

/obj/structure/tyranid/spawner/Destroy()
	GLOB.tyranid_spawners_by_hive[hivenumber] -= src
	return ..()

///Change minimap icon if spawner is under attack or not
/obj/structure/tyranid/spawner/proc/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_TYRANID, image('icons/UI_icons/map_blips.dmi', null, "spawner[warning ? "_warn" : "_passive"]", ABOVE_FLOAT_LAYER))

/// Transfers the spawned minion to the silo's hivenumber.
/obj/structure/tyranid/spawner/proc/on_spawn(list/newly_spawned_things)
	for(var/mob/living/carbon/tyranid/spawned_minion AS in newly_spawned_things)
		spawned_minion.transfer_to_hive(hivenumber)
		linked_minions += spawned_minion
		if(hivenumber == TYRANID_HIVE_FALLEN) //snowflake so valhalla isnt filled with minions after you're done
			RegisterSignal(src, COMSIG_QDELETING, PROC_REF(kill_linked_minions))

/obj/structure/tyranid/spawner/proc/kill_linked_minions()
	for(var/mob/living/carbon/tyranid/linked in linked_minions)
		linked.death(TRUE)
	UnregisterSignal(src, COMSIG_QDELETING)
