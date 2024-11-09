/mob/living/carbon/tyranid/pyrogen
	caste_base_type = /datum/tyranid_caste/pyrogen
	name = "Pyrogen"
	desc = "A skittish alien, it burns with fury."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/pyrogen.dmi'
	icon_state = "pyrogen Walking"
	health = 325
	maxHealth = 325
	plasma_stored = 300
	mob_size = MOB_SIZE_TYRANID
	drag_delay = 3
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	pixel_x = -16
	bubble_icon = "alienroyal"

/mob/living/carbon/tyranid/pyrogen/on_floored_trait_loss(datum/source)
	. = ..()
	flick("stunned_comeback",src)

/mob/living/carbon/tyranid/pyrogen/set_resting()
	. = ..()
	if(resting)
		flick("demanifest", src)
	else
		flick("manifest", src)

/mob/living/carbon/tyranid/pyrogen/primordial
	upgrade = TYRANID_UPGRADE_PRIMO
