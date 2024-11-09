// ***************************************
// *********** Tail sweep
// ***************************************
/datum/action/ability/tyranid_action/tail_sweep
	name = "Tail Sweep"
	action_icon_state = "tail_sweep"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/defender.dmi'
	desc = "Hit all adjacent units around you, knocking them away and down."
	ability_cost = 35
	use_state_flags = ABILITY_USE_CRESTED
	cooldown_duration = 12 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TAIL_SWEEP,
	)

/datum/action/ability/tyranid_action/tail_sweep/can_use_action(silent, override_flags)
	. = ..()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	if(tyranid_owner.crest_defense && tyranid_owner.plasma_stored < (ability_cost * 2))
		to_chat(tyranid_owner, span_tyranidwarning("We don't have enough plasma, we need [(ability_cost * 2) - tyranid_owner.plasma_stored] more plasma!"))
		return FALSE

/datum/action/ability/tyranid_action/tail_sweep/action_activate()
	var/mob/living/carbon/tyranid/tyranid_owner = owner

	GLOB.round_statistics.defender_tail_sweeps++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "defender_tail_sweeps")
	tyranid_owner.visible_message(span_tyranidwarning("\The [tyranid_owner] sweeps its tail in a wide circle!"), \
	span_tyranidwarning("We sweep our tail in a wide circle!"))

	tyranid_owner.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX
	tyranid_owner.spin(4, 1)
	tyranid_owner.enable_throw_parry(0.6 SECONDS)
	playsound(tyranid_owner,pick('sound/effects/alien/tail_swipe1.ogg','sound/effects/alien/tail_swipe2.ogg','sound/effects/alien/tail_swipe3.ogg'), 25, 1) //Sound effects

	var/sweep_range = 1
	var/list/L = orange(sweep_range, tyranid_owner)		// Not actually the fruit

	for (var/mob/living/carbon/human/H in L)
		if(H.stat == DEAD || !tyranid_owner.Adjacent(H))
			continue
		H.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX; motion blur
		addtimer(CALLBACK(H, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
		var/damage = tyranid_owner.tyranid_caste.melee_damage
		var/affecting = H.get_limb(ran_zone(null, 0))
		if(!affecting) //Still nothing??
			affecting = H.get_limb("chest") //Gotta have a torso?!
		H.knockback(tyranid_owner, sweep_range, 4)
		H.apply_damage(damage, BRUTE, affecting, MELEE)
		H.apply_damage(damage, STAMINA, updating_health = TRUE)
		H.Paralyze(0.5 SECONDS) //trip and go
		GLOB.round_statistics.defender_tail_sweep_hits++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "defender_tail_sweep_hits")
		shake_camera(H, 2, 1)

		to_chat(H, span_tyranidwarning("We are struck by \the [tyranid_owner]'s tail sweep!"))
		playsound(H,'sound/weapons/alien_claw_block.ogg', 50, 1)

	addtimer(CALLBACK(tyranid_owner, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
	succeed_activate()
	if(tyranid_owner.crest_defense)
		tyranid_owner.use_plasma(ability_cost)
	add_cooldown()

/datum/action/ability/tyranid_action/tail_sweep/on_cooldown_finish()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	to_chat(tyranid_owner, span_notice("We gather enough strength to tail sweep again."))
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	return ..()

/datum/action/ability/tyranid_action/tail_sweep/ai_should_start_consider()
	return TRUE

/datum/action/ability/tyranid_action/tail_sweep/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	if(get_dist(target, owner) > 1)
		return FALSE
	if(!can_use_action(override_flags = ABILITY_IGNORE_SELECTED_ABILITY))
		return FALSE
	if(target.get_tyranid_hivenumber() == owner.get_tyranid_hivenumber())
		return FALSE
	return TRUE

// ***************************************
// *********** Forward Charge
// ***************************************
/datum/action/ability/activable/tyranid/charge/forward_charge
	name = "Forward Charge"
	action_icon_state = "pounce"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/runner.dmi'
	desc = "Charge up to 4 tiles and knockdown any targets in our way."
	cooldown_duration = 10 SECONDS
	ability_cost = 80
	use_state_flags = ABILITY_USE_CRESTED|ABILITY_USE_FORTIFIED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_FORWARD_CHARGE,
	)
	charge_range = DEFENDER_CHARGE_RANGE
	///How long is the windup before charging
	var/windup_time = 0.5 SECONDS

/datum/action/ability/activable/tyranid/charge/forward_charge/use_ability(atom/A)
	if(!A)
		return
	var/mob/living/carbon/tyranid/tyranid_owner = owner

	if(!do_after(tyranid_owner, windup_time, IGNORE_HELD_ITEM, tyranid_owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_ability), A, FALSE, ABILITY_USE_BUSY)))
		return fail_activate()

	var/mob/living/carbon/tyranid/defender/defender = tyranid_owner
	if(defender.fortify)
		var/datum/action/ability/tyranid_action/fortify/fortify_action = tyranid_owner.actions_by_path[/datum/action/ability/tyranid_action/fortify]

		fortify_action.set_fortify(FALSE, TRUE)
		fortify_action.add_cooldown()
		to_chat(tyranid_owner, span_tyranidwarning("We rapidly untuck ourselves, preparing to surge forward."))

	tyranid_owner.visible_message(span_danger("[tyranid_owner] charges towards \the [A]!"), \
	span_danger("We charge towards \the [A]!") )
	tyranid_owner.emote("roar")
	succeed_activate()

	RegisterSignal(tyranid_owner, COMSIG_TYRANID_OBJ_THROW_HIT, PROC_REF(obj_hit))
	RegisterSignal(tyranid_owner, COMSIG_TYRANID_LEAP_BUMP, PROC_REF(mob_hit))
	RegisterSignal(tyranid_owner, COMSIG_MOVABLE_POST_THROW, PROC_REF(charge_complete))
	tyranid_owner.tyranid_flags |= TYRANID_LEAPING

	tyranid_owner.throw_at(A, charge_range, 5, tyranid_owner)

	add_cooldown()

