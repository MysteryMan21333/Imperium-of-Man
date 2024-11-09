
/datum/action/ability/tyranid_action
	///If you are going to add an explanation for an ability. don't use stats, give a very brief explanation of how to use it.
	desc = "This ability can not be found in codex."
	action_icon = 'modular_imperium/master_files/icons/tyranid/actions/general.dmi'

/datum/action/ability/tyranid_action/New(Target)
	. = ..()
	var/mutable_appearance/empowered_appearence = mutable_appearance('modular_imperium/master_files/icons/tyranid/actions/general.dmi', "borders_center", ACTION_LAYER_EMPOWERED, FLOAT_PLANE)
	visual_references[VREF_MUTABLE_EMPOWERED_FRAME] = empowered_appearence

/datum/action/ability/tyranid_action/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_TYRANID_ABILITY_ON_UPGRADE, TYPE_PROC_REF(/datum/action/ability, on_tyranid_upgrade))

/datum/action/ability/tyranid_action/remove_action(mob/living/L)
	UnregisterSignal(L, COMSIG_TYRANID_ABILITY_ON_UPGRADE)
	return ..()

/datum/action/ability/tyranid_action/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/tyranid/X = owner
	if(!X)
		return FALSE
	var/to_check_flags = use_state_flags|override_flags

	if(!(to_check_flags & ABILITY_USE_FORTIFIED) && X.fortify)
		if(!silent)
			X.balloon_alert(X, "Cannot while fortified")
		return FALSE

	if(!(to_check_flags & ABILITY_USE_CRESTED) && X.crest_defense)
		if(!silent)
			X.balloon_alert(X, "Cannot while in crest defense")
		return FALSE

	if(!(to_check_flags & ABILITY_IGNORE_PLASMA) && X.plasma_stored < ability_cost)
		if(!silent)
			X.balloon_alert(X, "Need [ability_cost - X.plasma_stored] more plasma")
		return FALSE

	return TRUE

//activatable
/datum/action/ability/activable/tyranid/New(Target)
	. = ..()
	var/mutable_appearance/empowered_appearence = mutable_appearance('modular_imperium/master_files/icons/tyranid/actions/general.dmi', "borders_center", ACTION_LAYER_EMPOWERED, FLOAT_PLANE)
	visual_references[VREF_MUTABLE_EMPOWERED_FRAME] = empowered_appearence

/datum/action/ability/activable/tyranid/give_action(mob/living/L)
	. = ..()
	RegisterSignal(L, COMSIG_TYRANID_ABILITY_ON_UPGRADE, TYPE_PROC_REF(/datum/action/ability, on_tyranid_upgrade))

/datum/action/ability/activable/tyranid/remove_action(mob/living/L)
	UnregisterSignal(L, COMSIG_TYRANID_ABILITY_ON_UPGRADE)
	return ..()

/datum/action/ability/activable/tyranid/can_use_action(silent = FALSE, override_flags)
	. = ..()
	if(!.)
		return

	var/mob/living/carbon/tyranid/X = owner
	if(!X)
		return FALSE
	var/to_check_flags = use_state_flags|override_flags

	if(!(to_check_flags & ABILITY_USE_FORTIFIED) && X.fortify)
		if(!silent)
			X.balloon_alert(X, "Cannot while fortified")
		return FALSE

	if(!(to_check_flags & ABILITY_USE_CRESTED) && X.crest_defense)
		if(!silent)
			X.balloon_alert(X, "Cannot while in crest defense")
		return FALSE

	if(!(to_check_flags & ABILITY_IGNORE_PLASMA) && X.plasma_stored < ability_cost)
		if(!silent)
			X.balloon_alert(X, "Need [ability_cost - X.plasma_stored] more plasma")
		return FALSE

	return TRUE
