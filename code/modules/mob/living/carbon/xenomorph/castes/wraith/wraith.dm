/mob/living/carbon/tyranid/wraith
	caste_base_type = /datum/tyranid_caste/wraith
	name = "Wraith"
	desc = "A strange tendriled alien. The air around it warps and shimmers like a heat mirage."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/wraith.dmi'
	icon_state = "Wraith Walking"
	bubble_icon = "alienleft"
	health = 150
	maxHealth = 150
	plasma_stored = 150
	pixel_x = -16
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)
