/datum/tyranid_caste/ravager
	caste_name = "Ravager"
	display_name = "Ravager"
	upgrade_name = ""
	caste_desc = "A brutal, devastating front-line attacker."
	caste_type_path = /mob/living/carbon/tyranid/ravager
	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "ravager" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 25
	melee_ap = 15
	attack_delay = 7

	// *** Speed *** //
	speed = -1.0

	// *** Plasma *** //
	plasma_max = 800
	plasma_gain = 15
	plasma_regen_limit = 0.5
	plasma_icon_state = "fury"

	// *** Health *** //
	max_health = 400

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/hunter

	// *** Flags *** //
	caste_flags = CASTE_INNATE_PLASMA_REGEN|CASTE_PLASMADRAIN_IMMUNE|CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 50, BULLET = 55, LASER = 50, ENERGY = 50, BOMB = 10, BIO = 40, FIRE = 70, ACID = 40)

	// *** Minimap Icon *** //
	minimap_icon = "ravager"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/charge,
		/datum/action/ability/activable/tyranid/ravage,
		/datum/action/ability/tyranid_action/endure,
		/datum/action/ability/tyranid_action/rage,
	)

/datum/tyranid_caste/ravager/on_caste_applied(mob/tyranid)
	. = ..()
	tyranid.AddElement(/datum/element/plasma_on_attack, 1.5)
	tyranid.AddElement(/datum/element/plasma_on_attacked, 0.5)

/datum/tyranid_caste/ravager/on_caste_removed(mob/tyranid)
	. = ..()
	tyranid.RemoveElement(/datum/element/plasma_on_attack, 1.5)
	tyranid.RemoveElement(/datum/element/plasma_on_attacked, 0.5)

/datum/tyranid_caste/ravager/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/ravager/primordial
	upgrade_name = "Primordial"
	caste_desc = "Red like the blood of those that try to stop its rampage."
	primordial_message = "Our frenzy is eternal. Rip and tear, until it is done."
	upgrade = TYRANID_UPGRADE_PRIMO

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/charge,
		/datum/action/ability/activable/tyranid/ravage,
		/datum/action/ability/tyranid_action/endure,
		/datum/action/ability/tyranid_action/rage,
		/datum/action/ability/tyranid_action/vampirism,
	)
