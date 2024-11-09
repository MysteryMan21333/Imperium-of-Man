#define CALLING_BURROWED_DURATION 15 SECONDS

// ***************************************
// *********** Call of the Burrowed
// ***************************************
/datum/action/ability/tyranid_action/call_of_the_burrowed
	name = "Call of the Burrowed"
	desc = "Attempts to summon all currently burrowed larva."
	action_icon_state = "larva_growth"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/leader.dmi'
	ability_cost = 400
	cooldown_duration = 2 MINUTES
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_CALL_OF_THE_BURROWED,
	)
	use_state_flags = ABILITY_USE_LYING


/datum/action/ability/tyranid_action/call_of_the_burrowed/action_activate()
	var/mob/living/carbon/tyranid/shrike/caller = owner
	if(!isnormalhive(caller.hive))
		to_chat(caller, span_warning("Burrowed larva? What a strange concept... It's not for our hive."))
		return FALSE
	var/datum/job/tyranid_job = SSjob.GetJobType(/datum/job/tyranid)
	var/stored_larva = tyranid_job.total_positions - tyranid_job.current_positions
	if(!stored_larva)
		to_chat(caller, span_warning("Our hive currently has no burrowed to call forth!"))
		return FALSE

	playsound(caller,'sound/magic/invoke_general.ogg', 75, TRUE)
	new /obj/effect/temp_visual/telekinesis(get_turf(caller))
	caller.visible_message(span_tyranidwarning("A strange buzzing hum starts to emanate from \the [caller]!"), \
	span_tyraniddanger("We call forth the larvas to rise from their slumber!"))

	if(stored_larva)
		RegisterSignals(caller.hive, list(COMSIG_HIVE_TYRANID_MOTHER_PRE_CHECK, COMSIG_HIVE_TYRANID_MOTHER_CHECK), PROC_REF(is_burrowed_larva_host))
		caller.hive.give_larva_to_next_in_queue()
		notify_ghosts("\The <b>[caller]</b> is calling for the burrowed larvas to wake up!", enter_link = "join_larva=1", enter_text = "Join as Larva", source = caller, action = NOTIFY_JOIN_AS_LARVA)
		addtimer(CALLBACK(src, PROC_REF(calling_larvas_end), caller), CALLING_BURROWED_DURATION)

	succeed_activate()
	add_cooldown()


/datum/action/ability/tyranid_action/call_of_the_burrowed/proc/calling_larvas_end(mob/living/carbon/tyranid/shrike/caller)
	UnregisterSignal(caller.hive, list(COMSIG_HIVE_TYRANID_MOTHER_PRE_CHECK, COMSIG_HIVE_TYRANID_MOTHER_CHECK))


/datum/action/ability/tyranid_action/call_of_the_burrowed/proc/is_burrowed_larva_host(datum/source, list/mothers, list/silos) //Should only register while a viable candidate.
	SIGNAL_HANDLER
	if(!owner.incapacitated())
		mothers += owner //Adding them to the list.


// ***************************************
// *********** Psychic Fling
// ***************************************
/datum/action/ability/activable/tyranid/psychic_fling
	name = "Psychic Fling"
	action_icon_state = "fling"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/shrike.dmi'
	desc = "Sends an enemy or an item flying. A close ranged ability."
	cooldown_duration = 12 SECONDS
	ability_cost = 100
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_PSYCHIC_FLING,
	)
	target_flags = ABILITY_MOB_TARGET


/datum/action/ability/activable/tyranid/psychic_fling/on_cooldown_finish()
	to_chat(owner, span_notice("We gather enough mental strength to fling something again."))
	return ..()


/datum/action/ability/activable/tyranid/psychic_fling/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!isitem(target) && !ishuman(target) && !isdroid(target))	//only items, droids, and mobs can be flung.
		return FALSE
	var/max_dist = 3 //the distance only goes to 3 now, since this is more of a utility then an attack.
	if(!line_of_sight(owner, target, max_dist))
		if(!silent)
			to_chat(owner, span_warning("We must get closer to fling, our mind cannot reach this far."))
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/victim = target
		if(isnestedhost(victim))
			return FALSE
		if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && victim.stat == DEAD)
			return FALSE


