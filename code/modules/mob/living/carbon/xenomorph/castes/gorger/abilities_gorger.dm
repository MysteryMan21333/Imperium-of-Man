/datum/action/ability/activable/tyranid/psydrain/free
	ability_cost = 0

/////////////////////////////////
// Devour
/////////////////////////////////
/datum/action/ability/activable/tyranid/devour
	name = "Devour"
	action_icon_state = "abduct"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Devour your victim to be able to carry it faster."
	use_state_flags = ABILITY_USE_STAGGERED|ABILITY_USE_FORTIFIED|ABILITY_USE_CRESTED //can't use while staggered, defender fortified or crest down
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_DEVOUR,
	)

/datum/action/ability/activable/tyranid/devour/can_use_ability(atom/target, silent, override_flags)
	. = ..()
	if(!.)
		return
	if(!ishuman(target) || issynth(target))
		if(!silent)
			to_chat(owner, span_warning("That wouldn't taste very good."))
		return FALSE
	var/mob/living/carbon/human/victim = target
	if(owner.do_actions) //can't use if busy
		return FALSE
	if(!owner.Adjacent(victim)) //checks if owner next to target
		return FALSE
	if(!HAS_TRAIT(victim, TRAIT_UNDEFIBBABLE))
		if(!silent)
			to_chat(owner, span_warning("This creature is struggling too much for us to devour it."))
		return FALSE
	if(victim.buckled)
		if(!silent)
			to_chat(owner, span_warning("[victim] is buckled to something."))
		return FALSE
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(owner_tyranid.eaten_mob)
		if(!silent)
			to_chat(owner_tyranid, span_warning("You have already swallowed one."))
		return FALSE
	if(owner_tyranid.on_fire)
		if(!silent)
			to_chat(owner_tyranid, span_warning("We're too busy being on fire to do this!"))
		return FALSE
	for(var/obj/effect/forcefield/fog in range(1, owner_tyranid))
		if(!silent)
			to_chat(owner_tyranid, span_warning("We are too close to the fog."))
		return FALSE

/datum/action/ability/activable/tyranid/devour/action_activate()
	. = ..()
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(!owner_tyranid.eaten_mob)
		return

	var/channel = SSsounds.random_available_channel()
	playsound(owner_tyranid, 'sound/vore/escape.ogg', 40, channel = channel)
	if(!do_after(owner_tyranid, GORGER_REGURGITATE_DELAY, IGNORE_HELD_ITEM, null, BUSY_ICON_DANGER))
		to_chat(owner, span_warning("We moved too soon!"))
		owner_tyranid.stop_sound_channel(channel)
		return
	owner_tyranid.eject_victim()

/datum/action/ability/activable/tyranid/devour/use_ability(atom/target)
	var/mob/living/carbon/human/victim = target
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	owner_tyranid.face_atom(victim)
	owner_tyranid.visible_message(span_danger("[owner_tyranid] starts to devour [victim]!"), span_danger("We start to devour [victim]!"), null, 5)
	var/channel = SSsounds.random_available_channel()
	playsound(owner_tyranid, 'sound/vore/struggle.ogg', 40, channel = channel)
	if(!do_after(owner_tyranid, GORGER_DEVOUR_DELAY, IGNORE_HELD_ITEM, victim, BUSY_ICON_DANGER, extra_checks = CALLBACK(owner, TYPE_PROC_REF(/mob, break_do_after_checks), list("health" = owner_tyranid.health))))
		to_chat(owner, span_warning("We stop devouring \the [victim]. They probably tasted gross anyways."))
		owner_tyranid.stop_sound_channel(channel)
		return
	owner.visible_message(span_warning("[owner_tyranid] devours [victim]!"), span_warning("We devour [victim]!"), null, 5)
	victim.forceMove(owner_tyranid)
	owner_tyranid.eaten_mob = victim
	add_cooldown()

/datum/action/ability/activable/tyranid/devour/ai_should_use(atom/target)
	return FALSE

