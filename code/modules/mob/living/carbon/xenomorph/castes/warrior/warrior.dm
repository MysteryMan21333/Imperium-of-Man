/mob/living/carbon/tyranid/warrior
	caste_base_type = /datum/tyranid_caste/warrior
	name = "Warrior"
	desc = "A beefy, alien with an armored carapace."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/warrior.dmi'
	icon_state = "Warrior Walking"
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 50
	pixel_x = -16
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	bubble_icon = "alienroyal"


// ***************************************
// *********** Icons
// ***************************************
/mob/living/carbon/tyranid/warrior/handle_special_state()
	var/datum/action/ability/tyranid_action/toggle_agility/agility_action = actions_by_path[/datum/action/ability/tyranid_action/toggle_agility]
	if(agility_action?.ability_active)
		icon_state = "[tyranid_caste.caste_name][(tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Agility"
		return TRUE
	return FALSE

/mob/living/carbon/tyranid/warrior/handle_special_wound_states(severity)
	. = ..()
	var/datum/action/ability/tyranid_action/toggle_agility/agility_action = actions_by_path[/datum/action/ability/tyranid_action/toggle_agility]
	if(agility_action?.ability_active)
		return "wounded_agility_[severity]"


// ***************************************
// *********** Mob overrides
// ***************************************
/mob/living/carbon/tyranid/warrior/stop_pulling()
	if(isliving(pulling) && !istyranid(pulling))
		var/mob/living/living_target = pulling
		grab_resist_level = 0 //zero it out
		living_target.SetStun(0)
		UnregisterSignal(living_target, COMSIG_LIVING_DO_RESIST)
	..()

/mob/living/carbon/tyranid/warrior/start_pulling(atom/movable/AM, force = move_force, suppress_message = TRUE, lunge = FALSE)
	if(!check_state())
		return FALSE
	var/mob/living/living_target = AM
	if(istyranid(living_target) && issametyranidhive(living_target))
		return ..()
	if(lunge && ..())
		return neck_grab(living_target)
	. = ..(living_target, force, suppress_message)

/// Puts the target on an upgraded grab and handles related effects.
/mob/living/carbon/tyranid/warrior/proc/neck_grab(mob/living/living_target)
	GLOB.round_statistics.warrior_grabs++
	SSblackbox.record_feedback("tally", "round_statistics", 1, "warrior_grabs")
	setGrabState(GRAB_NECK)
	living_target.resistance_flags |= RESTRAINED_NECKGRAB
	RegisterSignal(living_target, COMSIG_LIVING_DO_RESIST, TYPE_PROC_REF(/atom/movable, resisted_against))
	living_target.drop_all_held_items()
	living_target.Paralyze(0.1 SECONDS)
	living_target.balloon_alert(src, "Grabbed [living_target]")
	return TRUE

/mob/living/carbon/tyranid/warrior/resisted_against(datum/source)
	var/mob/living/living_target = source
	living_target.do_resist_grab()
