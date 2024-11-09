/mob/living/carbon/tyranid/shrike
	caste_base_type = /datum/tyranid_caste/shrike
	name = "Shrike"
	desc = "A large, lanky alien creature. It seems psychically unstable."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/shrike.dmi'
	icon_state = "Shrike Walking"
	bubble_icon = "alienroyal"
	attacktext = "bites"
	attack_sound = null
	friendly = "nuzzles"
	wall_smash = FALSE
	health = 240
	maxHealth = 240
	plasma_stored = 300
	pixel_x = -16
	drag_delay = 3 //pulling a medium dead tyranid is hard
	tier = TYRANID_TIER_FOUR
	upgrade = TYRANID_UPGRADE_NORMAL
	var/shrike_flags = SHRIKE_FLAG_PAIN_HUD_ON
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
		/mob/living/carbon/tyranid/proc/hijack,
	)