// ***************************************
// *********** Drain blood
// ***************************************
/datum/action/ability/activable/tyranid/drain
	name = "Drain"
	action_icon_state = "drain"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Hold a guardsman for some time and drain their blood, while healing. You can't attack during this time and can be shot by the guardsman. When used on a dead human, you heal, or gain overheal, gradually and don't gain blood."
	use_state_flags = ABILITY_KEYBIND_USE_ABILITY
	cooldown_duration = 15 SECONDS
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_DRAIN,
	)

/datum/action/ability/activable/tyranid/drain/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!ishuman(target) || issynth(target))
		if(!silent)
			to_chat(owner, span_tyranidwarning("We can't drain this!"))
		return FALSE

	var/mob/living/carbon/tyranid/owner_tyranid = owner
	var/mob/living/carbon/human/target_human = target
	if(!owner_tyranid.Adjacent(target_human))
		if(!silent)
			to_chat(owner_tyranid, span_notice("We need to be next to our meal."))
		return FALSE

	if(target_human.stat == DEAD)
		if(owner_tyranid.do_actions)
			return FALSE
		return TRUE

	if(!.)
		return

	if(owner_tyranid.plasma_stored >= owner_tyranid.tyranid_caste.plasma_max)
		if(!silent)
			to_chat(owner_tyranid, span_tyranidwarning("No need, we feel sated for now..."))
		return FALSE

#define DO_DRAIN_ACTION(owner_tyranid, target_human) \
	owner_tyranid.do_attack_animation(target_human, ATTACK_EFFECT_REDSTAB);\
	owner_tyranid.visible_message(target_human, span_danger("[owner_tyranid] stabs its tail into [target_human]!"));\
	playsound(target_human, SFX_ALIEN_CLAW_FLESH, 25, TRUE);\
	target_human.emote("scream");\
	target_human.apply_damage(damage = 4, damagetype = BRUTE, def_zone = BODY_ZONE_HEAD, blocked = 0, sharp = TRUE, edge = FALSE, updating_health = TRUE);\
\
	var/drain_healing = GORGER_DRAIN_HEAL;\
	HEAL_TYRANID_DAMAGE(owner_tyranid, drain_healing, TRUE);\
	adjustOverheal(owner_tyranid, drain_healing);\
	owner_tyranid.gain_plasma(owner_tyranid.tyranid_caste.drain_plasma_gain)

/datum/action/ability/activable/tyranid/drain/use_ability(mob/living/carbon/human/target_human)
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(target_human.stat == DEAD)
		var/overheal_gain = 0
		while((owner_tyranid.health < owner_tyranid.maxHealth || owner_tyranid.overheal < owner_tyranid.tyranid_caste.overheal_max) &&do_after(owner_tyranid, 2 SECONDS, NONE, target_human, BUSY_ICON_HOSTILE))
			overheal_gain = owner_tyranid.heal_wounds(2.2)
			adjustOverheal(owner_tyranid, overheal_gain)
			owner_tyranid.adjust_sunder(-2.5)
		to_chat(owner_tyranid, span_notice("We feel fully restored."))
		return
	owner_tyranid.face_atom(target_human)
	owner_tyranid.emote("roar")
	owner_tyranid.AdjustImmobilized(0.5 SECONDS)
	ADD_TRAIT(owner_tyranid, TRAIT_HANDS_BLOCKED, src)
	for(var/i = 0; i < GORGER_DRAIN_INSTANCES; i++)
		target_human.Immobilize(GORGER_DRAIN_DELAY)
		if(!do_after(owner_tyranid, GORGER_DRAIN_DELAY, IGNORE_HELD_ITEM, target_human))
			break
		DO_DRAIN_ACTION(owner_tyranid, target_human)

	REMOVE_TRAIT(owner_tyranid, TRAIT_HANDS_BLOCKED, src)
	target_human.blur_eyes(1)
	add_cooldown()

#undef DO_DRAIN_ACTION

/datum/action/ability/activable/tyranid/drain/ai_should_use(atom/target)
	return can_use_ability(target, TRUE)

// ***************************************
// *********** Transfusion
// ***************************************

