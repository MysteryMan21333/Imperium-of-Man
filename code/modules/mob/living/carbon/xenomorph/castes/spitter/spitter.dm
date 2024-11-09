/mob/living/carbon/tyranid/spitter
	caste_base_type = /datum/tyranid_caste/spitter
	name = "Spitter"
	desc = "A gross, oozing alien of some kind."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/spitter.dmi'
	icon_state = "Spitter Walking"
	bubble_icon = "alienroyal"
	health = 180
	maxHealth = 180
	plasma_stored = 150
	pixel_x = -16
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)
