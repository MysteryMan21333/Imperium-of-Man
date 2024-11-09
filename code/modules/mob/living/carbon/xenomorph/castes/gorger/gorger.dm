/mob/living/carbon/tyranid/gorger
	caste_base_type = /datum/tyranid_caste/gorger
	name = "Gorger"
	desc = "A large, powerfully muscled tyranid with seemingly more vitality than others."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/gorger.dmi'
	icon_state = "Gorger Walking"
	health = 600
	maxHealth = 600
	plasma_stored = 100
	pixel_x = -16
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	mob_size = MOB_SIZE_BIG
	bubble_icon = "alienroyal"

/mob/living/carbon/tyranid/gorger/Initialize(mapload)
	. = ..()
	GLOB.huds[DATA_HUD_TYRANID_HEART].add_hud_to(src)