/datum/action/ability/activable/tyranid/psychic_fling/use_ability(atom/target)
	var/mob/living/victim = target
	GLOB.round_statistics.psychic_flings++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "psychic_flings")

	owner.visible_message(span_tyranidwarning("A strange and violent psychic aura is suddenly emitted from \the [owner]!"), \
	span_tyranidwarning("We violently fling [victim] with the power of our mind!"))
	victim.visible_message(span_tyranidwarning("[victim] is violently flung away by an unseen force!"), \
	span_tyranidwarning("You are violently flung to the side by an unseen force!"))
	playsound(owner,'sound/effects/magic.ogg', 75, 1)
	playsound(victim,'sound/weapons/alien_claw_block.ogg', 75, 1)

	//Held facehuggers get killed for balance reasons
	for(var/obj/item/clothing/mask/facehugger/hugger in owner.get_held_items())
		hugger.kill_hugger()
		owner.dropItemToGround(hugger)

	succeed_activate()
	add_cooldown()
	if(ishuman(victim))
		victim.apply_effects(2 SECONDS, 0.2 SECONDS) 	// The fling stuns you enough to remove your gun, otherwise the guardsman effectively isn't stunned for long.
		shake_camera(victim, 2, 1)

	var/facing = get_dir(owner, victim)
	var/fling_distance = (isitem(victim)) ? 4 : 3 //Objects get flung further away.
	var/turf/T = victim.loc
	var/turf/temp

	for(var/x in 1 to fling_distance)
		temp = get_step(T, facing)
		if(!temp)
			break
		T = temp
	victim.throw_at(T, fling_distance, 1, owner, TRUE)


// ***************************************
// *********** Unrelenting Force
// ***************************************
/datum/action/ability/activable/tyranid/unrelenting_force
	name = "Unrelenting Force"
	action_icon_state = "screech"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/queen.dmi'
	desc = "Unleashes our raw psychic power, pushing aside anyone who stands in our path."
	cooldown_duration = 50 SECONDS
	ability_cost = 300
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY | ABILITY_IGNORE_SELECTED_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_UNRELENTING_FORCE,
		KEYBINDING_ALTERNATE = COMSIG_TYRANIDABILITY_UNRELENTING_FORCE_SELECT,
	)


/datum/action/ability/activable/tyranid/unrelenting_force/on_cooldown_finish()
	to_chat(owner, span_notice("Our mind is ready to unleash another blast of force."))
	return ..()


/datum/action/ability/activable/tyranid/unrelenting_force/use_ability(atom/target)
	succeed_activate()
	add_cooldown()
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, update_icons)), 1 SECONDS)
	var/mob/living/carbon/tyranid/tyranid = owner
	owner.icon_state = "[tyranid.tyranid_caste.caste_name][(tyranid.tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Screeching"
	if(target) // Keybind use doesn't have a target
		owner.face_atom(target)

	var/turf/lower_left
	var/turf/upper_right
	switch(owner.dir)
		if(NORTH)
			lower_left = locate(owner.x - 1, owner.y + 1, owner.z)
			upper_right = locate(owner.x + 1, owner.y + 3, owner.z)
		if(SOUTH)
			lower_left = locate(owner.x - 1, owner.y - 3, owner.z)
			upper_right = locate(owner.x + 1, owner.y - 1, owner.z)
		if(WEST)
			lower_left = locate(owner.x - 3, owner.y - 1, owner.z)
			upper_right = locate(owner.x - 1, owner.y + 1, owner.z)
		if(EAST)
			lower_left = locate(owner.x + 1, owner.y - 1, owner.z)
			upper_right = locate(owner.x + 3, owner.y + 1, owner.z)

	var/list/things_to_throw = list()
	for(var/turf/affected_tile in block(lower_left, upper_right)) //everything in the 3x3 block is found.
		affected_tile.Shake(duration = 0.5 SECONDS)
		for(var/atom/movable/affected AS in affected_tile)
			if(!ishuman(affected) && !istype(affected, /obj/item) && !isdroid(affected))
				affected.Shake(duration = 0.5 SECONDS)
				continue
			if(ishuman(affected))
				var/mob/living/carbon/human/H = affected
				if(H.stat == DEAD)
					continue
				H.apply_effects(2 SECONDS, 2 SECONDS)
				shake_camera(H, 2, 1)
			things_to_throw += affected

	for(var/atom/movable/affected AS in things_to_throw)
		var/throwlocation = affected.loc
		for(var/x in 1 to 6)
			throwlocation = get_step(throwlocation, owner.dir)
		affected.throw_at(throwlocation, 6, 1, owner, TRUE)

	owner.visible_message(span_tyranidwarning("[owner] sends out a huge blast of psychic energy!"), \
	span_tyranidwarning("We send out a huge blast of psychic energy!"))

	playsound(owner,'sound/effects/bamf.ogg', 75, TRUE)
	playsound(owner, SFX_ALIEN_ROAR, 50)

	//Held facehuggers get killed for balance reasons
	for(var/obj/item/clothing/mask/facehugger/hugger in owner.get_held_items())
		hugger.kill_hugger()
		owner.dropItemToGround(hugger)


