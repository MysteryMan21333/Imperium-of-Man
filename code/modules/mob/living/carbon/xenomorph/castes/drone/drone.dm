/mob/living/carbon/tyranid/drone
	caste_base_type = /datum/tyranid_caste/drone
	name = "Drone"
	desc = "An Alien Drone"
	icon = 'modular_imperium/master_files/icons/tyranid/castes/drone.dmi'
	icon_state = "Drone Walking"
	bubble_icon = "alienleft"
	health = 120
	maxHealth = 120
	plasma_stored = 350
	tier = TYRANID_TIER_ONE
	upgrade = TYRANID_UPGRADE_NORMAL
	pixel_x = -12
	pull_speed = -2
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)
