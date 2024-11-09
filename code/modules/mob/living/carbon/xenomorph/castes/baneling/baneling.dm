/mob/living/carbon/tyranid/baneling
	caste_base_type = /datum/tyranid_caste/baneling
	name = "Baneling"
	desc = "An oozy, squishy alien that can roll in agile speeds, storing various dangerous chemicals in its sac..."
	icon = 'modular_imperium/master_files/icons/tyranid/castes/baneling.dmi'
	icon_state = "Baneling Walking"
	bubble_icon = "alienleft"
	health = 100
	maxHealth = 100
	plasma_stored = 50
	tier = TYRANID_TIER_MINION
	upgrade = TYRANID_UPGRADE_BASETYPE
	pixel_x = -16

/mob/living/carbon/tyranid/baneling/UnarmedAttack(atom/A, has_proximity, modifiers)
	/// We dont wanna be able to slash while balling
	if(m_intent == MOVE_INTENT_RUN)
		return
	return ..()

// ***************************************
// *********** Icon
// ***************************************
/mob/living/carbon/tyranid/baneling/handle_special_state()
	. = ..()
	if(m_intent == MOVE_INTENT_RUN)
		icon_state = "[tyranid_caste.caste_name][(tyranid_flags & TYRANID_ROUNY) ? " rouny" : ""] Running"
		return TRUE
	return FALSE

/mob/living/carbon/tyranid/baneling/handle_special_wound_states(severity)
	. = ..()
	if(m_intent == MOVE_INTENT_RUN)
		return "wounded_running_[severity]"
