/mob/living/carbon/tyranid/crusher
	caste_base_type = /datum/tyranid_caste/crusher
	name = "Crusher"
	desc = "A huge alien with an enormous armored head crest."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/crusher.dmi'
	icon_state = "Crusher Walking"
	bubble_icon = "alienleft"
	health = 300
	maxHealth = 300
	plasma_stored = 200
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	drag_delay = 6 //pulling a big dead tyranid is hard
	mob_size = MOB_SIZE_BIG
	buckle_flags = CAN_BUCKLE
	pixel_x = -16
	pixel_y = -3

/mob/living/carbon/tyranid/crusher/handle_special_state()
	if(is_charging >= CHARGE_ON)
		icon_state = "[tyranid_caste.caste_name][(tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Charging"
		return TRUE
	return FALSE


/mob/living/carbon/tyranid/crusher/handle_special_wound_states(severity)
	. = ..()
	if(is_charging >= CHARGE_ON)
		return "wounded_charging_[severity]"

/mob/living/carbon/tyranid/crusher/buckle_mob(mob/living/buckling_mob, force = FALSE, check_loc = TRUE, lying_buckle = FALSE, hands_needed = 0, target_hands_needed = 0, silent)
	if(!force)//crushers should be overriden by runners
		return FALSE
	return ..()

/mob/living/carbon/tyranid/crusher/can_mount(mob/living/user, target_mounting = FALSE)
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
