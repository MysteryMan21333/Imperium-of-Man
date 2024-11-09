/mob/living/carbon/tyranid/sentinel
	caste_base_type = /datum/tyranid_caste/sentinel
	name = "Sentinel"
	desc = "A slithery, spitting kind of alien."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/sentinel.dmi'
	icon_state = "Sentinel Walking"
	bubble_icon = "alienleft"
	health = 150
	maxHealth = 150
	plasma_stored = 75
	pixel_x = -12
	tier = TYRANID_TIER_ONE
	upgrade = TYRANID_UPGRADE_NORMAL
	pull_speed = -2
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)

/mob/living/carbon/tyranid/sentinel/retrograde
	caste_base_type = /datum/tyranid_caste/sentinel/retrograde