// ***************************************
// *********** Psychic Cure
// ***************************************
/datum/action/ability/activable/tyranid/psychic_cure
	name = "Psychic Cure"
	action_icon_state = "heal_tyranid"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/drone.dmi'
	desc = "Heal and remove debuffs from a target."
	cooldown_duration = 1 MINUTES
	ability_cost = 200
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_PSYCHIC_CURE,
	)
	var/heal_range = SHRIKE_HEAL_RANGE
	target_flags = ABILITY_MOB_TARGET


/datum/action/ability/activable/tyranid/psychic_cure/on_cooldown_finish()
	to_chat(owner, span_notice("We gather enough mental strength to cure sisters again."))
	return ..()


/datum/action/ability/activable/tyranid/psychic_cure/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(QDELETED(target))
		return FALSE
	if(!check_distance(target, silent))
		return FALSE
	if(!istyranid(target))
		return FALSE
	var/mob/living/carbon/tyranid/patient = target
	if(!CHECK_BITFIELD(use_state_flags|override_flags, ABILITY_IGNORE_DEAD_TARGET) && patient.stat == DEAD)
		if(!silent)
			to_chat(owner, span_warning("It's too late. This sister won't be coming back."))
		return FALSE


/datum/action/ability/activable/tyranid/psychic_cure/proc/check_distance(atom/target, silent)
	var/dist = get_dist(owner, target)
	if(dist > heal_range)
		if(!silent)
			to_chat(owner, span_warning("Too far for our reach... We need to be [dist - heal_range] steps closer!"))
		return FALSE
	else if(!line_of_sight(owner, target))
		if(!silent)
			to_chat(owner, span_warning("We can't focus properly without a clear line of sight!"))
		return FALSE
	return TRUE


/datum/action/ability/activable/tyranid/psychic_cure/use_ability(atom/target)
	if(owner.do_actions)
		return FALSE
	if(!do_after(owner, 1 SECONDS, IGNORE_TARGET_LOC_CHANGE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL))
		return FALSE
	if(!can_use_ability(target, TRUE))
		return FALSE

	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++
	GLOB.round_statistics.psychic_cures++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "psychic_cures")
	owner.visible_message(span_tyranidwarning("A strange psychic aura is suddenly emitted from \the [owner]!"), \
	span_tyranidwarning("We cure [target] with the power of our mind!"))
	target.visible_message(span_tyranidwarning("[target] suddenly shimmers in a chill light."), \
	span_tyranidwarning("We feel a sudden soothing chill."))

	playsound(target,'sound/effects/magic.ogg', 75, 1)
	new /obj/effect/temp_visual/telekinesis(get_turf(target))
	var/mob/living/carbon/tyranid/patient = target
	patient.heal_wounds(SHRIKE_CURE_HEAL_MULTIPLIER)
	patient.adjust_sunder(-SHRIKE_CURE_HEAL_MULTIPLIER)
	if(patient.health > 0) //If they are not in crit after the heal, let's remove evil debuffs.
		patient.SetUnconscious(0)
		patient.SetStun(0)
		patient.SetParalyzed(0)
		patient.set_stagger(0)
		patient.set_slowdown(0)
	patient.updatehealth()

	owner.changeNext_move(CLICK_CD_RANGE)

	log_combat(owner, patient, "psychically cured")

	succeed_activate()
	add_cooldown()


// ***************************************
// *********** Construct Acid Well
// ***************************************
/datum/action/ability/tyranid_action/place_acidwell
	name = "Place acid well"
	action_icon_state = "place_trap"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/construction.dmi'
	desc = "Place an acid well that can put out fires."
	ability_cost = 400
	cooldown_duration = 2 MINUTES
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_PLACE_ACID_WELL,
	)
	use_state_flags = ABILITY_USE_LYING

/datum/action/ability/tyranid_action/place_acidwell/can_use_action(silent = FALSE, override_flags)
	. = ..()
	var/turf/T = get_turf(owner)
	if(!T || !T.is_weedable() || T.density)
		if(!silent)
			to_chat(owner, span_warning("We can't do that here."))
		return FALSE

	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(!owner_tyranid.loc_weeds_type)
		if(!silent)
			to_chat(owner, span_warning("We can only shape on weeds. We must find some resin before we start building!"))
		return FALSE

	if(!T.check_alien_construction(owner, silent, /obj/structure/tyranid/acidwell))
		return FALSE

	if(!T.check_disallow_alien_fortification(owner, silent))
		return FALSE

