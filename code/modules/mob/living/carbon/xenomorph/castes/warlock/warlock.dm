/mob/living/carbon/tyranid/warlock
	caste_base_type = /datum/tyranid_caste/warlock
	name = "Warlock"
	desc = "A large, physically frail creature. It hovers in the air and seems to buzz with psychic power."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/warlock.dmi'
	icon_state = "Warlock Walking"
	bubble_icon = "alienroyal"
	attacktext = "slashes"
	attack_sound = null
	friendly = "nuzzles"
	wall_smash = FALSE
	health = 320
	maxHealth = 320
	plasma_stored = 1400
	pixel_x = -16
	drag_delay = 3
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	pass_flags = PASS_LOW_STRUCTURE

/mob/living/carbon/tyranid/warlock/Initialize(mapload)
	. = ..()
	ammo = GLOB.ammo_list[/datum/ammo/energy/tyranid/psy_blast]
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, TYRANID_TRAIT)

/mob/living/carbon/tyranid/warlock/get_liquid_slowdown()
	return WARLOCK_WATER_SLOWDOWN
