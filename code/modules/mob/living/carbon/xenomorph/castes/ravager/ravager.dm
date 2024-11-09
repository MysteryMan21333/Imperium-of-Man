/mob/living/carbon/tyranid/ravager
	caste_base_type = /datum/tyranid_caste/ravager
	name = "Ravager"
	desc = "A huge, nasty red alien with enormous scythed claws."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/ravager.dmi'
	icon_state = "Ravager Walking"
	health = 250
	maxHealth = 250
	plasma_stored = 50
	mob_size = MOB_SIZE_BIG
	drag_delay = 6 //pulling a big dead tyranid is hard
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_NORMAL
	pixel_x = -16
	bubble_icon = "alienroyal"

/mob/living/carbon/tyranid/ravager/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_LIGHT_STEP, TYRANID_TRAIT)

// ***************************************
// *********** Mob overrides
// ***************************************
/mob/living/carbon/tyranid/ravager/fire_act(burn_level)
	. = ..()
	if(stat)
		return
	if(TIMER_COOLDOWN_CHECK(src, COOLDOWN_RAVAGER_FLAMER_ACT))
		return FALSE
	gain_plasma(50)
	TIMER_COOLDOWN_START(src, COOLDOWN_RAVAGER_FLAMER_ACT, 1 SECONDS)
	if(prob(30))
		emote("roar")
		to_chat(src, span_tyraniddanger("The heat of the fire roars in our veins! KILL! CHARGE! DESTROY!"))

// ***************************************
// *********** Ability related
// ***************************************
/mob/living/carbon/tyranid/ravager/get_crit_threshold()
	. = ..()
	if(!endure)
		return
	var/datum/action/ability/tyranid_action/endure/endure_ability = actions_by_path[/datum/action/ability/tyranid_action/endure]
	return endure_ability.endure_threshold

/mob/living/carbon/tyranid/ravager/get_death_threshold()
	. = ..()
	if(!endure)
		return
	var/datum/action/ability/tyranid_action/endure/endure_ability = actions_by_path[/datum/action/ability/tyranid_action/endure]
	return endure_ability.endure_threshold