/datum/action/ability/activable/tyranid/charge/forward_charge/mob_hit(datum/source, mob/living/living_target)
	. = TRUE
	if(living_target.stat || istyranid(living_target) || !(iscarbon(living_target))) //we leap past tyranids
		return

	var/mob/living/carbon/tyranid/tyranid_owner = owner
	var/mob/living/carbon/carbon_victim = living_target
	var/extra_dmg = tyranid_owner.tyranid_caste.melee_damage * tyranid_owner.tyranid_melee_damage_modifier * 0.5 // 50% dmg reduction
	carbon_victim.attack_alien_harm(tyranid_owner, extra_dmg, FALSE, TRUE, FALSE, TRUE) //Location is always random, cannot crit, harm only
	var/target_turf = get_ranged_target_turf(carbon_victim, get_dir(src, carbon_victim), rand(1, 2)) //we blast our victim behind us
	target_turf = get_step_rand(target_turf) //Scatter
	carbon_victim.throw_at(get_turf(target_turf), charge_range, 5, src)
	carbon_victim.Paralyze(4 SECONDS)

/datum/action/ability/activable/tyranid/charge/forward_charge/ai_should_use(atom/target)
	. = ..()
	if(!.)
		return
	action_activate()
	LAZYINCREMENT(owner.do_actions, target)
	addtimer(CALLBACK(src, PROC_REF(decrease_do_action), target), windup_time)

///Decrease the do_actions of the owner
/datum/action/ability/activable/tyranid/charge/forward_charge/proc/decrease_do_action(atom/target)
	LAZYDECREMENT(owner.do_actions, target)

// ***************************************
// *********** Crest defense
// ***************************************
/datum/action/ability/tyranid_action/toggle_crest_defense
	name = "Toggle Crest Defense"
	action_icon_state = "crest_defense"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/defender.dmi'
	desc = "Increase your resistance to projectiles at the cost of move speed. Can use abilities while in Crest Defense."
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED // duh
	cooldown_duration = 1 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_CREST_DEFENSE,
	)
	var/last_crest_bonus = 0

/datum/action/ability/tyranid_action/toggle_crest_defense/give_action()
	. = ..()
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner
	last_crest_bonus = tyranid_owner.tyranid_caste.crest_defense_armor

/datum/action/ability/tyranid_action/toggle_crest_defense/on_tyranid_upgrade()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	if(tyranid_owner.crest_defense)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(-last_crest_bonus)
		last_crest_bonus = tyranid_owner.tyranid_caste.crest_defense_armor
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(last_crest_bonus)
		tyranid_owner.add_movespeed_modifier(MOVESPEED_ID_CRESTDEFENSE, TRUE, 0, NONE, TRUE, tyranid_owner.tyranid_caste.crest_defense_slowdown)
	else
		last_crest_bonus = tyranid_owner.tyranid_caste.crest_defense_armor