/obj/effect/ebeam/transfusion
	name = "blood transfusion beam"

/datum/action/ability/activable/tyranid/transfusion
	name = "Transfusion"
	action_icon_state = "transfusion"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Restores some of the health of another tyranid, or overheals, at the cost of blood."
	//When used on self, drains blood continuosly, slows you down and reduces damage taken, while restoring health over time.
	cooldown_duration = 2 SECONDS
	ability_cost = 20
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TRANSFUSION,
	)

	///Used to keep track of the target's previous health for extra_health_check()
	var/target_health

/datum/action/ability/activable/tyranid/transfusion/can_use_ability(atom/target, silent = FALSE, override_flags) //it is set up to only return true on specific tyranid or human targets
	. = ..()
	if(!.)
		return

	if(!istyranid(target))
		if(!silent)
			to_chat(owner, span_notice("We can only restore familiar biological lifeforms."))
		return FALSE

	var/mob/living/carbon/tyranid/target_tyranid = target

	if(owner.do_actions)
		return FALSE
	if(!line_of_sight(owner, target_tyranid, 2) || get_dist(owner, target_tyranid) > 2)
		if(!silent)
			to_chat(owner, span_notice("It is beyond our reach, we must be close and our way must be clear."))
		return FALSE
	if(target_tyranid.stat == DEAD)
		if(!silent)
			to_chat(owner, span_notice("We can only help living sisters."))
		return FALSE
	target_health = target_tyranid.health
	var/datum/beam/transfuse_beam = owner.beam(target_tyranid, icon_state= "lichbeam", beam_type = /obj/effect/ebeam/essence_link)
	transfuse_beam.visuals.alpha = 127
	if(!do_after(owner, 1 SECONDS, IGNORE_TARGET_LOC_CHANGE, target_tyranid, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL, extra_checks = CALLBACK(src, PROC_REF(extra_health_check), target_tyranid)))
		QDEL_NULL(transfuse_beam)
		return FALSE
	QDEL_NULL(transfuse_beam)
	return TRUE

///An extra check for the do_mob in can_use_ability. If the target isn't immobile and has lost health, the ability is cancelled. The ability is also cancelled if the target is knocked into crit DURING the do_mob.
/datum/action/ability/activable/tyranid/transfusion/proc/extra_health_check(mob/living/target)
	if((target.health < target_health && !HAS_TRAIT(target, TRAIT_IMMOBILE)) || (target.InCritical() && target_health > target.get_crit_threshold()))
		return FALSE
	target_health = target.health
	return TRUE

/datum/action/ability/activable/tyranid/transfusion/use_ability(atom/target)
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	var/mob/living/carbon/tyranid/target_tyranid = target
	var/heal_amount = target_tyranid.maxHealth * GORGER_TRANSFUSION_HEAL
	HEAL_TYRANID_DAMAGE(target_tyranid, heal_amount, FALSE)
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++
	adjustOverheal(target_tyranid, heal_amount)
	new /obj/effect/temp_visual/healing(get_turf(target_tyranid))
	if(target_tyranid.overheal)
		target_tyranid.balloon_alert(owner_tyranid, "Overheal: [target_tyranid.overheal]/[target_tyranid.tyranid_caste.overheal_max]")
	add_cooldown()
	succeed_activate()

/datum/action/ability/activable/tyranid/transfusion/ai_should_use(atom/target)
	// no healing non-tyranid
	if(!istyranid(target))
		return FALSE
	var/mob/living/carbon/tyranid/target_tyranid = target
	if(target_tyranid.get_tyranid_hivenumber() != owner.get_tyranid_hivenumber())
		return FALSE
	// no overhealing
	if(target_tyranid.health > target_tyranid.maxHealth * (1 - GORGER_TRANSFUSION_HEAL))
		return FALSE
	return can_use_ability(target, TRUE)

// ***************************************
// *********** oppose
// ***************************************

/particles/bulwark_aoe/oppose_aoe
	color = LIGHT_COLOR_BLOOD_MAGIC
	fade = 3 SECONDS

