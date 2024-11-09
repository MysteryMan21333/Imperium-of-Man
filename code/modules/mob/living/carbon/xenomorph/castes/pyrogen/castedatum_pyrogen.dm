/datum/tyranid_caste/pyrogen
	caste_name = "Pyrogen"
	display_name = "Pyrogen"
	upgrade_name = ""
	caste_desc = "A tyranid constantly engulfed by plasma flames."
	caste_type_path = /mob/living/carbon/tyranid/pyrogen
	tier = TYRANID_TIER_TWO
	upgrade = TYRANID_UPGRADE_BASETYPE
	wound_type = "pyrogen" //used to match appropriate wound overlays
	evolution_threshold = 225

	// *** Melee Attacks *** //
	melee_damage = 22
	attack_delay = 7

	// *** Speed *** //
	speed = -0.9

	// *** Plasma *** //
	plasma_max = 325
	plasma_gain = 25

	// *** Health *** //
	max_health = 400

	// *** Evolution *** //
	upgrade_threshold = TIER_TWO_THRESHOLD

	deevolves_to = /mob/living/carbon/tyranid/runner

	// *** Flags *** //
	caste_flags = CASTE_EVOLUTION_ALLOWED|CASTE_FIRE_IMMUNE
	can_flags = CASTE_CAN_BE_QUEEN_HEALED|CASTE_CAN_BE_GIVEN_PLASMA|CASTE_CAN_BE_LEADER
	caste_traits = null

	// *** Defense *** //
	soft_armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 0, BIO = 30, FIRE = 200, ACID = 30)
	hard_armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 0)

	// *** Minimap Icon *** //
	minimap_icon = "pyrogen"

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/charge/fire_charge,
		/datum/action/ability/activable/tyranid/fireball,
		/datum/action/ability/activable/tyranid/firestorm,
	)

/datum/tyranid_caste/pyrogen/normal
	upgrade = TYRANID_UPGRADE_NORMAL

/datum/tyranid_caste/pyrogen/primordial
	upgrade_name = "Primordial"
	caste_desc = "The fire within this one shimmers brighter than the ones before."
	primordial_message = "Everything shall experience the cold of the void."
	upgrade = TYRANID_UPGRADE_PRIMO

	// *** Abilities *** //
	actions = list(
		/datum/action/ability/tyranid_action/tyranid_resting,
		/datum/action/ability/tyranid_action/watch_tyranid,
		/datum/action/ability/activable/tyranid/psydrain,
		/datum/action/ability/activable/tyranid/charge/fire_charge,
		/datum/action/ability/activable/tyranid/fireball,
		/datum/action/ability/activable/tyranid/firestorm,
		/datum/action/ability/tyranid_action/heatray,
	)