/datum/action/ability/tyranid_action/toggle_crest_defense/on_cooldown_finish()
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner
	to_chat(tyranid_owner, span_notice("We can [tyranid_owner.crest_defense ? "raise" : "lower"] our crest."))
	return ..()

/datum/action/ability/tyranid_action/toggle_crest_defense/action_activate()
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner

	if(tyranid_owner.crest_defense)
		set_crest_defense(FALSE)
		add_cooldown()
		return succeed_activate()

	var/was_fortified = tyranid_owner.fortify
	if(tyranid_owner.fortify)
		var/datum/action/ability/tyranid_action/fortify/FT = tyranid_owner.actions_by_path[/datum/action/ability/tyranid_action/fortify]
		if(FT.cooldown_timer)
			to_chat(tyranid_owner, span_tyranidwarning("We cannot yet untuck ourselves!"))
			return fail_activate()
		FT.set_fortify(FALSE, TRUE)
		FT.add_cooldown()
		to_chat(tyranid_owner, span_tyranidwarning("We carefully untuck, keeping our crest lowered."))

	set_crest_defense(TRUE, was_fortified)
	add_cooldown()
	return succeed_activate()

/datum/action/ability/tyranid_action/toggle_crest_defense/proc/set_crest_defense(on, silent = FALSE)
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner
	if(on)
		if(!silent)
			to_chat(tyranid_owner, span_tyranidwarning("We tuck ourselves into a defensive stance."))
		GLOB.round_statistics.defender_crest_lowerings++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "defender_crest_lowerings")
		ADD_TRAIT(tyranid_owner, TRAIT_STAGGERIMMUNE, CREST_DEFENSE_TRAIT) //Can now endure impacts/damages that would make lesser tyranids flinch
		tyranid_owner.move_resist = MOVE_FORCE_EXTREMELY_STRONG
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(last_crest_bonus)
		tyranid_owner.add_movespeed_modifier(MOVESPEED_ID_CRESTDEFENSE, TRUE, 0, NONE, TRUE, tyranid_owner.tyranid_caste.crest_defense_slowdown)
	else
		if(!silent)
			to_chat(tyranid_owner, span_tyranidwarning("We raise our crest."))
		GLOB.round_statistics.defender_crest_raises++
		SSblackbox.record_feedback("tally", "round_statistics", 1, "defender_crest_raises")
		REMOVE_TRAIT(tyranid_owner, TRAIT_STAGGERIMMUNE, CREST_DEFENSE_TRAIT)
		tyranid_owner.move_resist = initial(tyranid_owner.move_resist)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(-last_crest_bonus)
		tyranid_owner.remove_movespeed_modifier(MOVESPEED_ID_CRESTDEFENSE)

	tyranid_owner.crest_defense = on
	tyranid_owner.update_icons()

// ***************************************
// *********** Fortify
// ***************************************
/datum/action/ability/tyranid_action/fortify
	name = "Fortify"
	action_icon_state = "fortify"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/defender.dmi'
	desc = "Plant yourself for a large defensive boost."
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED
	cooldown_duration = 1 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_FORTIFY,
	)
	var/last_fortify_bonus = 0

/datum/action/ability/tyranid_action/fortify/give_action()
	. = ..()
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner
	last_fortify_bonus = tyranid_owner.tyranid_caste.fortify_armor

/datum/action/ability/tyranid_action/fortify/on_tyranid_upgrade()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	if(tyranid_owner.fortify)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(-last_fortify_bonus)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyRating(BOMB = -last_fortify_bonus)

		last_fortify_bonus = tyranid_owner.tyranid_caste.fortify_armor

		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(last_fortify_bonus)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyRating(BOMB = last_fortify_bonus)
	else
		last_fortify_bonus = tyranid_owner.tyranid_caste.fortify_armor

/datum/action/ability/tyranid_action/fortify/on_cooldown_finish()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	to_chat(tyranid_owner, span_notice("We can [tyranid_owner.fortify ? "stand up" : "fortify"] again."))
	return ..()