/datum/action/ability/tyranid_action/place_acidwell/action_activate()
	var/turf/T = get_turf(owner)
	succeed_activate()

	playsound(T, SFX_ALIEN_RESIN_BUILD, 25)
	new /obj/structure/tyranid/acidwell(T, owner)

	to_chat(owner, span_tyranidnotice("We place an acid well; it can be filled with more acid."))
	GLOB.round_statistics.tyranid_acid_wells++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "tyranid_acid_wells")
	owner.record_traps_created()


// ***************************************
// *********** Psychic Vortex
// ***************************************
#define VORTEX_RANGE 4
#define VORTEX_INITIAL_CHARGE 2 SECONDS
#define VORTEX_POST_INITIAL_CHARGE 0.5 SECONDS
/datum/action/ability/activable/tyranid/psychic_vortex
	name = "Pyschic vortex"
	action_icon_state = "vortex"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/shrike.dmi'
	desc = "Channel a sizable vortex of psychic energy, drawing in nearby enemies."
	ability_cost = 600
	cooldown_duration = 2 MINUTES
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_PSYCHIC_VORTEX,
	)
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder
	///The particle type this ability uses
	var/channel_particle = /particles/warlock_charge

/datum/action/ability/activable/tyranid/psychic_vortex/on_cooldown_finish()
	to_chat(owner, span_notice("Our mind is ready to unleash another chaotic vortex of energy."))
	return ..()

/datum/action/ability/activable/tyranid/psychic_vortex/use_ability(atom/target)
	succeed_activate()
	add_cooldown()

	particle_holder = new(owner, channel_particle)
	particle_holder.pixel_x = 15
	particle_holder.pixel_y = 0

	if(target) // Keybind use doesn't have a target
		owner.face_atom(target)
	ADD_TRAIT(owner, TRAIT_IMMOBILE, VORTEX_ABILITY_TRAIT)
	if(do_after(owner, VORTEX_INITIAL_CHARGE, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER))
		vortex_pull()
	if(do_after(owner, VORTEX_POST_INITIAL_CHARGE, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER))
		vortex_push()
	if(do_after(owner, VORTEX_POST_INITIAL_CHARGE, IGNORE_HELD_ITEM, owner, BUSY_ICON_DANGER))
		vortex_pull()
	QDEL_NULL(particle_holder)
	REMOVE_TRAIT(owner, TRAIT_IMMOBILE, VORTEX_ABILITY_TRAIT)
	return


/**
 * Checks for any non-anchored movable atom, throwing them towards the shrike/owner using the ability.
 * While causing shake to anything in range with effects applied to humans affected.
 */
/datum/action/ability/activable/tyranid/psychic_vortex/proc/vortex_pull()
	playsound(owner, 'sound/effects/seedling_chargeup.ogg', 60)
	for(var/atom/movable/movable_victim in range(VORTEX_RANGE, owner.loc))
		if(movable_victim.anchored || istyranid(movable_victim) || movable_victim.move_resist > MOVE_FORCE_STRONG)
			continue
		if(ishuman(movable_victim))
			var/mob/living/carbon/human/H = movable_victim
			if(H.stat == DEAD)
				continue
			H.apply_effects(1,1)
			H.adjust_stagger(2 SECONDS)
			shake_camera(H, 2, 1)
		else if(isitem(movable_victim))
			var/turf/targetturf = get_turf(owner)
			targetturf = locate(targetturf.x + rand(1, 4), targetturf.y + rand(1, 4), targetturf.z)
			movable_victim.throw_at(targetturf, 4, 1, owner, FALSE, FALSE)
		movable_victim.throw_at(owner, 4, 1, owner, FALSE, FALSE)

/// Randomly throws movable atoms in the radius of the vortex abilites range, different each use.
/datum/action/ability/activable/tyranid/psychic_vortex/proc/vortex_push()
	for(var/atom/movable/movable_victim in range(VORTEX_RANGE, owner.loc))
		if(movable_victim.anchored || istyranid(movable_victim) || movable_victim.move_resist == INFINITY)
			continue
		if(ishuman(movable_victim))
			var/mob/living/carbon/human/human_victim = movable_victim
			if(human_victim.stat == DEAD)
				continue
		var/turf/targetturf = get_turf(owner)
		targetturf = locate(targetturf.x + rand(1, 4), targetturf.y + rand(1, 4), targetturf.z)
		movable_victim.throw_at(targetturf, 4, 1, owner, FALSE, FALSE)
