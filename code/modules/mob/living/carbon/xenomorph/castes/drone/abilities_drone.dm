/datum/action/ability/activable/tyranid/corrosive_acid/drone
	name = "Corrosive Acid"
	ability_cost = 75
	acid_type = /obj/effect/tyranid/acid/weak

/datum/action/ability/activable/tyranid/transfer_plasma/drone
	plasma_transfer_amount = PLASMA_TRANSFER_AMOUNT * 2

/datum/action/ability/tyranid_action/create_jelly/slow
	cooldown_duration = 45 SECONDS

// ***************************************
// *********** Essence Link
// ***************************************
/datum/action/ability/activable/tyranid/essence_link
	name = "Essence Link"
	action_icon_state = "essence_link_0"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/drone.dmi'
	desc = "Link to a tyranid. This changes some of your abilities, and grants them and you both various bonuses."
	cooldown_duration = 5 SECONDS
	ability_cost = 0
	target_flags = ABILITY_MOB_TARGET
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_ESSENCE_LINK,
		KEYBINDING_ALTERNATE = COMSIG_TYRANIDABILITY_ESSENCE_LINK_REMOVE,
	)
	use_state_flags = ABILITY_USE_LYING

	/// Used to determine whether there is an existing Essence Link or not. Also allows access to its vars.
	var/datum/status_effect/stacking/essence_link/existing_link
	/// The target of an existing link, if applicable.
	var/mob/living/carbon/tyranid/linked_target
	/// Time it takes for the attunement levels to increase.
	var/attunement_cooldown = 60 SECONDS

/datum/action/ability/activable/tyranid/essence_link/can_use_ability(mob/living/carbon/tyranid/target, silent = FALSE, override_flags)
	var/mob/living/carbon/tyranid/X = owner
	if(!istyranid(target) || target.get_tyranid_hivenumber() != X.get_tyranid_hivenumber())
		return FALSE
	if(!X.Adjacent(target))
		X.balloon_alert(X, "Not adjacent")
		return FALSE
	if(target.tier == TYRANID_TIER_ZERO || target.tier == TYRANID_TIER_MINION)
		target.balloon_alert(X, "We cannot link to her.")
		return FALSE
	if(HAS_TRAIT(X, TRAIT_ESSENCE_LINKED))
		target.balloon_alert(X, "We are already linked")
		return FALSE
	if(HAS_TRAIT(target, TRAIT_ESSENCE_LINKED))
		target.balloon_alert(X, "She is already linked")
		return FALSE
	return ..()

/datum/action/ability/activable/tyranid/essence_link/use_ability(atom/target)
	var/mob/living/carbon/tyranid/X = owner
	if(!HAS_TRAIT(X, TRAIT_ESSENCE_LINKED))
		target.balloon_alert(X, "Linking...")
		if(!do_after(X, DRONE_ESSENCE_LINK_WINDUP, NONE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_FRIENDLY))
			X.balloon_alert(X, "Link cancelled")
			return
		X.apply_status_effect(STATUS_EFFECT_TYRANID_ESSENCE_LINK, 1, target)
		existing_link = X.has_status_effect(STATUS_EFFECT_TYRANID_ESSENCE_LINK)
		linked_target = target
		target.balloon_alert(target, "Essence Link established")
	succeed_activate()

/datum/action/ability/activable/tyranid/essence_link/alternate_action_activate()
	var/mob/living/carbon/tyranid/X = owner
	if(!HAS_TRAIT(X, TRAIT_ESSENCE_LINKED))
		X.balloon_alert(X, "No link to cancel")
		return
	end_ability()
	return COMSIG_KB_ACTIVATED

/// Ends the ability, removing signals and buffs.
/datum/action/ability/activable/tyranid/essence_link/proc/end_ability()
	var/mob/living/carbon/tyranid/X = owner
	var/datum/action/ability/tyranid_action/enhancement/enhancement_action = X.actions_by_path[/datum/action/ability/tyranid_action/enhancement]
	enhancement_action?.end_ability()
	X.remove_status_effect(STATUS_EFFECT_TYRANID_ESSENCE_LINK)
	existing_link = null
	linked_target = null
	add_cooldown()

/datum/action/ability/activable/tyranid/essence_link/update_button_icon()
	action_icon_state = "essence_link_[existing_link ? (existing_link.stacks) : (0)]"
	return ..()

// ***************************************
// *********** Acidic Salve
// ***************************************
/datum/action/ability/activable/tyranid/psychic_cure/acidic_salve
	name = "Acidic Salve"
	action_icon_state = "heal_tyranid"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/drone.dmi'
	desc = "Apply a minor heal to the target. If applied to a linked sister, it will also apply a regenerative buff. Additionally, if that linked sister is near death, the heal's potency is increased"
	cooldown_duration = 5 SECONDS
	ability_cost = 150
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_ACIDIC_SALVE,
	)
	heal_range = DRONE_HEAL_RANGE
	target_flags = ABILITY_MOB_TARGET

