/mob/living/carbon/tyranid/widow
	caste_base_type = /datum/tyranid_caste/widow
	name = "Widow"
	desc = "A large arachnid tyranid, with fangs ready to bear and crawling with many little spiderlings ready to grow."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/widow.dmi'
	icon_state = "Widow Walking"
	bubble_icon = "alienroyal"
	health = 200
	maxHealth = 200
	plasma_stored = 150
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	buckle_flags = CAN_BUCKLE
	pixel_x = -16
	max_buckled_mobs = 5

/mob/living/carbon/tyranid/widow/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_LIGHT_STEP, TYRANID_TRAIT)

/mob/living/carbon/tyranid/widow/buckle_mob(mob/living/buckling_mob, force = FALSE, check_loc = TRUE, lying_buckle = FALSE, hands_needed = 0, target_hands_needed = 0, silent)
	if(!force)
		return FALSE
	return ..()

/mob/living/carbon/tyranid/widow/post_unbuckle_mob(mob/living/M)
	M.layer = initial(M.layer)
	M.pixel_x = rand(-8, 8)
	M.pixel_y = rand(-8, 8)


//Prevents humans unbuckling spiderlings
/mob/living/carbon/tyranid/widow/user_unbuckle_mob(mob/living/buckled_mob, mob/user, silent)
	if(ishuman(user))
		return
	return ..()

/mob/living/carbon/tyranid/widow/set_stat(new_stat)
	. = ..()
	if(new_stat == UNCONSCIOUS)
		unbuckle_all_mobs(TRUE) //If we have spiderlings on us, get them off and ready for guard
		SEND_SIGNAL(src, COMSIG_SPIDERLING_GUARD)
	else if(new_stat == CONSCIOUS)
		unbuckle_all_mobs(TRUE)
		SEND_SIGNAL(src, COMSIG_SPIDERLING_UNGUARD)

/mob/living/carbon/tyranid/widow/death(gibbing, deathmessage, silent)
	unbuckle_all_mobs(TRUE) //RELEASE THE HORDE
	return ..()

/mob/living/carbon/tyranid/widow/transfer_to_hive(hivenumber)
	. = ..()
	var/mob/living/carbon/tyranid/widow/X = src
	var/datum/action/ability/tyranid_action/create_spiderling/create_spiderling_action = X.actions_by_path[/datum/action/ability/tyranid_action/create_spiderling]
	for(var/mob/living/carbon/tyranid/spider AS in create_spiderling_action.spiderlings)
		spider.transfer_to_hive(hivenumber)

/mob/living/carbon/tyranid/widow/on_eord(turf/destination)
	..()
	var/datum/action/ability/tyranid_action/create_spiderling/create_spiderling_action = actions_by_path[/datum/action/ability/tyranid_action/create_spiderling]
	for(var/mob/living/carbon/tyranid/spider AS in create_spiderling_action.spiderlings)
		spider.revive(TRUE)
		spider.forceMove(destination)