/datum/action/ability/activable/tyranid/oppose
	name = "Oppose"
	action_icon_state = "rejuvenation"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Violently suffuse the ground with stored blood. A guardsman on your tile is staggered and injured, ajacent guardsmans are staggered, and any nearby tyranids are healed, including you."
	cooldown_duration = 30 SECONDS
	ability_cost = GORGER_OPPOSE_COST
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_OPPOSE,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY

/datum/action/ability/activable/tyranid/oppose/use_ability(atom/A)
	. = ..()
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	add_cooldown()
	succeed_activate()

	playsound(owner_tyranid.loc, 'sound/effects/bang.ogg', 25, 0)
	owner_tyranid.visible_message(span_tyraniddanger("[owner_tyranid] smashes her fists into the ground!"), \
	span_tyraniddanger("We smash our fists into the ground!"))

	owner_tyranid.create_stomp() //Adds the visual effects. Wom wom wom
	new /obj/effect/temp_visual/oppose_shatter(get_turf(owner_tyranid)) //shatter displays stagger range

	var/obj/effect/abstract/particle_holder/aoe_particles = new(owner.loc, /particles/bulwark_aoe/oppose_aoe) //particles display heal range
	aoe_particles.particles.position = generator(GEN_SQUARE, 0, 16 + 3*32, LINEAR_RAND)
	addtimer(CALLBACK(src, PROC_REF(stop_particles), aoe_particles), 0.5 SECONDS)

	var/list/oppose_range = range(3)
	for(var/mob/living/M in oppose_range)
		if(M.stat == DEAD)
			continue
		var/distance = get_dist(M, owner_tyranid)
		if(owner_tyranid.issametyranidhive(M))  //Tyranids in range will be healed and overhealed, including you.
			var/mob/living/carbon/tyranid/target_tyranid = M
			var/heal_amount = M.maxHealth * GORGER_OPPOSE_HEAL
			HEAL_TYRANID_DAMAGE(target_tyranid, heal_amount, FALSE)
			adjustOverheal(target_tyranid, heal_amount)
			new /obj/effect/temp_visual/healing(get_turf(target_tyranid))
			if(owner.client)
				var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
				personal_statistics.heals++
		else if(distance == 0) //if we're right on top of them, they take actual damage
			M.take_overall_damage(20, BRUTE, MELEE, updating_health = TRUE, max_limbs = 3)
			to_chat(M, span_highdanger("[owner_tyranid] slams her fists into you, crushing you to the ground!"))
			M.adjust_stagger(2 SECONDS)
			M.adjust_slowdown(3)
			shake_camera(M, 3, 3)
		else if(distance <= 1) //guardsmans will only be staggerslowed if they're one tile away from you
			shake_camera(M, 2, 2)
			to_chat(M, span_highdanger("Blood shatters the ground around you!"))
			M.adjust_stagger(2 SECONDS)
			M.adjust_slowdown(3)

///Stops particle spawning, then gives existing particles time to fade out before deleting them.
/datum/action/ability/activable/tyranid/oppose/proc/stop_particles(obj/effect/abstract/particle_holder/aoe_particles)
	aoe_particles.particles.spawning = 0
	QDEL_IN(aoe_particles, 3 SECONDS)

/datum/action/ability/activable/tyranid/oppose/ai_should_use(atom/target)
	return FALSE

// ***************************************
// *********** Psychic Link
// ***************************************
/datum/action/ability/activable/tyranid/psychic_link
	name = "Psychic Link"
	action_icon_state = "psychic_link"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Link to a tyranid and take some damage in their place. Unrest to cancel."
	cooldown_duration = 50 SECONDS
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_PSYCHIC_LINK,
	)
	///Timer for activating the link
	var/apply_psychic_link_timer
	///Overlay applied on the target tyranid while linking
	var/datum/progressicon/target_overlay

