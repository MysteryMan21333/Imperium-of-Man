/mob/living/carbon/tyranid/praetorian
	caste_base_type = /datum/tyranid_caste/praetorian
	name = "Praetorian"
	desc = "A huge, looming beast of an alien."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/praetorian.dmi'
	icon_state = "Praetorian Walking"
	health = 210
	maxHealth = 210
	plasma_stored = 200
	pixel_x = -16
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead tyranid is hard
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	bubble_icon = "alienroyal"

/mob/living/carbon/tyranid/praetorian/dancer
	caste_base_type = /datum/tyranid_caste/praetorian/dancer

/mob/living/carbon/tyranid/praetorian/dancer/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TYRANID_POSTATTACK_LIVING, PROC_REF(on_postattack))

/// Applies the dancer mark status effect to those that they slash and damage.
/mob/living/carbon/tyranid/praetorian/dancer/proc/on_postattack(mob/living/source, mob/living/target, damage)
	SIGNAL_HANDLER
	target.apply_status_effect(STATUS_EFFECT_DANCER_TAGGED, 4 SECONDS)

