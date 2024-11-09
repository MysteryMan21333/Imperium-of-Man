/mob/living/carbon/tyranid/hunter
	caste_base_type = /datum/tyranid_caste/hunter
	name = "Hunter"
	desc = "A beefy, fast alien with sharp claws."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/hunter.dmi'
	icon_state = "Hunter Running"
	bubble_icon = "alien"
	health = 150
	maxHealth = 150
	plasma_stored = 50
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_NORMAL
	inherent_verbs = list(
		/mob/living/carbon/tyranid/proc/vent_crawl,
	)

/mob/living/carbon/tyranid/hunter/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_SILENT_FOOTSTEPS, TYRANID_TRAIT)

/mob/living/carbon/tyranid/hunter/weapon_x
	caste_base_type = /datum/tyranid_caste/hunter/weapon_x

/mob/living/carbon/tyranid/hunter/weapon_x/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_CAMPAIGN_MISSION_ENDED, PROC_REF(terminate_specimen))

///Removed the tyranid after the mission ends
/mob/living/carbon/tyranid/hunter/weapon_x/proc/terminate_specimen()
	SIGNAL_HANDLER
	qdel(src)