/datum/action/ability/activable/tyranid/psychic_link/can_use_ability(atom/target, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return
	if(apply_psychic_link_timer)
		if(!silent)
			owner.balloon_alert(owner, "cancelled")
		link_cleanup()
		return FALSE
	if(owner.do_actions)
		return FALSE
	if(!istyranid(target))
		if(!silent)
			to_chat(owner, span_notice("We can only link to familiar biological lifeforms."))
		return FALSE
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(owner_tyranid.health <= owner_tyranid.maxHealth * GORGER_PSYCHIC_LINK_MIN_HEALTH)
		if(!silent)
			to_chat(owner, span_notice("You are too hurt to link."))
		return FALSE
	if(!line_of_sight(owner, target, GORGER_PSYCHIC_LINK_RANGE))
		if(!silent)
			to_chat(owner, span_notice("It is beyond our reach, we must be close and our way must be clear."))
		return FALSE
	if(HAS_TRAIT(owner, TRAIT_PSY_LINKED))
		if(!silent)
			to_chat(owner, span_notice("You are already linked to a tyranid."))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_PSY_LINKED))
		if(!silent)
			to_chat(owner, span_notice("[target] is already linked to a tyranid."))
		return FALSE
	return TRUE

/datum/action/ability/activable/tyranid/psychic_link/use_ability(atom/target)
	apply_psychic_link_timer = addtimer(CALLBACK(src, PROC_REF(apply_psychic_link), target), GORGER_PSYCHIC_LINK_CHANNEL, TIMER_UNIQUE|TIMER_STOPPABLE)
	target_overlay = new (target, BUSY_ICON_MEDICAL)
	owner.balloon_alert(owner, "linking...")

///Activates the link
/datum/action/ability/activable/tyranid/psychic_link/proc/apply_psychic_link(atom/target)
	link_cleanup()
	if(HAS_TRAIT(owner, TRAIT_PSY_LINKED) || HAS_TRAIT(target, TRAIT_PSY_LINKED))
		return fail_activate()

	var/mob/living/carbon/tyranid/owner_tyranid = owner
	var/psychic_link = owner_tyranid.apply_status_effect(STATUS_EFFECT_TYRANID_PSYCHIC_LINK, -1, target, GORGER_PSYCHIC_LINK_RANGE, GORGER_PSYCHIC_LINK_REDIRECT, owner_tyranid.maxHealth * GORGER_PSYCHIC_LINK_MIN_HEALTH, TRUE)
	RegisterSignal(psychic_link, COMSIG_TYRANID_PSYCHIC_LINK_REMOVED, PROC_REF(status_removed))
	target.balloon_alert(owner_tyranid, "link successul")
	owner_tyranid.balloon_alert(target, "linked to [owner_tyranid]")
	if(!owner_tyranid.resting)
		owner_tyranid.set_resting(TRUE, TRUE)
	RegisterSignal(owner_tyranid, COMSIG_TYRANID_UNREST, PROC_REF(cancel_psychic_link))
	succeed_activate()

///Removes the status effect on unrest
/datum/action/ability/activable/tyranid/psychic_link/proc/cancel_psychic_link(datum/source)
	SIGNAL_HANDLER
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	owner_tyranid.remove_status_effect(STATUS_EFFECT_TYRANID_PSYCHIC_LINK)

///Cancels the status effect
/datum/action/ability/activable/tyranid/psychic_link/proc/status_removed(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_TYRANID_PSYCHIC_LINK_REMOVED)
	UnregisterSignal(owner, COMSIG_TYRANID_UNREST)
	add_cooldown()

///Clears up things used for the linking
/datum/action/ability/activable/tyranid/psychic_link/proc/link_cleanup()
	QDEL_NULL(target_overlay)
	deltimer(apply_psychic_link_timer)
	apply_psychic_link_timer = null


/datum/action/ability/activable/tyranid/psychic_link/ai_should_use(atom/target)
	return FALSE

// ***************************************
// *********** Carnage
// ***************************************
/datum/action/ability/activable/tyranid/carnage
	name = "Carnage"
	action_icon_state = "carnage"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Enter a state of thirst, gaining movement and healing on your next attack, scaling with missing blood. If your blood is below a certain %, you also knockdown your victim and drain some blood, during which you can't move."
	cooldown_duration = 15 SECONDS
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_CARNAGE,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY

/datum/action/ability/activable/tyranid/carnage/use_ability(atom/A)
	. = ..()
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	owner_tyranid.apply_status_effect(STATUS_EFFECT_TYRANID_CARNAGE, 10 SECONDS, owner_tyranid.tyranid_caste.carnage_plasma_gain, owner_tyranid.maxHealth * GORGER_CARNAGE_HEAL, GORGER_CARNAGE_MOVEMENT)
	add_cooldown()

/datum/action/ability/activable/tyranid/carnage/ai_should_use(atom/target)
	if(!iscarbon(target))
		return FALSE
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(owner_tyranid.plasma_stored > owner_tyranid.tyranid_caste.plasma_max * 0.8 && owner_tyranid.health > owner_tyranid.maxHealth * 0.9)
		return FALSE
	// nothing gained by slashing allies
	if(target.get_tyranid_hivenumber() == owner_tyranid.get_tyranid_hivenumber())
		return FALSE
	return can_use_ability(target, TRUE)

// ***************************************
// *********** Feast
// ***************************************
#define FEAST_MISCLICK_CD "feast_misclick"
/datum/action/ability/activable/tyranid/feast
	name = "Feast"
	action_icon_state = "feast"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/gorger.dmi'
	desc = "Enter a state of rejuvenation. During this time you use a small amount of blood and heal. You can cancel this early."
	cooldown_duration = 180 SECONDS
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_FEAST,
	)
	keybind_flags = ABILITY_KEYBIND_USE_ABILITY
	use_state_flags = ABILITY_USE_STAGGERED

/datum/action/ability/activable/tyranid/feast/can_use_ability(atom/target, silent, override_flags)
	. = ..()
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(TIMER_COOLDOWN_CHECK(owner_tyranid, FEAST_MISCLICK_CD))
		return FALSE
	if(owner_tyranid.has_status_effect(STATUS_EFFECT_TYRANID_FEAST))
		return TRUE
	if(owner_tyranid.plasma_stored < owner_tyranid.tyranid_caste.feast_plasma_drain * 10)
		if(!silent)
			to_chat(owner_tyranid, span_notice("Not enough to begin a feast. We need [owner_tyranid.tyranid_caste.feast_plasma_drain * 10] blood."))
		return FALSE

/datum/action/ability/activable/tyranid/feast/use_ability(atom/A)
	. = ..()
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	if(owner_tyranid.has_status_effect(STATUS_EFFECT_TYRANID_FEAST))
		to_chat(owner_tyranid, span_notice("We decide to end our feast early..."))
		owner_tyranid.remove_status_effect(STATUS_EFFECT_TYRANID_FEAST)
		return

	owner_tyranid.emote("roar")
	owner_tyranid.visible_message(owner_tyranid, span_notice("[owner_tyranid] begins to overflow with vitality!"))
	owner_tyranid.apply_status_effect(STATUS_EFFECT_TYRANID_FEAST, GORGER_FEAST_DURATION, owner_tyranid.tyranid_caste.feast_plasma_drain)
	TIMER_COOLDOWN_START(src, FEAST_MISCLICK_CD, 2 SECONDS)
	add_cooldown()

/datum/action/ability/activable/tyranid/feast/ai_should_use(atom/target)
	var/mob/living/carbon/tyranid/owner_tyranid = owner
	// cancel the buff when at full health to conserve plasma, otherwise don't cancel
	if(owner_tyranid.has_status_effect(STATUS_EFFECT_TYRANID_FEAST))
		return owner_tyranid.health == owner_tyranid.maxHealth
	// small damage has more efficient alternatives to be healed with
	if(owner_tyranid.health > owner_tyranid.maxHealth * 0.7)
		return FALSE
	// should use the ability when there is enough resource for the buff to tick a moderate amount of times
	if(owner_tyranid.plasma_stored / owner_tyranid.tyranid_caste.feast_plasma_drain < 7)
		return FALSE
	return can_use_ability(target, TRUE)

#undef FEAST_MISCLICK_CD