/datum/action/ability/activable/tyranid/psychic_cure/acidic_salve/use_ability(atom/target)
	var/mob/living/carbon/tyranid/X = owner
	if(X.do_actions)
		return FALSE
	if(!do_after(X, 1 SECONDS, NONE, target, BUSY_ICON_FRIENDLY, BUSY_ICON_MEDICAL))
		return FALSE
	X.visible_message(span_tyranidwarning("\the [X] vomits acid over [target], mending their wounds!"))
	owner.changeNext_move(CLICK_CD_RANGE)
	salve_healing(target)
	succeed_activate()
	add_cooldown()
	if(owner.client)
		var/datum/personal_statistics/personal_statistics = GLOB.personal_statistics_list[owner.ckey]
		personal_statistics.heals++

/// Heals the target and gives them a regenerative buff, if applicable.
/datum/action/ability/activable/tyranid/psychic_cure/acidic_salve/proc/salve_healing(mob/living/carbon/tyranid/target)
	var/datum/action/ability/activable/tyranid/essence_link/essence_link_action = owner.actions_by_path[/datum/action/ability/activable/tyranid/essence_link]
	var/heal_multiplier = 1
	if(essence_link_action.existing_link?.link_target == target)
		var/remaining_health = round(target.maxHealth - (target.getBruteLoss() + target.getFireLoss()))
		var/health_threshold = round(target.maxHealth / 10) // 10% of the target's maximum health
		target.apply_status_effect(STATUS_EFFECT_TYRANID_SALVE_REGEN)
		if(essence_link_action.existing_link.stacks > 0 && remaining_health <= health_threshold)
			heal_multiplier = 3
	playsound(target, SFX_ALIEN_DROOL, 25)
	new /obj/effect/temp_visual/telekinesis(get_turf(target))
	var/heal_amount = (DRONE_BASE_SALVE_HEAL + target.recovery_aura * target.maxHealth * 0.01) * heal_multiplier
	target.adjustFireLoss(-max(0, heal_amount - target.getBruteLoss()), TRUE)
	target.adjustBruteLoss(-heal_amount)
	target.adjust_sunder(-heal_amount/10)
	if(heal_multiplier > 1) // A signal depends on the above heals, so this has to be done here.
		playsound(target,'sound/effects/magic.ogg', 75, 1)
		essence_link_action.existing_link.add_stacks(-1)

// ***************************************
// *********** Enhancement
// ***************************************
/datum/action/ability/tyranid_action/enhancement
	name = "Enhancement"
	action_icon_state = "enhancement"
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/drone.dmi'
	desc = "Apply an enhancement to the linked tyranid, increasing their capabilities beyond their limits."
	cooldown_duration = 120 SECONDS
	ability_cost = 0
	keybinding_signals = list(
		KEYBINDING_NORMAL = COMSIG_TYRANIDABILITY_ENHANCEMENT,
	)
	/// References Essence Link and its vars.
	var/datum/action/ability/activable/tyranid/essence_link/essence_link_action //todo: All this link stuff is handled in a stinky way
	/// Used to determine whether Enhancement is already active or not. Also allows access to its vars.
	var/datum/status_effect/drone_enhancement/existing_enhancement
	/// Damage bonus given by this ability.
	var/damage_multiplier = 1.15
	/// Speed bonus given by this ability.
	var/speed_addition = -0.4

/datum/action/ability/tyranid_action/enhancement/New(Target)
	. = ..()
	INVOKE_NEXT_TICK(src, PROC_REF(link_essence_action))

/datum/action/ability/tyranid_action/enhancement/can_use_action()
	if(existing_enhancement)
		return TRUE
	if(!HAS_TRAIT(owner, TRAIT_ESSENCE_LINKED))
		return FALSE
	if(!essence_link_action.existing_link.was_within_range)
		return FALSE
	if(essence_link_action.existing_link.stacks < essence_link_action.existing_link.max_stacks)
		return FALSE
	return ..()

/datum/action/ability/tyranid_action/enhancement/action_activate()
	if(existing_enhancement)
		end_ability()
		return succeed_activate()
	essence_link_action.existing_link.add_stacks(-1)
	essence_link_action.linked_target.apply_status_effect(STATUS_EFFECT_TYRANID_ENHANCEMENT, owner)
	existing_enhancement = essence_link_action.linked_target.has_status_effect(STATUS_EFFECT_TYRANID_ENHANCEMENT)
	succeed_activate()

///Links this action to
/datum/action/ability/tyranid_action/enhancement/proc/link_essence_action()
	if(essence_link_action)
		return
	var/mob/living/carbon/tyranid/X = owner
	essence_link_action = X.actions_by_path[/datum/action/ability/activable/tyranid/essence_link]
	if(!essence_link_action)
		CRASH("[type] loaded with a drone_enhancement to link to")
	RegisterSignal(essence_link_action, COMSIG_QDELETING, PROC_REF(unlink_essence_action))

///Signal proc to delink essence_link. Should only happen when the owner is being deleted to begin with
/datum/action/ability/tyranid_action/enhancement/proc/unlink_essence_action()
	SIGNAL_HANDLER
	essence_link_action = null

/// Ends the ability if the Enhancement buff is removed.
/datum/action/ability/tyranid_action/enhancement/proc/end_ability()
	if(existing_enhancement)
		essence_link_action.linked_target.remove_status_effect(STATUS_EFFECT_TYRANID_ENHANCEMENT)
		existing_enhancement = null
		add_cooldown()
