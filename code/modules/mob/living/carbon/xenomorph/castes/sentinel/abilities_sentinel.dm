// ***************************************
// *********** Toxic Spit
// ***************************************
/datum/action/ability/activable/tyranid/tyranid_spit/toxic_spit
	name = "Toxic Spit"
	desc = "Spit a toxin at your target up to 7 tiles away, inflicting the Intoxicated debuff and dealing damage over time."
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TOXIC_SPIT,
	)

/datum/ammo/tyranid/acid/toxic_spit
	name = "toxic spit"
	icon_state = "tyranid_toxic"
	bullet_color = COLOR_PALE_GREEN_GRAY
	damage = 16
	spit_cost = 30
	ammo_behavior_flags = AMMO_TYRANID|AMMO_SKIPS_ALIENS
	/// The amount of stacks applied on hit.
	var/intoxication_stacks = 5

/datum/ammo/tyranid/acid/toxic_spit/on_hit_mob(mob/target_mob, obj/projectile/proj)
	if(!iscarbon(target_mob))
		return
	var/mob/living/carbon/target_carbon = target_mob
	if(target_carbon.issametyranidhive(proj.firer))
		return
	if(HAS_TRAIT(target_carbon, TRAIT_INTOXICATION_IMMUNE))
		return
	if(target_carbon.has_status_effect(STATUS_EFFECT_INTOXICATED))
		var/datum/status_effect/stacking/intoxicated/debuff = target_carbon.has_status_effect(STATUS_EFFECT_INTOXICATED)
		debuff.add_stacks(intoxication_stacks)
	target_carbon.apply_status_effect(STATUS_EFFECT_INTOXICATED, intoxication_stacks)

// ***************************************
// *********** Toxic Slash
// ***************************************
/datum/action/ability/tyranid_action/toxic_slash
	name = "Toxic Slash"
	action_icon_state = "neuroclaws_off"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/sentinel.dmi'
	desc = "Imbue your claws with acid for a short duration, inflicting lasting effects on your victims."
	cooldown_duration = 10 SECONDS
	ability_cost = 100
	//use_state_flags = ABILITY_USE_BUCKLED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TOXIC_SLASH,
	)
	/// The amount of stacks to apply per hit.
	var/intoxication_stacks = 0
	/// The remaining amount of Toxic Slashes.
	var/remaining_slashes = 0
	/// Timer for the ability; we reference this to delete the timer if the effect lapses before the timer does.
	var/ability_duration
	/// Used for particles. Holds the particles instead of the mob. See particle_holder for documentation.
	var/obj/effect/abstract/particle_holder/particle_holder

/datum/action/ability/tyranid_action/toxic_slash/action_activate()
	. = ..()
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	intoxication_stacks = SENTINEL_TOXIC_SLASH_STACKS_PER + tyranid_owner.tyranid_caste.additional_stacks
	remaining_slashes = SENTINEL_TOXIC_SLASH_COUNT
	ability_duration = addtimer(CALLBACK(src, PROC_REF(toxic_slash_deactivate), tyranid_owner), SENTINEL_TOXIC_SLASH_DURATION, TIMER_STOPPABLE) //Initiate the timer and set the timer ID for reference
	RegisterSignal(tyranid_owner, COMSIG_TYRANID_ATTACK_LIVING, PROC_REF(toxic_slash))
	tyranid_owner.balloon_alert(tyranid_owner, "Toxic Slash active")
	tyranid_owner.playsound_local(tyranid_owner, 'sound/voice/alien/drool2.ogg', 25)
	action_icon_state = "neuroclaws_on"
	particle_holder = new(owner, /particles/toxic_slash)
	particle_holder.pixel_x = 9
	particle_holder.pixel_y = 2
	succeed_activate()
	add_cooldown()