/datum/action/ability/tyranid_action/fortify/action_activate()
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner

	if(tyranid_owner.fortify)
		set_fortify(FALSE)
		add_cooldown()
		return succeed_activate()

	var/was_crested = tyranid_owner.crest_defense
	if(tyranid_owner.crest_defense)
		var/datum/action/ability/tyranid_action/toggle_crest_defense/CD = tyranid_owner.actions_by_path[/datum/action/ability/tyranid_action/toggle_crest_defense]
		if(CD.cooldown_timer)
			to_chat(tyranid_owner, span_tyranidwarning("We cannot yet transition to a defensive stance!"))
			return fail_activate()
		CD.set_crest_defense(FALSE, TRUE)
		CD.add_cooldown()
		to_chat(tyranid_owner, span_tyranidwarning("We tuck our lowered crest into ourselves."))

	var/datum/action/ability/activable/tyranid/charge/forward_charge/combo_cooldown = tyranid_owner.actions_by_path[/datum/action/ability/activable/tyranid/charge/forward_charge]
	combo_cooldown.add_cooldown(cooldown_duration)

	set_fortify(TRUE, was_crested)
	add_cooldown()
	return succeed_activate()

/datum/action/ability/tyranid_action/fortify/proc/set_fortify(on, silent = FALSE)
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner
	GLOB.round_statistics.defender_fortifiy_toggles++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "defender_fortifiy_toggles")
	if(on)
		ADD_TRAIT(tyranid_owner, TRAIT_IMMOBILE, FORTIFY_TRAIT)
		ADD_TRAIT(tyranid_owner, TRAIT_STOPS_TANK_COLLISION, FORTIFY_TRAIT)
		if(!silent)
			to_chat(tyranid_owner, span_tyranidwarning("We tuck ourselves into a defensive stance."))
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(last_fortify_bonus)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyRating(BOMB = last_fortify_bonus) //double bomb bonus for explosion immunity
	else
		if(!silent)
			to_chat(tyranid_owner, span_tyranidwarning("We resume our normal stance."))
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyAllRatings(-last_fortify_bonus)
		tyranid_owner.soft_armor = tyranid_owner.soft_armor.modifyRating(BOMB = -last_fortify_bonus)
		REMOVE_TRAIT(tyranid_owner, TRAIT_IMMOBILE, FORTIFY_TRAIT)
		REMOVE_TRAIT(tyranid_owner, TRAIT_STOPS_TANK_COLLISION, FORTIFY_TRAIT)

	tyranid_owner.fortify = on
	tyranid_owner.anchored = on
	playsound(tyranid_owner.loc, 'sound/effects/stonedoor_openclose.ogg', 30, TRUE)
	tyranid_owner.update_icons()

// ***************************************
// *********** Regenerate Skin
// ***************************************
/datum/action/ability/tyranid_action/regenerate_skin
	name = "Regenerate Skin"
	action_icon_state = "regenerate_skin"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/defender.dmi'
	desc = "Regenerate your hard exoskeleton skin, restoring some health and removing all sunder."
	use_state_flags = ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED|ABILITY_TARGET_SELF|ABILITY_IGNORE_SELECTED_ABILITY|ABILITY_KEYBIND_USE_ABILITY|ABILITY_USE_LYING
	ability_cost = 160
	cooldown_duration = 1 MINUTES
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_REGENERATE_SKIN,
	)

/datum/action/ability/tyranid_action/regenerate_skin/on_cooldown_finish()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	to_chat(tyranid_owner, span_notice("We feel we are ready to shred our skin and grow another."))
	return ..()

/datum/action/ability/tyranid_action/regenerate_skin/action_activate()
	var/mob/living/carbon/tyranid/defender/tyranid_owner = owner

	if(!can_use_action(TRUE))
		return fail_activate()

	if(tyranid_owner.on_fire)
		to_chat(tyranid_owner, span_tyranidwarning("We can't use that while on fire."))
		return fail_activate()

	tyranid_owner.emote("roar")
	tyranid_owner.visible_message(span_warning("The skin on \the [tyranid_owner] shreds and a new layer can be seen in it's place!"),
		span_notice("We shed our skin, showing the fresh new layer underneath!"))

	tyranid_owner.do_jitter_animation(1000)
	tyranid_owner.set_sunder(0)
	tyranid_owner.heal_overall_damage(25, 25, updating_health = TRUE)
	add_cooldown()
	return succeed_activate()


// ***************************************
// *********** Centrifugal force
// ***************************************
/datum/action/ability/tyranid_action/centrifugal_force
	name = "Centrifugal force"
	action_icon_state = "centrifugal_force"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/defender.dmi'
	desc = "Rapidly spin and hit all adjacent humans around you, knocking them away and down. Uses double plasma when crest is active."
	ability_cost = 15
	use_state_flags = ABILITY_USE_CRESTED
	cooldown_duration = 30 SECONDS
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_CENTRIFUGAL_FORCE,
	)
	///bool whether we should take a random step this tick
	var/step_tick = FALSE
	///timer hash for the timer we use when spinning
	var/spin_loop_timer

