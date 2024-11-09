/mob/living/carbon/tyranid/behemoth
	caste_base_type = /datum/tyranid_caste/behemoth
	name = "Behemoth"
	desc = "A resilient and equally ferocious monster that commands the earth itself."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/behemoth.dmi'
	icon_state = "Behemoth Walking"
	bubble_icon = "alienleft"
	health = 750
	maxHealth = 750
	plasma_stored = 200
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	drag_delay = 6
	mob_size = MOB_SIZE_BIG
	max_buckled_mobs = 2
	pixel_x = -28.5
	footstep_type = FOOTSTEP_TYRANID_HEAVY


// ***************************************
// *********** Special States
// ***************************************
/mob/living/carbon/tyranid/behemoth/handle_special_state()
	var/datum/action/ability/tyranid_action/ready_charge/behemoth_roll/behemoth_roll_action = actions_by_path[/datum/action/ability/tyranid_action/ready_charge/behemoth_roll]
	if(!behemoth_roll_action || !behemoth_roll_action.charge_ability_on)
		return FALSE
	if(behemoth_roll_action.valid_steps_taken == behemoth_roll_action.max_steps_buildup)
		icon_state = "Behemoth[(tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Charging"
	else
		icon_state = "Behemoth Rolling"
	return TRUE

/mob/living/carbon/tyranid/behemoth/handle_special_wound_states(severity)
	. = ..()
	var/datum/action/ability/tyranid_action/ready_charge/behemoth_roll/behemoth_roll_action = actions_by_path[/datum/action/ability/tyranid_action/ready_charge/behemoth_roll]
	if(behemoth_roll_action?.charge_ability_on)
		return "wounded_charging_[severity]"

/mob/living/carbon/tyranid/behemoth/get_status_tab_items()
	. = ..()
	if(tyranid_caste.wrath_max > 0)
		. += "Wrath: [wrath_stored] / [tyranid_caste.wrath_max]"

/mob/living/carbon/tyranid/behemoth/can_mount(mob/living/user, target_mounting = FALSE)
	. = ..()
	if(!target_mounting)
		user = pulling
	if(!istyranid(user))
		return FALSE
	var/mob/living/carbon/tyranid/grabbed = user
	if(grabbed.incapacitated() || !(grabbed.tyranid_caste.can_flags & CASTE_CAN_RIDE_CRUSHER))
		return FALSE
	return TRUE

/mob/living/carbon/tyranid/crusher/resisted_against(datum/source)
	user_unbuckle_mob(source, source)