///Called when Toxic Slash is active.
/datum/action/ability/tyranid_action/toxic_slash/proc/toxic_slash(datum/source, mob/living/target, damage, list/damage_mod, list/armor_mod)
	SIGNAL_HANDLER
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	var/mob/living/carbon/tyranid_target = target
	if(HAS_TRAIT(tyranid_target, TRAIT_INTOXICATION_IMMUNE))
		tyranid_target.balloon_alert(tyranid_owner, "Immune to Intoxication")
		return
	playsound(tyranid_target, 'sound/effects/spray3.ogg', 20, TRUE)
	if(tyranid_target.has_status_effect(STATUS_EFFECT_INTOXICATED))
		var/datum/status_effect/stacking/intoxicated/debuff = tyranid_target.has_status_effect(STATUS_EFFECT_INTOXICATED)
		debuff.add_stacks(intoxication_stacks)
	tyranid_target.apply_status_effect(STATUS_EFFECT_INTOXICATED, intoxication_stacks)
	remaining_slashes-- //Decrement the toxic slash count
	if(!remaining_slashes) //Deactivate if we have no toxic slashes remaining
		toxic_slash_deactivate(tyranid_owner)

///Called when Toxic Slash expires.
/datum/action/ability/tyranid_action/toxic_slash/proc/toxic_slash_deactivate(mob/living/carbon/tyranid/tyranid_owner)
	UnregisterSignal(tyranid_owner, COMSIG_TYRANID_ATTACK_LIVING)
	remaining_slashes = 0
	deltimer(ability_duration) // Delete the timer so we don't have mismatch issues, and so we don't potentially try to deactivate the ability twice
	ability_duration = null
	QDEL_NULL(particle_holder)
	tyranid_owner.balloon_alert(tyranid_owner, "Toxic Slash over") //Let the user know
	tyranid_owner.playsound_local(tyranid_owner, 'sound/voice/hiss5.ogg', 25)
	action_icon_state = "neuroclaws_off"

/datum/action/ability/tyranid_action/toxic_slash/on_cooldown_finish()
	owner.playsound_local(owner, 'sound/effects/alien/new_larva.ogg', 25, 0, 1)
	owner.balloon_alert(owner, "Toxic Slash ready")
	return ..()

/particles/toxic_slash
	icon = 'icons/effects/particles/generic_particles.dmi'
	icon_state = "x"
	width = 100
	height = 100
	count = 1000
	spawning = 4
	lifespan = 9
	fade = 10
	grow = 0.2
	velocity = list(0, 0)
	position = generator(GEN_CIRCLE, 10, 10, NORMAL_RAND)
	drift = generator(GEN_VECTOR, list(0, -0.15), list(0, 0.15))
	gravity = list(0, 0.4)
	scale = generator(GEN_VECTOR, list(0.3, 0.3), list(0.9,0.9), NORMAL_RAND)
	rotation = 0
	spin = generator(GEN_NUM, 10, 20)
	color = "#7DCC00"

// ***************************************
// *********** Drain Sting
// ***************************************
/datum/action/ability/activable/tyranid/drain_sting
	name = "Drain Sting"
	action_icon_state = "neuro_sting"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/sentinel.dmi'
	desc = "Sting your victim, draining them and gaining benefits if they are Intoxicated."
	cooldown_duration = 25 SECONDS
	ability_cost = 75
	target_flags = ABILITY_MOB_TARGET
	use_state_flags = ABILITY_USE_BUCKLED
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_DRAIN_STING,
	)

/datum/action/ability/activable/tyranid/drain_sting/can_use_ability(atom/A, silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return FALSE
	if(!istype(A, /mob/living/carbon/human))
		if(!silent)
			A.balloon_alert(owner, "Cannot sting")
		return FALSE
	var/mob/living/carbon/target = A
	if(!owner.Adjacent(target))
		target.balloon_alert(owner, "Cannot reach")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_INTOXICATION_IMMUNE))
		target.balloon_alert(owner, "Immune to intoxication")
		return FALSE
	if(!target.has_status_effect(STATUS_EFFECT_INTOXICATED))
		target.balloon_alert(owner, "Not intoxicated")
		return FALSE

