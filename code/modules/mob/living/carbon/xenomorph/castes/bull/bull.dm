/mob/living/carbon/tyranid/bull
	caste_base_type = /datum/tyranid_caste/bull
	name = "Bull"
	desc = "A bright red alien with a matching temper."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/bull.dmi'
	icon_state = "Bull Walking"
	bubble_icon = "alienleft"
	health = 160
	maxHealth = 160
	plasma_stored = 200
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL

	pixel_x = -16
	pixel_y = -3


/mob/living/carbon/tyranid/bull/handle_special_state()
	if(is_charging >= CHARGE_ON)
		icon_state = "[tyranid_caste.caste_name][(tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Charging"
		return TRUE
	return FALSE


/mob/living/carbon/tyranid/bull/handle_special_wound_states(severity)
	. = ..()
	if(is_charging >= CHARGE_ON)
		return "wounded_charging_[severity]"
