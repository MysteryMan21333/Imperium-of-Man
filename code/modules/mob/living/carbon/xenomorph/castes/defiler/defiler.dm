/mob/living/carbon/tyranid/defiler
	caste_base_type = /datum/tyranid_caste/defiler
	name = "Defiler"
	desc = "A large, powerfully muscled tyranid replete with dripping spines and gas leaking dorsal vents."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/defiler.dmi'
	icon_state = "Defiler Walking"
	bubble_icon = "alienroyal"
	health = 225
	maxHealth = 225
	plasma_stored = 400
	pixel_x = -16
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	var/emitting_gas = FALSE
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)