/datum/action/ability/tyranid_action/centrifugal_force/can_use_action(silent, override_flags)
	if(spin_loop_timer)
		return TRUE
	. = ..()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	if(tyranid_owner.crest_defense && tyranid_owner.plasma_stored < (ability_cost * 2))
		to_chat(tyranid_owner, span_tyranidwarning("We don't have enough plasma, we need [(ability_cost * 2) - tyranid_owner.plasma_stored] more plasma!"))
		return FALSE

/datum/action/ability/tyranid_action/centrifugal_force/action_activate()
	if(spin_loop_timer)
		stop_spin()
		return
	if(!can_use_action(TRUE))
		return fail_activate()
	if(!do_after(owner, 0.5 SECONDS, NONE, owner, BUSY_ICON_DANGER, extra_checks = CALLBACK(src, PROC_REF(can_use_action), FALSE, ABILITY_USE_BUSY)))
		return fail_activate()
	owner.visible_message(span_tyranidwarning("\The [owner] starts swinging its tail in a circle!"), \
		span_tyranidwarning("We start swinging our tail in a wide circle!"))
	do_spin() //kick it off

	spin_loop_timer = addtimer(CALLBACK(src, PROC_REF(do_spin)), 5, TIMER_STOPPABLE)
	add_cooldown()
	RegisterSignals(owner, list(SIGNAL_ADDTRAIT(TRAIT_FLOORED), SIGNAL_ADDTRAIT(TRAIT_INCAPACITATED), SIGNAL_ADDTRAIT(TRAIT_IMMOBILE)), PROC_REF(stop_spin))

/// runs a spin, then starts the timer for a new spin if needed
/datum/action/ability/tyranid_action/centrifugal_force/proc/do_spin()
	spin_loop_timer = null
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	tyranid_owner.spin(4, 1)
	tyranid_owner.enable_throw_parry(0.6 SECONDS)
	playsound(tyranid_owner, pick('sound/effects/alien/tail_swipe1.ogg','sound/effects/alien/tail_swipe2.ogg','sound/effects/alien/tail_swipe3.ogg'), 25, 1) //Sound effects

	for(var/mob/living/carbon/human/slapped in orange(1, tyranid_owner))
		if(slapped.stat == DEAD)
			continue
		slapped.add_filter("defender_tail_sweep", 2, gauss_blur_filter(1)) //Add cool SFX; motion blur
		addtimer(CALLBACK(slapped, TYPE_PROC_REF(/datum, remove_filter), "defender_tail_sweep"), 0.5 SECONDS) //Remove cool SFX
		var/damage = tyranid_owner.tyranid_caste.melee_damage/2
		var/affecting = slapped.get_limb(ran_zone(null, 0))
		if(!affecting)
			affecting = slapped.get_limb("chest")
		slapped.knockback(tyranid_owner, 1, 4)
		slapped.apply_damage(damage, BRUTE, affecting, MELEE)
		slapped.apply_damage(damage, STAMINA, updating_health = TRUE)
		slapped.Paralyze(0.3 SECONDS)
		shake_camera(slapped, 2, 1)

		to_chat(slapped, span_tyranidwarning("We are struck by \the [tyranid_owner]'s flying tail!"))
		playsound(slapped, 'sound/weapons/alien_claw_block.ogg', 50, 1)

	succeed_activate(tyranid_owner.crest_defense ? ability_cost * 2 : ability_cost)
	if(step_tick)
		step(tyranid_owner, pick(GLOB.alldirs))
	step_tick = !step_tick

	if(can_use_action(tyranid_owner, ABILITY_IGNORE_COOLDOWN))
		spin_loop_timer = addtimer(CALLBACK(src, PROC_REF(do_spin)), 5, TIMER_STOPPABLE)
		return
	stop_spin()

/// stops spin and unregisters all listeners
/datum/action/ability/tyranid_action/centrifugal_force/proc/stop_spin()
	SIGNAL_HANDLER
	if(spin_loop_timer)
		deltimer(spin_loop_timer)
		spin_loop_timer = null
	UnregisterSignal(owner, list(SIGNAL_ADDTRAIT(TRAIT_FLOORED), SIGNAL_ADDTRAIT(TRAIT_INCAPACITATED), SIGNAL_ADDTRAIT(TRAIT_IMMOBILE)))
