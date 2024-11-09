/datum/tyranid_caste/gorger
	caste_name = "Gorger"
	display_name = "Gorger"
	upgrade_name = ""
	caste_desc = "A frightening looking, bulky alien creature that drips with a familiar red fluid."
	caste_type_path = /mob/living/carbon/tyranid/gorger
	primordial_message = "There is nothing we can't withstand."

	tier = TYRANID_TIER_THREE
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "gorger" //used to match appropriate wound overlays

	// *** Melee Attacks *** //
	melee_damage = 22

	// *** Speed *** //
	speed = -0.4
	weeds_speed_mod = -0.2

	// *** Plasma *** //
	plasma_max = 400
	plasma_gain = 0
	plasma_regen_limit = 0
	plasma_icon_state = "fury"

	// *** Health *** //
	max_health = 700

	// *** Evolution *** //
	upgrade_threshold = TIER_THREE_THRESHOLD

	deevolves_to = /datum/tyranid_caste/warrior

	// *** Flags *** //
	caste_flags = CASTE_INNATE_PLASMA_REGEN|CASTE_PLASMADRAIN_IMMUNE|CASTE_EVOLUTION_ALLOWED
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 10, BIO = 20, FIRE = 20, ACID = 20)

	// *** Minimap Icon *** //
	minimap_icon = "gorger"

	// *** Gorger Abilities *** //
	overheal_max = 275
	drain_plasma_gain = 40
	carnage_plasma_gain = 40
	feast_plasma_drain = 20

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain/free,
		/datum/action/ability/activable/tyranid/psychic_link,
		/datum/action/ability/activable/tyranid/drain,
		/datum/action/ability/activable/tyranid/transfusion,
		/datum/action/ability/activable/tyranid/carnage,
		/datum/action/ability/activable/tyranid/feast,
		/datum/action/ability/activable/tyranid/devour,
	)

/datum/tyranid_caste/gorger/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/gorger/primordial
	upgrade_name = "Primordial"
	caste_desc = "Being within mere eyeshot of this hulking monstrosity fills you with a deep, unshakeable sense of unease. You are unsure if you can even harm it."
	upgrade = TYRANID_UPGRADE_PRIMO

	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain/free,
		/datum/action/ability/activable/tyranid/psychic_link,
		/datum/action/ability/activable/tyranid/drain,
		/datum/action/ability/activable/tyranid/transfusion,
		/datum/action/ability/activable/tyranid/oppose,
		/datum/action/ability/activable/tyranid/carnage,
		/datum/action/ability/activable/tyranid/feast,
		/datum/action/ability/activable/tyranid/devour,
	)