/datum/action/ability/activable/tyranid/drain_sting/use_ability(atom/A)
	var/mob/living/carbon/tyranid/tyranid_owner = owner
	var/mob/living/carbon/tyranid_target = A
	var/datum/status_effect/stacking/intoxicated/debuff = tyranid_target.has_status_effect(STATUS_EFFECT_INTOXICATED)
	var/drain_potency = debuff.stacks * SENTINEL_DRAIN_MULTIPLIER
	if(debuff.stacks > debuff.max_stacks - 10)
		tyranid_target.emote("scream")
		tyranid_owner.apply_status_effect(STATUS_EFFECT_DRAIN_SURGE)
		new /obj/effect/temp_visual/drain_sting_crit(get_turf(tyranid_target))
	tyranid_target.adjustFireLoss(drain_potency / 5)
	tyranid_target.AdjustKnockdown(max(0.1 SECONDS, debuff.stacks - 10))
	HEAL_TYRANID_DAMAGE(tyranid_owner, drain_potency, FALSE)
	tyranid_owner.gain_plasma(drain_potency * 3.5)
	tyranid_owner.do_attack_animation(tyranid_target, ATTACK_EFFECT_DRAIN_STING)
	playsound(owner.loc, 'sound/effects/alien/tail_swipe1.ogg', 30)
	tyranid_owner.visible_message(message = span_tyranidwarning("\A [tyranid_owner] stings [tyranid_target]!"), self_message = span_tyranidwarning("We sting [tyranid_target]!"))
	debuff.stacks -= round(debuff.stacks * 0.7)
	succeed_activate()
	add_cooldown()
	GLOB.round_statistics.sentinel_drain_stings++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "sentinel_drain_stings")

/datum/action/ability/activable/tyranid/drain_sting/on_cooldown_finish()
	playsound(owner.loc, 'sound/voice/alien/drool1.ogg', 50, 1)
	owner.balloon_alert(owner, "Drain Sting ready")
	return ..()

/obj/effect/temp_visual/drain_sting_crit
	name = "drain_sting"
	icon = 'icons/effects/64x64.dmi'
	icon_state = "drain_sting_crit"
	duration = 3.5
	pixel_x = -18
	pixel_y = -18

// ***************************************
// *********** Toxic Grenade
// ***************************************
/datum/action/ability/activable/tyranid/toxic_grenade
	name = "Toxic grenade"
	action_icon_state = "gas mine"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/sentinel.dmi'
	desc = "Throws a lump of compressed acidic gases, which will inflict damage over time and Intoxicate victims."
	ability_cost = 200
	cooldown_duration = 50 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TOXIC_GRENADE,
	)
	///Type of nade to be thrown
	var/nade_type = /obj/item/explosive/grenade/smokebomb/tyranid

/datum/action/ability/activable/tyranid/toxic_grenade/use_ability(atom/A)
	. = ..()
	succeed_activate()
	add_cooldown()
	var/obj/item/explosive/grenade/smokebomb/tyranid/nade = new nade_type(get_turf(owner))
	nade.throw_at(A, 5, 1, owner, TRUE)
	nade.activate(owner)
	owner.visible_message(span_warning("[owner] vomits up a bulbous lump and throws it at [A]!"), span_warning("We vomit up a bulbous lump and throw it at [A]!"))

/obj/item/explosive/grenade/smokebomb/tyranid
	name = "toxic grenade"
	desc = "A fleshy mass that bounces along the ground. It seems to be heating up."
	greyscale_colors = "#42A500"
	greyscale_config = /datum/greyscale_config/tyranidgrenade
	det_time = 15
	smoke_duration = 4
	dangerous = TRUE
	smoketype = /datum/effect_system/smoke_spread/tyranid/toxic
	arm_sound = 'sound/voice/alien/yell_alt.ogg'
	smokeradius = 3

/obj/item/explosive/grenade/smokebomb/tyranid/update_overlays()
	. = ..()
	if(active)
		. += image('modular_imperium/master_files/icons/obj/items/grenade.dmi', "tyranidnade_active")

//Neuro variant
/datum/action/ability/activable/tyranid/toxic_grenade/neuro
	name = "Neuro grenade"
	action_icon_state = "gas mine"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/sentinel.dmi'
	desc = "Throws a lump of compressed neurotoxin, which explodes into a small gas cloud."
	ability_cost = 200
	cooldown_duration = 50 SECONDS
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_TOXIC_GRENADE,
	)
	nade_type = /obj/item/explosive/grenade/smokebomb/tyranid/neuro

/obj/item/explosive/grenade/smokebomb/tyranid/neuro
	name = "Neuro grenade"
	desc = "A fleshy mass that bounces along the ground. It seems to be heating up."
	greyscale_colors = "#bfc208"
	greyscale_config = /datum/greyscale_config/tyranidgrenade
	det_time = 15
	smoke_duration = 4
	dangerous = TRUE
	smoketype = /datum/effect_system/smoke_spread/tyranid/neuro/light
	arm_sound = 'sound/voice/alien/yell_alt.ogg'
	smokeradius = 3
